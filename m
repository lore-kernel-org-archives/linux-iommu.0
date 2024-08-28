Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74E0187FF0
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852671; cv=fail; b=T9zAJBTR1XWU74iEWQhbJzCGalj03xi1yYska4w8EWOdFP4jMORTA1tvwnM3pEzDbIVZkRjww/u+mr24xCygGriq2Njzi2RRPJWGhWBfzt2mdbn7MzLzsjqMJ8iht+3ykJUu6xO4Bh9g4n19WuVLY6s4Fwuu8A4lNIMrHIgdwTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852671; c=relaxed/simple;
	bh=cToOCtFUFgt57Voo8y6Ke/fV29YSG3V95lpPpEC6AGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUyYNwGWOAVj7DTMLU1+7TJdhkM3xV6cAvM0OnYzNpbsZsyUxi7HLTXoJvETGONBsHtzPywiosKLN0QDGbBegaUVvVTfk8hk1e5OEAkhcoNRGBMCtIHEAoQ/FbgmxjkCwZycFKDs3DttwO+rX16wZtJtu9RWQ09jdDTYmSWLkoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CirNtxH9; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CirNtxH9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQDB0LVG0o2w9xTZfP52Xh1xmcXawYhE3wPTbmn9S9lUzRux5FRsgJyw+L1d9YpPljc7pz6/ENL5ThNn+jsADF4Ftov+G8k9SP/yCZWuBZXIHDCJ4jRgw6qcZhSwJ/xpQVQUmUNvCFUCCfaIQmpUHtc4/IIzQn4V8QSeSba4cqqJL41KwebfB+4bROiMhp1+M/lxmnGn6XiqWo5epgcNdM2HV2nA/j1Z2nKP3LMys7g+X1eW6H3SyatmRxSyAQhZ5bOnhufMnMynQh7mxqu3dA8QCbYF8Dx/USH93nE6UG6R5Hrl9TDWGOvNDNvYU9a/3VpnQlg0blXCttUPwIyjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwxUXFH7ss2WXb5rDK2sbw/9y8vR0eG9ICmHXCQjF9A=;
 b=BEFp19t8/FMbUvYPjYrmpwa/n3ldiLOd2wZs9Imkzsnn3M+JjRbKhDkTi3hIVSSgxwefzVc47+L5qMoa18yt9mr+tBe/InX0R6+X1XMdAAX0eYGoKBCuxTraxxTZVtga3upozujaXtWKo+/s2rOrF2jU2Z8wy0ydid7BAMgepmdluNwcyfJkh7cXFDfXTHL7++Jzhkpbf/Btcn4j3FdpMotKRwOZf4fvdzz57Mzc2rZ6hL6mUEko1ygYBmOpItNk3/JqHZg2pHasqnj2SMFPCqav66ICZubvNeBViDg2wscEQZ2x5WcISMpb0GIkO/dTkXK/Hicj6zRi58Gf0MWSyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwxUXFH7ss2WXb5rDK2sbw/9y8vR0eG9ICmHXCQjF9A=;
 b=CirNtxH9/pdKdNwfDJchqGmZkqvt3F4bu8b3YUiHdHrWvc7G1E+jM0F6sR2n7kry0g+hTDy6gPBTXq/g0zp9py9xgQHSA2A2seu2oxR/vmk3rIeiDt/5pMh8loArXMI7SrLpSC2SJp5nZ/x6EsqnzWsFKH1v8ebZgMtH9ZSTyBU=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 13:44:26 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::a9) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Wed, 28 Aug 2024 13:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:44:25 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:44:22 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 03/10] iommu/amd: xarray to track protection_domain->iommu list
Date: Wed, 28 Aug 2024 13:43:10 +0000
Message-ID: <20240828134317.6239-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828134317.6239-1-vasant.hegde@amd.com>
References: <20240828134317.6239-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: d0224a68-2a3c-4deb-e458-08dcc7678803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3fSJFbOFHsDAIW9GjXm7PbHBIW0NKIZsputN2/l3baOEZWUBl2Jb5Rwewr/g?=
 =?us-ascii?Q?MiK89T7CrljA8I/aY0+SzJs1WPPPgg1FYJQp7u1QAI6Zlkm/Cy2XG34KMf0q?=
 =?us-ascii?Q?l0p+kJ0Xds5iHebJi2wh9TqI2biRV8Z+E7wMABmnXNjAaHyY7jfT9cLP7Bg8?=
 =?us-ascii?Q?HbZqb4K85eRXipwWjkL6zzj1BDQqrwx6Sc9qXC+YVk0812D4oB3YaZXhY00m?=
 =?us-ascii?Q?sDiI97j7kxW2xQordYAt/b5IaaEqKRm5/Mb+/s939Jd0P2bgGndP5EEqbC3I?=
 =?us-ascii?Q?DXtCv0S2M4bpGdRobiPevXA6WAJFHXoyxVArJMLqPf4W6ZUgDHo+54XVzx4g?=
 =?us-ascii?Q?ptz1TuAnIoy25kpeCOeXXeyMCwl1Nvnx1InXy+GGHC4ZWlXqlT8XOiqfD/2Q?=
 =?us-ascii?Q?VnL2TlhlKpM/S43E+L2sB7zBntkIdhP/2FkQyPsOlUQbX5IjogZnkkqn7oCG?=
 =?us-ascii?Q?FX6dDaw6Cd/vgklQT6u4rUF/a2w4+5ki68K43zSPSPYtEYqiSVjHowzOb2ta?=
 =?us-ascii?Q?2AepAJ6LWPMklvtOwqs+Ce/K03o24l7XgDt7V9iKX85Y107tpWqx90EmPSvT?=
 =?us-ascii?Q?gGRJ3gyF1rL88rf2xNImf5bJz8fXqEBbtCk55Y4Vl5xIgFpUqLICu2KIEDYn?=
 =?us-ascii?Q?7TO/slvZspvUsWgoVWxtmbuHlHoK9DbmnICIs5hHI0fjQ9sXWQgv1n/3iQc+?=
 =?us-ascii?Q?H7UYZDb+blappFEePH197TSzE37olA1Hq+D5zzmBW4rve/eAIk0Jgf0aCs0i?=
 =?us-ascii?Q?ACUBNjQAlNYXSf50nQ4ESo76wMTJeI/9AruZiXdEpY9qxHv2CyaZ5dnZaCKk?=
 =?us-ascii?Q?YHxHFaw8g3O8k1P7FCa+KAhVK/zyap2RwT+Z08ua4uvfTQ/DuP6EZbZulVFJ?=
 =?us-ascii?Q?1x8gKHyde5V4kQSpNxPs+CUIg7ZBuUrDFO/hNJBbhS3nxQ7qQsE47945Vded?=
 =?us-ascii?Q?tRvpxW6rRunbmroXY/K3hCCRtLnzML8Cghh0QNDswyJisFAxB9ya1N1JqZK4?=
 =?us-ascii?Q?qjLsOj4saZHYyeg/UD2HT/j0Xw7TyxQYsRS+yvgHw3xAdibX8MMtx8sy0+3v?=
 =?us-ascii?Q?6MJ6DCSQ097cyDYqseIWtLbcmJiqvd0UogA+4q9LN9Busp/pHfQCGzz3gLoj?=
 =?us-ascii?Q?BqQISDomEUiO3RF40WKZZZML+TE/zRvZfqmOk2lwexK/kETfi4j6cdXl8jEb?=
 =?us-ascii?Q?AhKax0j1BaKtPS9w9fCanCT9Y/5jcZzA4KBwntOUSTtlHliACX4x3NazO8bH?=
 =?us-ascii?Q?58nilXpxzY1aYi0wvlFyc1UZsIF0YoiRaPkdeRwaAY6uOfoNBDjmDOOQeTYY?=
 =?us-ascii?Q?I0eDBA6r4mxktSslZViFidN1oGhyfCWUAKbzRzg2iffwzic6ttzePeQHdI+K?=
 =?us-ascii?Q?63mQk0b5wC7+0gS8ZTerjn9jngvxV4S6lNLq35gUbx6sj1HjJrWGrBBd6tKq?=
 =?us-ascii?Q?xc8rLSZjusNCMg64H9DpimSUzWdmAxhR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:44:25.6033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0224a68-2a3c-4deb-e458-08dcc7678803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505

Use xarray to track IOMMU attached to protection domain instead of
static array of MAX_IOMMUS.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  8 ++-
 drivers/iommu/amd/iommu.c           | 85 ++++++++++++++++++++++-------
 2 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 6655e2d71ea9..7c08325ab644 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -561,6 +561,12 @@ struct pdom_dev_data {
 	struct list_head list;
 };
 
+/* Keeps track of the IOMMUs attached to protection domain */
+struct pdom_iommu_info {
+	struct amd_iommu *iommu; /* IOMMUs attach to protection domain */
+	u32 refcnt;	/* Count of attached dev/pasid per domain/IOMMU */
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -575,7 +581,7 @@ struct protection_domain {
 	int nid;		/* Node ID */
 	enum protection_domain_mode pd_mode; /* Track page table type */
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
-	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
+	struct xarray iommu_array;	/* per-IOMMU reference count */
 
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 748469a96975..4ad72b517ae7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1256,18 +1256,15 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 
 static void domain_flush_complete(struct protection_domain *domain)
 {
-	int i;
-
-	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (domain && !domain->dev_iommu[i])
-			continue;
+	struct pdom_iommu_info *pdom_iommu_info;
+	unsigned long i;
 
-		/*
-		 * Devices of this domain are behind this IOMMU
-		 * We need to wait for completion of all commands.
-		 */
-		iommu_completion_wait(amd_iommus[i]);
-	}
+	/*
+	 * Devices of this domain are behind this IOMMU
+	 * We need to wait for completion of all commands.
+	 */
+	 xa_for_each(&domain->iommu_array, i, pdom_iommu_info)
+		iommu_completion_wait(pdom_iommu_info->iommu);
 }
 
 static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
@@ -1449,21 +1446,20 @@ static int domain_flush_pages_v2(struct protection_domain *pdom,
 static int domain_flush_pages_v1(struct protection_domain *pdom,
 				 u64 address, size_t size)
 {
+	struct pdom_iommu_info *pdom_iommu_info;
 	struct iommu_cmd cmd;
-	int ret = 0, i;
+	int ret = 0;
+	unsigned long i;
 
 	build_inv_iommu_pages(&cmd, address, size,
 			      pdom->id, IOMMU_NO_PASID, false);
 
-	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (!pdom->dev_iommu[i])
-			continue;
-
+	xa_for_each(&pdom->iommu_array, i, pdom_iommu_info) {
 		/*
 		 * Devices of this domain are behind this IOMMU
 		 * We need a TLB flush
 		 */
-		ret |= iommu_queue_command(amd_iommus[i], &cmd);
+		ret |= iommu_queue_command(pdom_iommu_info->iommu, &cmd);
 	}
 
 	return ret;
@@ -2018,6 +2014,50 @@ static void destroy_gcr3_table(struct iommu_dev_data *dev_data,
 	free_gcr3_table(gcr3_info);
 }
 
+static int pdom_attach_iommu(struct amd_iommu *iommu,
+			     struct protection_domain *pdom)
+{
+	struct pdom_iommu_info *pdom_iommu_info, *curr;
+
+	pdom_iommu_info = xa_load(&pdom->iommu_array, iommu->index);
+	if (pdom_iommu_info) {
+		pdom_iommu_info->refcnt++;
+		return 0;
+	}
+
+	pdom_iommu_info = kzalloc(sizeof(*pdom_iommu_info), GFP_ATOMIC);
+	if (!pdom_iommu_info)
+		return -ENOMEM;
+
+	pdom_iommu_info->iommu = iommu;
+	pdom_iommu_info->refcnt = 1;
+
+	curr = xa_cmpxchg(&pdom->iommu_array, iommu->index,
+			  NULL, pdom_iommu_info, GFP_ATOMIC);
+	if (curr) {
+		kfree(pdom_iommu_info);
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
+static void pdom_detach_iommu(struct amd_iommu *iommu,
+			      struct protection_domain *pdom)
+{
+	struct pdom_iommu_info *pdom_iommu_info;
+
+	pdom_iommu_info = xa_load(&pdom->iommu_array, iommu->index);
+	if (!pdom_iommu_info)
+		return;
+
+	pdom_iommu_info->refcnt--;
+	if (pdom_iommu_info->refcnt == 0) {
+		xa_erase(&pdom->iommu_array, iommu->index);
+		kfree(pdom_iommu_info);
+	}
+}
+
 static int do_attach(struct iommu_dev_data *dev_data,
 		     struct protection_domain *domain)
 {
@@ -2033,13 +2073,17 @@ static int do_attach(struct iommu_dev_data *dev_data,
 		domain->nid = dev_to_node(dev_data->dev);
 
 	/* Do reference counting */
-	domain->dev_iommu[iommu->index] += 1;
+	ret = pdom_attach_iommu(iommu, domain);
+	if (ret)
+		return ret;
 
 	/* Setup GCR3 table */
 	if (pdom_is_sva_capable(domain)) {
 		ret = init_gcr3_table(dev_data, domain);
-		if (ret)
+		if (ret) {
+			pdom_detach_iommu(iommu, domain);
 			return ret;
+		}
 	}
 
 	return ret;
@@ -2065,7 +2109,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	list_del(&dev_data->list);
 
 	/* decrease reference counters - needs to happen after the flushes */
-	domain->dev_iommu[iommu->index] -= 1;
+	pdom_detach_iommu(iommu, domain);
 }
 
 /*
@@ -2310,6 +2354,7 @@ struct protection_domain *protection_domain_alloc(unsigned int type)
 	INIT_LIST_HEAD(&domain->dev_list);
 	INIT_LIST_HEAD(&domain->dev_data_list);
 	domain->nid = NUMA_NO_NODE;
+	xa_init(&domain->iommu_array);
 
 	switch (type) {
 	/* No need to allocate io pgtable ops in passthrough mode */
-- 
2.31.1

