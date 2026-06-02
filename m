Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349603EEAEF
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410320; cv=none; b=JwVxK5EOsVcA0tbtXq+lZVHm0wJ2Vey0khRUl/1wpeiCh8FHnFMfRp8zPN7Xhw7I5sgpB2wQF4q+oS/UBgy9IhNiYQiI0SdW8l9mei9UfxcGttwWEvB9b94cuEDQCJFe+/ehym2Ow2F5srgevaabRc7wnFaabsdU6UCnHoaLskg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410320; c=relaxed/simple;
	bh=7c3By5Fqf6YUXX91bObyQOTRnp7RUJa/336wDuuAYVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMMkXsyB7nCKuF/txezJOZokwD2uc28yHcFSabijlhR1ixlc+lj20kbxUXigX54KDb6NwXbLf8yacvseJo0i4p6HukhYzPPVqFLcYBaK3HA16zYs0hsbDHHxEewjuD/8YdSYcWMChtS0WH+l76bllHZqLt9ntKJLYK+Rsn8sc1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CM8WVyVB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CM8WVyVB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49045e2a8a2so1055e9.0
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 07:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780410318; x=1781015118; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o9oIfSe8SaoV8fiGTSV1jg9fuPB2TzAWTv2+N73dZ3o=;
        b=CM8WVyVBurI20tTx7JGJ369tasyft/9nxew+Pet1N0qF0T372AReHIXwvUI7eQYFVM
         +5OcZY/6FLKyJhz7WcsUTovzEHJn6uxH9JpZ3qouWteOy5havD5pQU+VT9GmdbzB9vPi
         +6hqq+/TOV6l5ytdyaJ54GkUIgOrs5yVTBL5ENPMeXC1YFizaQPfSoGVnSeaIN2ohft3
         Wj1RrhzYezh3fRTq0MUVDIPO/DXvjKItX7WSqioqjS15gHuflzjQRJRhh5yhevn73J8f
         GQi5F1QifJqz8eQ0qOQuu0HDR/ywAmM5eEwQP9Mivpht9RV9KE4wH+IzgIgFi9bBgvBG
         zRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410318; x=1781015118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9oIfSe8SaoV8fiGTSV1jg9fuPB2TzAWTv2+N73dZ3o=;
        b=DlrqZQJvyPi8oX18y+YLyEY03VZZYcfDGZ8mG9KNau8NrUt0Lq8X6kHf9msEmPmvo2
         myHppoQtnS4yHQYAMg36rVEtKHofRtRDvzWw33aJwIH/GLCxPH9xxl3P2HitRkt4bofP
         9MvZFfP0/h45N9azynxMlyJlRh0n7Qr6m7ZmAR27Hkd25yWpz6tJK8/GIt7ns10uDc1b
         BUyTQ7THYai/6zwalepQ+Nb6Tpj2tVY2U/mBwYcrFTxKfr+r6jB87YALSuaPL2Q/VxVf
         kzK6lIFrXhXJhjhr3+33dxEDnvL1poBlGs5Fg11i7nJxuvTghDgx4Bi/yYITeD+LGGue
         NP9A==
X-Gm-Message-State: AOJu0Yw0CLIZnytbRGp8bJr1YcpJ2hl1Dn58HVwEbOKGB0NY7i//FLnK
	Ah9mC4J2ANyFyNtcpc5PAZKvYfd8oFo1ZxtDRNlVx4vkbADCU35SdtzmrITBhca3bg==
X-Gm-Gg: Acq92OG+cX/O6iFJnxKoZVkqFwmghP13tq5JsHwodVKppYYkFEk0nEfNgCcyYteiG/X
	D+HdotvSNRT+t76Of2HX3+ZDA0mxrAZlsVvT1DpAkke04Uv7EEpkbMQ4ZEJNlERaXS/+LtdYmj1
	7N1X7dZu3aaz4VlT/dkkrlF/887qm7nKEGCs1wI+d2WKUUTSTU34DFBDsTAH7SCpTeFFKNqj2eA
	iGZyXnRH35vpqwmHp1Td75ygIp73FFE6WIytHSJLWeB86Nv019/W0YKNFUe3ep/Qa0npcAsXj21
	NqTkzsqLfvqASKXrBh91VOhPjxQNKh1sq73y2hPi3Npm4w596CWILtUavA65TQi//saDJYr3B8n
	TIObuIcOpWE/Rds+hnqeNhlzqCex2Tr0GaaXVAcFWe86TGziPPBKSa2yj2b8OCbANit2ezuLRER
	lMMyPtByoQqybyLfE9eTiqZ5QBqbtgqkPUVdpMRkypFPR29/EVI3WS26NbZ4zD73bFOQili3v7
X-Received: by 2002:a05:600c:2203:b0:490:b4bb:21e with SMTP id 5b1f17b1804b1-490b4bb0331mr153245e9.1.1780410317170;
        Tue, 02 Jun 2026 07:25:17 -0700 (PDT)
Received: from google.com (203.80.140.34.bc.googleusercontent.com. [34.140.80.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e18e1csm66666745e9.4.2026.06.02.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:25:16 -0700 (PDT)
Date: Tue, 2 Jun 2026 14:25:12 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca
Subject: Re: [PATCH v2 0/8] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <ah7nyK0-XVUM74rO@google.com>
References: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420061415.3650870-1-aneesh.kumar@kernel.org>

On Mon, Apr 20, 2026 at 11:44:07AM +0530, Aneesh Kumar K.V (Arm) wrote:
> This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
> dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
> are handled consistently.
> 
> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> shared/decrypted buffer handling. This series consolidates the
> force_dma_unencrypted() checks in the top-level functions and ensures
> that the remaining DMA interfaces use DMA attributes to make the correct
> decisions.

I tested this series on protected KVM and did not see regressions.
Tested-by: Mostafa Saleh <smostafa@google.com>

Next, I will:
- Send the pKVM CC patch separately.
- Review this series.

Thanks,
Mostafa

> 
> The series:
> - moves swiotlb-backed allocations out of __dma_direct_alloc_pages(),
> - propagates DMA_ATTR_CC_SHARED through the dma-direct alloc/free
>   paths,
> - teaches the atomic DMA pools to track encrypted versus decrypted
>   state,
> - tracks swiotlb pool encryption state and enforces strict pool
>   selection,
> - centralizes encrypted/decrypted pgprot handling in dma_pgprot() using
>   DMA attributes,
> - makes dma_direct_map_phys() choose the DMA address encoding from
>   attrs, and
> - uses the selected swiotlb pool state to derive the returned DMA
>   address.
> 
> Changes from v1:
> * rebased to latest kernel (change from DMA_ATTR_CC_DECRYPTED -> DMA_ATTR_CC_SHARED)
> * Update alloc path such that DMA_ATTR_CC_SHARED s not a caller-visible attribute.
> 
> Aneesh Kumar K.V (Arm) (8):
>   dma-direct: swiotlb: handle swiotlb alloc/free outside
>     __dma_direct_alloc_pages
>   dma-direct: use DMA_ATTR_CC_SHARED in alloc/free paths
>   dma-pool: track decrypted atomic pools and select them via attrs
>   dma: swiotlb: track pool encryption state and honor DMA_ATTR_CC_SHARED
>   dma-mapping: make dma_pgprot() honor DMA_ATTR_CC_SHARED
>   dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED
>   dma-direct: set decrypted flag for remapped DMA allocations
>   dma-direct: select DMA address encoding from DMA_ATTR_CC_SHARED
> 
>  drivers/iommu/dma-iommu.c   |   2 +-
>  include/linux/dma-direct.h  |  10 ++
>  include/linux/dma-map-ops.h |   2 +-
>  include/linux/swiotlb.h     |   7 +-
>  kernel/dma/direct.c         | 185 ++++++++++++++++++++++++++++--------
>  kernel/dma/direct.h         |  25 ++---
>  kernel/dma/mapping.c        |  16 +++-
>  kernel/dma/pool.c           | 154 +++++++++++++++++++-----------
>  kernel/dma/swiotlb.c        |  89 +++++++++++++----
>  9 files changed, 355 insertions(+), 135 deletions(-)
> 
> 
> base-commit: c1f49dea2b8f335813d3b348fd39117fb8efb428
> -- 
> 2.43.0
> 
