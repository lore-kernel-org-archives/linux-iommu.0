Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD09CC433FE
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 13:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C62B60B45;
	Tue, 25 Jan 2022 13:00:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ms6aObl4wVMY; Tue, 25 Jan 2022 13:00:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 28BBC607F9;
	Tue, 25 Jan 2022 13:00:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F27FBC0031;
	Tue, 25 Jan 2022 13:00:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6BA9C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 13:00:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B854E83F9C
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 13:00:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eJRgfk2_C2JG for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 13:00:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33AB382882
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 13:00:37 +0000 (UTC)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jjn140vWnz1FCtn;
 Tue, 25 Jan 2022 20:56:40 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 21:00:33 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 21:00:32 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Tue, 25 Jan 2022 13:00:30 +0000
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHXidEW6lbeFvKh4k2Spj/Qhyfs76x0tQKA
Date: Tue, 25 Jan 2022 13:00:30 +0000
Message-ID: <9da65c2504b944398188e468eac1abff@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.82.150]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "will@kernel.org" <will@kernel.org>,
 "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "steven.price@arm.com" <steven.price@arm.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>,
 "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
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

Hi Robin/Lorenzo,

> -----Original Message-----
> From: iommu [mailto:iommu-bounces@lists.linux-foundation.org] On Behalf
> Of Shameer Kolothum
> Sent: 05 August 2021 09:07
> To: linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: robin.murphy@arm.com; jon@solid-run.com; Linuxarm
> <linuxarm@huawei.com>; steven.price@arm.com; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; yangyicong <yangyicong@huawei.com>;
> Sami.Mujawar@arm.com; will@kernel.org; wanghuiqiang
> <wanghuiqiang@huawei.com>
> Subject: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
> 
> Hi,
> 
> The series adds support to IORT RMR nodes specified in IORT
> Revision E.b -ARM DEN 0049E[0]. RMR nodes are used to describe
> memory ranges that are used by endpoints and require a unity
> mapping in SMMU.
> 
> We have faced issues with 3408iMR RAID controller cards which
> fail to boot when SMMU is enabled. This is because these
> controllers make use of host memory for various caching related
> purposes and when SMMU is enabled the iMR firmware fails to
> access these memory regions as there is no mapping for them.
> IORT RMR provides a way for UEFI to describe and report these
> memory regions so that the kernel can make a unity mapping for
> these in SMMU.
> 
> Change History:
> 
> v6 --> v7
> 
> The only change from v6 is the fix pointed out by Steve to
> the SMMUv2 SMR bypass install in patch #8.
> 
> Thanks to the Tested-by tags by Laurentiu with SMMUv2 and
> Hanjun/Huiqiang with SMMUv3 for v6. I haven't added the tags
> yet as the series still needs more review[1].
> 
> Feedback and tests on this series is very much appreciated.

Since we have an update to IORT spec(E.c) now[1] and includes additional
attributes/flags for the RMR node, I am planning to respin this series soon.

Going through the new spec, I have a few queries,

The memory range attributes can now be described as one of the following,

0x00: Device-nGnRnE memory
0x01: Device-nGnRE memory
0x02: Device-nGRE memory
0x03: Device-GRE memory
0x04: Normal Inner Non-cacheable Outer Non-cacheable
0x05: Normal Inner Write-back Outer Write-back Inner Shareable

I am not sure how this needs to be captured and used in the kernel. Is there
any intention of using these fine-grained attributes in the kernel now
or a generic mapping of the above to the struct iommu_rev_region prot field
is enough? i.e., something like,

{
    ....
    prot = IOMMU_READ | IOMMU_WRITE;

    if (rmr_attr == normal_mem) // 0x05
        prot |= IOMMU_CACHE;
    
    if (rmr_attr == device_mem) { //0x00 - 0x03
        prot |= IOMMU_MMIO;
        prot |= IOMMU_NOEXEC;
    }
    ....
}

Similarly for the 'flags' field, the new 'Access Privilege' is intended to set the
IOMMU_PRIV ?
  
Please let me know.

Thanks,
Shameer

[1] https://developer.arm.com/documentation/den0049/ec/?lang=en

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
