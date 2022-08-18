Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C72D7B
	for <iommu@lists.linux.dev>; Thu, 18 Aug 2022 20:10:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C484D106F;
	Thu, 18 Aug 2022 13:10:33 -0700 (PDT)
Received: from [10.57.14.91] (unknown [10.57.14.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B64C3F70D;
	Thu, 18 Aug 2022 13:10:31 -0700 (PDT)
Message-ID: <51efe220-9eb2-b52f-81e3-45949e51fb27@arm.com>
Date: Thu, 18 Aug 2022 21:10:25 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] iommu/virtio: Fix interaction with VFIO
Content-Language: en-GB
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org
Cc: will@kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev
References: <20220818163801.1011548-1-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220818163801.1011548-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-08-18 17:38, Jean-Philippe Brucker wrote:
> Commit e8ae0e140c05 ("vfio: Require that devices support DMA cache
> coherence") requires IOMMU drivers to advertise
> IOMMU_CAP_CACHE_COHERENCY, in order to be used by VFIO. Since VFIO does
> not provide to userspace the ability to maintain coherency through cache
> invalidations, it requires hardware coherency. Advertise the capability
> in order to restore VFIO support.
> 
> The meaning of IOMMU_CAP_CACHE_COHERENCY also changed from "IOMMU can
> enforce cache coherent DMA transactions" to "IOMMU_CACHE is supported".
> While virtio-iommu cannot enforce coherency (of PCIe no-snoop
> transactions), it does support IOMMU_CACHE.
> 
> Non-coherent accesses are not currently a concern for virtio-iommu
> because host OSes only assign coherent devices,

Is that guaranteed though? I see nothing in VFIO checking *device* 
coherency, only that the *IOMMU* can impose it via this capability, 
which would form a very circular argument. We can no longer say that in 
practice nobody has a VFIO-capable IOMMU in front of non-coherent PCI, 
now that Rockchip RK3588 boards are about to start shipping (at best we 
can only say that they still won't have the SMMUs in the DT until I've 
finished ripping up the bus ops).

> and the guest does not
> enable PCIe no-snoop. Nevertheless, we can summarize here the possible
> support for non-coherent DMA:
> 
> (1) When accesses from a hardware endpoint are not coherent. The host
>      would describe such a device using firmware methods ('dma-coherent'
>      in device-tree, '_CCA' in ACPI), since they are also needed without
>      a vIOMMU. In this case mappings are created without IOMMU_CACHE.
>      virtio-iommu doesn't need any additional support. It sends the same
>      requests as for coherent devices.
> 
> (2) When the physical IOMMU supports non-cacheable mappings. Supporting
>      those would require a new feature in virtio-iommu, new PROBE request
>      property and MAP flags. Device drivers would use a new API to
>      discover this since it depends on the architecture and the physical
>      IOMMU.
> 
> (3) When the hardware supports PCIe no-snoop. Some architecture do not
>      support this either (whether no-snoop is supported by an Arm system
>      is not discoverable by software). If Linux did enable no-snoop in
>      endpoints on x86, then virtio-iommu would need additional feature,
>      PROBE property, ATTACH and/or MAP flags to support enforcing snoop.

That's not an "if" - various Linux drivers *do* use no-snoop, which IIUC 
is the main reason for VFIO wanting to enforce this in the first place. 
For example, see the big fat comment in drm_arch_can_wc_memory() if 
you've forgotten the fun we had with AMD GPUs in the TX2 boxes back in 
the day ;)

This is what I was getting at in reply to v1, it's really not a "this is 
fine as things stand" kind of patch, it's a "this is the best we can do 
to be less wrong for expected usage, but still definitely not right". 
Admittedly I downplayed that a little in [2] by deliberately avoiding 
all mention of no-snoop, but only because that's such a horrific 
unsolvable mess it's hardly worth the pain of bringing up...

Cheers,
Robin.

> Fixes: e8ae0e140c05 ("vfio: Require that devices support DMA cache coherence")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> 
> Since v1 [1], I added some details to the commit message. This fix is
> still needed for v5.19 and v6.0.
> 
> I can improve the check once Robin's change [2] is merged:
> capable(IOMMU_CAP_CACHE_COHERENCY) could return dev->dma_coherent for
> case (1) above.
> 
> [1] https://lore.kernel.org/linux-iommu/20220714111059.708735-1-jean-philippe@linaro.org/
> [2] https://lore.kernel.org/linux-iommu/d8bd8777d06929ad8f49df7fc80e1b9af32a41b5.1660574547.git.robin.murphy@arm.com/
> ---
>   drivers/iommu/virtio-iommu.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 08eeafc9529f..80151176ba12 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1006,7 +1006,18 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>   	return iommu_fwspec_add_ids(dev, args->args, 1);
>   }
>   
> +static bool viommu_capable(enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   static struct iommu_ops viommu_ops = {
> +	.capable		= viommu_capable,
>   	.domain_alloc		= viommu_domain_alloc,
>   	.probe_device		= viommu_probe_device,
>   	.probe_finalize		= viommu_probe_finalize,
