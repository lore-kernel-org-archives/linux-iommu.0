Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08AB377AB6
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054997; cv=fail; b=S5UvFaWs51FJEaJa2b0BmnNXWPfvEBK69x5UnNd5BmQhaCf0q/tt85MU0QtZ6vsq/9fNOasJLlz9XAQKTt0gCayTljL/aD+Qokq1KzBF+2OyhGGL1ulE2bB9pV5yjrm+FR+UWSQQ7wqKD/t/wBuGwxbKAVmkPs08kKyKJ17Fq4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054997; c=relaxed/simple;
	bh=T7mGxgRXriK+P2Ae96alHs5k+OQJIWgRFWPmiiahHDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQdJOy//vC86k97p0kMjjDoDRC0LtCjlEuwm2bvZNvZW9l5PeNe9QJRw/xrpjO1KM+XRBbaakikusVHBI9Ij9iNpJgZCeciuJMEaE4oTPBfEf9uembm35oO5uKMvLfWgMnZh1W1sFArVAa+A4h4fP8ODIA1wW0GFTYQPuxrXhlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jM+cM5P3; arc=fail smtp.client-ip=52.101.46.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jM+cM5P3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeEgWJ8nidzwpiDBytNjoRGLyhr+1B/Rn4RjFGAn6VX3IVypFtzXlP6em3yYrPUBt4Ob58ky2XNrWx5Gjszp+bUiRJF4X3hgIJY8N1sRmc5N3MPbO9WpkEuIwi5o4pCRrGKdE68/0oj0WOkmPiFIrNGBkUHxmmCxDKMuBsKNJ5MnoXerftGkxCWfZ5x21hVh0yNjR8/5ZcdLV43jOoFAZgNYHPCtwqQCoW64hwj6l5u33KGcchva0t3dQti0Py/K4Xspjl45zvrtPtxVB6XvLmhmd1nxr43m5pzIK3ASumV7/Tl572t0ZCvSj8rEIhy1xqkML9eNf8Lt6EyBY5oorA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/ZZMDQQ1u88VuGmdO/wJo7bXpfNK1/FkBn2XGeJyyo=;
 b=KP9Fm1XpupG2jeeKib9X9vN5cFNk08NGBfzMgTT4ImLAZq/YlOps1PCrqhXr0xj3StcM/TYaWIv4GNIq+a5HYkEt8Qx1oawE6A6Hi8z93i3FgIfbNkMLcLJCBGcXt5TYac5vA1PvS1yEPa4lPtJZIuyzk2QvQDGsOE7kYb7ow7GlfPtansQ5eTJCh4dkoDoOEOVCCl/Y2CUXRjayhBvjOrIjJXQvs0g3RaM1vCskuipD/A/NWlhpJIJQkk7pPNDIyYyjHtb+n4rmnF308Ad9j76hqwrquACoVJIC1AoIJZIICYaSNcCEjfprzs1E5Pf1yy990ewpKCBBfVStaIS+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/ZZMDQQ1u88VuGmdO/wJo7bXpfNK1/FkBn2XGeJyyo=;
 b=jM+cM5P3r6oJW/AH9y0+3Txeqa+pkXGUPnhWfnU3ApYv3Hj1oAfM1nKzmoHrtM2XBwkE0WBqejVvpxQBlxaoAFynl6yNPj55UOrTfJnyTaadoe5dPJAofgXd326EHmhelxVLES6F+j8tk01mQBSb630S54IioqhkBD6Rfh6vF0XbtnsvlTlRCtCNPPKD5Tbo55v5Sq84HaI3m5KG1sn+YREivQYNHvCtIATIwAyusFzBADVaLVYjoq3+vHVFaZZe2Q2jmMuO6QkdZfIsvf06GVzTikkl5V9/16Oa5STx0jXn6pVpCdrUtPBlOo/79zqmkJjpdcX5t7+kGoO89Lc1VQ==
Received: from BL1PR13CA0193.namprd13.prod.outlook.com (2603:10b6:208:2be::18)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 18:49:44 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:2be:cafe::a1) by BL1PR13CA0193.outlook.office365.com
 (2603:10b6:208:2be::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Tue,
 14 Jul 2026 18:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Tue, 14 Jul 2026 18:49:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 11:49:17 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 11:49:17 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 11:49:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Pranjal Shrivastava <praan@google.com>
Subject: [PATCH v4 2/6] iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation commands
Date: Tue, 14 Jul 2026 11:48:48 -0700
Message-ID: <5c70a336821e3cea176356470d94ff18329ff867.1784054606.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784054606.git.nicolinc@nvidia.com>
References: <cover.1784054606.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b105e7-ddbf-4da4-4866-08dee1d8ab6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|82310400026|36860700016|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gipmp9u+Y7gLHfxnsttYXBlhZt1WDT+ZuVNqr7jnuODHPDIFonaFcDwwyzXMekCkqmyUQGVF5lsI3j3QTtKX2lJsM38yhuDaqUe5D5Mne+oPJSMkEWNiOVQW25/LCezwPb947S0UXPeap6dvhV7unlPasymZ1pMpMt+8nBFInnh6ti1nDm5iEeNKZ83dg2XtKl3npWV5z7gr53nP8EekNn3FSo7mQYbyWREWWoB5pwB1vaHgf/dfDJ58XdVdisAnFfByoXdSlZL/m1XBx90QsSCdoF0TbYjgqUotEoqHI/PmaK9DTzHntG1bZtmcK98bGwQBgE1tzV05nYYdJC1qCHqnT6fQgjVptCap3DHMpb43TyOdcy2Kard3hSeEKFavBvtwqm09n5Ul2u2BL/mcAtoWbc5TSP3u4+1x0x9Kb105v7oo7jImfnUd6pW+Uw/Yb6lfh6AGlHlHCCIFwQXHDNhWOrVV3JZa2kcOj15puZSOQuZ27HitFhvLfQ0GmTmr9c7GZJKviG6vLztQ0tj4Js2FHuMlAez4Sy/WxALQ2+aWRnKk1ho+/GH/PU0xgcYaWtbH+NkuivVRvrOXCKceFwlRL3x5/Jq0qXvG8fbETqBpVQI6dLwpvxoc9/kEX8o0Y3NcrIGtsR+tjxMu4e/L07UBAFpRxlEiPSzlNg4ST8yhyosMD3jDQuhYOXiRjeol982Bpyp7a+vFVapUh/7VGQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MrAbkCLhDPcPYjom/uVPR1O4puxUDmHCBbEdqu1cBq9cjggpe+WvfUMBHTjCs24onDlzKUkRQmcfQYsJicsIME0KRlg5Vo7T4r3oiGAzekkDrKIjEQjt3U8urvqNKNhwJijD0ZCdBGZnuTqrgGrUKZ8t3wFQrpuouIhLZL47sLOK4xXG7/9I8nxDb/iPvzYGd6kIeR/OhN8AqgXBU19t4EO6ocKxsNNCY1L3YGaD9lmF2Xc8tDYeXdZHGY3Yk+p1tE1m+fhfCvbtdlM3Qg5IPMISYRCK+OwP2movv2DJtLtVKE+FKiuDx7JQlSn5CU3oU5rFhcQsbPN/UrOR06YnVwJBum31yLqnjjMvDvfuMHBK1d/NH01mzpwB3xySVqnt0tvF9VN/fdLxksEfa6mwNRBOoYSbWzlMXD7Vl/6coZH178vjScB7XAmJ2uXphvSh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:49:43.6352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b105e7-ddbf-4da4-4866-08dee1d8ab6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453

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
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h                  |   4 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 125 ++++++++++++++++--
 2 files changed, 117 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 72bb0e47dc272..6686a121cc950 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -909,7 +909,9 @@ struct iommu_hwpt_vtd_s1_invalidate {
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
index 1e9f7d2de3441..07e502879dffc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -305,6 +305,102 @@ struct arm_vsmmu_invalidation_cmd {
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
@@ -315,33 +411,40 @@ struct arm_vsmmu_invalidation_cmd {
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

