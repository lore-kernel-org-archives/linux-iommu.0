Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035092EDD40
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766094232; cv=fail; b=JnF5lWYGH98hbVFOuqR7SBG6rrWIYhypVHYDldDbFwF8qKTGYrd8ndiMamSyQk6y2DJiaMFkxUe9DqtGHVzp/lopw/Jf4fB3PegiHXXDQpq5n8l3Ep9DawMSzH6yw+6zQ8CUDD2G76d/hAORWe31COFPmEdta1INkkIYPuDdxsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766094232; c=relaxed/simple;
	bh=PhdGwCIV00i1T7PfsbxGAR6qEzk7ekCO12PJF6jlpDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgtquaiDqcuCduFx8VVDSYknhZxPtqjTO3nDwpp0NG8OiA1+khCY1R+tQFyjDbW4pFoKIB4/6yizghVa4kvRDhTMpC38ywBhxKMlsMG4VM7cayeiGYBSrYayrvr98+g+xcDYHf89zN1JbJidAH1+PRnyQnmcEw3tF89KtOSi4bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T7VLIT+v; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T7VLIT+v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTogMhIkMuP645rQE87W+Wbi7XmvH2bUTNhF5b/pRZ30tCxqpCY0sLMzb/DA7ZcqL+fBfVl2ALKRyQwFBtHKqNOnwvNz8sCTBNsEOyZTZdtdXju4k3caP0TL3dch1fIJqniUU708yM+eERkqlANHwYzbtmNE7yAtk13q19X1nnH0rnEvJLF0pSnEGk9Kyg9pkynfA1ChZ4FilSBcuI3N1l5LoNtzN3/ZIA0JB1uM+P0cvWYAspBaO46xMs0hFiFATVx4zS7izBAH72aaIMJbG/MubP2zJF7GJKqRuOKNVkEf/HxTwkUaBKyuqt3OBjQPDRw7BmLy0Kp6EIiJBI9KWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5P6R43RBzsyBkSe/PsjJhJlVcbrO4PgfzUML1o5VOc=;
 b=ZuNeDcWiZvHbgpH5T0MrliUbXMBIfyNvtWz2uqEbJ5dmr/vh4H3GJR6KTh/E6WqC8h0SHUdlkyJQw0J8fdt2Y3cueaSWVXe+wXEqANx0fUfhPXQN2FjkNUzcVx5OLvnie4MAxhOzJPsgQoSjgb9iuX4lsjpPN7V+yY7S7vnTxYzyJJ/7FEVhz87CjBcfVem/CJ06dAsFiI5iLpa740MPlXvX3WGrzU1IAjj7KJBCfE76pElEK1LMhCCtsFfyEsLbcFIhWKmQ7klckFRlZ19EI2aiQ37kpX411yHYj0Q1ouv/b71BbFlWj59GpkOUQ/gK7Y/878nIgvENHL1FRjynJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5P6R43RBzsyBkSe/PsjJhJlVcbrO4PgfzUML1o5VOc=;
 b=T7VLIT+vOl6ApZDvHy3WXoY6ZN5KOwuoaKYKUZOd2p9xhw4UzrQiq0/5H9m6N6fi8EpWjvqUcuOR2Gj8LKF3CS8/o595591ziUZmZ0VIuuCDAGFqC68v/7SkyWdTf6b8flOytkOG0KvErRvoaBFOyg2AAgBlIg0BC9VPgZUEKMaDnojQPIdZeKfuyGGiwBCYXAGFmJ3tV3GG/+o+mxYQGiA96vcnn8RqQRBqllpG9y3CcDUmKmHrwOSGRPjPyZHv0j1IPV7HM6ZpllwqUTai1HJI2G60Uj+FrEoX42FdBwEnw0ROcxz+hhz651sIGsLFAUlJdfxeuMF083raQ5xY2w==
Received: from SA9P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::16)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 21:43:40 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::d6) by SA9P223CA0011.outlook.office365.com
 (2603:10b6:806:26::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Thu,
 18 Dec 2025 21:43:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 21:43:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 13:43:25 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 18 Dec 2025 13:43:24 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 13:43:24 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <jgg@nvidia.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>, <smostafa@google.com>
Subject: [PATCH rc v5 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix STE update sequence
Date: Thu, 18 Dec 2025 13:41:56 -0800
Message-ID: <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1766093909.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1766093909.git.nicolinc@nvidia.com>
References: <cover.1766093909.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: becd68c1-e8ed-4942-78c3-08de3e7e8243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GfuDiB4kWO7BNCdXiCpeRPSGCD3maqH1lzIfRxESkGvD2w8UPYsWlxKPpuI2?=
 =?us-ascii?Q?qAhfremQ8wB36PzNMhXxLHnGtFHcxa2XQ6WiPVhR1iCVCAQBIAHFLbn5zqiN?=
 =?us-ascii?Q?m4phTA/fUBWKYQ/KatPUXhPckV7lbHAGwvdpYqOVa8HPF+q0SO3hXmsa3q79?=
 =?us-ascii?Q?hLVgoxu3K0UGBh0a2fTgXTgtzdWzz0Tl7l9v8Tz1hhyjbC7XClIsshHcRPiS?=
 =?us-ascii?Q?ADSC05/pd7RgUpxa1fHk0Oe9tSOQGY6c3aWTrxVKJO3O0i1WWz4FWfA204QK?=
 =?us-ascii?Q?oETR7yiZ6GHDTbkkxIWTcpP0D55tqq2eEennF/PWFN1fImyUvPs5OWUt7Il1?=
 =?us-ascii?Q?JvOHO5cpIH3UArBtvTty6vRX5pYOEqQT4Kc7NptmtUMXzJhTJdBWqTTk2UM1?=
 =?us-ascii?Q?UAfqYz+NPtND583ogMocujJcWRXCtnu69CbdPLPjEh5E0TNnUNS+3tvFy4yy?=
 =?us-ascii?Q?iYaYkajjrXIOXSOl9JXYP693gyIrR6xsHtGq1XfyJJwfTnPTbJ+vL2M62DNN?=
 =?us-ascii?Q?1D5y/D8gUucyF+sECRqb53SQMqTOl7qq1SY/uPn17qMNSUdwR05bAkX+k9eC?=
 =?us-ascii?Q?4gAiuVGL1Wh9xqm7txrFwm44EOZX6vl6ErXrOkKI2f3Q9BhYw+CUZyIlm0pG?=
 =?us-ascii?Q?i5imnQ9ITghQ1ou4MQ8cr3LsoQzgy6AO70no5fTU9f5LiMMNuy1LqYV11Omo?=
 =?us-ascii?Q?i3+m6BeZDyrX3Njm+lxG0ROi7rs7F6MStokKhsnFOJ119qufH9HKAPCcjahe?=
 =?us-ascii?Q?NaClCqidqBrkZSa1MKvqgC7gLCXtEwQClyD5XB+OY7jAtTyEwZprJPJCMwWm?=
 =?us-ascii?Q?9NnRLP2on8+QgfjsboR94cdcBEaMJC0pKwprh+v1eLEfdA+t9OfML5aa1NaS?=
 =?us-ascii?Q?IBlyoajo0150Hvhn40JfLm+zFnlSVNLdxZLhpaZQTzeI47Z4n7o2QsJct0TU?=
 =?us-ascii?Q?IynyAPry3rWSLHpERnY4Wxt/QU3tJ+mlxI8mAHb4nt7E8deESC95xDFCdiIU?=
 =?us-ascii?Q?ZkrxC7lLbEOGzE8aAWUoCit4AXol1BbSaWOuBeHw4JcCOoci3azLCJ5y6R6V?=
 =?us-ascii?Q?fr0yr2WrZRJqpe+/CS/9c58BU3QxaXmoCRKPGAye32EE3TilmpMx3qgEcfC6?=
 =?us-ascii?Q?Rws9jUs0/VvJiuctUcDl03f70g5S+V6YzL6T3Kc7HRfcW8Pp56bRbvlLX5AX?=
 =?us-ascii?Q?/3cBJEJfwyER/EyThvoMIR+XbQpjT5m4xJqVRfg1ykchX/iA4I7hH3lFl37O?=
 =?us-ascii?Q?0YsleXe0MoOAm0FwSGbrXO2xYdxegnVG8jg3nJ/VJxsdPbl29iHS47IqAVTL?=
 =?us-ascii?Q?e9TMT2oNfD2XRfd55sUOnAegrhqKEQgTScdue6D7gfgD7gpfgPeI6wqVNLhn?=
 =?us-ascii?Q?fvqnu16YL70uPr8s3jm6cmAXQO8dYy3kpQ98h9sUtFB0HzScvbLPzeZBhk9V?=
 =?us-ascii?Q?eAMTnITas+ZWxYvyoqs40DPOzYwfYBCyupMPgHwymgL3pWP2blDRPvqJ9hXq?=
 =?us-ascii?Q?OKHbJmdoASjrKmUi+k28TGbs+xl2UlnSx4MifJtlJKrwRrsZ2bXwvDXMLQJd?=
 =?us-ascii?Q?YFwNbynXUH+jaAJqDAY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 21:43:40.4208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: becd68c1-e8ed-4942-78c3-08de3e7e8243
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

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

