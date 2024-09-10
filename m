Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756A514037D
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951614; cv=fail; b=fjDfhTtGhsfHLmLzJLFC8yBGO6F1RlW5eUJYCQ99p2OTEcPCbXFq4jgdcAkOL8+3kNvnmvEjlC+upx02j5ffMcB951I+Ps3uKo5VkYVLoKWnz6Q9wDFtbQCggBEhj6L6XTYDxwwxxuhVzrFc7zSKPkmJcFpVr/aJqWG+gj5JW8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951614; c=relaxed/simple;
	bh=Ex5WgsfLh1aNyqCMF6FFhfYTu1ZnvVQrcEHoi+kGFu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usnQlv1Op5/MCXdTYgcLYEtD6YSr/4y3eaZ2PRsYuvGq/UfxcHIExLuphIBBSNsT0YqDGjGmFslq6eS3oRZS4p17Zy9K6qp2UakvsewMIMIwsDDzb9WmV0BbMPXX1iCfQw7OfZhcGD4E2z6fld15GXtV/GdHP4xvK45ichi+4jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A90sOM4t; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A90sOM4t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3zdm7pd38fSCDGu200NPfEezHhsrzFUrdlQiatCiAnsuO4GeM6y87q1sHHDTWTy9or/JbkkolnpBPDueaTl6su5+IvkzejwzNsJfQCo6WM81xxm4VJKxdKYTF8RRP1oSIBbZMGfRmDeoGPeuzD340rIufurGUlVYO8TrR2UVk/es/J6EeMdNIrsnDyd0rFso2Rd5MDm43vVUF6qjzIggqgszJXI/3BCazysOIs37N1IfgHt1B48Ym5adu1mFoSMpjxODPpKHSFF0wJYswyUuQQyopQB03Yc7fGDEZFu62IVmkXRopQmEz3/tkQ44ZAR21nXmvT6QWmGD+Uwy2L3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjK96TyCYR3bN10vdQR8uMsGHA1ja9peRy+QVWsE4Ek=;
 b=hvj+i/g9tDKXoK1Xayy08uY5KL8iKbBoLjQmHxNAQcXZrkuBVmk+R85YAFXuehDZ1rJKn1ipaXp5lR2VU+TyJEcmtlHBvZwtSYrT6uNLENP5Ym7SURNXpZ6zlAb1vLG9v3AKmlUZRqvsFheI1NM7MT86i8m9U0P4QCYabSD09szxzpdt4C0AqbiCSDnM+0qcXryOAdsebSQZBanixAr0vuC7xfquyVSVZTLQe94i/0fzVzlWpPTow76QORckxhdkVrv48rL9p5e0t3uX5hCpCk+M38WpP++Fnop/TBN/I93Vy6cJ75OH/alB0S/IeeeCZ5I9UFQzNuIMDfbzYSaAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjK96TyCYR3bN10vdQR8uMsGHA1ja9peRy+QVWsE4Ek=;
 b=A90sOM4thujw8fDE74WwEAas6Tw6d5k615nePcHbaB4Ewlips8/IM+bC+nV6apgIFcjP5AsJw3knQpxxYg5d2hhuCID3Tfx9EQXUNl0tNeTbec7NS4OLUmsJO1X/5DG7hGLtK3pOVyILnj3hA5B/yMayUOygHuSog7DUwTbNJ58=
Received: from BN0PR10CA0004.namprd10.prod.outlook.com (2603:10b6:408:143::18)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 07:00:07 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::84) by BN0PR10CA0004.outlook.office365.com
 (2603:10b6:408:143::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Tue, 10 Sep 2024 07:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 07:00:06 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 02:00:02 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 06/10] iommu/amd: Reduce domain lock scope in attach device path
Date: Tue, 10 Sep 2024 06:58:08 +0000
Message-ID: <20240910065812.6091-7-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|BY5PR12MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eede7be-8b66-4d5a-9be1-08dcd16633e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LFvrhesHSiZp/SDh0qQ1c/ihtTUAK0M5OsDuyc48Qltmt5Kly7475YauqT5q?=
 =?us-ascii?Q?DY/JOj/qU6QuMu219yfcHSLLB1GGqQ6WpHwZLReKtaj1V3ByrwE6PcIVgMAd?=
 =?us-ascii?Q?m/aVQGFIPr+s2G+prHkyNyfhxtDdmi8NQHjMrxrfiGmnafpXTzN37BIE8ihI?=
 =?us-ascii?Q?732F4CYhUnYQZpsNDLjV6/qdD9xpvbu0Zj6hYsf/xbbl2SQHLNr//Heza1d6?=
 =?us-ascii?Q?Jw9v9I08IbzSNp6zdFX9UrsB1MqN9K/NCQYkbFSlSsqNm6sEJOR0D7PNLzOp?=
 =?us-ascii?Q?V7YQ9cfGGcvyIcYWVS9HK5BZkxtSqkzzdiGaqFYR/UCscYYqgt+f+cmgkXvW?=
 =?us-ascii?Q?2N26vCX3DcPyymSGIp99I+6k/+NQQoODl9PMSqg9vVwP/MmsCfac12xFVk3W?=
 =?us-ascii?Q?zkkcozZMhx2DQ1avRAdVa+LAAprEVQxALiCSqB1r9RpWl6/7eKwmCiaWPoFE?=
 =?us-ascii?Q?JIux3zS+qEwcblNvRQ8K1fEwrI7Zb5m1MmqgxE2az2XWea3apVSmqA/LHlpc?=
 =?us-ascii?Q?uupHwZEZeEjW5au8+anX2YhAgGeq79VIEC3qgzFbMVy9t3RJLkEz4h3TkXUa?=
 =?us-ascii?Q?GRYrZcVw4leJs1G23OV1w5LHyOrk1Nke642AV8B6hA0Q02skZLeg7ahB6Hn+?=
 =?us-ascii?Q?c1H82mFwOuXLQ8UadDwP3ocMao2RIRT3aX0/sZC+N3VkKF/vg+TTadN6XRye?=
 =?us-ascii?Q?YpR1XlcMjVTid9ltYQ+hu+bFDz9UDepgYzfpbgnEVtJtOaXu+Luy2ZVyw5ih?=
 =?us-ascii?Q?iUUcfn9hJHrZsXNRyiduCKbYWoqvvIjBAhzvt+/tzuSjY5fiEZYr4CC3HntN?=
 =?us-ascii?Q?aK8hy8AKsLTShC4kY4nZyrY2xtOE+Sw737xLVzDgKL8AjLbwKiOn2r+5LPus?=
 =?us-ascii?Q?fxHUk/x8fj5nmcIUO95P16xr6nmeQV7N/v4tGJQ7UzsfK4xnJKRTfldSmZrT?=
 =?us-ascii?Q?eqpZhjhr+nOa6i0Grna1dkcsxvVZlUzVVOSkZhT3lnStLffewiWS1QnmKj/U?=
 =?us-ascii?Q?WHb42zLzLV6PfDkvMjEeWIaWZO5Eb8OJsI6Bxwx8Vo00infxDVh/2ioTUMWC?=
 =?us-ascii?Q?y76pFPLh1yO9gKq2ROoj01M/3NRP2lu7Po//uVgghbOL9SLB4YMTddHo8dpf?=
 =?us-ascii?Q?RO7+BB3H6/yGjRyCa3sxEdIZfyCMozz2jr+6g47Lz247wJ0bF8tYwo1JQFgS?=
 =?us-ascii?Q?7wLJQeRXs6okkoPxQiT1YUYGXeaQEjF8SOIQwxLk9yi/mP2Y2OF7ZI5b/MXm?=
 =?us-ascii?Q?hr6arGxI4grntXLz1p0nIUYCvEA1gsZSLGDr6CsH7+NchJClYA1uPbrqPcSn?=
 =?us-ascii?Q?uctSt3oVSuTl/soJ9pc7qghc2zkNk7WvP3Mw8hNMTwqniJUD3u9hyhKtkpxQ?=
 =?us-ascii?Q?dI3nTyBdefFpXiXYpNtVt8fxth4R8CfQ6bCj02+2acxN5ThknRJislpismCB?=
 =?us-ascii?Q?PfXNRFdOvxuQHyK9EBhjeLcA5p+Z2REJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 07:00:06.5357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eede7be-8b66-4d5a-9be1-08dcd16633e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323

Protection domain lock is required only when updating domain details.
Hence reduce the scope of protection domain lock.

Also move numa node assignment to pdom_attach_iommu().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 49 +++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a4a4fc7ba689..713d05a85de9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2016,16 +2016,23 @@ static int pdom_attach_iommu(struct amd_iommu *iommu,
 			     struct protection_domain *pdom)
 {
 	struct pdom_iommu_info *pdom_iommu_info, *curr;
+	struct io_pgtable_cfg *cfg = &pdom->iop.pgtbl.cfg;
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
@@ -2034,43 +2041,52 @@ static int pdom_attach_iommu(struct amd_iommu *iommu,
 			  NULL, pdom_iommu_info, GFP_ATOMIC);
 	if (curr) {
 		kfree(pdom_iommu_info);
-		return -ENOSPC;
+		ret = -ENOSPC;
+		goto out_unlock;
 	}
 
-	return 0;
+	/* Update NUMA Node ID */
+	if (cfg->amd.nid == NUMA_NO_NODE)
+		cfg->amd.nid = dev_to_node(&iommu->dev->dev);
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
 		     struct protection_domain *domain)
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
-	struct io_pgtable_cfg *cfg = &domain->iop.pgtbl.cfg;
 	int ret = 0;
 
 	/* Update data structures */
 	dev_data->domain = domain;
 	list_add(&dev_data->list, &domain->dev_list);
 
-	/* Update NUMA Node ID */
-	if (cfg->amd.nid == NUMA_NO_NODE)
-		cfg->amd.nid = dev_to_node(dev_data->dev);
-
 	/* Do reference counting */
 	ret = pdom_attach_iommu(iommu, domain);
 	if (ret)
@@ -2119,11 +2135,8 @@ static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
 {
 	struct iommu_dev_data *dev_data;
-	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&domain->lock, flags);
-
 	dev_data = dev_iommu_priv_get(dev);
 
 	spin_lock(&dev_data->lock);
@@ -2138,8 +2151,6 @@ static int attach_device(struct device *dev,
 out:
 	spin_unlock(&dev_data->lock);
 
-	spin_unlock_irqrestore(&domain->lock, flags);
-
 	return ret;
 }
 
@@ -2149,13 +2160,9 @@ static int attach_device(struct device *dev,
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
@@ -2179,8 +2186,6 @@ static void detach_device(struct device *dev)
 out:
 	spin_unlock(&dev_data->lock);
 
-	spin_unlock_irqrestore(&domain->lock, flags);
-
 	/* Remove IOPF handler */
 	if (ppr)
 		amd_iommu_iopf_remove_device(iommu, dev_data);
-- 
2.31.1

