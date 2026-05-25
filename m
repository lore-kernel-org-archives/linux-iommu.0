Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253AD37BE88
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734644; cv=none; b=Xg3gSv7wH3B86SY2dp5JbuEKlH6O7h5SjXYr4jg0uvSPcx0iW7qzTemhdsM7CGbIpQoOuBspqs+2n7vL9+8Rf3JcG3zSK9BXJvfPqtHD7+bspNFbIXYiSqfI/kQh2WMkR5hSgpj74vkKHSsrGnm4WMHYsn0TcEwBFlbHUFkmg9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734644; c=relaxed/simple;
	bh=cfRHgvxt8vecrezTNhpJ2ROe+FrkIO0BXhKCSXsf5wY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RTlWWolQwmaEieTWcbTws8BOQJNrG8PhP2HHh24A0TCLB3LRfLieRuUBOCvefDIaFzW5z+AFt8AV1lXFX0nw85KKZC+ip/uIINgfLsEi/HJm18nl08MTSkgwAreEskyVTZQYzm72FxOUnbQzn/JI7xy+yU+kW1s9GVQ83FbftLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WCXhiigo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCXhiigo"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd1dbcccf6so24837475ad.2
        for <iommu@lists.linux.dev>; Mon, 25 May 2026 11:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779734642; x=1780339442; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejVfo6aDK2IjkhbswQYdZPzC7RHqvBJONF1IKeVRso4=;
        b=WCXhiigo5hw63i7D7dVWP+7TLp9DahoRT0OvuD157hw9EetpHKkcFsmpkv35AyHFj3
         eAxZ9POXvStr2bl84cFYAlV4nFXVU5eRLwybLr3OM00wX7zALaVFlOYzEq0KoqkbL5YA
         13f3XkNybv/Zk7lER4PUtgEV+mDLiSfk9UjrK+hJblSbvLKhm81GDtKPnjGfMolrszNj
         30YDCk0na8eT6YTihFPBIgH8C2cqTcMMIlZ4HUOHZgGa9KQT5CbepEqPi3hAL3qhoPJu
         6AA3gPX7nzI9YICrHq0SAmAeEWYqBp18Z8BtRRjqiMSieob+wspxJz9IxPCgna9S840t
         hVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734642; x=1780339442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejVfo6aDK2IjkhbswQYdZPzC7RHqvBJONF1IKeVRso4=;
        b=XdB57qOmUCvl3zA4bXkYLddqIv0kxm3HPV5ZA9xQv+BLXbs0CiHJx4yb1x91Sa5Xa3
         rBreOY1DIPIkiFfbss6TK24Hvf4XYitR0xfd0ZqNHFJT/MKkTHtgwgKz+LTVxoEDcU3g
         QcJwXUJEDV768IJTvi3oDSLCMOixTQJrKjKxpfsvFzHmGJ99voO0OteTVlQBSZnXcV9Z
         FGHD+QA1FAeMSEY656BRIMPnzcFfuQQrWH63SqLSrFeVXtxfZ5W02ofNGZgvTKvFU5Bk
         EKsHOlzFpn5YgAzFjAniQ1BtnnOR+GlHTK8U+Z6yKVvdExGJ5ssn5J2KocfZfCVtjBl9
         Izlg==
X-Gm-Message-State: AOJu0YzfZUEp84DeMdvHSmc9rg807kXQaGS/flFvXLzvX6DmDoHDMF+h
	PyxMb/VUy1/URgTDoIz/NhXhhxF/2/Y5nAcs4Ndv4wKcNKIkJHO8X9SNHPHfxiH0rnQnbNTU1Qm
	zoMZCIITnYAh+Enl68nbCvu/08uBSUqo1eBBtaDixtsaKO2U7j7QieiAoVW8Y9b+t4QqMcoLtST
	bX9H2XpCupnk33dec/hCHQ63ntS5vXwA==
X-Received: from plbke6.prod.google.com ([2002:a17:903:3406:b0:2ba:2935:3b4])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78e:b0:2bc:8359:66f
 with SMTP id d9443c01a7336-2beb06db375mr172687615ad.35.1779734642223; Mon, 25
 May 2026 11:44:02 -0700 (PDT)
Date: Mon, 25 May 2026 18:43:47 +0000
In-Reply-To: <20260525184347.4059549-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260525184347.4059549-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525184347.4059549-6-praan@google.com>
Subject: [PATCH v4 5/5] iommu/amd: Fail probe on ATS configuration failure
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, David Matlack <dmatlack@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mostafa Saleh <smostafa@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the AMD IOMMU driver to handle ATS configuration and enablement
more strictly. Specifically, update the device probe to fail if
pci_prepare_ats() returns an error. This ensures that any ATS-capable
master reaching the attach phase is guaranteed to have a valid config.

Additionally, update pdev_enable_cap_ats() to WARN_ON() if pci_enable_ats
fails. Since earlier checks in the probe phase preclude config-related
failures, any failure during hardware enablement is considered a kernel
bug.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 84cad43dc188..1dddb08e7b22 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -570,10 +570,16 @@ static inline int pdev_enable_cap_ats(struct pci_dev *pdev)
 	if (amd_iommu_iotlb_sup &&
 	    (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP)) {
 		ret = pci_enable_ats(pdev, PAGE_SHIFT);
-		if (!ret) {
-			dev_data->ats_enabled = 1;
-			dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
-		}
+		/*
+		 * pci_enable_ats() should not fail here because earlier checks
+		 * have already verified support and configuration.
+		 */
+		if (WARN_ON(ret))
+			return ret;
+
+		dev_data->ats_enabled = 1;
+		dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
+		ret = 0;
 	}
 
 	return ret;
@@ -2502,8 +2508,17 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	else
 		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
 
-	if (dev_is_pci(dev))
-		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		if (pci_ats_supported(pdev)) {
+			ret = pci_prepare_ats(pdev, PAGE_SHIFT);
+			if (ret) {
+				iommu_dev = ERR_PTR(ret);
+				goto out_err;
+			}
+		}
+	}
 
 out_err:
 	return iommu_dev;
-- 
2.54.0.746.g67dd491aae-goog

