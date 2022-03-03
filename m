Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970D1C433EF
	for <iommu@archiver.kernel.org>; Thu,  3 Mar 2022 13:02:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E65783F68;
	Thu,  3 Mar 2022 13:02:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IiS8KDUwl57Z; Thu,  3 Mar 2022 13:02:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9A52683EDD;
	Thu,  3 Mar 2022 13:02:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C4E1C0082;
	Thu,  3 Mar 2022 13:02:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AD9EC000B
 for <iommu@lists.linux-foundation.org>; Thu,  3 Mar 2022 13:02:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 45C4E83F68
 for <iommu@lists.linux-foundation.org>; Thu,  3 Mar 2022 13:02:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S9hunkrsU3EC for <iommu@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 13:02:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4C8183EDD
 for <iommu@lists.linux-foundation.org>; Thu,  3 Mar 2022 13:02:20 +0000 (UTC)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K8WLL2JXZzBrbT;
 Thu,  3 Mar 2022 21:00:26 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 21:02:16 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 21:02:15 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.021; Thu, 3 Mar 2022 13:02:13 +0000
To: Steven Price <steven.price@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
Thread-Topic: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
Thread-Index: AQHYJznkm20llCW58kat42rWyx2T0aythveAgAAnagA=
Date: Thu, 3 Mar 2022 13:02:13 +0000
Message-ID: <f62c9542a9ab46cab0ef26919a47e8b9@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <dc755b11-ece7-4028-b153-cc8b9301099c@arm.com>
In-Reply-To: <dc755b11-ece7-4028-b153-cc8b9301099c@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.82.4]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "jon@solid-run.com" <jon@solid-run.com>, Linuxarm <linuxarm@huawei.com>,
 "Guohanjun \(Hanjun
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
> From: Steven Price [mailto:steven.price@arm.com]
> Sent: 03 March 2022 10:38
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> iommu@lists.linux-foundation.org
> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
> joro@8bytes.org; robin.murphy@arm.com; will@kernel.org; wanghuiqiang
> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; Sami.Mujawar@arm.com; jon@solid-run.com;
> eric.auger@redhat.com; yangyicong <yangyicong@huawei.com>
> Subject: Re: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
> 
> On 21/02/2022 15:43, Shameer Kolothum wrote:
> > Hi,
> >
> > Since we now have an updated verion[0] of IORT spec(E.d) which
> > addresses the memory attributes issues discussed here [1],
> > this series now make use of it.
> >
> > The pull request for ACPICA E.d related changes are already
> > raised and can be found here,
> > https://github.com/acpica/acpica/pull/752
> >
> > v7 --> v8
> >   - Patch #1 has temp definitions for RMR related changes till
> >     the ACPICA header changes are part of kernel.
> >   - No early parsing of RMR node info and is only parsed at the
> >     time of use.
> >   - Changes to the RMR get/put API format compared to the
> >     previous version.
> >   - Support for RMR descriptor shared by multiple stream IDs.
> >
> > Please take a look and let me know your thoughts.
> 
> Hi Shameer,
> 
> I've now been able to test this on the Juno platform with a modified
> firmware supporting the newer spec (thanks Sami!). Everything works, so
> feel free to add my:
> 
> Tested-by: Steven Price <steven.price@arm.com>
> 
> (Note that I haven't tested the smmu-v3 support)

Thanks Steve, for giving it a spin and verifying.

Cheers,
Shameer
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
