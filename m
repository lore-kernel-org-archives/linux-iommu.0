Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B5C3E717C
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773949962; cv=fail; b=hNEAcWCvp90QEy8DHlXdhfQU2umfwDkJBKqYK5jc6YvI0w82mbM2OPGuQZBjT7adcaPIAOiiETjj2Y1TpvDSU7QEcNxYevzMAnqCY55BwpF4lo0DoYubxiv1Ex8d8BhN39u+SHfXh4W7u6NBHOFtY8ermMpKBlpGlH7ULpLPoZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773949962; c=relaxed/simple;
	bh=y250Q2PYihW47gZMkwz0Yvjtdq+LV/hkt9WLpqBIRCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAyVYpqfhYtVk6gPeT3VXWIvK3YOcMfw9h6SXgd93mPMRyJNJdFGwszUtGFCXv3d5PpNCT0lvM7hCJo36CHFhxny10w+pSeyCeu9nTLPQsHirLkqT54TXPeWdoNWrA0z+bZQ9Vfu6HS2NplXLWq4LJDh4ZopEaJz6XRtEQsVgEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uh2N9T0r; arc=fail smtp.client-ip=52.101.85.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uh2N9T0r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIB1Xa22pcv8/fJryOovfs1/HHvvjrYOM15WRbozxIor3/K4tqMD7604fR6K+1dG6pqvSSoWG/n8TU8mc+SmqP61pE3sAKRF88b5at54LPnQuprWvfLCcNi1ynUYcP7wOsNcn3LhI7Vu7M5XphZyoubyAqMaAv5cFwvk5NOZ77hHZMptUvGrNb4A/VQq54wApmczRnBlCht2wuVBEwAM6HBy6ta8f9BaWIa2IT6JHNCSRxGcqCSSLF1S4DFNGFsxOaHIpga+xbs40goEmWUdKiDyanucWCmeMCNeekszPKUJYaCVUge27oss2zUuKpJGKidf3jq0UrSyPcr9rADbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BvTRjSzVVPiukmcWPQWJi7xjBPAIBOqVIiIRwRFQeQ=;
 b=QeVRlXUXph++4WbYXkcv13qo+g2sCGlX3K1DKyci2gzGxKf2TSg+zpPqAaB0/oAJ3HVl2/JE5bejYIMuTWD5vsRhLRS7Sq1qpgCyjU0My+WYfPo7p2Vkrqm8kkF322xHOfZnJNu2mFI9A2vmmipoa2HnayKFUw2ZWT2opW9NPMwmTnyFhAqGJPnO1+L0WSTjWDfnC8IXjZDHRlqAhSvattTvxVp4CclNQ+/GA7ojpmcrN4eGJFxG4dQQiNKXYgL0sZGLm5BXtPlnpIsVZHeT7Mm+R5VduwKGqaKtlNFfxX160/2NR0e+k+jOfIbk8MX6sNlgG9ttBwJQV3VIOZY85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BvTRjSzVVPiukmcWPQWJi7xjBPAIBOqVIiIRwRFQeQ=;
 b=Uh2N9T0rsLHZ1gzB3CdoX4i6JwbefmlmCZFHK6TdkUz07A5CWgb/pSUy8lx9C0zdOkRAzLjl2SMLfOz4Li6xku+bX11xdxw9zokvkIXOxOxxYYYr8PdbimHra2eY+YlgqsoGEE+/28t1Mrwq018SPjbQxiSzQURX2aMcBIeXgxIW341Fw033gAszD9ZAkw/eMr8Czg2GQzwYSs9bjaNrccTP3oxqDSXXhT7sbogooI9Zfw0PXZLf6CvmNME6rMLJxlvdgtcmV/Lm9iI9NgvH3z9Ujs+wKTNymsd2FKHzKRXt13MMdM8XNXvlc10ro78i/GbZzkJUOtAXV79ksdFORw==
Received: from DS7PR03CA0319.namprd03.prod.outlook.com (2603:10b6:8:2b::27) by
 BN7PPF9E4583E15.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6dc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 19:52:29 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:8:2b:cafe::d5) by DS7PR03CA0319.outlook.office365.com
 (2603:10b6:8:2b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Thu,
 19 Mar 2026 19:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Thu, 19 Mar 2026 19:52:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:11 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:52:10 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Mar 2026 12:52:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jpb@kernel.org>,
	<praan@google.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
Subject: [PATCH v4 06/10] iommu/arm-smmu-v3: Introduce INV_TYPE_S2_VMID_VSMMU
Date: Thu, 19 Mar 2026 12:51:52 -0700
Message-ID: <c514aa533257ce67bf28645863abf5eaab437996.1773949042.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773949042.git.nicolinc@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|BN7PPF9E4583E15:EE_
X-MS-Office365-Filtering-Correlation-Id: 121df83f-ba63-4c32-6b36-08de85f10d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|56012099003|18002099003|22082099003|3613699012;
X-Microsoft-Antispam-Message-Info:
	vkEM5kqtJ/3jXH9p1OJvlrflqOmO8gD91fukWX2FRA1VJwjrBQX33IcIDsdKKv+1Hzk62GO9ox//k0OU8RZ/aJcvD6TFFJSn4QKQq82F8aUndXXpMCay/TkiOrZ588OZk8owp8/32/FWWfrhIKraKUQkcrJD6OzkvpfgP8GObNjhnzB2ivyvs0aWKKdaKc9ee3VxKOnq1Y/CbJn9miSQ6KRHriTcFd4WFpaJImiYBCo5aK06jXX50guDuRFhpZwr/QqpWp9GoX+0JCvdC1AuVw/GAxDBKW3XxYpHYWoExUBX/ev1gEqkHvuA1SzllFVV42mordQZyL9shXQ/MOR48ptvfI5HB9iDWAxaTDXNIukPe4zI17hcYjzpd8INxGlkYB+VsjQ474NY0Zn2zRc9mABLX6DKNYI3FOQVQxKQr0c2VlMjsch3KAVKQiSxiAoX/QNTM8rEpPhsjVA7I89js9qIa9R1YDJGa6Bfds/MS1F6la2UZ3Jfw7+deOvvv62EDHv51UqKgMn0so1U/HJGxIVlm6UUAoKolRL6VuTk3gj41K7AjpaZvoUP6/VV2z2iDdb5ZNRmE00U7ePyKUJrWxDl4Pcr71aBgqkonR6Bs07mCTwoUAIBBU+WLSPNi8Z2Vktwknsu/IHf6byLzo1/Eu883FbeAQePdWNwcfgDk1ax8+nCqWQIfzSSmLtYMG8CrA74I8OZ0lpzlmhXEL1qwunY2m0J05fLPnjIjMCB0F1ezV6aPQA5x2knjljZS81C1d+MZ49vreg0YLCkpwtY9aAXSKvVYrZ/bEIboQCLoLiF0MfYsEeIfpTDEo1GdC0fteFXsDNNrtXy5I37CotDDw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	323Con7baJUcdaVNtwKl6zDozxhqWm4yqELmCG0l4hPtLZCkgDIUrJ0WIXSS5a/TbOn9Y12u2dZYWcKFHIc3yVkCtx4PKfPfCh/oZW55OYJZZlJWRhfukRRkhPe109pXtiFToAwzHs8VwmFW/+TCnxgk8p9DvY5QLlAfaj6og503z1EmSZC6kaj73mvCk5fQcGmqQRcx/647RpXvOXDQtQ1yk1jBjhnu3JdEfiIpfLqCf7MJuDazlkJSkJoETzEQEtxKSkC1cCKsEXg580Y09XoIO0+OjOiEx0IOoLFpSPeO+f6pQnn2FWjG9x9nr2w0gr6bvJQID7sHy/Oxf3+jpHb3BjiKMswX46vyjAPyh5w4OcQxWNpXTiatis/J2U5ajp014w84SHlXQ4zpbNZGfCmasVdJ30csiA2shFY6M7I9zavwpR5bCUUJO/9dIFTT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 19:52:28.9032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121df83f-ba63-4c32-6b36-08de85f10d56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9E4583E15

A VMID held by a vSMMU is required to setup hardware (e.g. tegra241-cmdqv)
during its initialization. So, it should be allocated in the ->viommu_init
callback. This makes the VMID lifecycle unique than a VMID allocated for a
naked S2 attachment.

Introduce an INV_TYPE_S2_VMID_VSMMU to prepare for this case.

In arm_smmu_alloc_iotlb_tag(), retrieve the preallocated VMID on the vSMMU
directly instead of allocating a new one.

In arm_smmu_find_iotlb_tag(), continue searching in the smmu_domain->invs,
using the type INV_TYPE_S2_VMID_VSMMU. This means a second device attached
to a nested domain associated with the same vSMMU instance shall reuse the
VMID held by the vSMMU. (FWIW, device attached to a nesting parent domain
will have an INV_TYPE_S2_VMID and will not resue the VMID on any vSMMU.)

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 12 +++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 385dc76bc1b9f..c722df9b21982 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -655,6 +655,7 @@ struct arm_smmu_cmdq_batch {
 enum arm_smmu_inv_type {
 	INV_TYPE_S1_ASID,
 	INV_TYPE_S2_VMID,
+	INV_TYPE_S2_VMID_VSMMU,
 	INV_TYPE_S2_VMID_S1_CLEAR,
 	INV_TYPE_ATS,
 	INV_TYPE_ATS_FULL,
@@ -676,7 +677,9 @@ struct arm_smmu_inv {
 
 static inline void arm_smmu_inv_assert_iotlb_tag(struct arm_smmu_inv *inv)
 {
-	WARN_ON(inv->type != INV_TYPE_S1_ASID && inv->type != INV_TYPE_S2_VMID);
+	WARN_ON(inv->type != INV_TYPE_S1_ASID &&
+		inv->type != INV_TYPE_S2_VMID &&
+		inv->type != INV_TYPE_S2_VMID_VSMMU);
 }
 
 static inline bool arm_smmu_inv_is_ats(const struct arm_smmu_inv *inv)
@@ -1195,6 +1198,13 @@ struct arm_vsmmu {
 	u16 vmid;
 };
 
+static inline struct arm_vsmmu *to_vsmmu(struct iommu_domain *domain)
+{
+	if (domain->type == IOMMU_DOMAIN_NESTED)
+		return to_smmu_nested_domain(domain)->vsmmu;
+	return NULL;
+}
+
 #if IS_ENABLED(CONFIG_ARM_SMMU_V3_IOMMUFD)
 void *arm_smmu_hw_info(struct device *dev, u32 *length,
 		       enum iommu_hw_info_type *type);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ca7628abef5bd..130b6442af37f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1987,7 +1987,8 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 	u64 vtcr_val;
 	struct arm_smmu_device *smmu = master->smmu;
 
-	WARN_ON(tag->type != INV_TYPE_S2_VMID);
+	WARN_ON(tag->type != INV_TYPE_S2_VMID &&
+		tag->type != INV_TYPE_S2_VMID_VSMMU);
 
 	memset(target, 0, sizeof(*target));
 	target->data[0] = cpu_to_le64(
@@ -2683,6 +2684,7 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 						   granule);
 			break;
 		case INV_TYPE_S2_VMID:
+		case INV_TYPE_S2_VMID_VSMMU:
 			cmd.tlbi.vmid = cur->id;
 			cmd.tlbi.leaf = leaf;
 			arm_smmu_inv_to_cmdq_batch(cur, &cmds, &cmd, iova, size,
@@ -3246,7 +3248,10 @@ int arm_smmu_find_iotlb_tag(struct iommu_domain *domain,
 		tag->type = INV_TYPE_S1_ASID;
 		break;
 	case ARM_SMMU_DOMAIN_S2:
-		tag->type = INV_TYPE_S2_VMID;
+		if (to_vsmmu(domain))
+			tag->type = INV_TYPE_S2_VMID_VSMMU;
+		else
+			tag->type = INV_TYPE_S2_VMID;
 		break;
 	default:
 		return -EINVAL;
@@ -3270,6 +3275,12 @@ static int arm_smmu_alloc_iotlb_tag(struct iommu_domain *domain,
 	if (!ret || ret != -ENOENT)
 		return ret;
 
+	if (tag->type == INV_TYPE_S2_VMID_VSMMU) {
+		/* Use the pre-allocated VMID from vSMMU */
+		tag->id = to_vsmmu(domain)->vmid;
+		return 0;
+	}
+
 	/* FIXME replace with an actual allocation from the bitmap */
 	if (tag->type == INV_TYPE_S1_ASID)
 		tag->id = smmu_domain->cd.asid;
@@ -3313,6 +3324,7 @@ arm_smmu_master_build_inv(struct arm_smmu_master *master,
 		}
 		break;
 	case INV_TYPE_S2_VMID:
+	case INV_TYPE_S2_VMID_VSMMU:
 		cur->size_opcode = CMDQ_OP_TLBI_S2_IPA;
 		cur->nsize_opcode = CMDQ_OP_TLBI_S12_VMALL;
 		break;
@@ -3357,7 +3369,7 @@ arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
 		return NULL;
 
 	/* All the nested S1 ASIDs have to be flushed when S2 parent changes */
-	if (nesting) {
+	if (tag->type == INV_TYPE_S2_VMID_VSMMU) {
 		if (!arm_smmu_master_build_inv(master,
 					       INV_TYPE_S2_VMID_S1_CLEAR,
 					       tag->id, IOMMU_NO_PASID, 0))
-- 
2.43.0

