Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BF61865E0
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 06:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271084; cv=fail; b=NMmCeSbukJpYTHery3adfEBcs/Byiir/U0eS1qMfZPgZCj2gN5z3nxX3fov7pgMrWqR3p5jHxCbXp546x+21uNurwFc+WtUQbBec7scX8fZwM/dqgeg1PXadJoznLPohJyqAxGZHEAElFmwPUzB/fVqLGmIBlrzxgFlV3Y/Pvrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271084; c=relaxed/simple;
	bh=jt4f/sPK0Gqjt4k5OjPWM/jfAr2q9OTz8BZjhmWr5Gg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIY/4vkLrXcH4N1V28LqA3zbcJFKw421YEsZ2skVMLWG8ZZqtElwKNrU8wZ1ERftVKJbFo+4x7hdD7e8mM8X6U7vKMuEsk2ZWsFZUKIHwqAWEE2y8vSX9Ci5k7q87rHlRsxi6UITscWNDRNYtcUy9lpLcsWQym0OwSOqUT5bEzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nq2nrnDX; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nq2nrnDX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wydnnp5ZbHHQUz0NXEeKf8hKULAbJY237yZEWp5s83VGSJyrqBHkC/93ODD3b3LnV5y6YjrYXJtjpJHlur3Z+7gnBsyxR3NXZ7pQEfrZGQt8VYHKFZnBsyW69iP1Sv9VGq9iY6GK3/ZGlCCX49jcloB2dtsNu7vepkOQPo35IgEhxUPd3+MyXgupd2JutDjBpr/fVEKmAt8lYqUrWQxzBvSJfBgQu1bWzNlXJPNwbO6br9jw1gwleItN3ZFofuwH//OEP1ROw6H2vUBN/q1YS13nvIQr5P3baT2Y4LQBxLaSfks8hkmE+4LKovJObxWgdchQBY4etjn6s0vAqFWVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeL7s51SaltiT4b3mzMFNm1PsZYqygeol3Di/rJlMSE=;
 b=vS5JxQZfX4qPpjCkWHAbM+/0TAhgXGLHNll9ZrprMtBHxJ7Y9MmCGcDbZYeippZEOrxO6qB5dJ0MGtGzPxhhfwv8QBkHD7Au4cLZ4y25j9xWjDGHYO379VA1gCbUb3OR/NkXhkA2J5EapVOqOgoMpEajS7Ny6oNkR6W79koqGeNXmEwwNQ9vTY06BtBJDZsdjQii+YdR71WcptUIaCNuURHqv0D9drbTdlLS+NHOpHzBQ12t9ofRM2I2WoTE6ydH1WWn2i8r3wqd3Y/LCxP4hxS47FSUJd5bMUc5jxyryri0cMr/BDYsdUFouMBhHWijehuF8c04+OtAGHbwgDS55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeL7s51SaltiT4b3mzMFNm1PsZYqygeol3Di/rJlMSE=;
 b=nq2nrnDXDlxB/dPlDgScryUkF2T203PVT1iqxp5sbKowZlaQuKDvgRF9VveQ8sfxMr3i6yadl1p9U7uYfgJYS18SWBV7vGoUZTPNocdOvuKL1gPVdmbhivDb880eo5m+WQd0RF/CidrQP4Ij9rxB9uORd+Mff2AbvOGpLHmXc6o=
Received: from BN1PR14CA0009.namprd14.prod.outlook.com (2603:10b6:408:e3::14)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 06:51:13 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::14) by BN1PR14CA0009.outlook.office365.com
 (2603:10b6:408:e3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Wed, 30 Oct 2024 06:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:51:13 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:49:46 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 10/12] iommu/amd: Reorder attach device code
Date: Wed, 30 Oct 2024 06:35:54 +0000
Message-ID: <20241030063556.6104-11-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: 698ef8d5-4998-4f96-6dee-08dcf8af3ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GwLQ//zSqH9BsibXNkBJQw3cjLYBObm7e1qT6n2Wca8ohQyl0tqPXIwFxnfb?=
 =?us-ascii?Q?DFT3eUKGzrXasxS+wf2EXtTYphQpsKozv+JYlM1gm+ygz79o5QLYk98292BK?=
 =?us-ascii?Q?+CcY2wt101M8634Zv84SKEf4E0jTPuUepKCDaD7GaRhIKu5IdbUUGtPHYKpP?=
 =?us-ascii?Q?tjPko6VPVho93xfZYBW8mXB7BVYAFlJiICz42OrcawLefuDONyUL+NVX+eYZ?=
 =?us-ascii?Q?ITHl1/Ig+fYq0ZuZrszeM3R7kjLTHJqPSNEQ55wmD0kyBIH8RURv0uax5fil?=
 =?us-ascii?Q?UMEfVJUAAEB9xemc628QiXryKZCaxL+0ghbIJyLJWRA6qZ+ESBz/12SpOMBa?=
 =?us-ascii?Q?kq0M4M5Y0yuXCF2QrLKZcj2dT5odw3CQ00j5CMZRywcd5L8GsQvIdrhtT2Ho?=
 =?us-ascii?Q?e+kh3ukijolRpS2mYSlU2PJct/P47lUsbUv/l8ZJ009h7ZsjySSSnVCMudfG?=
 =?us-ascii?Q?14gakbn6S9kepmaomwFmlSQO7UFCeMAwpLgsi8zM2i/3K0a4VZZ6SU7zRR3u?=
 =?us-ascii?Q?AFMFuK2d4BwYZ0JRBoKQVrXzt8wk4q2xZgHVoZwBvJtz7AlAke44CQgGCiRg?=
 =?us-ascii?Q?DXXJQKQO6u80fO1y4zKQq0RyLhEWObzTuP+RbRwpAhnRkYwInAHtmTow93f6?=
 =?us-ascii?Q?wVjVudDFNfmN/Gk8VQ+HnNwFC8EEdvq82f1MQ2a504DFOcwwgDzpjFRHTNwR?=
 =?us-ascii?Q?iCOabgHIco6Pzw6fcRtIoYgqJ41PBSKAODA3jfi8qoWEc4UGVzEiRVetODep?=
 =?us-ascii?Q?z5wYc1F7l78A8a30QCB71Lh7/VAt4nfNBtruEXuRR3vs8VveAor5RMjxjJHZ?=
 =?us-ascii?Q?aG7sbdXFfs20DRR9ntJiuhJ4zJtfnEpU8WKe5ZTP6QkX62mMEmhsqiABn9F8?=
 =?us-ascii?Q?X21M4bNa1d7TNQTO63I9NslrgcvCYq2XpstRgKSQepbYsLoNONfIctdJ2Cn4?=
 =?us-ascii?Q?ghx/CNGt+79QzyhEXgCZh8CXHsbKeaPQgHzlQbYrQa/sPZDz2IB6Z2AfoZg+?=
 =?us-ascii?Q?CO+OrJUs/KdnE4tcsFV4nDWvO+BTjF8gvdpgEyBL6gcV6Fxy0JIQjkZ71s0I?=
 =?us-ascii?Q?CTXxtnArE0cS2DFWS0A44WUSEgqWxGQP7Rvj6DvYKMu2mzujvNFZ6ZEJOJi/?=
 =?us-ascii?Q?xtIfYYuMFUfLdZcn8Y1d052ypTmMbuKR3FL3r4F51nsQVPzZ9gskt7SlGVMF?=
 =?us-ascii?Q?2t5bYVCEfnpa51uAcQa4qrBpQg4SuZKs1cKpCqH5z49St4Z9wZO13c75c7YS?=
 =?us-ascii?Q?TmWTCK6TAxijGEYuqbO49VRXwSdOE3rbIAmbWvsbGI/yeoLbkSZ9K7dTxnsY?=
 =?us-ascii?Q?wHcV0r7gkIF6XPov8keMMDyRMI3AxnmlKw6QJot1QtaLx6bzyy4/Bk2BxE9D?=
 =?us-ascii?Q?Q3h+Wx8Mj+HNsaOVVRONG8ySMHZ2Ih37vxoavSkpNo66/0FTIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:51:13.6978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 698ef8d5-4998-4f96-6dee-08dcf8af3ee2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270

Ideally in attach device path, it should take dev_data lock before
making changes to device data including IOPF enablement. So far dev_data
was using spinlock and it was hitting lock order issue when it tries to
enable IOPF. Hence Commit 526606b0a199 ("iommu/amd: Fix Invalid wait
context issue") moved IOPF enablement outside dev_data->lock.

Previous patch converted dev_data lock to mutex. Now its safe to call
amd_iommu_iopf_add_device() with dev_data->mutex. Hence move back PCI
device capability enablement (ATS, PRI, PASID) and IOPF enablement code
inside the lock. Also in attach_device(), update 'dev_data->domain' at
the end so that error handling becomes simple.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 65 +++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7bb55ffe7a3f..c6f5130088e0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2090,6 +2090,7 @@ static int attach_device(struct device *dev,
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	struct pci_dev *pdev;
 	int ret = 0;
 
 	mutex_lock(&dev_data->mutex);
@@ -2099,10 +2100,6 @@ static int attach_device(struct device *dev,
 		goto out;
 	}
 
-	/* Update data structures */
-	dev_data->domain = domain;
-	list_add(&dev_data->list, &domain->dev_list);
-
 	/* Do reference counting */
 	ret = pdom_attach_iommu(iommu, domain);
 	if (ret)
@@ -2117,6 +2114,28 @@ static int attach_device(struct device *dev,
 		}
 	}
 
+	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
+	if (pdev && pdom_is_sva_capable(domain)) {
+		pdev_enable_caps(pdev);
+
+		/*
+		 * Device can continue to function even if IOPF
+		 * enablement failed. Hence in error path just
+		 * disable device PRI support.
+		 */
+		if (amd_iommu_iopf_add_device(iommu, dev_data))
+			pdev_disable_cap_pri(pdev);
+	} else if (pdev) {
+		pdev_enable_cap_ats(pdev);
+	}
+
+	/* Update data structures */
+	dev_data->domain = domain;
+	list_add(&dev_data->list, &domain->dev_list);
+
+	/* Update device table */
+	dev_update_dte(dev_data, true);
+
 out:
 	mutex_unlock(&dev_data->mutex);
 
@@ -2131,7 +2150,6 @@ static void detach_device(struct device *dev)
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	struct protection_domain *domain = dev_data->domain;
-	bool ppr = dev_data->ppr;
 	unsigned long flags;
 
 	mutex_lock(&dev_data->mutex);
@@ -2145,13 +2163,15 @@ static void detach_device(struct device *dev)
 	if (WARN_ON(!dev_data->domain))
 		goto out;
 
-	if (ppr) {
+	/* Remove IOPF handler */
+	if (dev_data->ppr) {
 		iopf_queue_flush_dev(dev);
-
-		/* Updated here so that it gets reflected in DTE */
-		dev_data->ppr = false;
+		amd_iommu_iopf_remove_device(iommu, dev_data);
 	}
 
+	if (dev_is_pci(dev))
+		pdev_disable_caps(to_pci_dev(dev));
+
 	/* Clear DTE and flush the entry */
 	dev_update_dte(dev_data, false);
 
@@ -2173,14 +2193,6 @@ static void detach_device(struct device *dev)
 
 out:
 	mutex_unlock(&dev_data->mutex);
-
-	/* Remove IOPF handler */
-	if (ppr)
-		amd_iommu_iopf_remove_device(iommu, dev_data);
-
-	if (dev_is_pci(dev))
-		pdev_disable_caps(to_pci_dev(dev));
-
 }
 
 static struct iommu_device *amd_iommu_probe_device(struct device *dev)
@@ -2509,7 +2521,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
-	struct pci_dev *pdev;
 	int ret;
 
 	/*
@@ -2542,24 +2553,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	}
 #endif
 
-	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
-	if (pdev && pdom_is_sva_capable(domain)) {
-		pdev_enable_caps(pdev);
-
-		/*
-		 * Device can continue to function even if IOPF
-		 * enablement failed. Hence in error path just
-		 * disable device PRI support.
-		 */
-		if (amd_iommu_iopf_add_device(iommu, dev_data))
-			pdev_disable_cap_pri(pdev);
-	} else if (pdev) {
-		pdev_enable_cap_ats(pdev);
-	}
-
-	/* Update device table */
-	dev_update_dte(dev_data, true);
-
 	return ret;
 }
 
-- 
2.31.1

