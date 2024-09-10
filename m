Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402EA17B4FE
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951567; cv=fail; b=eH1GGWfEav5eD9jZDwaCZSysz7nNYHLaFuL2hzTEUAleqysSDWr8FMA3R9oNuj1FwFjH1bAYa/TlMpHF/pf4kXRkTKJX0JhX2KBcia5nOc73srLtWcF9WMh31RnGD3uuZcUg898z0hE31xfQ88nM860cDwU/N8725BI/rsiiCJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951567; c=relaxed/simple;
	bh=sysJeVYgimxQTKMAg9y2bQyPgQBIifBvBEwDIOuMWMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPpyLeYZDEhUB6sSJRbQZmfOyrxnU1PR44HOrI3zmjQYnkYoxKSAiZhUEDFXuaeuR5Phz8691LNkju1D/Eioaw/Aq1/76V8IPsDBK6+oMfWfZMg8ed5qrbkzl0yczHST84awUVHj2L86niHfvIbgUdJ0f7Ws4yOTS5LktCe7FSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XetEm2KU; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XetEm2KU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZnZFuiZF3fkRRCtipEzuqblXdk9aUaPrcukvmqlkNN5Dc1yOZM1XaFK8waEuFf3Q6SOHD0pdTCtxTH8HPDSAGGTxWY5vN1METaX62dfVXVqhARb3wKBN0/6WTducnh+C7LZXy0/gtncJKE7vpnJbZM+pNgIGitDNNXSBz3+fMGM4Pg66F0EdvFsqJ3PV3awixD1fYyjGMEZXmUKs4scb5udMNjTqKn5+SIlq0l07LDDANGxfSTA00ndPE3uKRLKzzzvuirxvOO3caXJ1grLOrf/Hrzj4v+SdcIJY8yVoZIiWdWCL8r353YK8M1w+dU7sliQzD6rtdmqCK8HvLOkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60lsj2pOtGUR1dMLB9wH/+HWsTKo+Wl0RGSutfIMkdw=;
 b=URYlTmT+CPl4C1Y3u501YzXxc4VorWhssiYCd/NSZuwAROdijP3bj6F7WrD+sIMcsNc61gsL01qxvKCnouuc//38qI++rj7VX6Hmdm/efGZ8H+N0uxvfcF6NSAzoQlg3dgIEKOJNNjlNeWBuclT0+8C2+utFPSWUgrulFMJmmB9ElaznGXAyOYNcrB76mYMS1es9CnNTURnEiGZY5tipCQahiMv8iwvB/QGsWy2M8ArcoEVo/qkdyEffwu+NGylbFVwsbA1i5NtKHzcV6+IHlvHJJYyvmmwmJpeiVdz3CFHdOJOvAh+2m3T5u+DmPyY4UPHQCwjxEyRQ/NI5iEZ7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60lsj2pOtGUR1dMLB9wH/+HWsTKo+Wl0RGSutfIMkdw=;
 b=XetEm2KUY4ilvWmgL1u8UN7NKOIRL2oLmWoht1l4VSZ7JR+ogeZn932V0SZhrgPM5Yp3+6OIT7rfR4O83fld+AdmjXzcXcFydmxUZkXjYm9BQnJEYY/7rrRQVD7VDmNvnE1dRNKPz7u2IM6S8jYomfNRaCjAc1SDoMQYipmdYCk=
Received: from BLAPR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:32b::29)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 06:59:19 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::f1) by BLAPR03CA0024.outlook.office365.com
 (2603:10b6:208:32b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 06:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 06:59:18 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 01:59:15 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 03/10] iommu/amd: xarray to track protection_domain->iommu list
Date: Tue, 10 Sep 2024 06:58:05 +0000
Message-ID: <20240910065812.6091-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910065812.6091-1-vasant.hegde@amd.com>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1b87e4-0ed6-4387-32cd-08dcd166177d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WouYBDu0Hzumia5UcCLYKmv/hVmfXx0TR1X0BJv55agisN2CuQuiSBLlfpf/?=
 =?us-ascii?Q?84Ak6ej+Iia6ie8NcNkkfXi3BLlyoPah7IcF3lBWB6HeFNcB1KLXOEqKinVG?=
 =?us-ascii?Q?DlkOv55ZtVvhWqZpoEoy6rWQw7KixGivHzqtT3bJkG+lp1ISiKNWp1xaqOGZ?=
 =?us-ascii?Q?nnPpL+P5ak53T7tFsn5QnQnD3JX80lyk8xAVLYoJICH94suHh8swA4bMIRep?=
 =?us-ascii?Q?lrfQHFtSjFjW2MAlIe4NuOUlOkwZQk/slMK7y1z7sEzutr+KLJHkK98EKXTI?=
 =?us-ascii?Q?RAyFSWgy8ao2whMMuiLFMlqF8qRuBv2fH+ejZ3BrLCSOtR6KXB4e3Mo3TVa5?=
 =?us-ascii?Q?BvPQXXwySV7WwlpyHIDTX42KheJcjYjpT1PihZ6iB/xs43uQkVSUR2ML2mWY?=
 =?us-ascii?Q?48jqHdAUG7lEAbLkDuNi/bqY9Mi1fCYYAaCFfF9eKebWY+6tA5mRxAEd/lBm?=
 =?us-ascii?Q?xmv5lvKyhUWa60GO2QHApBalTukf6QiKP12Tm0CnAGEPpppCaWqsiALjthRJ?=
 =?us-ascii?Q?VqlJ4lmfkxfeX90KCP+EcYJ9g3lubqvC1Y10wsQHezCuylI26v7c2kYWFGHT?=
 =?us-ascii?Q?fBSZSTHcpWsNLpSYPyvwKRXZxyMHcZR/ZMl9siOYEn6hHvbzduPSxKx41Hc1?=
 =?us-ascii?Q?e/3OAhOD6Hpw0Ydzuunq+y7kSy2p5SR01uM5cMqO0Tlv0hw4dFimvvg0PCSK?=
 =?us-ascii?Q?XJh8hjV2CWXzrBBUF1yvKBhQh+PoEq9OTK189Rj02H6BA/qzQsqZVGLRwC/T?=
 =?us-ascii?Q?o/7UI76ftS+gHKmw40CIjxG46mA3PHxX8FlDp/xMvpeBQRxyeAKpgmI1w174?=
 =?us-ascii?Q?WBY/fLJAOCNgLNC/cyPFHoMi3xJFBOXC2aUos2ajw2jGyP9l8Kjb4y65vrQp?=
 =?us-ascii?Q?YsDyYwcU58iQA/Z0aNCJAKpRrHaPcuZ9qkXI4YWPHXgBMIiWGy2TRjsJPqYk?=
 =?us-ascii?Q?KMpJ84iSD+Tm5V4ZMi8TxrFqRcmlyUb2n6osfY9LSidsOIi9tsfMR5ZHyabQ?=
 =?us-ascii?Q?s3wpC4ibJrCfIV2mMa+ye4FJDBl3IMGGBnol4hfjAkSsKTBALERbWTI0V2y4?=
 =?us-ascii?Q?QXS+0h+AX67tqXv/EdfS2SdFvEujPMKLF6xyo3mNw9pCAw/7p0+ZZx9ysSDq?=
 =?us-ascii?Q?iVqae696rzhuTzemyJclARXJUkoXBfU3BY+0Lu2eyR7kjgl/NQvD4VenJW5K?=
 =?us-ascii?Q?FRhsYHHCqt2/gVKkfZqKJTHDx9ZWoPqzwXFp+mmSiIton3xEt/4E/2RnmQNZ?=
 =?us-ascii?Q?ghz9RumVT/QUk5y57Misumvn/i9fIQx3Qz6hsbq1R31hr/BLsPWlI3Uxmf/t?=
 =?us-ascii?Q?Rw8bCPRCX5FhEpyQnLmo09qdUPJlQySjI55vKzfEtx1elwcvGXCM59Rl/41d?=
 =?us-ascii?Q?3v6j3VtLcRx6nJ8wWcTrg6p0tK4x11uf7vmZDzLLaJdH6TI1UDr/zmoR/gXL?=
 =?us-ascii?Q?WPmrbPv3AnZ1524FgIpfVLgwiD8n0wxE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 06:59:18.9311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1b87e4-0ed6-4387-32cd-08dcd166177d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126

Use xarray to track IOMMU attached to protection domain instead of
static array of MAX_IOMMUS.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  8 ++-
 drivers/iommu/amd/iommu.c           | 85 ++++++++++++++++++++++-------
 2 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 418c14aa4ec9..0f030a61ceb2 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -565,6 +565,12 @@ struct pdom_dev_data {
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
@@ -578,7 +584,7 @@ struct protection_domain {
 	u16 id;			/* the domain id written to the device table */
 	enum protection_domain_mode pd_mode; /* Track page table type */
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
-	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
+	struct xarray iommu_array;	/* per-IOMMU reference count */
 
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d870aeb654a7..b9b060219596 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1254,18 +1254,15 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 
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
@@ -1447,21 +1444,20 @@ static int domain_flush_pages_v2(struct protection_domain *pdom,
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
@@ -2016,6 +2012,50 @@ static void destroy_gcr3_table(struct iommu_dev_data *dev_data,
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
@@ -2032,13 +2072,17 @@ static int do_attach(struct iommu_dev_data *dev_data,
 		cfg->amd.nid = dev_to_node(dev_data->dev);
 
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
@@ -2064,7 +2108,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	list_del(&dev_data->list);
 
 	/* decrease reference counters - needs to happen after the flushes */
-	domain->dev_iommu[iommu->index] -= 1;
+	pdom_detach_iommu(iommu, domain);
 }
 
 /*
@@ -2273,6 +2317,7 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
 	INIT_LIST_HEAD(&domain->dev_data_list);
+	xa_init(&domain->iommu_array);
 	domain->iop.pgtbl.cfg.amd.nid = nid;
 
 	switch (type) {
-- 
2.31.1

