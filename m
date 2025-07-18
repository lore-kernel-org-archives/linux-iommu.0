Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624CC2DBF5B
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843404; cv=none; b=k9OtGVlx4WKyZIfTr2VueAe2AH2Y1oBrW5kZ7wtSwz6meOU2Xx/mr5DlMEUzos+28Ep2Wuj9K/LXWyp138f/QTScLDM2eAtCHCZ/cfagx6iaijl/OPRgxAy2DhFNwt/4J24LxrSylnnx8xoADf7cCLE6mEIh8jM9XmLNQE64hAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843404; c=relaxed/simple;
	bh=tJiqVXRt0a+gvJ9l3cFrPtNY47CPPeIvbURs6OLnEjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIJe2/iy2z3b2o3BsoTf3FSFYHeCKlSD5j4OL5Pv8/c6iBnZQUrjcDAsit82Sna38jmnrugIMnlUiErjxNrUUc2WqAyEGRMrLJUJNafU7kbNJ1B8fgaJn91SM7DCp2fJgBqGaRMCqhnHGUl1Ob14P3wwYjyGc79iIVqlyDNksmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5049B15A1;
	Fri, 18 Jul 2025 05:56:34 -0700 (PDT)
Received: from [10.57.1.4] (unknown [10.57.1.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B98733F6A8;
	Fri, 18 Jul 2025 05:56:38 -0700 (PDT)
Message-ID: <b4169471-fcd0-4415-8281-c5bd722e5f2b@arm.com>
Date: Fri, 18 Jul 2025 13:56:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] iommu: Add verisilicon IOMMU driver
To: Will Deacon <will@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, nicolas.dufresne@collabora.com,
 jgg@ziepe.ca, iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20250710082450.125585-1-benjamin.gaignard@collabora.com>
 <20250710082450.125585-4-benjamin.gaignard@collabora.com>
 <aHTzPwTob8_5rtBS@willie-the-truck>
 <baa1fcde-f167-4a1b-afca-0a2957a688cc@collabora.com>
 <aHozv0NG1OBlAH6c@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aHozv0NG1OBlAH6c@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-07-18 12:45 pm, Will Deacon wrote:
> On Mon, Jul 14, 2025 at 04:56:53PM +0200, Benjamin Gaignard wrote:
>> Le 14/07/2025 à 14:08, Will Deacon a écrit :
>>> On Thu, Jul 10, 2025 at 10:24:44AM +0200, Benjamin Gaignard wrote:
>>>> +/* vsi iommu regs address */
>>>> +#define VSI_MMU_CONFIG1_BASE			0x1ac
>>>> +#define VSI_MMU_AHB_EXCEPTION_BASE		0x380
>>>> +#define VSI_MMU_AHB_CONTROL_BASE		0x388
>>>> +#define VSI_MMU_AHB_TLB_ARRAY_BASE_L_BASE	0x38C
>>>> +
>>>> +/* MMU register offsets */
>>>> +#define VSI_MMU_FLUSH_BASE		0x184
>>>> +#define VSI_MMU_BIT_FLUSH		BIT(4)
>>>> +
>>>> +#define VSI_MMU_PAGE_FAULT_ADDR		0x380
>>>> +#define VSI_MMU_STATUS_BASE		0x384	/* IRQ status */
>>>> +
>>>> +#define VSI_MMU_BIT_ENABLE		BIT(0)
>>>> +
>>>> +#define VSI_MMU_OUT_OF_BOUND		BIT(28)
>>>> +/* Irq mask */
>>>> +#define VSI_MMU_IRQ_MASK		0x7
>>>> +
>>>> +#define VSI_DTE_PT_ADDRESS_MASK		0xffffffc0
>>>> +#define VSI_DTE_PT_VALID		BIT(0)
>>>> +
>>>> +#define VSI_PAGE_DESC_LO_MASK		0xfffff000
>>>> +#define VSI_PAGE_DESC_HI_MASK		GENMASK_ULL(39, 32)
>>>> +#define VSI_PAGE_DESC_HI_SHIFT		(32 - 4)
>>> How does this page-table format relate to the one supported already by
>>> rockchip-iommu.c? From a quick glance, I suspect this is a derivative
>>> and so ideally we'd be able to have a common implementation of the
>>> page-table code which can be used by both of the drivers.
>>>
>>> Similarly:
>>
>> No they comes from different IP providers, this one is from Verisilicon.
>> I agree they looks very similar and my first attempt was to add it into
>> rockchip-iommu code but when doing it I realize that registers addresses
>> where all different so I had to code all the functions twice.
> 
> Understood, and I'm not suggesting to merge the drivers or try to
> consolidate the register layouts. What I _am_ saying is that the
> in-memory page-table format should be factored out in a way that can
> be reused by the two drivers and also that some of the logic (as highlighted
> by vsi_iommu_domain_free()) is practically identical between the drivers
> and should also be shared.

All they really have in common is that they're 2-level formats with 
32-bit PTEs and 10 bits per level (as is tegra-smmu too). The permission 
encodings have some overlap but are not fully equivalent. Crucially, the 
schemes for packing >32-bit PAs into PTEs are incompatibly different, so 
if you're really keen to genericise things to *that* extent, that's what 
Jason's already working on.

As for domain_free, you could argue that it also looks basically the 
same as exynos_iommu_domain_free(), because at the end of the day, 
there's only so many ways to free a 2-level pagetable, and it's at least 
better than what, say, sun50i, omap or tegra are doing (or rather, not 
doing...)

Cheers,
Robin.
