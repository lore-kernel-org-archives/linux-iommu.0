Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C76CCA481
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 16:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2580460B8B;
	Fri,  1 Jul 2022 16:43:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2580460B8B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ftY-UfHIcV0P; Fri,  1 Jul 2022 16:43:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E5E1360B70;
	Fri,  1 Jul 2022 16:43:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E5E1360B70
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6D46C0032;
	Fri,  1 Jul 2022 16:43:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10991C002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 16:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8D928470E
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 16:43:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8D928470E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PyspCg__9s0e for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 16:43:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7BC5E84706
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7BC5E84706
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 16:43:12 +0000 (UTC)
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4LZLb26StgzTwLq;
 Sat,  2 Jul 2022 00:42:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 2 Jul 2022 00:43:05 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2375.024; Fri, 1 Jul 2022 17:43:04 +0100
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, 
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYgKBK6ZkZvzZxLEqm8BkaLnkVo61TfSMAgAs//6CABHLxAIABViUAgAVKlWA=
Date: Fri, 1 Jul 2022 16:43:03 +0000
Message-ID: <9bcec024bba444caa0f60d37afd88b6b@huawei.com>
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
 <03b03d88-87cd-0b29-863b-2cb2a9a117d1@arm.com>
 <44338c87254d4d439d29694de8f19435@huawei.com>
 <ff579ecb-9a37-09ef-a975-cf1e25ab731e@arm.com> 
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.169.16]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "lorenzo.pieralisi@gmail.com" <lorenzo.pieralisi@gmail.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 Steven Price <steven.price@arm.com>, "hch@infradead.org" <hch@infradead.org>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
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
From: Shameerali Kolothum Thodi via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: Shameerali Kolothum Thodi
> Sent: 28 June 2022 09:00
> To: 'Robin Murphy' <robin.murphy@arm.com>; joro@8bytes.org;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
> hch@infradead.org; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> Sami.Mujawar@arm.com; will@kernel.org; wanghuiqiang
> <wanghuiqiang@huawei.com>; lpieralisi@kernel.org; Steven Price
> <steven.price@arm.com>; lorenzo.pieralisi@gmail.com
> Subject: RE: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
> > > Hi Will/Robin,
> > >
> > > Appreciate, if you could please take a look at the remaining SMMU
> > > related
> > > patches(7-9) and provide your approval?
> >
> > I said v12 looked fine, but for the avoidance of doubt, here it is
> > again, as formally as can be:
> >
> > Acked-by: Robin Murphy <robin.murphy@arm.com>
> 
> Thanks Robin.
> 
> Hi Joerg,
> 
> Now that we have all the required acks, could you please pick this series via
> IOMMU tree?

Hi Will,

Since Joerg hasn't replied yet, just wondering could you please take it through ARM
SMMU tree if that makes sense? Don't want to miss the 5.20 merge window for this
series.

Thanks,
Shameer


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
