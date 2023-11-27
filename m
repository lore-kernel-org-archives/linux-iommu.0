Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id BA52034562
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: (qmail 126610 invoked by uid 1000); 27 Nov 2023 11:02:20 -0500
Date: Mon, 27 Nov 2023 11:02:20 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Hamza Mahfooz <someguy@effective-light.com>,
  Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Andrew <travneff@gmail.com>,
  Ferry Toth <ferry.toth@elsinga.info>,
  Andy Shevchenko <andy.shevchenko@gmail.com>,
  Thorsten Leemhuis <regressions@leemhuis.info>, iommu@lists.linux.dev,
  Kernel development list <linux-kernel@vger.kernel.org>,
  USB mailing list <linux-usb@vger.kernel.org>
Subject: Bug in add_dma_entry()'s debugging code
Message-ID: <736e584f-7d5f-41aa-a382-2f4881ba747f@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Among other things, add_dma_entry() in kernel/dma/debug.c prints an 
error message when it sees two overlapping FROM_DEVICE DMA mappings.  
The actual overlap detection is performed by a separate routine, 
active_cacheline_insert().  But the criterion this routine uses is 
wrong.

All it looks for is mappings that start on the same cache line.  However 
on architectures that have cache-coherent DMA (such as x86), touching 
the same cache line does not mean that two DMA mappings will interfere 
with each other.  To truly overlap, they would have to touch the same 
_bytes_.

The routine does not check for this, and consequently we get error 
messages about overlapping mappings when in fact there is no overlap.  
This bug has been reported in

	https://bugzilla.kernel.org/show_bug.cgi?id=215740

How should this be fixed?  Since the check done in add_dma_entry() is 
completely invalid for x86 and similar architectures, should it simply 
be removed for them?  Or should the check be enhanced to look for 
byte-granularity overlap?

Alan Stern

PS: As a separate issue, active_cacheline_insert() fails to detect 
overlap in situations where a mapping occupies more than one cache line.  
For example, if mapping A uses lines N and N+1 and mapping B uses line 
N+1, no overlap will be detected because the radix-tree keys for A and B 
will be different (N vs. N+1).
