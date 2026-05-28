Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3EA35FF5B
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999852; cv=none; b=FXgMtXOxE5RDOZpNHNuGWMMdirNU8p94n6GQv2V9cpIzjW26RUd32rO+87HTnmLase9i+5oic9itcxofH2bQoBolPrDqVJfNK8DpwyrEIFuNIEK/lWndGWb0ss7HSTvjdHm6qxaqnF+dqCQBkyumqp6xgfCKMsUwyGDTNlaJUms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999852; c=relaxed/simple;
	bh=rCPBs6VpzFnSeGV1IQONO9sqLS2eG7RrmNxYtsUNeyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c9KaQ2mwoFeyIVu52OqNvoH4v1cRxocIQzkF9YBNxuy3PZS8WYzHBRNaslRLrG5/LJqnWYoX2gaLtC1E64YaG55KNC94Uwd2EJyqXTx3xp+Gn0ZCu+SShPwSbHaDuYdjHw4iT9aGvizRkSEm1Tugc+ffarS6gTU8GHQtGopAE90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Txlfjdvg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Txlfjdvg"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36ba98cc003so366384a91.1
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 13:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779999850; x=1780604650; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=junrNZ+TOSSnGGCt6IWg1rMtIZuzEOzNu3RMYtfyWkA=;
        b=TxlfjdvggCP5qZd2dvwV1YdGTpjhtPtnkCdXk+gUF2EqAOdLoXEGX5QmpKYeKnf/8P
         VbYBBzJNdwkEeCgdbM6LeGatREC1u2RroEohAzOa9DVmobxmeJFTgg7MCLUcurshrBTU
         IEyKPJxLu5QfEPt0yha2e8tKl5dQMtW7liu2xLnIUFY+F0TMAgErJhJATG0XFG7usBqH
         abmjMxaCb9VLcrdty0pVKl43arpTYpOCrKyePmBq+hnPv+qA+4xXXf5VSnWTbt5O2Xvq
         eDaP8B3zBA2OT/niGVSF71jKp3OBqA4lsc0dBhMpZ3GUCQBFDDXd4UBrWdMcjN/fLN1S
         C4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999850; x=1780604650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=junrNZ+TOSSnGGCt6IWg1rMtIZuzEOzNu3RMYtfyWkA=;
        b=ECI8gcLaJ/lqxP7X5aJ/F0aLja7rh8+sNd9t/tDyS+2s8RDNlqu2xQUC4apv9qmzye
         X9MifgC+U0jOSNJS+p7foP4xbIgcXPbG+84yAYWGDVPxx3cMVsfRMNg5NjPOf/Sjy9uY
         1srzQGNtw/ZqLdJPvqKElWiKwmB0N5TYP5KfBD7ldNADmGDu9VzsSCpxo5IZcLqBLFsj
         kzEzhgYlICPohExy2ve+9HQ16aMLLdJOJ35JlLmSYki1uYe6A8M4+owjtEbs2FSeC/99
         E2/B/x9Xsgyheios9pjOljsHT+W7Bv7BJh4pTDbooaymrA1y3GclGMHucmX/bRX4haOO
         kQEw==
X-Gm-Message-State: AOJu0YxU8zyx79FM9jc+PqlGJbewbSeX3sTk4AQAGms/1R2JBQH7gvF/
	2aBM5CSq59mhB80VuwT9/JU/PlJa/4MMf4WVm1Gl6nnkgqadQXKTYUbB8+yeXeN6hNwH7gmUwg5
	xCgmNhvtQKnVIqc5FyWvEQsaBBssZ6Lx0BtLFgE5LjoxjU+67nkLz7qPeqBJojy5QI7v8FwfmY9
	tc3acEulD+HYgkLqh2R0NG+viIPtUsyw==
X-Received: from pjbbb14.prod.google.com ([2002:a17:90b:8e:b0:36b:bdb2:1426])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:586b:b0:36b:abe2:bc82
 with SMTP id 98e67ed59e1d1-36bbcc16bb4mr121972a91.1.1779999850016; Thu, 28
 May 2026 13:24:10 -0700 (PDT)
Date: Thu, 28 May 2026 20:23:53 +0000
In-Reply-To: <20260528202353.3422206-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260528202353.3422206-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528202353.3422206-8-praan@google.com>
Subject: [PATCH v5 7/7] iommu/amd: Fail probe on ATS configuration failure
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

Fix a pre-existing Use-After-Free risk by ensuring iommu_ignore_device()
is called on all probe failures after iommu_init_device().

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 84cad43dc188..b74c4504bee3 100644
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
@@ -2502,10 +2508,22 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
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
+	if (IS_ERR(iommu_dev))
+		iommu_ignore_device(iommu, dev);
+
 	return iommu_dev;
 }
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

