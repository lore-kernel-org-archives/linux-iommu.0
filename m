Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69570431A33
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419574; cv=none; b=CA6YXjvYJDkQ8C3Z2saduElWDmojjN0tnBDcJi1eNIakECeXb9dimRxK6GUIIDOm9aNPrOpFqDwfwZ94kLEVdFuYBK5BHI4DXO/Ctl2N/uSXSpCvRMdZblcpUZPVNibj2SY2LG3FPegAfHzAZ98uY88rcOC+EL9nSkVUiPn12Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419574; c=relaxed/simple;
	bh=C7uR6B9fb8HvPHrGmaqfKVsAu+EWaz9P8uwgznXhPjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVqdrA9hbw6Otn6+DzqRxJP/vXh9gAmHepc1BsGevD7WT2x8/IIPi027MC45iseEivfkdJZEb2HXq6F14IsXk9up0QJcbbfMz0l1NvhUt7ttp+z2Zo7qbirNqdBhKZNWVRl+R2ic2pKDipbzVRgClQsICdnakogEwn/YtsX2CuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oolJmGlX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oolJmGlX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 777FA1684;
	Thu, 30 Jul 2026 06:52:47 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 466C73F7B4;
	Thu, 30 Jul 2026 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785419571; bh=C7uR6B9fb8HvPHrGmaqfKVsAu+EWaz9P8uwgznXhPjM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oolJmGlXf6wnKYKfrIVkRJIrYIUZvJM/sJdau4Bw+7wl7h1O8zsEzAmDd6gOfV2Ld
	 fuHtpQ82fu+5cmQVFkJAJygyjtCjoyZuitbX7djU6J0fCn7ij98TqG1i6sTUPAOUj3
	 lLQaMcTupx4vB2iMZNsZwnF3eEZNmSuN4TuaetV4=
Message-ID: <77cf82e3-785a-4697-afda-e2f3530f162f@arm.com>
Date: Thu, 30 Jul 2026 14:52:34 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/dma: Restore locking around msi_page_list
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, will@kernel.org, nicolinc@nvidia.com, jgg@ziepe.ca
References: <20260730132323.1428473-1-andrew.jones@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260730132323.1428473-1-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/07/2026 2:23 pm, Andrew Jones wrote:
> Unlike a group's default domain, which is always freshly allocated
> and privately owned (iommu_group_alloc_default_domain()), VFIO type1's
> legacy container merges any newly attached group into an existing
> domain whenever their iommu_ops and cache-coherency enforcement match.
> 
> iommu_dma_get_msi_page() only asserts the caller's own group mutex is
> held (iommu_group_mutex_assert()). On an IOMMU that publishes
> IOMMU_RESV_SW_MSI, e.g. ARM SMMU, a VM with two such devices assigned
> through the legacy container can have their guest drivers probe and
> allocate MSIs in parallel; each host-side VFIO_DEVICE_SET_IRQS lands
> on a different device fd and group mutex, but both devices' domains
> are the same merged domain, so both can enter
> iommu_dma_get_msi_page() concurrently and corrupt msi_page_list.
> 
> commit 288683c92b1a ("iommu: Make iommu_dma_prepare_msi() into a
> generic operation") dropped the prior msi_prepare_lock on the
> reasoning that "each iommu_domain is unique to a group," which holds
> for default domains but not this VFIO type1 case. Restore the static
> lock, since it's only guarding a corner case and will likely never
> be contended.
> 
> iommufd avoids the equivalent problem by having its own callers
> (iommufd_sw_map_msi()) take a ctx-wide sw_msi_lock before ever
> reaching the shared list. VFIO type1 can't mirror that since it
> dispatches to iommu_dma_sw_msi() which is outside VFIO's jurisdiction.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

It occurs to me that it's also not impossible to explicitly attach a 
group to another group's DMA domain either, so in theory I think the 
concern could technically apply in both cases anyway. Plus it's not like 
anyone ever claimed any issue when the locking was in this path before, 
so I reckon it's the right thing to do for peace of mind.

Thanks,
Robin.

> Fixes: 288683c92b1a ("iommu: Make iommu_dma_prepare_msi() into a generic operation")
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> ---
> Sashiko reported this issue while reviewing a riscv iommu series[1].
> I've only compile-tested this fix.
> 
> [1] https://sashiko.dev/#/patchset/20260724151218.965929-1-andrew.jones@oss.qualcomm.com
> 
> v2:
>   - switched back to statick lock as 288683c92b1a had [Robin]
> 
> 
>   drivers/iommu/dma-iommu.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec0703ef..9a07eb39336e 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -2204,6 +2204,19 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>   	dma_addr_t iova;
>   	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>   	size_t size = cookie_msi_granule(domain);
> +	static DEFINE_MUTEX(msi_prepare_lock);
> +
> +	/*
> +	 * Normally a device's default domain is only ever attached to that
> +	 * device's own group, and the group mutex held by
> +	 * iommu_group_mutex_assert()'s callers is enough on its own. A VFIO
> +	 * type1 container is the one case that breaks that assumption: it
> +	 * can merge devices from different groups onto one domain, so two
> +	 * devices' group mutexes don't serialize each other here. A static
> +	 * lock is sufficient due to the expectation that this is a corner
> +	 * case that will never be contended in practice.
> +	 */
> +	guard(mutex)(&msi_prepare_lock);
>   
>   	msi_addr &= ~(phys_addr_t)(size - 1);
>   	list_for_each_entry(msi_page, msi_page_list, list)

