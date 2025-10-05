package com.grupo6.aplicacionasesor

import android.os.Bundle
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Tab
import androidx.compose.material3.TabRow
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.grupo6.aplicacionasesor.ui.theme.AplicacionAsesorTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            AplicacionAsesorTheme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    VistaAsesor(modifier = Modifier.padding(innerPadding))
                }
            }
        }
    }
}

@Composable
fun VistaAsesor(modifier: Modifier = Modifier) {
    val context = LocalContext.current

    // Estado simulado
    var clienteActual by remember { mutableStateOf<String?>(null) }
    var siguientes by remember { mutableStateOf(listOf("Cliente 1", "Cliente 2", "Cliente 3")) }
    var atendidos by remember { mutableStateOf(listOf<String>()) }

    var tabIndex by remember { mutableStateOf(0) }
    val tabs = listOf("Siguientes", "Atendidos")

    Column(
        modifier = modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {
        // Título
        Text(
            text = "Atendiendo actualmente",
            style = MaterialTheme.typography.headlineSmall,
            modifier = Modifier.fillMaxWidth(),
            textAlign = TextAlign.Center
        )

        Spacer(modifier = Modifier.height(8.dp))

        // Recuadro usuario actual
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .height(100.dp),
            colors = CardDefaults.cardColors(
                containerColor = if (clienteActual != null) MaterialTheme.colorScheme.primaryContainer
                else MaterialTheme.colorScheme.surfaceVariant
            )
        ) {
            Box(
                modifier = Modifier.fillMaxSize(),
                contentAlignment = Alignment.Center
            ) {
                Text(
                    text = clienteActual ?: "Ningún cliente en atención",
                    style = MaterialTheme.typography.titleLarge,
                    textAlign = TextAlign.Center
                )
            }
        }

        Spacer(modifier = Modifier.height(16.dp))

        // Botones
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceEvenly
        ) {
            Button(
                onClick = {
                    clienteActual?.let  {
                        atendidos = atendidos + it
                        clienteActual = null
                        Toast.makeText(context, "Cliente atendido", Toast.LENGTH_SHORT).show()
                    }
                },
                enabled = clienteActual != null
            ) {
                Text("Atendido")
            }

            Button(
                onClick = {
                    if (siguientes.isNotEmpty()) {
                        clienteActual = siguientes.first()
                        siguientes = siguientes.drop(1)
                        Toast.makeText(context, "Atendiendo a $clienteActual", Toast.LENGTH_SHORT).show()
                    }
                },
                enabled = clienteActual == null && siguientes.isNotEmpty()
            ) {
                Text("Atender siguiente")
            }
        }

        Spacer(modifier = Modifier.height(24.dp))

        // Tabs (Siguientes / Atendidos)
        TabRow(selectedTabIndex = tabIndex) {
            tabs.forEachIndexed { index, title ->
                Tab(
                    text = { Text(title) },
                    selected = tabIndex == index,
                    onClick = { tabIndex = index }
                )
            }
        }

        Spacer(modifier = Modifier.height(8.dp))

        when (tabIndex) {
            0 -> ListaClientes(siguientes, "Clientes en cola")
            1 -> ListaClientes(atendidos, "Clientes atendidos")
        }
    }
}
@Composable
fun ListaClientes(clientes: List<String>, titulo: String) {
    Column(modifier = Modifier.fillMaxSize()) {
        Text(
            text = titulo,
            style = MaterialTheme.typography.titleMedium,
            modifier = Modifier.padding(8.dp)
        )
        LazyColumn(modifier = Modifier.fillMaxSize()) {
            items(clientes) { cliente ->
                Card(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(4.dp)
                ) {
                    Text(
                        text = cliente,
                        modifier = Modifier.padding(16.dp)
                    )
                }
            }
        }
    }
}