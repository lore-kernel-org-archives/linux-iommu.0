Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB2CC433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 10:44:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AAD561130
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 10:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7AAD561130
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4272B80DD9;
	Tue, 28 Sep 2021 10:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rR3uoiDAT42k; Tue, 28 Sep 2021 10:44:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2867D80D6E;
	Tue, 28 Sep 2021 10:44:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2A83C0011;
	Tue, 28 Sep 2021 10:44:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 005ECC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 10:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D65FF401D3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 10:44:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qoOg46wwUhFo for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 10:44:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5EC4F40151
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 10:44:25 +0000 (UTC)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
 id CC9C37F2AD; Tue, 28 Sep 2021 13:44:21 +0300 (EEST)
Date: Tue, 28 Sep 2021 13:44:21 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Joerg Roedel <joro@8bytes.org>,
 "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: [PATCH v5] iommu/amd: Use report_iommu_fault()
Message-ID: <YVLyBW97vZLpOaAp@wantstofly.org>
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

This patch makes iommu/amd call report_iommu_fault() when an I/O page
fault occurs, which has two effects:

1) It allows device drivers to register a callback to be notified of
   I/O page faults, via the iommu_set_fault_handler() API.

2) It triggers the io_page_fault tracepoint in report_iommu_fault()
   when an I/O page fault occurs.

The latter point is the main aim of this patch, as it allows
rasdaemon-like daemons to be notified of I/O page faults, and to
possibly initiate corrective action in response.

A number of other IOMMU drivers already use report_iommu_fault(), and
I/O page faults on those IOMMUs therefore already trigger this
tracepoint -- but this isn't yet the case for AMD-Vi and Intel DMAR.

The AMD IOMMU specification suggests that the bit in an I/O page fault
event log entry that signals whether an I/O page fault was for a read
request or for a write request is only meaningful when the faulting
access was to a present page, but some testing on a Ryzen 3700X suggests
that this bit encodes the correct value even for I/O page faults to
non-present pages, and therefore, this patch passes the R/W information
up the stack even for I/O page faults to non-present pages.

Signed-off-by: Lennert Buytenhek <buytenh@arista.com>
---
Tested on v5.15-rc3 on a Ryzen 3700X and on a Ryzen 5950X, where it
has the desired effect.

Changes for v5:
- Code formatting tweaking.  (Suggested by Joerg Roedel.)

Changes for v4:
- Unconditionally pass through RW bit, after testing that suggests
  that this bit is reliable even for I/O page faults to non-present
  pages.

Changes for v3:
- Test fault flags via macros.  (Suggested by Suravee Suthikulpanit.)

Changes for v2:
- Don't call report_iommu_fault() for IRQ remapping faults.
  (Suggested by Joerg Roedel.)

 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/iommu.c           | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 8dbe61e2b3c1..867535eb0ce9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -138,6 +138,8 @@
 #define EVENT_DOMID_MASK_HI	0xf0000
 #define EVENT_FLAGS_MASK	0xfff
 #define EVENT_FLAGS_SHIFT	0x10
+#define EVENT_FLAG_RW		0x020
+#define EVENT_FLAG_I		0x008
 
 /* feature control bits */
 #define CONTROL_IOMMU_EN        0x00ULL
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1722bb161841..beadcffcc223 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -473,6 +473,12 @@ static void amd_iommu_report_rmp_fault(volatile u32 *event)
 		pci_dev_put(pdev);
 }
 
+#define IS_IOMMU_MEM_TRANSACTION(flags)		\
+	(((flags) & EVENT_FLAG_I) == 0)
+
+#define IS_WRITE_REQUEST(flags)			\
+	((flags) & EVENT_FLAG_RW)
+
 static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 					u64 address, int flags)
 {
@@ -485,6 +491,20 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 		dev_data = dev_iommu_priv_get(&pdev->dev);
 
 	if (dev_data) {
+		/*
+		 * If this is a DMA fault (for which the I(nterrupt)
+		 * bit will be unset), allow report_iommu_fault() to
+		 * prevent logging it.
+		 */
+		if (IS_IOMMU_MEM_TRANSACTION(flags)) {
+			if (!report_iommu_fault(&dev_data->domain->domain,
+						&pdev->dev, address,
+						IS_WRITE_REQUEST(flags) ?
+							IOMMU_FAULT_WRITE :
+							IOMMU_FAULT_READ))
+				goto out;
+		}
+
 		if (__ratelimit(&dev_data->rs)) {
 			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
 				domain_id, address, flags);
@@ -495,6 +515,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
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
