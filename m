Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A402C3B191
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5193522314
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vb+Tx4YP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5193522314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 44F742153B;
	Thu, 13 Feb 2020 16:52:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lk3m-aZ2oKtZ; Thu, 13 Feb 2020 16:52:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D299F2152F;
	Thu, 13 Feb 2020 16:52:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE948C07FE;
	Thu, 13 Feb 2020 16:52:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2138C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DEE0E86E89
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id poeG9bhXOp79 for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 16:52:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4FE5286E7F
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 16:52:11 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id c84so7564328wme.4
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 08:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KQbvHTAFoAU5RHLdLgupX/fENQ0mj2n5jeDSVw5UmQU=;
 b=vb+Tx4YPjuXKC+c6jky2UOwKA2GKWNy9qTjZE2ccpnmXF3+xctohVChy1RbIW9obB9
 T5Dve49ZEZiff4UfFfbZ1i2aUZzg4V2o2NTC/rqi2aeTWg6t7vgUSnfI6pPcZ63ljaYq
 1jksjGTZuLzEXRfpEum+ObMhOmrPcw67ATU4rmbyzt5qncORgsTJtboZDSrixLiU39r6
 d4FHVn+XQpd4hHLF6Mvwomwy2xBIomvAvWxjfaz/xaLo4n269iAJR7AQZt6hs6TqCjTJ
 7XxeEJhZ/HsAQQ6e2wKmcrt0h5oWxjRhU48DgNeKFQNSppeWzcoCSrf/Y/j58wqyrVxo
 Cviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KQbvHTAFoAU5RHLdLgupX/fENQ0mj2n5jeDSVw5UmQU=;
 b=gjP899FGdFxWTg9iSmx7GbFZft0ZxmbdYnBXNJ2Ja62QTSZ347vVnL28bS1Oz9wy26
 E3LzvmtaVYB+KKMukdH4PUDtWuOn8v6D9Bh8GCMJWR2qKCVc50+MriMJUdI2yMi0rMUK
 Awh83++LwdQ+k5y6dzLPrVPWsH5Y/yWqu0u0j9JOTQ+H1vi91lPlCw/A39iqQSvI2zPS
 boB0pdbDdxJkrFHWaneOxZPjt9+y23RN0nCgOja1p3THQF08++y/PPgjFSkUtXCRObN7
 C5TiCYg7sSqtz54QjjsQu4aTcbddPjqeZWSrg1D3pbAfzWLbq6LSisP/9Hg6GnU7pJDR
 nV5g==
X-Gm-Message-State: APjAAAWIv3KwuDq4e7WPBpmBkOo62am9USJ+nKJbd6PmGLM1tUDEvd0+
 jkoq4Z6vKpn/o6sB2XNsAq4YLw==
X-Google-Smtp-Source: APXvYqw/HW+Dcw12NoCQYY4ILhwP9Zxgh/zKxvP8cCtRxWLv/EO4gTZlVf5WfvykVkAwV5DQqK1Qkw==
X-Received: by 2002:a1c:ddc3:: with SMTP id u186mr6747949wmg.103.1581612729610; 
 Thu, 13 Feb 2020 08:52:09 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y6sm3484807wrl.17.2020.02.13.08.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 08:52:09 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
 lorenzo.pieralisi@arm.com, joro@8bytes.org, baolu.lu@linux.intel.com,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 05/11] PCI/ATS: Gather checks into pci_ats_supported()
Date: Thu, 13 Feb 2020 17:50:43 +0100
Message-Id: <20200213165049.508908-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213165049.508908-1-jean-philippe@linaro.org>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, frowand.list@gmail.com, corbet@lwn.net,
 liviu.dudau@arm.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
 guohanjun@huawei.com, amurray@thegoodpenguin.co.uk, robin.murphy@arm.com,
 dwmw2@infradead.org, lenb@kernel.org
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

IOMMU drivers need to perform several tests when checking if a device
supports ATS.  Move them all into a new function that returns true when
a device and its host bridge support ATS.

Since pci_enable_ats() now calls pci_ats_supported(), the following
new checks are now common:
* whether a device is trusted.  Devices plugged into external-facing
  ports such as thunderbolt are untrusted.
* whether the host bridge supports ATS, which defaults to true unless
  the firmware description states that ATS isn't supported by the host
  bridge.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/ats.c       | 30 +++++++++++++++++++++++++++++-
 include/linux/pci-ats.h |  3 +++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 390e92f2d8d1..bbfd0d42b8b9 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -30,6 +30,34 @@ void pci_ats_init(struct pci_dev *dev)
 	dev->ats_cap = pos;
 }
 
+/**
+ * pci_ats_supported - check if the device can use ATS
+ * @dev: the PCI device
+ *
+ * Returns true if the device supports ATS and is allowed to use it, false
+ * otherwise.
+ */
+bool pci_ats_supported(struct pci_dev *dev)
+{
+	struct pci_host_bridge *bridge;
+
+	if (!dev->ats_cap)
+		return false;
+
+	if (dev->untrusted)
+		return false;
+
+	bridge = pci_find_host_bridge(dev->bus);
+	if (!bridge)
+		return false;
+
+	if (!bridge->ats_supported)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(pci_ats_supported);
+
 /**
  * pci_enable_ats - enable the ATS capability
  * @dev: the PCI device
@@ -42,7 +70,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	u16 ctrl;
 	struct pci_dev *pdev;
 
-	if (!dev->ats_cap)
+	if (!pci_ats_supported(dev))
 		return -EINVAL;
 
 	if (WARN_ON(dev->ats_enabled))
diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index d08f0869f121..f75c307f346d 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -6,11 +6,14 @@
 
 #ifdef CONFIG_PCI_ATS
 /* Address Translation Service */
+bool pci_ats_supported(struct pci_dev *dev);
 int pci_enable_ats(struct pci_dev *dev, int ps);
 void pci_disable_ats(struct pci_dev *dev);
 int pci_ats_queue_depth(struct pci_dev *dev);
 int pci_ats_page_aligned(struct pci_dev *dev);
 #else /* CONFIG_PCI_ATS */
+static inline bool pci_ats_supported(struct pci_dev *d)
+{ return false; }
 static inline int pci_enable_ats(struct pci_dev *d, int ps)
 { return -ENODEV; }
 static inline void pci_disable_ats(struct pci_dev *d) { }
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
