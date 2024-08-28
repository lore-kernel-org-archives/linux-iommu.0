Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E273E1DFE1
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852750; cv=fail; b=Ko3WNOZqZF7/WGR8cnPJpzkWz71Ckhqn+btXCnqpoCrI4QqPzmuTR4J2oQIReWYgLdkRXlN/pbhvldsWT+NGz9Te0bkAUWE2WtE4aG8V8aQPIgV21yeIcp2TvJzpOzZHVy743/2Csjsb80g5s4OywAcHvqbWaHlCksGQl9A+L+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852750; c=relaxed/simple;
	bh=zohoxTLjTP+n53/qR1VyrjT8vhKZqxJoV49jDL5M8vE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLAbNK82SEwoM5mTaR1lqpzxd8Kfz+q7p3I41ao2MwxDh3vPSjR6uYmL2TuYpandSBG59RsKqP632ee6Bnkjtl6FKNLkQGhVyuQWl6cP63vpW1VjAClaVs2gl7By2wWYi5jz1qhLLyzW2/3JWGhBplS9PM9WivKrZgGPfUDy+rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4S0t7Tbb; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4S0t7Tbb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kg7RJUjfHsaCEP9nvHTVOOwjiWYTWnSIw8pbizqQVYf1ECtY9+lLIYDevrsLZrdLcGjS/m/xhjqWDykseXheUe/JblG+WcPuJJ8fsFdQoWQTHEyIjDhFAyKN7YiSL63wjgSxZFRWLmpXeA9FMK5SQRjVbKd1FVJkYh9mLw+KWQVnUfDvs1ZxPY5YdR/kP497M0jhu2vapWjouZdP2v8JOqbj2RLeuPTJo/OmD8ZqcGXWNwsirDRfxodiav2VV/gJhH8ej9Qc5K4gtBLcsIJhxe3EXpz3lzuXiuDZGcZrPTFVzObeOz5KF+cl2nXu4QGVFpGqkE1JqwXl61lRV/T7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oElnQBGIC7DNSeDKVtpOosVbf6KOuGOp9qc5z0PF8NQ=;
 b=o++8jMdfmT6bqmUl3ROtHSvvpfL1/vNoUpYe8p3JnBeBUsq9MzfLzVwUzRc2Cx8CHKajRbJWRa1nDCcGaVHSPOC0WVOExwkn/M5eyW3DHIyJSoMzeG7OYIweDwUEsXPcGcK1r8YhtiPyqGyhDh3PQzblfm80mEtmOY52YSd2bGQxXFEHQm899F+f6udl59VzXH0UzGbVskFgh88ToBAuzQuZxz+8jBGsXsqmC7E+kjsGCdgwBD2WJw3LmiBWZDYyuK36Y3k62Mkda7xiJG3eDaIXVomDr2I0kM+GS5e30Rw2p8MOx4mlOcZ2dkyK/leCswUtRz0CChXTcViksFYMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oElnQBGIC7DNSeDKVtpOosVbf6KOuGOp9qc5z0PF8NQ=;
 b=4S0t7TbbFinpV4gnqjGn2153H+cHMTASTC9FCWR68odUyAJB9bElx6MBtxiuFmbYdHmTubYdl7qK1S27skdiJK5uxWCZQIaRtLahBnjaXW4eP6B7IPkUCGJOIHFZiDd3Qujepb6Yjl06xxYiNV7oalnmflcvlx4vzH7X7l95H84=
Received: from BN9PR03CA0391.namprd03.prod.outlook.com (2603:10b6:408:111::6)
 by DS7PR12MB8273.namprd12.prod.outlook.com (2603:10b6:8:ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 13:45:45 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::7d) by BN9PR03CA0391.outlook.office365.com
 (2603:10b6:408:111::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Wed, 28 Aug 2024 13:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:45:44 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:45:41 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 08/10] iommu/amd: Convert dev_data lock from spinlock to mutex
Date: Wed, 28 Aug 2024 13:43:15 +0000
Message-ID: <20240828134317.6239-9-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DS7PR12MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb61aee-3181-4907-5ccf-08dcc767b72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hfHghfPK1cMnaCU3EQkHQAtZyLLWx4DekEDfdIX2oc0+zLfWU4ZvFC0Zax4j?=
 =?us-ascii?Q?ndzn4zBmXPTHEY3HYghp4EUC1t932VVIdeBRt3sRgFjpb93nYDC4J4Z4n86p?=
 =?us-ascii?Q?BrYYFrh/OTNBGqgRzruZj6mrcVka+5IRXzZAYQr2V/vO9pH3KAhsOZlWCnh7?=
 =?us-ascii?Q?xHn5ih5KcWjk+YEYAsi+zTFV8g66MGsr5+8Xotiea1IoU1wSglFuqeUzYN8k?=
 =?us-ascii?Q?IcDMMhQqw4Rer3E+YI6aOsIU1GM9u7c8uOzeg+dWFtQUzpJlrTivjVqWwZ76?=
 =?us-ascii?Q?D6LCpSwv2klUbISc8TeaaUWvBlSQQaIv759KLxv8IirKEXfXrANzQs/w3tZM?=
 =?us-ascii?Q?QWUOlTqWfDx9MOcuVTqNgMwVeMWN/5ICE8A9QC3tPNk1+f9e4TZXI9sfwbS5?=
 =?us-ascii?Q?LVeWdjA2XBLuzN9gnqQimHRCGcprhaJn8O/uYyZvhSynluQs36uAd84eLNTl?=
 =?us-ascii?Q?84xKzKwi9I18KLdgDZG+KLvXwxBIOyUhHgmjAAnqadrCpzsIss5wirwCObQH?=
 =?us-ascii?Q?cSgE3BPZB2EeeAaoK2tHoQZ4a6hL8LnnNz2P3Hxd2sEKTxkfaWsnZKI/Rhj+?=
 =?us-ascii?Q?DVzF97kNJdJDWwJIz/mph2SrvhFlkcBAd2A65zq8U8z15recJPanoGUGjdkW?=
 =?us-ascii?Q?LSl1hSP//FNrEZnqa70OjJpg99nbsSNBXk4HlNzwqpH90Rc5hq/qj2uF+e7J?=
 =?us-ascii?Q?sVkNXC1Dr+srGdU/0UwM9F5UC/qHxH8XkhPFUEzN/KSTPvi7C7gj/dsjT+rD?=
 =?us-ascii?Q?erztSeB2c5xhmIQMV7SgygRaJ4UzKcp6K0+grI/A0XGPoNyveCQOxLPUgzuo?=
 =?us-ascii?Q?Wv4aYBUL+W2RjnYFOcPWPbeVH6wNu/jjAeQEoVND7vQFTbbJrNGBfIaLXl9L?=
 =?us-ascii?Q?KwHkZFNHJljOKAfN2HjM9U4M1C+Ny1u3ZGf+lPbiIqh4SWjg/25gW81odRb+?=
 =?us-ascii?Q?LsUe/ELIpt/O8h5Cue+n2OVVFVhl9kkzWG62niCef9L3ahlXKxiDNL7d4PZW?=
 =?us-ascii?Q?obxQ30aPQyhMr2jl2wT5WYdPLsrRSp8AzDHNTdyaA1YONKFWrKuld4EvwUDx?=
 =?us-ascii?Q?D+P/x7X3Df5imyXEl+NuJNR5QdDh6Sz1Eu1qppxIpAK8/AlWlR/kaBLasGue?=
 =?us-ascii?Q?cr2TEltEnGVP03N0BsKZRbHoogzFWp3x9Qq/XCS2pwKQsluT2u0u411YtzUQ?=
 =?us-ascii?Q?ySvglcLR8TJrg6SBJxr1fEPqRSKlZ+ZT51di1bZqpGbH5aMk29xj8wKTBxWO?=
 =?us-ascii?Q?JbdSE3/SpvX/YS4xHQr+0kw/JaPio+vE249+vY9rijwAg+MpzwLZmqzYeWEX?=
 =?us-ascii?Q?6xIBMW2LKQm1IfX8y2K6tHgXttWV4TKdnwejmgRKA1pf15or6Y7JikHpkQlz?=
 =?us-ascii?Q?kOf84AVvmuMeDjhYsabdolBQOKnGwuaBJuDjsdp5nqZ4ppN3egRfcGWWUQ9y?=
 =?us-ascii?Q?0QZv7ETjQ8OcES7ZE/ZK2BBB+DswCLHV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:45:44.7814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb61aee-3181-4907-5ccf-08dcc767b72e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8273

Currently in attach device path it takes dev_data->spinlock. But as per
design attach device path can sleep. Also if device is PRI capable then
it adds device to IOMMU fault handler queue which takes mutex.

Hence covert dev_data lock from spinlock to mutex.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/iommu.c           | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 4ffe87b71caf..23b5f15f20b9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -833,7 +833,7 @@ struct devid_map {
  */
 struct iommu_dev_data {
 	/*Protect against attach/detach races */
-	spinlock_t lock;
+	struct mutex mutex;
 
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 469d3acf4180..7da1b7b22b2d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -209,7 +209,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 	if (!dev_data)
 		return NULL;
 
-	spin_lock_init(&dev_data->lock);
+	mutex_init(&dev_data->mutex);
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
@@ -2089,7 +2089,7 @@ static int attach_device(struct device *dev,
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	int ret = 0;
 
-	spin_lock(&dev_data->lock);
+	mutex_lock(&dev_data->mutex);
 
 	if (dev_data->domain != NULL) {
 		ret = -EBUSY;
@@ -2115,7 +2115,7 @@ static int attach_device(struct device *dev,
 	}
 
 out:
-	spin_unlock(&dev_data->lock);
+	mutex_unlock(&dev_data->mutex);
 
 	return ret;
 }
@@ -2130,7 +2130,7 @@ static void detach_device(struct device *dev)
 	struct protection_domain *domain = dev_data->domain;
 	bool ppr = dev_data->ppr;
 
-	spin_lock(&dev_data->lock);
+	mutex_lock(&dev_data->mutex);
 
 	/*
 	 * First check if the device is still attached. It might already
@@ -2166,7 +2166,7 @@ static void detach_device(struct device *dev)
 	pdom_detach_iommu(iommu, domain);
 
 out:
-	spin_unlock(&dev_data->lock);
+	mutex_unlock(&dev_data->mutex);
 
 	/* Remove IOPF handler */
 	if (ppr)
@@ -2473,9 +2473,9 @@ static int blocked_domain_attach_device(struct iommu_domain *domain,
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

