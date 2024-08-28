Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AB2168489
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852655; cv=fail; b=TKIwHHb5/Wjj8Odlc5/CbkN701gXog20tVFFhWnt+V6a/pOQuNo6/83awo7OPUbjm4XGP/Ulh+XcIRTZsmag+T89ga9dmTXKwpfiVWxWz0Tmhv83gPqlwTG9eNdGZsdGwV7HxbLMJMOLxYwCKD1vpD7meG0MOFeOB/fRSDGrpKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852655; c=relaxed/simple;
	bh=GIlWqyS6PMnw3se/D2Hee6XjnhFG4SkV3+q0Ct6CEI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snhhdw/7oBKUWeYsNZhZTuKqSOBoqnlVkcAxF64h8iztLfQrY1kvo0R7AgCi/R3ZVQGDxYaZ9Y+6s1euJogVBSA0c3r1XNhsE78v5nSuUZAQI4taf05JJzVE5X75VgKu9zB64ngjXwexRUVbHSwgEuH0uSEK3K2ih34OJ8p8OX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YQw1NgKD; arc=fail smtp.client-ip=40.107.95.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YQw1NgKD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bS09w/iIALk1E6noVAHC6UE4A8xpr6oNVMz/7j3KMmhIho0IAv2ja8dEhHgHr9SbO3TOO+eaeRY2iHyurCtXt/O2VqbR/rMW/HMtr2ersdVIpmVBBpHizpdRlT3i7euwyNuLr5W0U8cajIzM3jS2hoOMMhVMSowzPyWS4SUBM8++CsqgvW/Y1CO2lzwDXc5Zzxc961pW3Soht7kD2Q92sa8mfttn7rJ9W0FvAJI1J/F2KmEFJrXOaVRRQulQfuWdJD8sSpwx9t8tP8TUnEZdsLviHwnCX/mh4PiHdvPvqJnQ9TtxVF7zAyPFJBDZL9OglQZ6ODwybNPWyjyEXPrJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snjX13kIXdD3EO/7vsr5y9RG4HKGwPNvRDiuzMt7wRw=;
 b=A+f/TOrz3q9/HsJNz719UIFlvNqE0Xr+q4Xqjh+9PqY1F772jViHzCL1oTqFrsyMSHnAEig+gFU4hV3sehL0XEvulV6YiogTKPyucx05QnL+ZZR04qE67CorpSWK0nlxWg5nMJ4h36yMkZBJTyHwhsB/stjXnhNvmLNJDsd8xpAC70wX1EZTNcvnrWqChWJXFJCa2vo979Bs/FQ/HbCq13V/bLMK9QWgf7lP4AI4lirKuspuZaF4mIZCZLVjjHWnmUAv9VzHEgpakEpJureLjCSDUVruF25aoGIYx9RjQW+etH6SoMAfstURUH6I2KDDxJLYJCoU4nmxuoYHD4BsTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snjX13kIXdD3EO/7vsr5y9RG4HKGwPNvRDiuzMt7wRw=;
 b=YQw1NgKD7F7DC7ov4WkZfgbV10r/B/vLkkIXlZeE54eRR7dO6uTClfgDNC3+tqDgCOXHtN+maCQ0vMY8I32Va1aTLbz2Y6Vjd9XLl/tPLKcPNFxleO5JnmjX2ry7h/stJA7HdzNr/0rPZgQSroq2NW+WHK8VtG5m3MGPcZMndqg=
Received: from BN9PR03CA0353.namprd03.prod.outlook.com (2603:10b6:408:f6::28)
 by PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 13:44:10 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::49) by BN9PR03CA0353.outlook.office365.com
 (2603:10b6:408:f6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Wed, 28 Aug 2024 13:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:44:09 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:44:07 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 02/10] iommu/amd: Remove protection_domain.dev_cnt variable
Date: Wed, 28 Aug 2024 13:43:09 +0000
Message-ID: <20240828134317.6239-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828134317.6239-1-vasant.hegde@amd.com>
References: <20240828134317.6239-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH8PR12MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 1570b6f1-7e5b-419f-144c-08dcc7677eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3X6rXUUgkvsrACe2wVKU+9wtE1sfcyE7mgS+LV7TIG9IhU63j9xCL9/UQQEs?=
 =?us-ascii?Q?NUguBWasCiclXlZ5oM1Eq97d7eMOgSeW1Kh8U8i1S8A7b5sz4ArQZfINelkj?=
 =?us-ascii?Q?qbjYCFpZIDBK0bFpu5UGdtuWuuVGhXCoYApL3TZA97cIzP7ALabzn04AUjaP?=
 =?us-ascii?Q?FJC+O5t855WJfw3ODJ86L9X9MUI0cDzhsObBcKLeaUjNE0S/nukT3hZu7wRG?=
 =?us-ascii?Q?dsSuXws5kq5jD6T61Key0xYkC87MbOGu/1Ym5R9blLgreLIuq1hajqwtnPZT?=
 =?us-ascii?Q?oCxEgLeqnMpnQYP0LgCqBFv3Jb+BBxdtYonqvzzDGMyKwUldcFBxtniA6cZM?=
 =?us-ascii?Q?czZ0IAMHaePQr3pAxO4gJqHUEZhbC8GvPEhvC4oSyqhWKuMeESn6ePGcdDi6?=
 =?us-ascii?Q?J49u2GDmJJwgtopcGGAqFsQNjLMW1uuJUp+LBqLAjUdAhMKEjpbA2OIvKqsK?=
 =?us-ascii?Q?kFTGK3V2CnkL7J4Q8BMHRxENdtpWcZE87omYm+xbqKcl8pfnAOMThLxcjKjz?=
 =?us-ascii?Q?h4yk5y/NZmpufsS91q+HqPJfiqWDB0l0b472uaj43FVho0lyYyLTIKWjb2FI?=
 =?us-ascii?Q?dKxjjecwaoBO/IMtjFrE2KpZxhpi0stnuDSrkhhu+1jg3zGIJ2rkWcG/1tQ4?=
 =?us-ascii?Q?cW8mahygaCfrQzyjWgNC8+bNNC2RzTVR354UzCmDqT8jLbEgwU5Ns8wQD3RC?=
 =?us-ascii?Q?xdjKtrOMnbQAydPaOzjcA+2ygwAfa56/G9LLvMK1Ry4lABYdCsZydKfVuf4R?=
 =?us-ascii?Q?aNrkfgpkHeAzcrnC84AJQrLx3NQAjzwJY2yquX8Mi+IgbmGdt1q+u7emb0L6?=
 =?us-ascii?Q?lnouReGzXGlDG8SPUkZJAqF1jqHfoEKT09DJo8J/d1FIS9xk6F6SYadmxPoi?=
 =?us-ascii?Q?rPkU06cOq1dO+bLe4ErXeXWqG/23Gu8uRRlucYIvOLmwtyluUaOqAldM6hNW?=
 =?us-ascii?Q?hcLvYiIlFCr3sjDq9jjWUvuH961rK/WgHsRw77MyI7k3Sa7qNRo090aZVchh?=
 =?us-ascii?Q?f/cjCBmYszQmyUuTAc+SVr3PEhURKvCyrX2LG3lcA3UKCgzEYAW8wTP4dU11?=
 =?us-ascii?Q?XnDl+RZULzHX3RGVQlqTVVXyXQTwgViM2up3mZZ61g82dzmRFQl8vFaQCcSW?=
 =?us-ascii?Q?53cIlssWlSTX/c8NiAfAH+fkcRf0NCizMq59/K0wsGQ9HtoqkEbRSLIpLEx8?=
 =?us-ascii?Q?b/ghj3yY7TXcAqMWw5BV+Rya0xNiKkbY7qHbAvymT/ivbHlwGN65ZVnRNBU6?=
 =?us-ascii?Q?UkqfdMusf1Shacquum176bBFOg+er2DufamVA0XVCVp0AeuHewPa6nWk42et?=
 =?us-ascii?Q?Czo742iJJ8116onIOaaqt7rnR/Y+YGKHZLGkUK3ehoUG074kRRco9zdh3Go9?=
 =?us-ascii?Q?ufbMJEYP0qyW5HwSK3nKyJygaNab2vFOHJWLYTItg6mBbUnIsP/dOmzqORkD?=
 =?us-ascii?Q?IhRa25ivNnZLN2yBu3C/Z4evAAK94B2v?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:44:09.9908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1570b6f1-7e5b-419f-144c-08dcc7677eac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028

protection_domain->dev_list tracks list of attached devices to
domain. We can use list_* functions on dev_list to get device count.
Hence remove 'dev_cnt' variable.

No functional change intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 1 -
 drivers/iommu/amd/iommu.c           | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5072ff46edc8..6655e2d71ea9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -575,7 +575,6 @@ struct protection_domain {
 	int nid;		/* Node ID */
 	enum protection_domain_mode pd_mode; /* Track page table type */
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
-	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a4f3d14e4ce3..748469a96975 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2034,7 +2034,6 @@ static int do_attach(struct iommu_dev_data *dev_data,
 
 	/* Do reference counting */
 	domain->dev_iommu[iommu->index] += 1;
-	domain->dev_cnt                 += 1;
 
 	/* Setup GCR3 table */
 	if (pdom_is_sva_capable(domain)) {
@@ -2067,7 +2066,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
 
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
-	domain->dev_cnt                 -= 1;
 }
 
 /*
@@ -2240,16 +2238,13 @@ static void cleanup_domain(struct protection_domain *domain)
 
 	lockdep_assert_held(&domain->lock);
 
-	if (!domain->dev_cnt)
-		return;
-
 	while (!list_empty(&domain->dev_list)) {
 		entry = list_first_entry(&domain->dev_list,
 					 struct iommu_dev_data, list);
 		BUG_ON(!entry->domain);
 		do_detach(entry);
 	}
-	WARN_ON(domain->dev_cnt != 0);
+	WARN_ON(!list_empty(&domain->dev_list));
 }
 
 void protection_domain_free(struct protection_domain *domain)
-- 
2.31.1

