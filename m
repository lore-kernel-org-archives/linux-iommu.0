Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01609C433E2
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 15:32:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB06F2075F
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 15:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4chTh4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB06F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 97A84881BA;
	Wed, 20 May 2020 15:32:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 90p1zcgAGfNJ; Wed, 20 May 2020 15:32:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 22518881AC;
	Wed, 20 May 2020 15:32:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09269C088C;
	Wed, 20 May 2020 15:32:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AEF7C0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 15:32:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 379B388165
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 15:32:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G70YraRoQNjH for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 15:32:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 39BC7881BC
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 15:32:49 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id e1so3608257wrt.5
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KMxSMp60RacutPPMRaTffGs/D3V+C6gcqSQh+60H4IM=;
 b=s4chTh4JDFjbN2gqTRyrB+FE+s9+8i/0fB88Bt2AOPHvQMpAM3GB80MGZAQGL2ZCJv
 wVV9P/kDEfZ4WBc+8nhHBecNu9A29ZysYDr+A6Y4pCFeSlbZnFi0Y9/Uya6DGUhNzXBb
 fj7Gj+i+ysvDh8pI+MeuBS7P/a031XQyCRHuY4E1U5BP/sKHh5sNVhl62x7S/n4YjnRp
 NNNnHpXJFlTghwMx0xG/JTXZ7fLa2Xt+eCqlfBrECBYpl0V8/pRRiWI/uy8q/MDWyT/i
 ylLzb/aNWYL0HaNX4GsQS6tqKBmhcqfE6HQ1vdqMPCLpXXMkFHWc/475lw5KY1I9m+tW
 T72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KMxSMp60RacutPPMRaTffGs/D3V+C6gcqSQh+60H4IM=;
 b=qF1x/oACnd7KahPh3ob1yJgXkhU5K/upP292QVuXoq9k0uyXhOoWHRc/YG274DeIkp
 uHlT9GSGja47t3dvIoTTyuzC1a/rCw/mPt+eUGywXHbeUqDdZPaa0pgd4z4txTyyHCjI
 S3iLOopSrB9ynS4yqMIuBipYUNi/6Jv9UxXrcpRV3Uovn4F99RCX9X5MJd8iXc60i34B
 YxxZ5sarojCnSJNesU/YeG9sXPnk3z7EXtbGbM5MU8BhQBr0mhf5AfHZaGh6capDQ8tE
 2AXk+kiLGk0ILO8PDobAHxLbJDfUqvnJZvVVzpzGGPTZOFZbcOYkK89fNa6F6rXsJvKo
 vtvw==
X-Gm-Message-State: AOAM532GgIna1Hpl6fjcB+uQJAcsOHdNI5tvytIwMfBKiWI1cGKBILA3
 tiszqUwcSrd2lXw1D9Epi0RayA==
X-Google-Smtp-Source: ABdhPJwJ12nN9Fkxr6qovPQcMT+RAZ4bBWm0IKZ4hW0qiE5gXWSsj2Yy/ihMe7U9E4fOI73l+IQpXw==
X-Received: by 2002:a5d:4008:: with SMTP id n8mr4535997wrp.82.1589988767748;
 Wed, 20 May 2020 08:32:47 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id 5sm3395840wmd.19.2020.05.20.08.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 08:32:47 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, joro@8bytes.org, bhelgaas@google.com
Subject: [PATCH v2 1/4] PCI/ATS: Only enable ATS for trusted devices
Date: Wed, 20 May 2020 17:22:00 +0200
Message-Id: <20200520152201.3309416-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520152201.3309416-1-jean-philippe@linaro.org>
References: <20200520152201.3309416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Joerg Roedel <jroedel@suse.de>, ashok.raj@intel.com, will@kernel.org,
 hch@infradead.org, alex.williamson@redhat.com, robin.murphy@arm.com,
 dwmw2@infradead.org
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

Add pci_ats_supported(), which checks whether a device has an ATS
capability, and whether it is trusted.  A device is untrusted if it is
plugged into an external-facing port such as Thunderbolt and could be
spoofing an existing device to exploit weaknesses in the IOMMU
configuration.  PCIe ATS is one such weaknesses since it allows
endpoints to cache IOMMU translations and emit transactions with
'Translated' Address Type (10b) that partially bypass the IOMMU
translation.

The SMMUv3 and VT-d IOMMU drivers already disallow ATS and transactions
with 'Translated' Address Type for untrusted devices.  Add the check to
pci_enable_ats() to let other drivers (AMD IOMMU for now) benefit from
it.

By checking ats_cap, the pci_ats_supported() helper also returns whether
ATS was globally disabled with pci=noats, and could later include more
things, for example whether the whole PCIe hierarchy down to the
endpoint supports ATS.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/pci-ats.h |  3 +++
 drivers/pci/ats.c       | 18 +++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

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
diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 390e92f2d8d1..b761c1f72f67 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -30,6 +30,22 @@ void pci_ats_init(struct pci_dev *dev)
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
+	if (!dev->ats_cap)
+		return false;
+
+	return (dev->untrusted == 0);
+}
+EXPORT_SYMBOL_GPL(pci_ats_supported);
+
 /**
  * pci_enable_ats - enable the ATS capability
  * @dev: the PCI device
@@ -42,7 +58,7 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	u16 ctrl;
 	struct pci_dev *pdev;
 
-	if (!dev->ats_cap)
+	if (!pci_ats_supported(dev))
 		return -EINVAL;
 
 	if (WARN_ON(dev->ats_enabled))
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
