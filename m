Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F101DE2C8
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323231; cv=none; b=affrnvkln+mU6ujQQR5htPNJBPPBl/fO4+8aZ0QoFMRw9BX3AWkO37OxX+P7tal8m7CQZysldUyIPMw3pYrLi8Hg7U6389+5L/8PQqacDfweE2tb9l7JMPbpGwUcR6SjqvJv6J3C+kLSwcwIBGh4boFZ4MnFh/zCf0dNzlMb4k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323231; c=relaxed/simple;
	bh=aAI2fvLhCalVZAE4ooCOETUvsyTUJigdau6jHZNXCXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKen3ET1w6/mgti2eIxhOubdsfef9vYQ6S53CyAGun3aAuIak5m7j1Gzb72TdB81pjFekONahIiG/jqW52CSqt4sDSuCRSD2Nc4YeqLMyDsixerGL4dYDufUwkXlSw7RFDjk3t+ZdoXSmdg0fVHw+YgbRUkKF27EfEACU0gtjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2726F13D5;
	Tue, 18 Mar 2025 11:40:37 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27BD03F694;
	Tue, 18 Mar 2025 11:40:22 -0700 (PDT)
Message-ID: <9bd56bd6-ce7d-495f-9bb3-ce7f07975f62@arm.com>
Date: Tue, 18 Mar 2025 18:40:20 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/rockchip: Add flush_iotlb_all ops
To: Detlev Casanova <detlev.casanova@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>
References: <20250318152049.14781-1-detlev.casanova@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250318152049.14781-1-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/03/2025 3:20 pm, Detlev Casanova wrote:
> From: Jonas Karlman <jonas@kwiboo.se>
> 
> On some Rockchip cores (like the vdpu34x video decoder), the IOMMU device
> is inside the the device that uses it.
> 
> The IOMMU device can still be driven by the iommu driver, but when an
> error occurs in the main device (e.g. a decoding error that resets the
> decoder), the IOMMU device will also be reseted.
> In such situation, the IOMMU driver and the hardware are out of sync and
> IOMMU errors will start popping up.
> 
> To avoid that, add a flush_iotlb_all function that will let the main drivers
> (e.g. rkvdec) tell the IOMMU driver to write all its cached mappings into
> the IOMMU hardware when such an error occured.

Eww, this is the exact opposite of what flush_iotlb_all represents, and 
I really don't like the idea of the public IOMMU API being abused for 
inter-driver communication. Please have some kind of proper reset 
notifier mechanism - in fact with runtime PM could you not already 
invoke a suspend/resume cycle via the device links? AFAICS it would also 
work to attach to a different domain then switch back again. Or at worst 
just export a public interface for the other driver to invoke 
rk_iommu_resume() directly. Just don't hide it in something completely 
inappropriate - I mean, consider if someone wants to implement 
IOMMU_CAP_DEFERRED_FLUSH support here in future...

Thanks,
Robin.

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>   drivers/iommu/rockchip-iommu.c | 45 ++++++++++++++++++++++++++++++----
>   1 file changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 323cc665c357..7086716cb8fc 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -899,6 +899,40 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
>   	return unmap_size;
>   }
>   
> +static void rk_iommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
> +	struct list_head *pos;
> +	unsigned long flags;
> +	int i, ret;
> +
> +	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
> +	list_for_each(pos, &rk_domain->iommus) {
> +		struct rk_iommu *iommu = list_entry(pos, struct rk_iommu, node);
> +
> +		ret = pm_runtime_get_if_in_use(iommu->dev);
> +		if (!ret || WARN_ON_ONCE(ret < 0))
> +			continue;
> +
> +		if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
> +			continue;
> +
> +		rk_iommu_enable_stall(iommu);
> +		for (i = 0; i < iommu->num_mmu; i++) {
> +			rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
> +				rk_ops->mk_dtentries(rk_domain->dt_dma));
> +			rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
> +			rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
> +		}
> +		rk_iommu_enable_paging(iommu);
> +		rk_iommu_disable_stall(iommu);
> +
> +		clk_bulk_disable(iommu->num_clocks, iommu->clocks);
> +		pm_runtime_put(iommu->dev);
> +	}
> +	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
> +}
> +
>   static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
>   {
>   	struct rk_iommudata *data = dev_iommu_priv_get(dev);
> @@ -1172,11 +1206,12 @@ static const struct iommu_ops rk_iommu_ops = {
>   	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
>   	.of_xlate = rk_iommu_of_xlate,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
> -		.attach_dev	= rk_iommu_attach_device,
> -		.map_pages	= rk_iommu_map,
> -		.unmap_pages	= rk_iommu_unmap,
> -		.iova_to_phys	= rk_iommu_iova_to_phys,
> -		.free		= rk_iommu_domain_free,
> +		.attach_dev		= rk_iommu_attach_device,
> +		.map_pages		= rk_iommu_map,
> +		.unmap_pages		= rk_iommu_unmap,
> +		.flush_iotlb_all	= rk_iommu_flush_iotlb_all,
> +		.iova_to_phys		= rk_iommu_iova_to_phys,
> +		.free			= rk_iommu_domain_free,
>   	}
>   };
>   
