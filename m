Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06667196C86
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015844; cv=none; b=qGbaIPv43+kqxKbNBC9ZrviB22nZSdn7pNBOcUTSTN5X8eJYTPtE/LmzJXSSGH/CbGlB6aTypBqsFmDeU0v8PT1fMadSEEz6dcwm+mzEczKPu9hnHfz1I5fHjKtFjf+earQltLu2gnbVQy9E9bks1F9Czd7lcOMtaNyekZeejgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015844; c=relaxed/simple;
	bh=ab9XIFNRkElNQpuGfoqIdx/EdnklAjwA/TWC7rptbwA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fKFplIPP9pvXwiTmM1OI+4YWZNYJkwmoMSLMWtV7I1D25M2kDuWT6q+e3r+uKNjCuV+A/CS58fKk2uF1MPIx4iTt4Juoz6UuU/R/dUxdlrhQ2QlNv/6Qh3fYRjldMBEAD5rQKS82HTi/z7OvTwy7rCDE4QVwmem+w0ZtukUBSI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pjNE5Zcz; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjNE5Zcz"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0353b731b8so2977783276.2
        for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725015842; x=1725620642; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/mKrNSDKBnu5yum3y3zhooOe1T+Lz6kz3xJIzbyQqs=;
        b=pjNE5ZczsrXsvaDecdOoYhK5cAwbMIPw4JkW3BkRV4C9j4nsvPv88OXy6ltcgMET0A
         EXOFb8b0Jqev81tXMEsGtuEEY9MaEcm+F52wu1q8bk2J0T2atUiZynVdPYKcbdWgVrA3
         DJ9R9t0u7JzF0POyrR9+g4QIKkOgYn3aU1FczfGIJgStP5S6jMVgg9+JYWm0tYzkBpjh
         E35IXhixhRmEtFv/+edbkyBvL9M7ufsFEVthZ8XTJylbGreUbczrU2Ndn7UohDs8dHbD
         XkDwpXjrfu1Q8XstJLQ1FhSn/SXAPK7bPaBTzZJWGxJzCmdIE+awmA3sZc3Af1kJktOf
         +meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725015842; x=1725620642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/mKrNSDKBnu5yum3y3zhooOe1T+Lz6kz3xJIzbyQqs=;
        b=KfSkeC2D/B/99d0rNyBeIVUFPQBMi6iWQD2NcMrpblEoA33A7GqJ+j160gQZTTcPLk
         iraoW/JACV2VWE6dSVhvG3LO2rYHxFqg8NrnB/aW/Jr+FNbRtBOZjditB3xsVyD2eUV3
         1D5beXr0KvdbzVNXRFUeN7WZbNU6ZQUDgKWugYh0w0YBc2THpH9UqDjKsnsUlZD/BRwC
         9N9RidQE35n8kJ22rWo6nU1c7gQfPr1fqSix5o0QgQGf2ivTQwiTaaUA6UUokpVQoFNz
         7MLxRsXnUZuMYh438yqCrJdL6mEnVVaYIaXw2GOXow+y7cwqDRaIvA3jr4t60PxsmUBX
         FsEw==
X-Forwarded-Encrypted: i=1; AJvYcCXLj5IAJ0OmuFPyJx6crjPQjLgnTKgx1SDEbR3V+rhnKu0HNEg9ANAbYAJXERPvA99DQyEc9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YygQBLFoEWHGmZTXMJmvRUiBCm4DeGOIDyiE8U7xkRGB+FnzjX0
	8EhzLw29TIMwn0S/Z6xnVI3fthY8tYQ3jBOaUQ2lfILfS85NvlN5P8UwHa4DW5HyjjnNgC0v1mK
	mrq2owEYwDw==
X-Google-Smtp-Source: AGHT+IHCT4BVIVvVKE9Liin+BCArrCMLiB0xZjSA3o/HnMqT8IOHQAQ0c34vg5JpBmozpHBlZUKNiQlne5c01Q==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a25:a208:0:b0:e11:5e87:aa9 with SMTP id
 3f1490d57ef6-e1a7a179ee1mr2994276.8.1725015842037; Fri, 30 Aug 2024 04:04:02
 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:03:48 +0000
In-Reply-To: <20240830110349.797399-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240830110349.797399-1-smostafa@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240830110349.797399-3-smostafa@google.com>
Subject: [PATCH v4 2/2] iommu/arm-smmu-v3-test: Test masters with stall enabled
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org
Cc: jean-philippe@linaro.org, jgg@ziepe.ca, nicolinc@nvidia.com, 
	mshavit@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

At the moment, the SMMUv3 unit tests assume ATS is always enabled,
although this is sufficient to test hitless/non-hitless transitions,
but exercising other features is useful to check ste/cd population
logic (for example the .get_used logic).

Add an enum where bits define features per-master, at the moment there
is only ATS and STALLs which are mutually exclusive, but this would
make it easier to extend with other features in the future.

Also, Add 2 more tests for s1 <-> s2 transitions with stalls enabled.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 83 ++++++++++++++-----
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index cceb737a7001..84baa021370a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -30,6 +30,11 @@ static struct mm_struct sva_mm = {
 	.pgd = (void *)0xdaedbeefdeadbeefULL,
 };
 
+enum arm_smmu_test_master_feat {
+	ARM_SMMU_MASTER_TEST_ATS = BIT(0),
+	ARM_SMMU_MASTER_TEST_STALL = BIT(1),
+};
+
 static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
 						const __le64 *used_bits,
 						const __le64 *target,
@@ -164,16 +169,22 @@ static const dma_addr_t fake_cdtab_dma_addr = 0xF0F0F0F0F0F0;
 
 static void arm_smmu_test_make_cdtable_ste(struct arm_smmu_ste *ste,
 					   unsigned int s1dss,
-					   const dma_addr_t dma_addr)
+					   const dma_addr_t dma_addr,
+					   enum arm_smmu_test_master_feat feat)
 {
+	bool ats_enabled = feat & ARM_SMMU_MASTER_TEST_ATS;
+	bool stall_enabled = feat & ARM_SMMU_MASTER_TEST_STALL;
+
 	struct arm_smmu_master master = {
+		.ats_enabled = ats_enabled,
 		.cd_table.cdtab_dma = dma_addr,
 		.cd_table.s1cdmax = 0xFF,
 		.cd_table.s1fmt = STRTAB_STE_0_S1FMT_64K_L2,
 		.smmu = &smmu,
+		.stall_enabled = stall_enabled,
 	};
 
-	arm_smmu_make_cdtable_ste(ste, &master, true, s1dss);
+	arm_smmu_make_cdtable_ste(ste, &master, ats_enabled, s1dss);
 }
 
 static void arm_smmu_v3_write_ste_test_bypass_to_abort(struct kunit *test)
@@ -204,7 +215,7 @@ static void arm_smmu_v3_write_ste_test_cdtable_to_abort(struct kunit *test)
 	struct arm_smmu_ste ste;
 
 	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &ste, &abort_ste,
 						       NUM_EXPECTED_SYNCS(2));
 }
@@ -214,7 +225,7 @@ static void arm_smmu_v3_write_ste_test_abort_to_cdtable(struct kunit *test)
 	struct arm_smmu_ste ste;
 
 	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &abort_ste, &ste,
 						       NUM_EXPECTED_SYNCS(2));
 }
@@ -224,7 +235,7 @@ static void arm_smmu_v3_write_ste_test_cdtable_to_bypass(struct kunit *test)
 	struct arm_smmu_ste ste;
 
 	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &ste, &bypass_ste,
 						       NUM_EXPECTED_SYNCS(3));
 }
@@ -234,7 +245,7 @@ static void arm_smmu_v3_write_ste_test_bypass_to_cdtable(struct kunit *test)
 	struct arm_smmu_ste ste;
 
 	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &bypass_ste, &ste,
 						       NUM_EXPECTED_SYNCS(3));
 }
@@ -245,9 +256,9 @@ static void arm_smmu_v3_write_ste_test_cdtable_s1dss_change(struct kunit *test)
 	struct arm_smmu_ste s1dss_bypass;
 
 	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_test_make_cdtable_ste(&s1dss_bypass, STRTAB_STE_1_S1DSS_BYPASS,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 
 	/*
 	 * Flipping s1dss on a CD table STE only involves changes to the second
@@ -265,7 +276,7 @@ arm_smmu_v3_write_ste_test_s1dssbypass_to_stebypass(struct kunit *test)
 	struct arm_smmu_ste s1dss_bypass;
 
 	arm_smmu_test_make_cdtable_ste(&s1dss_bypass, STRTAB_STE_1_S1DSS_BYPASS,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(
 		test, &s1dss_bypass, &bypass_ste, NUM_EXPECTED_SYNCS(2));
 }
@@ -276,16 +287,20 @@ arm_smmu_v3_write_ste_test_stebypass_to_s1dssbypass(struct kunit *test)
 	struct arm_smmu_ste s1dss_bypass;
 
 	arm_smmu_test_make_cdtable_ste(&s1dss_bypass, STRTAB_STE_1_S1DSS_BYPASS,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(
 		test, &bypass_ste, &s1dss_bypass, NUM_EXPECTED_SYNCS(2));
 }
 
 static void arm_smmu_test_make_s2_ste(struct arm_smmu_ste *ste,
-				      bool ats_enabled)
+				      enum arm_smmu_test_master_feat feat)
 {
+	bool ats_enabled = feat & ARM_SMMU_MASTER_TEST_ATS;
+	bool stall_enabled = feat & ARM_SMMU_MASTER_TEST_STALL;
 	struct arm_smmu_master master = {
+		.ats_enabled = ats_enabled,
 		.smmu = &smmu,
+		.stall_enabled = stall_enabled,
 	};
 	struct io_pgtable io_pgtable = {};
 	struct arm_smmu_domain smmu_domain = {
@@ -308,7 +323,7 @@ static void arm_smmu_v3_write_ste_test_s2_to_abort(struct kunit *test)
 {
 	struct arm_smmu_ste ste;
 
-	arm_smmu_test_make_s2_ste(&ste, true);
+	arm_smmu_test_make_s2_ste(&ste, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &ste, &abort_ste,
 						       NUM_EXPECTED_SYNCS(2));
 }
@@ -317,7 +332,7 @@ static void arm_smmu_v3_write_ste_test_abort_to_s2(struct kunit *test)
 {
 	struct arm_smmu_ste ste;
 
-	arm_smmu_test_make_s2_ste(&ste, true);
+	arm_smmu_test_make_s2_ste(&ste, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &abort_ste, &ste,
 						       NUM_EXPECTED_SYNCS(2));
 }
@@ -326,7 +341,7 @@ static void arm_smmu_v3_write_ste_test_s2_to_bypass(struct kunit *test)
 {
 	struct arm_smmu_ste ste;
 
-	arm_smmu_test_make_s2_ste(&ste, true);
+	arm_smmu_test_make_s2_ste(&ste, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &ste, &bypass_ste,
 						       NUM_EXPECTED_SYNCS(2));
 }
@@ -335,7 +350,7 @@ static void arm_smmu_v3_write_ste_test_bypass_to_s2(struct kunit *test)
 {
 	struct arm_smmu_ste ste;
 
-	arm_smmu_test_make_s2_ste(&ste, true);
+	arm_smmu_test_make_s2_ste(&ste, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &bypass_ste, &ste,
 						       NUM_EXPECTED_SYNCS(2));
 }
@@ -346,8 +361,8 @@ static void arm_smmu_v3_write_ste_test_s1_to_s2(struct kunit *test)
 	struct arm_smmu_ste s2_ste;
 
 	arm_smmu_test_make_cdtable_ste(&s1_ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
-	arm_smmu_test_make_s2_ste(&s2_ste, true);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
+	arm_smmu_test_make_s2_ste(&s2_ste, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s1_ste, &s2_ste,
 						       NUM_EXPECTED_SYNCS(3));
 }
@@ -358,8 +373,8 @@ static void arm_smmu_v3_write_ste_test_s2_to_s1(struct kunit *test)
 	struct arm_smmu_ste s2_ste;
 
 	arm_smmu_test_make_cdtable_ste(&s1_ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
-	arm_smmu_test_make_s2_ste(&s2_ste, true);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
+	arm_smmu_test_make_s2_ste(&s2_ste, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s2_ste, &s1_ste,
 						       NUM_EXPECTED_SYNCS(3));
 }
@@ -375,9 +390,9 @@ static void arm_smmu_v3_write_ste_test_non_hitless(struct kunit *test)
 	 * s1 dss field in the same update.
 	 */
 	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
-				       fake_cdtab_dma_addr);
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_test_make_cdtable_ste(&ste_2, STRTAB_STE_1_S1DSS_BYPASS,
-				       0x4B4B4b4B4B);
+				       0x4B4B4b4B4B, ARM_SMMU_MASTER_TEST_ATS);
 	arm_smmu_v3_test_ste_expect_non_hitless_transition(
 		test, &ste, &ste_2, NUM_EXPECTED_SYNCS(3));
 }
@@ -503,6 +518,30 @@ static void arm_smmu_test_make_sva_release_cd(struct arm_smmu_cd *cd,
 	arm_smmu_make_sva_cd(cd, &master, NULL, asid);
 }
 
+static void arm_smmu_v3_write_ste_test_s1_to_s2_stall(struct kunit *test)
+{
+	struct arm_smmu_ste s1_ste;
+	struct arm_smmu_ste s2_ste;
+
+	arm_smmu_test_make_cdtable_ste(&s1_ste, STRTAB_STE_1_S1DSS_SSID0,
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_STALL);
+	arm_smmu_test_make_s2_ste(&s2_ste, ARM_SMMU_MASTER_TEST_STALL);
+	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s1_ste, &s2_ste,
+						       NUM_EXPECTED_SYNCS(3));
+}
+
+static void arm_smmu_v3_write_ste_test_s2_to_s1_stall(struct kunit *test)
+{
+	struct arm_smmu_ste s1_ste;
+	struct arm_smmu_ste s2_ste;
+
+	arm_smmu_test_make_cdtable_ste(&s1_ste, STRTAB_STE_1_S1DSS_SSID0,
+				       fake_cdtab_dma_addr, ARM_SMMU_MASTER_TEST_STALL);
+	arm_smmu_test_make_s2_ste(&s2_ste, ARM_SMMU_MASTER_TEST_STALL);
+	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s2_ste, &s1_ste,
+						       NUM_EXPECTED_SYNCS(3));
+}
+
 static void arm_smmu_v3_write_cd_test_sva_clear(struct kunit *test)
 {
 	struct arm_smmu_cd cd = {};
@@ -547,6 +586,8 @@ static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_non_hitless),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_s1_clear),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_s1_change_asid),
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_s1_to_s2_stall),
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_s2_to_s1_stall),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_clear),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_release),
 	{},
-- 
2.46.0.469.g59c65b2a67-goog

