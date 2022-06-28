Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DDDC43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 07:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF6736072A;
	Tue, 28 Jun 2022 07:59:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF6736072A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6RhTy6udaiYj; Tue, 28 Jun 2022 07:59:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A8925606C0;
	Tue, 28 Jun 2022 07:59:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8925606C0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C28AC007C;
	Tue, 28 Jun 2022 07:59:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C757C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36434416CE
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:59:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36434416CE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eYDQvCS7smZM for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 07:59:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B879D4167F
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B879D4167F
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:59:46 +0000 (UTC)
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4LXH6Z2Y0wzTsLd;
 Tue, 28 Jun 2022 15:59:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 15:59:41 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Tue, 28 Jun 2022 08:59:39 +0100
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, 
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYgKBK6ZkZvzZxLEqm8BkaLnkVo61TfSMAgAs//6CABHLxAIABViUA
Date: Tue, 28 Jun 2022 07:59:39 +0000
Message-ID: <26bbc80ddc7b4260b0d345913ed5ba1b@huawei.com>
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
 <03b03d88-87cd-0b29-863b-2cb2a9a117d1@arm.com>
 <44338c87254d4d439d29694de8f19435@huawei.com>
 <ff579ecb-9a37-09ef-a975-cf1e25ab731e@arm.com>
In-Reply-To: <ff579ecb-9a37-09ef-a975-cf1e25ab731e@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "lorenzo.pieralisi@gmail.com" <lorenzo.pieralisi@gmail.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 Steven Price <steven.price@arm.com>, "hch@infradead.org" <hch@infradead.org>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
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
> Sent: 27 June 2022 13:26
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> Steven Price <steven.price@arm.com>; linux-arm-kernel@lists.infradead.org;
> linux-acpi@vger.kernel.org; iommu@lists.linux-foundation.org
> Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
> hch@infradead.org; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> Sami.Mujawar@arm.com; will@kernel.org; wanghuiqiang
> <wanghuiqiang@huawei.com>; lpieralisi@kernel.org
> Subject: Re: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
> 
> On 2022-06-24 16:44, Shameerali Kolothum Thodi via iommu wrote:
> >
> >
> >> -----Original Message-----
> >> From: Steven Price [mailto:steven.price@arm.com]
> >> Sent: 17 June 2022 13:42
> >> To: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>;
> >> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> >> iommu@lists.linux-foundation.org
> >> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
> >> joro@8bytes.org; robin.murphy@arm.com; will@kernel.org;
> wanghuiqiang
> >> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> >> <guohanjun@huawei.com>; Sami.Mujawar@arm.com;
> jon@solid-run.com;
> >> eric.auger@redhat.com; laurentiu.tudor@nxp.com; hch@infradead.org
> >> Subject: Re: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
> >>
> >> On 15/06/2022 11:10, Shameer Kolothum wrote:
> >>> Hi
> >>>
> >>> v12 --> v13
> >>>    -No changes. Rebased to 5.19-rc1.
> >>>    -Picked up tags received from Laurentiu, Hanjun and Will. Thanks!.
> >>
> >> You've already got my Tested-by tags, but just to confirm I gave this a
> >> spin and it works fine.
> >
> > Thanks Steve.
> >
> > I think the series is now in a good shape to be merged.
> >
> > Hi Will/Robin,
> >
> > Appreciate, if you could please take a look at the remaining SMMU related
> > patches(7-9) and provide your approval?
> 
> I said v12 looked fine, but for the avoidance of doubt, here it is
> again, as formally as can be:
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Thanks Robin.

Hi Joerg,

Now that we have all the required acks, could you please pick this series via
IOMMU tree?

Thanks,
Shameer
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
