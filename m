Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010035.outbound.protection.outlook.com [52.101.46.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80662D97BB
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299062; cv=fail; b=uva7tSEyCo+eAIUkBbwOzU3O4aWerdcM26U7cVEqX/jbSJPTxtJreEznOFp+YKP6h3tUJdHLXkuL/RnF/mlnHUG6ukZyJC1mi0cpsHn8smxzlhKgmNPo/O7AevPCsvaRTOxrT6jQvJIh76bRsH0SSb42MXEHnZJLITP2nmwb80I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299062; c=relaxed/simple;
	bh=/knl81H0JsbYvWgRMY+Y+RlP25UKA3HpjP1+rP9Ospo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/AAC2ZkkafM0nk+VAaiIEgaBTzoxn8neajgvXthrqBm9xd4spMzofXjtqX5xOWg74GScQkzxLSEewXLmDe1JZ4urRQRughNcRUU5mysEeuSZDm3u/9gvxO3qu0EWwRPEHlS8gXxa5QB3U5Rw5JOIFiWa+TBqEj2qiPtueaqu7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ro/zztG9; arc=fail smtp.client-ip=52.101.46.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ro/zztG9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qK5LFbvMPGlcg5rehO7zkE3ZA09pIlXYMNH7fjtO76Tfy8LEv/z13KOt+uZbVWja6bqDaCkPolB1h5MuMZRPgfqXJ/LDFpxEWwa2RZ7WEj58GHP2CBW048//G+3jlJSqwhbD9HBwtq8mTyKntjlaqSp6BBknR5XucqvtNh9zxOsPSVcP4sZ0AFQ1H2ZGVQEGdll93oqIe0+pD207TCWjGMRoi1exvdUuVwAod2G4WmL6AXLxsHq9lLu6aNWjbkR6wdSL508gN06zMUQpwWH55R9FjFJQ34nmjB3YajWa5rnJ17YhTDwndWPoJe4K5byyhPduF6QcUQ0qfrTYqw5RKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu2DTTxHyscqmHgB8sKlSnR9lzoPp43DcUQhf9uuocQ=;
 b=KFPs4eaRrZMs26dEgb3KkInp+g8gwHyN2b31o8MZQB1eGwb9srIXsF/TOvoVuBpIS+k1doT5HQnsrhd62vHEH45G6rw9SYWnKplpoQeIM+/QpiwPsRZhYd9B2z7tOzq2CqBGXl6v32bxO50wZEo5U9LcohBRGKuQFLLNbQRnGVC6gBvme7fP/PggTjjuI0l5XjwUKVhtBIQgVjBQilBF609I64MzD5R2jozR954Ce5bOU4A2h/eMO1+BSxAsTmRp+94fW0I5vbhLOkR38VL2wtXa8IEtXL66SFZP1SS4pRYBw47iE5PoTHXTFMoOS58I5BtM6onEhIh7n48kYwspIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu2DTTxHyscqmHgB8sKlSnR9lzoPp43DcUQhf9uuocQ=;
 b=Ro/zztG9Y/p4oHC5rTDNOiHEpMLKmhskjfCYL0ZFoLUnkZjjv6bIgo4l0OIALviB3KhjOCe0dgwvcGugTdX6Puy04Yd3ChyYX86BZUNLvR3962nA2oFrZ4cvJp4HkF/ezo0Wlcr73vbP4g90G9xrB/YZJLTiiw1fclzTEkfjXAo=
Received: from SN7PR04CA0078.namprd04.prod.outlook.com (2603:10b6:806:121::23)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 06:10:54 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::13) by SN7PR04CA0078.outlook.office365.com
 (2603:10b6:806:121::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 06:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 1 Oct 2025 06:10:53 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 23:10:47 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 07/12] iommu/amd: Make amd_iommu_completion_wait() non-static
Date: Wed, 1 Oct 2025 06:09:49 +0000
Message-ID: <20251001060954.5030-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9f4cd6-ff57-41c3-e4f9-08de00b14756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gv/Rmqf3eukkSdRHlnCmkWWgOPfDNNsR8+ImZ7aOj+Sk8Gj3WBCotCzLGDZs?=
 =?us-ascii?Q?mHBGuN4fdW79TwYQNK3vQ0fi9YGUncdd+z1C5t8rq7+xyF0v00s2kVTE5qto?=
 =?us-ascii?Q?TYJ50TcHJwy+tRJsCSIwnnPqqglabnzC3lidID8H3EDHHeyvpmtIKhXic/V8?=
 =?us-ascii?Q?DA2RBu6exYQ896ZvWFQ9WfF5Y9Gq5FcWXo9gFqQO8fPbq4AEsjh3XuoAXtlW?=
 =?us-ascii?Q?Qmayj1Uf/mPz7yF9trERVs/1nL9OOLUMfHHJ4LK/3X9NOhIut2YEGqGDgGBj?=
 =?us-ascii?Q?6JcawM+qrfCUeJ5zPiBlDQpL0SH7nca6cC4eD7WbeTQY75Y+Gx4xql6ldBtc?=
 =?us-ascii?Q?9+BKX47i24Gk/6gLVu5gHg4W3iqWW+XMX7IM1kkEc8fibE3BvkcEUXB6A82m?=
 =?us-ascii?Q?abVIvM+2fvyVfNmHtxLwwVkJH/Mizjp8uS+IbX/A3FNP/qfqqonRJNpNo1l9?=
 =?us-ascii?Q?Bdc9wzp+lRkZ5syQO49JGOkDqqO083WQFxiCuc8d9dXzp6g5w0cO5oNRuPd8?=
 =?us-ascii?Q?kz12C31ycSIauZUpK/HNFwaIoFM9GQrXrImnKEn4uC5af7p1YQ68afvxnDAr?=
 =?us-ascii?Q?M7vNCAmlpGNbEDDySxgeOlTJQYlQYJrbzHBRjnM5rKnBIz6EU6diZJ+LQ5/1?=
 =?us-ascii?Q?9swxiFA3jLzm+xHbq0MA38jfA1N0uRZ0s26/xGDaZvT2h5bkA2O/6eXcSQF8?=
 =?us-ascii?Q?P5vrqMSaRTLZcU+JKheXgXsl0wHrFhgr2LDy8sRujOf/9h8XPsKOhp/3ymnt?=
 =?us-ascii?Q?/BrZu0G6KG+nIJ3E2PN9T6zoagXXZckBTQRhVJNqmEWr21CaLogb3m5VYYWX?=
 =?us-ascii?Q?yBXxx25oMMyjxdr6N+P2trVek4kxK6AiUDlLUWCaxVQZOeL78fDtOVJIztEs?=
 =?us-ascii?Q?UtOVSdDvL6vP3dYGxaSVBs3I8j1mbPe1EcOy8BvGLBlyIKx23OjsT4ibUHaR?=
 =?us-ascii?Q?P152fS1aekzkiFhRp2HusJxhjiqGMKLM5qXKZ7imf6xloPlWwYHZDEbG/MIn?=
 =?us-ascii?Q?8NGV+zL3T1lyta4O3VPTLzk78dZK5Hk5uGAg1wZjgEMemHjP1hindL6lu4U5?=
 =?us-ascii?Q?vHbqx+A7zdVRCj9WzN/IbyBtbujqt6ZtBG2Jz137KKUvKQtRZA022MaNHnkl?=
 =?us-ascii?Q?BbLFES1o5Byz1BKSTTG+Y3EhMUuZsehKEeVJJ2JoNl1RvCijjyA6+8an8XRT?=
 =?us-ascii?Q?Ke7LnGvxhtHn9YEBD1AOshWeKOu+dPtWmImlwC2m7iEt7FIvsm6+LJqjs1Co?=
 =?us-ascii?Q?/VNmiGaF0zrXWsNVks0UfWM/QwUtGtFa2HTjHWuKQD1NZ1l0y7q4/Rupy7Nx?=
 =?us-ascii?Q?/pu5Meymjg3KaZeiz2gCyHYi79aIO9ZfeWQc++mCz2GGn7xqqXqcMv+gar/s?=
 =?us-ascii?Q?W8jFshDx+XljUUyeiAW7CMynx3Pyxu/4P759Cpn0YN5nE2gElPnpxQ9PrG6a?=
 =?us-ascii?Q?m97GO47KHpWNcR/CXzB8pRZ2XuvFZqAOM6s9zOn72Fe/VJ+MWSmjvHoksizg?=
 =?us-ascii?Q?NwTfXry+pROpYfRUbvyfbnfY4j+5o2cl7Hka3mMAr8i4V6PeOdiRpCt08AMf?=
 =?us-ascii?Q?v+MLeX31hrOVBh0am44=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 06:10:53.8576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9f4cd6-ff57-41c3-e4f9-08de00b14756
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043

To allow reuse in other files in subsequent patches

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c7cb4a80d44a..d533bb8851ea 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -187,6 +187,7 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 				  u64 *root, int mode);
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
+int amd_iommu_completion_wait(struct amd_iommu *iommu);
 
 /* DTE */
 int amd_iommu_device_flush_dte(struct iommu_dev_data *dev_data);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 386ac96b2c02..e0bfcda678a8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1392,7 +1392,7 @@ static int iommu_queue_command(struct amd_iommu *iommu, struct iommu_cmd *cmd)
  * This function queues a completion wait command into the command
  * buffer of an IOMMU
  */
-static int iommu_completion_wait(struct amd_iommu *iommu)
+int amd_iommu_completion_wait(struct amd_iommu *iommu)
 {
 	struct iommu_cmd cmd;
 	unsigned long flags;
@@ -1431,7 +1431,7 @@ static void domain_flush_complete(struct protection_domain *domain)
 	 * We need to wait for completion of all commands.
 	 */
 	 xa_for_each(&domain->iommu_array, i, pdom_iommu_info)
-		iommu_completion_wait(pdom_iommu_info->iommu);
+		amd_iommu_completion_wait(pdom_iommu_info->iommu);
 }
 
 static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
@@ -1449,7 +1449,7 @@ static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid)
 
 	ret = iommu_flush_dte(iommu, devid);
 	if (!ret)
-		iommu_completion_wait(iommu);
+		amd_iommu_completion_wait(iommu);
 }
 
 static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
@@ -1460,7 +1460,7 @@ static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 	for (devid = 0; devid <= last_bdf; ++devid)
 		iommu_flush_dte(iommu, devid);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 /*
@@ -1479,7 +1479,7 @@ static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 		iommu_queue_command(iommu, &cmd);
 	}
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
@@ -1490,7 +1490,7 @@ static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
 			      dom_id, IOMMU_NO_PASID, false);
 	iommu_queue_command(iommu, &cmd);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void amd_iommu_flush_all(struct amd_iommu *iommu)
@@ -1500,7 +1500,7 @@ static void amd_iommu_flush_all(struct amd_iommu *iommu)
 	build_inv_all(&cmd);
 
 	iommu_queue_command(iommu, &cmd);
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void iommu_flush_irt(struct amd_iommu *iommu, u16 devid)
@@ -1523,7 +1523,7 @@ static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 	for (devid = 0; devid <= last_bdf; devid++)
 		iommu_flush_irt(iommu, devid);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
@@ -1748,7 +1748,7 @@ void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 	if (dev_data->ats_enabled)
 		device_flush_iotlb(dev_data, address, size, pasid, true);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
@@ -2137,7 +2137,7 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 
 	clone_aliases(iommu, dev_data->dev);
 	amd_iommu_device_flush_dte(dev_data);
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 /*
@@ -2421,7 +2421,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 
 out_err:
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 
 	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
 		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
@@ -3255,7 +3255,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 		set_remap_table_entry(iommu, alias, table);
 
 out_wait:
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 
 out_unlock:
 	spin_unlock_irqrestore(&iommu_table_lock, flags);
-- 
2.34.1

