Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52965C433F5
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 15:13:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8A6B610CD;
	Wed,  6 Apr 2022 15:13:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YZb64zMoM9YW; Wed,  6 Apr 2022 15:13:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A97E560EA2;
	Wed,  6 Apr 2022 15:13:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7980EC001D;
	Wed,  6 Apr 2022 15:13:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92B41C0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 15:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72EBB83DF5
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 15:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B2HOOJj81S-Y for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 15:13:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6BF8583E00
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 15:13:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3F2F12FC;
 Wed,  6 Apr 2022 08:13:07 -0700 (PDT)
Received: from lpieralisi (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B1543F73B;
 Wed,  6 Apr 2022 08:13:04 -0700 (PDT)
Date: Wed, 6 Apr 2022 16:12:50 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v9 03/11] ACPI/IORT: Make
 iort_iommu_msi_get_resv_regions() return void
Message-ID: <20220406151250.GA27518@lpieralisi>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-4-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220404124209.1086-4-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: will@kernel.org, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, wanghuiqiang@huawei.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Apr 04, 2022 at 01:42:01PM +0100, Shameer Kolothum wrote:
> At present iort_iommu_msi_get_resv_regions() returns the number of
> MSI reserved regions on success and there are no users for this.
> The reserved region list will get populated anyway for platforms
> that require the HW MSI region reservation. Hence, change the
> function to return void instead.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 26 ++++++++++----------------
>  include/linux/acpi_iort.h |  6 +++---
>  2 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index fd06cf43ba31..c5ebb2be9a19 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -832,25 +832,23 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
>  
>  /**
>   * iort_iommu_msi_get_resv_regions - Reserved region driver helper
> + *                                   for HW MSI regions.

Very minor but is this a spurious change ?

>   * @dev: Device from iommu_get_resv_regions()
>   * @head: Reserved region list from iommu_get_resv_regions()
>   *
> - * Returns: Number of msi reserved regions on success (0 if platform
> - *          doesn't require the reservation or no associated msi regions),
> - *          appropriate error value otherwise. The ITS interrupt translation
> - *          spaces (ITS_base + SZ_64K, SZ_64K) associated with the device
> - *          are the msi reserved regions.
> + * The ITS interrupt translation spaces (ITS_base + SZ_64K, SZ_64K)
> + * associated with the device are the HW MSI reserved regions.
>   */
> -int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> +void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	struct acpi_iort_its_group *its;
>  	struct acpi_iort_node *iommu_node, *its_node = NULL;
> -	int i, resv = 0;
> +	int i;
>  
>  	iommu_node = iort_get_msi_resv_iommu(dev);
>  	if (!iommu_node)
> -		return 0;
> +		return;
>  
>  	/*
>  	 * Current logic to reserve ITS regions relies on HW topologies
> @@ -870,7 +868,7 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  	}
>  
>  	if (!its_node)
> -		return 0;
> +		return;
>  
>  	/* Move to ITS specific data */
>  	its = (struct acpi_iort_its_group *)its_node->node_data;
> @@ -884,14 +882,10 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  
>  			region = iommu_alloc_resv_region(base + SZ_64K, SZ_64K,
>  							 prot, IOMMU_RESV_MSI);
> -			if (region) {
> +			if (region)
>  				list_add_tail(&region->list, head);
> -				resv++;
> -			}
>  		}
>  	}
> -
> -	return (resv == its->its_count) ? resv : -ENODEV;
>  }
>  
>  static inline bool iort_iommu_driver_enabled(u8 type)
> @@ -1058,8 +1052,8 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
>  }
>  
>  #else
> -int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> -{ return 0; }
> +void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> +{ }
>  int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
>  { return -ENODEV; }
>  #endif
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index f1f0842a2cb2..a8198b83753d 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -36,7 +36,7 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
>  /* IOMMU interface */
>  int iort_dma_get_ranges(struct device *dev, u64 *size);
>  int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
> -int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
> +void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>  phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
>  #else
>  static inline void acpi_iort_init(void) { }
> @@ -52,8 +52,8 @@ static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
>  static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
>  { return -ENODEV; }
>  static inline
> -int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> -{ return 0; }
> +void iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
> +{ }
>  
>  static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
>  { return PHYS_ADDR_MAX; }
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
