Return-Path: <SRS0=m4R2=22=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B28C33C8C
	for <iommu@archiver.kernel.org>; Sun,  5 Jan 2020 13:58:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF8B207FD
	for <iommu@archiver.kernel.org>; Sun,  5 Jan 2020 13:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF8B207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7832586727;
	Sun,  5 Jan 2020 13:57:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x+qipYfjsf6i; Sun,  5 Jan 2020 13:57:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 586BA8664E;
	Sun,  5 Jan 2020 13:57:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A530C18DD;
	Sun,  5 Jan 2020 13:57:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E4B2C0881
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 13:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0758020353
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 13:57:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1hwL6Emrt8Pe for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jan 2020 13:57:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from tc-sys-mailedm04.tc.baidu.com (mx137-tc.baidu.com
 [61.135.168.137])
 by silver.osuosl.org (Postfix) with ESMTP id 8F84A20243
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jan 2020 13:57:50 +0000 (UTC)
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
 by tc-sys-mailedm04.tc.baidu.com (Postfix) with ESMTP id 6A8A7236C003;
 Sun,  5 Jan 2020 21:57:47 +0800 (CST)
From: jimyan <jimyan@baidu.com>
To: joro@8bytes.org, jsnitsel@redhat.com, baolu.lu@linux.intel.com,
 roland@purestorage.com
Subject: [PATCH v2] iommu/vt-d: Don't reject nvme host due to scope mismatch
Date: Sun,  5 Jan 2020 21:57:48 +0800
Message-Id: <1578232668-2696-1-git-send-email-jimyan@baidu.com>
X-Mailer: git-send-email 1.7.1
Cc: jimyan@baidu.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On a system with an Intel PCIe port configured as a nvme host device, iommu
initialization fails with

    DMAR: Device scope type does not match for 0000:80:00.0

This is because the DMAR table reports this device as having scope 2
(ACPI_DMAR_SCOPE_TYPE_BRIDGE):

but the device has a type 0 PCI header:
80:00.0 Class 0600: Device 8086:2020 (rev 06)
00: 86 80 20 20 47 05 10 00 06 00 00 06 10 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 00 00
30: 00 00 00 00 90 00 00 00 00 00 00 00 00 01 00 00

VT-d works perfectly on this system, so there's no reason to bail out
on initialization due to this apparent scope mismatch. Add the class
0x06 ("PCI_BASE_CLASS_BRIDGE") as a heuristic for allowing DMAR
initialization for non-bridge PCI devices listed with scope bridge.

Signed-off-by: jimyan <jimyan@baidu.com>
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index eecd6a421667..50c92eb23ee4 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -244,7 +244,7 @@ int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
 		     info->dev->hdr_type != PCI_HEADER_TYPE_NORMAL) ||
 		    (scope->entry_type == ACPI_DMAR_SCOPE_TYPE_BRIDGE &&
 		     (info->dev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
-		      info->dev->class >> 8 != PCI_CLASS_BRIDGE_OTHER))) {
+		      info->dev->class >> 16 != PCI_BASE_CLASS_BRIDGE))) {
 			pr_warn("Device scope type does not match for %s\n",
 				pci_name(info->dev));
 			return -EINVAL;
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
