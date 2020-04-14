Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DD6C55180
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:05:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2822206A2
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSZ3slzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2822206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A5BB221F5A;
	Tue, 14 Apr 2020 17:05:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NJ3D8Uq11AuF; Tue, 14 Apr 2020 17:04:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AACCA203A4;
	Tue, 14 Apr 2020 17:04:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93C4DC1D8D;
	Tue, 14 Apr 2020 17:04:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51964C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 32FE72154A
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T-3ZXXOZDOQ8 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 17:04:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 153F22155D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:52 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id t14so2023234wrw.12
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dxDAAgL2UYsehlg428ECGLr43fDkT+szEz8iWolntSk=;
 b=KSZ3slzLde6NozRQYn2Ai7oqpucgG9X78qXMfbMZBdcER7nRY1kUNT7Qt/IDN4MDjl
 vb8Pwa0ulpEZSn0BBnH4dvqEPTE7RcoGq9Z0W234cFc+SVbRftS1kIvCyI853alAlB+Y
 rEPDG1qUaGZ8aDnk0qSGGOfVXMDaGzZE9CbxCxqT/oC+CO1OIwkFRvN+6kDc104C4vkE
 8G9SDBWgw+ffbm6VeWoWzvyoCQ+PUbDkthqAws5ZdzYv2p4NNty/Nv1AQXZJv7O+3rA/
 yHUo655cjGXVw0ER+P3ankuAQ6Jt9og6eLbHOvkwVehp8uN30C+g/z+zrhkAnk1Cf6Kl
 OqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dxDAAgL2UYsehlg428ECGLr43fDkT+szEz8iWolntSk=;
 b=HY0hsT4RHkcW+Sjesp41d8c0oLjTihqEVEREyVDZoX3oc6DbA/R6MCup/BrSVND1f3
 H9a9367pptnchPYGDjZxxSu9rMQ2nlQpYZS9XF9siww/l0/VMfkZXBFJwfXGOaebcRGU
 N7qayQkd98rufxBuvEZQXXlHpmeiXc2tvnqbP3ahMftYdzqLGFqQicpPGWUc8iGNSos6
 VbVu0mc7g6YkjOtNxFJ65Xk8phfBeMkJ6rmsoaZb4BZCmIN864iXMyDq+BC/FENnRSfo
 vQ+7eubOs7STsHPyiUwhCQndDIXUQaNudcfOPjuzRYsXxCw7jaDucOrxEDVQ5GgX9Psi
 d1RA==
X-Gm-Message-State: AGi0PubWCNi1Q6WeJvFyczyHtQ1GgcSNprG5ejDMzxoup4hwh/0Y1Aa7
 No9RlGwG2hNCss1Op3oeeA+DPknqbPMpvA==
X-Google-Smtp-Source: APiQypLvU1DM9P6089K9k3mSfMy8oJyq3WdIaLTthIKtphu5RdduiyeU/R3KBAD03tQZ8c5tQnffKg==
X-Received: by 2002:a5d:4447:: with SMTP id x7mr2258833wrr.299.1586883890363; 
 Tue, 14 Apr 2020 10:04:50 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 10:04:49 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v5 23/25] PCI/ATS: Add PRI stubs
Date: Tue, 14 Apr 2020 19:02:51 +0200
Message-Id: <20200414170252.714402-24-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 catalin.marinas@arm.com, robin.murphy@arm.com, jgg@ziepe.ca,
 Bjorn Helgaas <bhelgaas@google.com>, zhangfei.gao@linaro.org, will@kernel.org,
 christian.koenig@amd.com
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

The SMMUv3 driver, which can be built without CONFIG_PCI, will soon gain
support for PRI.  Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove
unused PRI and PASID stubs") to re-introduce the PRI stubs, and avoid
adding more #ifdefs to the SMMU driver.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/pci-ats.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
index f75c307f346de..e9e266df9b37c 100644
--- a/include/linux/pci-ats.h
+++ b/include/linux/pci-ats.h
@@ -28,6 +28,14 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
 void pci_disable_pri(struct pci_dev *pdev);
 int pci_reset_pri(struct pci_dev *pdev);
 int pci_prg_resp_pasid_required(struct pci_dev *pdev);
+#else /* CONFIG_PCI_PRI */
+static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
+{ return -ENODEV; }
+static inline void pci_disable_pri(struct pci_dev *pdev) { }
+static inline int pci_reset_pri(struct pci_dev *pdev)
+{ return -ENODEV; }
+static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
+{ return 0; }
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
