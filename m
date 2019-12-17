Return-Path: <SRS0=3Hz1=2H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5D8C43603
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 10:59:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011C12064B
	for <iommu@archiver.kernel.org>; Tue, 17 Dec 2019 10:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2wwIVh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011C12064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C199F204F3;
	Tue, 17 Dec 2019 10:59:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D-JXEyy032dh; Tue, 17 Dec 2019 10:59:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9A89020481;
	Tue, 17 Dec 2019 10:59:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 949B3C1AE8;
	Tue, 17 Dec 2019 10:59:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4D2DC077D
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 10:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D3D53860D6
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 10:59:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QgDsoMR69mpK for <iommu@lists.linux-foundation.org>;
 Tue, 17 Dec 2019 10:59:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1858484FB6
 for <iommu@lists.linux-foundation.org>; Tue, 17 Dec 2019 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576580356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tAVUgYEbOKAmbmGHd4mLJpWS0BdtmbZWYoTyqnMHjpM=;
 b=R2wwIVh8dMkxUDGl6S7wuToR518kKDr9mikIoQNInFYk5/jA7acLvGsCf1uy48paSln6mL
 /QRAoYlKc/gLu5O8OjYchM00QZl3PglNXg8bkLo++qHI2/UiOZW8hDILK/+9aDdUjHfeV6
 VZR2uEhdse/v1Kl9poox8UT+rPw0Oc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-toc7B--iMgaH3SihD5o5Wg-1; Tue, 17 Dec 2019 05:59:12 -0500
X-MC-Unique: toc7B--iMgaH3SihD5o5Wg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D132618FF662;
 Tue, 17 Dec 2019 10:59:08 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1D465D9C9;
 Tue, 17 Dec 2019 10:59:04 +0000 (UTC)
Subject: Re: [PATCH v3 01/13] iommu/arm-smmu-v3: Drop __GFP_ZERO flag from DMA
 allocation
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20191209180514.272727-1-jean-philippe@linaro.org>
 <20191209180514.272727-2-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2917e0a3-e351-69fe-5e67-adeda9d40617@redhat.com>
Date: Tue, 17 Dec 2019 11:59:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191209180514.272727-2-jean-philippe@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
> Since commit 518a2f1925c3 ("dma-mapping: zero memory returned from
> dma_alloc_*"), dma_alloc_* always initializes memory to zero, so there
> is no need to use dma_zalloc_* or pass the __GFP_ZERO flag anymore.
> 
> The flag was introduced by commit 04fa26c71be5 ("iommu/arm-smmu: Convert
> DMA buffer allocations to the managed API"), since the managed API
> didn't provide a dmam_zalloc_coherent() function.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

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
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
