Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA021CEE91
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478240; cv=fail; b=u2EowIL8A6CXXUpiNjsVZLB+tu2XZOs9QolxiwZm60maXMuuEITQO1LfAe8/tuH3pLCU7JogNrw9qg7QfkkToh/Y8US5OLdNtcq2EeSiPQXehtBNW7sVAZkdIPXPZs6ibjvVeQd/+zJ9OHOD+vaYs6U0pao8krIxhlaKeemRqd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478240; c=relaxed/simple;
	bh=FfAzNctd+sDX6/EB3BGFbJYSJWDZTp6Up7+xd79Z1x0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8PWKyZgqTLMWnJ4wGv1FpigcLA5F6vYdxG/UmIQetsSknUgsEzJ8UgxvUMze1CcYwl7CwZABQnpI4Y56QxUFuywTj9WidLPziQkwps4BXHsi6GncL5izs0uZmQGZClauliC4cVw069U+Pgs+18ZJlcjQSwo3e0zxbKbhYRHct0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YrVzN+Z4; arc=fail smtp.client-ip=40.107.95.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YrVzN+Z4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtysqdkUKGmfG8pzxXG3glcd6juybjdD+KMxVGoTgqIwgtDKuAigaoT4+vXY0MqYBusterA9iXzhUEoargW+Rl9nHiBrYpcu1LAYKh8VbTU5dICArWRy/KKBm87rNurRZJfFOI09Mk02HjGVbhuoudTsUr1oYtNZ3/hTD5aaF3VeW62sprJY2GgMPQ2bnZrSNxY87GsGI5u6jqiVi3xKM+HoEdQOw8AV8UZTvQDT5XpxhPJ5oiC6FGlrw2fqzlZvJKKVJcdXUsH9SIxjrRTuDwg9AFkkMsRD7O9q4HAlwlp4hi9sjf+5r6UXt7+EV4HtNvvCi/IAz/T1x2xYnS6lMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFaYk8skvinWoau3hkwrRvgny9+I159yfwvR9xM6/nU=;
 b=C44KhMcoaSvSLqEAOaVIOTzZP79l+jGpv+FHG+bsW+1Luyloorp9WRXOdmPRqo9IXzMqBN1+y7xID0bxagk3xwTGJ1yy6zdfesHJPtzImvGL/2VWceTi8YWaKfYWZHlaCdYqmEPjjLT7MX0Z2BtCpImHG2M3sWXDyl1habHIGQ7LmWIqcGtN06XoToYdbfSRu6oHj1IwE1QSV2gh/niUHWHDSOIdi40EdrAt14NurjkbCyEYoYCgfqoi07v5NaLn2TMtNxzjg9Bw+fsEHrZQytjonbkl73LZ2lhlMduMJArBgO5Kqv/YqXZLNM2lg0g5raLWHCE5Dp5b9ub0hJw6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFaYk8skvinWoau3hkwrRvgny9+I159yfwvR9xM6/nU=;
 b=YrVzN+Z4m6QAeBDjcaDyqdY6Ke3k8hGzok/auvb0SnahcsjiZ+lw8LpC9LrNeGoTJ70KjoDmN/kTYkHtfHlQ/8NWgY04WX21KhGeKPN1UvKYJj46a6kswQx0twxUF5cEeHLJhXiZ1MWdEmLkF3ijPEx+ftUJlQRqovoPG9o+iAw=
Received: from MW4PR03CA0188.namprd03.prod.outlook.com (2603:10b6:303:b8::13)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 16:23:55 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:303:b8:cafe::b1) by MW4PR03CA0188.outlook.office365.com
 (2603:10b6:303:b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32 via Frontend
 Transport; Fri, 1 Nov 2024 16:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 16:23:55 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 11:23:51 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v9 09/10] iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()
Date: Fri, 1 Nov 2024 16:23:03 +0000
Message-ID: <20241101162304.4688-10-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bb45f1-1d0e-4a01-9244-08dcfa9194e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e7wQiDAIzwYFpYJPAxxwStNKbYG3oM/EkuTBvUuzsKNOMEWyu6Z6Jb227+UC?=
 =?us-ascii?Q?IjNmfTUqut195Kde8anD7ALpv/LV4vOhaurR5yD2UfbQVj9uB0fGwYKjsREW?=
 =?us-ascii?Q?jzu1WuvModWJ3e3EjavXB9bnWDpb/MZ0yk3FIZFydxVaHhOxqVQlXJkOrCRm?=
 =?us-ascii?Q?CYOMaUEkt3x5Qk+k8HT6S25khslmtEbwopB4lJMfzzW1tjlTka34G1BAZ1J+?=
 =?us-ascii?Q?BhYT0gacUF1hNarfUiZEiVeSqrDNfNQfhz4LLIzbPKIWpkvAl26xlQ3mifDE?=
 =?us-ascii?Q?K2DXBfxG30p+4qR49GSUYMjKI0USmMp1z4sClzb4WrCsBLgdHUo1JUkcN8LR?=
 =?us-ascii?Q?PHZ2cTiKwGZA4BwFGmnonymMFXFAMy8VAYA3gusUI7QEFeXWu60kWJZqmwuQ?=
 =?us-ascii?Q?W51MWUsXT5oQpFVMTol780FpHUAbztztEFZMBrhgcL/AotCe55DOur81jPz5?=
 =?us-ascii?Q?Fk93hN8Xv/FueoDAjTFxfg8EH6Mc5YzxaXs6id6Z4uFsC6y3GO9vmtp2lgHP?=
 =?us-ascii?Q?PsZUC6dqyr18NsjM38vqUohaYNQydy8QO+7EaqDAJ6T4SJHsUqXNOaKfehJJ?=
 =?us-ascii?Q?wTVdOg4NDdLO1GxawZMNkaHR2HPP9DZQecwmXLMbkcPEY4s9DC8LWoXpIXyz?=
 =?us-ascii?Q?duK/3jXTR7LEwMta2UuJXkngaNwYwNR5HCrQNBDzgwuqB4uiV2Njr34PjR1a?=
 =?us-ascii?Q?Y2nR2fqh898E+4mS+Sh99NmimmopbNVEv4uGjYvStM/8VC7mdPbqOz95T6rc?=
 =?us-ascii?Q?GYU0SYGEOEtOwEPaGmief8CMB+/j7bRDrquEUOyPUqjdmJOMXva3ER/KkJ3i?=
 =?us-ascii?Q?UtC1C1+ajgBFPe5akiLoH/+vvCWuVbKDYF01IETMDtw321JKcn4IkP/0kTrw?=
 =?us-ascii?Q?mNuEDOiUINr/uPrAYcH2jU/gWEGQM9Jap24U17h3Nm6DxP3uolRPxfKODxWV?=
 =?us-ascii?Q?pD25/u3JZi5s6XgMK3XLJZw2nOMjApkyQskYmUmLmWGiDhKAoG4ojoDzcFZW?=
 =?us-ascii?Q?r7+F8DsFsHD6fRr8b6AK6b75jSkUWU7vL9a4ELiMbfBnkTefhIT2zo7nR8gO?=
 =?us-ascii?Q?vaIHFnjd5+AtLKiuTCCN0XV4H/IVkz0fERyvWvENtTd8cfrb3wwDCCo9ANSA?=
 =?us-ascii?Q?rh21wKpDBRV/ypmfuyMVXrZnem276W9xGDu4KIY3h5OvHI9fL9yhSMaYRlFh?=
 =?us-ascii?Q?28IMuwbMrYSB4uO/CvPprL+z+B7TC0Ewd6YQUbVXWthJcsXZehR+TdVrpuV9?=
 =?us-ascii?Q?Y9y8E1YuQR+OOdPKtAQlz8jIxx92ConEoC52cwERfA11gJHcH6OBjZ3q4m2i?=
 =?us-ascii?Q?iu8r/h7iuFJfo136gjpuP7VkFoHRuzhEWbTovLFJ9iCmXDYN0JBy/Rb4yY7G?=
 =?us-ascii?Q?LeMKmXqC5gRkkHIHbEu2fW49iPPp3M8ZxpGPCZdMHa3WkU6UfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:23:55.3908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bb45f1-1d0e-4a01-9244-08dcfa9194e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320

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
index f9260bb8fc85..7b43894f6b90 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -185,3 +185,4 @@ struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 #endif
 
 struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid);
+struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0a7287c41cf4..50b98b62936f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -339,7 +339,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 	return dev_data;
 }
 
-static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
+struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
 	struct llist_node *node;
@@ -2830,12 +2830,12 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
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
@@ -2844,16 +2844,15 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
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
@@ -3120,17 +3119,23 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
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

