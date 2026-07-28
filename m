Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A753A8722
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260061; cv=fail; b=ZGYC6nNx0izb1ttZjewOZ+swnksOlKQZpHnRzXatZ7PrDhaF/dV6/zZeJbSAw372X3r+eNpOIl8BrSllSOssaZoIjqS/uzMWWPh1IGa5Xy3LiDcjjMlCXgCwbPgihD6qccdCNJfwvM9RpMwKaS5G1CvFqrBAUIWsFb2/oA4BxN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260061; c=relaxed/simple;
	bh=5bqvKcdqOVQ7lSxk+PYJ2X/sEwyynLA7NRphAV67JUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DA3LltlIcAdJMKrb0WhbodertpcnXsDnhSuy52IJZREeXk1fWROh1moZKrpKb6As1HTGlVxQlEEON7lTyYtgm6EVdy/xIowUwYauyuNzg56hveyZNxgLBLdIqD0daqg6g2zxII2k69KEC82PEm9GwHrQSb2gczrdYfu3NhBelnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t+a5lFwv; arc=fail smtp.client-ip=52.101.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t+a5lFwv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeW+CkzMa6QNkebMvZbNWfZUzJ8D0w96vT7Pdzu8I800MHe+fMzd4ltFHr/NhKX8w3VayKop55/ov7xrJyCp/B6hYrdtvGRTzSZlnLXxzpvbXb8sdS+EATVWh1PHk2pydlxAMmIAsXlpjtCznc0jHUChyvDlllEBL9cNn3xMEnzPYEu4Oja9OEPFTv8BmSfqxo66L00HcPQHchfou9gl4F3H2pd8DNXPUzAwWri9MinJ5VyF0fKW8LFeqw58jxf7ihqfLJYoI4xKCqjqomfkqIgSg7hmkpr1F0BcreJ6cLrQcIRjSaOIZqi1+7qIn2LzmycxdPykDdhsr1E/YakY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFc6RbhYeyF7VyJNadtfnjW8hgDGs+YrFTnaS6O/F+I=;
 b=M6llRSgQds/erl/iTDceXOj5DqtnJ0bzUD90nKTM9qtPJYEkX2vK5CkblOMTUakWzl4LvqXgW9PldAYjFhX9KzvxzXfcSY5CR2ufmBvU3KZC2eF1/rH8UaWTklGYMLjifq+Pj19nFlL9iAlMBoj7Cj3eTkoupHzQyzP1EHMEHJHg6S5KmnO31388GGFubGyZyGceeediOvSAGztIuxKKrK7eLd45mbnzJDTAgW3yrXYNP1Pwu7KECJ0xzVV519HVKHETyqkoXCCTWga2vFJZC1/teMFtwQ1kpE6tqWI8+kEQBFUP7WO6fIcyylnzc7Uf7Frz1qi1f5aWbdyW4A4EDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFc6RbhYeyF7VyJNadtfnjW8hgDGs+YrFTnaS6O/F+I=;
 b=t+a5lFwv3h4LlgL+83iam2wLiq3jM8zGY4IKZ3hm2hj5XVMcK5PIeJL+qXDoi0/YphAf8sEg28LE5bQr2XwCXiVX/AKtMPWT2OBglb86VgNHlQMtybZsT8fbmLDTVJm1w66lmY0dfLcgxk59Fetnphd1vWQvnh93JYv/7+gwoNkbTuE2nAg0aNTH69gz/lV/8qKmg5+yjowIk6S5Y5AiAZfSFVDExqDlqXJRt3iYAnVA8UR1EELnHnrcT3SzGiVjiXNOf6YqxMq70oicbRIYHLBGPxsf4SZ4ooRKKLgJzbGBNYXIvOFakj5obTXcbh123Ut8OGLd5wGrcyE2BifFZQ==
Received: from DM6PR04CA0013.namprd04.prod.outlook.com (2603:10b6:5:334::18)
 by SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 17:34:10 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::5e) by DM6PR04CA0013.outlook.office365.com
 (2603:10b6:5:334::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 17:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 17:34:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 28 Jul
 2026 10:33:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Jul
 2026 10:33:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Jul 2026 10:33:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Pranjal Shrivastava
	<praan@google.com>
Subject: [PATCH v5 2/6] iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation commands
Date: Tue, 28 Jul 2026 10:33:34 -0700
Message-ID: <d5a55fc73e81ade8e86cbdc993815553fdde2dfe.1785258826.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785258826.git.nicolinc@nvidia.com>
References: <cover.1785258826.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1283f2-94e9-4ea0-38f2-08deecce6ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|82310400026|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	VaodCw0DUb4paGC40Ch3UpLWp/E4+Ie2xHY6MmogqhMUqNAj2g/QG9r4H3d5V9xJZgGCumyXhBtF1Znq8EIyJ2tFqK6SKusdf5Y3exrMOJuborBXlRqtQ9hXebOziEZqav9LC0+7L+ZudNKpRnuhUSmK+zU5EKiOrkiE4/Yy5QEcfDR6v65pJky/4BRgDgrPVsMZKm80emGAUSxXAWYrF7VFJ9dp8i6YLgwTmhsvZYpsNyBG2Rv4mm9eyzWvCFNR/LKGTjyf7KgehPmpB+fqSoX1NoT+KAJ4xIpmGME4wwx6+IE6QgLhtWIdMna48agXT6TZWA9XubIpt27aKMS3MoPtK8YqW/a3EB60mJUVAX+v8lhvAlOZrdvIR9hQbtzPeVQu4sly/6huGdulLpkP7OR0HqzdkCqEsMP9f0oZ+E46Cy8gmqRvSwpjpZKxXNgGpOvqPcbEbvcZKCM4L8a6OlUzVkUg3QqTuKzVhf++JE/S+iAewiN8ANjAWgmfdi1zvd8yltTPfqVZBo+y4/Z3CoCat/GiH1t7ffagTwNOVmOuqVNnLRhnrCWH94BBWXDB7SI/graM7mFqYVL+yqvzNfO69VkeBkjDzWiPD9y8s0OsQ6YQ4/PQ2ueq75wCt9h2Y3z1lJKTaBIwkIRPfh4MfIIDW5U1G5FO9z5ZBrGqhMr7CA3lM+GQViYBa1j0uqvUJTriIcQLiouy4eD2QDyUzQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mObVY573Qos161ZdIDiQKKCJbefQJJUi8B4vMKKqIFEuIQA3Dsg67M0cPyWVHspvcOnGPX7weGEduCHVRJyvqg3Y1xbVBJjiHmOasXELXFJQOa5BXknizoEUZBgXHwhrGWIjV/w2ILdI6nQu0md/iCSXUW5Fz0dQsIqWrg9+MjSTzFDFMV9o+g82ZH/DDOFC5uKPlg0Tq5ktCHUhl+N7Pnt6FTl8sKmbuNfKrbN+NF9BY5UUbwB8A1s1spK19KjMrdAQQwLBr3JM6PALYlIYPq3lkc7io7DvNUVzngVHJzF72hIulVsPQ1o1xbA4RUxz+yyZ/AvI4SXxt7RtySGpD8NQKWegG3LogZH1JWIKqfrar3Nw8jlvRouAxDkpqOcwcYv7UhK8ziUNA+1TVgMLdXBTogW9uKTyoS8/R13ApvpqBTeLkz+d+db7KUywzbg5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 17:34:09.7127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1283f2-94e9-4ea0-38f2-08deecce6ebe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808

The arm_vsmmu_cache_invalidate() op hands a guest's invalidation commands
to the trusted main command queue after enforcing only the VMID or the SID,
and passes the rest of the command through to the queue unchanged.

That lets a guest set bits the host never meant to forward: a reserved or
undefined bit makes a command malformed; per the Arm SMMUv3 specification,
in its section 4.1.3 "Command errors", a CERROR_ILL is raised, among other
cases, when:

  A valid command opcode is used and a Reserved or undefined field is
  optionally detected as non-zero, which results in the command being
  treated as malformed.

Restrict each opcode to the fields that the driver supports and reject the
command with -EIO if it sets any other bit, before the command reaches the
queue. This stops the host from forwarding any bit whose meaning it does
not control. Document this contract in the uAPI header, so user space must
take the responsibility to forward valid commands only.

Some fields and whole opcodes are legal only on an SMMU that implements
the matching feature, so accept them conditionally:

 - NUM, SCALE, TG and TTL need FEAT_RANGE_INV.
 - SCALE bit 25, for values above 31, and TTL == 0b01 with a 16KB TG
   need SMMU_IDR5.DS, gated on ARM_SMMU_FEAT_DS so that a VMM exposing
   DS from the reported IDR5 register keeps working.
 - ASID is limited to asid_bits, since its upper 8 bits are RES0 on an
   SMMU that only supports 8-bit ASIDs.
 - ATC_INV needs FEAT_ATS. Per the specification's section 4.5 "ATS and
   PRI", CMD_ATC_INV is ILLEGAL when:

     SMMU_IDR0.ATS == 0 and this command is issued on a Non-secure or
     Secure Command queue.

 - SSV, SSID and Global need a non-zero ssid_bits. Without it, setting
   them is not illegal but CONSTRAINED UNPREDICTABLE, which a guest
   should not be able to provoke. Global also takes effect only when
   SSV == 1, broadening the invalidation from the one SSID to all the
   PASIDs of the single device that the SID field addresses.

Some values inside the accepted fields are Reserved too:

 - NUM == 0, SCALE == 0 and TTL == 0 together are a Reserved combination
   and cause a CERROR_ILL.
 - NUM, SCALE and TTL turn RES0 when TG == 0.
 - An ATC_INV Size above 52, the invalidate-all span, is permitted to
   raise a CERROR_ILL.

Reject these Reserved values the same way. In contrast, an out-of-range
address or ID value is defined as CONSTRAINED UNPREDICTABLE that would
be scoped to the guest itself, so it does not deserve a check.

Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h                  |   4 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 129 ++++++++++++++++--
 2 files changed, 121 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c6851c7655c66..a45fecbd7c774 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -920,7 +920,9 @@ struct iommu_hwpt_vtd_s1_invalidate {
  *     CMDQ_OP_CFGI_CD
  *     CMDQ_OP_CFGI_CD_ALL
  *
- * -EIO will be returned if the command is not supported.
+ * User space must forward only valid commands: the kernel rejects, with
+ * -EIO, any command carrying an unsupported opcode, an unsupported field,
+ * or a field value that the underlying SMMU hardware does not implement.
  */
 struct iommu_viommu_arm_smmuv3_invalidate {
 	__aligned_le64 cmd[2];
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 76333091ec158..c76573c65f80f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -308,6 +308,106 @@ struct arm_vsmmu_invalidation_cmd {
 	};
 };
 
+/* Reject the range field values that the spec defines as Reserved */
+static int arm_vsmmu_validate_range(struct arm_smmu_device *smmu, u64 data[2])
+{
+	bool range = !!(data[0] & (CMDQ_TLBI_0_NUM | CMDQ_TLBI_0_SCALE));
+	u8 ttl = FIELD_GET(CMDQ_TLBI_1_TTL, data[1]);
+	u8 tg = FIELD_GET(CMDQ_TLBI_1_TG, data[1]);
+
+	/* NUM, SCALE and TTL are RES0 when TG == 0 */
+	if (!tg)
+		return (range || ttl) ? -EIO : 0;
+	/* TTL == 0b01 with a 16KB TG requires SMMU_IDR5.DS */
+	if (tg == 2 && ttl == 1 && !(smmu->features & ARM_SMMU_FEAT_DS))
+		return -EIO;
+	/* NUM == 0, SCALE == 0 with TTL == 0 is a reserved combination */
+	if (!range && !ttl)
+		return -EIO;
+	return 0;
+}
+
+static int arm_vsmmu_validate_user_cmd(struct arm_vsmmu *vsmmu, u64 data[2])
+{
+	struct arm_smmu_device *smmu = vsmmu->smmu;
+	u64 allowed[2] = { CMDQ_0_OP };
+
+	/* Collect the fields userspace is allowed to set for each opcode */
+	switch (data[0] & CMDQ_0_OP) {
+	case CMDQ_OP_TLBI_NSNH_ALL:
+		break;
+	case CMDQ_OP_TLBI_NH_VA:
+		/* An SMMU with 8-bit ASIDs treats the upper 8 bits as RES0 */
+		allowed[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID,
+					 GENMASK(smmu->asid_bits - 1, 0));
+		fallthrough;
+	case CMDQ_OP_TLBI_NH_VAA:
+		/* NUM/SCALE/TG/TTL are range fields gated on FEAT_RANGE_INV */
+		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
+			if (arm_vsmmu_validate_range(smmu, data))
+				return -EIO;
+			allowed[0] |= CMDQ_TLBI_0_NUM | CMDQ_TLBI_0_SCALE;
+			allowed[1] |= CMDQ_TLBI_1_TG | CMDQ_TLBI_1_TTL;
+			/* SCALE bit 25 (values above 31) is RES0 without DS */
+			if (!(smmu->features & ARM_SMMU_FEAT_DS))
+				allowed[0] &= ~FIELD_PREP(CMDQ_TLBI_0_SCALE,
+							  BIT(5));
+		}
+		allowed[0] |= CMDQ_TLBI_0_VMID;
+		allowed[1] |= CMDQ_TLBI_1_LEAF | CMDQ_TLBI_1_VA_MASK;
+		break;
+	case CMDQ_OP_TLBI_NH_ASID:
+		/* An SMMU with 8-bit ASIDs treats the upper 8 bits as RES0 */
+		allowed[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID,
+					 GENMASK(smmu->asid_bits - 1, 0));
+		fallthrough;
+	case CMDQ_OP_TLBI_NH_ALL:
+		allowed[0] |= CMDQ_TLBI_0_VMID;
+		break;
+	case CMDQ_OP_ATC_INV:
+		/* ATC_INV is illegal unless the SMMU implements ATS */
+		if (!(smmu->features & ARM_SMMU_FEAT_ATS))
+			return -EIO;
+		/* A Size above 52 (invalidate-all) may raise a CERROR_ILL */
+		if (FIELD_GET(CMDQ_ATC_1_SIZE, data[1]) > ATC_INV_SIZE_ALL)
+			return -EIO;
+		/*
+		 * SSV/SSID/Global need substream support. SSID and Global are
+		 * IGNORED (not RES0) when SSV == 0, so they need no SSV check.
+		 */
+		if (smmu->ssid_bits)
+			allowed[0] |= CMDQ_0_SSV | CMDQ_ATC_0_SSID |
+				      CMDQ_ATC_0_GLOBAL;
+		allowed[0] |= CMDQ_ATC_0_SID;
+		allowed[1] |= CMDQ_ATC_1_SIZE | CMDQ_ATC_1_ADDR_MASK;
+		break;
+	case CMDQ_OP_CFGI_CD:
+		/* No SSV for CFGI_CD; SSID requires substream support */
+		if (smmu->ssid_bits)
+			allowed[0] |= CMDQ_CFGI_0_SSID;
+		allowed[1] |= CMDQ_CFGI_1_LEAF;
+		fallthrough;
+	case CMDQ_OP_CFGI_CD_ALL:
+		allowed[0] |= CMDQ_CFGI_0_SID;
+		break;
+	default:
+		return -EIO;
+	}
+
+	/*
+	 * Reject any other bit, e.g. a RES0 bit or a Secure bit, before the
+	 * command reaches the trusted main cmdq, so a guest cannot wedge the
+	 * shared queue for every device with a CERROR_ILL.
+	 *
+	 * By contrast, an out-of-range address or ID value does not need a
+	 * check: the spec defines it as CONSTRAINED UNPREDICTABLE, which is
+	 * scoped to the guest itself and does not raise a CERROR_ILL.
+	 */
+	if ((data[0] & ~allowed[0]) || (data[1] & ~allowed[1]))
+		return -EIO;
+	return 0;
+}
+
 /*
  * Convert, in place, the raw invalidation command into an internal format that
  * can be passed to arm_smmu_cmdq_issue_cmdlist(). Internally commands are
@@ -318,33 +418,40 @@ struct arm_vsmmu_invalidation_cmd {
 static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
 				      struct arm_vsmmu_invalidation_cmd *cmd)
 {
+	u64 *data = cmd->cmd.data;
+	int ret;
+
 	/* Commands are le64 stored in u64 */
-	cmd->cmd.data[0] = le64_to_cpu(cmd->ucmd.cmd[0]);
-	cmd->cmd.data[1] = le64_to_cpu(cmd->ucmd.cmd[1]);
+	data[0] = le64_to_cpu(cmd->ucmd.cmd[0]);
+	data[1] = le64_to_cpu(cmd->ucmd.cmd[1]);
+
+	ret = arm_vsmmu_validate_user_cmd(vsmmu, data);
+	if (ret)
+		return ret;
 
-	switch (cmd->cmd.data[0] & CMDQ_0_OP) {
+	switch (data[0] & CMDQ_0_OP) {
 	case CMDQ_OP_TLBI_NSNH_ALL:
 		/* Convert to NH_ALL */
-		cmd->cmd.data[0] = CMDQ_OP_TLBI_NH_ALL |
-			      FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
-		cmd->cmd.data[1] = 0;
+		data[0] = CMDQ_OP_TLBI_NH_ALL |
+			  FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
+		data[1] = 0;
 		break;
 	case CMDQ_OP_TLBI_NH_VA:
 	case CMDQ_OP_TLBI_NH_VAA:
 	case CMDQ_OP_TLBI_NH_ALL:
 	case CMDQ_OP_TLBI_NH_ASID:
-		cmd->cmd.data[0] &= ~CMDQ_TLBI_0_VMID;
-		cmd->cmd.data[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
+		data[0] &= ~CMDQ_TLBI_0_VMID;
+		data[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, vsmmu->vmid);
 		break;
 	case CMDQ_OP_ATC_INV:
 	case CMDQ_OP_CFGI_CD:
 	case CMDQ_OP_CFGI_CD_ALL: {
-		u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, cmd->cmd.data[0]);
+		u32 sid, vsid = FIELD_GET(CMDQ_CFGI_0_SID, data[0]);
 
 		if (arm_vsmmu_vsid_to_sid(vsmmu, vsid, &sid))
 			return -EIO;
-		cmd->cmd.data[0] &= ~CMDQ_CFGI_0_SID;
-		cmd->cmd.data[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, sid);
+		data[0] &= ~CMDQ_CFGI_0_SID;
+		data[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, sid);
 		break;
 	}
 	default:
-- 
2.43.0

