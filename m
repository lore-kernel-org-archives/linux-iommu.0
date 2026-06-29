Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E903543901F
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747716; cv=fail; b=HODymie9IVjhi5GSr1PI5O0zXtX8Md3hylMSblyGjjsgdzWWxAvfLJv+ysPhuyLBE2Y/Ng0C6hPxekpyN58qwk7rlHKo3RDP52ZBZirDU/ZhNxAHU9n5JGOSehSW5lJUss+v8P/LUQftrWpY1f9O3amRJbV2XUjBHl3CTJ4huLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747716; c=relaxed/simple;
	bh=odHT2BNcAHB4NqygKFcS7aQfHDGVKq4cEY1M4C1kjKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smbhGlpF2M3mvrIHZfi6Lwy0FdKwwVy08MEQlTuIxzjC6gn5QMvOEdsjdSN+Hg2yPlxcDYODBe8LKsx5QKa395xzRplXThwJPpRKB8LcHqbMbvYXHr1aTZR96P8Po1f7ud0fB9AxWUCLcFLwkIftYJYxw4U+23hS/GQ3duHyGxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dDYnPLqW; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dDYnPLqW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ul/tg94ZQlIRQQOSNghc+3EOw5eEWsIPXSHR5nhxyKFPxQzYO5udH4ZQkInm+GIk8cSLLhh2S4jtX37Brrqdk9J6az7XfRhIoLOx+8cv+/3Rg0QgL9NPGHhfrxejqm2VLhcOPcHZeTJGeV+SboToYV3MaiVUV0PQUf6vUVfnbox73cAAzi2bFQxAaCt0s4OkOZWM3pCx3uB+hz2+oQISEHSbJs9iJK+lHMdZEGqCqiCQE16XZYJ8umKLk6bbKZ5cZntlk0X++oKMG7D2JP2RXS3EFi558VhOvfT4de4/ydb0RhhrgYvRSLS51fKK7sB5lDUySbXkhoA5fF0qYCJiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbYyrX5LIC4AUWXl9AJpPbmLpc+Kwym0OIpshrs+P6w=;
 b=Sq2413IOd3GjEtidOL1/Rm0ul8+aRjVDv58iUzPrxgU3zVWwq0PITxYCjQev6tox0e/TnWQq1DrXr8QTUTbkWnpT48UgqXfl57ilZsKHI/Gp4cCLH4jmwUPIfOvsNGTi25OEAYLSBHMC6nPyinlbb1IUAC4G6cO7ru8bJfITuMRmqHStyA1fPe6Te3kxlcP7h/ewvf9Hii2tcxWGNd58GMZDWYghZ9FhhoaLz6NM8NHVc48IfDilQ0ixj9QyA9ymRayCOumfHywOu0spxOVIhhmjOFwh24cLGNgLs9LJae5k1u5qVC4v8DagJbV0Y0jCs0wtETrYiVzPXlUWAUI72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbYyrX5LIC4AUWXl9AJpPbmLpc+Kwym0OIpshrs+P6w=;
 b=dDYnPLqWztBzaZPlfj4xviijdTgPYYD1bF36SkPxd9CJiMWbqxcX3S+LvUnGUrGqY5mDgoE5Jz/SgSY67sY1anzLAlEz6HRcNLUHWC0E1Wk+qc6tN2u239JeGYJ1quro2mwHF90LuoXmBmsT1TFKwCKHXcCjlLKd4sgPwftwhIQ=
Received: from SJ2P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::7)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:41:47 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:5da:cafe::18) by SJ2P220CA0010.outlook.office365.com
 (2603:10b6:a03:5da::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:41:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:32 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:35:57 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 01/22] iommu/amd: Make amd_iommu_completion_wait() non-static
Date: Mon, 29 Jun 2026 15:35:14 +0000
Message-ID: <20260629153535.15775-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a771e49-4458-4381-4418-08ded5f4ede2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|3023799007|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	zgTfN+pVLQTqlNCsYkvOZ6P06pBcgJqu33fBu4iv0Lb8tx01EevWhAr0L2RmhyPgVX/ZhNtBADWj36Ik7TuP1ZQ0eJYv/Oj2VzdwwsmPcrrQW33eqH56O3NOBGbb/clGzAUUTTxhOfuQvar5V3o4HDvivTFm1hzQ/g9s6cJcbbpuiJYyNf370lRGJWgmtvvJAMxRsenhzN0qJudGTTY7BIotIu4pzfZMYcgzxt9DZWpQZFb0btoTSPCyHSFeIpuLEwGpS+Qm/UxAmCCr+bRrDgAgAZtYgGwtrfhm2KVhBpetEEsBxSaBS+wleBzlz2FFiQ4Po+HQHSUB3PvEXT1V+JUBbXaUzPX1cp2520cxkFUDC53p1Z0aJcR0Bowrm/18YG7MfwA161NebGubJKD+A5Of3uwI0klj1OB087fkKU0O2tJ7FWpOK566064CbgAHiwyO0q6hZfW2Erh/E5mKuPurnQcpUrm/bIbT6hGFtjjSgGYh435WBnN9e4KQUNHIGX+AqMa4xW1CYs4KGMgojPu+fo7F853ljjY/aI1sV9dnC6gbpkJvWEpQwiWmFvxR3+c/yOK5uVRiKYkr2RID9XAHbrOH01fbuvcW+UkOYgWZCY7IUIH0ZKISkbX4FJj6jyHg4Jal7Nyu3/CKosc8EF26P1ynS1RPa3FbC5b/+S6BITIFt+pHVcn+7v97aXqZCcAPe69fRBm9khZQmlUAFg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VgAblEWa8qN/EqkaQv+yBjneau3lw7QbpJKO5aLqUHaA4LR7wgEDlYSVT/kmYPtpA625O8FKU9ZWPi8hr8r77tCLPsc5v2hyUMpH+AF/43ZLZkJF8bgGO3MmNtWMpUPi6fF/UcVVenldeUixro7D5LmFvyeS1P0OflHTynCbkv+a+QWgiQitBigbW6G0NFe4EDlnbCZRKBvv8LN2NhlJCL20sx6bFkO8lL5N3EOnI4YZsfdKDBeQPac591RiLf0K1uNt1Okr3Yz1d7+lkXVJxV9938DCWx6yq8ikXutXwFq78Maho7//HK1rwyd4MHDLddwt9vu50vilP3Wepkhk+5Ra+aikVVK6JitwbZUtTxsy9zRaRNtWEt6ivtRv7S9TR8l/FrxYdYwRzyPhTUhsbvY7OgINJYb3+oN4CHPi9DMRX25XUlg4FyfUcv2zmmae
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:41:47.1676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a771e49-4458-4381-4418-08ded5f4ede2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358

This will be reused in a new iommufd.c file for nested translation.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 26 ++++++++++++--------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index af720bf14914..9f961ccbe3b4 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -199,6 +199,7 @@ void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
 void amd_iommu_update_dte(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data,
 			  struct dev_table_entry *new);
+int amd_iommu_completion_wait(struct amd_iommu *iommu);
 
 static inline void
 amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 84cad43dc188..4b4dd20ebec6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -90,8 +90,6 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 
 static void clone_aliases(struct amd_iommu *iommu, struct device *dev);
 
-static int iommu_completion_wait(struct amd_iommu *iommu);
-
 /****************************************************************************
  *
  * Helper functions
@@ -216,7 +214,7 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 	update_dte256(iommu, dev_data, new);
 	clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(dev_data);
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
@@ -1449,7 +1447,7 @@ static u64 get_cmdsem_val(struct amd_iommu *iommu)
  * This function queues a completion wait command into the command
  * buffer of an IOMMU
  */
-static int iommu_completion_wait(struct amd_iommu *iommu)
+int amd_iommu_completion_wait(struct amd_iommu *iommu)
 {
 	struct iommu_cmd cmd;
 	unsigned long flags;
@@ -1487,7 +1485,7 @@ static void domain_flush_complete(struct protection_domain *domain)
 	 * We need to wait for completion of all commands.
 	 */
 	 xa_for_each(&domain->iommu_array, i, pdom_iommu_info)
-		iommu_completion_wait(pdom_iommu_info->iommu);
+		amd_iommu_completion_wait(pdom_iommu_info->iommu);
 }
 
 static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
@@ -1505,7 +1503,7 @@ static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid)
 
 	ret = iommu_flush_dte(iommu, devid);
 	if (!ret)
-		iommu_completion_wait(iommu);
+		amd_iommu_completion_wait(iommu);
 }
 
 static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
@@ -1516,7 +1514,7 @@ static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 	for (devid = 0; devid <= last_bdf; ++devid)
 		iommu_flush_dte(iommu, devid);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 /*
@@ -1535,7 +1533,7 @@ static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 		iommu_queue_command(iommu, &cmd);
 	}
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
@@ -1546,7 +1544,7 @@ static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
 			      dom_id, IOMMU_NO_PASID, false);
 	iommu_queue_command(iommu, &cmd);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static int iommu_flush_pages_v1_hdom_ids(struct protection_domain *pdom, u64 address, size_t size)
@@ -1582,7 +1580,7 @@ static void amd_iommu_flush_all(struct amd_iommu *iommu)
 	build_inv_all(&cmd);
 
 	iommu_queue_command(iommu, &cmd);
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void iommu_flush_irt(struct amd_iommu *iommu, u16 devid)
@@ -1605,7 +1603,7 @@ static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 	for (devid = 0; devid <= last_bdf; devid++)
 		iommu_flush_irt(iommu, devid);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
@@ -1841,7 +1839,7 @@ void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 	if (dev_data->ats_enabled)
 		device_flush_iotlb(dev_data, address, size, pasid, true);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
@@ -2495,7 +2493,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		goto out_err;
 	}
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 
 	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
 		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
@@ -3392,7 +3390,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 		set_remap_table_entry(iommu, alias, table);
 
 out_wait:
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 
 out_unlock:
 	spin_unlock_irqrestore(&iommu_table_lock, flags);
-- 
2.34.1

