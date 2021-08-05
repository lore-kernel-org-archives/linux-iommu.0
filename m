Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ABCC4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 15:44:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8516113B
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 15:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C8516113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9A3D83A5D;
	Thu,  5 Aug 2021 15:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TfVnrQxj4awz; Thu,  5 Aug 2021 15:44:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B323683AFC;
	Thu,  5 Aug 2021 15:43:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8608BC001A;
	Thu,  5 Aug 2021 15:43:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B098C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 15:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 747774012F
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 15:43:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iOFOtqV9lqTp for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 15:43:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 22B5E400F7
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 15:43:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6447731B;
 Thu,  5 Aug 2021 08:43:56 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75C6E3F66F;
 Thu,  5 Aug 2021 08:43:54 -0700 (PDT)
Date: Thu, 5 Aug 2021 16:43:49 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v7 4/9] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Message-ID: <20210805154349.GA23085@lpieralisi>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210805080724.480-5-shameerali.kolothum.thodi@huawei.com>
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

On Thu, Aug 05, 2021 at 09:07:19AM +0100, Shameer Kolothum wrote:
> Add a helper function (iort_iommu_get_rmrs()) that retrieves RMR
> memory descriptors associated with a given IOMMU. This will be used
> by IOMMU drivers to setup necessary mappings.
> 
> Invoke it from the generic helper iommu_dma_get_rmrs().
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/dma-iommu.c |  4 ++++
>  include/linux/acpi_iort.h |  7 +++++++
>  3 files changed, 49 insertions(+)

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index d76ba46ebe67..3c32d62e63b6 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -809,6 +809,42 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
>  	return NULL;
>  }
>  
> +/**
> + * iort_iommu_get_rmrs() - Helper to retrieve RMR info associated with IOMMU
> + * @iommu_fwnode: fwnode for the IOMMU
> + * @head: RMR list head to be populated
> + *
> + * Returns: 0 on success, <0 failure. Please note, we will keep the already
> + *          allocated RMR reserve regions in case of a kmemdup()
> + *          failure.
> + */
> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *head)
> +{
> +	struct iommu_resv_region *e;
> +	struct acpi_iort_node *iommu;
> +	int rmrs = 0;
> +
> +	iommu = iort_get_iort_node(iommu_fwnode);
> +	if (!iommu || list_empty(&iort_rmr_list))
> +		return -ENODEV;
> +
> +	list_for_each_entry(e, &iort_rmr_list, list) {
> +		struct iommu_resv_region *region;
> +
> +		if (e->fw_data.rmr.smmu != iommu)
> +			continue;
> +
> +		region = kmemdup(e, sizeof(*region), GFP_KERNEL);
> +		if (region) {
> +			list_add_tail(&region->list, head);
> +			rmrs++;
> +		}
> +	}
> +
> +	return (rmrs == 0) ? -ENODEV : 0;
> +}
> +
>  /**
>   * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>   * @dev: Device from iommu_get_resv_regions()
> @@ -1041,6 +1077,8 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  { return 0; }
>  int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
>  { return -ENODEV; }
> +int iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct list_head *head)
> +{ return -ENODEV; }
>  #endif
>  
>  static int nc_dma_get_range(struct device *dev, u64 *size)
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2fa2445e9070..1b6e27475279 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -185,6 +185,9 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
>  int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
>  		       struct list_head *list)
>  {
> +	if (!is_of_node(iommu_fwnode))
> +		return iort_iommu_get_rmrs(iommu_fwnode, list);
> +
>  	return -EINVAL;
>  }
>  EXPORT_SYMBOL(iommu_dma_get_rmrs);
> @@ -200,6 +203,7 @@ EXPORT_SYMBOL(iommu_dma_get_rmrs);
>  void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
>  			struct list_head *list)
>  {
> +	generic_iommu_put_resv_regions(iommu_fwnode->dev, list);
>  }
>  EXPORT_SYMBOL(iommu_dma_put_rmrs);
>  
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index f1f0842a2cb2..d8c030c103f5 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -38,6 +38,8 @@ int iort_dma_get_ranges(struct device *dev, u64 *size);
>  int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
>  int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>  phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *list);
>  #else
>  static inline void acpi_iort_init(void) { }
>  static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> @@ -57,6 +59,11 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  
>  static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
>  { return PHYS_ADDR_MAX; }
> +
> +static inline
> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *list)
> +{ return -ENODEV; }
>  #endif
>  
>  #endif /* __ACPI_IORT_H__ */
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
