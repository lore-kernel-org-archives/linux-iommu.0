Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49713241E7
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852719; cv=fail; b=pbL7uIwxMwPt5nzkdE5dITvP6Clj2lEhhO/q2r4BZ85IjVkh9x4DGubSF3WneQi4oiVT8T+XKrz9rEndt8u6StWlmnhBpJQAbOCBCgFAiVO/Sx7nV/cBJb6xm/4JmvEfu8W92Ft36cLDGg1kXfnf4mXb05Bw4a03JHpTzkf/gs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852719; c=relaxed/simple;
	bh=pLMa8id+xU1Qn8bvQF9EFRYkWuImN9Rr/nttN2PZZCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mH1xr6NaLSdr/ucFF25b47qgXm/kjbx57I1CO+ZslelxHPg8P2XdntuSHsqnKvAgHBKu44tOJDfSC/g4dIKY7C+UttvBdnqmjIP6/EvlQo/HwBzL6GIr/D8fLtdFD65b/T5KPdj6IQm28JFDVdPw4zK503Gii6IVJIIvzzo5m0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gvpOH/s2; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gvpOH/s2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPj3zoNclbtAtaspT0ovOah87Np9S3MT8x0riCIemg6Up/WqsGTub6pXZk0Vu9mWplNHK5tbdHhq8oB1+g88/aZvFh678KWFClxeWH8AquF93C9b4I/lVwFGzkjqsqgGDna+rMBAQVmYB9oz2mrkXh/7TrANOPDqjBpi5iD3Z+OY7cGNIsiOADTIYMhNwIjbXpxTWSsEFOuSQJ26JgX5TTE2GBJjsc2F13tcN36FySqbtcRHGo3mcijlWJkYfyg7CRW34kZJXqkolIpc9phTSiRD+zF0lCb0rn2f6zU+jmBh7yehDsIS2Gbt8HCkHoatIGYh3KazTDF/o4RUNPU32w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJr6jDlReRDP37Ch48YT6DNc6JpuQL2CPz32TtOud7o=;
 b=KFKgFljCMFGh/RPsGfWnmdo9/UdG9u0k8ZdAcOTP4sVb4gxhyL9t/W+zSYXFh/cCho9CGt6T68JrROTTjtDE+HM8tdTUCFBwOHZAQNCIhBKuczQ5Du1RZaZpbiaF9/v9/2e2CyB018NUKC0/h5lQoHrKptcYV30+Hq8OrW+tK6aeYKGzJyo2hlnLy1q5EQFOJ7Msa4p8/07JCO9zVKuKbh1J96j+i2OZeAXS+l1061eKX6hYvjvhuRQ7I39XE2tOsHU+U9IVitQWvW+OcF3LdII1F7h6+jxHgFEA/92Xbk1zvwnCNyjSjVNPp2M4w+gAZLJ+7XWXTwuzj7odQXKmfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJr6jDlReRDP37Ch48YT6DNc6JpuQL2CPz32TtOud7o=;
 b=gvpOH/s2kHghPGPR2OJ/iH3BlrkGYO+jLVe7K8PUIY7lFP+YEW1kEc/RkAmOFitd2HnnK7HFSMvUKYxT5PdKqMIQhqiu/yVrJt43lpsKLJBE3aYV4C5dcpGOstYTWz9JeeYCzCU2gnGOL9aeu79ZGgXf+lQKJVV5RKFs0bzOOQw=
Received: from BN0PR08CA0005.namprd08.prod.outlook.com (2603:10b6:408:142::20)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 13:45:14 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::70) by BN0PR08CA0005.outlook.office365.com
 (2603:10b6:408:142::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Wed, 28 Aug 2024 13:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:45:13 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:45:10 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 06/10] iommu/amd: Reduce domain lock scope in attach device path
Date: Wed, 28 Aug 2024 13:43:13 +0000
Message-ID: <20240828134317.6239-7-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: d584b5bb-bfdd-4072-9cb1-08dcc767a468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f4nZPWNDar9dfRaEpFM5KRCsdro8caR4u7q2Xt6CRu89yCzqdLjFxWimc/0Z?=
 =?us-ascii?Q?rL8o5hvqypgi5bZlNbzJV/Ok/JHZpQ45K5nOFHtpJ0x5tHIq576HVMkm9jWp?=
 =?us-ascii?Q?QlkmtIS0iZsFHWeie40ozlamWzb2vKqDlU4Ehcaw3zhabgHutCgleHna9vWj?=
 =?us-ascii?Q?a7Owb2ODejMmK+72HqpbeNY0FdKXQ0NPAoxmZ5fTOFqCc3sjRmnjwFsnrnus?=
 =?us-ascii?Q?TS3nBDrtiEoz9ALLdcBrFb/S3kPukWkzj7IXOEPARVpyW8rSsb0XnPo+Trg5?=
 =?us-ascii?Q?AzbJp84xE5HYm6f8uzW6Y4lfZ34n/b9lVHNmviRmtOvs3nR2D+DjJQu1GN9n?=
 =?us-ascii?Q?9e7KLYNyOE2PxOX7Bt64dR2MwAgdbXyiYqUfGLtAzS2cKJ41+JnisOmfKYDi?=
 =?us-ascii?Q?vd8+p7kfaNmvWXF1UKyVbPEM+R5K+uVsLQ9QVbbWxEdpi4P+TzHjxkrode/4?=
 =?us-ascii?Q?LSqxgkVmnCsKFOSNbm6D0s1PLfkpcHmhU37tm8783HtTBegUeC5nDW/Slidz?=
 =?us-ascii?Q?NWFxdbCvNWtzQ52vMKcR1vB6JhCa07g9+gCGW1gSiJ0N4gHoT3K7WAxPLr0b?=
 =?us-ascii?Q?J3jkGLDe34DJgfYg9eDfic4ax4KMCryR/tma8CV7VzNzcjD+Pyp+IwMLate9?=
 =?us-ascii?Q?Zn29tLYcFP3/rAEE9ihlBcaxo8LGPmJLY7CmTTRqT1Zja2Fn7yAIP/fafHz8?=
 =?us-ascii?Q?tiuFT71aurpHpBAAw6DzNFacUisgGnuonYTwbg0OdQBQuk7QaVVL9Xnro55C?=
 =?us-ascii?Q?i23lV8ii8906FRs6HEs7Xki/QKtlPw96lmUwM1GVn9bxysgNkfz7MvCws/K5?=
 =?us-ascii?Q?YQMeBKe8jpI0yC5xlT5F/eK0AkDctGgTjyIb97Q60qDKyMm48bexzmI85uz3?=
 =?us-ascii?Q?VwOV0+pL0wyAfnaS4bAiaW92Sk75Frl5niAed9ez92x9sEXXrK2Coh1BIEY1?=
 =?us-ascii?Q?OV+GMQVo3TFPWXvd2AzZnOq3i+TtSOAqF0Lj+8RcjY2/BYiwhkWixkYdD9Yl?=
 =?us-ascii?Q?NiWECImY0Krx51Jlf7KaqMfqSu8+j9GoRAM96qRuMwCdgUg/pLS8jYUqtZ7u?=
 =?us-ascii?Q?EXR0CKXJhRY2zHUqVy1aaTTgxOLuybaHuE2OCL+6itbecYeyYaXoMjQLVLnu?=
 =?us-ascii?Q?rXr+hjSPTIkPFwS7BMYtaz+deFIatXemfP41/PUNAQStTinCY+VBJowQD3XX?=
 =?us-ascii?Q?CUV0EdGIuIvB03JfcrEoMHyw4Q0UO2DDyggdFlte5cri0tjtnpIgfCW4g4x7?=
 =?us-ascii?Q?Vbgar/gSOjY8lkIR8pxfKmCBLQaJII5ioEd+jgwgQsbRpFsjJrnN40EetApD?=
 =?us-ascii?Q?fJkBx6AbYeK8FPFl+icRiOG3HIA+Glo2Q8MrlKikV2/+dfs8Z3Rt+w4iYZ34?=
 =?us-ascii?Q?SmWDVPge6Yjw///RAP23IgQBemn3wonRrqBCcuU9NA1c9UU7u+7yYhrVgzgX?=
 =?us-ascii?Q?LfzJaC+8rJd+jZQqSfUfA22t8YUBOseX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:45:13.3021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d584b5bb-bfdd-4072-9cb1-08dcc767a468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913

Protection domain lock is required only when updating domain details.
Hence reduce the scope of protection domain lock.

Also move 'pdom->nid' assignment to pdom_attach_iommu().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 47 ++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index da3c42fe3e86..45647aafcc3e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2018,16 +2018,22 @@ static int pdom_attach_iommu(struct amd_iommu *iommu,
 			     struct protection_domain *pdom)
 {
 	struct pdom_iommu_info *pdom_iommu_info, *curr;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&pdom->lock, flags);
 
 	pdom_iommu_info = xa_load(&pdom->iommu_array, iommu->index);
 	if (pdom_iommu_info) {
 		pdom_iommu_info->refcnt++;
-		return 0;
+		goto out_unlock;
 	}
 
 	pdom_iommu_info = kzalloc(sizeof(*pdom_iommu_info), GFP_ATOMIC);
-	if (!pdom_iommu_info)
-		return -ENOMEM;
+	if (!pdom_iommu_info) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
 
 	pdom_iommu_info->iommu = iommu;
 	pdom_iommu_info->refcnt = 1;
@@ -2036,26 +2042,40 @@ static int pdom_attach_iommu(struct amd_iommu *iommu,
 			  NULL, pdom_iommu_info, GFP_ATOMIC);
 	if (curr) {
 		kfree(pdom_iommu_info);
-		return -ENOSPC;
+		ret = -ENOSPC;
+		goto out_unlock;
 	}
 
-	return 0;
+	/* Update NUMA Node ID */
+	if (pdom->nid == NUMA_NO_NODE)
+		pdom->nid = dev_to_node(&iommu->dev->dev);
+
+out_unlock:
+	spin_unlock_irqrestore(&pdom->lock, flags);
+	return ret;
 }
 
 static void pdom_detach_iommu(struct amd_iommu *iommu,
 			      struct protection_domain *pdom)
 {
 	struct pdom_iommu_info *pdom_iommu_info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdom->lock, flags);
 
 	pdom_iommu_info = xa_load(&pdom->iommu_array, iommu->index);
-	if (!pdom_iommu_info)
+	if (!pdom_iommu_info) {
+		spin_unlock_irqrestore(&pdom->lock, flags);
 		return;
+	}
 
 	pdom_iommu_info->refcnt--;
 	if (pdom_iommu_info->refcnt == 0) {
 		xa_erase(&pdom->iommu_array, iommu->index);
 		kfree(pdom_iommu_info);
 	}
+
+	spin_unlock_irqrestore(&pdom->lock, flags);
 }
 
 static int do_attach(struct iommu_dev_data *dev_data,
@@ -2068,10 +2088,6 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	dev_data->domain = domain;
 	list_add(&dev_data->list, &domain->dev_list);
 
-	/* Update NUMA Node ID */
-	if (domain->nid == NUMA_NO_NODE)
-		domain->nid = dev_to_node(dev_data->dev);
-
 	/* Do reference counting */
 	ret = pdom_attach_iommu(iommu, domain);
 	if (ret)
@@ -2120,11 +2136,8 @@ static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
 {
 	struct iommu_dev_data *dev_data;
-	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&domain->lock, flags);
-
 	dev_data = dev_iommu_priv_get(dev);
 
 	spin_lock(&dev_data->lock);
@@ -2139,8 +2152,6 @@ static int attach_device(struct device *dev,
 out:
 	spin_unlock(&dev_data->lock);
 
-	spin_unlock_irqrestore(&domain->lock, flags);
-
 	return ret;
 }
 
@@ -2150,13 +2161,9 @@ static int attach_device(struct device *dev,
 static void detach_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
-	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
-	unsigned long flags;
 	bool ppr = dev_data->ppr;
 
-	spin_lock_irqsave(&domain->lock, flags);
-
 	spin_lock(&dev_data->lock);
 
 	/*
@@ -2180,8 +2187,6 @@ static void detach_device(struct device *dev)
 out:
 	spin_unlock(&dev_data->lock);
 
-	spin_unlock_irqrestore(&domain->lock, flags);
-
 	/* Remove IOPF handler */
 	if (ppr)
 		amd_iommu_iopf_remove_device(iommu, dev_data);
-- 
2.31.1

