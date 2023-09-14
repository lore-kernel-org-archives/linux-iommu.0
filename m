Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE239C;
	Thu, 14 Sep 2023 15:09:31 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2bfbd7d49e7so17113861fa.1;
        Thu, 14 Sep 2023 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694704170; x=1695308970; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0p2Fq5+hhl2cqW/SVj6LzHkxBEiQPEgkqZ0kedkzFo=;
        b=JzII9vnQX1ZxPlYxfdd/38J9J54MtIjAvyrHSvcBsj3Pv0bj3OJNfESKM9LniIp3ML
         dWxzd9gZTQThcMb2BiwNARlXDbR2h8ggaI7OaKIp5ukc4UkPe1I8fmMBsolhpBw4J5BG
         kf9wMTfMcUUd0BX4y7BdlGs9p7ShQyeFwgJvzfEBy2hN2Ei79D1o/MzX5dxuA/Co8+mB
         wLQ8HKpkRiIsI7WhIxodvDtP7sPKUMGjeCLtje8++0mRxiEqP24F4qIiLU0gy1DYhNRU
         kYdSUqE1CaiI/fCguWkO1SATPSWRlxUUcbjXiMfMvTl65UvEQ1RvYhTo+GXyK7Rx3AJ3
         zGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694704170; x=1695308970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0p2Fq5+hhl2cqW/SVj6LzHkxBEiQPEgkqZ0kedkzFo=;
        b=GOnlNrW534BBz8fNfrFS72N85hp2q8VkRvHpmeKV6/pSp9ws2BBmq+CKjUnx9u50dK
         gvYDjo+Y3WzCWpnuRj0A3AexmcTgdAZtqt5mk6Lzp6frwh+zC3HLJD980rWJtezr0fSa
         AbCrHOZzNBrSne+CJVnO2UddmEbQ35HhpMQOuswcOj7Vk0eXyphdFG/84IuirFZcvv8H
         iN/pDyEP+FYJRvF259RrEi/KeEPgHFb/8xGqpd8DE2sLonXlzNcSCiXsZq5yErNSHLOi
         lOia/+wq551mjInsAQK2QzaWU1AaJfiNF6o7/NygkwSvf89cXJylMVjYcxqTmE3E1ff8
         ly8Q==
X-Gm-Message-State: AOJu0Yyg/tBWOjI1mhUqky6ElUmWtezMPlJDMfqhHNjdTiAqP/InCw3W
	oZSXuNoWg7+93CRKSJQhus4=
X-Google-Smtp-Source: AGHT+IH4YOeufwCrX/hbygxPlNKDg8361e4VDmQWvIJ0vsQn9E6uQVWHXteDHYpafcchB+dIAnqyDA==
X-Received: by 2002:a05:651c:103b:b0:2b6:dc55:c3c7 with SMTP id w27-20020a05651c103b00b002b6dc55c3c7mr5758747ljm.20.1694704169528;
        Thu, 14 Sep 2023 08:09:29 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id m18-20020a1709066d1200b00993a37aebc5sm1121294ejr.50.2023.09.14.08.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:09:29 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: joro@8bytes.org, will@kernel.org, Robin Murphy <robin.murphy@arm.com>
Cc: wens@csie.org, samuel@sholland.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/sun50i: Convert to map_pages/unmap_pages
Date: Thu, 14 Sep 2023 17:09:28 +0200
Message-ID: <5708623.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <157d5041-96ac-6bad-9137-19a78fbf3591@arm.com>
References:
 <20230912181941.2971036-1-jernej.skrabec@gmail.com>
 <157d5041-96ac-6bad-9137-19a78fbf3591@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne sreda, 13. september 2023 ob 22:20:15 CEST je Robin Murphy napisal(a):
> On 2023-09-12 19:19, Jernej Skrabec wrote:
> > Convert driver to use map_pages and unmap_pages. Since functions operate
> > on page table, extend them to be able to operate on whole table, not
> > just one entry.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> > Hi!
> > 
> > I'm not sure if it makes sense to check validity of page table entry when
> > unmaping pages makes sense. What do you think?
> 
> As things currently stand it's largely a matter of opinion - some
> drivers consider that unmapping something which hasn't been mapped is
> nonsensical, and almost always represents the caller having gone wrong,
> thus report it as an error; others take the view that as long as they
> can achieve the requested end result, they're not going to think too
> hard about how they got there. The same arguments apply to whether you'd
> quietly replace an existing PTE or not when mapping, so I'd say the main
> thing is to at least be self-consistent one way or the other.

Ok, I preserved strict checks in this update, which is consistent and same as 
before.

Best regards,
Jernej

> 
> Cheers,
> Robin.
> 
> > Best regards,
> > Jernej
> > 
> >   drivers/iommu/sun50i-iommu.c | 55 +++++++++++++++++++++---------------
> >   1 file changed, 33 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> > index 74c5cb93e900..be6102730a56 100644
> > --- a/drivers/iommu/sun50i-iommu.c
> > +++ b/drivers/iommu/sun50i-iommu.c
> > @@ -589,11 +589,12 @@ static u32 *sun50i_dte_get_page_table(struct
> > sun50i_iommu_domain *sun50i_domain,> 
> >   }
> >   
> >   static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long
> >   iova,> 
> > -			    phys_addr_t paddr, size_t size, int 
prot, gfp_t gfp)
> > +			    phys_addr_t paddr, size_t pgsize, size_t 
pgcount,
> > +			    int prot, gfp_t gfp, size_t *mapped)
> > 
> >   {
> >   
> >   	struct sun50i_iommu_domain *sun50i_domain = 
to_sun50i_domain(domain);
> >   	struct sun50i_iommu *iommu = sun50i_domain->iommu;
> > 
> > -	u32 pte_index;
> > +	u32 pte_index, count, i;
> > 
> >   	u32 *page_table, *pte_addr;
> >   	int ret = 0;
> > 
> > @@ -604,45 +605,55 @@ static int sun50i_iommu_map(struct iommu_domain
> > *domain, unsigned long iova,> 
> >   	}
> >   	
> >   	pte_index = sun50i_iova_get_pte_index(iova);
> > 
> > -	pte_addr = &page_table[pte_index];
> > -	if (unlikely(sun50i_pte_is_page_valid(*pte_addr))) {
> > -		phys_addr_t page_phys = 
sun50i_pte_get_page_address(*pte_addr);
> > -		dev_err(iommu->dev,
> > -			"iova %pad already mapped to %pa cannot 
remap to %pa prot: %#x\n",
> > -			&iova, &page_phys, &paddr, prot);
> > -		ret = -EBUSY;
> > -		goto out;
> > +	count = min(pgcount, (size_t)NUM_PT_ENTRIES - pte_index);
> > +	for (i = 0; i < count; i++) {
> > +		pte_addr = &page_table[pte_index + i];
> > +		if (unlikely(sun50i_pte_is_page_valid(*pte_addr))) {
> > +			phys_addr_t page_phys = 
sun50i_pte_get_page_address(*pte_addr);
> > +
> > +			dev_err(iommu->dev,
> > +				"iova %pad already mapped to %pa 
cannot remap to %pa prot: %#x\n",
> > +				&iova, &page_phys, &paddr, prot);
> > +			ret = -EBUSY;
> > +			goto out;
> > +		}
> > +		*pte_addr = sun50i_mk_pte(paddr, prot);
> > +		paddr += SPAGE_SIZE;
> > 
> >   	}
> > 
> > -	*pte_addr = sun50i_mk_pte(paddr, prot);
> > -	sun50i_table_flush(sun50i_domain, pte_addr, 1);
> > +	sun50i_table_flush(sun50i_domain, &page_table[pte_index], i);
> > +	*mapped = i * SPAGE_SIZE;
> > 
> >   out:
> >   	return ret;
> >   
> >   }
> >   
> >   static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned
> >   long iova,> 
> > -				 size_t size, struct 
iommu_iotlb_gather *gather)
> > +				 size_t pgsize, size_t pgcount,
> > +				 struct iommu_iotlb_gather 
*gather)
> > 
> >   {
> >   
> >   	struct sun50i_iommu_domain *sun50i_domain = 
to_sun50i_domain(domain);
> > 
> > +	u32 dte, count, i, pte_index;
> > 
> >   	phys_addr_t pt_phys;
> >   	u32 *pte_addr;
> > 
> > -	u32 dte;
> > 
> >   	dte = sun50i_domain->dt[sun50i_iova_get_dte_index(iova)];
> >   	if (!sun50i_dte_is_pt_valid(dte))
> >   	
> >   		return 0;
> >   	
> >   	pt_phys = sun50i_dte_get_pt_address(dte);
> > 
> > -	pte_addr = (u32 *)phys_to_virt(pt_phys) +
> > sun50i_iova_get_pte_index(iova); +	pte_index =
> > sun50i_iova_get_pte_index(iova);
> > +	pte_addr = (u32 *)phys_to_virt(pt_phys) + pte_index;
> > 
> > -	if (!sun50i_pte_is_page_valid(*pte_addr))
> > -		return 0;
> > +	count = min(pgcount, (size_t)NUM_PT_ENTRIES - pte_index);
> > +	for (i = 0; i < count; i++)
> > +		if (!sun50i_pte_is_page_valid(pte_addr[i]))
> > +			break;
> > 
> > -	memset(pte_addr, 0, sizeof(*pte_addr));
> > -	sun50i_table_flush(sun50i_domain, pte_addr, 1);
> > +	memset(pte_addr, 0, sizeof(*pte_addr) * i);
> > +	sun50i_table_flush(sun50i_domain, pte_addr, i);
> > 
> > -	return SZ_4K;
> > +	return i * SPAGE_SIZE;
> > 
> >   }
> >   
> >   static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain
> >   *domain,
> > 
> > @@ -838,8 +849,8 @@ static const struct iommu_ops sun50i_iommu_ops = {
> > 
> >   		.iotlb_sync_map = sun50i_iommu_iotlb_sync_map,
> >   		.iotlb_sync	= sun50i_iommu_iotlb_sync,
> >   		.iova_to_phys	= sun50i_iommu_iova_to_phys,
> > 
> > -		.map		= sun50i_iommu_map,
> > -		.unmap		= sun50i_iommu_unmap,
> > +		.map_pages	= sun50i_iommu_map,
> > +		.unmap_pages	= sun50i_iommu_unmap,
> > 
> >   		.free		= sun50i_iommu_domain_free,
> >   	
> >   	}
> >   
> >   };




