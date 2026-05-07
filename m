Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E029743D504
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168638; cv=none; b=uXUe2pZSyhe4gQVtVZyRKWVHfU6eCRit07NZuoVoHdz/TYCmBacFMhFACf6FgV8VTQXulBfXQqz1sGJWMTnXsn95nY3uuKGOVoNdy1mz43dEl4NkhGwCxtcGfgKe8VqX9VY5lAd8kNNRf6ZEtPu3D6eKeg9PFO4H3mNJWCV/aps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168638; c=relaxed/simple;
	bh=JvTfGtQt/QzZHDNLS/mKUWRZZK3nInAjvOmIg4zwlgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qe1802S8NDSNErBLsIBzIkJXZduusziLD8VXLeYjNBXVyLGbALCZgJmrNsPuycRAn8hcrqVSsKl1DoOjYBz0gXIVNhK9qNBwLnYMO9nDvgy+4FIKdcKrGwrUuJvpzwmGwdB2QhO95oV21sSqR5aKmX65t/fLj12uDCofzmsjKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhCNLODa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhCNLODa"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so12776525e9.2
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 08:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778168635; x=1778773435; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EhQrAQa75d2J0YA5KpT6AkN5xsQFVAOM6cWXJDqCQUw=;
        b=dhCNLODavf7Nzy1B10FioLaBlbojQfmfGakSpXprrU6mcHO7X3MyZnz41mwCCw+EFi
         K6RZHe7kH6Xf3IBr3UI5Y1dwZ6HvCOceqUEclyKT2kb87U4+AjdHPuEMPwRYyd2gQISx
         wkAPodPPvHKXzeQjS7NAxnvmWXRG6cYCkNbRnShAEZ8kkR1C/b6eJQ/3pe/a7Kj2H6Pk
         swzIntzGyy3/dWcwZJLhPbyANWJ9BtbwGjV0EzaUu0cI+01krbH5bjYPKmjCWBbuBZSS
         gFer/l0t4Akxt3VgyufUqwEDuhEQuICfAieDfADs4GNbfRKNOoAGjkqZ/YKN+zZGMVuO
         onQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168635; x=1778773435;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhQrAQa75d2J0YA5KpT6AkN5xsQFVAOM6cWXJDqCQUw=;
        b=NUXxQtFc/dnw/oh1CGRKB9nXNZcrs/syvh266z/3tP2rU4HefrgrZDlGDIkjdeKmJX
         eFPF3YnTCxb58r+4aTFpw/rkac3R1gnzvM3E1+DWP9NyXO8DlRfCfK6i0N1492wBzR6F
         eYqEQ+CngSQm9pVux2PN/poi1d7FAMUvmiLMdp8b32eRaG0RVQ++36Wh0UNMFnNEzR+V
         6Eh0MuI+JeVqeXYBMJ+dfQB7dtAGAqP74FZnrCu1OHs1sX2CEYfkd5mIyPBRO/DwxGfy
         Pu7PiMABVcvqTbfb0AHHbP2mgGvWxuN3DLguDXp/TX53dAAWqSi3v5byYgA0JKw36nke
         +F2Q==
X-Gm-Message-State: AOJu0Yy5K1doojaePeAmSHNzOi52hamkf5bOaaPrQFlF6Y3z5En7Paat
	qReY5rWoMd+gmcV2na8uxGVxvtdgu/7DfjZ0G09akrmtYLRkMCf2F599/zZ9
X-Gm-Gg: AeBDies0M78Dd0hlxfzw/SW8z4qU04xMclpmWwaoTkWa0vo6Eosci8YETEngPqeOnih
	Z4dSSxja1hvfRWHGPbd+YcpoRlx6P/v63cO1wZoJa63eR4rNgp/JpKQh7EuTlwPIfF0SzU5hfbQ
	I2cpkTMe2msQKrtQ/DNeTiBNOCJOyuYwfP3/wAwHmSI2PohOcb6KQ5WC619SvsAGisUGRSbsUF/
	+Uu1RpwXqilvwbq7rlYUir9tDhO0zYUneTsQTjQ710eA37XNTMDDnrSvVK49B4mhyauAMaorkTY
	4LWGttbKELs48toxzfQVOd6pT1pt1yViIyxiD7AJ+rrXMw5qAInmYclVqDCIQhKRyCrA/5K2KwZ
	NDz9ls2NvMjSeZsAI17RMxzFHYCnFA+jYciJ/cgkmpXGJCPdM8TC2Zs91upyEAdfETzQjsDstsA
	5yWzbEtX2MhEwOxK4G+3EeJmH8Ib40rkFKsuvHnsNNsv2ydl6ptjmQ4WX/rbasyfDgXg1unHRPB
	En8Ero7RM3mWpNKGcw=
X-Received: by 2002:a05:600c:a305:b0:48d:364:6c54 with SMTP id 5b1f17b1804b1-48e51f4144amr102180955e9.23.1778168635011;
        Thu, 07 May 2026 08:43:55 -0700 (PDT)
Received: from [192.168.1.17] (host-79-50-55-97.retail.telecomitalia.it. [79.50.55.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53891d62sm209994895e9.1.2026.05.07.08.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:43:54 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 07 May 2026 17:43:15 +0200
Subject: [PATCH v3] iommu: arm-smmu-qcom: Ensure smmu is powered up in
 set_ttbr0_cfg
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-qcom_smmu_pmfix-v3-1-af8cd05831a2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNzQrCMBAGX6XkbCTZ9Ec9+R4iZdOubcA0NdGgl
 L67aS8K4nE+dmYnFsgbCuyQTcxTNMG4IYHaZKzpceiImzYxAwGlACn4rXG2DtY+6tFezJMDEra
 gMScQLFmjpzSvxdM5cW/C3fnX+iDKZf3fipJLXu10JXOFjSjUsbNortt0xpZWhI+voPj1Ifkaq
 3KPJbZC07c/z/Mb6SbGKO4AAAA=
X-Change-ID: 20260210-qcom_smmu_pmfix-2aead2ba4e20
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Anna Maniscalco <anna.maniscalco2000@gmail.com>, 
 Rob Clark <rob.clark@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778168633; l=2650;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=JvTfGtQt/QzZHDNLS/mKUWRZZK3nInAjvOmIg4zwlgw=;
 b=78r+QvfiiQHi317bGaK1Vp3B2bi2od5HUfeBqAj9XVv3eh8gwkCyaKS+hC7krNXwwLSK/Ustd
 uBpdiT/GZqBDZ8rCiOrpauIwtCS2Vf4qswB9VZB1iXJHovt55TZVPwy
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

arm_smmu_write_context_bank() assumes it is being called with RPM
active, but it turns out that is not guaranteed in the path from
qcom_adreno_smmu_set_ttbr0_cfg(), so it's possible for the register
writes to get lost when configuring the context bank while the GPU is
idle, leading to page faults later.
Add the RPM calls here to make sure the SMMU is active before we touch
it.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
Changes in v3:
- Changed commit message to be more self-contained as suggested.
- Collected RBs
- Link to v2: https://lore.kernel.org/r/20260325-qcom_smmu_pmfix-v2-1-ba769a6ad0be@gmail.com

Changes in v2:
- Simplify patch by acquiring device just around the call that needs it
- Link to v1: https://lore.kernel.org/r/20260210-qcom_smmu_pmfix-v1-1-78b7143ac053@gmail.com

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 573085349df3..cab7d110aaf5 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -231,6 +231,7 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const void *cookie,
 	struct io_pgtable *pgtable = io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_cb *cb = &smmu_domain->smmu->cbs[cfg->cbndx];
+	int ret;
 
 	/* The domain must have split pagetables already enabled */
 	if (cb->tcr[0] & ARM_SMMU_TCR_EPD1)
@@ -260,8 +261,16 @@ static int qcom_adreno_smmu_set_ttbr0_cfg(const void *cookie,
 		cb->ttbr[0] |= FIELD_PREP(ARM_SMMU_TTBRn_ASID, cb->cfg->asid);
 	}
 
+	ret = pm_runtime_resume_and_get(smmu_domain->smmu->dev);
+	if (ret < 0) {
+		dev_err(smmu_domain->smmu->dev, "failed to get runtime PM: %d\n", ret);
+		return -ENODEV;
+	}
+
 	arm_smmu_write_context_bank(smmu_domain->smmu, cb->cfg->cbndx);
 
+	pm_runtime_put_autosuspend(smmu_domain->smmu->dev);
+
 	return 0;
 }
 

---
base-commit: 50c4a49f7292b33b454ea1a16c4f77d6965405dc
change-id: 20260210-qcom_smmu_pmfix-2aead2ba4e20

Best regards,
--  
Anna Maniscalco <anna.maniscalco2000@gmail.com>

