Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B5443C04
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653557; cv=none; b=E6Hz8nhk2SVBghdcQ9NEETA+L6peoNNMjoIRnkkZVGbGeC4fxw67oPgyI7/KRSAfzcNIeH5bzo6HiLbhyNSBSkD7YgdGYXcal6aFXrtGooOC0cAjUuH96U64WL4Jgq1jOJdbxly53zLKhxf1YPV54jU1SbHMntETtz/tFhMmyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653557; c=relaxed/simple;
	bh=xKzOlxV1mbMqlPwZGhd+MrehSrrNxk9EFSUjk86veO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JykNZzoSPJI0HrogwKeX5GplnL9oSoP1UOwz+WKZlODfFdMpZmEgsLEzPB83PcqKhERwGGRxOW1KTaTcbf+reQVQhrRV8BgWOf1gEzdvzJAMxGebDFuMNFbiQkSmih3gjHP8zK9WoF0OmjuZs8tw3k5khGQh6bhDVh9VSCw5GV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qgqd859V; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qgqd859V"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e2c785aa62so4708955ad.3
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 20:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653555; x=1791258355; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIxR9gKP4j1PYg6iofZ/XK63ShN3XaQLf38quAwtMeA=;
        b=qgqd859VQNfFwwrpKhaQ4FK+xwR39b8LbxR2smA70snPgt4+z1cnjEzL7iWOgnsdAL
         HrfgK3ClYhbfaZTH0Fm2uKMO3QRwj1iyaspDpFTir9f/XuovEFpkOJJBSGVnCxTtRggF
         tZtXFiK2qhEh0m1tgPqtj1j2A3uVgQg0M6WKXclD0vJEfPmxdUfo06bQcD6t24dOwPhw
         DPi5a5gmllN6pkr+AoGMCat1uoF9Bjn0xYsbDpD2E7W/wyJKhD0xUAw3Jml1+5Y8Zmpv
         Mb2OcssN+PWiJS4A+P6xrI9dCkySvsRZ2EkhV5kS0rQyCQueGDUJweyznG8vJyqn9BqC
         2ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653555; x=1791258355;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jIxR9gKP4j1PYg6iofZ/XK63ShN3XaQLf38quAwtMeA=;
        b=kppp8i/4ab2GXrABIDnL2eM3t7Sy8kijjHtjny9dYLDiTMf/e4yKgQJUud8aLWUgQo
         n8QAgYVlNnnxO30QhxIUPb1Ln+QdR0Kfbo0M3ypr4q1hqh56yebUoDx5ig5lJ8pKOYwn
         pSA0sC/mFAIujYjpVdCNJy3pAeflAHVxwKxyBhgAevYQQ3dyrVIvwZNIWd5ctLjhsieE
         KG44B28zSFNS4RwQF4ocxGsVLALE89c64MuS69xWLeGj1Bok9MoTVuPYVq/gQDhqXLQX
         EsiDGh8E4aj+f9gz4rmvQxXvsCYhM3MQz0sPM09DBQvUB/arrVYGs8QCVAFsY51QTegu
         Wc2Q==
X-Gm-Message-State: AFq9FYIQbLpQbkCQkzTkh2Z6fesGOp+pOB6VydAkU3VyyVUWgwtmI1Gs
	86iaxug9Gkf111qYkWGgXMeyw3PYrcgsgE7nT5ZsflC1IBjrwxAP5Te0X/vGq5rzUrlm0qT0rmO
	je1X/1bRx7uBTBFwok2O5MatsTS7BxP0Dr61P5TNuR99cBsID+w5cu0dSdqQ9O0M7cjZ88p1Fcb
	c2SezE7Z8cdRlOzWk9T24lj6VIOOO4nw==
X-Received: from pgce10.prod.google.com ([2002:a05:6a02:1ca:b0:cc7:9b89:2a8d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51c1:b0:39e:6c68:c77b
 with SMTP id 98e67ed59e1d1-3a098e078b8mr13128801a91.49.1790653554263; Mon, 28
 Sep 2026 20:45:54 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:45:08 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-15-praan@google.com>
Subject: [PATCH v11 14/16] iommu/arm-smmu-v3: Enable pm_runtime and setup devlinks
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
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
index e127e3be3a6b..2a1b5ce6ff1c 100644
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
@@ -5097,9 +5117,17 @@ static void arm_smmu_disable_action(void *data)
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
@@ -5912,6 +5940,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
 
@@ -5927,6 +5966,10 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
+	/* If the SMMU is already suspended, nothing to do */
+	if (pm_runtime_suspended(&pdev->dev))
+		return;
+
 	arm_smmu_device_disable(smmu);
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

