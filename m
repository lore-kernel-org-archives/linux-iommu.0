Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A78A33CCD
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185091; cv=fail; b=BfSTb4bfbk0+KgAn9dedQTwwrc0j3XU2cHaJDS3aG1LK0FketMWLXuqdH6QknQXeB8+tjQLdtgicocAifET0lOzd7sf3I6Su+gk/CAihLlkKLau+Pvs/h2mHWw2vCt8xKgzxB3E8dsEw7MxeoOg/ja0lpRR8hHHUAM83Tm0aCSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185091; c=relaxed/simple;
	bh=jk2jpj7nifKfIgmwDKCwnIGWjGB7iU0QfQe357o0jOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VliWWsWFiRHXwsuCfiirpnp5K4KzBIj08GtTROskpDGINtzdLqkydwrBi4ceDyhH1N7AwQmCIAuOyI31S4zgwZcMNGuyeXN7zNsGNiRSGb2iRV+xdVxXjo0mnvcZy76KbLKdN/ea1eb1SLnvP2Fp701Gst7kPLIsTZaCjENEqv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CkJiHVuO; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CkJiHVuO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSgIBA9zMrKXdEITyzcltJvwiHxU9trkbnysTkaBpRh3UXcuL/umSZyDBrpmZIVCZeMNjh4woZc3llD4yqUHVF4kco0nQFn1io7Q0Pq+KLzVD06VLvVZSBff2dUiAm9apTv6V+KkIQ8Cs/U42vIhlld1/vI/Hxy933j9FnQdXTcY5CZ039v9NDAyaYKeleOH4msrbcVKU9fyMjDvFdjGN/vf3CApTJjbqFtE7Y/fJ+ajqIuHreVSUMw+M19qG7PGAT6pJRwgmZbLg9jqRL4fQgl4jyzH2Ipbxq6UzZzJWaIb6BtoSn7C5nBIFiFlPkpceQuSTSYdd2/Ip07qVIAhSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ztZ/m9+F9LaVO7LJhk77B/ykg/R/VD7JSnjAwu31vo=;
 b=VbORG760pVsD5aMcLUQ7D4t+RpTJSrFIj3BD+2y5IbCo6X+UR6EYxQYKDSzqyGPLxsVlUtJCslgUrnZBRkpFVCxHE8WLrqc8Yj9WublCVlX2b9HXN8ANtO29fJlWuukz5p/Wc1TPWBszDb9Ayn/8Y7dJngnh21zANzmrBQAn1kDMA9cSwy1G1JtVsV41tK1sjCnqXdLxKTW+FiOyoD83u22LmyGC1mX73ew7Qxx4pY5aUluC8vtRLqDEQtTgOD4oOzhLXMfPDdcZoFffmRuH8ZhU4zdH7fIKJ/MPosdBxuRA4gpt8B8Qgxe/P/5u4ZbRQJiTgZkDFVM3J2JIofxBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ztZ/m9+F9LaVO7LJhk77B/ykg/R/VD7JSnjAwu31vo=;
 b=CkJiHVuOORlOjNGIsEDGh/MyEJi0qvMwyVyesn8LmvyJa9Tinediy/GQxpjDyrTBI0/H+o62F36WO6NIyQlFLJiZHbzLPooUD+NcA1SkA0+tkN4jtYZeol8ZUI1Nx6L3T1bZBWCxGx46LeM9hqMLa7Ii6238LZFin5JxHiEcYo8=
Received: from SJ0P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::18)
 by SA3PR12MB9200.namprd12.prod.outlook.com (2603:10b6:806:39c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 12:18:05 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::72) by SJ0P220CA0027.outlook.office365.com
 (2603:10b6:a03:41b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Thu, 25 Jan 2024 12:18:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 12:18:04 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:17:58 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 13/17] iommu/amd: Refactor GCR3 table helper functions
Date: Thu, 25 Jan 2024 12:11:31 +0000
Message-ID: <20240125121135.8217-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125121135.8217-1-vasant.hegde@amd.com>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SA3PR12MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: fcad4599-d9f4-4b7d-a7a5-08dc1d9faeaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zpzljtl0ItZ0I04vf47DLJq9+d+Ru1XkU95mOz0NNdOyf1FXuW7nryuPU+LxvnSrRkx7NuVqOLxEYlmW41ULVJBBvbYNnjfniDqG5ceqNQfw/58H2AWBjoubmUgBu0na3jXj1swLz221dzZFoxPJ3oCNYOPu35L8Xm6Ir1nea7b7wLZgdGVEySSGfnG/q0J9DcWb11Bud7VdXIqInTgtqtSvhT07uKGzh0M/9S4EVarXNA8jn+Ixk9okkeW/bxFzWzHe3VZnunf2ef21pebfnHqzj520Hg7HzbwE9R79RHxToOjJBkdxxUNlXB+DCy6vezOxWZgLB3K3ZEQgbcRtQOLwXEWgNYw0Dqwr2TQvo53fDPY2JOdxXpnBEZu5Y9qeVFQk3gkUJbqa0exsn3u6Eh1AdLdU9x58Q//Wk1GebfUYNBh90No4rHPSsVdXiU0Gf2pVgeJGFmmVuCtKuJdOT4VT5AZ0gA7p1f5kXn7EH3MWfMLkKZ80LgvLPPdsDABmqqn4Od2gfDjIa//uLC/tLCU/S2POBOQB0BMxVvQCbTr7qQ8gqnfxTshzp/5RBzdYbayKhmGExydQpqkSlosFJXcsCBkG3flB9uYe3NQ4pelI5ArVesSezX7xiSuQJ9f7CYgOcmPpvPcJZcfIC2Okj51b31Rdro3wKdztgRjvHgh0YnF/hFtUE5Vy7U/STIqOV147XZ+jL0lsrBFwhyhIl/FSNSatx4Xv+ZSjugweZ2+X/q99jSBM6Yow7Nr0HeojTwYXfI29M4kYlj6K+wae8w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(83380400001)(41300700001)(47076005)(16526019)(336012)(426003)(26005)(2616005)(1076003)(81166007)(82740400003)(356005)(36860700001)(8936002)(4326008)(5660300002)(8676002)(478600001)(44832011)(2906002)(7696005)(6666004)(54906003)(70586007)(316002)(70206006)(110136005)(86362001)(36756003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:18:04.5333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcad4599-d9f4-4b7d-a7a5-08dc1d9faeaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9200

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To use the new per-device struct gcr3_tbl_info. Use GFP_KERNEL flag
instead of GFP_ATOMIC for GCR3 table allocation. Also modify
set_dte_entry() to use new per device GCR3 table.

Also in free_gcr3_table() path replace BUG_ON with WARN_ON_ONCE().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 53 +++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9a78972fa8a7..dd86a681099c 100644
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
@@ -1810,6 +1817,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	u16 devid = dev_data->devid;
 	struct protection_domain *domain = dev_data->domain;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
 		pte_root = iommu_virt_to_phys(domain->iop.root);
@@ -1837,9 +1845,9 @@ static void set_dte_entry(struct amd_iommu *iommu,
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
@@ -1867,7 +1875,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
 		}
 
-		if (domain->flags & PD_GIOV_MASK)
+		/* GIOV is supported with V2 page table mode only */
+		if (pdom_is_v2_pgtbl_mode(domain))
 			pte_root |= DTE_FLAG_GIOV;
 	}
 
@@ -1924,14 +1933,14 @@ static int do_attach(struct iommu_dev_data *dev_data,
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
@@ -1953,7 +1962,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* Clear GCR3 table */
 	if (domain->pd_mode == PD_MODE_V2) {
 		update_gcr3(dev_data, 0, 0, false);
-		free_gcr3_table(dev_data->domain);
+		free_gcr3_table(&dev_data->gcr3_info);
 	}
 
 	/* Update data structures */
-- 
2.31.1

