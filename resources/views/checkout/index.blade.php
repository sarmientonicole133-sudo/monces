@extends('layouts.landing')

@section('content')
<div class="relative min-h-screen bg-black text-white pt-20">
    <div class="pb-12">
        <div class="container mx-auto px-4">
            <div class="text-center mb-16">
                <h1 class="text-4xl md:text-5xl font-bold mb-6 animate-fade-in-down">
                    Checkout
                </h1>
                <p class="text-xl text-gray-400 max-w-2xl mx-auto animate-fade-in-up">
                    Complete your purchase and provide shipping information
                </p>
            </div>
            
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                <!-- Order Summary -->
                <div class="bg-gray-900 rounded-lg shadow-md overflow-hidden">
                    <div class="px-6 py-8">
                        <h2 class="text-2xl font-bold text-white mb-6">Order Summary</h2>
                        
                        <div class="space-y-6">
                            @foreach($items as $item)
                                <div class="flex items-center py-4 border-b border-gray-800">
                                    <div class="h-20 w-20 flex-shrink-0 overflow-hidden rounded-md bg-gray-800">
                                        @if($item->product->cover_image)
                                            <img src="{{ asset('images/' . $item->product->cover_image) }}" alt="{{ $item->product->name }}" class="h-full w-full object-cover">
                                        @else
                                            <div class="bg-gray-800 border-2 border-dashed border-gray-700 rounded-xl w-full h-full flex items-center justify-center">
                                                <svg class="h-6 w-6 text-gray-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                                </svg>
                                            </div>
                                        @endif
                                    </div>
                                    <div class="ml-4 flex flex-1 flex-col">
                                        <div>
                                            <div class="flex justify-between text-base font-medium text-white">
                                                <h3>{{ $item->product->name }}</h3>
                                                <p class="ml-4">${{ number_format($item->product->price * $item->quantity, 2) }}</p>
                                            </div>
                                            <p class="mt-1 text-sm text-gray-400">{{ $item->product->category->name }}</p>
                                        </div>
                                        <div class="flex flex-1 items-end justify-between text-sm mt-2">
                                            <p class="text-gray-400">Qty {{ $item->quantity }}</p>
                                        </div>
                                    </div>
                                </div>
                            @endforeach
                        </div>
                        
                        <div class="mt-8 border-t border-gray-800 pt-6">
                            <div class="flex justify-between text-base font-medium text-white">
                                <p>Subtotal</p>
                                <p>${{ number_format($total, 2) }}</p>
                            </div>
                            <div class="mt-3 flex justify-between text-sm text-gray-400">
                                <p>Shipping</p>
                                <p>Calculated at next step</p>
                            </div>
                            <div class="mt-3 flex justify-between text-sm text-gray-400">
                                <p>Tax</p>
                                <p>Calculated at next step</p>
                            </div>
                            <div class="mt-6 flex justify-between text-xl font-bold text-white">
                                <p>Total</p>
                                <p>${{ number_format($total, 2) }}</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Shipping Information -->
                <div class="bg-gray-900 rounded-lg shadow-md overflow-hidden">
                    <div class="px-6 py-8">
                        <h2 class="text-2xl font-bold text-white mb-6">Shipping Information</h2>
                        
                        <form action="{{ route('checkout.store') }}" method="POST" class="mt-6 space-y-6">
                            @csrf
                            <div>
                                <label for="email" class="block text-sm font-medium text-gray-300 mb-2">Email</label>
                                <input type="email" id="email" name="email" required class="w-full rounded-md bg-gray-800 border border-gray-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm py-3 px-4">
                            </div>
                            
                            <div>
                                <label for="name" class="block text-sm font-medium text-gray-300 mb-2">Full Name</label>
                                <input type="text" id="name" name="name" required class="w-full rounded-md bg-gray-800 border border-gray-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm py-3 px-4">
                            </div>
                            
                            <div>
                                <label for="address" class="block text-sm font-medium text-gray-300 mb-2">Address</label>
                                <input type="text" id="address" name="address" required class="w-full rounded-md bg-gray-800 border border-gray-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm py-3 px-4">
                            </div>
                            
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                                <div>
                                    <label for="city" class="block text-sm font-medium text-gray-300 mb-2">City</label>
                                    <input type="text" id="city" name="city" required class="w-full rounded-md bg-gray-800 border border-gray-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm py-3 px-4">
                                </div>
                                
                                <div>
                                    <label for="state" class="block text-sm font-medium text-gray-300 mb-2">State</label>
                                    <input type="text" id="state" name="state" required class="w-full rounded-md bg-gray-800 border border-gray-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm py-3 px-4">
                                </div>
                            </div>
                            
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
                                <div>
                                    <label for="zip" class="block text-sm font-medium text-gray-300 mb-2">ZIP / Postal Code</label>
                                    <input type="text" id="zip" name="zip" required class="w-full rounded-md bg-gray-800 border border-gray-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm py-3 px-4">
                                </div>
                                
                                <div>
                                    <label for="phone" class="block text-sm font-medium text-gray-300 mb-2">Phone</label>
                                    <input type="text" id="phone" name="phone" required class="w-full rounded-md bg-gray-800 border border-gray-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm py-3 px-4">
                                </div>
                            </div>
                            
                            <div class="mt-8">
                                <button type="submit" class="w-full flex justify-center rounded-md border border-transparent bg-red-600 py-3 px-4 text-base font-medium text-white shadow-sm hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-offset-2 transition duration-300">
                                    Continue to Payment
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-black py-8 border-t border-gray-800 mt-auto">
        <div class="container mx-auto px-4">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
                <div>
                    <h3 class="text-2xl font-bold mb-4">OXGN<span class="text-red-600">FASHION</span></h3>
                    <p class="text-gray-400">
                        Urban fashion redefined. Premium quality streetwear for the modern lifestyle.
                    </p>
                </div>
                
                <div>
                    <h4 class="text-lg font-semibold mb-4">Shop</h4>
                    <ul class="space-y-2">
                        <li><a href="{{ route('shop') }}" class="text-gray-400 hover:text-white transition">New Arrivals</a></li>
                        <li><a href="{{ route('shop') }}" class="text-gray-400 hover:text-white transition">Best Sellers</a></li>
                        <li><a href="{{ route('shop') }}" class="text-gray-400 hover:text-white transition">Sale</a></li>
                        <li><a href="#collections" class="text-gray-400 hover:text-white transition">Collections</a></li>
                    </ul>
                </div>
                
                <div>
                    <h4 class="text-lg font-semibold mb-4">Support</h4>
                    <ul class="space-y-2">
                        <li><a href="#" class="text-gray-400 hover:text-white transition">Contact Us</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-white transition">Shipping Info</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-white transition">Returns</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-white transition">FAQ</a></li>
                    </ul>
                </div>
                
                <div>
                    <h4 class="text-lg font-semibold mb-4">Connect</h4>
                    <div class="flex space-x-4">
                        <a href="#" class="text-gray-400 hover:text-white transition">
                            <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
                                <path d="M22 12c0-5.523-4.477-10-10-10S2 6.477 2 12c0 4.991 3.657 9.128 8.438 9.878v-6.987h-2.54V12h2.54V9.797c0-2.506 1.492-3.89 3.777-3.89 1.094 0 2.238.195 2.238.195v2.46h-1.26c-1.243 0-1.63.771-1.63 1.562V12h2.773l-.443 2.89h-2.33v6.988C18.343 21.128 22 16.991 22 12z"/>
                            </svg>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white transition">
                            <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
                                <path d="M8.29 20.251c7.547 0 11.675-6.253 11.675-11.675 0-.178 0-.355-.012-.53A8.348 8.348 0 0022 5.92a8.19 8.19 0 01-2.357.646 4.118 4.118 0 001.804-2.27 8.224 8.224 0 01-2.605.996 4.107 4.107 0 00-6.993 3.743 11.65 11.65 0 01-8.457-4.287 4.106 4.106 0 001.27 5.477A4.072 4.072 0 012.8 9.713v.052a4.105 4.105 0 003.292 4.022 4.095 4.095 0 01-1.853.07 4.108 4.108 0 003.834 2.85A8.233 8.233 0 012 18.407a11.616 11.616 0 006.29 1.84"/>
                            </svg>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white transition">
                            <svg class="h-6 w-6" fill="currentColor" viewBox="0 0 24 24">
                                <path d="M12 2C6.477 2 2 6.477 2 12c0 5.523 4.477 10 10 10s10-4.477 10-10c0-5.523-4.477-10-10-10zm0 18c-4.418 0-8-3.582-8-8s3.582-8 8-8 8 3.582 8 8-3.582 8-8 8zm-2-12c-1.105 0-2 .895-2 2s.895 2 2 2 2-.895 2-2-.895-2-2-2zm4 8H8v-1c0-1.324 1.945-2 4-2s4 .676 4 2v1z"/>
                            </svg>
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="border-t border-gray-800 mt-8 pt-8 text-center text-gray-400">
                <p>&copy; {{ date('Y') }} OXGN FASHION. All rights reserved.</p>
            </div>
        </div>
    </footer>
</div>
@endsection