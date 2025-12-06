Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010052.outbound.protection.outlook.com [52.101.193.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2449D20A5E5
	for <iommu@lists.linux.dev>; Sat,  6 Dec 2025 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764982354; cv=fail; b=nicar2xBvTTeUZsbZc74Mvj6lpA0xu3qeo8oct56rblPfZ9nqaZXfe8kW3xmzuUSyn/kOWk+umH1bc3CoA1bPJCwzqNQ/Iy6RL+C8qUBAeToZYEn0BfpdT7SbbGSUUGpvW8+d0tEPpBdjWKIalVtMMVfVtGY6ig01eOOsMNsiBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764982354; c=relaxed/simple;
	bh=xM+58L3R5TpJhJ+cEdC7UbM3PAGmCsJokyi013t9AzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpytiOY2210kJX+jaaAYIBTyjBVv8ejhG3zX4L0n7cNbVCMQ3j7FGCKzixfFaa1pneoh5KAKhF9PGOimdoHfRXSj3RlCYQP1wt93EFRXQh1fMMDnqPQW0x1OIzZx70fCT/xqFJy1Fc7g0u5lCyn7CKs3HK5dbonpFc/0hv0WBYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fBhw98h9; arc=fail smtp.client-ip=52.101.193.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fBhw98h9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5Ge0i9i+W4ypUXObXwDfwGGo8pGXByb3IlyDdL1aPNDUlAMiq/oMgSOgu73zsjQz6sQCUpNldsayV0QDeOzFXqkbSK3q0wfl7sCQ0WMtrLgc/2uEDzkfFC2TwVe40QTd/vuttrBdXykCh5djuYfSXEQWuKbkVboukt7r//2NqEm2wgGV9PTEDkz8NSMSxOUh0qk9XDcihbZiWPkY8W7bKq5kDJg8v2KD7gKNMCLD+CSk88slXOysu5Gqq04UdHn4Auh5n8TUHo3ap67j62D7AiPHhIxCD+gaoVjb+eg8W6uB0teyt1+swFEsyemKTqtI/Fd20FfOR3K0/H7Yb1G7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjH4NxLn4Ia09FgahNu8RhvS8d6NqhMSPYuVnsFcDxA=;
 b=pM/YyajjP8S5cLSpQrj6oOamZB/WaPYq6e6U41//Ye/hHV9XavdsS7Nw4Et4Y4Ls2c8tbBzbZafzNZQOEHro+IkSezY7TEEVKLKdbTWH2PxJK2eSG2DZz7SeOsCvXU7mVyp6utu121QgAdQ1qIKD903Fc8Lk4QvOFS4ETW0C0rAqF3HN8GX5A8OpxTx7rQRoS8no7BGn3FY1cIMJovrZyZOiYnbp4DlBwvpSA8nO3jrciiUXNDKD6OEa5Lh+eRk/LzaDoqdR4EbMF1osLl2N6+TfLe49uV7zCzKkdlGDA4l0H3I/RHolt7T7xypNnYs7Dg36JXS9+p0Du/zbmJz5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjH4NxLn4Ia09FgahNu8RhvS8d6NqhMSPYuVnsFcDxA=;
 b=fBhw98h9qkyhazmcidvSfRCZIypBUPGeJcVevUF2apSGWmbhdLVws/NX2BFs78DYYU05EkgIkmqZfMh0pR1OsHkNQAcKibQ3dgtcp0UUG9FchZbNExfcY8/VUAy7SDlBB+dVcJGGi1Niw/xqA1Wd10JwOZC3QVeSnkqe8+uWrfxW9HyGgkvKPasye+/KevTkv2VvbsUR6ad4jw+1hIZWmelUv07r3mjFI8Sh2LiTppShUFVNV9/+GcdBYE1hv50eZb8NgubRJchEcY1FbjoNE9nBLWiC15+qKM0CaZ3cHAShhGeRBNHeL+hHJc2o83SzzF2Bax++gYfardgvPpvldQ==
Received: from SA0PR11CA0125.namprd11.prod.outlook.com (2603:10b6:806:131::10)
 by PH7PR12MB8179.namprd12.prod.outlook.com (2603:10b6:510:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sat, 6 Dec
 2025 00:52:27 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::57) by SA0PR11CA0125.outlook.office365.com
 (2603:10b6:806:131::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.10 via Frontend Transport; Sat,
 6 Dec 2025 00:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 6 Dec 2025 00:52:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 16:52:19 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 5 Dec 2025 16:52:19 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Dec 2025 16:52:18 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>
Subject: [PATCH rc v1 1/4] iommu/arm-smmu-v3: Add ignored bits to fix STE update sequence
Date: Fri, 5 Dec 2025 16:52:00 -0800
Message-ID: <6ec73bb7cd03d90a0764f12c4b14071158163818.1764982046.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1764982046.git.nicolinc@nvidia.com>
References: <cover.1764982046.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|PH7PR12MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 310a8266-0768-46c0-f00a-08de3461b9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AAWBpa3Nhrplge5BR6Nu39C7rfBwDK1X/YBqoxPYygJUPyiO9Ku+a2oihGq8?=
 =?us-ascii?Q?+mOlgkvsVralGnHIJqFL4WmxWtWIeLwO40XaWc1SdI950VLp7kiXv2Vx0Mna?=
 =?us-ascii?Q?VrvAHAHSIgR3G6nbOkjMFMgoiE4KEILn3AAoxhANZ3iYTt0yCpUn5xka2lJJ?=
 =?us-ascii?Q?q8uULuQgi6tu62wzaf2kEv3+g+pLf7YmUqRaWB2l+NEFIRnWDu5ID78a28BT?=
 =?us-ascii?Q?gFoYW+KFlwbv+dndGFy54hQ+uHveGwZNFc06eedN4bmFi0WWKZ70jZ+HIXFO?=
 =?us-ascii?Q?17/9UJikrYjETJ0OcR9WcNBIijEUMPEfohhE2AdqRATCJHiLKYg2V0WJLRjW?=
 =?us-ascii?Q?h6D30XCqMmxp0/T4I7wlycRAlzOK4u2FemiMvKiu54KUqDiyN5dhQ43Ng4ik?=
 =?us-ascii?Q?NcI9wrQz2YaQQyuCtA017qokQZ7jvOhGWRtt9yeZl9AdtZP/7yw8CkuRVF/j?=
 =?us-ascii?Q?RFKPOlgYAbW045SFP5KwhAoV08nHb7JLr2u01grG8xQg/k7rQ5hjUfzW4LTu?=
 =?us-ascii?Q?WeZLKuHJCp8i9dYMVWklr7itRy2ym/197uczzH/adWwA4Pqden4w8hrAqzR7?=
 =?us-ascii?Q?5aiITRis8YN1mkPD80u5Ekb6BQaPzQvDZ6LCATyDgmulk43kLEjxUXHQv7Rg?=
 =?us-ascii?Q?sR3VaLSkSpdmCZL7uNrfAFbYQh4+cFN1GWI3HyO4Nl4Y3ooD8ul4aQ2qHqxj?=
 =?us-ascii?Q?nUBv25ervzNW8FIm+sR/G3bjmSmUgM2TsnZ4D4HhNqxulI4QDj3kdOXWtr4K?=
 =?us-ascii?Q?k5JrPsZ+2odoBX3gX3/gRjRmilS97MfKh3ybctJ+LBpGfe0qkoyFkQf9B7Vv?=
 =?us-ascii?Q?ESGCG3tt7v1lzF252sA9ZW+a8fusDEeHRRo0JbEb/Z2ZoYAdmXaAD2o1q0+/?=
 =?us-ascii?Q?U3AQLrBa59SouGzSugpM3zHlCRB0z3pPBLAWhfh0G5qzz5YIUqr2GNhB6ehO?=
 =?us-ascii?Q?AnBPiVVBB2rdO/1J1xaYuMHw5lg+lXgQIMX4kDFoTDPcMab8g55oDrw2/5X2?=
 =?us-ascii?Q?sTOHfYhZU+j3UT52QY+iYQtkbFbl5qpBBYHGI+gQ4xr5Dbas1KqJ3iO7OBK9?=
 =?us-ascii?Q?yAFG3ZXs/nS+M3+TQhDh/HTsrNK+0mNPOVW/Yp54FUBcpDHr5Qwoz6jmQ817?=
 =?us-ascii?Q?VXgqKwKIzv7P+ELyVtBnKjmxswpXhrKJ7/+KlELTdb3ARxkhfvWv9xTvjAb+?=
 =?us-ascii?Q?DOvGVxnWJtsgWacT8bOdZLt/FftoVMFQvBFUdecBe10v3NOvYkX11ZOeQ1a6?=
 =?us-ascii?Q?2GlS3XRQcPtTmnADLDkAR5ZaQpHAGmUNbiuv6JM/T9nQZEZExEKxbJK0LqkP?=
 =?us-ascii?Q?6A4S3uXF6CuTQVqF1oYXTbvyvKySLzLlwznF9NJzwWtOQeGZ92k14xrOerwh?=
 =?us-ascii?Q?gX9lb+DSRcacUNF1SLhQ/KLZ2ssdx9JKKUFwEKuzmLwn23On9KCvekMZrlFb?=
 =?us-ascii?Q?AVWcAye1Z7qtFLNMRFESZLBVhd6ZnuZhZHE1QrcbkT1t1mQM8K0CH/D49bja?=
 =?us-ascii?Q?XAVvAEZcTFT0V5rwSDNU1Vfz0vI6AiYTlJ5GFRBeqLRgrcEL1tNuXmsJ3aRs?=
 =?us-ascii?Q?WhEkQz0MMo8W4gQexdw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 00:52:26.6425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 310a8266-0768-46c0-f00a-08de3461b9d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8179

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
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 17 ++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 24 ++++++++++++-------
 3 files changed, 32 insertions(+), 11 deletions(-)

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
index d2671bfd3798..9287904c93a2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -37,6 +37,7 @@ enum arm_smmu_test_master_feat {
 
 static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
 						const __le64 *used_bits,
+						const __le64 *ignored,
 						const __le64 *target,
 						unsigned int length)
 {
@@ -44,7 +45,7 @@ static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
 	unsigned int i;
 
 	for (i = 0; i < length; i++) {
-		if ((entry[i] & used_bits[i]) != target[i])
+		if ((entry[i] & used_bits[i]) != (target[i] & ~ignored[i]))
 			differs = true;
 	}
 	return differs;
@@ -56,12 +57,18 @@ arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
 	struct arm_smmu_test_writer *test_writer =
 		container_of(writer, struct arm_smmu_test_writer, writer);
 	__le64 *entry_used_bits;
+	__le64 *ignored_bits;
 
 	entry_used_bits = kunit_kzalloc(
 		test_writer->test, sizeof(*entry_used_bits) * NUM_ENTRY_QWORDS,
 		GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test_writer->test, entry_used_bits);
 
+	ignored_bits = kunit_kzalloc(test_writer->test,
+				     sizeof(*ignored_bits) * NUM_ENTRY_QWORDS,
+				     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test_writer->test, ignored_bits);
+
 	pr_debug("STE value is now set to: ");
 	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8,
 			     test_writer->entry,
@@ -79,14 +86,17 @@ arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
 		 * configuration.
 		 */
 		writer->ops->get_used(test_writer->entry, entry_used_bits);
+		if (writer->ops->get_ignored)
+			writer->ops->get_ignored(ignored_bits);
 		KUNIT_EXPECT_FALSE(
 			test_writer->test,
 			arm_smmu_entry_differs_in_used_bits(
 				test_writer->entry, entry_used_bits,
-				test_writer->init_entry, NUM_ENTRY_QWORDS) &&
+				ignored_bits, test_writer->init_entry,
+				NUM_ENTRY_QWORDS) &&
 				arm_smmu_entry_differs_in_used_bits(
 					test_writer->entry, entry_used_bits,
-					test_writer->target_entry,
+					ignored_bits, test_writer->target_entry,
 					NUM_ENTRY_QWORDS));
 	}
 }
@@ -106,6 +116,7 @@ arm_smmu_v3_test_debug_print_used_bits(struct arm_smmu_entry_writer *writer,
 static const struct arm_smmu_entry_writer_ops test_ste_ops = {
 	.sync = arm_smmu_test_writer_record_syncs,
 	.get_used = arm_smmu_get_ste_used,
+	.get_ignored = arm_smmu_get_ste_ignored,
 };
 
 static const struct arm_smmu_entry_writer_ops test_cd_ops = {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d16d35c78c06..95a4cfc5882d 100644
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
@@ -1094,11 +1100,14 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
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
 		/*
@@ -1106,16 +1115,17 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
 		 * allowed to set a bit to 1 if the used function doesn't say it
 		 * is used.
 		 */
-		WARN_ON_ONCE(target[i] & ~target_used[i]);
+		WARN_ON_ONCE(target[i] & ~target_used[i] & ~ignored[i]);
 
 		/* Bits can change because they are not currently being used */
-		unused_update[i] = (entry[i] & cur_used[i]) |
+		unused_update[i] = (entry[i] & (cur_used[i] | ignored[i])) |
 				   (target[i] & ~cur_used[i]);
 		/*
 		 * Each bit indicates that a used bit in a qword needs to be
 		 * changed after unused_update is applied.
 		 */
-		if ((unused_update[i] & target_used[i]) != target[i])
+		if ((unused_update[i] & target_used[i]) !=
+		    (target[i] & ~ignored[i]))
 			used_qword_diff |= 1 << i;
 	}
 	return used_qword_diff;
@@ -1207,12 +1217,9 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
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
@@ -1543,6 +1550,7 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
 static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops = {
 	.sync = arm_smmu_ste_writer_sync_entry,
 	.get_used = arm_smmu_get_ste_used,
+	.get_ignored = arm_smmu_get_ste_ignored,
 };
 
 static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
-- 
2.43.0

