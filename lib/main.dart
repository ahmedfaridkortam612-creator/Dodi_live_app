import React, { useState } from 'react';

// تطبيق غرف الدردشة الصوتية والمرئية المتكامل (Voice & Video Live Rooms)
export default function App() {
  const [lang, setLang] = useState('ar'); // 'ar' أو 'en'
  const [currentTab, setCurrentTab] = useState('home'); // 'home' (Rooms), 'live' (Video Live), 'games', 'wallet', 'profile', 'room_active', 'live_room'
  const [coins, setCoins] = useState(4);
  const [diamonds, setDiamonds] = useState(324);
  const [selectedMultiplier, setSelectedMultiplier] = useState(1);

  // القواميس الترجمية للغتين العربية والإنجليزية
  const t = {
    ar: {
      rooms: 'الغرف الصوتية',
      liveStreams: 'البث المباشر 🎥',
      games: 'الألعاب والجوائز',
      wallet: 'المحفظة والشحن',
      profile: 'الملف الشخصي',
      recharge: 'شحن',
      exchange: 'استبدال',
      pkBattle: 'تحدي PK ساخن 🔥',
      send: 'إرسال',
      sayHi: 'قول مرحبا...',
      headwear: 'الإطارات المتحركة',
      vehicle: 'مركبات الدخول',
      viewers: 'مشاهد',
      balance: 'رصيد العملات',
      diamondBalance: 'رصيد الجواهر',
      close: 'إغلاق ❌',
      gifts: '🎁 هدايا'
    },
    en: {
      rooms: 'Voice Rooms',
      liveStreams: 'Live Video 🎥',
      games: 'Games Center',
      wallet: 'Wallet & Recharge',
      profile: 'Profile',
      recharge: 'Recharge',
      exchange: 'Exchange',
      pkBattle: 'Hot PK Battle 🔥',
      send: 'Send',
      sayHi: 'Say hi...',
      headwear: 'Headwear',
      vehicle: 'Vehicle',
      viewers: 'viewers',
      balance: 'My coin balance',
      diamondBalance: 'My diamond balance',
      close: 'Close ❌',
      gifts: '🎁 Gifts'
    }
  };

  return (
    <div className={`min-h-screen bg-gradient-to-b from-[#1a0b36] via-[#2a0e4f] to-[#0f051d] text-white font-sans ${lang === 'ar' ? 'rtl' : 'ltr'}`}>
      
      {/* شريط التحكم العلوي */}
      <header className="flex justify-between items-center p-4 bg-black/40 backdrop-blur-md border-b border-purple-900/50 sticky top-0 z-50">
        <div className="flex items-center space-x-2 space-x-reverse">
          <span className="text-xl font-bold bg-gradient-to-r from-yellow-400 to-yellow-200 bg-clip-text text-transparent">👑 Magic Live & Voice</span>
        </div>
        <div className="flex items-center gap-3">
          <button 
            onClick={() => setLang(lang === 'ar' ? 'en' : 'ar')}
            className="px-3 py-1 bg-purple-700/60 hover:bg-purple-600 rounded-full text-xs font-semibold border border-purple-500/40 transition">
            {lang === 'ar' ? 'English 🇺🇸' : 'العربية 🇸🇦'}
          </button>
        </div>
      </header>

      {/* المحتوى الرئيسي */}
      <main className="p-4 pb-28">
        
        {/* 1. قائمة الغرف الصوتية الرئيسية (Home / Rooms) */}
        {currentTab === 'home' && (
          <div className="space-y-6">
            {/* إعلان الفوز المتحرك العلوي */}
            <div className="bg-gradient-to-r from-yellow-600/80 via-yellow-500/90 to-yellow-600/80 p-2 rounded-xl flex items-center justify-between shadow-lg border border-yellow-300/40 animate-pulse">
              <div className="flex items-center gap-2 text-xs font-bold text-black">
                <span className="bg-black text-yellow-400 px-2 py-0.5 rounded">WIN</span>
                <span>عبدو الفيومي win 330,000 coins</span>
              </div>
              <button className="bg-black text-yellow-300 px-3 py-1 rounded-full text-xs font-black shadow">GO</button>
            </div>

            {/* تصنيفات الدول */}
            <div className="flex gap-2 overflow-x-auto pb-2">
              <button className="bg-purple-600 text-white text-xs px-4 py-1.5 rounded-full font-bold">الكل</button>
              <button className="bg-purple-950/60 text-purple-300 text-xs px-4 py-1.5 rounded-full border border-purple-800">مصر 🇪🇬</button>
              <button className="bg-purple-950/60 text-purple-300 text-xs px-4 py-1.5 rounded-full border border-purple-800">السعودية 🇸🇦</button>
              <button className="bg-purple-950/60 text-purple-300 text-xs px-4 py-1.5 rounded-full border border-purple-800">ترفيه 🎙️</button>
            </div>

            {/* شبكة الرومات الصوتية */}
            <div className="grid grid-cols-2 gap-3">
              {[
                { title: 'سهرة العندليب الطربية 🎵', host: 'كابتن أحمد', members: 7, bg: 'from-purple-900 to-indigo-950' },
                { title: 'قعدة شباب القاهرة والاسكندرية 🔥', host: 'ملك الإحساس', members: 5, bg: 'from-pink-950 to-purple-950' },
                { title: 'تحدي الدويتو والضحكة الصافية 😂', host: 'سمية المصرية', members: 8, bg: 'from-blue-950 to-purple-950' },
                { title: 'سوالف خليجية وعِزف عود 🎸', host: 'سلطان الدوسري', members: 6, bg: 'from-amber-950 to-purple-950' },
              ].map((room, idx) => (
                <div key={idx} onClick={() => setCurrentTab('room_active')} className={`bg-gradient-to-br ${room.bg} p-3 rounded-2xl border border-purple-700/40 cursor-pointer hover:scale-105 transition shadow-lg`}>
                  <div className="flex justify-between items-center mb-2">
                    <span className="text-[10px] bg-black/40 px-2 py-0.5 rounded-full text-yellow-300">🎙️ صوتي</span>
                    <span className="text-[10px] text-gray-300">👤 {room.members}/8</span>
                  </div>
                  <h4 className="font-bold text-xs truncate mb-1">{room.title}</h4>
                  <p className="text-[10px] text-purple-300">المضيف: {room.host}</p>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* 2. تفاصيل الغرفة الصوتية المباشرة (Voice Room Active) */}
        {currentTab === 'room_active' && (
          <div className="space-y-4">
            <div className="flex justify-between items-center bg-black/40 p-3 rounded-2xl border border-purple-900">
              <div>
                <h3 className="text-xs font-bold text-yellow-300">سهرة العندليب الطربية 🎵</h3>
                <span className="text-[10px] text-gray-400">ID: 994821</span>
              </div>
              <button onClick={() => setCurrentTab('home')} className="bg-purple-800 px-3 py-1 rounded-full text-xs font-bold">{t[lang].close}</button>
            </div>

            {/* منصة الكراسي الصوتية (مضيف + 8 كراسي) */}
            <div className="grid grid-cols-4 gap-4 justify-items-center my-6">
              <div className="col-span-4 flex flex-col items-center">
                <div className="w-16 h-16 rounded-full border-2 border-yellow-400 p-0.5 bg-purple-900/80 relative shadow-lg shadow-purple-500/30">
                  <div className="w-full h-full rounded-full bg-black/60 flex items-center justify-center text-xl">👑</div>
                </div>
                <span className="text-xs mt-1 text-yellow-200">Host (Ahmed)</span>
              </div>

              {[1, 2, 3, 4, 5, 6, 7, 8].map((seatNum) => (
                <div key={seatNum} className="flex flex-col items-center">
                  <div className="w-14 h-14 rounded-full border border-purple-400/50 bg-purple-950/70 flex items-center justify-center relative shadow-inner">
                    <span className="text-purple-300 text-sm">🪑</span>
                    <span className="absolute -bottom-1 bg-purple-900 text-purple-200 text-[10px] px-1.5 rounded-full border border-purple-600">{seatNum}</span>
                  </div>
                </div>
              ))}
            </div>

            {/* شات الروم الصوتي */}
            <div className="bg-black/30 backdrop-blur-sm rounded-2xl p-3 h-36 overflow-y-auto space-y-2 border border-purple-900/30 text-xs">
              <div className="text-gray-400 bg-purple-950/40 p-2 rounded-lg">Respect others and keep conversations polite.</div>
              <div className="text-green-300 bg-purple-900/20 p-2 rounded-lg">🎉 أحمد أرسل Lucky Pan*3، مع جائزة مضاعفة!</div>
            </div>

            {/* شريط الإرسال السفلي للروم الصوتي */}
            <div className="bg-purple-950/80 border border-purple-800/50 p-3 rounded-2xl flex items-center justify-between">
              <input type="text" placeholder={t[lang].sayHi} className="bg-black/40 border border-purple-700/50 rounded-full px-4 py-2 text-xs text-white focus:outline-none w-36" />
              <div className="flex items-center gap-2">
                <select value={selectedMultiplier} onChange={(e) => setSelectedMultiplier(Number(e.target.value))} className="bg-purple-900 text-white text-xs px-2 py-1.5 rounded-lg border border-purple-600">
                  <option value={1}>1x</option>
                  <option value={5}>5x</option>
                  <option value={10}>10x</option>
                  <option value={77}>77x</option>
                </select>
                <button className="bg-gradient-to-r from-purple-600 to-indigo-600 px-4 py-1.5 rounded-full text-xs font-bold shadow-lg">{t[lang].send}</button>
              </div>
            </div>
          </div>
        )}

        {/* 3. قائمة البث المرئي المباشر (Live Streams Video) */}
        {currentTab === 'live' && (
          <div className="space-y-4">
            <h2 className="text-lg font-bold text-yellow-300 flex items-center gap-2">🎥 {t[lang].liveStreams}</h2>
            <div className="grid grid-cols-2 gap-3">
              {[
                { name: 'نور الشام ✨', viewers: '4.2k', game: 'تحدي PK ساخن 🔥', avatar: '👩‍🰰' },
                { name: 'كابتن رامي 🏋️‍♂️', viewers: '1.8k', game: 'دردشة حرة', avatar: '🧔' },
                { name: 'حور الجنان 🌸', viewers: '9.5k', game: 'غناء طربي وعزف', avatar: '👩‍🎤' },
                { name: 'إسلام المصري 🇪🇬', viewers: '3.1k', game: 'ألعاب وربح جواهر', avatar: '👨‍💻' },
              ].map((stream, idx) => (
                <div key={idx} onClick={() => setCurrentTab('live_room')} className="relative h-48 rounded-2xl overflow-hidden border border-purple-700/50 bg-purple-950/80 cursor-pointer group shadow-xl">
                  <div className="absolute inset-0 flex items-center justify-center bg-gradient-to-t from-black via-transparent to-black/40">
                    <span className="text-5xl">{stream.avatar}</span>
                  </div>
                  <div className="absolute top-2 left-2 right-2 flex justify-between items-center text-[10px]">
                    <span className="bg-red-600 text-white px-2 py-0.5 rounded-full font-bold animate-pulse">LIVE</span>
                    <span className="bg-black/60 px-2 py-0.5 rounded-full text-gray-200">👁️ {stream.viewers}</span>
                  </div>
                  <div className="absolute bottom-2 left-2 right-2">
                    <p className="text-xs font-bold truncate">{stream.name}</p>
                    <p className="text-[10px] text-yellow-300 truncate">{stream.game}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* 4. غرفة البث المرئي الفردي وتحدي الـ PK (Live Stream View) */}
        {currentTab === 'live_room' && (
          <div className="relative h-[72vh] bg-black/60 rounded-3xl overflow-hidden border border-purple-800/60 flex flex-col justify-between p-4">
            <div className="flex justify-between items-center bg-black/40 backdrop-blur-md p-2 rounded-2xl">
              <div className="flex items-center gap-2">
                <div className="w-10 h-10 rounded-full bg-gradient-to-r from-pink-500 to-purple-600 p-0.5">
                  <div className="w-full h-full rounded-full bg-black flex items-center justify-center text-lg">👩‍🰰</div>
                </div>
                <div>
                  <h4 className="text-xs font-bold">نور الشام ✨</h4>
                  <span className="text-[10px] text-yellow-400">ID: 883920</span>
                </div>
              </div>
              <button onClick={() => setCurrentTab('live')} className="bg-red-600 px-3 py-1 rounded-full text-xs font-bold">{t[lang].close}</button>
            </div>

            <div className="bg-red-950/50 border border-red-500/40 p-2 rounded-xl text-center animate-pulse">
              <span className="text-xs font-extrabold text-red-400">⚔️ {t[lang].pkBattle}</span>
            </div>

            <div className="space-y-2">
              <div className="bg-black/40 backdrop-blur-sm rounded-2xl p-3 h-32 overflow-y-auto space-y-1 text-xs">
                <div className="text-yellow-300">👑 [VIP] أحمد: منورين أحلى بث!</div>
                <div className="text-pink-300">🎁 رامي أرسل هدية [Lucky Ring]</div>
                <div className="text-green-300">🎉 مبروك الفوز بالدعم السريع!</div>
              </div>
              <div className="flex items-center gap-2">
                <input type="text" placeholder={t[lang].sayHi} className="bg-black/50 border border-purple-700 rounded-full px-4 py-2 text-xs w-full focus:outline-none" />
                <button className="bg-gradient-to-r from-pink-600 to-purple-600 px-4 py-2 rounded-full text-xs font-bold shadow-lg">{t[lang].gifts}</button>
              </div>
            </div>
          </div>
        )}

        {/* 5. مركز الألعاب (Games Center) */}
        {currentTab === 'games' && (
          <div className="space-y-4">
            <h2 className="text-lg font-bold text-yellow-300">🔥 {t[lang].games}</h2>
            <div className="grid grid-cols-3 gap-3">
              {[
                { name: 'Egypt Winner', icon: '🏆', price: '10,000' },
                { name: 'Morocco Winner', icon: '⚽', price: '10,000' },
                { name: 'Dancing Cat', icon: '🐱', price: '27,777' },
                { name: 'Lucky Box', icon: '🎁', price: '57,777' },
                { name: 'Lucky 77', icon: '🎰', price: '77,777' },
                { name: 'Roulette', icon: '🎡', price: '777' },
              ].map((game, idx) => (
                <div key={idx} className="bg-purple-900/30 border border-purple-700/40 p-3 rounded-xl flex flex-col items-center text-center hover:bg-purple-800/40 transition">
                  <span className="text-3xl mb-1">{game.icon}</span>
                  <span className="text-[11px] font-semibold truncate w-full">{game.name}</span>
                  <span className="text-[10px] text-yellow-400 mt-1">🪙 {game.price}</span>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* 6. المحفظة (Wallet & Recharge) */}
        {currentTab === 'wallet' && (
          <div className="space-y-6 text-center">
            <div className="bg-purple-950/60 p-6 rounded-2xl border border-purple-800/50">
              <div className="text-4xl mb-2">🪙</div>
              <p className="text-gray-400 text-xs">{t[lang].balance}</p>
              <h3 className="text-3xl font-extrabold text-yellow-400 mt-1">{coins}</h3>
            </div>
            <div className="grid grid-cols-2 gap-3">
              <div className="bg-purple-900/40 p-4 rounded-xl border border-purple-700/40">
                <span className="text-xs text-gray-300">42,500 Coins</span>
                <p className="text-yellow-400 font-bold mt-1">$0.99</p>
              </div>
              <div className="bg-purple-900/40 p-4 rounded-xl border border-purple-700/40">
                <span className="text-xs text-gray-300">425,000 Coins</span>
                <p className="text-yellow-400 font-bold mt-1">$9.99</p>
              </div>
            </div>
          </div>
        )}

        {/* 7. الملف الشخصي والإطارات (Profile) */}
        {currentTab === 'profile' && (
          <div className="space-y-6">
            <div className="flex items-center gap-4 bg-purple-950/60 p-4 rounded-2xl border border-purple-800/40">
              <div className="w-16 h-16 rounded-full bg-gradient-to-tr from-yellow-400 to-purple-600 p-0.5">
                <div className="w-full h-full rounded-full bg-black flex items-center justify-center text-2xl">😎</div>
              </div>
              <div>
                <h3 className="font-bold text-base flex items-center gap-2">Mogrem 🇧🇭 <span className="text-xs bg-purple-800 px-2 py-0.5 rounded-full text-yellow-300">Lv.10</span></h3>
                <p className="text-xs text-gray-400 mt-0.5">ID: 3419764</p>
              </div>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="bg-purple-900/30 p-3 rounded-xl border border-purple-700/30">
                <h4 className="text-xs font-bold text-yellow-300 mb-2">{t[lang].headwear}</h4>
                <div className="flex gap-2">
                  <div className="w-10 h-10 rounded-full border border-yellow-400 bg-purple-950 flex items-center justify-center text-xs">👑</div>
                  <div className="w-10 h-10 rounded-full border border-purple-400 bg-purple-950 flex items-center justify-center text-xs">🌟</div>
                </div>
              </div>
              <div className="bg-purple-900/30 p-3 rounded-xl border border-purple-700/30">
                <h4 className="text-xs font-bold text-yellow-300 mb-2">{t[lang].vehicle}</h4>
                <div className="flex gap-2">
                  <div className="w-10 h-10 rounded-lg border border-orange-400 bg-purple-950 flex items-center justify-center text-xs">🏎️</div>
                </div>
              </div>
            </div>
          </div>
        )}

      </main>

      {/* شريط التنقل السفلي */}
      <nav className="fixed bottom-0 left-0 right-0 bg-black/80 backdrop-blur-lg border-t border-purple-900/50 flex justify-around py-3 px-2 z-50">
        <button onClick={() => setCurrentTab('home')} className={`flex flex-col items-center ${currentTab === 'home' || currentTab === 'room_active' ? 'text-yellow-400' : 'text-gray-400'}`}>
          <span className="text-xl">🎙️</span>
          <span className="text-[10px] mt-1">{t[lang].rooms}</span>
        </button>
        <button onClick={() => setCurrentTab('live')} className={`flex flex-col items-center ${currentTab === 'live' || currentTab === 'live_room' ? 'text-yellow-400' : 'text-gray-400'}`}>
          <span className="text-xl">🎥</span>
          <span className="text-[10px] mt-1">{t[lang].liveStreams}</span>
        </button>
        <button onClick={() => setCurrentTab('games')} className={`flex flex-col items-center ${currentTab === 'games' ? 'text-yellow-400' : 'text-gray-400'}`}>
          <span className="text-xl">🎮</span>
          <span className="text-[10px] mt-1">{t[lang].games}</span>
        </button>
        <button onClick={() => setCurrentTab('wallet')} className={`flex flex-col items-center ${currentTab === 'wallet' ? 'text-yellow-400' : 'text-gray-400'}`}>
          <span className="text-xl">💰</span>
          <span className="text-[10px] mt-1">{t[lang].wallet}</span>
        </button>
        <button onClick={() => setCurrentTab('profile')} className={`flex flex-col items-center ${currentTab === 'profile' ? 'text-yellow-400' : 'text-gray-400'}`}>
          <span className="text-xl">👤</span>
          <span className="text-[10px] mt-1">{t[lang].profile}</span>
        </button>
      </nav>

    </div>
  );
}
