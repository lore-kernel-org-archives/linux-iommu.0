Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F6A59
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115209; cv=fail; b=CbebUvinU7VYK63V0ooYLyb3fIaTerxynUqRpSLzeA5Wq0L85xSxGW4iT5RKppRNRqQx1uqLfeAN7BiEXev1Pm5PhkeRm7RcOUzjBDxSQsCktq9cTptXfOBAxCXFwDrQMG4RWRdv3szXyOAdaR62KXhG76so+ijIhaBpzYjEHuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115209; c=relaxed/simple;
	bh=Fw/uXWCD58H2JodIMgjugnlRaauv7Z/uVgHg2YSVl70=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUZnEgfMdHvbPnj+NwDCFNH5WM0FXVz8zPwq4wlInujMyWhDOqguRtIAf/EIh8X3auEDOEimRodXyo70UhmPC1dDMgGw3NF2JXFQpX/MkNIXIxol0F8K33AAZiwl9Ge+gzZFfuk75ZIqV4ZnBtUtceBsPuAqzifijSW9mB5c8h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eEBapjDO; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eEBapjDO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoS2HBxTXBg+QgaG4HqC9jfgQPaMHZ8n9JTEp931KKgAM2PPOswUlEqZmUQiq0UtaO2gXuRERmCvibpLx/gN3JEWFYkuehJrHWiLelAqZMpAfGfr/9LroKNl2GrHp7unj8Il5QaBtpI5eXFuDP3ylNR7/pVQBqCy+wdqrPDZNJFI0u82DG9uoye7GlI1c/LMBUuMtrC9HvOXZO/sDJPUbBQW45FuF1QWHpc3SjounFG0Yddt5TnHW7FbYEXFhwVEvBUPN+dfNVM+NBNJ5hOhjPo+a3ch99MggWpkPR0KS5pJc13MkoNbrSa2D2awp6a/HfiortUD5nYr5knkk/7gkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCaMoLEpW9O8lwNcvFs0afGuRHLF8GY0J0wWpDt2bRk=;
 b=yohBhbC2W/lm1H03DA+cvNl4jbfZxHO2ZrS03clupjLJFUi6fUIiLAaBZZSny415BwaCgQ3Kn9voSgDfnzp+UG/UthVGkQ9bS4I+07u3m6WxC7md91y/DAtf/FiO4bwdQ3Oo1OgvzKka6LIsANz+VYGwt32t9myNk+uarH/+/vXLmRmh9f+aCjFqOXH4Hqxypf+NKOUI4SG8E9MqFdgiB3v0c0og8tL+9E0lIZgRpS3V+n/5tHSkWCDbHGX8B+8Tl28aqBQYzjxkp/gMv7sRRghea+bYD6jinql+77sU6mN68DOOTl/uJg12lDWNtZJXF+djea+sXzpWTguwkjTmzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCaMoLEpW9O8lwNcvFs0afGuRHLF8GY0J0wWpDt2bRk=;
 b=eEBapjDOWHWTRxZVl+8uBzRM5lIp2F5VnJ6BFi/Ne5iEEWa5FBtvHS71GZ5Uj719AC2Wq69N9l4ysyCR6xlib/fR0Qt5NX97jW9eCGxPqd/F6nQbb3DDdLr7M2MU/OLkobdKCF0pQ6GayGsSxSkhr+dJ0J3ZHAyyLp86fqjhwcg=
Received: from PH1PEPF000132F4.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::39)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 28 Oct
 2024 11:33:21 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::3) by PH1PEPF000132F4.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 11:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 11:33:20 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 06:33:17 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH v4 04/12] iommu/amd: xarray to track protection_domain->iommu list
Date: Mon, 28 Oct 2024 11:31:40 +0000
Message-ID: <20241028113148.5774-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028113148.5774-1-vasant.hegde@amd.com>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e09f55-c603-4bc6-60f7-08dcf7445383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i4va8PO4RttVGHOMgcblAVA3cg2Ux5Z+IHe374trBqQ8ybObgSeV532k+e7p?=
 =?us-ascii?Q?e/J+uKrpWDbDctMkCkhRhWifKJ9gWf/SHLyPkjAYCXxtFK2/OHaGNQsfA1ff?=
 =?us-ascii?Q?MNBYG7+2/tLmCVEkltnJRwVU+6SmXOisVK732gVcHkRgjlgFqyEeM+zyK3vJ?=
 =?us-ascii?Q?8MJrZx0jq/x1wUaQ+U+/WHTF1n5b8fAUenYKQFPaTha8Q3wOPiIfttLDLTeF?=
 =?us-ascii?Q?ANSBt2hFB/yo5B62Yt/ZJVxZ3kkoNekZcbRx8mSMSGfPl6lZfNHu8cODowa8?=
 =?us-ascii?Q?uWVoe7aVn2Pc9mTNumjB9rxFsY1h1FNTy3uIslvVlVkFNCaRCJFN1TbePtuJ?=
 =?us-ascii?Q?UR2/ylYRCkSE2nP1yOhM4Q0JyVhdH0mOrv5pI8LMJyGhDboWgxJKkFnwL5Bp?=
 =?us-ascii?Q?gkowM7A/k5+11byZjIM+cRmhoIcHv8rv4jz15BOYvlFNMQb3QrQycb6pxHct?=
 =?us-ascii?Q?a+eEjkOS0hYluFwT6dWuOnj11mnpVixN8YVSjjVOs4q3rOtlb7xvgJAQVXKA?=
 =?us-ascii?Q?Zs3p6Rof2XLJnXRjrRYLqFP5Md3p09Ea/c/ih2ihI1+JqSjypWVNiyvgNMB4?=
 =?us-ascii?Q?clX3PDf40UZnSWLegLT+tmLoy22K3dctz/xEReUoPQ5EvkYiDXYcRpQXj24e?=
 =?us-ascii?Q?a4sjpSBn6FF078pxPHnuEyTIoW0U1B9tiNqpxv6TF06ZYuD9b4falsFFparF?=
 =?us-ascii?Q?+jgrpzrRtyI+WZapEmhN5ww2pZ1bcnFEOSnR641LT7gLV0jI1aIT78At6Idd?=
 =?us-ascii?Q?UpFR+UDT5NHuH5clSkHT+jrI5ObeLZ5jykPGEutdv2tuBHM59PO3E3y2Bvk3?=
 =?us-ascii?Q?ewIvr7KHN8C2ukSL/2JB/XjEFw2SPqCsBy/jK6FeaEsJQpNpKTcFKvDpkzuk?=
 =?us-ascii?Q?zh+mTeK2mR8F74JmJ3xbOy/6yuyoDrVyNSnEqghX1jMa8pQUEREJsa3dSx3K?=
 =?us-ascii?Q?B0D0Xm2MBw/g4TDa4NWl1vEmIDkgAvdD1tVYqKcg1icIfRoUWRu/X3ueDpxW?=
 =?us-ascii?Q?Dm7G4uBgg855L1EAiaT2EeijZOHlapvSBAQRT/FAxOLYukY2K3BAyoCTZpG7?=
 =?us-ascii?Q?5QXFMhcAvKLwr2KKekIiKpsR+XpIag+89S5mB0AMMVPz+kGTiwFsplUdpRPv?=
 =?us-ascii?Q?IT6eaURuahC3kTYTwNr4N/Paq8M3AhSF4egY/YUUNkd7F1+2p0qAD1fpHxK/?=
 =?us-ascii?Q?nDz4V9ipNorpuHJa42xE9WdNQrlfVHWifgrYHDpA4aw5T/aSOXiNx5kZAUpg?=
 =?us-ascii?Q?M9btYuaZ+i8fu9WdkzWVtQR3EcYUv6HgIms7eNdWmTfunGhHr5t628UoxXNY?=
 =?us-ascii?Q?q/p+3zCOlWz7D2kGJlKFqsztq99t9Zs5KP0WAFdupHdBgDlWT7lehjkMEYvV?=
 =?us-ascii?Q?4Zg+u2yqBr+Nh2OA32XZAuByrvrVlOaHsZ4yyX70MwQ10m0OUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:33:20.9786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e09f55-c603-4bc6-60f7-08dcf7445383
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109

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
index 2411b79cbba7..12389ba1e542 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1254,18 +1254,17 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 
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
@@ -1447,21 +1446,22 @@ static int domain_flush_pages_v2(struct protection_domain *pdom,
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
@@ -1500,6 +1500,8 @@ static void __domain_flush_pages(struct protection_domain *domain,
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size)
 {
+	lockdep_assert_held(&domain->lock);
+
 	if (likely(!amd_iommu_np_cache)) {
 		__domain_flush_pages(domain, address, size);
 
@@ -2011,6 +2013,50 @@ static void destroy_gcr3_table(struct iommu_dev_data *dev_data,
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
@@ -2027,13 +2073,17 @@ static int do_attach(struct iommu_dev_data *dev_data,
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
@@ -2059,7 +2109,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	list_del(&dev_data->list);
 
 	/* decrease reference counters - needs to happen after the flushes */
-	domain->dev_iommu[iommu->index] -= 1;
+	pdom_detach_iommu(iommu, domain);
 }
 
 /*
@@ -2268,6 +2318,7 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
 	INIT_LIST_HEAD(&domain->dev_data_list);
+	xa_init(&domain->iommu_array);
 	domain->iop.pgtbl.cfg.amd.nid = nid;
 
 	switch (type) {
-- 
2.31.1

