Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747E4C47254
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 14:37:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4413A2078C
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 14:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4413A2078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F4054230FD;
	Mon,  4 May 2020 14:37:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zVO7WwuEkJQ9; Mon,  4 May 2020 14:37:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 99195203E6;
	Mon,  4 May 2020 14:37:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C810C088C;
	Mon,  4 May 2020 14:37:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB179C0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 14:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CA3F9871FC
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 14:37:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TACCtkpakUIq for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 14:37:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 45E7187073
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 14:37:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D6461FB;
 Mon,  4 May 2020 07:37:17 -0700 (PDT)
Received: from [10.37.12.17] (unknown [10.37.12.17])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 543783F305;
 Mon,  4 May 2020 07:37:04 -0700 (PDT)
Subject: Re: [PATCH v6 11/25] iommu/arm-smmu-v3: Share process page tables
To: jean-philippe@linaro.org
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-12-jean-philippe@linaro.org>
 <580a915f-f8bf-3b3e-c77d-6d0c2ea4bd02@arm.com>
 <20200504141137.GA170104@myrica>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <82f54362-34f1-2378-49c2-2d87e065e385@arm.com>
Date: Mon, 4 May 2020 15:42:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200504141137.GA170104@myrica>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, jgg@ziepe.ca,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, fenghua.yu@intel.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, catalin.marinas@arm.com, felix.kuehling@amd.com,
 will@kernel.org, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 05/04/2020 03:11 PM, Jean-Philippe Brucker wrote:
> On Thu, Apr 30, 2020 at 04:39:53PM +0100, Suzuki K Poulose wrote:
>> On 04/30/2020 03:34 PM, Jean-Philippe Brucker wrote:
>>> With Shared Virtual Addressing (SVA), we need to mirror CPU TTBR, TCR,
>>> MAIR and ASIDs in SMMU contexts. Each SMMU has a single ASID space split
>>> into two sets, shared and private. Shared ASIDs correspond to those
>>> obtained from the arch ASID allocator, and private ASIDs are used for
>>> "classic" map/unmap DMA.
>>>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> ---
>>
>>> +
>>> +	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - VA_BITS) |
>>> +	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
>>> +	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
>>> +	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
>>> +	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
>>> +
>>> +	switch (PAGE_SIZE) {
>>> +	case SZ_4K:
>>> +		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_4K);
>>> +		break;
>>> +	case SZ_16K:
>>> +		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_16K);
>>> +		break;
>>> +	case SZ_64K:
>>> +		tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_TG0, ARM_LPAE_TCR_TG0_64K);
>>> +		break;
>>> +	default:
>>> +		WARN_ON(1);
>>> +		ret = -EINVAL;
>>> +		goto err_free_asid;
>>> +	}
>>> +
>>> +	reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
>>> +	par = cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR0_PARANGE_SHIFT);
>>> +	tcr |= FIELD_PREP(CTXDESC_CD_0_TCR_IPS, par);
>>> +
>>> +	cd->ttbr = virt_to_phys(mm->pgd);
>>
>> Does the TTBR follow the same layout as TTBR_ELx for 52bit IPA ? i.e,
>> TTBR[5:2] = BADDR[51:48] ? Are you covered for that ?
> 
> Good point, I don't remember checking this. The SMMU TTBR doesn't have the
> same layout as the CPU's, and we don't need to swizzle the bits. For the
> lower bits, the alignment requirements on the pgd are identical to the
> MMU.

Ok, if that is the case:

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
