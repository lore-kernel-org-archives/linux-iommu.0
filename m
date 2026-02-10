Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6290932C33E
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740295; cv=none; b=rIHXpufFjAYrqJXlWJWZmOAT5zyZ7fHi8GpHKwY5L6WEo6CiX3meLdZct0wVlxlaEs5LkwUQYcuiHMvaGNVrPO4OWs6pY0RopXAvzTd4FvAtnimwbXDYGv/Ldvgd9SZM8Z3drjUDE0t2wISmqKGLxV4I1S7b4pxSVAWpqnzaey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740295; c=relaxed/simple;
	bh=VRL/E7nK1fyZMX83uu6bt4FiGrPrpeuaTEztrOQsu9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VTd60vNaH0HrCkrvafnfoKfNmPYIq4lmNaiVDg1XbMlAgUX1ZIgaIUfbxfjdm6Ph3Yi4b8XDqXsH/06oMDYDBYsoaofEevs2z0q1NWd8UCci/UigVV38merUqIpVfFQ48oFooeunvzGHD0mxuPYQw0MsGPJEJ7V4BgAck6YxpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irhEEEoy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irhEEEoy"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4377174e1ebso1551842f8f.3
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 08:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770740292; x=1771345092; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3mzE9q9JZeLiz5qheXEKidJ4W/5JZW1PBYdqCp5RPU=;
        b=irhEEEoyLDCn/xWpEaAuHGfJXWQYHMB8JKuTSBeR6OX620PMS6gf/ialWYWzFTqd8S
         FxckSp0GlaRoAoHg+lbuGTbT81o3WPtUHWIlQjy6uNocwW5TfTHhcD7+4hA74sm1TIjf
         ciFGLTshrPHb1uE7R4wNf0xf8MYLCj718zF+Lq70oml10F3Qev6jqpDZjYcSCVG/Rfzk
         NaW5akdKtLAEgvsL5FUn2tEB1YpZIBkBQ9iOSZeF6MZCanTb4BglItWRgzJT6MfstRjD
         pj7sZYTuDmPjs3MLKH3TpNBNRTrBDBOi5jnMa+zew8l2Hpfo9izglxe3bVq3gmoZ/ZYW
         N9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770740292; x=1771345092;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3mzE9q9JZeLiz5qheXEKidJ4W/5JZW1PBYdqCp5RPU=;
        b=mAhd94XJKpNC0OSE8GKcNUPlsYwNJO7xyPeaRzYZuBdl9qpg4VLUdO4nD+8zZy4dIm
         7AdNKoO3C7uSLBjWn7RVjRbrtSQ/cXfjOWW6s5+qllFdrZRT3gLDytpUlb7GiQm67tox
         GEwt+YBNek0wRPOo6bMF8PNNFcXSKOsuviXj70AwY6tFBdLflBAUNyoj2OGrfrCB/b3z
         IPPzBBiduSWT7+eJC3QxaWPCIs8BiV+XVn3cqVT7eU1JzA++dS0joZ8auQJvX3WxKKGz
         eWrxZeuvUtAr3mo3cd1BA/clx1U10bx8iujBVlH0UzwfXaakBMAHYZeMTWthasfW/J9o
         tujw==
X-Gm-Message-State: AOJu0YzCqy9B/bCXhrA3j7h7FbwNFbWVZojWhYV7E/xB6AFhcGDcGnrM
	BzQ05vSzs/vq7RDHt53yifGuApHTdloe0eIKKaSutVDkYDUBb5Id4Bg=
X-Gm-Gg: AZuq6aIwVLhmquwCo7issa2Bqe3OSa0wO8KJM8jecq2b+brUWkmC5HUMiZYUFKxMEOh
	OpHqNlc0j6JvXccpjLTCAaQyTrfvQbGn4+pA+W1oUPGxa3x3xJBmRJ3exajH3eQuFAOr4zThyFW
	xjpt9jvDx3wSUc+jh3xl/+A9YyaVrPXpSMyEZNvkUasy4QyYIihWpn+mEnPbcz77e4V9QLOEKcV
	oXg8k6D8A1AUzYwlZKUSx6i3AO6bUihcy6oKFOX52FKfK0aTupgxBeNyj/dcPZuyce6HVkEm1lj
	gbpW6QSRdlogX29JRpJPARL/uZQVq14TuSj/YD9Fs9ifHrKhHIwxtpL3v0EafRGTNmTnjsAizw3
	QFm41euHU8V7Cc89P7NxbrHJkkmma4VPUY1zvTjsi3ZdbDhvFT/LQeTDGosYU/KYMoijCtThewM
	NgsrTC9c09Dky4gLGmMyElTyL6pmTeIfi3qrc5GTjjP9Czc+XIo/Q4Whqw3hF9L5znjDrrev28z
	i1d92n34Yd2kw==
X-Received: by 2002:a5d:5f54:0:b0:435:9ce0:f93c with SMTP id ffacd0b85a97d-4362969509amr24592397f8f.62.1770740291496;
        Tue, 10 Feb 2026 08:18:11 -0800 (PST)
Received: from [192.168.1.17] (host-79-19-172-190.retail.telecomitalia.it. [79.19.172.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972fa41sm39165771f8f.23.2026.02.10.08.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 08:18:10 -0800 (PST)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Tue, 10 Feb 2026 17:17:38 +0100
Subject: [PATCH] iommu: arm-smmu-qcom: Ensure smmu is powered up in
 set_ttbr0_cfg
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-qcom_smmu_pmfix-v1-1-78b7143ac053@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7TtAlOvSVCDHdag9aKUUg/j3pO
 AMzBTIlpgyjKJDo4cxHbKA7AW63cSPJvjGgwkGhVvJyRzA5hNucYeVXoiXrcbE9oYJWnYma/o/
 TXOsHqLYDBGEAAAA=
X-Change-ID: 20260210-qcom_smmu_pmfix-2aead2ba4e20
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770740289; l=2426;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=VRL/E7nK1fyZMX83uu6bt4FiGrPrpeuaTEztrOQsu9U=;
 b=3pZgXNEhwfzftk2Cfw8XXJ8nneEtPReIYQm7FPKnhsBaAF4wvq6oc6yGwv56OjIaVfHmJkCqc
 mZihmSR2ywFBaJPn3/li3OAgz3sQw2TocZC9SOPytLYad1lKiiWdrfF
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

Previously the device was being accessed while potentially in a
suspended state.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 573085349df3..ca34b7a141e6 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -231,16 +231,27 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const void *cookie,
 	struct io_pgtable *pgtable = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_cb *cb = &smmu_domain->smmu->cbs[cfg->cbndx];
+	int ret;
+
+	ret = pm_runtime_resume_and_get(smmu_domain->smmu->dev);
+	if (ret < 0) {
+		dev_err(smmu_domain->smmu->dev, "failed to get runtime PM: %d\n", ret);
+		return -ENODEV;
+	}
 
 	/* The domain must have split pagetables already enabled */
-	if (cb->tcr[0] & ARM_SMMU_TCR_EPD1)
-		return -EINVAL;
+	if (cb->tcr[0] & ARM_SMMU_TCR_EPD1) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	/* If the pagetable config is NULL, disable TTBR0 */
 	if (!pgtbl_cfg) {
 		/* Do nothing if it is already disabled */
-		if ((cb->tcr[0] & ARM_SMMU_TCR_EPD0))
-			return -EINVAL;
+		if ((cb->tcr[0] & ARM_SMMU_TCR_EPD0)) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		/* Set TCR to the original configuration */
 		cb->tcr[0] = arm_smmu_lpae_tcr(&pgtable->cfg);
@@ -249,8 +260,10 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const void *cookie,
 		u32 tcr = cb->tcr[0];
 
 		/* Don't call this again if TTBR0 is already enabled */
-		if (!(cb->tcr[0] & ARM_SMMU_TCR_EPD0))
-			return -EINVAL;
+		if (!(cb->tcr[0] & ARM_SMMU_TCR_EPD0)) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		tcr |= arm_smmu_lpae_tcr(pgtbl_cfg);
 		tcr &= ~(ARM_SMMU_TCR_EPD0 | ARM_SMMU_TCR_EPD1);
@@ -262,6 +275,8 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const void *cookie,
 
 	arm_smmu_write_context_bank(smmu_domain->smmu, cb->cfg->cbndx);
 
+out:
+	pm_runtime_put_autosuspend(smmu_domain->smmu->dev);
 	return 0;
 }
 

---
base-commit: 50c4a49f7292b33b454ea1a16c4f77d6965405dc
change-id: 20260210-qcom_smmu_pmfix-2aead2ba4e20

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

