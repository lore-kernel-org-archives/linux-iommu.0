Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1058810FD
	for <iommu@lists.linux.dev>; Thu,  2 Feb 2023 10:09:36 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46D1168C7B; Thu,  2 Feb 2023 11:09:27 +0100 (CET)
Date: Thu, 2 Feb 2023 11:09:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: iommu@lists.linux.dev, mchehab@kernel.org, hch@lst.de,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Regression: v4l/bttv vbi vs iommu
Message-ID: <20230202100926.GA14931@lst.de>
References: <Y9qSwkLxeMpffZK/@gallifrey>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9qSwkLxeMpffZK/@gallifrey>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 01, 2023 at 04:26:42PM +0000, Dr. David Alan Gilbert wrote:
> f5ff79fddf0efecca538046b5cc20fb3ded2ec4f is the first bad commit
> commit f5ff79fddf0efecca538046b5cc20fb3ded2ec4f
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Sat Feb 26 16:40:21 2022 +0100
> 
>     dma-mapping: remove CONFIG_DMA_REMAP

Which just enabled some code on common x86 configs that was already
used on many other platforms.  In other words:  the code already
was buggy, but got away with it on x86 so far as no one tested on
e.g. arm or arm64.

The bug is in videobuf_dma_init_kernel:

	for (i = 0; i < nr_pages; i++) {
		void *addr;

		addr = dma_alloc_coherent(dma->dev, PAGE_SIZE,
					  &(dma->dma_addr[i]), GFP_KERNEL);
		if (addr == NULL)
			goto out_free_pages;

		dma->vaddr_pages[i] = virt_to_page(addr);
	}
	dma->vaddr = vmap(dma->vaddr_pages, nr_pages, VM_MAP | VM_IOREMAP,
			  PAGE_KERNEL);

The address by dma_alloc_coherent is just a kernel virtual address,
and virt_to_page must not be used on it as it could be vmalloc (as in
this case) or various other really odd forms of memory.

