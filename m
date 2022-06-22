Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA12C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 04:45:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E39196122E;
	Wed, 22 Jun 2022 04:45:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E39196122E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MnySCHHS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oNcKFvsCY-2O; Wed, 22 Jun 2022 04:45:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8530561052;
	Wed, 22 Jun 2022 04:45:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8530561052
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A35EC0039;
	Wed, 22 Jun 2022 04:45:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E03BC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 04:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1155E4038B
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 04:45:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1155E4038B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MnySCHHS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SAQWQJiSPbNH for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 04:45:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 36955400DD
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 36955400DD
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 04:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655873132; x=1687409132;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CMoUcpPlVSjI5v0iYxRqec/ZANBG5N/XfEwKajaEL7s=;
 b=MnySCHHSwZmGhaE0YmOkgI1qiJmWUxZyqIFi34uVCer4w/az0AuCN+aP
 bXrDiSqenW2Hu/b3Wpv8KMI/uQO/5jHm5UadAD/8LGGSwbxfEbcfNgOxT
 EhhD4zZ1keH4F8+UkyzOf4udZ4hP+ZjJh4DhM9U1WfQeiCKvv4NkDttgO
 WkuUzg5s6Z6MI6HSwNT8ozVjMN2tewfGWyV9MM+mmfe/roj+T0ZLRSqBq
 V5LXTGwidBNGiVZoogEdjjusk7goHS4CDghu3x/ixLBjO1IEdMOoXDzX2
 ZgVS5OwZqb8v8RwlI60aD0Vk2qeb1iuk1h1aOrJP6i+6U+Vc0g7QugxfN A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281385376"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; d="scan'208";a="281385376"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 21:45:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; d="scan'208";a="833907396"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga006.fm.intel.com with ESMTP; 21 Jun 2022 21:45:28 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v2 1/1] iommu/vt-d: Fix RID2PASID setup failure
Date: Wed, 22 Jun 2022 12:41:20 +0800
Message-Id: <20220622044120.21813-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Chenyi Qiang <chenyi.qiang@intel.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

The IOMMU driver shares the pasid table for PCI alias devices. When the
RID2PASID entry of the shared pasid table has been filled by the first
device, the subsequent devices will encounter the "DMAR: Setup RID2PASID
failed" failure as the pasid entry has already been marked as present. As
the result, the IOMMU probing process will be aborted.

This fixes it by skipping RID2PASID setting if the pasid entry has been
populated. This works because the IOMMU core ensures that only the same
IOMMU domain can be attached to all PCI alias devices at the same time.
Therefore the subsequent devices just try to setup the RID2PASID entry
with the same domain, which is negligible. This also adds domain validity
checks for more confidence anyway.

Fixes: ef848b7e5a6a0 ("iommu/vt-d: Setup pasid entry for RID2PASID support")
Reported-by: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

Change log:
v2:
 - Add domain validity check in RID2PASID entry setup.

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index cb4c1d0cf25c..4f3525f3346f 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -575,6 +575,19 @@ static inline int pasid_enable_wpe(struct pasid_entry *pte)
 	return 0;
 };
 
+/*
+ * Return true if @pasid is RID2PASID and the domain @did has already
+ * been setup to the @pte. Otherwise, return false. PCI alias devices
+ * probably share the single RID2PASID pasid entry in the shared pasid
+ * table. It's reasonable that those devices try to set a share domain
+ * in their probe paths.
+ */
+static inline bool
+rid2pasid_domain_valid(struct pasid_entry *pte, u32 pasid, u16 did)
+{
+	return pasid == PASID_RID2PASID && pasid_get_domain_id(pte) == did;
+}
+
 /*
  * Set up the scalable mode pasid table entry for first only
  * translation type.
@@ -595,9 +608,8 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 	if (WARN_ON(!pte))
 		return -EINVAL;
 
-	/* Caller must ensure PASID entry is not in use. */
 	if (pasid_pte_is_present(pte))
-		return -EBUSY;
+		return rid2pasid_domain_valid(pte, pasid, did) ? 0 : -EBUSY;
 
 	pasid_clear_entry(pte);
 
@@ -698,9 +710,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 		return -ENODEV;
 	}
 
-	/* Caller must ensure PASID entry is not in use. */
 	if (pasid_pte_is_present(pte))
-		return -EBUSY;
+		return rid2pasid_domain_valid(pte, pasid, did) ? 0 : -EBUSY;
 
 	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
@@ -738,9 +749,8 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 		return -ENODEV;
 	}
 
-	/* Caller must ensure PASID entry is not in use. */
 	if (pasid_pte_is_present(pte))
-		return -EBUSY;
+		return rid2pasid_domain_valid(pte, pasid, did) ? 0 : -EBUSY;
 
 	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
