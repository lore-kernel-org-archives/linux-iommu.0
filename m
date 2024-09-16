Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37BE158A1F
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507174; cv=fail; b=a/WcOvPJYqGuznGbhyjr4rhCAmw6LvExqFCNz9uWBhu22k5FX3BXaq1ofSSDt6HXd5fhcKr4t2hRzY7Zvf7Rgg44YYTQ5IDzS6qzDbdqkfdr4Z/N6ew14iG6jM5j61Z7alo41MbjztpoJrgJ9dkf5obz5NbOUo/JSPoRJq5Ja/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507174; c=relaxed/simple;
	bh=c8s5quovYTwGOd9TcYkHidZZ9gIp6+84+frXQ6a9R/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtUzahzoc/XXOIKmCQHPL0mMxLqDrq0CPbflVblZ8mcHpAiOzu//7SssvffItQaK9DArKqs07XCgIrpA5WtJ5C8IaA4VKHcecUriWPtf20KrY4SYEBAaTacB12uJdFe6w8uWj7IurBmX0DLWMUHwHj55r7Tgqce3xSP5IMW8WYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yh4qMJKy; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yh4qMJKy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0P8SeB33yZiJuuD2AzY/SQazX8c1b3+oCR8LSSt1auXAhs0OVKpzeT0mMGorWZw6Y7T5jvubObax6A9et9HlndJ4Y7CoTQSyUc011tTcSQBFJNUtB3Y7Y7r6bAddfWnvq7a+RaI3KhwOL/vG3xYMJzHDNlNsERpAYK1aykaVWCeDCkO6+ANCXl+BDejo81JvpzeRkgktUnkskAKRHNfivxyDyHQFkLw/aKIbLTScHFR6wRKgor36afNi6BBeyM3C0fCcAelyVHWovl64oPfbDqic7dIpO6i9Yt6Kl1p8VqaDi5tmhL96J+3mmkPdAwdWBxaF2KUQcmuYu02+H9VEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHLTDxlXXS8CyTxVxgeZKLdPirx8ZMJSKoD1ADJpnao=;
 b=BRFHqYncBzJolLru+lTvHWo3TN4ysvAO12ZeVZGDHleIQeTHg9UQVCXeGjdXGfkKcRPBLFRDkqCQP5aGU41xZJbOUNeiUXSTJfq7vRJ8/I5Pi7rQYWh+4y00oNN45mxz9ddU5G5C0zFz53cCjByQVokjH/EIqmMDM35Dn2PEQMBqoSlmRCsmcEFpPepnIWXVMw84Kq+P6gkfIdfQnZvrx/pMVy5iYTf7gAoJFKvUGLQmL2TYbs3zJVz1zyLkh7dTJzk31+pYdsRlPveHyPf+E13fNkVt4LAhR0DxYmMnv+oA5+Hc2h6XQSugyqT7i+YLTWpZjGF6sXFAhspuQ6vjYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHLTDxlXXS8CyTxVxgeZKLdPirx8ZMJSKoD1ADJpnao=;
 b=yh4qMJKy+jBp7E9NJiO0A8JX6QbWzHM7Q5EqZTNA57JeqEKfSGqIb/kXRW4nxr+TWYcXaBuhBk+dyUv9PyL26NPSPUHJN80iLx9RZZXhBZBJ9Pf7GfM82x4rbbKiqxgWKyBDQSRsTCbzC9/NXIJVxJ8E1WZucEGueEthVGCjdwQ=
Received: from CH0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:610:cd::11)
 by SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 17:19:29 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::7a) by CH0PR03CA0096.outlook.office365.com
 (2603:10b6:610:cd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Mon, 16 Sep 2024 17:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 17:19:29 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 12:18:51 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 6/6] iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()
Date: Mon, 16 Sep 2024 17:18:05 +0000
Message-ID: <20240916171805.324292-7-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: aaebb6fb-5e70-4baf-dc00-08dcd673b945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YMc+ZTV46/pqg7LgQEKmGoeVI+WDAG47dmUqQU08BrSSCaILOpP8DSmhZeus?=
 =?us-ascii?Q?sVHAyptt4Wuv8QmiCIEZ5BkX/hzT4cPAAWEaaCh2Ii6c4cGzA+069sZ435/K?=
 =?us-ascii?Q?yG0uOj4mzwEXTyfK1RbaMW89paNfbikDDALNuvSetrgGCdTShzvvZKJJhbNH?=
 =?us-ascii?Q?z8hw3L2DBY49NvxEQJPvEp65/x2HMa5Vl2Sqsp5Uqv2SLSlaqLqQFbpwPXzW?=
 =?us-ascii?Q?o29qyyidtsQq6Ph+padFmreeNTW1hT1P/Za5SDPGxh8vKPnvuGIEXunXniyl?=
 =?us-ascii?Q?0osQRtYuoMOizvJjMA8LkZQahjd4ymOVytH8Wc1OWkDRNmNegaAqTF6hcs0E?=
 =?us-ascii?Q?oeF6hYwXHRIBq1i1h58sZcpHWW/PAaJE7faAb/qc8+Tqw/mYT1oUrcYuhoZq?=
 =?us-ascii?Q?tPwsLkJL1sN2v1R0GCQM0B0WGO4YrX2RB6AuKiJsZv9xGSGomokJ3msmz198?=
 =?us-ascii?Q?vuvBmaMuPAlP8546nT+AM0BxVVmXDAhsfPP3wWNGxhEPILLafXptdBzzabkB?=
 =?us-ascii?Q?qMwjNZtdl2PcQy7rTd42WyqtkUg1w6t56+AcXTU8eoy9Wt5611JcoX/buaWZ?=
 =?us-ascii?Q?YriFw01d4kMAgZz7Om84sS+CLDUJ1F/wyKZ0rv7roskGJXr7hYFJyoJ3rOFN?=
 =?us-ascii?Q?Kf4WFVIn+OhywO+kQtpb9fMiwbU9eV+CtBPVOqk4Za361MKlyKNInSb//ist?=
 =?us-ascii?Q?cOPpEHAfgdqW030yvE4xqFCyyMWe/am0V86lfhR5HKeubk21byeoWZYTImFd?=
 =?us-ascii?Q?jvNN3+QSw+qJ9O9fUBsFMZlKlaxYws04l5KrZyBv+iO8bsn1n1TJky047KHh?=
 =?us-ascii?Q?lMThOOzvoNwqVU4DF0m9YxQA3aIPI9fLTTdH3kSIVJ+JOOYqlCxKZ0E5MvjP?=
 =?us-ascii?Q?a4kkMaJaQ21DAiwb3QMJO7l8I9iC53suxF2bWKIcbibRk8T35WL9og9+zCAO?=
 =?us-ascii?Q?rsxU5nbAI929kRNnY31Fq05kx6afd6E2NgWV6fTj0Acr6363ozwEKsH4Uzy3?=
 =?us-ascii?Q?+gnFIRYfCRi67Dpe09KOkaxvarxBWF5RkKcTAv/qATKwVDXKq953mglNChaH?=
 =?us-ascii?Q?rlmV0yyr1hOOZb0qj0nOkNyUf49tWgZjpoerUy4OEN2mcH0nBfjrD+AIkl+J?=
 =?us-ascii?Q?NBJ5jlHg2HIXReOVmAtnGBLTUbMA96K3+Z8hwOM+1//BWclMorD2OlyNluHt?=
 =?us-ascii?Q?Hbwu6qTkpPooA5KdX5EVptRiZFoOxKwjbKibZsvWQeqZAAiFuBoP7tgmL1WF?=
 =?us-ascii?Q?hqUR0cLXPjYTwe7cyafmYeoTI4lfpyafvrnKFRjjE6REsFmuo9n2WfdW9mpg?=
 =?us-ascii?Q?oU/CxWAfFy5qtCzFSTUIvIYE+SoRGerM0BaR8OtRKXQNgQV6wPCV1NCKKaX6?=
 =?us-ascii?Q?sKU/iCqFUB3L+lpcG5hgQ1tITJBcCtgrFFUvkEuNYzcuX6+s7WH2YoBUpVHJ?=
 =?us-ascii?Q?pLJCp7ikJ9mu4qCLcG0Y2DIZ0K+E+Ep8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 17:19:29.6932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaebb6fb-5e70-4baf-dc00-08dcd673b945
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979

When updating only within a 64-bit tuple of a DTE, just lock the DTE and
use WRITE_ONCE() because it is writing to memory read back by HW.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 42 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2df679eb61c9..d69b0d41e93f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2813,12 +2813,12 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
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
@@ -2827,16 +2827,15 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
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
+		new = dte->data[0];
+		new = (enable ? new | DTE_FLAG_HAD : new & ~DTE_FLAG_HAD);
+		WRITE_ONCE(dte->data[0], new);
+		spin_unlock(&dev_data->dte_lock);
 
 		/* Flush device DTE */
-		dev_table[dev_data->devid].data[0] = pte_root;
 		device_flush_dte(dev_data);
 		domain_flush = true;
 	}
@@ -3102,17 +3101,24 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
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
+
+	new = dte->data[2];
+	new &= ~DTE_IRQ_PHYS_ADDR_MASK;
+	new |= iommu_virt_to_phys(table->table);
+	new |= DTE_IRQ_REMAP_INTCTL;
+	new |= DTE_INTTABLEN;
+	new |= DTE_IRQ_REMAP_ENABLE;
 
-	dte	= dev_table[devid].data[2];
-	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
-	dte	|= iommu_virt_to_phys(table->table);
-	dte	|= DTE_IRQ_REMAP_INTCTL;
-	dte	|= DTE_INTTABLEN;
-	dte	|= DTE_IRQ_REMAP_ENABLE;
+	WRITE_ONCE(dte->data[2], new);
 
-	dev_table[devid].data[2] = dte;
+	if (dev_data)
+		spin_unlock(&dev_data->dte_lock);
 }
 
 static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
-- 
2.34.1

