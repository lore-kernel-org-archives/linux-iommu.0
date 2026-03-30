Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3E3ACA61
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860174; cv=fail; b=kTGRSGLpJu0Y+D5ptXbSEc/gnxz8Vuqcah1kxw1zhJpN2v/2XNDWqYaKeJEOebi4hv+nZbh0ho98Ivgu6Q+ApJUqGpCrNv5BTdviTDks83YdkLPn07U4pauFhN51GkMnC7UztN6Rs83C8+nXjYkmvbgK5pFuVrz5vGvLX6mdvQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860174; c=relaxed/simple;
	bh=ENo7x6SJakRjiKBsHn4PUsTqYn229fBNXW6ytGGBW08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dq5oXD1wwGmptG0yqZybTzXb0cyP22+T0d3UUrT9tr6901WHgtbGSfqoNMzEewroRcW5hH3hhahcB1Cuw6bzwhdCIwlKR6LBM1BNi/RmZ7udM6zxg5OTURRLCMpUCIvsYIWnMZWQGLEFsAtirBt2RwkDtXZV6XM0Y5tb5BbKAHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HbutmMLR; arc=fail smtp.client-ip=40.93.195.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HbutmMLR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0kn+JExrxo5ldFfyi7HGPc6LFkEinorzaotzEVMJIQNUZCCI0t1qFUPI0P50/F3BimL3eyGYI6g3MhzHnBEJc0cxKqwbkCCU5/xYMiWEbm1duPE3JXbphQe0w7Y2ahTR6dyOyMpHnQnmgOgLoHk9h/tPcQGPDhgKfblw2ieChEDxClrg31/XaL3Tsc7oWkIJ2KdCUYsnHKqdwTFAMgupDE8iZ9xf3wh0fhiZ6n3UNCW27iKvgN6G9H6t82rWyYxmHFflkaoQ+AmLidLpADV9VXHTU2IOMLQOQc/Z7FBzfkbeE7TkoXdYJUhgbaMKY2mL16/0rbe1sjnQP/8/Y4guw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0jGIYPugxYwc53gZ9/hBV3H7xkHuM/BFTLg6fTdDm4=;
 b=NEGedTqnuY/r8K3pL8ngvHoat97FDYzLZTGAkOBMpW3s4VFFmP2Bl/x3Lj5hTzRVNs1kdGudop8J2dpF8BvznHYNPZjfO+SwK0HDFdb8ulxLyT7rcE+JWLSjeWnE5YgC8qC2kRA/J6K6GdVsmmf3XPQyxwZPb7UTMoDjXtsPPlItKtxdR0YnPyjdVm+laqgYPTQGN9y09UfYNlqDcG5ruledlE8gAig1MMCUIqemmNKyGCHyWQ6jUyS54GC86OUi9dvb1G+lFi5JuKCMs09yMDYHqss477BrzoVr/FuzpNHI/NoIxOIJIpYvjZhD4hVvUzRUxWWkhV8HD3FqK5t+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0jGIYPugxYwc53gZ9/hBV3H7xkHuM/BFTLg6fTdDm4=;
 b=HbutmMLR6IyqA//WVgcc9D7YISUnG/FxbB2fBIQj8i1OypokdTN3OdyK4WZEHU0VFCUVf74Y6WUEJG2yDSGwOx8IO11JQeGnsNYv4LVXdXmHZxm2EykwjdEgAnvh82vVfeVw2ejUrF2B6iyUr3yrMo8e1D7rups3CDLqmr9+a6k=
Received: from DS7PR03CA0240.namprd03.prod.outlook.com (2603:10b6:5:3ba::35)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:42:45 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::42) by DS7PR03CA0240.outlook.office365.com
 (2603:10b6:5:3ba::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:42:45 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:42:40 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 01/22] iommu/amd: Make amd_iommu_completion_wait() non-static
Date: Mon, 30 Mar 2026 08:41:45 +0000
Message-ID: <20260330084206.9251-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|SA3PR12MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: a7715fa8-4c98-4a15-e08b-08de8e38509d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vH7vNoZKmtXaBpGoVFJD2fjy5aROEuSwPa6/nXIXWLb2AUxxoSn5gMezMoTf9ZyTCjjqwCXZmYVMK0y88suSG5uyYnR9reYFPzdZUeOdGB1LBDLyaX7STIv12AE6exVaZfq6NnHsca+zqTyLshsMH6plhXJeW6O0s/eXOy51qX8GACFDgZp/8aejD4hosGBOl1px7oDYnbbtWV/YnCsUTj3hoVKvp93DyExLrN2xR0QNtDZy5xGOK5Hc4TmWwEmkGe16c1gHt3Wzo0Rhe4HYVTOXNzbimWg3BjOtZo48FF5nDZL9iKD1ko2ZszcGlYlgJ7yt9bQ59mZiUlqP3dNoD1BY6ojYZHvmLIefpoZ7RYFMrEfXtURB1x7WGieqZAjDHeiHfbdp4K90ZnOnCdQl75/HkKZSFz/yzq7ha8JgqtEUrIduX5pEax3Pb8nOCMPGWVremduXnHftSDZpYVZstOCbrA34nyGUrW4hk/V56uBCZmCInR8zFrd1mwpDtlj/W/b4YmiCX0OpVFLLoiRgjVy4CFGKVAdD8J/YQyn1b0NNhDhoRfPH+u95ZiocJLIKXIAs1TJVpvHpORWQP0oFugJNPITecwaQ/XGgJ01dnmLnxB23lwQ4f5JdztR/9UmAfAWtJLK+6/VQFQsFt2v2fA04Abgl78zSh4A0x4F+EtO/xkLLfOtONNbC0bjOiFGZuHcEvzcAjnnWW/KHxQDnw94gwZ4GfmxA1suEKBXaLLesGNY0CfgFRtSEVSdiy0hqp7xiPJI0GHYN0zFPjrQPUA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yg2gW0yprQCqC4mNM7tCe2Lxn/gcMWHu8zEjOqbRBDRW8HVdSDCg1I1Slt7t293HcqTwqgKb3//bfiQMeqoWU79b/uL1letWsFb+z6tTdt3l5cHVAK9WyKNYQgBcqZ4x7F4s4uUXmky1x//E5bIGHtHQNquqSxL4mTJK7s4bXkL4u7k9iSHKiV+ye0tvgKn4tvT4JMTqwnYF3A4Dd3DAOWvJ/u6S+VZOy+gzQqLayn+THmxXISmBL1GEoLOMgzpC/viCFPbVlGlCbizwxFbhJLgNX3x5hauPX7Q9hW1eA89ha+Y36vkX09PRJ/HcYJegqv5lg9j6rIbnx13w+uf//2AQl2QqWdeF5sg4bAhN23zR/k46vIs3yxrCpn0N/rOZfpAf1fZBm9PC5U8qpagqHoG3FEu7FSP2xv3ZfaQySetibMCJMqFTiyKKB1R9MD7j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:42:45.4277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7715fa8-4c98-4a15-e08b-08de8e38509d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437

This will be reused in a new iommufd.c file for nested translation.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 26 ++++++++++++--------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 02f10922f70b..7308c6f1835c 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -197,6 +197,7 @@ void amd_iommu_set_dte_v1(struct iommu_dev_data *dev_data,
 void amd_iommu_update_dte(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data,
 			  struct dev_table_entry *new);
+int amd_iommu_completion_wait(struct amd_iommu *iommu);
 
 static inline void
 amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7e724f5675f4..ffa65a97ba86 100644
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
@@ -1443,7 +1441,7 @@ static int iommu_queue_command(struct amd_iommu *iommu, struct iommu_cmd *cmd)
  * This function queues a completion wait command into the command
  * buffer of an IOMMU
  */
-static int iommu_completion_wait(struct amd_iommu *iommu)
+int amd_iommu_completion_wait(struct amd_iommu *iommu)
 {
 	struct iommu_cmd cmd;
 	unsigned long flags;
@@ -1481,7 +1479,7 @@ static void domain_flush_complete(struct protection_domain *domain)
 	 * We need to wait for completion of all commands.
 	 */
 	 xa_for_each(&domain->iommu_array, i, pdom_iommu_info)
-		iommu_completion_wait(pdom_iommu_info->iommu);
+		amd_iommu_completion_wait(pdom_iommu_info->iommu);
 }
 
 static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
@@ -1499,7 +1497,7 @@ static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid)
 
 	ret = iommu_flush_dte(iommu, devid);
 	if (!ret)
-		iommu_completion_wait(iommu);
+		amd_iommu_completion_wait(iommu);
 }
 
 static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
@@ -1510,7 +1508,7 @@ static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 	for (devid = 0; devid <= last_bdf; ++devid)
 		iommu_flush_dte(iommu, devid);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 /*
@@ -1529,7 +1527,7 @@ static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 		iommu_queue_command(iommu, &cmd);
 	}
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
@@ -1540,7 +1538,7 @@ static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
 			      dom_id, IOMMU_NO_PASID, false);
 	iommu_queue_command(iommu, &cmd);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static int iommu_flush_pages_v1_hdom_ids(struct protection_domain *pdom, u64 address, size_t size)
@@ -1576,7 +1574,7 @@ static void amd_iommu_flush_all(struct amd_iommu *iommu)
 	build_inv_all(&cmd);
 
 	iommu_queue_command(iommu, &cmd);
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void iommu_flush_irt(struct amd_iommu *iommu, u16 devid)
@@ -1599,7 +1597,7 @@ static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 	for (devid = 0; devid <= last_bdf; devid++)
 		iommu_flush_irt(iommu, devid);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu)
@@ -1835,7 +1833,7 @@ void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 	if (dev_data->ats_enabled)
 		device_flush_iotlb(dev_data, address, size, pasid, true);
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 }
 
 static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
@@ -2488,7 +2486,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		goto out_err;
 	}
 
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 
 	if (FEATURE_NUM_INT_REMAP_SUP_2K(amd_iommu_efr2))
 		dev_data->max_irqs = MAX_IRQS_PER_TABLE_2K;
@@ -3354,7 +3352,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 		set_remap_table_entry(iommu, alias, table);
 
 out_wait:
-	iommu_completion_wait(iommu);
+	amd_iommu_completion_wait(iommu);
 
 out_unlock:
 	spin_unlock_irqrestore(&iommu_table_lock, flags);
-- 
2.34.1

