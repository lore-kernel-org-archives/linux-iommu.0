Return-Path: <SRS0=3Hz1=2H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F46CC43603
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 13:27:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E873B20717
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 13:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUJigyGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E873B20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AFF6586274;
	Tue, 17 Dec 2019 13:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XcHwyDKmgTJV; Tue, 17 Dec 2019 13:27:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 92C4086239;
	Tue, 17 Dec 2019 13:27:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74029C1D7D;
	Tue, 17 Dec 2019 13:27:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCE6FC077D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 13:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B225D8665D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 13:27:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o4NzbIgIHzcw for <iommu@lists.linux-foundation.org>;
 Tue, 17 Dec 2019 13:27:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C3AC6840A3
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576589233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pUq2a5pZ/dt2qGPzTnxHTjJcR3qch9Jn0NM29Gx0avs=;
 b=GUJigyGWcU335oSByS5Vqq52E8m1ie5RgYu1+SLT3bhurC6t9oKI+SZg6giEaDzAwuP2yX
 mP3zSihoeiDDCROxhnmcMzatLROia6mh+TdPnLWNjd3W5j+H8TofDwfS8nZ4+LLSONUf1p
 foD9hdRomb+1L7dl5L/4LNGocQ+zDcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-D7gd0hVnNieBrcFWJ_UiaQ-1; Tue, 17 Dec 2019 08:27:09 -0500
X-MC-Unique: D7gd0hVnNieBrcFWJ_UiaQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 265F68017DF;
 Tue, 17 Dec 2019 13:27:07 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24A2060C63;
 Tue, 17 Dec 2019 13:27:02 +0000 (UTC)
Subject: Re: [PATCH v3 05/13] iommu/arm-smmu-v3: Prepare arm_smmu_s1_cfg for
 SSID support
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-6-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7b20be5c-0b3f-dbec-ffd6-508b4667cf1b@redhat.com>
Date: Tue, 17 Dec 2019 14:27:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191209180514.272727-6-jean-philippe@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: mark.rutland@arm.com, robin.murphy@arm.com, guohanjun@huawei.com,
 rjw@rjwysocki.net, robh+dt@kernel.org, sudeep.holla@arm.com,
 bhelgaas@google.com, zhangfei.gao@linaro.org, will@kernel.org, lenb@kernel.org
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

Hi Jean,

On 12/9/19 7:05 PM, Jean-Philippe Brucker wrote:
> When adding SSID support to the SMMUv3 driver, we'll need to manipulate
> leaf pasid tables and context descriptors. Extract the context
> descriptor structure and introduce a new table structure.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  drivers/iommu/arm-smmu-v3.c | 44 +++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 837b4283b4dc..b287e303b1d7 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -553,16 +553,21 @@ struct arm_smmu_strtab_l1_desc {
>  	dma_addr_t			l2ptr_dma;
>  };
>  
> +struct arm_smmu_ctx_desc {
> +	u16				asid;
> +	u64				ttbr;
> +	u64				tcr;
> +	u64				mair;
> +};
> +
> +struct arm_smmu_cd_table {
> +	__le64				*ptr;
> +	dma_addr_t			ptr_dma;
> +};
> +
>  struct arm_smmu_s1_cfg {
> -	__le64				*cdptr;
> -	dma_addr_t			cdptr_dma;
> -
> -	struct arm_smmu_ctx_desc {
> -		u16	asid;
> -		u64	ttbr;
> -		u64	tcr;
> -		u64	mair;
> -	}				cd;
> +	struct arm_smmu_cd_table	table;
> +	struct arm_smmu_ctx_desc	cd;
>  };
>  
>  struct arm_smmu_s2_cfg {
> @@ -1471,6 +1476,7 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
>  				    struct arm_smmu_s1_cfg *cfg)
>  {
>  	u64 val;
> +	__le64 *cdptr = cfg->table.ptr;
>  
>  	/*
>  	 * We don't need to issue any invalidation here, as we'll invalidate
> @@ -1488,12 +1494,12 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
>  	if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
>  		val |= CTXDESC_CD_0_S;
>  
> -	cfg->cdptr[0] = cpu_to_le64(val);
> +	cdptr[0] = cpu_to_le64(val);
>  
>  	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK;
> -	cfg->cdptr[1] = cpu_to_le64(val);
> +	cdptr[1] = cpu_to_le64(val);
>  
> -	cfg->cdptr[3] = cpu_to_le64(cfg->cd.mair);
> +	cdptr[3] = cpu_to_le64(cfg->cd.mair);
>  }
>  
>  /* Stream table manipulation functions */
> @@ -1624,7 +1630,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
>  			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
>  
> -		val |= (s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> +		val |= (s1_cfg->table.ptr_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
>  			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS);
>  	}
>  
> @@ -2138,11 +2144,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>  		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
>  
> -		if (cfg->cdptr) {
> +		if (cfg->table.ptr) {
>  			dmam_free_coherent(smmu_domain->smmu->dev,
>  					   CTXDESC_CD_DWORDS << 3,
> -					   cfg->cdptr,
> -					   cfg->cdptr_dma);
> +					   cfg->table.ptr,
> +					   cfg->table.ptr_dma);
>  
>  			arm_smmu_bitmap_free(smmu->asid_map, cfg->cd.asid);
>  		}
> @@ -2167,9 +2173,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	if (asid < 0)
>  		return asid;
>  
> -	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
> -					 &cfg->cdptr_dma, GFP_KERNEL);
> -	if (!cfg->cdptr) {
> +	cfg->table.ptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
> +					     &cfg->table.ptr_dma, GFP_KERNEL);
> +	if (!cfg->table.ptr) {
>  		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
>  		ret = -ENOMEM;
>  		goto out_free_asid;
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
