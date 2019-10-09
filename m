Return-Path: <SRS0=Ni9g=YC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B7AECE58C
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 22:54:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32F620B7C
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 22:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ub814ZHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32F620B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CB757DDF;
	Wed,  9 Oct 2019 22:54:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 569C59CA
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 22:54:14 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E6AB314D
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 22:54:13 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 620DE2190F;
	Wed,  9 Oct 2019 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570661653;
	bh=vwAsHjIpJMFGa1o/24iffI4QWs6biqMN+sVglTxJguY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ub814ZHm5F7VqMTZH495WNPdwgVouKWogdiDPrEY0/6y28I3KdzrDe9hMgIT971ae
	gIsJA7tegnAH58ljiEHDoZHKzVyYHGM3OtRZoFoYwGhEa3kUDn+bj+lO8z3//a4SCv
	Tfp+YvHwi0F9rlUXbdqAZsPqi4EkROQBlX4GYwT0=
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Subject: [PATCH 2/3] PCI/ATS: Remove unnecessary EXPORT_SYMBOL_GPL()
Date: Wed,  9 Oct 2019 17:53:53 -0500
Message-Id: <20191009225354.181018-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191009225354.181018-1-helgaas@kernel.org>
References: <20191009225354.181018-1-helgaas@kernel.org>
MIME-Version: 1.0
Cc: Krzysztof Wilczynski <kw@linux.com>, Ashok Raj <ashok.raj@intel.com>,
	linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
	iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>
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

The following functions are only used by the PCI core or by IOMMU drivers
that cannot be modular, so there's no need to export them at all:

  pci_enable_ats()
  pci_disable_ats()
  pci_restore_ats_state()
  pci_ats_queue_depth()
  pci_ats_page_aligned()

  pci_enable_pri()
  pci_restore_pri_state()
  pci_reset_pri()
  pci_prg_resp_pasid_required()

  pci_enable_pasid()
  pci_disable_pasid()
  pci_restore_pasid_state()
  pci_pasid_features()
  pci_max_pasids()

Remove the unnecessary EXPORT_SYMBOL_GPL()s.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/ats.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 76ae518d55f4..982b46f0a54d 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -69,7 +69,6 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	dev->ats_enabled = 1;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_enable_ats);
 
 /**
  * pci_disable_ats - disable the ATS capability
@@ -88,7 +87,6 @@ void pci_disable_ats(struct pci_dev *dev)
 
 	dev->ats_enabled = 0;
 }
-EXPORT_SYMBOL_GPL(pci_disable_ats);
 
 void pci_restore_ats_state(struct pci_dev *dev)
 {
@@ -102,7 +100,6 @@ void pci_restore_ats_state(struct pci_dev *dev)
 		ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
 	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
 }
-EXPORT_SYMBOL_GPL(pci_restore_ats_state);
 
 /**
  * pci_ats_queue_depth - query the ATS Invalidate Queue Depth
@@ -129,7 +126,6 @@ int pci_ats_queue_depth(struct pci_dev *dev)
 	pci_read_config_word(dev, dev->ats_cap + PCI_ATS_CAP, &cap);
 	return PCI_ATS_CAP_QDEP(cap) ? PCI_ATS_CAP_QDEP(cap) : PCI_ATS_MAX_QDEP;
 }
-EXPORT_SYMBOL_GPL(pci_ats_queue_depth);
 
 /**
  * pci_ats_page_aligned - Return Page Aligned Request bit status.
@@ -156,7 +152,6 @@ int pci_ats_page_aligned(struct pci_dev *pdev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_ats_page_aligned);
 
 #ifdef CONFIG_PCI_PRI
 void pci_pri_init(struct pci_dev *pdev)
@@ -218,7 +213,6 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_enable_pri);
 
 /**
  * pci_disable_pri - Disable PRI capability
@@ -271,7 +265,6 @@ void pci_restore_pri_state(struct pci_dev *pdev)
 	pci_write_config_dword(pdev, pri + PCI_PRI_ALLOC_REQ, reqs);
 	pci_write_config_word(pdev, pri + PCI_PRI_CTRL, control);
 }
-EXPORT_SYMBOL_GPL(pci_restore_pri_state);
 
 /**
  * pci_reset_pri - Resets device's PRI state
@@ -299,7 +292,6 @@ int pci_reset_pri(struct pci_dev *pdev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_reset_pri);
 
 /**
  * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
@@ -315,7 +307,6 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 
 	return pdev->pasid_required;
 }
-EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
@@ -373,7 +364,6 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_enable_pasid);
 
 /**
  * pci_disable_pasid - Disable the PASID capability
@@ -398,7 +388,6 @@ void pci_disable_pasid(struct pci_dev *pdev)
 
 	pdev->pasid_enabled = 0;
 }
-EXPORT_SYMBOL_GPL(pci_disable_pasid);
 
 /**
  * pci_restore_pasid_state - Restore PASID capabilities
@@ -421,7 +410,6 @@ void pci_restore_pasid_state(struct pci_dev *pdev)
 	control = PCI_PASID_CTRL_ENABLE | pdev->pasid_features;
 	pci_write_config_word(pdev, pasid + PCI_PASID_CTRL, control);
 }
-EXPORT_SYMBOL_GPL(pci_restore_pasid_state);
 
 /**
  * pci_pasid_features - Check which PASID features are supported
@@ -450,7 +438,6 @@ int pci_pasid_features(struct pci_dev *pdev)
 
 	return supported;
 }
-EXPORT_SYMBOL_GPL(pci_pasid_features);
 
 #define PASID_NUMBER_SHIFT	8
 #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
@@ -478,5 +465,4 @@ int pci_max_pasids(struct pci_dev *pdev)
 
 	return (1 << supported);
 }
-EXPORT_SYMBOL_GPL(pci_max_pasids);
 #endif /* CONFIG_PCI_PASID */
-- 
2.23.0.581.g78d2f28ef7-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
