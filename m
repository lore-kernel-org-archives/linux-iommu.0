Return-Path: <SRS0=nHvM=OY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CFFC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 10:07:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F086120A
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 10:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31F086120A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0C9942761;
	Mon,  4 Oct 2021 10:07:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FR3Jr6QW5fzT; Mon,  4 Oct 2021 10:07:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B243E42730;
	Mon,  4 Oct 2021 10:07:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76DF9C0011;
	Mon,  4 Oct 2021 10:07:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40B79C000D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 10:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F36142731
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 10:07:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qsueGAK5Tcyk for <iommu@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 10:07:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F2DA442730
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 10:07:27 +0000 (UTC)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
 id 140507F54C; Mon,  4 Oct 2021 13:07:24 +0300 (EEST)
Date: Mon, 4 Oct 2021 13:07:24 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Joerg Roedel <joro@8bytes.org>,
 "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2] iommu/amd: Recover from event log overflow
Message-ID: <YVrSXEdW2rzEfOvk@wantstofly.org>
MIME-Version: 1.0
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org
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

The AMD IOMMU logs I/O page faults and such to a ring buffer in
system memory, and this ring buffer can overflow.  The AMD IOMMU
spec has the following to say about the interrupt status bit that
signals this overflow condition:

	EventOverflow: Event log overflow. RW1C. Reset 0b. 1 = IOMMU
	event log overflow has occurred. This bit is set when a new
	event is to be written to the event log and there is no usable
	entry in the event log, causing the new event information to
	be discarded. An interrupt is generated when EventOverflow = 1b
	and MMIO Offset 0018h[EventIntEn] = 1b. No new event log
	entries are written while this bit is set. Software Note: To
	resume logging, clear EventOverflow (W1C), and write a 1 to
	MMIO Offset 0018h[EventLogEn].

The AMD IOMMU driver doesn't currently implement this recovery
sequence, meaning that if a ring buffer overflow occurs, logging
of EVT/PPR/GA events will cease entirely.

This patch implements the spec-mandated reset sequence, with the
minor tweak that the hardware seems to want to have a 0 written to
MMIO Offset 0018h[EventLogEn] first, before writing an 1 into this
field, or the IOMMU won't actually resume logging events.

Signed-off-by: Lennert Buytenhek <buytenh@arista.com>
---
Tested on v5.15-rc4 on a Ryzen 3700X.

Changes for v2:
- Rate limit event log overflow messages.

 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/init.c            | 10 ++++++++++
 drivers/iommu/amd/iommu.c           | 10 ++++++++--
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 416815a525d6..bb95edf74415 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -14,6 +14,7 @@
 extern irqreturn_t amd_iommu_int_thread(int irq, void *data);
 extern irqreturn_t amd_iommu_int_handler(int irq, void *data);
 extern void amd_iommu_apply_erratum_63(u16 devid);
+extern void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
 extern void amd_iommu_reset_cmd_buffer(struct amd_iommu *iommu);
 extern int amd_iommu_init_devices(void);
 extern void amd_iommu_uninit_devices(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 8dbe61e2b3c1..095076029f8d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -110,6 +110,7 @@
 #define PASID_MASK		0x0000ffff
 
 /* MMIO status bits */
+#define MMIO_STATUS_EVT_OVERFLOW_INT_MASK	(1 << 0)
 #define MMIO_STATUS_EVT_INT_MASK	(1 << 1)
 #define MMIO_STATUS_COM_WAIT_INT_MASK	(1 << 2)
 #define MMIO_STATUS_PPR_INT_MASK	(1 << 6)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 2a822b229bd0..f1c5eb023bda 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -654,6 +654,16 @@ static int __init alloc_command_buffer(struct amd_iommu *iommu)
 	return iommu->cmd_buf ? 0 : -ENOMEM;
 }
 
+/*
+ * This function restarts event logging in case the IOMMU experienced
+ * an event log buffer overflow.
+ */
+void amd_iommu_restart_event_logging(struct amd_iommu *iommu)
+{
+	iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN);
+	iommu_feature_enable(iommu, CONTROL_EVT_LOG_EN);
+}
+
 /*
  * This function resets the command buffer if the IOMMU stopped fetching
  * commands from it.
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1722bb161841..f46eb7397021 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -742,7 +742,8 @@ amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
 #endif /* !CONFIG_IRQ_REMAP */
 
 #define AMD_IOMMU_INT_MASK	\
-	(MMIO_STATUS_EVT_INT_MASK | \
+	(MMIO_STATUS_EVT_OVERFLOW_INT_MASK | \
+	 MMIO_STATUS_EVT_INT_MASK | \
 	 MMIO_STATUS_PPR_INT_MASK | \
 	 MMIO_STATUS_GALOG_INT_MASK)
 
@@ -752,7 +753,7 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
 	u32 status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
 
 	while (status & AMD_IOMMU_INT_MASK) {
-		/* Enable EVT and PPR and GA interrupts again */
+		/* Enable interrupt sources again */
 		writel(AMD_IOMMU_INT_MASK,
 			iommu->mmio_base + MMIO_STATUS_OFFSET);
 
@@ -773,6 +774,11 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
 		}
 #endif
 
+		if (status & MMIO_STATUS_EVT_OVERFLOW_INT_MASK) {
+			pr_info_ratelimited("IOMMU event log overflow\n");
+			amd_iommu_restart_event_logging(iommu);
+		}
+
 		/*
 		 * Hardware bug: ERBT1312
 		 * When re-enabling interrupt (by writing 1
-- 
2.31.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
