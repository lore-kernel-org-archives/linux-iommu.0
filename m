Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11877156DB;
	Mon, 11 Sep 2023 19:29:21 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso6100816a12.0;
        Mon, 11 Sep 2023 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694460560; x=1695065360; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZzh/DBuy01jQlncJ8BxreG4T0oh4ErWrLQjt3L1jcs=;
        b=fUVOCVz13t8vWSXI+2rZkj/tIy4Fuw+1VrDq4ys6OnFhqs6C3AqudtPHSZC+Ndo4qp
         OJV4E1FC9IYOOirrU8RRhgA4QIAVnhN6juGc8RdFoir2Q53br8jDkvfLTb4R6Wh+RYu3
         iYtXBOBmLJ+hvygajlRQlWrIMZSp8hhI7FCdFIgnZNNtvsQexryO7/nw7mMFo3YsEPlc
         tgUyksMa+GNyvdvuw0EJPQfftA+LfXBDk2mAOsC+oUYj0OLz2fORUrq+VsAmChdpWfIr
         pmEAdyTG0ihqNrTaHfQ0G9Rumgp7VTzDMHGcIQwFzT8nKQ2IjVnEvcJgn16Ez0iAsHjx
         8vwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694460560; x=1695065360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZzh/DBuy01jQlncJ8BxreG4T0oh4ErWrLQjt3L1jcs=;
        b=KyzpTuq61c4EQb3BzbMlTh+tkuMdN9p7LXvMCzspshyaHp358X63nz/iIpQZW4JRZk
         98v+w4eXCx0Is+d1ZkqIdA/eHj9amXWrX1o+MKdwDX40wLwd8GlLhu4DzTkme0mBCKYw
         hjtLuWtgwJtPfApQLUh5cnfgRaeNQJ5QxQRhgDpQkOqBxOU82DnuhWRTrRayzi46qfQi
         P8mpK4yqENwuHGF0toCbseq3kd/KEFyM9v3gKjKOpG6ieRqix4oHY8mEAjm4UDggB1kj
         wQtus3sf2jxB+Euep0DPhxPGyUpH/ua0joO/y4kmWDr8dbnwFUDhIC6ngRhWxHWGyh7X
         yyFw==
X-Gm-Message-State: AOJu0YyDmpSJqXSZ8J4B3i/ZQy8rSIq4SitJ+Co6ieX2Y850NlwLJU+O
	4aJVSHLiieu8LIKuSU4qpXM=
X-Google-Smtp-Source: AGHT+IH3JKjxir6dCvy6TAASsokGwwD1qL65KbvEhXU9Z1phY7jA9USqKstRMNkQ2Jhj8vTcYYdzXg==
X-Received: by 2002:aa7:d1cb:0:b0:52c:9f89:4447 with SMTP id g11-20020aa7d1cb000000b0052c9f894447mr8580218edp.4.1694460559977;
        Mon, 11 Sep 2023 12:29:19 -0700 (PDT)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id w9-20020aa7cb49000000b0051bed21a635sm5027658edt.74.2023.09.11.12.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:29:19 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: joro@8bytes.org, will@kernel.org, Robin Murphy <robin.murphy@arm.com>
Cc: wens@csie.org, samuel@sholland.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/sun50i: Allow page sizes between 4K and 1M
Date: Mon, 11 Sep 2023 21:29:18 +0200
Message-ID: <5707055.DvuYhMxLoT@archlinux>
In-Reply-To: <40649946-739b-fec6-d743-f7828613fec5@arm.com>
References:
 <20230911190218.1758812-1-jernej.skrabec@gmail.com>
 <40649946-739b-fec6-d743-f7828613fec5@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, September 11, 2023 9:06:12 PM CEST Robin Murphy wrote:
> On 2023-09-11 20:02, Jernej Skrabec wrote:
> > While peripheral supports only 4K page sizes, we can easily emulate
> > support for bigger page sizes, up to 1M. This is done by making multiple
> > entries in map function or clearing multiple entries in unmap.
> 
> No, it's done by converting over to the {map,unmap}_pages ops. There's
> no need to resurrect this horrible bodge.

Missed those, thanks! In any case, logic to implement those isn't that 
different than here.

Best regards,
Jernej

> 
> Thanks,
> Robin.
> 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> > 
> >   drivers/iommu/sun50i-iommu.c | 49 +++++++++++++++++++++++-------------
> >   1 file changed, 31 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> > index 74c5cb93e900..93077575d60f 100644
> > --- a/drivers/iommu/sun50i-iommu.c
> > +++ b/drivers/iommu/sun50i-iommu.c
> > @@ -95,6 +95,10 @@
> > 
> >   #define SPAGE_SIZE			4096
> > 
> > +#define SUN50I_IOMMU_PGSIZES		(SZ_4K | SZ_8K | SZ_16K | SZ_32K | 
\
> > +					 SZ_64K | SZ_128K | 
SZ_256K | \
> > +					 SZ_512K | SZ_1M)
> > +
> > 
> >   struct sun50i_iommu {
> >   
> >   	struct iommu_device iommu;
> > 
> > @@ -593,10 +597,12 @@ static int sun50i_iommu_map(struct iommu_domain
> > *domain, unsigned long iova,> 
> >   {
> >   
> >   	struct sun50i_iommu_domain *sun50i_domain = 
to_sun50i_domain(domain);
> >   	struct sun50i_iommu *iommu = sun50i_domain->iommu;
> > 
> > -	u32 pte_index;
> > +	u32 pte_index, pages, i;
> > 
> >   	u32 *page_table, *pte_addr;
> >   	int ret = 0;
> > 
> > +	pages = size / SPAGE_SIZE;
> > +
> > 
> >   	page_table = sun50i_dte_get_page_table(sun50i_domain, iova, gfp);
> >   	if (IS_ERR(page_table)) {
> >   	
> >   		ret = PTR_ERR(page_table);
> > 
> > @@ -604,18 +610,22 @@ static int sun50i_iommu_map(struct iommu_domain
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
> > +	for (i = 0; i < pages; i++) {
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
> > +	sun50i_table_flush(sun50i_domain, &page_table[pte_index], pages);
> > 
> >   out:
> >   	return ret;
> > 
> > @@ -626,8 +636,10 @@ static size_t sun50i_iommu_unmap(struct iommu_domain
> > *domain, unsigned long iova> 
> >   {
> >   
> >   	struct sun50i_iommu_domain *sun50i_domain = 
to_sun50i_domain(domain);
> >   	phys_addr_t pt_phys;
> > 
> > +	u32 dte, pages, i;
> > 
> >   	u32 *pte_addr;
> > 
> > -	u32 dte;
> > +
> > +	pages = size / SPAGE_SIZE;
> > 
> >   	dte = sun50i_domain->dt[sun50i_iova_get_dte_index(iova)];
> >   	if (!sun50i_dte_is_pt_valid(dte))
> > 
> > @@ -636,13 +648,14 @@ static size_t sun50i_iommu_unmap(struct iommu_domain
> > *domain, unsigned long iova> 
> >   	pt_phys = sun50i_dte_get_pt_address(dte);
> >   	pte_addr = (u32 *)phys_to_virt(pt_phys) +
> >   	sun50i_iova_get_pte_index(iova);
> > 
> > -	if (!sun50i_pte_is_page_valid(*pte_addr))
> > -		return 0;
> > +	for (i = 0; i < pages; i++)
> > +		if (!sun50i_pte_is_page_valid(pte_addr[i]))
> > +			return 0;
> > 
> > -	memset(pte_addr, 0, sizeof(*pte_addr));
> > -	sun50i_table_flush(sun50i_domain, pte_addr, 1);
> > +	memset(pte_addr, 0, sizeof(*pte_addr) * pages);
> > +	sun50i_table_flush(sun50i_domain, pte_addr, pages);
> > 
> > -	return SZ_4K;
> > +	return size;
> > 
> >   }
> >   
> >   static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain
> >   *domain,
> > 
> > @@ -827,7 +840,7 @@ static int sun50i_iommu_of_xlate(struct device *dev,
> > 
> >   }
> >   
> >   static const struct iommu_ops sun50i_iommu_ops = {
> > 
> > -	.pgsize_bitmap	= SZ_4K,
> > +	.pgsize_bitmap	= SUN50I_IOMMU_PGSIZES,
> > 
> >   	.device_group	= sun50i_iommu_device_group,
> >   	.domain_alloc	= sun50i_iommu_domain_alloc,
> >   	.of_xlate	= sun50i_iommu_of_xlate,




