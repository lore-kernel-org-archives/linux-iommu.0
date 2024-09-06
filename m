Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995F01CE6E5
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624842; cv=fail; b=T3UkK3JG8fDZsJW1pEeOYboc1m7IuDlf19Wqq1gHhznLFHDTwVNaA910SyP8qGu+z1zGYgdowvjj2zQD7DUAz2lLnKjvj9VwovAzIgv2zTFDxrtD0dl38u7gqUBd54vQzX2YU/FVOikUsNETrR75NAUWHa+HzBuWZ13brf3YLSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624842; c=relaxed/simple;
	bh=9tLX/OkpB56SmFAAaPgZKuqtEsQkGjepCyACatzsPpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3JI4StXKN9cTCYNb/85ab75m5zb/edyr5afvaiDpxPDiC0o6FHSyyioMuvqthrBdAMJ84HZg1JrdyoCG4mbK3CMtKF0xGlaziXvAdJhMtw8Y685AMmNJd0njS5fEe5lhsTr+mRhO5XqwD3d+lhLjLTACYLpiQgBcjG6FdBQXnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KhyCyVm5; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KhyCyVm5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulZZtZ9PqLI8JFuX0HcomCnDFTF8b+PrcxU2AMPLF9WvS5MzxDUhW5PfiJDgZy5oqgPAP8Xm/KlDb3PxbgiI1tonbDH5R5jh47Hjwn1qmeqQOXl3nZT8Y/dwv7dJzzR+2iRM6/yU1yqjjgoeFIq1KlZ841sbQq/PqRH55UciC2DDOWMTxa3WcxPinZNz5vFOSg+/KmZnW1x3CPtCfIE5YGmiFmqscmv/Kk0IWnp+zsW7Ogn9oUA7WmoaAqX29Wm4/pmEd5q0Nu0781nJqjuNsUul5OeHOuiJVfyfmLqoWtIdj/fpblBqHGJ9IF4h9LE+z8dE71TmeKX+PkaSfe8zJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dopMOQxtKGeTcJ8vMSkuhoQ9X5+NPPuAMMx6APmQNH0=;
 b=ZgYYCWg6Texsghzkx5MP/7duF1plaze2NdnPueUch4p/9MvggPbjmcYQ0sHPBoo1M5DjYo7PBaHKMMJm29p/1d7PVGlD6d6BLC9EB2NRafVCMLfqT1hxl2kDHKyjzlaLdjguWnngPJEVcgaCUuEQjLubV+6bFzLBmM+MlCD5undJZ5DuH0jWgeeI9GryCvMWc6L7pRTH300ZEVR0bEYLcotecg7fLQCNvbroqddOLOD10E6Pv/2imLFQHTflfRk/j7ua/s62fpThszhkAv5qgeu5yF3gr43LE+sNN3vTCwJtzEnjUX1/hkJahlatLmlh/QJMPY5ee8XFRhyWBGyu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dopMOQxtKGeTcJ8vMSkuhoQ9X5+NPPuAMMx6APmQNH0=;
 b=KhyCyVm5PfP0OqRwqNDdH5j6HIeHxRm14gGC5hS/UGvGByLaeUQCVhJyp0b92qbrU/Od8+pqym1oy2s/j/xHVYHx3l74eeIQtqwFqzpEKB5Y+lymcjwn5v6ZASl5soC/b0P89HlauIAq5hhLBrmTBWw21TWyFJJcb1CS08H4pAo=
Received: from MN2PR22CA0014.namprd22.prod.outlook.com (2603:10b6:208:238::19)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 12:13:55 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::f3) by MN2PR22CA0014.outlook.office365.com
 (2603:10b6:208:238::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 12:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 12:13:55 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 07:13:51 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<ubizjak@gmail.com>, <jgg@nvidia.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 4/5] iommu/amd: Modify clear_dte_entry() to avoid in-place update
Date: Fri, 6 Sep 2024 12:13:07 +0000
Message-ID: <20240906121308.5013-5-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a5778f-6ff8-4924-6dfd-08dcce6d6117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LXKBTh+wxdj9cRUvrSFj1A12t8kUjGnmN4HzMIGfE7NkXympqUyTjMIVPLhe?=
 =?us-ascii?Q?1Hz+t7Gj9HrxTwEWva0R3mSqRT25153BEraecA2VYwe5DYEZw/V1oZHihGkL?=
 =?us-ascii?Q?WOyDC/pwbwqdq4EqruzK92uBsgI/CwIsnC83k4mD5mUN/b/FYBGWKY9arEvF?=
 =?us-ascii?Q?BUihAZ+zn6pq43NDiCSySzPD61dk/MWaJevxWJahy3Vm8KMbiD51IfP6bKxc?=
 =?us-ascii?Q?Qepu+yEN6FRdLJL8oZlbu4hPufbBHlIK4F5YhNFi8LVEyuD+VUqCz7pOcmx6?=
 =?us-ascii?Q?ToN4++36teN8BWC+9MENy+NoNcq3Zf+7/th4KE6hmSaE775uzcWcncslir9Q?=
 =?us-ascii?Q?K9clyoA4eEqoQBZuuICZWXK2JW9MpMSWisZoXEH3hCcv9wc9zVHwr5GKT15v?=
 =?us-ascii?Q?09+2lbR4YcLqX6EgjCfAB23XJeKW8HrbNjzSoPsmuNIz3/a0q/Y862yl/Yfh?=
 =?us-ascii?Q?6w77/bRhrNquBNDn0haJh5M6ggO+X1NFqmtY6LXXn6tRmaN3Qz8vQCcZO4Mi?=
 =?us-ascii?Q?pAkFlVGZT9oX7QQ6+R5xqHrWXhzI87eEJIlYIj2cK8TIDBbFGoU0qVSIREEV?=
 =?us-ascii?Q?b/DmmBU3OSYWmf3gTrS2ixM7sB2yJCotwkPRMA0W/kvyH1KRMj11ddhQthae?=
 =?us-ascii?Q?NKqtpYivD4NsOIYO7IECylmiZ+Gh0yzdFHRokP5+/CT89ljb9i77HwWgmKvJ?=
 =?us-ascii?Q?27E7vMFbNYVdwPTXLTEV05RuOPnTiWmwqVdymgvdavAphcgWtrKWqcbGwqSU?=
 =?us-ascii?Q?3d5ohyLhIJkq72DBPGI/umx3UM3ZQnJWlEt5w1drnp0YusS14ZARvAo85FLB?=
 =?us-ascii?Q?zz+H1GEFih/1ZzXkoTgC3KIvkyN1S7dFRQU8rwZVGegiE5ezk7pwS04zqnOE?=
 =?us-ascii?Q?E0sPg2ogoUn0Bfj8C7VmlATIaFvWwltt6ddqbsIFUm1HRN+Vpt17gyOLziY/?=
 =?us-ascii?Q?hsga1sUj10OPa14mLVAowGj37Z82zZIlDAjFXWbYunBDvIkc/240EsrXp+1u?=
 =?us-ascii?Q?mYvpZBEi4fbhQkZha4Kd6bJ7da6t+L+w7bJ8EqDdAWIuxwVSJhundopJK6kp?=
 =?us-ascii?Q?87AdV8B6GomrgbsNCPxoAJJ/TznhYnc5qcTkIknqf4QZItBm1ecTIdudk7mx?=
 =?us-ascii?Q?5ICHvGplE0ZnzKc0FinoDEL4jAeX6izGbUbXz4IYNVVT/ILKqW/0uuMlhPjw?=
 =?us-ascii?Q?HFhGVCsuGlX6pmZGYG5BojSd+d58mBqidPw98WuXTEAzWP/b+e+xBW9bT1QW?=
 =?us-ascii?Q?GqFn1bvagAb6veuUl9b2vBnJ8AY/p5Ra2e1/rGuKZWoaNNGHDovXwISitMry?=
 =?us-ascii?Q?9ANrapw1JaHrYtk31cRqiTfaE8+etSl1sZN7C9PMxumYFxftIJyYX+cUOyVZ?=
 =?us-ascii?Q?tEe0BpnXdWUc2G9kLZxMAUAtklh6l+E4lcwvduLNrKc9+p3S9Bz+IDlYGWlV?=
 =?us-ascii?Q?mweG5EXDnBxKd+WVHnFlobPdYcEkUAOK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 12:13:55.4669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a5778f-6ff8-4924-6dfd-08dcce6d6117
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726

Lock DTE and copy value to a temporary storage before update using
cmpxchg128.

Also, refactor the function to simplify logic for applying erratum 63.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/iommu.c           | 27 ++++++++++++++++++++-------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1836da2d9e60..81a994471a30 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -425,6 +425,8 @@
 
 #define DTE_GPT_LEVEL_SHIFT	54
 
+#define DTE_SYSMGT_MASK		GENMASK_ULL(41, 40)
+
 #define GCR3_VALID		0x01ULL
 
 #define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f18ae6c077f4..15eb816d4313 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2025,19 +2025,32 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	}
 }
 
-static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
+static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
 {
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct dev_table_entry new;
+	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
+
+	/*
+	 * Need to preserve DTE[96:106] because certain fields are
+	 * programmed using value in IVRS table from early init phase.
+	 */
+	spin_lock(&dev_data->dte_lock);
+	get_dte256(iommu, dev_data, &new);
 
 	/* remove entry from the device table seen by the hardware */
-	dev_table[devid].data[0]  = DTE_FLAG_V;
+	new.data[0] = DTE_FLAG_V;
 
 	if (!amd_iommu_snp_en)
-		dev_table[devid].data[0] |= DTE_FLAG_TV;
+		new.data[0] |= DTE_FLAG_TV;
 
-	dev_table[devid].data[1] &= DTE_FLAG_MASK;
+	new.data[1] &= DTE_FLAG_MASK;
 
-	amd_iommu_apply_erratum_63(iommu, devid);
+	/* Apply erratum 63 */
+	if (FIELD_GET(DTE_SYSMGT_MASK, new.data[1]) == 0x01)
+		new.data[0] |= BIT_ULL(DEV_ENTRY_IW);
+
+	WARN_ON(!try_cmpxchg128(&dte->data128[0], &dte->data128[0], new.data128[0]));
+	spin_unlock(&dev_data->dte_lock);
 }
 
 /* Update and flush DTE for the given device */
@@ -2048,7 +2061,7 @@ void amd_iommu_dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	if (set)
 		set_dte_entry(iommu, dev_data);
 	else
-		clear_dte_entry(iommu, dev_data->devid);
+		clear_dte_entry(iommu, dev_data);
 
 	clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(dev_data);
-- 
2.34.1

