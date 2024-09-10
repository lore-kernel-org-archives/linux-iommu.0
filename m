Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311D17BB06
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951683; cv=fail; b=eJsTlpijQdYKd/Sq7ksNWyN6ErbjQXMZ5d6qMIaQ+kj8wm9ahT8UDlxd9HXqErbxP7rdEOWRFjqJSMnckrOZxEkyi5sUzdBipR/9P1N+kNMgvm9HuG9Bq+qiDu9N4ZdGkPZ3EoAFs+uP4cj+ElnYYuZ95mIDxAxRHLrWL0GlfT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951683; c=relaxed/simple;
	bh=yjUzYWx4a/iCLSt54K+f02zw7KF5f3MUPIhJMlSqAF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpPcaUi19fNjFADATWVvswRa8scM8mthJg7U1tnhzW+l9lE+Z6UMqOgXsgrC0IZKdYPd5Y/mklC37lhysp71ImVUF1ETKjqLIUYPg9WtIG1dR4A+YUB4kqR/sLZVZMCrEtlwe3/bXNmkJ7WFoO3Lo8s14zUmN+gWfS4eaDntlPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5o9dieMK; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5o9dieMK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DI1wmzHrs8FEayMIOCD03na5J8WkwREoVEA1omnIpmPJIocVZolx9ZnajxNIVS3OYRGtAoxWxudDFBNmZY32A0SFc1Y0wAL2jp6hG0qa6srNqgN855+IAO8L7GsWrG09jmlfgecb+v4BtO56aK/VFP4Dlogc9uXzMt8rjOn8He+Kd0NzfbB3sqjJpucx86/0yxQfs0DamrmC+mggdZam/lcOgPQqgTA/tSqF3QYNVHCgdjmIhv+/KSVOtM1xTu8gEGstzqXzLE3/kD5RcUI+xOiTjiCEZhsDqN77UXUNOtyi2erVnxHXuJ+ujGe9SeR2tFx7dUPt13vY5SLDMYR/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAR31qu3eRHq3rl00qqgzN/tRLN9HNQJbyTcs6M9v4Y=;
 b=V344pGXOCTRKAopamdHa92pvM3NstnZs7fGjEcS69Ep/tSP8VlPJv56cosHurOsUYp2hKQg6aN+h7+VI3v5GN+QXXkfb3GMQCfnEov5O2qX8ofYuwTRIfDYmobYAWqaOy24+dUrznNw4tmnavO/GKNMjDYPaaUqMIgRTOMgW9tyhhZvfsh1EUvg92WP0ZowHdmMdExfceQovrEveDCbSzmvUNnPV5KQ8v+4uR42nHVVNUnTp29vg7C0Lydawx5li08BP4ZyaSGcsjQfdDsE38SBlVxRGFzZQeXdelITiWPeAVBgCYSs0omaDR0pbAl0Z9c62sOjpIzzjRBcMjHEZHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAR31qu3eRHq3rl00qqgzN/tRLN9HNQJbyTcs6M9v4Y=;
 b=5o9dieMK0xg4ctdMMj/zXsooaJlZcJ0pHfhj4s3J95kf6VvWCvazuLK9Gq/kK7HiLehx58xbesDJcKoaC10LqEdvPb9jY7cIaa/KBpY8Zjouve+D/3YZhK+f4OItRqQn7tMjZkI+XCb0xr/s79gwjhGn+bD8kFSAHCzJ34PHbkE=
Received: from BLAP220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::22)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 07:01:16 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::34) by BLAP220CA0017.outlook.office365.com
 (2603:10b6:208:32c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22 via Frontend
 Transport; Tue, 10 Sep 2024 07:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 07:01:16 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 02:01:13 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 10/10] iommu/amd: Improve amd_iommu_release_device()
Date: Tue, 10 Sep 2024 06:58:12 +0000
Message-ID: <20240910065812.6091-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910065812.6091-1-vasant.hegde@amd.com>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f2e3b8-fff1-47b2-5378-08dcd1665d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ggKTVtj+eN4Ki1sI8ESs+ZpU2jfVf2VhsNEIYXAgIgPYSSgV7D1NHCKdgQ56?=
 =?us-ascii?Q?pRcSCBnKH3nksXwfIxoJ7uI7L68WfruoLedtAgYIMIq4e5IFvNwLA77aXJEV?=
 =?us-ascii?Q?UTdNnnZoST5xXhiapVj5Ad/fFeaKXuCubSbMyqSC41SpIDHRPsnZvbOVVtH6?=
 =?us-ascii?Q?effGpEsOW4zOq+CPgxR9gFvh6rmzfPZ5HDvuH2vGlD3GdNITFfQw+13/IGn8?=
 =?us-ascii?Q?+bMBVjoktHOOtA3vBZz0Ma7/CfGx498e2ehIa2xBRll+3rwDAKcuE9g+T6Zh?=
 =?us-ascii?Q?vQTVkpXhtg0XEf7t/D8Vl99d9LkHjsXWNiZEklVBYcOJ7tmRLkiUQum3C/83?=
 =?us-ascii?Q?U1I/G2Wv9XTAp3Zz4H1NUWxkKoUeazhtywnWzO1xTsk0KxrEZZWId4jPO7Mh?=
 =?us-ascii?Q?3JmNSB7roTSBEbXCFC+qpah1MZ3e0dmGlAQBz/BF1rs41d3ReZ9cBVdLbI0s?=
 =?us-ascii?Q?1i8m2N4NIzSu6Xkaa0oCxJvIU5SwO34BIuQkgu4aKGdtc36PQTYuFRd5XDZC?=
 =?us-ascii?Q?wZwygDHnGsITaqdz1/q9lp3jfBuwqRyzU/ugi1aA3t+ZM3+5qM6jyCBok0Kf?=
 =?us-ascii?Q?onDSKs2XqgY0cVKUeStXfyWCC+NX0jZwJZqPwYZC8FwZxRd8HVjzFJDRt5N3?=
 =?us-ascii?Q?JbfV64Idvp0zldkDQgNCtGLm6eHYCj9Vo7sY3x9vWoz5df2QUmz4SDHnTHxI?=
 =?us-ascii?Q?zB9LrUncmZfj2Pb51ARoXe0OvkHDt/MCnN19C3C6pe8W4c3oQPp5IqvFiFRT?=
 =?us-ascii?Q?hTKQKDUP9mofQcSKMI7Ny0DYaxcy9MBooezYyScsXLEma5x0I8X4asmFu2HY?=
 =?us-ascii?Q?bERdUZOi3kTDgoWls7bh92J6rdRtSZ2dsnQXNybkdUFeuIL0lULsZG284gVq?=
 =?us-ascii?Q?YKB8VAduuxCpk1pdBLrCssK5QL5gNmBbk35P0so7EhrKMAKI5SskeKpRBDyn?=
 =?us-ascii?Q?AY6k4bP7toWCnelewnKuu2wQ8/5m4XCkTc8Ep9MRkqiFg2JllHbrqz9ZxDmq?=
 =?us-ascii?Q?PazNTeoj5aIRFiGW0OwB1/lvYYIocAZ//JbDqxGwdK9P+AK2zvfirtmp3ANx?=
 =?us-ascii?Q?PBfXoqyUN9wvP6rcEI5K0ebeupIRn0ZYHShzBemjPzuS6fI4zgqmttfzb5PC?=
 =?us-ascii?Q?lDu0/EdtHDURRetWZfapg85ndQjJqFw2vN98sbVY9h3mjEgYdb61XoQ1oGzo?=
 =?us-ascii?Q?XGhN7ol15py93hGuIdmWur3wMe5QLUgYoJSydvz99nvAWGIN6RnqQpCOOGN0?=
 =?us-ascii?Q?CjN+LbQsNOBLyk11qN4aMjUAL+qmWKl7F31TfgMzFlIk9weYFEdPur41p6tf?=
 =?us-ascii?Q?V8geiUO0sQXsUP38opzgGz7gqYmU6Ue899qYUhU5dJJETZEOYx7zEgJdjjcD?=
 =?us-ascii?Q?C0XmIgb2dEwusOIWR4OlIvQBQPxzDvny+Co0EwH/CkyJLhjoEPmiNA5np3yL?=
 =?us-ascii?Q?utAi18iQjY7ybL3Jgr4EglXJr21szC8+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 07:01:16.3276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f2e3b8-fff1-47b2-5378-08dcd1665d6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807

No need to have separate amd_iommu_uninit_device() just to check
dev_data and call detach domain. Hence move these checks to
amd_iommu_release_device() itself.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e7fc59e30387..15895ddf1413 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -77,8 +77,6 @@ static DEFINE_IDA(pdom_ids);
 
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
@@ -2242,6 +2224,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 
 static void amd_iommu_release_device(struct device *dev)
 {
+	struct iommu_dev_data *dev_data;
 	struct amd_iommu *iommu;
 
 	if (!check_device(dev))
@@ -2251,7 +2234,18 @@ static void amd_iommu_release_device(struct device *dev)
 	if (!iommu)
 		return;
 
-	amd_iommu_uninit_device(dev);
+	dev_data = dev_iommu_priv_get(dev);
+	if (!dev_data)
+		return;
+
+	if (dev_data->domain)
+		detach_device(dev);
+
+	/*
+	 * We keep dev_data around for unplugged devices and reuse it when the
+	 * device is re-plugged - not doing so would introduce a ton of races.
+	 */
+
 	iommu_completion_wait(iommu);
 }
 
-- 
2.31.1

