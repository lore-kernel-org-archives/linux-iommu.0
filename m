Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9746679
	for <iommu@lists.linux.dev>; Thu,  7 Jul 2022 14:20:32 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id k30so15225216edk.8
        for <iommu@lists.linux.dev>; Thu, 07 Jul 2022 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R3YvgoVOcvENsgz6mM2PhgZ4r8jumaGbydF495sktxQ=;
        b=V4iiItN/P7QOqwrv8hB5ZeqMGjjSsmKGmpL8MNiwT17QzCtpF919syW5BM/LN8l2JI
         V0NPBda6S9YXHWL7349PlufZ2XVsGcND4XV9xkIfftSQN+RCPM9GNdXzaLp3CwTgypvG
         +i+9FsDKbnOHHCKW6nILHf6SXFi5hqdrkDVTwi3GIYUfuZoWgms84RyBXsTROnGeXvWn
         7CNIHUlyHJMSja8xHZqyGJZ8ciYTMiS7wBj/ilHUuMn8rMwdRxGlDi6BAC2GEwNzHTcR
         1NDSE5KGnBj03qUgxWIEK2K1gAdYRVG7kaPcJ0Kxy1fWo4UbkVNdZp4N5t6W02qMwATV
         hj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R3YvgoVOcvENsgz6mM2PhgZ4r8jumaGbydF495sktxQ=;
        b=bdn9ZHu2DJ1EpbdEYFUvFndv6pTkERWjHPS+ZAjhcnboJ0jWoGpHeprtYvVLAIsWB6
         kc3CHRFkPx3hNMVXxPVPdMQI60z9EPG8Zud3vEDJwXGGdH4vgosGR8In4xmSyWUZw87g
         bEi2GUNOORX224sg4vQu/wAeD0UIIxiOn5/Rfm0Rc/aTbDoRhei+VDIPS7o3hbFPFPnQ
         KQBDsymzp+4nf1BcgdoKCRP9/f3ZdprxI6ygj08NMqmVhX9WxaP9hJ9zCFD4tzGEvl4d
         XbS/744zOGrbrXrFTKspNAjSz5YIaIAOdMovef5Sw57z/+Ub32Q9rcFA/NIbVFU+8OSK
         bAAQ==
X-Gm-Message-State: AJIora/DzoAoUWunP+Ni7ogQ/Dhd9lb78Vp8KO55e/x0G6nMvLSfwosx
	z+uUcTA7IAON24h3r3/LY4I=
X-Google-Smtp-Source: AGRyM1sTkE4DDQ5Gd2nGohP4Wwi9Svf0DI7dgdf1GN+6OhqHEurLuKocx8rXzO9t3Nu60K9Ip58LyQ==
X-Received: by 2002:a05:6402:4144:b0:431:6ef0:bef7 with SMTP id x4-20020a056402414400b004316ef0bef7mr60613152eda.151.1657203630423;
        Thu, 07 Jul 2022 07:20:30 -0700 (PDT)
Received: from anparri (host-79-49-199-193.retail.telecomitalia.it. [79.49.199.193])
        by smtp.gmail.com with ESMTPSA id b4-20020a1709065e4400b00706287ba061sm18931212eju.180.2022.07.07.07.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:20:30 -0700 (PDT)
Date: Thu, 7 Jul 2022 16:20:24 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Anvin <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC PATCH 2/2] dma-direct: Fix dma_direct_{alloc,free}() for
 Hyperv-V IVMs
Message-ID: <20220707142024.GA14362@anparri>
References: <20220706195027.76026-1-parri.andrea@gmail.com>
 <20220706195027.76026-3-parri.andrea@gmail.com>
 <20220707055840.GA13401@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707055840.GA13401@lst.de>

> > @@ -305,6 +306,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >  		ret = page_address(page);
> >  		if (dma_set_decrypted(dev, ret, size))
> >  			goto out_free_pages;
> > +#ifdef CONFIG_HAS_IOMEM
> > +		/*
> > +		 * Remap the pages in the unencrypted physical address space
> > +		 * when dma_unencrypted_base is set (e.g., for Hyper-V AMD
> > +		 * SEV-SNP isolated guests).
> > +		 */
> > +		if (dma_unencrypted_base) {
> > +			phys_addr_t ret_pa = virt_to_phys(ret);
> > +
> > +			ret_pa += dma_unencrypted_base;
> > +			ret = memremap(ret_pa, size, MEMREMAP_WB);
> > +			if (!ret)
> > +				goto out_encrypt_pages;
> > +		}
> > +#endif
> 
> 
> So:
> 
> this needs to move into dma_set_decrypted, otherwise we don't handle
> the dma_alloc_pages case (never mind that this is pretty unreadable).
> 
> Which then again largely duplicates the code in swiotlb.  So I think
> what we need here is a low-level helper that does the
> set_memory_decrypted and memremap.  I'm not quite sure where it
> should go, but maybe some of the people involved with memory
> encryption might have good ideas.  unencrypted_base should go with
> it and then both swiotlb and dma-direct can call it.

Agreed, will look into this more  (other people's ideas welcome).


> > +	/*
> > +	 * If dma_unencrypted_base is set, the virtual address returned by
> > +	 * dma_direct_alloc() is in the vmalloc address range.
> > +	 */
> > +	if (!dma_unencrypted_base && is_vmalloc_addr(cpu_addr)) {
> >  		vunmap(cpu_addr);
> >  	} else {
> >  		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
> >  			arch_dma_clear_uncached(cpu_addr, size);
> > +#ifdef CONFIG_HAS_IOMEM
> > +		if (dma_unencrypted_base) {
> > +			memunmap(cpu_addr);
> > +			/* re-encrypt the pages using the original address */
> > +			cpu_addr = page_address(pfn_to_page(PHYS_PFN(
> > +					dma_to_phys(dev, dma_addr))));
> > +		}
> > +#endif
> >  		if (dma_set_encrypted(dev, cpu_addr, size))
> 
> Same on the unmap side.  It might also be worth looking into reordering
> the checks in some form instead o that raw dma_unencrypted_base check
> before the unmap.

Got it.

Thanks,
  Andrea
