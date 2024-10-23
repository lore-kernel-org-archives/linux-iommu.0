Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E21AAE10
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680358; cv=fail; b=XBBC7rq1o0PFiTbOOS2ZlsiLHUeRnOMmY1AL6c1LgqTlawSyEFQmdxZhhgo16iK/0Bu5q2vq3PT/AesKNcQZ/qWAWkrP2NGhB8pY9TiDIsUVtgCOHjNNVYk/6vw6C6g3rCC0XuDlf5+ocUOGdrTmGr97k2oqy8ACKCvnDseNkoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680358; c=relaxed/simple;
	bh=m5Zx4Alt05lsqwFL0NrYv0t2DJe+NNfBW6wi45BcJeo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SV+FHHon9MnMzv+V2/6eVKhqForHLLyC9EWK6gkyp+4uRCH/E0iL5lp9LHnH7S/BebdgYHPU0YuojfLAKRHhZyzocUcvLqlrOTyv400mlML4mN+1m1cz+NzM8PlVdiy73q78ZJOJxyNPhHM8wDzhTABtiPZR8hf7tQ1SNCgD9DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eYVQiDPj; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eYVQiDPj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+7sVdl2oFvqgEZak9MUT8bNooe+/9vRdDXPQ2NMerGJCE6Kt9vVjQ/LWlSpOKWqRU/Rn9YFIFrZ3nlvXEmIzP43gaJif9h1wi5H0KZlSIqsbgb5cLg7CXSR3Kry0CB1no7lNA49GK2sXp9A5P26uy9OOumFQf1Xrp5xeDMDRKyJrU68WQnMEQm5Ew6SsVSFEjBLDweR6fSLYkThifommjB1BMB/3UJyWNrAGizgF3dgAUtmnkPy/J/IzeQCqhIXx2+WeQVCcK/xWeGuv7SgPKhLQTx8VrPchCuicpPuTy+wU2T41yMhM7V+778q88Gu8eWUK3Vpaun8GHNXE/OK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2ecMGfHudau8m9MiKi57VIBzOVo5nTTBHvFoYDrAwE=;
 b=Kg58pM58tM8Tm4aIIqnmR9SLhm8pd8BNq4K4hnwPKBzdviUQdK7hjsLsCGJmbzMsa3W+B26gcA73xhW2yvZHAh3XjvTkO8JbxuFodaQM2vUyrVQhuUiarDBN6KzgrmcrqaSdXKMd2pCaXWw1NMhwz57jvc2DoniZqONHPh2LNFmJB3eFLq8VbCGn1u4OXWNUiimDWawhQGpKIgDkDcsIq6tQCV4Yy6vIRUAtnMezmSzs/HuTc6MM3v9mkLUEymlclyV6IYiBQlKGPeLPgeVSEivN7TVs3RZ63pQtBdV6Jf8IZDUUSBawl1Sb/c3WpwnurEwFkJOMfDG/7ocpqAYJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2ecMGfHudau8m9MiKi57VIBzOVo5nTTBHvFoYDrAwE=;
 b=eYVQiDPjfryq9FBh5l3HvCI0BtGzErK54onC1c7fNiFzACN27Kaul7/dCn/pP4CAHnHys3kfNTw9FO8nt2a6xusFYXA/tjwq0O8YoArzJneejsAzg6c3KH2aT3OlvsAmcYz2HcJZ4q7mT6rjGvquqX15hVL34hxtyhBHHnWYIdw=
Received: from BN9PR03CA0577.namprd03.prod.outlook.com (2603:10b6:408:10d::12)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Wed, 23 Oct
 2024 10:45:53 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::69) by BN9PR03CA0577.outlook.office365.com
 (2603:10b6:408:10d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 10:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:45:52 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:45:48 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, "Vasant
 Hegde" <vasant.hegde@amd.com>
Subject: [PATCH v4 12/12] iommu: Create __iommu_alloc_identity_domain()
Date: Wed, 23 Oct 2024 10:42:07 +0000
Message-ID: <20241023104207.5894-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023104207.5894-1-vasant.hegde@amd.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: 810b2f5a-4ab9-4a98-2938-08dcf34fddd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ejy/Y1GYQ2oJsJucHASP+AeS4q5UxzQBPXv9jdEQZBVyyXMxMdzQkiTbyvvJ?=
 =?us-ascii?Q?ecQ1bJ0q2wdLpSAPjeHmHpUEzm15GTgJKxKrHquRH+69uwdefM1Sa6rC5exR?=
 =?us-ascii?Q?jxDBekIneOOrJHdy3vy+iO3eTC2uOibG4KHFgNAjeXMXLMDFeTGJbKgRHsZ5?=
 =?us-ascii?Q?WMtO4OJW7s4mVNbbv79pcOBIxhR19jt57Sgp9RAZDRmroakmYsK1f89XGr9c?=
 =?us-ascii?Q?voJtc13H4nQSRrMBGb3mGF4Ozl9C8avOYI82jjqG1JQxU7n+SNcLwMkjBstm?=
 =?us-ascii?Q?rwqnj9dHRu2KIKk8aMtQ6enPMvAfUopa5PaaWwtLQcQp530unt0LGwCVE0km?=
 =?us-ascii?Q?bX2yWEr3xnWiOKLqR3Udj59iZngxoik8AwSEVcF3mVDu3AEbTXBtvzjpVbmN?=
 =?us-ascii?Q?DehUmz8BOTDZ4MZcfu+cP3xd7PZrjUsF9gcyazoG+CSd/oyTfwpKAzmUVB0P?=
 =?us-ascii?Q?Gadz/oTgRZBWoCXsNLVR0FcMLVQLM6um50WcHLXyq4ZutV4qLXl4/FeTVRyX?=
 =?us-ascii?Q?TMoOKDQ35S46Mytw5AIAqrbDoJySOF4d2YQ6zIgPBWNSd4eEYk2PRWfMqudq?=
 =?us-ascii?Q?y+u2ngpJR57pl7K771Po/uDu0MMoBrWybwG+YQ63n48jxN81wPNFNyPJ6V3Z?=
 =?us-ascii?Q?oYd7qMD/OTfuh+q4S8Hk4T1/JsRNpsp15haLPrdIyYZJtmsVCuddRT1F6hI5?=
 =?us-ascii?Q?PbCDJmoE5rW6i8DaoIFxwCR1HrqTIEL510AU0uHwJ4qtNSx0pKX0nh+wwgBq?=
 =?us-ascii?Q?MNmxoJDwxXzILroIZgR0veDPkXvTOf1AR5fpiOzblEh00YrTs+00sEp0ikgh?=
 =?us-ascii?Q?GFG2B8IPZlaOGDrE9L4RSb8FCKBUPyCs//BnMYJwe+o+jYgczTxKgZiMBfo+?=
 =?us-ascii?Q?jA0Ub20+yM8AGl93Ei7jgBzg4pE/jEyD8VFVnFJz2v3vHvyQo+jA62QLMj0E?=
 =?us-ascii?Q?+NIHJm/7GxWb9bcfxAl1wwbIhQc9CwT9WqC3e0R/J8W8Ks1upnChQi4GFa2j?=
 =?us-ascii?Q?AVYok7UQNJAGxzR7jwG200nnEzTTo+8JfvAeAFWfxLjE7Zr1T8G5naE3wf+G?=
 =?us-ascii?Q?br0WN3mGBnPSe/cm3ppGhz3OZSCSGn+RDwdOZB0NkpRup6VnYNKWh8yRzj5g?=
 =?us-ascii?Q?PjG/AIGKnIiHLO6u8ZrxMghwyFRW1DkFiFU02lI4J4pQcBzFteSFpp+2W7/i?=
 =?us-ascii?Q?30Iw+UTwzMFeWT4y06TJho04ikuzcOEBNXiSEoAScWvTaEigKWuj+l39U9rX?=
 =?us-ascii?Q?PPjMU247LXMZaD7fp1A8kN1REYhf87YHvysR8PVRB0ODFEUP4aXCZ2ORsxLr?=
 =?us-ascii?Q?vwc/GTyjBVJbqgkGvJQqsHSRDHnM0L0QwFKA25mIIEBmDrlyRlUBkrQHkJGI?=
 =?us-ascii?Q?IwbvDTwQ9EMGkqQZ1jgGy9GPxE74b2bIVKpIo+2k3/GI8lMQlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:45:52.8515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 810b2f5a-4ab9-4a98-2938-08dcf34fddd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041

From: Jason Gunthorpe <jgg@nvidia.com>

Consolidate all the code to create an IDENTITY domain into one
function. This removes the legacy __iommu_domain_alloc() path from all
paths, and preps it for final removal.

BLOCKED/IDENTITY/PAGING are now always allocated via a type specific
function.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4677b676bd0b..dfc2f9816086 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -94,8 +94,6 @@ static const char * const iommu_group_resv_type_string[] = {
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
 static void iommu_release_device(struct device *dev);
-static struct iommu_domain *
-__iommu_group_domain_alloc(struct iommu_group *group, unsigned int type);
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev);
 static int __iommu_attach_group(struct iommu_domain *domain,
@@ -137,6 +135,8 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 						     struct device *dev);
 static void __iommu_group_free_device(struct iommu_group *group,
 				      struct group_device *grp_dev);
+static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
+			      const struct iommu_ops *ops);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -1590,6 +1590,28 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
+static struct iommu_domain *__iommu_alloc_identity_domain(struct device *dev)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_domain *domain;
+
+	if (ops->identity_domain)
+		return ops->identity_domain;
+
+	/* Older drivers create the identity domain via ops->domain_alloc() */
+	if (!ops->domain_alloc)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	domain = ops->domain_alloc(IOMMU_DOMAIN_IDENTITY);
+	if (IS_ERR(domain))
+		return domain;
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	iommu_domain_init(domain, IOMMU_DOMAIN_IDENTITY, ops);
+	return domain;
+}
+
 static struct iommu_domain *
 __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 {
@@ -1617,7 +1639,10 @@ __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 		return dom;
 	}
 
-	return __iommu_group_domain_alloc(group, req_type);
+	if (req_type == IOMMU_DOMAIN_IDENTITY)
+		return __iommu_alloc_identity_domain(dev);
+
+	return ERR_PTR(-EINVAL);
 }
 
 /*
@@ -1983,9 +2008,7 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	struct iommu_domain *domain;
 	unsigned int alloc_type = type & IOMMU_DOMAIN_ALLOC_FLAGS;
 
-	if (alloc_type == IOMMU_DOMAIN_IDENTITY && ops->identity_domain)
-		return ops->identity_domain;
-	else if (type & __IOMMU_DOMAIN_PAGING && ops->domain_alloc_paging)
+	if (type & __IOMMU_DOMAIN_PAGING && ops->domain_alloc_paging)
 		domain = ops->domain_alloc_paging(dev);
 	else if (ops->domain_alloc)
 		domain = ops->domain_alloc(alloc_type);
@@ -2006,14 +2029,6 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	return domain;
 }
 
-static struct iommu_domain *
-__iommu_group_domain_alloc(struct iommu_group *group, unsigned int type)
-{
-	struct device *dev = iommu_group_first_dev(group);
-
-	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, type);
-}
-
 static int __iommu_domain_alloc_dev(struct device *dev, void *data)
 {
 	const struct iommu_ops **ops = data;
-- 
2.31.1

