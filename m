Return-Path: <SRS0=vqUx=OG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FABC433F5
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 11:17:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD72161130
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 11:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD72161130
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B53C834B9;
	Thu, 16 Sep 2021 11:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FgV70Hy3xtAS; Thu, 16 Sep 2021 11:17:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 34853834C6;
	Thu, 16 Sep 2021 11:17:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01F16C0011;
	Thu, 16 Sep 2021 11:17:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EDFEC000D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 11:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 447AB613C2
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 11:17:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id orpxAtMp26YE for <iommu@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 11:17:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 437CD606EF
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 11:17:16 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id c21so15451660edj.0
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 04:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lg0xzckHIVV7W+CI++paNDzu+/o9fNI3DOu2sTI2cvM=;
 b=Y5w1f0yq+ooQVuascIf6oiAlIPAIcq1PkK/2Wiq1ve7TNMzek6961oApGNgUoEizYo
 9EiUnCz7xPV2b7TUj1MxEEooP+MQe+W0kFoJs/KRjF1vj1AreTAXucPyX85GIqsn98kl
 G5T4GOnViifEZD3bDRq9ENtxLnneDFll1BVME+KJmaUwIvKbi59+kqLs23ERFIl98kiI
 c0MX6rtFibuShtiupMbqa3iigZVX3bZR3x1qaYyDkwl8Dx515ea/eMiJA/W3EJ0GEhB3
 od/6+D7/SyszdXsH27hCaFKuvsOmGzPiXGxv91EPhbT+T1BJfFh6zdAI0ty7NnmfbWEZ
 1aBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lg0xzckHIVV7W+CI++paNDzu+/o9fNI3DOu2sTI2cvM=;
 b=OBZt7ySWXdNN89Q04seq/6tsGQMlt7oKXJmmfR0hpxBAL05xB9lRnykW+hD/86waDl
 Zwinq2oEN+zhJzVfj9SHTK07mEzYojecz2r+d3HU2/pzSSdTJTFbnB6+fsg6SJHdiGps
 pCQhjX1C4dSX9OS3e0qe1fuEYdUew9ctAWi1SEEHDICMSdRCM1LJSbh136zfg3tdvXWF
 34C1bmV1Za1VLHvD4D5vqs/baZeaYWKgrReJxaffLgVXDKFHsyFATNCE1nPE6Safc4cJ
 OjMpraR7P0exjYMTOB8YVZLMpfOzJiyv2qYEX5r7X8vbpxB5D79B5Y0Z4AKdAQiUVkTN
 Wk1A==
X-Gm-Message-State: AOAM533KwkWxPYer488+iNvi4TJirX83LcJcR888HuP6Gat14RHp33m2
 Ci0UW7gUUJ0Kwv8WAgopoEr08dsBXkNHg9P2gKnpGg==
X-Google-Smtp-Source: ABdhPJyglz26x+lmrgv6QCUasZVL5xJn5w0vQbfMzmz7rEnBmOyo3+67cFGRz4jCisM44sKcP+W8/9WYMUYsVmTCErA=
X-Received: by 2002:a17:906:901:: with SMTP id
 i1mr5900541ejd.248.1631791034238; 
 Thu, 16 Sep 2021 04:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <20210805160319.GB23085@lpieralisi>
 <5d9bebdf-6eb5-49a0-2e8f-490df2d6754d@arm.com>
 <CABdtJHt-18TDHBFq1X89=qngUbopGoFnqjuXiBOPtZG58vy3sg@mail.gmail.com>
 <f3fc713365f7465e966aaed7cdd8870a@huawei.com>
 <CABdtJHuEViN0MSz-ZJhR52+b=F6yvQ5mm_edVuLy1B=nHp+ESQ@mail.gmail.com>
 <e02a00a10ea3440dab1f9f9320de42ad@huawei.com>
In-Reply-To: <e02a00a10ea3440dab1f9f9320de42ad@huawei.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Thu, 16 Sep 2021 13:16:37 +0200
Message-ID: <CABdtJHuRB29Ufryvz=kCO7b_xgVb1D-7y3RQgCkKvSmshkkH1A@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Will Deacon <will@kernel.org>, Steven Price <steven.price@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>, Sami Mujawar <Sami.Mujawar@arm.com>,
 Robin Murphy <robin.murphy@arm.com>,
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

On Thu, Sep 16, 2021 at 10:26 AM Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Jon Nettleton [mailto:jon@solid-run.com]
> > Sent: 16 September 2021 08:52
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>; Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com>; Laurentiu Tudor <laurentiu.tudor@nxp.com>;
> > linux-arm-kernel <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling
> > List <linux-acpi@vger.kernel.org>; Linux IOMMU
> > <iommu@lists.linux-foundation.org>; Joerg Roedel <joro@8bytes.org>; Will
> > Deacon <will@kernel.org>; wanghuiqiang <wanghuiqiang@huawei.com>;
> > Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; Steven Price
> > <steven.price@arm.com>; Sami Mujawar <Sami.Mujawar@arm.com>; Eric
> > Auger <eric.auger@redhat.com>; yangyicong <yangyicong@huawei.com>
> > Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
> >
> > On Thu, Sep 16, 2021 at 9:26 AM Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Jon Nettleton [mailto:jon@solid-run.com]
> > > > Sent: 06 September 2021 20:51
> > > > To: Robin Murphy <robin.murphy@arm.com>
> > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Shameerali
> > > > Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>; Laurentiu
> > > > Tudor <laurentiu.tudor@nxp.com>; linux-arm-kernel
> > > > <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling List
> > > > <linux-acpi@vger.kernel.org>; Linux IOMMU
> > > > <iommu@lists.linux-foundation.org>; Linuxarm <linuxarm@huawei.com>;
> > > > Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>;
> > > > wanghuiqiang <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
> > > > <guohanjun@huawei.com>; Steven Price <steven.price@arm.com>; Sami
> > > > Mujawar <Sami.Mujawar@arm.com>; Eric Auger
> > <eric.auger@redhat.com>;
> > > > yangyicong <yangyicong@huawei.com>
> > > > Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node
> > > > parsing
> > > >
> > > [...]
> > >
> > > > > >
> > > > > > On the prot value assignment based on the remapping flag, I'd
> > > > > > like to hear Robin/Joerg's opinion, I'd avoid being in a
> > > > > > situation where "normally" this would work but then we have to quirk
> > it.
> > > > > >
> > > > > > Is this a valid assumption _always_ ?
> > > > >
> > > > > No. Certainly applying IOMMU_CACHE without reference to the
> > > > > device's _CCA attribute or how CPUs may be accessing a shared
> > > > > buffer could lead to a loss of coherency. At worst, applying
> > > > > IOMMU_MMIO to a device-private buffer *could* cause the device to
> > > > > lose coherency with itself if the memory underlying the RMR may
> > > > > have allocated into system caches. Note that the expected use for
> > > > > non-remappable RMRs is the device holding some sort of long-lived
> > > > > private data in system RAM - the MSI doorbell trick is far more of a niche
> > hack really.
> > > > >
> > > > > At the very least I think we need to refer to the device's memory
> > > > > access properties here.
> > > > >
> > > > > Jon, Laurentiu - how do RMRs correspond to the EFI memory map on
> > > > > your firmware? I'm starting to think that as long as the
> > > > > underlying memory is described appropriately there then we should
> > > > > be able to infer correct attributes from the EFI memory type and flags.
> > > >
> > > > The devices are all cache coherent and marked as _CCA, 1.  The
> > > > Memory regions are in the virt table as
> > ARM_MEMORY_REGION_ATTRIBUTE_DEVICE.
> > > >
> > > > The current chicken and egg problem we have is that during the
> > > > fsl-mc-bus initialization we call
> > > >
> > > > error = acpi_dma_configure_id(&pdev->dev, DEV_DMA_COHERENT,
> > > >                                               &mc_stream_id);
> > > >
> > > > which gets deferred because the SMMU has not been initialized yet.
> > > > Then we initialize the RMR tables but there is no device reference
> > > > there to be able to query device properties, only the stream id.
> > > > After the IORT tables are parsed and the SMMU is setup, on the
> > > > second device probe we associate everything based on the stream id
> > > > and the fsl-mc-bus device is able to claim its 1-1 DMA mappings.
> > >
> > > Can we solve this order problem by delaying the
> > > iommu_alloc_resv_region() to the iommu_dma_get_rmr_resv_regions(dev,
> > > list) ? We could invoke
> > > device_get_dma_attr() from there which I believe will return the _CCA
> > attribute.
> > >
> > > Or is that still early to invoke that?
> >
> > That looks like it should work. Do we then also need to parse through the
> > VirtualMemoryTable matching the start and end addresses to determine the
> > other memory attributes like MMIO?
>
> Yes. But that looks tricky as I can't find that readily available on Arm, like the
> efi_mem_attributes(). I will take a look.
>
> Please let me know if there is one or any other easy way to retrieve it.

maybe we don't need to.  Maybe it is enough to just move
iommu_alloc_resv_regions and then set the IOMMU_CACHE flag
if type = IOMMU_RESV_DIRECT_RELAXABLE and _CCN=1?

-Jon

>
> Thanks,
> Shameer
>
> >
> > -Jon
> >
> > >
> > > Thanks,
> > > Shameer
> > >
> > > > cat /sys/kernel/iommu_groups/0/reserved_regions
> > > > 0x0000000001000000 0x0000000010ffffff direct-relaxable
> > > > 0x0000000008000000 0x00000000080fffff msi
> > > > 0x000000080c000000 0x000000081bffffff direct-relaxable
> > > > 0x0000001c00000000 0x0000001c001fffff direct-relaxable
> > > > 0x0000002080000000 0x000000209fffffff direct-relaxable
> > > >
> > > > -Jon
> > > >
> > > > >
> > > > > Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
