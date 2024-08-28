Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71463188CAF
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852767; cv=fail; b=RtExukhwyHkgWdtvqzJD1qcSJIQidWkzxz+h2NxfoH0fUyf0KXu0pE7ATE2Srv9P91g9eWFmicHBVJKxfLITI4AZIgkmV6N2FoEbs5rGpeCnLHFGVkqDNoLguQIdmh209IsEAk2HWbtB6XzIE+IWtoYZ+xWxhCG3SWHxNOQHlBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852767; c=relaxed/simple;
	bh=dcj1I4Jhb59OCHL8dMfT6O7HCYkThOChlOxL+Xo2ogs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOIBnJAZtlirSFtImCzI5XkUeYa5Opbp3WVHz8E84auYSGgUABmt7xZJyk16uKXFO6fJYxnIKHNXmzrhxD9ZffUvQclalozXOCBGCxetkexR0RbFV8LVtxpedXpDToBv0uQuhlqIeRNGBcGYVeVdn2pQ5Ya9n5FiCkKiHmMwTAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EGpCnc7M; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EGpCnc7M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pB+pJJPuwqQ2TC+TQfZIzWti7gYiwXhlF0NPlXm1Oa0dkeNa04lUnBFX6E6SBFJHsb8b8slAsLFtnD+e7t6OD0nP4mVmv3MjfqbjECwVsyyE6UsrxSbBDNplmrDBURLpv7oTLdJJZxbP/ailgON3FznMtkgLwOd9QGW1RTWTb0wlVMqMG8JIN6k50YG9JQTyeQIx+2OUFPzdTZJgdZAElOxu5tR6lgWRxpI2RqIO1VaYSKqf78Sv8whe5QWfowwkd1hltpqUncUU/eJVy71TkJ4vqC7WRfeqnxGWdpYtDUSraOncmmeHYmxaBFwApIlk1bLcUtxgMt/ENiA197iiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wiVFsPSoi7pn5lAxpEPPElTTZQeDkLfQhoHz1P+nN4=;
 b=cL/Nk7AcRfI/q0y85nFQPSt1E3IbwFb8+B2w3sRyxd94hPgTuNEaq+6vJYBabMu2URLqiSG1TKfa6oQ/cqrfhhgqEXNUaWf5V4bWHTj5mCJ404P4YwX8OzlARb/PZwZ5WgSTAe8jajy/fwQ/7XTAhGlnol/rzyM9q3MJEQH4/D9rzjVw35IMSXNdDbbUqlt60iszAwyYOqXJh8EjYVHlJzaIyxq+bhkqhdUe8zjs21BM0e4m/EB5j5KTf21Z9Ofl5jy1+0sDcjFwbJO+HeouTSy0PQNSKecr7pPIiRbVPmG2WoKS9XqepB5d1Y5AwUlbPa0wg6afhkZ0bdfmiJZPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wiVFsPSoi7pn5lAxpEPPElTTZQeDkLfQhoHz1P+nN4=;
 b=EGpCnc7M9eltbuh1UUqF6oif3qWb6iavn6UwBu3GLb30RZPnZ/k+9Oi4F679Uii5yIXGRQ7C/2Tp7b+yu6sbQ0FuRxoEFbE+OztnaztT50Jo//1wJwPs4EiMaYkRNbERWGeFdyuhZxcg7hc2ueCqPbT8QSv4KLv2VuiJC4jQZBI=
Received: from BN1PR14CA0023.namprd14.prod.outlook.com (2603:10b6:408:e3::28)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 13:46:00 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::ec) by BN1PR14CA0023.outlook.office365.com
 (2603:10b6:408:e3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Wed, 28 Aug 2024 13:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:46:00 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:45:57 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 09/10] iommu/amd: Reorder attach device code
Date: Wed, 28 Aug 2024 13:43:16 +0000
Message-ID: <20240828134317.6239-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: 3657521b-3e21-45b4-ab95-08dcc767c07c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jh9AWwjOjlGyvrZXD8gCFkdCVfsnWc/yyNu9hGmPXiDv7BnVSrM8XL4RzOYv?=
 =?us-ascii?Q?5gzJXhMJtxXkOs8X9/eJvPUz3ZpNYBJ+/1CvAAcbgPBar55hSeFnRd6OLTp3?=
 =?us-ascii?Q?C/2iIMHpKB/+fG1Pv86N0qbquUSsUR1GSbvtfSse+pNC8i1q3WhaR7M1UOtT?=
 =?us-ascii?Q?Intg7fqEz4tCn2IgGtjaIny8+Lw9YkGzMqFJUlRC0B+ggZEBLzhLTgTfmjgB?=
 =?us-ascii?Q?g/hNjkwXZk2Ux4IT30vKi6k5P1csrbtM4twh0pbQyhE2TQid096hmY8n8FsB?=
 =?us-ascii?Q?vh9W3L9P6F1N6iwugK9wCB2QX3PvLN0DH7XWR0mbyJ1/Y/58EH4F0sQKaTkY?=
 =?us-ascii?Q?DJ++Ki1VYpZY/E+xMhczgK2cttUTaK7IAh0eZL3MVi+mJxzvyeDje36GOcuz?=
 =?us-ascii?Q?Ww5WtuQg5qgN6LOERL+JaZKbIZWniNbC7NfxxiPzfThpsR7frMdtGWYUcPsy?=
 =?us-ascii?Q?S9ducCy9KcEvb+0KemfWc2mI8yK9GNnozhwGt2M2yvXGzb0BC5LpowSGzDBR?=
 =?us-ascii?Q?AwouZM4m5GSqvqc/e1Xa8He4VMNmSK0EepluGXrIfm4mE4a9Jczx6zqnLubt?=
 =?us-ascii?Q?am6QtXL1lMOAMEnolv6B+jARxuNPrlDfV3/Co0oXSGJS92TGT7+cVe5WVDLV?=
 =?us-ascii?Q?62wTCDy7Vr2fRd6cPcOCetHrAWrjF+omvg/8r4Zjl5WgwUPCZZfmzHNokfOM?=
 =?us-ascii?Q?FpmotbckPVnlg0dcCRkgP2YC74PdrP0H/eU6JpfOEyFxyrdRgUBGPbfyA9uB?=
 =?us-ascii?Q?V/aNgtUK6ZGX/9OD8Caqx95MnKyOVwUKZPdn14IH6hZFaNqyudHjDlFwQ105?=
 =?us-ascii?Q?5mtfZIfTFHPV4tSV8OKY4kgVzdS+T79CPCokylOLIOlTJnwkP+S16cN3u2b7?=
 =?us-ascii?Q?wVGBVjMogWZ1TnV85aCPkjdu+8yL4oSqtQqU/uvfS5tNe2C2vzVXGNd6E/sr?=
 =?us-ascii?Q?8p5pPXRgB3bKd8XEyT803Ncvs8mGrlu+tQvS44KOr3ykWHH5QZQ0aNUh5ZRt?=
 =?us-ascii?Q?t0i5LFSNb3dwFmtbciA2k4XCJMOIdKgmPLLFTMt9Tx4LS1JQJU9NWqJER9ur?=
 =?us-ascii?Q?gFB/ITqVlQArap3Y7A+HeVea8+LTJf2mXl3lxtCY0A0vVPFx3/repFCw2oia?=
 =?us-ascii?Q?DNcKfsivvOGLM4UenW54dl6aY3+SsMuOWRCb2xZkBI8qUCMNiMT2WBnaylHe?=
 =?us-ascii?Q?OTMBmW6xhgspioAAN9PZGP3Zz7ITPkhWCHTB8d9n/KzM6zxVS+dk1Z95bOk2?=
 =?us-ascii?Q?rRWACeE6Xvmzx7pM7fV0AY+bDiqSpbklLxOERlP/uORVs865m90sWreTHGp3?=
 =?us-ascii?Q?CXiPpGgEVxDv88wDsMVV3ujuxRCx+iKDrLDDTszdrPu4KadE+HIZTw5hzc6g?=
 =?us-ascii?Q?8TsTq+OF0f3pPCiZBF3oyVoXfzZNvKjAl8WhoS4AgwFXfHw0eBZTRtNzag7w?=
 =?us-ascii?Q?NDGb9Wik9fCaxpc1cPqYGHCJwPwqpvq/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:46:00.4097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3657521b-3e21-45b4-ab95-08dcc767c07c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112

Previous patch converted dev_data lock to mutex. Move PCI device capability
enablement (ATS, PRI, PASID) and IOPF enablement code inside the lock. Also
update 'dev_data->domain' at the end so that error handling becomes simple.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 65 +++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7da1b7b22b2d..21e5a894e0f6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2087,6 +2087,7 @@ static int attach_device(struct device *dev,
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	struct pci_dev *pdev;
 	int ret = 0;
 
 	mutex_lock(&dev_data->mutex);
@@ -2096,10 +2097,6 @@ static int attach_device(struct device *dev,
 		goto out;
 	}
 
-	/* Update data structures */
-	dev_data->domain = domain;
-	list_add(&dev_data->list, &domain->dev_list);
-
 	/* Do reference counting */
 	ret = pdom_attach_iommu(iommu, domain);
 	if (ret)
@@ -2114,6 +2111,28 @@ static int attach_device(struct device *dev,
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
 
@@ -2128,7 +2147,6 @@ static void detach_device(struct device *dev)
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	struct protection_domain *domain = dev_data->domain;
-	bool ppr = dev_data->ppr;
 
 	mutex_lock(&dev_data->mutex);
 
@@ -2141,13 +2159,15 @@ static void detach_device(struct device *dev)
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
 
@@ -2167,14 +2187,6 @@ static void detach_device(struct device *dev)
 
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
@@ -2493,7 +2505,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
-	struct pci_dev *pdev;
 	int ret;
 
 	/*
@@ -2526,24 +2537,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
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

