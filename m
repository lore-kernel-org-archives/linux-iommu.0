Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62CE2BF01B
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 20:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105975; cv=none; b=IMtOAhCnWeVUOAHffE1fIzSROrdWfvCaIuzuPrabyI7p3vU7zBSetp/UVZViGPAFDk39uYtbT3ar3L4jSZCiVLbXkdP8FPEaLFmrgUZ7PE65TQMW32gPnE7f6Y9WVRJVzM+ejyF1gD8QfOQHTmxt4LUtuAnZZI6qIeDG31tbwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105975; c=relaxed/simple;
	bh=9pSzx/+NybDcULfNmyPfAHsUhJkqZN7l0csz6umYppM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jbz3wgd/e25GDnZWyc6hwkjeM5tsCq+LJNkfAnfs0q3+i5KoKuHCKCDaCPgzbL5dWBg9NMSx0Y4HmaVHnlZOY8WC30f2lDhlB/wLXdc6p8W9c8ixDmvY8K5dbdHv69iRDKpzOKJRYd1065P+8TLL4T0CTwHtLQGJICifP13Qb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nn+6/Sj2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nn+6/Sj2"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74858256d38so3497209b3a.2
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750105972; x=1750710772; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G5MNwJPU+70d569VUN6lPQHEtJYu+It6ZbCngR/3Uxg=;
        b=Nn+6/Sj2gm7JI4mw44OmFN4OgsPKmJxoMNJdMN9GXhMQ+DCvTny7ABw7MRFfQG/M/l
         6h9+LNhI64tKUvdi5uGGTT1GriMMC30RzreeanrAcTcO1BtWNSYVUzJZAczf8jCG/HqI
         C/xtiDPc9Ij8LoDlNAn1dQxzd8rbfxSwTKfVpA8WsPUdwuXhZTCf0RheOClCePiXjRcl
         9T2XfzTXeK44SgpFf7BTisEh3bte+uZ6F7YSYuYi5M86dW94erjMyQxVAxyVDT4GM73T
         IczfdBIjiKwvjH/uuiJmVQXlJxkcrbZJEOagn8Rr0XRgxE57xnryMS4K7FkgGqdDvmai
         pmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750105972; x=1750710772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5MNwJPU+70d569VUN6lPQHEtJYu+It6ZbCngR/3Uxg=;
        b=NJ4ii6JL/uiudE6RV78O+zKiUKGQyi7VBsti2lyIB0/ILPQtJsNj75WBEqRO1vqIOb
         U9JpsnImVCpLWlNtx+kj2qffQsucQ92zurMz9tbpePzDJ/SbPAT9+sIRxzThokYVfdV4
         f/218mCMFYLcmVNJEJKDHdanWDRMfis92lht1OvgZWfml6vwr6r3KI2ZAPdrSSKfVH2j
         VNOsHeqAFWCyUETaN/wwMQVy/SAAtLcsudvE0JVOGLpnE4vpWpk3PR1H99UpTsuxlYVQ
         1qIFxrj6Z7FbRVN9o+qrMB92TlFkrnFRB9whJKniMOcOGC0yU5e6d6iD8wJksY9g3qvn
         L9mw==
X-Forwarded-Encrypted: i=1; AJvYcCU1zxZnglcwO8fSdQW0XjUe1eUYNGo6Sz57c4tLAuf05XQbkJDviO+DQqSC0F4fyIOipVwhdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YymhqETFUPfzKDRh4BXgjmakQTDrQBKhlBuYKdXFaEi1cCpUxNV
	fOJRy1r2IRwpjVj/M19h9//JZ62EcGKOfHiFmyncEidhSR2SbfJjjl3hgE/A2rKvGEagUQ59poc
	GvA==
X-Google-Smtp-Source: AGHT+IE51a9kzmtfXKJjHugD4glFwvZU1Mvr9ULzrY4Hn8cKt827E1yrcVlbxYhqFYG2GxflKEhNaz2rsQ==
X-Received: from pfblt13.prod.google.com ([2002:a05:6a00:744d:b0:746:2747:e782])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2ea6:b0:747:ee09:1fdf
 with SMTP id d2e1a72fcca58-7489cf6aaf9mr14244723b3a.4.1750105972101; Mon, 16
 Jun 2025 13:32:52 -0700 (PDT)
Date: Mon, 16 Jun 2025 20:31:48 +0000
In-Reply-To: <20250616203149.2649118-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250616203149.2649118-1-praan@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250616203149.2649118-8-praan@google.com>
Subject: [RFC PATCH v3 7/8] iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable PM runtime for SMMUs having a power-domain during smmu probe.
Add a devlink between the clients and SMMU device. The absence of a
power domain effectively disables runtime power management.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5736f08e3af7..80928e5a2d60 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3568,6 +3568,9 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		pci_prepare_ats(to_pci_dev(dev), stu);
 	}
 
+	device_link_add(dev, smmu->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+
 	return &smmu->iommu;
 
 err_free_master:
@@ -4927,11 +4930,18 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_disable;
 
+	if (dev->pm_domain) {
+		pm_runtime_set_active(dev);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_set_autosuspend_delay(dev, RPM_AUTOSUSPEND_DELAY_MS);
+		pm_runtime_enable(dev);
+	}
+
 	/* And we're up. Go go go! */
 	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
 				     "smmu3.%pa", &ioaddr);
 	if (ret)
-		goto err_disable;
+		goto err_rpm_disable;
 
 	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (ret) {
@@ -4943,6 +4953,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 err_free_sysfs:
 	iommu_device_sysfs_remove(&smmu->iommu);
+err_rpm_disable:
+	pm_runtime_disable(dev);
 err_disable:
 	arm_smmu_device_disable(smmu);
 err_free_iopf:
-- 
2.50.0.rc2.692.g299adb8693-goog

