Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92853BED5C
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324616; cv=none; b=N/T9RDZWZndc1YL/GW+NmDU8XR6AIm/naTwTv9nZfDR3Y8qzorsnebaH+56BJ/kS0kNHrV6yMQ+/5Ll5Vu6dBCKoyAi3NU8q1HX68lmxF/3iAMiz8i2tEsnJCIIq8pPEjookOdSfqROeGd/Gvzgni+Wn7CKACcCY/0IiRnoWLEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324616; c=relaxed/simple;
	bh=j7uWcfmh8/AWow0GpSjwBM2W8CoLXjCsLXTc1fs8K4M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c8zdMIQ7i2I4fB99HfKzqpkpFb0WT1652cNzabJBvh290qdp4EH4UumhCGtAJDgjf/Bd00dbGPg3H9NFxjblpkJCNKtxlmFWL2hI51IR44t2ChrlQVnIZszhUidjd+6vItODRsu8v4Wq6Hgx0gfo+W54aQID1vq3WQsU0UTDAV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdf4SOy7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdf4SOy7"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b7f696b40so3801885a91.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780324615; x=1780929415; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S3NEMqkb9FMkJODx4KCoMPC9Bib26rrCy6qGt3/6ySA=;
        b=fdf4SOy7ffs3jOWoDuLePwb//yZyCXFKidNRcPUeDwpVBmDybfkFIBNl09XtVtJldy
         LqY0FPYEy5BJkzu64ln7XArvaR49jUjOro2loIC8UXgcxTlCLXcpX2ohe0buFcjtg2dk
         rjZfeTASDlDqmNiIm0KKu1BM8RmwdpcmAH75Br+0ms71gpG268vSKiU3+nY7Iyy7pBJc
         bVrOLlwBiRsFgd3RZq4wVTTrOJvNnz+8noJTobGloqNgPOuaJMCVnx1TAG+9R+t0DME+
         LbJD0UlBP9lCN+8cHv9r2aZPvsPQEwGq4mL7N/W3WqynuIlrkiLcRXFB1CxgevoJpW2L
         16+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324615; x=1780929415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3NEMqkb9FMkJODx4KCoMPC9Bib26rrCy6qGt3/6ySA=;
        b=EHE8+0Jd59g9cFauc/IciVLpRy+8wAvRXpnkuPuvQFrVj4F2D4xlZ5QSzXSoxxBB/O
         4UK22QW8eEk8O1QGbHxDDxz83M08owg5tEY6Q176tdrCTmZo+MpN3o7UklUypfxY1Umx
         v4xhNs/8lzTW5oCnpqBtfUeHunPKbby1Tfupr/B6O4juJmVGBqGFdRzdzpKwlzO/8nWt
         NNjaWIP2p4AJ9amWNSqTOcpS936VItWmuMNtYOnuDZGbrB0poPIETgmCqPZgCFg7mKAw
         o5kRwCq04+rIZwYc97FlZ3Wq1qqpC/1nSmMnHzYkpQd8OEECHJ3idLMLF6UL9lhnIxGV
         oMeQ==
X-Gm-Message-State: AOJu0Yw7W4f4Z4/Al8mZcK0YlWS1oTeEEJbJ/nHJOA24gGwxVv/k69L8
	ZDJV5CYWTpEJ058x7D7gjW+joOlx0/hWMf2F55S8CD6zw7zHMlPnkecuth24HNXMZ/fHsPtG6Ur
	NlGdYAdNm4NH5WOK+8dkQnfJ+zT0xEcnaeUkZwgMvn1l5U/y9kv6jxrVemOCKXOcUArlCX0Pjfm
	1My1Q2c4OXh96tahySBa+e4ge1/gKdlQ==
X-Received: from pjpo14.prod.google.com ([2002:a17:90a:9f8e:b0:36b:28fe:916f])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:590d:b0:36b:b3f4:d574
 with SMTP id 98e67ed59e1d1-36c68482266mr10917424a91.25.1780324614861; Mon, 01
 Jun 2026 07:36:54 -0700 (PDT)
Date: Mon,  1 Jun 2026 14:36:43 +0000
In-Reply-To: <20260601143644.2358771-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601143644.2358771-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601143644.2358771-5-praan@google.com>
Subject: [PATCH v7 4/5] iommu/arm-smmu-v3: Standardize ATS enablement failure reporting
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update arm_smmu_enable_ats() to wrap the pci_enable_ats() call in
WARN_ON(). Since probe-time checks now preclude configuration errors
any failure during hardware enablement is considered a kernel bug.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 54c7f1ae3a84..dfb2b0d2d2a5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2956,7 +2956,12 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
 	 */
 	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
-	if (pci_enable_ats(pdev, stu))
+
+	 /*
+	  * Since pci_prepare_ats() has already verified the HW capability
+	  * and programmed the STE, pci_enable_ats() should not fail here.
+	  */
+	if (WARN_ON(pci_enable_ats(pdev, stu)))
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

