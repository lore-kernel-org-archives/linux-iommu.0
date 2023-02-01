Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACB2A32
	for <iommu@lists.linux.dev>; Wed,  1 Feb 2023 08:25:10 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id cl23-20020a17090af69700b0022c745bfdc3so1236554pjb.3
        for <iommu@lists.linux.dev>; Wed, 01 Feb 2023 00:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EhWybcKgTwds/UHsJLPm/Ip1rELEiggR3k8BSANmn/I=;
        b=ltlOKB2q4A2HTRmq7Dd6Ig4Vvauzv0PlgyzuE2wbGRTqcZGY3SofmipAwycEkv0A6H
         Gm5b8ayE3VOW014QJ0/ph3vg0cw9PBWDPFpqogh/P6up8znRkfZi4Bl2T++yh2DImAfg
         hwKGnGc2PmTDt5bjUNkaY5/e7/EBEIO/qeSSUvfBLlAt3Qe7tvXMU5rjwKjNlpMLEmeN
         FBjNqHtDakNjnJrzh3h0KRASuGXv0D4LjsI0PHKvtzVoUbN/fHW0IRPIPXdbPWfdbL7y
         uGymn8832EqR3WcEkA8CMvYvdhzv4m+q2j24yhuGRI4MJj7Vo1lzMtrkZtuVwQUcCMpk
         yjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhWybcKgTwds/UHsJLPm/Ip1rELEiggR3k8BSANmn/I=;
        b=L8RIrD2zddQwS8a62WIEktPUKKCAXYPwIbF9nQ/S8vt7KX3ZGCWEfUmEWhiNj1JRHj
         Sy4HGK+opDAFqNajX3OxAlZwt7qTN1w5TsqpmzXVHiw0SIKxEc3AQIXOmVLmAG1LyNHd
         5jEOCciPLzEmfRw+uloHwTJuEvSHNv2m1MLT5OeQlBMZ1FKX+AN/oeWlqUH76+qJDXma
         D+uxeYoPkqzdOCaVHIDURncQLSAyqTIMycUbfh6hkOX42X03dB3IGq3OLVUUoyKq6H07
         oFazFRfVSwTTpzhtD1GEvx50PRu0d82k/CWdI2QkKRRAua+316cRTjnkziQaqIySmgvM
         YspA==
X-Gm-Message-State: AO0yUKXBvOU0YlidMXfh3hGfZHo0sPXl93/ilr0pjlL00vLNGBaQPBse
	nuItwqAvVOk0KwHK5TEXaZGH
X-Google-Smtp-Source: AK7set8wFefYkOrTHJG39/CBWCzGmLDVbAv8tEZKj7KT7UoQ6jnnb/WxZtO0aauyj4ZllhmV4AYCIw==
X-Received: by 2002:a05:6a20:2a1e:b0:bc:74c3:9499 with SMTP id e30-20020a056a202a1e00b000bc74c39499mr1623148pzh.24.1675239909774;
        Wed, 01 Feb 2023 00:25:09 -0800 (PST)
Received: from localhost.localdomain ([59.92.99.243])
        by smtp.gmail.com with ESMTPSA id 69-20020a630248000000b0045ff216a0casm9847836pgc.3.2023.02.01.00.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 00:25:08 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: will@kernel.org,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	andersson@kernel.org,
	johan+linaro@kernel.org,
	steev@kali.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] iommu/arm-smmu-qcom: Rework the logic finding the bypass quirk
Date: Wed,  1 Feb 2023 13:55:00 +0530
Message-Id: <20230201082500.61656-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic used to find the quirky firmware that intercepts the writes to
S2CR register to replace bypass type streams with a fault, and ignore the
fault type, is not working with the firmware on newer SoCs like SC8280XP.

The current logic uses the last stream mapping group (num_mapping_groups
- 1) as an index for finding quirky firmware. But on SC8280XP, this
logic is not working as the number of stream mapping groups reported by
the SMMU (163 as on the SC8280XP-CRD device) is not valid for some reason.
So the current logic that checks the (163-1) S2CR entry fails to detect
the quirky firmware on these devices and triggers invalid context fault
for bypass streams.

To fix this issue, rework the logic to find the first non-valid (free)
stream mapping register group (SMR) and use that index to access S2CR
for detecting the bypass quirk.

This also warrants a change in variable name from last_s2cr to free_s2cr.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 24 +++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 78fc0e1bf215..4104f81b8d8f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -267,23 +267,37 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 
 static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 {
-	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
 	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	u32 free_s2cr;
 	u32 reg;
 	u32 smr;
 	int i;
 
+	/*
+	 * Find the first non-valid (free) stream mapping register group and
+	 * use that index to access S2CR for detecting the bypass quirk.
+	 */
+	for (i = 0; i < smmu->num_mapping_groups; i++) {
+		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
+
+		if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
+			break;
+	}
+
+	free_s2cr = ARM_SMMU_GR0_S2CR(i);
+
 	/*
 	 * With some firmware versions writes to S2CR of type FAULT are
 	 * ignored, and writing BYPASS will end up written as FAULT in the
-	 * register. Perform a write to S2CR to detect if this is the case and
-	 * if so reserve a context bank to emulate bypass streams.
+	 * register. Perform a write to the first free S2CR to detect if
+	 * this is the case and if so reserve a context bank to emulate
+	 * bypass streams.
 	 */
 	reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, S2CR_TYPE_BYPASS) |
 	      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, 0xff) |
 	      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT);
-	arm_smmu_gr0_write(smmu, last_s2cr, reg);
-	reg = arm_smmu_gr0_read(smmu, last_s2cr);
+	arm_smmu_gr0_write(smmu, free_s2cr, reg);
+	reg = arm_smmu_gr0_read(smmu, free_s2cr);
 	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS) {
 		qsmmu->bypass_quirk = true;
 		qsmmu->bypass_cbndx = smmu->num_context_banks - 1;
-- 
2.25.1

