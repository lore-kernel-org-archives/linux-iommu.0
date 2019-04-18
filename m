From: Kees Cook <keescook@google.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Date: Thu, 18 Apr 2019 00:41:45 -0500
Message-ID: <CAGXu5jL-qJtW7eH8S2yhqciE+J+FWz8HHzTrGJTgVUbd55n6dQ@mail.gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com> <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com> <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com> <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
 <20190417172632.GA95485@gmail.com> <063753CC-5D83-4789-B594-019048DE22D9@gmail.com>
 <alpine.DEB.2.21.1904172317460.3174@nanos.tec.linutronix.de>
 <CAHk-=wgBMg9P-nYQR2pS0XwVdikPCBqLsMFqR9nk=wSmAd4_5g@mail.gmail.com>
 <alpine.DEB.2.21.1904180129000.3174@nanos.tec.linutronix.de>
 <CAHk-=whUwOjFW6RjHVM8kNOv1QVLJuHj2Dda0=mpLPdJ1UyatQ@mail.gmail.com> <CALCETrXm9PuUTEEmzA8bQJmg=PHC_2XSywECittVhXbMJS1rSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrXm9PuUTEEmzA8bQJmg=PHC_2XSywECittVhXbMJS1rSA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Nadav Amit <nadav.amit@gmail.com>, Ingo Molnar <mingo@kernel.org>, Khalid Aziz <khalid.aziz@oracle.com>, Juerg Haefliger <juergh@gmail.com>, Tycho Andersen <tycho@tycho.ws>, Julian Stecklina <jsteckli@amazon.de>, Kees Cook <keescook@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Juerg Haefliger <juerg.haefliger@canonical.com>, deepa.srinivasan@oracle.com, chris hyser <chris.hyser@oracle.com>, Tyler Hicks <tyhicks@canonical.com>, David Woodhouse <dwmw@amazon.co.uk>, Andrew Cooper <andrew.cooper3@citrix.com>, Jon Masters <jcm@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, iommu <iommu@lists.linux-foundation.org>, X86 ML <x86@kernel.or>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 17, 2019 at 11:41 PM Andy Lutomirski <luto@kernel.org> wrote:
> I don't think this type of NX goof was ever the argument for XPFO.
> The main argument I've heard is that a malicious user program writes a
> ROP payload into user memory (regular anonymous user memory) and then
> gets the kernel to erroneously set RSP (*not* RIP) to point there.

Well, more than just ROP. Any of the various attack primitives. The NX
stuff is about moving RIP: SMEP-bypassing. But there is still basic
SMAP-bypassing for putting a malicious structure in userspace and
having the kernel access it via the linear mapping, etc.

> I find this argument fairly weak for a couple reasons.  First, if
> we're worried about this, let's do in-kernel CFI, not XPFO, to

CFI is getting much closer. Getting the kernel happy under Clang, LTO,
and CFI is under active development. (It's functional for arm64
already, and pieces have been getting upstreamed.)

> mitigate it.  Second, I don't see why the exact same attack can't be
> done using, say, page cache, and unless I'm missing something, XPFO
> doesn't protect page cache.  Or network buffers, or pipe buffers, etc.

My understanding is that it's much easier to feel out the linear
mapping address than for the others. But yes, all of those same attack
primitives are possible in other memory areas (though most are NX),
and plenty of exploits have done such things.

-- 
Kees Cook
