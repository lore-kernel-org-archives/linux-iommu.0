Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D2DC4332F
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 19:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B13F04016B;
	Tue, 22 Mar 2022 19:08:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bVMoS8y3RjO5; Tue, 22 Mar 2022 19:08:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 10C6A40004;
	Tue, 22 Mar 2022 19:08:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAF51C0012;
	Tue, 22 Mar 2022 19:08:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA9CFC000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 19:08:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C58A08175B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 19:08:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B6TTisBOqPAO for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 19:08:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC7DA814A0
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 19:08:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E61DE152B;
 Tue, 22 Mar 2022 12:08:51 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E21053F66F;
 Tue, 22 Mar 2022 12:08:49 -0700 (PDT)
Message-ID: <479ae561-e03e-163e-f945-d0c8fdf8dcea@arm.com>
Date: Tue, 22 Mar 2022 19:08:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 05/11] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Content-Language: en-GB
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-6-shameerali.kolothum.thodi@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220221154344.2126-6-shameerali.kolothum.thodi@huawei.com>
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 will@kernel.org, wanghuiqiang@huawei.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-02-21 15:43, Shameer Kolothum via iommu wrote:
> Add helper functions (iort_iommu_get/put_rmrs()) that
> retrieves/releases RMR memory descriptors associated
> with a given IOMMU. This will be used by IOMMU drivers
> to set up necessary mappings.
> 
> Invoke it from the generic iommu helper functions.

iommu_dma_get_resv_regions() already exists - please extend that rather 
than adding a parallel implementation of the same thing but different. 
IORT should export a single get_resv_regions helper which combines the 
new RMRs with the existing MSI workaround, and a separate "do I need to 
bypass this StreamID" helper for the SMMU drivers to call directly at 
reset time, since the latter isn't really an iommu-dma responsibility.

I'm happy to do that just by shuffling wrappers around for now - we can 
come back and streamline the code properly afterwards - but the sheer 
amount of indirection currently at play here is so hard to follow that 
it's not even all that easy to see how it's crossing abstraction levels 
improperly.

Thanks,
Robin.

> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/acpi/arm64/iort.c | 56 +++++++++++++++++++++++++++++++++++++++
>   drivers/iommu/dma-iommu.c |  4 +++
>   include/linux/acpi_iort.h | 14 ++++++++++
>   3 files changed, 74 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 05da9ebff50a..b2c959c72fb2 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1055,6 +1055,57 @@ static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
>   	}
>   }
>   
> +/**
> + * iort_iommu_dma_put_rmrs - Free any memory associated with RMRs.
> + * @iommu_fwnode: fwnode associated with IOMMU
> + * @head: Resereved region list
> + *
> + * This function go through the provided reserved region list and
> + * free up memory associated with RMR entries and delete them from
> + * the list.
> + */
> +void iort_iommu_put_rmrs(struct fwnode_handle *iommu_fwnode,
> +			 struct list_head *head)
> +{
> +	struct iommu_resv_region *e, *tmp;
> +
> +	/*
> +	 * RMR entries will have mem allocated for fw_data.rmr.sids.
> +	 * Free the mem and delete the node.
> +	 */
> +	list_for_each_entry_safe(e, tmp, head, list) {
> +		if (e->fw_data.rmr.sids) {
> +			kfree(e->fw_data.rmr.sids);
> +			list_del(&e->list);
> +			kfree(e);
> +		}
> +	}
> +}
> +
> +/**
> + *
> + * iort_iommu_dma_get_rmrs - Retrieve Reserved Memory Regions(RMRs) associated
> + *                      with a given IOMMU and dev.
> + * @iommu_fwnode: fwnode associated with IOMMU
> + * @dev: Device associated with RMR(Optional)
> + * @list: RMR list to be populated
> + *
> + * This function populates the RMR list associated with a given IOMMU and
> + * dev(if provided). If dev is NULL, the function populates all the RMRs
> + * associated with the given IOMMU.
> + */
> +void iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode, struct device *dev,
> +			 struct list_head *head)
> +{
> +	struct acpi_iort_node *iommu;
> +
> +	iommu = iort_get_iort_node(iommu_fwnode);
> +	if (!iommu)
> +		return;
> +
> +	iort_find_rmrs(iommu, dev, head);
> +}
> +
>   /**
>    * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>    * @dev: Device from iommu_get_resv_regions()
> @@ -1287,6 +1338,11 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>   { return 0; }
>   int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
>   { return -ENODEV; }
> +void iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct device *dev,
> +			 struct list_head *head)
> +{ }
> +void iort_iommu_put_rmrs(struct fwnode_handle *fwnode, struct list_head *head)
> +{ }
>   #endif
>   
>   static int nc_dma_get_range(struct device *dev, u64 *size)
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 65ab01d5128b..b33e4df85de1 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -382,12 +382,16 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>   void iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode, struct device *dev,
>   			struct list_head *list)
>   {
> +	if (!is_of_node(iommu_fwnode))
> +		iort_iommu_get_rmrs(iommu_fwnode, dev, list);
>   }
>   EXPORT_SYMBOL(iommu_dma_get_rmrs);
>   
>   void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
>   			struct list_head *list)
>   {
> +	if (!is_of_node(iommu_fwnode))
> +		iort_iommu_put_rmrs(iommu_fwnode, list);
>   }
>   EXPORT_SYMBOL(iommu_dma_put_rmrs);
>   
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index f1f0842a2cb2..212f7f178ec3 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -38,6 +38,10 @@ int iort_dma_get_ranges(struct device *dev, u64 *size);
>   int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
>   int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>   phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
> +void iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode, struct device *dev,
> +			 struct list_head *list);
> +void iort_iommu_put_rmrs(struct fwnode_handle *iommu_fwnode,
> +			 struct list_head *list);
>   #else
>   static inline void acpi_iort_init(void) { }
>   static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> @@ -57,6 +61,16 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>   
>   static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
>   { return PHYS_ADDR_MAX; }
> +
> +static inline
> +void iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode, struct device *dev,
> +			 struct list_head *list)
> +{  }
> +void iort_iommu_put_rmrs(struct fwnode_handle *iommu_fwnode,
> +			 struct list_head *list)
> +{ }
> +
> +{ }
>   #endif
>   
>   #endif /* __ACPI_IORT_H__ */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
