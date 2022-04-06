Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B7DC43217
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 15:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8894B6111C;
	Wed,  6 Apr 2022 15:51:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EUkxZFTs3ec7; Wed,  6 Apr 2022 15:51:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 75E1660EDD;
	Wed,  6 Apr 2022 15:51:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D244C001D;
	Wed,  6 Apr 2022 15:51:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6ABD1C0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 15:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 587DE60EDD
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 15:51:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nuZ5I7aMwM_A for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 15:51:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79DCA60EE5
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 15:51:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1BC012FC;
 Wed,  6 Apr 2022 08:51:14 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.21.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC8973F73B;
 Wed,  6 Apr 2022 08:51:12 -0700 (PDT)
Date: Wed, 6 Apr 2022 16:51:13 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v9 07/11] ACPI/IORT: Add a helper to retrieve RMR info
 directly
Message-ID: <20220406155113.GC27518@lpieralisi>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-8-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220404124209.1086-8-shameerali.kolothum.thodi@huawei.com>
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

On Mon, Apr 04, 2022 at 01:42:05PM +0100, Shameer Kolothum wrote:
> This will provide a way for SMMU drivers to retrieve StreamIDs
> associated with IORT RMR nodes and use that to set bypass settings
> for those IDs.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 29 +++++++++++++++++++++++++++++
>  include/linux/acpi_iort.h |  8 ++++++++
>  2 files changed, 37 insertions(+)

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 1147387cfddb..fb2b0163c27d 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1402,6 +1402,35 @@ int iort_dma_get_ranges(struct device *dev, u64 *size)
>  		return nc_dma_get_range(dev, size);
>  }
>  
> +/**
> + * iort_get_rmr_sids - Retrieve IORT RMR node reserved regions with
> + *                     associated StreamIDs information.
> + * @iommu_fwnode: fwnode associated with IOMMU
> + * @head: Resereved region list
> + */
> +void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
> +		       struct list_head *head)
> +{
> +	iort_iommu_rmr_get_resv_regions(iommu_fwnode, NULL, head);
> +}
> +EXPORT_SYMBOL_GPL(iort_get_rmr_sids);
> +
> +/**
> + * iort_put_rmr_sids - Free all the memory allocated for RMR reserved regions.
> + * @iommu_fwnode: fwnode associated with IOMMU
> + * @head: Resereved region list
> + */
> +void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
> +		       struct list_head *head)
> +{
> +	struct iommu_resv_region *entry, *next;
> +
> +	iort_iommu_put_resv_regions(NULL, head);
> +	list_for_each_entry_safe(entry, next, head, list)
> +		kfree(entry);
> +}
> +EXPORT_SYMBOL_GPL(iort_put_rmr_sids);
> +
>  static void __init acpi_iort_register_irq(int hwirq, const char *name,
>  					  int trigger,
>  					  struct resource *res)
> diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
> index eb3c28853110..774b8bc16573 100644
> --- a/include/linux/acpi_iort.h
> +++ b/include/linux/acpi_iort.h
> @@ -33,6 +33,10 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
>  					  enum irq_domain_bus_token bus_token);
>  void acpi_configure_pmsi_domain(struct device *dev);
>  int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
> +void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
> +		       struct list_head *head);
> +void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
> +		       struct list_head *head);
>  /* IOMMU interface */
>  int iort_dma_get_ranges(struct device *dev, u64 *size);
>  int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
> @@ -47,6 +51,10 @@ static inline struct irq_domain *iort_get_device_domain(
>  	struct device *dev, u32 id, enum irq_domain_bus_token bus_token)
>  { return NULL; }
>  static inline void acpi_configure_pmsi_domain(struct device *dev) { }
> +static inline
> +void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) { }
> +static inline
> +void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) { }
>  /* IOMMU interface */
>  static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
>  { return -ENODEV; }
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
