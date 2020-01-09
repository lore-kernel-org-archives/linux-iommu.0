Return-Path: <SRS0=4b30=26=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ECBC282DD
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 14:36:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BD82080D
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 14:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z6zkCoDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BD82080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2FE1C20405;
	Thu,  9 Jan 2020 14:36:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TfPpdAIu8dW4; Thu,  9 Jan 2020 14:36:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 69C9C20011;
	Thu,  9 Jan 2020 14:36:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63B72C18DC;
	Thu,  9 Jan 2020 14:36:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2261DC0881
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 14:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 11585863BB
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 14:36:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QNBPHHBiPnvU for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jan 2020 14:36:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C3F358625D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 14:36:26 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id c14so7622346wrn.7
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jan 2020 06:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=g2drrPLS9W1lcBDXqoZZiE3Yz8L8Qun+2VJ+iOV7n9U=;
 b=z6zkCoDmXbyKIxNdRu3f+62NTSmeRR1H7SSY5NSACWxmE7l6Hx44I/sC8Tv73fqYSs
 AU2DcCxpx+ac0feHDzb2ec0bwRByF0IBMLG2BS6y2ijM1gFmamN8HBNpKJ4H9yF4OsyT
 WTrfzeJZwSrjLTnegGFZ4jXXqqQdOlhQIB1yciwcd26uyVKWGN0v0glC7GaUqJW34+lJ
 eUaWwYy/Z73VEnyNwguYUX+e0xO+PmHCBz82W/M3kM+LhnyCmd15D/FQ2VmjHb/iWLX3
 sdAb3U3VrUpZAQXEOIi6jyKKLjQhqZxU/qGePqGTgDCO2wSItFKHvAPuoqyt+/kUNP5F
 Fjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g2drrPLS9W1lcBDXqoZZiE3Yz8L8Qun+2VJ+iOV7n9U=;
 b=U7gbi02GQ44mKqzLZ+2U3V+Mz4tarxAMHb+8J5TzQ2rWPoSexdLBAMHYXAz7ohdQGE
 ni+sDl23EiJPKc/DqTfPkNZlMdoNZ6xu/hz0oRcMY4+qpTk7sZMfHXnmaCRkMWm3vyJQ
 DMZVFvLfD5cEsE/IexC7J70at/D1OsFV5ZYAVX4ukPnRR4lztEaG9KHDMBUbVrVsyG08
 heZv8vqC8yt/OMM4E9H9jUGukFPebCh6qFClmZLTNRnqaA6AJJyxU437hyVL7yQKA826
 DJIc9prSeYF1tuXUmNFMmQ3P1ziYqSMgJODwx5N8aJehJy8/YVay+q6hIYxKa7A4AGkZ
 b2Vw==
X-Gm-Message-State: APjAAAWc79ttNmyGY58aB1HdGv+z4v91LRr+p/HMg7WNgaqC6XSostd4
 Fqf6+liMRq4K3CJokbPseGjXnQ==
X-Google-Smtp-Source: APXvYqwF8e5jIK0p0rSZVDWRKyZV/LcuULWfpv1lLvBp4kTaTHfK4BZm6ZFa/I1SthEb6xyhNmBKxA==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr11584783wrm.241.1578580585031; 
 Thu, 09 Jan 2020 06:36:25 -0800 (PST)
Received: from myrica (adsl-84-227-176-239.adslplus.ch. [84.227.176.239])
 by smtp.gmail.com with ESMTPSA id l6sm3122575wmf.21.2020.01.09.06.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 06:36:24 -0800 (PST)
Date: Thu, 9 Jan 2020 15:36:18 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: Re: [PATCH v4 00/13] iommu: Add PASID support to Arm SMMUv3
Message-ID: <20200109143618.GA942461@myrica>
References: <20191219163033.2608177-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191219163033.2608177-1-jean-philippe@linaro.org>
Cc: mark.rutland@arm.com, will@kernel.org, guohanjun@huawei.com,
 rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
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

Hi Will,

On Thu, Dec 19, 2019 at 05:30:20PM +0100, Jean-Philippe Brucker wrote:
> Add support for Substream ID and PASIDs to the SMMUv3 driver. Since v3
> [1], I added review and tested tags where appropriate and applied the
> suggested changes, shown in the diff below. Thanks all!
> 
> I'm testing using the zip accelerator on the Hisilicon KunPeng920 and
> Zhangfei's uacce module [2]. The full SVA support, which I'll send out
> early next year, is available on my branch sva/zip-devel at
> https://jpbrucker.net/git/linux/

Is there anything more I should do for the PASID support? Ideally I'd like
to get this in v5.6 so I can focus on the rest of the SVA work and on
performance improvements.

Thanks,
Jean

> 
> [1] https://lore.kernel.org/linux-iommu/20191209180514.272727-1-jean-philippe@linaro.org/
> [2] https://lore.kernel.org/linux-iommu/1576465697-27946-1-git-send-email-zhangfei.gao@linaro.org/
> 
> Jean-Philippe Brucker (13):
>   iommu/arm-smmu-v3: Drop __GFP_ZERO flag from DMA allocation
>   dt-bindings: document PASID property for IOMMU masters
>   iommu/arm-smmu-v3: Parse PASID devicetree property of platform devices
>   ACPI/IORT: Parse SSID property of named component node
>   iommu/arm-smmu-v3: Prepare arm_smmu_s1_cfg for SSID support
>   iommu/arm-smmu-v3: Add context descriptor tables allocators
>   iommu/arm-smmu-v3: Add support for Substream IDs
>   iommu/arm-smmu-v3: Propagate ssid_bits
>   iommu/arm-smmu-v3: Prepare for handling arm_smmu_write_ctx_desc()
>     failure
>   iommu/arm-smmu-v3: Add second level of context descriptor table
>   iommu/arm-smmu-v3: Improve add_device() error handling
>   PCI/ATS: Add PASID stubs
>   iommu/arm-smmu-v3: Add support for PCI PASID
> 
>  .../devicetree/bindings/iommu/iommu.txt       |   6 +
>  drivers/acpi/arm64/iort.c                     |  18 +
>  drivers/iommu/arm-smmu-v3.c                   | 467 +++++++++++++++---
>  drivers/iommu/of_iommu.c                      |   6 +-
>  include/linux/iommu.h                         |   2 +
>  include/linux/pci-ats.h                       |   3 +
>  6 files changed, 442 insertions(+), 60 deletions(-)
> 
> -- 
> Diff since v3:
> #diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index cde7af39681c..8e95ecad4c9a 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -589,8 +589,10 @@ struct arm_smmu_cd_table {
>  };
> 
>  struct arm_smmu_s1_cfg {
> +	/* Leaf tables or linear table */
>  	struct arm_smmu_cd_table	*tables;
>  	size_t				num_tables;
> +	/* First level tables, when two levels are used */
>  	__le64				*l1ptr;
>  	dma_addr_t			l1ptr_dma;
>  	struct arm_smmu_ctx_desc	cd;
> @@ -1561,27 +1563,22 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
> 
> -	if (cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR) {
> -		table = &cfg->tables[0];
> -		idx = ssid;
> -	} else {
> -		idx = ssid >> CTXDESC_SPLIT;
> -		if (idx >= cfg->num_tables)
> -			return NULL;
> +	if (cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
> +		return cfg->tables[0].ptr + ssid * CTXDESC_CD_DWORDS;
> 
> -		table = &cfg->tables[idx];
> -		if (!table->ptr) {
> -			if (arm_smmu_alloc_cd_leaf_table(smmu, table,
> -							 CTXDESC_L2_ENTRIES))
> -				return NULL;
> +	idx = ssid >> CTXDESC_SPLIT;
> +	table = &cfg->tables[idx];
> +	if (!table->ptr) {
> +		if (arm_smmu_alloc_cd_leaf_table(smmu, table,
> +						 CTXDESC_L2_ENTRIES))
> +			return NULL;
> 
> -			l1ptr = cfg->l1ptr + idx * CTXDESC_L1_DESC_DWORDS;
> -			arm_smmu_write_cd_l1_desc(l1ptr, table);
> -			/* An invalid L1CD can be cached */
> -			arm_smmu_sync_cd(smmu_domain, ssid, false);
> -		}
> -		idx = ssid & (CTXDESC_L2_ENTRIES - 1);
> +		l1ptr = cfg->l1ptr + idx * CTXDESC_L1_DESC_DWORDS;
> +		arm_smmu_write_cd_l1_desc(l1ptr, table);
> +		/* An invalid L1CD can be cached */
> +		arm_smmu_sync_cd(smmu_domain, ssid, false);
>  	}
> +	idx = ssid & (CTXDESC_L2_ENTRIES - 1);
>  	return table->ptr + idx * CTXDESC_CD_DWORDS;
>  }
> 
> @@ -1617,8 +1614,12 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
>  	u64 val;
>  	bool cd_live;
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> -	__le64 *cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
> +	__le64 *cdptr;
> 
> +	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
> +		return -E2BIG;
> +
> +	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
>  	if (!cdptr)
>  		return -ENOMEM;
> 
> @@ -1640,9 +1641,9 @@ static int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
>  		cdptr[3] = cpu_to_le64(cd->mair);
> 
>  		/*
> -		 * STE is live, and the SMMU might fetch this CD at any
> -		 * time. Ensure that it observes the rest of the CD before we
> -		 * enable it.
> +		 * STE is live, and the SMMU might read dwords of this CD in any
> +		 * order. Ensure that it observes valid values before reading
> +		 * V=1.
>  		 */
>  		arm_smmu_sync_cd(smmu_domain, ssid, true);
> 
> @@ -1706,7 +1707,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
>  	 * Only allocate a leaf table for linear case. With two levels, leaf
>  	 * tables are allocated lazily.
>  	 */
> -	if (!cfg->l1ptr) {
> +	if (cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR) {
>  		ret = arm_smmu_alloc_cd_leaf_table(smmu, &cfg->tables[0],
>  						   max_contexts);
>  		if (ret)
> @@ -2657,17 +2658,21 @@ static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
> 
>  	features = pci_pasid_features(pdev);
>  	if (features < 0)
> -		return -ENODEV;
> +		return features;
> 
>  	num_pasids = pci_max_pasids(pdev);
>  	if (num_pasids <= 0)
> -		return -ENODEV;
> +		return num_pasids;
> 
>  	ret = pci_enable_pasid(pdev, features);
> -	if (!ret)
> -		master->ssid_bits = min_t(u8, ilog2(num_pasids),
> -					  master->smmu->ssid_bits);
> -	return ret;
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to enable PASID\n");
> +		return ret;
> +	}
> +
> +	master->ssid_bits = min_t(u8, ilog2(num_pasids),
> +				  master->smmu->ssid_bits);
> +	return 0;
>  }
> 
>  static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
