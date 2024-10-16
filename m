Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0943616C687
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729057111; cv=fail; b=HPDn4wWmYydflQEmQwY7oXUswcvG8+yJqDXgSUPwp0GB/KE4mWdhbbvYYFBKSyjLAztPrSYZ0fo7dcOQAN4matX7QTKYIP9kuO3LPxIBkMQ5SZxC3rOfzA7IuwNFt2fFKq+b2Ep7TyT9fjJ4eueARpseCM6TCccs0wm/Ib4GgP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729057111; c=relaxed/simple;
	bh=9W9cYYZIcW8bvU+ERRXnjaXjO6ZRcfDprMODbK2cyMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MT/0yW/Ihnw3uYycf/CyWtzG1UkWWobucXSzXqU+BBLNahdcHkq8meGpYe/MSDlePigVWPV/Myt9BH5F/+XM3uoBraL4Lcs9jsm/CYyq4HWB6uWxcPyZahjIuCbArlkWqsAjdgenofKoh4AVJpIw64R3H3vQbuSzKVdktu9ap+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r/NnhuKw; arc=fail smtp.client-ip=40.107.102.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r/NnhuKw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c763rPFKFrfS8LoNTNBc2YvUQ83IVzYowU11peD9kPoJzmm9IDIe+XFWxbYlPoKT1myXHCmn9bhQklasDSELxD0OhcjOYPADW4IYfvNLEpLC1zmE/UfZ3ZQo1TUDaF0HbEzlwEV/pAIoWEAGAgAR1b+Gds0wh1x2ZbfmkI1YPvlVdOa2uQlgTbt/7BI/bfDfGqG0kHpsBmkd7i9xxrBpfHfY7367sVOyYVYbsKqZ5u6VZFXrTpf1mk2YYGTDFL7sH2/gmclciue5iJXlMMmg4KMi8abhN+FHLfxcJiJemEecBcA3PkPcUtNOkMOqWhTnVVpXbTpm/00+fiFmKs0bMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCBUpY5BhU9v443UOpVrUWyc+AsCbmX4Or/+QBj+3yQ=;
 b=rdczx+iE8ccOS2SMTiiiU3/dAHI7ihB2i0vz3OQU8ko1ZRohHtiKU1MSiM3BFgUioDumzTrp0Xyu4ozJX9W4YN1E/OfC07Fp/V+jwKUmNv8+/5NBNS/IlX4QGyzx2djr3j+p4t97BFeZRinPkHa2rE/uWPO81d6dBZYtWEHaK/wjZUIQfZdKbXTcT8hh0ojc7hofsqG0om+IIu1193dnRRKB9yEB8bNSJIpQK1cwsurGw/3KNEMzQ8iegrZAzNH7kw3hnbxokp3nbcDd8fvRAm/8epTHeeRsiTW/8Uul9dw6l0THEtQmHLWw+QrT0Ok33TAkh4vq1/iBPAUZ6YOByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCBUpY5BhU9v443UOpVrUWyc+AsCbmX4Or/+QBj+3yQ=;
 b=r/NnhuKwZGaSArTdDf/p3QMN2svoyKnccy1m2FIwJ5gmS5DGaB6qbi/6yNJ90CSD16TXV/5FeR9mngejcunG50IauhKW3XKKB6XK5R3xAU80r8qR7tPKmx3ijmI9+LNuJe+i2Dui8FKmFVa0R5bebDQPlnG/dkc3E+/LAh4p5NE=
Received: from BN8PR12CA0036.namprd12.prod.outlook.com (2603:10b6:408:60::49)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 05:38:27 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:60:cafe::42) by BN8PR12CA0036.outlook.office365.com
 (2603:10b6:408:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 05:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:38:26 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:38:23 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Joerg
 Roedel" <jroedel@suse.de>
Subject: [PATCH v3 08/10] iommu/amd: Convert dev_data lock from spinlock to mutex
Date: Wed, 16 Oct 2024 05:34:59 +0000
Message-ID: <20241016053501.97497-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016053501.97497-1-vasant.hegde@amd.com>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0786b9-70bd-4aa1-f945-08dceda4c216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y56+kXG1cHSoA/UrI8zpiKvMhrCZwFDED+KIX/u/gmtSzCjIN7TCXDsEI5UX?=
 =?us-ascii?Q?DPP8USgtaFsXqkbudnbLBx2meKDlVWVmphWN5RzHdTtTQsw7k+OfmpuyI8Zt?=
 =?us-ascii?Q?RkJP74SFR8FFlzWRItb+4j3hI1xx84CaI3GCarSTLJH4CV3cDKul7yeRAsRV?=
 =?us-ascii?Q?LMqqmHwhAQNQQg3ZQdmwBU1CMbgB+LuFeNX/5wf4xVL2yxhyX76ed3NK5q6l?=
 =?us-ascii?Q?EGwNPWMBx6pl/gUYClDkTbrMNZT2E/YrrhdejC/3+5S2qbl6ztegUFOTdzNf?=
 =?us-ascii?Q?J96tlEyBt6aCImcG+O9GIuAMh4SOB2Ak2KdY4Vc8UrizqwLpfxFvXJpCyapu?=
 =?us-ascii?Q?mjZerAKbA2Nr0jfnojxWgnEbW0Kxn+X5mXrSEYdgRYUEOFQgXCFNbntQZCfh?=
 =?us-ascii?Q?kcEfrqaTViVpVXi7LOhhkLNzNj8cjKOt1bCk+y381dCwrbM3as1JDm8xNgdg?=
 =?us-ascii?Q?tsvLEiZD/hL3MXuhlMAVaiU1fuOQgcayS0SBFjTBtfAzUVzVo443KPsbbgCf?=
 =?us-ascii?Q?eUeixciuzQkbsS8oQ/rRDJhhZZHpQcrNtyG6RWBmwOOhIDfQnXCxKi1utPK6?=
 =?us-ascii?Q?rC6257aE3nrlEnvrgoOp0DoWQoQ7oIeyNQnB5ZoJgcHPige/ZuqG8vm3lZ+I?=
 =?us-ascii?Q?oBfoVmk1jJk3lKM8Noh4CMaOU8fwdHsbH3gV65iMBcA5srvk+67VxjaBfoou?=
 =?us-ascii?Q?PlviYwGxuL9Bluxn2YTaUH3/IgkrL3mhjZBFWrfVAL3PTJYAEBtORvmFqnsj?=
 =?us-ascii?Q?8o+6GhrlD0cfIpbBuaPWJ9oY8j/RSxRc8/psknuKC7i1E67K6V7LxQprOf9Z?=
 =?us-ascii?Q?WiDdXK8wLCiAEyi9SoNZrCnxgQW94sBWCIi7Id3J8Nma+vbx4UvyXjO4hlzq?=
 =?us-ascii?Q?AclsH1aVbyUJbH2TL1iZCN6JpbD85onfw4F+P7f40bNA70N9SkRTYkR8pJSQ?=
 =?us-ascii?Q?m84rU20KE1cqnH4gaoac5OIDpri+inWHGuEXr8grK/2deXbIVZelaJCoo8Mk?=
 =?us-ascii?Q?bVULXKA5s5T/Vmxw0PM+4nDi1+Fgt0DiLjmhPh8YVBHFbRyim8FZ+EEjOK1B?=
 =?us-ascii?Q?StNIOwXPTO6itygMtXbpZoV9jgF+ps7WNXlJNddD3LPsDMFwYrMc0V0PFPQR?=
 =?us-ascii?Q?uVODTJfbQszLnHZLZaw6mQcAgPKYXcws8NFXHrzttG+5FM1lS/OCLR4VO06F?=
 =?us-ascii?Q?SH37a3LdrI3Eo6Rx6jvjAOkgiEhhT7k9rbUZcg1lKAWfZnDD/LNZGffyu0lw?=
 =?us-ascii?Q?uVzON8bPwSg0t+PE/5ZHs9kYxul/d7D4HRh1faebANkUl2SAWhKr9UyeGQ5H?=
 =?us-ascii?Q?vD0jBfoYDl3YfaCVGYtTasOQ9Hk65qMa2BQfK20k/y0EIY4J2cFzr2whASG/?=
 =?us-ascii?Q?o7mQztC2iiEXbuDzZwax78GuN1h0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:38:26.5847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0786b9-70bd-4aa1-f945-08dceda4c216
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

Currently in attach device path it takes dev_data->spinlock. But as per
design attach device path can sleep. Also if device is PRI capable then
it adds device to IOMMU fault handler queue which takes mutex. Hence
currently PRI enablement is done outside dev_data lock.

Covert dev_data lock from spinlock to mutex so that it follows the
design and also PRI enablement can be done properly.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
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
index dd1fb3bedd33..2fefb7abb9ab 100644
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

