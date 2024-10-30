Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452691D0E27
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270910; cv=fail; b=N7vsZDEDPlQp90RhII2vpLQf6NkZ+u1YFDIiGPMuc8pZanOMjImrgougq93rW1Qv2gnUeEonISqBJqr/bWq8YdCitCtibr8XtOMLIjmuqsGWJQRzhlLbDTPkc29lojANEi29KoiH8Cwt+YD10SC3QzlZxSxg0ZZwqHNh0RFkfgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270910; c=relaxed/simple;
	bh=t85WBXQL31sywHdch0U2DOc/VMLOG47LtGiRTyDSKE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fu3+Q5bQ4FLI/HuN2E5D7uojsj1V49N+iFnQL6ZUReaZGfFNUrrMN+qBSyT+M/lXJkSdhZz7MYUI61GAvI8Sx5SAUOcW6HsuKHWzIDUHk3OfqVMFojq5gSBydI8GShZNWdcAj1FUklvAaHHfRmkqMYLsb1q5LtSIDOYuUh/hMwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F2Dr33JH; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F2Dr33JH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgsIqHl+iEAAYDhJrc6Uw5SY+5IkAG1k60SQffCQQxfESOnoV+Lsq9emKDlBVYjHs9+WwZygOZoT0OG2rUXJxH4qCec4/pqZajG0+pVpdUuL+Ahale288IHBF4WArL+UIbeWRp0+6a65faQioeQgwg18cIEKUobyOiwQsqfB1eEu5h39YasCqTdn5uRI1J+YSghJJrejzwSsiduetC5OGtbn5xVuIqWwNxdvz7sI92bo9XRHP9H/pOeSI3UWrr7INQN6uzDHXqEUe96YRueL0emIykuag1quuV2Uwk1DIfS76uaLgHqO6Cuo+2t+LFzpFG4/NnAx6n4/YgYET2lWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrWumuj2jN5DtmQFGQDOG9iBOzzOo5aqEZUNVIy9rCQ=;
 b=OQ6ZKl6OKSMIeIghPPka2qOF+AvLJB48BeNP+jYl00Iz3C827JnOL9yGW5p4LLYs0Ig8HSzpkoFmi/evGZTKfA4//O/U2No3+7pAaWGnm2UxWzmp3c215qQpnwtB0bDOzFZL8s+4b/DlOvKcNrTR3j/rLLtEuzA/SZksdAsgOFFAbEbx5x686kHsdgxgkN3BBKwSHmndtSri60B+AJWMZi9LAa5ER9fOaSSc/SGln3QLzRkMbvhqZLOZEoYrG4F+MJ8wX9VoFeKEEME2tZtHyXLmTf1WShrurPuq4XKYerYQWNrIIhKhbx7N1P2YA0k43aVsHxDJEG2yu/PYIHozzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrWumuj2jN5DtmQFGQDOG9iBOzzOo5aqEZUNVIy9rCQ=;
 b=F2Dr33JH7K0CWhS04D8V0ND/7YLMgHZ56++ZmyDKFuSfjIwb62xjfDla77jgzj/pOTOaD979OePAAXB/Mg45FnUTmngPXUGoV0hFCzYjmBS6cgqaNwvgLfOAua7i8ClV/6FrF3X4+Kdsb7bYXiMGJ/yESZWgg952HqT5nbJzEfM=
Received: from BL1P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::23)
 by PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 06:48:20 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::ef) by BL1P223CA0018.outlook.office365.com
 (2603:10b6:208:2c4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 06:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:48:19 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:46:59 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH v5 08/12] iommu/amd: Rearrange attach device code
Date: Wed, 30 Oct 2024 06:35:52 +0000
Message-ID: <20241030063556.6104-9-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|PH8PR12MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: beaae275-1aea-4e38-8b9d-08dcf8aed72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ApIBj1ac67ug33VbL0ROeuKdXA34TAuZJU+QToOU2fnapKqp1A/pG36usb26?=
 =?us-ascii?Q?B+dVYAuvY/yy3Ib7nmoGQM1O7AWCwi830nxK7+tssarXt0gW3vyEKngpgiup?=
 =?us-ascii?Q?05du+1/znDTg3B3YqeAwtgqIP6InwH1V0wI1oi6n+z9okqmJuDv+pEuMEpH3?=
 =?us-ascii?Q?niv3iRU+40tlOc6b+zUfRWGwxF+ku5u9pzScQ9HzjApfFxViALAmG2MPkwFy?=
 =?us-ascii?Q?jlf1KPk9j+ZUfGlfa8HbTSV2eVWAn9klsVzzkVcDL40YfYtaadlJlV1r8K36?=
 =?us-ascii?Q?a+jnchsaC9sU6T3s2utwEYEWcy9inou2OSJMmDpSsSAc/vDiYNU5TqlR9Xkb?=
 =?us-ascii?Q?Boku17ndPI2mg3kTF1rRp0NgKkcapQfrwl+lqUCdfiztjX6LT9HtRCOwR4t+?=
 =?us-ascii?Q?xGA+umiZgU6imGAvAoXe4rm4gKDYdySfTOFoDFr6Z1B8hjn6rcfmfwdsht4q?=
 =?us-ascii?Q?6YRCG4JVzFu84jaVgO28bHtN/CXi/rkOvXom710QeRB7QTTwr2CYoJeZx2YE?=
 =?us-ascii?Q?rR5YpD+/AvXv430CRY9kmagghTCmiHao2QXV+m7UP76ogaG8JHoxzZCT2Slp?=
 =?us-ascii?Q?km9oyu3Ym7n0nYmv3ogN5KZq0w1EANqrOGI2HMOmeVZju0MyYDMuIzSMAx/y?=
 =?us-ascii?Q?p+CLVoV5vfWWdlWYqfjuLwDjfKyLOROnMVXPMGsZSDPA2JMvMRHfUH9D08Bd?=
 =?us-ascii?Q?98WWLHqAjLKpl69p1UqOW5d4IyklqPaORUamOWow8Id/bnhwF+VLJAbzsw/h?=
 =?us-ascii?Q?TupILMyARYLjjzgJTZO2o05K557zZ+997ke2iDIwNv3ypGxFXPk2I4nMiRlH?=
 =?us-ascii?Q?ejfnlMrdJG+gysSBTZlxQFQOJZsmdbmqKMalRtRSIJwvI7fWWoe71FekeAC/?=
 =?us-ascii?Q?LoQfrUfwcLT9bzBFvK5bFD0BYeD52KXXdWNAf3xIeqAgPjBuwX6rfrcNTuiK?=
 =?us-ascii?Q?pnQOZwZgqiiX8EcxRtUCOaCw9WAkWOVi4nI3yWqMrbHTgI8FXoO/npbM0if7?=
 =?us-ascii?Q?10YyAQ2TD0/jETN75eNenLnZ3X3t+nKPBia/okt9fTQI4QEb5Bho+9zSOxcB?=
 =?us-ascii?Q?MGzmrfgtHQBdK1NXgTWHaJUnvjj/kmCIoZZRHq+xJJ5078BdAKGfHoaGQ21v?=
 =?us-ascii?Q?50nF82vH06+bC08aBV3ep7d+CmZzcs5sEXUV9ZWjdJYinWB6oIof7wzuLdOI?=
 =?us-ascii?Q?wrUdBCxgqtsxecuAvWy4+9HsMEguVPnsIpX7WQLWlFPLEN5h31yQ5CnbqtwJ?=
 =?us-ascii?Q?qoFfBcVpRCn+t9mWcpbUYirjsL634I29e1q4Hbg86MKmMxfZEq3DlWSs37l2?=
 =?us-ascii?Q?19oZL7tJiYmBBDgR3A8T/UzCaGya55WSnma3988bFc6Cmd7DFq6CtijFvxvc?=
 =?us-ascii?Q?qNwvnXh2ec7KK86O7M3lsiJJqTnpbVOiiODfJMgTlGr6VvaGVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:48:19.7070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beaae275-1aea-4e38-8b9d-08dcf8aed72d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028

attach_device() is just holding lock and calling do_attach(). There is
not need to have another function. Just move do_attach() code to
attach_device(). Similary move do_detach() code to detach_device().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 91 ++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 55 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f5ba715c8efc..7cf6f44ac90c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2081,12 +2081,24 @@ static void pdom_detach_iommu(struct amd_iommu *iommu,
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
@@ -2094,67 +2106,17 @@ static int do_attach(struct iommu_dev_data *dev_data,
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
-	unsigned long flags;
-
-	/* Clear DTE and flush the entry */
-	dev_update_dte(dev_data, false);
-
-	/* Flush IOTLB and wait for the flushes to finish */
-	spin_lock_irqsave(&domain->lock, flags);
-	amd_iommu_domain_flush_all(domain);
-	spin_unlock_irqrestore(&domain->lock, flags);
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
 
@@ -2168,7 +2130,9 @@ static void detach_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	struct protection_domain *domain = dev_data->domain;
 	bool ppr = dev_data->ppr;
+	unsigned long flags;
 
 	spin_lock(&dev_data->lock);
 
@@ -2188,7 +2152,24 @@ static void detach_device(struct device *dev)
 		dev_data->ppr = false;
 	}
 
-	do_detach(dev_data);
+	/* Clear DTE and flush the entry */
+	dev_update_dte(dev_data, false);
+
+	/* Flush IOTLB and wait for the flushes to finish */
+	spin_lock_irqsave(&domain->lock, flags);
+	amd_iommu_domain_flush_all(domain);
+	spin_unlock_irqrestore(&domain->lock, flags);
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

