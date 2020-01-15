Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA0C33CB1
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 09:45:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3B22187F
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 09:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDC5rTxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3B22187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D847B203D0;
	Wed, 15 Jan 2020 09:45:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iFZ0wK-1ZwN9; Wed, 15 Jan 2020 09:45:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BB4A2203C8;
	Wed, 15 Jan 2020 09:45:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97E14C1D83;
	Wed, 15 Jan 2020 09:45:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90444C077D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 09:45:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7D51E8618C
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 09:45:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gL7EDwsKOU4G for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 09:45:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C68E287812
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 09:45:34 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id q9so17081207wmj.5
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 01:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9wkd2dirzcLFMZe8FU543qaw7ijLSERXETdbeouxTnU=;
 b=IDC5rTxOPsqytGko2kQMljlQZBwBuNt8KKgY8q6IVAW/ySemHw5OtVmZYZGFvfjk5l
 GlWXT2vBGCuAa2XIepytG7BISG5MAAQp4FClvQ+7Gxplg445NhK4ii3kFHCOsiYlGxrU
 A0ERCUq5C0NZDeEOmSipXTQkvujaqr4xuaaKREBVgZZJy16KyNEVMT81TD3kMfVjcAOQ
 BQFv4WUk6iuqMyuL27FXeIOxm/zELox0Uo4Fk771+4DoDhhuNYKEaxHul726afcE1Z+w
 7D2oyg9fcoJ5C8vJmJqnq6dIH9xPcEYIil5AL4CwSHtlP9I6O7Q/Ll2kfdeCGqGL66gx
 6wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9wkd2dirzcLFMZe8FU543qaw7ijLSERXETdbeouxTnU=;
 b=acQQkP8GEKn4elGekmCOMW5L8cwLPiasfOEEJa5fMTuh4M3feZXNb5vmFCPymFfxBj
 LyLQJHDNb2AdNaqRPIqr7RosdSHIRZYm494B6MvuixeAleAC1QBBPH33CzronD1V4HPy
 DCt6f+oumzT5gOeMdbiZhr16Uq2lbVW+38rUB0NU3Xs/SGUgWLMwZs8gdlQatAdRWKER
 UfQ+Uvck3fv6D0Bcl4c8h/xc3fB1Z1ZDlxMg3euBuqFFAdSi++EMNikK+wBAhPWjNv5R
 utBLwjtD5PYVfxQhRyUK2yXGeRkwn5qU4Y99Vvy/Jyptx7odZQ46QuNLnrLDA7k42gn2
 lL2g==
X-Gm-Message-State: APjAAAXYdMcCqceV8fMmuzjI/KW8t0TJeTpDa7tLOYHaKU6tjyaqO3E1
 Zz1ilGALAz/a4SDq1y+KlSh52A==
X-Google-Smtp-Source: APXvYqxR2npzUP0k42uJhm9Im1rL58AtIxFUtjkScu/sxkhhW7+4pJhKUdhG5rM9VQoJWl4fFZgc9A==
X-Received: by 2002:a1c:488a:: with SMTP id
 v132mr31093095wma.153.1579081533150; 
 Wed, 15 Jan 2020 01:45:33 -0800 (PST)
Received: from myrica ([2001:171b:2266:ba60:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id j2sm22908749wmk.23.2020.01.15.01.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 01:45:32 -0800 (PST)
Date: Wed, 15 Jan 2020 10:45:27 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 10/13] iommu/arm-smmu-v3: Add second level of context
 descriptor table
Message-ID: <20200115094527.GB32782@myrica>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
 <20191219163033.2608177-11-jean-philippe@linaro.org>
 <20200114150435.GA2579@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200114150435.GA2579@willie-the-truck>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, guohanjun@huawei.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Jan 14, 2020 at 03:04:36PM +0000, Will Deacon wrote:
> On Thu, Dec 19, 2019 at 05:30:30PM +0100, Jean-Philippe Brucker wrote:
> > The SMMU can support up to 20 bits of SSID. Add a second level of page
> > tables to accommodate this. Devices that support more than 1024 SSIDs now
> > have a table of 1024 L1 entries (8kB), pointing to tables of 1024 context
> > descriptors (64kB), allocated on demand.
> > 
> > Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 154 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 144 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index b825a5639afc..bf106a7b53eb 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -224,6 +224,7 @@
> >  
> >  #define STRTAB_STE_0_S1FMT		GENMASK_ULL(5, 4)
> >  #define STRTAB_STE_0_S1FMT_LINEAR	0
> > +#define STRTAB_STE_0_S1FMT_64K_L2	2
> >  #define STRTAB_STE_0_S1CTXPTR_MASK	GENMASK_ULL(51, 6)
> >  #define STRTAB_STE_0_S1CDMAX		GENMASK_ULL(63, 59)
> >  
> > @@ -263,7 +264,20 @@
> >  
> >  #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
> >  
> > -/* Context descriptor (stage-1 only) */
> > +/*
> > + * Context descriptors.
> > + *
> > + * Linear: when less than 1024 SSIDs are supported
> > + * 2lvl: at most 1024 L1 entries,
> > + *       1024 lazy entries per table.
> > + */
> > +#define CTXDESC_SPLIT			10
> > +#define CTXDESC_L2_ENTRIES		(1 << CTXDESC_SPLIT)
> > +
> > +#define CTXDESC_L1_DESC_DWORDS		1
> > +#define CTXDESC_L1_DESC_VALID		1
> 
> 	#define CTXDESC_L1_DESC_V	(1UL << 0)
> 
> fits better with the rest of the driver and also ensures that the thing
> is unsigned (we should probably switch over the BIT macros, but that's a
> separate cleanup patch).
> 
> > +#define CTXDESC_L1_DESC_L2PTR_MASK	GENMASK_ULL(51, 12)
> > +
> >  #define CTXDESC_CD_DWORDS		8
> >  #define CTXDESC_CD_0_TCR_T0SZ		GENMASK_ULL(5, 0)
> >  #define ARM64_TCR_T0SZ			GENMASK_ULL(5, 0)
> > @@ -575,7 +589,12 @@ struct arm_smmu_cd_table {
> >  };
> >  
> >  struct arm_smmu_s1_cfg {
> > -	struct arm_smmu_cd_table	table;
> > +	/* Leaf tables or linear table */
> > +	struct arm_smmu_cd_table	*tables;
> > +	size_t				num_tables;
> > +	/* First level tables, when two levels are used */
> > +	__le64				*l1ptr;
> > +	dma_addr_t			l1ptr_dma;
> 
> It probably feels like a nit, but I think this is all a little hard to read
> because it differs unnecessarily from the way the stream table is handled.
> 
> Could we align the two as follows? (I've commented things with what they
> refer to in your patch):
> 
> 
> struct arm_smmu_l1_ctx_desc {				// arm_smmu_cd_table
> 	__le64				*l2ptr;		// ptr
> 	dma_addr_t			l2ptr_dma;	// ptr_dma
> };
> 
> struct arm_smmu_ctx_desc_cfg {
> 	__le64				*cdtab;		// l1ptr
> 	dma_addr_t			cdtab_dma;	// l1ptr_dma
> 	struct arm_smmu_l1_ctx_desc	*l1_desc;	// tables
> 	unsigned int			num_l1_ents;	// num_tables
> };
> 
> struct arm_smmu_s1_cfg {
> 	struct arm_smmu_ctx_desc_cfg	cdcfg;
> 	struct arm_smmu_ctx_desc	cd;
> 	u8				s1fmt;
> 	u8				s1cdmax;
> };
> 
> 
> I don't know whether you'd then want to move s1fmt and s1cdmax into the
> cdcfg, I'll leave that up to you. Similarly if you want any functions
> to operate on arm_smmu_ctx_desc_cfg in preference to arm_smmu_s1_cfg.
> 
> Thoughts?

No problem, it looks cleaner overall.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
