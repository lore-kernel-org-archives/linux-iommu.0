Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2F25392A
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 03:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483387; cv=fail; b=ePcuezWzWk7341rBqjm+EiDr3iotgzez0l33/JnHnngDq7DswO34W1aQQK62I+LwlhGvp0g2+9DjrItbBtF2nPD1XPoQUUMfBdmd5SbNGpr3/9BOANtvTfsCQl6OfoaRLpG3gaPFfl2DZY84ed4y8JOMM7x84aYKDNIydptvg8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483387; c=relaxed/simple;
	bh=e8w+kJJTWpDvNnIri4qzlJLkamQnd9zmXkfKm5e180o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nogsdDpCeRmhldMiPFY4teuHViJa5NzAcSkZ0mnrx7/T3sKC7u7yjUTxKG3gekh8wyPPTZSN/WiooSFKz5t50cw4wMt5zEF9nkvR459a+L+qmR3btHamzGh+HlAB82NmricV7a828FM43bteIRfyoVUply44i+s1043vauAsS9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XA6vuvBo; arc=fail smtp.client-ip=52.101.52.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XA6vuvBo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXioHBJVFLRpnuboZLQzkONi+Is8CKHVeUClgrTnfkI/+HHBnw+qpBI4s7qJMmvGYMqhHhsiNpEqF8WqhJPQQs6d3Obg3BnyCWtNr+KNeZRb2AzirByccTW6foGrQp2ou1q7/r50aJz8SE40qgsr7P6F1cfkfUu62twCF0TMjxCS6keKq0ohid+ToxJPdjX/Do3XVAQU6i2MaeNJWC+OGmco0sAEewq3BuDnLvTKgE+ip/bJlM44RrIbBzwMN1sJUDU/uOc4yl2ZE8oCV0rRnJHL1fi4RUGKjOOR39mPuBDeI09IozHvPDYcBTpiEULsaYVYGrZgI5cZBFq/CsXvdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bR1WV+hnSofJm2a+W10Fau6sfiq5FT+in6HkPRcmHnA=;
 b=ueCifcrMV1xT533SLv/UT6OhiB4UuQCizMWCn6Ze1Gpmp/C9KSTin5AzjWGFwiBJxu4b8H5sXYky8oAZqfVyhRpEplVkiODfp8gmVA+vmclpHaFiaVbwlVo/KHnXFw/gEJUu5tZHIvwezoWxjJQtIRLtI/1jFhOiJnLW+4EapvGWcqrLFTnGVdIx9Y1aXnelszOxJ6bt7FZ3Gzi7tAYlDF2SASWE5dtMaOpIMnQo4ORmnK9ECsvW9WRNvJqbih+qf61LdSKDcTaAwNyLjxyHbYdSMWA9PSEML8tkKmCstJfxzrGqeHKJ/bBtIm8L5mmaZc8Aqu3pAhIKcyWXRFpRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR1WV+hnSofJm2a+W10Fau6sfiq5FT+in6HkPRcmHnA=;
 b=XA6vuvBodTJrs8u9WKnU9s5kIXTmoPhNugsQi9z43VXbYweroezo9mOH0YNXotZY8UaTT7AMr/iBGrZEhvVrENXXK7RL5kMBuljEc2BjMeEjmLHPRE42V9SslyyXPifOHxHzX6vM7uMGpS8R1DTBqUurNVrqpNDTMqLtP3Q4OmLHl3yDGgZktRakYZD4E6tKDIu0kZKZlOjxKiMld8WBlu1o/dFrVMHIHP4Q18ZZBQXxgRfk21URoliRweeWeE32K0rqzwL+lapAjHX5MFluzaqAObfYssISYAsW7UxfO4e6E3LlRclqiaXL8joLa/l7QzGmLjvFCriTqMNsq9BrIg==
Received: from CH0PR13CA0032.namprd13.prod.outlook.com (2603:10b6:610:b2::7)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 03:09:41 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::63) by CH0PR13CA0032.outlook.office365.com
 (2603:10b6:610:b2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 03:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 03:09:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 19:09:34 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 26 Jan 2026 19:09:33 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 26 Jan 2026 19:09:33 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 1/8] iommu/arm-smmu-v3: Add a missing dma_wmb() for hitless STE update
Date: Mon, 26 Jan 2026 19:09:12 -0800
Message-ID: <b657710166d5ce662f74054a916d81fa8b9545d8.1769476588.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769476588.git.nicolinc@nvidia.com>
References: <cover.1769476588.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa9c70b-4199-438e-4f97-08de5d5183cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lkFV7ovoHYJFhTK52A96KTWxGdonXlt87P2iNeyR5Ln5D/ZzyT3g1nQNFHGd?=
 =?us-ascii?Q?8MCzbFgLQqqsdXtJkxYZYfxMta7+IpyM4oQodvN0/liyJ9wErSPQZTkw+23Y?=
 =?us-ascii?Q?rMyf3a81A7HsnU0kiNswYWYssHSXEi5gOEuVrGYXOvs1dNrTY7w5+9U0NCfq?=
 =?us-ascii?Q?PcCKfvtHdk+nlSCOIcgo0sJdTX27cjB+/PbKWbeEJgnnssCPOdySZsEhqsVZ?=
 =?us-ascii?Q?XcQDbh2hHk6JVGmSS0NBaa+cRf09feYXvKekwLFpxHcdPvjUgiYnLF1Hu+os?=
 =?us-ascii?Q?JeXpzD21CivvnH3y65JXZf+/CcrzRtgmz/gakrRcYzIjp2geyEWY339dTPPa?=
 =?us-ascii?Q?dhpFIjo8fkBEwU/II7Ms75Gy3MjFotfxBiwa14YPEWXATo/w6ofrnAczzU0N?=
 =?us-ascii?Q?TIb9MeH20CtRi1acQeV2faFf3VXY9jw3ubmFx2FHBkNPiPn+SvyqfyDBTTOY?=
 =?us-ascii?Q?VENdXityEW2yLmbaUDCH/C4XpCK7jelcH3MbpOd5SOkhs8IH6bvVAuyHU14Y?=
 =?us-ascii?Q?ag2oh4zvs5R0Pg3W2miELctvkuapnYvc+k32KKxH3COncA2xcq2bW5JK7F0A?=
 =?us-ascii?Q?JG/vyoSkHd02DqPAEKDCTUR3VvVhWXLUqGjYI+CU4fi3JS3KuGOBH7RcD+nd?=
 =?us-ascii?Q?eDVA9O5o/uw0xM9wzaTIwcqmtE7BGnnArfWoHCWFsh488ZQbbmDLlo4JXGq7?=
 =?us-ascii?Q?hlMro+MFbLM/nByxHyUBFQJO5ZcvcidtcChC0Bwnd2ttqyp7iqfP2NKfUljC?=
 =?us-ascii?Q?uZmAdrpFDeW6BQHIYtiv1y91b0Z+3qkNPLrDn7rWNHs8DcuiMPKyo87knnMg?=
 =?us-ascii?Q?lZjTpWdlSzzx9ZEZHKjUSbgHmLExkLJPOEr2BfxXSivLXokWJz0uqLxewMc5?=
 =?us-ascii?Q?z/nsicrb/VUoWvpAiUvc7R1QPG5B3KAytFuuq+e9ASKheYN7uUT90t132HLM?=
 =?us-ascii?Q?QOOgv5eCvU/W0MURJAtlkG8hP9r3F2ToxssyesGCJWs170U2bNXConE0DQnm?=
 =?us-ascii?Q?CHp73Czs/j1J3uVJGbSJTJtW2EicqCkCGL/jqWtPTfTrMRhNMiT3dm598B5u?=
 =?us-ascii?Q?F1tDbFy+4XSw7XzvsSvMnVqiVxhjI5YV0+L6rMEf6REGsorDuk9T88WrL36I?=
 =?us-ascii?Q?kpzI5sDsqgXPgI7Bkg5yq3hrCEeHDmY5ZeQ/tUUTtbVqSyqk+BpyghzncXNh?=
 =?us-ascii?Q?5dTLvCOkv27dEfYnmzUuZm5WX+ZWCYyhKQo7XKQ8CCqCTxCyd2MKJZ47sw8l?=
 =?us-ascii?Q?bQeHUzDis54sj3JLTlGYnLg/m4tiT8WBsKi7Y3LsE5ogpJ3Uh6TYNzKaOkPr?=
 =?us-ascii?Q?P6hlim1hslwwgbHcwlQuwCrsyjZHdPIOzKeUVzfKZuaeUHFVjzZxdVOt6sLr?=
 =?us-ascii?Q?zE/p+tDlBU66HqeHohV/UoaE3Na+mYkS0SdOKc0xSbJBk2KM6wtuehX5+diW?=
 =?us-ascii?Q?fEX+MipkaBLI4usJgBtp91vTVE7HnYj3AYMaH8BpcQgltN4lfzknwNveIAeI?=
 =?us-ascii?Q?S2ida5TAkL/GW08dKP4pT8PJbRYEDPjrZcIzSEmK0h/gG+sL8N8u6IO5BUUX?=
 =?us-ascii?Q?4oBBAyPlKMA4X7JqCH7mBCplfmxib07nH3lN+Nrl4x5BerZLO3RDOvHlsLaV?=
 =?us-ascii?Q?r5hxMbfpeNw5O6Kma2rJF4pMGtotc0rC9ULdNXfb4vqJwjFsB9x/lY5XOSVg?=
 =?us-ascii?Q?V57KWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 03:09:41.6591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa9c70b-4199-438e-4f97-08de5d5183cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086

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

