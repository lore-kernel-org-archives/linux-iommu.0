Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E891BC4C
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134586; cv=fail; b=j3ndrBfStj44kYv4FHEB0oLFzAW2o4Uk6u8CapD4zsikEqb35yvayZp0kZNc40xScVNURzZWY9g3CEpFODIFeGzvz1YjtU6Nkl0vrONLqtJeOMhsOuV75duzJHPRuMEMytMhzOCJOQEMahFLBA574NODowaPv38oQ6Md9HgYMXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134586; c=relaxed/simple;
	bh=C6+yzKIl8YuCtYCZNexZ0yGZDY/RCTU8QhnsYx0ADRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSqDPzUzlvRLzr1VP6noyzqv6yFZS5tZuM9d2PzgxEf9hhgTnsJBLthbqbqenrdJN+evBGQJfAV8A/nQu740QyOa3ZDu+BExBLkatg+H8nydvSPT0o8W0WMDEoaPkNfvbD5jtpb31wlFlhCZOZX81e7+A+iluvnwXRuprkd77U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KmxCtaD9; arc=fail smtp.client-ip=40.107.101.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KmxCtaD9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz5bR2GSk1+TmdWwGqNa2GqJ8CmkzrFKV/9XIcPx3SfuLfAv/ARC/fqulssaKzakrR3FkUK4uVNsY4lbIW/AH9U57nG1iwjapdDKcK3x+nVm/eafeSSKF/1MNBGe5EgLvvF/CV/IZ8zntW9FMhPSDeNlNG5oXPa83fqUAeOsKRHBav+SDC+QOXyO2MxuzqeL+JX0+i0jrXVszr6J2gPilb5GZWyH7qnm9LKZAsi8eCcUPLEJHWAHuV3xxFZtCB27wRbmHIfeGps1+fVB+VJU+IOSuSYoXAiTmFfITr472L+DPCkarNlyDseSESbaH5b9QU/Jh96rdEqS5+iOX6qZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udutKoEy6rjiDY5yFLZELanUTak10mpd0DJBrq9zpSk=;
 b=DhZyXEOuWrsLVfROEsa2xp3HVAyhnRBXOHGtsNBRcozi+amBd/fGV7XoV5VoVSJC7RmA089UClirYEsMpjxI9ziTrMUvI9Dh6gId1C9ehPA3UHzNCinlNoFl4lWdDKxMlv1roKzOXZ+elnMC9//EDoCLceAbted4Z5vK3fJdlI3O/4/CcRyuQHsziOHuQlIp40BztEcMYUBDa2oDW0FG1mhvz7eYzSis/KRUk4G0eJRGqReLnUa4UQqlYGflkc7vBsh5y64QWEJF++MmNmJhMhYRLZ4ycfOF4yeSUtgAFXqtHsHP9mWk9BQynHqGa9/kS/qGvePULkbMkcvPrHFspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udutKoEy6rjiDY5yFLZELanUTak10mpd0DJBrq9zpSk=;
 b=KmxCtaD9JYMRRaHDWytKv1dop7ezotk5AO5EkNWcLuMqCk+VNLXKuLUfU0AkuWv/AZ+Shl5+25fOm2u8QMCLAiGj0TwfbzEOMqSUrEQVMQ/kNM1U+6fljP5ZoJoRWkD/e7CgO3lz/ufUWosWr6DDvwkW0TDfg5YnKw3Fgtqkf9I=
Received: from BN9PR03CA0854.namprd03.prod.outlook.com (2603:10b6:408:13d::19)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Mon, 5 Feb
 2024 12:02:59 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::50) by BN9PR03CA0854.outlook.office365.com
 (2603:10b6:408:13d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Mon, 5 Feb 2024 12:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 12:02:59 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 06:02:50 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 13/17] iommu/amd: Refactor GCR3 table helper functions
Date: Mon, 5 Feb 2024 11:56:11 +0000
Message-ID: <20240205115615.6053-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205115615.6053-1-vasant.hegde@amd.com>
References: <20240205115615.6053-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: dcae30a5-c269-41df-2b23-08dc264265ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rzoUurtkGpRIZyN8YhbsPL/+R69qS/Q/Rx7YkMYu8ZyErLbsDyc27p+8bR/NOXCzXjijtKbjEEWw0TuYgHKPED7rFHn0LvTnV0KmIslvhsodhpOv/rOh1BRXSuOoYh3csgIn3hKyehF/Q2ebxSCMqVOyvHUK8yyDbwsqZucCd3dAqAAY8sd/0Lvv8/sku0mH5lXGU9/AoFuJzMElJIuGxvGhVAqM8n4oRuICI4HVVSSv//4x+zPkePIJRDCzKKDUNHJZbmywxN6a6gFBQx4IJvCnTM2tm9mvq9siSvGNlrJAPrHXNL1ETMKnk8mFkopSmUg1IP9yIlapCbmnhkCUZ3CZqyLa5NYj3ClbM7l0d6iBKBIkyNEj5k39W50yhfJbsQbvUdtJaLzWfk5pZIZt8BEZX6sBhGYsmwL//yInO0nDFgcW0+6fQzO5R3ZKwIduazuaKDlAM+Q3PGzAp3aENhglaLWWlTVLV7gbuQ9odOgo8thsJTbrfYIalmdmsPAGNhW0IcD5eOnLWBOOIGRK/E8KCaO0QZdRsy1d4b6d9PPFFYElagd9PmnPeKRAlzhx4rzEyGzgIl//w2URjnAhYP0S+QogGp1d+M9qzzui6lA8g8AGBGKixnMQtmDsYJ9CyBZ40hioWq+iqv5m/H5Nf0Mi3A/d96YXjFi5JGWbfnXOY7qNxNr+ZswORJavAaTPVUbvGsUQwK+aEBvySnyE7gCvo1AliiMPWs64A72waN3eICY0OZcRJVob+p3UXr/eLd3Dfvp9NrTfjYqqVkX2Ow==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(110136005)(54906003)(81166007)(316002)(82740400003)(83380400001)(356005)(2616005)(7696005)(6666004)(1076003)(26005)(16526019)(2906002)(70206006)(86362001)(5660300002)(70586007)(478600001)(336012)(8676002)(47076005)(44832011)(4326008)(426003)(8936002)(36756003)(40480700001)(40460700003)(36860700001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 12:02:59.4440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcae30a5-c269-41df-2b23-08dc264265ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To use the new per-device struct gcr3_tbl_info. Use GFP_KERNEL flag
instead of GFP_ATOMIC for GCR3 table allocation. Also modify
set_dte_entry() to use new per device GCR3 table.

Also in free_gcr3_table() path replace BUG_ON with WARN_ON_ONCE().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 53 +++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f56f09d83bea..4ef4351ed96f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -79,6 +79,9 @@ struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
 
+static void set_dte_entry(struct amd_iommu *iommu,
+			  struct iommu_dev_data *dev_data);
+
 /****************************************************************************
  *
  * Helper functions
@@ -1670,16 +1673,19 @@ static void free_gcr3_tbl_level2(u64 *tbl)
 	}
 }
 
-static void free_gcr3_table(struct protection_domain *domain)
+static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
 {
-	if (domain->glx == 2)
-		free_gcr3_tbl_level2(domain->gcr3_tbl);
-	else if (domain->glx == 1)
-		free_gcr3_tbl_level1(domain->gcr3_tbl);
+	if (gcr3_info->glx == 2)
+		free_gcr3_tbl_level2(gcr3_info->gcr3_tbl);
+	else if (gcr3_info->glx == 1)
+		free_gcr3_tbl_level1(gcr3_info->gcr3_tbl);
 	else
-		BUG_ON(domain->glx != 0);
+		WARN_ON_ONCE(gcr3_info->glx != 0);
+
+	gcr3_info->glx = 0;
 
-	free_page((unsigned long)domain->gcr3_tbl);
+	free_page((unsigned long)gcr3_info->gcr3_tbl);
+	gcr3_info->gcr3_tbl = NULL;
 }
 
 /*
@@ -1698,22 +1704,23 @@ static int get_gcr3_levels(int pasids)
 	return levels ? (DIV_ROUND_UP(levels, 9) - 1) : levels;
 }
 
-/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
-static int setup_gcr3_table(struct protection_domain *domain, int pasids)
+static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
+			    struct amd_iommu *iommu, int pasids)
 {
 	int levels = get_gcr3_levels(pasids);
+	int nid = iommu ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 
 	if (levels > amd_iommu_max_glx_val)
 		return -EINVAL;
 
-	domain->gcr3_tbl = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
-	if (domain->gcr3_tbl == NULL)
-		return -ENOMEM;
+	if (gcr3_info->gcr3_tbl)
+		return -EBUSY;
 
-	domain->glx      = levels;
-	domain->flags   |= PD_IOMMUV2_MASK;
+	gcr3_info->gcr3_tbl = alloc_pgtable_page(nid, GFP_KERNEL);
+	if (gcr3_info->gcr3_tbl == NULL)
+		return -ENOMEM;
 
-	amd_iommu_domain_update(domain);
+	gcr3_info->glx = levels;
 
 	return 0;
 }
@@ -1812,6 +1819,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	u16 devid = dev_data->devid;
 	struct protection_domain *domain = dev_data->domain;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
 		pte_root = iommu_virt_to_phys(domain->iop.root);
@@ -1839,9 +1847,9 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	if (domain->dirty_tracking)
 		pte_root |= DTE_FLAG_HAD;
 
-	if (domain->flags & PD_IOMMUV2_MASK) {
-		u64 gcr3 = iommu_virt_to_phys(domain->gcr3_tbl);
-		u64 glx  = domain->glx;
+	if (gcr3_info && gcr3_info->gcr3_tbl) {
+		u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+		u64 glx  = gcr3_info->glx;
 		u64 tmp;
 
 		pte_root |= DTE_FLAG_GV;
@@ -1869,7 +1877,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
 		}
 
-		if (domain->flags & PD_GIOV_MASK)
+		/* GIOV is supported with V2 page table mode only */
+		if (pdom_is_v2_pgtbl_mode(domain))
 			pte_root |= DTE_FLAG_GIOV;
 	}
 
@@ -1926,14 +1935,14 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	/* Init GCR3 table and update device table */
 	if (domain->pd_mode == PD_MODE_V2) {
 		/* By default, setup GCR3 table to support single PASID */
-		ret = setup_gcr3_table(dev_data->domain, 1);
+		ret = setup_gcr3_table(&dev_data->gcr3_info, iommu, 1);
 		if (ret)
 			return ret;
 
 		ret = update_gcr3(dev_data, 0,
 				  iommu_virt_to_phys(domain->iop.pgd), true);
 		if (ret) {
-			free_gcr3_table(dev_data->domain);
+			free_gcr3_table(&dev_data->gcr3_info);
 			return ret;
 		}
 	}
@@ -1955,7 +1964,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* Clear GCR3 table */
 	if (domain->pd_mode == PD_MODE_V2) {
 		update_gcr3(dev_data, 0, 0, false);
-		free_gcr3_table(dev_data->domain);
+		free_gcr3_table(&dev_data->gcr3_info);
 	}
 
 	/* Update data structures */
-- 
2.31.1

