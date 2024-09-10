Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1644D17965E
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951669; cv=fail; b=a21QdTbZx2qx0TbSpwLQSYVJF/IyclknLihwq2xMZkFPbMOVXPfdKDgSBFFKhjKCmHkn4PX41I4xVTwl6jmcXFWgBu+ZBqyWyJDX6D1rQGyFF2ictiN6Gul3W+3EA/sXiBTAbJz4BC7nCkdJwDdu+UVZwTTTK8BQFb8ejQ9lEyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951669; c=relaxed/simple;
	bh=gI0kdk50RLhK8VxH6BhXfFDlcE0eJohIXHCrD4lkL80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlLV3nMwW1AUouT3/RnFV3EIwtOr8qytJ9zNHFM/8kpzPZst8McQD93Wrs/IzY0TdoObGGIzec3QV/tKG5rGUtQvaIhgoFkNlY1m34OPgg3rvj5xZmX0NOTohijMX3uwI6uKB6YUwaK8lUMpnYfbXOJeMTSUcez0nf2lNT/36C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fBkxAFCx; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fBkxAFCx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuD5ZzaXZnt+JJzF3Ibb7CBzV/0Zk4HB1zZQjm8QYVvJu34Hn4oQ5kS6BoTxw3M7RnkfKp1cZKc0QXyDEjcr7wXu61iVreZ6t9+aqkjMUd8Uf06gxaKZrBCUkN8Qptauzzgwrs27bW/Ui848k04xw5Etu3gSezcsHKydZUeHUzbfuPBgwIs27YIJOPsiYqOZnEnSBhGIYnodyjWA0QGYUYOdFvoNp01QvdIUmGkVzZyHbXbkoV/O/65Tpcyhm5E2nSDEifJ4Q8o/i+oQhvvht3T6BXE4hxu9aXOggNu9hR2mLno8kwoeLvBOnzh/XZeOic4HuH4nLC2ZA0kVigregA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBcjwAW8tAByAi0tftKM5UhNvpAFIvUoBBgPoblzk00=;
 b=PiOWwvTNW8g7yB8qG+WfN4OxBD/4RKchOlxrh4hZ6Sj4w2F+Cpu2L3Qew4AYN3aZ/DAaAGsWdQriqGyKX18uH8nLXV+ATSHvM2/61hmBO9WuLw62kosufwCK/kHSfQJbJVBkh403tUveW6OAL9gFe8UvpTp4xvsBm65XuE58HXN1O3IyUOFVVMrNUQHqAsGxuDJepzMYQuYqiOei/HL2iG11Y4tWoyJndz3eVGgAWnUSGAJaCsR0DFnftCF68Qro4tE7mUcR2zo6BX7sLZxolTsi38OColpKF2rM1rRUdYVHobQ06d0iQVAd94POGpyMhuDeNjsmjHjS0tJCsAi7gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBcjwAW8tAByAi0tftKM5UhNvpAFIvUoBBgPoblzk00=;
 b=fBkxAFCx+z9ih/vCCJyDE1EZvO4OW10o0fLSW2pqnNW3HV5T1vy821l7IfJyO34CZrrgG23zkAoSXDm9ARKo1gy1g26BTmuMkP6Va/Mff0L88X/JcGrlWc7tt0DWxn3mh9V5GRxHau5QznBKeG8f+Iwl3xWw/Ea4SxaO3dvvarw=
Received: from BN0PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:143::31)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 07:01:02 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::d0) by BN0PR10CA0001.outlook.office365.com
 (2603:10b6:408:143::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Tue, 10 Sep 2024 07:01:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 07:01:02 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 02:00:58 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 09/10] iommu/amd: Reorder attach device code
Date: Tue, 10 Sep 2024 06:58:11 +0000
Message-ID: <20240910065812.6091-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 55083b4a-b61a-4d46-70df-08dcd1665534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K3MSeZXBgjf3f24VswGttvelFzjqCmiUhkDGsGwHUys62du5tMmglP7qxfX5?=
 =?us-ascii?Q?kQ891XWR56CK8x8eKgWFc6tgRZ08N8756fZHOq0sVYBkUUg/DkMmdn5eb9YC?=
 =?us-ascii?Q?2+ql7rtx2AsLWIDVQZo4KY1K9ipCyCSdLFMd2o9ANxsVJo8DNbsB7o8wIzR0?=
 =?us-ascii?Q?uGvFRa8LHWpWGg62337pBQvlr7rN9w8cnRbWVygvtHKjKVreLxUlcfKGREsr?=
 =?us-ascii?Q?xvIXHfaRUBxmLKAnCYILD/0LJ4Gkz+bVpYiP8Z4KjFmNU3YAQQSUjuuI5mqW?=
 =?us-ascii?Q?i+AB/r/MO1ZtXqp93Q6I8ohwdZcZO92QGVjq2NkyLflqBy4B4Yx7U0pTKzuI?=
 =?us-ascii?Q?toQzilsbAbtJseP6XU0Ph54ZOy8lVgUZPbRSKKdbAWZO/i3xvkJtTszuYhwZ?=
 =?us-ascii?Q?BVdzcQwZfy2TNmKhTHhma0XFNc2aZMRD8zrjUr1tpNTQaGTOqSjlz0LXQqP1?=
 =?us-ascii?Q?yvxh+PKqhlj7VJHsYa0Cwq7xe2uZ3GDixhCM6pP9qHsSQbxrgAJkfWUInFXl?=
 =?us-ascii?Q?A/JzsBmUEPEBTdrq/3Xj+aniTUc8ooGUOQNIbeD71aBXmmZ2SeqguH93xLCJ?=
 =?us-ascii?Q?tQ8nLcQ6LCv0No2Dy7dVu8CdFzaQqCWbAF13FgAmgblk37HEMWPN4NMiNb6k?=
 =?us-ascii?Q?ToY7huK61BDnixdGnJAPwzXxV//L2B81HaEM+zr4/Bu2Ws4v+54y5VZmfvdf?=
 =?us-ascii?Q?Bsmmqq9vyCYIAlQkxC0CK3GasY+PcSGtXgt+RX6uPaKNkzGQeNCz2eu4VNhP?=
 =?us-ascii?Q?gi5Jo2QNsjyRni/MzH0ndAkTaOjmdc+GVKpqItovFt9AOKBxCAqlIRWOd2Yj?=
 =?us-ascii?Q?rfVuu2AouqrzVXpMPA/rrlnqezG1V/29+BA1raqbbbE23btg16pkz8dzt1io?=
 =?us-ascii?Q?VAJWIUuYds/yosoT5WGJXt/5xeLphExMhvRPvjaUzBJHRU0UcLwXHZop/Pg2?=
 =?us-ascii?Q?gb4tJeOHysc8JrHqnT3d6IEabgJJMiarpvqwUTJMWuUF7LeH/7Sl5tNpIHMe?=
 =?us-ascii?Q?h3RkBKscSZ5P3Goj7otUEwBGpRJ2npWfm0askZrc710VDxgV7uPgqNXeGKjx?=
 =?us-ascii?Q?G7HV0tRR/07N/fzuHWA3DrEjTHmUThdYfXu9R1Afzl+PndzK09X7Vg7mg3x5?=
 =?us-ascii?Q?nmjIY5e+dHvsOvnPHSyl0lB0vQQoVBfZXKqZZSLxIdcmHw5kNYEtOfRL6moF?=
 =?us-ascii?Q?bLhyQtOlQNbpqe49eciB1VpbfccUJcCo4GTzDFyFJ8hlqQUP8iQes+nVbJ8+?=
 =?us-ascii?Q?Xo40aWqwoaeQG1pOTnRB5fkHqk1Nk7h3SWeD/lLNHHSqIm4GyRLzI1g3+GBi?=
 =?us-ascii?Q?loYmRigxMsSpupUGGjigQwH7vHXITElcTBLymZSpEUXQ3atwGtveEF7PrajM?=
 =?us-ascii?Q?86DccwAxqIQAgFYyy/u/STOZelYoVyd+EkvjZSRnI7Q1dP88NCtJxMFCicxS?=
 =?us-ascii?Q?aF+YAzsMMPSphFWTmoMhO/wDKHx1ayfP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 07:01:02.4731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55083b4a-b61a-4d46-70df-08dcd1665534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819

Previous patch converted dev_data lock to mutex. Move PCI device capability
enablement (ATS, PRI, PASID) and IOPF enablement code inside the lock. Also
in attach_device(), update 'dev_data->domain' at the end so that error
handling becomes simple.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 65 +++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0f83e1b3fb0c..e7fc59e30387 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2086,6 +2086,7 @@ static int attach_device(struct device *dev,
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	struct pci_dev *pdev;
 	int ret = 0;
 
 	mutex_lock(&dev_data->mutex);
@@ -2095,10 +2096,6 @@ static int attach_device(struct device *dev,
 		goto out;
 	}
 
-	/* Update data structures */
-	dev_data->domain = domain;
-	list_add(&dev_data->list, &domain->dev_list);
-
 	/* Do reference counting */
 	ret = pdom_attach_iommu(iommu, domain);
 	if (ret)
@@ -2113,6 +2110,28 @@ static int attach_device(struct device *dev,
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
 
@@ -2127,7 +2146,6 @@ static void detach_device(struct device *dev)
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	struct protection_domain *domain = dev_data->domain;
-	bool ppr = dev_data->ppr;
 
 	mutex_lock(&dev_data->mutex);
 
@@ -2140,13 +2158,15 @@ static void detach_device(struct device *dev)
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
 
@@ -2166,14 +2186,6 @@ static void detach_device(struct device *dev)
 
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
@@ -2450,7 +2462,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
-	struct pci_dev *pdev;
 	int ret;
 
 	/*
@@ -2483,24 +2494,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
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

