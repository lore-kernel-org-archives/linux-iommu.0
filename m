Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AB33C37
	for <iommu@lists.linux.dev>; Tue,  4 Oct 2022 15:02:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99C081063;
	Tue,  4 Oct 2022 08:02:33 -0700 (PDT)
Received: from [10.57.65.170] (unknown [10.57.65.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 895D73F792;
	Tue,  4 Oct 2022 08:02:24 -0700 (PDT)
Message-ID: <eb1955e4-a618-ebf0-562d-17f9dd58b0da@arm.com>
Date: Tue, 4 Oct 2022 16:02:18 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v4 5/5] iommu/s390: Fix incorrect pgsize_bitmap
Content-Language: en-GB
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Pierre Morel
 <pmorel@linux.ibm.com>, iommu@lists.linux.dev
Cc: linux-s390@vger.kernel.org, borntraeger@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
 svens@linux.ibm.com, joro@8bytes.org, will@kernel.org, jgg@nvidia.com,
 linux-kernel@vger.kernel.org
References: <20221004120706.2957492-1-schnelle@linux.ibm.com>
 <20221004120706.2957492-6-schnelle@linux.ibm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221004120706.2957492-6-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-10-04 13:07, Niklas Schnelle wrote:
> The .pgsize_bitmap property of struct iommu_ops is not a page mask but
> rather has a bit set for each size of pages the IOMMU supports. As the
> comment correctly pointed out at this moment the code only support 4K
> pages so simply use SZ_4K here.

Unless it's already been done somewhere else, you'll want to switch over 
to the {map,unmap}_pages() interfaces as well to avoid taking a hit on 
efficiency here. The "page mask" thing was an old hack to trick the core 
API into making fewer map/unmap calls where the driver could map 
arbitrary numbers of pages at once anyway. The multi-page interfaces now 
do that more honestly and generally better (since they work for 
non-power-of-two sizes as well).

Robin.

> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/iommu/s390-iommu.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 94c444b909bd..6bf23e7830a2 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -12,13 +12,6 @@
>   #include <linux/sizes.h>
>   #include <asm/pci_dma.h>
>   
> -/*
> - * Physically contiguous memory regions can be mapped with 4 KiB alignment,
> - * we allow all page sizes that are an order of 4KiB (no special large page
> - * support so far).
> - */
> -#define S390_IOMMU_PGSIZES	(~0xFFFUL)
> -
>   static const struct iommu_ops s390_iommu_ops;
>   
>   struct s390_domain {
> @@ -350,7 +343,7 @@ static const struct iommu_ops s390_iommu_ops = {
>   	.probe_device = s390_iommu_probe_device,
>   	.release_device = s390_iommu_release_device,
>   	.device_group = generic_device_group,
> -	.pgsize_bitmap = S390_IOMMU_PGSIZES,
> +	.pgsize_bitmap = SZ_4K,
>   	.get_resv_regions = s390_iommu_get_resv_regions,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
>   		.attach_dev	= s390_iommu_attach_device,
