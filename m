Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2315026B
	for <iommu@lists.linux.dev>; Mon, 25 Dec 2023 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQcUQCy0"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-427b515c2bbso535271cf.0
        for <iommu@lists.linux.dev>; Mon, 25 Dec 2023 04:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703509087; x=1704113887; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5pB9sG2YVahrJBm+52H/7Y6+9CGJtHH+HQy1aNMVrE=;
        b=dQcUQCy00TPllo2m+0pp1ltySDGaTuU9G2U1Wi2ysZWv2xffz+afdkiBCi0AYXLkk1
         YvwcA46Ee+lzBKOtPXtkKXasfIiTJn/cyFx1ZQQdTi5TaRmQq+0TyqsXeDMe2XdH/XqR
         xZcFNZXGGPujO1A3cW2Bor5OGZZJIoiT5Zs+sDTjA/buDEh0N1Eem2+fxcoAORXaQd/0
         Aqj5L2ce3WTlzie7DV8qpJsRsFXOCisdYM+dcyR3xzz1JrVFiavafvr7BF/Z5k4FP8Fg
         ns5rcvtjn3gVulziioyo3ERwdYTqiyIW4jIIpeVFmCiWhDDNwkKrbSwTGnGU327I9rp0
         7lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703509087; x=1704113887;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5pB9sG2YVahrJBm+52H/7Y6+9CGJtHH+HQy1aNMVrE=;
        b=uVV+ZSiNMeLSr3Ji2g3dCSJ+EAwd9vpZ5o7bCaiwZ4Oakti1VVWw2PSa3vIvn2kFWX
         9OeKLnTMCeAWjcfzxLK1989ebXB/ixaoHzClDX7zeMkh4GfT4QVMRzIkmDBnWfA9gDWF
         pnCJtYOSTNgq8CNjLE4wPeXEL7sG6YZo++eLi7wzZCVhoyib0mZcvnh3Kuc9FTjJ+QCh
         b9eTymHY+PLTwKPxy7c0tssjlo4Ad4myJItqbmag/1ScAaESzxB7zYjL1yw4BgS0bjwJ
         /cHOaCsyI8iirUhZFO3VMnQ2cgJV2YY/obXTHI1WcPBLGjWWbhPeFeseIvEzXdBh9HUX
         MSTg==
X-Gm-Message-State: AOJu0YycNSvvaYVHNbzqzOC6FCY2vQFgWSkU4q5khslFGlGl1RoTNJJ6
	ZXBEvifsjh6Gq9IF2tim1nPuAripVytSHIB/XKp4qlQ0YIwJ
X-Google-Smtp-Source: AGHT+IG1upy3u+ppZ5JcEEtnjt2MNG9ANpyJPHAMvln/aMs08aFXCMA1VcpWDEiMlhBoJHMpwXy1OBIk/+sczK4IIAA=
X-Received: by 2002:a05:622a:2c9:b0:425:7fb2:aa10 with SMTP id
 a9-20020a05622a02c900b004257fb2aa10mr431234qtx.5.1703509087255; Mon, 25 Dec
 2023 04:58:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: by 2002:a05:6214:d4f:b0:67f:2bf8:28a6 with HTTP; Mon, 25 Dec 2023
 04:58:06 -0800 (PST)
In-Reply-To: <CAKHBV24ApTjc3hy-kbMD9Y7wVdb5OPTb8bU6AkZdCQPg+LWDSg@mail.gmail.com>
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com> <CAKHBV24UGZuG6+J4cybadJCTyf9hN+e_VgAC0NVOPotmEur7SQ@mail.gmail.com>
 <20231012121616.GF3952@nvidia.com> <CAKHBV27G1PLZ5gkYkOOCZdD9waZOZypkWqk4_HSR4XXGFT-+LA@mail.gmail.com>
 <20231018130455.GU3952@nvidia.com> <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
 <20231020113918.GD3952@nvidia.com> <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com> <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
 <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com> <CAKHBV24ApTjc3hy-kbMD9Y7wVdb5OPTb8bU6AkZdCQPg+LWDSg@mail.gmail.com>
From: Michael Shavit <mshavit@google.com>
Date: Mon, 25 Dec 2023 20:58:06 +0800
Message-ID: <CAKHBV26kVYoXP-vNtQMhv3fBDYSmSCG5AU8eyU=D6fWUV1BCBQ@mail.gmail.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming independent
 of the callers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Ok I'm probably getting ahead of myself here, but on an nth re-read to
sanity check things I realized that this is pretty well suited to
unit-testing. In fact that's how I caught the bug that this last email
fixed.

(Sorry for duplicate email Jason, first email was accidentally off-list).

---
From 8b71430fd55a40203d600b29da93b413af4349ee Mon Sep 17 00:00:00 2001
From: Michael Shavit <mshavit@google.com>
Date: Fri, 22 Dec 2023 16:54:12 +0800
Subject: [PATCH] iommu/arm-smmu-v3: Add unit tests for arm_smmu_write_entry

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
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 344 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  41 +--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  38 +-
 5 files changed, 400 insertions(+), 34 deletions(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 7673bb82945b6..e4c4071115c8e 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -405,6 +405,15 @@ config ARM_SMMU_V3_SVA
          Say Y here if your system supports SVA extensions such as PCIe PASID
          and PRI.

+config ARM_SMMU_V3_KUNIT_TEST
+       tristate "KUnit tests for arm-smmu-v3 driver"  if !KUNIT_ALL_TESTS
+       depends on ARM_SMMU_V3 && KUNIT
+       default KUNIT_ALL_TESTS
+       help
+         Enable this option to unit-test arm-smmu-v3 driver functions.
+
+         If unsure, say N.
+
 config S390_IOMMU
        def_bool y if S390 && PCI
        depends on S390 && PCI
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile
b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 54feb1ecccad8..014a997753a8a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -3,3 +3,5 @@ obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
 arm_smmu_v3-objs-y += arm-smmu-v3.o
 arm_smmu_v3-objs-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
 arm_smmu_v3-objs := $(arm_smmu_v3-objs-y)
+
+obj-$(CONFIG_ARM_SMMU_V3_KUNIT_TEST) += arm-smmu-v3-test.o
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
new file mode 100644
index 0000000000000..2e59e157bf528
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+
+#include "arm-smmu-v3.h"
+
+struct arm_smmu_test_writer {
+       struct arm_smmu_entry_writer writer;
+       struct kunit *test;
+       __le64 *(*get_used_bits)(struct arm_smmu_test_writer *test_writer,
+                                const __le64 *entry);
+
+       const __le64 *init_entry;
+       const __le64 *target_entry;
+       __le64 *entry;
+
+       bool invalid_entry_written;
+       int num_syncs;
+};
+
+static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
+                                               const __le64 *used_bits,
+                                               const __le64 *target,
+                                               unsigned int length)
+{
+       bool differs = false;
+       int i;
+
+       for (i = 0; i < length; i++) {
+               if ((entry[i] & used_bits[i]) != target[i])
+                       differs = true;
+       }
+       return differs;
+}
+
+static void
+arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
+{
+       struct arm_smmu_test_writer *test_writer =
+               container_of(writer, struct arm_smmu_test_writer, writer);
+       __le64 *entry_used_bits;
+
+       pr_debug("STE value is now set to: ");
+       print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8,
+                            test_writer->entry,
+                            writer->entry_length * sizeof(*test_writer->entry),
+                            false);
+
+       test_writer->num_syncs += 1;
+       if (!(test_writer->entry[0] & writer->v_bit))
+               test_writer->invalid_entry_written = true;
+       else {
+               /*
+                * At any stage in a hitless transition, the entry must be
+                * equivalent to either the initial entry or the target entry
+                * when only considering the bits used by the current
+                * configuration.
+                */
+               entry_used_bits = test_writer->get_used_bits(
+                       test_writer, test_writer->entry);
+               KUNIT_EXPECT_FALSE(test_writer->test,
+                                  arm_smmu_entry_differs_in_used_bits(
+                                          test_writer->entry, entry_used_bits,
+                                          test_writer->init_entry,
+                                          writer->entry_length) &&
+                                          arm_smmu_entry_differs_in_used_bits(
+                                                  test_writer->entry,
+                                                  entry_used_bits,
+                                                  test_writer->target_entry,
+                                                  writer->entry_length));
+       }
+}
+
+static __le64 *
+arm_smmu_test_ste_writer_get_used_bits(struct arm_smmu_test_writer
*test_writer,
+                                      const __le64 *entry)
+{
+       struct arm_smmu_ste *used_bits = kunit_kzalloc(
+               test_writer->test, sizeof(*used_bits), GFP_KERNEL);
+
+       arm_smmu_get_ste_used(entry, used_bits);
+       return used_bits->data;
+}
+
+static void
+arm_smmu_v3_test_ste_debug_print_used_bits(const struct arm_smmu_ste *ste)
+{
+       struct arm_smmu_ste used_bits = { 0 };
+
+       arm_smmu_get_ste_used(ste->data, &used_bits);
+       pr_debug("STE used bits: ");
+       print_hex_dump_debug(
+               "    ", DUMP_PREFIX_NONE, 16, 8, used_bits.data,
+               ARRAY_SIZE(used_bits.data) * sizeof(*used_bits.data), false);
+}
+
+static void arm_smmu_v3_test_ste_expect_transition(
+       struct kunit *test, const struct arm_smmu_ste *cur,
+       const struct arm_smmu_ste *target, int num_syncs_expected, bool hitless)
+{
+       struct arm_smmu_ste cur_copy;
+       struct arm_smmu_ste preallocated_staging_ste = { 0 };
+       struct arm_smmu_entry_writer_ops arm_smmu_test_writer_ops = {
+               .sync_entry = arm_smmu_test_writer_record_syncs,
+               .set_unused_bits = arm_smmu_ste_set_unused_bits,
+               .get_used_qword_diff_indexes =
+                       arm_smmu_ste_used_qword_diff_indexes,
+       };
+       struct arm_smmu_test_writer test_writer = {
+               .writer = {
+                       .ops = arm_smmu_test_writer_ops,
+                       .v_bit = cpu_to_le64(STRTAB_STE_0_V),
+                       .entry_length = ARRAY_SIZE(cur_copy.data),
+               },
+               .get_used_bits = arm_smmu_test_ste_writer_get_used_bits,
+               .test = test,
+               .init_entry = cur->data,
+               .target_entry = target->data,
+               .entry = cur_copy.data,
+               .num_syncs = 0,
+               .invalid_entry_written = false,
+
+       };
+       memcpy(&cur_copy, cur, sizeof(cur_copy));
+
+       pr_debug("STE initial value: ");
+       print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8, cur_copy.data,
+                            ARRAY_SIZE(cur_copy.data) * sizeof(*cur_copy.data),
+                            false);
+       arm_smmu_v3_test_ste_debug_print_used_bits(cur);
+       pr_debug("STE target value: ");
+       print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8, target->data,
+                            ARRAY_SIZE(cur_copy.data) * sizeof(*cur_copy.data),
+                            false);
+       arm_smmu_v3_test_ste_debug_print_used_bits(target);
+
+       arm_smmu_write_entry(&test_writer.writer, cur_copy.data, target->data,
+                            preallocated_staging_ste.data);
+
+       KUNIT_EXPECT_EQ(test, test_writer.invalid_entry_written, !hitless);
+       KUNIT_EXPECT_EQ(test, test_writer.num_syncs, num_syncs_expected);
+       KUNIT_EXPECT_MEMEQ(test, target->data, cur_copy.data,
+                          ARRAY_SIZE(cur_copy.data));
+}
+
+static void arm_smmu_v3_test_ste_expect_non_hitless_transition(
+       struct kunit *test, const struct arm_smmu_ste *cur,
+       const struct arm_smmu_ste *target, int num_syncs_expected)
+{
+       arm_smmu_v3_test_ste_expect_transition(test, cur, target,
+                                              num_syncs_expected, false);
+}
+
+static void arm_smmu_v3_test_ste_expect_hitless_transition(
+       struct kunit *test, const struct arm_smmu_ste *cur,
+       const struct arm_smmu_ste *target, int num_syncs_expected)
+{
+       arm_smmu_v3_test_ste_expect_transition(test, cur, target,
+                                              num_syncs_expected, true);
+}
+
+static const dma_addr_t fake_cdtab_dma_addr = 0xF0F0F0F0F0F0;
+
+static void arm_smmu_test_make_cdtable_ste(struct arm_smmu_ste *ste,
+                                          unsigned int s1dss,
+                                          const dma_addr_t dma_addr)
+{
+       struct arm_smmu_master master;
+       struct arm_smmu_ctx_desc_cfg cd_table;
+       struct arm_smmu_device smmu;
+
+       cd_table.cdtab_dma = dma_addr;
+       cd_table.s1cdmax = 0xFF;
+       cd_table.s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
+       smmu.features = ARM_SMMU_FEAT_STALLS;
+       master.smmu = &smmu;
+
+       arm_smmu_make_cdtable_ste(ste, &master, &cd_table, true, s1dss);
+}
+
+struct arm_smmu_ste bypass_ste;
+struct arm_smmu_ste abort_ste;
+
+static int arm_smmu_v3_test_suite_init(struct kunit_suite *test)
+{
+       arm_smmu_make_bypass_ste(&bypass_ste);
+       arm_smmu_make_abort_ste(&abort_ste);
+
+       return 0;
+}
+
+static void arm_smmu_v3_write_ste_test_bypass_to_abort(struct kunit *test)
+{
+       /*
+        * Bypass STEs has used bits in the first two Qwords, while abort STEs
+        * only have used bits in the first QWord. Transitioning from bypass to
+        * abort requires two syncs: the first to set the first qword and make
+        * the STE into an abort, the second to clean up the second qword.
+        */
+       arm_smmu_v3_test_ste_expect_hitless_transition(
+               test, &bypass_ste, &abort_ste,
+               /*num_syncs_expected=*/2);
+}
+
+static void arm_smmu_v3_write_ste_test_abort_to_bypass(struct kunit *test)
+{
+       /*
+        * Transitioning from abort to bypass also requires two syncs: the first
+        * to set the second qword data required by the bypass STE, and the
+        * second to set the first qword and switch to bypass.
+        */
+       arm_smmu_v3_test_ste_expect_hitless_transition(
+               test, &abort_ste, &bypass_ste,
+               /*num_syncs_expected=*/2);
+}
+
+static void arm_smmu_v3_write_ste_test_cdtable_to_abort(struct kunit *test)
+{
+       struct arm_smmu_ste ste;
+
+       arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
+                                      fake_cdtab_dma_addr);
+       arm_smmu_v3_test_ste_expect_hitless_transition(
+               test, &ste, &abort_ste,
+               /*num_syncs_expected=*/2);
+}
+
+static void arm_smmu_v3_write_ste_test_abort_to_cdtable(struct kunit *test)
+{
+       struct arm_smmu_ste ste;
+
+       arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
+                                      fake_cdtab_dma_addr);
+       arm_smmu_v3_test_ste_expect_hitless_transition(
+               test, &abort_ste, &ste,
+               /*num_syncs_expected=*/2);
+}
+
+static void arm_smmu_v3_write_ste_test_cdtable_to_bypass(struct kunit *test)
+{
+       struct arm_smmu_ste ste;
+
+       arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
+                                      fake_cdtab_dma_addr);
+       arm_smmu_v3_test_ste_expect_hitless_transition(
+               test, &ste, &bypass_ste,
+               /*num_syncs_expected=*/3);
+}
+
+static void arm_smmu_v3_write_ste_test_bypass_to_cdtable(struct kunit *test)
+{
+       struct arm_smmu_ste ste;
+
+       arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
+                                      fake_cdtab_dma_addr);
+       arm_smmu_v3_test_ste_expect_hitless_transition(
+               test, &bypass_ste, &ste,
+               /*num_syncs_expected=*/3);
+}
+
+static void arm_smmu_v3_write_ste_test_cdtable_s1dss_change(struct kunit *test)
+{
+       struct arm_smmu_ste ste;
+       struct arm_smmu_ste s1dss_bypass;
+
+       arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
+                                      fake_cdtab_dma_addr);
+       arm_smmu_test_make_cdtable_ste(&s1dss_bypass, STRTAB_STE_1_S1DSS_BYPASS,
+                                      fake_cdtab_dma_addr);
+
+       /*
+        * Flipping s1dss on a CD table STE only involves changes to the second
+        * qword of an STE and can be done in a single write.
+        */
+       arm_smmu_v3_test_ste_expect_hitless_transition(
+               test, &ste, &s1dss_bypass,
+               /*num_syncs_expected=*/1);
+       arm_smmu_v3_test_ste_expect_hitless_transition(
+               test, &s1dss_bypass, &ste,
+               /*num_syncs_expected=*/1);
+}
+
+static void
+arm_smmu_v3_write_ste_test_s1dssbypass_to_stebypass(struct kunit *test)
+{
+       struct arm_smmu_ste s1dss_bypass;
+
+       arm_smmu_test_make_cdtable_ste(&s1dss_bypass, STRTAB_STE_1_S1DSS_BYPASS,
+                                      fake_cdtab_dma_addr);
+       arm_smmu_v3_test_ste_expect_hitless_transition(
+               test, &s1dss_bypass, &bypass_ste,
+               /*num_syncs_expected=*/2);
+}
+
+static void
+arm_smmu_v3_write_ste_test_stebypass_to_s1dssbypass(struct kunit *test)
+{
+       struct arm_smmu_ste s1dss_bypass;
+
+       arm_smmu_test_make_cdtable_ste(&s1dss_bypass, STRTAB_STE_1_S1DSS_BYPASS,
+                                      fake_cdtab_dma_addr);
+       arm_smmu_v3_test_ste_expect_hitless_transition(
+               test, &bypass_ste, &s1dss_bypass,
+               /*num_syncs_expected=*/2);
+}
+
+static void arm_smmu_v3_write_ste_test_non_hitless(struct kunit *test)
+{
+       struct arm_smmu_ste ste;
+       struct arm_smmu_ste ste_2;
+
+       /*
+        * Although no flow resembles this in practice, one way to force an STE
+        * update to be non-hitless is to change its CD table pointer as well as
+        * s1 dss field in the same update.
+        */
+       arm_smmu_test_make_cdtable_ste(&ste, STRTAB_STE_1_S1DSS_SSID0,
+                                      fake_cdtab_dma_addr);
+       arm_smmu_test_make_cdtable_ste(&ste_2, STRTAB_STE_1_S1DSS_BYPASS,
+                                      0x4B4B4b4B4B);
+       arm_smmu_v3_test_ste_expect_non_hitless_transition(
+               test, &ste, &ste_2,
+               /*num_syncs_expected=*/2);
+}
+
+static struct kunit_case arm_smmu_v3_test_cases[] = {
+       KUNIT_CASE(arm_smmu_v3_write_ste_test_bypass_to_abort),
+       KUNIT_CASE(arm_smmu_v3_write_ste_test_abort_to_bypass),
+       KUNIT_CASE(arm_smmu_v3_write_ste_test_cdtable_to_abort),
+       KUNIT_CASE(arm_smmu_v3_write_ste_test_abort_to_cdtable),
+       KUNIT_CASE(arm_smmu_v3_write_ste_test_cdtable_to_bypass),
+       KUNIT_CASE(arm_smmu_v3_write_ste_test_bypass_to_cdtable),
+       KUNIT_CASE(arm_smmu_v3_write_ste_test_cdtable_s1dss_change),
+       KUNIT_CASE(arm_smmu_v3_write_ste_test_s1dssbypass_to_stebypass),
+       KUNIT_CASE(arm_smmu_v3_write_ste_test_stebypass_to_s1dssbypass),
+       KUNIT_CASE(arm_smmu_v3_write_ste_test_non_hitless),
+       {},
+};
+
+static struct kunit_suite arm_smmu_v3_test_module = {
+       .name = "arm-smmu-v3-kunit-test",
+       .suite_init = arm_smmu_v3_test_suite_init,
+       .test_cases = arm_smmu_v3_test_cases,
+};
+kunit_test_suites(&arm_smmu_v3_test_module);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0accd00ed1918..ec15a8c6a0f65 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -967,31 +967,6 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device
*smmu, u16 asid)
        arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 }

-struct arm_smmu_entry_writer;
-
-/**
- * struct arm_smmu_entry_writer_ops - Helper class for writing a CD/STE entry.
- * @sync_entry: sync entry to the hardware after writing to it.
- * @set_unused_bits: Make bits of the entry that aren't in use by the hardware
- *                   equal to the target's bits.
- * @get_used_qword_diff_indexes: Compute the list of qwords in the entry that
- *                               are incorrect compared to the target,
- *                               considering only the used bits in the target.
- *                               The set bits in the return value
represents the
- *                               indexes of those qwords.
- */
-struct arm_smmu_entry_writer_ops {
-       void (*sync_entry)(struct arm_smmu_entry_writer *);
-       void (*set_unused_bits)(__le64 *entry, const __le64 *target);
-       u8 (*get_used_qword_diff_indexes)(__le64 *entry, const __le64 *target);
-};
-
-struct arm_smmu_entry_writer {
-       struct arm_smmu_entry_writer_ops ops;
-       __le64 v_bit;
-       unsigned int entry_length;
-};
-
 static void arm_smmu_entry_set_unused_bits(__le64 *entry, const __le64 *target,
                                           const __le64 *entry_used,
                                           unsigned int length)
@@ -1046,7 +1021,7 @@ static u8
arm_smmu_entry_used_qword_diff_indexes(__le64 *entry,
  * V=0 process. This relies on the IGNORED behavior described in the
  * specification
  */
-static void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer,
+void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer,
                                 __le64 *cur, const __le64 *target,
                                 __le64 *staging_entry)
 {
@@ -1466,8 +1441,8 @@ static void arm_smmu_sync_ste_for_sid(struct
arm_smmu_device *smmu, u32 sid)
  * would be nice if this was complete according to the spec, but minimally it
  * has to capture the bits this driver uses.
  */
-static void arm_smmu_get_ste_used(const __le64 *ent,
-                                 struct arm_smmu_ste *used_bits)
+void arm_smmu_get_ste_used(const __le64 *ent,
+                         struct arm_smmu_ste *used_bits)
 {
        memset(used_bits, 0, sizeof(*used_bits));

@@ -1523,7 +1498,7 @@ struct arm_smmu_ste_writer {
        u32 sid;
 };

-static void arm_smmu_ste_set_unused_bits(__le64 *entry, const __le64 *target)
+void arm_smmu_ste_set_unused_bits(__le64 *entry, const __le64 *target)
 {
        struct arm_smmu_ste entry_used;
        arm_smmu_get_ste_used(entry, &entry_used);
@@ -1532,7 +1507,7 @@ static void arm_smmu_ste_set_unused_bits(__le64
*entry, const __le64 *target)
                                       ARRAY_SIZE(entry_used.data));
 }

-static u8 arm_smmu_ste_used_qword_diff_indexes(__le64 *cur,
+u8 arm_smmu_ste_used_qword_diff_indexes(__le64 *cur,
                                               const __le64 *target)
 {
        struct arm_smmu_ste target_used;
@@ -1588,7 +1563,7 @@ static void arm_smmu_write_ste(struct
arm_smmu_device *smmu, u32 sid,
        }
 }

-static void arm_smmu_make_abort_ste(struct arm_smmu_ste *target)
+void arm_smmu_make_abort_ste(struct arm_smmu_ste *target)
 {
        memset(target, 0, sizeof(*target));
        target->data[0] = cpu_to_le64(
@@ -1596,7 +1571,7 @@ static void arm_smmu_make_abort_ste(struct
arm_smmu_ste *target)
                FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT));
 }

-static void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
+void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target)
 {
        memset(target, 0, sizeof(*target));
        target->data[0] = cpu_to_le64(
@@ -1606,7 +1581,7 @@ static void arm_smmu_make_bypass_ste(struct
arm_smmu_ste *target)
                FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING));
 }

-static void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
+void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
                                      struct arm_smmu_master *master,
                                      struct arm_smmu_ctx_desc_cfg *cd_table,
                                      bool ats_enabled, unsigned int s1dss)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 91b23437f4105..9789f18a04a59 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -752,6 +752,43 @@ struct arm_smmu_master_domain {
        u16 ssid;
 };

+struct arm_smmu_entry_writer;
+
+/**
+ * struct arm_smmu_entry_writer_ops - Helper class for writing a CD/STE entry.
+ * @sync_entry: sync entry to the hardware after writing to it.
+ * @set_unused_bits: Make bits of the entry that aren't in use by the hardware
+ *                   equal to the target's bits.
+ * @get_used_qword_diff_indexes: Compute the list of qwords in the entry that
+ *                               are incorrect compared to the target,
+ *                               considering only the used bits in the target.
+ *                               The set bits in the return value
represents the
+ *                               indexes of those qwords.
+ */
+struct arm_smmu_entry_writer_ops {
+       void (*sync_entry)(struct arm_smmu_entry_writer *writer);
+       void (*set_unused_bits)(__le64 *entry, const __le64 *target);
+       u8 (*get_used_qword_diff_indexes)(__le64 *entry, const __le64 *target);
+};
+
+struct arm_smmu_entry_writer {
+       struct arm_smmu_entry_writer_ops ops;
+       __le64 v_bit;
+       unsigned int entry_length;
+};
+
+void arm_smmu_get_ste_used(const __le64 *ent, struct arm_smmu_ste *used_bits);
+void arm_smmu_ste_set_unused_bits(__le64 *entry, const __le64 *target);
+u8 arm_smmu_ste_used_qword_diff_indexes(__le64 *cur, const __le64 *target);
+void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *cur,
+                         const __le64 *target, __le64 *staging_entry);
+void arm_smmu_make_abort_ste(struct arm_smmu_ste *target);
+void arm_smmu_make_bypass_ste(struct arm_smmu_ste *target);
+void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
+                                     struct arm_smmu_master *master,
+                                     struct arm_smmu_ctx_desc_cfg *cd_table,
+                                     bool ats_enabled, unsigned int s1dss);
+
 static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
        return container_of(dom, struct arm_smmu_domain, domain);
@@ -783,7 +820,6 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
 void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
                             struct arm_smmu_cd *cdptr,
                             const struct arm_smmu_cd *target);
-
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
                       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
                       struct arm_smmu_cd *cd);

base-commit: 5c93358344002b351615b6f8c8c526a7ae83f72d
--
2.43.0.472.g3155946c3a-goog
