Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579EA374E66
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539902; cv=fail; b=MOC4UpXwp+xUIOV9UNocMmcqKsL6wdroGuaNfPKffUxeonGBu04Ur6OkCrfCm3iKnwgheIf9vyYKI4K/EXgL+tL254TAlQPXO+hDtgie8CDQt4rcvBzy6z75FYzLxGEnH01QYYrRlHwtKVg1mAEFZodJDoVmoC+LvDILkCXOvPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539902; c=relaxed/simple;
	bh=big4yeN3tRIi/bwUWTwcJmX8SK3K/3LMXWf/7/rAPos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwTHHlIjDsTzaB/SK7X3OXUu/7JkwNWg3jMuj+ooGqEtUMGd8uZpuk65XBA9kN2eM/twCBbGJRDHF8o2iwBrk8luUrEmn8oxeDUjavG+JR77K+D958yOWr8b8VmhVme+6Vb1yWAPC8HlruS9RCwfIKeKe+mS47aLmzZLt/i+wyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WRsU5JCa; arc=fail smtp.client-ip=52.101.56.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WRsU5JCa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJwZujN5MgAeQaIbeIYU+lh5m+JBxeg+CfID4vS9qTtnxIsLIFHCdVxsLl/qUOCspsCEhnB7qckiUAqTGWeJulKvqOb3t6miMmFbdP2iAGvOnXbSlxMySoI8f1qXavYEzCWUs09k90fIlSOLSLU+FXU3XQX8gkbcqNqFxVNgxfteiXVO3EGjCI0N6URP0RsjYrwI/TJi8CJpcI919Us6/s+z0RdbsEeQT5wu0kLpqMOEHFYdSSK37nPcaUoZO06dYoNYgLklvbrmx0pjyXSFqSYzCUVM5E0WpW79zES7EJns0jb0pNXJakU08i2OyKtEz17tCKU/TuLGV1asaymPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2JQkiNXOv8g1wVvgQE/9lvQJ8a+sIlFA4W6wTm/wqk=;
 b=Tjp8E8J1fa3CgGVRddN6ZeowKBiVweuVPq0x5S7bhXvH+XgmvKnbGCNB/qRmsyWxFPNYbN9VWGb/GOtQxnK6v2DhNkDEIpeOP8RyUd8jERNajhaLxfqeFLOibCQkUz+SedsKXd0fMWPgkM8J5297xcaFHv+qewUkHPdZ1kZ8tWw3c94dVGcqyChE5sGkzUalxopFRRjT+raC5SlLAN8Js5+Yt92doircL2ip7iZnYVIXSGZ/9o+/FGrN8Npbxknr65jWitXCeD00QULwk34rZ79e9YN5a26T7UjeacJL2YI6N2TYO2V6RoWE3ct5yz+oS9jeuHHmBRKXQcJAQ9Johw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2JQkiNXOv8g1wVvgQE/9lvQJ8a+sIlFA4W6wTm/wqk=;
 b=WRsU5JCatNy+82ahsm28+ebG42u8uPKkShIO6j/Sefk5xnqdTZdDA5N2J6W7L9g/y74ZIoKig0M+0bfZB5IH6ahWMQW5YgRS+dWOkCSYmHE+MEGiyBWOmda9mPERcu67q1g7vzNQXSpj+SqZUVfkWcxRfC45DkrBn2Cb/wdmXL1SdXB1zfDVNS7+F6lCVYNqx9N6GtH0zK4Bq5C3rl3LcOUYk6u2WmvW/Qqqq1uQdFHJqgWxas9vCJuxRHb60lbGiaydgxGVjyJc6eTUuHGszopNb3Gvb5LZCyMRObNcoqp0aZ/Zw7q17w6nRY9Nf8WiCjEVHZiu57ibpnqkSKxcGg==
Received: from SJ0PR13CA0231.namprd13.prod.outlook.com (2603:10b6:a03:2c1::26)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 19:44:50 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::67) by SJ0PR13CA0231.outlook.office365.com
 (2603:10b6:a03:2c1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 19:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 19:44:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Jul
 2026 12:44:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Jul 2026 12:44:38 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Jul 2026 12:44:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/5] iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation commands
Date: Wed, 8 Jul 2026 12:44:16 -0700
Message-ID: <194fec44b30b7b4233d218686cd76d63208932ff.1783539724.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783539724.git.nicolinc@nvidia.com>
References: <cover.1783539724.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 95dc810b-362c-4e7a-7812-08dedd295fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|3023799007|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dU8RozKN3zfIhMlgblzLAAt764nxqJuXIKGiRQ5dZ+kRFpfS0/fX/pE0EjgYM5EQ1JRyy7uzdIJ50ksxjZEQ7BxUpZklI0PIAXWR4TKPswn3S/5gOpUUXzHfFqJ+8kWaDtIqdGVD/HyM7XjPnXzOYfmgVAEpIJhHSLU/hX9p25pz0BWBKlCRyt8QRxHeUPkyOs8r8iuEfeZ8Qvirsds09S3QKxcaCjM1MZ5jQMGG7pkhYM1+nWER5B0w9KxLuFOqYWzojorhMlOCh5bxD8QSXCkSvmxCSd7Qi/6Us8YoELdjfW6e0KodKwCAMzn8jd1RUW9OBCAm/7LLSHhFEEjKhBHnUcWqYlbAi1o+6kNP98Gv3t1omOIOLbi4rWoAOi4TcgWN/mSLLuSdxL4+gLpxd1Qw8B6r7GgmwvFhClDTcBYN0cNTtwESbvu70BvGRbLCoPga1+2YHw/1unjG39kOptncjLyUWuKtVjJm2z3U0aTZOqccbig9ot3xJioAIT4YNCuMYUlvNb6A0QWR9hNZvz/A6pGwkvNT5VOQA9dr0zl5Nv7EX9ckYhfcUjORmH+rXKI+SgJM6zIIaj6TQNNy05t5VprrVakVdgafl+fOzLwLO0lNEgJ+Ii8E0MhWoAhqyjhU2Lptu9TQfE3RxtpLI2MAkNcBN9hF6BqStq9ol3f+Dw6CMiUSIvpGHjK/A3vuzNg/ZRk78iW8czXcSGPSQw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(3023799007)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CpwzAcDdXg9zDbewRxRvka0VWhmr6O9Yk8ZYs6Yrpjn6MXi4zhytbmb2Mt2C96JMVPlKjbvFqxgi5UAH48Pg3cHYCGQ6wYCUuwe5VuCK89rIv6MBi8pibrlTtMcFe44Zea1vX9e9JsAfelGVR7pos/yTXElo3QVM8PkfBCMPhhRX2hClrRUnscpK16nJ3b1qmHIeaES7RuaMZaVBN0+3XGxIwDhM1ZKIq53BH8QhTqPcb80CPtGG2p2QyPZMDjWWZRVBYpNprmr3mNocEtR3MfVuEjh9QOiG6iSrGq9heDuu/tS0i/Wc6+2Nh3ZVTD9IuB272bGGfOtAj4mfBr4sGpo5djKGnDjmtpnAlCzCJRqC+wAn4RelQ4q3FZwRTgS5Curcm6LBHo/shKKVC6ny5lM/mrrAdnLMMI/g+yATUph77/TU/Zuhn8KwiYnfHF+4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:44:50.3825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dc810b-362c-4e7a-7812-08dedd295fcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

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
   need SMMU_IDR5.DS. The raw IDR5 that iommufd reports has let a VMM
   expose DS to its guest all along, so add the minimal ARM_SMMU_FEAT_DS
   detection and gate the two encodings on it, rather than regress such
   a VMM by rejecting them unconditionally. Widening the SCALE field
   does not change what the host emits in the range invalidation path,
   which now masks its scale value explicitly to keep the pre-existing
   5-bit truncation.
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   4 +-
 include/uapi/linux/iommufd.h                  |   4 +-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 116 ++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   6 +-
 4 files changed, 116 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c909c9a88538b..3c59e62978a13 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -64,6 +64,7 @@ struct arm_vsmmu;
 
 #define ARM_SMMU_IDR5			0x14
 #define IDR5_STALL_MAX			GENMASK(31, 16)
+#define IDR5_DS				(1 << 7)
 #define IDR5_GRAN64K			(1 << 6)
 #define IDR5_GRAN16K			(1 << 5)
 #define IDR5_GRAN4K			(1 << 4)
@@ -415,7 +416,7 @@ struct arm_smmu_cmd {
 
 #define CMDQ_TLBI_0_NUM			GENMASK_ULL(16, 12)
 #define CMDQ_TLBI_RANGE_NUM_MAX		31
-#define CMDQ_TLBI_0_SCALE		GENMASK_ULL(24, 20)
+#define CMDQ_TLBI_0_SCALE		GENMASK_ULL(25, 20)
 #define CMDQ_TLBI_0_VMID		GENMASK_ULL(47, 32)
 #define CMDQ_TLBI_0_ASID		GENMASK_ULL(63, 48)
 #define CMDQ_TLBI_1_LEAF		(1UL << 0)
@@ -921,6 +922,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_HD		(1 << 22)
 #define ARM_SMMU_FEAT_S2FWB		(1 << 23)
 #define ARM_SMMU_FEAT_BBML2		(1 << 24)
+#define ARM_SMMU_FEAT_DS		(1 << 25)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
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
index 1e9f7d2de3441..a5cfbc2499034 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -305,6 +305,26 @@ struct arm_vsmmu_invalidation_cmd {
 	};
 };
 
+/* Reject the range field values that the spec defines as Reserved */
+static int arm_vsmmu_validate_range(struct arm_smmu_device *smmu,
+				    struct arm_vsmmu_invalidation_cmd *cmd)
+{
+	bool range = cmd->cmd.data[0] & (CMDQ_TLBI_0_NUM | CMDQ_TLBI_0_SCALE);
+	u8 ttl = FIELD_GET(CMDQ_TLBI_1_TTL, cmd->cmd.data[1]);
+	u8 tg = FIELD_GET(CMDQ_TLBI_1_TG, cmd->cmd.data[1]);
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
 /*
  * Convert, in place, the raw invalidation command into an internal format that
  * can be passed to arm_smmu_cmdq_issue_cmdlist(). Internally commands are
@@ -315,33 +335,107 @@ struct arm_vsmmu_invalidation_cmd {
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
+			if (arm_vsmmu_validate_range(smmu, cmd))
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
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4f..9f121f9f404ea 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2446,9 +2446,10 @@ static void arm_smmu_cmdq_batch_add_range(struct arm_smmu_device *smmu,
 			/* Determine how many chunks of 2^scale size we have */
 			num = (num_pages >> scale) & CMDQ_TLBI_RANGE_NUM_MAX;
 
+			/* Keep the pre-DS 5-bit truncation when scale > 31 */
 			cmd->data[0] = orig_data0 |
 				FIELD_PREP(CMDQ_TLBI_0_NUM, num - 1) |
-				FIELD_PREP(CMDQ_TLBI_0_SCALE, scale);
+				FIELD_PREP(CMDQ_TLBI_0_SCALE, scale & 0x1f);
 
 			/* range is num * 2^scale * pgsize */
 			inv_range = num << (scale + tg);
@@ -5098,6 +5099,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	/* Maximum number of outstanding stalls */
 	smmu->evtq.max_stalls = FIELD_GET(IDR5_STALL_MAX, reg);
 
+	if (reg & IDR5_DS)
+		smmu->features |= ARM_SMMU_FEAT_DS;
+
 	/* Page sizes */
 	if (reg & IDR5_GRAN64K)
 		smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
-- 
2.43.0

