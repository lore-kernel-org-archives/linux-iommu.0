Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D83C43464
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 13:17:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 668F720872
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 13:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668F720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0C34F872ED;
	Fri, 18 Sep 2020 13:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Is29rjcWGaGU; Fri, 18 Sep 2020 13:17:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 60B36870F7;
	Fri, 18 Sep 2020 13:17:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44F47C0859;
	Fri, 18 Sep 2020 13:17:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45EC5C0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 13:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3B2C62E1F8
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 13:17:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nFms2zl312-N for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 13:17:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by silver.osuosl.org (Postfix) with ESMTPS id 06ABD2E1FA
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 13:17:04 +0000 (UTC)
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id EC5B2F2C726B32665062;
 Fri, 18 Sep 2020 14:17:02 +0100 (IST)
Received: from localhost (10.52.125.116) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 18 Sep
 2020 14:17:02 +0100
Date: Fri, 18 Sep 2020 14:15:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 00/13] iommu: Shared Virtual Addressing for SMMUv3
 (PT sharing part)
Message-ID: <20200918141524.00004cef@Huawei.com>
In-Reply-To: <20200918101852.582559-1-jean-philippe@linaro.org>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.52.125.116]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: fenghua.yu@intel.com, catalin.marinas@arm.com, robin.murphy@arm.com,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On Fri, 18 Sep 2020 12:18:40 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> This is version 10 of the page table sharing support for Arm SMMUv3.
> Patch 1 still needs an Ack from mm maintainers. However patches 4-11 do
> not depend on it, and could get merged for v5.10 regardless.

Hi Jean-Philippe,

It's been a rather long time since I last looked at this stuff (about v4
I think!), but I just had a read through this set and they all look good to me.

FWIW:
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

> 
> v10:
> * Fix patches 3, 8, 9 and 10 following Eric's review.
> 
> v9 resend: https://lore.kernel.org/linux-iommu/20200817171558.325917-1-jean-philippe@linaro.org/
> * Rebased onto v5.9-rc1. Moved to drivers/iommu/arm/arm-smmu-v3/ as a
>   result.
> 
> v9: https://lore.kernel.org/linux-iommu/20200723145724.3014766-1-jean-philippe@linaro.org/
> * Moved most of the SVA code to arm-smmu-v3-sva.c. This required moving
>   struct definitions and macros to arm-smmu-v3.h (patch 7), hence the
>   new 700 insertions/deletions in the diffstat.
> * Updated patches 4 and 8 following review.
> * Fixed a bug when replacing a private ASID.
> 
> v8: https://lore.kernel.org/linux-iommu/20200618155125.1548969-1-jean-philippe@linaro.org/
> * Split SVA series into three parts: page table sharing, I/O page
>   faults, and additional features (DVM, VHE and HTTU).
> 
> Fenghua Yu (1):
>   mm: Define pasid in mm
> 
> Jean-Philippe Brucker (12):
>   iommu/ioasid: Add ioasid references
>   iommu/sva: Add PASID helpers
>   arm64: mm: Pin down ASIDs for sharing mm with devices
>   iommu/io-pgtable-arm: Move some definitions to a header
>   arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
>   iommu/arm-smmu-v3: Move definitions to a header
>   iommu/arm-smmu-v3: Share process page tables
>   iommu/arm-smmu-v3: Seize private ASID
>   iommu/arm-smmu-v3: Check for SVA features
>   iommu/arm-smmu-v3: Add SVA device feature
>   iommu/arm-smmu-v3: Implement iommu_sva_bind/unbind()
>   iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
> 
>  drivers/iommu/Kconfig                         |  17 +
>  drivers/iommu/Makefile                        |   1 +
>  drivers/iommu/arm/arm-smmu-v3/Makefile        |   5 +-
>  arch/arm64/include/asm/mmu.h                  |   3 +
>  arch/arm64/include/asm/mmu_context.h          |  11 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 752 +++++++++++++++
>  drivers/iommu/io-pgtable-arm.h                |  30 +
>  drivers/iommu/iommu-sva-lib.h                 |  15 +
>  include/linux/ioasid.h                        |  10 +-
>  include/linux/mm_types.h                      |   4 +
>  arch/arm64/kernel/cpufeature.c                |   1 +
>  arch/arm64/mm/context.c                       | 105 ++-
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 488 ++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 860 ++++--------------
>  drivers/iommu/intel/iommu.c                   |   4 +-
>  drivers/iommu/intel/svm.c                     |   6 +-
>  drivers/iommu/io-pgtable-arm.c                |  27 +-
>  drivers/iommu/ioasid.c                        |  38 +-
>  drivers/iommu/iommu-sva-lib.c                 |  86 ++
>  MAINTAINERS                                   |   3 +-
>  20 files changed, 1731 insertions(+), 735 deletions(-)
>  create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>  create mode 100644 drivers/iommu/io-pgtable-arm.h
>  create mode 100644 drivers/iommu/iommu-sva-lib.h
>  create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>  create mode 100644 drivers/iommu/iommu-sva-lib.c
> 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
