Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8EC24DFF3
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745019327; cv=none; b=hCP0fHKekMWciMF2VTJ05VVaNrhFo56LIz1aT8550f9bC2jD3gVq+OH2mamgEqs3tOF0R/LacPkKEGkYAZmddMzTrBhm9IQi1oBD+u7ZT4yQPio+TBWuB6zm3lJ8vU7G2iMs6nJdTmbKkD7KN3Ib3EVodKXmBDd2nBSFp3kDoiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745019327; c=relaxed/simple;
	bh=UU+uv61qPKE0bnnNebBBoVVzZD012Aa/bDmY8DAJ98w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UDWQ3YCNMQmMcKdmuEYmv5OoI81HiIG3d8uX5UURu7qoJKqFircu8DFelX2eQLHMAUeFp8b/YVHqH49FUQ7yuSOeMn3tlbZ3FIH19tQO1genN1h5TJDrafemUG1Vp193sVdR7xqa16Pn5ar3K7F0UG+8GY+ZSSAli+gwjFj39AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5uJL+Cr; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5uJL+Cr"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af5a8c67707so1429666a12.1
        for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 16:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745019326; x=1745624126; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEUXJG3T6PBoIoT32sqn55uECvpEimhUm3CtKOYq2VQ=;
        b=p5uJL+CrVZY5CJtioxG7pLnkbJyNSPdoFKDNMgAD6YsKJtyPLtF9TcJ39bwNIdw4vT
         TogxSL5MDaT6m5io/o6camMYWbAMJ8A05aaCr/jYZHkFzUbFKpHAQxuTgkCXf/1YEgSY
         5bDj/5UzdbkKTqiU7SbHh1N5DuqvFXZMdlRR4JfQCHXV1H4TADAIUNwkUFHDv3ZtjShc
         7364JpsumYs3jKtPIVhPn3sNaRrgNX+z5QhtY9mpPVEwQgH/GfkwgLNtOJhG3o/5SdNw
         BNswu67MVlSU16HuRZX5MhSzv9YLD2LlScWkmB2SrL+2OGcwdk+hIKzRjU9VN7WSS/4o
         L2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745019326; x=1745624126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dEUXJG3T6PBoIoT32sqn55uECvpEimhUm3CtKOYq2VQ=;
        b=bZ6LU0W7DB5/JeyZ/8kYp+4Ls5k0Y/Be/OXHWj8kqxGirohrUbu0KqXn9DAiBuVQh/
         jlzTozUmPU6rXxpUYm9fhtVYMpfI//z0Ah8cc46dArqhfpvIHqq25R3ips46N7+dQQpa
         ucYmwbwnT02i/5/Vrm/qMO0rEH8PmkZRcFRDuiYTnyWf7cXjyR2z7ITS+ebzoONowmnL
         m1iWt7NvNX1+2brOWOap+hZklSn8ws568WduC0PADhd0zUWFOj9auV+1VWhHyidJyyWs
         F8DLrtWWVgtKY5uQVM9/FGN637LsGSsLkwJmq53lcI1oWmU/cbx8J6GmaN05TvhTlld7
         IFLA==
X-Forwarded-Encrypted: i=1; AJvYcCWza/9KSMKir4ckjnSdZSHGTpnah/m1RvfE+AWrYt5jAWFE0HD5fjym0dloL4UscKMjbprXRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBcVeyi6Z2wPVxiNSRvz81bkYUqpmIShMXncnJCKV3QIscb2uZ
	bhLRKYIFtahCXK0NtxB+xqPhQPZIQYODC/tlquxz4LWcEfVXQXK30FaL4asxp4Um5PR7B3nlUg=
	=
X-Google-Smtp-Source: AGHT+IHxqcKt71TccW382ES0vX3BhyXgX9oGKlJFC0XeqvrkvLr0XTxJ/2hhD9ejB0KON6txnhOKCLTl+Q==
X-Received: from pfbi24.prod.google.com ([2002:a05:6a00:af18:b0:737:30c9:fe46])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1909:b0:730:95a6:375f
 with SMTP id d2e1a72fcca58-73dc14111d1mr5835419b3a.3.1745019325823; Fri, 18
 Apr 2025 16:35:25 -0700 (PDT)
Date: Fri, 18 Apr 2025 23:34:08 +0000
In-Reply-To: <20250418233409.3926715-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250418233409.3926715-1-praan@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418233409.3926715-10-praan@google.com>
Subject: [RFC PATCH v2 09/10] iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
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
Reviewed-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7099c0cbf5fe..d78c6ab24eb2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3640,6 +3640,9 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		pci_prepare_ats(to_pci_dev(dev), stu);
 	}
 
+	device_link_add(dev, smmu->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+
 	return &smmu->iommu;
 
 err_free_master:
@@ -4999,11 +5002,18 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
@@ -5015,6 +5025,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 err_free_sysfs:
 	iommu_device_sysfs_remove(&smmu->iommu);
+err_rpm_disable:
+	pm_runtime_disable(dev);
 err_disable:
 	arm_smmu_device_disable(smmu);
 err_free_iopf:
-- 
2.49.0.805.g082f7c87e0-goog

