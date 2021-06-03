Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38C7C47082
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 11:21:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BCEE613F0
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 11:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCEE613F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 579EC405E2;
	Thu,  3 Jun 2021 11:21:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3vKQmQ3ySLOI; Thu,  3 Jun 2021 11:21:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3B01405C0;
	Thu,  3 Jun 2021 11:21:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF0A2C000E;
	Thu,  3 Jun 2021 11:21:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2772C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 11:21:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A373883ECF
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 11:21:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xo8n1REnIeTx for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 11:21:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5487830DE
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 11:21:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FE681063;
 Thu,  3 Jun 2021 04:21:01 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 585D83F774;
 Thu,  3 Jun 2021 04:20:59 -0700 (PDT)
Date: Thu, 3 Jun 2021 12:20:54 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v4 3/8] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Message-ID: <20210603112054.GA14606@lpieralisi>
References: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
 <20210513134550.2117-4-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210513134550.2117-4-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 wanghuiqiang@huawei.com, guohanjun@huawei.com, yangyicong@huawei.com,
 Sami.Mujawar@arm.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Thu, May 13, 2021 at 02:45:45PM +0100, Shameer Kolothum wrote:
> Add a helper function that retrieves RMR memory descriptors
> associated with a given IOMMU. This will be used by IOMMU
> drivers to setup necessary mappings.
> 
> Now that we have this, invoke it from the generic helper

"Add a helper function (iort_iommu_get_rmrs()) that retrieves RMR memory
descriptors associated with a given IOMMU. This will be used by IOMMU
drivers to setup necessary mappings.

Invoke it from the generic helper iommu_dma_get_rmrs()."

> interface.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 40 +++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/dma-iommu.c |  3 +++
>  include/linux/acpi_iort.h |  7 +++++++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index fea1ffaedf3b..6ca88c38987a 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/acpi_iort.h>
>  #include <linux/bitfield.h>
> +#include <linux/dma-iommu.h>
>  #include <linux/iommu.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -837,6 +838,43 @@ static inline int iort_add_device_replay(struct device *dev)
>  	return err;
>  }
>  
> +/**
> + * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with IOMMU

iort_iommu_get_rmrs()

please check other functions comments in the patchset.

> + * @iommu: fwnode for the IOMMU

Does not match the parameter.

> + * @head: RMR list head to be populated
> + *
> + * Returns: 0 on success, <0 failure
> + */
> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *head)
> +{
> +	struct iort_rmr_entry *e;
> +	struct acpi_iort_node *iommu;
> +
> +	iommu = iort_get_iort_node(iommu_fwnode);
> +	if (!iommu)
> +		return -EINVAL;
> +
> +	list_for_each_entry(e, &iort_rmr_list, list) {
> +		struct acpi_iort_rmr_desc *rmr_desc;
> +		struct iommu_rmr *rmr;
> +
> +		if (e->smmu != iommu)
> +			continue;
> +
> +		rmr_desc = e->rmr_desc;
> +		rmr = iommu_dma_alloc_rmr(rmr_desc->base_address,
> +					  rmr_desc->length, e->sid,
> +					  e->flags);
> +		if (!rmr)
> +			return -ENOMEM;

I suppose it is OK to leave the already allocated regions allocated
on -ENOMEM.

Probably worth clarifying it in the function comment.

Lorenzo

> +
> +		list_add_tail(&rmr->list, head);
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * iort_iommu_msi_get_resv_regions - Reserved region driver helper
>   * @dev: Device from iommu_get_resv_regions()
> @@ -1108,6 +1146,8 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
>  const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>  						const u32 *input_id)
>  { return NULL; }
> +int iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct list_head *head)
> +{ return -ENODEV; }
>  #endif
>  
>  static int nc_dma_get_range(struct device *dev, u64 *size)
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 674bd8815159..2d9caf548a32 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -203,6 +203,9 @@ EXPORT_SYMBOL(iommu_dma_get_resv_regions);
>  int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
>  		       struct list_head *list)
>  {
> +	if (!is_of_node(iommu_fwnode))
> +		return iort_iommu_get_rmrs(iommu_fwnode, list);
> +
>  	return -EINVAL;
>  }
>  EXPORT_SYMBOL(iommu_dma_get_rmrs);
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index 1a12baa58e40..e8c45fa59531 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -39,6 +39,8 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>  						const u32 *id_in);
>  int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
>  phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
> +int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
> +			struct list_head *list);
>  #else
>  static inline void acpi_iort_init(void) { }
>  static inline u32 iort_msi_map_id(struct device *dev, u32 id)
> @@ -59,6 +61,11 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
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
