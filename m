Return-Path: <SRS0=qXOr=FH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2FAC433FE
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 15:02:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E44206D6
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 15:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E44206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4B2C687C5A;
	Thu,  3 Dec 2020 15:02:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OTZZFJ-Q05yh; Thu,  3 Dec 2020 15:02:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4E3D487BE5;
	Thu,  3 Dec 2020 15:02:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F0A8C163C;
	Thu,  3 Dec 2020 15:02:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D81A9C0FA7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 06:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BFB38870EF
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 06:53:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fBNS8Bxyr8RN for <iommu@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 06:53:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8CFF0870ED
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 06:53:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 078BE11FB
 for <iommu@lists.linux-foundation.org>; Wed,  2 Dec 2020 22:53:17 -0800 (PST)
Received: from mail-pg1-f175.google.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E96A73F575
 for <iommu@lists.linux-foundation.org>; Wed,  2 Dec 2020 22:53:16 -0800 (PST)
Received: by mail-pg1-f175.google.com with SMTP id i38so831306pgb.5
 for <iommu@lists.linux-foundation.org>; Wed, 02 Dec 2020 22:53:16 -0800 (PST)
X-Gm-Message-State: AOAM532qYQpIbxiUTx4zAg9uWUiuttzz7W/HEUxHYZwUZoWPPmOl4ZKN
 QEbiW+NaKjB9Pn4GHsPVuw6ZvsOLEObgDO8yHtU=
X-Google-Smtp-Source: ABdhPJygtekmLjjncvjFwG4SdpDCdLwfKHAXG6gTy9UWIl0OW84LFK0WMjkvnr+8NjJZe42RTQB3PnaS/Udv9iPQkrg=
X-Received: by 2002:a62:790f:0:b029:18a:ae57:353f with SMTP id
 u15-20020a62790f0000b029018aae57353fmr1698141pfc.78.1606978392331; Wed, 02
 Dec 2020 22:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
From: Vivek Gautam <vivek.gautam@arm.com>
Date: Thu, 3 Dec 2020 12:22:59 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHAiZ22t9gOv04HfYGeFdmKxTYhLb0yXDPo0bgcSfHUSg@mail.gmail.com>
Message-ID: <CAFp+6iHAiZ22t9gOv04HfYGeFdmKxTYhLb0yXDPo0bgcSfHUSg@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] iommu: I/O page faults for SMMUv3
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
X-Mailman-Approved-At: Thu, 03 Dec 2020 15:02:56 +0000
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, PCI <linux-pci@vger.kernel.org>,
 sudeep.holla@arm.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Robin Murphy <robin.murphy@arm.com>, linux-acpi@vger.kernel.org,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 robh+dt <robh+dt@kernel.org>, guohanjun@huawei.com,
 Bjorn Helgaas <bhelgaas@google.com>, zhangfei.gao@linaro.org,
 Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, lenb@kernel.org
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

Hi Jean,


On Thu, Nov 12, 2020 at 6:33 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Add support for stall and PRI to the SMMUv3 driver, along with a common
> I/O Page Fault handler.
>
> These patches were last sent as part of v7 of the larger SVA series [1].
> Main changes since v7:
> * Dropped CONFIG_IOMMU_PAGE_FAULT, reuse CONFIG_IOMMU_SVA_LIB instead.
> * Extracted devicetree support into patch 4.
> * Added patch 5 for ACPI support.
> * Dropped event queue flush on unbind(). Since device drivers must
>   complete DMA transactions before calling unbind(), there cannot be any
>   pending stalled event.
> * A few small fixes.
>
> The series depends on "iommu/sva: Add PASID helpers" [2], since it
> provides the function to search an mm_struct by PASID.
>
> Has anyone been testing the PRI patches on hardware? I still only have a
> software model to test them, so as much as I'd like to cross this off my
> list, we could leave out patches 7-9 for now.
>
I have been testing this series for sometime now with a RDN1Edge platform model.
The public model for N1-Edge rd FVP can be found at [A].
With reference software [B] and your kernel branch with smmute [C], I
was able to
test smmute by initiating different DMA transactions. With model logs I was able
to validate ATS and PRI command flows as well.
So I am happy to give my tested-by tag.

Tested-by: Vivek Gautam <vivek.gautam@arm.com>

Best regards
Vivek

[A] https://developer.arm.com/tools-and-software/open-source-software/arm-platforms-software/arm-ecosystem-fvps
[B] https://git.linaro.org/landing-teams/working/arm/arm-reference-platforms.git/about/docs/rdn1edge/user-guide.rst
[C] https://jpbrucker.net/git/linux/log/?h=sva/smmute-2020-11-12

> [1] https://lore.kernel.org/linux-iommu/20200519175502.2504091-1-jean-philippe@linaro.org/
> [2] https://lore.kernel.org/linux-iommu/20201106155048.997886-1-jean-philippe@linaro.org/
>
> Jean-Philippe Brucker (9):
>   iommu: Add a page fault handler
>   iommu/arm-smmu-v3: Maintain a SID->device structure
>   dt-bindings: document stall property for IOMMU masters
>   of/iommu: Support dma-can-stall property
>   ACPI/IORT: Enable stall support for platform devices
>   iommu/arm-smmu-v3: Add stall support for platform devices
>   PCI/ATS: Add PRI stubs
>   PCI/ATS: Export PRI functions
>   iommu/arm-smmu-v3: Add support for PRI
>
>  drivers/iommu/Makefile                        |   1 +
>  .../devicetree/bindings/iommu/iommu.txt       |  18 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  69 +-
>  drivers/iommu/iommu-sva-lib.h                 |  53 ++
>  include/linux/iommu.h                         |   4 +
>  include/linux/pci-ats.h                       |   7 +
>  drivers/acpi/arm64/iort.c                     |   1 +
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  52 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 605 +++++++++++++++---
>  drivers/iommu/io-pgfault.c                    | 462 +++++++++++++
>  drivers/iommu/of_iommu.c                      |   5 +-
>  drivers/pci/ats.c                             |   4 +
>  12 files changed, 1191 insertions(+), 90 deletions(-)
>  create mode 100644 drivers/iommu/io-pgfault.c
>
> --
> 2.29.1
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
