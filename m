From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Date: Wed, 17 Apr 2019 19:09:18 +0200
Message-ID: <20190417170918.GA68678@gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com>
 <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de, keescook@google.com, konrad.wilk@oracle.com, Juerg Haefliger <juerg.haefliger@canonical.com>, deepa.srinivasan@oracle.com, chris.hyser@oracle.com, tyhicks@canonical.com, dwmw@amazon.co.uk, andrew.cooper3@citrix.com, jcm@redhat.com, boris.ostrovsky@oracle.com, iommu@lists.linux-foundation.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Dave
List-Id: iommu@lists.linux-foundation.org


* Khalid Aziz <khalid.aziz@oracle.com> wrote:

> > I.e. the original motivation of the XPFO patches was to prevent execution 
> > of direct kernel mappings. Is this motivation still present if those 
> > mappings are non-executable?
> > 
> > (Sorry if this has been asked and answered in previous discussions.)
> 
> Hi Ingo,
> 
> That is a good question. Because of the cost of XPFO, we have to be very
> sure we need this protection. The paper from Vasileios, Michalis and
> Angelos - <http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>,
> does go into how ret2dir attacks can bypass SMAP/SMEP in sections 6.1
> and 6.2.

So it would be nice if you could generally summarize external arguments 
when defending a patchset, instead of me having to dig through a PDF 
which not only causes me to spend time that you probably already spent 
reading that PDF, but I might also interpret it incorrectly. ;-)

The PDF you cited says this:

  "Unfortunately, as shown in Table 1, the W^X prop-erty is not enforced 
   in many platforms, including x86-64.  In our example, the content of 
   user address 0xBEEF000 is also accessible through kernel address 
   0xFFFF87FF9F080000 as plain, executable code."

Is this actually true of modern x86-64 kernels? We've locked down W^X 
protections in general.

I.e. this conclusion:

  "Therefore, by simply overwriting kfptr with 0xFFFF87FF9F080000 and 
   triggering the kernel to dereference it, an attacker can directly 
   execute shell code with kernel privileges."

... appears to be predicated on imperfect W^X protections on the x86-64 
kernel.

Do such holes exist on the latest x86-64 kernel? If yes, is there a 
reason to believe that these W^X holes cannot be fixed, or that any fix 
would be more expensive than XPFO?

Thanks,

	Ingo
