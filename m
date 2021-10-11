Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317CFC433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 15:42:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC95760E9C
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 15:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC95760E9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95CFD4015F;
	Mon, 11 Oct 2021 15:42:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D8Rh61w4FllZ; Mon, 11 Oct 2021 15:42:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2597140100;
	Mon, 11 Oct 2021 15:42:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F106DC000F;
	Mon, 11 Oct 2021 15:42:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73A6EC000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 15:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 615B34015F
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 15:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 60Qt6R300hoZ for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 15:42:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E7E040100
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 15:42:23 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HSjgr6NBGz8tYr;
 Mon, 11 Oct 2021 23:41:12 +0800 (CST)
Received: from dggpemm100006.china.huawei.com (7.185.36.196) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 23:42:17 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100006.china.huawei.com (7.185.36.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 23:42:16 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.008; Mon, 11 Oct 2021 16:42:14 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, Jon Nettleton <jon@solid-run.com>
Subject: RE: [PATCH v7 9/9] iommu/dma: Reserve any RMR regions associated with
 a dev
Thread-Topic: [PATCH v7 9/9] iommu/dma: Reserve any RMR regions associated
 with a dev
Thread-Index: AQHXidFJPtitnW05ZU6HeLs3tvFT7qvJZyyAgAEtMACAA6jKAIAAG4sQ
Date: Mon, 11 Oct 2021 15:42:14 +0000
Message-ID: <9a84c9d20094403ea5aea53d6f6c304f@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-10-shameerali.kolothum.thodi@huawei.com>
 <44e00e32-be89-1174-beb5-9a2fca85a683@arm.com>
 <CABdtJHv+SZ15RcBaFt0w4iTsMMbAjGB2Wm4GST3cNw+2Q=OeVw@mail.gmail.com>
 <706e2dc8-37af-2344-0d99-6da1f27ba0fb@arm.com>
In-Reply-To: <706e2dc8-37af-2344-0d99-6da1f27ba0fb@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.25.32]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Linuxarm <linuxarm@huawei.com>, Steven Price <steven.price@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>, "Guohanjun
 \(Hanjun Guo\)" <guohanjun@huawei.com>, yangyicong <yangyicong@huawei.com>,
 Sami Mujawar <Sami.Mujawar@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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
> Sent: 11 October 2021 16:01
> To: Jon Nettleton <jon@solid-run.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> linux-arm-kernel <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling
> List <linux-acpi@vger.kernel.org>; Linux IOMMU
> <iommu@lists.linux-foundation.org>; Linuxarm <linuxarm@huawei.com>;
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Joerg Roedel
> <joro@8bytes.org>; Will Deacon <will@kernel.org>; wanghuiqiang
> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> <guohanjun@huawei.com>; Steven Price <steven.price@arm.com>; Sami
> Mujawar <Sami.Mujawar@arm.com>; Eric Auger <eric.auger@redhat.com>;
> yangyicong <yangyicong@huawei.com>
> Subject: Re: [PATCH v7 9/9] iommu/dma: Reserve any RMR regions associated
> with a dev
> 
> On 2021-10-09 08:07, Jon Nettleton wrote:
> > On Fri, Oct 8, 2021 at 3:10 PM Robin Murphy <robin.murphy@arm.com>
> wrote:
> >>
> >> On 2021-08-05 09:07, Shameer Kolothum wrote:
> >>> Get ACPI IORT RMR regions associated with a dev reserved
> >>> so that there is a unity mapping for them in SMMU.
> >>
> >> This feels like most of it belongs in the IORT code rather than
> >> iommu-dma (which should save the temporary list copy as well).
> >
> > See previous comment.  The original intent was for device-tree to also
> > be able to use these mechanisms to create RMR's and support them
> > in the SMMU.
> 
> Can you clarify how code behind an "if (!is_of_node(...))" check
> alongside other IORT-specific code is expected to be useful for DT?
> 
> Yes, iommu_dma_get_resv_regions() itself wants to end up serving as an
> abstraction layer, but that still doesn't mean it has to do much more
> than dispatch into firmware-specific backends as appropriate.

(Resending as I accidently replied earlier from our internal ML id. Sorry)

The way I thought about is as below,

1.  iommu_dma_get_resv_regions() will invoke the common iommu_dma_get_rmr_resv_regions().
    Yes, the if (!is_of_node(...)) is not required here.
2.  iommu_dma_get_rmr_resv_regions() calls iommu_dma_get_rmrs().
    iommu_dma_get_rmrs() has the  (!is_of_node(...)) check to call into IORT or DT specific functions
    to retrieve the RMR reserve regions associated with a given iommu_fwnode.
3.  The common iommu_dma_get_rmr_resv_regions() further checks for PCI host preserve_config
    and whether the returned RMR list actually has any dev specific region to reserve or not.

So the only firmware specific backend is handled inside the iommu_dma_get_rmrs() and that is also called
from the SMMU driver probe to install bypass SIDs.

Anyway, if the eventual DT implementation or further IORT spec changes makes this abstraction
irrelevant I am Ok to move this into the IORT code.

Thanks,
Shameer
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
