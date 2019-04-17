From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Date: Wed, 17 Apr 2019 19:26:32 +0200
Message-ID: <20190417172632.GA95485@gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com>
 <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com>
 <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Khalid Aziz <khalid.aziz@oracle.com>, juergh@gmail.com, Tycho Andersen <tycho@tycho.ws>, jsteckli@amazon.de, keescook@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Juerg Haefliger <juerg.haefliger@canonical.com>, deepa.srinivasan@oracle.com, chris.hyser@oracle.com, tyhicks@canonical.com, David Woodhouse <dwmw@amazon.co.uk>, Andrew Cooper <andrew.cooper3@citrix.com>, jcm@redhat.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>, iommu <iommu@lists.linux-foundation.org>, X86 ML <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, LSM List <linux-security-module@vger.kernel.org>, Khalid Aziz <khalid@gonehiking.o>
List-Id: iommu@lists.linux-foundation.org


* Nadav Amit <nadav.amit@gmail.com> wrote:

> > On Apr 17, 2019, at 10:09 AM, Ingo Molnar <mingo@kernel.org> wrote:
> > 
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
> > 
> > The PDF you cited says this:
> > 
> >  "Unfortunately, as shown in Table 1, the W^X prop-erty is not enforced 
> >   in many platforms, including x86-64.  In our example, the content of 
> >   user address 0xBEEF000 is also accessible through kernel address 
> >   0xFFFF87FF9F080000 as plain, executable code."
> > 
> > Is this actually true of modern x86-64 kernels? We've locked down W^X 
> > protections in general.
> 
> As I was curious, I looked at the paper. Here is a quote from it:
> 
> "In x86-64, however, the permissions of physmap are not in sane state.
> Kernels up to v3.8.13 violate the W^X property by mapping the entire region
> as “readable, writeable, and executable” (RWX)—only very recent kernels
> (≥v3.9) use the more conservative RW mapping.”

But v3.8.13 is a 5+ years old kernel, it doesn't count as a "modern" 
kernel in any sense of the word. For any proposed patchset with 
significant complexity and non-trivial costs the benchmark version 
threshold is the "current upstream kernel".

So does that quote address my followup questions:

> Is this actually true of modern x86-64 kernels? We've locked down W^X
> protections in general.
>
> I.e. this conclusion:
>
>   "Therefore, by simply overwriting kfptr with 0xFFFF87FF9F080000 and
>    triggering the kernel to dereference it, an attacker can directly
>    execute shell code with kernel privileges."
>
> ... appears to be predicated on imperfect W^X protections on the x86-64
> kernel.
>
> Do such holes exist on the latest x86-64 kernel? If yes, is there a
> reason to believe that these W^X holes cannot be fixed, or that any fix
> would be more expensive than XPFO?

?

What you are proposing here is a XPFO patch-set against recent kernels 
with significant runtime overhead, so my questions about the W^X holes 
are warranted.

Thanks,

	Ingo
