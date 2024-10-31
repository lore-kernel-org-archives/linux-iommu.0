Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F095197A88
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366241; cv=fail; b=ndsACzjGQtbgQmIYT43uqAm4ULGZzcD05nvCbSSTuBsbaDCuE55/z0vZTm2oQBqIkZ9Alp7FQRxut3zRjX8FarY+MUrOiM7E9glBxBZfIfxYnlqg1s1Mo+GTdLIzqWywoygZ18QF36BgmPzfDa4DJFF1VExLZUE/MZPjl2BOCSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366241; c=relaxed/simple;
	bh=UyEDKP88toYK/nbO11G/dr2DYFUAt9gaM+62LeGfsS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XDXfaAoO/hfuqxKp6qEddXWIWSiooqIJYfodl7waR0sZ4PvxRcpruo5e4acvUq5yNGavpSh7Enl1VO+2BkQ0ob+ULYhz+pIe3NE2G5DrFQNvyZnb3xZ26pRLp2mCmP62VB4P2SNgtTmb4FjsqmlLjGuhUkCgMziBQch++lE//Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OE6T9J5K; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OE6T9J5K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYuug2+plUWvmba9aXEZ8Q0reQuenRS9h2COl82TyoXpbu3dlwpWUcS3g5L+YCFhAj1HtpdbUTfmfievazKoi7ZTaW34EWZfrLLUc0f9ACTHq4RcATMtHm2wCqqBSKutOAUEBknbcauhcGO+ban9+fSG0VgMrEPp7Vv6p2tIKvFrkQogmAqG9xltJqjhkTcYMvVKUQTK2QZYp1sr1b6eIPx7pUl2vSjWu/hxCdLCciCKAu9sSdMkWmskTsA8qomlr4Zzyllbz+StoAliHxuHyL9TW/gu8Ek72Qg5URY8trmnZ/KHjNFbe41LTHNX1pEwxtSBlTkcAB7eKAzN9DoFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg6FO3HYh8ssK5OECx8B2mzekZ17jc2imAZ8nPh3Zxs=;
 b=RkpfS3ngk4qALjawwCojqQOW1vGBjlQCI21ebb+ce+/nnSlBgkAqsl+6gryMFGRiCWwfDZqILhqMENXEFtXmGhxobI7MehBSeApnx7RQEC7aFmAcAT8K077DX+FH/KnkmR4wI6ndEEERq5N1na6C7x4PlXZGzPLQwxHCu55HSi7CzFJ96rvUK/jvMikSXh0oHbX86co0r06sJrLgxVNvR85eyYxzOsFAp+1ES5Ll7v3pud5yhZ27F7yPmSKxSNnahOQlpU7Oev8yUhoqMlJY0Z15wlxtUIAX4WEbFyDJD3Ho5VAyz4KMAYQ1hUuQP1gYSTjw4YMyvv1vjHxtZjGd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg6FO3HYh8ssK5OECx8B2mzekZ17jc2imAZ8nPh3Zxs=;
 b=OE6T9J5KA6axCvNi6hUmalvbFFAeE9Jpdp4wvfSd3iLY/svUhDA+QM+foQDwBd1XEAyGMytmnn5YPw4VkP6zE4UN1iz7pxJs5l6z3Y5EikaamYv598fr47lD8y2fR2mEtq2+W3v2ieD3PKo12W5V7ia+sKX6yc2TwLkfFDWTaj8=
Received: from MW4PR04CA0069.namprd04.prod.outlook.com (2603:10b6:303:6b::14)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 09:17:15 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::20) by MW4PR04CA0069.outlook.office365.com
 (2603:10b6:303:6b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 09:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 09:17:15 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 04:17:11 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v7 09/10] iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()
Date: Thu, 31 Oct 2024 09:16:23 +0000
Message-ID: <20241031091624.4895-10-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
References: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7ffd96-ee07-496c-f286-08dcf98ccf80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zrphaez3iUSyJgpru3Opeibm8Zueht8opbreMEMia32blQ7PxC3rBs/Hmaj7?=
 =?us-ascii?Q?24M3Di+5Jgj/fZvg+iATgjjHYZ0+EFmW2uGiWl7QwhBVXrHAitdlQDRGsyvl?=
 =?us-ascii?Q?B7KCUH6LgkQBw3fOh/P0tR1Fgv2dFUWKKC1yUeYXmIy3TfVOHLpWPWeaUn9h?=
 =?us-ascii?Q?Go4QthoRJPyD7EFvgbfpSsWO6+a6/ZQX8GPIjQ0FzHPFxxZSoUuORx+U1VMA?=
 =?us-ascii?Q?DHXLZPPJFg6XuQVgSSlHvFYHdIleYK4f3qqv0YokVeWWaLqsEc22mjHRsL60?=
 =?us-ascii?Q?CgSOFW1suDdXKke7zXGYbKwDpZeWusz/R0/l1hOTUMHAqpr5iLnYcqrVINzZ?=
 =?us-ascii?Q?2qkO2AmOERb6t1t4Ru8nSmVe6IH3ddgBFuJdTdNKYh3PihKpoT+NWDBijYYS?=
 =?us-ascii?Q?RU/6mkcxRObb0UIqBB1fHFx+xScOxFhAJw+zL53ditkCCNjcwI7588WsHbVw?=
 =?us-ascii?Q?HTf/vutIGIaR7PK8PMbzVDoinsmgmqyP81a7Kxvhn3qgQRGwq2mlh7jwjPji?=
 =?us-ascii?Q?fElDt/he1qNA9JD3FM8NyBBgGSjgSWB5oltFq1l4rSOMNRb6Ag6Vt53hoV0x?=
 =?us-ascii?Q?1agUVSAgG8P3yPaveDx0ewURXWjlJxhRV0xZ+sxWBzVsZDYlWk3/tWHB0fbw?=
 =?us-ascii?Q?XmnzLaLk+HLPEcMNghu0Aeo2Ac/B3IGXllvNf5DVyretemzcAwnkQGUNCWTQ?=
 =?us-ascii?Q?2DWQQO+hbcS83zjs7q5SndyDeNy4ZwEGCEJaGV6ZgZLC8sJuRSMBbjXMp6Fo?=
 =?us-ascii?Q?UD8Jr8IHvPGDA5WxwmdegKNLcG3Ai67OF67LHI4D4Eaufp6VwFNKD31vjtwm?=
 =?us-ascii?Q?MHRI3lb5RPiphbW590oY0K9N/xYoh6iQfNRCM74e36G6utsKipMswvHjYF/d?=
 =?us-ascii?Q?z1TCvGgSaDBJ/JCYRA6ZDPl1dkw/LBYKJH1awCSInaYzim89iDctk/m2ylfC?=
 =?us-ascii?Q?vM5vywP8hHr686mLoZZlONwea2oPXxVHOsAdc35gVsM0f6LXqUy47T6m4GSd?=
 =?us-ascii?Q?KSJ0HuascxRY2++5u4iesvHoPgdMZbVCYdW2SAxQLGIFX0pOp3rotVfMqiSp?=
 =?us-ascii?Q?3BKk64QiNQRH5ob2J5GxzmvwIGiZlko/yU3zOigYjzpjpRQ2R81ue83m8MFm?=
 =?us-ascii?Q?kw7J6N00JOFP61AYpPJxlB3BEn2IzCj2wuU6tBJpFAlp4HU8u3HARXOxDVVz?=
 =?us-ascii?Q?AImxZOP71SRbU1WKTMXi14qyR6E0W7fi06UDoZ+xukIK6GVrcQ3dDb+bzv6f?=
 =?us-ascii?Q?Ed4D1ij8jJSffIi9OhVYOyWV6A0eVq3Fgi5uae1InE7wybAzGMdrrW2+E4vd?=
 =?us-ascii?Q?V95DTjzP5ZO3W9o+B4FoGLUTnHpYGgspPjizKegQXc2aESGVoHa5iX392okW?=
 =?us-ascii?Q?xpKZVwVUptOPhNjzfYaM008waKJHDiIf2BlizvsZS5GiZVwZAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:17:15.0121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7ffd96-ee07-496c-f286-08dcf98ccf80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057

When updating only within a 64-bit tuple of a DTE, just lock the DTE and
use WRITE_ONCE() because it is writing to memory read back by HW.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 43 +++++++++++++++++++----------------
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 35d1e40930a5..bfc61f7ed923 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -179,3 +179,4 @@ struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 #endif
 
 struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 devid);
+struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b71fb22d001a..9459695bdc12 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -333,7 +333,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 	return dev_data;
 }
 
-static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
+struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
 	struct llist_node *node;
@@ -2791,12 +2791,12 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 					bool enable)
 {
 	struct protection_domain *pdomain = to_pdomain(domain);
-	struct dev_table_entry *dev_table;
+	struct dev_table_entry *dte;
 	struct iommu_dev_data *dev_data;
 	bool domain_flush = false;
 	struct amd_iommu *iommu;
 	unsigned long flags;
-	u64 pte_root;
+	u64 new;
 
 	spin_lock_irqsave(&pdomain->lock, flags);
 	if (!(pdomain->dirty_tracking ^ enable)) {
@@ -2805,16 +2805,15 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	}
 
 	list_for_each_entry(dev_data, &pdomain->dev_list, list) {
+		spin_lock(&dev_data->dte_lock);
 		iommu = get_amd_iommu_from_dev_data(dev_data);
-
-		dev_table = get_dev_table(iommu);
-		pte_root = dev_table[dev_data->devid].data[0];
-
-		pte_root = (enable ? pte_root | DTE_FLAG_HAD :
-				     pte_root & ~DTE_FLAG_HAD);
+		dte = &get_dev_table(iommu)[dev_data->devid];
+		new = READ_ONCE(dte->data[0]);
+		new = (enable ? new | DTE_FLAG_HAD : new & ~DTE_FLAG_HAD);
+		WRITE_ONCE(dte->data[0], new);
+		spin_unlock(&dev_data->dte_lock);
 
 		/* Flush device DTE */
-		dev_table[dev_data->devid].data[0] = pte_root;
 		device_flush_dte(dev_data);
 		domain_flush = true;
 	}
@@ -3079,17 +3078,23 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 			      struct irq_remap_table *table)
 {
-	u64 dte;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	u64 new;
+	struct dev_table_entry *dte = &get_dev_table(iommu)[devid];
+	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
+
+	if (dev_data)
+		spin_lock(&dev_data->dte_lock);
 
-	dte	= dev_table[devid].data[2];
-	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
-	dte	|= iommu_virt_to_phys(table->table);
-	dte	|= DTE_IRQ_REMAP_INTCTL;
-	dte	|= DTE_INTTABLEN;
-	dte	|= DTE_IRQ_REMAP_ENABLE;
+	new = READ_ONCE(dte->data[2]);
+	new &= ~DTE_IRQ_PHYS_ADDR_MASK;
+	new |= iommu_virt_to_phys(table->table);
+	new |= DTE_IRQ_REMAP_INTCTL;
+	new |= DTE_INTTABLEN;
+	new |= DTE_IRQ_REMAP_ENABLE;
+	WRITE_ONCE(dte->data[2], new);
 
-	dev_table[devid].data[2] = dte;
+	if (dev_data)
+		spin_unlock(&dev_data->dte_lock);
 }
 
 static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
-- 
2.34.1

