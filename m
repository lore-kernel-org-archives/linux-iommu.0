Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A632020F08E
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389249; cv=none; b=REBE6AaPyszA02VHfzYpwGbCHfdQynqI8y3F/OTvg/rvNbdAmHdahuU9xmbf5mHZV0iKuUb5Ys4pMNglLe/uk0POBkxawWqwnhCKIic0KFIRVMfLtdbDS7jU2b58cJyHrZ9yzn67HG+29IUElhw/VR/pW7I9kVD9xnI1bbq13IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389249; c=relaxed/simple;
	bh=GK6q/dVVr56KWhz4xjVfQwVF4jkBpchAnFtJB9s53JE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3PqJPTRZ2eArSV8AhKLm5qrOlYBaEYNifNVt6ipbdbQAa9ZpVlzrUwYCU/rzz0EllAlMijcrPeOBvEMuht7EFfZn4NZBJ3E5Jxa5Snubmej6YHQqtEKoJjxdbEPwnqXjj3IbnB575u2l2/wuZcmVZLYNwnC512tcHzdbC4HZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E45C106F;
	Fri, 11 Apr 2025 09:34:06 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5745F3F694;
	Fri, 11 Apr 2025 09:34:06 -0700 (PDT)
Message-ID: <24e278c3-98a3-4799-9d54-22bdbc7a15be@arm.com>
Date: Fri, 11 Apr 2025 17:34:05 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Clear IOMMU DMA ops when detaching a device from
 its IOMMU group
To: Chen-Yu Tsai <wenst@chromium.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250410101001.429694-1-wenst@chromium.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250410101001.429694-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/2025 11:09 am, Chen-Yu Tsai wrote:
> In recent changes to the IOMMU subsystem seen in v6.15-rc1, the process
> and order of how IOMMU linked devices are brought up has changed. Now
> when the IOMMU is probed, the IOMMU subsystem core will attempt to link
> or attach devices described in the device tree as using the IOMMU to
> the IOMMU's associated group or domain. If any part of this fails, the
> whole process is (mostly) undone. The IOMMU failure is then treated as
> a deferred probe; after sufficient time, the deferred probe times out
> and the attached devices are brought out without the IOMMU.
> 
> In the process of undoing changes, one part was missed. When a device
> is initialized for use with the IOMMU, iommu_setup_dma_ops() is also
> called, which signals that DMA operations should go through the IOMMU.
> This part was not reverted when the IOMMU changes were undone. When
> the device later probes without the IOMMU, DMA operations would attempt
> to use IOMMU operations with no IOMMU domain present, causing a crash.
> 
> The above was observed on an MT8188 Chromebook. The MT8188 device tree
> had incorrectly described the IOMMU endpoint for part of its display
> pipeline; the IOMMU driver would successfully attach a couple hardware
> blocks, fail at the incorrectly described one, and roll back all
> changes. Later when the deferred probe times out, the display pipleine
> probes without the IOMMU, but when a framebuffer is allocated, it goes
> through the IOMMU DMA ops, causing a NULL pointer dereference crash.
> 
> Add a helper that is the opposite of iommu_setup_dma_ops(), and call it
> when the IOMMU-enabled device is being detached from its IOMMU.

Apologies for the crossover - seems you sent this just as I got to 
finishing up the response and patch I'd left open on my office machine 
the other day... and now I find that I forgot to actually send *this* 
mail when I wrote it yesterday either, sigh :(

As per my version I don't think this is really a fix as there was never 
a consistent well-defined behaviour to begin with. From an arm64 
perspective I think it would have last changed with b67483b3c44e 
("iommu/dma: Centralise iommu_setup_dma_ops()"), but that's not the case 
for other architectures/drivers which either already had this condition 
beforehand or still didn't afterwards.

Thanks,
Robin.

> Closes: https://lore.kernel.org/all/CAGXv+5HJpTYmQ2h-GD7GjyeYT7bL9EBCvu0mz5LgpzJZtzfW0w@mail.gmail.com/
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> This patch should be applied for v6.15. It's not immediately clear to
> me which commit is the actual cause, so I did not add a Fixes tag.
> ---
>   drivers/iommu/dma-iommu.c | 5 +++++
>   drivers/iommu/dma-iommu.h | 5 +++++
>   drivers/iommu/iommu.c     | 2 ++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index cb7e29dcac15..62a51d84ffe1 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1739,6 +1739,11 @@ void iommu_setup_dma_ops(struct device *dev)
>   	dev->dma_iommu = false;
>   }
>   
> +void iommu_clear_dma_ops(struct device *dev)
> +{
> +	dev->dma_iommu = false;
> +}
> +
>   static bool has_msi_cookie(const struct iommu_domain *domain)
>   {
>   	return domain && (domain->cookie_type == IOMMU_COOKIE_DMA_IOVA ||
> diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
> index eca201c1f963..dfd31cb9e685 100644
> --- a/drivers/iommu/dma-iommu.h
> +++ b/drivers/iommu/dma-iommu.h
> @@ -10,6 +10,7 @@
>   #ifdef CONFIG_IOMMU_DMA
>   
>   void iommu_setup_dma_ops(struct device *dev);
> +void iommu_clear_dma_ops(struct device *dev);
>   
>   int iommu_get_dma_cookie(struct iommu_domain *domain);
>   void iommu_put_dma_cookie(struct iommu_domain *domain);
> @@ -30,6 +31,10 @@ static inline void iommu_setup_dma_ops(struct device *dev)
>   {
>   }
>   
> +static inline void iommu_clear_dma_ops(struct device *dev)
> +{
> +}
> +
>   static inline int iommu_dma_init_fq(struct iommu_domain *domain)
>   {
>   	return -EINVAL;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index c8033ca66377..498f8f48394c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -677,6 +677,8 @@ static void __iommu_group_remove_device(struct device *dev)
>   	struct iommu_group *group = dev->iommu_group;
>   	struct group_device *device;
>   
> +	iommu_clear_dma_ops(dev);
> +
>   	mutex_lock(&group->mutex);
>   	for_each_group_device(group, device) {
>   		if (device->dev != dev)
