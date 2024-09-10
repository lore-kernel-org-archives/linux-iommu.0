Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D617B50A
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951652; cv=fail; b=euVACq2qTG+2yPERY1Ur8JmJHhVd5Kjo8LMIXs7e5ajGRNw7Lq/WLzs8f5lNPDOglaU91zXawaCdJU1x5FF0DQKjU1h/+A2vArvGsqF7u+fsk9WGK6vkoew6f8fzQphDqEE0qCWniYlcO3y9Sh9aONR7Kl6Fwv++Dsv8lD2ZK8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951652; c=relaxed/simple;
	bh=SoxpyNcJNUG+Kq/Eq0MrwJhONuLxaGIQrMmpMnEAI8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLFKVKyuyor+Ej1JYiCl35acGwMi+2Ox/7nw1e4TvGH8f3gQpPn2PQI7n3fizmPXSP+RytfpSJZPcmgrW6EbVhdSsuYpP9DY7FfeMYoqzWwQ9tnh/yVuA+2B7LJNVnAtzIhLKpqtfmiQ7G0DUsI/hqFn6RK6QSoFK+sNYMsq5ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yJ/nSrtu; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yJ/nSrtu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/Ih8SoB5b346tQVsAfQzG6otXeaZKKAdt/Vui7gaaiiDIS/VqxkTqIF8/Pa5QQwvh+ppfZNuVSPkRZtv0Bo2Sy0D5+7C2UT8HkutI4idc83npCNrSG+BDC6RP3vMqTJnMLrm97S9mYkHpvFp7h2J8llITCG3rU/584RtxsEWolGbSJFuIjitJVPtd6qTGXNJTf88Xfg7ZXX48ovrAipwvBithU0voXW6kaAfSDYOcFgn4X9XvqXvqkMOaD6mTElQ3nEUAEpDmtcMbajJj/1E+LyHJ3iAVo6I1I+qD7t2qH0pA5PaMrdvyoGJTdl9UZ0aZDwMZvkRTHNr5i1LILynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nIVhGbvdAY7sRjoHYU6fPKwqXyszWRknTwMBbLJ3WI=;
 b=UvbJDSzk5ghFwFcltCAnEzYKe2JCweY9WUaZvf7qV/P/7MnffhOfEiIznc4YJggWBwIWCBAQp5YNQ2L8F7jM71h2DCYo+YzH013di3pXKqmlTXgF0Hf8Po2gdUgmKScJrMhTCe5AmY3P5KoWOqTK6TV4rAr2vgFFCbHWHT8sMcy1lxOG0NGmC23fRwXYH0VH4s1C9KsdHjhdVQUOmSmBS1GWVawa/O4NsVSAfNAlMnfPhOx3CWp1AyAqsFLdoGheAYzthfcCAeOg0GHjnBpIpmEYZoQCecuxjVc/4SMvGAxrSIVhHz/6U0+V1A5mXlpTOhSs4BpDlEKAejAYCoA2ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nIVhGbvdAY7sRjoHYU6fPKwqXyszWRknTwMBbLJ3WI=;
 b=yJ/nSrtu9uFjdfSbuP4taTp79pZeXK5ogdHAuRRmxEjioI+Qruub3wj1y6A/Fak7yHmXh0hb00pTjNcjY0f+G5eQKScvbszpjngl7irwNJGIKTgmdon9jHNbOy9LJOqDRmHOyDokZiUxdrj9hboVDoxGjWQsSKNbm+SJUBSLdbs=
Received: from BN0PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:143::16)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 10 Sep
 2024 07:00:46 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::56) by BN0PR10CA0002.outlook.office365.com
 (2603:10b6:408:143::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Tue, 10 Sep 2024 07:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 07:00:45 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 02:00:42 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 08/10] iommu/amd: Convert dev_data lock from spinlock to mutex
Date: Tue, 10 Sep 2024 06:58:10 +0000
Message-ID: <20240910065812.6091-9-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 0470f5bd-b148-4ffc-c04d-08dcd1664b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wynQfTzb0rP/TV4J8g2532bA3Qw8WV2B1n65ux9O9dTY4VEF+efPYxLmDx5a?=
 =?us-ascii?Q?hwG2NhsjFYWkhC5s0kc5hDXcDm1gy5EjDx3KKf/EDfwjrI3haND1xWuDK1AI?=
 =?us-ascii?Q?CL5qZ3aqc51l4Pc/TcBYuvkGFUFfmrf3Rv9DJRg5uuc2R3E9edjlMLPxDwik?=
 =?us-ascii?Q?IhLtzzoy6ioAHd6yC4wTiJVN88mYw3P8jk5/b0WtbFT72WVoxTYvHnWLP7rK?=
 =?us-ascii?Q?caiD8NKToi03e2UfT8pGvSVDAQiJ5TuMuWA4UW8PA2MogoVbuO/SpTKg2Y7e?=
 =?us-ascii?Q?SiBjYB5MRzNroLVrzPoKHTRUfJdSilYI/vxiB2cEouJEP+whOqfnE89RW1IU?=
 =?us-ascii?Q?qfD1sMGPvoVwb+StoX6N/7fMupG1Zmd9ReXvXyKgO1AZCLetCI002D3YINZt?=
 =?us-ascii?Q?mKZPTo2tCHnj8eKDYIlhxV2bO2Cym9OcsKBEM6oEiGQu6tY1Pe4quegZH5jh?=
 =?us-ascii?Q?IfGDWh6Kp+BcK2vYHwaoESLG9u5gx0COhos3bX30oGywn+JaUD5HtCBIogGD?=
 =?us-ascii?Q?DO/IzpORwXyyHtqFRbNqK3jk3ka9Drla02lDnno1A4smMu1PCEcWTivrDBIG?=
 =?us-ascii?Q?nhvAS0wR50jqEztA0ZnLuT7DVY0GBlGJoxruAhH7ZON+YC6Mm0w1tqWs9qlw?=
 =?us-ascii?Q?1f/+VHffabDwV8A9tgrz81au7g1MJbU1jlPUBFZWvterMU3vskQqzu6WkH7w?=
 =?us-ascii?Q?WVq9xa4tbY/Rv2jEOSXW87LZ6NjI3+EIC5DwVBeybK+2Lh+eMb6ch7dyYF9e?=
 =?us-ascii?Q?OqAfWAvrLje+m876xeRtZxUohhjst/rU2QnrDMwVLsdx/EwsJJfwBN3rpyxt?=
 =?us-ascii?Q?Amx169n61bPgig1TMVJ4W9PXsBUUeZX8O0FAferufmmn/xjMdXW6yOPlq2bD?=
 =?us-ascii?Q?HAawCI6GI/UugPy/RZEvzX74F2zyVOMYufdcPxraCdw2Y3FWgBYY8GS4PZYX?=
 =?us-ascii?Q?JYQW0oKDjqKcc5Asiz2Qeys7D9Zu9wBWGEs0KXSOLuIO5Vbf4VseRIrscp2I?=
 =?us-ascii?Q?1DN5ydc1gCRVaBvmUmZN893xiJJ42l1WJneCkPDXZGRfoxoTRXOS1kaA2FIp?=
 =?us-ascii?Q?Cfs2bor4PagDWX7RZTaXm1baiH30/GDO5RDwBJ7TPKx57HG92MCAqbQYFB/Z?=
 =?us-ascii?Q?Q02DwjKYenWTQCp4ds/nG5K+A66SbVMtb4Y4y6KaQ6LGjOxJmhxKpAYuoxgJ?=
 =?us-ascii?Q?XTgb5YvYlOEpSG37Bevd5L29PzCm3AhE+xIwYh851rwwWlAGAU59yeCy8+6o?=
 =?us-ascii?Q?1UR3+YQeKDxNNi3a6UmR+Od/HKgiWFfVRlGG40CdTLLFaDeVU28z3Pa2vJLR?=
 =?us-ascii?Q?QR82fUv/6J/OCeZZOaq+OUpLnPY/7TToO1/zSRkYtnDgiE5DWvjcYfTsT9WO?=
 =?us-ascii?Q?fAYbYTDI/Lc+lyW1cz8QCSwaiFKz4ndXUt6bP0PZ4izLy3DlGCk/jvflcSXB?=
 =?us-ascii?Q?b17y93C1jkJ8Qan00qJD14AhxuG6hwL6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 07:00:45.7856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0470f5bd-b148-4ffc-c04d-08dcd1664b3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667

Currently in attach device path it takes dev_data->spinlock. But as per
design attach device path can sleep. Also if device is PRI capable then
it adds device to IOMMU fault handler queue which takes mutex. Hence
currently PRI enablement is done outside dev_data lock.

Covert dev_data lock from spinlock to mutex so that it follows the
design and also PRI enablement can be done properly.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/iommu.c           | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ad6ce13c0b7b..a13c347baffd 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -836,7 +836,7 @@ struct devid_map {
  */
 struct iommu_dev_data {
 	/*Protect against attach/detach races */
-	spinlock_t lock;
+	struct mutex mutex;
 
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ab8bedf55459..0f83e1b3fb0c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -207,7 +207,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 	if (!dev_data)
 		return NULL;
 
-	spin_lock_init(&dev_data->lock);
+	mutex_init(&dev_data->mutex);
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
@@ -2088,7 +2088,7 @@ static int attach_device(struct device *dev,
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	int ret = 0;
 
-	spin_lock(&dev_data->lock);
+	mutex_lock(&dev_data->mutex);
 
 	if (dev_data->domain != NULL) {
 		ret = -EBUSY;
@@ -2114,7 +2114,7 @@ static int attach_device(struct device *dev,
 	}
 
 out:
-	spin_unlock(&dev_data->lock);
+	mutex_unlock(&dev_data->mutex);
 
 	return ret;
 }
@@ -2129,7 +2129,7 @@ static void detach_device(struct device *dev)
 	struct protection_domain *domain = dev_data->domain;
 	bool ppr = dev_data->ppr;
 
-	spin_lock(&dev_data->lock);
+	mutex_lock(&dev_data->mutex);
 
 	/*
 	 * First check if the device is still attached. It might already
@@ -2165,7 +2165,7 @@ static void detach_device(struct device *dev)
 	pdom_detach_iommu(iommu, domain);
 
 out:
-	spin_unlock(&dev_data->lock);
+	mutex_unlock(&dev_data->mutex);
 
 	/* Remove IOPF handler */
 	if (ppr)
@@ -2430,9 +2430,9 @@ static int blocked_domain_attach_device(struct iommu_domain *domain,
 		detach_device(dev);
 
 	/* Clear DTE and flush the entry */
-	spin_lock(&dev_data->lock);
+	mutex_lock(&dev_data->mutex);
 	dev_update_dte(dev_data, false);
-	spin_unlock(&dev_data->lock);
+	mutex_unlock(&dev_data->mutex);
 
 	return 0;
 }
-- 
2.31.1

