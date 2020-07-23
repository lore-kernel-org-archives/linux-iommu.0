Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540AAC43458
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 22:37:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212FC20792
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 22:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212FC20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E92ED87D97;
	Thu, 23 Jul 2020 22:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JUU86ybBDZf3; Thu, 23 Jul 2020 22:37:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 21F0D87D80;
	Thu, 23 Jul 2020 22:37:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0755AC004D;
	Thu, 23 Jul 2020 22:37:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99E5BC004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 22:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 88D9C884A9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 22:37:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VLeWW2THcdiC for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 22:37:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C238A884A1
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 22:37:33 +0000 (UTC)
IronPort-SDR: 5wAy3w+gSaZJU67v+gpPs2ygFlkcsJnGi8k+35wlSvfiEBcAshVsLmYtcd5j/fPvItQ2DnAXSl
 fzGhJoPD7bnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="215225203"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="215225203"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 15:37:32 -0700
IronPort-SDR: EY9s5rW5U1aQy5GNQAR9ZgvrDr76Axq9ss9gxITH1EAgoJHJ+6EbSpbf8LmFYkpNc8X3sUts6d
 rG4eADnva0VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="272425639"
Received: from otc-nc-03.jf.intel.com ([10.54.39.25])
 by fmsmga008.fm.intel.com with ESMTP; 23 Jul 2020 15:37:32 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@intel.com>
Subject: [PATCH v3 1/1] PCI/ATS: Check PRI supported on the PF device when
 SRIOV is enabled
Date: Thu, 23 Jul 2020 15:37:29 -0700
Message-Id: <1595543849-19692-1-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: iommu@lists.linux-foundation.org, Ashok Raj <ashok.raj@intel.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
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

PASID and PRI capabilities are only enumerated in PF devices. VF devices
do not enumerate these capabilites. IOMMU drivers also need to enumerate
them before enabling features in the IOMMU. Extending the same support as
PASID feature discovery (pci_pasid_features) for PRI.

Fixes: b16d0cb9e2fc ("iommu/vt-d: Always enable PASID/PRI PCI capabilities before ATS")
Signed-off-by: Ashok Raj <ashok.raj@intel.com>

To: Bjorn Helgaas <bhelgaas@google.com>
To: Joerg Roedel <joro@8bytes.com>
To: Lu Baolu <baolu.lu@intel.com>
Cc: stable@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: iommu@lists.linux-foundation.org
---
v3: Added Fixes tag
v2: Fixed build failure reported from lkp when CONFIG_PRI=n

 drivers/iommu/intel/iommu.c |  2 +-
 drivers/pci/ats.c           | 13 +++++++++++++
 include/linux/pci-ats.h     |  4 ++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d759e7234e98..276452f5e6a7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2560,7 +2560,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 			}
 
 			if (info->ats_supported && ecap_prs(iommu->ecap) &&
-			    pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI))
+			    pci_pri_supported(pdev))
 				info->pri_supported = 1;
 		}
 	}
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index b761c1f72f67..2e6cf0c700f7 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -325,6 +325,19 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 
 	return pdev->pasid_required;
 }
+
+/**
+ * pci_pri_supported - Check if PRI is supported.
+ * @pdev: PCI device structure
+ *
+ * Returns true if PRI capability is present, false otherwise.
+ */
+bool pci_pri_supported(struct pci_dev *pdev)
+{
+	/* VFs share the PF PRI configuration */
+	return !!(pci_physfn(pdev)->pri_cap);
+}
+EXPORT_SYMBOL_GPL(pci_pri_supported);
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index f75c307f346d..df54cd5b15db 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -28,6 +28,10 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
 void pci_disable_pri(struct pci_dev *pdev);
 int pci_reset_pri(struct pci_dev *pdev);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev);
+bool pci_pri_supported(struct pci_dev *pdev);
+#else
+static inline bool pci_pri_supported(struct pci_dev *pdev)
+{ return false; }
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
