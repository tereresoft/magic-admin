<?php
namespace {{namespace}}Http\Controllers;

use {{namespace}}Http\Requests;
use Illuminate\Http\Request;

class WellcomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('frontend/wellcome');
    }
}
