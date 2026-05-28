Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFF635E1AE
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999850; cv=none; b=kkxmBFWQx9THrZtTiicNsc7e0EoaziH5lnH/tDvqKG3ofJk2XzzW0+kjMp2At69m4890bqKgaymMjlEBnOhxUaNP4eexb9hCrb+FxAmCUDfFG5zDpyROhfk04MQLA/p58TiCsoIlLDHwGIghw9x2WVZ6iST8Gf46uLWcKMg4cDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999850; c=relaxed/simple;
	bh=ylHhsRCHAqSMh1pS6GMlC808waOAu3ILm6CtLVqC5hg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AhCtxQs0T7Yyqmf9dE+oKms7XJhnSUuOWIQbXcJ9ovAK5szcQ0Fdczl0NXvD34OQUEDjLcpNuI8HeDgxcfcyb2psHKMt9wIfAFfXmpx66Y7Z5Xz/fxOTS2qRmYpgUQgAI4ZQ2OSyBHK3JDJ8nhp/Bgpr34kRx0sb/fddrcbAJjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mneN4hf3; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mneN4hf3"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2babbeff9e4so146141945ad.0
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779999848; x=1780604648; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7UJLNVkpdPww3mteKfmSVmHt+OJdAAQ7hsDxELrWtY=;
        b=mneN4hf3kG56t/PH2W3AK9Hi2H8Znx0ug5rJt3vDLcvoaNzKl5zezhh+2JlAI4HlRO
         ZrF3+J1UeMREcTL0He+HN3lIjReZ+4OdrOuugW7TB+3NWh1WGIcrMHC900J0hLVKfTUk
         Cguy7HxBW3tmnuJAlFwAZaV7Cj3lv2X0uZ+KVzH8ihCuKvRY3tndx0zcKPM0SnW/uN/+
         zCQkCMN6bcPOZVpnxm4UIlc+t6wPdfU7X65IR/xaaO9zWvorePsAgAtkm7ZUDUiCqOTt
         YS3AU5MaQy+e96W+fzQWwEHy1Kjizzyo+0GvMrf0mOLtkkogiIc3rP/SxICYZajo5roW
         p/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999848; x=1780604648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7UJLNVkpdPww3mteKfmSVmHt+OJdAAQ7hsDxELrWtY=;
        b=ADCcCyEBhMGxdi8mKVkxeoSOYhQEo/5nFc1i2MCcoXavrdaT7DbiXPwM/Fc9f5GgfU
         2gOiFbuQ/N81tFc5N9xokEtorK/XZ2ptIlB9BZDMsaQYxAAuezshB4g/lLhJLf8sbt6h
         tMo5qe0RJY+g1DBMIAXMJK/e82XLngVsO3NKA09Qt+5g7Ro9TTKGDo8Jv2x/bMZsoMrb
         QWLo4B++nNlmb6o6FgdL5pjwGm0kjWCsclWqUyl8Af690jPgOc3SD9OOz0Vb73MZ7H+7
         /+p/HQfVn4+d4/Jz7xJLuoUXq3VDaXJLbfNI0mYe+HUl847Tljd9dolkCP1iE1jOLR5j
         /Dlw==
X-Gm-Message-State: AOJu0Yzc1kPqoUP6w05m4x0CSZ4/9Hr5f3HM+oBRdelU49thUC1B58se
	uP/rm0cfkOePBVRFo+95uY6nXKxUdqbW7Pysj1ItGrGFM9b1mDrctULJKDKqRcb5Zaerd2D9rD0
	oVzxzPMZ/03L4Cj9bM+enYo//YFi7pDjGEFYRL8Vmt/Ybt7stXB9fDh5ZG8mTiQqS667vrWUtsP
	qM9V4iCss+z9eVnC6pwUnfLWlAseyRMQ==
X-Received: from pllh12.prod.google.com ([2002:a17:902:748c:b0:2bf:8c:2de])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fa3:b0:2bc:8e7d:3dce
 with SMTP id d9443c01a7336-2bf1ffee251mr1653365ad.27.1779999847992; Thu, 28
 May 2026 13:24:07 -0700 (PDT)
Date: Thu, 28 May 2026 20:23:52 +0000
In-Reply-To: <20260528202353.3422206-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260528202353.3422206-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528202353.3422206-7-praan@google.com>
Subject: [PATCH v5 6/7] iommu/vt-d: Fail probe on ATS configuration failure
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
index ed6d3a0203f5..f13da16717fe 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -876,8 +876,14 @@ static void iommu_enable_pci_ats(struct device_domain_info *info)
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
@@ -3292,7 +3298,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
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
2.54.0.823.g6e5bcc1fc9-goog

