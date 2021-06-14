Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43B0C2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 12:37:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE2961206
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 12:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE2961206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4B619402D6;
	Mon, 14 Jun 2021 12:37:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5nbgXA-vDbVp; Mon, 14 Jun 2021 12:37:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A92CC400B5;
	Mon, 14 Jun 2021 12:37:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62151C000E;
	Mon, 14 Jun 2021 12:37:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 837BAC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 12:37:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 591B1402D6
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 12:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IlEU40tLUk4I for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 12:37:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8D7C400B5
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 12:37:41 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G3W9b42KPzZdp9;
 Mon, 14 Jun 2021 20:34:43 +0800 (CST)
Received: from dggema722-chm.china.huawei.com (10.3.20.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 14 Jun 2021 20:37:37 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggema722-chm.china.huawei.com (10.3.20.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 14 Jun 2021 20:37:36 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Mon, 14 Jun 2021 13:37:34 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v5 1/8] ACPI/IORT: Add support for RMR node parsing
Thread-Topic: [PATCH v5 1/8] ACPI/IORT: Add support for RMR node parsing
Thread-Index: AQHXUIxnG5hhFJByf0K0fNZqfWU2CasTaxEAgAAiFPA=
Date: Mon, 14 Jun 2021 12:37:34 +0000
Message-ID: <5634877440314121a8b0ed7cc238fb63@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-2-shameerali.kolothum.thodi@huawei.com>
 <15c7fac0-11a8-0cdb-aac3-b5d8feb8f066@arm.com>
In-Reply-To: <15c7fac0-11a8-0cdb-aac3-b5d8feb8f066@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.26.251]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>
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

Hi Robin,

> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: 14 June 2021 12:15
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
> joro@8bytes.org; wanghuiqiang <wanghuiqiang@huawei.com>; Guohanjun
> (Hanjun Guo) <guohanjun@huawei.com>; steven.price@arm.com;
> Sami.Mujawar@arm.com; jon@solid-run.com; eric.auger@redhat.com;
> yangyicong <yangyicong@huawei.com>
> Subject: Re: [PATCH v5 1/8] ACPI/IORT: Add support for RMR node parsing
> 
> On 2021-05-24 12:02, Shameer Kolothum wrote:
> > Add support for parsing RMR node information from ACPI.
> > Find associated stream id and smmu node info from the
> > RMR node and populate a linked list with RMR memory
> > descriptors.
> >
> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> > ---
> >   drivers/acpi/arm64/iort.c | 104
> +++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 103 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 3912a1f6058e..fea1ffaedf3b 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -40,6 +40,19 @@ struct iort_fwnode {
> >   static LIST_HEAD(iort_fwnode_list);
> >   static DEFINE_SPINLOCK(iort_fwnode_lock);
> >
> > +/*
> > + * One entry for IORT RMR.
> > + */
> > +struct iort_rmr_entry {
> > +	struct list_head list;
> > +	u32 sid;
> > +	struct acpi_iort_node *smmu;
> > +	struct acpi_iort_rmr_desc *rmr_desc;
> > +	u32 flags;
> > +};
> > +
> > +static LIST_HEAD(iort_rmr_list);         /* list of RMR regions from ACPI
> */
> > +
> >   /**
> >    * iort_set_fwnode() - Create iort_fwnode and use it to register
> >    *		       iommu data in the iort_fwnode_list
> > @@ -393,7 +406,8 @@ static struct acpi_iort_node
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
> > @@ -1660,6 +1674,91 @@ static void __init iort_enable_acs(struct
> acpi_iort_node *iort_node)
> >   #else
> >   static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
> >   #endif
> > +static int iort_rmr_desc_valid(struct acpi_iort_rmr_desc *desc, u32 count)
> > +{
> > +	int i, j;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		u64 end, start = desc[i].base_address, length = desc[i].length;
> > +
> > +		if (!IS_ALIGNED(start, SZ_64K) || !IS_ALIGNED(length, SZ_64K))
> > +			return -EINVAL;
> 
> We should certainly FW_BUG for this, but maybe it's OK to continue,
> since all we should need to do is round our iommu_resv_regions to at
> least PAGE_SIZE. That seems possibly better than ignoring them and
> having things potentially blow up later (especially if an end user
> exercises the system more thoroughly than the firmware developer tested
> it, which in at least one case I've seen may be "at all"...)

Ok. Will report FW_BUG but continue with a rounded addr/size.

> 
> > +		end = start + length - 1;
> > +
> > +		/* Check for address overlap */
> > +		for (j = i + 1; j < count; j++) {
> > +			u64 e_start = desc[j].base_address;
> > +			u64 e_end = e_start + desc[j].length - 1;
> > +
> > +			if (start <= e_end && end >= e_start)
> > +				return -EINVAL;
> 
> Similarly it's not *too* hard to trim overlaps; I guess it's really a
> question of whether we want to bother :/

I guess then, we can just report it and ignore,
   pr_warn(FW_BUG, "Found overlapping rmr desc @...., but ignoring...\n"

Thanks
Shameer

> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init iort_parse_rmr(struct acpi_iort_node *iort_node)
> > +{
> > +	struct acpi_iort_node *smmu;
> > +	struct iort_rmr_entry *e;
> > +	struct acpi_iort_rmr *rmr;
> > +	struct acpi_iort_rmr_desc *rmr_desc;
> > +	u32 map_count = iort_node->mapping_count;
> > +	u32  sid;
> 
> Nit: extra space.
> 
> > +	int i, ret = 0;
> > +
> > +	if (iort_node->type != ACPI_IORT_NODE_RMR)
> > +		return 0;
> > +
> > +	if (!iort_node->mapping_offset || map_count != 1) {
> 
> Beware that there was some discussion about allowing multiple SIDs to
> share an RMR descriptor, since there are potential use-cases which would
> otherwise lead to excessive duplication (e.g. an MSI doorbell carveout
> in a VM which would effectively apply to all possible PCI RIDs). I think
> the conclusion we reached was that disallowing that was fairly
> arbitrary, and could possibly be relaxed in future. It looks like the
> design of things here could grow to fit that fairly easily though, so I
> don't think it's a major concern.
> 
> Robin.
> 
> > +		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
> > +		       iort_node);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Retrieve associated smmu and stream id */
> > +	smmu = iort_node_get_id(iort_node, &sid, 0);
> > +	if (!smmu) {
> > +		pr_err(FW_BUG "Invalid SMMU reference, skipping RMR
> node %p\n",
> > +		       iort_node);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Retrieve RMR data */
> > +	rmr = (struct acpi_iort_rmr *)iort_node->node_data;
> > +	if (!rmr->rmr_offset || !rmr->rmr_count) {
> > +		pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR
> node %p\n",
> > +		       iort_node);
> > +		return -EINVAL;
> > +	}
> > +
> > +	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
> > +				rmr->rmr_offset);
> > +
> > +	ret = iort_rmr_desc_valid(rmr_desc, rmr->rmr_count);
> > +	if (ret) {
> > +		pr_err(FW_BUG "Invalid RMR descriptor[%d] for node %p,
> skipping...\n",
> > +		       i, iort_node);
> > +		return ret;
> > +	}
> > +
> > +	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
> > +		e = kmalloc(sizeof(*e), GFP_KERNEL);
> > +		if (!e)
> > +			return -ENOMEM;
> > +
> > +		e->sid = sid;
> > +		e->smmu = smmu;
> > +		e->rmr_desc = rmr_desc;
> > +		e->flags = rmr->flags;
> > +
> > +		list_add_tail(&e->list, &iort_rmr_list);
> > +	}
> > +
> > +	return 0;
> > +}
> >
> >   static void __init iort_init_platform_devices(void)
> >   {
> > @@ -1689,6 +1788,9 @@ static void __init iort_init_platform_devices(void)
> >
> >   		iort_enable_acs(iort_node);
> >
> > +		if (iort_table->revision == 3)
> > +			iort_parse_rmr(iort_node);
> > +
> >   		ops = iort_get_dev_cfg(iort_node);
> >   		if (ops) {
> >   			fwnode = acpi_alloc_fwnode_static();
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
