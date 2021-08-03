Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96406C4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 16:19:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F4560F94
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 16:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C9F4560F94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95A646078E;
	Tue,  3 Aug 2021 16:19:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id be51l-8dflB4; Tue,  3 Aug 2021 16:19:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 42BD0606C7;
	Tue,  3 Aug 2021 16:19:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AACDC0010;
	Tue,  3 Aug 2021 16:19:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEB60C000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 16:19:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90AA340290
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 16:19:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0RWcS9uC_I8K for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 16:19:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 219CC40171
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 16:19:42 +0000 (UTC)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
 id 72EAB7F083; Tue,  3 Aug 2021 19:19:39 +0300 (EEST)
Date: Tue, 3 Aug 2021 19:19:39 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3] iommu/amd: Use report_iommu_fault()
Message-ID: <YQlsm1vED/lEKoZw@wantstofly.org>
MIME-Version: 1.0
Content-Disposition: inline
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

This patch makes iommu/amd call report_iommu_fault() when an I/O page
fault occurs, which has two effects:

1) It allows device drivers to register a callback to be notified of
   I/O page faults, via the iommu_set_fault_handler() API.

2) It triggers the io_page_fault tracepoint in report_iommu_fault()
   when an I/O page fault occurs.

I'm mainly interested in (2).  We have a daemon with some rasdaemon-like
functionality for handling platform errors, and being able to be notified
of I/O page faults for initiating corrective action is very useful -- and
receiving such events via event tracing is a lot nicer than having to
scrape them from kmsg.

A number of other IOMMU drivers already use report_iommu_fault(), and
I/O page faults on those IOMMUs therefore already seem to trigger this
tracepoint -- but this isn't (yet) the case for AMD-Vi and Intel DMAR.

I copied the logic from the other callers of report_iommu_fault(), where
if that function returns zero, the driver will have handled the fault,
in which case we avoid logging information about the fault to the printk
buffer from the IOMMU driver.

With this patch I see io_page_fault event tracing entries as expected:

   irq/24-AMD-Vi-48    [002] ....   978.554289: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x0000000091482640 flags=0x0000
   irq/24-AMD-Vi-48    [002] ....   978.554294: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x0000000091482650 flags=0x0000
   irq/24-AMD-Vi-48    [002] ....   978.554299: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x0000000091482660 flags=0x0000
   irq/24-AMD-Vi-48    [002] ....   978.554305: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x0000000091482670 flags=0x0000
   irq/24-AMD-Vi-48    [002] ....   978.554310: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x0000000091482680 flags=0x0000
   irq/24-AMD-Vi-48    [002] ....   978.554315: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x00000000914826a0 flags=0x0000

For determining IOMMU_FAULT_{READ,WRITE}, I followed the AMD IOMMU
spec, but I haven't tested that bit of the code, as the page faults I
encounter are all to non-present (!EVENT_FLAG_PR) mappings, in which
case EVENT_FLAG_RW doesn't make sense.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
Changes for v3:
- Test fault flags via macros.  (Suggested by Suravee Suthikulpanit.)

Changes for v2:
- Don't call report_iommu_fault() for IRQ remapping faults.
  (Suggested by Joerg Roedel.)

 drivers/iommu/amd/amd_iommu_types.h |  4 ++++
 drivers/iommu/amd/iommu.c           | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 94c1a7a9876d..2f2c6630c24c 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -138,6 +138,10 @@
 #define EVENT_DOMID_MASK_HI	0xf0000
 #define EVENT_FLAGS_MASK	0xfff
 #define EVENT_FLAGS_SHIFT	0x10
+#define EVENT_FLAG_TR		0x100
+#define EVENT_FLAG_RW		0x020
+#define EVENT_FLAG_PR		0x010
+#define EVENT_FLAG_I		0x008
 
 /* feature control bits */
 #define CONTROL_IOMMU_EN        0x00ULL
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a7d6d78147b7..00975b08bd3f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -473,6 +473,22 @@ static void amd_iommu_report_rmp_fault(volatile u32 *event)
 		pci_dev_put(pdev);
 }
 
+/*
+ * AMD I/O Virtualization Technology (IOMMU) Specification, revision
+ * 3.00, section 2.5.3 ("IO_PAGE_FAULT Event") says that the RW
+ * ("read-write") bit is only valid if the I/O page fault was caused
+ * by a memory transaction request referencing a page that was marked
+ * present.
+ */
+#define IS_IOMMU_MEM_TRANSACTION(flags)		\
+	(((flags) & EVENT_FLAG_I) == 0)
+
+#define IS_RW_FLAG_VALID(flags)			\
+	(((flags) & (EVENT_FLAG_TR | EVENT_FLAG_PR)) == EVENT_FLAG_PR)
+
+#define IS_WRITE_REQUEST(flags)			\
+	(IS_RW_FLAG_VALID(flags) && ((flags) & EVENT_FLAG_RW))
+
 static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 					u64 address, int flags)
 {
@@ -484,6 +500,18 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 	if (pdev)
 		dev_data = dev_iommu_priv_get(&pdev->dev);
 
+	/*
+	 * If this is a DMA fault (for which the I(nterrupt) bit will
+	 * be unset), allow report_iommu_fault() to prevent logging it.
+	 */
+	if (dev_data && IS_IOMMU_MEM_TRANSACTION(flags)) {
+		if (!report_iommu_fault(&dev_data->domain->domain,
+					&pdev->dev, address,
+					IS_WRITE_REQUEST(flags) ?
+					IOMMU_FAULT_WRITE : IOMMU_FAULT_READ))
+			goto out;
+	}
+
 	if (dev_data) {
 		if (__ratelimit(&dev_data->rs)) {
 			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
@@ -495,6 +523,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 			domain_id, address, flags);
 	}
 
+out:
 	if (pdev)
 		pci_dev_put(pdev);
 }
-- 
2.31.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
