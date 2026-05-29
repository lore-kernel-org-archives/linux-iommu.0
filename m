Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA73D3CF4
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053147; cv=none; b=sxoYz/Ykw4eaCN9dbsVO/LTtndIzuGu7PtKJKhSOmt8AukqHdd3flzTDhhfqwzcHgcH+rLstInIC1rkOLdImVF3xzBYUST0xX4ymG5GTH9Nze83SG5ybxLP5/Y6HNrhwCSGMJGjz/QKDnRhLErnzKvzfW+iXXozXpKgyHu8yyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053147; c=relaxed/simple;
	bh=7e7DAPIm+AHn3qv5bIN9iON9Yk8ymifmGfWJ9sb7sLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZdQjztMBGcHXZvnpg0AUCWIiePUgpVjPhEce/Y1sCJwMGqfCEYU2vzqG5noIjTzy8x0YlFlVN6g9cS6vDkneSXH+bYiL5fd6FRl4rFTA5Mg8on5zgWhncwbIbULIhDmhynRSe0DCLptGl+PmZLSH/fgo9V+N2KqNoht1+UzXO+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqlQrVqg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqlQrVqg"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83ef22f8e8bso9356784b3a.0
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 04:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780053144; x=1780657944; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNaUgI3CtCWyHWdRlJq0xZGnOnJtcDe+W2oSC+iqpLQ=;
        b=DqlQrVqg9sAP++eNJsCA0VCk6J9bE9BJ4Zxbo3R55I4kZILNvUQsnI+67eLNMKGmtP
         QUvqZdX/l6kgcvv1evaOvlNCDIsRoQ/KN6nCtRJ+IDZ12R14LqfeQ+O0hDcpUOe+mN6J
         YDsYQJ72DykYw4EMAnl42409CceE3vWzOkkUGVfIl4meIxJHHc3X3YNp0/T7Tn7Ilvg7
         i0dj6vx5ZUmVSd+Jbjv2cdRq5g3aBTuj0hCwdBcgVWsm5WS+oeEqWy0lf1ZwMNG6iq33
         cnwexK1o5mRFR2gEJcYcVS/lgzmLsUXQY2j8HT0JVHWiY+XOQySeM7u1ylYYr/CSz2yX
         wwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053144; x=1780657944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNaUgI3CtCWyHWdRlJq0xZGnOnJtcDe+W2oSC+iqpLQ=;
        b=kImD59f2HG2AGp4whNGqoj03DBZZzeHnvLRa1kBe1pPuhig47ksHxekAG3f4EbBnmX
         mOaDeZmDrIveCu+B6jjdA4nNrNkw20kq8uwohcWBCNQQihusvabUAH0er59vVbZLr1DU
         bp4x6GIK2BsGtSVRBcXhZE/b4baAV4HvSeeAC2zTprgzgO5bGJ16Dcy2dH61k0gnctYF
         DWTY6EZKSTQtOPCnCxz5SEC6zp3p1tANcX+KuH8yWbRsEZ5cd4QnqPR79NqZXitJon+z
         qcjAo0PlALoqXfa7W8vjghU9tKB8TzIQeYRzrUgmi2+zbjxq2y+Ngn1YkDhNcAO7xD5v
         3J3g==
X-Gm-Message-State: AOJu0Yw9rNqbRM12m3kmq1bawROTJX1Abf8vrbHg7l0hvMAFlzzXrhQR
	df1liHpvnlyGjOpJ9zzKYNXprCmfKyDxnTja/PLRvKnLe19F9zpbTcgtfae+qQa3XHEJQV070fV
	40lRp/VUuFT8vyOWD8/fNaABAh3G/5Dbp/Dd3DsTo5r/eaHEBVX/wQfVpd5Sll2upR4GMUkXBN7
	DEPNdpvw4lK8yICjPy4z13oTaAU3XzhA==
X-Received: from pfbll21.prod.google.com ([2002:a05:6a00:7295:b0:835:429c:76df])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:848:b0:82a:7471:eb90
 with SMTP id d2e1a72fcca58-84212ba36e5mr2711651b3a.30.1780053143552; Fri, 29
 May 2026 04:12:23 -0700 (PDT)
Date: Fri, 29 May 2026 11:12:07 +0000
In-Reply-To: <20260529111208.387412-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529111208.387412-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529111208.387412-6-praan@google.com>
Subject: [PATCH v6 5/6] iommu/vt-d: Fail probe on ATS configuration failure
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
2.54.0.823.g6e5bcc1fc9-goog

