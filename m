From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Date: Wed, 17 Apr 2019 12:49:04 -0700
Message-ID: <CALCETrXFzWFMrV-zDa4QFjB=4WnC9RZmorBko65dLGhymDpeQw@mail.gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com> <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com> <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com> <8d314750-251c-7e6a-7002-5df2462ada6b@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8d314750-251c-7e6a-7002-5df2462ada6b@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Ingo Molnar <mingo@kernel.org>, Juerg Haefliger <juergh@gmail.com>, Tycho Andersen <tycho@tycho.ws>, jsteckli@amazon.de, Kees Cook <keescook@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Juerg Haefliger <juerg.haefliger@canonical.com>, deepa.srinivasan@oracle.com, chris hyser <chris.hyser@oracle.com>, Tyler Hicks <tyhicks@canonical.com>, "Woodhouse, David" <dwmw@amazon.co.uk>, Andrew Cooper <andrew.cooper3@citrix.com>, Jon Masters <jcm@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, iommu@lists.linux-foundation.org, X86 ML <x86@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>LSM List <linux>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 17, 2019 at 10:33 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> On 4/17/19 11:09 AM, Ingo Molnar wrote:
> >
> > * Khalid Aziz <khalid.aziz@oracle.com> wrote:
> >
> >>> I.e. the original motivation of the XPFO patches was to prevent execution
> >>> of direct kernel mappings. Is this motivation still present if those
> >>> mappings are non-executable?
> >>>
> >>> (Sorry if this has been asked and answered in previous discussions.)
> >>
> >> Hi Ingo,
> >>
> >> That is a good question. Because of the cost of XPFO, we have to be very
> >> sure we need this protection. The paper from Vasileios, Michalis and
> >> Angelos - <http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>,
> >> does go into how ret2dir attacks can bypass SMAP/SMEP in sections 6.1
> >> and 6.2.
> >
> > So it would be nice if you could generally summarize external arguments
> > when defending a patchset, instead of me having to dig through a PDF
> > which not only causes me to spend time that you probably already spent
> > reading that PDF, but I might also interpret it incorrectly. ;-)
>
> Sorry, you are right. Even though that paper explains it well, a summary
> is always useful.
>
> >
> > The PDF you cited says this:
> >
> >   "Unfortunately, as shown in Table 1, the W^X prop-erty is not enforced
> >    in many platforms, including x86-64.  In our example, the content of
> >    user address 0xBEEF000 is also accessible through kernel address
> >    0xFFFF87FF9F080000 as plain, executable code."
> >
> > Is this actually true of modern x86-64 kernels? We've locked down W^X
> > protections in general.
> >
> > I.e. this conclusion:
> >
> >   "Therefore, by simply overwriting kfptr with 0xFFFF87FF9F080000 and
> >    triggering the kernel to dereference it, an attacker can directly
> >    execute shell code with kernel privileges."
> >
> > ... appears to be predicated on imperfect W^X protections on the x86-64
> > kernel.
> >
> > Do such holes exist on the latest x86-64 kernel? If yes, is there a
> > reason to believe that these W^X holes cannot be fixed, or that any fix
> > would be more expensive than XPFO?
>
> Even if physmap is not executable, return-oriented programming (ROP) can
> still be used to launch an attack. Instead of placing executable code at
> user address 0xBEEF000, attacker can place an ROP payload there. kfptr
> is then overwritten to point to a stack-pivoting gadget. Using the
> physmap address aliasing, the ROP payload becomes kernel-mode stack. The
> execution can then be hijacked upon execution of ret instruction. This
> is a gist of the subsection titled "Non-executable physmap" under
> section 6.2 and it looked convincing enough to me. If you have a
> different take on this, I am very interested in your point of view.

My issue with all this is that XPFO is really very expensive.  I think
that, if we're going to seriously consider upstreaming expensive
exploit mitigations like this, we should consider others first, in
particular CFI techniques.  grsecurity's RAP would be a great start.
I also proposed using a gcc plugin (or upstream gcc feature) to add
some instrumentation to any code that pops RSP to verify that the
resulting (unsigned) change in RSP is between 0 and THREAD_SIZE bytes.
This will make ROP quite a bit harder.
