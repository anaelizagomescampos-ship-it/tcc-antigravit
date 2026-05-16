<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/status', function () {
    return response()->json([
        'service' => 'EcoGo API',
        'company' => 'EcoJac',
        'status' => 'online',
        'message' => 'API de sustentabilidade funcionando corretamente'
    ]);
});

Route::get('/pontos-coleta', function () {
    return response()->json([
        'title' => 'Pontos de Coleta EcoGo',
        'data' => [
            [
                'id' => 1,
                'name' => 'Ponto Central Verde',
                'address' => 'Rua das Palmeiras, 100',
                'city' => 'São Paulo',
                'accepted_waste' => ['papel', 'plástico', 'metal']
            ],
            [
                'id' => 2,
                'name' => 'Praça Recicla Fácil',
                'address' => 'Av. Sustentável, 250',
                'city' => 'Campinas',
                'accepted_waste' => ['vidro', 'papelão', 'eletrônicos']
            ]
        ]
    ], 200);
});

Route::get('/tipos-residuos', function () {
    return response()->json([
        'title' => 'Tipos de Resíduos Aceitos',
        'residuos' => [
            'papel',
            'plástico',
            'metal',
            'vidro',
            'eletrônicos',
            'orgânicos secos'
        ]
    ]);
});

Route::get('/dicas-eco', function () {
    return response()->json([
        'title' => 'Dicas EcoGo',
        'tips' => [
            'Lave e seque os recipientes antes de reciclar.',
            'Separe os resíduos por tipo antes de levar ao ponto de coleta.',
            'Prefira embalagens reutilizáveis sempre que possível.'
        ]
    ]);
});
