Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BC91A0AFA
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680259; cv=fail; b=Xhe2XeZf+Cnhvz9qZP9a4hD0BVdfWMTtDK0zPzS1wl2DuJ6RS+ZBxe85teeFEwwsdpwyLXRttfPsYD0WeC+jdq8hRkbszKsc00l6qevxnxiG1VGvEjONAMua1YrYIFXiFmRwxOS+qm291fNONaQenz4lI/pb5gxlIxXeyx1oawk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680259; c=relaxed/simple;
	bh=9oUlbVQQmhJ5PzYQEiwm6VICgFwNDDl6yZd4Tuten2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXz8ND9iblejCeZyyFtDl2ndKv4nnNy5Kh02nuEYuto/zeQ2pqtDv8T+o6WXK+LooVi3SiQdEwlp/rw401uzim49Z3uSV8GLQMDGJb7Jty3LtIlEB/yEzpcz9NRx6I0ixNgzxnuefa3bFvCHeWdwY5LiW632U8AZvSBNKK2ZaQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0EdwY3fR; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0EdwY3fR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9SJQdwl/kG4k6wEUKN7DjDeHnnvw2blx5pnh8CJi5akzcXN18XHyKpDJktZsIG69W6dDZCxTWn8/DBpTTkhloSTEcmaGI+u5ywwAUXwNYQNTAfr+DEZ69N9Oc1rkWBhPMpPzdOKHul2p9YBYtz5ybiz3U6oSfbEh9Odl+aNvxpejlLd9FYz6jI4UD1sTfluqqfydnmlzRwS8StgcoQBUNJnliQ2ncZRZuyDKmw6LuBZFDKyy6lG6zK/ZN7XukHtYLsOckS77OeBIGOhH1t0gny1x8rkRm8gOr2WrsSvjZQ7SDlU8/u+uqJuf9X7KD4otb7L+muhFFpTcU7hPI6PZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVbxNsIRJt/lGGhOiieES5HryQJB7aXeZPpN3veGPLA=;
 b=R/WIB8rUdqo018KEZcUmOFtb85Stz7SfQYYiNntUR/KfpzVzRfLELtoIIcQo8lBRUIoZCrSy1hptdwCLL6Hhzn3BJ5Pnp2sHLLTBFLa9miT6YTIpk6zoX/qKX3WsxmptWhOHM9G5Wp62UhInnF0CH5nWRLcxfwuA9l3Dc6VCMpO3JhjL/SmgVuPRlOS1bEDaVvPNk91sZmQMa2+aXcS3FRRvtFZcpK582FUoUsjtH2uopdB/BmR3agOoJFjpx6J8Zls3feJhWTaK9Xae809x/Gt/4UqQ+YMosxj/h2aTmdbhJjlZv8pV9F96MCqZ3jXScuGgAd3nSpNDrhJtzfP91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVbxNsIRJt/lGGhOiieES5HryQJB7aXeZPpN3veGPLA=;
 b=0EdwY3fRQoiOSyDcgwm09SaZAPjZ4M95BWofC2gk8EIIuvcTRKG1ZYPwgE2uGOtdyPDZLR0scDfxIREvGeAgRDGHyeFMIuHQGijdn61xbSmy8yVVqSmxHBIZPEQKukCIk/OgcGVvlajvDgCcyB2O02b/amdZOcLq+pNYybDscVQ=
Received: from MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18) by
 SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.20; Wed, 23 Oct 2024 10:44:14 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::35) by MN2PR01CA0049.outlook.office365.com
 (2603:10b6:208:23f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19 via Frontend
 Transport; Wed, 23 Oct 2024 10:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:44:13 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:44:09 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v4 06/12] iommu/amd: Move V2 page table support check to early_amd_iommu_init()
Date: Wed, 23 Oct 2024 10:42:01 +0000
Message-ID: <20241023104207.5894-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023104207.5894-1-vasant.hegde@amd.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SA0PR12MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: 16fb2736-c319-4ddb-a84b-08dcf34fa2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wTcJCU0OX5BVJfTAitEDiYm0LcQUvd7PqNRRo1sQGuD/+lw+2fSnuaUQdTsL?=
 =?us-ascii?Q?2rB5A6ccw2UBA8tYtrHFVYjS14y98AFTZCYBWm4XF2qvLeerYhEGs188MoB+?=
 =?us-ascii?Q?XZ4I00ev+marReXGMXzhuUV822Ets/o958Q+/0mLi7oCMd+QlJ9z4yVY949G?=
 =?us-ascii?Q?8cRcu5FSRTpxtY0YalQflfCtCKrmWecpV3BpPvCXSDjso+KRHXKBAegcSA4V?=
 =?us-ascii?Q?NIz2YcoVjZ6v0qK5pMl/Ms44nRhcSBjJqMmXtRiX4+CUNvSGc7r9qMXbOPH0?=
 =?us-ascii?Q?0K64JOBKgvmuPBIk4ZloRFkBqj7WAi9W/q2R15Nrg3qCOCz8HOo8DiasH7cx?=
 =?us-ascii?Q?XBmpDZauinLhxp/McRFP5VX4DDFCiUm12ohpMnIFO4wJutZGEpIjBpd4thpc?=
 =?us-ascii?Q?w67J5Ufonvx6KJYdaVqLmJHFAyf7HbncXslaLxAETXbVtMgWHMYVtUmXsiBH?=
 =?us-ascii?Q?Opz+l2Jfh9jTQ62f+5bghM4WfSxV9k5hfRFDngWx8DyfQD7ziltt9Zzfr4cd?=
 =?us-ascii?Q?TQ3cfWqJNlN7LyVjqIWQVl1lmXPLYYay2rA9cufJtSSX5hOenSXACW2zUM9y?=
 =?us-ascii?Q?NIM6TxSSLYob2fMiFLvjPOL5Ty9Qrn6DhubjBMDsPWBS88BSnAn7fpqJHvhG?=
 =?us-ascii?Q?i+dewIikmu8OBCAqlQ0zpe7ejv7EtCepDRrFVjXnPm4yRW3hBQqYukIEriDj?=
 =?us-ascii?Q?khlTWp/sML5rjcmuXjFe4phECINmIyLslxcpBgCn+D7KVf7XIaCh3FI9h01A?=
 =?us-ascii?Q?lg/1tacqYFJ1phIv0WGU/oin2U1fNErYu70ZqbJMUPNruTZ3hECn/xe1z35T?=
 =?us-ascii?Q?owc9Gkdm/b5dCIn/ibwKiFIi1zbui11ErTHxpR8yKYSmyoDT7gY+F+/FT3vZ?=
 =?us-ascii?Q?AEoztH43xsw+gGi7LXK81Yt2b8032zIuvnF5V5s/lfj3gWaHm6r72vLKUrPH?=
 =?us-ascii?Q?0RNCPF1cUKqH2JOAuRVwlIT4Tkf1k56IAJ1n7cl0cE0UBwyTBHM5PPIGPe2b?=
 =?us-ascii?Q?C0Lhr/tzW3N0DmgXPegCLXmdwNyfeQU2CwPWBmRBygdp9ovH0nlBumJG8j0v?=
 =?us-ascii?Q?v7uBMTId4yHsyqa/QZvS/xj9I7WjCBXkWsHUMTxlFeIhe2YsvjvHHvNdbRLY?=
 =?us-ascii?Q?SfwFQymgYKqXIA6YZhAkrnHfAvWcF8qU0IdZFD0jfmcPpvxK+CDTJWtTud1r?=
 =?us-ascii?Q?rBGyY0xsYZyp4NCaTY3oUqXUSkZbZ3AQ+OWbZ0OXPLihod9gdUrAhaK0L6ru?=
 =?us-ascii?Q?qS5q1PvBdHTlexLzQ2AJ1v6N+eGUnhMjDQRRJLplcFGBhUKlwBNcGw/tp2OL?=
 =?us-ascii?Q?EmemhBB2G3pU1M4qTd2tx+Y82+HyKM2QWFkaa0I46/lEwpkNNEjkwIBSUdq2?=
 =?us-ascii?Q?aaiB7HJmoFWpfVxEJLoWUNyFktAgCIKxUWTiTsieF60NjsoyZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:44:13.8536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fb2736-c319-4ddb-a84b-08dcf34fa2d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445

amd_iommu_pgtable validation has to be done before calling
iommu_snp_enable(). It can be done immediately after reading IOMMU
features. Hence move this check to early_amd_iommu_init().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/init.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 7ae478d95e2b..7c883be22559 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2070,13 +2070,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 	init_iommu_perf_ctr(iommu);
 
-	if (amd_iommu_pgtable == AMD_IOMMU_V2) {
-		if (!amd_iommu_v2_pgtbl_supported()) {
-			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
-			amd_iommu_pgtable = AMD_IOMMU_V1;
-		}
-	}
-
 	if (is_rd890_iommu(iommu->dev)) {
 		int i, j;
 
@@ -3090,6 +3083,13 @@ static int __init early_amd_iommu_init(void)
 	    FIELD_GET(FEATURE_GATS, amd_iommu_efr) == GUEST_PGTABLE_5_LEVEL)
 		amd_iommu_gpt_level = PAGE_MODE_5_LEVEL;
 
+	if (amd_iommu_pgtable == AMD_IOMMU_V2) {
+		if (!amd_iommu_v2_pgtbl_supported()) {
+			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
+			amd_iommu_pgtable = AMD_IOMMU_V1;
+		}
+	}
+
 	/* Disable any previously enabled IOMMUs */
 	if (!is_kdump_kernel() || amd_iommu_disabled)
 		disable_iommus();
-- 
2.31.1

