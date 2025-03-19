Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DCA374EA
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742345007; cv=none; b=EoSk1Fkak3OTXgXpPNcp+Cl3F5mPIdZDtNU6RZEIBgv2HZzzjuYxCY8tpb7meLnxkyV4Gzy7d5RhKvN9PPP1CKOPU10E/jl0hnzXL/uz4Hnr/DAPtTxDc8Hy1IC77httLpc33qJwUK8VGpW/MMle2MIyUzTe0eO8/kBUvaZ+F5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742345007; c=relaxed/simple;
	bh=v0bUyKaQ5bIUViU0S8F3NT9AGJ0W92fGWwC5UhrJ6gI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WtciQhUDea/Z+azBaNlFnnZC4rSjvqesp2dEKFKCkBK4+cB4Po+t81UKx1zoJdxqWIfX/6ObCm+nwJ7BuhUgS9PzmAVq0Brzq9+4zZzr+sqfQ/x0fBMicuLiFpMeneP7nAGxVOE3Dbj9B4kWbreXVVNeV9ulYGxS0Co2vvqGAO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRy3c88q; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRy3c88q"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff64898e2aso326158a91.1
        for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 17:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742345005; x=1742949805; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zqF8i4zHBLlbilwjPKubp9moFMBUakKlglNO99byI9E=;
        b=GRy3c88qDfCJY8TlS21d9Q9s7mGBDpeYuY3ViGLwbAmM2VNDTvoqvHMi17fr5BC2Xc
         SynFrBrTaY+R+/6yLCzy21t126/y8AdzVX1KjWUGSCJDD+cI+uqfjiTnk6w5svY4oJVj
         ZonWnLmykURfGi0urPlzJNP/b6e46BJZkOhgaA6kRTO/m1hYiEsLIKZ/bYWcxlNZz9uB
         nYJ23r+GIInAXiBqwYKdOArtQ0+V83xl+hkyMyBidcq43uIEr2O3roOShXbvvvhFbHli
         y1rd3oul7GAeQLidU59LJzjG8EEo6BrQNB1+ZZJTe8JVN7WM7FXjcg5rtV/KyyfLOtjj
         /w0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742345005; x=1742949805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqF8i4zHBLlbilwjPKubp9moFMBUakKlglNO99byI9E=;
        b=RaYjNhMkMcOnpQpzOzTWCohahbGlUCPBaELiB/tu5DM6vXgmWtNR8B8z5wrnwUhWpk
         xAldIC52qOBsAiNaJEa4ZCjk6jcX9q6xmpJHhXfnTp9S/qjMtwl+fLOBeIPkAhpDkVTC
         e90F2ooXo7Xa4HbRHu3LN84eVUQboR3zqdybUcIs9H7xAPxUm+CqPZKIGgM/cE06ADJN
         Ou3tKhPFIp3NiGTfPB64FjyVek2DwMq14FxTDMY99JCGPD6a/eUUA7T4kmWOiIa0fM9Y
         eD917qZddD3M9y+n0ixCQOeMGs2eaFmEwsW00g78J6BM48oy9sp3V2qwzdxrt5pxEdh5
         ytvw==
X-Forwarded-Encrypted: i=1; AJvYcCXejkZokioEv/s1s+T/a2Z1utoKex5NM6m50fmGRAqG5ua7aHf1AWokHv+zd4UyYupgSgE8vQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzP5Lm78JozMMiiokRZOIgvE1Jhn9pq89F1puV+zJs1nUjPvU7i
	4wKORX7cOSNa/XT/DE1uNwUFEM8AQatzDNnsvbOmfEQlJScpQiyMd9+udUmqivPW5fYUrxKXIw=
	=
X-Google-Smtp-Source: AGHT+IEbPTHdsiG4Aqef65SKGSl4DCXCvaD0m35/diuccvjMVxxneEJ9UHQP65WLmAKBCP5B3A2Z92hUKg==
X-Received: from pjj14.prod.google.com ([2002:a17:90b:554e:b0:2f5:63a:4513])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b41:b0:2fa:6793:e860
 with SMTP id 98e67ed59e1d1-301a548a805mr5895037a91.0.1742345005174; Tue, 18
 Mar 2025 17:43:25 -0700 (PDT)
Date: Wed, 19 Mar 2025 00:42:53 +0000
In-Reply-To: <20250319004254.2547950-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250319004254.2547950-1-praan@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319004254.2547950-5-praan@google.com>
Subject: [RFC PATCH 4/5] iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable PM runtime for SMMUs having a power-domain during smmu probe.
Add a devlink between the clients and SMMU device. The absence of a
power domain effectively disables runtime power management.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index caf750470772..602784e84e84 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3515,6 +3515,9 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		pci_prepare_ats(to_pci_dev(dev), stu);
 	}
 
+	device_link_add(dev, smmu->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+
 	return &smmu->iommu;
 
 err_free_master:
@@ -4836,11 +4839,18 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
@@ -4852,6 +4862,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 err_free_sysfs:
 	iommu_device_sysfs_remove(&smmu->iommu);
+err_rpm_disable:
+	pm_runtime_disable(dev);
 err_disable:
 	arm_smmu_device_disable(smmu);
 err_free_iopf:
-- 
2.49.0.rc1.451.g8f38331e32-goog

