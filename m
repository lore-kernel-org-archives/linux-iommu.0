Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B58D189900
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852702; cv=fail; b=g8DUuxP06tjO3nN5v+saM5O4wIysIUO2030JoaALA40r3Ajkp48XlHZPpxDN29rjlLntzxE1ZITeJbmXUW3SRmUPWKnTNUtv2+4Ew7dtUD9RElmuSFtTO2lKF7MgvsjmFi4dRWcUIaO/AUjXLncYuBIivZzE126q5jcEeA5dBJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852702; c=relaxed/simple;
	bh=ZtKHi50lvqNzUDsPhwAmyOW4xWGxGCZmjucwuvJm9Eo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TI83Me2XqZZ0GuWby5i7ChpXMjZgFWC9xaRdvzNkln7GZMM+DXZiFD3XV33BCKJ8E5XJ6Pwgl6fT00hc40VrHsZs/zp9iYLg3YcbN2GYUGXNh9b2+T9v5c0qOEBiY4QaYJzfL5Ff3jwN5jbz8cKED0DzJASOZLIp7Jokrg1Cth4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3EO06xwm; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3EO06xwm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9YpnJXPjr91PxbhJY/Tw8IfbcP0nQpJ3PvyCy6JSnpZGfUmoBfXbqW8PYSWqZfCRubaIRwxxZCU9/5f+KCBlPKzNzeBqQnUQm2jYeZ2DWgvwl6de7EistkHPW9fHJdJrNqBHpKFjbe9DWka7F/aSfAfG25I9m8lgZDZNyqpsca695bt8Mk0e3VHOJlw0RVtpZNNrJweEACHyBkBlnx2UaGUQgzVsU7nLVMiDRwrGBvuUYkidtTVS2Zyd6usFvsUe3szleuewg+8DPcLwIenGrcDkm+tBsOrfTmujj9nlJ+fhBGNStIibrXzUjqeSv5It4GROQfaqDQ3eAa5QnJ+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2DNLOig+jhm3NCm/QAVoWUrakBAAkeTgZi2QpmJpdE=;
 b=KPKM9n/DggCf0VKdknKPKXezDbLqFafXE29WyDRUdlaD0/+Hea93vPFfzcYrKT0Pg02nIlEts4Rqc37FPKLb/rtVcd5c8dT9LQiTEXxc9IvTJ6eJyltCO8/MZLDb//wMzQ05gt7KV2795ZVGMYdN3q3p+ad0gBQZWdKhHBZViZCsYAAaq7YR1dRsmq0K9ZQj6lPjNpM1JHHwD/vyfowj3O6ST0GP50ogRdu8Pt+yJ3reacPJwUj+843Qfxh11wg2VXV9iwQ5NQ+1lUYNW8qSZoPNpPsoabS8v6yjsljqo96tp+NccF0DspBYzw71JD97TrJzEK/bhMKby517+uS9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2DNLOig+jhm3NCm/QAVoWUrakBAAkeTgZi2QpmJpdE=;
 b=3EO06xwmUCebjMF3lmzobLeJ5ievPRD1Dn5lunFX1raNKEDTWOZ1EjAjKeKEUNes53Jfgp3pGic6JGP0eWm1ZjBapWNg46qJbTeAhc0aAitA48qlxAkrGJKGKveETIAxhjPd4vmCcZMupa+eB5Dvt9uXTLb9b7czGND2Avub+wQ=
Received: from BN0PR04CA0094.namprd04.prod.outlook.com (2603:10b6:408:ec::9)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 13:44:57 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::69) by BN0PR04CA0094.outlook.office365.com
 (2603:10b6:408:ec::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 13:44:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:44:56 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:44:54 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 05/10] iommu/amd: Do not detach devices in domain free path
Date: Wed, 28 Aug 2024 13:43:12 +0000
Message-ID: <20240828134317.6239-6-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 751eb798-daba-4374-eb1a-08dcc7679aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8u5z1JgHXMECHcgET14zoLO7sqRfZgrcashn20ViduKAJrzBX5fOe9LQXHiQ?=
 =?us-ascii?Q?hVrJvX+jOk0tqkpgaOWrk0r/OrG9o9Wl7OUs7aqOt6EC8VKkinuQb60hZJLx?=
 =?us-ascii?Q?HQTfcfnC4CsWWW38cJvx+PmjtuVGojx/NbwUX42vhddEPchSmJkKI6f3bfQI?=
 =?us-ascii?Q?BhVcuyLNuhktaQvzeWqjQHuIlD+zmaz0tMvKcFWkXcaFuM6l98sbhHhVhMAw?=
 =?us-ascii?Q?aBW+GDbUIG+1WI+ZcQiTAZ5Pt95m06EWsYsFUfThe0q+Bd7Ppnc0y0Rt0oe0?=
 =?us-ascii?Q?/M0y9bSpvMJosTXveEKUr8kkCiC4PSXU1WpIYZd+wFu8KQC8Ph2Lq03Pk5vm?=
 =?us-ascii?Q?KYSjm9meHJhirNosekghslbHZizs5p9Au+pv5IsGjRwKy0GIg+iFnISL1O+Z?=
 =?us-ascii?Q?eDULRaPMhhQPWQ9d/GxQ8LwfimsZNMd4Av7s/vZmPX6dDJ0nf5h0MGfLzaAe?=
 =?us-ascii?Q?PLMbNZH/kXOWigaQb/8IiKCehdEQhYdl1HVsjgTsuyO0pClmIysvwQ0YZrzH?=
 =?us-ascii?Q?tLmL4OIOsUPZ3S/vnSpG0ltVd/uXslqflz0byoJzXzKk/n4mLHDorXDRrpZ5?=
 =?us-ascii?Q?3aME9b6hzNHgG9QruuWiO2AdMGynnelO6hfkoTJNblIrkLLFs3pX6l5S7i4C?=
 =?us-ascii?Q?/t/ff1MZPIY0t51BZXIztpuhM2ywwshTn2XCHCzVIpcHId1+wGkir00t1knv?=
 =?us-ascii?Q?1yu4Zwg4PwrNLbWp/L8ak3oIXKwBmNHtTxAgpVZ6U3wYN2/VPcfNzI/mLSPA?=
 =?us-ascii?Q?cxNs7306CPGzRmvTz4UU19eU7a7KwVIkmiDl20KXEwutRCMCK6I24smXhERQ?=
 =?us-ascii?Q?VSkItaHdR6FLU2dbCLKK1wbHLzeehCc6XHtMbyuSP8GWe+yP5BbkotNL8cxt?=
 =?us-ascii?Q?GR9GVwR4WdNb1f6JqHvV87eh/166psxxuessofTK6A90WS2xxj4sftlXCwod?=
 =?us-ascii?Q?Xgqk+f0rCWy2B3tvdzk8nnQ6AtotG9bWRTaoDe+XKSFCU5UOSVtmDGfszDgN?=
 =?us-ascii?Q?cFjfaEDZ5o9SZ6FxBub9gRPb+mJ+HQLq52yKQaS3RDmVLx610DSgWh/LUM93?=
 =?us-ascii?Q?GKv4BS7XPOLJKWB1KWFPLmcP8eOrX0UDS9IYvKGHMuYYa4mGOIijSL/Xszwx?=
 =?us-ascii?Q?4cPrCXiPN5hDHNxwsgycQNz2MUtaha9wpeUyDLYivpobiduWsqhmSpV0YvuD?=
 =?us-ascii?Q?jpjuul60Mio4fArc3wbWeqcs6dHDg/IcFYVLJfTsE8Y0G5awcWEnafieR3QX?=
 =?us-ascii?Q?SAaOE9G2I5w9Wv2pVVaOhbgGmc+gRZzE66Meym/nkQzyy9g12zWq+7S9oK45?=
 =?us-ascii?Q?9eEtHivdhPUjQZ3SthSCDo/O3zBFQTdCj6Is5lOIyUqIQIZbow5FsrAy+PWs?=
 =?us-ascii?Q?9pVtMoIvsB26lxLleoMUXEUlCKDx7z8JTjtg+65qfLZLR/Ly0qSvBCLl14n0?=
 =?us-ascii?Q?GmSQspi7Fh6bDn0i2QSWHk0a/R+BewY2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:44:56.8888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 751eb798-daba-4374-eb1a-08dcc7679aa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

All devices attached to a protection domain must be freed before
calling domain free. Hence do not try to free devices in domain
free path. Continue to throw warning if pdom->dev_list is not empty
so that any potential issues can be fixed.

Also no need to have separate function just to check domain->dev_list.
Remove cleanup_domain() and move WARN_ON check to amd_iommu_domain_free().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4ad72b517ae7..da3c42fe3e86 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2276,21 +2276,6 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
  *
  *****************************************************************************/
 
-static void cleanup_domain(struct protection_domain *domain)
-{
-	struct iommu_dev_data *entry;
-
-	lockdep_assert_held(&domain->lock);
-
-	while (!list_empty(&domain->dev_list)) {
-		entry = list_first_entry(&domain->dev_list,
-					 struct iommu_dev_data, list);
-		BUG_ON(!entry->domain);
-		do_detach(entry);
-	}
-	WARN_ON(!list_empty(&domain->dev_list));
-}
-
 void protection_domain_free(struct protection_domain *domain)
 {
 	if (!domain)
@@ -2482,18 +2467,13 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
-	unsigned long flags;
 
 	if (!dom)
 		return;
 
 	domain = to_pdomain(dom);
 
-	spin_lock_irqsave(&domain->lock, flags);
-
-	cleanup_domain(domain);
-
-	spin_unlock_irqrestore(&domain->lock, flags);
+	WARN_ON(!list_empty(&domain->dev_list));
 
 	protection_domain_free(domain);
 }
-- 
2.31.1

