Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B44428
	for <iommu@lists.linux.dev>; Sat,  6 Jan 2024 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mshavit.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MF8qNXYH"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e73e6a17d5so5193097b3.0
        for <iommu@lists.linux.dev>; Sat, 06 Jan 2024 00:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704530190; x=1705134990; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nJwEIeCdbFbn5FhX95dhzpKGct6FNDBY5+YNRS7W7w0=;
        b=MF8qNXYHmys9+0Ij2YTbsYJ7zEQvEOomcmJs/fWHywMt2vliEVHs4h3iwuMelHdaES
         bxJM3SBCmhYjJ+Sf9i7XyfEJ7vb8bQoiEsrl957gL7j0mX9DQygNjaoEtPKKxkpGkqPu
         d/Fr6eiRlGr9MbC3OWYU+/1j1+LLlCvcBQ9AA5z0jhHoP4MStjJ/seKd2tEMB+R3u+Ck
         HPyb0DSk/q26HIXiZRPhv/9xw25o6Ba9NoYqsviCcAP+HdYVwqoJiODEpAysTP6uwQ1z
         wkxCizDgNqiBYYzoy+4yDZ0OQyxjnZsXiamJFsyffi51j1RCd5MqmtC+oPnBWo3C1PJz
         IcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704530190; x=1705134990;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJwEIeCdbFbn5FhX95dhzpKGct6FNDBY5+YNRS7W7w0=;
        b=suFLr74BIO+arfgVGHfAu162cbg979dsbQW03MN9CdjQQIlrWDr9uFJ3VSxnPc8tG8
         I6SsDUQsFiSWEELHnhMXLuiLo0tiUDhUh85ZyyDUMCDC1pJXIeu4r2KbsQmqR8hvzwLK
         SDl+9G2kOQs+AfdrOC7u1KySjZDIzV2QgpxP0vZas5Lg5AwsN4hiVnPSd3c9I5iPGfaz
         lRMAPYqem20J8EVfkSkQsR81vRSY7ENZBWdONZbdo1U3v2EhnXo01WlW+XulV1KyFv+B
         5m8uMch7IcMsD3CpA3maAWw2NwBL/qMgTHyKAy4UToklDYRFsO/wLOlGp11pSlZ9IRbm
         C5rA==
X-Gm-Message-State: AOJu0YzIkJGD1NtCeOg7MgjZWcGROEupCdbO7275wKYsOz85C/zTDQ1d
	F9n8v18V3rWSWJr0l0WzVUYlKvdFxk4RkpD7oXc=
X-Google-Smtp-Source: AGHT+IE29sg959wifB8l2iwbM+tiYJ6Yo6VZ+9zGG6aasagIY/qyBg9xDy6/ntDjM+l5Zj/QGf1oGLPe0F8K
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:356c:2731:54ab:8e9])
 (user=mshavit job=sendgmr) by 2002:a05:690c:296:b0:5f3:7dfe:5958 with SMTP id
 bf22-20020a05690c029600b005f37dfe5958mr366273ywb.8.1704530190011; Sat, 06 Jan
 2024 00:36:30 -0800 (PST)
Date: Sat,  6 Jan 2024 16:36:16 +0800
In-Reply-To: <20240106083617.1173871-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240103175043.GS50406@nvidia.com> <20240106083617.1173871-1-mshavit@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240106083617.1173871-3-mshavit@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Add unit tests for arm_smmu_write_entry
From: Michael Shavit <mshavit@google.com>
To: jgg@nvidia.com
Cc: iommu@lists.linux.dev, joro@8bytes.org, 
	linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com, will@kernel.org, 
	nicolinc@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Add tests for some of the more common STE update operations that we
expect to see, as well as some artificial STE updates to test the edges
of arm_smmu_write_entry. These also serve as a record of which common
operation is expected to be hitless, and how many syncs they require.

arm_smmu_write_entry implements a generic algorithm that updates an
STE/CD to any other abritrary STE/CD configuration. The update requires
a sequence of write+sync operations, with some invariants that must be
held true after each sync. arm_smmu_write_entry lends itself well to
unit-testing since the function's interaction with the STE/CD is already
abstracted by input callbacks that we can hook to introspect into the
sequence of operations. We can use these hooks to guarantee that
invariants are held throughout the entire update operation.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 drivers/iommu/Kconfig                         |   9 +
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   2 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 329 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   6 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   7 +-
 5 files changed, 349 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 7673bb82945b6..e4c4071115c8e 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -405,6 +405,15 @@ config ARM_SMMU_V3_SVA
 	  Say Y here if your system supports SVA extensions such as PCIe PASID
 	  and PRI.
 
+config ARM_SMMU_V3_KUNIT_TEST
+	tristate "KUnit tests for arm-smmu-v3 driver"  if !KUNIT_ALL_TESTS
+	depends on ARM_SMMU_V3 && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to unit-test arm-smmu-v3 driver functions.
+
+	  If unsure, say N.
+
 config S390_IOMMU
 	def_bool y if S390 && PCI
 	depends on S390 && PCI
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 54feb1ecccad8..014a997753a8a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -3,3 +3,5 @@ obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
 arm_smmu_v3-objs-y += arm-smmu-v3.o
 arm_smmu_v3-objs-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
 arm_smmu_v3-objs := $(arm_smmu_v3-objs-y)
+
+obj-$(CONFIG_ARM_SMMU_V3_KUNIT_TEST) += arm-smmu-v3-test.o
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
new file mode 100644
index 0000000000000..59ffcafb575fb
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+
+#include "arm-smmu-v3.h"
+
+struct arm_smmu_test_writer {
+	struct arm_smmu_entry_writer_ops ops;
+	struct kunit *test;
+	const __le64 *init_entry;
+	const __le64 *target_entry;
+	__le64 *entry;
+
+	bool invalid_entry_written;
+	int num_syncs;
+};
+
+static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
+						const __le64 *used_bits,
+						const __le64 *target,
+						unsigned int length)
+{
+	bool differs = false;
+	int i;
+
+	for (i = 0; i < length; i++) {
+		if ((entry[i] & used_bits[i]) != target[i])
+			differs = true;
+	}
+	return differs;
+}
+
+static void
+arm_smmu_test_writer_record_syncs(const struct arm_smmu_entry_writer_ops *ops)
+{
+	struct arm_smmu_test_writer *test_writer =
+		container_of(ops, struct arm_smmu_test_writer, ops);
+	__le64 *entry_used_bits;
+
+	entry_used_bits = kunit_kzalloc(
+		test_writer->test,
+		sizeof(*entry_used_bits) * ops->num_entry_qwords, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test_writer->test, entry_used_bits);
+
+	pr_debug("STE value is now set to: ");
+	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8,
+			     test_writer->entry,
+			     ops->num_entry_qwords * sizeof(*test_writer->entry),
+			     false);
+
+	test_writer->num_syncs += 1;
+	if (!(test_writer->entry[0] & ops->v_bit))
+		test_writer->invalid_entry_written = true;
+	else {
+		/*
+		 * At any stage in a hitless transition, the entry must be
+		 * equivalent to either the initial entry or the target entry
+		 * when only considering the bits used by the current
+		 * configuration.
+		 */
+		ops->get_used(ops,
+			test_writer->entry,
+			entry_used_bits);
+		KUNIT_EXPECT_FALSE(test_writer->test,
+				   arm_smmu_entry_differs_in_used_bits(
+					   test_writer->entry, entry_used_bits,
+					   test_writer->init_entry,
+					   ops->num_entry_qwords) &&
+					   arm_smmu_entry_differs_in_used_bits(
+						   test_writer->entry,
+						   entry_used_bits,
+						   test_writer->target_entry,
+						   ops->num_entry_qwords));
+	}
+}
+
+static void arm_smmu_v3_test_ste_debug_print_used_bits(
+	const struct arm_smmu_entry_writer_ops *ops,
+	const struct arm_smmu_ste *ste)
+{
+	struct arm_smmu_ste used_bits = { 0 };
+
+	arm_smmu_get_ste_used(ops, ste->data, used_bits.data);
+	pr_debug("STE used bits: ");
+	print_hex_dump_debug(
+		"    ", DUMP_PREFIX_NONE, 16, 8, used_bits.data,
+		ARRAY_SIZE(used_bits.data) * sizeof(*used_bits.data), false);
+}
+
+static void arm_smmu_v3_test_ste_expect_transition(
+	struct kunit *test, const struct arm_smmu_ste *cur,
+	const struct arm_smmu_ste *target, int num_syncs_expected, bool hitless)
+{
+	struct arm_smmu_ste cur_copy;
+	struct arm_smmu_test_writer test_writer = {
+		.ops = {
+			.v_bit = cpu_to_le64(STRTAB_STE_0_V),
+			.num_entry_qwords = ARRAY_SIZE(cur_copy.data),
+			.sync = arm_smmu_test_writer_record_syncs,
+			.get_used = arm_smmu_get_ste_used,
+		},
+		.test = test,
+		.init_entry = cur->data,
+		.target_entry = target->data,
+		.entry = cur_copy.data,
+		.num_syncs = 0,
+		.invalid_entry_written = false,
+
+	};
+	memcpy(&cur_copy, cur, sizeof(cur_copy));
+
+	pr_debug("STE initial value: ");
+	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8, cur_copy.data,
+			     ARRAY_SIZE(cur_copy.data) * sizeof(*cur_copy.data),
+			     false);
+	arm_smmu_v3_test_ste_debug_print_used_bits(&test_writer.ops, cur);
+	pr_debug("STE target value: ");
+	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8, target->data,
+			     ARRAY_SIZE(cur_copy.data) * sizeof(*cur_copy.data),
+			     false);
+	arm_smmu_v3_test_ste_debug_print_used_bits(&test_writer.ops, target);
+
+	arm_smmu_write_entry(&test_writer.ops, cur_copy.data, target->data);
+
+	KUNIT_EXPECT_EQ(test, test_writer.invalid_entry_written, !hitless);
+	KUNIT_EXPECT_EQ(test, test_writer.num_syncs, num_syncs_expected);
+	KUNIT_EXPECT_MEMEQ(test, target->data, cur_copy.data,
+			   ARRAY_SIZE(cur_copy.data));
+}
+
+static void arm_smmu_v3_test_ste_expect_non_hitless_transition(
+	struct kunit *test, const struct arm_smmu_ste *cur,
+	const struct arm_smmu_ste *target, int num_syncs_expected)
+{
+	arm_smmu_v3_test_ste_expect_transition(test, cur, target,
+					       num_syncs_expected, false);
+}
+
+static void arm_smmu_v3_test_ste_expect_hitless_transition(
+	struct kunit *test, const struct arm_smmu_ste *cur,
+	const struct arm_smmu_ste *target, int num_syncs_expected)
+{
+	arm_smmu_v3_test_ste_expect_transition(test, cur, target,
+					       num_syncs_expected, true);
+}
+
+static const dma_addr_t fake_cdtab_dma_addr = 0xF0F0F0F0F0F0;
+
+static void arm_smmu_test_make_cdtable_ste(struct arm_smmu_ste *ste,
+					   unsigned int s1dss,
+					   const dma_addr_t dma_addr)
+{
+	struct arm_smmu_master master;
+	struct arm_smmu_ctx_desc_cfg cd_table;
+	struct arm_smmu_device smmu;
+
+	cd_table.cdtab_dma = dma_addr;
+	cd_table.s1cdmax = 0xFF;
+	cd_table.s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
+	smmu.features = ARM_SMMU_FEAT_STALLS;
+	master.smmu = &smmu;
+
+	arm_smmu_make_cdtable_ste(ste, &master, &cd_table, true, s1dss);
+}
+
+struct arm_smmu_ste bypass_ste;
+struct arm_smmu_ste abort_ste;
+
+static int arm_smmu_v3_test_suite_init(struct kunit_suite *test)
+{
+	arm_smmu_make_bypass_ste(&bypass_ste);
+	arm_smmu_make_abort_ste(&abort_ste);
+
+	return 0;
+}
+
+static void arm_smmu_v3_write_ste_test_bypass_to_abort(struct kunit *test)
+{
+	/*
+	 * Bypass STEs has used bits in the first two Qwords, while abort STEs
+	 * only have used bits in the first QWord. Transitioning from bypass to
+	 * abort requires two syncs: the first to set the first qword and make
+	 * the STE into an abort, the second to clean up the second qword.
+	 */
+	arm_smmu_v3_test_ste_expect_hitless_transition(
+		test, &bypass_ste, &abort_ste,
+		/*num_syncs_expected=*/2);
+}
+
+static void arm_smmu_v3_write_ste_test_abort_to_bypass(struct kunit *test)
+{
+	/*
+	 * Transitioning from abort to bypass also requires two syncs: the first
+	 * to set the second qword data required by the bypass STE, and the
+	 * second to set the first qword and switch to bypass.
+	 */
+	arm_smmu_v3_test_ste_expect_hitless_transition(
+		test, &abort_ste, &bypass_ste,
+		/*num_syncs_expected=*/2);
+}
+
+static void arm_smmu_v3_write_ste_test_cdtable_to_abort(struct kunit *test)
+{
+	struct arm_smmu_ste ste;
+
+	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
+				       fake_cdtab_dma_addr);
+	arm_smmu_v3_test_ste_expect_hitless_transition(
+		test, &ste, &abort_ste,
+		/*num_syncs_expected=*/2);
+}
+
+static void arm_smmu_v3_write_ste_test_abort_to_cdtable(struct kunit *test)
+{
+	struct arm_smmu_ste ste;
+
+	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
+				       fake_cdtab_dma_addr);
+	arm_smmu_v3_test_ste_expect_hitless_transition(
+		test, &abort_ste, &ste,
+		/*num_syncs_expected=*/2);
+}
+
+static void arm_smmu_v3_write_ste_test_cdtable_to_bypass(struct kunit *test)
+{
+	struct arm_smmu_ste ste;
+
+	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
+				       fake_cdtab_dma_addr);
+	arm_smmu_v3_test_ste_expect_hitless_transition(
+		test, &ste, &bypass_ste,
+		/*num_syncs_expected=*/3);
+}
+
+static void arm_smmu_v3_write_ste_test_bypass_to_cdtable(struct kunit *test)
+{
+	struct arm_smmu_ste ste;
+
+	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
+				       fake_cdtab_dma_addr);
+	arm_smmu_v3_test_ste_expect_hitless_transition(
+		test, &bypass_ste, &ste,
+		/*num_syncs_expected=*/3);
+}
+
+static void arm_smmu_v3_write_ste_test_cdtable_s1dss_change(struct kunit *test)
+{
+	struct arm_smmu_ste ste;
+	struct arm_smmu_ste s1dss_bypass;
+
+	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
+				       fake_cdtab_dma_addr);
+	arm_smmu_test_make_cdtable_ste(&s1dss_bypass, STRTAB_STE_1_S1DSS_BYPASS,
+				       fake_cdtab_dma_addr);
+
+	/*
+	 * Flipping s1dss on a CD table STE only involves changes to the second
+	 * qword of an STE and can be done in a single write.
+	 */
+	arm_smmu_v3_test_ste_expect_hitless_transition(
+		test, &ste, &s1dss_bypass,
+		/*num_syncs_expected=*/1);
+	arm_smmu_v3_test_ste_expect_hitless_transition(
+		test, &s1dss_bypass, &ste,
+		/*num_syncs_expected=*/1);
+}
+
+static void
+arm_smmu_v3_write_ste_test_s1dssbypass_to_stebypass(struct kunit *test)
+{
+	struct arm_smmu_ste s1dss_bypass;
+
+	arm_smmu_test_make_cdtable_ste(&s1dss_bypass, STRTAB_STE_1_S1DSS_BYPASS,
+				       fake_cdtab_dma_addr);
+	arm_smmu_v3_test_ste_expect_hitless_transition(
+		test, &s1dss_bypass, &bypass_ste,
+		/*num_syncs_expected=*/2);
+}
+
+static void
+arm_smmu_v3_write_ste_test_stebypass_to_s1dssbypass(struct kunit *test)
+{
+	struct arm_smmu_ste s1dss_bypass;
+
+	arm_smmu_test_make_cdtable_ste(&s1dss_bypass, STRTAB_STE_1_S1DSS_BYPASS,
+				       fake_cdtab_dma_addr);
+	arm_smmu_v3_test_ste_expect_hitless_transition(
+		test, &bypass_ste, &s1dss_bypass,
+		/*num_syncs_expected=*/2);
+}
+
+static void arm_smmu_v3_write_ste_test_non_hitless(struct kunit *test)
+{
+	struct arm_smmu_ste ste;
+	struct arm_smmu_ste ste_2;
+
+	/*
+	 * Although no flow resembles this in practice, one way to force an STE
+	 * update to be non-hitless is to change its CD table pointer as well as
+	 * s1 dss field in the same update.
+	 */
+	arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
+				       fake_cdtab_dma_addr);
+	arm_smmu_test_make_cdtable_ste(&ste_2, STRTAB_STE_1_S1DSS_BYPASS,
+				       0x4B4B4b4B4B);
+	arm_smmu_v3_test_ste_expect_non_hitless_transition(
+		test, &ste, &ste_2,
+		/*num_syncs_expected=*/3);
+}
+
+static struct kunit_case arm_smmu_v3_test_cases[] = {
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_bypass_to_abort),
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_abort_to_bypass),
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_cdtable_to_abort),
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_abort_to_cdtable),
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_cdtable_to_bypass),
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_bypass_to_cdtable),
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_cdtable_s1dss_change),
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_s1dssbypass_to_stebypass),
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_stebypass_to_s1dssbypass),
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_non_hitless),
+	{},
+};
+
+static struct kunit_suite arm_smmu_v3_test_module = {
+	.name = "arm-smmu-v3-kunit-test",
+	.suite_init = arm_smmu_v3_test_suite_init,
+	.test_cases = arm_smmu_v3_test_cases,
+};
+kunit_test_suites(&arm_smmu_v3_test_module);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 065df42c86b28..e8630a317cc5e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1511,7 +1511,7 @@ static void arm_smmu_write_ste(struct arm_smmu_device *smmu, u32 sid,
 	}
 }
 
-static void arm_smmu_make_abort_ste(struct arm_smmu_ste *target)
+void arm_smmu_make_abort_ste(struct arm_smmu_ste *target)
 {
 	memset(target, 0, sizeof(*target));
 	target->data[0] = cpu_to_le64(
@@ -1519,7 +1519,7 @@ static void arm_smmu_make_abort_ste(struct arm_smmu_ste *target)
 		FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT));
 }
 
-static void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
+void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
 {
 	memset(target, 0, sizeof(*target));
 	target->data[0] = cpu_to_le64(
@@ -1529,7 +1529,7 @@ static void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
 		FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING));
 }
 
-static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
+void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 				      struct arm_smmu_master *master,
 				      struct arm_smmu_ctx_desc_cfg *cd_table,
 				      bool ats_enabled, unsigned int s1dss)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 54a6af60800d2..eddd686645040 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -766,6 +766,12 @@ void arm_smmu_get_ste_used(const struct arm_smmu_entry_writer_ops *ops,
 			   const __le64 *ent, __le64 *used_bits);
 void arm_smmu_write_entry(const struct arm_smmu_entry_writer_ops *ops,
 			  __le64 *cur, const __le64 *target);
+void arm_smmu_make_abort_ste(struct arm_smmu_ste *target);
+void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target);
+void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
+				      struct arm_smmu_master *master,
+				      struct arm_smmu_ctx_desc_cfg *cd_table,
+				      bool ats_enabled, unsigned int s1dss);
 
 static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
@@ -798,7 +804,6 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 			     struct arm_smmu_cd *cdptr,
 			     const struct arm_smmu_cd *target);
-
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
 		       struct arm_smmu_cd *cd);

base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
prerequisite-patch-id: 3bc3d332ed043fbe64543bda7c7e734e19ba46aa
prerequisite-patch-id: bb900133a10e40d3136e104b19c430442c4e2647
prerequisite-patch-id: 9ec5907dd0348b00f9341a63490bdafd99a403ca
prerequisite-patch-id: dc50ec47974c35de431b80b83b501c4ca63758a3
prerequisite-patch-id: 371b31533a5abf8e1b8dc8568ffa455d16b611c6
prerequisite-patch-id: 0000000000000000000000000000000000000000
prerequisite-patch-id: 7743327071a8d8fb04cc43887fe61432f42eb60d
prerequisite-patch-id: c74e8e54bd5391ef40e0a92f25db0822b421dd6a
prerequisite-patch-id: 3ce8237727e2ce08261352c6b492a9bcf73651c4
prerequisite-patch-id: d6342ff93ec8850ce76e45f1e22d143208bfa13c
prerequisite-patch-id: 6d2c59c2fdb9ae9e09fb042148f57b12d5058c9e
prerequisite-patch-id: f86746e1c19fba223fe2e559fc0f3ecf6fc7cc47
prerequisite-patch-id: 2d43b690a831e369547d10cf08a8e785fc4c1b69
prerequisite-patch-id: ae154d0d43beba4483f29747aecceae853657561
prerequisite-patch-id: 1ac7f3a4007a4ff64813e1a117ee6f16c28695bc
prerequisite-patch-id: ed34d0ebe0b56869508698367a26bd9e913394eb
prerequisite-patch-id: 658bad2b9692a0f959ee73e2d3798a34f16c9f11
prerequisite-patch-id: 4d83a8451a41ee3d597f1e6be1457f695b738b76
prerequisite-patch-id: d3b421dc985d58dbaaef46ec6d16b4a2764424ea
prerequisite-patch-id: ac7aab762dcd10fcc241be07503abae66f5912c8
prerequisite-patch-id: 34877d560c1c74de6e6875bdd719dafebb620732
prerequisite-patch-id: 9864c8f72ae9de7d6caf90096cf015ad0199ea7e
prerequisite-patch-id: fa730102c85dc93ce0c9e7b4128d08dc09306192
prerequisite-patch-id: 8c1a8a32e9be9b282727985a542afe4766c4afd5
prerequisite-patch-id: ac25e540981c4015261293bd5502ab39f0b6d9e6
prerequisite-patch-id: 0000000000000000000000000000000000000000
prerequisite-patch-id: 245dbf34f0d60634846534ce846baa39ff91f6dc
prerequisite-patch-id: 879c03c00f0023fcddfc8194692cd5706be4b893
prerequisite-patch-id: 6aa6a678f8c0d9ff3ce278d27342742ec352e95d
prerequisite-patch-id: ccb225b386bb12bf442a8ac9096aabc4b2c6058c
prerequisite-patch-id: b6ba55a23631a83543d6abc75a13665c8d17a8a9
prerequisite-patch-id: b93c7d0e70d2bfe18a5fe3c444e2584c4268574a
prerequisite-patch-id: 049b8b92e1d5920dd67712b54d74f58f9db21244
prerequisite-patch-id: 1d014b01b316a06e116a08d7b1395e00673c8d5c
prerequisite-patch-id: 2d066a698eedeb5b5466095056812810d27f69c9
prerequisite-patch-id: f07cf696ae2e60cb6f4cc36828c4e7680a2b1b94
prerequisite-patch-id: c2059064e48ee1c541d43d3420d79ebab1205990
prerequisite-patch-id: 96a7e4869c5c7a6786387d09a77eb30574fdd354
prerequisite-patch-id: 6fc000e0534c9850283e65443e4df0df02c6c1cd
prerequisite-patch-id: f75c57a884b38f8fc61ef3737d6c9b5639497adc
prerequisite-patch-id: a07fd1675545f66f62152ddf1761463c4c2b2e17
prerequisite-patch-id: 5f8983e3a633d4c148a36584620d9473c563946c
prerequisite-patch-id: ad462723fb76d41e1e6f66003af2265b9c2b364a
prerequisite-patch-id: 946f07ca0236544523d4349670207e10e94b39ae
prerequisite-patch-id: 5da1224014c422b3423ff959318f2777b44b9175
prerequisite-patch-id: 958ac7ea7e001daf18aa62a3bacfd3746fd54d13
prerequisite-patch-id: 2d25b818974f17416479c9138b0b27acd6918444
prerequisite-patch-id: 21bf03fe577e3c6d6b712075ad954814d8a531ac
prerequisite-patch-id: 413192b0b6adb07ba90b9104b25a60de8190656d
prerequisite-patch-id: f6deff80e594f31469d40caae9cf809436dbf057
prerequisite-patch-id: 741a67b7b3511d378615126f2020c4c8466a7596
prerequisite-patch-id: 54640c82d0f87a7ffd054edeec4ec41e0e42f33d
prerequisite-patch-id: 6d46cbd6d73441b67c594f4af7bb6b0091fb6063
-- 
2.43.0.472.g3155946c3a-goog

