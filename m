Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38BF199395
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366239; cv=fail; b=GYi12uiB1JTn+FYHvciDD364yiuM1DYJUaDEBwrCBRWnbtTRRttVifRaF1r7oNMJeE4PUpdb4BCaghbINNiZRqB6ZVZOERbQaX5z5z6W6qHIV6U1sI48Ad3lDYJTPaAbpSAfmiY6oz0tIoueK+YivXWMiI2ziFcVaEjLcRp1C+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366239; c=relaxed/simple;
	bh=oZwxeRCWOEKZ5nthGtd4lnz006kQr2Vslh+shyuf6PI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOUhD0ZzBdMbnnk+RwnmROcasrKPB1n7SaRNQ70hVlDSjcI0XWZ7E6KjVaLkrldclzaoUmErZxunlZAPrdmet+Dm1Dws8f6psERjepidaUS69B8PsClwtkJ4N9M2aYF+urZ7wkLQfVmdrFWhlyLzYotudwszvPpyiOzkrG1ttpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cCgwwecG; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cCgwwecG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COrLRQDbzoJ3kVHrAYJ52PXLnVjChcd8t9qb0pA0UqXFHGpb+oS29/eUA7BYv/NP6F6qcNx5WCkTCFREWgikKmA1dTwUmC/MdLsFr387LhYXgSMAYf5MZ0SqUiUZdau4uv2Fyd5wWNI6+SIP0kkPKu0eeSea9DWCLQBMURQc/OfgVLfqrySMG5SmsWLc/0+6WiDvFFWZ3LHAhilxU4U7U6OaNlv3+3jLnfBcPX+YeE7BcqGjlAYoDckdecLzBILbPNFj8EMQYzMOAxzGgVru0/3al95/njoOTS62msKF+MaCjD8r9hBa8vVrzG0JsgNsYYkkRY2G5bKny1NlwktmaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN7G2YikVy9lTsi4FMxto4UU/q0vMgn2TE/iiSNh6cI=;
 b=V2jfD7Ohg5Mtr3Vz0IrLFhIxVvNVkZWBkGagcGtNlvYWMDtUbwtc1n/8bUtYBVi8WWYZfg4ED5ZHSsBGM4ST6GbhnW1vyQrdQdeZ4+sTjgVKgxP61kNaaqGgBgL/IkdrM0fdp4OH/vRuUQMU7BEMgGSP1YQwIrrakJbudk0QQOJa4RtX3d1Vc/VYKi11eH4xOvVt2wJxVvyFLaIIGC+4XezM4nx/mwFWXHBzmzw2OKZ9sWiU52cdQOSxO7WHVP0xWYP9zHUcpawRjKl6+L5VfCFGbxfeux1/BKRbDUmHtVdd4Ge/xXAhY3gUtZIfJTGQoyQtBuE3qvaOrXxgeKdjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN7G2YikVy9lTsi4FMxto4UU/q0vMgn2TE/iiSNh6cI=;
 b=cCgwwecGHZReQaa++l4TElBn54czLDysKo8vKrp9Psh6C6ibMkGwyNfjGjXFpf/8h+yB3c75g9R+39Ga/olSwxH/ze4DSU9YbzfPt2PEyFcI3yQR1o/ZWXIDo4qyrqjd/Bdc/KpwfkxCguw9EKf4hk8Qk1MugFfg8+5Rq1BXLBM=
Received: from SJ0PR03CA0139.namprd03.prod.outlook.com (2603:10b6:a03:33c::24)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 09:17:13 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::4a) by SJ0PR03CA0139.outlook.office365.com
 (2603:10b6:a03:33c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 09:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 09:17:12 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 04:17:03 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v7 07/10] iommu/amd: Introduce helper function get_dte256()
Date: Thu, 31 Oct 2024 09:16:21 +0000
Message-ID: <20241031091624.4895-8-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: a776a4e6-fa67-43e1-f0db-08dcf98cce3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qfd/UHb6Tj+Mj+iSPeedejEdsc7mt7f1sIonwODCNSCBQzLExwBK3Htsq0mU?=
 =?us-ascii?Q?exIfj0+d7htIBG2uSncIJgNq0wZXSH2Y3g/lRLH2JR4UU+/Bn4l0xe2opECh?=
 =?us-ascii?Q?R5lZ2mWW4A8/bpjXAucWcFFc5/bcO1YNLeH1+fcV3NEE+3ez8BXV5sWUC3DX?=
 =?us-ascii?Q?7guUSesuUw+QUDYOdeyWQOoYCPWH1cdWEjctb8BnUno3Q4kskieNFuhi3Xg0?=
 =?us-ascii?Q?XmYHwaO1pmT/38k2TleIVtGXDzyB0zYjZfYiNmTuSuJQ6QBW1+jUkpS2WIhH?=
 =?us-ascii?Q?CxFx9IY6PjsUdvd5Woelje21qquRGYXqTYSWVPJ4jnrhtbcQYX5zhhAP8AAh?=
 =?us-ascii?Q?UiAX/82cQDwZb4kNY+3K7UxklTkFyOupt0hw6pMm+FnK6mKHHiA9Sw+upr+H?=
 =?us-ascii?Q?Q2mm8GBlVpcQHcOWrRnHPeRTJU1OLrkx9phpzCMkgNRJ4/697LlFhEHdZhas?=
 =?us-ascii?Q?LGVdv/AQDz9PLRiayFasX99cCAoB6Bc6WvkTMDX4mOz8033xpJoSusEiSlDA?=
 =?us-ascii?Q?aJBbRFFU4flxart8CIuZbk4ZURczUZEgk4lw3iLcx35eq2NTHJ2eBkrXU0pn?=
 =?us-ascii?Q?bTJx2TDIS9JazM6pL692xo/mdT9Jd5lugYqZmU7rHoFN3jAWhYBmN8LnDHGL?=
 =?us-ascii?Q?nO1bR4Rxk7uKO9YhWeLmDWb/NOYUIxXUo+aYsWARYw2gGvCl8Sf90KSpEq+6?=
 =?us-ascii?Q?zqj9/3v8+uwbR0Ui7mdElIuJgidO5vgkEVvdmrzTRK5OH1VPdNdNIkx4Ryr6?=
 =?us-ascii?Q?3BStDnNa5qQoad6r9tZqTSLDZi9nCXmXKkMMQN+FNVNwRIADMJ+80xklf+/H?=
 =?us-ascii?Q?nId3Sjm5qlRZWTzCvrW4xQYVrR3vAS/nKziqLS7SxROLfpVd2EEDLvXJLQk4?=
 =?us-ascii?Q?uBOw7pF/vcM691aRFwAgrWjSZitjWWTVcyOfuvyAoR5I1hpT493ddvrfgtC0?=
 =?us-ascii?Q?T3wNaPKa+Oj5NWIFoDxWPuQTWzIyfDH+THKIUhEKy3bj3Q9jMy//cZ1N/2NM?=
 =?us-ascii?Q?t0+hptCHGi0bKmb2bYZHGRSZSEd4AZYjjmuB+TT21g6TdvnAlsQ3JbFJVz/n?=
 =?us-ascii?Q?lCnK+VBb53J7lKt6hISI//yFhwAQj3sZnXLX6yXMY1VST7bzd8tTvPK+jtaa?=
 =?us-ascii?Q?+656amJHga5A3s+sd+cxEHSiejyjBCWWGC0LnT0TyPS3e8SMM1YsmXONd2lX?=
 =?us-ascii?Q?v7J3Z5yddyJzWsO7jC3+5q2RNGHIz7+lGjcSZtTssCWy3trvkN4xGblgMpWZ?=
 =?us-ascii?Q?S3J2mYqTxlrYgJSO2N0hP3yTTw2NEjeq13lyAmzt7hmfb3bKwdzhQ8FEJHuc?=
 =?us-ascii?Q?qMKWt7UXslcBhnfG/OmZhmUJ8/IkdIrY/leoqJC7W9NZYICIMCEbsKG/yC1y?=
 =?us-ascii?Q?XsU/CvyORlzx8xmQ4Kf6Y0L3NjSgEtfeS9P0rJh1rNhprh7k3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:17:12.9174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a776a4e6-fa67-43e1-f0db-08dcf98cce3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131

And use it in clone_alias() along with update_dte256().
Also use get_dte256() in dump_dte_entry().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 61 ++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fd239b38809b..c8b0be83ee9b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -79,6 +79,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 
 static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
 
+static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid);
+
 /****************************************************************************
  *
  * Helper functions
@@ -189,6 +191,20 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 	spin_unlock(&dev_data->dte_lock);
 }
 
+static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
+		      struct dev_table_entry *dte)
+{
+	struct dev_table_entry *ptr;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	ptr = &dev_table[dev_data->devid];
+
+	spin_lock(&dev_data->dte_lock);
+	dte->data128[0] = READ_ONCE(ptr->data128[0]);
+	dte->data128[1] = READ_ONCE(ptr->data128[1]);
+	spin_unlock(&dev_data->dte_lock);
+}
+
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
@@ -337,9 +353,11 @@ static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid
 
 static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
+	struct dev_table_entry new;
 	struct amd_iommu *iommu;
-	struct dev_table_entry *dev_table;
+	struct iommu_dev_data *dev_data, *alias_data;
 	u16 devid = pci_dev_id(pdev);
+	int ret = 0;
 
 	if (devid == alias)
 		return 0;
@@ -348,13 +366,27 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 	if (!iommu)
 		return 0;
 
-	amd_iommu_set_rlookup_table(iommu, alias);
-	dev_table = get_dev_table(iommu);
-	memcpy(dev_table[alias].data,
-	       dev_table[devid].data,
-	       sizeof(dev_table[alias].data));
+	/* Copy the data from pdev */
+	dev_data = dev_iommu_priv_get(&pdev->dev);
+	if (!dev_data) {
+		pr_err("%s : Failed to get dev_data for 0x%x\n", __func__, devid);
+		ret = -EINVAL;
+		goto out;
+	}
+	get_dte256(iommu, dev_data, &new);
 
-	return 0;
+	/* Setup alias */
+	alias_data = find_dev_data(iommu, alias);
+	if (!alias_data) {
+		pr_err("%s : Failed to get alias dev_data for 0x%x\n", __func__, alias);
+		ret = -EINVAL;
+		goto out;
+	}
+	update_dte256(iommu, alias_data, &new);
+
+	amd_iommu_set_rlookup_table(iommu, alias);
+out:
+	return ret;
 }
 
 static void clone_aliases(struct amd_iommu *iommu, struct device *dev)
@@ -627,6 +659,12 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 		return -ENOMEM;
 
 	dev_data->dev = dev;
+
+	/*
+	 * The dev_iommu_priv_set() needes to be called before setup_aliases.
+	 * Otherwise, subsequent call to dev_iommu_priv_get() will fail.
+	 */
+	dev_iommu_priv_set(dev, dev_data);
 	setup_aliases(iommu, dev);
 
 	/*
@@ -640,8 +678,6 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
 	}
 
-	dev_iommu_priv_set(dev, dev_data);
-
 	return 0;
 }
 
@@ -688,10 +724,13 @@ static void amd_iommu_uninit_device(struct device *dev)
 static void dump_dte_entry(struct amd_iommu *iommu, u16 devid)
 {
 	int i;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct dev_table_entry dte;
+	struct iommu_dev_data *dev_data = find_dev_data(iommu, devid);
+
+	get_dte256(iommu, dev_data, &dte);
 
 	for (i = 0; i < 4; ++i)
-		pr_err("DTE[%d]: %016llx\n", i, dev_table[devid].data[i]);
+		pr_err("DTE[%d]: %016llx\n", i, dte.data[i]);
 }
 
 static void dump_command(unsigned long phys_addr)
-- 
2.34.1

