From: Kees Cook via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
Date: Mon, 22 Apr 2019 15:23:32 -0700
Message-ID: <CAGXu5jLPkD_6BL1m2=13KVTfZ7znr-xAyz+CB23eoeboFgCSOg@mail.gmail.com>
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
	<8f9d059d-e720-cd24-faa6-45493fc012e0@oracle.com>
Reply-To: Kees Cook <keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8f9d059d-e720-cd24-faa6-45493fc012e0-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Dave Hansen <dave-gkUM19QKKo4@public.gmane.org>, "open list:DOCUMENTATION" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-MM <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, deepa.srinivasan-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org>, X86 ML <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, LSM List <linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Julian Stecklina <jsteckli-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>, Arjan van de Ven <arjan-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, chris hyser <chris.hyser-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, "linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Khalid Aziz <khalid-21RPF02GE+GXwddmVfQv5g@public.gmane.org>, Juerg Haefliger <juergh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Cooper <andrew.cooper3@ci>
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 18, 2019 at 7:35 AM Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
>
> On 4/17/19 11:41 PM, Kees Cook wrote:
> > On Wed, Apr 17, 2019 at 11:41 PM Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >> I don't think this type of NX goof was ever the argument for XPFO.
> >> The main argument I've heard is that a malicious user program writes a
> >> ROP payload into user memory (regular anonymous user memory) and then
> >> gets the kernel to erroneously set RSP (*not* RIP) to point there.
> >
> > Well, more than just ROP. Any of the various attack primitives. The NX
> > stuff is about moving RIP: SMEP-bypassing. But there is still basic
> > SMAP-bypassing for putting a malicious structure in userspace and
> > having the kernel access it via the linear mapping, etc.
> >
> >> I find this argument fairly weak for a couple reasons.  First, if
> >> we're worried about this, let's do in-kernel CFI, not XPFO, to
> >
> > CFI is getting much closer. Getting the kernel happy under Clang, LTO,
> > and CFI is under active development. (It's functional for arm64
> > already, and pieces have been getting upstreamed.)
> >
>
> CFI theoretically offers protection with fairly low overhead. I have not
> played much with CFI in clang. I agree with Linus that probability of
> bugs in XPFO implementation itself is a cause of concern. If CFI in
> Clang can provide us the same level of protection as XPFO does, I
> wouldn't want to push for an expensive change like XPFO.
>
> If Clang/CFI can't get us there for extended period of time, does it
> make sense to continue to poke at XPFO?

Well, I think CFI will certainly vastly narrow the execution paths
available to an attacker, but what I continue to see XPFO useful for
is stopping attacks that need to locate something in memory. (i.e. not
ret2dir but, like, read2dir.) It's arguable that such attacks would
just use heap, stack, etc to hold such things, but the linear map
remains relatively easy to find/target. But I agree: the protection is
getting more and more narrow (especially with CFI coming down the
pipe), and if it's still a 28% hit, that's not going to be tenable for
anyone but the truly paranoid. :)

All that said, there isn't a very good backward-edge CFI protection
(i.e. ROP defense) on x86 in Clang. The forward-edge looks decent, but
requires LTO, etc. My point is there is still a long path to gaining
CFI in upstream.

-- 
Kees Cook
