Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC04BCA906D
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA172051A
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8F2CAh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA172051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6BF3286DF2;
	Thu, 30 Apr 2020 14:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5_7aooJeRU2H; Thu, 30 Apr 2020 14:40:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DEE0386E09;
	Thu, 30 Apr 2020 14:40:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2CB2C088D;
	Thu, 30 Apr 2020 14:40:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E55EFC016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D4AB388789
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2PsWOTDeGWXN for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 14:40:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E5EF88879B
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:47 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id y24so2204773wma.4
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 07:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=62jj6X1LyxzprUaI/fsrszNvC/iCvzNFlzOxzXxMTmE=;
 b=y8F2CAh6V2jZZ6B8MaXX8bNU3xhjF6A6xftgKRo5JNfOivZ4u0mxU5xIR4pAdncRts
 6l7bUbk1qPf11fVOJF5ftAX+YvaRJ8cXFwCudw6bxApeZPCZrXZtaaHXtPfThk5Jco3K
 a/O5NV8b14TR6O3KF9WIkjjfc/Gcv12HGrAm6m8EO0m1BeQXzRMZnOhib6MYqbtHBwsT
 sErFA6eMmDmS52FVu+QrR1ltOzaQfn2PJ62g8elC51l52AIXrpu8StMl/Go2TPf2eTs+
 JpTwIf91IA6+h7AHE7yatTK0354lTEslYrLGPhBE1Hb4pA4bdkCtICpgF+meBh7cqw9n
 5sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=62jj6X1LyxzprUaI/fsrszNvC/iCvzNFlzOxzXxMTmE=;
 b=UAlaV9MpS4ipK6fettg9MXgbQTM+e1+vHGelrSlt4/XzRR391iAD/Yjykh19K5Q3iJ
 8+1qNHJ9duIFruslGv1kOPPk+mw12KyUsHKYJbZAE2iMnRlXZjNP4b5K00ItIgaQtqDX
 AcZjzaeIVicka4WkvBOfIibNbuNnKCvLaOrIgTFUZaUqhy+SujOXWPavipIKx0nifeHc
 MdVeRFNPLBZugVEx0YZ5dNV/AUcqxt5xcNed9aFgz5RQFp65ZUbU+OEKD858zLFC4ASS
 HPF6d6LlFcTBsGm9IoVjw3dfb3yjtdsHWnoyH+nfxjaWa49dVU/Aw7dOnGiFJFT+ANUh
 OVaA==
X-Gm-Message-State: AGi0PuZNFAFDYSGb1w5a1nwfkNlllSR/YjsG/ZExtu+5oLPqWRmDQA+t
 YLgAwJ1xSWpcMxFLKRp8cmZkEkVOy9o=
X-Google-Smtp-Source: APiQypKtLi1Ei7GLEgyORO8pAsx6cVgJjSvoyoPjqzURXKE3LoS9Wil8gnTZulxN2y2v3ecbYlihTA==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr3533862wmc.83.1588257646202; 
 Thu, 30 Apr 2020 07:40:46 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 07:40:45 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v6 23/25] PCI/ATS: Add PRI stubs
Date: Thu, 30 Apr 2020 16:34:22 +0200
Message-Id: <20200430143424.2787566-24-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
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

The SMMUv3 driver, which can be built without CONFIG_PCI, will soon gain
support for PRI.  Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove
unused PRI and PASID stubs") to re-introduce the PRI stubs, and avoid
adding more #ifdefs to the SMMU driver.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
