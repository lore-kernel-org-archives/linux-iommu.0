Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9713CC433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 05:59:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37EAC60EE7
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 05:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37EAC60EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 017BD4039B;
	Mon, 11 Oct 2021 05:59:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v8LSjuUS8vzo; Mon, 11 Oct 2021 05:59:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 89A4F4021A;
	Mon, 11 Oct 2021 05:59:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B4C2C0011;
	Mon, 11 Oct 2021 05:59:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B103C000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 05:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EEE2340224
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 05:59:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G9hcb9Sqc0MJ for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 05:59:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 79EAE4021A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 05:59:09 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HSSky0l9Yz8tWZ;
 Mon, 11 Oct 2021 13:58:02 +0800 (CST)
Received: from dggpemm100008.china.huawei.com (7.185.36.125) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 13:59:06 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100008.china.huawei.com (7.185.36.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 13:59:05 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.008; Mon, 11 Oct 2021 06:59:03 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
Thread-Topic: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
Thread-Index: AQHXidEiKr58723PTUGGkSglF1QKPavJYUsAgART7vA=
Date: Mon, 11 Oct 2021 05:59:03 +0000
Message-ID: <e258aeaac12a4ae59d54fda705f91e24@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <e24df2a9-1332-0eb3-b52a-230662fe46ba@arm.com>
In-Reply-To: <e24df2a9-1332-0eb3-b52a-230662fe46ba@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.25.32]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "will@kernel.org" <will@kernel.org>, wanghuiqiang <wanghuiqiang@huawei.com>
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



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: 08 October 2021 13:49
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
> steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
> will@kernel.org; wanghuiqiang <wanghuiqiang@huawei.com>
> Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
> 
> On 2021-08-05 09:07, Shameer Kolothum wrote:
> > Add support for parsing RMR node information from ACPI.
> >
> > Find the associated streamid and smmu node info from the
> > RMR node and populate a linked list with RMR memory
> > descriptors.
> >
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > ---
> >   drivers/acpi/arm64/iort.c | 134
> +++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 133 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 3b23fb775ac4..d76ba46ebe67 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -40,6 +40,8 @@ struct iort_fwnode {
> >   static LIST_HEAD(iort_fwnode_list);
> >   static DEFINE_SPINLOCK(iort_fwnode_lock);
> >
> > +static LIST_HEAD(iort_rmr_list);	/* list of RMR regions from ACPI */
> > +
> >   /**
> >    * iort_set_fwnode() - Create iort_fwnode and use it to register
> >    *		       iommu data in the iort_fwnode_list
> > @@ -393,7 +395,8 @@ static struct acpi_iort_node
> *iort_node_get_id(struct acpi_iort_node *node,
> >   		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
> >   		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
> >   		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
> > -		    node->type == ACPI_IORT_NODE_PMCG) {
> > +		    node->type == ACPI_IORT_NODE_PMCG ||
> > +		    node->type == ACPI_IORT_NODE_RMR) {
> >   			*id_out = map->output_base;
> >   			return parent;
> >   		}
> > @@ -1566,6 +1569,134 @@ static void __init iort_enable_acs(struct
> acpi_iort_node *iort_node)
> >   #else
> >   static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
> >   #endif
> > +static void iort_rmr_desc_check_overlap(struct acpi_iort_rmr_desc *desc,
> u32 count)
> > +{
> > +	int i, j;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		u64 end, start = desc[i].base_address, length = desc[i].length;
> > +
> > +		end = start + length - 1;
> > +
> > +		/* Check for address overlap */
> > +		for (j = i + 1; j < count; j++) {
> > +			u64 e_start = desc[j].base_address;
> > +			u64 e_end = e_start + desc[j].length - 1;
> > +
> > +			if (start <= e_end && end >= e_start)
> > +				pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] overlaps,
> continue anyway\n",
> > +				       start, end);
> > +		}
> > +	}
> > +}
> > +
> > +static void __init iort_node_get_rmr_info(struct acpi_iort_node *iort_node)
> > +{
> > +	struct acpi_iort_node *smmu;
> > +	struct acpi_iort_rmr *rmr;
> > +	struct acpi_iort_rmr_desc *rmr_desc;
> > +	u32 map_count = iort_node->mapping_count;
> > +	u32 sid;
> > +	int i;
> > +
> > +	if (!iort_node->mapping_offset || map_count != 1) {
> > +		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
> > +		       iort_node);
> > +		return;
> > +	}
> > +
> > +	/* Retrieve associated smmu and stream id */
> > +	smmu = iort_node_get_id(iort_node, &sid, 0);
> > +	if (!smmu) {
> > +		pr_err(FW_BUG "Invalid SMMU reference, skipping RMR
> node %p\n",
> > +		       iort_node);
> > +		return;
> > +	}
> > +
> > +	/* Retrieve RMR data */
> > +	rmr = (struct acpi_iort_rmr *)iort_node->node_data;
> > +	if (!rmr->rmr_offset || !rmr->rmr_count) {
> > +		pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR
> node %p\n",
> > +		       iort_node);
> > +		return;
> > +	}
> > +
> > +	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
> > +				rmr->rmr_offset);
> > +
> > +	iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
> > +
> > +	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
> > +		struct iommu_resv_region *region;
> > +		enum iommu_resv_type type;
> > +		int prot = IOMMU_READ | IOMMU_WRITE;
> > +		u64 addr = rmr_desc->base_address, size = rmr_desc->length;
> > +
> > +		if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
> > +			/* PAGE align base addr and size */
> > +			addr &= PAGE_MASK;
> > +			size = PAGE_ALIGN(size +
> offset_in_page(rmr_desc->base_address));
> > +
> > +			pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to
> 64K, continue with [0x%llx - 0x%llx]\n",
> > +			       rmr_desc->base_address,
> > +			       rmr_desc->base_address + rmr_desc->length - 1,
> > +			       addr, addr + size - 1);
> > +		}
> > +		if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
> > +			type = IOMMU_RESV_DIRECT_RELAXABLE;
> > +			/*
> > +			 * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
> > +			 * normally used for allocated system memory that is
> > +			 * then used for device specific reserved regions.
> > +			 */
> > +			prot |= IOMMU_CACHE;
> > +		} else {
> > +			type = IOMMU_RESV_DIRECT;
> > +			/*
> > +			 * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally
> used
> > +			 * for device memory like MSI doorbell.
> > +			 */
> > +			prot |= IOMMU_MMIO;
> > +		}
> 
> I'm not sure we ever got a definitive answer to this - does DPAA2
> actually go wrong if we use IOMMU_MMIO here? I'd still much prefer to
> make the fewest possible assumptions, since at this point it's basically
> just a stop-gap until we can fix the spec. It's become clear that we
> can't reliably rely on guessing attributes, so I'm not too fussed about
> theoretical cases that currently don't work (due to complete lack of RMR
> support) continuing to not work for the moment, as long as we can make
> the real-world cases we actually have work at all. Anything which only
> affects performance I'd rather leave until firmware can tell us what to do.

Just to report back, we have done some basic sanity tests with IOMMU_MMIO
set as default and it works for us. But I see that it doesn't for Jon's case.
So not sure what the stop-gap can be.. Can we use the _CCA + EFI approach
and override it later when the spec gets updated?

Thanks,
Shameer
 
> 
> > +		region = iommu_alloc_resv_region(addr, size, prot, type);
> > +		if (region) {
> > +			region->fw_data.rmr.flags = rmr->flags;
> > +			region->fw_data.rmr.sid = sid;
> > +			region->fw_data.rmr.smmu = smmu;
> > +			list_add_tail(&region->list, &iort_rmr_list);
> > +		}
> > +	}
> > +}
> > +
> > +static void __init iort_parse_rmr(void)
> > +{
> > +	struct acpi_iort_node *iort_node, *iort_end;
> > +	struct acpi_table_iort *iort;
> > +	int i;
> > +
> > +	if (iort_table->revision < 3)
> > +		return;
> > +
> > +	iort = (struct acpi_table_iort *)iort_table;
> > +
> > +	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> > +				 iort->node_offset);
> > +	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> > +				iort_table->length);
> > +
> > +	for (i = 0; i < iort->node_count; i++) {
> > +		if (WARN_TAINT(iort_node >= iort_end,
> TAINT_FIRMWARE_WORKAROUND,
> > +			       "IORT node pointer overflows, bad table!\n"))
> > +			return;
> > +
> > +		if (iort_node->type == ACPI_IORT_NODE_RMR)
> > +			iort_node_get_rmr_info(iort_node);
> > +
> > +		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> > +					 iort_node->length);
> > +	}
> > +}
> >
> >   static void __init iort_init_platform_devices(void)
> >   {
> > @@ -1636,6 +1767,7 @@ void __init acpi_iort_init(void)
> >   	}
> >
> >   	iort_init_platform_devices();
> > +	iort_parse_rmr();
> 
> I guess initcall ordering vs. driver registration probably covers it up,
> but for the sake of cleanliness I'd rather make sure the RMRs are fully
> discovered *before* we create the SMMU devices that we expect to start
> consuming them.
> 
> Robin.
> 
> >   }
> >
> >   #ifdef CONFIG_ZONE_DMA
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
