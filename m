Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8673588F
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id 797F568B05; Mon, 27 Nov 2023 17:08:00 +0100 (CET)
Date: Mon, 27 Nov 2023 17:07:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Hamza Mahfooz <someguy@effective-light.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew <travneff@gmail.com>, Ferry Toth <ferry.toth@elsinga.info>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	iommu@lists.linux.dev,
	Kernel development list <linux-kernel@vger.kernel.org>,
	USB mailing list <linux-usb@vger.kernel.org>
Subject: Re: Bug in add_dma_entry()'s debugging code
Message-ID: <20231127160759.GA1668@lst.de>
References: <736e584f-7d5f-41aa-a382-2f4881ba747f@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <736e584f-7d5f-41aa-a382-2f4881ba747f@rowland.harvard.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 27, 2023 at 11:02:20AM -0500, Alan Stern wrote:
> All it looks for is mappings that start on the same cache line.  However 
> on architectures that have cache-coherent DMA (such as x86), touching 
> the same cache line does not mean that two DMA mappings will interfere 
> with each other.  To truly overlap, they would have to touch the same 
> _bytes_.

But that is a special case that does not matter.  Linux drivers need
to be written in a portable way, and that means we have to care about
platforms that are not DMA coherent.

> How should this be fixed?  Since the check done in add_dma_entry() is 
> completely invalid for x86 and similar architectures, should it simply 
> be removed for them?  Or should the check be enhanced to look for 
> byte-granularity overlap?

The patch is every but "completely invalid".  It points out that you
violate the Linux DMA API requirements.  This might not have an
effect on the particular plaform you are currently running on, but it
is still wrong.  Note that there have been various mumblings about
using nosnoop dma on x86, in which case you'll have the issue there
as well.

> PS: As a separate issue, active_cacheline_insert() fails to detect 
> overlap in situations where a mapping occupies more than one cache line.  
> For example, if mapping A uses lines N and N+1 and mapping B uses line 
> N+1, no overlap will be detected because the radix-tree keys for A and B 
> will be different (N vs. N+1).

Fixes welcome.
