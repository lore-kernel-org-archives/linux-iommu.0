Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE66313CF82
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270996; cv=fail; b=VW2wmR/ABtIqAAwBbdPP4guaVZWbGQpXuKSd1hYk7MeTnhMBxIGLJLgOUibKv9+45ctfXVDIW/Sy6sl1Xd/btMUnuXtk9CsNXv+vORObR7hFvq/EP6TozqXhA/vy8a9BKXXYBZNcpcV/LjkArJO22l/BGEYONaW4VhkAxOJ5K3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270996; c=relaxed/simple;
	bh=dBvp9xeBrG1fBLTlSkQK+5nLZy90OSet57iupxTjHCI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBsg0j2lMx6YF/gNzhPfyqCBk7IDlVYcpSvw2s1Vmts7bDP+Akk97/6qUcjAfroVofgQmpIxht1SSQXEgpkq2r0op521FZW50Uu0UUOjsapeu5pxWh/Ka9DkTj/DriYTgbUzcb33t3RB/SxxwSv9kfX5021R8ZxhnhIrVvcpXCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OgEOB2oZ; arc=fail smtp.client-ip=40.107.102.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OgEOB2oZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOHHD39k6fcJveDrD//Rvt+5pmG7X0nZEImKO21XrYGwVLTNPfgtyQyoiCxhAiPFLIpdtWCKDXGo14qMW48Mbf0KCSIP48Y3Wbr0Y/02jdBAS0oyGVsBtsvYAQHqUkKgXj4UD5FH/IQRFXemYBzuFRFjmMIu6BzggkhaIpWRmpBwrL51ljo+qBNVPwu1xwLfsIrqbaaBzyT6d/P/wt0ccGXPIZLjtu/WlmqUS6H55f9DeG2e8pO+npy6zXarfj5sQI7MXMP7osby7eHmeNQdhT1QEdhxiCfTD/SBJdV6lfOTyfBmez+Op+KCvsFjndykLeKIOl5Vnx5sBUdjM94pCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJovCudoLuCJZA4U2cMq33RwZ97uKX+OKW1Uxd9fH+s=;
 b=F1IDCOnoYVus4OMLhIsZqLdvsSZFYv9C2h0J6BdN2VJKzgHPiYtJx2nV2yiA3lJssPV333EDlBmM7XsjEN8e6kkH4VVKpvwTbSNoj9EHIbUVJpiypTwaAcE5NQQOBKahmFBIX0Ae7RLw9F5pPV04Zn7IcQGg/LSBcU5BBH9P/pbDcGe4Jhs+PbSYsafC8Z4OZY/tDj0hgVamVOLwr23tXylJR9Vc5TfY0Hp/EtZPykS2jHiHsNZlYfg5WZVWBv/kDwCSjpM4RWtt1nRzhmtLrL5HDz43kqiyjJ0hUmPcnH85XUZUOLLwLKkwJH9Z2VhyAer3AJVR9GAyxN1l0HIxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJovCudoLuCJZA4U2cMq33RwZ97uKX+OKW1Uxd9fH+s=;
 b=OgEOB2oZVCxfXuwrsgi+CbqsVAc8oGsEiMzCAvb5+n0eSf8TGOr2j0BQQC+g1EU9rDuKMZ6PdW9xY6I1dPQyoySuP8W2YKAlQWZT3F/5KDEGNbEF2nEUAZxPtvTh9UGubJMcmMjJFKzhbwqbDKK+re64d0bL9xGXhhSB2FV+XLU=
Received: from BL1PR13CA0426.namprd13.prod.outlook.com (2603:10b6:208:2c3::11)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 06:49:47 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::60) by BL1PR13CA0426.outlook.office365.com
 (2603:10b6:208:2c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 06:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:49:47 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:48:18 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH v5 09/12] iommu/amd: Convert dev_data lock from spinlock to mutex
Date: Wed, 30 Oct 2024 06:35:53 +0000
Message-ID: <20241030063556.6104-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 74597411-d13c-4e3d-658c-08dcf8af0b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iuw524vaYC2O3yHeBNL07XJ5DiLPIUhAhgWVvWpdLwo2HMg7JYw4GiGE7I3G?=
 =?us-ascii?Q?gyiu5hi3okJ22nmcXtZLM+2bbCkDDnsLck0T8IRRb+mdmZz8E1OEB00ntmo3?=
 =?us-ascii?Q?hd/NN20uTk0VuGZ7ZEORl9CpeWPRleawWXmryPGsjZ7wB0r5B5oVFnnEV4n/?=
 =?us-ascii?Q?veosdvrv6YujENFfwcsvggTJe1WS5H5ZcmOQj3BZbTk/PrKcqc8ygmOkoKy2?=
 =?us-ascii?Q?gTO/gf/dIsJdtCAfdOK59oLqyBMv6mvbX1t3Nb7nRo5jMmD2BzjCuJgXcTCw?=
 =?us-ascii?Q?86hYfY9FTDVLkx/+5BQwjqiYVMUXBBhmROJjx5Mgy6HxposVHWNnfSLM8A4I?=
 =?us-ascii?Q?kKrSynmOEnk/l60IrJprf+/a8C46Zgidzfi9mitx+590SXnvXPqO6d+GtK0T?=
 =?us-ascii?Q?cFtwZTu5ZssxgJSCHUzNbbbu3gP3WZH13VKYrRyZrEB+cz0BHdw1b+VOTgsy?=
 =?us-ascii?Q?OXt3880MUBnnPRFqiO5uNkPzpkcxL9ynx8ctSm+KgdvHqTglSHlyKV8ICwkG?=
 =?us-ascii?Q?HOg+fe7AYeFHVWRN8Gp8t/nAiMQnqetyXERyOH5j0QQ3T9hknUaaKuyrwZcg?=
 =?us-ascii?Q?Wx/BKOCP9VxZzjlO9jnD04/4bdUMhEhWUD2u9vaZoE7KqUkbMeZ2LJJZQtAi?=
 =?us-ascii?Q?FuUOiRDA2CHeRzYepn/amNhoYzMdu/7g9t3t3tP69PD6GB3R9yuymns7Cvgp?=
 =?us-ascii?Q?agPPSY4VaQpe2EKutYm9i8VvMIQ3IkZJMGV0nKgWl8nanIwCDvgQUEa3ITxe?=
 =?us-ascii?Q?OQlFAp96onK5WuGeMWsxtikJE8y2DivoQ7Cr70fEr1DcMps8NoB5ENjlCXgP?=
 =?us-ascii?Q?S7L8ZO+nPzInCWK+CAmTcZKzSEkJW+n8bS5oFv/xTQWOC8r3RJXFr7ZemtZd?=
 =?us-ascii?Q?A4/JrnKIGGrlldEhnn4LzES90vaYeu6+OG9fI6hdJG54Jg42EyrkTgS01+wJ?=
 =?us-ascii?Q?Y5vR5JZZbz9nGc/xzEPw8pbRB+qNgDeOmvEDuyTIfOH+qCrgL8MfgUNKq8Im?=
 =?us-ascii?Q?15nbns03vfPK1CaSViaUFIyfuGLDmXeZDgzFR2P96tbC/WAD4DT8jxZ8QOLd?=
 =?us-ascii?Q?3BblaDYGYK+X0h6JmbEiw6HTQXgc+2FHZ4diybzTMGVzrDyd7ppbWT5jhzJF?=
 =?us-ascii?Q?wxFc71q0TQDqEA5yYbOo65YpGRktM4uyceu9lvjwiU3wK901cuGZOJBsf0zP?=
 =?us-ascii?Q?JK7eg3Hd0QkES/O/FtYETEERHFzkrceY8m27Az/mgb4iSzv7EH3qNH5Fv9A+?=
 =?us-ascii?Q?ajkAVP4NxA1Hb75KgelxVnoX63qAEreF8Zro1EkdDQTSUrvv1zQpHl9HQQmH?=
 =?us-ascii?Q?58CC0lOaZKy7zR4Poq3PF/pUwXgc1bjECjbbLm24jNhP1TME/gFnu5McHFdK?=
 =?us-ascii?Q?+ph8pQel6J4d5IidmOladmMW+9FaUsJ84kvikS6BrRX3Gg+y5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:49:47.2909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74597411-d13c-4e3d-658c-08dcf8af0b5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792

Currently in attach device path it takes dev_data->spinlock. But as per
design attach device path can sleep. Also if device is PRI capable then
it adds device to IOMMU fault handler queue which takes mutex. Hence
currently PRI enablement is done outside dev_data lock.

Covert dev_data lock from spinlock to mutex so that it follows the
design and also PRI enablement can be done properly.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/iommu.c           | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f44de5f31625..fdb0357e0bb9 100644
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
index 7cf6f44ac90c..7bb55ffe7a3f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -210,7 +210,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 	if (!dev_data)
 		return NULL;
 
-	spin_lock_init(&dev_data->lock);
+	mutex_init(&dev_data->mutex);
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
@@ -2092,7 +2092,7 @@ static int attach_device(struct device *dev,
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	int ret = 0;
 
-	spin_lock(&dev_data->lock);
+	mutex_lock(&dev_data->mutex);
 
 	if (dev_data->domain != NULL) {
 		ret = -EBUSY;
@@ -2118,7 +2118,7 @@ static int attach_device(struct device *dev,
 	}
 
 out:
-	spin_unlock(&dev_data->lock);
+	mutex_unlock(&dev_data->mutex);
 
 	return ret;
 }
@@ -2134,7 +2134,7 @@ static void detach_device(struct device *dev)
 	bool ppr = dev_data->ppr;
 	unsigned long flags;
 
-	spin_lock(&dev_data->lock);
+	mutex_lock(&dev_data->mutex);
 
 	/*
 	 * First check if the device is still attached. It might already
@@ -2172,7 +2172,7 @@ static void detach_device(struct device *dev)
 	pdom_detach_iommu(iommu, domain);
 
 out:
-	spin_unlock(&dev_data->lock);
+	mutex_unlock(&dev_data->mutex);
 
 	/* Remove IOPF handler */
 	if (ppr)
@@ -2470,9 +2470,9 @@ static int blocked_domain_attach_device(struct iommu_domain *domain,
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

