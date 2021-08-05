Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_RED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E043C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 13:22:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF136113B
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 13:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BDF136113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97307607AC;
	Thu,  5 Aug 2021 13:22:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TlVbgGqkR-1X; Thu,  5 Aug 2021 13:22:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7B34F6074D;
	Thu,  5 Aug 2021 13:22:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46454C001A;
	Thu,  5 Aug 2021 13:22:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 578C3C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 13:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 452AC607AC
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 13:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RGcjJXXqLsXD for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 13:22:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAFA66074D
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 13:22:44 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48DF461154
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 13:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628169764;
 bh=rABZo6aAjftHjiZ5IWVoUogsJY3wYwnWG2rnzy4liBo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Wvd0gPN3bIkbH85Jb8aiK9vAeTaGXkKH0MPPvHrT67OI7Yv4pArZ3mpw+PSlewnAk
 PnYEYc30nVMFJfbbkDTxRhqH4HilA2dnpEQinC6/a2ywTKEu5145yOWfueC31EFsne
 QhqBB69I6VY8hq+RW66dpCUIpmO6LVAeWRUefgRrASbWZBtrtYcVZ1bPgZvE8U7j1Z
 pIK8w0B94XWyw2tc9gxARVmYCPzhqQAjHnGb+TBmGyMiIH1MeZ3T3eUM+Lg7HwHP4C
 w4DGrWG56tp3VXJvpseidZvpVsG86dLc/vIcckBLXQRwspK+ODQ7dt3zdW1045KQDp
 4XqNS2b0S6CLA==
Received: by mail-ot1-f42.google.com with SMTP id
 h63-20020a9d14450000b02904ce97efee36so5088270oth.7
 for <iommu@lists.linux-foundation.org>; Thu, 05 Aug 2021 06:22:44 -0700 (PDT)
X-Gm-Message-State: AOAM533xD7lp7XAJPe/uItAOhFCkdusFqsXTLhJmP66Po2BEdGvNhRLG
 dywYnBPAxO5yfLUDggmYbxPmu+OYxXQM88WpnAc=
X-Google-Smtp-Source: ABdhPJx0hDuVxvbP140/VxO38R4dIU/rEbrl3LBsoE8UOKfL6M4pTys5XpazDhygGrztUo1RJOEBxMauD3jhjiaPAZQ=
X-Received: by 2002:a9d:5c2:: with SMTP id 60mr3654201otd.77.1628169763566;
 Thu, 05 Aug 2021 06:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 5 Aug 2021 15:22:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHNjeDb2HuPeV_6Er4oALVKFz+g=gQ_0rf+JW22NxqqTA@mail.gmail.com>
Message-ID: <CAMj1kXHNjeDb2HuPeV_6Er4oALVKFz+g=gQ_0rf+JW22NxqqTA@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Will Deacon <will@kernel.org>, Jon Nettleton <jon@solid-run.com>,
 Linuxarm <linuxarm@huawei.com>, Steven Price <steven.price@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, wanghuiqiang@huawei.com,
 Hanjun Guo <guohanjun@huawei.com>, yangyicong@huawei.com,
 Sami Mujawar <Sami.Mujawar@arm.com>, Robin Murphy <robin.murphy@arm.com>,
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

On Thu, 5 Aug 2021 at 10:10, Shameer Kolothum
<shameerali.kolothum.thodi@huawei.com> wrote:
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

Does this mean we are ignoring the RMR memory ranges, and exposing the
entire physical address space to devices using the stream IDs in
question?


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
>
> v5 --> v6
> - Addressed comments from Robin & Lorenzo.
>   : Moved iort_parse_rmr() to acpi_iort_init() from
>     iort_init_platform_devices().
>   : Removed use of struct iort_rmr_entry during the initial
>     parse. Using struct iommu_resv_region instead.
>   : Report RMR address alignment and overlap errors, but continue.
>   : Reworked arm_smmu_init_bypass_stes() (patch # 6).
> - Updated SMMUv2 bypass SMR code. Thanks to Jon N (patch #8).
> - Set IOMMU protection flags(IOMMU_CACHE, IOMMU_MMIO) based
>   on Type of RMR region. Suggested by Jon N.
>
> Thanks,
> Shameer
> [0] https://developer.arm.com/documentation/den0049/latest/
> [1] https://lore.kernel.org/linux-acpi/20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com/T/#m043c95b869973a834b2fd57f3e1ed0325c84f3b7
> ------
> v4 --> v5
>  -Added a fw_data union to struct iommu_resv_region and removed
>   struct iommu_rmr (Based on comments from Joerg/Robin).
>  -Added iommu_put_rmrs() to release mem.
>  -Thanks to Steve for verifying on SMMUv2, but not added the Tested-by
>   yet because of the above changes.
>
> v3 -->v4
> -Included the SMMUv2 SMR bypass install changes suggested by
>  Steve(patch #7)
> -As per Robin's comments, RMR reserve implementation is now
>  more generic  (patch #8) and dropped v3 patches 8 and 10.
> -Rebase to 5.13-rc1
>
> RFC v2 --> v3
>  -Dropped RFC tag as the ACPICA header changes are now ready to be
>   part of 5.13[0]. But this series still has a dependency on that patch.
>  -Added IORT E.b related changes(node flags, _DSM function 5 checks for
>   PCIe).
>  -Changed RMR to stream id mapping from M:N to M:1 as per the spec and
>   discussion here[1].
>  -Last two patches add support for SMMUv2(Thanks to Jon Nettleton!)
> ------
>
> Jon Nettleton (1):
>   iommu/arm-smmu: Get associated RMR info and install bypass SMR
>
> Shameer Kolothum (8):
>   iommu: Introduce a union to struct iommu_resv_region
>   ACPI/IORT: Add support for RMR node parsing
>   iommu/dma: Introduce generic helper to retrieve RMR info
>   ACPI/IORT: Add a helper to retrieve RMR memory regions
>   iommu/arm-smmu-v3: Introduce strtab init helper
>   iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
>     bypass
>   iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
>   iommu/dma: Reserve any RMR regions associated with a dev
>
>  drivers/acpi/arm64/iort.c                   | 172 +++++++++++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  76 +++++++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  48 ++++++
>  drivers/iommu/dma-iommu.c                   |  89 +++++++++-
>  include/linux/acpi_iort.h                   |   7 +
>  include/linux/dma-iommu.h                   |  13 ++
>  include/linux/iommu.h                       |  11 ++
>  7 files changed, 393 insertions(+), 23 deletions(-)
>
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
