Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82E32D443
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249261; cv=fail; b=mGSv5NVkZWSgUml3Sc7dueeDtyE1Bau2mIs6pifMdDkDJb7sJo64L2SE0+/QRtDm8AMGA4it1048TCDBDOv8se9IXfgG7eXUpTjfeX9qQNhcgmU1VjULe6NZWB4JmjmaEKxMYLubUnHEw3heZgVK8a1toWbx3PMDuRY7u9Y8z54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249261; c=relaxed/simple;
	bh=E1nm8taLbPVgyaZrABT1cIHNFSED/VOTI6h7kTAOFK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUAFB7D14gK7q6qraHqHo8mHDr2/CanfxN1i7AESzDr8mliBccm0MprQg/nuKEXY7MNvTHmRwkr9F9Bn1ddYSxnkA4qXbCtr9MsghP1hfp5b87ZVek2lxaWTMIFHG439MRJjkE5GT4GIztCRUkLGDfWQCWcLf7nBcVjNb7jQxGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qMRCTqso; arc=fail smtp.client-ip=40.93.196.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qMRCTqso"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLrQb0HAJBpsMkfdpaq+ke9xrHkZoXiHDPx0q57vZoGBG74xvEwH5D3ev3GlIJYcgMIz+rV4WxWLetopxcZ+m8WNK9CqL548OJjXLuTYvn8d+rKUXAjNawmiLxPMUvr29sIK/ZAOOhsrZMJFqqGa4EWJkdsV+h0mA+4CUUOc4T/5R4C6j/aGeMhhKcyFTSGOJ1ncLoVn8K7GUb8msT2MMTLPPvf/dmYIMb7MfySH4QiqEfZwQL2BSiSEPcFEJeF+HGpoSIdX7FDf5vK+owV1vWJp+TVJZJ4st/e+fwR4gO4qS2BoD2bqlTwgQCU0sKXZGLT0T6QidyEthGZNroYYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhQ/l8zlOW/dB5Nz1HUCH2e0aQ+NjZ6t4sg0AaKC5Lo=;
 b=XidrvTwh3q5fcfmSDJfmiTlMdKb1XSN6lG8CMvkmUgH1bmC2f1eOvNWwd5tweZTtw19Okpqt7TUueWjLm2GS0VySVmtmGDKeDMeDsChYm33p/+bm95wL/QQxuSwFlQ7vfui0BUQKLgQt4pgKc/Ay2wKIMRsx0v9SK6Ge4s6mN4qOFdxbt4ySOiK57R3hmq5yBhCNgE8Ph9Mwx11MlXMwISUx1hddQy1e/IpAzjgVov+OckraDPqYrlmyCZIpQESr/uVxoKNPnwwT88S/Z0SMG9VpZozgL2PSTeE9KTdBooGpwIJ/BJzwDfbs8zR6tWl0B1Z2xK8QLkmxxF9pQ6rFdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhQ/l8zlOW/dB5Nz1HUCH2e0aQ+NjZ6t4sg0AaKC5Lo=;
 b=qMRCTqsoqBMbq6lp5lWZdU/cjKOrppy6M4ThE5f89O8PMRUOdnvFzAv5hU0ipKxl+Q4p9C1X51IOjjBS/A7OhO5SWF023EjAO+WqWVyY+lnF5oKqOyhHwoWJSc/oV5qZnRICIhYRU/y+q42jv3HWyIInnNVjDH3/edKdcHyM6bxw0DRgn0EYHjo9qDiI5SSOfUe0/xEbXOVIfgXmmjm/Nqod/HgJLx29rgfPbvbzpwsUzJoZTz6Fr942AoYQHVd8DIQJLwGwXbc9QKdaKGIio50TOPZwbk20Pr0qmNYzH57I9lDe0KsINzJDtg0U0A2OW1zxbEfkhS23DpBbKkyzVg==
Received: from CH0PR03CA0204.namprd03.prod.outlook.com (2603:10b6:610:e4::29)
 by SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 20:20:55 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::a3) by CH0PR03CA0204.outlook.office365.com
 (2603:10b6:610:e4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 20:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 20:20:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 12:20:34 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 12:20:34 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 12:20:33 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jgg@nvidia.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>, <smostafa@google.com>
Subject: [PATCH rc v6 3/4] iommu/arm-smmu-v3: Mark STE EATS safe when computing the update sequence
Date: Mon, 12 Jan 2026 12:20:16 -0800
Message-ID: <b8055e0f0f1b4473db2583586350b4f7aa8f3b4c.1768248467.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c6a9b1-9b79-4340-3fe1-08de521816f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J8aVQerNugRxJZj9ydWLllI1h7PlZ+YqNKfR4ThOSXAN6qPW7bmO0hhfWbxa?=
 =?us-ascii?Q?YZChj/jtfXGOiJWf/PMXh5j2t8XxYIWkrJvaPvQDdIqNR6iUTbfKK7tl8Q0+?=
 =?us-ascii?Q?APtPpumXYoEaDek8ZPH9B1FT2hhe58GfOh9/NQf26uXfA4IuGbQzSoiDbmjk?=
 =?us-ascii?Q?MVCRrSaIJ2FwdQOb9A9HI5iPVFCJo1y6HCzN1xGtEoexXiquPkd5m2lOQj2d?=
 =?us-ascii?Q?4Ic9Vi5QasWrFizz+JfpSLt+zxgN0sqcw1dbzLGANucc1SqVIe+yAFh8L2/u?=
 =?us-ascii?Q?LyLxQU11TGAjGXjpwETJjdyMN67Ax19+4y8VDCW/1H2idvkYG+IuzekVNE2o?=
 =?us-ascii?Q?4WRvDF37jiFm9vj7XwQ1lSkRGYRaOnF6hgdoN7i55HD1ROcoP7ORXkJu9bRJ?=
 =?us-ascii?Q?bQJgPNS0MS7v2NXITBtgOYRLTzL6XsEobHiZeBXPJLqAeDpq+W6wntQKtCrJ?=
 =?us-ascii?Q?lTiJlknYouKwcwc/+Ueh/0RS2A5cD2uhtipWhfhAXf2KcqqS32IZL7Ntfssv?=
 =?us-ascii?Q?9/wfaDbvznnnQC3vFyFOOCzwRWKtG5LxAN3VgUvHMh/W6wh9ztrozHMdTtBE?=
 =?us-ascii?Q?TM2ELF6QHeHav5H+2kT62G+86563JPwvK54UtYmj0ocq2quzZnVcXPYgsPtK?=
 =?us-ascii?Q?WgIVcJxeL2fJz5IYooK2d/RTsGFg5WOmBHiNPA19kBgsKXcQkPNIEieKPgTO?=
 =?us-ascii?Q?BcwZFsaMlJLfoWC1EZ6pSpy10evHuYte/v6QTZRFbpp/JO8D8bgM5TAPOTEQ?=
 =?us-ascii?Q?Iy+vY3SNUjmgAbT8xk1/uMe2K0g+KdfEtQdkj02HOkr/nX097GDanRfBDT89?=
 =?us-ascii?Q?rZzcQX67JkJQzz+RTdZfYz3Q5+hS6QJXHT3A+5P4IV7Vpon0hrsxkCPbf03i?=
 =?us-ascii?Q?hTSkFA0rQ6N7dtJ0+WgHLbLGfJCTyAb27/smiEoS7sTLEUYldBI4+cdco3zQ?=
 =?us-ascii?Q?PeMk3Rx5Uc9GWUaHJFxjJdofGJLdHAo8D6QNJ0L04CoRJ23mY8kvMVUy7FY+?=
 =?us-ascii?Q?Xvf+XS88vjWR0sttU6tc1stE48QfLHgo2F8RpEEjOI5yqAkOYQqgyzGbLyTa?=
 =?us-ascii?Q?El/QovVoRAx2S9OFb3tiiXNKa61z82AiaZ6oMfkER3XIqEy1oHFB7iVTFjWJ?=
 =?us-ascii?Q?phhKrM1DFwI3hjBn429M8VKbbpGV95f2W05WCqeka9FeJfao82Lo+y9kA2O0?=
 =?us-ascii?Q?QdFqsVlBOqfrZt+hs5XEV5ivgNk8Y2Q6XlxFmXfGAj73KeSvW5q+rTr1Jh0M?=
 =?us-ascii?Q?vfScl6pyf7VFL/kaRwioJP5tKXZ/B8SGHHZ0orNdytN+8357o6oB0H7JaQtH?=
 =?us-ascii?Q?xzdZ7F33ECVc6pYhM6AmNcLt9DC999ca8iMn7zIo4k087e0BFSSmt3dVYcel?=
 =?us-ascii?Q?QVkVeur9/3IKFvnrcNmvHdp+Nq984mleAlIf1Bc5u8YuJoimPqovQzgnv89j?=
 =?us-ascii?Q?zlw+vXFFuW8b0U5mE8EEwqzO/oVHz9WrwXeGVF5krUIAG6noMebU2wqj0M8h?=
 =?us-ascii?Q?4l0gjGRs9qIlhRvQn69o7tfq+OSrpbKDJFa3qILNq6N8Pyfo3FppcSkIy00k?=
 =?us-ascii?Q?FqcDTHl9V346k1dSG1E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 20:20:54.9574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c6a9b1-9b79-4340-3fe1-08de521816f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248

From: Jason Gunthorpe <jgg@nvidia.com>

If a VM wants to toggle EATS off at the same time as changing the CFG, the
hypervisor will see EATS change to 0 and insert a V=0 breaking update into
the STE even though the VM did not ask for that.

In bare metal, EATS is ignored by CFG=ABORT/BYPASS, which is why this does
not cause a problem until we have nested where CFG is always a variation of
S2 trans that does use EATS.

Relax the rules for EATS sequencing, we don't need it to be exact because
the enclosing code will always disable ATS at the PCI device if we are
changing EATS. This ensures there are no ATS transactions that can race
with an EATS change so we don't need to carefully sequence these bits.

Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ccd6357fa5a8..58008fe94ab3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1096,6 +1096,24 @@ void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
 	 *  fault records even when MEV == 0.
 	 */
 	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
+
+	/*
+	 * When a STE comes to change EATS the sequencing code in the attach
+	 * logic already will have the PCI cap for ATS disabled. Thus at this
+	 * moment we can expect that the device will not generate ATS queries
+	 * and so we don't care about the sequencing of EATS. The purpose of
+	 * EATS is to protect the system from hostile untrusted devices that
+	 * issue ATS when the PCI config space is disabled. However, if EATS
+	 * is being changed then we already must be trusting the device since
+	 * the EATS security block is being disabled.
+	 *
+	 *  Note: Since we moved the EATS update to the first phase, changing
+	 *  S2S and EATS might transiently set S2S=1 and EATS=1, resulting in
+	 *  a bad STE. See "5.2 Stream Table Entry". In such a case, we can't
+	 *  do a hitless update.
+	 */
+	if (!((cur[2] | target[2]) & cpu_to_le64(STRTAB_STE_2_S2S)))
+		safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);
 
-- 
2.43.0

