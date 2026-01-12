Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFD8301489
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249259; cv=fail; b=Wf3AgvOFCXUzRaXMR+vtweu9wAYTCMpF+7hdpwlelR+CKWv/I7gmYASBfQcvkWc9EipYyHn9Pm4a37DwgNzbDeFe+XBbbsRy0XUiHNbIeTyyE/Ud4F8RSACzDr2HNrYR+avwQI+M65/Vm62zyK7lsuTDxXn5GQaWb9f9oeLBDqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249259; c=relaxed/simple;
	bh=KOgGbioykyoROtjjVWLa9LzedTXIWY8DLplCsoSYs+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVRRNLI6fHf+wDJT3LcaS5q2vBBFvHosOdTBDFbNvhu1vgsCMD/f4pLrxyS239YWZG0WBwcXcjVyAdw6tNhtHPSOzuBIQQr9xgRPJQCBqS0iPPzzbInpu1NO0NfwSqy5rR+oWHiqKxrbMTPdWlVGd9wGh4vtWoGKM7CPiTOZxPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VrtIGcdB; arc=fail smtp.client-ip=52.101.193.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VrtIGcdB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG/IB1elnqfFrT69x/2ybF9zfy12Vtx+JFcR856iNRKoJFpalkNISe2ESSbeQga+uzZLr2mprkAxKdmxSEjKFaaKxd7HxwphZlldZkQ9WFJcwSDxB66k4mKTnFV2d5xD7RzRkjQn0EQsYxb6Kmq5cTv4mgAomWWibybn9d+tnWPS0rTQ+jYuXBwxmZXscrp3sMs9nbE86RFcHoin+gILFLWrFkv0VLGvPPZsotUofy0bFapONSuV9yhHJmVw4omWhxG/+dXAkXsh0zm0uTCni8YvHTtCO0dTb6ZEH4WuYxURvImBR20L575HeFZZCmo0/uurC3e2nDAFWq4q9n6mng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vfxMggFRhq42rZRwUyXF7412+PX7DLmee87AABxQmY=;
 b=X7ImypkgHywYiOVJ3ZGZ9hX+dk7kXZQHiUd9u5a7pEO14St9ZgVwcjfyjrt2RWBpkX8b9xfdGrMR5ytp30UItByg4y9b1Og4myUGeQ6Tk1BWCAnw0fhlC5TiZA6dWBeCXY+W0RNm1kVzeNuJ+DXY9MqiUmWO3qPKJ5LfJs8TBSG3AxVU9ogK5KxwMYs+7MlCL2lT4tYve5EA9CgtQTfh1Gk+WNxzcdKYfYADuNsCYOPdI8wRHUdnDGqF7axrY7/4UG1aAUuH0FFLbrLohNfLSk1+Z+psOYLr58NeIa6lkHHUfrpk1J0QkzjI7ebpSIAp9bBRoy0601DqYqsev/Aunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vfxMggFRhq42rZRwUyXF7412+PX7DLmee87AABxQmY=;
 b=VrtIGcdBVdIeJLU1OkIoeOTtAlocbjOSjrIOJaxcTUQSIxaoofNQoehxRF3VCAmQRTD7P0vIOoaVNdFgcmFyxJXUKDrB3XEgeltvFxpjZp5iRCKjTL1kwLXqDoXKLYEA9F0b1akJJxkSanw1ZnygoMdXtH9rNBfzzVumSK2ZTGN6yDGDAuUSXTaqYfFCx4FgDMqgkfAm1P7TTD5vPX2ePkNtFL5Yk6YA8FRUqizdwW7Oi4U6d3rwQ0qkKo05sGq3mjGKvCiTqSNax8upZU0m8I6Z3vTfLQ0rrO4A4UUTH2bbj59WLkIYX5H/m9q0QA8DlIOCV1BRAi41x0mFqLLtSA==
Received: from CH2PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:52::34)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 20:20:50 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::a0) by CH2PR04CA0024.outlook.office365.com
 (2603:10b6:610:52::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 20:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 20:20:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 12:20:32 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 12:20:31 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 12:20:31 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jgg@nvidia.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>, <smostafa@google.com>
Subject: [PATCH rc v6 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix STE update sequence
Date: Mon, 12 Jan 2026 12:20:14 -0800
Message-ID: <b80ddc54f439a239e74bd7c0bf33ffb73e2eed1d.1768248467.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768248467.git.nicolinc@nvidia.com>
References: <cover.1768248467.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3d95cd-3a2e-4b6c-6244-08de5218145b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K38jKDOePbKf0yC6BA1aNo4/3caVbEd9qpzEW7TYUnfiOS8PlzjmuRw11ZGa?=
 =?us-ascii?Q?qsZnvsS43nfF8fIFvcEp6JoN6UYMcgk/iXbAnPVQtXwqFsbxsxjxb2MtBH5H?=
 =?us-ascii?Q?S/P3oMRpC4G2blw1Mt1TmGk9dChuAt32qnjiMFvJdc3FhhN8xBQMEd6wNfQf?=
 =?us-ascii?Q?Wyqlw5Q+m/HPtovWCjjhbUlC9CYsG/FrrxYs6ZY3+/oAxgoQKzvGB+MkNeMU?=
 =?us-ascii?Q?Pepj/WUVJPGbmOitUiOykoYKjbZBMkCNHaD6fd9WxfnCYAGyZ2bDj/naXDG+?=
 =?us-ascii?Q?6qOQGqfL7Tgw2eFPFvvaEc7WgCEU5u27y1Eh5nQvFnYGmXbJFWXiCAsYUfaY?=
 =?us-ascii?Q?iU4NRcHeeUypoL8LAjmUlhX/JR9KxSzrri8JMwDHjjSd02jJsPSRxmuDWukx?=
 =?us-ascii?Q?1N/Y2zi7KOnQcEb4Auwg+ilnkSWEhGFM/v/+/i35YQhE27kcHYnXNaeO99BY?=
 =?us-ascii?Q?Soprt0E3QYkj5ihYcM9uzTg8vuMU4uj3xf2WtJni4sg9eHXNtjAUYPqmodfP?=
 =?us-ascii?Q?AbUpNGuDz7RHjcWsiwAUuOl6yWf0mblqfGR534lKMIRVpUSpZAnoXWo9cOJg?=
 =?us-ascii?Q?Lhbt3hM/d0uzYKbvX4eoIFQpPLmaPbJK25GzLIIPNq/3rHT2hvbhgz1q/sSG?=
 =?us-ascii?Q?7kQf0oj/+ko+m9DqPM4EZC5XppTzJiZ8LUqylCdtnqpxaTNHdyA3D5wx/RcS?=
 =?us-ascii?Q?07GY1s2udGF3qb+Awy7t71huuWxjH1JETljHeEQoNHJWug3swcBaMGYorPsv?=
 =?us-ascii?Q?tde7Q9txr9REprjkgktmnz+EZ4GfPCNa2W+KbzZOA0DN1NtN6PXkfSZxSPmT?=
 =?us-ascii?Q?c9/yvCLpyZdkA6sngOLiPBSGGkqYtYRGdM0ddFvS/wy89C+ditP4vlvWHzYS?=
 =?us-ascii?Q?A8BiDIIM3GnYZzJyccsEcJIE0rKXQImjyDooaM8MdHSnzteeR/7CZlIKtW1t?=
 =?us-ascii?Q?eixKDKW+8Bn8YgjENfv7EjX+qCifKfqTV58ZtAuYKFeZa1SLEJ1bYs9hnqZT?=
 =?us-ascii?Q?sn1h5lwfTpK0LELZ+FenHB49O78FCXaT5zFeItOR8b/ygB2Frkn58/++cKsc?=
 =?us-ascii?Q?KMOU1aYmOC8C/GRXrtFj9zsx0Pmmd5NP/JwPI+yf0r9Cuca1Rdxd3BM0vtl5?=
 =?us-ascii?Q?xedUJIoQZbGPlgYtpfLb0iPmsrzb/HCQZ1ESeZRilay4j5q7cfqgT9LQ3S0C?=
 =?us-ascii?Q?XcOjr7A1vhj+LPSaYrG21sxrmmWWQeCUuTzB3WrvEK5xgYdT49hmyqskNDuA?=
 =?us-ascii?Q?WCixQjSD7M/vxwsz+FSkvqAvCEoL+AIJoz9gmGxThJWNuLkBJw+EtsoCOLIM?=
 =?us-ascii?Q?Safm/aByttHfjBna27Ae9T3dvMw/Qe72lI3le8nzgHK/cofQPOCwjXd5CZsc?=
 =?us-ascii?Q?nFnYkQXqQOwmccwLlk5rx1ZDJ9uhcjI/ziqUtb/5K8sPaQ4iFE/2BoWrkEjw?=
 =?us-ascii?Q?GyAAsJX5iOKIBzOQn/dNkElv2OQA9ds+XEzkULkZAhngKmIbBygrTB0Zs288?=
 =?us-ascii?Q?ZtSyWwPjIf8LOM/JJz4AvMeozK3nW5dT+ZvCMr6LVf8AokwcE9iwIlKC9iOM?=
 =?us-ascii?Q?car0XLQ01+BhiWKpRqk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 20:20:50.5877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3d95cd-3a2e-4b6c-6244-08de5218145b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072

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
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 +++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 31 +++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 28 ++++++++++++-----
 3 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ae23aacc3840..287e223c054d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -900,6 +900,8 @@ struct arm_smmu_entry_writer {
 
 struct arm_smmu_entry_writer_ops {
 	void (*get_used)(const __le64 *entry, __le64 *used);
+	void (*get_update_safe)(const __le64 *cur, const __le64 *target,
+				__le64 *safe_bits);
 	void (*sync)(struct arm_smmu_entry_writer *writer);
 };
 
@@ -911,6 +913,8 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
 
 #if IS_ENABLED(CONFIG_KUNIT)
 void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits);
+void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
+				  __le64 *safe_bits);
 void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *cur,
 			  const __le64 *target);
 void arm_smmu_get_cd_used(const __le64 *ent, __le64 *used_bits);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index d2671bfd3798..b254a94b2003 100644
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
@@ -56,12 +59,24 @@ arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
 	struct arm_smmu_test_writer *test_writer =
 		container_of(writer, struct arm_smmu_test_writer, writer);
 	__le64 *entry_used_bits;
+	__le64 *safe_target;
+	__le64 *safe_init;
 
 	entry_used_bits = kunit_kzalloc(
 		test_writer->test, sizeof(*entry_used_bits) * NUM_ENTRY_QWORDS,
 		GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test_writer->test, entry_used_bits);
 
+	safe_target = kunit_kzalloc(test_writer->test,
+				    sizeof(*safe_target) * NUM_ENTRY_QWORDS,
+				    GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test_writer->test, safe_target);
+
+	safe_init = kunit_kzalloc(test_writer->test,
+				  sizeof(*safe_init) * NUM_ENTRY_QWORDS,
+				  GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test_writer->test, safe_init);
+
 	pr_debug("STE value is now set to: ");
 	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8,
 			     test_writer->entry,
@@ -79,14 +94,23 @@ arm_smmu_test_writer_record_syncs(struct arm_smmu_entry_writer *writer)
 		 * configuration.
 		 */
 		writer->ops->get_used(test_writer->entry, entry_used_bits);
+		if (writer->ops->get_update_safe)
+			writer->ops->get_update_safe(test_writer->entry,
+						     test_writer->init_entry,
+						     safe_init);
+		if (writer->ops->get_update_safe)
+			writer->ops->get_update_safe(test_writer->entry,
+						     test_writer->target_entry,
+						     safe_target);
 		KUNIT_EXPECT_FALSE(
 			test_writer->test,
 			arm_smmu_entry_differs_in_used_bits(
 				test_writer->entry, entry_used_bits,
-				test_writer->init_entry, NUM_ENTRY_QWORDS) &&
+				test_writer->init_entry, safe_init,
+				NUM_ENTRY_QWORDS) &&
 				arm_smmu_entry_differs_in_used_bits(
 					test_writer->entry, entry_used_bits,
-					test_writer->target_entry,
+					test_writer->target_entry, safe_target,
 					NUM_ENTRY_QWORDS));
 	}
 }
@@ -106,6 +130,7 @@ arm_smmu_v3_test_debug_print_used_bits(struct arm_smmu_entry_writer *writer,
 static const struct arm_smmu_entry_writer_ops test_ste_ops = {
 	.sync = arm_smmu_test_writer_record_syncs,
 	.get_used = arm_smmu_get_ste_used,
+	.get_update_safe = arm_smmu_get_ste_update_safe,
 };
 
 static const struct arm_smmu_entry_writer_ops test_cd_ops = {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d16d35c78c06..390446d259ab 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1082,6 +1082,13 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_used);
 
+VISIBLE_IF_KUNIT
+void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
+				  __le64 *safe_bits)
+{
+}
+EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);
+
 /*
  * Figure out if we can do a hitless update of entry to become target. Returns a
  * bit mask where 1 indicates that qword needs to be set disruptively.
@@ -1094,13 +1101,22 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
 {
 	__le64 target_used[NUM_ENTRY_QWORDS] = {};
 	__le64 cur_used[NUM_ENTRY_QWORDS] = {};
+	__le64 safe[NUM_ENTRY_QWORDS] = {};
 	u8 used_qword_diff = 0;
 	unsigned int i;
 
 	writer->ops->get_used(entry, cur_used);
 	writer->ops->get_used(target, target_used);
+	if (writer->ops->get_update_safe)
+		writer->ops->get_update_safe(entry, target, safe);
 
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
@@ -1109,6 +1125,7 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
 		WARN_ON_ONCE(target[i] & ~target_used[i]);
 
 		/* Bits can change because they are not currently being used */
+		cur_used[i] &= ~safe[i];
 		unused_update[i] = (entry[i] & cur_used[i]) |
 				   (target[i] & ~cur_used[i]);
 		/*
@@ -1121,7 +1138,7 @@ static u8 arm_smmu_entry_qword_diff(struct arm_smmu_entry_writer *writer,
 	return used_qword_diff;
 }
 
-static bool entry_set(struct arm_smmu_entry_writer *writer, __le64 *entry,
+static void entry_set(struct arm_smmu_entry_writer *writer, __le64 *entry,
 		      const __le64 *target, unsigned int start,
 		      unsigned int len)
 {
@@ -1137,7 +1154,6 @@ static bool entry_set(struct arm_smmu_entry_writer *writer, __le64 *entry,
 
 	if (changed)
 		writer->ops->sync(writer);
-	return changed;
 }
 
 /*
@@ -1207,12 +1223,9 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
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
@@ -1543,6 +1556,7 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
 static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops = {
 	.sync = arm_smmu_ste_writer_sync_entry,
 	.get_used = arm_smmu_get_ste_used,
+	.get_update_safe = arm_smmu_get_ste_update_safe,
 };
 
 static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
-- 
2.43.0

