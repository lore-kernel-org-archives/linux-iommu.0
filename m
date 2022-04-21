Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5C3C433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 14:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5499460BBF;
	Thu, 21 Apr 2022 14:50:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id agGM2ugWTpkS; Thu, 21 Apr 2022 14:50:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3E3D560D6D;
	Thu, 21 Apr 2022 14:50:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12F4AC0033;
	Thu, 21 Apr 2022 14:50:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78027C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 14:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6335460D6D
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 14:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id twSPnb_NFWHK for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 14:50:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D8BF260B9C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 14:50:11 +0000 (UTC)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KkgRP36DQz1J9qw;
 Thu, 21 Apr 2022 22:49:21 +0800 (CST)
Received: from dggpemm100005.china.huawei.com (7.185.36.231) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 22:50:07 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100005.china.huawei.com (7.185.36.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 22:50:06 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Thu, 21 Apr 2022 15:50:04 +0100
To: Christoph Hellwig <hch@infradead.org>
Subject: RE: [PATCH v10 4/9] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Thread-Topic: [PATCH v10 4/9] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Thread-Index: AQHYVNbBiFMGcGX7Dk+uLBP0wkUUHKz53S4AgACVfEA=
Date: Thu, 21 Apr 2022 14:50:03 +0000
Message-ID: <54f289c1cfc5401a978a29dc6ff2cea7@huawei.com>
References: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
 <20220420164836.1181-5-shameerali.kolothum.thodi@huawei.com>
 <YmD+Puk4xfPpwED9@infradead.org>
In-Reply-To: <YmD+Puk4xfPpwED9@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "will@kernel.org" <will@kernel.org>,
 "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: 21 April 2022 07:49
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>;
> lorenzo.pieralisi@arm.com; joro@8bytes.org; robin.murphy@arm.com;
> will@kernel.org; wanghuiqiang <wanghuiqiang@huawei.com>; Guohanjun
> (Hanjun Guo) <guohanjun@huawei.com>; steven.price@arm.com;
> Sami.Mujawar@arm.com; jon@solid-run.com; eric.auger@redhat.com;
> laurentiu.tudor@nxp.com; hch@infradead.org
> Subject: Re: [PATCH v10 4/9] ACPI/IORT: Add support to retrieve IORT RMR
> reserved regions
> 
[...]

> >  void generic_iommu_put_resv_regions(struct device *dev, struct list_head
> *list)
> >  {
> >  	struct iommu_resv_region *entry, *next;
> >
> > -	list_for_each_entry_safe(entry, next, list, list)
> > +	list_for_each_entry_safe(entry, next, list, list) {
> > +		if (entry->resv_region_free_fw_data)
> > +			entry->resv_region_free_fw_data(dev, entry);
> >  		kfree(entry);
> 
> I'd move the kfree to the free callback if present.  This would also
> allow to hide the union from the common code entirely and use a
> container structure like:
> 
> struct iommu_iort_rmr_data {
> 	struct iommu_resv_region rr;
> 
> 	/* Stream IDs associated with IORT RMR entry */
> 	const u32 *sids;
> 	u32 num_sids;
> };

Ok. I will respin soon with the above changes.

Thanks,
Shameer 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
