Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC7ACA906C
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFE220757
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ond7VfsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFE220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1B0DD86DF6;
	Thu, 30 Apr 2020 14:40:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fax7T-UkW3Lf; Thu, 30 Apr 2020 14:40:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 78C5F86E09;
	Thu, 30 Apr 2020 14:40:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 660EEC0864;
	Thu, 30 Apr 2020 14:40:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF1B9C016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CC7F52514E
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AF-0pVuCsFmM for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 14:40:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 18EEB25265
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:49 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id e26so2151059wmk.5
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S8Zr7dUhZQI4HWh04x7nsOmPtJZbUwXznxGwACU1UQI=;
 b=Ond7VfsZgmGD/BrByxf9wz0efWlE1iwXffnfpfQfxt1hg9QT9Xs5mqM2Rr/FizdA+e
 IWEBTJhCC4xfsNHrlhEGfHF9LwPrU4ybRmBqXvtCSAgzt+kjb8RoWZdz70Mg491WTSOe
 epwnq/qI820d8QDoeGKyaC2M9DH6QVrxTbYbk7wjnrLB0OisjPj7hQm/Iz0c1B5TAdEy
 ik9JR0/fhw2dfKLEjNH/AByP8RBN8Rk7hu0iTumPKK6WIizh0K1GhVzR4dxhvfJc9gJo
 ci1084DYu6K879DUlLLGSCP2fM9vSK7OyOiumE/wAKaIBFk1KrHnIPzL9xfVwpktSlDF
 GFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S8Zr7dUhZQI4HWh04x7nsOmPtJZbUwXznxGwACU1UQI=;
 b=YLcly1OcPiFIc3q2NyHsXZXH71mYCYRYrG9wf6G2ahu+1557FcfMSLQ0/GUeiY7l27
 SHdqML7yhmz6F5HroWtZd8THaQ3OTz/FFlW6HZ9iZH8Wz7C4zm/QOXpR9HaA9GHdiOSH
 Gpe85bPF/L2+bc1JH5AwLPqHktN0+mcA3cj5he009e38RZJDs6Mh14DqzF6a+XDXdpJj
 Q5KNvc5DwmBcZHcB8k5nQWmks+VCqUX4lQZLmFTUoqc5FO1j0eEctIFWN6eR4elZ9ZeD
 wcesvYYaWLxHiIQcv9lFCBrGHxkgqGUvV3h/YkYBxhG8m0/z3APD8l7M5eQTL/rmkJHv
 vOTQ==
X-Gm-Message-State: AGi0PuaCGUQnCRyaXW42lkorwpqLivIdfncrK+nTu3X64i8X1mBNyVex
 vwDhXVAHhhwsFm6vhkhWKKN/202mpno=
X-Google-Smtp-Source: APiQypJa6BmZ0czrxG/gUnFompMSHFZ8UIvLo+IeAtRqA371so/Ns388yHVshP+vFCzW1022DPCjrw==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr3126384wmc.146.1588257647382; 
 Thu, 30 Apr 2020 07:40:47 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 07:40:46 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v6 24/25] PCI/ATS: Export PRI functions
Date: Thu, 30 Apr 2020 16:34:23 +0200
Message-Id: <20200430143424.2787566-25-jean-philippe@linaro.org>
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
index bbfd0d42b8b97..fc8fc6fc8bd55 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -197,6 +197,7 @@ void pci_pri_init(struct pci_dev *pdev)
 	if (status & PCI_PRI_STATUS_PASID)
 		pdev->pasid_required = 1;
 }
+EXPORT_SYMBOL_GPL(pci_pri_init);
 
 /**
  * pci_enable_pri - Enable PRI capability
@@ -243,6 +244,7 @@ int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_enable_pri);
 
 /**
  * pci_disable_pri - Disable PRI capability
@@ -322,6 +324,7 @@ int pci_reset_pri(struct pci_dev *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_reset_pri);
 
 /**
  * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
@@ -337,6 +340,7 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
 
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
