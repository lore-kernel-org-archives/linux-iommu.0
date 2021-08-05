Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47770C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 16:03:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0188761156
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 16:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0188761156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD16C83B33;
	Thu,  5 Aug 2021 16:03:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id te3PLQwM6Z4i; Thu,  5 Aug 2021 16:03:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 75F4A83B2E;
	Thu,  5 Aug 2021 16:03:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55255C0010;
	Thu,  5 Aug 2021 16:03:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF9DBC000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 16:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C11B1608EB
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 16:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wfGG1x5hjxKf for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 16:03:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id E684A608D3
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 16:03:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 354FD31B;
 Thu,  5 Aug 2021 09:03:24 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 481C93F66F;
 Thu,  5 Aug 2021 09:03:22 -0700 (PDT)
Date: Thu, 5 Aug 2021 17:03:19 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
Message-ID: <20210805160319.GB23085@lpieralisi>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
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

On Thu, Aug 05, 2021 at 09:07:17AM +0100, Shameer Kolothum wrote:

[...]

> +static void __init iort_node_get_rmr_info(struct acpi_iort_node *iort_node)
> +{
> +	struct acpi_iort_node *smmu;
> +	struct acpi_iort_rmr *rmr;
> +	struct acpi_iort_rmr_desc *rmr_desc;
> +	u32 map_count = iort_node->mapping_count;
> +	u32 sid;
> +	int i;
> +
> +	if (!iort_node->mapping_offset || map_count != 1) {
> +		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
> +		       iort_node);
> +		return;
> +	}
> +
> +	/* Retrieve associated smmu and stream id */
> +	smmu = iort_node_get_id(iort_node, &sid, 0);
> +	if (!smmu) {
> +		pr_err(FW_BUG "Invalid SMMU reference, skipping RMR node %p\n",
> +		       iort_node);
> +		return;
> +	}
> +
> +	/* Retrieve RMR data */
> +	rmr = (struct acpi_iort_rmr *)iort_node->node_data;
> +	if (!rmr->rmr_offset || !rmr->rmr_count) {
> +		pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR node %p\n",
> +		       iort_node);
> +		return;
> +	}
> +
> +	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
> +				rmr->rmr_offset);
> +
> +	iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
> +
> +	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
> +		struct iommu_resv_region *region;
> +		enum iommu_resv_type type;
> +		int prot = IOMMU_READ | IOMMU_WRITE;
> +		u64 addr = rmr_desc->base_address, size = rmr_desc->length;
> +
> +		if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
> +			/* PAGE align base addr and size */
> +			addr &= PAGE_MASK;
> +			size = PAGE_ALIGN(size + offset_in_page(rmr_desc->base_address));
> +
> +			pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to 64K, continue with [0x%llx - 0x%llx]\n",
> +			       rmr_desc->base_address,
> +			       rmr_desc->base_address + rmr_desc->length - 1,
> +			       addr, addr + size - 1);
> +		}
> +		if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
> +			type = IOMMU_RESV_DIRECT_RELAXABLE;
> +			/*
> +			 * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
> +			 * normally used for allocated system memory that is
> +			 * then used for device specific reserved regions.
> +			 */
> +			prot |= IOMMU_CACHE;
> +		} else {
> +			type = IOMMU_RESV_DIRECT;
> +			/*
> +			 * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally used
> +			 * for device memory like MSI doorbell.
> +			 */
> +			prot |= IOMMU_MMIO;
> +		}

On the prot value assignment based on the remapping flag, I'd like to
hear Robin/Joerg's opinion, I'd avoid being in a situation where
"normally" this would work but then we have to quirk it.

Is this a valid assumption _always_ ?

Thanks,
Lorenzo

> +
> +		region = iommu_alloc_resv_region(addr, size, prot, type);
> +		if (region) {
> +			region->fw_data.rmr.flags = rmr->flags;
> +			region->fw_data.rmr.sid = sid;
> +			region->fw_data.rmr.smmu = smmu;
> +			list_add_tail(&region->list, &iort_rmr_list);
> +		}
> +	}
> +}
> +
> +static void __init iort_parse_rmr(void)
> +{
> +	struct acpi_iort_node *iort_node, *iort_end;
> +	struct acpi_table_iort *iort;
> +	int i;
> +
> +	if (iort_table->revision < 3)
> +		return;
> +
> +	iort = (struct acpi_table_iort *)iort_table;
> +
> +	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> +				 iort->node_offset);
> +	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> +				iort_table->length);
> +
> +	for (i = 0; i < iort->node_count; i++) {
> +		if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
> +			       "IORT node pointer overflows, bad table!\n"))
> +			return;
> +
> +		if (iort_node->type == ACPI_IORT_NODE_RMR)
> +			iort_node_get_rmr_info(iort_node);
> +
> +		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> +					 iort_node->length);
> +	}
> +}
>  
>  static void __init iort_init_platform_devices(void)
>  {
> @@ -1636,6 +1767,7 @@ void __init acpi_iort_init(void)
>  	}
>  
>  	iort_init_platform_devices();
> +	iort_parse_rmr();
>  }
>  
>  #ifdef CONFIG_ZONE_DMA
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
