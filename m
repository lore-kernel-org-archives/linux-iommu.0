Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696651CDFBF
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400224; cv=fail; b=IWIxuvdNZK+MucXJ3I1TW1lXwAw0F1jV0HltUPzci1VoYWeUCYRyccuNL0HqmPYG+pjmss7xuTo8AaRIIclgsDWIlXvQdVgnvs6Dp0x8mMXxjPp27SUMWME5HxDZwzur1zY6eJZN/v1JUAEvsOYDONQj4f5TeFsOEmUaVD2AxLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400224; c=relaxed/simple;
	bh=Kp1IURODHt8hjZ10eon3/l0oQpMba1l5WYAf6ZgPlEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvVDTk+j3uRJA80anTN/Uac/npx82Zrf2zMcCkxn14gE64Poi2FDygKFhrvGuIUpL0K+6mQlKSa9QNKjT9xdiAz5EFWZ7DFCElhKIUD6GE5fL8aD9+uNeIViR553UD0o6Ox9RxL0V6E0FpM1AbT2aGURj/Dlk9y1ErUlUmI+oxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tZbLEKtX; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tZbLEKtX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcvtPFTJVyCIiIUSPzrHECMq2EYwI1Wpd/v6qxnoAzKxr9BmJ0ivCKRSDkbb7OjhYyjBF6d4GJ00xJyo4V0gCLYnaOnsmYNGe4zkJx0+TVmydsSgt1kMKOVkjhswR/KW68GwkFjjHioAe7Q75FXQxihCzn2OWDhR/u8KtRDI5MRW5MUyJKX7gks14OTjp1I5v1x5z+HQHg1qti6wA4WmMmxiENBQyDczU2SFXtkuvuSPg0rMaxexmmBqtj67LDkK8mmAzy7ieFO56JvpRB5Dy5MG5w8Wi8ZRhwIpVQxjrnLmhKgHH+PP3PXz4WYvSsslOIx0RuneXFwwQS7mqMYvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weFHvm8qi3saXKeoEEAEJnFSW5q6mGRt/q7EWQh5YB4=;
 b=RhxLYv0O3gEKaKda6kCTKS9jcu6mB/kH+3w1a8+GddXAhuzt3Q0d80T0AmEbZ3ZyKQhxsjZl6b6Y4rPX+IGyL4f3LI4oosgpBD7Kw2Y7rrz3DWTN1esrpih3H4eeTrcX8EiRlLsYZuMPQeLhAiUlWfjc7gYak/kSNKRTNGBSp0SBlVW6onkzZrFEwyRBDdeJzabXXTZ0pqHYtR0pJw2eq9l9JiCBxQdeF1VT4afiEx2CAYe4I+Z51yRoB1RDcw+G66DLLOlt7f6nlOMYr3PpSB/2Psg7KRyN4nKwtp1f7DrcbRZHwtKOHZREa94zBJs7uqXwPdu/6WuLUUBQk57I6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weFHvm8qi3saXKeoEEAEJnFSW5q6mGRt/q7EWQh5YB4=;
 b=tZbLEKtXVhh6/OCkYMKTHYtlXt7r3zozVXb5ngCBku9menuhaCofWQgtj1+f3ngeygEtCZBHINhV9+TJiNI0W4tF9yG24KFDEHsxyxr2SqeJCHkYHSIrBcurI3s5NhjFWldD5E0NC3ZPOx5Hl9YPVXOhF5LDE3ZMc/eEGVjGX1k=
Received: from CH0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:610:32::8)
 by MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 18:43:39 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::16) by CH0PR07CA0003.outlook.office365.com
 (2603:10b6:610:32::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Thu, 31 Oct 2024 18:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:43:38 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:43:30 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v8 09/10] iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()
Date: Thu, 31 Oct 2024 18:42:42 +0000
Message-ID: <20241031184243.4184-10-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: edb603f3-85fa-471d-3477-08dcf9dbef2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OGpdE6gevuSyEeb+nTJrMLZW9jzUA27qVaFN0d9JNk4Ne/r3+ZhyZ52uEz2t?=
 =?us-ascii?Q?hF7ySgt551sH2/iqUP3Uxe2d8Qg0gDrTaGJgJBjx0Mxzu3olEsYJ+qMx/tt4?=
 =?us-ascii?Q?sgKfJl1L7SLQphnbg8qoADNEi9Fy/z7rsVCWPyLPIvmOZauKg7CdwY+V7tjp?=
 =?us-ascii?Q?Rz4YKya5vuVPKYIE5yhlurQZxHXhzIya89ay7mTzkpAY9y7nTmPNjfdmD+At?=
 =?us-ascii?Q?xbaZPJJuofsa1futqBEQrO6WQwow3JipCD+gyprDm1lfqqj3xzQaFmX7MG18?=
 =?us-ascii?Q?LCVSYyPRV8KpEJ+brPGacle3+MujDRpFjaZvOn/5tfAp+iz/LclnKVuiFcgH?=
 =?us-ascii?Q?3kss/d5Fh6np48Gxv8zqHHcqf5va5eznEEqha7ElAiXWo6g1DHyHi8ROUVzO?=
 =?us-ascii?Q?ldlm5jKn4LQbb94vatX0oNG6M21go1U9qZ990lqQejAfVOMwptSFA+UNr73c?=
 =?us-ascii?Q?jRFqwEc9Ykx1+7TAgh201Nm0HrdPVoFCbAmkBSbMcZMFPPfpruU1ja42zjx8?=
 =?us-ascii?Q?jD99ZvFPvwTAop5Q2jba4EaAdH+/i5MaFrFLxge8bq5NuWRpbzz/4idpO4wn?=
 =?us-ascii?Q?GS5qSn7Bxa9Cu1qLvpqnoMaL/NPeL32M48MVXzgmtX5CXKD0IDcgA9LyMAsn?=
 =?us-ascii?Q?MNq54elRjSML6HAgEJljvX6adLO+X8FcQj9oU2slP+5DdExq5wQE6K5msrnq?=
 =?us-ascii?Q?3cXyEG7iqzP53OsPlpGxmWYsEwAbfkC806mugQMH/KR3Y31HevTuSa5ejzh+?=
 =?us-ascii?Q?9FTPK2HlUZdT8cGoQZO0vYYvEgTKmSfMRC4V2VZehvKaJq6GH7GmLxxGUiRz?=
 =?us-ascii?Q?nHDtbxytbsE2GE2KblQJCv/74Sj9JMxqnw0n/yNpTZ3SHyxcMnoIVvYQ6Kwl?=
 =?us-ascii?Q?EnYBkY/NdjBUc4HLLoF3s4NRGAXGWEhdq9BrhaKZ8li2OkMKpI/BggMCIODz?=
 =?us-ascii?Q?0m0DyGJM5BdmuQlruzSepJL9g8MFgi3TKcTXRpIBQPcbuc2dOJceWoUNlwKM?=
 =?us-ascii?Q?bD94jGAby6Rl1eXI5dhWurIt1P04nK5h5k/hXmxZt67KvCIdO03ONC2LS6m1?=
 =?us-ascii?Q?HW9bJD66leXAQIySJ6j54gytyHaAasJZHlHhMavDBVWYL19PJfdGQtVDY20c?=
 =?us-ascii?Q?toWm3g2f/0VYwfXbMSl7N4YFRaB6HcOYA9zbFki6R4mkFNtosOQML6Aagxxv?=
 =?us-ascii?Q?GnHEY1lgFSGsgXBL9uYUF5tza12CBMR5Dx+Q18lDuVb4gYAhwTVaWSvKe1x6?=
 =?us-ascii?Q?VqHC3+nvthE+2SXp7wRNjtUOKiCG2VtIR3Bu6VjkB6qd/t4kUizXQPkWAQ3S?=
 =?us-ascii?Q?x2BAFiTc/hRNCVHtmIoz/UguMIUZ4oTvyhpEpDS76LtHcpTfEFA1cnKiQ7p6?=
 =?us-ascii?Q?0N/qgTRhCUcKrsuw1XXdawU++9QjngBs2GlMNmyoDD8y4dfAvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:43:38.4832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb603f3-85fa-471d-3477-08dcf9dbef2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957

When updating only within a 64-bit tuple of a DTE, just lock the DTE and
use WRITE_ONCE() because it is writing to memory read back by HW.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 43 +++++++++++++++++++----------------
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 25c630bbcc0b..3bdceff30abf 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -179,3 +179,4 @@ struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 #endif
 
 struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid);
+struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f0ae0d7734b5..bfcf195736a5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -333,7 +333,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 	return dev_data;
 }
 
-static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
+struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
 	struct llist_node *node;
@@ -2791,12 +2791,12 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
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
@@ -2805,16 +2805,15 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
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
+		new = READ_ONCE(dte->data[0]);
+		new = (enable ? new | DTE_FLAG_HAD : new & ~DTE_FLAG_HAD);
+		WRITE_ONCE(dte->data[0], new);
+		spin_unlock(&dev_data->dte_lock);
 
 		/* Flush device DTE */
-		dev_table[dev_data->devid].data[0] = pte_root;
 		device_flush_dte(dev_data);
 		domain_flush = true;
 	}
@@ -3079,17 +3078,23 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
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
 
-	dte	= dev_table[devid].data[2];
-	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
-	dte	|= iommu_virt_to_phys(table->table);
-	dte	|= DTE_IRQ_REMAP_INTCTL;
-	dte	|= DTE_INTTABLEN;
-	dte	|= DTE_IRQ_REMAP_ENABLE;
+	new = READ_ONCE(dte->data[2]);
+	new &= ~DTE_IRQ_PHYS_ADDR_MASK;
+	new |= iommu_virt_to_phys(table->table);
+	new |= DTE_IRQ_REMAP_INTCTL;
+	new |= DTE_INTTABLEN;
+	new |= DTE_IRQ_REMAP_ENABLE;
+	WRITE_ONCE(dte->data[2], new);
 
-	dev_table[devid].data[2] = dte;
+	if (dev_data)
+		spin_unlock(&dev_data->dte_lock);
 }
 
 static struct irq_remap_table *get_irq_table(struct amd_iommu *iommu, u16 devid)
-- 
2.34.1

