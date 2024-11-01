Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5461CDFD5
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478236; cv=fail; b=ky7pzQNsaYItiaVUXMpSpucaRhuTeahgOlBtoAnPsSWqJPWp6bmB3noS+hW7lPAo+tnPp6bReJBF13Wr0Q7yeUBIj88v8CVR6LI6OrMPEJD6zJ5180/t+hFlvUKt79pRN384BOhRzqzdJGnWBKDlt22GbrPY381jt/sTt/hfe+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478236; c=relaxed/simple;
	bh=AYR9K5N2AgCVVs/B3EKI65k6IXUb8yeoBi05gs1woq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfQCQTqW9ClqWLVq5ju1uYZJ5+Cx7arVJw35/M8oCo/Ms3fRDzaONQkfHrgDd8ZI21snsSRL+aeLnHht+mfs7nPwY3PlTyubee4al3RWJOA/ApWTAtfZmKgmOAt3Zvm0H9qpupwJaIFwLtJXzu9T90wIlyJcPE01ZrV/vNrNgH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iC/YmT3h; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iC/YmT3h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBOUGh/YO83ntpLU+yCYsqsiciUBOd/Auxx+LEXCu/v3H/4HcerYTsZYYqUyZJoN1pXe6OgFTRWcnQZ7+31DVFZl21Yqlukro2iKSefLN4Cyvq1o70j7RP4oN0gkJ/rpCV73zG5ME9w+pfgrvn94MMR9MvDIptKqdys7PPoTsp7o3ZwFiRK6Yx4fA5fgApgB2lbzNLljaJEaEAd3Hx/2nO+L+AGJaocx+SVh1//d3RFk/t0fS4tGXVXB/N9FAHLTkA4nIJ7ycXsApsLqsoZhxSTucT72VmXTozOB0XNFR43cIj/A0QYjh6GRS1ihZk87Gcf9M1DNK/jZTbOZC8qeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpPwrNHju5DSUGALjPGSnzKUyLP7MYHq/dZto7gcJus=;
 b=i17KUOOoxtdPM8bR8RVEX1+PtNwR+FAZa1ogrDIrKVfD2w/L1PWWrzh0zmGjPmiJrohEs83pqOLL7oq50iRHXO2KGBiEbrLD6p7hCv+EGAJGJV0BNiXTErzXvotc4bV+uCsdpvr7x+/DGxzS1tvw8evoFvCd1QpRifgEVf4gORdHTm/ujHtX36jFreuyHBPli9yOJEfkEfZMvx0uhKeTTofwcyTjG46ge9LQOmGUx7OZmIRS3N2epfH+e6c/KT9tLTO/I9Z5btFebOXMb9dykpnHt53STMaX/l2Ynz+SioMoegh0YHWNv+I1SNH/Kvvj3WFWvAMOafTFcv9vOVo+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpPwrNHju5DSUGALjPGSnzKUyLP7MYHq/dZto7gcJus=;
 b=iC/YmT3he02BjroqkRI3yK0wgLouYx3IZWja+0GgxZZzdQjK8Fgzo+fLWjYMAeefg/lJ5VAYZbn5nrIEMFvdzrmyMRS8JbP1nFghjr7SN57PGDXVxsPxS0FljWDtdNgu5mOTSittsdiz/YTqDREYfAE5OL8711uvRJQVOF5LA5E=
Received: from MW4PR03CA0189.namprd03.prod.outlook.com (2603:10b6:303:b8::14)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Fri, 1 Nov
 2024 16:23:49 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:303:b8:cafe::63) by MW4PR03CA0189.outlook.office365.com
 (2603:10b6:303:b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.35 via Frontend
 Transport; Fri, 1 Nov 2024 16:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 16:23:48 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 11:23:44 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v9 07/10] iommu/amd: Introduce helper function get_dte256()
Date: Fri, 1 Nov 2024 16:23:01 +0000
Message-ID: <20241101162304.4688-8-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 0849c8fb-a46a-4f24-fc15-08dcfa9190a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5J+rx9QTZLmL5aFcZnGvACYXEovzT2pS5lX2otqT4cnx/B++CFQ/L75Ltyxd?=
 =?us-ascii?Q?AzF97Zb6spb9LkzDQlVozV+nvChUp7ciwWNCcx7t7BwRHA6WO8MuFVIs/twj?=
 =?us-ascii?Q?wVfWJ+kUa4xhf9jwqbOonxggBcCCBpzGV3ADzed3D7+Uw2+n0/nNk0SlB2sN?=
 =?us-ascii?Q?fib0q/cAT3V6R/EtDcFMIhw6EMWqog1ubp46aRjPZc0PnwgxNoZ0wgOq+QF+?=
 =?us-ascii?Q?YbeSHyn3GPjxf2u44v0NyUyHQ/n6ePpBwC7eidiFGaD4zBczUgLo9Kxa13M9?=
 =?us-ascii?Q?g2oaiu9gldR3M8AyOyvp6mS252P5mQUwDJuruq8+JiLaHNEznnsQQ49xZs0P?=
 =?us-ascii?Q?zhuOpIH2RgZOPLsZg25xdb4jIWU4Ifbm/UK/kMukosTkTbe/ilo1D5Nkl3y5?=
 =?us-ascii?Q?FmUJ6hLrFYbtt5OM05fXhsSZtBM4V1YMkr28Fqh1/jFZYDCRtznv7TxfQmIC?=
 =?us-ascii?Q?DvQemwfVlxj05s2JAJ2esWLbvd7jMNUOk0xL+tAetuoGFy9ulAyeiFNxcUD3?=
 =?us-ascii?Q?ST/y+hbzNfsRdj5XjR74kd0mYcAxITHE/W2HQB1hXyZ2vo+NW0L4JxR35rZV?=
 =?us-ascii?Q?KLugMpyOpnrSWHPw5mVbbLc+PDyTbaCu1aepcK7/oF5AF6rmls3RcsQaMdwD?=
 =?us-ascii?Q?Hqw65JzCwSzhVe91WD96pThlYXN+NKeoZNANcQ9h4h+O/0uSkqhLN9+QLjUX?=
 =?us-ascii?Q?RH9zwydaPQG2vI26LOpWuaA3FaAoUnltKwRp7ydntUEdU2OpdxB7znHlar4Y?=
 =?us-ascii?Q?eGmqm7s0HSsIWnvB7BQ2+QZZIHQnrzarDXWRjvxdNljmCAvSSQyvEeuNGyaH?=
 =?us-ascii?Q?fNBAKutHLps/iVIv+y5Cao2Q57xIKufDsl2oRuvHqXAVvv2luOLRKKZm6CsB?=
 =?us-ascii?Q?hHiJSTYgic3V9oUZ97nlRISlPnH1fwoxAM/EgA4iXVR0KiPBphRfhLBMmMQV?=
 =?us-ascii?Q?oy0R1yfGSwuHwM6dpHeCs+a6IibpaDlCMJOvFkODqIc52cv9xsuNbbnqXWps?=
 =?us-ascii?Q?NHklD0xg9lLTrxWOId0MfJMolO4p7RTISflEZqUXhXZNLB6vGplJIOKGapl0?=
 =?us-ascii?Q?4ou64kavayQhWCeLA7Jtzq3wqTqj72JUrp1UaiPtaWijFS6Z+GLGUjWVAmTk?=
 =?us-ascii?Q?t8oqNFMskYlPSnXQmB1cfnSZNvcw3qwfp5X8anxWsUVbEQ6VUnp800xEsrPU?=
 =?us-ascii?Q?YIjOA3aT3RVNIYHLyWD+CdKECwzEvetBN64mUOEf4a03FpZjjxhoXZhdPRgi?=
 =?us-ascii?Q?mplsn/djyZDlOSaQq7RB0JO68TVOGXqMDP4a5pMqWZl2HX6OFc795gkd47Bq?=
 =?us-ascii?Q?bzTtUK0O/cZQNJ9LrMFQOj6oHBpyHmprrOJ+5mYLvwilP1pWI5gJc7T5FYPm?=
 =?us-ascii?Q?XBfuq1Sa+kR6cG4rkQXlltAUEYv0zCBgU2KZ31NQa+on8IMCGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:23:48.2501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0849c8fb-a46a-4f24-fc15-08dcfa9190a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859

And use it in clone_alias() along with update_dte256().
Also use get_dte256() in dump_dte_entry().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 61 ++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 27bda7798f0e..4151225b4245 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -85,6 +85,8 @@ static void set_dte_entry(struct amd_iommu *iommu,
 
 static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
 
+static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid);
+
 /****************************************************************************
  *
  * Helper functions
@@ -195,6 +197,20 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
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
@@ -343,9 +359,11 @@ static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid
 
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
@@ -354,13 +372,27 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
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
@@ -633,6 +665,12 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
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
@@ -646,8 +684,6 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
 	}
 
-	dev_iommu_priv_set(dev, dev_data);
-
 	return 0;
 }
 
@@ -678,10 +714,13 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
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

