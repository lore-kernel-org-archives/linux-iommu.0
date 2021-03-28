Return-Path: <SRS0=8IIh=I2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F034C433C1
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 07:41:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246A461972
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 07:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246A461972
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19C6083D17;
	Sun, 28 Mar 2021 07:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DvXPCjCO6zN7; Sun, 28 Mar 2021 07:41:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1868383D21;
	Sun, 28 Mar 2021 07:41:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7D5BC000C;
	Sun, 28 Mar 2021 07:41:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 718CFC000C
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 07:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5310E83D0E
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 07:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bGkLTKUfzxrF for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 07:41:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79A4983D17
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 07:40:47 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 1BB1A580837;
 Sun, 28 Mar 2021 03:40:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sun, 28 Mar 2021 03:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=Vy6E0MxWbRhX4
 RoI6Yq5IaYmb034bjKM5sp0Hah9+WQ=; b=EqP4X8k5xnFPIViuK10Vtxsgq5iYh
 jUoi6eybBLMtvlHsjzj1KXkpYPhQase06K/uzWuOwDJeriquTjYne6je7W3CMEO/
 Pya8LllWhNPm2KTOmQU72UMVS+PWqzVIfRh7hvHQj0y83JRcarBvtQ73YP6eFsph
 d21jiBHPVAXcaebLN68OgjUmsebkGDd/QEq4atgbg9rhZDrMsujI7D2kEHuTv/3I
 cdZtJnLsZbBlvBrjI9va7gS7mSGsvvWwFpcUdanCS6KPzxXMIcDFQZGd2BHh0IQB
 tNxxAu40XavZjMYtEyVOlWglEamTKuNIaUXYRZE9IuZIwm09nbfrq329Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=Vy6E0MxWbRhX4RoI6Yq5IaYmb034bjKM5sp0Hah9+WQ=; b=IUSrIXf7
 JzhFSVVgcLuE7QAxzQaZ8YKynbYe5TY9+NqU0ZtPK2EPSaYaZVwLqKM+STWIElHh
 6OywUaTff/f5F/JhhaOwu2U+kzNsweUYcHE4/O9j+y+qd0TCy30hNFcBMJhSKoDD
 leqpQ5SmS2CaOndbuSD2SYYx6Ww7wmJRVWzGvPAED96o1I7OHr6/rQPPTEzp/4KZ
 yFIlCR9SqSXGqwcjlEKSHVRvn+RU/fGRI+hlHF3Fe+Ccqtvzs2JWu7mqjQlgm+OA
 TRJCgVEx0fryywer8zeJ5gAQckie+uwrH0IWK1FG/mVkpx8i6O1tFhhyOBPhXaB0
 qMi7jzg0Np/0+Q==
X-ME-Sender: <xms:_jJgYLY0e-jE9KDLvKbbZGyvK-bWiUmbiqeSjvwDCZ86LqFPFl-pUg>
 <xme:_jJgYKYRj2FbR1p9kibuCl1dwwmwbyCwmEVQw5YsHkCN7SFjkN9KxgV1NK2L8s_6I
 CJjNaTB2hse7B5RSKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehhedguddutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
 ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
 gvrhhnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfef
 jeenucfkphepudejiedrudelledrvddutddrudehieenucevlhhushhtvghrufhiiigvpe
 dunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggv
 vh
X-ME-Proxy: <xmx:_jJgYN__LUR3GGMBJwVuGU8E2nInOr-DiG8Qx7Uz9Fczqb-l2094Qw>
 <xmx:_jJgYBq47-PP63eUxiqUp_raNFxWcNlhHAids5flEo73y0TjfqL2tg>
 <xmx:_jJgYGqDtOwqu8WOUJ4CEKAqdt9yuHFvVHKws8J02IBolHCRv-e3Iw>
 <xmx:_jJgYMhlG_G_bSG7jcVuTvWveE6Iwe7IgOLUE6UpeG7Ka2DnqBERJDSOsGA>
Received: from localhost.localdomain
 (ip-176-199-210-156.hsi06.unitymediagroup.de [176.199.210.156])
 by mail.messagingengine.com (Postfix) with ESMTPA id EBEBD240057;
 Sun, 28 Mar 2021 03:40:43 -0400 (EDT)
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 3/3] iommu: dart: Add DART iommu driver
Date: Sun, 28 Mar 2021 09:40:09 +0200
Message-Id: <20210328074009.95932-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210328074009.95932-1-sven@svenpeter.dev>
References: <20210328074009.95932-1-sven@svenpeter.dev>
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Sven Peter <sven@svenpeter.dev>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, linux-arm-kernel@lists.infradead.org,
 Stan Skowronek <stan@corellium.com>
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Apple's new SoCs use iommus for almost all peripherals. These Device
Address Resolution Tables must be setup before these peripherals can
act as DMA masters.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS                      |   1 +
 drivers/iommu/Kconfig            |  14 +
 drivers/iommu/Makefile           |   1 +
 drivers/iommu/apple-dart-iommu.c | 858 +++++++++++++++++++++++++++++++
 4 files changed, 874 insertions(+)
 create mode 100644 drivers/iommu/apple-dart-iommu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f5397328fa1f..70747b8ac0ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1241,6 +1241,7 @@ M:	Sven Peter <sven@svenpeter.dev>
 L:	iommu@lists.linux-foundation.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iommu/apple,t8103-dart.yaml
+F:	drivers/iommu/apple-dart-iommu.c
 
 APPLE SMC DRIVER
 M:	Henrik Rydberg <rydberg@bitmath.org>
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 192ef8f61310..a1b239147dbc 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -249,6 +249,20 @@ config SPAPR_TCE_IOMMU
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
 	  is not implemented as it is not necessary for VFIO.
 
+config IOMMU_APPLE_DART
+	tristate "Apple DART IOMMU Support"
+	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
+	select IOMMU_API
+	select IOMMU_IO_PGTABLE
+	select IOMMU_IO_PGTABLE_LPAE
+	help
+	  Support for Apple DART (Device Address Resolution Table) IOMMUs
+	  found in Apple ARM SoCs like the M1.
+	  This IOMMU is required for most peripherals using DMA to access
+	  the main memory.
+
+	  Say Y here if you are using an Apple SoC with a DART IOMMU.
+
 # ARM IOMMU support
 config ARM_SMMU
 	tristate "ARM Ltd. System MMU (SMMU) Support"
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 61bd30cd8369..5f21f0dfec6a 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
 obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o
+obj-$(CONFIG_IOMMU_APPLE_DART) += apple-dart-iommu.o
diff --git a/drivers/iommu/apple-dart-iommu.c b/drivers/iommu/apple-dart-iommu.c
new file mode 100644
index 000000000000..05fb8ca44843
--- /dev/null
+++ b/drivers/iommu/apple-dart-iommu.c
@@ -0,0 +1,858 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Apple DART (Device Address Resolution Table) IOMMU driver
+ *
+ * Copyright (C) 2021 The Asahi Linux Contributors
+ *
+ * Based on arm/arm-smmu/arm-ssmu.c and arm/arm-smmu-v3/arm-smmu-v3.c
+ *  Copyright (C) 2013 ARM Limited
+ *  Copyright (C) 2015 ARM Limited
+ * and on exynos-iommu.c
+ *  Copyright (c) 2011,2016 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/dma-iommu.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io-pgtable.h>
+#include <linux/iopoll.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_iommu.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/ratelimit.h>
+
+#define DART_MAX_STREAMS 16
+#define DART_MAX_TTBR 4
+
+#define DART_STREAM_ALL 0xffff
+
+#define DART_CONFIG 0x60
+#define DART_CONFIG_LOCK BIT(15)
+
+#define DART_ERROR 0x40
+#define DART_ERROR_STREAM_SHIFT 24
+#define DART_ERROR_STREAM_MASK 0xf
+#define DART_ERROR_CODE_MASK 0xffffff
+#define DART_ERROR_FLAG BIT(31)
+#define DART_ERROR_READ_FAULT BIT(4)
+#define DART_ERROR_WRITE_FAULT BIT(3)
+#define DART_ERROR_NO_PTE BIT(2)
+#define DART_ERROR_NO_PMD BIT(1)
+#define DART_ERROR_NO_TTBR BIT(0)
+
+#define DART_STREAM_SELECT 0x34
+
+#define DART_STREAM_COMMAND 0x20
+#define DART_STREAM_COMMAND_BUSY BIT(2)
+#define DART_STREAM_COMMAND_INVALIDATE BIT(20)
+
+#define DART_STREAM_COMMAND_BUSY_TIMEOUT 100
+
+#define DART_STREAM_REMAP 0x80
+
+#define DART_ERROR_ADDR_HI 0x54
+#define DART_ERROR_ADDR_LO 0x50
+
+#define DART_TCR(sid) (0x100 + 4 * (sid))
+#define DART_TCR_TRANSLATE_ENABLE BIT(7)
+#define DART_TCR_BYPASS0_ENABLE BIT(8)
+#define DART_TCR_BYPASS1_ENABLE BIT(12)
+
+#define DART_TTBR(sid, idx) (0x200 + 16 * (sid) + 4 * (idx))
+#define DART_TTBR_VALID BIT(31)
+#define DART_TTBR_SHIFT 12
+
+/*
+ * Private structure associated with each DART device.
+ *
+ * @dev: device struct
+ * @regs: mapped MMIO region
+ * @irq: interrupt number, can be shared with other DARTs
+ * @clks: clocks associated with this DART
+ * @num_clks: number of @clks
+ * @lock: lock for @used_sids and hardware operations involving this dart
+ * @used_sids: bitmap of streams attached to a domain
+ * @iommu: iommu core device
+ */
+struct apple_dart {
+	struct device *dev;
+
+	void __iomem *regs;
+
+	int irq;
+	struct clk_bulk_data *clks;
+	int num_clks;
+
+	spinlock_t lock;
+
+	u32 used_sids;
+
+	struct iommu_device iommu;
+};
+
+/*
+ * This structure is used to identify a single stream attached to a domain.
+ * It's used as a list inside that domain to be able to attach multiple
+ * streams to a single domain. Since multiple devices can use a single stream
+ * it additionally keeps track of how many devices are represented by this
+ * stream. Once that number reaches zero it is detached from the IOMMU domain
+ * and all translations from this stream are disabled.
+ *
+ * @dart: DART instance to which this stream belongs
+ * @sid: stream id within the DART instance
+ * @num_devices: count of devices attached to this stream
+ * @stream_head: list head for the next stream
+ */
+struct apple_dart_stream {
+	struct apple_dart *dart;
+	u32 sid;
+
+	u32 num_devices;
+
+	struct list_head stream_head;
+};
+
+/*
+ * This structure is attached to each iommu domain handled by a DART.
+ * A single domain is used to represent a single virtual address spaces.
+ * It is always allocated together with a page table.
+ *
+ * Streams are the smallest units the DART hardware can differentiate.
+ * These are pointed to the page table of a domain whenever a device is
+ * attached to it. A single stream can only be assigned to a single domain.
+ *
+ * Devices are assigned to at least a single and sometimes multiple individual
+ * streams (using the iommus property in the device tree). Multiple devices
+ * can theoretically be represented by the same stream, though this is usually
+ * not the case.
+ *
+ * We only keep track of streams here and just count how many devices are
+ * represented by each stream. When the last device is removed the whole stream
+ * is removed from the domain.
+ *
+ * @dart: pointer to the DART instance
+ * @pgtbl_ops: pagetable ops allocated by io-pgtable
+ * @type: domain type IOMMU_DOMAIN_IDENTITY_{IDENTITY,DMA,UNMANAGED,BLOCKED}
+ * @streams: list of streams attached to this domain
+ * @lock: spinlock for operations involving the list of streams
+ * @domain: core iommu domain pointer
+ */
+struct apple_dart_domain {
+	struct apple_dart *dart;
+	struct io_pgtable_ops *pgtbl_ops;
+
+	unsigned int type;
+
+	struct list_head streams;
+
+	spinlock_t lock;
+
+	struct iommu_domain domain;
+};
+
+/*
+ * This structure is attached to devices with dev_iommu_priv_set() on of_xlate
+ * and contains a list of streams bound to this device as defined in the
+ * device tree. Multiple DART instances can be attached to a single device
+ * and each stream is identified by its stream id.
+ * It's usually reference by a pointer called *cfg.
+ *
+ * A dynamic array instead of a linked list is used here since in almost
+ * all cases a device will just be attached to a single stream and streams
+ * are never removed after they have been added.
+ *
+ * @num_streams: number of streams attached
+ * @streams: array of structs to identify attached streams and the device link
+ *           to the iommu
+ */
+struct apple_dart_master_cfg {
+	int num_streams;
+	struct {
+		struct apple_dart *dart;
+		u32 sid;
+
+		struct device_link *link;
+	} streams[];
+};
+
+static struct platform_driver apple_dart_driver;
+static const struct iommu_ops apple_dart_iommu_ops;
+
+static struct apple_dart_domain *to_dart_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct apple_dart_domain, domain);
+}
+
+static void apple_dart_hw_enable_translation(struct apple_dart *dart, u16 sid)
+{
+	writel(DART_TCR_TRANSLATE_ENABLE, dart->regs + DART_TCR(sid));
+}
+
+static void apple_dart_hw_enable_isolation(struct apple_dart *dart, u16 sid)
+{
+	writel(0, dart->regs + DART_TCR(sid));
+}
+
+static void apple_dart_hw_enable_bypass(struct apple_dart *dart, u16 sid)
+{
+	writel(DART_TCR_BYPASS0_ENABLE | DART_TCR_BYPASS1_ENABLE,
+	       dart->regs + DART_TCR(sid));
+}
+
+static void apple_dart_hw_set_ttbr(struct apple_dart *dart, u16 sid, u16 idx,
+				   phys_addr_t paddr)
+{
+	writel(DART_TTBR_VALID | (paddr >> DART_TTBR_SHIFT),
+	       dart->regs + DART_TTBR(sid, idx));
+}
+
+static void apple_dart_hw_clear_ttbr(struct apple_dart *dart, u16 sid, u16 idx)
+{
+	writel(0, dart->regs + DART_TTBR(sid, idx));
+}
+
+static void apple_dart_hw_clear_all_ttbrs(struct apple_dart *dart, u16 sid)
+{
+	int i;
+
+	for (i = 0; i < 4; ++i)
+		apple_dart_hw_clear_ttbr(dart, sid, i);
+}
+
+static int apple_dart_hw_stream_command(struct apple_dart *dart, u16 sid_bitmap,
+					u32 command)
+{
+	unsigned long flags;
+	int ret;
+	u32 command_reg;
+
+	spin_lock_irqsave(&dart->lock, flags);
+
+	writel(sid_bitmap, dart->regs + DART_STREAM_SELECT);
+	writel(command, dart->regs + DART_STREAM_COMMAND);
+
+	ret = readl_poll_timeout(dart->regs + DART_STREAM_COMMAND, command_reg,
+				 !(command_reg & DART_STREAM_COMMAND_BUSY), 1,
+				 DART_STREAM_COMMAND_BUSY_TIMEOUT);
+
+	spin_unlock_irqrestore(&dart->lock, flags);
+
+	if (ret) {
+		dev_err(dart->dev,
+			"busy bit did not clear after command %x for streams %x\n",
+			command, sid_bitmap);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int apple_dart_hw_invalidate_tlb_global(struct apple_dart *dart)
+{
+	return apple_dart_hw_stream_command(dart, DART_STREAM_ALL,
+					    DART_STREAM_COMMAND_INVALIDATE);
+}
+
+static int apple_dart_hw_invalidate_tlb_stream(struct apple_dart *dart, u16 sid)
+{
+	return apple_dart_hw_stream_command(dart, 1 << sid,
+					    DART_STREAM_COMMAND_INVALIDATE);
+}
+
+static int apple_dart_hw_reset(struct apple_dart *dart)
+{
+	int sid;
+	u32 config;
+
+	config = readl(dart->regs + DART_CONFIG);
+	if (config & DART_CONFIG_LOCK) {
+		dev_err(dart->dev, "DART is locked down until reboot: %08x\n",
+			config);
+		return -EINVAL;
+	}
+
+	for (sid = 0; sid < DART_MAX_STREAMS; ++sid) {
+		apple_dart_hw_enable_isolation(dart, sid);
+		apple_dart_hw_clear_all_ttbrs(dart, sid);
+	}
+
+	/* restore stream identity map */
+	writel(0x03020100, dart->regs + DART_STREAM_REMAP);
+	writel(0x07060504, dart->regs + DART_STREAM_REMAP + 4);
+	writel(0x0b0a0908, dart->regs + DART_STREAM_REMAP + 8);
+	writel(0x0f0e0d0c, dart->regs + DART_STREAM_REMAP + 12);
+
+	/* clear any pending errors before the interrupt is unmasked */
+	writel(readl(dart->regs + DART_ERROR), dart->regs + DART_ERROR);
+
+	return apple_dart_hw_invalidate_tlb_global(dart);
+}
+
+static void apple_dart_domain_flush_tlb(struct apple_dart_domain *domain)
+{
+	unsigned long flags;
+	struct apple_dart_stream *stream;
+	struct apple_dart *dart = domain->dart;
+
+	if (!dart)
+		return;
+
+	spin_lock_irqsave(&domain->lock, flags);
+	list_for_each_entry(stream, &domain->streams, stream_head) {
+		apple_dart_hw_invalidate_tlb_stream(stream->dart, stream->sid);
+	}
+	spin_unlock_irqrestore(&domain->lock, flags);
+}
+
+static void apple_dart_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+
+	apple_dart_domain_flush_tlb(dart_domain);
+}
+
+static void apple_dart_iotlb_sync(struct iommu_domain *domain,
+				  struct iommu_iotlb_gather *gather)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+
+	apple_dart_domain_flush_tlb(dart_domain);
+}
+
+static void apple_dart_iotlb_sync_map(struct iommu_domain *domain,
+				      unsigned long iova, size_t size)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+
+	apple_dart_domain_flush_tlb(dart_domain);
+}
+
+static void apple_dart_tlb_flush_all(void *cookie)
+{
+	struct apple_dart_domain *domain = cookie;
+
+	apple_dart_domain_flush_tlb(domain);
+}
+
+static void apple_dart_tlb_flush_walk(unsigned long iova, size_t size,
+				      size_t granule, void *cookie)
+{
+	struct apple_dart_domain *domain = cookie;
+
+	apple_dart_domain_flush_tlb(domain);
+}
+
+static const struct iommu_flush_ops apple_dart_tlb_ops = {
+	.tlb_flush_all = apple_dart_tlb_flush_all,
+	.tlb_flush_walk = apple_dart_tlb_flush_walk,
+	.tlb_add_page = NULL,
+};
+
+static phys_addr_t apple_dart_iova_to_phys(struct iommu_domain *domain,
+					   dma_addr_t iova)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
+
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+		return iova;
+	if (!ops)
+		return -ENODEV;
+
+	return ops->iova_to_phys(ops, iova);
+}
+
+static int apple_dart_map(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
+
+	if (!ops)
+		return -ENODEV;
+	if (prot & IOMMU_MMIO)
+		return -EINVAL;
+	if (prot & IOMMU_NOEXEC)
+		return -EINVAL;
+
+	return ops->map(ops, iova, paddr, size, prot, gfp);
+}
+
+static size_t apple_dart_unmap(struct iommu_domain *domain, unsigned long iova,
+			       size_t size, struct iommu_iotlb_gather *gather)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
+
+	if (!ops)
+		return 0;
+
+	return ops->unmap(ops, iova, size, gather);
+}
+
+/* must be called with held dart_domain->lock */
+static int apple_dart_finalize_domain(struct iommu_domain *domain)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+	struct apple_dart *dart = dart_domain->dart;
+	struct io_pgtable_cfg pgtbl_cfg;
+
+	if (dart_domain->pgtbl_ops)
+		return 0;
+	if (dart_domain->type != IOMMU_DOMAIN_DMA &&
+	    dart_domain->type != IOMMU_DOMAIN_UNMANAGED)
+		return 0;
+
+	pgtbl_cfg = (struct io_pgtable_cfg){
+		.pgsize_bitmap = SZ_16K,
+		.ias = 32,
+		.oas = 36,
+		.coherent_walk = 1,
+		.tlb = &apple_dart_tlb_ops,
+		.iommu_dev = dart->dev,
+	};
+
+	dart_domain->pgtbl_ops =
+		alloc_io_pgtable_ops(ARM_APPLE_DART, &pgtbl_cfg, domain);
+	if (!dart_domain->pgtbl_ops)
+		return -ENOMEM;
+
+	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
+	domain->geometry.aperture_start = 0;
+	domain->geometry.aperture_end = DMA_BIT_MASK(32);
+	domain->geometry.force_aperture = true;
+
+	return 0;
+}
+
+/* must be called with held domain->lock */
+static int apple_dart_attach_stream(struct apple_dart_domain *domain,
+				    struct apple_dart *dart, u32 sid)
+{
+	unsigned long flags;
+	struct apple_dart_stream *stream;
+	struct io_pgtable_cfg *pgtbl_cfg;
+	int ret;
+
+	list_for_each_entry(stream, &domain->streams, stream_head) {
+		if (stream->dart == dart && stream->sid == sid) {
+			stream->num_devices++;
+			return 0;
+		}
+	}
+
+	spin_lock_irqsave(&dart->lock, flags);
+
+	if (WARN_ON(dart->used_sids & BIT(sid))) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	stream->dart = dart;
+	stream->sid = sid;
+	stream->num_devices = 1;
+	list_add(&stream->stream_head, &domain->streams);
+
+	dart->used_sids |= BIT(sid);
+	spin_unlock_irqrestore(&dart->lock, flags);
+
+	apple_dart_hw_clear_all_ttbrs(stream->dart, stream->sid);
+
+	switch (domain->type) {
+	case IOMMU_DOMAIN_IDENTITY:
+		apple_dart_hw_enable_bypass(stream->dart, stream->sid);
+		break;
+	case IOMMU_DOMAIN_BLOCKED:
+		apple_dart_hw_enable_isolation(stream->dart, stream->sid);
+		break;
+	case IOMMU_DOMAIN_UNMANAGED:
+	case IOMMU_DOMAIN_DMA:
+		pgtbl_cfg = &io_pgtable_ops_to_pgtable(domain->pgtbl_ops)->cfg;
+		apple_dart_hw_set_ttbr(stream->dart, stream->sid, 0,
+				       pgtbl_cfg->apple_dart_cfg.ttbr);
+
+		apple_dart_hw_enable_translation(stream->dart, stream->sid);
+		apple_dart_hw_invalidate_tlb_stream(stream->dart, stream->sid);
+		break;
+	}
+
+	return 0;
+
+error:
+	spin_unlock_irqrestore(&dart->lock, flags);
+	return ret;
+}
+
+static void apple_dart_disable_stream(struct apple_dart *dart, u32 sid)
+{
+	unsigned long flags;
+
+	apple_dart_hw_enable_isolation(dart, sid);
+	apple_dart_hw_clear_all_ttbrs(dart, sid);
+	apple_dart_hw_invalidate_tlb_stream(dart, sid);
+
+	spin_lock_irqsave(&dart->lock, flags);
+	dart->used_sids &= ~BIT(sid);
+	spin_unlock_irqrestore(&dart->lock, flags);
+}
+
+/* must be called with held domain->lock */
+static void apple_dart_detach_stream(struct apple_dart_domain *domain,
+				     struct apple_dart *dart, u32 sid)
+{
+	struct apple_dart_stream *stream;
+
+	list_for_each_entry(stream, &domain->streams, stream_head) {
+		if (stream->dart == dart && stream->sid == sid) {
+			stream->num_devices--;
+
+			if (stream->num_devices == 0) {
+				apple_dart_disable_stream(dart, sid);
+				list_del(&stream->stream_head);
+				kfree(stream);
+			}
+			return;
+		}
+	}
+}
+
+static int apple_dart_attach_dev(struct iommu_domain *domain,
+				 struct device *dev)
+{
+	int ret;
+	int i, j;
+	unsigned long flags;
+	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+	struct apple_dart *dart = cfg->streams[0].dart;
+
+	spin_lock_irqsave(&dart_domain->lock, flags);
+
+	if (!dart_domain->dart)
+		dart_domain->dart = dart;
+
+	ret = apple_dart_finalize_domain(domain);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < cfg->num_streams; ++i) {
+		ret = apple_dart_attach_stream(
+			dart_domain, cfg->streams[i].dart, cfg->streams[i].sid);
+		if (ret) {
+			/* try to undo what we did before returning */
+			for (j = 0; j < i; ++j)
+				apple_dart_detach_stream(dart_domain,
+							 cfg->streams[j].dart,
+							 cfg->streams[j].sid);
+
+			goto out;
+		}
+	}
+
+	ret = 0;
+
+out:
+	spin_unlock_irqrestore(&dart_domain->lock, flags);
+	return ret;
+}
+
+static void apple_dart_detach_dev(struct iommu_domain *domain,
+				  struct device *dev)
+{
+	int i;
+	unsigned long flags;
+	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+
+	spin_lock_irqsave(&dart_domain->lock, flags);
+
+	for (i = 0; i < cfg->num_streams; ++i)
+		apple_dart_detach_stream(dart_domain, cfg->streams[i].dart,
+					 cfg->streams[i].sid);
+
+	spin_unlock_irqrestore(&dart_domain->lock, flags);
+}
+
+static struct iommu_device *apple_dart_probe_device(struct device *dev)
+{
+	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
+	int i;
+
+	if (!cfg)
+		return ERR_PTR(-ENODEV);
+
+	for (i = 0; i < cfg->num_streams; ++i) {
+		cfg->streams[i].link =
+			device_link_add(dev, cfg->streams[i].dart->dev,
+					DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
+	}
+
+	return &cfg->streams[0].dart->iommu;
+}
+
+static void apple_dart_release_device(struct device *dev)
+{
+	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
+	int i;
+
+	if (!cfg)
+		return;
+
+	for (i = 0; i < cfg->num_streams; ++i)
+		device_link_del(cfg->streams[i].link);
+
+	dev_iommu_priv_set(dev, NULL);
+	kfree(cfg);
+}
+
+static struct iommu_domain *apple_dart_domain_alloc(unsigned int type)
+{
+	struct apple_dart_domain *dart_domain;
+
+	if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED &&
+	    type != IOMMU_DOMAIN_IDENTITY && type != IOMMU_DOMAIN_BLOCKED)
+		return NULL;
+
+	dart_domain = kzalloc(sizeof(*dart_domain), GFP_KERNEL);
+	if (!dart_domain)
+		return NULL;
+
+	INIT_LIST_HEAD(&dart_domain->streams);
+	spin_lock_init(&dart_domain->lock);
+	iommu_get_dma_cookie(&dart_domain->domain);
+	dart_domain->type = type;
+
+	return &dart_domain->domain;
+}
+
+static void apple_dart_domain_free(struct iommu_domain *domain)
+{
+	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
+
+	WARN_ON(!list_empty(&dart_domain->streams));
+
+	kfree(dart_domain);
+}
+
+static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
+{
+	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
+	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
+	struct apple_dart_master_cfg *cfg_new;
+	struct apple_dart *dart = platform_get_drvdata(iommu_pdev);
+
+	if (args->args_count != 1)
+		return -EINVAL;
+
+	if (cfg == NULL) {
+		cfg = kzalloc(struct_size(cfg, streams, 1), GFP_KERNEL);
+		if (!cfg)
+			return -ENOMEM;
+	} else {
+		cfg_new = krealloc(
+			cfg, struct_size(cfg, streams, cfg->num_streams + 1),
+			GFP_KERNEL);
+		if (!cfg_new)
+			return -ENOMEM;
+
+		cfg = cfg_new;
+	}
+
+	dev_iommu_priv_set(dev, cfg);
+
+	cfg->streams[cfg->num_streams].dart = dart;
+	cfg->streams[cfg->num_streams].sid = args->args[0];
+	cfg->num_streams++;
+
+	return 0;
+}
+
+static struct iommu_group *apple_dart_device_group(struct device *dev)
+{
+	/* once we have PCI support this needs to use pci_device_group conditionally */
+	return generic_device_group(dev);
+}
+
+static const struct iommu_ops apple_dart_iommu_ops = {
+	.domain_alloc = apple_dart_domain_alloc,
+	.domain_free = apple_dart_domain_free,
+	.attach_dev = apple_dart_attach_dev,
+	.detach_dev = apple_dart_detach_dev,
+	.map = apple_dart_map,
+	.unmap = apple_dart_unmap,
+	.flush_iotlb_all = apple_dart_flush_iotlb_all,
+	.iotlb_sync = apple_dart_iotlb_sync,
+	.iotlb_sync_map = apple_dart_iotlb_sync_map,
+	.iova_to_phys = apple_dart_iova_to_phys,
+	.probe_device = apple_dart_probe_device,
+	.release_device = apple_dart_release_device,
+	.device_group = apple_dart_device_group,
+	.of_xlate = apple_dart_of_xlate,
+	.pgsize_bitmap = SZ_16K,
+};
+
+static irqreturn_t apple_dart_irq(int irq, void *dev)
+{
+	struct apple_dart *dart = dev;
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
+	const char *fault_name = NULL;
+	u32 error = readl(dart->regs + DART_ERROR);
+	u32 error_code = error & DART_ERROR_CODE_MASK;
+	u32 addr_lo = readl(dart->regs + DART_ERROR_ADDR_LO);
+	u32 addr_hi = readl(dart->regs + DART_ERROR_ADDR_HI);
+	u64 addr = addr_lo | (((u64)addr_hi) << 32);
+	u8 domain_idx =
+		(error >> DART_ERROR_STREAM_SHIFT) & DART_ERROR_STREAM_MASK;
+
+	if (!(error & DART_ERROR_FLAG))
+		return IRQ_NONE;
+
+	if (error_code & DART_ERROR_READ_FAULT)
+		fault_name = "READ FAULT";
+	else if (error_code & DART_ERROR_WRITE_FAULT)
+		fault_name = "WRITE FAULT";
+	else if (error_code & DART_ERROR_NO_PTE)
+		fault_name = "NO PTE FOR IOVA";
+	else if (error_code & DART_ERROR_NO_PMD)
+		fault_name = "NO PMD FOR IOVA";
+	else if (error_code & DART_ERROR_NO_TTBR)
+		fault_name = "NO TTBR FOR IOVA";
+
+	if (WARN_ON(fault_name == NULL))
+		fault_name = "unknown";
+
+	if (__ratelimit(&rs)) {
+		dev_err(dart->dev,
+			"translation fault: status:0x%x stream:%d code:0x%x (%s) at 0x%llx",
+			error, domain_idx, error_code, fault_name, addr);
+	}
+
+	writel(error, dart->regs + DART_ERROR);
+	return IRQ_HANDLED;
+}
+
+static int apple_dart_probe(struct platform_device *pdev)
+{
+	int ret;
+	int i;
+	struct resource *res;
+	struct apple_dart *dart;
+	struct device *dev = &pdev->dev;
+
+	dart = devm_kzalloc(dev, sizeof(*dart), GFP_KERNEL);
+	if (!dart)
+		return -ENOMEM;
+
+	dart->dev = dev;
+	spin_lock_init(&dart->lock);
+
+	if (pdev->num_resources < 1)
+		return -ENODEV;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+	if (resource_size(res) < 0x4000) {
+		dev_err(dev, "MMIO region too small (%pr)\n", res);
+		return -EINVAL;
+	}
+
+	dart->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dart->regs))
+		return PTR_ERR(dart->regs);
+
+	ret = devm_clk_bulk_get_all(dev, &dart->clks);
+	if (ret < 0)
+		return ret;
+	dart->num_clks = ret;
+
+	ret = clk_bulk_prepare_enable(dart->num_clks, dart->clks);
+	if (ret)
+		return ret;
+
+	ret = apple_dart_hw_reset(dart);
+	if (ret)
+		return ret;
+
+	dart->irq = platform_get_irq(pdev, 0);
+	if (dart->irq < 0)
+		return -ENODEV;
+
+	ret = devm_request_irq(dart->dev, dart->irq, apple_dart_irq,
+			       IRQF_SHARED, "apple-dart fault handler", dart);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, dart);
+
+	ret = iommu_device_sysfs_add(&dart->iommu, dev, NULL, "apple-dart.%s",
+				     dev_name(&pdev->dev));
+	if (ret)
+		return ret;
+
+	iommu_device_set_ops(&dart->iommu, &apple_dart_iommu_ops);
+	iommu_device_set_fwnode(&dart->iommu, dev->fwnode);
+
+	ret = iommu_device_register(&dart->iommu);
+	if (ret)
+		return ret;
+
+	if (dev->bus->iommu_ops != &apple_dart_iommu_ops) {
+		ret = bus_set_iommu(dev->bus, &apple_dart_iommu_ops);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int apple_dart_remove(struct platform_device *pdev)
+{
+	struct apple_dart *dart = platform_get_drvdata(pdev);
+
+	devm_free_irq(dart->dev, dart->irq, dart);
+
+	iommu_device_unregister(&dart->iommu);
+	iommu_device_sysfs_remove(&dart->iommu);
+
+	clk_bulk_disable(dart->num_clks, dart->clks);
+	clk_bulk_unprepare(dart->num_clks, dart->clks);
+
+	return 0;
+}
+
+static void apple_dart_shutdown(struct platform_device *pdev)
+{
+	apple_dart_remove(pdev);
+}
+
+static const struct of_device_id apple_dart_of_match[] = {
+	{ .compatible = "apple,t8103-dart", .data = NULL },
+	{},
+};
+MODULE_DEVICE_TABLE(of, apple_dart_of_match);
+
+static struct platform_driver apple_dart_driver = {
+	.driver	= {
+		.name			= "apple-dart",
+		.of_match_table		= apple_dart_of_match,
+	},
+	.probe	= apple_dart_probe,
+	.remove	= apple_dart_remove,
+	.shutdown = apple_dart_shutdown,
+};
+module_platform_driver(apple_dart_driver);
+
+MODULE_DESCRIPTION("IOMMU API for Apple's DART");
+MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
