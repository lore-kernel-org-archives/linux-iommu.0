Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B23F15B13B
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507138; cv=fail; b=j4Xlfjf+yNSpvb0WI1zZBLvxwULQR2xJYp6MyoeyEOIauxfESOaO9/YKoCFZzzEoFEi3DFneVHyetOomxleMRW1nXQAqihmuY2y6tDBQLBQF+82xZ3TjnL+Zp+8dYZ+S2jtdUh8kR+DUIJAFGn0L4qnenEeSCJAUrLxirKbdoNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507138; c=relaxed/simple;
	bh=G6UUyeSCkNw80t9xzliFkoGty2fU/uwd4o2ZdUkm/wg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNEmQBqYwRPl/MP8LDlpexnwOCbBLJ6NKgMj3JUxO7tKgFM2unV7pGi2y+6l/7LPnYHYIS8G7+Ultk259CO/pPwrDGGIK6AQcgjHVksPFnjH/YkIJMywGDCoqhwSvfCDZ/w/drjbv6A8JPeEmEtWqYyDxq57P0QJZ4gV/enPn2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=havEVw3b; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="havEVw3b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieeLwsJd1C61qD+FXr37od45CiUOKLpKgliV3TMqaJAqKg0PU8AUGRfO49nOzwsjSpJJzkSKpNM6mLo0DBm1CS7O6cSIwmH1hT/JK02czkOmF8t1hyBmoM+KGq0XwO5Ia3DE9KMGy4TsFm+EeHMnFj9vk5Umq1datX5U4EuYlrGlBKOyCdiQ0825F5N6Dl6fh7hFH872Xlu7Kpw+5HdhLbzblPzWFhHxfli21i02GORs7gR7ukzqM4JjsvKtQFSuqB0Nml/Eny/0d/SX6xKiDBpwDz6/NKbqr4J2yX/FLe7e+/F2N/gaXwBibhCJcLiWhutFl4W4sfTxgpFv5mKD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcpEGhJxV04khh2/dgkIIhtdTMkFChedRdm0jsGV4yY=;
 b=C2JMeax1x7eo0tloFvOCBQ0zrKG8pV92IZuwGiBwWEWCjmZ+yFYzqPgj4cbcmPWyH9DAGmcR0mFiGbw0NlaLDztAPmcvNMXyu4uodoQ7yzTRt0pMvZQ/xCp/pCpE3n+T6F/qlpZF7nUmrS+txzM9MWqQ/NW1L8TJXi1O3791/Q0BNYQhnbZPXkRkgdad5+zAX2alxROxCnQX0a3TiYPAHzAgWCZibChUmG8XMW80ZuTyPfCZpdJMhm6olsu0w3iZ2StR1XrYqb9tMIwpKj793ryWQZgr15anOxNCFjYMt6KBziFtfHHJwAnO+6M9gPYZbqgU+Nl7rszRRuJ9XyTuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcpEGhJxV04khh2/dgkIIhtdTMkFChedRdm0jsGV4yY=;
 b=havEVw3b7Q2qSLJ6zay30gOLpo0dg1839xc18esK7U8J9szsuvIXikGL3VoVbh3WF+40HpZqG9A3nV/qhiRk+PdMd1Ksxb51LmHx2qhRVvO6WCK3DNd7H9c0N5T25PAJJ/YYh74MJxM/HcS+JwtMfvmGZyKFzTIUV4bPgvcp6hk=
Received: from CH5PR05CA0006.namprd05.prod.outlook.com (2603:10b6:610:1f0::11)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 17:18:52 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::6c) by CH5PR05CA0006.outlook.office365.com
 (2603:10b6:610:1f0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.14 via Frontend
 Transport; Mon, 16 Sep 2024 17:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 17:18:52 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 12:18:44 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 4/6] iommu/amd: Introduce helper function get_dte256()
Date: Mon, 16 Sep 2024 17:18:03 +0000
Message-ID: <20240916171805.324292-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: ca74e4c4-bcad-458e-fdc2-08dcd673a32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wlIVg+6sNvV0Hy/pdoLySlw/rPCb03Fag104fnEYWGOI7NsE5Qgs2ULnt6mg?=
 =?us-ascii?Q?O75YtPcn/PU8Hy1Aq+ey8cl3jXro6LpN1oXxPnv6eI7f4i97b1SoOOAfrDx7?=
 =?us-ascii?Q?7Z9R3TNzvh89CJnv+mJfLCOEr5vVClgrL5nzWaRZNmpi2Pe5lrZ3yt5K+jIj?=
 =?us-ascii?Q?ETHO+TbcwSHKBZ8xR64ae0rZnQSUuLj+P17qDHPFWXkXVqbmVisG35VCX6qn?=
 =?us-ascii?Q?WbegH7l+HyWLC1vL1v9B9bFXD29k0K+3eFCEIpSTYji9LuBEjWKVQpFzc+tA?=
 =?us-ascii?Q?A9z7UNYg/OyDhEJp/drUnjOEvhWlJwGQ5G3PGuDOhVyq9xFmbw1Dal2nhH8z?=
 =?us-ascii?Q?Xg5CKo2gVEQYtfsqetQ2V+ItSEayM2hAl8TIm5XK0Lpv7x7f7bmm/GgB9M+P?=
 =?us-ascii?Q?qffyXWwkUe5hvem3wT/Lqw3j5uXbLIl2J9obzptchyekvQBMYQUY/JwS0SbK?=
 =?us-ascii?Q?BSp0XKujqqFFmuCqfol6pe29FNDI3raounX2yS/vLh1VTaouYg+kwqAJ58pZ?=
 =?us-ascii?Q?AWkaYwIq/czZOc7bgZ94kUaPtLH/0p6iVDQuKKDnAsvrx7198SLS5KkdcrSD?=
 =?us-ascii?Q?3qa1PGYMkbfB6/jPmeZLTvLriVbKut7P2FP2v6yhlRi2q5DkyPm4uDeQPd1+?=
 =?us-ascii?Q?W216CR2eCZ8kkfmDWs2PoaBHEMvKvE0QdsWJsCSfOIHCypQFPUx87F1F3ctF?=
 =?us-ascii?Q?j5ZqJGeZSaXfv+oHW07+aUCKg//nKMK6NMIfLKc1A0a4y0Vs//yn9raMgG+t?=
 =?us-ascii?Q?MK+4Rfj2AXuhTCL8xlGUmC7VUjXqIi2dUYjnVVjIZHwRLDIpfqLmWQuM4mmA?=
 =?us-ascii?Q?HBr2VwyOkGA5CM8GvrVZX3F/B9VjH5YgqCOGLKK6T+zXMUaWCFZZehLIMgSz?=
 =?us-ascii?Q?UzGJlZFMKn5xrCpKDoopLqd3YbFGirKpkHZED2pYpqlQwWg6FFAaPfPQZSVb?=
 =?us-ascii?Q?oCEZx3Yq7z/4UZzxuv2081+SfFhjLCzW/od6Tzst5eCOWAIU0UDlEOlC/PQ8?=
 =?us-ascii?Q?0j/DJJEIan2ItBBgmjMt8l+6gYUe7W/i+/cs5NPXGaeRHf7+DUVnmLx0DIV0?=
 =?us-ascii?Q?aO85n93d0KYqLc4YuEja3s0bOLuxSe3sjr2E2aNAn5Z22Xmxg9gnW3SjbcNw?=
 =?us-ascii?Q?TI44cmjRT7Xm9xwHKaMXPNjSQoiwBNmyAgQNUxH8DE8fPpQobzezTqrvKLwq?=
 =?us-ascii?Q?HgKMFqJ1occ3spOOr/DXDta/ibHsAKMfbUruJ21AuH4930vyPT/PFFOIUDQm?=
 =?us-ascii?Q?Z+Fv/7xB3l5DEPSPzejobIT2vG/7/cDHdMs2dMHF4GVlmA+su3+NhCYjyrQW?=
 =?us-ascii?Q?U9JgRFWVQFHYRj3rIgUisWvOljJI+ZDrBaAzJ1st2b/pa0OMdbNz59MDW9nM?=
 =?us-ascii?Q?YoB1cGxW/4afWVkxPGT4Gk/9rCafuyF3l+KYpV+mKfvlpgMasu0cWZPhfkdl?=
 =?us-ascii?Q?OP0i0aUv53g0tNLtY3ro7Cr7iFuVDMYL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 17:18:52.6334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca74e4c4-bcad-458e-fdc2-08dcd673a32e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158

And use it in clone_alias() along with update_dte256().
Also use get_dte256() in dump_dte_entry().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 49 ++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 12f27061680d..676742d6f19a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -170,6 +170,20 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
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
+	dte->data128[0] = ptr->data128[0];
+	dte->data128[1] = ptr->data128[1];
+	spin_unlock(&dev_data->dte_lock);
+}
+
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
@@ -318,9 +332,11 @@ static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid
 
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
@@ -329,13 +345,25 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
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
+		ret = -EINVAL;
+		goto out;
+	}
+	get_dte256(iommu, dev_data, &new);
 
-	return 0;
+	/* Setup alias */
+	alias_data = search_dev_data(iommu, alias);
+	if (!alias_data) {
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
@@ -669,10 +697,13 @@ static void amd_iommu_uninit_device(struct device *dev)
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

