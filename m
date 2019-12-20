Return-Path: <SRS0=Sm7F=2K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019E7C43603
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 07:17:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9878624679
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 07:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9878624679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 57D67871EC;
	Fri, 20 Dec 2019 07:17:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iNRqKjPUYlsf; Fri, 20 Dec 2019 07:17:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C4000871D8;
	Fri, 20 Dec 2019 07:17:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1144C18DC;
	Fri, 20 Dec 2019 07:17:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35977C077D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 07:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2C844871E1
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 07:17:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zyeRXFK3uHPh for <iommu@lists.linux-foundation.org>;
 Fri, 20 Dec 2019 07:17:32 +0000 (UTC)
X-Greylist: delayed 00:09:35 by SQLgrey-1.7.6
Received: from tc-sys-mailedm01.tc.baidu.com (mx133-tc.baidu.com
 [61.135.168.133])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EEA33871D8
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 07:17:31 +0000 (UTC)
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
 by tc-sys-mailedm01.tc.baidu.com (Postfix) with ESMTP id 1DE5D204005E;
 Fri, 20 Dec 2019 15:07:54 +0800 (CST)
From: jimyan <jimyan@baidu.com>
To: joro@8bytes.org
Subject: [PATCH] iommu/vt-d: Don't reject nvme host due to scope mismatch
Date: Fri, 20 Dec 2019 15:07:54 +0800
Message-Id: <1576825674-18022-1-git-send-email-jimyan@baidu.com>
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
0x600 ("PCI_CLASS_BRIDGE_HOST") as a heuristic for allowing DMAR
initialization for non-bridge PCI devices listed with scope bridge.

Signed-off-by: jimyan <jimyan@baidu.com>
---
 drivers/iommu/dmar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index eecd6a421667..9faf2f0e0237 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -244,6 +244,7 @@ int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
 		     info->dev->hdr_type != PCI_HEADER_TYPE_NORMAL) ||
 		    (scope->entry_type == ACPI_DMAR_SCOPE_TYPE_BRIDGE &&
 		     (info->dev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
+			  info->dev->class >> 8 != PCI_CLASS_BRIDGE_HOST &&
 		      info->dev->class >> 8 != PCI_CLASS_BRIDGE_OTHER))) {
 			pr_warn("Device scope type does not match for %s\n",
 				pci_name(info->dev));
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
