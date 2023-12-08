Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DEF41C8E
	for <iommu@lists.linux.dev>; Fri,  8 Dec 2023 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RV8v6MrT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702065492; x=1733601492;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hzztr2vL6DpeporjOTsxI9y9kBcB6HDvx6vV8t2DZhw=;
  b=RV8v6MrTzdbBWd5lmLT6qHgJSel/TnzY5mLK7mMwYJLRasLUyv4CfkOR
   8OI5wYva+IdTpfQTOYIW2iPJT325Wlci2Oc/P2A48sAlBeNN87pS0Au70
   zrKHg5VTv2r2f24AbvZlf9NnUN7N0gtUT/mL32mmWlpvgRghlKbnUB6kU
   3PcRRlHHAuxzPEIBu3oi5G5rwWYPHWahoM3llN+59sKxemPxOXYnkh2lC
   ipPY4V1nOJRqpmMLKvvvJJJNlXVblpzgagLXOvRJvWqMMwp3NiLvVBHtJ
   lKtHZtpOozxna0MUmFH8tN7zVMibN1ZKATk4MHAVTgallxHMbVh/IVVvA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="398320437"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="398320437"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 11:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="842723679"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="842723679"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 11:57:44 -0800
Date: Fri, 8 Dec 2023 12:02:36 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML
 <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
 iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
 kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, Joerg Roedel
 <joro@8bytes.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov
 <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, Raj Ashok
 <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 maz@kernel.org, seanjc@google.com, Robin Murphy <robin.murphy@arm.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH RFC 09/13] x86/irq: Install posted MSI notification
 handler
Message-ID: <20231208120236.0f3b287d@jacob-builder>
In-Reply-To: <87zfyksyge.ffs@tglx>
References: <20231112041643.2868316-1-jacob.jun.pan@linux.intel.com>
	<20231112041643.2868316-10-jacob.jun.pan@linux.intel.com>
	<20231115125624.GF3818@noisy.programming.kicks-ass.net>
	<87cyvjun3z.ffs@tglx>
	<20231207204607.2d2a3b72@jacob-builder>
	<87zfyksyge.ffs@tglx>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Thomas,

On Fri, 08 Dec 2023 12:52:49 +0100, Thomas Gleixner <tglx@linutronix.de>
wrote:

> On Thu, Dec 07 2023 at 20:46, Jacob Pan wrote:
> > On Wed, 06 Dec 2023 20:50:24 +0100, Thomas Gleixner <tglx@linutronix.de>
> > wrote:  
> >> I don't understand what the whole copy business is about. It's
> >> absolutely not required.  
> >
> > My thinking is the following:
> > The PIR cache line is contended by between CPU and IOMMU, where CPU can
> > access PIR much faster. Nevertheless, when IOMMU does atomic swap of the
> > PID (PIR included), L1 cache gets evicted. Subsequent CPU read or xchg
> > will deal with invalid cold cache.
> >
> > By making a copy of PIR as quickly as possible and clearing PIR with
> > xchg, we minimized the chance that IOMMU does atomic swap in the middle.
> > Therefore, having less L1D misses.
> >
> > In the code above, it does read, xchg, and call_irq_handler() in a loop
> > to handle the 4 64bit PIR bits at a time. IOMMU has a greater chance to
> > do atomic xchg on the PIR cache line while doing call_irq_handler().
> > Therefore, it causes more L1D misses.  
> 
> That makes sense and if we go there it wants to be documented.
will do. How about this explanation:
"
Posted interrupt descriptor (PID) fits in a cache line that is frequently
accessed by both CPU and IOMMU.

During posted MSI processing, the CPU needs to do 64-bit read and xchg for
checking and clearing posted interrupt request (PIR), a 256 bit field
within the PID. On the other side, IOMMU do atomic swaps of the entire
PID cache line when posting interrupts. The CPU can access the cache line
much faster than the IOMMU.

The cache line states after each operation are as follows:

CPU		IOMMU			PID Cache line state
-------------------------------------------------------------
read64					exclusive
lock xchg64				modified
		post/atomic swap	invalid
-------------------------------------------------------------
Note that PID cache line is evicted after each IOMMU interrupt posting.

The posted MSI demuxing loop is written to optimize the cache performance
based on the two considerations around the PID cache line:

1. Reduce L1 data cache miss by avoiding contention with IOMMU's interrupt
posting/atomic swap, a copy of PIR is used to dispatch interrupt handlers.

2. Keep the cache line state consistent as much as possible. e.g. when
making a copy and clearing the PIR (assuming non-zero PIR bits are present
in the entire PIR), do:
read, read, read, read, xchg, xchg, xchg, xchg
instead of:
read, xchg, read, xchg, read, xchg, read, xchg
"

> 
> > Without PIR copy:
> >
> > DMA memfill bandwidth: 4.944 Gbps
> > Performance counter stats for './run_intr.sh 512 30':
> > 
> >     77,313,298,506      L1-dcache-loads
> >               (79.98%) 8,279,458      L1-dcache-load-misses     #
> > 0.01% of all L1-dcache accesses  (80.03%) 41,654,221,245
> > L1-dcache-stores                                              (80.01%)
> > 10,476      LLC-load-misses           #    0.31% of all LL-cache
> > accesses  (79.99%) 3,332,748      LLC-loads
> >                         (80.00%) 30.212055434 seconds time elapsed
> > 
> >        0.002149000 seconds user
> > 30.183292000 seconds sys
> >                         
> >
> > With PIR copy:
> > DMA memfill bandwidth: 5.029 Gbps
> > Performance counter stats for './run_intr.sh 512 30':
> >
> >     78,327,247,423      L1-dcache-loads
> >               (80.01%) 7,762,311      L1-dcache-load-misses     #
> > 0.01% of all L1-dcache accesses  (80.01%) 42,203,221,466
> > L1-dcache-stores                                              (79.99%)
> > 23,691      LLC-load-misses           #    0.67% of all LL-cache
> > accesses  (80.01%) 3,561,890      LLC-loads
> >                         (80.00%)
> >
> >       30.201065706 seconds time elapsed
> >
> >        0.005950000 seconds user
> >       30.167885000 seconds sys  
> 
> Interesting, though I'm not really convinced that this DMA memfill
> microbenchmark resembles real work loads.
> 
It is just a tool to get some quick experiments done, not realistic. Though
I am adding various knobs to make it more useful. e.g. adjustable interrupt
rate, delays in idxd hardirq handler.

> Did you test with something realistic, e.g. storage or networking, too?
> 
Not yet for this particular code, working on testing with FIO on Samsung
Gen5 NVMe disks. I am getting help from the people with the set up.


Thanks,

Jacob
