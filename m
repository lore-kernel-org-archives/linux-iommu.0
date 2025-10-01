Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA802D8760
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 06:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299037; cv=fail; b=U4Kf8zwF4nGRJx6yWUUAgg+KCExG47RDN1u792vowohIkvja2Viy4wHF1JhQ3dmsCb+Bi/I3PlaGzcsd4gOV9Ft8OyLFiVS3n2s0wuu3ZIP3/8FqkOEA45grByaXM6kI59jK6NmfIwUZX2r9Bi8k8zT4VTOurwpYgbJPJcIh0nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299037; c=relaxed/simple;
	bh=pkQLRyG97D/bPuNzZJZnrh3GqYTOtrWFNTUTFVgTs2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sThUjoOEcxkNmgwJjyhZwRVB2ffaz6OcHMbmKqo1WwRGCYZdrRkNS0g1DqSxtEgYzqXGcDaJTkJwfoE+Mknl3kdWHx9qQ5UmnsGm1dXkQHI3FphIA/fhZBc1EyvBxCqsZ2oEVge3WmrKDtf8nXVSRtQlsX/Z1hgtPiw8ptpsCjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QY45V5lv; arc=fail smtp.client-ip=40.107.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QY45V5lv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5Zv/xTGK8hs8WUAzvzsX97myHvE3yg5/CX3CrTTTdZmSGvqcRFsknRHSd1LRD2pH+DwtDD5Hl9ncvAiYvVMmf4xGBupVYdeXP0h0Oh58tKBE0q0+5G0pBiUVI7mGHPuvnqWgFxnuT4k+4YGgdSJ7ePNZ8la4g3WjOr45LNakFcFLdg3WH7IXnhsXzvXJohgv9LFYxQoBNoDMn5BPB0JWX9wSD7mt/aOHWYJp9IWCQTK93IOR6EgfR76eS6lp/eUo4/9lEqX6jAdeHbj8g/w5MxEQOTzgk8hq8Pai30+zjzpLPkK9xbcDH8kN8YG+M9OL6z3eri2jOuYXt6YtseBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhjwauXThrvwtuonBrpvPjQIUfSYWRyuGj5/xBNWZBw=;
 b=TOlnleiR5hFO4+63sXxeIssZBIxrZztySi+6/sm0Vb40nfJIYhCyEFZbZBc/Y2GX5MZD3f0ZW/L/TacAJ/drDSA4cQxgb6q/nYfu8YBXMTMHs6fMNsZGEZoEWqLvwhIcIOgUracjrfriHWld4c8PzfKIUPWROY6OcpNQvbyl4jC1hvsTf31UwNWa1y8ChZmrwGuACzUdv5UYk31RgKV76mGz8MDFM+BB2Rpv0exh/qIczaDTex3qJbUTqcLlrR2XV4Yi2xSU+Uxk0EqW0cw04wvSqODS9yGnbLsMb1yBwWMgrV1Vn1TlADiHAL6DQQWJfXw05cvVGEMlb0KSgsg9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhjwauXThrvwtuonBrpvPjQIUfSYWRyuGj5/xBNWZBw=;
 b=QY45V5lvqNlYYT7biRhDjniBLAvLqqlwqkpIm46ZsioMVGYKdzZODEKvmReKbcaLVFI+nsIzHxFPIoBjw1acebeiScMw9sH8LR/lidXrbvXIyiaolKschrrugbu5SRkK5s5CMvcBsPcavQJqJTO4gH1kgfWiZoCtzfgWecwvO7c=
Received: from SA1PR05CA0014.namprd05.prod.outlook.com (2603:10b6:806:2d2::23)
 by CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Wed, 1 Oct
 2025 06:10:31 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::a4) by SA1PR05CA0014.outlook.office365.com
 (2603:10b6:806:2d2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 06:10:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 06:10:31 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 23:10:25 -0700
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
Subject: [PATCH v2 03/12] iommu/amd: Make amd_iommu_pdom_id_free() non-static
Date: Wed, 1 Oct 2025 06:09:45 +0000
Message-ID: <20251001060954.5030-4-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f012cce-abbf-4c46-dc0c-08de00b139ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ATXmDiRSgDnxX79Tsbs0bOwrmfwjUcU7rW0p4EdiOgguUAX3CfOCts86omdQ?=
 =?us-ascii?Q?BOHPNhOHnM9J76hHeAz04Z/cDAc0qbMahv7oFiWsKFUjSwnYnG7lIAiZCb6o?=
 =?us-ascii?Q?HDicwcQr65pdwvzWXPCBwDasQWkxDX6kqNsTwaEMuCI/dDSCCve7suX/T9YO?=
 =?us-ascii?Q?bzd5APKzuVkRH9EXxSCrv+DxVdlOEwq0Qwj9cj9V92DJ5VfMosLdG0BnYB5f?=
 =?us-ascii?Q?TC3XNiD3D40ya24f8eV2s2AsBB3Ger8ZD+GzK7ltF3F2CBSvNMTgBQielJ9b?=
 =?us-ascii?Q?P3VcjbPo9OM4W7VbTcfL90jirWEa972Jq3JISfEf5O4ocO4lRmpzECUi41XK?=
 =?us-ascii?Q?1y+Gw1GSDLN9P1U+i0+KSLhb4CnED55LNtMlR2UDdmVpxXRh3W029FUcxxbW?=
 =?us-ascii?Q?ory0G64PP63PtNsAONz+xzVIevt/OUwIH7ynkvH/MS6DrTY8W3bVjuO5aXYn?=
 =?us-ascii?Q?51jrLl9luYPf1M2IyuTMMqOeA3GvZfbHSHiTYsYW/wY2FsMrMSgqe6l0wGxc?=
 =?us-ascii?Q?rboiTUO7b3pi88dtgQH78fA/4Q9VrMkGYSYa7uJEhVbr4SKUcXhIf9WK8t7r?=
 =?us-ascii?Q?mUQPuNIeV+GDEFK7SPgVykNFi2PiyxFHQlP+QbWvxUHDd5gxQuZEOX/KE5S3?=
 =?us-ascii?Q?TZ+0rDf2ssVSpStOU7zCNzr+dR/fEX0hpbm5rsBj8dTF3fNRiPFPlafYcqUJ?=
 =?us-ascii?Q?zcoXFA+icIjomhbKRB7mcmX69EAm15znmSHmDmZAFlNfUVY0crYMuAzlzhWC?=
 =?us-ascii?Q?T2mAEBnyuTAMWMjOBOz1kC2BupqL4G7ylcDn2V2aySabtkoWPCdmiT2cKsUu?=
 =?us-ascii?Q?ljquQTGZ+n3GqsgbihrB6OPFCeXlGzO929sK8zhTfHyj6qB11JbMOo7woBo1?=
 =?us-ascii?Q?mNT4H9fOZfBIKFg3uzLnuxr792TJ9iURZplUvKtXEkUrge6NaIn4dAuCA/P8?=
 =?us-ascii?Q?4CdbIwWgrHPFQO5Kc1mXmglodXc+udm2uYBNjObZs3LTSxZiy/jJP08jpm1e?=
 =?us-ascii?Q?SZzgtErNgQVD2+lGpzdyv9PrissLO0/muWMptwbvZyA7eLPPLkbirEbwmsyt?=
 =?us-ascii?Q?dn6Rh4p/PvowAyh98RgzClNHMb4GldxgwM5NbaoeJxWmTIBo59dl4gISRMVI?=
 =?us-ascii?Q?EJRVkmZ0kC3sidUHvOmbo8U9TY+U5A2AVJr89s5JDR0pWy85odQ5V0Zrzsls?=
 =?us-ascii?Q?BaC9pSHtnClwAg6Nzo4mRryBpQE50mjRYozKnXyIdNSItSTsOC5LBayGxMJC?=
 =?us-ascii?Q?vBQiRnk8CwBYYfTvwJ1ctueYn70cf8vZBovyeXwk1X+SQ2U7oNCSiBtCOYZf?=
 =?us-ascii?Q?nkJY4tu94xg5D22ad379Wl45ihTgPxPbc3Cc4zx3UdU25BRKBUiwMcXViy/R?=
 =?us-ascii?Q?2UcfYw2KAGM4+7BvSRwkuv8U+9jzl2k57B8LhWGuVIbKvHOGkdvwqcIryMTJ?=
 =?us-ascii?Q?piZT1qwUkynlfSgLiHC9o1Ym9w/FvRdo578Y1IPpGgKWAVu3rJ2PnZB9y89d?=
 =?us-ascii?Q?27k2f9PX/Ch3PEW9YaLOmurF7qTUCvV0IIWjRu6ip22FWZh0kn/LhxpoTKvS?=
 =?us-ascii?Q?n3AdkWLRMkt6I9s5Ruc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 06:10:31.0303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f012cce-abbf-4c46-dc0c-08de00b139ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683

To allow reuse in other files in subsequent patches.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6ea549816a1f..322c8c73444a 100644
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
index 78b3e5485006..0b61059e485d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1823,7 +1823,7 @@ int amd_iommu_pdom_id_alloc(void)
 	return ida_alloc_range(&pdom_ids, 1, MAX_DOMAIN_ID - 1, GFP_ATOMIC);
 }
 
-static void pdom_id_free(int id)
+void amd_iommu_pdom_id_free(int id)
 {
 	ida_free(&pdom_ids, id);
 }
@@ -1870,7 +1870,7 @@ static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
 	gcr3_info->glx = 0;
 
 	/* Free per device domain ID */
-	pdom_id_free(gcr3_info->domid);
+	amd_iommu_pdom_id_free(gcr3_info->domid);
 
 	iommu_free_pages(gcr3_info->gcr3_tbl);
 	gcr3_info->gcr3_tbl = NULL;
@@ -1913,7 +1913,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 
 	gcr3_info->gcr3_tbl = iommu_alloc_pages_node_sz(nid, GFP_ATOMIC, SZ_4K);
 	if (gcr3_info->gcr3_tbl == NULL) {
-		pdom_id_free(domid);
+		amd_iommu_pdom_id_free(domid);
 		return -ENOMEM;
 	}
 
@@ -2573,7 +2573,7 @@ do_iommu_domain_alloc(struct device *dev, u32 flags,
 	domain->pd_mode = pgtable;
 	ret = pdom_setup_pgtable(domain, dev);
 	if (ret) {
-		pdom_id_free(domain->id);
+		amd_iommu_pdom_id_free(domain->id);
 		kfree(domain);
 		return ERR_PTR(ret);
 	}
@@ -2631,7 +2631,7 @@ void amd_iommu_domain_free(struct iommu_domain *dom)
 	WARN_ON(!list_empty(&domain->dev_list));
 	if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
 		free_io_pgtable_ops(&domain->iop.pgtbl.ops);
-	pdom_id_free(domain->id);
+	amd_iommu_pdom_id_free(domain->id);
 	kfree(domain);
 }
 
-- 
2.34.1

