Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0C737F8C0
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055617; cv=none; b=ICMIJQC/btKsaAA2Ig7c0vnHAvHwyz33auA7BS6LoZIMPL7NhfVLeFSEP2QxuvNsp9otEo7eRpeQxTktFPApwSMSJYnsjs7n2VDPB1pGfRiiRqHCbwWuK0KApYWzVxiGMfNP3IOpro8IqiIWkD5/7eg3qeAmx4Q2K5Lh2fCq5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055617; c=relaxed/simple;
	bh=YhOPOssQqMK8uIlEV7/uK0cLb/KwvQZPKEhAnKAI8u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Et7fKXnmawAfrm3NuL7CDRFfkgRA6ocqFp1Kd+7gponQwDaQnnjhdQeiGyPurU375169gOhbpEahoIoahDR068a79numxykWkqDxoyXqS8nZE9MuD3X/cPAnf9Ba27NIOYQQPfojLjjN3rEJlNfP0MYSS8K3R6KRBKifF1pS0GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W3t66Bn2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W3t66Bn2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A6DF22C8;
	Thu, 10 Sep 2026 08:53:31 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF7953F59E;
	Thu, 10 Sep 2026 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789055614; bh=YhOPOssQqMK8uIlEV7/uK0cLb/KwvQZPKEhAnKAI8u0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W3t66Bn2Ug402lvI8p0AvhSV08VDSfpzkZp6Dp1iGvuua4ZJpuDt1ugoq5ZRspvZs
	 IMZLrAogbnzhNhfmi2PISu395I1Oerei1bDsrtOiPpEJ0Wx9JtCa4MOC0+BPETxfxK
	 SFbs7KV0ubv3DhI2LO06hUZe4kW3tUrak3TcXfl4=
Message-ID: <31072ec3-d80e-4ce6-81fb-e0266fec6ebb@arm.com>
Date: Thu, 10 Sep 2026 16:53:32 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu: Finalize deferred attachments when mapping MSI
 pages
To: Federico Parola <fparola@amazon.de>, "Joerg Roedel (AMD)"
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: nh-open-source@amazon.com
References: <20260910150517.95239-1-fparola@amazon.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260910150517.95239-1-fparola@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2026 4:04 pm, Federico Parola wrote:
> When a device's attachment to its default domain is deferred, the IOMMU
> is still translating the device with the tables inherited from the
> previous kernel. Any mapping installed in that domain does not take
> effect until the deferred attachment is finalized.
> 
> iommu_deferred_attach() covers the DMA mapping paths, but nothing covers
> iommu_dma_prepare_msi(): programming an MSI installs the MSI page in
> group->domain and hands the resulting IOVA to the irqchip, so an MSI
> programmed before the first DMA map is written using an IOVA that the
> hardware does not yet translate.
> 
> This issue is currently not triggerable as the two IOMMU implementations
> supporting deferred attachments, Intel and AMD, do not rely on DMA
> translations for MSI transactions. However, the Arm implementation being
> introduced in [1] will be subject to it.
> 
> Finalize the deferred attachment from iommu_dma_prepare_msi() too,
> before the MSI page is mapped. Do it outside group->mutex, as
> iommu_deferred_attach() takes the mutex itself and the two operations do
> not need to be atomic with respect to each other: if an attach replaces
> group->domain in between, the MSI page is mapped into whatever
> group->domain holds once the mutex is taken.
> 
> iommu_get_domain_for_dev() cannot return NULL here: MSI setup only runs
> for a device whose driver is bound, and of_iommu_configure() and
> acpi_iommu_configure_id() hold the bind off until the IOMMU is
> registered, hence until iommu_device_register() has set up the group's
> default domain. group->domain then stays non-NULL until
> iommu_deinit_device() clears it once the group is empty.
> dma_iova_try_alloc() already relies on the same guarantee.
> 
> The static key gating the iommu_deferred_attach() calls in dma-iommu.c
> is private to that file, and replicating it here is not worthwhile since
> MSI page mapping is not a fast path.
> 
> The behaviour of a rejected attach changes slightly: an attach refused
> because the device is being reset (-EBUSY) now fails MSI setup rather
> than only the first DMA map.

I know there are drivers which explicitly test MSI delivery when 
starting up, and it's reasonable that they might do so before any 
explicit DMA API operation, so this seems fair to me.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Link: https://lore.kernel.org/linux-iommu/cover.1788130528.git.nicolinc@nvidia.com/ [1]
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Federico Parola <fparola@amazon.de>
> ---
> Changes in v2:
> - Moved up iommu_deferred_attach() from iommu_dma_sw_msi() to
>    iommu_dma_prepare_msi() and removed unlocked variant of the function.
> - Link to v1: https://lore.kernel.org/linux-iommu/20260910115152.54108-1-fparola@amazon.de
> ---
>   drivers/iommu/iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cd1bca7ede9a..b486b8bbd1fc 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -4243,6 +4243,10 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>   	if (!group)
>   		return 0;
>   
> +	ret = iommu_deferred_attach(dev, iommu_get_domain_for_dev(dev));
> +	if (ret)
> +		return ret;
> +
>   	mutex_lock(&group->mutex);
>   	/* An IDENTITY domain must pass through */
>   	if (group->domain && group->domain->type != IOMMU_DOMAIN_IDENTITY) {

