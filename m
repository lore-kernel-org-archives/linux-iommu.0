Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C01CCB58
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624835; cv=fail; b=YwigNsG2FhUztGNQsvhL4TVm9QxCLyMnh37qVEcETkJCfOyA0SHzXEyDqKKXlMVAM7tjHktVvJbfJLhaeXTl9AvEm7sY4z1hYwhg3pENSLOwbzOyiAcemOOSFdlzziPUj/7wQgZoYcYcujHqUlWbBN4cvOlFt/4+vX1hAGkjlNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624835; c=relaxed/simple;
	bh=7/TFEU/7OvEayCiXThhCnBO9vKFNHDMLFLfdc0r1l40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1iObaIVNxRSSN1sVhk8rmRiPyou4i2B5X6NsvNiqZ0XZDnh1RhZmrIRV6eAPDltxAUPBgpzqIHAtEbjFdUL5sIDQg00VwH/g0hSncEulyI/jJQBihyaxiEnIyQT8Zh3aJ3YPyrDHEOlFDPm9S8pMUX8Sc2/Myg/tux44cGM4JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UeKswy/g; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UeKswy/g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjSJUfgM6NpdNmtXc7PiIjQfl9/avI7v6H7rKcQo4/W5k3mbZgE4p/JH5t9fwUB2rY8AtvnoipqN6CFB1TgKEuW2A08AI2/uYHskoDP+ZQY55+7lQdQpgIrfmeAWNhcZyJdft8flX4ytYtkmt0F3ZlXUP694WDKexcrddbz68RfOKxe+W5386hm0Ul7PcjIu4wQVnPyiNMA9Ia5MI4zuucT2E4vMSxUmJgllVDkbDpVH0QBPP5gOV9zXmAJ1lnhKnC8nT08Bb13A5CjjBH25EVd9LQmNyKFNpv4O2pj0bAtIJ8Dfj/CbmiUdo6QKttW7NLN6esrrZkztwp85e98Z6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEHNU8HKw9Eo8oYvE7HfuF9qXQ5+lobm9hgC/6PyoRA=;
 b=d/YD2XfpHOpiOgD2iNDPwHwcH0v0fYKaSMnfW7bhOONPKlzkYRDFrPkDFPzEBXfB/9TWOhaDZph/A6HoXQpKctlaeFq+FY0AM3+g1x5ggfIzO565LqvhGfyrBx4Y1wCD5cqLCnYcuUHnCymxp+ZHgva1WzcmgwkPBOGiBo6KXGE9W6Rwjv7k7FNVld/6EJYKWI0QpJXCcVKndsIlQd/3wnfcQXco5KDVltQ9W94EpjPMASvuaXW8LOQ1Rtd8mRTtBNv7MnfW/NgzA935xFB8fWUsQfkn5r1ueQiAS5amtdeawQ5YdHFm3/u+W+/tNTy8lt9edTDw34fd8nXLG796TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEHNU8HKw9Eo8oYvE7HfuF9qXQ5+lobm9hgC/6PyoRA=;
 b=UeKswy/gEdbLykQ3VT/sgX57SPIeZVlYs/5a44Vz8Q9nKv4EaG6o8ZQLwzGheQQUBfj62xxqulMERrvuF2t9zAn0EE+mlk8SFgaA1drHCR36POnYNm20smNy5CVCqF5UYlSkv3v5zPWN9sNsP3l7Dc+3jhn47r+qHcaiDK1Ao6s=
Received: from MN0PR05CA0003.namprd05.prod.outlook.com (2603:10b6:208:52c::33)
 by PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 12:13:48 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::fe) by MN0PR05CA0003.outlook.office365.com
 (2603:10b6:208:52c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.19 via Frontend
 Transport; Fri, 6 Sep 2024 12:13:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 12:13:48 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 07:13:44 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<ubizjak@gmail.com>, <jgg@nvidia.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 2/5] iommu/amd: Introduce helper functions to access and update 256-bit DTE
Date: Fri, 6 Sep 2024 12:13:05 +0000
Message-ID: <20240906121308.5013-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
References: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|PH7PR12MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 113e080e-5ae0-48d2-e55e-08dcce6d5cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BPWgHOBkXbDuC++k3iDioeFkUW6cIjzzMm8Hjiti0UX1R9evgZAzWZItVCYe?=
 =?us-ascii?Q?o9cU7ka1Y0HCoX263WAB+x20HkOW5QX9FIZzP0q/S6x1TE1V0fYZDIpn6hU5?=
 =?us-ascii?Q?1/OhuFKwuIdDLBx4skH8+wYWU3rSQfKk1jIxUNf47F1hdGu/qmNwE2E0H7Ra?=
 =?us-ascii?Q?vBAc03T4f+qa2Tu01FjJWh6V/RTrI1UpA2gWi4+yuY1dNDwIJ4mTmsctgxOH?=
 =?us-ascii?Q?ylYi+XqQltM/s83VEQ92ELlKi0poPaMiMKWYTg2zNJN5UYl/6BqxF44WpMao?=
 =?us-ascii?Q?ThJdyNEJ9h5k93bw+hp38FN7YatYJ4bxppW74oZ82efZ/ZWbaD1V/b2rIIZ1?=
 =?us-ascii?Q?eSqkUQwBznFpznzYwvjWOgNFgclDO6vz3J6+punCrnu6fMSDaVwr8Cx7RuFv?=
 =?us-ascii?Q?/S5Hh1dFV183M7JJkIlHy4bBtmog1MKU/YAedBX5z1hYw45K1wK0RR2yKf+d?=
 =?us-ascii?Q?x4zA8owpGyCiBEZZ3zzWOSL7PnwzUvknreE9Svlgq13AHeamA7EXkujjTDxc?=
 =?us-ascii?Q?7mPdKtQnt4ZzZwqGWZXhwrb8cQ5ZuwED68sHtl6ySsM/rHAYms6xcGrRNuCX?=
 =?us-ascii?Q?jR2lL94trCzbFzFVexqrY0aqTAIRHOV7xk8CZ7Cg0YgzuLhKe7SKFAQ3ma76?=
 =?us-ascii?Q?18RcKGTFZv9xyJb5MSssET8eeHWG/wKB6J8bsqtJyup0gR6E1h8Ac/Jatc1D?=
 =?us-ascii?Q?t40FS507QMsJz7IBgkjUi0LzOB87zqA6MDhkYIwHSRSyM76oqfQnGe3krWHg?=
 =?us-ascii?Q?n5QJn+yWjgKy5ZGUE2ZYyy55C1/ZyflMxDFByTVNjT+P8h2YQS//FCjAtff2?=
 =?us-ascii?Q?7pVWqQPHT77dYp8Lt6D3ZB59xqIEsqNEpV2GJoC/6UOdfz7JyJBBkkNz5lkm?=
 =?us-ascii?Q?U/pnvbXbjpjZDKII0rOImMT2Q7at+JdhhnYi6Io76vg52fErnXkiCGfj6JFm?=
 =?us-ascii?Q?5uPZugHriDP0uCVBI8fvEhVUOEYXeO5NaIvgdG6YV6P9Xuwf2fGbRV5A+oCO?=
 =?us-ascii?Q?f+dUsVAIUGqvsgcBwwcuAPmQ4MY5YJ8kCZ17ajSifgKmm5Wud7T8cXTbWQyA?=
 =?us-ascii?Q?6QtG7VmnhZeQ+bAZegTB7MtA61HX4S5dV4agiRGscMU1W7dX708pcVmwH4jb?=
 =?us-ascii?Q?Y/KBMw5tE7oRNMbhbiGcTLYnGFFRdT3A/H6o2q/KAqnUP424t4vlMXbvaWko?=
 =?us-ascii?Q?HFDuTkb0fiKWAw6WfRrOX3FhQsJwdRDTRnmAQJl6nOVQ+ErcLTgPc4Zxjr33?=
 =?us-ascii?Q?i+ehZDSCqMxHXIQAMWrWEHF8b2zm3Xne32Gfp/JChV1iIvB5e2SFXOlMC5F5?=
 =?us-ascii?Q?qhmSx2PfiDo8NkyZII5v7GXKuH4vaRosaxq/xVpWKuDBpyNrFVKWY5UCPk0K?=
 =?us-ascii?Q?Qwtln/ME8crE21QJ2DuJbm0f0bGmTDY7lOaFnUCU4u/r2IhrBrJ/N5+XlcgI?=
 =?us-ascii?Q?eLCtBKNAEjLCXvxFlvN7HTvjJlU8fFmV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 12:13:48.1364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 113e080e-5ae0-48d2-e55e-08dcce6d5cb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038

The current implementation does not follow 128-bit write requirement
to update DTE as specified in the AMD I/O Virtualization Techonology
(IOMMU) Specification.

Therefore, modify the struct dev_table_entry to contain union of u128 data
array, and introduce two helper functions:

  * update_dte256() to update DTE using two 128-bit cmpxchg
    operations to update 256-bit DTE with the modified structure.

  * get_dte256() to copy 256-bit DTE to the provided structrue.

In addition, when access/update 256-bit DTE, it needs to be locked
to prevent cmpxchg128 failure and data tearing. Therefore, introduce
a per-DTE spin_lock struct dev_data.dte_lock to provide synchronization
across get_dte256() and update_dte256().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++-
 drivers/iommu/amd/iommu.c           | 80 +++++++++++++++++++++++++----
 2 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c9f9a598eb82..1836da2d9e60 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -833,6 +833,7 @@ struct devid_map {
 struct iommu_dev_data {
 	/*Protect against attach/detach races */
 	spinlock_t lock;
+	spinlock_t dte_lock;              /* DTE lock for 256-bit access */
 
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
@@ -883,7 +884,10 @@ extern struct amd_iommu *amd_iommus[MAX_IOMMUS];
  * Structure defining one entry in the device table
  */
 struct dev_table_entry {
-	u64 data[4];
+	union {
+		u64 data[4];
+		u128 data128[2];
+	};
 };
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 87c5385ce3f2..b994e7837306 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -85,6 +85,45 @@ static void set_dte_entry(struct amd_iommu *iommu,
  *
  ****************************************************************************/
 
+static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
+			  struct dev_table_entry *new)
+{
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
+	struct dev_table_entry old;
+	u128 tmp;
+
+	lockdep_assert_held(&dev_data->dte_lock);
+
+	old.data128[0] = ptr->data128[0];
+	old.data128[1] = ptr->data128[1];
+
+	tmp = cmpxchg128(&ptr->data128[1], old.data128[1], new->data128[1]);
+	if (tmp == old.data128[1]) {
+		if (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], new->data128[0])) {
+			/* Restore hi 128-bit */
+			cmpxchg128(&ptr->data128[1], new->data128[1], tmp);
+			pr_err("%s: Failed. devid=%#x, dte=%016llx:%016llx:%016llx:%016llx\n",
+			       __func__, dev_data->devid, new->data[0], new->data[1],
+			       new->data[2], new->data[3]);
+		}
+	}
+}
+
+static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
+		      struct dev_table_entry *dte)
+{
+	struct dev_table_entry *ptr;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	lockdep_assert_held(&dev_data->dte_lock);
+
+	ptr = &dev_table[dev_data->devid];
+
+	dte->data128[0] = ptr->data128[0];
+	dte->data128[1] = ptr->data128[1];
+}
+
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
@@ -205,6 +244,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 		return NULL;
 
 	spin_lock_init(&dev_data->lock);
+	spin_lock_init(&dev_data->dte_lock);
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
@@ -232,9 +272,11 @@ static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid
 
 static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
+	struct dev_table_entry dte;
 	struct amd_iommu *iommu;
-	struct dev_table_entry *dev_table;
+	struct iommu_dev_data *dev_data, *alias_data;
 	u16 devid = pci_dev_id(pdev);
+	int ret;
 
 	if (devid == alias)
 		return 0;
@@ -243,13 +285,28 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 	if (!iommu)
 		return 0;
 
-	amd_iommu_set_rlookup_table(iommu, alias);
-	dev_table = get_dev_table(iommu);
-	memcpy(dev_table[alias].data,
-	       dev_table[devid].data,
-	       sizeof(dev_table[alias].data));
+	/* Get DTE for pdev */
+	dev_data = dev_iommu_priv_get(&pdev->dev);
+	if (!dev_data)
+		return -EINVAL;
 
-	return 0;
+	spin_lock(&dev_data->dte_lock);
+	get_dte256(iommu, dev_data, &dte);
+	spin_unlock(&dev_data->dte_lock);
+
+	/* Setup for alias */
+	alias_data = search_dev_data(iommu, alias);
+	if (!alias_data) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	spin_lock(&alias_data->dte_lock);
+	update_dte256(iommu, alias_data, &dte);
+	amd_iommu_set_rlookup_table(iommu, alias);
+	spin_unlock(&alias_data->dte_lock);
+out:
+	return ret;
 }
 
 static void clone_aliases(struct amd_iommu *iommu, struct device *dev)
@@ -583,10 +640,15 @@ static void amd_iommu_uninit_device(struct device *dev)
 static void dump_dte_entry(struct amd_iommu *iommu, u16 devid)
 {
 	int i;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct dev_table_entry dte;
+	struct iommu_dev_data *dev_data = find_dev_data(iommu, devid);
+
+	spin_lock(&dev_data->dte_lock);
+	get_dte256(iommu, dev_data, &dte);
+	spin_unlock(&dev_data->dte_lock);
 
 	for (i = 0; i < 4; ++i)
-		pr_err("DTE[%d]: %016llx\n", i, dev_table[devid].data[i]);
+		pr_err("DTE[%d]: %016llx\n", i, dte.data[i]);
 }
 
 static void dump_command(unsigned long phys_addr)
-- 
2.34.1

