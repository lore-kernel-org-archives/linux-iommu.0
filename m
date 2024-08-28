Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898831EB35
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852735; cv=fail; b=dbYWL0r8KUpvYjokNPzkur/HdssV+iL9/uLST/WUyS54H9KYbrkhy20KEHBU5esOK9zrGq0wrUr2dDCwWCGc55D4SoqgqP2Dkmuch6PbmjmUHgJd+DwENM4YtS3ljsGV+gMO+d5kXAkZoWDD4zFvlrqVaqvVfQRg+wCMgwfx6sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852735; c=relaxed/simple;
	bh=/7q7tY+YbVWF7sJgHU2XQ31ndqostxqUSb4wxkLEdUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXornMta01j5QvaRiezQxachlG+zfz604yG+R3JT4Lb3hdIgmaEfPM2C1dMvHPGjlP3GNRUzV+KO1kaF+b/np6tzC5AhVq5gDQFc79Fi6EBsNG9/Tt9Qo96e7fAKsSt4vuI9uP6f8do4Jic7HrNQtOw/2XjhqUMNpbBvLwehj7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XsZ5eqZU; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XsZ5eqZU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhuNiQFaBsNxO6Vrxt38Lkx0c20vY+hlkJEGwurvlYesFG2Ht0irAOig5JAtxVjPxSUa2BNPfiTRjx6WzjR2DgJnQWQ+YieGARREubHAkR32bsaZJON9rwff6T0PDjDK3jy9QBRBrXyV82UPtgOC9VdhMhjBmbEFSFM6De6n9RbNNoVppo0rnVQJIzhq3EjfYJl9pPm0o5eYGeLsXjBdlsDhDkAgln/AX62BlC9b14aZiusw6qssjsAhemWIZxUNfvQ35rP9gON3Xdl9tqsEtxI903htAOj9y+RB2R/dd6Vq8x5nqynFWteO/+5C9et2/AjbKOboyHaU817ztG58TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ij0JvaHzA9r/gYZ+UtHheNHwTX6jqAeyhwTZzeZIac4=;
 b=L/jVDjg7TWKs1ORoklBiwbkMgITf9fwr64dBWl3vIJN0IvW8TZ6KTA6NB4w9NnS9o8+TNCBZ+Sn1Z8M8XoqX1r1UclZmi99fHa2ENCYftMbzC8UTjhGXLyjtVZdWW8+W+211f/3vHHJxb9tpyizC+zerbva+qra/C2oBAq8MKHUDmIZRrq65aj51OCpxdmDGWUlq5jVysueO0LIcx+e2m6wqpOUnagrvksVjgCYnCYkQ3dFZgUCYG63Ag85MgoauvQ6NOxTpZiqv8z+8eXnn42inBbl9dZ0ZhfTyRV+JLlGQmevSTvn108UWYkov5Okq4TcUUw8gQE0uDqXL0FvxSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij0JvaHzA9r/gYZ+UtHheNHwTX6jqAeyhwTZzeZIac4=;
 b=XsZ5eqZUUXeuUSdLRfRU7GSGPowlRez5V9HTRe8DczR7DczB8WWfXzC29QChxRqmm6JCR18m7IA73wmHEs4XLT3BFidCG1414aqfl86ZwB5ESrV3jajtzA00LG7S8rN3ubvbjBwlZ+I+IWiVqYjqBKoauaqCRdK2c96GTEJnG+c=
Received: from BN9PR03CA0764.namprd03.prod.outlook.com (2603:10b6:408:13a::19)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 13:45:29 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::4a) by BN9PR03CA0764.outlook.office365.com
 (2603:10b6:408:13a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 13:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:45:29 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:45:26 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 07/10] iommu/amd: Rearrange attach device code
Date: Wed, 28 Aug 2024 13:43:14 +0000
Message-ID: <20240828134317.6239-8-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dbe3c3c-ba55-402a-d86c-08dcc767add3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e2q1g7q2V+eQuu4UrS7HFSVPieZkNguTqOkfeqzuPO8lGfDRE4WuDFejwoDi?=
 =?us-ascii?Q?0lMhi5uwvZrIj3PZuGLnPS3Rku2JoUHGjxPHuEFHj6Qr4yy1GfxW/NT4Vbfe?=
 =?us-ascii?Q?30aOyjJpzgX4htjLIsHKV3Xd45YNhkW8vKdb87dJxC/Eq5siZSdcZbqiSCiY?=
 =?us-ascii?Q?3cHI7bYMzOkBbQkjK5lRWvsGXP5zTlmiGfbeBMm3q8YCAwi2Ro1mbo+fQznU?=
 =?us-ascii?Q?9mghbObgr14g0JsgVE2NL10KiCyE9DFHVEONpuQaXtGfQF4AElbfkAiyDbSO?=
 =?us-ascii?Q?KzBqYHvUeKl2acSF083pxKJrdY0B2eU2IQ3QY6f7ZZSK793gTaIJ1y51NJU7?=
 =?us-ascii?Q?U6ThYhq/nNSx1qJDAwN79c8//E3burM0p43wkfb/P2H9LTgqCpS+MTHaEA+X?=
 =?us-ascii?Q?y+HzwkenE+KTji+VeHKVXH6LkVZ7cbSKY2qtey4BobUHPFT/xcq7vrVYKCtW?=
 =?us-ascii?Q?o/x+EycIYS+nmfE0nZq8oq/NLSzx+ZLW3JzCBpZsR4udFxqqFAbEvLNyQ+AR?=
 =?us-ascii?Q?uf2F3kp7QoOCHphYyf9wLEmLMXdG1CcBObdO5uXn9T+meRy75hUsa/uplPpo?=
 =?us-ascii?Q?7+glfQifDH6OsZC1e65QVny9w+sDUvC1AWZupbyP1eJmD8d9lTXzawJjVEni?=
 =?us-ascii?Q?X1jiRbqUlYD2qqwjrHDShEGOhEyAry+Y4gG0oPerkJ+wGY+xphwv+N4OtHsl?=
 =?us-ascii?Q?bOhPEeRVuhFSMah0AD79iY9lq8uH87fLZ74P5rp7VjvYUjiWuP3JhpRTfyXq?=
 =?us-ascii?Q?eN2UpnyXMgA6vv0OEvqJhUgZqq2W5K3Gkhwhy9BBWJoKTpmNd+hxwpk9Cazz?=
 =?us-ascii?Q?iEIB0QdpYj0gvSE6EBfRA4NtCZMRXgsE9QRLcVsrxSm8PVSsINmllwOrH4Tv?=
 =?us-ascii?Q?t2avl1hpMnWmdzenNnISYuHGli6JRdrYgD2PGsjdo20GujZNttUuW04p+3H/?=
 =?us-ascii?Q?3felbqYceF23n+6ILp0pYgSYHPmZZhsUHMIkDp67mEvEaHfxc03b8XO9F1XM?=
 =?us-ascii?Q?UVsUF0NErEHAM7z7roPLsP9rBP7cuxOTV+HRp4q0ZqA/SWlcGcSfhJ7bcPlC?=
 =?us-ascii?Q?BoJblVhgxQjLBBhJFg0nW0AvTcPOAeiWBmxOUqOXGWMYEre7ZVV2B71ljf4x?=
 =?us-ascii?Q?vgxaa/plOQUxlyQfaxHKcGulm93PuqSS4kEhM6MOmACQUIt1NYoWYQqnhk7u?=
 =?us-ascii?Q?Ud0tJ/P8rY2m9xGML9zd4F9f+VqRWP3m4JWgbj9lg5Jgv3MFob/MAAiY8BlU?=
 =?us-ascii?Q?s123bVPLjgi8U9t8ijYgS+VxwCTPowPBPpv4K8FV2VqAq81jtZLMjpqp3UYA?=
 =?us-ascii?Q?YKUBoLMf/xvk3xq73/mNvdnUGEdi+UMAG0J/aTPaV1dew5VT7h5FaLh2EYoK?=
 =?us-ascii?Q?kNqQUOWHg2Yehay78nJA9XR1WR2cPTfBr7gFjR3kGBliv2zB34WzVJz9nAHd?=
 =?us-ascii?Q?aWNXCqjtkebPQ1x2qG2SFvrznzUp28u8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:45:29.1043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbe3c3c-ba55-402a-d86c-08dcc767add3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260

attach_device() is just holding lock and calling do_attach(). There is
not need to have another function. Just move do_attach() code to
attach_device(). Similary move do_detach() code to detach_device().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 85 +++++++++++++++------------------------
 1 file changed, 33 insertions(+), 52 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 45647aafcc3e..469d3acf4180 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2078,12 +2078,24 @@ static void pdom_detach_iommu(struct amd_iommu *iommu,
 	spin_unlock_irqrestore(&pdom->lock, flags);
 }
 
-static int do_attach(struct iommu_dev_data *dev_data,
-		     struct protection_domain *domain)
+/*
+ * If a device is not yet associated with a domain, this function makes the
+ * device visible in the domain
+ */
+static int attach_device(struct device *dev,
+			 struct protection_domain *domain)
 {
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	int ret = 0;
 
+	spin_lock(&dev_data->lock);
+
+	if (dev_data->domain != NULL) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* Update data structures */
 	dev_data->domain = domain;
 	list_add(&dev_data->list, &domain->dev_list);
@@ -2091,64 +2103,17 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	/* Do reference counting */
 	ret = pdom_attach_iommu(iommu, domain);
 	if (ret)
-		return ret;
+		goto out;
 
 	/* Setup GCR3 table */
 	if (pdom_is_sva_capable(domain)) {
 		ret = init_gcr3_table(dev_data, domain);
 		if (ret) {
 			pdom_detach_iommu(iommu, domain);
-			return ret;
+			goto out;
 		}
 	}
 
-	return ret;
-}
-
-static void do_detach(struct iommu_dev_data *dev_data)
-{
-	struct protection_domain *domain = dev_data->domain;
-	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
-
-	/* Clear DTE and flush the entry */
-	dev_update_dte(dev_data, false);
-
-	/* Flush IOTLB and wait for the flushes to finish */
-	amd_iommu_domain_flush_all(domain);
-
-	/* Clear GCR3 table */
-	if (pdom_is_sva_capable(domain))
-		destroy_gcr3_table(dev_data, domain);
-
-	/* Update data structures */
-	dev_data->domain = NULL;
-	list_del(&dev_data->list);
-
-	/* decrease reference counters - needs to happen after the flushes */
-	pdom_detach_iommu(iommu, domain);
-}
-
-/*
- * If a device is not yet associated with a domain, this function makes the
- * device visible in the domain
- */
-static int attach_device(struct device *dev,
-			 struct protection_domain *domain)
-{
-	struct iommu_dev_data *dev_data;
-	int ret = 0;
-
-	dev_data = dev_iommu_priv_get(dev);
-
-	spin_lock(&dev_data->lock);
-
-	if (dev_data->domain != NULL) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	ret = do_attach(dev_data, domain);
-
 out:
 	spin_unlock(&dev_data->lock);
 
@@ -2162,6 +2127,7 @@ static void detach_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	struct protection_domain *domain = dev_data->domain;
 	bool ppr = dev_data->ppr;
 
 	spin_lock(&dev_data->lock);
@@ -2182,7 +2148,22 @@ static void detach_device(struct device *dev)
 		dev_data->ppr = false;
 	}
 
-	do_detach(dev_data);
+	/* Clear DTE and flush the entry */
+	dev_update_dte(dev_data, false);
+
+	/* Flush IOTLB and wait for the flushes to finish */
+	amd_iommu_domain_flush_all(domain);
+
+	/* Clear GCR3 table */
+	if (pdom_is_sva_capable(domain))
+		destroy_gcr3_table(dev_data, domain);
+
+	/* Update data structures */
+	dev_data->domain = NULL;
+	list_del(&dev_data->list);
+
+	/* decrease reference counters - needs to happen after the flushes */
+	pdom_detach_iommu(iommu, domain);
 
 out:
 	spin_unlock(&dev_data->lock);
-- 
2.31.1

