Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92C937F729
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271693; cv=none; b=PK9bN8KondjR8YWfnWEqAwTfv3KevgECWqd3S36HkCtTQiv/ibjCx//OCMD0qLqzjIA11/UobAwr/g+waGUNG60Lm6I2ztkjkLVuINW/fVdMN0Q8k0IzXnX8Ny1Hu45INBELhXmMjSm95HaDHJi7wUCTLRVM65SazfIl7zrmRjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271693; c=relaxed/simple;
	bh=ICj0wAtJRRduZAQNYbOQYfMiSjIGzueYliFd7ewUTXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMyl7x04tULfvoE9bj25XpuSGM11ipHbzX+G5aQK7SwF573EQ61wTde8yFUsMeRS7cX/qDTrVmQS4AQgmnAvW4mV7dHUv6lbYQA8e0z+MyLCTkqToQMs57ECntJ63xitIi2BpUJgWIq8Y2XSkgnTJ18q9w0ZIdbxyu+DrswOTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yWeqHscu; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yWeqHscu"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7PehjTQDQ015wn/ZvTb+hVcLco1J7k/Jl+s9qryKFNA=;
	b=yWeqHscuwv51B6vFdthsDV7qm+8b6jcbJbn2PgSeP+a6Y0km/fWkb+MVkxOOvBM6V4K/+wzF0
	emsmsUOYx3jaf/IwqJ3mTZwjqSFkNTs9TewoH6+DdlbFUAIbURrqGayifEmVxi/ddeNMgb0MeGN
	0jsmjV0qeSdippQOHY3Eeqg=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hZ6qb3XZ2z1prKd;
	Tue,  1 Sep 2026 21:57:15 +0800 (CST)
Received: from kwepemo500007.china.huawei.com (unknown [7.202.195.114])
	by mail.maildlp.com (Postfix) with ESMTPS id B1EDB40575;
	Tue,  1 Sep 2026 22:08:06 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500007.china.huawei.com (7.202.195.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 1 Sep 2026 22:08:05 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <ben.horgan@arm.com>, <zhangzhanpeng.jasper@bytedance.com>,
	<joro@8bytes.org>, <palmer@dabbelt.com>, <tony.luck@intel.com>,
	<reinette.chatre@intel.com>, <tomasz.jeznach@linux.dev>,
	<zengheng4@huawei.com>, <fustini@kernel.org>, <cuiyunhui@bytedance.com>,
	<wangzhou1@hisilicon.com>, <xiaqinxin@huawei.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <pjw@kernel.org>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <Dave.Martin@arm.com>,
	<james.morse@arm.com>, <babu.moger@amd.com>, <corbet@lwn.net>,
	<shuah@kernel.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<yuanzhu@bytedance.com>, <iommu@lists.linux.dev>, <linuxarm@huawei.com>,
	<baolin.wang@linux.alibaba.com>
Subject: [RFC PATCH 3/5] iommu/arm-smmu-v3: Support MPAM device DMA QoS tagging
Date: Tue, 1 Sep 2026 22:08:00 +0800
Message-ID: <20260901140802.1215508-4-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260901140802.1215508-1-xiaqinxin@huawei.com>
References: <20260901140802.1215508-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500007.china.huawei.com (7.202.195.114)

Enable tagging a master's DMA with an MPAM PARTID/PMG so resctrl can assign
a device to a resource group.

When the SMMU supports MPAM, register it with the MPAM code and let resctrl
program a device's PARTID/PMG, bounded by the hardware limits.

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 96 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 13 +++
 2 files changed, 109 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122..7b1f65c0ee6d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -11,6 +11,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/arm_mpam.h>
 #include <linux/bitops.h>
 #include <linux/crash_dump.h>
 #include <linux/delay.h>
@@ -4374,6 +4375,65 @@ static int arm_smmu_def_domain_type(struct device *dev)
 	return 0;
 }
 
+static int arm_smmu_set_dev_requestor_id(struct device *dev, u32 partid,
+					 u8 pmg)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_cmd cmd;
+	struct arm_smmu_cmdq_batch cmds;
+	struct arm_smmu_device *smmu;
+	u64 val;
+	int i;
+
+	/*
+	 * TODO: This writes the PARTID/PMG directly into the live STEs, so the
+	 * tag is lost on any later STE rewrite and can race a concurrent writer.
+	 * It should be stored on arm_smmu_master and stamped in the STE
+	 * generators via a group-mutex-holding path instead.
+	 */
+	if (!master || !master->smmu)
+		return -ENODEV;
+	smmu = master->smmu;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_MPAM))
+		return -EOPNOTSUPP;
+
+	if (partid > smmu->partid_max || pmg > smmu->pmg_max)
+		return -ERANGE;
+
+	/* Program the stream-level PARTID/PMG into every STE the master owns. */
+	arm_smmu_cmdq_batch_init_cmd(smmu, &cmds, &cmd);
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < master->num_streams; i++) {
+		u32 sid = master->streams[i].id;
+		struct arm_smmu_ste *ste = arm_smmu_get_step_for_sid(smmu, sid);
+
+		if (!ste)
+			continue;
+
+		val = le64_to_cpu(ste->data[1]);
+		val &= ~STRTAB_STE_1_S1MPAM;
+		WRITE_ONCE(ste->data[1], cpu_to_le64(val));
+
+		val = le64_to_cpu(ste->data[4]);
+		val &= ~STRTAB_STE_4_PARTID;
+		val |= FIELD_PREP(STRTAB_STE_4_PARTID, partid);
+		WRITE_ONCE(ste->data[4], cpu_to_le64(val));
+
+		val = le64_to_cpu(ste->data[5]);
+		val &= ~STRTAB_STE_5_PMG;
+		val |= FIELD_PREP(STRTAB_STE_5_PMG, pmg);
+		WRITE_ONCE(ste->data[5], cpu_to_le64(val));
+
+		cmd = arm_smmu_make_cmd_cfgi_ste(sid, true);
+		arm_smmu_cmdq_batch_add_cmd_p(smmu, &cmds, &cmd);
+	}
+
+	mutex_unlock(&smmu->streams_mutex);
+	arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	return 0;
+}
+
 static const struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
@@ -4388,6 +4448,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.page_response		= arm_smmu_page_response,
+	.set_dev_requestor_id	= arm_smmu_set_dev_requestor_id,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.get_viommu_size	= arm_smmu_get_viommu_size,
 	.viommu_init		= arm_vsmmu_init,
@@ -5046,6 +5107,36 @@ static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
 			  hw_features, fw_features);
 }
 
+static void arm_smmu_mpam_register_smmu(struct arm_smmu_device *smmu)
+{
+	u16 partid_max;
+	u8 pmg_max;
+	u32 reg;
+
+	if (!IS_ENABLED(CONFIG_ARM64_MPAM))
+		return;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_MPAM))
+		return;
+
+	reg = readl_relaxed(smmu->base + ARM_SMMU_MPAMIDR);
+	if (!reg)
+		return;
+
+	partid_max = FIELD_GET(SMMU_MPAMIDR_PARTID_MAX, reg);
+	pmg_max = FIELD_GET(SMMU_MPAMIDR_PMG_MAX, reg);
+
+	smmu->partid_max = partid_max;
+	smmu->pmg_max = pmg_max;
+
+	if (mpam_register_requestor(partid_max, pmg_max)) {
+		smmu->features &= ~ARM_SMMU_FEAT_MPAM;
+		return;
+	}
+
+	mpam_register_device_requestor();
+}
+
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
@@ -5197,6 +5288,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (FIELD_GET(IDR3_BBM, reg) == 2)
 		smmu->features |= ARM_SMMU_FEAT_BBML2;
 
+	if (FIELD_GET(IDR3_MPAM, reg))
+		smmu->features |= ARM_SMMU_FEAT_MPAM;
+
 	/* IDR5 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
 
@@ -5261,6 +5355,8 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (arm_smmu_sva_supported(smmu))
 		smmu->features |= ARM_SMMU_FEAT_SVA;
 
+	arm_smmu_mpam_register_smmu(smmu);
+
 	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
 		 smmu->oas, smmu->features);
 	return 0;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 50f8321e979c..f0118214c81c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -59,6 +59,7 @@ struct arm_vsmmu;
 #define IDR1_SIDSIZE			GENMASK(5, 0)
 
 #define ARM_SMMU_IDR3			0xc
+#define IDR3_MPAM			(1 << 7)
 #define IDR3_FWB			(1 << 8)
 #define IDR3_RIL			(1 << 10)
 #define IDR3_BBM			GENMASK(12, 11)
@@ -171,6 +172,10 @@ struct arm_vsmmu;
 #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
 
+#define ARM_SMMU_MPAMIDR		0x130
+#define SMMU_MPAMIDR_PARTID_MAX		GENMASK(15, 0)
+#define SMMU_MPAMIDR_PMG_MAX		GENMASK(23, 16)
+
 #define ARM_SMMU_REG_SZ			0xe00
 
 /* Common MSI config fields */
@@ -300,6 +305,10 @@ static inline u32 arm_smmu_strtab_l2_idx(u32 sid)
 #define STRTAB_STE_2_S2S		(1UL << 57)
 #define STRTAB_STE_2_S2R		(1UL << 58)
 
+#define STRTAB_STE_1_S1MPAM		(1UL << 26)
+#define STRTAB_STE_4_PARTID		GENMASK_ULL(31, 16)
+#define STRTAB_STE_5_PMG		GENMASK_ULL(7, 0)
+
 #define STRTAB_STE_3_S2TTB_MASK		GENMASK_ULL(51, 4)
 
 /* These bits can be controlled by userspace for STRTAB_STE_0_CFG_NESTED */
@@ -927,8 +936,12 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_BBML2		(1 << 24)
 #define ARM_SMMU_FEAT_HAFT		(1 << 25)
 #define ARM_SMMU_FEAT_DS		(1 << 26)
+#define ARM_SMMU_FEAT_MPAM		(1 << 27)
 	u32				features;
 
+	u16				partid_max;
+	u8				pmg_max;
+
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
 #define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
-- 
2.33.0

