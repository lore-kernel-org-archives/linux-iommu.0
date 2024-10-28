Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0233C1D6DC5
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115284; cv=fail; b=YlqYhk3FWigXH0iPKLM986GuExx9nN2NgajadDoa/r4muCE2e+2EFvk7qAtvdr3IX4oIYmHYdNBqmO/kTaVRZR9fyI03RSWHG/TPREyOCZguggxa5MakrEYswxvE3B4drINWGEM3sZtQCdgddMEZ9/EvUMzljTUBgFvbl0eOObs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115284; c=relaxed/simple;
	bh=Lw2n34nOXHR54pV5DtOzdyEJOwhe8MpzFAH23Ec0w/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQxRHRPTxP4COLznAcPi2IAdo+F0d9Wt7l9jY7/b7qnjWZN2zH6wQUtCTAMCLGm9bZkSmBWoAE/SdPPH58++Sy4CKAxsisKZWtuixnT2GjdUDWVMKI1RzM338EbvSMDPJS3aYxMTQshotwc+jrDGFKDDARXJYM67ZCEf9hiELrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2b8d7ROd; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2b8d7ROd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTMuvGlb1R0fTWkim3kCATuMCK4qNdmsJFKOO8c/ShmjZgQtYCyWhuX5f2lToXRGw1ErBU6kGcLR28t+GyDDKIE2Ud8RVdGi3A0/LPNDfCt5kgPQrncYMOIzSB6LpWxjzvJbRySr4J/pbFbtG0sh1lOmjXB82F3z0mmYZridwXjY8IFevNsKBm2HqviXP0LkLRytvNOMG46iMtlrBTvDSqv/AGc785lod7rd/j+cBXVcNC03XpEr/h8p9M901N/WJ/lXVr0wghog10VbevYzzI3lb6e2bTb2S5qCzFkrSKextbPMPwMqrWh/rHLCSrlHgDUTPOP0TfI/uWmiR0hOrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRgD59kxpnrUIh+ekQeMJ3sOl/jEF3A5U7hLTd2F4b4=;
 b=pOCqOwMHcyuzgWdDsIoYJNSR5pkN82/4ByXx41d2h17pKM+/5ZIJw9eEMoM6naqgmtM+qFD/YnNKJd8OJmCJxyzxRZSWn+IiivAUSDbgpULEPp7HCjwv6FfgHyEXHtyshSlg0RTE9mt72LFH70GI4ADDaZaMQ7nRCFMZeBmQGGqnE/qjtHX9aXD1q7HGjA8x5XwCLpIVbfHWGy+51lFVgQcMqXtdDkCehtBs6KQ2/btJGM+rz/fqo6fJw9KW88hqdIMtoSZ1ViH0GejDaFF/Lm9eU0zq5kZZ3Wlxrh1F1pM9N8+VkLFgzejDDf76hNZSBqrhFKr/ZvVDRNaCNtirfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRgD59kxpnrUIh+ekQeMJ3sOl/jEF3A5U7hLTd2F4b4=;
 b=2b8d7ROdB9M9eXg46tS2GR5zU+lbQjlp4aFu9dj1PZMj/2mRvTqvNY1Gez3e2/VxhfeYNHVF+AsXxirUy3Cw6kHD5a8Q5AdVIJo3xlvRS5mIiBsNdcK7Adr6kmFmx1C0H2wouwfU++bCe+hGe26bQ97C2IgevaYIgP3gsysLq6k=
Received: from PH7P221CA0057.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::20)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 11:34:39 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::eb) by PH7P221CA0057.outlook.office365.com
 (2603:10b6:510:33c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 11:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 11:34:38 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 06:34:35 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH v4 09/12] iommu/amd: Convert dev_data lock from spinlock to mutex
Date: Mon, 28 Oct 2024 11:31:45 +0000
Message-ID: <20241028113148.5774-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 05476f3c-5cfa-4d0d-ebdb-08dcf74481fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yqzqd5FL7uqiT65vabvyLPKsAmfJbEhfOP2Iz0quhR+VhqyuTeTl1A4tP11+?=
 =?us-ascii?Q?KSTl6k8Sc9H/WatQ8CqtR7Ow5reDUZKgG5kCKtnHuCO2wUwAORjIb/mXAq69?=
 =?us-ascii?Q?j2irV4TXPNA4LlnwkY87ESW/6vMct5oZArP5VRteSM9queDpwO/pFxCflqiP?=
 =?us-ascii?Q?lwjynmZXkijX0qrSkKyAxfFPBkWZ8F2pyLSgaJ7WCuwhpJuzhV9TBjPNYqfB?=
 =?us-ascii?Q?l8/iE6vqtc1yuftkgHXuDIGjMwga4yS8k5keAkIHrFEOu/G2CtpxB1u4mMBU?=
 =?us-ascii?Q?jbkw3zaTquGmjHWjwuYN+IESFvOBPmeCpp7HvgMEsv/SRY1bTiJSY8MWuPuL?=
 =?us-ascii?Q?tm7dzLCyJ6oIu8Pjw0gvOWpB6u6l2UAaoupayjaDQ70uLC23IsKboMpXvPkw?=
 =?us-ascii?Q?Dyx7i26jJWoeIYo1JO5lPJMh4GqYniDBn4jmb8A2JkHPiHVD+0WiVlpLbxB+?=
 =?us-ascii?Q?tS077JStjoIgTjGyg1lFhnXvADs3eXdOCnl5OIYjdrfSNjLRssI6jSkhcGN/?=
 =?us-ascii?Q?RZuFDdkEKb/7gpNfTq6T3KmIAXhWH13pBuQORRBuIYLpVkDk80qfWvvUTov1?=
 =?us-ascii?Q?OrHBrwtjN/EbE9X8sCfwnORe/ugVbB1rrZNnbE5O2JFiJ4crsXJ3il/2MkNE?=
 =?us-ascii?Q?953Vh5OrUF4ctEMsuOudM/CBiCiAMS2g9kgh7IwqEXKrrzpHYj8NX4YJ3kKC?=
 =?us-ascii?Q?D9Kq4Tnz4xui2W4TjTTTu4wzUDgl8Xr08eKmVsXhcdA0LPZ4xHTy3Y3uey1V?=
 =?us-ascii?Q?514fbhliGrnKu9WQJvCgX1Q5I2xhJrPOHHA391JRmYhevzjNWGU9cfUGNmGE?=
 =?us-ascii?Q?4Rs8ADFjMuGVwsq0N4LazUtz7TrcjZMN7Bv4lI9PrI1g/p+3vjaBHtnZP25p?=
 =?us-ascii?Q?T/4mrv21q0zq9uiFalJ8H+xTWZ2KdDxr5JXEYsLST08Aogtpm27cdPa+12Uj?=
 =?us-ascii?Q?ksiCt9gzGGpxmI+G1Ny0qDm3L2n8p7Ni28scgGj2giUzsdjz1tIeOYtKJTGX?=
 =?us-ascii?Q?1c6LoJCWADeRfgk/401U2zJXL5zC5Bn0D8SAWnO9+qJf4UKyBOsFXxtt5bSs?=
 =?us-ascii?Q?oWzcPKieXZdo9OkcE8vFKe3DOpxgx4jPAXSMaXGBToTLnmFMFb7WetV1zk6/?=
 =?us-ascii?Q?0NKS419hkPevyIp+ssQ4mdnWy2LyPg8IdknIVBrundKfOVFqraB3H4z0q1aZ?=
 =?us-ascii?Q?oU0BDwEDKVx3qMmt8PYQLRfpyFHhqZsDE0gropG0IiBGkwjIRqy/lQD5psIv?=
 =?us-ascii?Q?UbDsHs2rHAKlrzhZXxqiY+YPfCcPQQyvXEQw3Rn/HDH+smgf5XfYdwcTxmet?=
 =?us-ascii?Q?JQDqKKMb2xhwKVhUEupdefwxzD9pJTb1fbTInPyssb/7aD9IAQlvoa7zP4TV?=
 =?us-ascii?Q?WqJB1CyOsh+gGIYjsAcUc24C73422klQWUr5XeIohSx9CRkTow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:34:38.9372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05476f3c-5cfa-4d0d-ebdb-08dcf74481fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185

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
index a7257d9e6388..fac634b24c72 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -207,7 +207,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
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
@@ -2131,7 +2131,7 @@ static void detach_device(struct device *dev)
 	bool ppr = dev_data->ppr;
 	unsigned long flags;
 
-	spin_lock(&dev_data->lock);
+	mutex_lock(&dev_data->mutex);
 
 	/*
 	 * First check if the device is still attached. It might already
@@ -2169,7 +2169,7 @@ static void detach_device(struct device *dev)
 	pdom_detach_iommu(iommu, domain);
 
 out:
-	spin_unlock(&dev_data->lock);
+	mutex_unlock(&dev_data->mutex);
 
 	/* Remove IOPF handler */
 	if (ppr)
@@ -2434,9 +2434,9 @@ static int blocked_domain_attach_device(struct iommu_domain *domain,
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

