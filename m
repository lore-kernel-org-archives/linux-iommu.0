Return-Path: <SRS0=eP4Y=2X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE93C2D0DE
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 00:20:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB20D20842
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 00:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB20D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7F3A22050E;
	Thu,  2 Jan 2020 00:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bhHY9Bq0seq4; Thu,  2 Jan 2020 00:19:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9737A2050F;
	Thu,  2 Jan 2020 00:19:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85AC8C18DC;
	Thu,  2 Jan 2020 00:19:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36808C077D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 00:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2E95886074
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 00:19:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o1XfmvVKQmUE for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jan 2020 00:19:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 11470860A2
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 00:19:53 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Jan 2020 16:19:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,384,1571727600"; d="scan'208";a="244475956"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 01 Jan 2020 16:19:51 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 22/22] iommu/vt-d: Add a quirk flag for scope mismatched
 devices
Date: Thu,  2 Jan 2020 08:18:23 +0800
Message-Id: <20200102001823.21976-23-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102001823.21976-1-baolu.lu@linux.intel.com>
References: <20200102001823.21976-1-baolu.lu@linux.intel.com>
Cc: Roland Dreier <roland@purestorage.com>, Jim Yan <jimyan@baidu.com>,
 iommu@lists.linux-foundation.org
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

We expect devices with endpoint scope to have normal PCI headers,
and devices with bridge scope to have bridge PCI headers. However,
some PCI devices may be listed in the DMAR table with bridge scope,
even though they have a normal PCI header. Add a quirk flag for
those special devices.

Cc: Roland Dreier <roland@purestorage.com>
Cc: Jim Yan <jimyan@baidu.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Tested-by: Jim Yan <jimyan@baidu.com>
---
 drivers/iommu/dmar.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index fb30d5053664..fc24abc70a05 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -65,6 +65,26 @@ static void free_iommu(struct intel_iommu *iommu);
 
 extern const struct iommu_ops intel_iommu_ops;
 
+static int scope_mismatch_quirk;
+static void quirk_dmar_scope_mismatch(struct pci_dev *dev)
+{
+	pci_info(dev, "scope mismatch ignored\n");
+	scope_mismatch_quirk = 1;
+}
+
+/*
+ * We expect devices with endpoint scope to have normal PCI
+ * headers, and devices with bridge scope to have bridge PCI
+ * headers.  However some PCI devices may be listed in the
+ * DMAR table with bridge scope, even though they have a
+ * normal PCI header. We don't declare a socpe mismatch for
+ * below special cases.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2f0d,	/* NTB devices  */
+			 quirk_dmar_scope_mismatch);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2020,	/* NVME host */
+			 quirk_dmar_scope_mismatch);
+
 static void dmar_register_drhd_unit(struct dmar_drhd_unit *drhd)
 {
 	/*
@@ -231,20 +251,9 @@ int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
 		if (!dmar_match_pci_path(info, scope->bus, path, level))
 			continue;
 
-		/*
-		 * We expect devices with endpoint scope to have normal PCI
-		 * headers, and devices with bridge scope to have bridge PCI
-		 * headers.  However PCI NTB devices may be listed in the
-		 * DMAR table with bridge scope, even though they have a
-		 * normal PCI header.  NTB devices are identified by class
-		 * "BRIDGE_OTHER" (0680h) - we don't declare a socpe mismatch
-		 * for this special case.
-		 */
-		if ((scope->entry_type == ACPI_DMAR_SCOPE_TYPE_ENDPOINT &&
-		     info->dev->hdr_type != PCI_HEADER_TYPE_NORMAL) ||
-		    (scope->entry_type == ACPI_DMAR_SCOPE_TYPE_BRIDGE &&
-		     (info->dev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
-		      info->dev->class >> 8 != PCI_CLASS_BRIDGE_OTHER))) {
+		if (!scope_mismatch_quirk &&
+		    ((scope->entry_type == ACPI_DMAR_SCOPE_TYPE_ENDPOINT) ^
+		     (info->dev->hdr_type == PCI_HEADER_TYPE_NORMAL))) {
 			pr_warn("Device scope type does not match for %s\n",
 				pci_name(info->dev));
 			return -EINVAL;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
