Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF997486418
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161680; cv=none; b=ASxFnWRqfCn/Y7J22OwLocBIe8cuTfEq+JGj1Sw7WOb7HV759PeDPZ93JjrJUjRlXJq//XeNYaiVkZKUKPlWvJZmxrvVOqn+iKrM3cFKu/AUUdwmUW6W6CQjulEt3S0AyAxCiNaJAAvjHpXrrGmdNM9KL0IsXhK7aujAevf6AsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161680; c=relaxed/simple;
	bh=VB6oO/0/aP3anKWJoqBgbBJ4sY9p6fnK67zg5+eEZ9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J9QlZ2Uwr8FPisyxmB6dprb2SrKv2OjQSOEZKJdP0ZPhxzFI5eApuel4VWWUEwmSaq+RxWkG7phx6HEoIa409fCKAcbU9nkZE2ZX3wETKrhejSjRBcuhg2qjCCFakN5lQt4ww9GFz1GDxe/ohG2q80XM6EueX139OaVJaodfemI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qShMLNSS; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qShMLNSS"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9adcso830236a12.0
        for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789161675; x=1789766475; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uvm+btPrQRBTuu8+5mSNLZIT1wcR2MM1QR5DtKY3sJA=;
        b=qShMLNSSsMbPLZ0SRLCFwKYBfyqpVo2QB6Cxn6FZQxoEXE4s21Z0LeESVjXA0TzPPl
         t8DtM5/it3b6CmlB1i+hqpXxaQK6IhXRXE/m8/qCd9qGkMELvX1/ym9r3fHXgwpcb0Kb
         n1LOyi2lqJmtF4W2rEQIScKdvzxZU5+a0me1kXxTSdveQQY8RRNsMiH3eTtzXLk1Ch4Z
         LKZZPCCnu24qxmIKtXqfOijvC9vJ1VKY0UT2G7tIBRX9ktvWPAJz9MYlXQeiE4iGMiY/
         xhV/8X71oomAvVaojUstyK9CjoxvU2iHTfsBgOgpXbTB4F4lc5lWFwydYuijyrZAhryB
         raSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161675; x=1789766475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uvm+btPrQRBTuu8+5mSNLZIT1wcR2MM1QR5DtKY3sJA=;
        b=V1pFZDpjWVupR8qBnbFn9Tyq9iOg5V5Cpuel+IWg8oBuMD/evMq+lNvY7pkvmIAOXU
         PIwQB45JEXYJUj66VVin1ztIc31rfaGt8DxeEg5XlSW9AMA66Cwvq5x5YYgiXDgW9kS1
         TOt2BebDZgRWZnqxl9sEZs+aJ0BCphaQNzMYveqIDo/dt4EipaBpfDzZ9tvog8q8u712
         1Xjr9q6mQYT5kXYXhcA/gM45JvUPp+cKvAE5FWgx7nB3JWzmrsMJl3y8MK/seHssgJyM
         Jsva6KOSAYmmmzPShXASdx61ZvjCrpMETivYaVeZWFY37iHjq3xdlvn55wFbHgtanIK/
         NMEw==
X-Forwarded-Encrypted: i=1; AKwUvBzcxnwAi9ei9F291kKhaQGrIaPK+UFBqz83Ix2JkNjoUxebmLQACBSZ+2WeA508cgUd0pMInA==@lists.linux.dev
X-Gm-Message-State: AFuF++m5kcOUedfjccjKxhQ1vz98ZSKGcEnrS+bdVbS+Mker8a+wUUwY
	d2qaNeQavC8gYNxGVpoG7srAj9LPAB12fJACPssNimjfQgmwnCPyM7nceoCgqfTbhUU=
X-Gm-Gg: AYBFou0OoGm5aYDQWXwzSUCX7Nk3hQ9fEoRHujp09lg8fkk4ENxTSPifrxFZcLZdrs/
	ik0L2OVrSJxGA7QpPM3tglMQJIapKtJCZihuQIddY8uedHT0yvdy35xy9cA5qW1UtttHbQqd9QD
	o3cKB7K/lwMxPrXLlqCkvwaytGh56spUrpQzn6jhA7cAESBJ1urw3NuROJJbCPWMxdc5ikT6Y5Z
	l9wvXC9EFzt2gT83BShlJ1nbtcITpO5N8Oy+fQsrDMihsDucvZr8z5IeDCCG1FodBYUiM5MqnBD
	ykbKC4Nh1v+C3fRCa+6fl5kk/9EdEo+4NRUeYu5i9STC0t0yM2/3MLYv6GC/ssbpgHYNdSpGMUU
	2ChqQvBqvK6/UzMBoG4qbjxO1/RkfXUjndmuOazE95vJuqxUKUi/J1717/9/dagv7jL3WSoGbjn
	nhMbWuu+L0pBnRNAUngBNFV/x3WZrmZftBBgB4VB3QcfvocPgcDXaXn0d+JTSwgt4s8kfhxdvMc
	z7dd5nUjwlKk/cA88x4bJwO4ifAfDhknwskFBbTxvyFitJw2wsU4MB7DxVw4cr/jg==
X-Received: by 2002:a17:907:6d0f:b0:c25:1b4f:6d95 with SMTP id a640c23a62f3a-c296650ef6bmr266540666b.6.1789161675053;
        Fri, 11 Sep 2026 14:21:15 -0700 (PDT)
Received: from petegriffin.c.googlers.com (116.118.90.34.bc.googleusercontent.com. [34.90.118.116])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29660234f2sm126375166b.12.2026.09.11.14.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:21:14 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 11 Sep 2026 21:21:06 +0000
Subject: [PATCH v2 2/2] iommu/arm-smmu-v3: Add support for
 arm,instdata-override DT property
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-arm-smmu-v3-instcfg-override-v2-2-5804e4f400b5@linaro.org>
References: <20260911-arm-smmu-v3-instcfg-override-v2-0-5804e4f400b5@linaro.org>
In-Reply-To: <20260911-arm-smmu-v3-instcfg-override-v2-0-5804e4f400b5@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>, 
 Daniel Mentz <danielmentz@google.com>, Mostafa Saleh <smostafa@google.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
 willmcvicker@google.com, jyescas@google.com, 
 Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5946;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=VB6oO/0/aP3anKWJoqBgbBJ4sY9p6fnK67zg5+eEZ9M=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBqpHDHzEijWCf5mE/ywG6gZ00CigmowyI36StKG
 HawX3dSwmWJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaqRwxwAKCRDO6LjWAjRy
 unoJD/9g5EpIQMsuKWJGdcGUJ/1Q3cLmc5iRMaXFcXKRRNNlmQyfwhjwmdzrUqjc/GzrWrWRqFA
 mk9NTrlWN0G/ZnnfBltZmYjJxgnqcEKXQo0SjN5kG0q2kvr40lu/nlbzx0rX0nxK+UVKfXeiHPY
 ttvXD+QErU05cm5EOIJXOiarJ5rCk+9UeDfdLBjmdn+T7wL2nfuEXW3kNAiTpY+JFyzL3skLOtk
 cnaLW7wXEL0TO6dBFtT5EzeXlF50ayjk31yafAiv08ncNMaO8OkO5FjKpay69TklnRP6Cw0a6Yz
 BPOYvVNiGRV+Al4hDtGlvrsC42hrfP6ct9ByLxOuR8Q9O5aME5HXCk/q6vrlmsbK2HYxSU/kmsj
 i1Y0a3zBceTr/GDtEijxlo1X89vAb31W6Mpixr80/KgpO4UHrNXZJB3Dmd7nydt7z/yUpzfuznz
 xPJNBPniX7Mz6XLciY4Nb9dev99DHTpFTw97okrfPUg3VmkVjDFixKYoA0/05SHz4yFVWk2g0cF
 R+x4kfEGIk+j3b34vAArwX46HNB8O57zU2FF3q9pms/VU+ulA7eYMXVDItuC6Bh1athAkXoO+V5
 4X9EPSOmO8ncYqj9VzhXH80guhjWpBeBHnCs4pPcoZp9SzM0ZTmSE6B5wpCCistAkcs59xTyuRO
 W5m1PFSqOy2/Ivg==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

The Google Tensor G5 SoC (Laguna) has a silicon errata with the SMMU
integration where the AxPROT[2] signal is always 1, which makes all
transactions appear as instructions.

To avoid F_PERMISSION faults (due to the VMSAv8-64 requirement that
unprivilieged writable buffers are treated as Privileged Execute-Never
(PXN)), as a software workaround we make use of the INSTCFG override
feature to force all incoming traffic to data.

To enable this workaround, the "arm,instdata-override" DT property can be
provided in the device tree entry for the SMMU, similar to how existing
errata workarounds are handled by this driver.

Note this is added for "stage-1" and "stage-2" but we intentionally leave
out "bypass" as nothing is downstream of the SMMU that makes use of the
Instruction/Data attribute.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
[peter.griffin: ported to upstream, updated commit message, remove
feature flag]
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes in v2
 - Fixup incorrect bracket (Sashiko / Nicolin)
 - Add more verbose description of the issue (Will/Robin)
 - Add note about why "bypass" is not required (Nicolin)
 - Remove ARM_SMMU_FEAT_PERMS_OVR flag (Nicolin)
 - Move check closer to IDR1_ATTR_TYPES_OVR read
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 +++++++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  6 ++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122d..f88647be94475 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -91,6 +91,7 @@ DEFINE_MUTEX(arm_smmu_asid_lock);
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
+	{ ARM_SMMU_OPT_OVR_INSTCFG_DATA, "arm,instdata-override"},
 	{ 0, NULL},
 };
 
@@ -1271,7 +1272,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 			cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |
 				    STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |
 				    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW |
-				    STRTAB_STE_1_EATS | STRTAB_STE_1_MEV);
+				    STRTAB_STE_1_EATS | STRTAB_STE_1_MEV |
+				    STRTAB_STE_1_INSTCFG);
 		used_bits[2] |= cpu_to_le64(STRTAB_STE_2_S2VMID);
 
 		/*
@@ -1287,7 +1289,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 	if (cfg & BIT(1)) {
 		used_bits[1] |=
 			cpu_to_le64(STRTAB_STE_1_S2FWB | STRTAB_STE_1_EATS |
-				    STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV);
+				    STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV |
+				    STRTAB_STE_1_INSTCFG);
 		used_bits[2] |=
 			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
 				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
@@ -1900,7 +1903,11 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 			 STRTAB_STE_1_S1STALLD :
 			 0) |
 		FIELD_PREP(STRTAB_STE_1_EATS,
-			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
+			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0) |
+		FIELD_PREP(STRTAB_STE_1_INSTCFG,
+			   smmu->options & ARM_SMMU_OPT_OVR_INSTCFG_DATA ?
+				   STRTAB_STE_1_INSTCFG_DATA :
+				   STRTAB_STE_1_INSTCFG_INCOMING));
 
 	if ((smmu->features & ARM_SMMU_FEAT_ATTR_TYPES_OVR) &&
 	    s1dss == STRTAB_STE_1_S1DSS_BYPASS)
@@ -1952,7 +1959,11 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 
 	target->data[1] = cpu_to_le64(
 		FIELD_PREP(STRTAB_STE_1_EATS,
-			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
+			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0) |
+		FIELD_PREP(STRTAB_STE_1_INSTCFG,
+			   smmu->options & ARM_SMMU_OPT_OVR_INSTCFG_DATA ?
+				   STRTAB_STE_1_INSTCFG_DATA :
+				   STRTAB_STE_1_INSTCFG_INCOMING));
 
 	if (pgtbl_cfg->quirks & IO_PGTABLE_QUIRK_ARM_S2FWB)
 		target->data[1] |= cpu_to_le64(STRTAB_STE_1_S2FWB);
@@ -5155,6 +5166,12 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (reg & IDR1_ATTR_TYPES_OVR)
 		smmu->features |= ARM_SMMU_FEAT_ATTR_TYPES_OVR;
 
+	if ((smmu->options & ARM_SMMU_OPT_OVR_INSTCFG_DATA) &&
+	    !(reg & IDR1_ATTR_PERMS_OVR)) {
+		dev_err(smmu->dev, "Inst/Data attribute override not supported\n");
+		return -ENXIO;
+	}
+
 	/* Queue sizes, capped to ensure natural alignment */
 	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
 					     FIELD_GET(IDR1_CMDQS, reg));
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dd2fee2f560e6..efbac8ca6d7a0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -52,6 +52,7 @@ struct arm_vsmmu;
 #define IDR1_QUEUES_PRESET		(1 << 29)
 #define IDR1_REL			(1 << 28)
 #define IDR1_ATTR_TYPES_OVR		(1 << 27)
+#define IDR1_ATTR_PERMS_OVR		(1 << 26)
 #define IDR1_CMDQS			GENMASK(25, 21)
 #define IDR1_EVTQS			GENMASK(20, 16)
 #define IDR1_PRIQS			GENMASK(15, 11)
@@ -285,6 +286,10 @@ static inline u32 arm_smmu_strtab_l2_idx(u32 sid)
 #define STRTAB_STE_1_SHCFG		GENMASK_ULL(45, 44)
 #define STRTAB_STE_1_SHCFG_INCOMING	1UL
 
+#define STRTAB_STE_1_INSTCFG		GENMASK_ULL(51, 50)
+#define STRTAB_STE_1_INSTCFG_INCOMING	0UL
+#define STRTAB_STE_1_INSTCFG_DATA	2UL
+
 #define STRTAB_STE_2_S2VMID		GENMASK_ULL(15, 0)
 #define STRTAB_STE_2_VTCR		GENMASK_ULL(50, 32)
 #define STRTAB_STE_2_VTCR_S2T0SZ	GENMASK_ULL(5, 0)
@@ -934,6 +939,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
+#define ARM_SMMU_OPT_OVR_INSTCFG_DATA	(1 << 5)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;

-- 
2.55.0.1007.g17ff1f9808-goog

