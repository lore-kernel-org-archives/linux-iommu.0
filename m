Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0816C13D53D
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843523; cv=fail; b=fTeEottEsVBqQYZftzgAJ58KwWv5SKBnIdGrsdyP9DahlBYgsdjFfUHe4zVyrMIWe+5Tamipqxe54TUY8bDsrfN65B7IXG6jMXTaUyaa/tvkQTaXgTJzbm5+V/lHLwMhg7dpWKOVJI6OBHzs9YvrF8LVEsX3GO3frd4N2ov43PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843523; c=relaxed/simple;
	bh=lgRHmwe+MAz7Gb/82ZkqkUZm/qFKrhdZBH6KCkUdwjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8d6rCOImtbWJZj5W6c/rOvkncdo5UTckRpar+5rh/aDONP2ir0N+rfO3oL9eMhM/J/ztBFl8M5zKA8U/UVEcDWO0Fol06820GMf3WGVJTQGMECMFGnCImZV/n3xylQNawBTFU9BJaBfuW1HulnielVEOktw4bH5QTkhKXFScG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H7sRcde/; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H7sRcde/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aERhbMbyGq8J6UhjaV+jh68JIO5J7C6hrsVaujF1ZYWyquHcggZ4XwG98fa8+E+yl4WfxQcChePF4iBwAR0q0DBtmPcqcWzu+8KkV9s6vDNkzyoLTwoTiRleKvBIbwpZCi17WpeVW1LRiiwaecPPnSt4467okFgHoS90yGzAFXeeDcBzV9wyBzYIOvu2BBInn0RjooLAZILHkjhLSgQORsDM671XDJzY6bzBEFJ8wbnn8dNAw6W2iManvdrp/mqpMosOT2naL9Ghmeez/ZgiSqqatahsL7a6ggo5AocFyviU9WCTJ34dElgPIDcVp7TP6XHrxX/Fe2W96QFhfYQlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faQdZpXTT4SRPndj60alPtKiWCxwQJPaxTHnTyU3nBg=;
 b=yvj+mbP3qANQzMTgDQUeOpOidwc07sCFXAIkYQorXGjqE9RA9rZgmL9v3AoWFE50dA1jjEld3ExsQ+W4nXv8aknnBJWeYry+RiemBblgLlCcmVvSLfFtVqbLjFnjmKh8yd5C9+yrSxngKRiqmGx9xDneYjgnrnAHvJZ92OL6erR9yxPThgB617yrbPPkJcrjIA/XDVWPXjk76RjKHzWvRdfZHrXQZ3LcdAMHZL0BBPDFQRela9S7LpYK798kREbU80xEXTIQdDMYOo+9eRUoL7Ys795bXy6ctyKhIYQ+CVH/ptp2I6LAmH1K9pTjT1lrRJ2R21FLdOdHPCdliQ7Dyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faQdZpXTT4SRPndj60alPtKiWCxwQJPaxTHnTyU3nBg=;
 b=H7sRcde/XLzaz68CIvJdOJvK2FxAdcE1kAKNMR3x+KytbON2wE9+PRUQV634QvHAuUi2uCiRIBNnbVJ52/hoqoMncq2SyesyyYmSBxjEQSafcuBN9ec+tjcPEaUqQ6aiqx4TRKNbwBdsEaytHr9kr8mplOY2wZbC6aHVfpocQHI=
Received: from BYAPR05CA0085.namprd05.prod.outlook.com (2603:10b6:a03:e0::26)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 11:11:59 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::54) by BYAPR05CA0085.outlook.office365.com
 (2603:10b6:a03:e0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19 via Frontend
 Transport; Wed, 28 Aug 2024 11:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 11:11:58 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 06:11:55 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 4/8] iommu/amd: Handle error path in amd_iommu_probe_device()
Date: Wed, 28 Aug 2024 11:10:25 +0000
Message-ID: <20240828111029.5429-5-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 828808bd-d397-4e34-40d1-08dcc7523bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mQw4TaQDiqgcT2JncPHA2bXd1YjIao8gp6lqBYi65KP9qeA1K4r/vH2o1cDZ?=
 =?us-ascii?Q?+0Wyx5MKfWVrsmo5g3pEYCiC2uJri9D9rX9T3V604+zACX1o7X/EmWvIX8se?=
 =?us-ascii?Q?6FeKQGi2CVYeOGO+B3poRGhJhi60cHZUOmNXAN3fX2gscsx3KFp0rMFDM69T?=
 =?us-ascii?Q?osYqO1ffbcc62N65oZQ46VLZpmAcyT6fFFuwQwaVsTnQjhlFLqPij4Yj2Tqg?=
 =?us-ascii?Q?WbpXGOzmDqVSreso52pQWBrVvaa/DEX/1147ja5/4GeJlMRNBUAmJ/EOeokB?=
 =?us-ascii?Q?wjCLmq+Int++qk37uqBH6ZysSTdrxuoElfyl4w1GTN1ZA7y3+fiXXCvuITbg?=
 =?us-ascii?Q?j+wI9RkZWK82Ulw1U0TnYbeDfCaijRc6mXxoMYbZrxVAzk2nFReCKKIEYkZW?=
 =?us-ascii?Q?8yCh8byqN3UHDrjlPnrFDgJVMWTGb8aDBjoEhm8JoebIBeoabzlB3TaRadXH?=
 =?us-ascii?Q?lpdT4eo3Mk0ny9Y6IfU0KMbM7a81+qD/SCf5VsDvmVBUb/1r2jTgDEkJk61j?=
 =?us-ascii?Q?k0LSbLBgeyh1+QFn3vn2hYVVYC1oeOLF5OpHY5oB+Szpvzn7sG28VOlyAV5U?=
 =?us-ascii?Q?C826WO1wVHRruLdLk/Q9XVU5/vOvvWesWe1oFkqWOI9NLm6b1YKE1qvSaLSi?=
 =?us-ascii?Q?OurTQxZss7eQ7e63qPsrPc2vi6SS925vq22a3JUoeVPT5XeJGQklbf88xSsD?=
 =?us-ascii?Q?L7Bc4nWwtWzqbxQWMdzuJ/UN11XL2v1SxVUDTovTLAv/o9x9w8wliEqIMr4X?=
 =?us-ascii?Q?Gw0Nl6RdkG9YoYotD5vpUtSAkZR5HU5xlwGS+RlyY2l/nKb2TQflKu2wB+AZ?=
 =?us-ascii?Q?gVgv/VNiNSn8+qcyIocnGgko5JpuPOVQzvJL7qU819JD8xJR8J/03JmWTVho?=
 =?us-ascii?Q?QnpB79LLup9LFaNs0LCV/cPaF1ZAjwH9fiG+UO0kgf6yvZqfcdcY3kMpfJxU?=
 =?us-ascii?Q?yBz4DHmNbTrZD0OgV/ZX5+EsstrMk4l96jBk9CSBUzNSAr7S8mvHh/AW2hwS?=
 =?us-ascii?Q?vkmGWeBUmUGpgbTC0hSYSJQWQys6Q+lEeCWyVrD7L1JBYxlKHpeJjaRAXfE4?=
 =?us-ascii?Q?acV/ThvnvMB+/9wakpnjYJLhLF/gxNcJPUOdrxLEN7z3M9gmi0HUNZBbmX5/?=
 =?us-ascii?Q?WSEvwqikrOTWk7uD8B+DcRwPFRKsfRYM+pJUQxXkHWZghLaILn7Hcxg9BvEE?=
 =?us-ascii?Q?TcP/vdF0A6q0E9EFOptzm5OqxGtrkofxnI0XNZ7PI4Js59Hk2GE5j8S2iyWC?=
 =?us-ascii?Q?n1sYuWjHrrVwLDgmpxTc6vImC2a+DzcsVhIcR9OXkXh1/K9DKIJ2zLklPJz1?=
 =?us-ascii?Q?sUghFmwwoe4paM5E0i5sgQ0fGXXSH2XVfcwMg73ARjva5w2efk1h1i7SpLtz?=
 =?us-ascii?Q?Wo6GwMwqP6G11EIBAYnLoD/FkWJtXnpLSPMSysSZNMkZ/FmLOo3HYvDbP8tr?=
 =?us-ascii?Q?+JuULavNe40UgbhHs7uDfRsFy057esQ2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 11:11:58.5051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 828808bd-d397-4e34-40d1-08dcc7523bf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239

Do not try to set max_pasids in error path as dev_data is not allocated.

Fixes: a0c47f233e68 ("iommu/amd: Introduce iommu_dev_data.max_pasids")
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c57ea47183c3..be31a263ac6f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2187,11 +2187,12 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
 		iommu_ignore_device(iommu, dev);
-	} else {
-		amd_iommu_set_pci_msi_domain(dev, iommu);
-		iommu_dev = &iommu->iommu;
+		goto out_err;
 	}
 
+	amd_iommu_set_pci_msi_domain(dev, iommu);
+	iommu_dev = &iommu->iommu;
+
 	/*
 	 * If IOMMU and device supports PASID then it will contain max
 	 * supported PASIDs, else it will be zero.
@@ -2203,11 +2204,12 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 					     pci_max_pasids(to_pci_dev(dev)));
 	}
 
-	iommu_completion_wait(iommu);
-
 	if (dev_is_pci(dev))
 		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
 
+out_err:
+	iommu_completion_wait(iommu);
+
 	return iommu_dev;
 }
 
-- 
2.31.1

