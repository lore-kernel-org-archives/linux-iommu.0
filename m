Return-Path: <SRS0=eAvY=NW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502E0C432BE
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 05:07:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95146103A
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 05:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D95146103A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9454040015;
	Tue, 31 Aug 2021 05:07:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bQmbQuZk_Ifq; Tue, 31 Aug 2021 05:07:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7CA10400E4;
	Tue, 31 Aug 2021 05:07:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5608BC0010;
	Tue, 31 Aug 2021 05:07:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C248DC000E
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 05:07:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A301E400E4
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 05:07:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7UjoiR1VNUvF for <iommu@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 05:07:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB28C401BB
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 05:07:36 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id n11so24868459edv.11
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 22:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+9JLMUEGuTSyUphLOiuK/o3WrAb7TWs20Kwls76RPEk=;
 b=X0wZCLCMDC9sOHDwi7WuzV8/HIEOdVWVnVcQzbv+QeObhsCAvWlPLJ+q1K4decobT2
 Rjz7HVerG6qQBUs316Ns6qzYJ7J+gb0AgJWwZFZlf8GkGzI8MelZQO5E83uTeiXBsNS+
 q96xFs8glcHHP7ug/irAHZ1TtvDKvpD4AqJPHpueP047PMOiXfDrOnXwEQEE3jAzfsoa
 SU13O9Po/RysClarcjxeCkvfTJ1NPvfYXb6ahOQb41hMuA7HPhcdmwKTpC/Bqb1eCje6
 XtwcfbKbrJEoOit6kq/cZU4HYiGbNa3Uc2gI1wQDztKzQ2g1F2RytBFxm+S3LflKARBL
 UCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+9JLMUEGuTSyUphLOiuK/o3WrAb7TWs20Kwls76RPEk=;
 b=I+k+305rmy9rjNGQy4bH8MfmahrSu/Z8EyKkChuRXmkfi3JqAPFwLyPqiv3qv25T4B
 NXQ7UFJG9VR77L4IAZ7byUMm3L3Z6jXID/VvYPAV9jawkT61B57e7YqyeHfKPczbWhL9
 79c7Fpmkv2cl+pUTbSlvkjHFT4K8fPiWQRHR0xtfc5GjK2+MthRe/zE6L/8ZBtNaAtyB
 15uKIWaM3hTAvV7qj8pKyKohvPiJT5GOf0CmSdMtKj6xEfaNzsrh4xuiOhhwnr8unBa5
 ndYRK4cI2zG/frpwqFz99GSq9rfKoMI1572HMp6Ky1EFDXAnsliiYNIxNqChsFpOLfaG
 fKmg==
X-Gm-Message-State: AOAM532VueC7jO9RN6COWlD6qdTkB2EiiBzW/KsBc+FujUXXSJb7jYwm
 TR65rfRzstkx/RpuNH9u/hhOCUjneJBgDBNpwss2Lg==
X-Google-Smtp-Source: ABdhPJw3bs9klmA4ZwzYsj0W52rj0T5yFqeP2kB+dZoyUd8oOW4bpTE8uDnH+x9cAw6FSmg6O3ZRvWW3aUfpYw8S8OI=
X-Received: by 2002:aa7:dd12:: with SMTP id i18mr27577652edv.368.1630386455037; 
 Mon, 30 Aug 2021 22:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <CAMj1kXHNjeDb2HuPeV_6Er4oALVKFz+g=gQ_0rf+JW22NxqqTA@mail.gmail.com>
 <8df7fc81b00142b68126efd3c700a579@huawei.com>
 <CAMj1kXHTdDWz14B5Smzfmj5NQqCTTsgFjam6EevvOwFKLsmJzw@mail.gmail.com>
In-Reply-To: <CAMj1kXHTdDWz14B5Smzfmj5NQqCTTsgFjam6EevvOwFKLsmJzw@mail.gmail.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Tue, 31 Aug 2021 07:06:58 +0200
Message-ID: <CABdtJHuYgw7cX2=uKMmaiC8UmVo7czk9oVrsc=hyZ4fFGoEskA@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>,
 Steven Price <steven.price@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>,
 "Guohanjun \(Hanjun Guo\)" <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>, Sami Mujawar <Sami.Mujawar@arm.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Thu, Aug 5, 2021 at 4:09 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 5 Aug 2021 at 15:35, Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Ard Biesheuvel [mailto:ardb@kernel.org]
> > > Sent: 05 August 2021 14:23
> > > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > > Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>; ACPI Devel Maling List
> > > <linux-acpi@vger.kernel.org>; Linux IOMMU
> > > <iommu@lists.linux-foundation.org>; Linuxarm <linuxarm@huawei.com>;
> > > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Joerg Roedel
> > > <joro@8bytes.org>; Robin Murphy <robin.murphy@arm.com>; Will Deacon
> > > <will@kernel.org>; wanghuiqiang <wanghuiqiang@huawei.com>; Guohanjun
> > > (Hanjun Guo) <guohanjun@huawei.com>; Steven Price
> > > <steven.price@arm.com>; Sami Mujawar <Sami.Mujawar@arm.com>; Jon
> > > Nettleton <jon@solid-run.com>; Eric Auger <eric.auger@redhat.com>;
> > > yangyicong <yangyicong@huawei.com>
> > > Subject: Re: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
> > >
> > > On Thu, 5 Aug 2021 at 10:10, Shameer Kolothum
> > > <shameerali.kolothum.thodi@huawei.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > The series adds support to IORT RMR nodes specified in IORT
> > > > Revision E.b -ARM DEN 0049E[0]. RMR nodes are used to describe
> > > > memory ranges that are used by endpoints and require a unity
> > > > mapping in SMMU.
> > > >
> > > > We have faced issues with 3408iMR RAID controller cards which
> > > > fail to boot when SMMU is enabled. This is because these
> > > > controllers make use of host memory for various caching related
> > > > purposes and when SMMU is enabled the iMR firmware fails to
> > > > access these memory regions as there is no mapping for them.
> > > > IORT RMR provides a way for UEFI to describe and report these
> > > > memory regions so that the kernel can make a unity mapping for
> > > > these in SMMU.
> > > >
> > >
> > > Does this mean we are ignoring the RMR memory ranges, and exposing the
> > > entire physical address space to devices using the stream IDs in
> > > question?
> >
> > Nope. RMR node is used to describe the memory ranges used by end points
> > behind SMMU. And this information is used to create 1 : 1 mappings for those
> > ranges in SMMU. Anything outside those ranges will result in translation
> > fault(if there are no other dynamic DMA mappings).
> >
>
> Excellent! It was not obvious to me from looking at the patches, so I
> had to ask.
>
> Thanks,
> Ard.
>
> >
> > >
> > > > Change History:
> > > >
> > > > v6 --> v7
> > > >
> > > > The only change from v6 is the fix pointed out by Steve to
> > > > the SMMUv2 SMR bypass install in patch #8.
> > > >
> > > > Thanks to the Tested-by tags by Laurentiu with SMMUv2 and
> > > > Hanjun/Huiqiang with SMMUv3 for v6. I haven't added the tags
> > > > yet as the series still needs more review[1].
> > > >
> > > > Feedback and tests on this series is very much appreciated.
> > > >
> > > > v5 --> v6
> > > > - Addressed comments from Robin & Lorenzo.
> > > >   : Moved iort_parse_rmr() to acpi_iort_init() from
> > > >     iort_init_platform_devices().
> > > >   : Removed use of struct iort_rmr_entry during the initial
> > > >     parse. Using struct iommu_resv_region instead.
> > > >   : Report RMR address alignment and overlap errors, but continue.
> > > >   : Reworked arm_smmu_init_bypass_stes() (patch # 6).
> > > > - Updated SMMUv2 bypass SMR code. Thanks to Jon N (patch #8).
> > > > - Set IOMMU protection flags(IOMMU_CACHE, IOMMU_MMIO) based
> > > >   on Type of RMR region. Suggested by Jon N.
> > > >
> > > > Thanks,
> > > > Shameer
> > > > [0] https://developer.arm.com/documentation/den0049/latest/
> > > > [1]
> > > https://lore.kernel.org/linux-acpi/20210716083442.1708-1-shameerali.koloth
> > > um.thodi@huawei.com/T/#m043c95b869973a834b2fd57f3e1ed0325c84f3b7
> > > > ------
> > > > v4 --> v5
> > > >  -Added a fw_data union to struct iommu_resv_region and removed
> > > >   struct iommu_rmr (Based on comments from Joerg/Robin).
> > > >  -Added iommu_put_rmrs() to release mem.
> > > >  -Thanks to Steve for verifying on SMMUv2, but not added the Tested-by
> > > >   yet because of the above changes.
> > > >
> > > > v3 -->v4
> > > > -Included the SMMUv2 SMR bypass install changes suggested by
> > > >  Steve(patch #7)
> > > > -As per Robin's comments, RMR reserve implementation is now
> > > >  more generic  (patch #8) and dropped v3 patches 8 and 10.
> > > > -Rebase to 5.13-rc1
> > > >
> > > > RFC v2 --> v3
> > > >  -Dropped RFC tag as the ACPICA header changes are now ready to be
> > > >   part of 5.13[0]. But this series still has a dependency on that patch.
> > > >  -Added IORT E.b related changes(node flags, _DSM function 5 checks for
> > > >   PCIe).
> > > >  -Changed RMR to stream id mapping from M:N to M:1 as per the spec and
> > > >   discussion here[1].
> > > >  -Last two patches add support for SMMUv2(Thanks to Jon Nettleton!)
> > > > ------
> > > >
> > > > Jon Nettleton (1):
> > > >   iommu/arm-smmu: Get associated RMR info and install bypass SMR
> > > >
> > > > Shameer Kolothum (8):
> > > >   iommu: Introduce a union to struct iommu_resv_region
> > > >   ACPI/IORT: Add support for RMR node parsing
> > > >   iommu/dma: Introduce generic helper to retrieve RMR info
> > > >   ACPI/IORT: Add a helper to retrieve RMR memory regions
> > > >   iommu/arm-smmu-v3: Introduce strtab init helper
> > > >   iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
> > > >     bypass
> > > >   iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
> > > >   iommu/dma: Reserve any RMR regions associated with a dev
> > > >
> > > >  drivers/acpi/arm64/iort.c                   | 172
> > > +++++++++++++++++++-
> > > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  76 +++++++--
> > > >  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  48 ++++++
> > > >  drivers/iommu/dma-iommu.c                   |  89 +++++++++-
> > > >  include/linux/acpi_iort.h                   |   7 +
> > > >  include/linux/dma-iommu.h                   |  13 ++
> > > >  include/linux/iommu.h                       |  11 ++
> > > >  7 files changed, 393 insertions(+), 23 deletions(-)
> > > >
> > > > --
> > > > 2.17.1
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Ping,  Can we get some movement on this patchset?  The standard was
was ratified over a year ago, and there is real world hardware that is
using or needs this functionality.

Thanks,
-Jon
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
