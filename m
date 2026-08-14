Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAFD3CB559
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 01:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672621; cv=none; b=MiyA9ZeSJNgHwbeW8unC3zKpBH4SUj1Mh8PMENb6HbaopaAuZDUvlDY0CgYt6V9Hd2Q+KgnwLJh0Y7lKt4yK10tMyFY7qZsF724D4fqgEiiNitGIWrSRMJ00nGtoQgrNCSCDcPBMtPNoBsx11WZhfHUplX0AqGi8ZBgYpaGOMiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672621; c=relaxed/simple;
	bh=TeLGlZlGueMnnuDpyMEND3hVfU0bdUekXlmjXYYylRc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HI1EhMD11hzY3ISWBfYOHHAYABRijfScrw1VF7jax7TlnBlPUg3DoMaLsE7PO5qVladIaqwqFRLc2/jMNulnOggJzg1aGlaezG1CK35w60HGFZmpJEQkM0ZbJECi/yXsxlzw8ty0EteBuqV/JmAMOdSxbOcsAThj2Nz+QeAhvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ORUWUYSI; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORUWUYSI"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e3d575d6eso682509b3a.3
        for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 18:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786672619; x=1787277419; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lxGWxHB9t694q53I+ISUkOTr7+vIRLM1u+PIWdopAvk=;
        b=ORUWUYSIqhQL3Df5jQZsk3yS6qdD0WsVrxN2vbPDpmH3QzTj5Ta5sKcSjcoUtHOrO3
         VZtTkpuWaaYs3Hn+ZdyQM7ArSgRCWo7Ec65oNwXMQy1PPBARu50XPejw2qArUZcbh5Yg
         dGVNtABDLrpjgQCauRkSpv8SDS4BhqQjgNWdaAZoNVIvrxs0T97I6NM0oI8PZ00KB3wG
         4eXeqDEqpCuV4bnH9n5bqohJcUCFiKxYbgiz8vRZ8GiCDpRv5g1CvrZyJYE64UNSGn8H
         G4rMNvmb8xMw1cZNNMApfGAr5HRt8uiGEUgoKHZEEIYkutkBx9ePZDD6w+LtRhfGXxpW
         eCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786672619; x=1787277419;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lxGWxHB9t694q53I+ISUkOTr7+vIRLM1u+PIWdopAvk=;
        b=mdnmFqIlnOk304b1fxVoDSed50VF9aAIqUPKvvypclCc69khIMq02xRj5gwtYBw1MM
         vVPYnhaNDkjilK2Fkw/NLDlDBfgFG9RlQ4U/dzKK+vUY+b9S39yYQXTQGHsx6foQClD/
         AvkxQ7KPFRdj7pOrLXqi0n9rO8pNX0AKzLGiXKC6SJA8jNSbFvTTns/EqFbXABsXCC2e
         3B8inBg7XjuF9eiXGz4QbMXOe1jamKyF+yDQRtS1r53SqwNqf2Ln2kD57jmyCVyjJJgc
         gVfZmKImqub3mDjBYeu8AI7VdpPWRgRDOuqDSk4Dp+vg8HfASOyPtkt2LFJGTOt81r6k
         CC6g==
X-Gm-Message-State: AOJu0YyQdVyvvkQcRoUAksB9Kb9rOScOVNrx0GFU7itSbm216RQ4DR2d
	3TIdII7DdwB3N0zz6tNuEHl10uw0/ui4pWSc/eM6MQzkPTqSlcVSEQM6IYVQzs0QiexN6DQtLLM
	zkjxNuE8Q/jbrI2pIWnf49rb5XYUwbYkwbRxDlla7mTyt1UJaquwAqfnlwU8D7TVOUVrsrakAER
	mS0Y6xcNn613W/w5TEFZWsJTq6Eq/vDw==
X-Received: from pfbfb42.prod.google.com ([2002:a05:6a00:2daa:b0:847:8962:8101])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21cf:b0:845:cf86:9469
 with SMTP id d2e1a72fcca58-84fde26cd95mr1986048b3a.29.1786672619169; Thu, 13
 Aug 2026 18:56:59 -0700 (PDT)
Date: Fri, 14 Aug 2026 01:56:46 +0000
In-Reply-To: <20260814015647.3370124-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260814015647.3370124-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814015647.3370124-5-praan@google.com>
Subject: [PATCH v2 4/5] iommu/amd: Fail probe on ATS configuration failure
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the driver to call pci_prepare_ats() after checking if
pci_ats_supported() and fail the probe_device if pci_prepare_ats()
returns an error. Additionally, update pdev_enable_cap_ats() to WARN_ON()
a failure in pci_enable_ats().

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 40 +++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 808011a700de..5ccc76bffb88 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -573,10 +573,17 @@ static inline int pdev_enable_cap_ats(struct pci_dev *pdev)
 	if (amd_iommu_iotlb_sup &&
 	    (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP)) {
 		ret = pci_enable_ats(pdev, PAGE_SHIFT);
-		if (!ret) {
-			dev_data->ats_enabled = 1;
-			dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
-		}
+
+		/*
+		 * pci_enable_ats() should not fail here because earlier
+		 * checks have already verified support & config.
+		 */
+		if (WARN_ON(ret))
+			return ret;
+
+		dev_data->ats_enabled = 1;
+		dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
+		ret = 0;
 	}
 
 	return ret;
@@ -2483,10 +2490,12 @@ static void detach_device(struct device *dev)
 	mutex_unlock(&dev_data->mutex);
 }
 
-static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
-				   struct device *dev,
-				   struct amd_iommu *iommu)
+static int iommu_init_device_caps(struct iommu_dev_data *dev_data,
+				  struct device *dev,
+				  struct amd_iommu *iommu)
 {
+	int ret;
+
 	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
 		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
 	else
@@ -2495,7 +2504,7 @@ static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
 	amd_iommu_set_pci_msi_domain(dev, iommu);
 
 	if (!dev_is_pci(dev))
-		return;
+		return 0;
 
 	/*
 	 * By default we use passthrough mode for IOMMUv2 capable device.
@@ -2518,7 +2527,13 @@ static void iommu_init_device_caps(struct iommu_dev_data *dev_data,
 					     pci_max_pasids(to_pci_dev(dev)));
 	}
 
-	pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
+	if (pci_ats_supported(to_pci_dev(dev))) {
+		ret = pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static struct iommu_device *amd_iommu_probe_device(struct device *dev)
@@ -2543,7 +2558,12 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		goto err_deinit;
 	}
 
-	iommu_init_device_caps(dev_data, dev, iommu);
+	ret = iommu_init_device_caps(dev_data, dev, iommu);
+	if (ret) {
+		iommu_dev = ERR_PTR(ret);
+		goto out_err;
+	}
+
 	iommu_dev = &iommu->iommu;
 
 	if (amd_iommu_pgtable == PD_MODE_NONE) {
-- 
2.55.0.691.gc56d675ccc-goog

