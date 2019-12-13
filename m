Return-Path: <SRS0=hFKH=2D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902F1C43603
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 21:31:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E3424125
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 21:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E3424125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EE88720408;
	Fri, 13 Dec 2019 16:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FPTPqM5KM-lC; Fri, 13 Dec 2019 16:45:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DEA75203BD;
	Fri, 13 Dec 2019 16:45:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0901C1D7F;
	Fri, 13 Dec 2019 16:45:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 450F6C0881
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 16:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 337B8862C1
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 16:45:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tPz_AtOL8N3v for <iommu@lists.linux-foundation.org>;
 Fri, 13 Dec 2019 16:45:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0B767862AB
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 16:45:14 +0000 (UTC)
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id D295B1175F5A999CD297;
 Fri, 13 Dec 2019 16:45:10 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 13 Dec 2019 16:45:10 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 13 Dec
 2019 16:45:10 +0000
Date: Fri, 13 Dec 2019 16:45:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v3 01/13] iommu/arm-smmu-v3: Drop __GFP_ZERO flag from
 DMA allocation
Message-ID: <20191213164508.00001f99@Huawei.com>
In-Reply-To: <20191209180514.272727-2-jean-philippe@linaro.org>
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-2-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
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

On Mon, 9 Dec 2019 19:05:02 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Since commit 518a2f1925c3 ("dma-mapping: zero memory returned from
> dma_alloc_*"), dma_alloc_* always initializes memory to zero, so there
> is no need to use dma_zalloc_* or pass the __GFP_ZERO flag anymore.
> 
> The flag was introduced by commit 04fa26c71be5 ("iommu/arm-smmu: Convert
> DMA buffer allocations to the managed API"), since the managed API
> didn't provide a dmam_zalloc_coherent() function.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Good to tidy these up whilst we are here.

Jonathan

> ---
>  drivers/iommu/arm-smmu-v3.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index effe72eb89e7..d4e8b7f8d9f4 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1675,7 +1675,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
>  
>  	desc->span = STRTAB_SPLIT + 1;
>  	desc->l2ptr = dmam_alloc_coherent(smmu->dev, size, &desc->l2ptr_dma,
> -					  GFP_KERNEL | __GFP_ZERO);
> +					  GFP_KERNEL);
>  	if (!desc->l2ptr) {
>  		dev_err(smmu->dev,
>  			"failed to allocate l2 stream table for SID %u\n",
> @@ -2161,8 +2161,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  		return asid;
>  
>  	cfg->cdptr = dmam_alloc_coherent(smmu->dev, CTXDESC_CD_DWORDS << 3,
> -					 &cfg->cdptr_dma,
> -					 GFP_KERNEL | __GFP_ZERO);
> +					 &cfg->cdptr_dma, GFP_KERNEL);
>  	if (!cfg->cdptr) {
>  		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
>  		ret = -ENOMEM;
> @@ -2883,7 +2882,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
>  
>  	l1size = cfg->num_l1_ents * (STRTAB_L1_DESC_DWORDS << 3);
>  	strtab = dmam_alloc_coherent(smmu->dev, l1size, &cfg->strtab_dma,
> -				     GFP_KERNEL | __GFP_ZERO);
> +				     GFP_KERNEL);
>  	if (!strtab) {
>  		dev_err(smmu->dev,
>  			"failed to allocate l1 stream table (%u bytes)\n",
> @@ -2910,7 +2909,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
>  
>  	size = (1 << smmu->sid_bits) * (STRTAB_STE_DWORDS << 3);
>  	strtab = dmam_alloc_coherent(smmu->dev, size, &cfg->strtab_dma,
> -				     GFP_KERNEL | __GFP_ZERO);
> +				     GFP_KERNEL);
>  	if (!strtab) {
>  		dev_err(smmu->dev,
>  			"failed to allocate linear stream table (%u bytes)\n",


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
