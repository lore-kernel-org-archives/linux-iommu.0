Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722223A994
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540133; cv=fail; b=uDq/8wgJBbbD4pHZUYsqmoVcoMMMhI5OilPvKkDydXeLbeFNmI3uKVyzCcX15E/imebz0stCLZXnso+uTv2z0uE7J6DxijjrmCkhNuhynyN6hZjtrlBtJ8kWMj5FIhpBROGENKc5eh4xuAOFNs8WxqDsaP6hOG8qlfxXE/lPn7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540133; c=relaxed/simple;
	bh=e8w+kJJTWpDvNnIri4qzlJLkamQnd9zmXkfKm5e180o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h08cXxs42pCEPB7XZFxSP9fe8/LC606YeAjcoAaSFffCS4HhLh4zBURsU9AwMXG7bg/Ts08Ac+ZJ4p7vrn5BZi61V6BdiDkRvq2mzjHt2P31ZqavyPp3RN/70YLls8X+nVCGHHXvxhW4iDgixirG4S5ioB4VvDfnhxGGtSlLrYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eWk7daZE; arc=fail smtp.client-ip=40.93.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eWk7daZE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ak3ZM4uxIhbnzJ7ApR6JqXJp+RzTXZz/yPRUxquu4wsuJUwAtUTzlb40eLfUeB+5JZFw5Jt4xbINbov3RRaJz2iJv6JQgyKX9M7shwX5i9KU38KllbQUOfJFDoaO+UmcrWLaZhoMpsIqUSW1rYEKxY4zpBWUXo6KiVunJiiatiY/7mvYonkFA02/GgmlNUqbOfmOOlxqa9g3FOOPFUFr1zM1Cq9C6DL0/Ilpx7XZqKBZ4tORfoRuFoag3oyQ+E49PNEQG3W4l/y66ySTvY7S1h0x+p8g15Wox7RfoP4m9KRh7l5WnCF6Ql2HJw+OgmriIZTAAZIbnHhNYIjs/swWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bR1WV+hnSofJm2a+W10Fau6sfiq5FT+in6HkPRcmHnA=;
 b=uPm6Mo693XIXernUqO1JqVBjdVYjyE+jjbzvfxfvnDUTVnWSCgLMIDqqutVDVggoZ6L4h3O36gNNAEt+IiS1bus5iGm3I1wfOoHX1uQXXa1vOCxHyisGTxkcaBMMrJ+POb97pVRX3ZaWDY8vgdonzOhhK2B72VLaV06tnkvY8n7ulbZybZnZ41RWFRWmPdzewMH9AiQiWmqxyFjCUfxyJvt2Ts9Pd8QXKO0Ago2BWZxpIHNpJ5Of7mCAdrWH82aRwiA++C0oQKUF8lTZVBC6LKNy2fePATiO7d+a5ogM0z9x6tK+c31EGty9COGcqq+g2GHwO0cnEJ5WvDPsQpiySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR1WV+hnSofJm2a+W10Fau6sfiq5FT+in6HkPRcmHnA=;
 b=eWk7daZEiZIyBS/5syTc9rBZm1QzQ/iCY4m/Mq1JFL/2/Sl6bDhi84zM7LfneMSmfnoc0xQ3+z7AbfEcXqZocQspspODLDSWn+Fefkacxzub6gg5YN1qzc3sQ5N8PxhdRCBDWYLiWhjUqJXb4h1C6uLWuiZF4z7Nxerhq0E3B2SObX3WyQCqA6MZkMv11LH7phQklplSat7agdaZKf+fcY6hnWtdqUekCLyRoPA7l2XRCF0Gl55ZrioF7zmtkNjDoqfDnsjcGOC9dDkCuoV0zAQFGoBZfnTh0hmrr9NE2Mh07LURhXfEkevc3XVKXT+xs/7NUEL5LSfoeNgO7OlO/g==
Received: from BL1PR13CA0248.namprd13.prod.outlook.com (2603:10b6:208:2ba::13)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 18:55:28 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::2) by BL1PR13CA0248.outlook.office365.com
 (2603:10b6:208:2ba::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 18:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 18:55:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:55:06 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:55:06 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 10:55:05 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v11 1/8] iommu/arm-smmu-v3: Add a missing dma_wmb() for hitless STE update
Date: Tue, 27 Jan 2026 10:54:53 -0800
Message-ID: <b657710166d5ce662f74054a916d81fa8b9545d8.1769539310.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769539310.git.nicolinc@nvidia.com>
References: <cover.1769539310.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: b27217ed-c5fe-46b9-a065-08de5dd5a36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nZa0rxUQkbAuYW41usjiGWQOBBGnryjZelNUAVTBCY2897fVUAIu1zBSSsZq?=
 =?us-ascii?Q?ZUrc5WN/7aRpRhvZNMwiPIiLLqAeV3URmT8FvohxXJDUr7oMdmtbaD+vr9VK?=
 =?us-ascii?Q?nragH7Zaz/BrcOAonCBw/rctPD5s+npqBmZY0CZ6EHhrnqmxh+pLPxtv2zkA?=
 =?us-ascii?Q?9uFpiJM8HIF4oDEe8QRsr8v1Ixp0k171Mq1Nkhkne10SCOq0+dT+jHRdj0Ei?=
 =?us-ascii?Q?jgIBg5XWqRftB1x7eDa727amv2llVls4qAF4S/8zoI4q829FrA7UJRPSwZ8Q?=
 =?us-ascii?Q?yAH8Zg1QHkHr9ZvzNrp2bZEr5JNSBehfaKLmH4bI/dLE+BL475EyZdS1OJyn?=
 =?us-ascii?Q?c6ny9VSYxI4MKTCrgmn7KuJBnearai6l1viszZx06v4GU+ocxC+uQUPkvL9R?=
 =?us-ascii?Q?kxckWW8ApV46l7pAUKICFcKvu67b5HgI/NyyYYcP8cq0OUL2EaH2Phg/82TS?=
 =?us-ascii?Q?uVGQamzd7q9FFwSCEKzwjssGy93yOFLWlHCD9ldhHioJSJQy9U/6pLBluANn?=
 =?us-ascii?Q?Z9wPBff90nSuwhbIMcDWBhs62EfxporeN7VxQaeCXGvJSv3g2uOyWXoM6Mo8?=
 =?us-ascii?Q?aH3/a3XumfrV2PSgtVZMZTrKlAznS1hVbNLnKOWm3HI4P5npLbTryo3rLhQt?=
 =?us-ascii?Q?FUFNWkcSewGVRRNyZmhQnhN+au2M0r7hmRWH1dWnW0x0cSC6DqyjueWOjYmx?=
 =?us-ascii?Q?26syJWzr95Ujt1tSl1FEA0vFyzubiFIxs0IA/kLXVquVa+Ywie6yHtm8s3vF?=
 =?us-ascii?Q?8/0P/GDzKjikvBYXWwgLqLNbG95MB6iQvxKyCJZFOQbGt5J1PDFnblyvwINy?=
 =?us-ascii?Q?KK25f2GlKD/yhzslQxDm3PT3fGO6gGn3rQtxxyQCugW7WXp+h08AzCIrX7dP?=
 =?us-ascii?Q?0mrF5vMzVXbWtnkw7sJtrMhUdE7QpMwv/jPXGMaWI4dTsPAN7JrU8r2Ggxhx?=
 =?us-ascii?Q?git3c9hCE4o85fnCbuEtPJZV/8L91BzDpl1qXOrrpo782Dns9ca1vPZUm21Z?=
 =?us-ascii?Q?jHD5eIG2lMNxhBkwf2gxKDKmnxHedRxmVMDjMhMr4rO70IiNq4AaI66QLBJw?=
 =?us-ascii?Q?jAC6FFMEHu8VMQH9sTRKsCfzgMmWDLsHNoymMgSaMztSW5rlQIvk/xQZVDjm?=
 =?us-ascii?Q?pe8IKkNU6djAI4ON4t3DW5kPPKqBnin9uXSkwj2AuR46S+M1d7f0KAcxZtKG?=
 =?us-ascii?Q?l/06H1z283ntR1iGt2rtlLxyZcaIjym15ZhTPtTUeh0nhXQ9NilEslYbsuUt?=
 =?us-ascii?Q?WE2/hs6eOEj3pr45RGIr0C/R8ulWkoUIbCcPDiCvzpVSm51ovAPQIiuG5hio?=
 =?us-ascii?Q?CVre0IcEhEwnNsOY3J0tNmbiSlUMpz0Z0TOM3ci1hW6zEqfkxTJR5sNW9NT9?=
 =?us-ascii?Q?T+65bGQUGoIUfVyHstM07R2vRu5WGfsLn1xVsc/nKDnnarle2Q3+/YZsJa8s?=
 =?us-ascii?Q?wcj2MVi5eEED5bBP541FO+PquKhD+/UWWGeeUDcjYuvVjv47boCBoyt6oQBS?=
 =?us-ascii?Q?VFs3NA1XYu6gh3Csr3Lr0dCsUJOCqHDPHuw3D4Ckxu3Rc/bevQlsv7xj8E25?=
 =?us-ascii?Q?HUme733KulpteaX7WDnOKpCyJVbqKYbrNGpBAqragfrAJDO8EXhdu0a+MyIC?=
 =?us-ascii?Q?5t7pHi1SDLMS9PpfZHMVNZVy40ao7csN+M36VMFntkCep2aFHxhS+Srx5Ywc?=
 =?us-ascii?Q?w5tBwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:55:28.2412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b27217ed-c5fe-46b9-a065-08de5dd5a36a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655

When writing a new (previously invalid) valid IOPTE to a page table, then
installing the page table into an STE hitlesslessly (e.g. in S2TTB field),
there is a window before an STE invalidation, where the page-table may be
accessed by SMMU but the new IOPTE is still siting in the CPU cache.

This could occur when we allocate an iommu_domain and immediately install
it hitlessly, while there would be no dma_wmb() for the page table memory
prior to the earliest point of HW reading the STE.

Fix it by adding a dma_wmb() prior to updating the STE.

Fixes: 56e1a4cc2588 ("iommu/arm-smmu-v3: Add unit tests for arm_smmu_write_entry")
Cc: stable@vger.kernel.org
Reported-by: Will Deacon <will@kernel.org>
Closes: https://lore.kernel.org/linux-iommu/aXdlnLLFUBwjT0V5@willie-the-truck/
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 852379845359..f0e3b407c293 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1236,6 +1236,13 @@ void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *entry,
 	__le64 unused_update[NUM_ENTRY_QWORDS];
 	u8 used_qword_diff;
 
+	/*
+	 * Many of the entry structures have pointers to other structures that
+	 * need to have their updates be visible before any writes of the entry
+	 * happen.
+	 */
+	dma_wmb();
+
 	used_qword_diff =
 		arm_smmu_entry_qword_diff(writer, entry, target, unused_update);
 	if (hweight8(used_qword_diff) == 1) {
-- 
2.43.0

