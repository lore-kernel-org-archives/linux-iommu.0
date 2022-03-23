Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8994BC433EF
	for <iommu@archiver.kernel.org>; Wed, 23 Mar 2022 16:06:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 370A441BAC;
	Wed, 23 Mar 2022 16:06:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yGT5aoDWRXnE; Wed, 23 Mar 2022 16:06:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E5C80418E0;
	Wed, 23 Mar 2022 16:06:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7CCAC0012;
	Wed, 23 Mar 2022 16:06:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45B38C000B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 16:06:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2AEC641BAC
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 16:06:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IhW1c41hAF7g for <iommu@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 16:06:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89891418E0
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 16:06:11 +0000 (UTC)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KNtTZ0w8TzfZWm;
 Thu, 24 Mar 2022 00:04:34 +0800 (CST)
Received: from dggpemm100005.china.huawei.com (7.185.36.231) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 00:06:07 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100005.china.huawei.com (7.185.36.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 00:06:06 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Wed, 23 Mar 2022 16:06:04 +0000
To: Robin Murphy <robin.murphy@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v8 05/11] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Thread-Topic: [PATCH v8 05/11] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Thread-Index: AQHYJzoHyQwMkRcbbE6vVIIVTT4JpazL8g2AgAFXK+A=
Date: Wed, 23 Mar 2022 16:06:04 +0000
Message-ID: <ad7ae652a2b54261a522008a25238039@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-6-shameerali.kolothum.thodi@huawei.com>
 <479ae561-e03e-163e-f945-d0c8fdf8dcea@arm.com>
In-Reply-To: <479ae561-e03e-163e-f945-d0c8fdf8dcea@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
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
From: Shameerali Kolothum Thodi via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: 22 March 2022 19:09
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
> steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
> will@kernel.org; wanghuiqiang <wanghuiqiang@huawei.com>
> Subject: Re: [PATCH v8 05/11] ACPI/IORT: Add a helper to retrieve RMR
> memory regions
> 
> On 2022-02-21 15:43, Shameer Kolothum via iommu wrote:
> > Add helper functions (iort_iommu_get/put_rmrs()) that
> > retrieves/releases RMR memory descriptors associated
> > with a given IOMMU. This will be used by IOMMU drivers
> > to set up necessary mappings.
> >
> > Invoke it from the generic iommu helper functions.
> 
> iommu_dma_get_resv_regions() already exists - please extend that rather
> than adding a parallel implementation of the same thing but different.
> IORT should export a single get_resv_regions helper which combines the
> new RMRs with the existing MSI workaround, and a separate "do I need to
> bypass this StreamID" helper for the SMMU drivers to call directly at
> reset time, since the latter isn't really an iommu-dma responsibility.

Right. I actually had couple of back and forth on the interfaces and settled
on this mainly because it just requires a single interface from IORT for both
get_resv_regions() and SMMU driver reset bypass path.
ie, iort_iommu_get/put_rmrs()).

But agree the above comment is also valid. 

> I'm happy to do that just by shuffling wrappers around for now - we can
> come back and streamline the code properly afterwards - but the sheer
> amount of indirection currently at play here is so hard to follow that
> it's not even all that easy to see how it's crossing abstraction levels
> improperly.

Please find below the revised ones. Please take a look and let me know.

Thanks,
Shameer

iommu-dma:

void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list) {

        if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
                iort_iommu_get_resv_regions(dev, list);
}

void iommu_dma_put_resv_regions(struct device *dev, struct list_head *list) {

        if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
                iort_iommu_put_resv_regions(dev, list);
        generic_iommu_put_resv_regions(dev, list);
}

iort:

void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head) {
        struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);

        iort_iommu_msi_get_resv_regions(dev, head);
        iort_iommu_get_rmrs(fwspec->iommu_fwnode, dev, head);
}

void iort_iommu_put_resv_regions(struct device *dev, struct list_head *head) {
   ./*Free both RMRs and HW MSI ones */
}

/* The below ones will be directly called from SMMU drivers during reset */
void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) {
        iort_iommu_get_rmrs(iommu_fwnode, NULL, head); }
}

void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) {
        iort_iommu_put_resv_regions(NULL, head);
}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
