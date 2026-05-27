Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFE83C5853
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920075; cv=none; b=FyPynUUJ5aop7wyU9PB8P2Jd8l0cvfToJu72RRk6G7LCh1VEDaxUHUY07EQuiqT+dJr6R4qSOxYMQ65EkhgfGSXZP3y39hUgWClemCC5Qd2acFLwNExRksHaskAXFIXVzf8pN8T/N4R6J4YRtj9CoJudOa+3NZx8qwYuPAa+D48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920075; c=relaxed/simple;
	bh=M7y7h2D6/gq0pKk769II9z7GaJiWUTi9wjV41bIUdLc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CLFDt6kd/8HCktdSw8C8Nk5FB8NbX9DwJUMxNf+ke2sjGSD6iTqp3gXpf4m0cUei6SmNxTM4atYnW+z+Ucakh01+krDghQ3CaPWh+wY98t92TWYkwQ5apAN8VhxbyGeFsURMfR0jWF/x0DDB9ZM7cNk4JwElt42hpH2amP4D5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amSH7sWc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amSH7sWc"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso78442495ad.3
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 15:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920074; x=1780524874; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=daz08EfrJ4p/ZHyn7R6Z/1LWdy6ghXZSAUnbV6ql+LU=;
        b=amSH7sWcE88w2PkTjC9jAuH77tmb5QKUkR3x+XvL74t+2wjJYH4kcP00oTgYXX0Al2
         KqmWFAFDpt3Dl0s58Kd7rrNLOug1IERrhkNnGgtWvDv9AhNKwnd30npC65fLlwSPOgsF
         TWjScmPKbbspjM7QVcvYtnNJCUHZ10SQ2SD5JtPQWEoc6sE6wmpdM6vam0Ek0QhO2blg
         b9cdmNZJr+9gcunHeEQLbHYrmLICDtoGTwafyx1qw4CHsPbH7BATF8JEg04hXQBAjJ88
         rejpF9UJciBZiAIyfbYuA/Wsp8baOQcsHRrTywknZ2KYEGz8nkrLXTIhA8VRLyQdouNA
         wDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920074; x=1780524874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=daz08EfrJ4p/ZHyn7R6Z/1LWdy6ghXZSAUnbV6ql+LU=;
        b=pXAO9ek9cojB1s+LdHxY15y/clAA6B5UPz+0CExuBn0RnM16k+nQonLwBCIew0J5tD
         ydK2ryZSLXhT7UvDNb67d6g1zvZxQlnp5P441LYsqF1XXRL1Q4d+I8V9HhLcpqQiEVnb
         p5m4yWGcdfuS0nUcVKaRWw84UmvfE1VdEgk8EfvibqUNLbjoRnPmUX4x0s+kYvHVrb3V
         23NT1V0KolSwz7WNRGq1nbKmQBXB88Nc3tLady0sdugWD4ptNN8DK7uVGSDrEC3IfucC
         nEDQN9XgMVaZIIRAjudytCmrLiAlH/l1Mrj2vj+7/+aixWuZNH+ABG/P2bLjOgDRTsXg
         OKdQ==
X-Gm-Message-State: AOJu0YzUKwOjfGXSVLYVs5SdjmXSP55OiiVWlQwSP+5JdUm2whBzUd55
	QpwCZDNU8GjKZ8aRy8HO09EFBE746+gA+Rsl5W2rD08tR2YFbFPd3C6sHR+BZjjSjzseFaWGKLx
	njKK+8a90qt8Cy0z9RbLNzJVovaeoIIEHjrFGRN7pMRAzBaTy1NC4rTPKsJ/oWRqJagCrf8gVNg
	RFbwBo/dMNXsdEe0Kg6oiT9FDgDBuvng==
X-Received: from plpe3.prod.google.com ([2002:a17:903:3c23:b0:2bf:106:cced])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a2b:b0:2bd:ef12:14d6
 with SMTP id d9443c01a7336-2beb06cfc33mr275251325ad.34.1779920073336; Wed, 27
 May 2026 15:14:33 -0700 (PDT)
Date: Wed, 27 May 2026 22:14:05 +0000
In-Reply-To: <20260527221407.1756491-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260527221407.1756491-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527221407.1756491-10-praan@google.com>
Subject: [PATCH v7 09/11] iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>
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
index 6cbb1724b377..34e249656ab4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4240,6 +4240,9 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		pci_prepare_ats(to_pci_dev(dev), stu);
 	}
 
+	device_link_add(dev, smmu->dev,
+			DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
+
 	return &smmu->iommu;
 
 err_free_master:
@@ -5592,11 +5595,18 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
@@ -5608,6 +5618,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 err_free_sysfs:
 	iommu_device_sysfs_remove(&smmu->iommu);
+err_rpm_disable:
+	pm_runtime_disable(dev);
 err_disable:
 	arm_smmu_device_disable(smmu);
 err_free_iopf:
-- 
2.54.0.794.g4f17f83d09-goog

