Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EC83822A3
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734642; cv=none; b=bRJpsrPvl/P8mFTwEw+Hf1bLc9C91mbEqVTyaSHdcau0q3FqN4ozg2D4KygrzkAUumJlj/nogHRsT89mEsYJBbK+lJsLDbgV/TrM9NIvZJOegGYRaC6NaU8w2Er+QSqcsmHWDOQYv/s83GcB0MFBIBoNLETx1rjrH32bSbLZ3Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734642; c=relaxed/simple;
	bh=TRq4A6KO1VvQ7IbUE+TwHmgzXSdtsRpTby/bdfBdlU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yfkf11TXdCk8j4s3HzpmFreW6EIFVo5jHh/VPHzfBqAvPWumFuUOYbgn8PokPpKBVhHT5Tr89vI6FZPwfswDUuMmYr5Nl6OlOJBbR3So8JgCtuu/xjqvSyNC96ve1+hU+ewcp9f3ZO6iTLXbx9Vy/nnTVwOdp/l0+arLja/juqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3ao3OAI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3ao3OAI"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa6c3a77cso5659329b3a.3
        for <iommu@lists.linux.dev>; Mon, 25 May 2026 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779734640; x=1780339440; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrjCHBiuBsjUFngiV4EYGqc8MUFFnHs0ozhKw+gXIDU=;
        b=b3ao3OAIHn/GFlZOTV+4i11cN7YIYL+L8K7M0h8HUNs4sh/ac+u8Em/lzeYLLib/hz
         Q3Z01nMRk41AOKg5Jnc0M0cqbOROp8AFhl2+DTRzOlhaO/FCkzGfS3Z95CY5/q1jQx+2
         MsKJL2K8xphEF+xCOx1WRiMMt817gsU7DKnvOqKOvL5d+imZ9HJMDt6mZN2uKsPIXkrS
         b4sLBEBeQDhFL4hA3xLW3+A6NjXRxoeTPyidLaOSnQd3K+QXUZGlO/Q+5e+9vA5w3c+c
         D5RQ2J/LEQLkoIKdT9p0aM7Pc1L8gz9rONBHb0k5cliFg2oSFHStxotgh9CZ0zIyUhGV
         qJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734640; x=1780339440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrjCHBiuBsjUFngiV4EYGqc8MUFFnHs0ozhKw+gXIDU=;
        b=WeuTXp25POc2ipggUwUNQ3tj3frXjCgKKUtmyoQ0eYyyLfWjHFrPud+T+M/zdOO32A
         6CcPRzM4Yb3cw0RgkYO0pq5xKHz2KqU/WxqUJ0ZLPcknDFBGhZ3EGuapxMFNhip6RV6s
         VPOTqE1g6x/29U8a82n6ZMzKxRCZkMc6qEsBeWnLERTD3zSs7BeYe7m7V/c0KsbDBiPV
         Akb8sYpTXaWUJFZt57Hl30LzNwj/6ds/WMNbxKYfZL4Ru+tOeXXZ0uVbSiPIWdpx/6Ar
         PXNK0pDXdpRcRie/7icBDmkHLnumFoc+1g+o49YoA/c6CadxwYjzVeX0huuhOClYBzzJ
         hKdg==
X-Gm-Message-State: AOJu0YwZc0b5RihQK0dikqjz9C6nqyn5KCcykUSlpfuwNqKYYI8yQscS
	tcm7afuD6pNUQ332wkEmkwxpmSxxq1OTXI2+c7i+dPYFa4O3H/OZH3Z77bOKZhIkvIdbKfnMpfO
	+Yo5s8NNnv/hmTV+cvTV1CTTKRl+uwu8Zlq7oaLaYvYXfHd+d4q8xFx3uIplpu/rAFN5nFPuOYZ
	TFvhjHABcGtbmkiwt3dwmF5s+aMZ/QTw==
X-Received: from pfbb5.prod.google.com ([2002:a05:6a00:ac85:b0:835:3df8:d72])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:421a:b0:838:af72:fb44
 with SMTP id d2e1a72fcca58-8415f0f16ddmr15589020b3a.2.1779734640045; Mon, 25
 May 2026 11:44:00 -0700 (PDT)
Date: Mon, 25 May 2026 18:43:46 +0000
In-Reply-To: <20260525184347.4059549-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260525184347.4059549-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525184347.4059549-5-praan@google.com>
Subject: [PATCH v4 4/5] iommu/vt-d: Fail probe on ATS configuration failure
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

Update the Intel VT-d driver to handle ATS configuration and enablement
more strictly. Specifically, update the device probe to fail if
pci_prepare_ats() returns an error. This ensures that any ATS-capable
master reaching the attach phase is guaranteed to have a valid config.

Additionally, update iommu_enable_pci_ats() to WARN() if pci_enable_ats
fails. Since earlier checks in the probe phase preclude config-related
failures, any failure during hardware enablement is considered a kernel
bug.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d0e65bc131d..22308e4911e1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -873,8 +873,14 @@ static void iommu_enable_pci_ats(struct device_domain_info *info)
 	if (!pci_ats_page_aligned(pdev))
 		return;
 
-	if (!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
-		info->ats_enabled = 1;
+	/*
+	 * pci_enable_ats() should not fail here because earlier checks
+	 * have already verified support and configuration.
+	 */
+	if (WARN_ON(pci_enable_ats(pdev, VTD_PAGE_SHIFT)))
+		return;
+
+	info->ats_enabled = 1;
 }
 
 static void iommu_disable_pci_ats(struct device_domain_info *info)
@@ -3288,7 +3294,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	dev_iommu_priv_set(dev, info);
 	if (pdev && pci_ats_supported(pdev)) {
-		pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
+		ret = pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
+		if (ret)
+			goto free;
+
 		ret = device_rbtree_insert(iommu, info);
 		if (ret)
 			goto free;
-- 
2.54.0.746.g67dd491aae-goog

