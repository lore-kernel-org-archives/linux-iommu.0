Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4704516C874
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843587; cv=fail; b=DjM4k/OuuXpNeOO8u7seLKNKpauMIwSO1DD3k2iVUmRO+6oE2f/kj8iigNER55z5hyPu8Bj6ISW0dej0qZss05mdRqI2bHDGo4fcFXPL5uFFGvsviHVqoRMo97h3omz7iZ9vCpNg+6+o08kCBomrcts/iV23KItbigQawZTXH+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843587; c=relaxed/simple;
	bh=WITvZjDQJNdNZOGPM7rzqnviFZEa34ULAOu0ZeZ2uhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZY80dSg4DH5oyANtjkXE2UijsQSoxUp0zzhQS6hv6pEQCjKEObapRNRxlGrKV4+iEqOLwyx0R32wte/54Ob5U13XCCUOZQHTZvDpiYEcBxHCo4e7mBGbd/tDDYB7cE+3kIUyqI2G+pcVLqkw0xj52MMSkmM4py5VKKkyZqGhhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hnae6krr; arc=fail smtp.client-ip=40.107.101.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hnae6krr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDjxf/nRHHpuid3yqnnSBRoJLGm7l+mjBsDOu/flocbGFbXeMx5N1p/FU6D8A9Xivj1hdFzJf/nitVI/m1Tgh0RfHbf7v2bmCtfSjOM/ZFscipDkwxeSfcDmuCnPyjztBsVuKjF1z2mkNDMXIidSnMppRkKse3CiLIBjb2EJlEAhjABCMfWn1zvOlDwGXacmGyeW8+RTAoXKdVLBjVI5NwH94h/u33q7jJkSvo0qeX7MQyKWG0wdk38hb0KCB7sb3dOxgpK39cxfZqpvfzZlc6Cnr7oftx0Cni+fHhw8OjNOV2Du4BggdOYMSLtFUWX1sKp+i1Xmr3a97dqTtYef8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiBHdng5mDnUVdUCDt7paqu7Ho+8i2g2htcugu74N14=;
 b=ZFNJzzHBi4PfYtbhIwn9Dt+tONoOPu66mgIY3sFg1BRJQKdjQQAuFPzYH7LUDeCslrIiUfNV6euz19DvUST7mpDQr9kVHeWtmHCQKb8xVVeZhr2ymHL2WO9TmqH4TGV2Ddlxr038ldPb+JyIjHLE82PecAZASTsIQ+ZsvtTJRwPbiz0JH4k4uz3FCjJiv/AAhCGL5U9mt4t20bxtxc9l2z3YdtZn50Itq+c0pdiGIVw108RWI9vrRywp+d+w2qcd8xYwDRJrDoGawv9S6WL8QwLG8gDQd7bbKJxxXSaJFrW1fCc4AXIRl/JUDLDX/vIVvG+bgofoLpGcQFzq0x8G9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiBHdng5mDnUVdUCDt7paqu7Ho+8i2g2htcugu74N14=;
 b=Hnae6krr3ETGkshZFHnJRHMtIwAYHyz4bbvx+pXVC4vSlajWMjxrjLkt6wgqs0BiXs+vwCC5vh6MwKmNSZc+mYAPdO2QQ54k8EY9fH9Q7DlfQGQ2u2CBBK7GVFIwba7wZ2oOZo1yT5NlfpV5ml91qkUAypTPplsvM6LGk+EGg5I=
Received: from MW4PR04CA0269.namprd04.prod.outlook.com (2603:10b6:303:88::34)
 by CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 28 Aug
 2024 11:13:02 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::6d) by MW4PR04CA0269.outlook.office365.com
 (2603:10b6:303:88::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 11:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 11:13:01 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 06:12:58 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 8/8] iommu/amd: Make amd_iommu_dev_update_dte() static
Date: Wed, 28 Aug 2024 11:10:29 +0000
Message-ID: <20240828111029.5429-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828111029.5429-1-vasant.hegde@amd.com>
References: <20240828111029.5429-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: c4cbdf61-1a43-4eb9-c03f-08dcc75261a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DpqIQ2pMW6U8IhfXBGjV2972LVhxUw8yg6TXDjLvtflDbIXrDukYpP1bl8C1?=
 =?us-ascii?Q?tdtkjKHQbYrYuTfgQDWKEssYBOCuu7bNBJGLUABqqK7G++G2HYoUXGYnM50V?=
 =?us-ascii?Q?+fDg65wCqK5cjzh3aTsCVImWHj4eMOqToN0GwRN6AfvE8aSZn6Gz1DlDST4t?=
 =?us-ascii?Q?fqG5nmzx6B9fUJulBdnB2bHgS/+nLcXq4Rxhe4HgzxMshGmdrWkxvHnVI3DY?=
 =?us-ascii?Q?sF2LmNKexKlg6mn7ot+my8vxTDeEFwWI5jCywBZZjrFf8sUZTkVXPToX8aSa?=
 =?us-ascii?Q?xrbx1oWxdYazyfGVwD0SaayYr0ENwzkS+FCGo1RelWBp4S+h1AgMxNOsd1oe?=
 =?us-ascii?Q?zQmSRJjBSa8Rhv5i69Iac3YJO0UziZQeUjJo4wWUubduEonIQYyro+rMwaLV?=
 =?us-ascii?Q?g39SrIafbvPlVKAPI041SSTrNVr++twFKm9X4lIjQyu9PsFJoz6sgB/q7jSH?=
 =?us-ascii?Q?fBuB0zV4UsjuNe/nsCRsyklfICzdcfkMQj9OHpFn4R6NsdqJt5QHJCBD3u6R?=
 =?us-ascii?Q?sT2SMg5e4odYEk+rjD2optnvUcM5pCoUe6srju1HPT7PBIf8xw0LKDE+wd9s?=
 =?us-ascii?Q?Ktxcfh8f8+LR01T610E/rFDvpWuvF3VBxjCs23IAdXAmJKXIkKk7KRl2zFqu?=
 =?us-ascii?Q?gXNjU+NWpidGNRcnIVbthnssrlY1/0XZaEKgEfT0P5izuZ0mCLsW5t2Sb1pA?=
 =?us-ascii?Q?86sEFI9HFAIxRxFnWjnJP9jw1q28x+4Pt0OjHqNW0gpfZga0i5aFpthIj1MF?=
 =?us-ascii?Q?a25KxMUnSGTy+ILvt6OFjQClxjknriInkkYI+wtlshR+npRQkKsFBZW2ulW7?=
 =?us-ascii?Q?ZdP4IOCiucbprfQIQ2xLKVGHC+q4ba+Kl5lZ/AyGJrtKmYko5QVn05Bu8chH?=
 =?us-ascii?Q?mVc9mS4i8ITNApk6wA0iIRdEY92wL9CG5cxIlAXJGAaRG6MV/Ib1w97n8O8h?=
 =?us-ascii?Q?io07tiNmu6YhzRp9TfEMxIeP6urUxojCF+5FdCMU+G+50hnlsHMyopqb5EYs?=
 =?us-ascii?Q?U0kIkJHHHzPbCnnDlmEwIVnbXM+myfUJ6RKgBbqaA9rrc0vLhdzlKbMMuiKd?=
 =?us-ascii?Q?k4phfPUzM22ZeDA0Q7CRzTuU8DEgEkJAHC/NhUY976rpXAeMKpdyvp+KuD9l?=
 =?us-ascii?Q?iM3KYXuCUgWZazLGhSQU5MSXAVNCJYm80+CJSgrZGclO/PXHdBSjMRlzZRrr?=
 =?us-ascii?Q?lEjVFVc+jnA2PWMWPE7N+i6x0nI6CDOYyiRz7PZrRUkrqtH77e4O28Xey6XS?=
 =?us-ascii?Q?YREf+PYaO3STDD1SlFJMPocrPT+qmH4r2OCHyhUxhD04PruLluRwFmFP8rfp?=
 =?us-ascii?Q?oQ8130hVazKEy56/7rlnHcrZqXLaqclKDPaLE1tyuPBudDYiszAjN40JPQPe?=
 =?us-ascii?Q?izmlE4NI/MBAcQNzEqQ047OeRo+z2BsJgJagNR2Q6WHTxAflagOFvb8bSo+H?=
 =?us-ascii?Q?Fj5tCY+TzV+P/idxLa8gCn64tuG8eIBa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 11:13:01.7375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cbdf61-1a43-4eb9-c03f-08dcc75261a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

As its used inside iommu.c only. Also rename function to dev_update_dte()
as its static function.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 1 -
 drivers/iommu/amd/iommu.c     | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 94402b88789d..705dd364afe3 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -87,7 +87,6 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag);
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
-void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size);
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 808959be0902..82c0ee527732 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1955,7 +1955,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 }
 
 /* Update and flush DTE for the given device */
-void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set)
+static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 
@@ -2055,7 +2055,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
 	/* Clear DTE and flush the entry */
-	amd_iommu_dev_update_dte(dev_data, false);
+	dev_update_dte(dev_data, false);
 
 	/* Flush IOTLB and wait for the flushes to finish */
 	amd_iommu_domain_flush_all(domain);
@@ -2470,7 +2470,7 @@ static int blocked_domain_attach_device(struct iommu_domain *domain,
 
 	/* Clear DTE and flush the entry */
 	spin_lock(&dev_data->lock);
-	amd_iommu_dev_update_dte(dev_data, false);
+	dev_update_dte(dev_data, false);
 	spin_unlock(&dev_data->lock);
 
 	return 0;
@@ -2538,7 +2538,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	}
 
 	/* Update device table */
-	amd_iommu_dev_update_dte(dev_data, true);
+	dev_update_dte(dev_data, true);
 
 	return ret;
 }
-- 
2.31.1

