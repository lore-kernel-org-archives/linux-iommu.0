Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A431D0E38
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115330; cv=fail; b=tbO+yXFARX29qHknaHmDkurzFeNhDjehLwpxaIvXrEUoKYGMi23TcnK/dJM1dc1SAxTdMuT0gnyvUS1XwCTONo5xQXP5tZ0s2iQuwtH3GRHqTb4e2EPm6La130befEonG18+pB8XA2yqwIvb5kelJ3r0P4MJF8PdcJqVsTGf/7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115330; c=relaxed/simple;
	bh=1zDKrwniCbMvIYhIwuMnKIYgOrgPXWqU/j6IV/6AryU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoLkpBp7Zm7HSmbYs8TiGTVc7NyyYdbF6fvvVatPi/9bqbO1q9xFTTS30C/HiWeaeyN8GDORVbeZkA7rlSKC6EOuSz4HdHHF2PM2A1gAoqpy3Wca8ke+7YGsbp+8mF9wxcw/Fa695CwqC4fBiJJIHij3GwOvP9EELxKC+vqDSj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HSqZS91V; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HSqZS91V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bExdd9fFzJoD5kq00CotkqMP+0ym4Jyl7cB+nxLpHGnalHU3eQsjyEYhojkN/ZAi/ZLGxx/cyBwenqgnXF/W+FlV3LBdhWHuWBrgZZCgTrOSgt9XwtPjN3vMDqurJmtzZpRBwrSw6HvRgkR2aouHRT+QA/u64f8MEOVhrPXan0GIzixckzL1I44ElA+c1FQlFu3rzpioiYBkrWguP7Pmk2n+nCOUnOpO70VnOvDUIfJiH0BhnAnE7KJo06Fg25+oTwiIC4kMT7BqEUwsfdmvp43lsRMDKl7Za9f4lwCElemBdp8QyvkhYT+nRiqpi6Y1HQ0KkrKnmXyqzQAvYmGpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcdsQ9UQFMMIc1yph/o1iJ7+RQT53p2hechcQE+TmD4=;
 b=ROqZT+3H3Q6s5hukGgh3Vtiu5Emi3O0ej/kcrAnFlM3U5qS6Q00IeUOftKYJTwQChgRdeFt7ElP/Q6IvmsMOSf5LhPD9Gyfcy9jNZ41JIdfw+piiAjzFEsKTAJ1iORij6d9bqxSizZlrTtXcc6zL5aH1tJbybv5/4sVElzbkfvfg0f8l55iwKkszKPJzVCGTlcqOyJqOZv7eYLx29EoJhSi2SWedlgcO5tc3vG9eA3wCawP4TgW73Izm/lM60Lnm2H4cZGrLqwrtbecFLZ4ic1Bcm/DTbR5Y2C2azBM1ZdnyQno7A+waOC1RwEg7dSrWaFTHfju+IBuxJufauG7LIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcdsQ9UQFMMIc1yph/o1iJ7+RQT53p2hechcQE+TmD4=;
 b=HSqZS91VAKl01VrEMlFy1MA10Iv1W0OQi5t4d63B5+4iY6zHkOJJ47a9dsbZq3BhZuPtHm6FK93sihlpozItin9Dp3y6NmnqFJeHcjZutCk9BVUFvPxwkPWm+5YOZGi20R+Y/5AyV6nvmDBUCGAGkIBYX00W6DHFXaNS4GDTFqY=
Received: from SN1PR12CA0075.namprd12.prod.outlook.com (2603:10b6:802:20::46)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 11:35:25 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::c6) by SN1PR12CA0075.outlook.office365.com
 (2603:10b6:802:20::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 11:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 11:35:25 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 06:35:22 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 12/12] iommu/amd: Improve amd_iommu_release_device()
Date: Mon, 28 Oct 2024 11:31:48 +0000
Message-ID: <20241028113148.5774-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028113148.5774-1-vasant.hegde@amd.com>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4e2eab-fd3e-4a71-591e-08dcf7449d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ab0Z/pNrHyLB9Z3Xjyz9bb8bnzU3TBj4wZ2JbJcniEZDXq/fiN48bPWAzLs5?=
 =?us-ascii?Q?U1uHaXUM+AN5uPJHFDLbccfqNufymCL0rULD5+PTbJaKvmwCEhjo+EV3KE4P?=
 =?us-ascii?Q?LfvR3Y5pX0AbctqP2jU8kH+Q+90SdRQYgD8gyCZsLLi12RBqzk2Aa2sKDSrW?=
 =?us-ascii?Q?Z8zwvjHqT8Z9BaOYZKZ0A5BMOrFHlF05/ZyKqzUzCiecDIilxdlvksQoA0XF?=
 =?us-ascii?Q?QDp+BbSk5OZ8NddGl5fr10R7xWUyt/Q+usobpv4UFyZWq3HUISuJ7yqzopyd?=
 =?us-ascii?Q?MqR5iUUIUrceYzsnxAhs/WFMOgYNlDVTU/CTmHY50rd1hehAJsVfuGfND1FZ?=
 =?us-ascii?Q?s6YIo9bQA9oskgr84ehB8nx38RUbDfF6YrTkLJKI/Sr/zYn9VhIYoo+cjg1V?=
 =?us-ascii?Q?dxYNkrglxdoTN68gsRVWTkgt1fPbxgabB3zYO0pVJIs7iZ7OsqCOQyJxF0Ok?=
 =?us-ascii?Q?M9suD0MzYXG/3ZsOfelfqav1KwRcSAQg8fAH12al72k1dwdRzg4ZCxKXrKAX?=
 =?us-ascii?Q?rOLhxO2B+i4TeY6H6RU2TjNkN8RBTwBAwmAdzx4gAK0p2ZfKeifnCbLgBi50?=
 =?us-ascii?Q?5be7bJvIP4S8VG4YtJR0+zDPzaNazRAQr2AzzoLgAxBThkeSxZ54YiNjnVq6?=
 =?us-ascii?Q?qsS+TvwIDUOrDAzHaxyfLJ1EuuaSKoEonN6tH25wyQOQ1V9P5VM6NepNfHG2?=
 =?us-ascii?Q?eQ1leZ68HzXqxwYf3HwqyD7mRGwXT6x0sCebG9GaO6KKnBzLtSFg5oe73q/B?=
 =?us-ascii?Q?xVnNEp7/MUzkLFvqwdecYlRGVWHpyEVNna33w5C7rFbb2LQ1WviwCdfCOHTG?=
 =?us-ascii?Q?LfXuZx9OUjUxFynYD4Eah1egZNQO5l7hxZpNU+IKIfLcmfNa0RtFVT2n2ks3?=
 =?us-ascii?Q?jja3SZXddfnPT9RefmUo3fmBehaJKrVvbyQTiZVX6n/5VUGVU5l3O2tdgIRE?=
 =?us-ascii?Q?BI/wlwXzcfGevKBzHyYyz9/5uUcPelhZp36259v3zwC9IhpmrwCQDXN16uuP?=
 =?us-ascii?Q?d1M9Yc1+Ahb/rm9DyCN4F49y5jQnSA0Bs9YeARISWJ9AnM2pgTjmGPrAZliZ?=
 =?us-ascii?Q?RTim9Rwl9or+tk39GKjHoV2TvEN0aaoqZ5q0pPIgSYo7AB0uoP2RTjhi1Gld?=
 =?us-ascii?Q?YqJ6RTKIbm2ThCHuUWorbyP2EPceIRNKMCBJRrXeLFnsz/xbi/RFyp37sj1z?=
 =?us-ascii?Q?3ccIJLmYA6L4Az0ZZiEQNdLqodwtK+3bnUGjuMFrE2dAMtks4cDJXtXH8cyc?=
 =?us-ascii?Q?xo8Fa26YgjmW5sQhUPQ6DaKiUnIbUUqEcXjm9sJkxtaPrLNNnEFQFkvgDpEV?=
 =?us-ascii?Q?ZRBL24veOqlgMPURau5djSeacLmbyLLEj9FXjIBe0j9JJ8n6oIfLNe+jiZTd?=
 =?us-ascii?Q?Xy92zyeJooUOO1+qzADdzBBEEmczEX+MiEnTgY9MWplFvJFUdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:35:25.1913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4e2eab-fd3e-4a71-591e-08dcf7449d8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763

Previous patch added ops->release_domain support. Core will attach
devices to release_domain->attach_dev() before calling this function.
Devices are already detached their current domain and attached to
blocked domain.

This is mostly dummy function now. Just throw warning if device is still
attached to domain.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b613636286c1..fc408340dca2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -77,8 +77,6 @@ DEFINE_IDA(pdom_ids);
 
 struct kmem_cache *amd_iommu_irq_cache;
 
-static void detach_device(struct device *dev);
-
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data);
 
@@ -560,22 +558,6 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 	setup_aliases(iommu, dev);
 }
 
-static void amd_iommu_uninit_device(struct device *dev)
-{
-	struct iommu_dev_data *dev_data;
-
-	dev_data = dev_iommu_priv_get(dev);
-	if (!dev_data)
-		return;
-
-	if (dev_data->domain)
-		detach_device(dev);
-
-	/*
-	 * We keep dev_data around for unplugged devices and reuse it when the
-	 * device is re-plugged - not doing so would introduce a ton of races.
-	 */
-}
 
 /****************************************************************************
  *
@@ -2246,17 +2228,14 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 
 static void amd_iommu_release_device(struct device *dev)
 {
-	struct amd_iommu *iommu;
-
-	if (!check_device(dev))
-		return;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 
-	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
-		return;
+	WARN_ON(dev_data->domain);
 
-	amd_iommu_uninit_device(dev);
-	iommu_completion_wait(iommu);
+	/*
+	 * We keep dev_data around for unplugged devices and reuse it when the
+	 * device is re-plugged - not doing so would introduce a ton of races.
+	 */
 }
 
 static struct iommu_group *amd_iommu_device_group(struct device *dev)
-- 
2.31.1

