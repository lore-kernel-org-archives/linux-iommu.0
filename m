Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515833D1A97
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053149; cv=none; b=TbpeWL7U6O6ZpSIJ9h1Ie3//LQ/dfealwJz53XOuI1eeD+tVQQFZHUXuQwLCYuPaiju6xr7xWwBq1S+2QVkrnzlWDFuyPRFQUhBV2H7WvA0zTXTDJ6yOhzgM7+bSvRUBf6v9pLhLBs3eZ7x7T7e71/+5aZIQu3cTAbnMqRBwBPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053149; c=relaxed/simple;
	bh=rCPBs6VpzFnSeGV1IQONO9sqLS2eG7RrmNxYtsUNeyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KSyo+PCIfzo14duqzadhkiIjfAYbPUylSenjJndw4cZCsWxBAeZWUpJbWHKvDwmN7I5LwoClUNZBUfjJB8RbAE5dzGGwWSeUA9LFhXpgj72fdJLZiPB6wdDq0C3cUW8ue1XX3OjpVUl6vsLdo4eZIIH1DGyw7wJwPmaa+aeVtaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUZSdK+P; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUZSdK+P"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso158504045ad.1
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780053146; x=1780657946; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=junrNZ+TOSSnGGCt6IWg1rMtIZuzEOzNu3RMYtfyWkA=;
        b=sUZSdK+PpnI3UoXxQV32x3101mn40agNWykIHXSF9KgIGZhZJI8Ay0A6gGSg15o5zb
         9i8f0FaHRcCpTPN4KDh9qqv1WWv9f3NK5WjAoYC7hGwREzxA7HlytSqp2w73uh8Q2Y6W
         R7VnoFSMnzo01P5Pf6cLTHaJUbjTSoTHiU1zVcXz2W70LZXg43LF+Dwg3MgthH9gjyPq
         XUfYna0PrHOKqs6Mr3EfqEhw6KbpqdyySgtPsQB1cToaw2koqf3xUr48aJfGghV2iNy6
         +nYRuf0xMizuAQnnGiWPRd69zV17JA6HZyOOPkvJDQ+PvbmbJV4mNtpofJAtQL8zRjGH
         bt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053146; x=1780657946;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=junrNZ+TOSSnGGCt6IWg1rMtIZuzEOzNu3RMYtfyWkA=;
        b=W1wGwIcnvHdIQDrgiF5HE3gHhS1doemQcmlrCVunc1V2J8NyLbGBdRNtpEcPDLCdFz
         GH7i77TTeu6pMDP0faP5HYEm7dI1QBpdUoUaCyGD9ubka294QLVGONaLazMxhLd8aAHE
         AtK3+eejFF0+DP8BkqKZzjI0p2DMmWZfjL9KFNG9b7B6S/LK5oRweQxIM+I1lmheYQ0W
         urJSfD+ikW9Ux4MyabQvEiSIzUfotGHvp2qQ3XkALOEK6Jsp3eq8ApZDa/ARXs94dYfl
         +hSLnRILcTd8mIBx0dBwVoi5RMCM0yFxLbJlMSBT6u49iIrMub3+muts/NXFVn1CjaeL
         aUWQ==
X-Gm-Message-State: AOJu0YzhhFx2aE80lh6POM9zYmSEygtTCDU+Tr4AioO9B3zJptmvGm3v
	I6PPIxSOSzsACsKdk9WxE15chlIRbf3nnvpe0LJG12MoByi8a+ZNjkRAqu9TfIkftEM/pSqEU1F
	MV7FqH8bKcJ8ZrzfPGp8KgqodqspqZ+tv1MCY3X62zGPQ3gGykazxF65yrlh3zTOku82HKOgqrf
	7wWb4YNWQIWJtbJ6aa1RYBnGL63AnsoQ==
X-Received: from plav20.prod.google.com ([2002:a17:902:f0d4:b0:2bf:1a98:5111])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f551:b0:2be:3850:297e
 with SMTP id d9443c01a7336-2bf2098933bmr34166025ad.31.1780053145610; Fri, 29
 May 2026 04:12:25 -0700 (PDT)
Date: Fri, 29 May 2026 11:12:08 +0000
In-Reply-To: <20260529111208.387412-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529111208.387412-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529111208.387412-7-praan@google.com>
Subject: [PATCH v6 6/6] iommu/amd: Fail probe on ATS configuration failure
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

