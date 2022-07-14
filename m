Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB24A3206
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 12:01:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66CA213D5;
	Thu, 14 Jul 2022 05:01:44 -0700 (PDT)
Received: from [10.57.86.49] (unknown [10.57.86.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1B423F792;
	Thu, 14 Jul 2022 05:01:42 -0700 (PDT)
Message-ID: <f701a947-3b93-d47e-f806-fd47d281d371@arm.com>
Date: Thu, 14 Jul 2022 13:01:37 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] iommu/virtio: Advertise IOMMU_CAP_CACHE_COHERENCY
Content-Language: en-GB
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org
Cc: will@kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, eric.auger@redhat.com
References: <20220714111059.708735-1-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220714111059.708735-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-07-14 12:11, Jean-Philippe Brucker wrote:
> Fix virtio-iommu interaction with VFIO, as VFIO now requires
> IOMMU_CAP_CACHE_COHERENCY. virtio-iommu does not support non-cacheable
> mappings, and always expects to be called with IOMMU_CACHE.

Can we know this is actually true though? What if the virtio-iommu 
implementation is backed by something other than VFIO, and the 
underlying hardware isn't coherent? AFAICS the spec doesn't disallow that.

Thanks,
Robin.

> Fixes: e8ae0e140c05 ("vfio: Require that devices support DMA cache coherence")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/iommu/virtio-iommu.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 25be4b822aa0..bf340d779c10 100644
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
