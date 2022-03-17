Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6801C433F5
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 15:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85DF0847BA;
	Thu, 17 Mar 2022 15:31:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id otLI7NqWOB4J; Thu, 17 Mar 2022 15:31:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 656FA847BB;
	Thu, 17 Mar 2022 15:31:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 386E4C001A;
	Thu, 17 Mar 2022 15:31:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C03AC000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 15:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ECDAF40151
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 15:31:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G9cZwVWDQqfm for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 15:30:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56F574012D
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 15:30:58 +0000 (UTC)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KK9x45Xqqz9sj3;
 Thu, 17 Mar 2022 23:27:04 +0800 (CST)
Received: from dggpemm100002.china.huawei.com (7.185.36.179) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 23:30:54 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 23:30:53 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Thu, 17 Mar 2022 15:30:51 +0000
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYJznkm20llCW58kat42rWyx2T0azA3K4AgAL7+yA=
Date: Thu, 17 Mar 2022 15:30:51 +0000
Message-ID: <dcc862048c624e109afbc7309f01c59d@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <640df5d4-e2f6-aa24-6b60-9cfaf3915060@redhat.com>
In-Reply-To: <640df5d4-e2f6-aa24-6b60-9cfaf3915060@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.178]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>, "Guohanjun \(Hanjun
 Guo\)" <guohanjun@huawei.com>, yangyicong <yangyicong@huawei.com>,
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
> From: Eric Auger [mailto:eric.auger@redhat.com]
> Sent: 15 March 2022 17:53
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
> joro@8bytes.org; robin.murphy@arm.com; will@kernel.org; wanghuiqiang
> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; steven.price@arm.com; Sami.Mujawar@arm.com;
> jon@solid-run.com; yangyicong <yangyicong@huawei.com>
> Subject: Re: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
> 
> Hi Shameer,

[...]

> >
> > Jon Nettleton (1):
> >   iommu/arm-smmu: Get associated RMR info and install bypass SMR
> >
> > Shameer Kolothum (10):
> >   ACPI/IORT: Add temporary RMR node flag definitions
> >   iommu: Introduce a union to struct iommu_resv_region
> >   ACPI/IORT: Add helper functions to parse RMR nodes
> >   iommu/dma: Introduce generic helper to retrieve RMR info
> >   ACPI/IORT: Add a helper to retrieve RMR memory regions
> >   iommu/arm-smmu-v3: Introduce strtab init helper
> >   iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
> >     bypass
> >   iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
> >   iommu/arm-smmu-v3: Reserve any RMR regions associated with a dev
> >   iommu/arm-smmu: Reserve any RMR regions associated with a dev
> fyi, the last 2 patches have conflicts with
> [PATCH v4 9/9] iommu: Split struct iommu_ops
> which was applied on core branch.

Hi Eric,

Thanks for the heads up. I am going to respin this series soon.

All,

Please let me know if there are any further comments on this series.

Thanks,
Shameer
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
