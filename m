Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251AE1946BC
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 06:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270828; cv=fail; b=mvOl0oSHMkH2njxr7z4judBFhfNAu8uNObY9IyENUhKll01AK75uBOS5N6aggLzEMqFCvrmM4EI4mhTM0KGvF5QNyLPbQLR+ZEbPgWHvAhR4X3I3hE9SYDsEJQasDzM6ZFIjCHsEjY1SzPjo7o/kCTStowoP0lpdNLy8WUi1V8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270828; c=relaxed/simple;
	bh=XGkwZD2Hb/uqN9REzK34rhWZz7pO5pXQgQF1n5Mmnss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQ57Gb4eVOUNVhszfadF8bTjLjKmoJwwoO8KzE/ReU4nTjSFrSN1u+ezjZ+o3F6pPjPTUOj508osxes97h6LtgJf3YxAzLztHbb1leWVq0uRMSfNXZ/AF98UM/opgqmc6jvnbsy/jGsiJgKOE/u/gXI6WBJUbLjtTYzGiJUjRkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GUFY7P9q; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GUFY7P9q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zm766x+tmuYNGPbDK5cqenTagG7uxJWEk0uHVWMPhz8YSxpkDw4CGExBOpSPnqFUGtlptoYRPnsIJ+uAt6aq6TM1NQECo4u5YOw4PWZxWNqVV5NbKBjPpLvaFZcL0kx/fGdhLsc9e9Co6YGgpNj1fjx7+RV857xTFMBwjr55Y17tb9SPGlQBglPF2gjZ3wvV6CPwB07SAXF07ONBwxmfLCAYfMlrcrcm7xRzLhlkL3fgObV3Kp/9baynnqU0He7AAM3NWmm9P+XRtNs2pUPJarDq1+GSAj0dPG3ywlZNAYlCNAbgpnVAMnVGwJeAxfj9FNTr+WRHNQsdC1/6Ffhd8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2C6MiVgEIPCS0flGKRJnFKK8zJXJII9i6AySD2XW6Dk=;
 b=e7ycrt5aKyqnIdOYByt2iX2Ys3ppAeTPtaLE4ng+TzIt6wq/mo84rJufjxQA/PlJs7ej2XabpY48I9yaNiHy8qUuI8z/KOkFb6Dw9kZT4qG1u5y7JVIJJOvw1hVWc3gku5ADBclqUrRI5fj27/mOne1sDdgWm1rA/m5r9dj0uPy1nVOd/nb+OfBzy4l0PkAgHkZY+D01jTnVbdLyP98c/b7Gjo5OXjQsWRKkTe2tKXHE4a8UB6KVFPOHHAqcrL4bq4HRos1irJAnxUcwJUHWeT+67I9qNkR0uwlEpKW1HPMk4kvDNQ2LWfSvrqGg9lrDu/57hiZnGS8CiVoTS7clCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C6MiVgEIPCS0flGKRJnFKK8zJXJII9i6AySD2XW6Dk=;
 b=GUFY7P9qK54Ke4KlveJxdCwZuJHjob6ygchPOfY1hIHYbtYWWfz+E9LhaRXEXikgqT1fO+7Zl89Tap3ISVFbDZqLaFQuNdX8a4gPE7LWa01oqXj4C44imOuAiYI/YrtYArmFY8OSG7Syhjx47/EIBna6iGuK+MYrxgn2pFl0Bmo=
Received: from MN2PR16CA0049.namprd16.prod.outlook.com (2603:10b6:208:234::18)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 06:46:59 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::41) by MN2PR16CA0049.outlook.office365.com
 (2603:10b6:208:234::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Wed, 30 Oct 2024 06:46:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:46:59 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:45:55 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 07/12] iommu/amd: Reduce domain lock scope in attach device path
Date: Wed, 30 Oct 2024 06:35:51 +0000
Message-ID: <20241030063556.6104-8-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e27a6da-a27b-4057-4579-08dcf8aea73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?59elFuhF8k8XY4z/TSEre0Xjutf03XFZy8hVYJdETDDo7BeM02JG/waW0Nyo?=
 =?us-ascii?Q?ALcw0Xpjt+VlWguJR46H7DCRd+GvrOA29XjZD6f2ou2ntgiGeoxG5ZVHuq+P?=
 =?us-ascii?Q?yvvzezITxxWhAjYBS5JQLAhWt9RWjd/6z3IsS4ovND5IdOCHuXLh7mbYX4NC?=
 =?us-ascii?Q?YijU8+p2F88yQ7bclvOGpESxgHOO/NtqG2CJ7MRSIFPmGtPUEd0WvPgUVe59?=
 =?us-ascii?Q?O7xEFqbdlbTuVvg+804Fbne6v9uEPkrfvCKey+hPGYOLORmXuWuRJQ5iI+hs?=
 =?us-ascii?Q?xVteF5ZT7tyz6EJe95MtSo5Tx857wYOUENZtPb5i+3Cr2pBDlhczlCOTmfNY?=
 =?us-ascii?Q?rp9OQvA09t12vOfFoyfWfSPqZGSrr3H5wklFwYtFWCcsJ7yWi0YQJiqEePET?=
 =?us-ascii?Q?36HC8luHBNQN5//ogIkHspFyZYUtto8QcfjQVImOPPoAtYt5qBVwKmv8lS2L?=
 =?us-ascii?Q?rp0WPGOlnIiRVKcn33Drsy/IEeXbNeVNvkqoGpuVwqLc+h50OXgJcpCsUbZO?=
 =?us-ascii?Q?m8z1JdPt5/iYVdNGazbBKbMfE0mTGureO6JpL/+NumUv9mv+o1BJL6JIt/sS?=
 =?us-ascii?Q?pbzEBfpX0gU48l/aYitMb6qmrI4VfwYTm4APyOFFLC6By6S3obozY1U2dc7G?=
 =?us-ascii?Q?LVV4SfaVD9tjL1NZDlTExvYYr75BSjL68jP11ZLcyu/NCm95HESRki0Iahdp?=
 =?us-ascii?Q?ylyxjK5d2tzM3N6ExAziDDLArR+SH4oYGh+AkOZfYgyqTT6Mqs/bvSZ06JZp?=
 =?us-ascii?Q?gJ9UCIyTotqVjg6bdSM2i5UChSx1eliUgSMpq6ayoXOqesd7HvEE/lZrD8Dv?=
 =?us-ascii?Q?V5t/Juu2YuBR98hUcpYz3xL7l9js6upzY/D1fIpHnuNzAxwlghkCSFrjFGrz?=
 =?us-ascii?Q?ReEXBd7ryPDxRjKPDMshyYiQ9xjAaq0Mphu5Q/+hWKQPo6ErY/THV7PAquC2?=
 =?us-ascii?Q?pjlccrApumgow08GtR4IvZTzp6no/QF5oQ62VTL76eUJ70KRCZrewzHe0sjr?=
 =?us-ascii?Q?Qy6scAoig8AvOt+ayT/3R3WrDz3cYRmbin7pvUygFgeLffE13hNeNIWJVkOT?=
 =?us-ascii?Q?p7VdXYIMDVUVbk38jO+38RNR7I11+9w+vuPcFJndgZ2tDPaJC7l/Ki+rsmIC?=
 =?us-ascii?Q?D0Hz5zA+EZe97xO23pGdGCDjJCqvcc5oOIBJfGxCYaaT2rRoSe7qAyUDxGtR?=
 =?us-ascii?Q?8mMWjHbVUDarpkDYOvJVOWDQGrFF1oKRRbmDNseGvWqsRUSilPNuGG1cmckA?=
 =?us-ascii?Q?6Y7YUCHYVEqYkVzm6qxeU7Wn2gGIcGdMRIJTXs9Ku6IePFd0UDTH2hVbBbCp?=
 =?us-ascii?Q?uyiZ3c2jrZWMYS44E3xa21oQB4mew/aD7JjKuZCdDC1VsCBU/6t/jLaEujLl?=
 =?us-ascii?Q?WgrgAIDqJFP02dP8s1kj2Q0kdcifaJ1H4aWjXrDnarPamuMVQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:46:59.2457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e27a6da-a27b-4057-4579-08dcf8aea73f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 52 ++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8f0fe2c70adf..f5ba715c8efc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2020,16 +2020,23 @@ static int pdom_attach_iommu(struct amd_iommu *iommu,
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
@@ -2038,43 +2045,52 @@ static int pdom_attach_iommu(struct amd_iommu *iommu,
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
@@ -2096,12 +2112,15 @@ static void do_detach(struct iommu_dev_data *dev_data)
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
@@ -2123,11 +2142,8 @@ static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
 {
 	struct iommu_dev_data *dev_data;
-	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&domain->lock, flags);
-
 	dev_data = dev_iommu_priv_get(dev);
 
 	spin_lock(&dev_data->lock);
@@ -2142,8 +2158,6 @@ static int attach_device(struct device *dev,
 out:
 	spin_unlock(&dev_data->lock);
 
-	spin_unlock_irqrestore(&domain->lock, flags);
-
 	return ret;
 }
 
@@ -2153,13 +2167,9 @@ static int attach_device(struct device *dev,
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
@@ -2183,8 +2193,6 @@ static void detach_device(struct device *dev)
 out:
 	spin_unlock(&dev_data->lock);
 
-	spin_unlock_irqrestore(&domain->lock, flags);
-
 	/* Remove IOPF handler */
 	if (ppr)
 		amd_iommu_iopf_remove_device(iommu, dev_data);
-- 
2.31.1

