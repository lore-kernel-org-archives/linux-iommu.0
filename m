Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629350;
	b=WfMjNn0Qe9eo2v5ZfveuuCRrm6U4qXUxU5vmcqghQDsF+7Y1ygiG717VeTnaRjtAIVgM
	 OGB2crkwbrYQui1jx3ko8LIWOlc0T3yjjWnFRakBNaZlSYmfDPlw800h5lmz94x5PwWEy
	 HUkNhj5eRr3lNLDEy+oj3qYa18V1ysewbVTk8RDk+sw5LgXdmsk/kQ9A/+UJnvrjqsyd3
	 URg791enVIEtqKQURUYrw1UindU2K27znh4k+JZ8qd7cPXMSby1imFatk6Aa8VCu1rfbW
	 9+t8kfAL9oWk29kF70rqsr4Phg4zqjdvD1D6dA3rHAjVAkWddNK75eaEo7hwELFGCXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZhgvvGhr19GJBCcJ3nyYAHYL8qsS8Qu8flUoaHfsv+4=;
	b=lDGCpSf/nO2gmCk/96Keo7nmRTGqqA9w+mVjKl8Uicz5Uk+Pg6ULIM3IxdkZmJBMshcS
	 dbqg8IoSLQ+nNwxctaKflywN+hsEGWV//DS7Ei+kmmpqHkVIRHzbsYL+cUfawUks2BB9a
	 xAKOKSh0LLHCza1h7uYgvjk7uIleazj2ML2/wms/ivt0+TYVeIzbKlUx38N5GoPZeg/4E
	 tnc6SPuDmXN7K1FMWBWrc+EZVFwOZlbTs7HirhS4xFfszemQM7dV7+t4nhPk9hAqnAx0e
	 VBCg1N5R8Cdw11WmV9EqV57O5ih7KVrzPV6xClKbTnToByyXvU5FYRBl6CAv7zhIGiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YtWIQKi1;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3585606A321
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 17:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3585606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=YtWIQKi1
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5430f70c827so72195831cf.2
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 09:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795629349; x=1796234149; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZhgvvGhr19GJBCcJ3nyYAHYL8qsS8Qu8flUoaHfsv+4=;
        b=YtWIQKi1a39yw7ox7ZJvw4pECqod3vu1tnJ6kSIbxQOki0xgTvjxTofMWD+k6QptGN
         fDdHmZ8VlGfpjqvlOXJXyk+C9qInvUVlQ7o85rHedCuaI+knMlWMGMWjgRPHttxioBVr
         6bK7FfsDZ+8jN1899wi3cT79XaIZvUYCPLSEnpO3Z0qE9qSqj23/rC0ptDHDaqZY9LHq
         yiZ2k0uPCiBsjFfUfV8n0Vz/E5TzrNm/kUkDHInrATppLESuIejLpzdTjHoRmH9yb+PK
         w/4IG+YJGM3PrAQRHucrxjceJr7Vmyzz+SMxAI0hAo8NSbWUvCeGcioSaA9GcAeomKvV
         ZoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629349; x=1796234149;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZhgvvGhr19GJBCcJ3nyYAHYL8qsS8Qu8flUoaHfsv+4=;
        b=D0JkQsKpGQ9/sDr6xKtwJA+F64tHx7/zhd7t4bIpH2VOznmCVZG3EGD9NyqFlr1t55
         MtdXHYsh9b14K5zteoKTNJuceuW5HlSZ1Lw8VYNl3BAI+LyzGp6DwV1f5iCy3bxqTCd3
         XV+i2bUUgdNpaPB9o8TiogvB96g59+SKh3lqqAkLRMoH18qJ5EX7I8MKoTnz9YelA0A8
         3cb2tjELE47yaSflqVP99pPM6LOsQdtROxdIOIAZBLUsU4Uvesc61GkmKs7OoBvYug5l
         ILxrvW77tVvHtR2Zekw+P3m++sXNd7MHq4YOnqo88uqnR9O1ucNzgF5UZMLF8RSjGh5M
         lJUA==
X-Forwarded-Encrypted: i=1; AL+hErGEnVmEGYiqc8Zst8IKMeaeEDfQ6TyugfACetW1PXnzI6iPTjDtSXmWg05syeqD3h1d1AI0vQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/SfiCZL0qiV3qaViv3tBbgUgvmury+hUQvTBwQgd7jqq3OnseN
	NIDybgMaeMVZs7KDzQGX+AVfkUIGdtnDOnvdhM+oYAJAaj3oB4zvUzfGfvtFKpUyc1Y=
X-Gm-Gg: AZFdTZcnVmoxSuXqIrMjXeWkYGoOJAFy8g/2Ts+XxrWqfhVrBIoLtcEMDJs2eirrGAX
	c9d030KRHPoYrPrgBRXY/9aP/qUSb5YlGIahwarzQoDMPk0ngWUKT5xCLjZwLtdeMfov8JF10Tq
	2ReVM2HfsLsAFmMuas2dvfnMBHgZ1Qj/LDA7QejOPRzLdfX4ljbHF5AwhHz3rKfv1AuykheGTC8
	Cqdc+OyoIu88AN+cykWlgn+lbMcC2t3N8sS1nb4r+Y5BjCBl/uDaO5noYK8J4PGgXzSXKdkAdwj
	fhG0/cXuAjycHcW7aCV8EmwP8je0Mqi63PT63urlw/Hh/DopyNHdoPlqTDaagrHf1CZPoypX/pG
	CsCqTQdnIEJSuIqnQkVlHvZ97bRIV11/vZR1mTmY6G6J6tkX5CqmDDOwY7c05rWI7d1FX1ob8Ny
	D52Z8r4oiWecxHiThijoYWHqgQ0mZTsDg8JJHOY/v/h07Val5VWQNZfEjw8Yl4rAlvn7yGDL5OG
	NXMupPi7/yzOT1aXrkjcFWTDLJPwt0W9lHGZb7FiwNdBoyxetQkyNc55Uz7O1jiC24k5Zx0fxtc
	zYh+yw==
X-Received: by 2002:ac8:5706:0:b0:536:3760:e6cb with SMTP id d75a77b69052e-55d769e9387mr335085841cf.14.1795629348805;
        Wed, 25 Nov 2026 09:55:48 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55dbb8546ecsm18274511cf.4.2026.11.25.09.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:55:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWHDf-0000000298s-0hJB;
	Wed, 25 Nov 2026 13:55:47 -0400
Date: Wed, 25 Nov 2026 13:55:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Sibi Sankar <sibi.sankar@oss.qualcomm.com>, will@kernel.org,
	robin.murphy@arm.com, honghuan@amd.com,
	Leon Romanovsky <leonro@nvidia.com>, joro@8bytes.org,
	prakash.gupta@oss.qualcomm.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "iommu/dma: simplify dma_iova_destroy() and drop
 the free_iova helper"
Message-ID: <20261125175547.GM246011@ziepe.ca>
References: <CGME20261125135138eucas1p141ba6b5e09623562e2033e290fba811c@eucas1p1.samsung.com>
 <20261125135120.1126571-1-sibi.sankar@oss.qualcomm.com>
 <a3722347-4b88-41ad-926b-455530020c6b@samsung.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3722347-4b88-41ad-926b-455530020c6b@samsung.com>

On Wed, Nov 25, 2026 at 06:21:06PM +0100, Marek Szyprowski wrote:
> On 25.11.2026 14:51, Sibi Sankar wrote:
> > This reverts commit 1acce29926d93f3eba427696fe3da6451504dae2.
> >
> > Before this commit, dma_iova_destroy() unmapped through
> > __iommu_dma_iova_unlink(..., free_iova=true), which set
> > iotlb_gather.queued from cookie->fq_domain, skipped iommu_iotlb_sync()
> > and freed the IOVA with the queued gather, exactly like
> > __iommu_dma_unmap(). After it, dma_iova_destroy() calls
> > dma_iova_unlink() and then dma_iova_free():
> >
> >   - dma_iova_unlink() never marks its gather as queued and always calls
> >     iommu_iotlb_sync() after iommu_unmap_fast().
> >   - dma_iova_free() passes a NULL gather to iommu_dma_free_iova(), so
> >     the IOVA goes straight back to the allocator through
> >     free_iova_fast() and never through queue_iova().
> >
> > DMA-FQ domains therefore get strict invalidation on this path. That
> > includes the block layer's blk_rq_dma_map() path, which NVMe uses for
> > all data transfers, so iommu.strict=0 has no effect on NVMe I/O.
> >
> > hw/sw details: Qualcomm Glymur CRD: SMMUv3 with no RANGE_INV,
> > 	       4K pages; NVMe SSD on PCIe Gen5 x4
> >
> > Fio sequential read/write numbers:
> >   Domain                          seq write    seq read
> >   DMA (strict)                    2694 MiB/s   2693 MiB/s
> >   DMA-FQ (lazy), flush queue      2707 MiB/s   2803 MiB/s
> >     bypassed (this regression)
> >   DMA-FQ (lazy), flush queue      10.6 GiB/s   11.9 GiB/s
> >     used by dma_iova_destroy()
> >
> > Fixes: 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper")
> > Cc: stable@vger.kernel.org # v7.3+
> > Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> 
> 
> The performance data clearly shows that the flush queue was there for
> the reason. Together with this revert it would probably make sense to
> apply the v1 of the reverted patch:
> 
> https://lore.kernel.org/all/20260701092033.422867-1-honghuan@amd.com/
> 
> Leon, do You see any other option?

Oh, there are a couple of issues here too, and reverting isn't fixing
the main problem with this..

The issue is the assumption we can separate the sync from the free:

       if (!iotlb_gather.queued)
               iommu_iotlb_sync(domain, &iotlb_gather);
       if (free_iova)
                iommu_dma_free_iova(domain, addr, size, &iotlb_gather);

We cannot. The gather must always be retired, either be calling
iommu_iotlb_sync() or by calling iommu_dma_free_iova(). It can never
just be left dangling.

Further you can't call iommu_dma_free_iova() with a NULL gather once
unlink has been called. That risks things out of order where the
rbtree can show the freed iova before the associated queued flush has
happened. That is a correctness issue.

I suppose the resolution here is to feed the gather up the call chain
and allow it to be retired correctly instead of trying to short
circuit it inside the API.

Jason
