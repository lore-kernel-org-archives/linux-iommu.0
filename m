Return-Path: <SRS0=Tv0G=2I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412FBC2D0BF
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 16:10:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118702176D
	for <iommu@archiver.kernel.org>; Wed, 18 Dec 2019 16:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sxy90pGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118702176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C129020527;
	Wed, 18 Dec 2019 16:10:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zNPQVl0M4Qnq; Wed, 18 Dec 2019 16:10:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AFE8520407;
	Wed, 18 Dec 2019 16:10:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92955C1797;
	Wed, 18 Dec 2019 16:10:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB345C077D
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 16:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CC9B28734E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 16:10:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nzjHJoWuGp9R for <iommu@lists.linux-foundation.org>;
 Wed, 18 Dec 2019 16:10:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9B27B8733F
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 16:10:33 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id q10so2883092wrm.11
 for <iommu@lists.linux-foundation.org>; Wed, 18 Dec 2019 08:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=c8CBYJotaME8s7Ii/JzatZyff2J7fay7KXQVz82AJFg=;
 b=Sxy90pGkAdWmS2Fgg1g9dDmRYM88EKGHw+3sHdVzrc/jXY1im07pY4qUv1tGNMFQQk
 IcekmR8ZcC3tFNKeEjDAkEGo31sQzuifBkI1yTZSgyo4SKdsyJsWbVwWFYGXwlPpAkhx
 XRuhpq4pljIs7U5JvYnTtLM4nZitTnXapzCw5DQHNgB6SeKoZJeGkQ1klqygxkp7+RpW
 WjEwhJC4iCG1aEKCSznQiMBQpuy+m+bSMgY28JLRnV8cBMrn15RqbaEHWG6RiNnqDhbN
 nih4Ob9CXvxvj259j4M6yjk+0zriLR+qz1v/rwXtQ0kpWi6stqyzl02mE7nywETjkOB5
 IjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=c8CBYJotaME8s7Ii/JzatZyff2J7fay7KXQVz82AJFg=;
 b=fAXk5cu5iG9s3vcHLuDx1qdCPjpvGuwMj6rDkzVXXhE4NG4WflXRRVxB7wnYPCK0uZ
 PkPPEerv7YlDhj9oG06V3s+eepjipP0q9NDD4pfoRS/ahCTy9g1rSZdKzx9+973mRLui
 +mSc+EshLUwIfxM5c3QqHRu03gyz7GwDjR0l/2TuqZLgDt5eJ/UhAIpTmTD3euAWfAiM
 AjQlHNYTlao+NuAuzp9vsq99IZ9tjtVwawxUS42XMyREX8wLVKSHw11jGawB2CSIyPIL
 tF5nXGEB8ZrgKjgzs7D5i39yv5xQw3keOCHWz2yZmgVN/Cf/eSP0rcTOKQ41V3S/K2Ne
 NJuQ==
X-Gm-Message-State: APjAAAU/ggmjt7ygwGO3JBEXgYVpX10wUDos62v+STK6LA0U/zpZ2Egk
 EdHaCGyYXv+cUnnOropf80yf5w==
X-Google-Smtp-Source: APXvYqzsaGjamve7e+ufvEcnCPaUD5lFGwfiwdLCMRmGmU/OQUapuquuTDlM74GkdPYUKGdDnOKsEA==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr3895866wru.318.1576685432128; 
 Wed, 18 Dec 2019 08:10:32 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id 60sm3115391wrn.86.2019.12.18.08.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 08:10:31 -0800 (PST)
Date: Wed, 18 Dec 2019 17:10:26 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 10/13] iommu/arm-smmu-v3: Add second level of context
 descriptor table
Message-ID: <20191218161026.GH2371701@myrica>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-11-jean-philippe@linaro.org>
 <26230082-03d2-5c01-389a-9e32dd281b57@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <26230082-03d2-5c01-389a-9e32dd281b57@redhat.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 sudeep.holla@arm.com, rjw@rjwysocki.net, robin.murphy@arm.com,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, guohanjun@huawei.com, bhelgaas@google.com,
 zhangfei.gao@linaro.org, will@kernel.org, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
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

On Wed, Dec 18, 2019 at 10:59:36AM +0100, Auger Eric wrote:
> >  struct arm_smmu_s1_cfg {
> > -	struct arm_smmu_cd_table	table;
> > +	struct arm_smmu_cd_table	*tables;
> > +	size_t				num_tables;
> > +	__le64				*l1ptr;
> you may add a comment saying that l1ptr and l1ptr_dma are only set/used
> in non linear case and one comment saying that "tables" represent leaf
> tables.

I now have
	/* Leaf tables or linear table */
and
	/* First level tables, when two level are used */
but I'm not entirely convinced it adds value

> > +	dma_addr_t			l1ptr_dma;
> >  	struct arm_smmu_ctx_desc	cd;
> >  	u8				s1fmt;
> >  	u8				s1cdmax;
> > @@ -1521,9 +1538,53 @@ static void arm_smmu_free_cd_leaf_table(struct arm_smmu_device *smmu,
> >  {
> >  	size_t size = num_entries * (CTXDESC_CD_DWORDS << 3);
> >  
> > +	if (!table->ptr)
> > +		return;
> >  	dmam_free_coherent(smmu->dev, size, table->ptr, table->ptr_dma);
> >  }
> >  
> > +static void arm_smmu_write_cd_l1_desc(__le64 *dst,
> > +				      struct arm_smmu_cd_table *table)
> > +{
> > +	u64 val = (table->ptr_dma & CTXDESC_L1_DESC_L2PTR_MASK) |
> > +		  CTXDESC_L1_DESC_VALID;
> > +
> > +	WRITE_ONCE(*dst, cpu_to_le64(val));
> > +}
> > +
> > +static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
> > +				   u32 ssid)
> > +{
> > +	__le64 *l1ptr;
> > +	unsigned int idx;
> > +	struct arm_smmu_cd_table *table;
> > +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> > +	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> > +
> > +	if (cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR) {
> > +		table = &cfg->tables[0];
> > +		idx = ssid;
> > +	} else {
> nit: you may avoid this extra indent by either returning above or go to
> a label.
> > +		idx = ssid >> CTXDESC_SPLIT;
> > +		if (idx >= cfg->num_tables)
> > +			return NULL;
> > +
> > +		table = &cfg->tables[idx];
> > +		if (!table->ptr) {
> > +			if (arm_smmu_alloc_cd_leaf_table(smmu, table,
> > +							 CTXDESC_L2_ENTRIES))
> > +				return NULL;
> > +
> > +			l1ptr = cfg->l1ptr + idx * CTXDESC_L1_DESC_DWORDS;
> > +			arm_smmu_write_cd_l1_desc(l1ptr, table);
> > +			/* An invalid L1CD can be cached */
> > +			arm_smmu_sync_cd(smmu_domain, ssid, false);
> > +		}
> > +		idx = ssid & (CTXDESC_L2_ENTRIES - 1);
> > +	}
> > +	return table->ptr + idx * CTXDESC_CD_DWORDS;> +}
> > +
> >  static u64 arm_smmu_cpu_tcr_to_cd(u64 tcr)
> >  {
> >  	u64 val = 0;
> > @@ -1556,8 +1617,10 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
> >  	u64 val;
> >  	bool cd_live;
> >  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> > -	__le64 *cdptr = smmu_domain->s1_cfg.table.ptr + ssid *
> > -			CTXDESC_CD_DWORDS;
> > +	__le64 *cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
> > +
> > +	if (!cdptr)
> > +		return -ENOMEM;
> -ENOMEM does not fit well with (idx >= cfg->num_tables) case
> Besides the idx is checked against the max table capacity only in non
> linear mode. Can't you check the ssid against cfg->s1cdmax earlier?

Ok, I'll move that check here

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
