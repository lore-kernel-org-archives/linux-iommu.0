Return-Path: <SRS0=Ni9g=YC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CA9ECE58C
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 22:46:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA81D218DE
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 22:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr469wBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA81D218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C0B9EDCA;
	Wed,  9 Oct 2019 22:46:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 17E97BDC
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 22:46:50 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id ACFC714D
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 22:46:49 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 2189C218AC;
	Wed,  9 Oct 2019 22:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570661209;
	bh=G4qaDJvkgucJqayGdIGRgColYPN7u9fMFeBqJUjKfz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gr469wBofiAFIdOGgkpSdkNgSeQMWQW+3lG3nQ7+YuABSj9TtzblnULya9ZAbb3ZV
	AnNOC2RkF1flKoPor+TBb/ggYQ6mwg7mIw+vkTJs4+dreg5w1AUipBYYc6N/cRq1Om
	j8AzddchSO4UXHhYCAzAhMkMdTVL/JV/8/t850jE=
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] PCI/ATS: Move pci_prg_resp_pasid_required() to
	CONFIG_PCI_PRI
Date: Wed,  9 Oct 2019 17:45:51 -0500
Message-Id: <20191009224551.179497-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191009224551.179497-1-helgaas@kernel.org>
References: <20191009224551.179497-1-helgaas@kernel.org>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
	iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_prg_resp_pasid_required() returns the value of the "PRG Response PASID
Required" bit from the PRI capability, but the interface was previously
defined under #ifdef CONFIG_PCI_PASID.

Move it from CONFIG_PCI_PASID to CONFIG_PCI_PRI so it's with the other
PRI-related things.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c       | 55 +++++++++++++++++++----------------------
 include/linux/pci-ats.h | 11 ++++-----
 2 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index e18499243f84..0d06177252c7 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -280,6 +280,31 @@ int pci_reset_pri(struct pci_dev *pdev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_reset_pri);
+
+/**
+ * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
+ *				 status.
+ * @pdev: PCI device structure
+ *
+ * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
+ */
+int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{
+	u16 status;
+	int pos;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+	if (!pos)
+		return 0;
+
+	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
+
+	if (status & PCI_PRI_STATUS_PASID)
+		return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
@@ -395,36 +420,6 @@ int pci_pasid_features(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_pasid_features);
 
-/**
- * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
- *				 status.
- * @pdev: PCI device structure
- *
- * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
- *
- * Even though the PRG response PASID status is read from PRI Status
- * Register, since this API will mainly be used by PASID users, this
- * function is defined within #ifdef CONFIG_PCI_PASID instead of
- * CONFIG_PCI_PRI.
- */
-int pci_prg_resp_pasid_required(struct pci_dev *pdev)
-{
-	u16 status;
-	int pos;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
-		return 0;
-
-	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
-
-	if (status & PCI_PRI_STATUS_PASID)
-		return 1;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
-
 #define PASID_NUMBER_SHIFT	8
 #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
 /**
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index 1ebb88e7c184..a7a2b3d94fcc 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -10,6 +10,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
 void pci_disable_pri(struct pci_dev *pdev);
 void pci_restore_pri_state(struct pci_dev *pdev);
 int pci_reset_pri(struct pci_dev *pdev);
+int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 
 #else /* CONFIG_PCI_PRI */
 
@@ -31,6 +32,10 @@ static inline int pci_reset_pri(struct pci_dev *pdev)
 	return -ENODEV;
 }
 
+static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{
+	return 0;
+}
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
@@ -40,7 +45,6 @@ void pci_disable_pasid(struct pci_dev *pdev);
 void pci_restore_pasid_state(struct pci_dev *pdev);
 int pci_pasid_features(struct pci_dev *pdev);
 int pci_max_pasids(struct pci_dev *pdev);
-int pci_prg_resp_pasid_required(struct pci_dev *pdev);
 
 #else  /* CONFIG_PCI_PASID */
 
@@ -66,11 +70,6 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
 {
 	return -EINVAL;
 }
-
-static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
-{
-	return 0;
-}
 #endif /* CONFIG_PCI_PASID */
 
 
-- 
2.23.0.581.g78d2f28ef7-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
