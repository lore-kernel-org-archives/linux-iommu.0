Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74577C43617
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:02:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C97E20823
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 18:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RaBfqvZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C97E20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 25816888BF;
	Tue, 19 May 2020 18:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a7nFrkP4DIjf; Tue, 19 May 2020 18:02:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 41C70888C4;
	Tue, 19 May 2020 18:02:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23A4CC0890;
	Tue, 19 May 2020 18:02:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F609C0881
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 26C2686D59
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y195njs061uR for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 18:02:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 66D9B86D87
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 18:02:10 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id f13so156694wmc.5
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 11:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hORlUUicNTnmubGRwNiUffCoZPiWJG9HuOL8osSXdzo=;
 b=RaBfqvZBLG2+O2ys2+0Ikq5Wp+XHH/rqPMkeuqJRaQX3zplSn8zIVMkUTAPhGK28u9
 wAEiv6Yy2jClvwowLeJGvp9nz/q2xjW3B1m8ef6AweRUFIRQce+1qhbFZu9Iqxpgb93T
 HQS/ayRa/QKZAcPdong1IOD4jlzFFccRioNNAzKo4Svis/lAW9o32Xi6WC9+XqJP5jVD
 95wb3prQy7RhU+V9NvD9Uimr2HAe66cN0BSaK01ShE8K4Vh5b6WaVDUh0vqD6yii3Akb
 VvWJQ/nNMjB1sgj37nXUu8itMP/AiTtQykovHtt0BFwZVr2yuqgX+iT4E9CLWqxkgpmY
 SZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hORlUUicNTnmubGRwNiUffCoZPiWJG9HuOL8osSXdzo=;
 b=HBDmMTyeXXt9xK2pUlzm1AO9W+M7Uox40GMJwD7mBsg4QNLDYe74vRqsqNh/h28cQe
 QpGawoQgpwx8Mz0/gjgcoG4c9izIOc0RYCs5xcgvZlPb+Z6PeTRSw4Q8P/CGAHZsobpE
 LVlTtO5PGKgFZueUE4PgpzY/htkC1Re+ZxjA+Eouw5PqYjIEMZt5gs/gSKXkQEoRuruS
 /CKtK8R/r6ErRXCvsUk068O/Xh4afVO3qMgxD5UHp7NjZ7+2mNc2ZQBYuh0yBl83kOk8
 b8SsYIvqTNwkz/UHGlm0PNWwT1xUYglSPZw9oUPiJR5/N7yGVFibNU7Y/24kqDyT//PM
 YhiA==
X-Gm-Message-State: AOAM531TCKyD4XdD29/3S1o+OaKayk4y+La8VxNOdtMIZk9zNnXkzMyW
 f68jtb2/QHku0U2D1B4OeoI7M4nvCuzq6g==
X-Google-Smtp-Source: ABdhPJxkJn6Qhu9nn0EKvZWG6V4NMT7DJRYrUqG7GGKCgCc/g26MRyJ+LKLXQeOruPfp1Lim/+kFJw==
X-Received: by 2002:a05:600c:29a:: with SMTP id
 26mr615194wmk.151.1589911328505; 
 Tue, 19 May 2020 11:02:08 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 11:02:08 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v7 23/24] PCI/ATS: Export PRI functions
Date: Tue, 19 May 2020 19:55:01 +0200
Message-Id: <20200519175502.2504091-24-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, kevin.tian@intel.com, jgg@ziepe.ca,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, felix.kuehling@amd.com, will@kernel.org,
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

The SMMUv3 driver uses pci_{enable,disable}_pri() and related
functions. Export those functions to allow the driver to be built as a
module.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/pci/ats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index a4722e8b6a51..418737a3c2c2 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -191,6 +191,7 @@ void pci_pri_init(struct pci_dev *pdev)
 	if (status & PCI_PRI_STATUS_PASID)
 		pdev->pasid_required = 1;
 }
+EXPORT_SYMBOL_GPL(pci_pri_init);
 
 /**
  * pci_enable_pri - Enable PRI capability
@@ -237,6 +238,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_pri);
 
 /**
  * pci_disable_pri - Disable PRI capability
@@ -316,6 +318,7 @@ int pci_reset_pri(struct pci_dev *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_reset_pri);
 
 /**
  * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
@@ -331,6 +334,7 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 
 	return pdev->pasid_required;
 }
+EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
 #endif /* CONFIG_PCI_PRI */
 
 #ifdef CONFIG_PCI_PASID
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
