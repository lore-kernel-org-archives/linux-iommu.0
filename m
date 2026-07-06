Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC67371885
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363661; cv=fail; b=HWX2H62GihmdhWz5JsMi3E2/KK1gOiqHw/r/MmmnDgcD6tWCDkWD/wcC51Vyqf6x1RoVkQ7KhfWeb0PK584H36BtY1FEBw2Y6Fx+VaM0yYEScSKo3MpuZeBgTixSzBbl1UZ0PP3anRoezpB3yCsMP40ZVDOeNwd96+olAnIpKBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363661; c=relaxed/simple;
	bh=wzWY/WO/VCS6J2LudGYkoDMu9ngbi58k8jIsO2m8f84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxmRhhZku1eXvgoz0IP6+YL/DwDMh7CMdR+brwvb5eQNALcPjavKz+LiFcHCzqFE31nzX78YHH9QgH+4PIJPY+l3o8Jdm/IhXppNB9CLftVN9Y3TnCc8dLMWS2Tcj1P/pXnd3cMJUQurSMwaPQ1Sg3dAswNdKIaZWPIpsCmUbOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pSh9XYKu; arc=fail smtp.client-ip=52.101.57.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pSh9XYKu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/gsmceBw6BVLjLMzwJhWBXfdwHHGFq0qdKfM1nLWlpUO+UqTX97l1nhl1Dl5A0Jvm1nI9s9iuDQnXx+mEYgzrLKN3tEA651KxBGDNfHLdXWljwsGHq+diL6Ii21H2qUGRvuuzdarMdl0LNF4TE0EmZFpmg04vlEUcbH3rIoJQYjVgHbdxkZE75ubwEUGuuZPYo2wSkmKnQ2Mg3o5euo09d2TyNsxo+9316K1JO7NdhZllbdKlMcZViqGSPwAzzKz/ASxBKQPxyi6iI0aDPpoXCBmv10W1VxbM2CWkhz694Bt26KrLG0r5/FHadyEWHqdPdusdtfXEPMSol2zFRC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dD1MD5NJ6Sr/Gwjbuo8gvHXtSBme3Wk6K6PMmfvvRw=;
 b=cX3YdhzhKUM8Ke/XtEC/BDVZ8TEtMW9oLGiyNOhK+FhoZlmN+42znXm37Xm/RbHqVuz3+6r4IqPQ/xZJhP0IfU20ccDb65Nv0lRYj9mHjWN5i3vKatpWvbvASCf41SrhaaCYZGrtYmKJxI4r4goYxWVQzpnmTrb5ffD2G6xACI3gGjFF23ZwM4vTqoXrbYFNFSgoz/cEF16Eg+6e8yC42xRQtiBDkJ2ltaC9YAErTZKoNIYVRmE/jwkWVNpaLwpU74c6EkYY+xp6sSmuYbGHQ5pYfZ0K+S17JznhoXNkUfBLEa67e/QfqbyRgMOqbJuFPiN0D7vj7OhwsvSTb8eO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dD1MD5NJ6Sr/Gwjbuo8gvHXtSBme3Wk6K6PMmfvvRw=;
 b=pSh9XYKuk7Bxl7mN8kTJGpZDCzi9dt5tsk13KJk7RP028pCJ8Af92lm7MlKqMUZkUJ9DUFB8XZBibSuCeWFs7dYFhyafHJGCzE3tN5hMg0nOz8gymCe6ncIIbbe/g+ZDDPW3jcTv1XTh/1pj3wfWBq4kbVHgiWVTqbdCeJjVULG+l6A0uS+iZ2X2HY/b9kHg9Vs4K9T/lweeJnWKtuSrTCv3stpRfblD2lX3CfkScIpFqkyHduLpXhqCk7zM7tMxXDXaQEuJIn2mrW1Bk0h+zUG/OENJXSAscgHZrQzwmgcvZy1HqGioeqw/20mAc0381q2SJXfgT5hxxcuWQTmAiA==
Received: from DS1P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::14) by
 MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Mon, 6 Jul 2026
 18:47:25 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:455:cafe::9f) by DS1P220CA0001.outlook.office365.com
 (2603:10b6:8:455::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 18:47:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 6 Jul
 2026 11:47:10 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Jul 2026 11:47:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Jul 2026 11:47:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/5] iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation commands
Date: Mon, 6 Jul 2026 11:46:51 -0700
Message-ID: <9b80861d509e9544715e2f011324cd83e719f915.1783363477.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783363477.git.nicolinc@nvidia.com>
References: <cover.1783363477.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: f84ea01c-6506-4622-a3bd-08dedb8f0516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|11063799006|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	INEf4W/g3wJ78kLSDpHiqxRVFpac1vuiEHT2u4CnpQSNCam1A0asxkQeCbIfyyI8WCR+E1g6g5J1mITfOB/flaZaxsqCXmmhnDM28SkXHY3MfG6svmNkoaSYpbQQaT5C8KEoZgkeJYJhRa0qY2xaGzIQPLHzaJYiKcdr6pbuztz/wMg3HKQel23D+S2faDHUnvEtBAFj/a9KLeMuZ3jhoaVh8ARJthxh5h7Ol+nD+4BDpQGMgQdAIFzDImLB0/gFTzRoQ7PfprjszhELfOVTma+OKz+bjRFmzTHOOUHzCH8C44paNqoErfUK2qCTh171yvFQDC5GvMqUS6nRWKHp2FOFyD4Q4Aj4Pz8DqkP2/PVHoeC/kQIz5iIFksHX0xbdSurb8A0FCTa/O/YjWXPgaZbWiABFQJ9T0GfbGmGqNiQNe9bz+1jY6b46YptHn/WDO34Pcy9LeKF+WBT2WL3zyBkMDOJtLV6YoVrLROTHANAhlYefSDYKrnw7TrDHfU5gVoqLNfkdlKu0XBDgP8SXVD00iVjYfhLQR6g3sEFzjX3yWmf+CxdqtiqrmrTOCweCUNPPaLEJP5a0kaheWQYhuQQy2HWY/FGhCY53PyFC6oPFFNYUAJXuOGO9hL+fM4QTNZgumKSANFFEbHYYB3ixLkThrNjISkbSLVZE4kXkEl5YnXktD2HmEaEyP203JiIT82agOgePodcBRhllLPYLYg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MlirJ5Emqiju4pF0vDAT7djB7Wxwh1RUsaf/6JTN2NeEROW0HpVb7m5USXWiLFQhL2Owflk8tW6Bk+9IPxUmV5C3foPTjfylPP0Mq3rOwt4HhTfc+VnmS0DnHv82er+8TCAGUR5b5ROJn1I20bIToHcRYQRZ04lZKcRJDYNmb1/1tavygDImpf657IX382FwDLcGigCOIk75+u/by2Q+VLWkRV3Owo+nS/F6gZYseLvbL/LqmzKGv5z02WmSy5XTZZFnGSDZ2zJf1SUaxNHP66DAQ2mauyLVFGN3Yo/ymXT4wcFpy+65vPCPZ+/w75iSwZOR6RDU+VwitOiIZb8GWnO5zw3fJ++DhKxHiIWC2c5lCTrtZf9W3sEJWJ2qLHneKbqQBW6RSQd2MLVdaLByLXVw0KZXHMBcjtkOlvNIPw9UbO2qsi2E6vETi6yKY2Hw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:47:24.3945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f84ea01c-6506-4622-a3bd-08dedb8f0516
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643

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
 - TTL == 0b01 with a 16KB TG is Reserved without SMMU_IDR5.DS, which
   the driver does not support.
 - NUM, SCALE and TTL turn RES0 when TG == 0.
 - An ATC_INV Size above 52, the invalidate-all span, is permitted to
   raise a CERROR_ILL.

Reject these Reserved values the same way. In contrast, an out-of-range
address or ID value is defined as CONSTRAINED UNPREDICTABLE that is
scoped to the guest itself, so it does not deserve a check.

Fixes: d68beb276ba2 ("iommu/arm-smmu-v3: Support IOMMU_HWPT_INVALIDATE using a VIOMMU object")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h                  |   4 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 111 ++++++++++++++++--
 2 files changed, 103 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0425d452d41ed..691b810ca574f 100644
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
index 1e9f7d2de3441..ee68a13025cab 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -305,6 +305,25 @@ struct arm_vsmmu_invalidation_cmd {
 	};
 };
 
+/* Reject the range field values that the spec defines as Reserved */
+static int arm_vsmmu_validate_range(struct arm_vsmmu_invalidation_cmd *cmd)
+{
+	bool range = cmd->cmd.data[0] & (CMDQ_TLBI_0_NUM | CMDQ_TLBI_0_SCALE);
+	u8 ttl = FIELD_GET(CMDQ_TLBI_1_TTL, cmd->cmd.data[1]);
+	u8 tg = FIELD_GET(CMDQ_TLBI_1_TG, cmd->cmd.data[1]);
+
+	/* NUM, SCALE and TTL are RES0 when TG == 0 */
+	if (!tg)
+		return (range || ttl) ? -EIO : 0;
+	/* TTL == 0b01 with a 16KB TG requires SMMU_IDR5.DS, unsupported */
+	if (tg == 2 && ttl == 1)
+		return -EIO;
+	/* NUM == 0, SCALE == 0 with TTL == 0 is a reserved combination */
+	if (!range && !ttl)
+		return -EIO;
+	return 0;
+}
+
 /*
  * Convert, in place, the raw invalidation command into an internal format that
  * can be passed to arm_smmu_cmdq_issue_cmdlist(). Internally commands are
@@ -315,33 +334,103 @@ struct arm_vsmmu_invalidation_cmd {
 static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
 				      struct arm_vsmmu_invalidation_cmd *cmd)
 {
+	struct arm_smmu_device *smmu = vsmmu->smmu;
+	u64 allowed[2] = { CMDQ_0_OP };
+	u64 *data = cmd->cmd.data;
+
 	/* Commands are le64 stored in u64 */
-	cmd->cmd.data[0] = le64_to_cpu(cmd->ucmd.cmd[0]);
-	cmd->cmd.data[1] = le64_to_cpu(cmd->ucmd.cmd[1]);
+	data[0] = le64_to_cpu(cmd->ucmd.cmd[0]);
+	data[1] = le64_to_cpu(cmd->ucmd.cmd[1]);
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
+			if (arm_vsmmu_validate_range(cmd))
+				return -EIO;
+			allowed[0] |= CMDQ_TLBI_0_NUM | CMDQ_TLBI_0_SCALE;
+			allowed[1] |= CMDQ_TLBI_1_TG | CMDQ_TLBI_1_TTL;
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

