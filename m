From: Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Date: Thu, 18 Apr 2019 08:34:32 -0600
Message-ID: <8f9d059d-e720-cd24-faa6-45493fc012e0@oracle.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com>
 <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com>
 <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
 <20190417172632.GA95485@gmail.com>
 <063753CC-5D83-4789-B594-019048DE22D9@gmail.com>
 <alpine.DEB.2.21.1904172317460.3174@nanos.tec.linutronix.de>
 <CAHk-=wgBMg9P-nYQR2pS0XwVdikPCBqLsMFqR9nk=wSmAd4_5g@mail.gmail.com>
 <alpine.DEB.2.21.1904180129000.3174@nanos.tec.linutronix.de>
 <CAHk-=whUwOjFW6RjHVM8kNOv1QVLJuHj2Dda0=mpLPdJ1UyatQ@mail.gmail.com>
 <CALCETrXm9PuUTEEmzA8bQJmg=PHC_2XSywECittVhXbMJS1rSA@mail.gmail.com>
 <CAGXu5jL-qJtW7eH8S2yhqciE+J+FWz8HHzTrGJTgVUbd55n6dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGXu5jL-qJtW7eH8S2yhqciE+J+FWz8HHzTrGJTgVUbd55n6dQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kees Cook <keescook@google.com>, Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave@sr71.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, deepa.srinivasan@oracle.com, "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <nadav.amit@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, X86 ML <x86@kernel.org>, LSM List <linux-security-module@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Julian Stecklina <jsteckli@amazon.de>, Arjan van de Ven <arjan@infradead.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jon Masters <jcm@redhat.com>, Borislav Petkov <bp@alien8.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, chris hyser <chris.hyser@oracle.com>, "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>, Khalid Aziz <khalid@gonehiking.org>, Juerg Haefliger <juergh@gmail.com>, Andrew Cooper <andrew.cooper3@citr>
List-Id: iommu@lists.linux-foundation.org

On 4/17/19 11:41 PM, Kees Cook wrote:
> On Wed, Apr 17, 2019 at 11:41 PM Andy Lutomirski <luto@kernel.org> wrote:
>> I don't think this type of NX goof was ever the argument for XPFO.
>> The main argument I've heard is that a malicious user program writes a
>> ROP payload into user memory (regular anonymous user memory) and then
>> gets the kernel to erroneously set RSP (*not* RIP) to point there.
> 
> Well, more than just ROP. Any of the various attack primitives. The NX
> stuff is about moving RIP: SMEP-bypassing. But there is still basic
> SMAP-bypassing for putting a malicious structure in userspace and
> having the kernel access it via the linear mapping, etc.
> 
>> I find this argument fairly weak for a couple reasons.  First, if
>> we're worried about this, let's do in-kernel CFI, not XPFO, to
> 
> CFI is getting much closer. Getting the kernel happy under Clang, LTO,
> and CFI is under active development. (It's functional for arm64
> already, and pieces have been getting upstreamed.)
> 

CFI theoretically offers protection with fairly low overhead. I have not
played much with CFI in clang. I agree with Linus that probability of
bugs in XPFO implementation itself is a cause of concern. If CFI in
Clang can provide us the same level of protection as XPFO does, I
wouldn't want to push for an expensive change like XPFO.

If Clang/CFI can't get us there for extended period of time, does it
make sense to continue to poke at XPFO?

Thanks,
Khalid
