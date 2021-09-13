Return-Path: <SRS0=sav6=OD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFE8C433EF
	for <iommu@archiver.kernel.org>; Mon, 13 Sep 2021 12:41:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320C160FF2
	for <iommu@archiver.kernel.org>; Mon, 13 Sep 2021 12:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 320C160FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F30394027C;
	Mon, 13 Sep 2021 12:41:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mqiaGD9W8wGB; Mon, 13 Sep 2021 12:41:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 959EC400C3;
	Mon, 13 Sep 2021 12:41:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A64FC0011;
	Mon, 13 Sep 2021 12:41:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACC3DC000D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Sep 2021 12:41:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F7B880F36
 for <iommu@lists.linux-foundation.org>; Mon, 13 Sep 2021 12:41:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Kii1iCk-xGf for <iommu@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 12:41:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id E2A4380F2D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Sep 2021 12:41:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6946D31B;
 Mon, 13 Sep 2021 05:41:27 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.15.112])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C33D3F59C;
 Mon, 13 Sep 2021 05:41:25 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH] iommu/dma: Tidy up Kconfig selects
Date: Mon, 13 Sep 2021 13:41:19 +0100
Message-Id: <9ba6f2e8568a3ff6a94fade66668d99705433c44.1631536879.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linux-ia64@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
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

Now that the dust has settled on converting all the x86 drivers to
iommu-dma, we can punt the Kconfig selection to arch code where it
was always intended to be.

CC: Christoph Hellwig <hch@lst.de>
CC: Marek Szyprowski <m.szyprowski@samsung.com>
CC: x86@kernel.org
CC: linux-ia64@vger.kernel.org
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/ia64/Kconfig           | 1 +
 arch/x86/Kconfig            | 1 +
 drivers/iommu/Kconfig       | 1 -
 drivers/iommu/amd/Kconfig   | 1 -
 drivers/iommu/intel/Kconfig | 1 -
 5 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 045792cde481..56c00a0851ce 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -51,6 +51,7 @@ config IA64
 	select GENERIC_TIME_VSYSCALL
 	select LEGACY_TIMER_TICK
 	select SWIOTLB
+	select IOMMU_DMA if INTEL_IOMMU
 	select SYSCTL_ARCH_UNALIGN_NO_WARN
 	select HAVE_MOD_ARCH_SPECIFIC
 	select MODULES_USE_ELF_RELA
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4e001bbbb425..10ea941e7c80 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -247,6 +247,7 @@ config X86
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
 	select HOTPLUG_SMT			if SMP
+	select IOMMU_DMA			if IOMMU_SUPPORT
 	select IRQ_FORCED_THREADING
 	select NEED_SG_DMA_LENGTH
 	select PCI_DOMAINS			if PCI
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 124c41adeca1..3538a2f38b94 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -459,7 +459,6 @@ config VIRTIO_IOMMU
 	depends on VIRTIO
 	depends on (ARM64 || X86)
 	select IOMMU_API
-	select IOMMU_DMA
 	select INTERVAL_TREE
 	select ACPI_VIOT if ACPI
 	help
diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index a3cbafb603f5..9b5fc3356bf2 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -9,7 +9,6 @@ config AMD_IOMMU
 	select PCI_PASID
 	select IOMMU_API
 	select IOMMU_IOVA
-	select IOMMU_DMA
 	select IOMMU_IO_PGTABLE
 	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
 	help
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 0ddb77115be7..28c3e922ca27 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -16,7 +16,6 @@ config INTEL_IOMMU
 	select DMAR_TABLE
 	select SWIOTLB
 	select IOASID
-	select IOMMU_DMA
 	select PCI_ATS
 	help
 	  DMA remapping (DMAR) devices support enables independent address
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
