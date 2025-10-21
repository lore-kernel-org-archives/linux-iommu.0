Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930E1274B4A
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011075; cv=fail; b=jkhXJkRdoeVOhDzoiUFO3jNJnMIsG8NhLasemN5NeAybn1QA1ftHzHDFXcy4hrIuTmaQX0F/JP2jwvS0PXkqnqR1aJRxeK5yYFbORZQgF6uf137SmovzQrsuT/uwMZXlsXcFi32v3lQBQ8Snh8qrzEGrrjxmMgTlywrKW2Vzz/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011075; c=relaxed/simple;
	bh=Ok/cM8ese5HL4McIaRLtL77VpEJEHVsaHuaPBMt6gKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGx3SDiC9h6mKJ+0dpH3keS+zwwa7jWbMwf2yej3B7GEku6OLx0bSyHOHv4VPd8Nhp7+rm5cWCistBS/cOC+iFQMQZctZJRFPsouGuMYNeGktbONV3vZzepaRLbz3ZivQTD482dLqZ4evS1R8+EdSarr1oKOkn25jRDn/voGBjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RQtXV0G4; arc=fail smtp.client-ip=52.101.52.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RQtXV0G4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkbcWa7FL5dGSquZ9P7GM198s3hvIvBCGltWTsYLXmcOXaxut9+Y/jHi1vHsmspS8QVov+Jon+0SiuTx/d/Qre3NDvjpffodUYxZiWabwZu4x8EH9E7dCwvdU6naa7C7TY1Hd9/n5Fhf5DkPBWrWnQVAVND9y8mJRshYrkQpbnqAtMoaqAsPhwOomAx8gItdyTp2XWHPWWZL/xvHjdBgYnGMLJO5O4yDSnfn/3kHMyX8xorHB2G5034gq7Qr3lrduFOj6qZJohz3rbAfQNESuDgEoAw9mTS94hRNstdDuq6/QGcg4DZb1wky9AJUPsR42x/KGg/aoZOhUVpM+QW5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3M28cYGNqz9F9QhqOm8yirZ+3BjaFb3Yd6KvB5xY6PE=;
 b=qhx1T/JtgMPGHYvJV2aXLJt0XGShTKops71ZXWC3QyR9NS29nFRHpFc1YgnRVtF861XWX5GkxnUIdIc3VrvgaIfJyp+Rr7xMmpyX3x5Mn21VSPFvLbYSe1MPXJVTvlzzybF2I/898XfkwRjoaUcvkXAI8MdtErb2WKa7emCAzEI+D+q6dVDWGb2UrweZh0gK2Woq2ab0v6pe5hr3dRhkpf+giHoflJqFc2t7WqoU6OIgGLzVXHwdxRUlYaJMG3w5stCm2Lwo0anO/jOhvpqQP69ZptmGyj/NQeTJbxnw8iD0B/TlL55kK1AGlvIyz7+skIbDT4U+SzXS/fnjeywIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3M28cYGNqz9F9QhqOm8yirZ+3BjaFb3Yd6KvB5xY6PE=;
 b=RQtXV0G41GgG4Pb0tPv+Qto+MDLlfH1j3xHORzAUpMi+ziu3bEfBDEQwks0D3PSlTI25PUL7h0F6lyl+HDNlcdb6clHMB44w0heaXVh/xCtLSt+v8lva1yh7P4OVB9vzqw3gqj++SPQR/MkScbtps73VCL7GY1AbN/XimGQChsc=
Received: from BN9PR03CA0904.namprd03.prod.outlook.com (2603:10b6:408:107::9)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 01:44:29 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::ad) by BN9PR03CA0904.outlook.office365.com
 (2603:10b6:408:107::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.14 via Frontend Transport; Tue,
 21 Oct 2025 01:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:44:29 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:44:23 -0700
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
Subject: [PATCH v4 07/16] iommu/amd: Make amd_iommu_completion_wait() non-static
Date: Tue, 21 Oct 2025 01:43:15 +0000
Message-ID: <20251021014324.5837-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ae2c10-ee84-46e8-69c9-08de10436025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bS9o2W32fEi4sL6W+hJKAXCrp54zUioh7xiNMagUnoN670bgEyufxwvjpwkM?=
 =?us-ascii?Q?hfcGvtemuDBM48UMlw53yALmskJlH+w23Tk6NOmQM46sHhLLEKqPDVZzlz6N?=
 =?us-ascii?Q?nrXhxEnYG7fwKapXKsxzqIYESC0r/OJc+dCFPVp45xqRs6jXZogNvmWSRZh0?=
 =?us-ascii?Q?EaLcPSAuE+6OBWcCx5b+bEj4ML0dxqLeEuzWHH+QDv024GTLMA9yQJtFrFlL?=
 =?us-ascii?Q?tDupzN0ZLWqzio2hBqWPpKcBahCodrPPLmuH8fEQXNHf0N5D5+wiRhG7yGzs?=
 =?us-ascii?Q?dCfSQ4q4iNkvZwcXhJqITVdIOJKIXm+otoRHKeZ3E1s3RgjX2ZWY64sFdCaT?=
 =?us-ascii?Q?dbqhmljScz+p3Jxx/903aufxNMueFAtTZ2aLogFE8iFcF7heO4vk75sEmlr2?=
 =?us-ascii?Q?RwRl3vl435fyNpObYTSIxIpX9ZtZeeYlZ0sefLPCXwVjMT4gNprj+pgvozZR?=
 =?us-ascii?Q?qpx2JOBFIlWO/I4y34VTUKl7w3YXMpbCJ9LNmtHN8kwGnlhDUlBrTejXswoH?=
 =?us-ascii?Q?YFSJCikP/6H1ckaMjMP90PhZRx5tOUi3p9o37EDZZdmuKglRrM/4lYL/xBDo?=
 =?us-ascii?Q?//70VAWSR0rwW45tfvDiMKeT/8f7UE3wNH2UQhzyN8ELKjrSN7b0Qk243oZA?=
 =?us-ascii?Q?ZcjiRSLUJUObSTohb2dl2KnqVpVoXNJJ8Gh3A9/hJRQv+jDSMQjYoTeSNjkJ?=
 =?us-ascii?Q?mD5CVqpiQPH15wgo1ROFxhAhMT/3dle6UYmN3JP9kkQ3AGl3MDOZARGv/pjT?=
 =?us-ascii?Q?J19nK5cb1kNQcZAB6LnKJr+0QcSIGGEJtugQd9sGfcfHPIFQTkPr+QI3wFC3?=
 =?us-ascii?Q?XHQY0Cru0ZrpaD2hf4IwKZI2FZ0GHB2XGT0IYVfT9B2xAjeuEWzXmbJCvcAy?=
 =?us-ascii?Q?wY7h/ELr86x0H0LC9zGw3Brlf7uLVh21t2vp5g+ynXxYiXkdHKQIptwlxqrv?=
 =?us-ascii?Q?VmkeeHV5FzISNSDApECRyaVxuCDkE2604pGP475aJssI8PmF52rNo1F9pWsJ?=
 =?us-ascii?Q?BN3lDmmLZyT+XrDOzLfdcMGQLAYkZqd1IzRgF4vfsMDXsXWW+8Hy8K36DJek?=
 =?us-ascii?Q?AX2Hj+SpEhjUwuL//xeQnsLY0krUtEBblg9RU406v8r6slz/o7He7TWSrk01?=
 =?us-ascii?Q?1450a0VWMORPWCGCKXPXeDMUVRw7Oqib8F3nDSh2kLBNDg5VssljUvOtgKTo?=
 =?us-ascii?Q?/d6ivVcJWd8IPf2HxfEKpGIU+e32kt9WGAdA9ZAw4AcE6PNBtEjH+aXiuA0F?=
 =?us-ascii?Q?VWQsl71JqqRvkhFp1gMfo31RM/Z6jVJjuhxnieQt1QFoqrQz0ODzCmaJoS+p?=
 =?us-ascii?Q?WQwrTkig4vzpY6TbSu9YDQ+Nfm7YwbVkCHtZpBNwpuMF9nO0XaFzHvbG+O/T?=
 =?us-ascii?Q?NQekm8AosxUxOou72amAT82bnxzbU1qITgExNjW8bTXCNGGfqivQ4m8owp4a?=
 =?us-ascii?Q?dM1l49dugHKV7DzLgkFwFUyD0VWT1WT63WP/pImDvE3g0Be4aYLmO5tJP4WZ?=
 =?us-ascii?Q?D+Sg4YvhX30s88WJCS5RroEoJRHPDxAdsvkO75ftcmRoNCAm4TeKdImqPXO2?=
 =?us-ascii?Q?Ab8+9chTCQ7VGDmRNUo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:44:29.4678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ae2c10-ee84-46e8-69c9-08de10436025
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186

This will be reused in a new iommufd.c file for nested translation.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
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

