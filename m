Return-Path: <SRS0=lDjG=O4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50146C433F5
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 13:10:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E500C61038
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 13:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E500C61038
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A48E64051B;
	Fri,  8 Oct 2021 13:10:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BiVhivMeiT8i; Fri,  8 Oct 2021 13:10:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 197F9400E8;
	Fri,  8 Oct 2021 13:10:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEF75C000F;
	Fri,  8 Oct 2021 13:10:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53A05C000D
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 13:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3DBA583D2A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 13:10:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bnTsCxdKJce3 for <iommu@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 13:10:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17C2383E1C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 13:10:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34D8A6D;
 Fri,  8 Oct 2021 06:10:06 -0700 (PDT)
Received: from [10.57.22.120] (unknown [10.57.22.120])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1BFA3F66F;
 Fri,  8 Oct 2021 06:10:03 -0700 (PDT)
Subject: Re: [PATCH v7 9/9] iommu/dma: Reserve any RMR regions associated with
 a dev
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-10-shameerali.kolothum.thodi@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <44e00e32-be89-1174-beb5-9a2fca85a683@arm.com>
Date: Fri, 8 Oct 2021 14:09:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210805080724.480-10-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
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

On 2021-08-05 09:07, Shameer Kolothum wrote:
> Get ACPI IORT RMR regions associated with a dev reserved
> so that there is a unity mapping for them in SMMU.

This feels like most of it belongs in the IORT code rather than 
iommu-dma (which should save the temporary list copy as well).

Robin.

> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/iommu/dma-iommu.c | 56 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 1b6e27475279..c1ae0c3d4b33 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -207,22 +207,68 @@ void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
>   }
>   EXPORT_SYMBOL(iommu_dma_put_rmrs);
>   
> +static bool iommu_dma_dev_has_rmr(struct iommu_fwspec *fwspec,
> +				  struct iommu_resv_region *e)
> +{
> +	int i;
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		if (e->fw_data.rmr.sid == fwspec->ids[i])
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void iommu_dma_get_rmr_resv_regions(struct device *dev,
> +					   struct list_head *list)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct list_head rmr_list;
> +	struct iommu_resv_region *rmr, *tmp;
> +
> +	INIT_LIST_HEAD(&rmr_list);
> +	if (iommu_dma_get_rmrs(fwspec->iommu_fwnode, &rmr_list))
> +		return;
> +
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +		struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
> +
> +		if (!host->preserve_config)
> +			return;
> +	}
> +
> +	list_for_each_entry_safe(rmr, tmp, &rmr_list, list) {
> +		if (!iommu_dma_dev_has_rmr(fwspec, rmr))
> +			continue;
> +
> +		/* Remove from iommu RMR list and add to dev resv_regions */
> +		list_del_init(&rmr->list);
> +		list_add_tail(&rmr->list, list);
> +	}
> +
> +	iommu_dma_put_rmrs(fwspec->iommu_fwnode, &rmr_list);
> +}
> +
>   /**
>    * iommu_dma_get_resv_regions - Reserved region driver helper
>    * @dev: Device from iommu_get_resv_regions()
>    * @list: Reserved region list from iommu_get_resv_regions()
>    *
>    * IOMMU drivers can use this to implement their .get_resv_regions callback
> - * for general non-IOMMU-specific reservations. Currently, this covers GICv3
> - * ITS region reservation on ACPI based ARM platforms that may require HW MSI
> - * reservation.
> + * for general non-IOMMU-specific reservations. Currently this covers,
> + *  -GICv3 ITS region reservation on ACPI based ARM platforms that may
> + *   require HW MSI reservation.
> + *  -Any ACPI IORT RMR memory range reservations (IORT spec rev E.b)
>    */
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
>   {
>   
> -	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
> +	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode)) {
>   		iort_iommu_msi_get_resv_regions(dev, list);
> -
> +		iommu_dma_get_rmr_resv_regions(dev, list);
> +	}
>   }
>   EXPORT_SYMBOL(iommu_dma_get_resv_regions);
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
