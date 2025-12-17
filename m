Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96BF230D0F
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 04:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765945591; cv=fail; b=K2TSjiTkeiiZlQSQ1YcgymKEGoHl0sws9IXwcbRkHwJ+wacHg0jkBR/0emTnnp7KlR5UXUj8yfySFJ6ItcLEwBlICdGXJN1qD772mfRduqZcbBuAduSQpN385KXUDaY3lXo36pU9m8Q9vJDySPCFblHyHptf6XpRx5GULN8uIbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765945591; c=relaxed/simple;
	bh=PhdGwCIV00i1T7PfsbxGAR6qEzk7ekCO12PJF6jlpDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mc+Qti04Jo18WnoHOiwF6lem50o8VzWRt9NAjgZYHwfRM1fph5FNyOY94011G2+mDyRi5uVwnCMC+LNBhpjTzf4uRIaNL1qHRvrv87NbJH1FhHxbX7IObO+u9Qhe6DwqydaEd7Risi0OctJ8xwnX4H333e/sYnmz7WiGaT5uHQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LWdU9lt6; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LWdU9lt6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOQhLAKBK80hFFQxbP/Bib3h5fSG1zmECulD0ROKUc/KX9VJJ2VexV7fceryuUOWro+GKMVi+xHgH6sLYHwfgc/Eg0FpjyS4wA6VT/QwhNMWv8+tWCvuQSXKiVs7ia3KHnTixanzSRR2E9/1eq/NRx+G2oNazgJxELj+c5yfY7/iIg1VXmPdZIG2hAxQSOqAXljdS0FWp7Tx3p3ZsARW0s2tjAcPvhMxmxTJDt7CYkxoUOobCmlL6K8TEPvasKVU68te2f8QeVGo3jH9LwTQzE4YKhlaXmzDfVLwv1ovjjiqq5lYkaca9eO0tMZ1vHLcMjQPwi63vJ3k6Ew+FHMmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5P6R43RBzsyBkSe/PsjJhJlVcbrO4PgfzUML1o5VOc=;
 b=xCJG3pznPn2TmMiMw9/Yi8NKMiZMYQ+u97Q7PVqr3idBuLu7XNECJeoiAYSvl8a19roHsvaEvnF30mL/BJMksI9wfnvsPUeR4CSNN6CFDnWXIUHmjQ3ULB3UFxqVtM05c4SMnpKF7XU99Lka6II57Xxluw56gHHZseT5EW4FZPCYvoAmxqcTgDHRR6xVimKI4Y4mZlf/yyxz89tg/beU4xDJuW0Awwl1nuzOymOLV4uD1Ov20JTmwhyRy0zgwcgYwUXneM/qWs3prYZqIAjfj/G7dUAzpWCup4kqLprG5/M0HDcA77rlBSv6tYZ2eyh1nKMQksXpJVr3j6NNQaNqbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5P6R43RBzsyBkSe/PsjJhJlVcbrO4PgfzUML1o5VOc=;
 b=LWdU9lt6eeNaKV1JoedwKVvusX+9trBIQmyhp7dIMqEPp1j+mpn8LgDShWetHo8gJgeIXn3jy9PtOSt9KQjnM+emaQy+HqXEVrgPxMssmaGSw3Cn5+GZI5rxmlA1P9Bg2c+2z2TEv2DoOdAYSO1jL7McMkucqIBx2JBPaMTxv5U0D6PvoaLzh9qCCZY5PQ3MpDw3As42w0moRgdMHtUjkCPE3oQUsPZWAYhO+vWn5F1zqPc5kPmWzjpAl/jTSLR7UBeQNg6QlpCa25upXRSQT8R6Et8ndonB0tam7PF0QBgE4GyvU4WciQeMn1g+EoKUo8aTqiGj7tJTV6QQbGjm5A==
Received: from CH0PR03CA0047.namprd03.prod.outlook.com (2603:10b6:610:b3::22)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 04:26:25 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::20) by CH0PR03CA0047.outlook.office365.com
 (2603:10b6:610:b3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Wed,
 17 Dec 2025 04:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 04:26:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 20:26:15 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 20:26:14 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Dec 2025 20:26:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <smostafa@google.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>
Subject: [PATCH rc v4 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix STE update sequence
Date: Tue, 16 Dec 2025 20:25:59 -0800
Message-ID: <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1765945258.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765945258.git.nicolinc@nvidia.com>
References: <cover.1765945258.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 8317f09f-8875-436b-3a6a-08de3d2470f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XrZXG50XxUEMTifmKPmqzZKdEgDJ+VlIRGbdDFacWrI/qzzYrmb62litixYf?=
 =?us-ascii?Q?LakpRsCuFxH6E4Qnwj49/nvQWJ2feIxzr1OtnXEK1IZow1VGOd0tyv+Rgz3V?=
 =?us-ascii?Q?A9NpzUVJA2jpo+/pTZ9lwnDXJuQi5zL5HRs/KtFXgoj8ZqIkJqEKd78vhevI?=
 =?us-ascii?Q?+jO07h44IQSc6HER1pDKfPxZ1ItSu7Icy+F0qp7+KR0UdqxI9O+lHKnIzVxN?=
 =?us-ascii?Q?XCWuwLegt4k/+wmLhpTEUCg7eScWuSzkS+P1H8TOf4KFPdAppFZqNrL2c00O?=
 =?us-ascii?Q?rOMb3XY6AUsDTvAp6g+to6aFLYA+Zzf+T1OeY4O7BG1hrPsFGG1lL/3yTPl5?=
 =?us-ascii?Q?jsNtt2pMGjridW9lAB/AeaEodbNqF3ZLyhPlvvrwLMlQIlkGbKRgRA7ClikY?=
 =?us-ascii?Q?jijII188T2qYZdqHLA4UeUbDNZsZQzfrKlRakW8cDoPRbtatluAcU8CARs+W?=
 =?us-ascii?Q?/DamGqj0d9KcgY+muR3M5UQXcsLR5FgYL9TnaILYdwZGBzKKVB3AK8lQ1Emp?=
 =?us-ascii?Q?pSXvLaUChMjZd/c6oK6KxMFNJm5DYUlHIG/tf34FoAH5tq7E5rWRJ5i+VHic?=
 =?us-ascii?Q?fws/7Yz+gebT7uR9nohZ0OvF7AUMpGu8gGe6yf6LZpsVaRx9bbIzrZyyMCQA?=
 =?us-ascii?Q?36imqjWNNkBRysLXOo4xHAPPSByR/2w45Y6WeuqRG9jofvPs+9XKNAdPuGvZ?=
 =?us-ascii?Q?lVGgyvzj+vsNVS4xun8yfo3ccP9spCf97N5kSupBbUh45yhIOmYF/9Jl8tXK?=
 =?us-ascii?Q?EOFq+pNrS0X8SaVELG1vwFATB2hMbEa3eyfY4QJLMuHE6H19klCEuKdh8yRK?=
 =?us-ascii?Q?bVhZe1naXKnj17Rt31ULxzvYXE+i3YuBcQZ3dvykXMVMsJL1gB0ntFk0TToY?=
 =?us-ascii?Q?Zrdq9/jXFkcnRn9DLNeA6tvqYJuwxZa0t0Qx8w4ArhRVXdaatYk7azwDkhe2?=
 =?us-ascii?Q?2+2dhW/bs63TUHAOl2OxQ5E4Jp2qtosm7dnbhq7IL6InN5BbtyeyD+YVTmtt?=
 =?us-ascii?Q?T7aXK/RkqNPB5u7PZNKB20t05cbCNvTSlo0vrdKqEaqnoW244irNajOMm4rb?=
 =?us-ascii?Q?13TUUz7dZKtzCS4J/kdrghEIuESlW39MDv3K1+tMARHpWAb3Y5yioIUhTbyy?=
 =?us-ascii?Q?bHeFsV2GRMu94zyngS9MvLLHn6cDghsEblJx5TUXkdqh+zHpAVhrYjWs6ols?=
 =?us-ascii?Q?vf0QWQGn1sD1ui62JKkOb2b3r6REIO7obdT8s1yO/pP3PEB4YeSC2zVo2i+e?=
 =?us-ascii?Q?//RccyI54MenaEdsqs2jXjljPde7ENgeP5vK1J9xyXJ+aRurgDX4EPT9+Yuk?=
 =?us-ascii?Q?J1g8SxAyorUvVcaCrRsHgoYI+SadqR5lN85z4FwNz/j6gx0KztgDOl7LD92E?=
 =?us-ascii?Q?Cs7Kk1HE3wTkBz7Co0nzzNseg2alG1Vl9j96nb7OQEv1uC/M5Zh6Juk1JcPc?=
 =?us-ascii?Q?otEAEXNGC8vZOLw5JoBiWiPdQNKXD8PopQa89+xLjWupRsSrdPeMjwctGOyi?=
 =?us-ascii?Q?llpDHhrwzzUZQCEcitBbZBwUQr9oGNfP2L226gL5nd2Tss7koU00/oGdem+d?=
 =?us-ascii?Q?uMwyPGhX0lH7RnoRWrg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 04:26:25.4412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8317f09f-8875-436b-3a6a-08de3d2470f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249

From: Jason Gunthorpe <jgg@nvidia.com>

C_BAD_STE was observed when updating nested STE from an S1-bypass mode to
an S1DSS-bypass mode. As both modes enabled S2, the used bit is slightly
different than the normal S1-bypass and S1DSS-bypass modes. As a result,
fields like MEV and EATS in S2's used list marked the word1 as a critical
word that requested a STE.V=0. This breaks a hitless update.

However, both MEV and EATS aren't critical in terms of STE update. One
controls the merge of the events and the other controls the ATS that is
managed by the driver at the same time via pci_enable_ats().

Add an arm_smmu_get_ste_update_safe() to allow STE update algorithm to
relax those fields, avoiding the STE update breakages.

After this change, entry_set has no caller checking its return value, so
change it to void.

Note that this change is required by both MEV and EATS fields, which were
introduced in different kernel versions. So add get_update_safe() first.
MEV and EATS will be added to arm_smmu_get_ste_update_safe() separately.

Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 ++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 18 ++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 27 ++++++++++++++-----
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ae23aacc3840..a6c976fa9df2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -900,6 +900,7 @@ struct arm_smmu_entry_writer {
 
 struct arm_smmu_entry_writer_ops {
 	void (*get_used)(const __le64 *entry, __le64 *used);
+	void (*get_update_safe)(__le64 *safe_bits);
 	void (*sync)(struct arm_smmu_entry_writer *writer);
 };
 
@@ -911,6 +912,7 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 
 #if IS_ENABLED(CONFIG_KUNIT)
 void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits);
+void arm_smmu_get_ste_update_safe(__le64 *safe_bits);
 void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *cur,
 			  const __le64 *target);
 void arm_smmu_get_cd_used(const __le64 *ent, __le64 *used_bits);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index d2671bfd3798..5db14718fdd6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -38,13 +38,16 @@ enum arm_smmu_test_master_feat {
 static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
 						const __le64 *used_bits,
 						const __le64 *target,
+						const __le64 *safe,
 						unsigned int length)
 {
 	bool differs = false;
 	unsigned int i;
 
 	for (i = 0; i < length; i++) {
-		if ((entry[i] & used_bits[i]) != target[i])
+		__le64 used = used_bits[i] & ~safe[i];
+
+		if ((entry[i] & used) != (target[i] & used))
 			differs = true;
 	}
 	return differs;
@@ -56,12 +59,17 @@ arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
 	struct arm_smmu_test_writer *test_writer =
 		container_of(writer, struct arm_smmu_test_writer, writer);
 	__le64 *entry_used_bits;
+	__le64 *safe;
 
 	entry_used_bits = kunit_kzalloc(
 		test_writer->test, sizeof(*entry_used_bits) * NUM_ENTRY_QWORDS,
 		GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test_writer->test, entry_used_bits);
 
+	safe = kunit_kzalloc(test_writer->test,
+			     sizeof(*safe) * NUM_ENTRY_QWORDS, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test_writer->test, safe);
+
 	pr_debug("STE value is now set to: ");
 	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8,
 			     test_writer->entry,
@@ -79,14 +87,17 @@ arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
 		 * configuration.
 		 */
 		writer->ops->get_used(test_writer->entry, entry_used_bits);
+		if (writer->ops->get_update_safe)
+			writer->ops->get_update_safe(safe);
 		KUNIT_EXPECT_FALSE(
 			test_writer->test,
 			arm_smmu_entry_differs_in_used_bits(
 				test_writer->entry, entry_used_bits,
-				test_writer->init_entry, NUM_ENTRY_QWORDS) &&
+				test_writer->init_entry, safe,
+				NUM_ENTRY_QWORDS) &&
 				arm_smmu_entry_differs_in_used_bits(
 					test_writer->entry, entry_used_bits,
-					test_writer->target_entry,
+					test_writer->target_entry, safe,
 					NUM_ENTRY_QWORDS));
 	}
 }
@@ -106,6 +117,7 @@ arm_smmu_v3_test_debug_print_used_bits(struct arm_smmu_entry_writer *writer,
 static const struct arm_smmu_entry_writer_ops test_ste_ops = {
 	.sync = arm_smmu_test_writer_record_syncs,
 	.get_used = arm_smmu_get_ste_used,
+	.get_update_safe = arm_smmu_get_ste_update_safe,
 };
 
 static const struct arm_smmu_entry_writer_ops test_cd_ops = {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d16d35c78c06..8dbf4ad5b51e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1082,6 +1082,12 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_used);
 
+VISIBLE_IF_KUNIT
+void arm_smmu_get_ste_update_safe(__le64 *safe_bits)
+{
+}
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);
+
 /*
  * Figure out if we can do a hitless update of entry to become target. Returns a
  * bit mask where 1 indicates that qword needs to be set disruptively.
@@ -1094,13 +1100,22 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
 {
 	__le64 target_used[NUM_ENTRY_QWORDS] = {};
 	__le64 cur_used[NUM_ENTRY_QWORDS] = {};
+	__le64 safe[NUM_ENTRY_QWORDS] = {};
 	u8 used_qword_diff = 0;
 	unsigned int i;
 
 	writer->ops->get_used(entry, cur_used);
 	writer->ops->get_used(target, target_used);
+	if (writer->ops->get_update_safe)
+		writer->ops->get_update_safe(safe);
 
 	for (i = 0; i != NUM_ENTRY_QWORDS; i++) {
+		/*
+		 * Safe is only used for bits that are used by both entries,
+		 * otherwise it is sequenced according to the unused entry.
+		 */
+		safe[i] &= target_used[i] & cur_used[i];
+
 		/*
 		 * Check that masks are up to date, the make functions are not
 		 * allowed to set a bit to 1 if the used function doesn't say it
@@ -1109,6 +1124,7 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
 		WARN_ON_ONCE(target[i] & ~target_used[i]);
 
 		/* Bits can change because they are not currently being used */
+		cur_used[i] &= ~safe[i];
 		unused_update[i] = (entry[i] & cur_used[i]) |
 				   (target[i] & ~cur_used[i]);
 		/*
@@ -1121,7 +1137,7 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
 	return used_qword_diff;
 }
 
-static bool entry_set(struct arm_smmu_entry_writer *writer, __le64 *entry,
+static void entry_set(struct arm_smmu_entry_writer *writer, __le64 *entry,
 		      const __le64 *target, unsigned int start,
 		      unsigned int len)
 {
@@ -1137,7 +1153,6 @@ static bool entry_set(struct arm_smmu_entry_writer *writer, __le64 *entry,
 
 	if (changed)
 		writer->ops->sync(writer);
-	return changed;
 }
 
 /*
@@ -1207,12 +1222,9 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
 		entry_set(writer, entry, target, 0, 1);
 	} else {
 		/*
-		 * No inuse bit changed. Sanity check that all unused bits are 0
-		 * in the entry. The target was already sanity checked by
-		 * compute_qword_diff().
+		 * No inuse bit changed, though safe bits may have changed.
 		 */
-		WARN_ON_ONCE(
-			entry_set(writer, entry, target, 0, NUM_ENTRY_QWORDS));
+		entry_set(writer, entry, target, 0, NUM_ENTRY_QWORDS);
 	}
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_write_entry);
@@ -1543,6 +1555,7 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
 static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops = {
 	.sync = arm_smmu_ste_writer_sync_entry,
 	.get_used = arm_smmu_get_ste_used,
+	.get_update_safe = arm_smmu_get_ste_update_safe,
 };
 
 static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
-- 
2.43.0

