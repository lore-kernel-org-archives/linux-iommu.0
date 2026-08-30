Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF3C21D5B0
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788128853; cv=fail; b=Lics7K1ZvyuyZfNddCfv0VjaGFAs5gjizU3HlB32u3KocGO62bqPes5IYOVDRUhCTEDtIl1vMAuBaL3LoNfjJmUPmqZc1CjELqzzojuqID6fbltxPtiXhP3hifei8IYJZycBkHe4UuIhp3cPY6lsjMpw2Wu6tK6QX1PgVmis8Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788128853; c=relaxed/simple;
	bh=c068ZnIlID8sN2Hwzf624J+HQh4WDGMzF+TC1AHUcIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeS3T0GpOurwrPLkEiYqDhcbfNeixnGve4orYdCsq86BS2urQxIqKAy/1Q8WHWqk9cC7mTjwsB6ukWhNbtBnmciQ90/C4U8Jq/m1xoCbCuf1cCcRb28g/XrI00ZKbfCm3U69gIdN/Bk8BALfoTm/+1ozdrhqVemTADa+QUmBnBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uAhsBBki; arc=fail smtp.client-ip=52.101.52.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uAhsBBki"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFyrvib7oarhJcnncwNmD0c4DxJ3IQgLJyYFgGA2Nl1DPsqzWCDmiR8UUIHiEbqJ2fYgdv5DR5wSxbWufeXSJeM/fZ8ugBSGhYwp1ev6wHL6YERLwoYqAh3kVlcyA5N7jbsoOWHwgM1Es7fq++Pjtwz7np1Jxg11ugv7ZEXC7/ETwFn/ATXqasb6p5s+DGJ1dwVv3YHN5l7sBCAAGl8stwQUeWaErr2PasY2ssXx2Wil6w5+ZKSSf+wZ9ufhnfNMWklbFLGAKTFVlIUX8yrXLi0HDvIXXDzNgKuqegJrbME5uK6lmIsVGYLOp/JJux3nX5v8vhaktrppt0bY6gLQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hAZhn1ZuCbIn9kCAF03NCUaUydT53dmAUTh5XgHi6k=;
 b=Kjax/12wTigk+fBlQmf/5zg5ubwcdLukfEEqux44OpJjpcN/28a2hpFvOoyb2GZTxuHfUCYYUr8nnICpKm4ihvdazcPNEhhhD4phW5NgHhOMsqW8N3HeAXBr5Cktg3ehlcYxW9tlSkvy4PNcDhrJfTps0QQJczBsUf0hMLQF/Y1SQ6GF6A5ygvZ5c5AQD1miwtCaSK4PCcXwZDW7a8IFWyS+i035DHdSUrXaUecANL9i906ohHVnU4sFNp5pouDyGDppK1z+vVznoVz8oV6tuCXdp509tz8HvcSY1uL3JfqiMm6Q4yNFbkN0Q5oTvHo+KfI6djYqcesi+9XOqZmQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hAZhn1ZuCbIn9kCAF03NCUaUydT53dmAUTh5XgHi6k=;
 b=uAhsBBkiV0GINJSPilseBUarqc/lqu5ZZR0TUk3ySDSUEaf+T8NSPk2cOkPqNT9PLZXVJZsWql1ncQ61dzLhuLLQ5DYHkrPD4IspjIVsvTrvLjhjOTx/0NDJ1aDlHVW4hcxEzxAcczsbxrJ7MATMe/xEKKZvEWaKfztFjA4oyWJAJSP61XeFT4HKQHMsY4BWT/kDqmrStNDYKeBoUUPdmpUO9NX4tdCeoYPjXcatUwhlZKMndDSmK14Ekjle8CsjukUOBxUVdSWRBXgQV0QW5w++w41S5IyUvFSK7MIkjopeu1E/IGnSa5r4Ojvrwy8dFeeGxEgW8cSpMdZStkZiqQ==
Received: from CH0P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::10)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 22:27:21 +0000
Received: from BN5PEPF00046988.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::9c) by CH0P221CA0028.outlook.office365.com
 (2603:10b6:610:11d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 22:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN5PEPF00046988.mail.protection.outlook.com (10.167.245.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 22:27:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 15:27:15 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 15:27:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 15:27:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Pranjal Shrivastava
	<praan@google.com>
Subject: [PATCH v6 1/5] iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation commands
Date: Sun, 30 Aug 2026 15:26:38 -0700
Message-ID: <40f4aabf98e434d6ac9f42a8d278b92200f202ca.1788127877.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788127877.git.nicolinc@nvidia.com>
References: <cover.1788127877.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN5PEPF00046988:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: e198db3f-c2cb-4e15-059e-08df06e5db7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|7416014|376014|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/td8lI+c0xSVeyOMXS0mBBOC0xUTkbR9virWpayDewbpoHyRi52hGpyukfH8SuKRRunp9JihqBOzMGRVSvcuEQVmItfAkswWI+V5MzMAd+3wydSVMmomab3f6emHVpxYJ1jz4kpUrPXk2poVfzDjk9x5CyVWAwdQGSAIOaJ0iDFUhoSYiw0WP5T4sxVHPQaf3E3BFoeDs5VXdpcC0KZ1uEiJQ099XFf6Ci0Oq+V9yQQRdUep6IFnqODCH63TFRCw2i5jsvSIMMuoXn2JwkUqjSYaFLMDR2J2f2OqJNSkTCGkknqLjVn19L3ZMhvggZL50gyXmvF8dETzchZI+ej/Qr76uoxuGICPqQ7AhsXHni3Wt7sSdmQo6PF2mMwcrTw4TG9RPPd/2uZDp0f5HEK3VdPxaG7agROY7L1Ni4H5+JCfXtxr8pc/QiO+3fg+cefV3rubst0hzlsQUXDjKEkRg333qUvrPJJ+PSgeBpAoC4oqXJ1e6X4WmVtoQJl/CaIOQBn98MbY992PvNdbDOtA5vu8f9GrH5xIvRpj80KCtVW53oR6TF0iFUg2+FPErZSaBPZ4zJQp25eKlhzix9+rJ0jOghShxJiFYazvLqhR4iL2wCoFW3Xg9yuwcyf/TM49nGdR90L5pJQKtPCtBRjoxD4DuNhJw/7cNQyIqCt33xXRLvShFw6FmBF26hzVu6aI4gd7QfXgyI5vNhXk1eFSDQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(7416014)(376014)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fipr5lsZm+41WOxJerKy0zB/qybM87KoIkKxF2a1p18NW6VATmZlkANpnSOuqqycf4bpdJseUwSK5L/6xtddzup8a3elpYhVo6xnGkmR3z96/P/51Bc3LlDKuO8xHRJ/uvcBUuImjTYVbW1Di+naPVCx+cVbUDnxQEQQHEXfOlWfDjz9hK7D5XNzdBhyobt5tcfpOtKN+d4+ro1FINV5UsXx5SJVyzA7rJJxnHpMSdjujt2h4LCLms75+Iod0ugY2Mj6/0EGDRNo9qShg7hMaCuE2vGqDedFyYaJDWRquLJhMDFfL9kC9xS5yMgj0eyvlaRCZXqgwqLGxC3NVInI6AOCTlUK+f6BAa8fN8U6whfUqh6penXa4ycWM4xAvsPRS1oCDFOz1ybzlDHZle29r0JUlFUyFo5EnGGCLGKFXx5CraDHL3rcOj092BSr+Exl
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 22:27:20.7686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e198db3f-c2cb-4e15-059e-08df06e5db7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF00046988.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156

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
index 206fa667c7828..5d47d1421c1fc 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -948,7 +948,9 @@ struct iommu_hwpt_vtd_s1_invalidate {
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
index 25982bdbcbd9a..747b9d47ff7e4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -322,6 +322,106 @@ struct arm_vsmmu_invalidation_cmd {
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
@@ -332,33 +432,40 @@ struct arm_vsmmu_invalidation_cmd {
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

