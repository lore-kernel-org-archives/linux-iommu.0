Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464F525D1F5
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011131; cv=fail; b=ZHD0440g6aA9A+G0+Ze+iQeWuS4Lrmxn9QGuleqIb7Zr77xViETsyd+nBK1SwtgfVPYnHgRncX9VciaWW59YoG91e/GNCxhctiOYe6I+dJrEY1kxLTD5cKMlJHTLaxB5ZkqD4YY0mhJk98P6xkxlwdfhKWOUYU9iS4NY41lN+Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011131; c=relaxed/simple;
	bh=zndC4N76LCwRgbByRHBvNnvw+0roD4hmCd9mHi2KX3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqGLAzpGu7bM8Zu6dvP9P5qepcbJfmdtLKNqpdqXfeezAv6VDm/9GsXjq7PXoO1kx7Kk0nEtkzr1fpCJBWEmmjpErcsIljbJL9Ta67pCQGAsomhpd4+Pugg32+hGeUicKc9ihspLWsfEsTx0qewm4SUVHRDDLIszI+BzmvNiuVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4gwDtnDX; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4gwDtnDX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEzV6lrcRuZNYI8x1VFtWtukhIpqWLfIW+pbrqeC00xCGDjge5tacTYtiHY1KX7/2gnPBBgqSp8d+1u8vJGLIzhwuYSR3owI6C02aaN9vm2aSvdvTSwB4x/tuiASaR4BaQYCWlx5BPCMhTbKD2UlLcAcU73CUu4KpCaaS/JnTgWsMveXfYP0SfQUcgQqBrZWx/NKJmTn6JehmeaiHcubleBbIgPzTAgjiIeMP6kOYltbckPckQNHQyjgLZ1QjfUAVOh9LdcsSpnrV1i0Pt52JGiL/ZO0k8MVZISFXrbkxcD7pdjVvXXfj+aeWuGJXhSi83rllv0c5K+RIDBH06VsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D55SiBFm3VstgNELqvFzvo2leY00epA7Z3rRt7Lipg=;
 b=JRcnOEFpa9UhoWozBLCBO6PFcxrysDvKzjC7YFNAdpKtTlv5rHmIsIqsMLpNgqHxB8sElsyaShtPhgqJXSGGPCOSZ1kcCZSce7kS3G9buKnMyk4SMlHYTad1uShvuOTFlTVq/GCqOdGPiIJEN9rMfsJ84b77wyTo8tCokz/f8I0L/gGY7lJ0ghhKm/crCZTzUON04XVdJI5Yp++/NRTTi8/R01FL6tiDrPrgPPWWwZNoQdgKMsUbEhVOUXdXrLQiol+2i1xcsMUPUpRgcchcmkkNib9URmYFcJNPgPHwrrJPSv97j50X2I6W0lEOVyKWbPpbMwi7mwzQKUkV3aD0hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D55SiBFm3VstgNELqvFzvo2leY00epA7Z3rRt7Lipg=;
 b=4gwDtnDX89aNCENmGAj4C5SylVFKOVaDr94URLCq+UzBBAky1KA6v+GrRbULahHsrxL7MhRNYw32LjDunsVWHYc/zwWtTcn/Fpeycz9V2t0MTZCwjAIU/CEkI0Dw4NO5nSURFP0xMhAxry1wk9ubuC76SeR3gM1AY79yD7jCw5E=
Received: from CH0PR03CA0407.namprd03.prod.outlook.com (2603:10b6:610:11b::34)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 01:45:24 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::14) by CH0PR03CA0407.outlook.office365.com
 (2603:10b6:610:11b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Tue,
 21 Oct 2025 01:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:45:23 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:45:02 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 14/16] iommu/amd: Refactor persistent DTE bits programming into amd_iommu_make_clear_dte()
Date: Tue, 21 Oct 2025 01:43:22 +0000
Message-ID: <20251021014324.5837-15-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 6651d5eb-c8ce-4987-2bc9-08de10438071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ohg8dBhqq3HdWhvgDT47QwkDXJLhp2NYmF1+Yu8pU+orWvXNkxoYCkUoy8w0?=
 =?us-ascii?Q?y+GHiH2bTRc5UbmJB51tPWC+daclELsEEHtDBS/QcJ/8dNYRwOvOYF7OYisT?=
 =?us-ascii?Q?fYwp54dgVxK3+JiH1fWca0kc55WV7Z95VdQL+RD6IWAlrXAyA48mIf83tR/X?=
 =?us-ascii?Q?1I0nqPcXZeXRehhh5zdkpnusjjPltzvi3cRc4g+w+Fz9p5iAGKLc4/4+j074?=
 =?us-ascii?Q?NDDTGTtf7WWaI2CyDs9AaOZpWO06yU3/pBKrL1S6unD5p15i5BvJcXIyNQe/?=
 =?us-ascii?Q?5e38LaDkq3DDFveN/1cV20QplUnHYiOcY8Qv323vhZlf3o9UTrGtZSrRtvMM?=
 =?us-ascii?Q?yvQQah4jecyOCvvKcDmuBwgJ/l0RnJihRGjJ13vboPf/evnYg9p0uWPOEn/n?=
 =?us-ascii?Q?CVjmpVAYwQ1LUY+HAhTjzrWApmmYv7lSmHUqa+zRqUVtHcIy8KmW5mu9X2Qv?=
 =?us-ascii?Q?Hi+G5aBJumBTk+7pDjz0G5BTrEzA1x5DWArntfMum1/VhkJTj1UGlsRya3IJ?=
 =?us-ascii?Q?+rte2EZVIz8zcWwtj3ID31JHNEsJCkji6QsqmYDX/N4ddFV3Cg9tH8PEh83U?=
 =?us-ascii?Q?SVgrvrgsTz0G3gEbh1hC4FIJzdL4drMYOMJQPVOqQQCHh7QxWPwzjsmNC9RJ?=
 =?us-ascii?Q?EcBOFnzIWJNM5DoVyWpOLGCX2SMuhtrlLUgNZ9DfjzQx9xO1IBA6MTjBOM8b?=
 =?us-ascii?Q?L4O2uJSS620I0QdjhsgJu0E5BPHnKn2HTJ5OeaYA86SCpp4Q3fKjQrqS21bz?=
 =?us-ascii?Q?UQqrIAchymKSRmRd+Yn0qn69vLjNWh44d4vK82kkiODiJnGGG2b7oyliUbb6?=
 =?us-ascii?Q?6Jaf8e3YjzoEcI9eOQJ7FWxEfYumRWBupGxa3/A4sNZb/SSpnmokp+hOUyHw?=
 =?us-ascii?Q?637KmX03A+s5aw3P4xogGAq4QQpORSAAghoIOhLZ52oNFz68lGUl+PUVOdVe?=
 =?us-ascii?Q?KGms3BsBeAb4J367PIw82ZZ2FivZkIkWGIv3S6Y42Vc+Lsgd7bv8EYpe1bt1?=
 =?us-ascii?Q?eXi5oHwWe4zYfCCPGUAVfSzlXt2quT3IW+PhSAsFSL1pz2X3wgEt7YyYLay6?=
 =?us-ascii?Q?ms4twwfnsfHt3XYOdc/5J/hmVZUcom6DOREyqRV7IJKW7VxgsvI+wug+iBl3?=
 =?us-ascii?Q?+rnjiKqG0V5rxmDTwayHDTnBNXQueCLYiVLhrFYZS0judnNQ1V6+ZsY0RBip?=
 =?us-ascii?Q?/dgWtSJgwv67Fl+J8xFs3fNL0aG33zCfS0f3lDIdSMRsqBtPIt/Da/C14n7h?=
 =?us-ascii?Q?0qjhSOsRb/02DC5/4t3zMXlZWWNyHgggbzc/0hmRQJryLcZRSqiBY2l8kX2h?=
 =?us-ascii?Q?6WR/X6kDlZQq0Nb2pSrHsnvjL3II+J7eS8gqyG/PP3524aEu8mfYB/wHJx0d?=
 =?us-ascii?Q?B7+KY0E/TEWRqx6+1K70G6DVM7iBOvwKLUi3pOnI765n8WUsOzSzFepiNFQd?=
 =?us-ascii?Q?52Y+bMbT7W+xIfc8fKT7NkJs0xUK0/EMXUErYtMds05nADhoYpFJa/NeBxmZ?=
 =?us-ascii?Q?2j0TKvWjuuSPuIubMB7Z8Wq2fdovjsFdQMg1yrNIhxvJFUaPQf1Xv2chjqus?=
 =?us-ascii?Q?hr4TrSW7pVBcbLediLc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:45:23.6140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6651d5eb-c8ce-4987-2bc9-08de10438071
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986

To help avoid duplicate logic when programing DTE for nested translation.

Note that this commit changes behavior of when the IOMMU driver is
switching domain during attach and the blocking domain, where DTE bit
fields for interrupt pass-through (i.e. Lint0, Lint1, NMI, INIT, ExtInt)
and System management message could be affected. These DTE bits are
specified in the IVRS table for specific devices, and should be persistent.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 13 +++++++++++++
 drivers/iommu/amd/iommu.c     | 11 -----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 3730d8bbe6dc..cfb63de7732a 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -197,9 +197,22 @@ void amd_iommu_update_dte256(struct amd_iommu *iommu,
 static inline void
 amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
 {
+	struct dev_table_entry *initial_dte;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+
 	/* All existing DTE must have V bit set */
 	new->data128[0] = DTE_FLAG_V;
 	new->data128[1] = 0;
+
+	/*
+	 * Restore cached persistent DTE bits, which can be set by information
+	 * in IVRS table. See set_dev_entry_from_acpi().
+	 */
+	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
+	if (initial_dte) {
+		new->data128[0] |= initial_dte->data128[0];
+		new->data128[1] |= initial_dte->data128[1];
+	}
 }
 
 /* NESTED */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e4db6f304599..e3330f3b8c14 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2078,7 +2078,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
 {
 	u16 domid;
 	u32 old_domid;
-	struct dev_table_entry *initial_dte;
 	struct dev_table_entry new = {};
 	struct protection_domain *domain = dev_data->domain;
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
@@ -2119,16 +2118,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 	new.data[1] |= domid;
 
-	/*
-	 * Restore cached persistent DTE bits, which can be set by information
-	 * in IVRS table. See set_dev_entry_from_acpi().
-	 */
-	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
-	if (initial_dte) {
-		new.data128[0] |= initial_dte->data128[0];
-		new.data128[1] |= initial_dte->data128[1];
-	}
-
 	set_dte_gcr3_table(iommu, dev_data, &new);
 
 	amd_iommu_update_dte256(iommu, dev_data, &new);
-- 
2.34.1

