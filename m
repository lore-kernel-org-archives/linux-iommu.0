Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA271CC16B
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400218; cv=fail; b=Wio2zw93n088JIPsSnJEfQORMOORm0eKcc/hu+zA/oZxWXCMRtlrOsNC7rJ8tHwL+7G+CU1zllWOvmOlDfLMP9CWCY+L+WaaT8doNlttzXw8rrJVoG2gCY6K1Xhf1/yJ53cJKiSI4N8XhAMcfDjzVq56rMiRXeKb6TEeHN5j4OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400218; c=relaxed/simple;
	bh=TDjkR4wulMV4fD7FS3zU4FsNX98i7NzL3t7DZPjC57w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PF33u6sg/LzPraKeN3TpEAOIk25IUY7sNTZNivmzLrupZo+aGAs8C3xrHUXRcmVdYW0yx2lbC42djrF8CNomch1wqtcXm9iUa1xRCBKka/k3A/3lVEMlIc6n9mn2pILJ4bHYq2Puio0rZ5zJcPhwWesbcLCE3Q4Ro5iG4BfiIpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3Q8W2wdR; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3Q8W2wdR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMCorRqx44OTZqrVDEYEpUeV2rqk7BsRPGAx/tXLZ2XaMmjWeBJyr4K9w1tZAlxzlfHtWRx/jWmDVos8waG1TvhycG8Lr89hGXo/xyYSTbMoJ+3H6nDGnByvhoDKxs5TNDTSUx4ogXIPgN1tf+iafkBFvP1usx/tpBdvo9STCRS7difMJtFo1VDO16HxF42IsiJnvjrdv/YW5IXaeVHSxWPjT8BA7yFN9QZV5lzIvRad7psBpVa3hifTHf/rVQnFC796XWGxVS3BAkWjxJEj9gZlDIOfLdIJcshBuWy5qVpYHkjKZNECUkBL1OxxLnZ6OkUxFaeMfo4AdXqODrVfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOE2XvkNQgMZ6KpI13Ds7TglC3FmAbqmNMTGAc85MrQ=;
 b=wzAPSPkAOOcFJHJW85DheSnI4YHAFQk1+OKVD9N8OSAeBRUcUQ28MNOzZgSpyOs8a0SiIOMJUlHXCjus4DteHcv3AS3PvjpZlX9POhHS1q+W3ltab/PGz9HXHDKZMMv8bBZsjp0EsvNUpiS92oWHJ5fVHzJ5AnpX2Va3WvgL4JB2t/2TXxAjbwMR/5K35vB0YYmgXsHROQ9HnU5kO9s/0KaDp00re41A/O+5x+S/NhY5h7ODv2hYKB15PK58KiuHStgoxQiKNdT+xiR37rJk9ko1KblpBm45L9jaMMmAENDAXztTJ8LvbU8FVg3SXAVcQzvRWW6rQVzDV8kXOqWOrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOE2XvkNQgMZ6KpI13Ds7TglC3FmAbqmNMTGAc85MrQ=;
 b=3Q8W2wdRvyCQl2rF0pDn4sfh2L8kYvKxr0+fDiXWCICMeB8Orwe5SOjw40erNz3GBeVuIyex+AFGlSy7EXLJZnSg84c35okth9NKkDWT4m9EhRCE4Vzt+IuZp3XFv07HwfNxwFGQzgXZPXbynDQL03zc9hdDvIjm9Wzd5T5okow=
Received: from CH0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:610:32::7)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 18:43:27 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::18) by CH0PR07CA0002.outlook.office365.com
 (2603:10b6:610:32::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Thu, 31 Oct 2024 18:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:43:27 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:43:23 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v8 07/10] iommu/amd: Introduce helper function get_dte256()
Date: Thu, 31 Oct 2024 18:42:40 +0000
Message-ID: <20241031184243.4184-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
References: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: b089d2d7-7c68-48ce-e5ad-08dcf9dbe888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n+FWHC7hMUNz0CuRWUaq2EwJwXWjPV8a5QC2QW6+FZytmDxoLQoR2/kOFabg?=
 =?us-ascii?Q?pFJTdRNyoUW07cF5EQ+eHp4OrhYz6xUAllsh1WIJ/+MCaq2kZhxTyqVY0g8m?=
 =?us-ascii?Q?+E8Ba/Nmg1dpgaakNMeOuLiLhzHnuih7XVTw8pO4VYpF3qNdGG4q7m2QjYer?=
 =?us-ascii?Q?so2Bhan3xVAkjhHA+mlz1YSqT55wywLNVT9eLLSp26hTTzJzsvh+E817uNFP?=
 =?us-ascii?Q?XcKxqJTaXVBtzqaMVYXCB94eeFr3dQZrw4+veJsL/tR1D05EDsFl0b9X7inX?=
 =?us-ascii?Q?3R3PrtUjuXlDxqcMJwCfz4l1kV4+1EPvIk4VJfhy2dKmdfr4hpWIYxXPi96G?=
 =?us-ascii?Q?vHMbwNaSbCsDLkmn7MGSm/fUWlBZybQCCKlSdfONOMpTNLBeWsEASsZEODks?=
 =?us-ascii?Q?0kFfW68mV7eaGIKxIbbxCpw6Pus2jQhnwBlVNEM3iR9OXA9CncgkxUTVuwIE?=
 =?us-ascii?Q?R3DUtu58K85SgkV7EJqaxrSxfbOeN4gmx7+X0aOoJ94arKnfs0EgSRIuB4Q3?=
 =?us-ascii?Q?kZRONwBGiNIUwCpAtp1vbhu5nfw00A4PHIA281yKgYqsW6U4y/phJ99KLitX?=
 =?us-ascii?Q?IaGGCxTA3s1XfPFdAzFN4yc7N4hyvZfd7MnYfbA7vY7EvrTR9EaI9qjpQeEw?=
 =?us-ascii?Q?Ex/QXopHGLm3G6J6Li7z777hmYlncbG1+ZgxlKuBw4dh3WRf7lIlc7Su4BDz?=
 =?us-ascii?Q?NRm5VZB5ZYCFu4dfT2c9g1pjaNpWduzkr7j2SrLhUgZydCRXjo+pIVk7O2fW?=
 =?us-ascii?Q?vbHmu8Cao/C9oEGS4eG5g9gBqyQBDN3CdEr3/gHpvndQVdNMjP/EfMGGz/vp?=
 =?us-ascii?Q?5EqsJTRjhUM0uBs0/jvMB21MUh5rcp/6mrKZyo7DVc5vC5IKg2PZYMx99sly?=
 =?us-ascii?Q?zjhCaOs86gJM4tQXVzz/8UTFVHbyerNXbanMrwXhlQYqdVqu3LjrGlkxf7YF?=
 =?us-ascii?Q?SehMJo0oAes2OLnjusux9oHvkKoXhKQPBoooDWqw9hr29EljPLJbSahnPRuK?=
 =?us-ascii?Q?zm7jl0VylKrL1zcIfKD/UIOAP2dI6cU0DQKY15nGTly/qilEku7jLhafdd5J?=
 =?us-ascii?Q?QqGQ0SDULlder8H1ciy/Pq/LKPq8ys+YdrH0DLHQxR+vcll87jEgJHzuatE+?=
 =?us-ascii?Q?10FRFvZmQ7zZHUgIGhPlpd+Vc5JLuhRdAfO7EPI0EHwFl6KPDsWeruOTVtb+?=
 =?us-ascii?Q?CpDAZPoNmzhVOUAxBIyFiidJbe25a5r1wN5S+ucnnsLEJYi32+m6z0sD/Tfb?=
 =?us-ascii?Q?F6cENKP4JhOjeAq5bReDET/QF0DqPQrEvHBrQQ+ZEFVc7S/n8idPtJt62wmI?=
 =?us-ascii?Q?i4qvM7UwRfxcJBAws2dGkYT34CVO6TcVHYWr10LCU2vl0vgpa5LJMfA9TYxi?=
 =?us-ascii?Q?rBgB3v6f5MXkJ/KsFEOhey5hr4iuySlYZsrAvU1X/aaJeFwA/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:43:27.3426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b089d2d7-7c68-48ce-e5ad-08dcf9dbe888
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205

And use it in clone_alias() along with update_dte256().
Also use get_dte256() in dump_dte_entry().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 61 ++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8c69bb0e9454..1262ea7150f6 100644
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

