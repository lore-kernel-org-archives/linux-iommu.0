From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Date: Wed, 17 Apr 2019 18:15:22 +0200
Message-ID: <20190417161042.GA43453@gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de, keescook@google.com, konrad.wilk@oracle.com, Juerg Haefliger <juerg.haefliger@canonical.com>, deepa.srinivasan@oracle.com, chris.hyser@oracle.com, tyhicks@canonical.com, dwmw@amazon.co.uk, andrew.cooper3@citrix.com, jcm@redhat.com, boris.ostrovsky@oracle.com, iommu@lists.linux-foundation.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Dave
List-Id: iommu@lists.linux-foundation.org


[ Sorry, had to trim the Cc: list from hell. Tried to keep all the 
  mailing lists and all x86 developers. ]

* Khalid Aziz <khalid.aziz@oracle.com> wrote:

> From: Juerg Haefliger <juerg.haefliger@canonical.com>
> 
> This patch adds basic support infrastructure for XPFO which protects 
> against 'ret2dir' kernel attacks. The basic idea is to enforce 
> exclusive ownership of page frames by either the kernel or userspace, 
> unless explicitly requested by the kernel. Whenever a page destined for 
> userspace is allocated, it is unmapped from physmap (the kernel's page 
> table). When such a page is reclaimed from userspace, it is mapped back 
> to physmap. Individual architectures can enable full XPFO support using 
> this infrastructure by supplying architecture specific pieces.

I have a higher level, meta question:

Is there any updated analysis outlining why this XPFO overhead would be 
required on x86-64 kernels running on SMAP/SMEP CPUs which should be all 
recent Intel and AMD CPUs, and with kernel that mark all direct kernel 
mappings as non-executable - which should be all reasonably modern 
kernels later than v4.0 or so?

I.e. the original motivation of the XPFO patches was to prevent execution 
of direct kernel mappings. Is this motivation still present if those 
mappings are non-executable?

(Sorry if this has been asked and answered in previous discussions.)

Thanks,

	Ingo
