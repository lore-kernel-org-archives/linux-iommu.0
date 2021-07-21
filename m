Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BEEC636C9
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 13:45:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE8C60FF4
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 13:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE8C60FF4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E8154027B;
	Wed, 21 Jul 2021 13:45:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LlmUtUjUpZXU; Wed, 21 Jul 2021 13:44:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 163804021E;
	Wed, 21 Jul 2021 13:44:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECE49C001A;
	Wed, 21 Jul 2021 13:44:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25496C000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 13:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13F0B60594
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 13:44:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7cKvwOlI7KD1 for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 13:44:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 108D860591
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 13:44:56 +0000 (UTC)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
 id 0B8397F46A; Wed, 21 Jul 2021 16:44:53 +0300 (EEST)
Date: Wed, 21 Jul 2021 16:44:53 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH] iommu/amd: Fix printing of IOMMU events when rate limiting
 kicks in
Message-ID: <YPgk1dD1gPMhJXgY@wantstofly.org>
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

For the printing of RMP_HW_ERROR / RMP_PAGE_FAULT / IO_PAGE_FAULT
events, the AMD IOMMU code uses such logic:

	if (pdev)
		dev_data = dev_iommu_priv_get(&pdev->dev);

	if (dev_data && __ratelimit(&dev_data->rs)) {
		pci_err(pdev, ...
	} else {
		printk_ratelimit() / pr_err{,_ratelimited}(...
	}

This means that if we receive an event for a PCI devid which actually
does have a struct pci_dev and an attached struct iommu_dev_data, but
rate limiting kicks in, we'll fall back to the non-PCI branch of the
test, and print the event in a different format.

Fix this by changing the logic to:

	if (dev_data) {
		if (__ratelimit(&dev_data->rs)) {
			pci_err(pdev, ...
		}
	} else {
		pr_err_ratelimited(...
	}

Suggested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 drivers/iommu/amd/iommu.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 811a49a95d04..a7d6d78147b7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -425,9 +425,11 @@ static void amd_iommu_report_rmp_hw_error(volatile u32 *event)
 	if (pdev)
 		dev_data = dev_iommu_priv_get(&pdev->dev);
 
-	if (dev_data && __ratelimit(&dev_data->rs)) {
-		pci_err(pdev, "Event logged [RMP_HW_ERROR vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
-			vmg_tag, spa, flags);
+	if (dev_data) {
+		if (__ratelimit(&dev_data->rs)) {
+			pci_err(pdev, "Event logged [RMP_HW_ERROR vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
+				vmg_tag, spa, flags);
+		}
 	} else {
 		pr_err_ratelimited("Event logged [RMP_HW_ERROR device=%02x:%02x.%x, vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
@@ -456,9 +458,11 @@ static void amd_iommu_report_rmp_fault(volatile u32 *event)
 	if (pdev)
 		dev_data = dev_iommu_priv_get(&pdev->dev);
 
-	if (dev_data && __ratelimit(&dev_data->rs)) {
-		pci_err(pdev, "Event logged [RMP_PAGE_FAULT vmg_tag=0x%04x, gpa=0x%llx, flags_rmp=0x%04x, flags=0x%04x]\n",
-			vmg_tag, gpa, flags_rmp, flags);
+	if (dev_data) {
+		if (__ratelimit(&dev_data->rs)) {
+			pci_err(pdev, "Event logged [RMP_PAGE_FAULT vmg_tag=0x%04x, gpa=0x%llx, flags_rmp=0x%04x, flags=0x%04x]\n",
+				vmg_tag, gpa, flags_rmp, flags);
+		}
 	} else {
 		pr_err_ratelimited("Event logged [RMP_PAGE_FAULT device=%02x:%02x.%x, vmg_tag=0x%04x, gpa=0x%llx, flags_rmp=0x%04x, flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
@@ -480,11 +484,13 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
 	if (pdev)
 		dev_data = dev_iommu_priv_get(&pdev->dev);
 
-	if (dev_data && __ratelimit(&dev_data->rs)) {
-		pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
-			domain_id, address, flags);
-	} else if (printk_ratelimit()) {
-		pr_err("Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
+	if (dev_data) {
+		if (__ratelimit(&dev_data->rs)) {
+			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
+				domain_id, address, flags);
+		}
+	} else {
+		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			domain_id, address, flags);
 	}
-- 
2.31.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
