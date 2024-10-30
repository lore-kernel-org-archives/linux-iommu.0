Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADBE1865E0
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271152; cv=fail; b=a2hd6tznlpjzktiIYwbftF4cn2f8SoXcMsIcUdacgWEziSwN5929Iu2vXiYvfDe0GzBXX90zSRNRybKj3XiZ9fJgrCA4sP9AxpAdV1z1wv9gidVHBV+VIiZylSHvFKwQM6SIFQ966Ontswv2FY4Li55Tmy9wKsNBzOvW2Y2YVa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271152; c=relaxed/simple;
	bh=0UuRPM3FEE17vk3rueFhk37C0lMP0V5+R8YYu7sIcmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sahQpqYBLfMeuv/d/kzeUC5tmfOilcG6yUBVhd+LlQnHnjrlqOx0a5fPZlUTs4bBfaPgGDfg6DHDYwLRHiWrZhBl6WcNFmj8dLElkiorNPLcbwSAwAGSMkFovmfhUbOLY/CkxXNI3TXYquxGwl9VYSQlPEcLPzbGbUZrcJ7gFxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LBnHxZvQ; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LBnHxZvQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvkrET3rROhTMyZRhIjNRLd3U0HE7mv2926/mO2yTfzTyeX+ZLx3Smkpg/OLwdSgPtnWgZLIgj3i4ZUVQpmpkbnh+oxMh3zF7XBbay574wmz9kn5SpVY1a6bHdfDIPWLJgqhjAMVlgU+9Tnb5bmREapTGQO4kvsMO5aHq36tJFO18gqxfrB9OnUsk1xYM2WSv+crufLjwILYqXq5EmMbRkwafLw2SS6ojnAZ5bqGs/SIgeaWAatQBHwdS1slgOBe9fCxcVhZ4oujXbkL9lTTzGaJokVHya9ndv75wm4yqkBpV92CCTsObfOmU3Iwpa5yROoDYh2faot7/0O+PfHtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkhR1C9Hk9HUMtiVae9LzDhQ3d5xMS+5HyYGqZWJrGQ=;
 b=XRlgKRiP5iiKcdzj+rh7WXkyDvKYPs1Q5KnVgu8xxfBz+OBNqujWmjARDwXOgqGPV8qJRUtp7XlywKsqlQ/yq9pG5lMbaqlTuMLVmzMuEdRBwtKJCm7Y0sg2A5RSq7fKkoe54HL+xY79pBIRRiR1O5loxQmng48zVzOQ1c/pucD233zzkzMMwjN1QPtgGjq+7QpF8CfZRmJwKWbt8loexwPFgSlyizv74ipGBcL/2AN+Eb8GBmyS72l7mLzDJSQlUOC3ivAFNPL3ntgVuLhiQczKSMRMjbXudivpl/qrQBilvsQIO1YuvaXeCC0B5KORS6HqU+oexJZpCTEKVqcEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkhR1C9Hk9HUMtiVae9LzDhQ3d5xMS+5HyYGqZWJrGQ=;
 b=LBnHxZvQIaPYElHr0tkfaddqkJOZ1xGqVAcUGWq4Lp5m25iGfstcxH10QKufIahurOoONtwc4r5euPGD9Smdrk7Yv1pslj9lP0oelwlMyfA5BmIbuzZ2xq4Lr5FP0/rws0mQSTQ0aJ9LrIdNbMPHFgzhQV+T5XPeeS6GsHqzDIU=
Received: from BN1PR14CA0007.namprd14.prod.outlook.com (2603:10b6:408:e3::12)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 06:52:23 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::2d) by BN1PR14CA0007.outlook.office365.com
 (2603:10b6:408:e3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 06:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:52:23 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:51:48 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 12/12] iommu/amd: Improve amd_iommu_release_device()
Date: Wed, 30 Oct 2024 06:35:56 +0000
Message-ID: <20241030063556.6104-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030063556.6104-1-vasant.hegde@amd.com>
References: <20241030063556.6104-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 86509585-a0ce-4ee9-a19f-08dcf8af687c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zF2PWuGgFamoQ9HjuKYH846PWGeMQL7lgKHTYcHYdTppnLK11m5fIJPVxb6m?=
 =?us-ascii?Q?u47dBE4EDOK7idhlmxY51HjSYp3JO3AhHWDkq9D10zQKx/DaU3xJnQUsKml3?=
 =?us-ascii?Q?etNJ0hFqr+GiX/Id3ldMpRaStyoReQft0nCglySSJ5kNe5Rk8Ds2iDTmousi?=
 =?us-ascii?Q?jw1UTAesBngmjE6PNiy4/S4SnQ2gwTuEepU94tg4zuDOWg1xh80yyJx4S/D+?=
 =?us-ascii?Q?WeTWn1n2pqRQZo5jPj6MqaBg5XNjBYzPNbI6YBfT48/L1JytDvDp5PA0IQmQ?=
 =?us-ascii?Q?p0pZc4uvScThsivWh2zOFa16jaRtcDtCI5jQPRwyIIwNX0oKI8HPYkuwHIdg?=
 =?us-ascii?Q?taV+7i8E1QO4700raJ0Nbs4uDjLU5oXTA2z/veEV+LVYrGu95LkXSPhuT3Ij?=
 =?us-ascii?Q?a5LD+VgJpNvESBE/T2lHXDu68KZLmjsOZcn6uGZPfkYectvUp6VpzO6y5jHC?=
 =?us-ascii?Q?Shl9gGjKspmX0yeyOAwfIxFt4YcugvfyxdSd4Mra5XxbYZKMvlGhCs/Xochu?=
 =?us-ascii?Q?igHjcgWmd7M3uTBjN6YFnwLzxPAd7fGGAP/O5qi5iVzBJPznjl6bkNn6/TPN?=
 =?us-ascii?Q?wg2u194mzHh414pg98xTfHz91Uaz9qo/KNql4bWpO911CLRk70rqYd0nV8jG?=
 =?us-ascii?Q?Q5ZzEHmtvma3rLM0QjT6uJ4X07nmS+EI6y2m6QgTfj+m1hzmfuRbli52J+PK?=
 =?us-ascii?Q?5G+yFuKMN5tp5vkzx0HINeS99ETPl460HgOrRw+MQCe8GkWEXCfN5WrIUwtt?=
 =?us-ascii?Q?fecG07xILjnUgjsazoW9HbIV+Q6oQNXm5H4JUsbQwB9/BQm4IsKzLxQHPqil?=
 =?us-ascii?Q?WH4CInlIxzb34nPFO0IkexZWzmG/fYZG27flaSdt+hBp3+Ab/vuIhiUbHxWb?=
 =?us-ascii?Q?9L2aT4fZGJ4RdpQWwuUzRmU+WkxXTUEFC+GKpPcMowNBs22ezgqbpWOxylc5?=
 =?us-ascii?Q?yKIQQrUNObUcnP5CZaWghEJILr3WHwo+vmFYWsiMoCkoy10SNUEOOcfWBhBc?=
 =?us-ascii?Q?L6t5UUzLvDaGE+9ujEg+KetIoaBsjjBWQP5mtfzUxw0MQA7rwOXuW/g6dTOQ?=
 =?us-ascii?Q?W9gCbcXe2IC9fzHJuVZtqPMVFuIFtJBrBAt4dh9VALSsljsOL16RqSeun0B+?=
 =?us-ascii?Q?Hzv0+ovSqcudxo/mAGNCxnuPTedkQepFiv3pboAkRIuLJBZaQm+bc/EEKzo0?=
 =?us-ascii?Q?3MGnCMB2mI910CB6umecxTDDGo9Hms/UlkUuaRnNFOeYLBdDxJCGiH0+RD5E?=
 =?us-ascii?Q?XBaznqjEYZD+7M7B9+Cwo6ASxZDJ7/XQ3JlV4R0KWISxpx3I/aKAe0sVJHPK?=
 =?us-ascii?Q?tHAhECjB6KsuNOepzHY6FA0F8BhJUNgxsVkvtyiCjdGYzTV61yU2vIix5O9h?=
 =?us-ascii?Q?xIeLIQVLfN0cwB0wrJdXicXhgi0+7hiLpVDzckiHmVsoSfrchA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:52:23.5106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86509585-a0ce-4ee9-a19f-08dcf8af687c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875

Previous patch added ops->release_domain support. Core will attach
devices to release_domain->attach_dev() before calling this function.
Devices are already detached their current domain and attached to
blocked domain.

This is mostly dummy function now. Just throw warning if device is still
attached to domain.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1186c4ae9a57..a8d3f46a0f37 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -77,8 +77,6 @@ DEFINE_IDA(pdom_ids);
 
 struct kmem_cache *amd_iommu_irq_cache;
 
-static void detach_device(struct device *dev);
-
 static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev);
 
@@ -563,22 +561,6 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
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
@@ -2249,17 +2231,14 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 
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

