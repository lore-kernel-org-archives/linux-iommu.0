Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EE0594800
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887868; cv=none; b=KjMw3PDJVYvklvW6zp2jyW3XFfenttVjphOAdxOJ6+EMQGPKKhKBicZUOfgD6bT+16KwSPZglVSqtOmtKCZJ8horj/seYwOwA/6HposRy8+OPWjlzaw7lFfl6/1gTqwW3T7yRtZeTUkPOyGBahCssbT4B6AHCfB6zj045Tj8pWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887868; c=relaxed/simple;
	bh=MUTMnGxgN7ZsIPTSmw72qQHVmNiRZojafGZilM+xRmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rZzkLQAk8hRGNGLlKt+izAAH1dIHrqfVmwuhpJbf07yzygLjCglPxuLkHGbjEu233d6y/xjie9jN9PnZsy6A6inHlSY1NccAZgZDVMNWmZofFGXPlS+5IZBJs/WqUjF9l2o1hWWqaFMcL6/wDBXn25Ntv6vTZQsmPcerTh27W9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DB4KfyQT; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DB4KfyQT"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84865f326efso754213b3a.0
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 10:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788887865; x=1789492665; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rNJP63wk2Rkn83yG1Ei0kp9ZP/m4h3IOpChfqBS5N08=;
        b=DB4KfyQT807mHefJWntCXq6hfJUSFKIhHFpe9pDjIVFt5PhDshk4X6JJVXevRW5DZ9
         JT//EQf840l2iUeJiYW/cbDwq0MmLdz+NQbx+nTuixsS9ZD5irvQyXt9LAj29Rg2lOOp
         g137VQTuzVyRtZToqa1rAdQtssCOecGEfyr6B5OTxutVUPYaHlP1pQjUahLPb/ThdKhF
         /fAuG1VEPLfCj1jpGVg/MJ/Inj/9kIKt+MpD1fWJXW0oHjiFqsKhlyIaQUlOU+y8nA9J
         80rQUrvXVv6xNE6JcDd6GLEoVF9urHS+V0RkbL2Y0bom/QK+g/2CytVazJPrTpGjAQQA
         Tx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887865; x=1789492665;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rNJP63wk2Rkn83yG1Ei0kp9ZP/m4h3IOpChfqBS5N08=;
        b=IM1BGxP/xvkRjBhsWbj5Z2sZSb+scZ19CP8guGm/8hdsrAYV2Xx4/NWF/OHJsMlrfK
         RuLY/cu0wfi8eZHhBfh+iuwIp+M0KYOKYemAfMvjPUzQR9fKKQTpB4IbXwU251nJY9x/
         HbmyjuOQ0KfOEgNCbH45RfOUyX5Cw4cWhJfkF0Cz7ywa9kalGov/mX9LY8wzmeKuXNO1
         Q+3VXb3GpCk35Zrm3u0EZ/ovoetuTQajwTP1PtkwKBBKCZBOKocY6w71/EhFjXF77qzU
         WXIVHKMxgvYhN50dMZry/yw/lUbEK67fq+oM7k5+OmP5HXExByctkDBcUDRUju+T6wT4
         VDNA==
X-Gm-Message-State: AFuF++kRT+6TQQYhgezgFgzCtrznd2ZhbCCPNtGSpx77Bd+6j/im2W3k
	fkGw6ODakXwrjdGjvWnjOdaJsIv/V1YA1/FjKRU4GQtgf4A8EGd88OWcevwZ7WatvQ7Kok1PTW7
	kjzEyqK1SUgOzOWjDKswPRW4OeHdAubnVGDtyxDdG71lvNKQCnmzTALNfKlMXAANWnYubbJt7//
	DzL4448OrrAWrFUV6lf8pxN3Yw7/ynlw==
X-Received: from pfbfn11.prod.google.com ([2002:a05:6a00:2fcb:b0:847:7d90:188e])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c15:b0:848:46a0:3d74
 with SMTP id d2e1a72fcca58-86169b6b588mr39091403b3a.9.1788887864762; Tue, 08
 Sep 2026 10:17:44 -0700 (PDT)
Date: Tue,  8 Sep 2026 17:17:09 +0000
In-Reply-To: <20260908171712.356645-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260908171712.356645-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908171712.356645-14-praan@google.com>
Subject: [PATCH v10 13/15] iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, driver-core@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable PM runtime for SMMUs having a power-domain during smmu probe.
Add a devlink between the clients and SMMU device. The absence of a
power domain effectively disables runtime power management.

Additionally, handle runtime PM teardown in arm_smmu_disable_action()
and skip MMIO accesses during teardown and shutdown if the SMMU is
already runtime suspended, as translation is already disabled and the
hardware is in a low-power state.

Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 49 +++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1c5d891564e4..0a83d495d8d2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4511,8 +4511,28 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	if (ret)
 		goto err_disable_pasid;
 
+	/*
+	 * If linking fails on an RPM-enabled SMMU, abort probe to prevent
+	 * DMA transactions while the SMMU is autosuspended. Otherwise, warn
+	 * and continue since the SMMU is always powered.
+	 */
+	if (!device_link_add(dev, smmu->dev,
+			     DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER)) {
+		if (pm_runtime_enabled(smmu->dev)) {
+			dev_err(smmu->dev, "failed to add devlink to %s\n",
+				dev_name(dev));
+			ret = -ENOMEM;
+			goto err_free_cd_tables;
+		}
+
+		dev_warn(smmu->dev, "failed to add devlink to %s\n", dev_name(dev));
+	}
+
 	return &smmu->iommu;
 
+err_free_cd_tables:
+	if (arm_smmu_cdtab_allocated(&master->cd_table))
+		arm_smmu_free_cd_tables(master);
 err_disable_pasid:
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
@@ -5116,9 +5136,17 @@ static void arm_smmu_disable_action(void *data)
 {
 	struct arm_smmu_device *smmu = data;
 
-	if (smmu->impl_ops && smmu->impl_ops->device_disable)
-		smmu->impl_ops->device_disable(smmu);
-	arm_smmu_device_disable(smmu);
+	/* If the SMMU is already suspended, nothing to do */
+	if (!pm_runtime_suspended(smmu->dev)) {
+		if (smmu->impl_ops && smmu->impl_ops->device_disable)
+			smmu->impl_ops->device_disable(smmu);
+		arm_smmu_device_disable(smmu);
+	}
+
+	if (pm_runtime_enabled(smmu->dev)) {
+		pm_runtime_dont_use_autosuspend(smmu->dev);
+		pm_runtime_disable(smmu->dev);
+	}
 }
 
 static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
@@ -5931,6 +5959,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * Safe to enable RPM here as client devices cannot be probed
+	 * before this probe function successfully returns.
+	 */
+	if (dev->pm_domain) {
+		pm_runtime_set_active(dev);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_set_autosuspend_delay(dev, RPM_AUTOSUSPEND_DELAY_MS);
+		pm_runtime_enable(dev);
+	}
+
 	return 0;
 }
 
@@ -5946,6 +5985,10 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
+	/* If the SMMU is already suspended, nothing to do */
+	if (pm_runtime_suspended(&pdev->dev))
+		return;
+
 	arm_smmu_device_disable(smmu);
 }
 
-- 
2.55.0.979.g7e5102b832-goog

