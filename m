Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570E9C33C9E
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 03:05:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3971324673
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 03:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3971324673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 189A28637D;
	Wed, 15 Jan 2020 03:05:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7d2U5-BqXhjv; Wed, 15 Jan 2020 03:05:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0C9DD85B8A;
	Wed, 15 Jan 2020 03:05:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED0EDC1D88;
	Wed, 15 Jan 2020 03:05:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C95EC077D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 03:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5C79A2042B
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 03:05:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rWhIDnLTTQNP for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 03:05:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id 95E25204CC
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 03:05:24 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jan 2020 19:05:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,321,1574150400"; d="scan'208";a="219138443"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.138])
 by fmsmga007.fm.intel.com with ESMTP; 14 Jan 2020 19:05:23 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/5] iommu/vt-d: Don't reject Host Bridge due to scope mismatch
Date: Wed, 15 Jan 2020 11:03:55 +0800
Message-Id: <20200115030359.13471-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115030359.13471-1-baolu.lu@linux.intel.com>
References: <20200115030359.13471-1-baolu.lu@linux.intel.com>
Cc: jimyan <jimyan@baidu.com>, iommu@lists.linux-foundation.org
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

From: jimyan <jimyan@baidu.com>

On a system with two host bridges(0000:00:00.0,0000:80:00.0), iommu
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
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Roland Dreier <roland@purestorage.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index fb30d5053664..613b7153905d 100644
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
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
