Return-Path: <SRS0=vqUx=OG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8F4C433F5
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 08:26:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2E36113E
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 08:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F2E36113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4B2F40755;
	Thu, 16 Sep 2021 08:26:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PjrCDjuOFcPZ; Thu, 16 Sep 2021 08:26:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 959CA406DF;
	Thu, 16 Sep 2021 08:26:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C3EBC0011;
	Thu, 16 Sep 2021 08:26:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3FD4C000D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 08:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFD67406E2
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 08:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wgyMLnGbl2YC for <iommu@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 08:26:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07C14406DF
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 08:26:21 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H996q084QzbmXv;
 Thu, 16 Sep 2021 16:22:11 +0800 (CST)
Received: from dggpemm100004.china.huawei.com (7.185.36.189) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 16:26:17 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggpemm100004.china.huawei.com (7.185.36.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 16 Sep 2021 16:26:16 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2308.008; Thu, 16 Sep 2021 09:26:14 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jon Nettleton <jon@solid-run.com>
Subject: RE: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
Thread-Topic: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
Thread-Index: AQHXidEiKr58723PTUGGkSglF1QKPatlAmqAgDJmwoCAACN+gIAO55oggAAG1QCAABhrQA==
Date: Thu, 16 Sep 2021 08:26:14 +0000
Message-ID: <e02a00a10ea3440dab1f9f9320de42ad@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <20210805160319.GB23085@lpieralisi>
 <5d9bebdf-6eb5-49a0-2e8f-490df2d6754d@arm.com>
 <CABdtJHt-18TDHBFq1X89=qngUbopGoFnqjuXiBOPtZG58vy3sg@mail.gmail.com>
 <f3fc713365f7465e966aaed7cdd8870a@huawei.com>
 <CABdtJHuEViN0MSz-ZJhR52+b=F6yvQ5mm_edVuLy1B=nHp+ESQ@mail.gmail.com>
In-Reply-To: <CABdtJHuEViN0MSz-ZJhR52+b=F6yvQ5mm_edVuLy1B=nHp+ESQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.83.177]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Will Deacon <will@kernel.org>, Steven Price <steven.price@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>, "Guohanjun
 \(Hanjun Guo\)" <guohanjun@huawei.com>, yangyicong <yangyicong@huawei.com>,
 Sami Mujawar <Sami.Mujawar@arm.com>, Robin Murphy <robin.murphy@arm.com>,
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
> From: Jon Nettleton [mailto:jon@solid-run.com]
> Sent: 16 September 2021 08:52
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: Robin Murphy <robin.murphy@arm.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>; Laurentiu Tudor <laurentiu.tudor@nxp.com>;
> linux-arm-kernel <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling
> List <linux-acpi@vger.kernel.org>; Linux IOMMU
> <iommu@lists.linux-foundation.org>; Joerg Roedel <joro@8bytes.org>; Will
> Deacon <will@kernel.org>; wanghuiqiang <wanghuiqiang@huawei.com>;
> Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; Steven Price
> <steven.price@arm.com>; Sami Mujawar <Sami.Mujawar@arm.com>; Eric
> Auger <eric.auger@redhat.com>; yangyicong <yangyicong@huawei.com>
> Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
> 
> On Thu, Sep 16, 2021 at 9:26 AM Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Jon Nettleton [mailto:jon@solid-run.com]
> > > Sent: 06 September 2021 20:51
> > > To: Robin Murphy <robin.murphy@arm.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Shameerali
> > > Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>; Laurentiu
> > > Tudor <laurentiu.tudor@nxp.com>; linux-arm-kernel
> > > <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling List
> > > <linux-acpi@vger.kernel.org>; Linux IOMMU
> > > <iommu@lists.linux-foundation.org>; Linuxarm <linuxarm@huawei.com>;
> > > Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>;
> > > wanghuiqiang <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> > > <guohanjun@huawei.com>; Steven Price <steven.price@arm.com>; Sami
> > > Mujawar <Sami.Mujawar@arm.com>; Eric Auger
> <eric.auger@redhat.com>;
> > > yangyicong <yangyicong@huawei.com>
> > > Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node
> > > parsing
> > >
> > [...]
> >
> > > > >
> > > > > On the prot value assignment based on the remapping flag, I'd
> > > > > like to hear Robin/Joerg's opinion, I'd avoid being in a
> > > > > situation where "normally" this would work but then we have to quirk
> it.
> > > > >
> > > > > Is this a valid assumption _always_ ?
> > > >
> > > > No. Certainly applying IOMMU_CACHE without reference to the
> > > > device's _CCA attribute or how CPUs may be accessing a shared
> > > > buffer could lead to a loss of coherency. At worst, applying
> > > > IOMMU_MMIO to a device-private buffer *could* cause the device to
> > > > lose coherency with itself if the memory underlying the RMR may
> > > > have allocated into system caches. Note that the expected use for
> > > > non-remappable RMRs is the device holding some sort of long-lived
> > > > private data in system RAM - the MSI doorbell trick is far more of a niche
> hack really.
> > > >
> > > > At the very least I think we need to refer to the device's memory
> > > > access properties here.
> > > >
> > > > Jon, Laurentiu - how do RMRs correspond to the EFI memory map on
> > > > your firmware? I'm starting to think that as long as the
> > > > underlying memory is described appropriately there then we should
> > > > be able to infer correct attributes from the EFI memory type and flags.
> > >
> > > The devices are all cache coherent and marked as _CCA, 1.  The
> > > Memory regions are in the virt table as
> ARM_MEMORY_REGION_ATTRIBUTE_DEVICE.
> > >
> > > The current chicken and egg problem we have is that during the
> > > fsl-mc-bus initialization we call
> > >
> > > error = acpi_dma_configure_id(&pdev->dev, DEV_DMA_COHERENT,
> > >                                               &mc_stream_id);
> > >
> > > which gets deferred because the SMMU has not been initialized yet.
> > > Then we initialize the RMR tables but there is no device reference
> > > there to be able to query device properties, only the stream id.
> > > After the IORT tables are parsed and the SMMU is setup, on the
> > > second device probe we associate everything based on the stream id
> > > and the fsl-mc-bus device is able to claim its 1-1 DMA mappings.
> >
> > Can we solve this order problem by delaying the
> > iommu_alloc_resv_region() to the iommu_dma_get_rmr_resv_regions(dev,
> > list) ? We could invoke
> > device_get_dma_attr() from there which I believe will return the _CCA
> attribute.
> >
> > Or is that still early to invoke that?
> 
> That looks like it should work. Do we then also need to parse through the
> VirtualMemoryTable matching the start and end addresses to determine the
> other memory attributes like MMIO?

Yes. But that looks tricky as I can't find that readily available on Arm, like the
efi_mem_attributes(). I will take a look.

Please let me know if there is one or any other easy way to retrieve it.

Thanks,
Shameer

> 
> -Jon
> 
> >
> > Thanks,
> > Shameer
> >
> > > cat /sys/kernel/iommu_groups/0/reserved_regions
> > > 0x0000000001000000 0x0000000010ffffff direct-relaxable
> > > 0x0000000008000000 0x00000000080fffff msi
> > > 0x000000080c000000 0x000000081bffffff direct-relaxable
> > > 0x0000001c00000000 0x0000001c001fffff direct-relaxable
> > > 0x0000002080000000 0x000000209fffffff direct-relaxable
> > >
> > > -Jon
> > >
> > > >
> > > > Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
