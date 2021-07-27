Return-Path: <SRS0=amFV=MT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E3CC4338F
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 06:52:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3089A6112D
	for <iommu@archiver.kernel.org>; Tue, 27 Jul 2021 06:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3089A6112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4405605EB;
	Tue, 27 Jul 2021 06:52:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kQloP9N_1u5x; Tue, 27 Jul 2021 06:52:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D13A7605B0;
	Tue, 27 Jul 2021 06:52:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6EBEC001A;
	Tue, 27 Jul 2021 06:52:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C149FC000E
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 06:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A66E5400CA
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 06:52:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yx2wxSr-GFUz for <iommu@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 06:52:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7E9F400A8
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 06:52:06 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GYnS01DHQz80CB;
 Tue, 27 Jul 2021 14:48:16 +0800 (CST)
Received: from dggpemm500003.china.huawei.com (7.185.36.56) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 14:52:00 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 14:51:58 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2176.012; Tue, 27 Jul 2021 07:51:56 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v6 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v6 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHXeh1vg51cV9IdVUizwG8vunPk8atKQ7KAgAwuDYA=
Date: Tue, 27 Jul 2021 06:51:56 +0000
Message-ID: <014a451d00304b80b3de700817d688de@huawei.com>
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
 <35db3320-d6e2-721e-8d49-e5e2e80e2359@nxp.com>
In-Reply-To: <35db3320-d6e2-721e-8d49-e5e2e80e2359@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.92.57]
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


> -----Original Message-----
> From: Laurentiu Tudor [mailto:laurentiu.tudor@nxp.com]
> Sent: 19 July 2021 14:46
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
> steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
> robin.murphy@arm.com; wanghuiqiang <wanghuiqiang@huawei.com>
> Subject: Re: [PATCH v6 0/9] ACPI/IORT: Support for IORT RMR node
> 
> On 7/16/2021 11:34 AM, Shameer Kolothum wrote:
> > Hi,
> >
> > Major Changes from v5:
> > - Addressed comments from Robin & Lorenzo.
> >   : Moved iort_parse_rmr() to acpi_iort_init() from
> >     iort_init_platform_devices().
> >   : Removed use of struct iort_rmr_entry during the initial
> >     parse. Using struct iommu_resv_region instead.
> >   : Report RMR address alignment and overlap errors, but continue.
> >   : Reworked arm_smmu_init_bypass_stes() (patch # 6).
> > - Updated SMMUv2 bypass SMR code. Thanks to Jon N (patch #8).
> > - Set IOMMU protection flags(IOMMU_CACHE, IOMMU_MMIO) based
> >   on Type of RMR region. Suggested by Jon N.

[...]

> >
> Validated on a NXP LX2160A with SMMUv2, so:
> 
> Tested-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 

Thanks for testing.

Hi All,

A gentle ping on this...

I am planning to respin this with the fix suggested by Steve in
patch #8 for SMMUv2. But would wait till other patches get a
proper review so that I can include those comments as well if
any.

Thanks,
Shameer
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
