Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33661FCE
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 04:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274509; cv=fail; b=r2/0ofX/v3ICGjpuGeUj5fNHmbF/IH4ncpitPR6fxz7yZLC6Lr89Z0nnzmpgPeHn/Dq1vKp4P09oe7aNrrSONZkYPEyK+z/I8Fhz0KyMs2v2D6Pu4vG+PKNAPZruGRd1O1a9RF+uOtehOwl7wpZoeI2Ap9tUfkTj9zfT0iyVqlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274509; c=relaxed/simple;
	bh=G37E1vGUauxMG8WBxbH4KDe16JKZ7dpupVh9Ga9sLHA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iutRYWNZwBrDPRw4JvMGcWVc2bg0QVkzMtf98kHjiErl9TFq+fg1x25xOigQ74rPsb/4CG3O92KjDkmDzH1WSP/Kr9TtNiHC2eGSVKR7ZCjE2pmwlv88T/ThXcN0WzCcTkjkrIvNsZkB4iQFkeIgmeuMPEcK1pnunk3658c/+0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gcg0REYz; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gcg0REYz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PL6vyhde835ePU+kb9lzyjagV2xgN7QhBOwfikcnDPgfKd3hMlTofk3DqIoVa1HYUfbtJYAH8x7MSW8AJTlOSV8/6rd6IkJzL1ictC7Fj540uy5kq9zoC0sO5gaBKjOB5HnEg7N/vTkWivrtVHMPp+QnN4KajVKh3bEQGrI+lcIHcuCB3bhw4YwBzSlWsKPCmsSE3VYHSc8/jrMillHT59MA8TX1bk8Ukd0XkUL4mkcg5dSuLpWKEOp/qI85AAAGrX29UIGfD0hQ6M9sO0ePYAmCqf7G47kIfHMVYHuauEod1MECNamjvCa6scItw7375vGTEguYzTVmAK9BY4bFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcRMiMEDiDOE951lUW1BZrwFdDPIyAbifOs/sZWClU4=;
 b=h3jWnvHCox7Zs5pWn9VRNNiIgulpUKhjhCSaegb0U3Q9V5Y3hX6Am1rBEYsohNaNGsaQMrBDxlbODnh8fGEvU0AdDfvH71CJiajKyg/ceXfLdczVxyZnRyqYmErJJcs3MftGwtLQQv2WAAEefD46hLhlA2yZytpkR7Job/BO7lQbJMV1hN91Wmzfw70IwTWjRrxTEBEGu8TvJ8vE5Mx/IPVKwdOhXdUy273UOD6gU+XB2yfKN9lV1CjLYwHmW3OQJ95Bj5Wwxr/CFfI9i5eCnFlK3zq/R2fVfx4QY6W02TriqIOSPV73gkAEtyfEA/VxpPOsKPFwPl63TbX+Ef30BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcRMiMEDiDOE951lUW1BZrwFdDPIyAbifOs/sZWClU4=;
 b=Gcg0REYzOzyxk9Dc61OL4H8UOki0JdBIQ0FpBb90vCsLaduQbvd9UgTf3Y7Cn3Zeu2mr2bh6gsOto4ueFDVolndHwSs1SuGySL9rdOyga11G5hzeuTNiei2kpASUonQiAqcsRHhA5W8hxezse/yjJYA7+Q4ns4EC6kdApLz12jM=
Received: from BYAPR02CA0043.namprd02.prod.outlook.com (2603:10b6:a03:54::20)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 04:15:05 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::4) by BYAPR02CA0043.outlook.office365.com
 (2603:10b6:a03:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 04:15:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 04:15:05 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:15:00 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 4/6] iommu/amd: Introduce helper function get_dte256()
Date: Mon, 7 Oct 2024 04:13:51 +0000
Message-ID: <20241007041353.4756-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: d20ef215-440a-4946-bc0f-08dce6869f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ZkB+d+917tj607KcB9a3M1Ta0MBrjl+7BUFbPjiqv4PXURUjvA5eJQQOdKV?=
 =?us-ascii?Q?+dHjzIUV6w2Nlnb/DY72E9R+Ww+/AMNyaeJlOtafquH1WjPZKQ6awszVOfAF?=
 =?us-ascii?Q?+AJhx9l3iGK7zy9oHWIlm14zPSejY6vbwPwKIHJztzNL4IHThCONrYB29lo8?=
 =?us-ascii?Q?B72Dgnr/+rPxIa1PWiWxLNpMBypn52GdoERzoTsfnQJQCcssY7YkifW+lQMH?=
 =?us-ascii?Q?ckf+t/ImNaeYFYepKRUlDDh2D4EAY/CJWv2X2Pjy4FA2mOBw1DnbmK7DL9VU?=
 =?us-ascii?Q?VvzGQcdktuoAYdaUUJqwNbIhjbLXurIJHkwFbiwVj2xQEE8uLPPlJ+pdOwcG?=
 =?us-ascii?Q?dFcgoMI0gZAw8WPvAyB40wUhZZWtcnIqOzDgxaxub7pOB5WshMNb0GOMtmhe?=
 =?us-ascii?Q?iwh4LNNBLTOR4g7Ss6GucjitFi8jseYo6V2MrJewjFudEpME3RTVGa9eu2jB?=
 =?us-ascii?Q?JhF/Zpf4Fm3fZaZBj1bYV+UFBtPNE6cE2i5qm17SgxASqEfdohjN5VAxPRmt?=
 =?us-ascii?Q?XWiYd4dsFK+MZb17lls/0LPlnGhNgt+yVxpERejSdgZY4QaZD4R773YiRyTN?=
 =?us-ascii?Q?gKTKDKf0VxHTo+zvHhf8B8b8ubl7GgsJtjuXvlYomeqtGkC0repRwLQEh0i/?=
 =?us-ascii?Q?1lSjDY9yrrIxNIgyCrUAx6jqi385VROBQXSTT0k4vrR57Y6/nYN0/ogcfgXp?=
 =?us-ascii?Q?XSRYNZLdFN9y9YSeg3WMRkRVK0Sg2J2nIo0a2TdarjbKerkjt1p7VBvQuT8r?=
 =?us-ascii?Q?2RUCmHKi1O7sKeAyWWnAExhAleOcsNIpJqNBCxIdn4VRsKeM7CrXHGuWbCGs?=
 =?us-ascii?Q?QgTYukPCSxIyA4ynSUg6SpIu7Q4OR4wPKHqbhT2tRJEy61yW9G2JF8kyHbB7?=
 =?us-ascii?Q?Sy249SFRLBlUddAQdErQYrXAIvEuV1/5MDruzmSui3UYiMoXZuNYRTbeU94C?=
 =?us-ascii?Q?Q44RV8s+CorlB7+9hpoTIb6VwcZWY1cER4JfKugvgLRviS00GFcx+KGJZd1D?=
 =?us-ascii?Q?4HF8l/V7E8srR5h/QcdYZihzNDK11W9S89lcCqpiTemp5fqM/7uQF4DvkDkJ?=
 =?us-ascii?Q?wlRvEGhlOtHD1zQzIH5TJ01lo5Pq49L5TvvnFDSMD0LHmzn+Hq/s8vYIXcFl?=
 =?us-ascii?Q?FFgE1iOsFo83OJH3N/rVhndymv0wmQOI/i6PUO6K5ip2qp8tvG03ZzUR/8bq?=
 =?us-ascii?Q?aoj+zkhSBEQWRunmbD5LDCBE3Tf1+ZwsK3a46r3oY3rjaDt9Wm0XX0ZDZ3QY?=
 =?us-ascii?Q?8esVVSIM60jhrbtjaDnca78N8y/MRzE6MeVsB/8Bvj7FEfaiFQtHRAnlWsHe?=
 =?us-ascii?Q?DnL0/DQv34x3UfmcThNCVvHvXGhPUHcl5NNGCpMz/6WVxrDCmN9UNDw4MHlN?=
 =?us-ascii?Q?aS8B71QGHRqJzOHOmg+gPj8lNbGl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:15:05.0031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d20ef215-440a-4946-bc0f-08dce6869f40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561

And use it in clone_alias() along with update_dte256().
Also use get_dte256() in dump_dte_entry().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 49 ++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6fa2f5bb5156..87a7c9dd86d9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -187,6 +187,20 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
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
@@ -335,9 +349,11 @@ static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid
 
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
@@ -346,13 +362,25 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
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
@@ -686,10 +714,13 @@ static void amd_iommu_uninit_device(struct device *dev)
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

