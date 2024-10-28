Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3581D5CC6
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115254; cv=fail; b=ka0kh0QHVA86df0wlb5s0Xv3DcoroFRC99i9vRMT6hpB8pe8aEMlgN6Mj+2HX3/+Izl0NNYCf18gT7BvZAjkkMhjTjFVp1MLxsntX3hnp0zNcM+FPAEkgPhuE6Vr3mWcHx3DAx8QmoIAVcG9izNNMpr+PdRl0oIq/3NfS1RluOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115254; c=relaxed/simple;
	bh=bOdJtVRxYsyCl4O9v+CatXQ5E1NAqHKEr2Gd7t+czo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/Z1xfFqsdPX5hDc4oVNbsveHyQYQ3slA8/Zz7NdEXbE476K9TlzTGNvQpm27HuE2proq7z5F+J4A97p5mljZEMmAvZHIR/wk6mpBn3CHM1EjpS7TYZnay9tc3FO9Ws3OG8Ezu/wCE7ofMaochM/79MtQR5+6ocayFt7KbgqNCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wGYTwC/B; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wGYTwC/B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiRvGN5+LV0NpMDaxOlV2E/dkw2eRrBeMKzzhlnm8VMsxasNvs6sAJtu5tX7eJ3Ghm9Pg7ZZGXQJ33WpAL0pByeqZrKiFLlR6n0tryHqHCR+qPfARm5bvHe6KMS9wWkSzBGqNk3S5gsI016VzHr0zXMzAoY0XTYPF0Y1UBIDC1nebwQqEHX+TfJl/cg+ysSXOLH5lJ6Fnyzf+gdLu1EJp/8aopuQP7jPZpeSx+vtx9Vypo6WUE7vCFcDC8P+8aDnT/OfAC8SEzkvPR8/kwiH5/FPiVIBrSRYC39++2Szzd+9NSKRWfHBSfLhTYIX7FiLE5qCboXMLdC+Cl78ucpDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQrKLuJKIIAhjBWmx9cyl1bNeucIGaOvomNBlnQ8wjM=;
 b=MHVdb4Luopj4H6Jv2yBUJfpfTxRKyrtnln96T0HzgMiWZ1Uqm4rOB2Ya8JteCVV7ty/NVW7sBNxcdmLqwHrU1PqVdR/lZbgObbyiGIFKtz4JLx0pMJ4LzM1quR7dsNgIUp0KEkV6zX+6yFh3sY8DRQyIry8WkdSLd6d+W5LEBNveIkGke1/t6WWnH0zuClTIEr0+vmBdNEgn26lFyE5zgHpa9SHszKkjJeI8hOTDormPPhnZjCeMs1WjBGQLVGn0gYzbpqt4z+vyQdeZ0mQ1eA1vz3TXkhviyp/vGHVUEkbVOgISutWhmtXQLHCkgjfjxZogyXlgdBMBWvl7QSATtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQrKLuJKIIAhjBWmx9cyl1bNeucIGaOvomNBlnQ8wjM=;
 b=wGYTwC/Ba9Cq2pfl3xf9p7pzSGN8PJm7LM31zH5/BFuAwKZmamICud820Az8JuHdRcTTilU7cy457k6jxlGHGKUt8Aczq29hl7Xcu07j5TEue3ouKTGO9J8WJNBC2zN0Rk7P1ioAqbLXdwygaRhZHGspOknAcCtA8M3CK1WYIdw=
Received: from SN7PR04CA0036.namprd04.prod.outlook.com (2603:10b6:806:120::11)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 11:34:07 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::a8) by SN7PR04CA0036.outlook.office365.com
 (2603:10b6:806:120::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 11:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 11:34:07 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 06:34:04 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v4 07/12] iommu/amd: Reduce domain lock scope in attach device path
Date: Mon, 28 Oct 2024 11:31:43 +0000
Message-ID: <20241028113148.5774-8-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2e7ae1-05e9-47b6-36a3-08dcf7446f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sWgZeDMJafzHVEESgJ1SOI4rFBznJFhFICVTtAnNCeQDb/C9t+Bs30w/lsED?=
 =?us-ascii?Q?bADNqks7hhHhKp5Y5XPj6U4FrGa2KoOw/qtUJfKfnhgL9ST9ipsyYqmSnVAS?=
 =?us-ascii?Q?dQx+Elfxr4hdqNqXPVvjz/7/A+cJoETx9aTMeYmncFwSX5DNb9gdfP7JdROB?=
 =?us-ascii?Q?ilaPHiliB/czo1zpIiwAySiMR8yKFof2dO7xlmlYvIbiVUk1ctN0/7/BIV6R?=
 =?us-ascii?Q?aclpifP0IdEi5CMZXd6Sg8366W84SXdu87B2xrCC/eHE7i6LZRFxFgRnbiJE?=
 =?us-ascii?Q?A++/nmYTQF3w4Tel7ixJuztWANpFU4f90OuWnJYImvLEfgP+QxE22+MHmYhk?=
 =?us-ascii?Q?5qxqMqrQaAvk0+0QadcO309jyKBSUdpr8tmvPF7pL8l1uTVaVwLTmXpPCqmZ?=
 =?us-ascii?Q?Vkq3/yt4G2boZvP+XGUmEhM+9xC0DY3agqsjv/d3UyvD3jzuQsbjvH3VqXgb?=
 =?us-ascii?Q?mp0i4yB9euj6rzLgwjjbbqXi91NTliDWG7H1zQAL7yrxCYBCRBnAh9L/kQjO?=
 =?us-ascii?Q?YeNay4I9LzpfMHTNHGKhmm5nEpuzv8B3Ibc81iaXkAFk146vRmTMBFX6Xu5i?=
 =?us-ascii?Q?xHjuPnAP8Y82uvGYr8R2uCCGMQNmsDvPmjaGD4ryk7s38mVJ0DYbYvKlgrE3?=
 =?us-ascii?Q?17mM9tAG2NNjLDn5UV67w8mma8MPIWEtjUjqKGiOxz0E7j5ZD1MTotZRCL3e?=
 =?us-ascii?Q?2bBCDIHcO1rF+j7OV09St9fVvbH3CD+iqkTM6+2dX7rbxH2kf4Y8ROfnfzi7?=
 =?us-ascii?Q?aTmseSHAbSPapLe51BQQtxJybHzHrbrxCmA/QhJmGD7hH+z8b2o2xSHtxOzu?=
 =?us-ascii?Q?8em7i0PKHiYAXkA+Ic5oWrRXC2vEvRiK8Syh8KeN64u0itOhxHeLfz+tcdod?=
 =?us-ascii?Q?YZyK/DT/2h7l8iCzjvgtqaD/TMv0jO0IZzABV6xqGjSuFeS3WvO0klQj/kAD?=
 =?us-ascii?Q?I1g31WfuCNIK1XrEz8YikVBh2lckRZVzcmnsKIt/x5VW+7kV31PdUBPY5emK?=
 =?us-ascii?Q?eWrMc3Ljve2O9zTiMcHn3L5J1J5lzWQ9mZ7Xh7PS5Wf3lcEL8E8pN97v7+VF?=
 =?us-ascii?Q?1OwZl43VIxjuSsxFG9Bku9mi68bmPhXZCTJsAxjiZkOBwS9U//WE/Bd13b4D?=
 =?us-ascii?Q?DyvrFhrQL3Gjm2TRrgxncDbIdtr34Wz/2b4+ikJjq29f4y/47HTWpY1Yxd2Y?=
 =?us-ascii?Q?bfRkxJZHs1HLEg3JtLyZKHiY+URfWhcbfFRjzaS1Y73t/AeqytIiaWOK1km/?=
 =?us-ascii?Q?HfAMzDzrI1wZ+SuFMK2/0e9jOm7TM+euzluHCByM4Y8veUBn8fJO/vpNbXh+?=
 =?us-ascii?Q?LPK0Syv0S70kBfgfg/0kTLyR5EqgyaAiLowm1i7DzQ+XZ8O6qTuAsNnJ4bgg?=
 =?us-ascii?Q?5zs9+6FOsIErxGYaVw3yx1TUyPNjS4H8riB/+aAPAZxj6chMdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:34:07.6416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2e7ae1-05e9-47b6-36a3-08dcf7446f51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718

Currently attach device path takes protection domain lock followed by
dev_data lock. Most of the operations in this function is specific to
device data except pdom_attach_iommu() where it updates protection
domain structure. Hence reduce the scope of protection domain lock.

Note that this changes the locking order. Now it takes device lock
before taking doamin lock (group->mutex -> dev_data->lock ->
pdom->lock). dev_data->lock is used only in device attachment path.
So changing order is fine. It will not create any issue.

Finally move numa node assignment to pdom_attach_iommu().

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 52 ++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8919642a5bd9..cc819d3b1198 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2017,16 +2017,23 @@ static int pdom_attach_iommu(struct amd_iommu *iommu,
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
@@ -2035,43 +2042,52 @@ static int pdom_attach_iommu(struct amd_iommu *iommu,
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
@@ -2093,12 +2109,15 @@ static void do_detach(struct iommu_dev_data *dev_data)
 {
 	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	unsigned long flags;
 
 	/* Clear DTE and flush the entry */
 	dev_update_dte(dev_data, false);
 
 	/* Flush IOTLB and wait for the flushes to finish */
+	spin_lock_irqsave(&domain->lock, flags);
 	amd_iommu_domain_flush_all(domain);
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 	/* Clear GCR3 table */
 	if (pdom_is_sva_capable(domain))
@@ -2120,11 +2139,8 @@ static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
 {
 	struct iommu_dev_data *dev_data;
-	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&domain->lock, flags);
-
 	dev_data = dev_iommu_priv_get(dev);
 
 	spin_lock(&dev_data->lock);
@@ -2139,8 +2155,6 @@ static int attach_device(struct device *dev,
 out:
 	spin_unlock(&dev_data->lock);
 
-	spin_unlock_irqrestore(&domain->lock, flags);
-
 	return ret;
 }
 
@@ -2150,13 +2164,9 @@ static int attach_device(struct device *dev,
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
@@ -2180,8 +2190,6 @@ static void detach_device(struct device *dev)
 out:
 	spin_unlock(&dev_data->lock);
 
-	spin_unlock_irqrestore(&domain->lock, flags);
-
 	/* Remove IOPF handler */
 	if (ppr)
 		amd_iommu_iopf_remove_device(iommu, dev_data);
-- 
2.31.1

