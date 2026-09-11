Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7306257844;
	Fri, 11 Sep 2026 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138516; cv=none; b=abook43NUTbtx7NyOrLTIzFGGkZsEl9pB1Tmzx48RDvnL2WW6c7YeqcCTGThRyQNRpjBKaEzHxHu365b0akdAJem6ObMQB6070UJqKLuQEaGsBBDJtd8s3EvNwYtU9e11unh/GgOs981pxMwwiJJm7xAmra1QJCTAOlb5MtO5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138516; c=relaxed/simple;
	bh=lTZDgOzkzqE40uD5VkNKgRbl8vg9n7epxfMjrYyLJww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GRN808bMzOnmm8cwT4CWSVqoHnUWSWJjTPpIgLZmfzL9jGxbkEz/UdLND1XVOcl7Zmfkq+Ps21/5w7xER/J2z7sw1TEwworMM/YaBuBcuP5T3Dj0es3FPbI5yWZkY3JcQBW9dblbW6H+HrmtQK1vaxKERXK5CCn0U3oYrDjaro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HRocxQ2l; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HRocxQ2l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=pXH7Hp3fCbzqhAxYvraMNI6BEc6m+hKD+4ceSqn9JZs=; b=HRocxQ2l1fASzqojA+U2uZwand
	oSVZr24tdOL3GXcoKbf5i6BK0vGIiEIY4Dssq4kY/bNWORO2n7at8SG4p5dokZY+cBs6t1pCV3rmv
	RlI6LHgRgQjuAgt4FssCPziE8o8Juh78k3Ajwlee2EofEjpxYOc+YLC9NbUzPPXDyfannbWCg9Tii
	sHbgZh4eet6/C1dWrUHQXsqBtUf7QqM9cmik17GQo54S9B82TRu0BbUz2tg3f3c95v9ZefvNnYghX
	aFgoz0nibraXZpgCiTlMhpKjudZkAS3U4hLFBkPGOhAbwOX0uKvBD2WOToJeldvvGqg7i1GmNunjV
	5C1Fdjmg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x52eh-001MpX-2S;
	Fri, 11 Sep 2026 14:55:08 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Sep 2026 07:54:44 -0700
Subject: [PATCH 1/2] iommu/arm-smmu-v3: inherit the previous kernel's
 stream table in kdump
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-smmu_fix_aws-v1-1-75870bf9655b@debian.org>
References: <20260911-smmu_fix_aws-v1-0-75870bf9655b@debian.org>
In-Reply-To: <20260911-smmu_fix_aws-v1-0-75870bf9655b@debian.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, catalin.marinas@arm.com, 
 mark.rutland@arm.com
Cc: puranjay@kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, rmikey@meta.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=6937; i=leitao@debian.org;
 h=from:subject:message-id; bh=lTZDgOzkzqE40uD5VkNKgRbl8vg9n7epxfMjrYyLJww=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqpBZCeec56XyE2qoY3oc55Upq1EFm5sgE0QGRC
 tC06zHu+iSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqQWQgAKCRA1o5Of/Hh3
 bdubD/kBbBR76+xpEeEE5wDBGtQk+c7gyN2iKaH4gZls5jWcfbmZ/w0x75g4J70WTDrQwBQXjl9
 37DL2A3+Yv1CG3sgNymS8Axjxma23Ypfs6PC77pIeiZHDXhr1v1t5LET/M8+X0DtZEntfJDc+Dp
 PVLkPknRBGLj42TB6Glt9c/F7HnyLYvekDO6UEujbKHt6uYhQArVYN/7spZwolXvC4pv1CYYsCU
 csxQkfJ1HOoFWKjnbPPhzmey/yy+3+mOuaRYVFFZg/PUdRRcLLz0TPDc7TtcbL3Ksa4GnkcZ9xq
 RiwPWf+lvb9DsEHbiz0L97M3VQL2MNxV9mRc0gTH7bnVxaZ1g7F8Da11xditKSsnm0V/9tXRJya
 7AX3wJeisWh3eHDoyvUKdYS+++2H5yJ4xgBBiPpIyADVDSx6yJJhLOupZ7//kdOOdcDyDbWCyma
 ZBcEawC3tLNNe3hYUS5rMBYxDQe+l+AI88kyG2yVyCiD3yoAOS0CY1BwtyV2ovlR8nhh0HqgmrQ
 WC993YwMoDFhWue70zW3ho7ZjIFeL3cNHDulmLBxMnkiCsdNy6yCzCI36Lv227LG36C54MxSjRb
 NzUvzwKlUfcHw/W8tgVgxlyxtPn5VZtSVCg82Jollx7dpntuyRRKxc8ef/YS56LC1Hu9/6+DYVK
 dwnEL+6L9nNNqqQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

A crash kexec does not run device_shutdown(), so the capture kernel boots
on a machine whose devices are still running. Whatever the crashed kernel
left DMAing keeps translating through the stream table it programmed,
because that table sits in memory the capture kernel never touches.

arm_smmu_device_reset() installs a fresh stream table instead, and that
table has no entry for those StreamIDs. On an Amazon EC2 m8g.metal-24xl
the two ENA NICs have no driver in the kdump initrd, so nothing resets
them and they keep DMAing for as long as the capture kernel runs:

  [   36.192904] arm-smmu-v3 arm-smmu-v3.0.auto: SMMU currently enabled! Resetting...
  [   36.491369] arm-smmu-v3 arm-smmu-v3.0.auto: event: C_BAD_STREAMID client: (unassigned sid) sid: 0x32d00 ssid: 0x0

StreamID 0x32d00 is 0003:2d:00.0, one of those NICs. The platform reports
hardware errors to firmware first:

  GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.

so firmware answers the fault by resetting the instance, and no dump is
written.

Read the previous stream table out of STRTAB_BASE before the SMMU is
disabled and copy its L1 descriptors into the new table.

Those descriptors still point at the previous kernel's L2 tables, so
arm_smmu_init_l2_strtab() maps one when a StreamID behind it is first
used rather than allocating a replacement.

Inheriting is skipped unless the SMMU was enabled, its geometry matches
what this driver would program, and it is coherent, since the descriptors
are written with no cache maintenance.

DMA that keeps translating also keeps landing in memory the dump then
records, so a vmcore can contain buffers that changed after the crash.
Intel and AMD accept the same trade.

On its own this does not keep the inherited entries alive. The core
attaches a default domain as it probes each device, which replaces them.
The next patch holds the inherited entry until a driver maps DMA.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 98 +++++++++++++++++++++++++----
 1 file changed, 85 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122d..51a809400d56a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1998,16 +1998,42 @@ static void arm_smmu_init_initial_stes(struct arm_smmu_ste *strtab,
 	}
 }
 
+/*
+ * Inherit L1 descriptor from previous kernel
+ */
+static struct arm_smmu_strtab_l2 *
+arm_smmu_inherit_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u64 l1d;
+
+	l1d = le64_to_cpu(cfg->l2.l1tab[arm_smmu_strtab_l1_idx(sid)].l2ptr);
+	if (!FIELD_GET(STRTAB_L1_DESC_SPAN, l1d))
+		return NULL;
+
+	return devm_memremap(smmu->dev, l1d & STRTAB_L1_DESC_L2PTR_MASK,
+			     sizeof(struct arm_smmu_strtab_l2), MEMREMAP_WB);
+}
+
 static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 {
 	dma_addr_t l2ptr_dma;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 	struct arm_smmu_strtab_l2 **l2table;
+	struct arm_smmu_strtab_l2 *inherited;
 
 	l2table = &cfg->l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)];
 	if (*l2table)
 		return 0;
 
+	if (is_kdump_kernel()) {
+		inherited = arm_smmu_inherit_l2_strtab(smmu, sid);
+		if (!IS_ERR_OR_NULL(inherited)) {
+			*l2table = inherited;
+			return 0;
+		}
+	}
+
 	*l2table = dmam_alloc_coherent(smmu->dev, sizeof(**l2table),
 				       &l2ptr_dma, GFP_KERNEL);
 	if (!*l2table) {
@@ -4526,6 +4552,58 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 				       PRIQ_ENT_DWORDS, "priq");
 }
 
+static u32 arm_smmu_strtab_base_cfg(struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
+		return FIELD_PREP(STRTAB_BASE_CFG_FMT,
+				  STRTAB_BASE_CFG_FMT_2LVL) |
+		       FIELD_PREP(STRTAB_BASE_CFG_LOG2SIZE,
+				  ilog2(cfg->l2.num_l1_ents) + STRTAB_SPLIT) |
+		       FIELD_PREP(STRTAB_BASE_CFG_SPLIT, STRTAB_SPLIT);
+
+	return FIELD_PREP(STRTAB_BASE_CFG_FMT, STRTAB_BASE_CFG_FMT_LINEAR) |
+	       FIELD_PREP(STRTAB_BASE_CFG_LOG2SIZE, smmu->sid_bits);
+}
+
+static void arm_smmu_inherit_strtab(struct arm_smmu_device *smmu, u32 l1size)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	void *old;
+
+	if (!is_kdump_kernel())
+		return;
+
+	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_SMMUEN))
+		return;
+
+	/* Descriptors are written here without cache maintenance. */
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY))
+		return;
+
+	/*
+	 * Only take the table over if it has the geometry this driver is about
+	 * to program, since the descriptors are copied into a table of that
+	 * shape. Comparing against the value arm_smmu_write_strtab() would
+	 * write covers format, size and split at once.
+	 */
+	if (readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG) !=
+	    arm_smmu_strtab_base_cfg(smmu))
+		return;
+
+	old = memremap(readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE) &
+		       STRTAB_BASE_ADDR_MASK, l1size, MEMREMAP_WB);
+	if (!old) {
+		dev_warn(smmu->dev, "failed to map previous stream table\n");
+		return;
+	}
+
+	memcpy(cfg->l2.l1tab, old, l1size);
+	memunmap(old);
+	dev_info(smmu->dev, "inherited stream table from previous kernel\n");
+}
+
 static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 {
 	u32 l1size;
@@ -4556,6 +4634,8 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 	if (!cfg->l2.l2ptrs)
 		return -ENOMEM;
 
+	arm_smmu_inherit_strtab(smmu, l1size);
+
 	return 0;
 }
 
@@ -4821,24 +4901,16 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 {
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
 	dma_addr_t dma;
-	u32 reg;
 
-	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-		reg = FIELD_PREP(STRTAB_BASE_CFG_FMT,
-				 STRTAB_BASE_CFG_FMT_2LVL) |
-		      FIELD_PREP(STRTAB_BASE_CFG_LOG2SIZE,
-				 ilog2(cfg->l2.num_l1_ents) + STRTAB_SPLIT) |
-		      FIELD_PREP(STRTAB_BASE_CFG_SPLIT, STRTAB_SPLIT);
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
 		dma = cfg->l2.l1_dma;
-	} else {
-		reg = FIELD_PREP(STRTAB_BASE_CFG_FMT,
-				 STRTAB_BASE_CFG_FMT_LINEAR) |
-		      FIELD_PREP(STRTAB_BASE_CFG_LOG2SIZE, smmu->sid_bits);
+	else
 		dma = cfg->linear.ste_dma;
-	}
+
 	writeq_relaxed((dma & STRTAB_BASE_ADDR_MASK) | STRTAB_BASE_RA,
 		       smmu->base + ARM_SMMU_STRTAB_BASE);
-	writel_relaxed(reg, smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
+	writel_relaxed(arm_smmu_strtab_base_cfg(smmu),
+		       smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
 }
 
 static int arm_smmu_device_reset(struct arm_smmu_device *smmu)

-- 
2.53.0-Meta

