Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9503433CB
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737996826; cv=none; b=RQX9JpLp80rKOaGJ46gKRwXfKHTnNlmken+GMpPIgKceqT+FkAXRz5Zq0oP2qiQWStyoM6qzI38sH6a7g+Q1+wkowuqwqG3CPmrEfVq4wgEMkAucOBlyicCaucyeQQw8ULjTR4ONxp4pFebDAqY8efLd8aw/PzTGOgjATweD7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737996826; c=relaxed/simple;
	bh=59LAdO589fHFbObQH5bNlKOAm/AwZsa5UEmq/TKBdGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PoH8w5XyR35tkvYvmq8qQcmcBBIZXFO7/rboWjUU9zKlpP2axWLF8hz8s0tkANYBl4lv/Bl9IzweZyiWL9/YqYiMYoOeUQJGN0heiaKF+y3O1mvVQHNKifjrhkvZMKE6EZNMXDvhCqmzbs5ruuyAOxH62t0bsvUXWf2CaYMy/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8772E497;
	Mon, 27 Jan 2025 08:54:09 -0800 (PST)
Received: from [10.57.36.159] (unknown [10.57.36.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B40D3F528;
	Mon, 27 Jan 2025 08:53:41 -0800 (PST)
Message-ID: <14f36a55-7814-4fe6-a82f-9e369960c4ce@arm.com>
Date: Mon, 27 Jan 2025 16:53:39 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Make intel iommu disable swiotlb
To: "Adrian Mardare (amardare)" <amardare@cisco.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <SA1PR11MB6687F4E752138AAED3FC980DCDED2@SA1PR11MB6687.namprd11.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <SA1PR11MB6687F4E752138AAED3FC980DCDED2@SA1PR11MB6687.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-01-26 5:09 am, Adrian Mardare (amardare) wrote:
> (resending as plain-text)
> Hi...
> I'd like to submit the below patch.
> While investigating a difference in memory consumption between the kernel in 5.4.x and in 6.6.x,
> I noticed there is around ~80M less reported in MemTotal in 6.6.x versus 5.4.x.
> This is because  in 6.6.x  the swiotlb is still enabled and consuming about 80M of kernel memory, even though
> the intel iommu has been fully initialized.
> This change will cause the swiotlb to be disabled /  memory to be released ( via swiotlb_exit ).
> Thanks,
> Adrian
> 
> 
>  From 27e63e727f23189e9c98d81fb445141f998c0808 Mon Sep 17 00:00:00 2001
> From: Adrian Mardare <amardare@cisco.com>
> Date: Sat, 25 Jan 2025 23:41:31 -0500
> Subject: [PATCH] Make intel iommu disable swiotlb
> 
> On boards where intel iommu has been successfully
> initialized, we need to disable the swiotlb as there
> is no reason for swiotlb to be active past that.

Except there are *two* reasons: 32-bit devices in identity domains, and 
untrusted (e.g. Thunderbolt) devices...

See commits c5a5dc4cbbf4 ("iommu/vt-d: Don't switch off swiotlb if 
bounce page is used") and subsequently 327d5b2fee91 ("iommu/vt-d: Allow 
32bit devices to uses DMA domain")

Thanks,
Robin.

> Signed-off-by: Adrian Mardare <amardare@cisco.com>
> ---
> drivers/iommu/intel/iommu.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cc46098f875b..971023d33a70 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3166,6 +3166,9 @@ int __init intel_iommu_init(void)
>                 pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
> 
>                  intel_iommu_enabled = 1;
> +#ifdef CONFIG_SWIOTLB
> +             x86_swiotlb_enable = false;
> +#endif
> 
>                  return 0;
> 

