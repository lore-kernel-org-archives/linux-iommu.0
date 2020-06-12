Return-Path: <SRS0=hcXW=7Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238CFC433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Jun 2020 23:15:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E51D9206D7
	for <iommu@archiver.kernel.org>; Fri, 12 Jun 2020 23:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/9Ki1us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51D9206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BEAE787DC0;
	Fri, 12 Jun 2020 23:15:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x5PsWPNBhoIG; Fri, 12 Jun 2020 23:15:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 23E0887C98;
	Fri, 12 Jun 2020 23:15:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FBA4C0178;
	Fri, 12 Jun 2020 23:15:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41D00C016F
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 23:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 301D888D5D
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 23:15:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n0Obrddzr9S2 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Jun 2020 23:15:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3321E88D27
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 23:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592003752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BIQD4d2xH0X1MAj8QZUOv2clh3zquYurbViFyUiFSeA=;
 b=H/9Ki1usJFZdICjGTrOrwrcWdqBvFMxZ442aqi5AUHVbiHc4kSrUSLug6G8AwTptNVBw9X
 30SNSOg3ztz/oJPr/0tgP3zwGO9R3t1OZKoYvbB8U0xPXjqVK3HEBKNgEw2r3Xtl1LVnFm
 XuC2otqcr9WA/apvidj9kvF4fLjbq6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-5At6G9DnOvC_mVs-5yzU4w-1; Fri, 12 Jun 2020 19:15:41 -0400
X-MC-Unique: 5At6G9DnOvC_mVs-5yzU4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A1FA18A8221;
 Fri, 12 Jun 2020 23:15:40 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-112-134.phx2.redhat.com [10.3.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1F3B5D9C5;
 Fri, 12 Jun 2020 23:15:39 +0000 (UTC)
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 2/2] iommu/amd: Move Kconfig and Makefile bits down into amd
 directory
Date: Fri, 12 Jun 2020 16:11:00 -0700
Message-Id: <20200612231100.293734-3-jsnitsel@redhat.com>
In-Reply-To: <20200612231100.293734-1-jsnitsel@redhat.com>
References: <20200612231100.293734-1-jsnitsel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Move AMD Kconfig and Makefile bits down into the amd directory
with the rest of the AMD specific files.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/Kconfig      | 45 +-------------------------------------
 drivers/iommu/Makefile     |  5 +----
 drivers/iommu/amd/Kconfig  | 44 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd/Makefile |  4 ++++
 4 files changed, 50 insertions(+), 48 deletions(-)
 create mode 100644 drivers/iommu/amd/Kconfig
 create mode 100644 drivers/iommu/amd/Makefile

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index b12d4ec124f6..78a8be0053b3 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -132,50 +132,7 @@ config IOMMU_PGTABLES_L2
 	def_bool y
 	depends on MSM_IOMMU && MMU && SMP && CPU_DCACHE_DISABLE=n
 
-# AMD IOMMU support
-config AMD_IOMMU
-	bool "AMD IOMMU support"
-	select SWIOTLB
-	select PCI_MSI
-	select PCI_ATS
-	select PCI_PRI
-	select PCI_PASID
-	select IOMMU_API
-	select IOMMU_IOVA
-	select IOMMU_DMA
-	depends on X86_64 && PCI && ACPI
-	---help---
-	  With this option you can enable support for AMD IOMMU hardware in
-	  your system. An IOMMU is a hardware component which provides
-	  remapping of DMA memory accesses from devices. With an AMD IOMMU you
-	  can isolate the DMA memory of different devices and protect the
-	  system from misbehaving device drivers or hardware.
-
-	  You can find out if your system has an AMD IOMMU if you look into
-	  your BIOS for an option to enable it or if you have an IVRS ACPI
-	  table.
-
-config AMD_IOMMU_V2
-	tristate "AMD IOMMU Version 2 driver"
-	depends on AMD_IOMMU
-	select MMU_NOTIFIER
-	---help---
-	  This option enables support for the AMD IOMMUv2 features of the IOMMU
-	  hardware. Select this option if you want to use devices that support
-	  the PCI PRI and PASID interface.
-
-config AMD_IOMMU_DEBUGFS
-	bool "Enable AMD IOMMU internals in DebugFS"
-	depends on AMD_IOMMU && IOMMU_DEBUGFS
-	---help---
-	  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!
-
-	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY, -REALLY- KNOW WHAT YOU ARE DOING!!!
-	  Exposes AMD IOMMU device internals in DebugFS.
-
-	  This option is -NOT- intended for production environments, and should
-	  not generally be enabled.
-
+source "drivers/iommu/amd/Kconfig"
 source "drivers/iommu/intel/Kconfig"
 
 config IRQ_REMAP
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 71dd2f382e78..f356bc12b1c7 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y += intel/
+obj-y += amd/ intel/
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
@@ -12,9 +12,6 @@ obj-$(CONFIG_IOASID) += ioasid.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
-obj-$(CONFIG_AMD_IOMMU) += amd/iommu.o amd/init.o amd/quirks.o
-obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd/debugfs.o
-obj-$(CONFIG_AMD_IOMMU_V2) += amd/iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
 arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
new file mode 100644
index 000000000000..1f061d91e0b8
--- /dev/null
+++ b/drivers/iommu/amd/Kconfig
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# AMD IOMMU support
+config AMD_IOMMU
+	bool "AMD IOMMU support"
+	select SWIOTLB
+	select PCI_MSI
+	select PCI_ATS
+	select PCI_PRI
+	select PCI_PASID
+	select IOMMU_API
+	select IOMMU_IOVA
+	select IOMMU_DMA
+	depends on X86_64 && PCI && ACPI
+	help
+	  With this option you can enable support for AMD IOMMU hardware in
+	  your system. An IOMMU is a hardware component which provides
+	  remapping of DMA memory accesses from devices. With an AMD IOMMU you
+	  can isolate the DMA memory of different devices and protect the
+	  system from misbehaving device drivers or hardware.
+
+	  You can find out if your system has an AMD IOMMU if you look into
+	  your BIOS for an option to enable it or if you have an IVRS ACPI
+	  table.
+
+config AMD_IOMMU_V2
+	tristate "AMD IOMMU Version 2 driver"
+	depends on AMD_IOMMU
+	select MMU_NOTIFIER
+	help
+	  This option enables support for the AMD IOMMUv2 features of the IOMMU
+	  hardware. Select this option if you want to use devices that support
+	  the PCI PRI and PASID interface.
+
+config AMD_IOMMU_DEBUGFS
+	bool "Enable AMD IOMMU internals in DebugFS"
+	depends on AMD_IOMMU && IOMMU_DEBUGFS
+	help
+	  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!
+
+	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY, -REALLY- KNOW WHAT YOU ARE DOING!!!
+	  Exposes AMD IOMMU device internals in DebugFS.
+
+	  This option is -NOT- intended for production environments, and should
+	  not generally be enabled.
diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
new file mode 100644
index 000000000000..552f68ddcefd
--- /dev/null
+++ b/drivers/iommu/amd/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o
+obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
+obj-$(CONFIG_AMD_IOMMU_V2) += iommu_v2.o
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
