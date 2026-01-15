Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D492D8768
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457354; cv=fail; b=MVlr5GC0g+bgLhFaKCHpIWW7XMGDfR3fgo8kwL6dMEHe/hc6DUi95I3tDGgee8eAbjev/VWLXxyqf0iUbyKVMTKbXmKed1i3K2LhN3qj4bht6qOr36B8lte6s85B53/u8qt0Qo4D4yUHKA9QgVApv5vsVRmQhmDWN0WbPLKrYRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457354; c=relaxed/simple;
	bh=5WSoV3chfxnDvqnQyV0aEZGsj/JxeduOCr9U+LdSzhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMQT9SP/hit6ZWEYuLNpMp1zVkViKwqAFIngWKs94ZcPA57zNQGTkUZFqInCDtyJNDJgoVC02mpLapIHUqgP2oZr7Na6BGLjTALAqLdmAXzE4ucaqa1q8ZMZYCVi57tyhnweyujrhWGktnwP3Tj6Df+j2uhXn2CGcj8WTnheQlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oToLpwDu; arc=fail smtp.client-ip=52.101.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oToLpwDu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTyDaD3igIvnElZA5OT+w9VYOckxVCQ/ug05t7We8fTWeICgjYZtm6GW7Z4q9ZK67v9x5ACQqj7fuMhTK+u+G2n+Em3iT1N9xoYtu9QHw0VlGAQmv5vPdP4nlFT44FDgw1WCf/lPCHBLgAOkm15t2bSxUHfNPk9AMK8/QtNkWKxSGUn81MIcJCvwaNQ7mGxzLbJMkTokpPs/uwUQnL9yegqkiXRvKAmDJH02aqfnhKJ7x5OrbThVqcLKKeacAfF/w3SxWNg9PvYsyAV1H0lRPvBv60WdC2mTT25a6O4O9UqTwOTBjmWEufhF6nxNlKPQeaizwvXb6+4ejfnoBADiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f80J25Etcv17vI0fnNgG09jgF+b1b5pgYZHoPcIxZn4=;
 b=vb8RfDcEIgVb6UEkzDLIaiqXr94roUYxguayZBNWklBmTV3ntigmWPu2HZFJmE96ddRHs3QmkPgCNjZ7BC1rWSpiSMGxh6SRJcxOh5yx2CJtrNlhMIlAZklIWLnDsfqtf+6BjQbm141yqVvrY8vsAisxgCY+o5OmS6JgCPhulavwgL6f/GPZ8rcRvwmcXvSoKSVWP2/1b4cwqBm6W5hAVMU9txQ7ecyIQslXld9v2daJqDgP1mYMVBU54+T7/UQYtBMIED4858gwr+PHhASbTwbjlW7IMbC3B3gVKdJZELuX8aN/Zzbq+Iw6FDYGFWFCGHrJLcMS2Q9/Z46D2RrTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f80J25Etcv17vI0fnNgG09jgF+b1b5pgYZHoPcIxZn4=;
 b=oToLpwDuM85C/zVd4ceilxjFiZBcdK+b4UNke1Lh0EdP1+4vkWCXo7CHdFilqBo/uKIP9ZI2NIDUPdZA/IL6kzslO53w+lc2GZ8Ru68GE2fhe6giMGF4sDiuBcfTCErHxXs8+X7iAGLWz+au9SjpjASfUcyC4CNsFVAVg731Pq8=
Received: from SN1PR12CA0076.namprd12.prod.outlook.com (2603:10b6:802:20::47)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 06:08:58 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::1d) by SN1PR12CA0076.outlook.office365.com
 (2603:10b6:802:20::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Thu,
 15 Jan 2026 06:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 06:08:58 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 00:08:53 -0600
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
Subject: [PATCH v6 04/13] iommu/amd: Introduce helper function amd_iommu_update_dte()
Date: Thu, 15 Jan 2026 06:08:05 +0000
Message-ID: <20260115060814.10692-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
References: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|PH8PR12MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 247642fb-f68c-4135-773b-08de53fc9290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HyLck6GBGlBzHOBTpnPlnRGQ8+dttVutV0MBxjAorjcGHwo7oKZolW+N6/gJ?=
 =?us-ascii?Q?eHkMNusR/KqyVG8rY71QOGBBN75w1AsFdAgc5J6+4Vik+Re+7QlAD2EaXr1P?=
 =?us-ascii?Q?g00Hds9zvUbM5+Tr+dux8qxodTyedpNPvUDpS+aYmgS5etms0GKkdfPenxPy?=
 =?us-ascii?Q?a6TL+4nimgHyIK790/CIRbZQ8RN8jMq7/fwzViV5xve8ymaFkApWNkRKxmgm?=
 =?us-ascii?Q?MC+6ncUkTlhH7zNFWuMFQ6rr3UBcoa/oxT7zh7JUGEJsNUVLM0dY+9Q9c8gT?=
 =?us-ascii?Q?OolHh82fE7tjVQFIgO6WluoTGyOw2nYlSKcFOcbG2+QfGpsW3kRQ9nw66LjM?=
 =?us-ascii?Q?fXisKrXkn+mkMM8CBd/KJRk55GMAA55KdUflWFCdrR+nn3CB1juasxlfQa3H?=
 =?us-ascii?Q?dG0em85eSoCt3cY1aG1lpK8eggptd8955sEp16uyh4tjMgydedinys89C7aW?=
 =?us-ascii?Q?r3Q3yu0O02NDygUhTkSLgyGR48olwDGYHPJhxzS9x1IPij6vIbZYJiCLvngM?=
 =?us-ascii?Q?tHnKRbChsRbhL2pG4fY8pCrqfRNWPzIOSlkVuUVYByM07QcjWhU2Kk+ZYizN?=
 =?us-ascii?Q?0ISRkNPekugyIX06bH9M6WcerVHJ5TK7IpOlQqyw0mJnhygbKARAM7uNqq3W?=
 =?us-ascii?Q?ehwShg/PlcF40JAUrzbWUs4lddI4GuCFzo8RctF58e28/fSJH+dQ3V++wwkX?=
 =?us-ascii?Q?tRPecRLj+uOoWfNFylktPYeP1MT8qcvSPmbTKn6yi9D1rFuSkVQzDMEkgNDG?=
 =?us-ascii?Q?B1juxKlfjF+6b8wB294cdBYzddbAHWKvx2wc54xmsTZst2RVmxwqwUy2af2d?=
 =?us-ascii?Q?1WKdRuaCEQR0Genmz2qKsQnCExRrChsXYlYDU/WD8II9bg5h4pwY6my/17Up?=
 =?us-ascii?Q?JljhKbKMcaH10upnsu7QGEj1Rr7SMKZ2Yrf1GoQS5eQdf4C8F3kI0X/AqJl+?=
 =?us-ascii?Q?ggaUbizsHhThKRyZPWpmMMC5jXILk+uE5NA/jlofxZM6VU6MlSf99vOsDgy4?=
 =?us-ascii?Q?gfYcX+vcGVij7u+K3h8BaBD9HRWyLo+LB9VkodaOcer1bScLJNoEUC7Q3KGf?=
 =?us-ascii?Q?O296w2AdVdp6G976aDhzDS0BwcOzg9gybna6xbJznaOGFy06lC9M4Vx5Cmzg?=
 =?us-ascii?Q?G9InXfa9ECiw00OdasA259w+SsMssg3RJ2UutW2K9UZQSdz9dOo/VtcKokD1?=
 =?us-ascii?Q?7OX0/w/OAOXmio+WD/WZBE6mKMz88MrVBS7wbc32RlbutW03JMIY3y2PGIY0?=
 =?us-ascii?Q?wac+uyVccs6F13R8OPYHozRv8qaKiXKn1GdlKQja5N8OaIaelJALYYP4wVuE?=
 =?us-ascii?Q?+IRyIhVrpf7P0kbDFU7VacT+eQCmJDxxp8rG7oCJ0o4xCMyOKWLtqZ6+3TXM?=
 =?us-ascii?Q?atGtNpbfwrqvbFtr13oUXHCOzywGUJ4GNuZaiKMVeXCKpWAe7jIpW/KubJMO?=
 =?us-ascii?Q?QQhJnOWXVW87aVSMSR5Z9eim1FfCxt71GoMPhoaXoLP+Iyss5g7Kb7A10K6C?=
 =?us-ascii?Q?wuKhtq9nJ2yxPwZLPhYVHPyasKirInp5EetieDuIosHi0Q2oY84PeccDkXSn?=
 =?us-ascii?Q?jrPZLxAm1/1w2RV+rZ/YaGqQkBNhZoV9Kqxm2/nbFFdpMEw4FclXB/Au/WE4?=
 =?us-ascii?Q?v+IUS6XuZQmBrxVCNZ58vaDtRvMRctF/Ilxx8PWzGyBpLMe9336k0YrfGjrW?=
 =?us-ascii?Q?k7nTuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:08:58.8276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 247642fb-f68c-4135-773b-08de53fc9290
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842

Which includes DTE update, clone_aliases, DTE flush and completion-wait
commands to avoid code duplication when reuse to setup DTE for nested
translation.

Also, make amd_iommu_update_dte() non-static to reuse in
in a new nested.c file for nested translation.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  4 ++++
 drivers/iommu/amd/iommu.c     | 24 ++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 8eb5e9857079..d97b9b6d76d3 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -190,6 +190,10 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
 
+void amd_iommu_update_dte(struct amd_iommu *iommu,
+			  struct iommu_dev_data *dev_data,
+			  struct dev_table_entry *new);
+
 static inline void
 amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
 {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ded8d4ba86e3..6fea4ac97e3d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -76,6 +76,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data,
 			  phys_addr_t top_paddr, unsigned int top_level);
 
+static int device_flush_dte(struct iommu_dev_data *dev_data);
+
 static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 				 phys_addr_t top_paddr, unsigned int top_level);
 
@@ -86,6 +88,10 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain);
 static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 					bool enable);
 
+static void clone_aliases(struct amd_iommu *iommu, struct device *dev);
+
+static int iommu_completion_wait(struct amd_iommu *iommu);
+
 /****************************************************************************
  *
  * Helper functions
@@ -203,6 +209,16 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 	spin_unlock_irqrestore(&dev_data->dte_lock, flags);
 }
 
+void amd_iommu_update_dte(struct amd_iommu *iommu,
+			     struct iommu_dev_data *dev_data,
+			     struct dev_table_entry *new)
+{
+	update_dte256(iommu, dev_data, new);
+	clone_aliases(iommu, dev_data->dev);
+	device_flush_dte(dev_data);
+	iommu_completion_wait(iommu);
+}
+
 static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
 		      struct dev_table_entry *dte)
 {
@@ -2123,7 +2139,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 
 	set_dte_gcr3_table(iommu, dev_data, &new);
 
-	update_dte256(iommu, dev_data, &new);
+	amd_iommu_update_dte(iommu, dev_data, &new);
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
@@ -2143,7 +2159,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_
 	struct dev_table_entry new = {};
 
 	amd_iommu_make_clear_dte(dev_data, &new);
-	update_dte256(iommu, dev_data, &new);
+	amd_iommu_update_dte(iommu, dev_data, &new);
 }
 
 /* Update and flush DTE for the given device */
@@ -2155,10 +2171,6 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 		set_dte_entry(iommu, dev_data, 0, 0);
 	else
 		clear_dte_entry(iommu, dev_data);
-
-	clone_aliases(iommu, dev_data->dev);
-	device_flush_dte(dev_data);
-	iommu_completion_wait(iommu);
 }
 
 /*
-- 
2.34.1

