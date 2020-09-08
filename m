Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F20C433E2
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 09:38:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3460C2166E
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 09:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WT0Exo1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3460C2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CEF0F86422;
	Tue,  8 Sep 2020 09:38:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YtNvWLOmAh9d; Tue,  8 Sep 2020 09:38:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5CD2C8641E;
	Tue,  8 Sep 2020 09:38:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E144C0859;
	Tue,  8 Sep 2020 09:38:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 592F2C0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 09:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 551558726C
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 09:38:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GWQoueXyLc5d for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 09:38:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 65C9387267
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 09:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599557926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DRV7ejS/Drc1QuFjzIpYewwGbkwU2nl6svzlLL2gbbE=;
 b=WT0Exo1B4Qy25vKpXm2REXhHcuONJ5pyBjzGD0XDCXPErLreoRjrgOHzWO+VEGdrvfidkj
 3l28rlorexGNn3a9LUsInbYz+g5+ONzPQH7VeCX3ot69QvvY1UQTkDAF97g9Q1i012NgyK
 7ilXzj5xTSPYQf82OqOrGhOUhnvoA30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-bUsNn4A8MCyzMXsNrXvPoQ-1; Tue, 08 Sep 2020 05:38:42 -0400
X-MC-Unique: bUsNn4A8MCyzMXsNrXvPoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AF9DE917;
 Tue,  8 Sep 2020 09:38:40 +0000 (UTC)
Received: from [10.36.114.107] (ovpn-114-107.ams2.redhat.com [10.36.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 876E560C15;
 Tue,  8 Sep 2020 09:38:35 +0000 (UTC)
Subject: Re: [PATCH RESEND v9 10/13] iommu/arm-smmu-v3: Check for SVA features
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
References: <20200817171558.325917-1-jean-philippe@linaro.org>
 <20200817171558.325917-11-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d8cef101-fae8-eead-a898-1fca5fe4faaf@redhat.com>
Date: Tue, 8 Sep 2020 11:38:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200817171558.325917-11-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: fenghua.yu@intel.com, will@kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, catalin.marinas@arm.com,
 zhengxiang9@huawei.com, zhangfei.gao@linaro.org, robin.murphy@arm.com
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
On 8/17/20 7:15 PM, Jean-Philippe Brucker wrote:
> Aggregate all sanity-checks for sharing CPU page tables with the SMMU
> under a single ARM_SMMU_FEAT_SVA bit. For PCIe SVA, users also need to
> check FEAT_ATS and FEAT_PRI. For platform SVA, they will have to check
> FEAT_STALLS.
> 
> Introduce ARM_SMMU_FEAT_BTM (Broadcast TLB Maintenance), but don't
> enable it at the moment. Since the entire VMID space is shared with the
> CPU, enabling DVM (by clearing SMMU_CR2.PTM) could result in
> over-invalidation and affect performance of stage-2 mappings.
In which series do you plan to enable it?
> 
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 10 +++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 43 +++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 ++
>  3 files changed, 56 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 90c08f156b43..7b14b48a26c7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -602,6 +602,8 @@ struct arm_smmu_device {
>  #define ARM_SMMU_FEAT_STALL_FORCE	(1 << 13)
>  #define ARM_SMMU_FEAT_VAX		(1 << 14)
>  #define ARM_SMMU_FEAT_RANGE_INV		(1 << 15)
> +#define ARM_SMMU_FEAT_BTM		(1 << 16)
> +#define ARM_SMMU_FEAT_SVA		(1 << 17)
>  	u32				features;
>  
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> @@ -683,4 +685,12 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
>  void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
>  bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
>  
> +#ifdef CONFIG_ARM_SMMU_V3_SVA
> +bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
> +#else /* CONFIG_ARM_SMMU_V3_SVA */
> +static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_ARM_SMMU_V3_SVA */
>  #endif /* _ARM_SMMU_V3_H */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index e919ce894dd1..bf81d91ce71e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -153,3 +153,46 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
>  		kfree(cd);
>  	}
>  }
> +
> +bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
> +{
> +	unsigned long reg, fld;
> +	unsigned long oas;
> +	unsigned long asid_bits;
> +
> +	u32 feat_mask = ARM_SMMU_FEAT_BTM | ARM_SMMU_FEAT_COHERENCY;
> +
> +	if ((smmu->features & feat_mask) != feat_mask)
> +		return false;
> +
> +	if (!(smmu->pgsize_bitmap & PAGE_SIZE))
> +		return false;
If we were to check VA_BITS versus SMMU capabilities I guess this would
be here?
> +
> +	/*
> +	 * Get the smallest PA size of all CPUs (sanitized by cpufeature). We're
> +	 * not even pretending to support AArch32 here. Abort if the MMU outputs
> +	 * addresses larger than what we support.
> +	 */
> +	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
> +	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
> +	oas = id_aa64mmfr0_parange_to_phys_shift(fld);
> +	if (smmu->oas < oas)
> +		return false;
> +
> +	/* We can support bigger ASIDs than the CPU, but not smaller */
> +	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_ASID_SHIFT);
> +	asid_bits = fld ? 16 : 8;
> +	if (smmu->asid_bits < asid_bits)
> +		return false;
> +
> +	/*
> +	 * See max_pinned_asids in arch/arm64/mm/context.c. The following is
> +	 * generally the maximum number of bindable processes.
> +	 */
> +	if (IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
Out of curiosity, What is the rationale behind using
arm64_kernel_unmapped_at_el0() versus
IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0)?
CPU caps being finalized? Is that why you say "generally" here?
> +		asid_bits--;
> +	dev_dbg(smmu->dev, "%d shared contexts\n", (1 << asid_bits) -> +		num_possible_cpus() - 2);
nit: s/shared/bindable?
> +
> +	return true;
> +}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9e755caea525..15cb3d9c1a5d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3258,6 +3258,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  
>  	smmu->ias = max(smmu->ias, smmu->oas);
>  
> +	if (arm_smmu_sva_supported(smmu))
> +		smmu->features |= ARM_SMMU_FEAT_SVA;
> +
>  	dev_info(smmu->dev, "ias %lu-bit, oas %lu-bit (features 0x%08x)\n",
>  		 smmu->ias, smmu->oas, smmu->features);
>  	return 0;
> 
Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
