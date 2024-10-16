Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1518E363
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055937; cv=fail; b=Aqc6nmsXw9TNfc8b6S7eCG90egaufXMKqNd/q9vseMWwafH7Mkx5r9p9FoUD2AyqUEvfKaZg4J6l4RjdIuPWcUs85F5Nqardt4VkeqE2HQugcjjbJemrHgRXYD6fiJ3//rsqEjNKS5+9/i/QGGr4rawF3ygsqldbsf3acccIz28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055937; c=relaxed/simple;
	bh=McLxg333Pw2lYiK74LGvDRaf3ieSOUFepyRa5zVmqzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APIZ4l6N4gAvyCH7SjfCw8ortmy6rD5wbavwW58s2G7h7meb0NBfrk9VvMdj/EXDpEpHSD2TisUBc+/JDMmpHJ5XtOimHUQAm8fMY2Qk6N3VNYLkRzyNJ6jhgqIkeBf7q9Rvu5yqwFj9IDBXQEOqCVJXyKns9ys62FYrZ8Jfz/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=anuVzvsU; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="anuVzvsU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7eoZYpBcoCGvb7soCGKEyAHYM/vmxsNaTtEi/GjkhLB0hacqFXI57JkeIhce+4LFSERrNt/fU8iVm+DXH3NiRC0BygKGv9NZjGqiKO3b9n077xv5S+qPPcXCwA9/q0OMzqUDUCRXlG9mBa3eehycxAhzypXlVzVNBOA036UoYuwcApEF1ytI3TQ347rFmkamsKPZEflOLE4mAHgsPYkhJ8Y4REXwKTMQEV2TJmeK2e2b4zfelwJ6Rybypmjtu9d/OTf4M7jXgLJXGYj6zNe3hnfYuucQewwG5LXqSd43rvzotgPwdDB3suAfS2vVcijOJhQX1p/5KXP6SyMlT7ctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRQpXoFHV0ra4G9V6vK8zu+jhnePsGhksSN/iwb8CJg=;
 b=h04ObGYru15mCrjzis5i/CFruwRUJCwSpVrj2ZR6GOrhWI5yHReuMA1yfSX+My8Mn2cVjp8Wsuf9Q/1vCEu3jkpasSDTkA4qvl/7JZGJtL2Mym8YxA6VpjV7Al+hRAlYloZ7ZCg25YAOV8F/huX43bFvAeKTyKo5WYkCntTXTIaGj1stncr5sRHXbWndRs4/W5zb8rZDbgYH3se1wWryJ/wFydZ1kllFtAQbqTEkghyydAwpHiDsrbWFiU4Ai8OPZUmB3fEm0wOUmQ5gwXR361SlMPRgmNeFxqm5jwDvMYPwyGp7MZf0Bf/6TmuAZx0+wdB4honwFz/MIw+b5sv6Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRQpXoFHV0ra4G9V6vK8zu+jhnePsGhksSN/iwb8CJg=;
 b=anuVzvsUApdq+vVis+hEUOPtjThquymPmY0HaSlaGPzwdFTP/3yQWsy7G0H+r4Al/I3JUIwDRX2CmS31ANVfFLfKwIiBQpBhc2Gnf1wYAEf8d7k6H43CXtq0G5nz+DOT0pGWNkqzNeEhmS08IV3B8ONCmpfvilmSGhDqhtwdTdc=
Received: from SA9PR10CA0023.namprd10.prod.outlook.com (2603:10b6:806:a7::28)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 05:18:51 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::c2) by SA9PR10CA0023.outlook.office365.com
 (2603:10b6:806:a7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Wed, 16 Oct 2024 05:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:18:51 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:18:46 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 9/9] iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()
Date: Wed, 16 Oct 2024 05:17:56 +0000
Message-ID: <20241016051756.4317-10-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: f547ddb4-2577-47b4-080b-08dceda2057a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VO7qRbL3fcilIHgeZmD91zG6yazhqWYOx93x7/dyjNjd4MtdvdPnkhG0ZQkj?=
 =?us-ascii?Q?m51FwSw4qMl29YjRdhzzipEB26XU8F9Q6cWVI/q16pxyTPdSjR264DwNa/f2?=
 =?us-ascii?Q?bDGyPbpf5Ku+rgid0aieovUfNqJsg4KbTa4hyk8W0glKQNjSISNm/KYE1lMO?=
 =?us-ascii?Q?pcPVQc1iYiL57N9XBwavNgTZLRkDm8intbou7PIbobUlb/yigrCa5/uRyXuJ?=
 =?us-ascii?Q?aWwVHka3dngFOQx1Oir8rob4AszKVScXRYzxctxprQE/cv3St4nTNy7/WoWO?=
 =?us-ascii?Q?3RDRPlPTUUxxaCyGP1WY1Zm8df5ITgLYyj1/IXRZUbvkTLJyJDkSiiB4MBa/?=
 =?us-ascii?Q?raYdM0mIWMYnhjGfAXDJimLJiexX1y8HazTxQ2I9uwJeINyBGlh+9llYpm4L?=
 =?us-ascii?Q?A65Excn/quMl8Jfk/erPbglt3lgvSapT96QTSLS3xYoYNft3DFXAemdIweEU?=
 =?us-ascii?Q?0v2ZdRnbyRe45Abk3VRMMvtiSh5CjYOlCyX02YOplnDOZIS8ZX5OexLL7a+M?=
 =?us-ascii?Q?HjNAvlCLmxv2L0XceQ8/1p4gwEeG6BtleXAkET6ig5NKko+ap8XWAah3At8s?=
 =?us-ascii?Q?NgD76/RqWmY9/MvEWZYIrssyRiapAQEo+E3Y0k06DfPyGYwaWdQeC16lpyDH?=
 =?us-ascii?Q?Ib7C9l8brHRSYHPh9IwZ9tGhPe8OrobEUTY82H2EbecmwahhF6O8paBVdt1X?=
 =?us-ascii?Q?0atjMkdQsNEGuj0JXnZ1ww+8jO02yoo3otyjfWlHDwueJTXvM4hC+njRJbsu?=
 =?us-ascii?Q?Z2FRKd9Vw/DhP45SWBei2XJRFGH55xFRdPuj+qRGZLLWXGrhAHLbji6P2BDq?=
 =?us-ascii?Q?hE4oI/geX9uF1V+zEZbpgE0MI8KvC+b4qzk0UiqXL+Bb/yTZB3VqpSAZANR0?=
 =?us-ascii?Q?EnJ+YRefFv7DV4m6CTnj4ZovhXX8DyxRVPK9tpIgMgEy0NDEpGxlJr8lRcGH?=
 =?us-ascii?Q?RBekBzEI52Vyu6ZZwoe+FDf/irrWCYg/EBns28e3AILwWlm4EWLEDuZpxGjt?=
 =?us-ascii?Q?IWhOUpZjFupbXK2KKldg5zIy6U3XShgX2UiqeZiinTSL/EOOz/pBJjcseDv6?=
 =?us-ascii?Q?fLRGt6fHBWNbC5kg7HJ4d+5eM/ge88jOU89VTK9AYaNbiqDA90CW+0qJwrJM?=
 =?us-ascii?Q?i+B/mwoVnY+ozvoTUCnCw+J7eRha82PWHUXk5PYuV6Rk3magInZ9xvDjBdFQ?=
 =?us-ascii?Q?PX0HSk99ktn0EpKEvXq6c4qEm0RBB42Wm3i9nSytEO9XfZVubxDbriLjIhQp?=
 =?us-ascii?Q?K1/QXEFmP5PGdhokVVBt51cH94RTZv0HhCkBI4GZupCfOXidE03mYrfOGJBd?=
 =?us-ascii?Q?MFdUodgVoLGe7ZLf/DKtySTp43WEqLJzVA1j/HpkWTv8/1b527da57A3/81I?=
 =?us-ascii?Q?UzxvPh3PiR7md4XktKyAu30ZwNn6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:18:51.1198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f547ddb4-2577-47b4-080b-08dceda2057a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188

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
index 1467bfc34fdf..23b9e92cc33b 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -178,3 +178,4 @@ struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 #endif
 
 struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid);
+struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9ef6ddae3b66..caea101df7b9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -331,7 +331,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 	return dev_data;
 }
 
-static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
+struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
 	struct llist_node *node;
@@ -2787,12 +2787,12 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
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
@@ -2801,16 +2801,15 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
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
@@ -3075,17 +3074,23 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
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

