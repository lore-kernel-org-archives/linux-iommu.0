Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184F28B50C
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429341; cv=none; b=YrHM6izabe5IqKkeOcBUi/c0L7H3SSgqEJ6oHJX93PD2WfkwZMFD5z29LdTeBX8KAFKyhOYosm/6d70BwY0oN3hg7GLDB+6754Mpu2Qw1/f0ni6U8RhFS4ueFJE6K3+OOOl68FBMd+WUwoInNCS6gAwSKJOiwnhs8EoDbmc1eKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429341; c=relaxed/simple;
	bh=mRc8M0gxR/bW04Xju3faBLjTBvHDMb62s/e3kfp1ILA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwbWrEYi01m3kX8OkiLwXD5h1Bl0tOMG320YjhZ1VQUC8G/GQ7MIWYelNmUkW6dNb5TpMdQJ1eWbYFit5Vu49IDxIXQYzmdHvf/TeX7kS+9plp9bpQ0C8QWtwiI+U2xahQd74pKrCSZCooWPeT+nBke0PfOlZpkAsSHI1n+QC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=n7mO5+42; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n7mO5+42"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476a1acf61eso869201cf.1
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 10:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745429338; x=1746034138; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IO21pmrwIRca1fPgD174SCTD3P5B2ca9Ykqyd/DD35Q=;
        b=n7mO5+42K7XdMbljgf0Dvk+3Cf+O7pAJKo4vySwdBl3wjjr0X3MJjA+ynZLtz3NPn/
         3My6G6ppXXiCFokehtSE6veS5wVJOciGgi2gatCR3DYXLhrGzMjLyG8f84/TqSp15Gdj
         OIzdBZDFXeNZy1B/bvLuXYwIRSpQOc+lRYX5+YGgYF14qXjCZNiIl65KK3JHf6kgwt/u
         Z50vg52NkBrSGTzAiP6nYwVMPllBozCGhgziHCKuiwC5qJ/V6vd+mYTeayEzzImHjz4c
         D4mF25sUyucYu2Tm09jZ9mydNHc9KAUp04pSpa/am9DOCo8LsE9tZr3fX2oSrYkdoHGQ
         Zx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429338; x=1746034138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IO21pmrwIRca1fPgD174SCTD3P5B2ca9Ykqyd/DD35Q=;
        b=a3IGsOXrCHCog45Cv8RSS/ZtEcI5yUSPrjHf2fFiZN4F7ab+E4UqA87wQ0Xs9aTA0r
         lZMovft6qNXrd9I3CRtC1Ymzv7fQfb+2MAbzT0cgn2pnxOBGO5s8km3yYJuKGca9POWm
         AuZ2Gqib0g2+DDQdclMxNE2NOEphcTHO3gQoHJevEpSntNVJtOxCchMuogEjpKwm4lfG
         4+uvvXvNmF/dKnBXoexAmUK2hzZqo9/XsuR66e6Sk+WYTgWcelepqkGDoDzPV/XKEJr4
         E0EEd+NshA6WTrk9+uVpK79gc+iRi9+bv2JZwknbOCbTpOrG3RJJkBDlboXtSsn6sm3S
         NNtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0ssITZhXhQkguoBneciFuku72lFcDT5S8BuBaJ85Gz5GyBXtrtkXLSH1HPphGuuQNQKwBBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZ+Nwn3QxTwqCxz8hFt7dtGM+SB+2xJ3+RtMK9MhBdxn58p7Fy
	nulviybjO4P7s8fogk9Nwe52aLW7wEitf5HmtpZfeIVIkvt878ct+Mkt+/rl5gI=
X-Gm-Gg: ASbGncvCLtBhur8oPPZkOa6W++fo2RH/NC4dk5XeGPwNPKnFQ/ku7z3Dt+tsU503yOF
	DCNcxW++v9eBOhrqnUZMIfc91BsT0GHccOGNcqSto5TcOFQJQrJqXVWals5Wje1rrs1hPp7GFhs
	1Mo/WpsS6gtDuF9UMHZHXQyg6G8C38fr0WDQzeQLJeG896btbumLypKKUgs8WS4c6do319B4yVZ
	QGgmGZ4brwfieK6/1lIjTumx2Z1ylQTXO39LScfhc5jEs839wCXfWfb1rqHB+WH7uYxdMUkPjV+
	ph3v0GA/POLvKgd95mw1/D7lbV+McIXlo+9Wbhv/GGqmrX8pIqNxOGlo+//8pnkMo5UFKaIIjpW
	VCTBB9hWT3at7IVZqZn4=
X-Google-Smtp-Source: AGHT+IFhccZU7hwIpoqF9kdgyBZNm8CDnNWVmBsNPQQ6+B1QKTjLAh4Uz8aWpAuaS2cilFrr6VCiig==
X-Received: by 2002:a05:622a:18a6:b0:477:5c21:2e1f with SMTP id d75a77b69052e-47e77a9e41emr774971cf.34.1745429337818;
        Wed, 23 Apr 2025 10:28:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c3b5c3sm71026671cf.21.2025.04.23.10.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:28:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7du4-00000007LYP-3LLk;
	Wed, 23 Apr 2025 14:28:56 -0300
Date: Wed, 23 Apr 2025 14:28:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 11/24] mm/hmm: provide generic DMA managing logic
Message-ID: <20250423172856.GM1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <3abc42885831f841dd5dfe78d7c4e56c620670ea.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3abc42885831f841dd5dfe78d7c4e56c620670ea.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:02AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> HMM callers use PFN list to populate range while calling
> to hmm_range_fault(), the conversion from PFN to DMA address
> is done by the callers with help of another DMA list. However,
> it is wasteful on any modern platform and by doing the right
> logic, that DMA list can be avoided.
> 
> Provide generic logic to manage these lists and gave an interface
> to map/unmap PFNs to DMA addresses, without requiring from the callers
> to be an experts in DMA core API.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>

I don't think Jens tested the RDMA and hmm parts :)

> +	/*
> +	 * The HMM API violates our normal DMA buffer ownership rules and can't
> +	 * transfer buffer ownership.  The dma_addressing_limited() check is a
> +	 * best approximation to ensure no swiotlb buffering happens.
> +	 */

This is a bit unclear, HMM inherently can't do cache flushing or
swiotlb bounce buffering because its entire purpose is to DMA directly
and coherently to a mm_struct's page tables. There are no sensible
points we could put the required flushing that wouldn't break the
entire model.

FWIW I view that fact that we now fail back to userspace in these
cases instead of quietly malfunction to be a big improvement.

> +bool hmm_dma_unmap_pfn(struct device *dev, struct hmm_dma_map *map, size_t idx)
> +{
> +	struct dma_iova_state *state = &map->state;
> +	dma_addr_t *dma_addrs = map->dma_list;
> +	unsigned long *pfns = map->pfn_list;
> +	unsigned long attrs = 0;
> +
> +#define HMM_PFN_VALID_DMA (HMM_PFN_VALID | HMM_PFN_DMA_MAPPED)
> +	if ((pfns[idx] & HMM_PFN_VALID_DMA) != HMM_PFN_VALID_DMA)
> +		return false;
> +#undef HMM_PFN_VALID_DMA

If a v10 comes I'd put this in a const function level variable:

          const unsigned int HMM_PFN_VALID_DMA = HMM_PFN_VALID | HMM_PFN_DMA_MAPPED;

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
