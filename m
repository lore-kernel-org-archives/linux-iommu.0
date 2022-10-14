Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935F828FA;
	Fri, 14 Oct 2022 15:03:57 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id a67so7181106edf.12;
        Fri, 14 Oct 2022 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0C0t3Bzybkn9+4XGQd/N9gYxMLzphWP8zpFWqf6WcLc=;
        b=ejq8RgwKb8KXuNH8oE5Rz95tCZ1s90ZkUzJ9IiwIBQMC0bjIxfbYWsOJp5pCY+zj86
         CRn+83E/dXCvxOoijOk7P9CPrHooIaJrMcmWcIBTjCbNwsKJ93N0kjnJNWSmVGriPnjS
         2wKEHjQ280dXJ6FiN79dE2LEARuam1uVFQRvRkFvq17W+q6WBSNX8KBPmP29tqfV+CQg
         bZvTdwKDgyJ3rqK4K06sZhskjrtalXa+MyqIgeiPTKI06uC9xjBdM+PRHIDhj3E8u4Oy
         IJEcZ7WsJ3NsXB4bNv43F8wEEYBXiDTOvliUouBKFBSu025JpFGm/j/oBqlW4PwLXwja
         p8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0C0t3Bzybkn9+4XGQd/N9gYxMLzphWP8zpFWqf6WcLc=;
        b=RtKtvNVB7eeJEqClX3FiR055ndgHIxaldu/4wC1zQrpZ/sI/C0Yy4ba14GJLjbaIDs
         tT9JOmdmyKE9am4PrQfgY20X6CU+jbSmFB3qShf3AsVm//0Iwf7cFV7DqIE2JuvSFOkU
         dj5F/IniArlA+fhOpORMUE0w7euNzm+KbVF7ARJa5V69HfpNDtPl6ihO1UIPD5FiU2rq
         +x8C5vD/kxm2i4JqyyKhoDluGWV9qdii0Wgpkb1TL/em1I/DVD+6bR+mZ2TDFbDMXdBw
         OIwg5UhbiPmraLhYTXv83b8lW74aa8LK9SFJDf87U4BkECZ2JYHtKDDZ0IIYdlMKZWn1
         EVpg==
X-Gm-Message-State: ACrzQf3UhGBKYSxKJKukf0aOpoNZB3saeQ+sqItDwYO6u5c8UXZ1cYlW
	Y8CKIZgkCayJjWFQHZfNW7Q=
X-Google-Smtp-Source: AMsMyM6n5TYixxzjKVJkR42cOB6Z7A9WsXklnbiisDz4tMmNnp55xREYU6ERXMG91w4OE9PPLNty0A==
X-Received: by 2002:a05:6402:1a4d:b0:459:319f:ff80 with SMTP id bf13-20020a0564021a4d00b00459319fff80mr4681904edb.144.1665759835585;
        Fri, 14 Oct 2022 08:03:55 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id kz12-20020a17090777cc00b00741a251d9e8sm1668219ejc.171.2022.10.14.08.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:03:55 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: maxime@cerno.tech, joro@8bytes.org, will@kernel.org, wens@csie.org, samuel@sholland.org, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH 5/5] iommu/sun50i: Invalidate iova in map and unmap callback
Date: Fri, 14 Oct 2022 17:03:54 +0200
Message-ID: <1866625.IobQ9Gjlxr@kista>
In-Reply-To: <71fb875f-5884-cbc6-534f-6ba72167bf6a@arm.com>
References: <20221013181221.3247429-1-jernej.skrabec@gmail.com> <20221013181221.3247429-7-jernej.skrabec@gmail.com> <71fb875f-5884-cbc6-534f-6ba72167bf6a@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne petek, 14. oktober 2022 ob 12:23:25 CEST je Robin Murphy napisal(a):
> On 2022-10-13 19:12, Jernej Skrabec wrote:
> > Mapped and unmapped iova addresses needs to be invalidated immediately
> > or otherwise they might or might not work when used by master or CPU.
> > 
> > This was discovered when running video decoder conformity test with
> > Cedrus. Some videos were now and then decoded incorrectly and generated
> > page faults.
> > 
> > Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> > 
> >   drivers/iommu/sun50i-iommu.c | 51 ++++++++++++++++++++++++++++++++++++
> >   1 file changed, 51 insertions(+)
> > 
> > diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> > index 7c3b2ac552da..21e47ce6946a 100644
> > --- a/drivers/iommu/sun50i-iommu.c
> > +++ b/drivers/iommu/sun50i-iommu.c
> > @@ -518,6 +518,53 @@ static u32 *sun50i_dte_get_page_table(struct
> > sun50i_iommu_domain *sun50i_domain,> 
> >   	return page_table;
> >   
> >   }
> > 
> > +static void sun50i_iommu_zap_iova(struct sun50i_iommu *iommu, unsigned
> > long iova) +{
> > +	unsigned long flags;
> > +	u32 reg;
> > +	int ret;
> > +
> > +	spin_lock_irqsave(&iommu->iommu_lock, flags);
> > +
> > +	iommu_write(iommu, IOMMU_AUTO_GATING_REG, 0);
> > +
> > +	iommu_write(iommu, IOMMU_TLB_IVLD_ADDR_REG, iova);
> > +	iommu_write(iommu, IOMMU_TLB_IVLD_ADDR_MASK_REG, GENMASK(11, 0));
> > +	iommu_write(iommu, IOMMU_TLB_IVLD_ENABLE_REG,
> > IOMMU_TLB_IVLD_ENABLE_ENABLE); +
> > +	ret = readl_poll_timeout_atomic(iommu->base + 
IOMMU_TLB_IVLD_ENABLE_REG,
> > +					reg, !reg, 1, 2000);
> > +	if (ret)
> > +		dev_warn(iommu->dev, "TLB invalidation timed out!\n");
> > +
> > +	iommu_write(iommu, IOMMU_AUTO_GATING_REG, 
IOMMU_AUTO_GATING_ENABLE);
> > +
> > +	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
> > +}
> > +
> > +static void sun50i_iommu_zap_ptw_cache(struct sun50i_iommu *iommu,
> > unsigned long iova) +{
> > +	unsigned long flags;
> > +	u32 reg;
> > +	int ret;
> > +
> > +	spin_lock_irqsave(&iommu->iommu_lock, flags);
> > +
> > +	iommu_write(iommu, IOMMU_AUTO_GATING_REG, 0);
> > +
> > +	iommu_write(iommu, IOMMU_PC_IVLD_ADDR_REG, iova);
> > +	iommu_write(iommu, IOMMU_PC_IVLD_ENABLE_REG,
> > IOMMU_PC_IVLD_ENABLE_ENABLE); +
> > +	ret = readl_poll_timeout_atomic(iommu->base + 
IOMMU_PC_IVLD_ENABLE_REG,
> > +					reg, !reg, 1, 2000);
> > +	if (ret)
> > +		dev_warn(iommu->dev, "PTW cache invalidation timed out!
\n");
> > +
> > +	iommu_write(iommu, IOMMU_AUTO_GATING_REG, 
IOMMU_AUTO_GATING_ENABLE);
> > +
> > +	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
> > +}
> > +
> > 
> >   static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long
> >   iova,>   
> >   			    phys_addr_t paddr, size_t size, int 
prot, gfp_t gfp)
> >   
> >   {
> > 
> > @@ -546,6 +593,8 @@ static int sun50i_iommu_map(struct iommu_domain
> > *domain, unsigned long iova,> 
> >   	*pte_addr = sun50i_mk_pte(paddr, prot);
> >   	sun50i_table_flush(sun50i_domain, pte_addr, 1);
> > 
> > +	sun50i_iommu_zap_iova(iommu, iova);
> > +	sun50i_iommu_zap_ptw_cache(iommu, iova);
> 
> Consider hooking up .sync_map if you need that behaviour. I'd guess the
> address/mask combination allows invalidating multiple pages at once,
> which would be a heck of a lot more efficient.
> 
> In principle we probably shouldn't need walk cache maintenance for just
> changing leaf entries, so that could perhaps be pushed further down into
> sun50i_dte_get_page_table().

Note that this is my first foray into iommu and sun50i-iommu documentation is 
confusing to say the least (it has english words in it, but their combination 
often doesn't make sense.) 

I'll try that, thanks. Without this invalidation, handing buffer between two 
iommu supported peripherals works, but CPU access often doesn't. PTW cache can 
be invalidated only one by one. It's TLB invalidation that has mask.

> 
> >   out:
> >   	return ret;
> > 
> > @@ -571,6 +620,8 @@ static size_t sun50i_iommu_unmap(struct iommu_domain
> > *domain, unsigned long iova> 
> >   	memset(pte_addr, 0, sizeof(*pte_addr));
> >   	sun50i_table_flush(sun50i_domain, pte_addr, 1);
> > 
> > +	sun50i_iommu_zap_iova(sun50i_domain->iommu, iova);
> > +	sun50i_iommu_zap_ptw_cache(sun50i_domain->iommu, iova);
> 
> Hmm, we already have .iotlb_sync hooked up for this, so at best adding
> more maintenance here is simply redundant, but at worst it would be
> papering over some bug in sun50i_iommu_iotlb_sync() - if unmaps really
> aren't working properly then that wants fixing instead. Of course it
> could also be enhanced to use the gather mechanism to perform more
> selective invalidations, but that's another patch in its own right.

.iotlb_sync assumes that flush operation will to the same thing as invalidation 
of each entry separately. It obviously doesn't, as my testing shows. I'll 
rewrite .iotlb_sync to do invalidation instead of flush and check if that 
works.

I have two questions:
1. documentation says it's mandatory to do TLB and PTW invalidation in 
interrupt handler when page fault occurs. Do you see a reason for that?
2. vendor driver and other iommu drivers have spin lock guards across whole 
.iova_to_phys, .map and .unmap functions. Should I add them here too?

Best regards,
Jernej

> 
> Thanks,
> Robin.
> 
> >   	return SZ_4K;
> >   
> >   }


