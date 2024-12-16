import React from 'react';
import { Header } from './components/Header';
import { Skills } from './components/Skills';
import { Timeline } from './components/Timeline';

function App() {
  return (
    <div className="min-h-screen bg-gray-100">
      <div className="container mx-auto px-4 py-8 max-w-5xl">
        <div className="space-y-6">
          <Header />
          <div className="grid md:grid-cols-3 gap-6">
            <div className="md:col-span-1">
              <Skills />
            </div>
            <div className="md:col-span-2">
              <Timeline />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;