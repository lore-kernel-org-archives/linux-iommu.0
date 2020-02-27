Return-Path: <SRS0=1PsK=4P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D778C35E17
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 18:22:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083CB246A6
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 18:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083CB246A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D5009203D0;
	Thu, 27 Feb 2020 18:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qsHRLhV3Oftt; Thu, 27 Feb 2020 18:22:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 45A31203AC;
	Thu, 27 Feb 2020 18:22:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39AD2C08A0;
	Thu, 27 Feb 2020 18:22:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AE68C0177
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 18:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 181CA203D0
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 18:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1lKK3WaQ5acs for <iommu@lists.linux-foundation.org>;
 Thu, 27 Feb 2020 18:22:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by silver.osuosl.org (Postfix) with ESMTPS id A958F203AC
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 18:22:10 +0000 (UTC)
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 99F00611DC9F15BD25C9;
 Thu, 27 Feb 2020 18:22:08 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 27 Feb 2020 18:22:07 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 27 Feb
 2020 18:22:07 +0000
Date: Thu, 27 Feb 2020 18:22:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 00/26] iommu: Shared Virtual Addressing and SMMUv3
 support
Message-ID: <20200227182206.000075aa@Huawei.com>
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, kevin.tian@intel.com,
 will@kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
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

On Mon, 24 Feb 2020 19:23:35 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Shared Virtual Addressing (SVA) allows to share process page tables with
> devices using the IOMMU. Add a generic implementation of the IOMMU SVA
> API, and add support in the Arm SMMUv3 driver.
> 
> Previous versions of this patchset were sent over a year ago [1][2] but
> we've made a lot of progress since then:
> 
> * ATS support for SMMUv3 was merged in v5.2.
> * The bind() and fault reporting APIs have been merged in v5.3.
> * IOASID were added in v5.5.
> * SMMUv3 PASID was added in v5.6, with some pending for v5.7.
> 
> * The first user of the bind() API will be merged in v5.7 [3]. The zip
>   accelerator is also the first piece of hardware that I've been able to
>   use for testing (previous versions were developed with software models)
>   and I now have tools for evaluating SVA performance. Unfortunately I
>   still don't have hardware that supports ATS and PRI; the zip accelerator
>   uses stall.
> 
> These are the remaining changes for SVA support in SMMUv3. Since v3 [1]
> I fixed countless bugs and - I think - addressed everyone's comments.
> Thanks to recent MMU notifier rework, iommu-sva.c is a lot more
> straightforward. I'm still unhappy with the complicated locking in the
> SMMUv3 driver resulting from patch 12 (Seize private ASID), but I
> haven't found anything better.
> 
> Please find all SVA patches on branches sva/current and sva/zip-devel at
> https://jpbrucker.net/git/linux
> 
> [1] https://lore.kernel.org/linux-iommu/20180920170046.20154-1-jean-philippe.brucker@arm.com/
> [2] https://lore.kernel.org/linux-iommu/20180511190641.23008-1-jean-philippe.brucker@arm.com/
> [3] https://lore.kernel.org/linux-iommu/1581407665-13504-1-git-send-email-zhangfei.gao@linaro.org/

Hi Jean-Phillippe.

Great to see this progressing.  Other than the few places I've commented
it all looks good to me.

Thanks,

Jonathan

> 
> Jean-Philippe Brucker (26):
>   mm/mmu_notifiers: pass private data down to alloc_notifier()
>   iommu/sva: Manage process address spaces
>   iommu: Add a page fault handler
>   iommu/sva: Search mm by PASID
>   iommu/iopf: Handle mm faults
>   iommu/sva: Register page fault handler
>   arm64: mm: Pin down ASIDs for sharing mm with devices
>   iommu/io-pgtable-arm: Move some definitions to a header
>   iommu/arm-smmu-v3: Manage ASIDs with xarray
>   arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
>   iommu/arm-smmu-v3: Share process page tables
>   iommu/arm-smmu-v3: Seize private ASID
>   iommu/arm-smmu-v3: Add support for VHE
>   iommu/arm-smmu-v3: Enable broadcast TLB maintenance
>   iommu/arm-smmu-v3: Add SVA feature checking
>   iommu/arm-smmu-v3: Add dev_to_master() helper
>   iommu/arm-smmu-v3: Implement mm operations
>   iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
>   iommu/arm-smmu-v3: Add support for Hardware Translation Table Update
>   iommu/arm-smmu-v3: Maintain a SID->device structure
>   iommu/arm-smmu-v3: Ratelimit event dump
>   dt-bindings: document stall property for IOMMU masters
>   iommu/arm-smmu-v3: Add stall support for platform devices
>   PCI/ATS: Add PRI stubs
>   PCI/ATS: Export symbols of PRI functions
>   iommu/arm-smmu-v3: Add support for PRI
> 
>  .../devicetree/bindings/iommu/iommu.txt       |   18 +
>  arch/arm64/include/asm/mmu.h                  |    1 +
>  arch/arm64/include/asm/mmu_context.h          |   11 +-
>  arch/arm64/kernel/cpufeature.c                |    1 +
>  arch/arm64/mm/context.c                       |  103 +-
>  drivers/iommu/Kconfig                         |   13 +
>  drivers/iommu/Makefile                        |    2 +
>  drivers/iommu/arm-smmu-v3.c                   | 1354 +++++++++++++++--
>  drivers/iommu/io-pgfault.c                    |  533 +++++++
>  drivers/iommu/io-pgtable-arm.c                |   27 +-
>  drivers/iommu/io-pgtable-arm.h                |   30 +
>  drivers/iommu/iommu-sva.c                     |  596 ++++++++
>  drivers/iommu/iommu-sva.h                     |   64 +
>  drivers/iommu/iommu.c                         |    1 +
>  drivers/iommu/of_iommu.c                      |    5 +-
>  drivers/misc/sgi-gru/grutlbpurge.c            |    4 +-
>  drivers/pci/ats.c                             |    4 +
>  include/linux/iommu.h                         |   73 +
>  include/linux/mmu_notifier.h                  |   10 +-
>  include/linux/pci-ats.h                       |    8 +
>  mm/mmu_notifier.c                             |    6 +-
>  21 files changed, 2699 insertions(+), 165 deletions(-)
>  create mode 100644 drivers/iommu/io-pgfault.c
>  create mode 100644 drivers/iommu/io-pgtable-arm.h
>  create mode 100644 drivers/iommu/iommu-sva.c
>  create mode 100644 drivers/iommu/iommu-sva.h
> 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
