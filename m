Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55101D31B2
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115300; cv=fail; b=N+XM8v40CVcgo65ccVS+FRJD3CbeY2kRWCWskCf+iiMGHEzOQr9ynoYZ8YaxLZHGYiMdj3m1qKUbE4m+RgTIMtnUHuiElikhaZ3xKmnkqWJflhaHwyixFCfO0JG9aMSi63Z8dBCJBLGlivYKqZsQPatRN9TP+FarTgLn1kE24Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115300; c=relaxed/simple;
	bh=DZcSIri8wadmwpZ7cea03AaKn1g1U9U07TwA53r0I24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHf4RBJM5i5urijR1VOigPhR8gh5/RBJiH1fhhEClcpTxgoaOe+d8nvyWbU1iCw8bBO8g4U1CI8vZe0vmZJMFKgla7rTmj7OiiQga+uGA3WYL7Vpdq+3vggfGnzUm7b1vi6pCo7Lr7clK/Q3DTO63ukCdw7/4UOcNqihebSLwCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BR01QywN; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BR01QywN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMeoSZ3nGJIzvAldKjUd+4Cip3YSG70vLwSTI4269fRi8gK/xjt1w2+D23ZmmK7nSG8gBbt7puHuVOBI7BuN1jnyXXzKXaw2wtCRcYL9Jb88OGUqXXRlS71Jp1JULL5zz6OYtKde7NcMqQe4SUy5KIJ5BtTHyTQRljrs8ypk7Rzm9HNNsWSrN8dCXuHq9xWciASr0mD+XiTlL2GSiuH0RPuRDbkN7kc9r8Y8iQ3KH9iogtcKjyQ3ViDJ69ITny3cXujNhIJcOSrkFNrgFxGWOq9y/SpfjgMcUaLHHLl9QwsxWp+XCiCfJ/rtIDSzD7MbkX9E50cnkes0/tuaFRtmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ7TM2KDvIm1BMONCwQLhijOG5XpiN8odS773Ofpa6U=;
 b=ecQLB+umSe2R47xCGnGunTA1wOOx/TuHXk8OcDGDEbCsYd3t3HK/wfYWDmbPuQYf0p/J6A1OOjNqHBCwb5E1lpv/OatQ31CY2kpuJ6E25fAJpJfpfLcKiybRlIZIiH4TZK02Qg9X2AdRbix/ybhKq5ql1NpAG8+QpRSaMf2anfdktNvvF2f+wYR9IKEWRPLbMXVzBel159rGZlHzYlefE3Y3C1xaiuboZbWMw/wMmqNTG4VSOIJNzKlEsHsPX73H8hkLi6KJTVG35o+b7boJpGhOjrIFL4URUfAwk+Hl0pD7MjO8SxfZT5aVp8fjSUFNozY/Akyl4oWdT8ae6ETO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ7TM2KDvIm1BMONCwQLhijOG5XpiN8odS773Ofpa6U=;
 b=BR01QywNGWYXQvsRyELb2G1EggkKVTCjeWSy+WvbYRz+JnBOgWG6rq28DhgZjWMIkj55D83qATdVHiceN1z0cxu8dZg16sf/7MjcngKZTkvj3iNTNJ39U95FXnIFGVMdzLyrTXx2eQDw3p+THS6UqhXIrMBduZl6QR1g3IjDfr8=
Received: from PH1PEPF000132F2.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::35)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 11:34:54 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::3) by PH1PEPF000132F2.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 11:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 11:34:54 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 06:34:51 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 10/12] iommu/amd: Reorder attach device code
Date: Mon, 28 Oct 2024 11:31:46 +0000
Message-ID: <20241028113148.5774-11-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f4551a-7395-4397-955e-08dcf7448b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ed7tZ2R0v1BXl1DVUjRoFEWW+XaNaMJVKtRaGmQAdvYnLTIIwWuW8j+2otG9?=
 =?us-ascii?Q?C53wztHIE1dQAqnlqSepgTE3fHY84HEsIciuODLNh/5iiYMOl57voqqOn6st?=
 =?us-ascii?Q?x7HrzSDI1L4OvhajrYYJLGnsEraDaaqwFbarADsFjhzEMiDKMvlxSshYmgkg?=
 =?us-ascii?Q?BZkOAAnfDtk0XX59sjLeoj5YktAqjw7aLyOtH4l5vr/GVCc71z8dygxDvllD?=
 =?us-ascii?Q?MtvRk8ZQDKnWUYfD4d1uFfRm9AXJdjO7ZWta9mGoImaUs5q0NJCYtCxvuOqO?=
 =?us-ascii?Q?jhJez7RpfuPIOzbeiHSzkwfwVez30VwGTj3uz9zhzZ7fBvmZelPxhD7krHDu?=
 =?us-ascii?Q?i7cgqKnEQSTJ07AorI/dHHP3Nri6vkTv9BySDPPjwqf7JzyD73Lvf3CAHcBL?=
 =?us-ascii?Q?U7QRyxT5u52jxR3IGPjZ1aSrfgrIfuWHxX8TLJY1InMZYBr9wFwDk4hrT5TO?=
 =?us-ascii?Q?NUXfzHaEELbg5O3e3Ye/ycQQ0lSElV4Tfrssc4crzyftY5D7H96ceJUf2vVa?=
 =?us-ascii?Q?vg+5JClytytaIlo73+iR87C5TzK+YO3Y0DQgDW749388qNRcbluiZMyJOIR4?=
 =?us-ascii?Q?qt2AMAtWra9P/l5evDZjxM4bMdGHJes/04cK28Jy1BaYqUFopJA2b57IhWSW?=
 =?us-ascii?Q?VFHBfFbZecMX/vnqoF2NDoUv/ipVOoUViw3rizyNVfFhF8D9e6Dw0znq7HC1?=
 =?us-ascii?Q?db1x/xP+uhCGEKAfnhhck1aYslZDw03QEYrXKzbmmodIUsADbHkMa6WcHQnF?=
 =?us-ascii?Q?3ESCrElfWL5plsxb06VJ3C5iRl5JMPYstpeBfeqts11AZ4xGKIM2UAMq8MEC?=
 =?us-ascii?Q?ssBAM1a877aYRCdFI/vo5DrbicpMLCe/SVK387t5e/wfVIrTcV2wG6S5Ejkx?=
 =?us-ascii?Q?N6WoDtlI0RLyLuFKzgiswrFPFtk+M/JgPFcRSHdRsRObBxjhdV95uMGAWJik?=
 =?us-ascii?Q?8Rhx4qIR7pIGe2n2a/rByS0wMobj69WILd8qAFDnUduczh54cjLL9ULiNclb?=
 =?us-ascii?Q?wachhecp/BUm2kheizL/YIh5HJF1pL5WDuAllnQiHNRsNM8iwxtaOphZbYT6?=
 =?us-ascii?Q?WEKrq9c0bV/Nohw1AQd/u/P7Amgdwc8jJ5MQQUMxjf0WQaFA1Ri3a1qWT3Wp?=
 =?us-ascii?Q?VoUaOUyu5TV0jviu64+QQyd4QcFqbuT0Ab5vLJP0UikrBAJbONvM4aHnqCmT?=
 =?us-ascii?Q?aL68IXq3E9Bc33DRcSPUoK7EK2vAgGsySo/kcVRiecZv+gSq3HGdkKK10Kxz?=
 =?us-ascii?Q?nYDaEKQoH9DFVWrz/I1HlNTzUbcRyn+l8m0MfrG/XsBacS9dUZ03UJgTk3/J?=
 =?us-ascii?Q?U9GW1o7d01LSmYd2byks7vXYSB5BTo883sn3WND1mk5RjG24QPzDA9GaiuV7?=
 =?us-ascii?Q?C40FRgbS+qM4VQ1EFEWtmcYO2aUqyNPlmLu1b5RDs0fPuYIJ6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:34:54.5416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f4551a-7395-4397-955e-08dcf7448b45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041

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
index fac634b24c72..c2e1d87891e5 100644
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
 	unsigned long flags;
 
 	mutex_lock(&dev_data->mutex);
@@ -2142,13 +2160,15 @@ static void detach_device(struct device *dev)
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
 
@@ -2170,14 +2190,6 @@ static void detach_device(struct device *dev)
 
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
@@ -2454,7 +2466,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
-	struct pci_dev *pdev;
 	int ret;
 
 	/*
@@ -2487,24 +2498,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
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

