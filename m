Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFC816C687
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729057128; cv=fail; b=aDQBy3Xd9tRD8ONmiufEGV4pGphEHtm2diKMUdxF55aP8q7V9lFjOjDlUzIPK0yeq3retPKRUxLIGRXbeUT/9Gc0CnukYeZdZg016v+Ml5AK5z1lzBiBAnTRAVedxOkwcACNP6sjAgbwwbuL1pydPFh1EA5LACXWsjlxDAb9aQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729057128; c=relaxed/simple;
	bh=1bimlniVrdeagtRuJtRGqtEqr6tbtK/Ku4YlpM8dbwk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAIf5YXMSfxxJ09/YK9Kkjo231cem5KVxtb98BpBRPkUz2wDbXfI+pNrF4jkhYMHNtFNqAF9vtjltVr8NBRmgpcIVGuarYe4g3vVAum1ob1TFGOyghliL3mkCa+RHczX8vAjOK36b+5kK99OS7AEQ4mt+gC2jpML1MtzhbCwOtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MKB3B7GL; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MKB3B7GL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnsZTIJaEMWgZd0WJGaz4pEQaXVtTiLUW6sFL1J4+sINu6ymQ8w+zCTainq7lDzfOA3tSuG/AbGZWB6POscAchjApz2YPHdy+iiD+xjFurt/00XJFIegX0VnNWWi1GLrMNUtkO4slKW6juLtCfiGKtsE9AqhyA1OrAec62vuESjsrv40/aLeerV/p5MkFQ/eP9KLvq9efQ2HD5FPLzfbC0hLorF/KZBqN2WXMTjnTw/AG4hRK5NGz17J4woYxgz3YfeKJXI/StjbOKIwoq99ulmOFpwGgOKe9s/Q4wclcbMQb1cB/EnzS/cmg+pbX19JwErKUFc25IsWoo+f5b6TYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfqZe10MKQrenImMrmZFINPrqWBTCEFwGsctQnoH6Fc=;
 b=DkR0JuCTnppTZjSlvZq8TK1rzrHQtgC+2lPRFNBeTGsnWm5j6LLQkKSWl8YQXf40ETaJdQprQCuP4xA1mvql6SeKAtn5QpFvbyOQan0KKQfJ8W722XiksOkUxHYBuS/q7IYT1m0yPQC8RBioOuAheHInEZfwwo6ehY9Tvurme2WmfGmPvLef1C9PdsZCuTuU2ca91WwLu5SVOhGkrc0WqBEUIoWecCMm1rRNNOhe3VvbcAygNE6QI1CGpEAXWRIfU/CrG9D1yWwU41r9VhBgsoCpTCcdaNRzs+KtlpuvLF+eF31QMgJR71JVKIKe0pPmPEYCu0n2eNLOW0lxfDl0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfqZe10MKQrenImMrmZFINPrqWBTCEFwGsctQnoH6Fc=;
 b=MKB3B7GLnrBlR2eZALKC5O+jvpTuktznazoEXqHh0+8tGFCpcB55EMqO8eYWqUo10S241kPAgG8I6khgTBdC7NmHobZgxxqeLFdjXMlc4vuuizK9GAngUOFaej20bJ64MnloIEoiEsDrS+iwlgpq42UQjopPjh2h0WdoxufrZ2Q=
Received: from LV3P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::14)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 16 Oct
 2024 05:38:42 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::ca) by LV3P220CA0014.outlook.office365.com
 (2603:10b6:408:234::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 05:38:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:38:42 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:38:39 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 09/10] iommu/amd: Reorder attach device code
Date: Wed, 16 Oct 2024 05:35:00 +0000
Message-ID: <20241016053501.97497-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016053501.97497-1-vasant.hegde@amd.com>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a66b6e5-0f12-453b-d7b9-08dceda4cb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tK7Tq6dS0s6dZURIsotBHNGjaTAkSFOUF+m/zm8LQUJQ1OxWuFdIJdRfm3Wy?=
 =?us-ascii?Q?wbuICW17z4Eum89NdSRtvpZxQoAk07yJkl5ch7KevNoSq3c0r2z/x1X0BhWH?=
 =?us-ascii?Q?yq8/LHpkfCeIzO32fTgps+u5sTO8IPIg1VExlD1NjVHaxQz5yd2C7U0/LhOO?=
 =?us-ascii?Q?P+Hp2382lNzU7b3qlAT4RvXzIQAcWg1Xo3D3StLyZ+Zs7nlRSExDcXxUpqEF?=
 =?us-ascii?Q?G8RlUGxCGT+2OTN6O1WmtBpj9Knk4QAJ+lT0STA3IkGfHNrjXsf+Y2tAxSDX?=
 =?us-ascii?Q?FsQ5cV1eQJesNTTVmmx53a3bFR09Ca4eu3F2Rmpl2L+Lv8U/q62xr1QY3AnQ?=
 =?us-ascii?Q?WIX1HCduiBA3jNAKpZ3zkOibyz4hKWMxZrlap0+htNZb6xeLj/sCr3vzk62N?=
 =?us-ascii?Q?LNP2MNeHQCxSSBel7QNENkdkt0ojKKGTiTxZdv92IqS3gF49Tx+9G3X48uzv?=
 =?us-ascii?Q?di91rVsIqpRcgb9VncUDuNj+mYqOnR7eO1Q+4xQL1X+Rn0EvpROq7550cJsM?=
 =?us-ascii?Q?DTZqT6Fp5rlT17ORDCjrjSEKBPS7W3BDZoHB9SejIDkDjGuC+zIWy91YcY++?=
 =?us-ascii?Q?nJ/62ZXumuqDC/MSuRpwTQnQYxszc909OtJYcvNOnk7CO8wEb3SQgBw467SP?=
 =?us-ascii?Q?5/TnhX2gI4L/TVWm0lQkGHaRSKr5P72rjwFhhcZQ9cfXeFrMx4tURSvkbzYh?=
 =?us-ascii?Q?B2ZxAB3fDWPbIkzFxqyd/mWatpfy4vYWaoucSOa2Ba6HQkInUPh7zsz0KtKS?=
 =?us-ascii?Q?4cbLt7NnG8epOYQ4dKr80vyw3MNXXb8lcoal+bm2RDQxO5bYVk3b91lCBO8+?=
 =?us-ascii?Q?Q5ByK24hddfbgEEhJM44rZaEwX7hk+17xbi4K2I46X60HS8x2pz9I4d9D6U+?=
 =?us-ascii?Q?qu1WTCswUhFTn8CF1ASMcypCd3rmFfka0NyTalSAJairLp8a7wpRMp+NYtDj?=
 =?us-ascii?Q?sUsYlhCNMl5WP6TVpLsenpxKo9mWZakH/atRNCEWSK34phXXFGKG7GVkbDP1?=
 =?us-ascii?Q?Am37gzOVZYnthFMLKspe3TuuLxrAoYDlh0lnEkIYQis/5EbOz+UfRGI3pbON?=
 =?us-ascii?Q?6Y12pTJ3WMk2uV73bEKefwWehgpSjoh2bw/uqrxBcOXouGGi8OKcAISa4y7u?=
 =?us-ascii?Q?iyykVY0/oNV+3yOnTkOaq062A0yPvdJkS0+Dgoy0JKbJXZ8gNCczzoROs6J4?=
 =?us-ascii?Q?DcUrQZ+Jkp+XkqKOtNTnanDNEBwwsQqtfCJKcHXBwc1sScCGxuq0X78cwqR3?=
 =?us-ascii?Q?hfxlW8XdjVMzerb9mVXwwIPaJl/3CGwL1SoqfE/34jX0Hx/BFSTsAtfHa9tE?=
 =?us-ascii?Q?5UAZDHi2QkacvEsDaH0nzXhPwJ8571pn9jX36+3Pfo1/VmquNKfCJrqcTiHj?=
 =?us-ascii?Q?szu88G0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:38:42.4476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a66b6e5-0f12-453b-d7b9-08dceda4cb8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833

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
---
 drivers/iommu/amd/iommu.c | 65 +++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2fefb7abb9ab..cd2371819635 100644
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

