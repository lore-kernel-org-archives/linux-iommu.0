Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773CB1CE711
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624846; cv=fail; b=lRH9shUMJVBrpLoZHhjUh48pA2K9vvEqlAuP5itYpZSk5V7pU815yjcSIO4oeZEflBQlBHM4F6YPN0dXrjTNzI8utEx7F1QZYked3swfm2hjiffEwZdIGO+VT5C6jSmxpQoQbrhn5qQcXCxxLJ3+jrmMwaLWupJlIwHvefW4fzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624846; c=relaxed/simple;
	bh=2nVnvikOUIsFUodik3VP1JBoAfE933fafZNky8D8X/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sgpq1m6zEaIrvyoApnVHO6Sf1pkYuvp75+bTpfyCf/ZOCKfjqhUSA24RIfo/hLQWcSdCZ3Nz4nVEZZKkZjeX51zaKA5eDtfyazH9eFYqfwXiQAPSOgc8w00c/wQLn34f5ZbIWhohooOpUnTO3dqznP0pIxXptfVZw9vBMP0qTBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=by0x15ku; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="by0x15ku"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nd5DwerbRlFarzMulc0D/rcLrTDyncrvrXlqXkhuS2J7tsug2d7pqULwq9E8xzvCjk+9ASGuKuQw5tvoWieRb1Z7RrZDquHSEo13v7iiARFKqtpbVDx5+DUacCDkHEqviPq3eus041FEw9xU0b3ltIMEZ+B14uMaRNDoiIS+PTM3tjzLovG2Nu5/9FOOfXW/8ywq3hxyjQVZqii8BlNVLm1gyINLPS3ThvH4fDnrppr25GGHYGo7lUi40LHggeqyXQzNHn8/m5o5UqrRVdz5sT57Yu0fs9GkuP8Wc03Invp0zLaQcqtUp1Ee5CEQAKBuTe31QqlUd1+v7PHe8G7/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kICso5MGfTTzA8tSvNrzoXPcRm//xOf2qPNobYpXia0=;
 b=iruqxDAZhYNtDztHiRUqTnRS2YPEynv/URzYXAqe0a00likkSVJC1mQGAZxZQ0Ca+6cQefrSJnjRzlZq2GEyuITxcWirLGHbzBu3MqO1ilB8qQmsa42L8hK5Ms59AbCMIkdjJB0j/cDQLae4Q1T84ZekKMpXRf2m9HPkrLxYbHx1yVHh8NvAPgWUeQs/OgvFznOgqd9VeOjQPG6kjTR4rqicjjaTcgu/v6EZlH+uYlcijEpQf2cIyLjL8U6TWSwMlY6HVhqoqOth0rruuWjQ/koauAkcVuK5UW9GJP4O2sEZ8gADCMNpn0z9Dy/EmfnN3VKhQFfLpL1er3b+6x/ZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kICso5MGfTTzA8tSvNrzoXPcRm//xOf2qPNobYpXia0=;
 b=by0x15kuPLMSaAuExrZCcToZGMIZ//EQxPMIfI/BaMfTMX5fcCmPle5AF9YJEmWz4ucvJmQljZJQYbr6Ej/YJDNmgJ0v6ct8DfGHX1S7wNy8v7X5Ff/kNuHpy0tuWMvUjVLZ2rHoJpi5An7JFdg4+Gt81KiU6B0ksYlTbrAQs98=
Received: from MN2PR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:23a::35)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 12:14:00 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::4c) by MN2PR03CA0030.outlook.office365.com
 (2603:10b6:208:23a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 12:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 12:13:59 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 07:13:55 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<ubizjak@gmail.com>, <jgg@nvidia.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 5/5] iommu/amd: Do not update DTE in-place in amd_iommu_set_dirty_tracking and set_dte_irq_entry
Date: Fri, 6 Sep 2024 12:13:08 +0000
Message-ID: <20240906121308.5013-6-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 183d2a8f-bf1a-4094-486a-08dcce6d6358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M/O7OCg7WAQdLx2LhPMh7YvtLnfGNkJc0e7gK/0AVuVYOva5gO02EutMhtl7?=
 =?us-ascii?Q?DYV8BFJbns6mN1h66SWiwP4Z0YojC6bAd/M+HIEGRCIooXcdtpk0uQj7PdWU?=
 =?us-ascii?Q?VYr4ZpjvZNJjyUno+CVHx0uB8gjHNvnPVaChWCiG7+Um+219jxQB/a+z8BTV?=
 =?us-ascii?Q?Ip1AU9ZHZzEEe4BM/YkV1n13MC2kCeq+w0X0WdoQR7uCQo43HBc1F/9mBgu5?=
 =?us-ascii?Q?toswmmuflpQLxNEJn8mM9lCCxOMCCqkUWaIpstRanIShjUnhdsaV9jRViRZ/?=
 =?us-ascii?Q?ITCTRS+D0xIfyWtS5Rr767uiyNOdDy2xFZKLxooZpxa0P0sjIk1i/cpZQYbc?=
 =?us-ascii?Q?EVo8+jzWlsPE1/GNfvI7CFbK/LBf7MSdYRyuPWq2SxPme9g2oIZl9lWRFXoa?=
 =?us-ascii?Q?5HlOwTFexmlmMxwuK+iY5ptvNN3xPDC7Cj9vvchejUWkniWRp/2RlPuwByZy?=
 =?us-ascii?Q?cteyWFEkMxDjaYApIfbyiEz68u0CvY6d129XY/DLDAyEstjPq/T5coRXxXgR?=
 =?us-ascii?Q?Ey5K9m66fRwhfwk4cLAXn0BI3aSd2Ng8XCzRYeO+ojJwKEPhMbonZwSQPU+h?=
 =?us-ascii?Q?zwWE0MkXJUaXgj4MJnRC+ztblhEDSkK5NQHWVJvYa9lXxqkurtZYQWWULtpp?=
 =?us-ascii?Q?sQ0odrvkqtyuc6QJvZgOnqj5svsUrr//k01B1wb4M4kzTlnUI91iwVhAtcjQ?=
 =?us-ascii?Q?ENFk+mtQ6xAJr2qZjY/wg+E8mdlG2ZIL6LQG7ztA5iVxZNCE+xqVXjI5bwkn?=
 =?us-ascii?Q?lkQF/x+9iHxvZZobOE1HY9H1TV3K3BFzo3chJlHFeIVfd5agVNjC6LZhpLKK?=
 =?us-ascii?Q?u20sNRLuxQkwViuUXJdrYbWNSKqj/lc18F0OmnHKpTQPHOzFUovmxXrtj+T8?=
 =?us-ascii?Q?rgegVahgPGJ/xsEhk7d3iWRfqIGkXTEvaedNo+Plz6ppJjebgXAWFfe+0wKv?=
 =?us-ascii?Q?JvnVglwjdpsZeafowoYxLgA5x0AlWdgzXmiGbOwnGTLiNG77b+r7tUTEuulB?=
 =?us-ascii?Q?O/WqWvA+8fwIXjsMtpAoOkAAJmxxeSeEFzKPCTE5+Mfp1F46ZLlNbac6vz1A?=
 =?us-ascii?Q?M/jDo95dKm8XylFR4GYE3U/+lAWWqU1AD1cGIMNBzwbCntZn+S3Kex625cwa?=
 =?us-ascii?Q?QLQYmMT7Lj3EVKsymV7ssJ0ukBK6FMJTtkjFwfwxq9HkFyGyElzukrPhrTWJ?=
 =?us-ascii?Q?+xhPTfrhUnPx9YiVkapMyEiv+Ono8MKa7BASHraL4JwQbmX3/gmAySbaA7vV?=
 =?us-ascii?Q?vBCON79wYvcUPHPIPcbSmbj8+Z+XouW+5+ICJeEPgBlZYw/OR6IP/kH/d6JJ?=
 =?us-ascii?Q?g7rYfYc6Ei5kjQ8/y9/2qPaV+Lj1F8u+DDdcbAUgfdD9X2xd5O4lgbe0VIsq?=
 =?us-ascii?Q?mfKKpHua4TFeVxoleA83c3pJiA+tZn3G0m8iJ/QvWJkTJJgHq4MoUU8xZss/?=
 =?us-ascii?Q?eegv4VYZLnk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 12:13:59.2473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 183d2a8f-bf1a-4094-486a-08dcce6d6358
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614

Update the DTE in place could result in data tearing since the AMD IOMMU
hardware reads the entire DTE either in two 128-bit transactions or
a single 256-bit transaction.

In case of updating only single 64-bit, it is sufficient to lock use
WRITE_ONCE() beaucse it is writing to memory read back by HW.

Also, lock the DTE before updating.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 42 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 15eb816d4313..e9cfe9238e83 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2753,12 +2753,12 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
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
@@ -2767,16 +2767,15 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
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
@@ -3042,17 +3041,24 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
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

