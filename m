Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830CF1B8E8C
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954895; cv=fail; b=OSHZv9MJfjhp/pRNwQCviLCc8rb8Y69pz/lUuwT0gqutqlXR2LfEUptVhNjs/6iPAhx2LI2w2mtcFaTR3jd/TUfKzDz/lXMyQoLPgWISxtTWRLlSx/fpbQopYB/BV2koZXAyRgEnSzAJ5ccfl/wLgJHH/1TcVEZ/1EgJ6H2+AHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954895; c=relaxed/simple;
	bh=YOeYVX3big/iEv6NXA2LCQ8cqp1h3KfdwCDf2Ub3qDc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Go0ek9QuEgVdeW4cHTZaNoTtO73HULuGe8uxkZuHjgXd/Ry9ZyYC1shiwmVARqsbmkER5ktRrC8rh9GD1NMMPd2v2Yze/RnilQHBvjoL8Dtb9fkMwUX/f+AvQvxgC+gAHEEgjCigysEhGxkEJcSNIJJE5Q9OX+jyiuQkMC6AIDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M4GlIvMH; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M4GlIvMH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yef6d4xxUhXHGRfUTvSzkozAf0Ue5Oa2eqNxzyleZsN8mOznFBnv65ndIuLmZc87FNeIxto47CSPpR+BpL110OZY3nwpdJbTXsMG1crsm3aDT+h3rvv+E90YRk0gNIEnUFtX5qnrH2wGVJLnZVGTVr8KWKxBMS3GSdD0QRfhKKiK521e+Hqfugf7PR0eZXZ1b/4DEv/i6CzxJgIF9yLphCRH+OLZM09oCCJ0PNY2j3cZLn8Z/Ed8sU9rhBW40tewLBYP+2nt2wf98sMuXvpSdLIkqbMBOz0f3ghB/aGvKx2Y6G76RhhFlMyu/sgA/Xa/z94WHdXk7orJVgxPJPiyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOaIJ3hd5hQsLtfAk18DJ9r4mbIKWJpFMkiHV4clRCk=;
 b=oq8kzQPvh/k5QefTtKUkgD86PqjXVD1+ADuwvEPyOJ4csRLdNllFfl922qJAGRG5IKr6OAR61AjkEFuh7IxZE1vDeCdJ2LT+s8aEJxFSKyQJFpbY1LcTCdMwb2p3nrJbhs5/4kauasb/3YAFuXeLcE2Rcf3is3x4loLSieic8mqPBIBm2EZidTw6/QqP8df7MQgaz3+TNR/kM0Eudt2t0cBwGuye14ZMFrZAF5YG4H9oDW3eV6ZrUJLoqfeul/Kc/5dK1lmPBStcwgeasEpzjEYdv+ZJ+Ev2GWpBq3InWzv+s+h2JKkR7FJyxKG87ijSBzAceisxOur0iQldZwydqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOaIJ3hd5hQsLtfAk18DJ9r4mbIKWJpFMkiHV4clRCk=;
 b=M4GlIvMHDrIKMN/VYN6LHfq0OmnSx+R62yrvtKpu4brVKeChPuulmtyeosPlSlY2lE/76vyJLdhOpoFZR2i9O/TSq4AGU/+6/lFi1BP9xBnQAHnhUjcN+6HyXJFZJEljlXmopBwVX7IZNl2HQQEl7Daz6qJdZRG9CVyItXfqNbA=
Received: from SA9PR10CA0027.namprd10.prod.outlook.com (2603:10b6:806:a7::32)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 18:08:10 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::e8) by SA9PR10CA0027.outlook.office365.com
 (2603:10b6:806:a7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Thu, 29 Aug 2024 18:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 18:08:08 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 13:08:03 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<ubizjak@gmail.com>, <jgg@nvidia.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 4/5] iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
Date: Thu, 29 Aug 2024 18:07:25 +0000
Message-ID: <20240829180726.5022-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
References: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a5a978-8ac3-4920-21ef-08dcc85589db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A/f7fwUPBCP7vcfiBJf3an+z/FeBZyLVXek6QZ+QEfqzgaPPVYgEYUEf2+x0?=
 =?us-ascii?Q?wZiSPlTcksWQ0y0SaBkAHNzYkUyFJgx2UwSfs8gVJ9YQKwJA6pbs/yWoVPfv?=
 =?us-ascii?Q?HDefB5QUoBlGvRWOi2ar5wtyKd1KEvovjldbiINwYNZ48/zRUysvOERND/3t?=
 =?us-ascii?Q?QMddLi8VcWAaRLE7TjpD/QQojkRk1lCJINM+XSbns4ulHei5Zc3ZJfW07tR3?=
 =?us-ascii?Q?8ZGD0BzEmA1TxHOkoqqBoYMB6OVBtvdPt0Ib6AjsnCTcS21aiOHid20NHogF?=
 =?us-ascii?Q?ll3wCYOgkqVl4x42jSNmq1xSdNDW52X+RgO/cApSoUEhv2YdlGyx3JpX11gG?=
 =?us-ascii?Q?Za9wLcGj8Nk8KpnFjfUjq3Ii+BTNA6oDJWSK5JkoICjkuBAXGnvBs3CWzw0i?=
 =?us-ascii?Q?Ql1aLdyv0REwqWQmfCCG34ZdIfsbZhddJVg4cgYdCZMk4tEMKnsX15xH0ROr?=
 =?us-ascii?Q?xtGw2QDjGz5CA2gZurd/j/eiA6c3WpkACeA5Lz3DFDatMbXyokG89mamnmpS?=
 =?us-ascii?Q?GNsMPbnw68ONVW41J5oJH5yySEFKb7YNnGaWRSF6Tap0LTTPMGNSA1wysdbh?=
 =?us-ascii?Q?XNay1tpdX0wwO2NPAgSOllxAMhOP7MH8u8b4wadm6r6Tcar9rKMszMDVQzDf?=
 =?us-ascii?Q?b0dfxXtC/mf61/45Aeoh8/qX5r5D05z2zExdeMpClksGfRXuax6ynhQC1iAa?=
 =?us-ascii?Q?MrE3HzGU84qfBGMKhUgddnEzZ4S9VvTlyZmD6fVd+RuSsKCzJwNsinaS1oWJ?=
 =?us-ascii?Q?IZPN00pfQmQZnMQxM2LVg0jTWEF1nIIRfqTjR82G2ckZhvLe+HTOD/R8Eniq?=
 =?us-ascii?Q?PmxpX05hQ1GwTCnv8D1SR4AmgLaeNwRsx4ej0Fpscn+RepMRlpD+pM3RDDEh?=
 =?us-ascii?Q?lCIo8zxIwUkCWmJDbMqiqAjXESZuB7yTILSNtOe87+ON7aHAnXG0GWJ5ZlCf?=
 =?us-ascii?Q?j2cLX9wwKdNBUjqm4dG7trn6/a2y0HDn1y2jx+/dkafDa3bdgw8yyXTCg5pE?=
 =?us-ascii?Q?u+KLxyD1ui4WAtXwV8AOtuFDinOoruiMiMwxmHM7EBLNrnt6pa0hgLupGFyF?=
 =?us-ascii?Q?hrUyFMQ07NHMXksa8Hnk//rLETeguAsUVZMNJslKauLwJkypdAxxNk7+Rah8?=
 =?us-ascii?Q?KhD0csizgOEX8/S+TpxkVkPL6yeASN0uftWOEakXsTqvaIySzr4VAr74ZnQ/?=
 =?us-ascii?Q?3YTA2MmxzEhTSgIznksT7RwNAIUk1mx4HiIg8xEGmGmQt6PyZy+C5+C+Hl7f?=
 =?us-ascii?Q?BoFiHH1E76bqhXVbVQ5E4XULsEy6QGz/d7k85DXa+Jj7cKEaZiyHuxQB6jEk?=
 =?us-ascii?Q?FLvFvXJMSqvJ0WE8pSUtlZ0uRCQGwnMLNZj9ieECyk5fGQfIAKOjhyrTZ/i2?=
 =?us-ascii?Q?y2oIb2eR+aNTpjazjvxbAoaitkelk7Wzuz+93xXRCdv2c1o1Aq+4Nb0MkJhu?=
 =?us-ascii?Q?6JPQIpGuw1OZ1kuCCwikRrFuX6XEcOIx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 18:08:08.7726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a5a978-8ac3-4920-21ef-08dcc85589db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482

Also, the set_dte_entry() is used to program several DTE fields (e.g.
stage1 table, stage2 table, domain id, and etc.), which is difficult
to keep track with current implementation.

Therefore, separate logic for setting up the GCR3 Table Root Pointer,
GIOV, GV, GLX, and GuestPagingMode into another helper function
set_dte_gcr3_table().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 121 +++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 93bca5c68bca..a24986c2478b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1905,16 +1905,56 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
+static void set_dte_gcr3_table(struct amd_iommu *iommu,
+			       struct iommu_dev_data *dev_data,
+			       struct dev_table_entry *target)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	u64 tmp, gcr3;
+
+	if (!gcr3_info->gcr3_tbl)
+		return;
+
+	pr_debug("%s: devid=%#x, glx=%#x, gcr3_tbl=%#llx\n",
+		 __func__, dev_data->devid, gcr3_info->glx,
+		 (unsigned long long)gcr3_info->gcr3_tbl);
+
+	tmp = gcr3_info->glx;
+	target->data[0] |= (tmp & DTE_GLX_MASK) << DTE_GLX_SHIFT;
+	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
+		target->data[0] |= DTE_FLAG_GIOV;
+	target->data[0] |= DTE_FLAG_GV;
+
+	/* First mask out possible old values for GCR3 table */
+	tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
+	target->data[0] &= ~tmp;
+	tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
+	tmp |= DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
+	target->data[1] &= ~tmp;
+
+	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+
+	/* Encode GCR3 table into DTE */
+	tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
+	target->data[0] |= tmp;
+	tmp = DTE_GCR3_VAL_B(gcr3) << DTE_GCR3_SHIFT_B;
+	tmp |= DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
+	target->data[1] |= tmp;
+
+	/* Mask out old values for GuestPagingMode */
+	target->data[2] &= ~(0x3ULL << DTE_GPT_LEVEL_SHIFT);
+	/* Guest page table can only support 4 and 5 levels  */
+	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
+		target->data[2] |= ((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
-	u64 pte_root = 0;
-	u64 flags = 0;
-	u32 old_domid;
-	u16 devid = dev_data->devid;
 	u16 domid;
+	u32 old_domid;
+	struct dev_table_entry new;
 	struct protection_domain *domain = dev_data->domain;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 
 	if (gcr3_info && gcr3_info->gcr3_tbl)
@@ -1922,73 +1962,46 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	else
 		domid = domain->id;
 
+	/*
+	 * Need to preserve the certain fields in DTE because it contains
+	 * interrupt-remapping and other settings, which might be
+	 * programmed earlier by other code.
+	 */
+	get_dte256(iommu, dev_data, &new);
+
 	if (domain->iop.mode != PAGE_MODE_NONE)
-		pte_root = iommu_virt_to_phys(domain->iop.root);
+		new.data[0] = iommu_virt_to_phys(domain->iop.root);
 
-	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
+	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
 
-	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
+	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
 
 	/*
 	 * When SNP is enabled, Only set TV bit when IOMMU
 	 * page translation is in use.
 	 */
 	if (!amd_iommu_snp_en || (domid != 0))
-		pte_root |= DTE_FLAG_TV;
-
-	flags = dev_table[devid].data[1];
-
-	if (dev_data->ats_enabled)
-		flags |= DTE_FLAG_IOTLB;
+		new.data[0] |= DTE_FLAG_TV;
 
 	if (dev_data->ppr)
-		pte_root |= 1ULL << DEV_ENTRY_PPR;
+		new.data[0] |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->dirty_tracking)
-		pte_root |= DTE_FLAG_HAD;
-
-	if (gcr3_info && gcr3_info->gcr3_tbl) {
-		u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
-		u64 glx  = gcr3_info->glx;
-		u64 tmp;
-
-		pte_root |= DTE_FLAG_GV;
-		pte_root |= (glx & DTE_GLX_MASK) << DTE_GLX_SHIFT;
-
-		/* First mask out possible old values for GCR3 table */
-		tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
-		flags    &= ~tmp;
+		new.data[0] |= DTE_FLAG_HAD;
 
-		tmp = DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
-		flags    &= ~tmp;
-
-		/* Encode GCR3 table into DTE */
-		tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
-		pte_root |= tmp;
-
-		tmp = DTE_GCR3_VAL_B(gcr3) << DTE_GCR3_SHIFT_B;
-		flags    |= tmp;
-
-		tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
-		flags    |= tmp;
-
-		if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL) {
-			dev_table[devid].data[2] |=
-				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
-		}
+	if (dev_data->ats_enabled)
+		new.data[1] |= DTE_FLAG_IOTLB;
+	else
+		new.data[1] &= ~DTE_FLAG_IOTLB;
 
-		/* GIOV is supported with V2 page table mode only */
-		if (pdom_is_v2_pgtbl_mode(domain))
-			pte_root |= DTE_FLAG_GIOV;
-	}
+	old_domid = new.data[1] & DEV_DOMID_MASK;
+	new.data[1] &= ~DEV_DOMID_MASK;
+	new.data[1] |= domid;
 
-	flags &= ~DEV_DOMID_MASK;
-	flags |= domid;
+	set_dte_gcr3_table(iommu, dev_data, &new);
 
-	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
-	dev_table[devid].data[1]  = flags;
-	dev_table[devid].data[0]  = pte_root;
+	update_dte256(iommu, dev_data, &new);
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
-- 
2.34.1

