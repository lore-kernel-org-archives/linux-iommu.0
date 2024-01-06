Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4A96109
	for <iommu@lists.linux.dev>; Sat,  6 Jan 2024 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mshavit.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="03+La5lj"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe868fdc33so363774276.0
        for <iommu@lists.linux.dev>; Sat, 06 Jan 2024 00:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704530181; x=1705134981; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQLm6DU6+ZhIxf8vzrbqa1M5Hu2F7TNZqgQaIB0rnfQ=;
        b=03+La5ljBIJP2vs4cQ9G4jRXpmvLhXx2FxkxALOSAGV+R2i7w18cyjX5UpZLlvhMap
         /Hf7Kajp1TpiBU376Rg3g5ex04XlDdFaR8+/C2xbuOKN35ce0Y1zVn3yemwO0ZWUk6Ni
         c0UzumCAp6l4hWsJ2pMLH/gR3O5kY+3tjzNX6gqfTTyJ4qJ0dCK9a1M2/v0LfESjVvw5
         qbK1KWXNzebqpcBsrNUySe6EAx3ItviFh25cPI8ywdNORm+qxfpGW596JhbVQTO368kU
         YT9sxFN2cuP/igyl0emKDoGypM3+pmSpn+KXPaS4ajADc0vS/n+TkLFMtVjgJwrDNFWi
         WwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704530181; x=1705134981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQLm6DU6+ZhIxf8vzrbqa1M5Hu2F7TNZqgQaIB0rnfQ=;
        b=Zj440ztNWj34Q3La6dYcbR8jmXrYrxLuXix0TTApB3IHlUrR8/s8brBejUq7ntyv2R
         X+qVhNPoB3n1oyR6fgHrMmlWjlWUfY7KNTN01s3lWxbUI6mFcSjrzLqByitjtuC9iGP+
         5URwp8JE73G/t8/urzEoeQNMywzgakzeWM1pEbgpFMnhVj66pEOnig6WvzJQ5OKbHDRs
         NJoGfa5dTM6zu5NHuyKfTbukRyaOz+3JzneOqKoN2W93cpplSXkzwet/PwqgXPghv1QL
         byp6ISDDJ1vE/bUR5gS1q5sfBOKqXw+MK+BTzyWFjHbPfMwxWmZivpA7r6EjT4rbfUeP
         fAmw==
X-Gm-Message-State: AOJu0YyvC7MxFkmZNzdupCFb1o4foC91+TLZVAImoA+j6tvlk7MXmtv1
	I8daNVgk5ul7e940rqS7XKR2BHMM7Y0eIJnZZaI=
X-Google-Smtp-Source: AGHT+IGRkUsXT21ISI9Iv0vi4zaUE1MBMClWCIMR4rjj8hPb8brSqxego6qEeSNca/IT44DPhXcqZv+lLrKw
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:356c:2731:54ab:8e9])
 (user=mshavit job=sendgmr) by 2002:a25:840c:0:b0:dbc:c7f0:7c2e with SMTP id
 u12-20020a25840c000000b00dbcc7f07c2emr222020ybk.2.1704530181096; Sat, 06 Jan
 2024 00:36:21 -0800 (PST)
Date: Sat,  6 Jan 2024 16:36:14 +0800
In-Reply-To: <20240103175043.GS50406@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240103175043.GS50406@nvidia.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240106083617.1173871-1-mshavit@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Make STE programming independent of the callers
From: Michael Shavit <mshavit@google.com>
To: jgg@nvidia.com
Cc: iommu@lists.linux.dev, joro@8bytes.org, 
	linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com, will@kernel.org, 
	nicolinc@nvidia.com
Content-Type: text/plain; charset="UTF-8"

From: Jason Gunthorpe <jgg@nvidia.com>

As the comment in arm_smmu_write_strtab_ent() explains, this routine has
been limited to only work correctly in certain scenarios that the caller
must ensure. Generally the caller must put the STE into ABORT or BYPASS
before attempting to program it to something else.

The next patches/series are going to start removing some of this logic
from the callers, and add more complex state combinations than currently.

Thus, consolidate all the complexity here. Callers do not have to care
about what STE transition they are doing, this function will handle
everything optimally.

Revise arm_smmu_write_strtab_ent() so it algorithmically computes the
required programming sequence to avoid creating an incoherent 'torn' STE
in the HW caches. The update algorithm follows the same design that the
driver already uses: it is safe to change bits that HW doesn't currently
use and then do a single 64 bit update, with sync's in between.

The basic idea is to express in a bitmask what bits the HW is actually
using based on the V and CFG bits. Based on that mask we know what STE
changes are safe and which are disruptive. We can count how many 64 bit
QWORDS need a disruptive update and know if a step with V=0 is required.

This gives two basic flows through the algorithm.

If only a single 64 bit quantity needs disruptive replacement:
 - Write the target value into all currently unused bits
 - Write the single 64 bit quantity
 - Zero the remaining different bits

If multiple 64 bit quantities need disruptive replacement then do:
 - Write V=0 to QWORD 0
 - Write the entire STE except QWORD 0
 - Write QWORD 0

With HW flushes at each step, that can be skipped if the STE didn't change
in that step.

At this point it generates the same sequence of updates as the current
code, except that zeroing the VMID on entry to BYPASS/ABORT will do an
extra sync (this seems to be an existing bug).

Going forward this will use a V=0 transition instead of cycling through
ABORT if a hitfull change is required. This seems more appropriate as ABORT
will fail DMAs without any logging, but dropping a DMA due to transient
V=0 is probably signaling a bug, so the C_BAD_STE is valuable.

A large part of this design is motivated by supporting the IOMMU driver
API expectations for hitless STE updates on the following sequences:

 - IDENTIY -> DMA -> IDENTITY hitless with RESV_DIRECT
 - STE -> S1DSS -> STE hitless (PASID upgrade)
 - S1 -> BLOCKING -> S1 with active PASID hitless (iommufd case)
 - NESTING -> NESTING (eg to change S1DSS, change CD table pointers, etc)
 - CD ASID change hitless (BTM S1 replacement)
 - CD quiet_cd hitless (SVA mm release)

In addition to support cases with VMs where STE transitions are quite
broad and the VM may be assuming hitless as the native HW can do.

Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Moritz Fischer <moritzf@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>

---

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 317 ++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  15 +
 2 files changed, 268 insertions(+), 64 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b120d836681c1..f663d2c11b8d0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -971,6 +971,142 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 }
 
+static bool entry_set(const struct arm_smmu_entry_writer_ops *ops,
+		      __le64 *entry, const __le64 *target, unsigned int start,
+		      unsigned int len)
+{
+	bool changed = false;
+	unsigned int i;
+
+	for (i = start; len != 0; len--, i++) {
+		if (entry[i] != target[i]) {
+			WRITE_ONCE(entry[i], target[i]);
+			changed = true;
+		}
+	}
+
+	if (changed)
+		ops->sync(ops);
+	return changed;
+}
+
+#define NUM_ENTRY_QWORDS (sizeof_field(struct arm_smmu_ste, data) / sizeof(u64))
+
+/*
+ * Figure out if we can do a hitless update of entry to become target. Returns a
+ * bit mask where 1 indicates that qword needs to be set disruptively.
+ * unused_update is an intermediate value of entry that has unused bits set to
+ * their new values.
+ */
+static u8 compute_qword_diff(const struct arm_smmu_entry_writer_ops *ops,
+			     const __le64 *entry, const __le64 *target,
+			     __le64 *unused_update)
+{
+	__le64 target_used[NUM_ENTRY_QWORDS];
+	__le64 cur_used[NUM_ENTRY_QWORDS];
+	u8 used_qword_diff = 0;
+	unsigned int i;
+
+	ops->get_used(ops, entry, cur_used);
+	ops->get_used(ops, target, target_used);
+
+	for (i = 0; i != ops->num_entry_qwords; i++) {
+		/*
+		 * Masks are up to date, the make functions are not allowed to
+		 * set a bit to 1 if the used function doesn't say it is used.
+		 */
+		WARN_ON_ONCE(target[i] & ~target_used[i]);
+
+		/* Bits can change because they are not currently being used */
+		unused_update[i] = (entry[i] & cur_used[i]) |
+				   (target[i] & ~cur_used[i]);
+		/*
+		 * Each bit indicates that a used bit in a qword needs to be
+		 * changed after unused_update is applied.
+		 */
+		if ((unused_update[i] & target_used[i]) !=
+		    (target[i] & target_used[i]))
+			used_qword_diff |= 1 << i;
+	}
+	return used_qword_diff;
+}
+
+/*
+ * Update the STE/CD to the target configuration. The transition from the current
+ * entry to the target entry takes place over multiple steps that attempts to make
+ * the transition hitless if possible. This function takes care not to create a
+ * situation where the HW can perceive a corrupted entry. HW is only required to
+ * have a 64 bit atomicity with stores from the CPU, while entries are many 64
+ * bit values big.
+ *
+ * The algorithm works by evolving the entry toward the target in a series of
+ * steps. Each step synchronizes with the HW so that the HW can not see an entry
+ * torn across two steps. During each step the HW can observe a torn entry that
+ * has any combination of the step's old/new 64 bit words. The algorithm
+ * objective is for the HW behavior to always be one of current behavior, V=0,
+ * or new behavior.
+ *
+ * In the most general case we can make any update in three steps:
+ *  - Disrupting the entry (V=0)
+ *  - Fill now unused bits, all bits except V
+ *  - Make valid (V=1), single 64 bit store
+ *
+ * However this disrupts the HW while it is happening. There are several
+ * interesting cases where a STE/CD can be updated without disturbing the HW
+ * because only a small number of bits are changing (S1DSS, CONFIG, etc) or
+ * because the used bits don't intersect. We can detect this by calculating how
+ * many 64 bit values need update after adjusting the unused bits and skip the
+ * V=0 process. This relies on the IGNORED behavior described in the
+ * specification
+ */
+void arm_smmu_write_entry(const struct arm_smmu_entry_writer_ops *ops,
+			  __le64 *entry, const __le64 *target)
+{
+	__le64 unused_update[NUM_ENTRY_QWORDS];
+	u8 used_qword_diff;
+	unsigned int critical_qword_index;
+
+	used_qword_diff = compute_qword_diff(ops, entry, target, unused_update);
+	if (hweight8(used_qword_diff) > 1) {
+		/*
+		 * At least two qwords need their used bits to be changed. This
+		 * requires a breaking update, zero the V bit, write all qwords
+		 * but 0, then set qword 0
+		 */
+		unused_update[0] = entry[0] & (~ops->v_bit);
+		entry_set(ops, entry, unused_update, 0, 1);
+		entry_set(ops, entry, target, 1, ops->num_entry_qwords - 1);
+		entry_set(ops, entry, target, 0, 1);
+	} else if (hweight8(used_qword_diff) == 1) {
+		/*
+		 * Only one qword needs its used bits to be changed. This is a
+		 * hitless update, update all bits the current STE is ignoring
+		 * to their new values, then update a single qword to change the
+		 * STE and finally 0 out any bits that are now unused in the
+		 * target configuration.
+		 */
+		critical_qword_index = ffs(used_qword_diff) - 1;
+		/*
+		 * Skip writing unused bits in the critical qword since we'll be
+		 * writing it in the next step anyways. This can save a sync
+		 * when the only change is in that qword.
+		 */
+		unused_update[critical_qword_index] = entry[critical_qword_index];
+		entry_set(ops, entry, unused_update, 0, ops->num_entry_qwords);
+		entry_set(ops, entry, target, critical_qword_index, 1);
+		entry_set(ops, entry, target, 0, ops->num_entry_qwords);
+	} else {
+		/*
+		 * If everything is working properly this shouldn't do anything
+		 * as unused bits should always be 0 and thus can't change.
+		 */
+		WARN_ON_ONCE(entry_set(ops, entry, target, 0,
+				       ops->num_entry_qwords));
+	}
+}
+
+#undef NUM_ENTRY_QWORDS
+
 static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 			     int ssid, bool leaf)
 {
@@ -1248,37 +1384,119 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 }
 
-static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
-				      struct arm_smmu_ste *dst)
+/*
+ * Based on the value of ent report which bits of the STE the HW will access. It
+ * would be nice if this was complete according to the spec, but minimally it
+ * has to capture the bits this driver uses.
+ */
+void arm_smmu_get_ste_used(const struct arm_smmu_entry_writer_ops *ops,
+			   const __le64 *ent, __le64 *used_bits)
 {
+	memset(used_bits, 0, ops->num_entry_qwords * sizeof(*used_bits));
+
+	used_bits[0] = cpu_to_le64(STRTAB_STE_0_V);
+	if (!(ent[0] & cpu_to_le64(STRTAB_STE_0_V)))
+		return;
+
 	/*
-	 * This is hideously complicated, but we only really care about
-	 * three cases at the moment:
-	 *
-	 * 1. Invalid (all zero) -> bypass/fault (init)
-	 * 2. Bypass/fault -> translation/bypass (attach)
-	 * 3. Translation/bypass -> bypass/fault (detach)
-	 *
-	 * Given that we can't update the STE atomically and the SMMU
-	 * doesn't read the thing in a defined order, that leaves us
-	 * with the following maintenance requirements:
-	 *
-	 * 1. Update Config, return (init time STEs aren't live)
-	 * 2. Write everything apart from dword 0, sync, write dword 0, sync
-	 * 3. Update Config, sync
+	 * If S1 is enabled S1DSS is valid, see 13.5 Summary of
+	 * attribute/permission configuration fields for the SHCFG behavior.
 	 */
-	u64 val = le64_to_cpu(dst->data[0]);
-	bool ste_live = false;
+	if (FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(ent[0])) & 1 &&
+	    FIELD_GET(STRTAB_STE_1_S1DSS, le64_to_cpu(ent[1])) ==
+		    STRTAB_STE_1_S1DSS_BYPASS)
+		used_bits[1] |= cpu_to_le64(STRTAB_STE_1_SHCFG);
+
+	used_bits[0] |= cpu_to_le64(STRTAB_STE_0_CFG);
+	switch (FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(ent[0]))) {
+	case STRTAB_STE_0_CFG_ABORT:
+		break;
+	case STRTAB_STE_0_CFG_BYPASS:
+		used_bits[1] |= cpu_to_le64(STRTAB_STE_1_SHCFG);
+		break;
+	case STRTAB_STE_0_CFG_S1_TRANS:
+		used_bits[0] |= cpu_to_le64(STRTAB_STE_0_S1FMT |
+					    STRTAB_STE_0_S1CTXPTR_MASK |
+					    STRTAB_STE_0_S1CDMAX);
+		used_bits[1] |=
+			cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |
+				    STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |
+				    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW);
+		used_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
+		break;
+	case STRTAB_STE_0_CFG_S2_TRANS:
+		used_bits[1] |=
+			cpu_to_le64(STRTAB_STE_1_EATS | STRTAB_STE_1_SHCFG);
+		used_bits[2] |=
+			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
+				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
+				    STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2R);
+		used_bits[3] |= cpu_to_le64(STRTAB_STE_3_S2TTB_MASK);
+		break;
+
+	default:
+		memset(used_bits, 0xFF,
+		       ops->num_entry_qwords * sizeof(*used_bits));
+		WARN_ON(true);
+	}
+}
+
+struct arm_smmu_ste_writer {
+	struct arm_smmu_entry_writer_ops ops;
+	struct arm_smmu_device *smmu;
+	u32 sid;
+};
+
+static void
+arm_smmu_ste_writer_sync_entry(const struct arm_smmu_entry_writer_ops *ops)
+{
+	struct arm_smmu_ste_writer *ste_writer =
+		container_of(ops, struct arm_smmu_ste_writer, ops);
+
+	arm_smmu_sync_ste_for_sid(ste_writer->smmu, ste_writer->sid);
+}
+
+static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops = {
+	.sync = arm_smmu_ste_writer_sync_entry,
+	.get_used = arm_smmu_get_ste_used,
+	.v_bit = cpu_to_le64(STRTAB_STE_0_V),
+	.num_entry_qwords =
+		sizeof_field(struct arm_smmu_ste, data) / sizeof(u64),
+};
+
+static void arm_smmu_write_ste(struct arm_smmu_device *smmu, u32 sid,
+			       struct arm_smmu_ste *ste,
+			       const struct arm_smmu_ste *target)
+{
+	struct arm_smmu_ste_writer ste_writer = {
+		.ops = arm_smmu_ste_writer_ops,
+		.smmu = smmu,
+		.sid = sid,
+	};
+
+	arm_smmu_write_entry(&ste_writer.ops, ste->data, target->data);
+
+	/* It's likely that we'll want to use the new STE soon */
+	if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH)) {
+		struct arm_smmu_cmdq_ent
+			prefetch_cmd = { .opcode = CMDQ_OP_PREFETCH_CFG,
+					 .prefetch = {
+						 .sid = sid,
+					 } };
+
+		arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
+	}
+}
+
+static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
+				      struct arm_smmu_ste *dst)
+{
+	u64 val;
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
 	struct arm_smmu_s2_cfg *s2_cfg = NULL;
 	struct arm_smmu_domain *smmu_domain = master->domain;
-	struct arm_smmu_cmdq_ent prefetch_cmd = {
-		.opcode		= CMDQ_OP_PREFETCH_CFG,
-		.prefetch	= {
-			.sid	= sid,
-		},
-	};
+	struct arm_smmu_ste target = {};
 
 	if (smmu_domain) {
 		switch (smmu_domain->stage) {
@@ -1293,22 +1511,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		}
 	}
 
-	if (val & STRTAB_STE_0_V) {
-		switch (FIELD_GET(STRTAB_STE_0_CFG, val)) {
-		case STRTAB_STE_0_CFG_BYPASS:
-			break;
-		case STRTAB_STE_0_CFG_S1_TRANS:
-		case STRTAB_STE_0_CFG_S2_TRANS:
-			ste_live = true;
-			break;
-		case STRTAB_STE_0_CFG_ABORT:
-			BUG_ON(!disable_bypass);
-			break;
-		default:
-			BUG(); /* STE corruption */
-		}
-	}
-
 	/* Nuke the existing STE_0 value, as we're going to rewrite it */
 	val = STRTAB_STE_0_V;
 
@@ -1319,16 +1521,11 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		else
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
 
-		dst->data[0] = cpu_to_le64(val);
-		dst->data[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
+		target.data[0] = cpu_to_le64(val);
+		target.data[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
 						STRTAB_STE_1_SHCFG_INCOMING));
-		dst->data[2] = 0; /* Nuke the VMID */
-		/*
-		 * The SMMU can perform negative caching, so we must sync
-		 * the STE regardless of whether the old value was live.
-		 */
-		if (smmu)
-			arm_smmu_sync_ste_for_sid(smmu, sid);
+		target.data[2] = 0; /* Nuke the VMID */
+		arm_smmu_write_ste(smmu, sid, dst, &target);
 		return;
 	}
 
@@ -1336,8 +1533,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		u64 strw = smmu->features & ARM_SMMU_FEAT_E2H ?
 			STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
 
-		BUG_ON(ste_live);
-		dst->data[1] = cpu_to_le64(
+		target.data[1] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
 			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
@@ -1346,7 +1542,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
 		    !master->stall_enabled)
-			dst->data[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
+			target.data[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
 		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
 			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
@@ -1355,8 +1551,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	}
 
 	if (s2_cfg) {
-		BUG_ON(ste_live);
-		dst->data[2] = cpu_to_le64(
+		target.data[2] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
 			 FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
 #ifdef __BIG_ENDIAN
@@ -1365,23 +1560,17 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			 STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 |
 			 STRTAB_STE_2_S2R);
 
-		dst->data[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
+		target.data[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
 
 		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
 	}
 
 	if (master->ats_enabled)
-		dst->data[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS,
+		target.data[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS,
 						 STRTAB_STE_1_EATS_TRANS));
 
-	arm_smmu_sync_ste_for_sid(smmu, sid);
-	/* See comment in arm_smmu_write_ctx_desc() */
-	WRITE_ONCE(dst->data[0], cpu_to_le64(val));
-	arm_smmu_sync_ste_for_sid(smmu, sid);
-
-	/* It's likely that we'll want to use the new STE soon */
-	if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH))
-		arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
+	target.data[0] = cpu_to_le64(val);
+	arm_smmu_write_ste(smmu, sid, dst, &target);
 }
 
 static void arm_smmu_init_bypass_stes(struct arm_smmu_ste *strtab,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 27ddf1acd12ce..565a38a61333c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -739,6 +739,21 @@ struct arm_smmu_domain {
 	struct list_head		mmu_notifiers;
 };
 
+/* The following are exposed for testing purposes. */
+struct arm_smmu_entry_writer_ops;
+struct arm_smmu_entry_writer_ops {
+	unsigned int num_entry_qwords;
+	__le64 v_bit;
+	void (*get_used)(const struct arm_smmu_entry_writer_ops *ops,
+			 const __le64 *entry, __le64 *used);
+	void (*sync)(const struct arm_smmu_entry_writer_ops *ops);
+};
+
+void arm_smmu_get_ste_used(const struct arm_smmu_entry_writer_ops *ops,
+			   const __le64 *ent, __le64 *used_bits);
+void arm_smmu_write_entry(const struct arm_smmu_entry_writer_ops *ops,
+			  __le64 *cur, const __le64 *target);
+
 static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct arm_smmu_domain, domain);

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
-- 
2.43.0.472.g3155946c3a-goog

