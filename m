Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488F12E7BCB
	for <iommu@lists.linux.dev>; Sun,  7 Dec 2025 20:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765140604; cv=fail; b=THFULbihD0DWhretEzSRjjO+FlCvk7wx62zPcntzN2tg36WPGSo0Ovx46TQnSsR8sSsG7+S3fCey0Dse48raKo5fm6YWB7G0S6dyTUm09uqb079HIpprbkH+ochzy9JUt3OR0cLmQK82wQB0K8Cs7A3WifrDx0ZzFFgJUr1E2Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765140604; c=relaxed/simple;
	bh=P4NldzcBvIo168mL0+1ODIlHQqAT9wN1ctpeo+bVssI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnSFSFz1wwBv23Ilo5wdlkLFEyMdHV/3WHmuXmw/7x6orB8YhSKtSxX0I1Sq8zCPUlZPea1nryYsYvqj7W0pah2lBXkL5EsEUq7RGLvjfzkL02AXikJQgZaVKMZjojGs4XTwJVtbidgI8OGP9IrpARdT6tlS9/No9k0QJlDel4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CpAcR3Q8; arc=fail smtp.client-ip=52.101.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CpAcR3Q8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwQ6BmL2jCaXkU7Zz2kRjXcyxSw8N9y4O53l6Ot3fMBiz43C6Pb4Pqlj8j/23Yc4m4trg2uFYXsbuMp9lCcDwJASxebHKM9jo52O9ZUTSOjpE5B34ZLjT1La0mlYWD83ls46pPVPrN45Ovort/UHfIuE8YFrzAnTS+My5U/D9DBu70afTSX+lHu+zYpVOASokRTyV4mKxw8Tf/7LOeXnGmJSyXea4EDgEYkxDGG6JCvA//sIKR9LhOw3NSsry05OR3wQoeBzHmfv3wNC6aBzZMnPWkPHI9Fjh1SZ8i0CRrC2cen7ZYjqeguGGEEN4gAou9yNKNkom77QeHtCtXIXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygW6DIHLHt5lsBXzwnnbR3qxMa4ilRUrb8C/mKvH4LE=;
 b=LJUXulvRlDdYCVMwmEr61IeIWZ2zkRMs+0JyexkocK7lqBnWJlU1klHfnZ1U9lx1UEBzqcmTcG5Yk0D2RNe6as/75EFX3m0H9pNCFCOD5UE9K0gRgxMGh159cemSQ10l2sRptD6f66pFEC0IRV78bcOv977FAuk3T5m99ZoUGvSq69INzyQAF7h/cDGVLZ3ETrX2vmo1aWuqLENzouPIyeO+EOgQLmmDSuO/LdVj67lwxoo1UJt/PMpR/vH9/XooAwB2fX3eLU25Q8spNLKlt/GAU3UC/FhuBC1328DYplXSo7xe4jUHKn7A+huyVeMXk54CN/8xBgiIF4r2Tvc9GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygW6DIHLHt5lsBXzwnnbR3qxMa4ilRUrb8C/mKvH4LE=;
 b=CpAcR3Q8EgLgvbzYHcXhreXHlSaIp61hD7991H5iZs6twADODeGqlRO5iv9isQtOui+TtCxdQowk/f0kHnPASR/SWxCW8l+xKLWGTnNskEq50CJZ4M8CJF2Sv2cH2foRB97N6JUerQE3f47L3qcfzIPAyL+UUcrT3FRmTodhXV2nnYn0VOjt1UbwSJqTcpBFTC/eQGf1AKEX7bcsWs1t++30+HfozX58g2fu8ukGrKEnmYDXXW7Es2OMUQID6jPKZXYu7sv25C2Z8qLO3ZQw1DrLlWwRtcY1NTjg0WFY2ovKxEVdesFcboIT751CA7GwYmvjH4XQsBxFY03URkBkKA==
Received: from DS7PR03CA0167.namprd03.prod.outlook.com (2603:10b6:5:3b2::22)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Sun, 7 Dec
 2025 20:49:55 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::e0) by DS7PR03CA0167.outlook.office365.com
 (2603:10b6:5:3b2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.13 via Frontend Transport; Sun,
 7 Dec 2025 20:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 7 Dec 2025 20:49:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Dec
 2025 12:49:46 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Dec
 2025 12:49:46 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 7 Dec 2025 12:49:45 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>, <xueshuai@linux.alibaba.com>
Subject: [PATCH rc v2 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE update sequence
Date: Sun, 7 Dec 2025 12:49:13 -0800
Message-ID: <0db5caabdcdd8aa170f4c196e94d54664cc87fd3.1765140287.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765140287.git.nicolinc@nvidia.com>
References: <cover.1765140287.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d18335e-5a7d-4cd4-9d7b-08de35d22d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f/ZSfq+OE0b5zgreH9lAlMClihbGf5q8+i5G5WXe7lsAd+nzLHq8jwh/VTyT?=
 =?us-ascii?Q?rQ7j0xGr/wB/FIoGwdpjdP2NN2AouxHJHW9PmOuD7/nLzet7++SSTFrsHkV8?=
 =?us-ascii?Q?CDmwKhJkxyRaqoHBuoQ4W+P/dIcSCUe0yNRjNSlrZvRmMwhuTPbz7ZS/JXcR?=
 =?us-ascii?Q?MrFIUeianFHsgtezAFvIBjBhkGvdj4fEKxuFXB3hlrZN3j3Vz+Ys1PFi3UxC?=
 =?us-ascii?Q?GXdcIeL88RP7DecBGMITbFN6c4sIfmcLfMBclvOSjoAYQafpLefjsbE71n8z?=
 =?us-ascii?Q?LBrila0Un9pIIwqOc8/+DL7l8jT2nE3DVfLBw2VKP/iY73D4Wz4irzPdu1dh?=
 =?us-ascii?Q?aEmEe2MqOv7zTQbH2iwK3qznMQBwVx/7uNiq+TG3wCYlL6vDybxjXSQa3/Ot?=
 =?us-ascii?Q?LYrnWWCmXt54FLAVf03kZz2BUeQxoX0OiBB6MPDvTqZ6OAhzBcZOqHGAk+EI?=
 =?us-ascii?Q?V+4N81pCI+QeVR8F8BMO162HgrVxBrR3XJd5pCzSdSX/KW2MgLY9VaxaPdHp?=
 =?us-ascii?Q?5Ud0784s1smiG9ygvcxmMcQDJfVTXCh3FciC2QwpzJ7HIU/w0VKr0myPog44?=
 =?us-ascii?Q?dEnpQCHVMHLPPoHGj09cfUi+Cljt5bvNEdFdXsolN+Za28cGMTpQtG5wDSLV?=
 =?us-ascii?Q?JsVk4rcZbUhMX9iv2N+/LJJXq1RJODw9pmErkejfsqKOzFMGIQ6O4YIlWw0p?=
 =?us-ascii?Q?kCGxJLvGLzTw1PulGNFMzQ/Z/eXHGtSEs75XqcyQERHMojc0ZCnftwVH9BMm?=
 =?us-ascii?Q?wqnwtMeoPbBJCOiNuRZc2camJKorvUDIQvq0aZd2nTbVR4MiJVL+fXv2WuKL?=
 =?us-ascii?Q?Aor2qWlpbNk0TroPSZ8XvQMgeeV8B+eLL1ATDUJ1zxNsfBDP9/segexkX+6Z?=
 =?us-ascii?Q?77z+kqksluqEBKvri2wr7flapZmOeaq0eZLqsSLAoqpGYVYP3hR/PCe1qNNy?=
 =?us-ascii?Q?PgyEVc4xj+EvqbQm4t5DMy42L/QIky9FG3al3yp1gnnuxACK05nuufx0bpi/?=
 =?us-ascii?Q?B75k18gXa3POcH1ixLp/LldUKAulYJc7ZlyQaSQfavQEhpMH9rdQwYKo0QtZ?=
 =?us-ascii?Q?0uuKTNolxji3KyRVN7gF444a7scEru3Rm4Uk5jW4llA7aAh6DHdLbHbRhbs+?=
 =?us-ascii?Q?ziTX7FW0UQOwQHQrUnIBRvfiwzKhF/nUTraReQIUrFLLaJDTmgt/h7UVhqJk?=
 =?us-ascii?Q?XplUkRNNZ3ukCPuhMJsy1WkLcdgDd51BhR9bPpbGWtzHlq2nuLbkSfynEzzi?=
 =?us-ascii?Q?MtQdk6izARSjDbACmHuPCKGG0SAlkyWXzBErAyFHbx1yzx3hRsE9Ge9j4DdW?=
 =?us-ascii?Q?fMDiv7mMKiLV0cgnJs9zFSU/Lk1ppDL0VkWR/ktDiv7nOPw1APjjoexDJCT3?=
 =?us-ascii?Q?phxY02D/oG19f3i7iZ3HFIi9b05EhUPBDlfML0nSnMzZitdSMOPVYR4zilFh?=
 =?us-ascii?Q?vg0zEJ+37mSaix3n3+vWgxyrss/j8x8eTQMGn46bZUG322ymlcp5HjiY88wG?=
 =?us-ascii?Q?DDbre2YXQz3AA22etDVWzN/xGbaazpMI/gumdlOqXwSMzmRDLMyX3po/k02t?=
 =?us-ascii?Q?3qOcUpLVEk8HoDvMpVw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 20:49:55.5648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d18335e-5a7d-4cd4-9d7b-08de35d22d8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142

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

