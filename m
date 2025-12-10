Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013046.outbound.protection.outlook.com [40.107.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81358248883
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 02:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765334767; cv=fail; b=JC31zcjvYHE3dIO+ttYj/7Mld4VMw3QWvTDckt3cYrGD7LHGVLpBnbputFwwzYQS0fkt307lqyWdJCMs4TvVdSJXzkK+WS3cDuFnAYMMHEWFrWS+ACcMFGOJcwyEsnVEtpEEXiHxFGhXNXTml1SM3ORV+LGKfXx8Oqy4y4M9vLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765334767; c=relaxed/simple;
	bh=Kn1vp756jVaAYCWGstHp4MFXxxUvX9FbBD3FDRFStm0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3GffwX0KAclhyQTmIwit1dbuoZhwdR771k+FEum2iigCmZw1ZkOEzeQ8sliYsQNhu+72qYIdq0Z9cEyvDuT5D4cc1CvdOi3qXAIwwiDuPIwBKCdBw+6EhasjlX+MTnzqQfEGCrvcw5JdtVLzWBbSzMq9REwyyqmKCkdqwvmTq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ak0GHy3H; arc=fail smtp.client-ip=40.107.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ak0GHy3H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlEk9CHc9or8P1/+ms/OGqDIQGiGAeLphx3Qo17gbV1zYa6HrYTwQOSu7RGE1tYSBDAgEicQJKcv2aBgbG9Qzsvh1svotu3jEqwqHAfu5n7jt4NCrjbzEwO+xfl9xcHlid6ptWdlIsOmINxkgi5M1Aa26S+V4nA5uNps/PHfIIKNSset3oKFEwW6ESTKnm+TqPS65AcAWgpX4RvQ90jbOn2C/Tl+S+wXOeS2JAbe3epeep3EKh5X2ghSkQon0gqTYOMN6IMi2oFkAuxFAre0QFxMHya9UHA5YybeNp8Q0ZFTmuCS6gkftR+HhVJ8tRQYHtiuPn44Ss4NYpktVBbLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlTzKqplEbIA9MI3FvZ8jQqByTKrf6WHy/n9UZPM2Pw=;
 b=b8rgECgqXTdW5Jg50WD7huLZ0ObbvO201H6rXci1tqU9/1/eUGqzvayClUKHWmheSnKkZ+ceB78Y3MONha1xdMrQG64fNzlnLQuTKvIJimJ24TX6mfcdw4EXQo60Qtn3N64Ts4oWPDRtwQBFlIHenqRJ3bFUkIdPcCdIMwSeIF0gQ+2mxM0wkqS+v00smx/i3r/Z31imVGc2tOS3gdG1dO+/ad1fREJSRP9iCCPHhOYDpHneNCqDoPV/2Kxoaw4J7qN4pD49/IbNYPlvslgIkBb13NESjG5OlYH70XsbQfpSuga/NSZ7WSmF6AZcc4Uo1Ei3iHqbbr7+GRlUuaRs0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlTzKqplEbIA9MI3FvZ8jQqByTKrf6WHy/n9UZPM2Pw=;
 b=ak0GHy3HBXJW2YCw/NHrhoCKt2gC3pyEkHrdRnZQBunmmYnmwd8MWYYLDIQMlkXPD9ey5LgmaUQqcj0DgQrkCa1dpT4a2tt/zPCpUat5HP/0sHpN08oDIP7jsm6EqhEznMWwVjzcd7HSN90zE3jmw+kNeecacqfXGZKM/YbZLlopdkn8oLtRXZDlhHD5qRCjCAmBJiFCf1ai9DbA+nlHt/jTZim/S/MJOsbNtyj6mq8U/fyu0BhcEoKmALmx5YSjaRKBcXkSBbAgMkjeMkKnEm/E1WQ5+GrChSw7DPIQqFuHQiVJ9/cU8DkNhs2u9yCxhaghCSaQFK+tXEz8tGq4RQ==
Received: from BN9PR03CA0809.namprd03.prod.outlook.com (2603:10b6:408:13f::34)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 02:45:59 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:13f:cafe::e8) by BN9PR03CA0809.outlook.office365.com
 (2603:10b6:408:13f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Wed,
 10 Dec 2025 02:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Wed, 10 Dec 2025 02:45:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 18:45:50 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 18:45:50 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 18:45:49 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>, <xueshuai@linux.alibaba.com>
Subject: [PATCH rc v3 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE update sequence
Date: Tue, 9 Dec 2025 18:45:16 -0800
Message-ID: <cc0d4ab571e2e789ee1cddfa035379dc54f0601b.1765334526.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765334526.git.nicolinc@nvidia.com>
References: <cover.1765334526.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 41280fd2-e22d-4eeb-f701-08de37963fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G8JFk6n9RZTuWe9kI9N18LwPL5/UhCR0lqnqfXRzZ56GbHfXmIZKtT6rvKG5?=
 =?us-ascii?Q?QQFuYaZ9VRyl1KkOEloFHz3urODPRu9HVOk5Q8yEwayglvIsFG1kG69Rm8ih?=
 =?us-ascii?Q?188wFcRu+dnOLcdtiRWsMy60slflEtHHpUkFEKGOMzPPAsQsjC3rDpLVWwXL?=
 =?us-ascii?Q?rMFu74D04SUJWXvzSXWPGZBttHmT9JyzvCAaEpR3wPQWFjvUfy9poQn71EhE?=
 =?us-ascii?Q?6xKFWkMUE1K2z+GsBQNK8wlJKDf4syhJhk3Duv7GmqcUfcet151PXgXn7Ej1?=
 =?us-ascii?Q?8ZhPRtmhgMg/mg8pUSt6cm6n+Co7TQL28fw4vmwKTFhfhY1aZ7bM6Q02ymdH?=
 =?us-ascii?Q?mJDw+bxgaoPdf3nonfZS1RBIrlBnEUomBScDCN73Ox3Sw2E7d72ysF2kh58y?=
 =?us-ascii?Q?cuZ9utdJPFqXHT7XPPRVSx0NvSZhvjc3N6LSCsfbk25566v/UfCv/hFOMb6T?=
 =?us-ascii?Q?LVrf8gTQCZ+AnaugVNfEm5i042jCXyxfBLWbNjOjlFg0xqO1qo9gOgZbGkWs?=
 =?us-ascii?Q?JaRzwbDkUQnVsWhinp+yiQs12CfW4K+fC9uwWfnk0i1OJNxuFtl+6K7/T6Zy?=
 =?us-ascii?Q?6i61Ze2UzNGgFB7nnpefz5CBJlpu3HJ71aq9OyIXOv8yUFiU2XYC1b4rPbCN?=
 =?us-ascii?Q?5j7b/0QJIFYYari0A4IOMii1bL5IKFaY1Z9GK29uvby2uKko8yFNxn8XELRI?=
 =?us-ascii?Q?Qzh5KPErAGHhOyi3RmBOgXp5WNR+HLJhklt6IVXfje+8GWHTv12IDctO5oV+?=
 =?us-ascii?Q?Jmd/LPcjQDRDttFqszsl5fw6044MGwh70pnn8CxBLfnNsgJYbfTOvV5/lrZK?=
 =?us-ascii?Q?K1HgFZYI95QJLAaFFCkCPCFOWmI7G4fxx3wCJJAtslATjlVgQwU0uAEqq62I?=
 =?us-ascii?Q?cDlzrtTOKVgzvS7Dc1UeNQXW+RO98q+DWIU59KTsih7M7qY9BqvpjFPkOBPV?=
 =?us-ascii?Q?XdV068iya3SZHJN7khWV25z2ky5Wv4fgvmIz5jt3dOIf/flVv7P2mqhyGCQf?=
 =?us-ascii?Q?CXcDVdCm1RNPAiBHNCLehFtc9+wCTSJOv9epiFAH3GbwevgF8nTuGMkqvgIl?=
 =?us-ascii?Q?1zyOmC3Hpxel+r2FF7THyKeHV4ji2HUbt0Cs5u/3I0g4amP7hSoGfAu6wmBc?=
 =?us-ascii?Q?ISokFH2yuc0VU3DH9UsiCPbtc3ek+ZoSG48Fi6zYGI4/g40zql9THlGw+DL/?=
 =?us-ascii?Q?dUMSpBTGsMwN5FTuP/W37MeDLvp3ilZwpyHX5rj9JWdTqdaFNQNvF1WUUEC7?=
 =?us-ascii?Q?xh6sQJS5WFj01ZNuxVvMbnfpt46ZT6vziowNKWiQUBxLEJI/nTJwOboH9tKP?=
 =?us-ascii?Q?s6rlmlLHLuLRrUCho2Zbc+E62jq+PCegn6dgHE8Wa7OYP73Njw5Lt2iWI8Ms?=
 =?us-ascii?Q?opMuivoyrt/ZUY7CgKHoxJ5Y9hCpkVrHiMm1iczhb7rvFoZdyHscWfNRfZE7?=
 =?us-ascii?Q?5KKAR/jhTNmuvugvCKdWY4t9pfRRK3gaWLi6z3EEc9WQnf/3L/e5abZ9Amiz?=
 =?us-ascii?Q?S17xUyRVK5BYT+DdApAPCOruHSSqvUVV7RUX3G4QxDX5EVoNE3hzej7RSiJ8?=
 =?us-ascii?Q?26aGDXM2bw+hL2doH1w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 02:45:58.4413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41280fd2-e22d-4eeb-f701-08de37963fad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350

From: Jason Gunthorpe <jgg@nvidia.com>

C_BAD_STE was observed when updating nested STE from an S1-bypass mode to
an S1DSS-bypass mode. As both modes enabled S2, the used bit is slightly
different than the normal S1-bypass and S1DSS-bypass modes. As a result,
fields like MEV and EATS in S2's used list marked the word1 as a critical
word that requested a STE.V=0. This breaks a hitless update.

However, both MEV and EATS aren't critical in terms of STE update. One
controls the merge of the events and the other controls the ATS that is
managed by the driver at the same time via pci_enable_ats().

Add an arm_smmu_get_ste_ignored() to allow STE update algorithm to ignore
those fields, avoiding the STE update breakages.

Note that this change is required by both MEV and EATS fields, which were
introduced in different kernel versions. So add this get_ignored() first.
The MEV and EATS will be added in arm_smmu_get_ste_ignored() separately.

Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 ++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 19 ++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 24 +++++++++++++++----
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ae23aacc3840..d5f0e5407b9f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -900,6 +900,7 @@ struct arm_smmu_entry_writer {
 
 struct arm_smmu_entry_writer_ops {
 	void (*get_used)(const __le64 *entry, __le64 *used);
+	void (*get_ignored)(__le64 *ignored_bits);
 	void (*sync)(struct arm_smmu_entry_writer *writer);
 };
 
@@ -911,6 +912,7 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 
 #if IS_ENABLED(CONFIG_KUNIT)
 void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits);
+void arm_smmu_get_ste_ignored(__le64 *ignored_bits);
 void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *cur,
 			  const __le64 *target);
 void arm_smmu_get_cd_used(const __le64 *ent, __le64 *used_bits);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index d2671bfd3798..3556e65cf9ac 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -38,13 +38,16 @@ enum arm_smmu_test_master_feat {
 static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
 						const __le64 *used_bits,
 						const __le64 *target,
+						const __le64 *ignored,
 						unsigned int length)
 {
 	bool differs = false;
 	unsigned int i;
 
 	for (i = 0; i < length; i++) {
-		if ((entry[i] & used_bits[i]) != target[i])
+		__le64 used = used_bits[i] & ~ignored[i];
+
+		if ((entry[i] & used) != (target[i] & used))
 			differs = true;
 	}
 	return differs;
@@ -56,12 +59,18 @@ arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
 	struct arm_smmu_test_writer *test_writer =
 		container_of(writer, struct arm_smmu_test_writer, writer);
 	__le64 *entry_used_bits;
+	__le64 *ignored;
 
 	entry_used_bits = kunit_kzalloc(
 		test_writer->test, sizeof(*entry_used_bits) * NUM_ENTRY_QWORDS,
 		GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test_writer->test, entry_used_bits);
 
+	ignored = kunit_kzalloc(test_writer->test,
+				sizeof(*ignored) * NUM_ENTRY_QWORDS,
+				GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test_writer->test, ignored);
+
 	pr_debug("STE value is now set to: ");
 	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8,
 			     test_writer->entry,
@@ -79,14 +88,17 @@ arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
 		 * configuration.
 		 */
 		writer->ops->get_used(test_writer->entry, entry_used_bits);
+		if (writer->ops->get_ignored)
+			writer->ops->get_ignored(ignored);
 		KUNIT_EXPECT_FALSE(
 			test_writer->test,
 			arm_smmu_entry_differs_in_used_bits(
 				test_writer->entry, entry_used_bits,
-				test_writer->init_entry, NUM_ENTRY_QWORDS) &&
+				test_writer->init_entry, ignored,
+				NUM_ENTRY_QWORDS) &&
 				arm_smmu_entry_differs_in_used_bits(
 					test_writer->entry, entry_used_bits,
-					test_writer->target_entry,
+					test_writer->target_entry, ignored,
 					NUM_ENTRY_QWORDS));
 	}
 }
@@ -106,6 +118,7 @@ arm_smmu_v3_test_debug_print_used_bits(struct arm_smmu_entry_writer *writer,
 static const struct arm_smmu_entry_writer_ops test_ste_ops = {
 	.sync = arm_smmu_test_writer_record_syncs,
 	.get_used = arm_smmu_get_ste_used,
+	.get_ignored = arm_smmu_get_ste_ignored,
 };
 
 static const struct arm_smmu_entry_writer_ops test_cd_ops = {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d16d35c78c06..e22c0890041b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1082,6 +1082,12 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_used);
 
+VISIBLE_IF_KUNIT
+void arm_smmu_get_ste_ignored(__le64 *ignored_bits)
+{
+}
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_ignored);
+
 /*
  * Figure out if we can do a hitless update of entry to become target. Returns a
  * bit mask where 1 indicates that qword needs to be set disruptively.
@@ -1094,13 +1100,22 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
 {
 	__le64 target_used[NUM_ENTRY_QWORDS] = {};
 	__le64 cur_used[NUM_ENTRY_QWORDS] = {};
+	__le64 ignored[NUM_ENTRY_QWORDS] = {};
 	u8 used_qword_diff = 0;
 	unsigned int i;
 
 	writer->ops->get_used(entry, cur_used);
 	writer->ops->get_used(target, target_used);
+	if (writer->ops->get_ignored)
+		writer->ops->get_ignored(ignored);
 
 	for (i = 0; i != NUM_ENTRY_QWORDS; i++) {
+		/*
+		 * Ignored is only used for bits that are used by both entries,
+		 * otherwise it is sequenced according to the unused entry.
+		 */
+		ignored[i] &= target_used[i] & cur_used[i];
+
 		/*
 		 * Check that masks are up to date, the make functions are not
 		 * allowed to set a bit to 1 if the used function doesn't say it
@@ -1109,6 +1124,7 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
 		WARN_ON_ONCE(target[i] & ~target_used[i]);
 
 		/* Bits can change because they are not currently being used */
+		cur_used[i] &= ~ignored[i];
 		unused_update[i] = (entry[i] & cur_used[i]) |
 				   (target[i] & ~cur_used[i]);
 		/*
@@ -1207,12 +1223,9 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
 		entry_set(writer, entry, target, 0, 1);
 	} else {
 		/*
-		 * No inuse bit changed. Sanity check that all unused bits are 0
-		 * in the entry. The target was already sanity checked by
-		 * compute_qword_diff().
+		 * No inuse bit changed, though ignored bits may have changed.
 		 */
-		WARN_ON_ONCE(
-			entry_set(writer, entry, target, 0, NUM_ENTRY_QWORDS));
+		entry_set(writer, entry, target, 0, NUM_ENTRY_QWORDS);
 	}
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_write_entry);
@@ -1543,6 +1556,7 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
 static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops = {
 	.sync = arm_smmu_ste_writer_sync_entry,
 	.get_used = arm_smmu_get_ste_used,
+	.get_ignored = arm_smmu_get_ste_ignored,
 };
 
 static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
-- 
2.43.0

