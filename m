Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012007.outbound.protection.outlook.com [40.93.195.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27443563D0
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971953; cv=fail; b=JZRT2zvDVoF0C8WDysQvJNhBmOyaXiolCGyC1CMqrZm8clE3JGz9eJkR/BKtvSTqGfaRR7K0ZG2O7so3OwG9fEMfCgp/YumNK2Pzr2AFDxZGx73HDt8Fsdjclg3DDzFUXqWEjf1ULefXPcfWGWcYsxhIMjI5XNQZEIBd3cXiWsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971953; c=relaxed/simple;
	bh=ELIjPhrnx4j+w3iIPyRSr32J/zy8ZkJ0lR45Oq+wysA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDi1Yuv+uYWzNOlYqIFkGwM0oafCHEC6T9bpXoTb89+qSbDlHxedMGfaUJSyIp+qU0wYIjhAotdXgJRfK3C9PNaaXx/zIKrWSjHctNCO9w7x1Wyxaf9MLh0Z9dIntdHtR70lg/1E/5GBFK8n090isphP7ycmNKpGgOFEmRiVuJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4OavHIuw; arc=fail smtp.client-ip=40.93.195.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4OavHIuw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDXqKnhlRvCuWDNd+zpqJiKoK/85GOlclrLLJvzIBT6w6D/2/QHChCyON/XUB3a00XirSxntDl5F8ioQE0TnoWQIlDMtW2M61wHopSnpGrsQFYaxX78OzEeFLyjxlUTHZFNOJjH2iElnuomtUc+BHWmGL1ZcnvULAErqQ06GGmM5LAlFq+pmWdLmlF/0t0qEXYvAK2FCfLPozmZGISekbBx+AgttObfQiCGu2pPX//MnybPeuJFg9Sx2DHvtxYwnSC34k2g6ehtBg1LuZ3GAG1s6LA78UAHXFTC1TQmnOiMwwRNoW7v4D4oqBBCXTy6hMmvo8f4gGjK/i9dedCZUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hDhcPIQuunr+iOdvxERkrROxQq9TjhD7HblJzqTZ8k=;
 b=tgutYpasvYs1GvJSAQP45fgW4Owe0KoZe/sdLSetKigdovIB0pU+f0EAT71/eDrNfxE9H5XZ0vPPHW17Atpx7/q1sbB1FZuk+B3zCbmAk9bOgVU+2a1fB2UxVkXdvMGh56Eja9grHrEe5lnn4Mr1D8NMwAw6+UHfqM0cR3hLaH6/aNozyqXp2pjVrVa6UZys0gUHDJJaUd7LkUruMzhMKlmUIio/7Kawb6E3o61gukpcQRicSqq9VXVe+DaOWW0fpeOLhbYq+yIa8pkDZKYUTYsfs3DxFRrO9DqQu0nnXSw1cH/j1SYuPx8V4FYVc8XLfkkHhXp8TGNlRZPE7na+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hDhcPIQuunr+iOdvxERkrROxQq9TjhD7HblJzqTZ8k=;
 b=4OavHIuwjDWC+Kjkr/nuL6QL9IaTf/tzQAi1jpknEUxewZci9j+jW0vuupoYLH9KGt/G+fTMAm0xJBsT2YGuAz+5eJnN6TGMplinffPeRAbCo2p3ZBDg6KlyLomlQ/2HOA2HnAoPmZCzuPQY0VmGK2tAgUV9xGIZmQL9vVq/dPg=
Received: from MN2PR08CA0014.namprd08.prod.outlook.com (2603:10b6:208:239::19)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 18:25:45 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::3d) by MN2PR08CA0014.outlook.office365.com
 (2603:10b6:208:239::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 18:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:25:44 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:25:39 -0800
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
Subject: [PATCH v5 03/14] iommu/amd: Make amd_iommu_pdom_id_free() non-static
Date: Wed, 12 Nov 2025 18:24:55 +0000
Message-ID: <20251112182506.7165-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 8712af6e-7418-48bb-8b9e-08de2218e4f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yai7fOsbLAkuTEj5GMDnG3nzQOutIQQaEKp5NxqJlbTCNEHl5LoQFX76MZUJ?=
 =?us-ascii?Q?N/q6RlQa70VPu2DS75cR+Fdimv/GizipJk2k2vKpRFj86z4mkJizT1TDZBDJ?=
 =?us-ascii?Q?6ptX1ptZDVrH5vGGvLlsOiS4zR10MFwnpAKZu1yqmjNrNV02y9fg+CQ0EsZu?=
 =?us-ascii?Q?JUR95hZgdJ6E8vyLa+g3Nx0w9uc3b+PWkCbzeB+VVczFn83XtBq7pspctBFW?=
 =?us-ascii?Q?eatoWz0LfXN9VlNrmVPylF+d7+7yaaKvbscYF6jALPKqRbxt0PHcVjFjzDbO?=
 =?us-ascii?Q?NG3vJDVwiffTv/A/mXjO0vTshGa0BcNkrKRCQYUDzCDXuLsVhtrbVtEN9IDQ?=
 =?us-ascii?Q?4vLiclF880O07C8mj9bajkXKWgWhYixkingbCQZV6LenC8F+GAf7HWavoowS?=
 =?us-ascii?Q?7lq7dIVPP5/L7n+EhL/xfb7/+9BbPvUXR06DjEOmksabtRVs/Gl0RYWrxCpP?=
 =?us-ascii?Q?Q59vyloletpDTiAU4cIEwrBkcBpZTWJsRzc9c2g+/wSJ5nVFCIAv66wWhUW3?=
 =?us-ascii?Q?s8CYVPaYW2YdXrfla0IYD1uYmWPqtfc0oAP3yM3UG+LJ0HRR/W57uFGyDyuo?=
 =?us-ascii?Q?HE5MQH32VWQvIaUbTRbp0k32TW/fp217EwiG2mAxSWiThCJBRKwpjPkhmLHu?=
 =?us-ascii?Q?PgPwq1KW6YhRvn4Ij3awfKV06SJdNVI4K6y0kAZWF3RK7qgIztYXsF/t5yd6?=
 =?us-ascii?Q?cCxiyuhu/I7ZCvCZ0vig3wTrBUTYaWwV91dTVbFz4OHllHOUGgQn9zC5uSx0?=
 =?us-ascii?Q?CDnf1FFhBM3rU2ybGkUZ6bxoJXmZU/+1fMy+8jpHP8sfKCy+s9FopQg1S+3N?=
 =?us-ascii?Q?dLe8ohU0aHt0G1JvX4WiXkES5D9YA1Rf+NjC5Yd/MenhEUbruJggHY6EXK4k?=
 =?us-ascii?Q?oYtuvylPFAh5WTbbG2xfk8MDqe1GYlEbG0n75c2so8RUzFPmdPmaJnsuuH4+?=
 =?us-ascii?Q?VtK80GwUzVSPbWBfSBMvVsgC1f85aFOXGqOpoawzzFL4dXnGR4s8oft1xeRz?=
 =?us-ascii?Q?n/bLFD7FYQ2A7uZ4gpm53EtN/jSypy6eYH8cyAAoR6vBuJjIYDtKWY15FILW?=
 =?us-ascii?Q?jhiRsA1QXQuXaZfVgreL/PT7pF8Jwk2h4D37WsuyLG6tcRk/Z1FoemskbTN6?=
 =?us-ascii?Q?xQ9YzsyocJmX5KF3tPgsycBDSdhfcXkH0MmbRuPvJfNfri3aAaApSMcbhtOI?=
 =?us-ascii?Q?h22Ow3Xl5EB1ZDCkzQItBgI5w4pQ8ou7Vxk3tMc6HRen41VaJFMiH3c85Qvz?=
 =?us-ascii?Q?szUC+rTAepoQNwuWyWnpCSRu7aJNUP3YD9j5srfiqa7f27m7dv9S0fRtioIx?=
 =?us-ascii?Q?ITEadHR7P2vnEskoM3gnjPf57gJpzO/RKVlOtRt/dMWY3Z5uEowtTvz1Ugri?=
 =?us-ascii?Q?f0OaZovIOOiYqkAXVEZQEynusCtBoA9pd8xOMVJH4YoyW737Yo6rsAHU/+4f?=
 =?us-ascii?Q?Sga6+1uGiEvs7/tyWXaKZTIEiQi6a4SMxLbxje8B8mWzDCMMDOHC1Z09NHWM?=
 =?us-ascii?Q?/yyer3/BhQh1081FWXGn/0yKCtQkef4/hgoULuW4/Ofu3GUw9IfI6CyDyrFB?=
 =?us-ascii?Q?IYs8XVOt4m/yU3+leCE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:25:44.8747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8712af6e-7418-48bb-8b9e-08de2218e4f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845

This will be reused in a new nested.c file for nested translation.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 1 +
 drivers/iommu/amd/iommu.c     | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index a9d724d43398..2730fd0b55de 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -27,6 +27,7 @@ void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
 int amd_iommu_pdom_id_alloc(void);
+void amd_iommu_pdom_id_free(int id);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(void);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b42738e9d8ab..81eb27aa30e1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1792,7 +1792,7 @@ int amd_iommu_pdom_id_alloc(void)
 	return ida_alloc_range(&pdom_ids, 1, MAX_DOMAIN_ID - 1, GFP_ATOMIC);
 }
 
-static void pdom_id_free(int id)
+void amd_iommu_pdom_id_free(int id)
 {
 	ida_free(&pdom_ids, id);
 }
@@ -1839,7 +1839,7 @@ static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
 	gcr3_info->glx = 0;
 
 	/* Free per device domain ID */
-	pdom_id_free(gcr3_info->domid);
+	amd_iommu_pdom_id_free(gcr3_info->domid);
 
 	iommu_free_pages(gcr3_info->gcr3_tbl);
 	gcr3_info->gcr3_tbl = NULL;
@@ -1882,7 +1882,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 
 	gcr3_info->gcr3_tbl = iommu_alloc_pages_node_sz(nid, GFP_ATOMIC, SZ_4K);
 	if (gcr3_info->gcr3_tbl == NULL) {
-		pdom_id_free(domid);
+		amd_iommu_pdom_id_free(domid);
 		return -ENOMEM;
 	}
 
@@ -2774,7 +2774,7 @@ void amd_iommu_domain_free(struct iommu_domain *dom)
 
 	WARN_ON(!list_empty(&domain->dev_list));
 	pt_iommu_deinit(&domain->iommu);
-	pdom_id_free(domain->id);
+	amd_iommu_pdom_id_free(domain->id);
 	kfree(domain);
 }
 
-- 
2.34.1

