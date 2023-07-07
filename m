Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF72C13D
	for <iommu@lists.linux.dev>; Fri,  7 Jul 2023 11:54:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FE69D75;
	Fri,  7 Jul 2023 04:55:23 -0700 (PDT)
Received: from [10.57.28.254] (unknown [10.57.28.254])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04CF13F740;
	Fri,  7 Jul 2023 04:54:39 -0700 (PDT)
Message-ID: <af4166f9-7b86-6c12-a8f8-ee0398743dd6@arm.com>
Date: Fri, 7 Jul 2023 12:54:35 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] iommu: Expose an API to set identity domain
Content-Language: en-GB
To: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: nikhilnd@google.com, mshavit@google.com, iommu@lists.linux.dev
References: <20230707104857.348353-1-praan@google.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230707104857.348353-1-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-07-07 11:48, Pranjal Shrivastava wrote:
> The iommu driver has a function `iommu_change_dev_def_domain` that
> allows the user to change iommu domain of a group through a sysfs entry.
> Currently, the following steps are required to change the iommu domain
> via sysfs:
> 
> 1. Unbind the driver
> 2. echo `domain_type` > /sys/kernel/iommu_groups/<grp_id>/type
> 3. Re-bind the driver
> 
> This change introduces a wrapper function around it which allows drivers
> to change their iommu domain to identity during the driver probe. This
> faciitates bypassing the iommu for trusted IPs/devices for performance
> without needing to unbind and re-bind the driver from the user space.

So a malicious endpoint now gets to bypass user policy and pwn the 
system by simply spoofing any endpoint ID whose driver has decided on 
the user's behalf that the user trusts it? Brilliant!

Sure, this is probably possible to an extent already with the 
IOMMU-driver-level quirks for integrated devices, since we're currently 
not considering the topology of exactly *where* we find those and 
whether it looks right or not, but c'mon, let's at least not 
*intentionally* smash a big hole in the trust model and leave an open 
invitation next to it.

Thanks,
Robin.

> Additionally, it helps in achieving this functionality when the sysfs is
> disabled for a system.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>   drivers/iommu/iommu.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f1dcfa3f1a1b..36f158621dc5 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -13,6 +13,7 @@
>   #include <linux/bug.h>
>   #include <linux/types.h>
>   #include <linux/init.h>
> +#include <linux/dma-map-ops.h>
>   #include <linux/export.h>
>   #include <linux/slab.h>
>   #include <linux/errno.h>
> @@ -2908,6 +2909,10 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
>   	if (ret)
>   		goto free_new_domain;
>   
> +	/* Make sure dma_ops are appropriatley set */
> +	if (type == IOMMU_DOMAIN_IDENTITY)
> +		set_dma_ops(dev, NULL);
> +
>   	iommu_domain_free(prev_dom);
>   
>   	return 0;
> @@ -2921,6 +2926,22 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
>   	return ret;
>   }
>   
> +/*
> + * Sets the default domain to identity of an iommu group
> + *
> + * @group: The group for which the default domain should be changed
> + * @dev: The first device in the group
> + *
> + * Returns 0 on success and error code on failure
> + * Note:Presently, this function shall be called only if the driver requests to
> + * change the group's default domain type to identity during the driver's probe.
> + */
> +int iommu_set_def_identity_domain(struct device *dev, struct iommu_group *group)
> +{
> +	return iommu_change_dev_def_domain(group, dev, IOMMU_DOMAIN_IDENTITY);
> +}
> +EXPORT_SYMBOL_GPL(iommu_set_def_identity_domain);
> +
>   /*
>    * Changing the default domain through sysfs requires the users to unbind the
>    * drivers from the devices in the iommu group, except for a DMA -> DMA-FQ
