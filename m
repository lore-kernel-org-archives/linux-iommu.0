Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA7463CB
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730270603; cv=fail; b=MB+s5EFPuf9A63nK3x3mYhzKgWWBIN0CTAN6rFXoYt1GHT5TElwgzlrQzW5eJ631/y0Jc6zixBvTdXabOqXV557A2xTgyskNKeo7pHaTs4EoAoOpBAr8I6S5RSkIYXKtAlBxLjik55ad5gBrEKSCZqXr99J8/CYUcUOOrWhTWGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730270603; c=relaxed/simple;
	bh=ujZY6BTeDVe3l0QD3gOzW+TSiOJxDDrQzMJ9yqpzMss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MlI4yd8RE6soblH77/SswUrjdu7aBdfv30cdvQC6nfCiLACBJgOFpdeOyoaDoyS/sZhOE6Jdb2UBgKJ0+tD4SDgZDwbsHo9QoWr62BCtH/cxuVzu22pMfAK1QGRO9dXKUVHv4AYsqyJxOu/m8KOxAARjUtBskEFUez//zbu4rlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vrQ9/nA6; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vrQ9/nA6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBkJFXBf4R0gVCUj5tGcZaRm7TWZWo0iGtVC9tnpR/qdZenBOvWOiS5+i8hnjzTJmooQHRYuJgETGmNW+fh0UOJQjgIV5benZhkCC+EjrJG0YQMu32CAT/mwmNYDakYZU1JtsjrmfmmjupJkpr0QNIbFqDMWm3uYcjOTwlMB8s7bwNxRTz3Qk3D53xUnpLU9emC1uj0vDotT6i+wOt5H67YrXC8MBgFRxgFG01AEEymjJxRmCxziWwMR43/vaE91QtkxKna9zezBKuXVxdtl8xpFFMEOUkgOYUWRsrHKEGObJyspvwb1ylxsUXpjpfyRoKRFLaaN2wX9ZKHztxwqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEjlKepVpC5XtD8AGkD2OEeknAgNfGwO5dD81FVa9cs=;
 b=Q6IoANiGI5vC5YWIiwvYpYyWV34UTT7KpdU05pwwePkHdRk3ovJ/O4TIw2FqTz1vgBidOSPfVe1SIoRpF8n38rOPNrqj0Cdt1WqhsQeaoCWFnu2/fNdirqI4IFkLhpnwXuT+JS7Pk2F+mk9JATQBR/GIyaYPtXqbCKd52d1zad9RcachHWWimK1tF4TE9R/r/3JYNPkrtww3MQTxNtXcniLg/JIguNlMZ5NjUpreULHVxtHtNeWzJ+oU6blYIuVajWM6wYXrBNxNUPtnWZfHm1/x1rP/HCHbQzqHxSWZNk8IRv4d7AFLsbvREAYpeQ/KtD12fCroAawVrhhTQ2MMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEjlKepVpC5XtD8AGkD2OEeknAgNfGwO5dD81FVa9cs=;
 b=vrQ9/nA6XuHLY1zQKh3DFcIHkvZZhc5cU9kJQY6cI8w/RMEoj5tNMOYBYt+Mkk55Pec6nW2ONPkCpYGrAYPlfUS12Y9wJnZF6cO7P4EXbMBWf72wTgtStSt1mKNLnocWo0nkS2KHn7EjQLqPfX15vuUY8RU9L5TNFFfbjmITJWM=
Received: from BL1PR13CA0281.namprd13.prod.outlook.com (2603:10b6:208:2bc::16)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 06:43:13 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::a9) by BL1PR13CA0281.outlook.office365.com
 (2603:10b6:208:2bc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.14 via Frontend
 Transport; Wed, 30 Oct 2024 06:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:43:12 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:43:07 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH v5 04/12] iommu/amd: xarray to track protection_domain->iommu list
Date: Wed, 30 Oct 2024 06:35:48 +0000
Message-ID: <20241030063556.6104-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030063556.6104-1-vasant.hegde@amd.com>
References: <20241030063556.6104-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc45fb8-4227-4956-5692-08dcf8ae202b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c3ZQdHBRzuUKvGeITViBXsM0aSKFuFtcStd0Mh/nou7IzEkHHKSR8+LpZ9+K?=
 =?us-ascii?Q?7mC6xd0IfFJz+7wvXdoLDIqvU0HpkgIwLpvVduyVhUkZlHV1w9MvEMY6UgBy?=
 =?us-ascii?Q?IpB6dAJ5zYnnxtu/j9nbTKF96znwTxlU6OuI1MxXTGN+GfcEPCNQPVrQQFyC?=
 =?us-ascii?Q?iKfGDsuxJFdRxMrMYRjb+tYLeYLlluj+Wlg/pf05JIG7UAKB5MCTMejOE6cg?=
 =?us-ascii?Q?onD7ciOWlmYCupIJUp7BHQaw5jZf9Fn6BaBxu8vKlK5duqj8cOGlsV5kpvjC?=
 =?us-ascii?Q?0T40By0/HQ+LyDwSlv4vC7R8terFp8jvrU+raXz9JCzY+CD/8a722de8TC5a?=
 =?us-ascii?Q?4kGTUV68Xfugrxm+5NX58cdX5pgYXOmRWH+qmqqm48CdEx/rsrRLvcwjyjPd?=
 =?us-ascii?Q?Qk8Ty8kPeeqbz9dCW7yw+QjBUH7IhB1/TTPPMWVO4zSdrtzBnYJoOHWNLShv?=
 =?us-ascii?Q?btDF4WctCQRUC+ODqUn4sgh+mi4topfouKUucYbBSWBGEoIQX4IXtq2xygic?=
 =?us-ascii?Q?zMwaZcGHyqvAKT8OZgHozM8Ge3NRGrAmvo8MZ1zuifFVkcNSlUKdImKZhrCt?=
 =?us-ascii?Q?HSZFeWkRpGrQ4+HLTiPWSWyLcd4oTrVEgongQPd70qAWigxZgdPaAuiJfzDH?=
 =?us-ascii?Q?sLMfcTXuwsQa4GtRYLHkt+EmQAgXvFOhOrUAtFJ6B/X7rBhFXxnW8wl022Vb?=
 =?us-ascii?Q?aIpoQ28eHZamXAGu9lR8P/Y/hedgk5FLg6fsy/B1fmIpnRTbKT4RKWFQdx/p?=
 =?us-ascii?Q?Wqxe0CqJenyN9H0C46gDHTGo0KAs8g+w7db52H9+sK2g25s3G05jbCwMsXKn?=
 =?us-ascii?Q?M3H2RgarjVkZ9VHrQlF1i6BkH8XHwUAhQXhIAWB3bxmxQf4u57UMatBLA9dQ?=
 =?us-ascii?Q?NAj/AD+GdTiiXZ6JGnzijdRGJRKmMwvBG4LjK1UCTZzPsiKLDlHbfNnB3p72?=
 =?us-ascii?Q?n4ewRWwMc6oPSIyhR4zCQn138f6yb0Fe3dOetXfA8PF5sRuMJz8YWImk/7GC?=
 =?us-ascii?Q?mmjqtPz8g9L0CWT8ipA/Xis7VYt858/W7iyZoazdeTuCM+HZIc5BeD53tNzE?=
 =?us-ascii?Q?n05z7p1Ily77qKow7wdIY61kyjokqkL1vfEeQlA4wW66y8oyDBDrmpUjyzng?=
 =?us-ascii?Q?ucvC2tkZ2n8CB8NFC3+/2IvTz/fHfLtV/xz2u3hei9v1Bs0Tp2GU0z4M0u4B?=
 =?us-ascii?Q?k5EzaCovxLAiL7D5UQ8eDrGt8tp6rE6+XPJupaXINldkRcdCzPuewFT++s/7?=
 =?us-ascii?Q?3EtIK4npLRMPWngBjW/UdxRh90Ntc67WNgXspdEpVXFSECYiIsr02yj6DNBQ?=
 =?us-ascii?Q?9awD/yf2B44OHdDwHT8FQEvWufbWvxYgq5XWhk2MmHVSYxrpv6UFnRyduF4Z?=
 =?us-ascii?Q?FEBrjGtWRJmXeH/UyUaUpmHNC9NNvFf+Yl7s9oMGwVWOsXD5LA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:43:12.6851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc45fb8-4227-4956-5692-08dcf8ae202b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

Use xarray to track IOMMU attached to protection domain instead of
static array of MAX_IOMMUS. Also add lockdep assertion.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  8 ++-
 drivers/iommu/amd/iommu.c           | 89 +++++++++++++++++++++++------
 2 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 90a752f57463..f88f6e4e910f 100644
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
index 00dbfbce263f..0bbe22c3544a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1257,18 +1257,17 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 
 static void domain_flush_complete(struct protection_domain *domain)
 {
-	int i;
+	struct pdom_iommu_info *pdom_iommu_info;
+	unsigned long i;
 
-	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (domain && !domain->dev_iommu[i])
-			continue;
+	lockdep_assert_held(&domain->lock);
 
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
@@ -1450,21 +1449,22 @@ static int domain_flush_pages_v2(struct protection_domain *pdom,
 static int domain_flush_pages_v1(struct protection_domain *pdom,
 				 u64 address, size_t size)
 {
+	struct pdom_iommu_info *pdom_iommu_info;
 	struct iommu_cmd cmd;
-	int ret = 0, i;
+	int ret = 0;
+	unsigned long i;
+
+	lockdep_assert_held(&pdom->lock);
 
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
@@ -1503,6 +1503,8 @@ static void __domain_flush_pages(struct protection_domain *domain,
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size)
 {
+	lockdep_assert_held(&domain->lock);
+
 	if (likely(!amd_iommu_np_cache)) {
 		__domain_flush_pages(domain, address, size);
 
@@ -2014,6 +2016,50 @@ static void destroy_gcr3_table(struct iommu_dev_data *dev_data,
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
@@ -2030,13 +2076,17 @@ static int do_attach(struct iommu_dev_data *dev_data,
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
@@ -2062,7 +2112,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	list_del(&dev_data->list);
 
 	/* decrease reference counters - needs to happen after the flushes */
-	domain->dev_iommu[iommu->index] -= 1;
+	pdom_detach_iommu(iommu, domain);
 }
 
 /*
@@ -2258,6 +2308,7 @@ static void protection_domain_init(struct protection_domain *domain, int nid)
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
 	INIT_LIST_HEAD(&domain->dev_data_list);
+	xa_init(&domain->iommu_array);
 	domain->iop.pgtbl.cfg.amd.nid = nid;
 }
 
-- 
2.31.1

