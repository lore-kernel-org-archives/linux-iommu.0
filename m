Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1A22153E1
	for <iommu@lists.linux.dev>; Mon, 31 Mar 2025 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743448253; cv=none; b=i5Fwghy2wIigDLO7puH5xWk6z5mIaEPC+YIQlPQoWRU6UVvEvzYIe+FqYZdHkECQcUEPlel9uBgf8S7rM0PwoDWW6LiSKIrHW/K7yRDsQOWiP2I8F3Nhyypgkh5UuIMaNQlnZtTASR8589amjrsqSVOFXiHMZuKHZMvxDyvhzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743448253; c=relaxed/simple;
	bh=YZzEwSKb0kqBKb0A2H4+zAX/AS8Wvht4a2tMV6ys5+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heXaDGBoLRaapheoUvyDfdUtLilL6CmqXT3tLxiViY3XFI08l8YP6cauIQXp3oPpUziS0rwVpGKDLdEz//Zv6sniT5rFThr5qwoBS3wKEkl1RuYYMTs79QurGBL33FO1ZWflgHmiYXdM2byy2o3g3WzTSz4NG7YWX3VwTkVcIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mWBLN5Ry; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mWBLN5Ry"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e900a7ce55so70091356d6.3
        for <iommu@lists.linux.dev>; Mon, 31 Mar 2025 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743448251; x=1744053051; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dt32gY7PII308zLmCJyd2JbPBk7pRfyqNOcGW9IblNM=;
        b=mWBLN5Ry+ZLRveB2Mv2PbRizfgqQY5C7h6nzGMqgL7b4pxOK+yhSjzD7BVNW//+ttq
         gHAgvc0SRpftJFVoAJGB7VqqAMva68nvkAjCszOaTdkdze8gbPPpK65Fcat2v/aJx6bc
         /llk7X1BZ8Kc7qB8n1MykreW1uRUs7JnXE8jr/OIuPeaE+XDq0UpE7knB8zhaMQEOjur
         niRf5HGBjas5tC9DIi/rnlXt08CZIrvwdNQz662L0MurjyddxQ4QrysOdF7OUscuS35/
         SqRTE7A8kyYevxe5V5hpBjvd5hWV5JQbLHMN3vMpp4w8iD40iwlNbmKyfXBfAe8+2eRI
         wKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743448251; x=1744053051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt32gY7PII308zLmCJyd2JbPBk7pRfyqNOcGW9IblNM=;
        b=JwWkwT/4gzRiTkXmw6epn2IBrhS0UQFaIfNa3K8BxacCNc2mydEp0wpSdHN77/EUry
         PULW+f/Bt6its93meyof64w3q/YYU/86Fe4SK/N+imoTegeCCLLbw6hIfpV3Z2OSR9KK
         0vJKSeWTfHaoc4lWI8QfyF9CetbySDx04XCsk5EFIYoh62jh0ovbYlI554vCQIq4hCsE
         i338beXcjSMUh8BZDJiudimoePa1u6Wm2bq1JmDfeLfZDNhYeEhkKJbjkunjQtENivxB
         JEveDOh2K3YzBsV+RfPT4LewzkSTI1TyFAEfy8IpUGVkZriDh1r11KRqDQCGv2Siy2sv
         22FA==
X-Forwarded-Encrypted: i=1; AJvYcCVHAFNUcAAfum4i888UtE6qM6bL+jamQ8KV6+ZtIqwD3+/PLtpSv+WMqNxZmWj5HddTBUkbVg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8lHLgSn/52E0MDEbYEjDREagIx3jOj6FuOd+nAIA4rywhF4/A
	Cu109aPFhcreV4qfzy8tfjVOvhp9vdoaxyvFq4iWYODq4QTm44b7fdQgAZpcq2k=
X-Gm-Gg: ASbGncvjkXnlaPtpp3mSVSIjaun2OHWvIAtB/ZVeeofyPbD3FOMUy50aSUoSSAFrHZg
	SyWs1l4vOYl59gBP/cNH3FabPtMavQeHOfR4XRuzvMwEaYQB51XXlKU3qC0Vy1yAAN41IZZcp8S
	dFG6k0/jZTxrH1uoJRmpke2yDYmRaGyIr6kM+EfT9U9y/uT5ikei1Ar9ON8gL2FhOtwP2pVaPS9
	O5IcGZ4k2l2PC7gBV2Fqx1Cn7tOTBZyWIdEPZlzU1pBMeZxRGO1uUte4JG5g9431mDVuh8AH+FI
	uQkf4AJ8YYTdoL9xtolGM8WgdLPPGyZj6vygwOpF/m9HaAP7pP6J7Zdy8AItkKFlb4ORmsC2Mc6
	pL85wSjOd4BzJmfTMnNF2rLM=
X-Google-Smtp-Source: AGHT+IEZHkY9cceG9Xv7rEu7PB72dn7pTp6BwVJLHoJ1MHilW0TdQewa+AGCIOjjtFFGEUJX/PJSGA==
X-Received: by 2002:a05:6214:19cd:b0:6df:99f7:a616 with SMTP id 6a1803df08f44-6eed5f4e587mr150303596d6.2.1743448250916;
        Mon, 31 Mar 2025 12:10:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9797136sm49986056d6.103.2025.03.31.12.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 12:10:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tzKX3-00000001EjT-33eb;
	Mon, 31 Mar 2025 16:10:49 -0300
Date: Mon, 31 Mar 2025 16:10:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 00/17] Provide a new two step DMA mapping API
Message-ID: <20250331191049.GB186258@ziepe.ca>
References: <20250220124827.GR53094@unreal>
 <CGME20250228195423eucas1p221736d964e9aeb1b055d3ee93a4d2648@eucas1p2.samsung.com>
 <1166a5f5-23cc-4cce-ba40-5e10ad2606de@arm.com>
 <d408b1c7-eabf-4a1e-861c-b2ddf8bf9f0e@samsung.com>
 <20250312193249.GI1322339@unreal>
 <adb63b87-d8f2-4ae6-90c4-125bde41dc29@samsung.com>
 <20250319175840.GG10600@ziepe.ca>
 <1034b694-2b25-4649-a004-19e601061b90@samsung.com>
 <20250322004130.GS126678@ziepe.ca>
 <c916a21e-2d95-476d-9895-4d91873fc5d5@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c916a21e-2d95-476d-9895-4d91873fc5d5@samsung.com>

On Fri, Mar 28, 2025 at 03:18:39PM +0100, Marek Szyprowski wrote:

> What kind of a fix is needed to dma_map_resource()/dma_unmap_resource() 
> API to make it usable with P2P DMA? It looks that this API is closest to 
> the mentioned dma_map_phys() and has little clients, so potentially 
> changing the function signature should be quite easy.

I looked at this once, actually it was one of my first ideas to get
the VFIO DMABUF side going. I gave up on it pretty fast because of how
hard it would be to actually use..

Something like this:

dma_addr_t dma_map_p2p(struct device *dma_dev, struct device *mmio_dev,
		       phys_addr_t phys_addr, u8 *unmap_flags, size_t size,
		       enum dma_data_direction dir, unsigned long attrs);
void dma_unmap_p2p(struct device *dev, dma_addr_t addr, u8 *unmap_flags,
		   size_t size, enum dma_data_direction dir,
		   unsigned long attrs);

Where 'unmap_flags' would have to be carried by the caller between map
and unmap. mmio_dev is part of the P2P metadata that dma_map_sg gets
out of the struct page via the pgmap.

unmap_flags is the big challenge, there is not an easy data structure
to put that u8 as a per-call array into in the DMABUF space. It could
maybe work not bad for VFIO, but the DRM DMABUF drivers would be a
PITA to store and this wouldn't be some trivial conversion I could do
to all drivers in a few hours.

But, the big killer is that such an API would not be suitable for
performance path, so even DMABUF might not want to use it.

If we start to fix the performance things then we end up back to this
series's API design where you have the notion of DMA transaction. The
more of the micro optimizations that this series has the closer the
APIs will be..

So, IDK, we could make some small painfull progress for VFIO with the
above, but replacing scatterlist would be off the table, we'd have to
continue to live with the DMABUF scatterlist abuse, and there is no
advancement toward a performance struct-page-less DMA API.

Jason
