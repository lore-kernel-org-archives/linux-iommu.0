Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818543101C0
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196053; cv=none; b=lNFHk77plJakcMEk3PfMLAbarqiOinoeBX2xvm0V8R9dgUvGYCRvSpfOgmMYawHVRnNgmTQcCuhFROW4EhQ5opZk/e7AuBmNsDMRO4reAmpOy/uoz6q45RdzF8enS8oC6ymTZ5fve/vW6N/wPDTwD5BmDobGwcpWRHWnabDzXcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196053; c=relaxed/simple;
	bh=2GvhSUF6ifmY/btUi9DK+eHy/Z0GbfeQeJmNGhSqZf4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fb172lw16vp0+eT1frWSaKdPytz0plihZSsIJ10goe52YIdLo8bkak3JzD7bPx1qB4eV1vuM2YnperzQMRHCHCRPWl6LcjsqnXET06hbI/svhYjmt0vIa0hyTK2ma+AOJkU1bYKiGIyl9cekPhdu0DX6wfHSZ4kIZU++THwfLCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yv6d5DsF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yv6d5DsF"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d99c2908cso5833557a91.0
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 12:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776196052; x=1776800852; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOjnulm/v0lmkNXvVLBQxZFN7QSX77ICQOZluyjIOiA=;
        b=Yv6d5DsFlX886+k7qR8AmI00jRCF6TwLJwVuR7bRX+VKtqlzJdVcrcahMSApLOoe2m
         Sebe65+KI28O7SQagbUF1cTuNoe++vsvrJImWMtpGDDn9DZp5FYHHc2Lvc54TZeilKBh
         Cbm5imQVgtCQ+IUFu7bckEKjfHxR1Shdjo5UiBugTOPZ9g2+/+vTJ3ki4xLQASPq1RB6
         2dFMqIilKXvA9OESZH/uAUOSz2qhl7z2QQaF0+E29bka6Qx6yv3Y0rCiuYn94YFohvEb
         oCiR+Ass1GIOOaUGaiR2cbNMkTWWlOhHIUJ+YQxxn3kvOoxnBlFZdljshbySiv9cFvrQ
         H+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196052; x=1776800852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOjnulm/v0lmkNXvVLBQxZFN7QSX77ICQOZluyjIOiA=;
        b=lgwvnVwccn+pdwlksOPODq2NcT9fB0sQQUA5Qtp4mH/erfMBBPCIWix+mwwGWsFeen
         qw4C7HkCx1wudkySSBLBCHQrOC56ENnG1vXUFym70i+XIt/jjZskYlSlItVKa16LsZrC
         iWzvB3WLb8uRyMbFhDCjf2IdpaVR0Ol+hTb/rn3G8FOitkip4XlrlT4OFUBkRbCzeDN5
         uvnClmQkboe3/qACf/XGI/BJzUDMrWNOWMBmP1I6kQpazS9z1WOd6VpZxq/LFWH6ahro
         B41YEbI2Lpp0bWNgLrBHh/Ate+X2fC8KzFJhpKmS1wSh77g9x2dfogctGAv+36eM4oCj
         /dOA==
X-Gm-Message-State: AOJu0YzzpnQm6lKUes2zQMNrW23x5iPykFajVfn+DLLb0NE4kNga1BBG
	Sy5cGlHP8pjJPDV5RlLGp7GSeZQVEEUE4piiGlvVteN9GftmLdE0oYQCGb/gzGJwpCO5+uvbeYz
	RvDMatvjI8nvk5J3kzFDlkO6OLt6eukm6TUpytOPtAyDMahem6vCHTfJjs3tMAxRJ12ncH0fwGH
	W3yyr+r1XhVXOwNKwy3tVJ7r6Gq2njpw==
X-Received: from pjbpv1.prod.google.com ([2002:a17:90b:3c81:b0:35c:2342:a073])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:1009:b0:35e:b017:da6a
 with SMTP id 98e67ed59e1d1-35eb017e4bbmr7197699a91.0.1776196051512; Tue, 14
 Apr 2026 12:47:31 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:47:01 +0000
In-Reply-To: <20260414194702.1229094-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414194702.1229094-10-praan@google.com>
Subject: [PATCH v6 09/10] iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable PM runtime for SMMUs having a power-domain during smmu probe.
Add a devlink between the clients and SMMU device. The absence of a
power domain effectively disables runtime power management.

Reviewed-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 28d7e82e4692..be091739af49 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4375,6 +4375,9 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		pci_prepare_ats(to_pci_dev(dev), stu);
 	}
 
+	device_link_add(dev, smmu->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+
 	return &smmu->iommu;
 
 err_free_master:
@@ -5709,11 +5712,18 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
@@ -5725,6 +5735,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 err_free_sysfs:
 	iommu_device_sysfs_remove(&smmu->iommu);
+err_rpm_disable:
+	pm_runtime_disable(dev);
 err_disable:
 	arm_smmu_device_disable(smmu);
 err_free_iopf:
-- 
2.54.0.rc0.605.g598a273b03-goog

