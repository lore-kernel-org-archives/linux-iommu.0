Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C701B86FC
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954890; cv=fail; b=JhmsFMuWeXLZJhaTkNSRjsvyr+y4n5bU2HWeFgTRj/hOBocn6OQCXCSI8JxaIzOxMuxjij2FsARs891NjRwb2AJPlaZQTOmNhbGpCpUgQCTvF/CJMUzBUw52HJhWWMOA5Hp/g80xphHAEB4xwv01pI7+VKvdST4hH24KbQ+NU5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954890; c=relaxed/simple;
	bh=1kcUNLCXGPQG7lvcwwKEhfoqaAj1wvWVOtNFeb0wKGQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiLFeDl1pSWI7WzEDsrY6Wluq4bbifibcFQJfwT+4UfnwlMg0r8E8BDLymGPg3f4NO1hMOuRHTo2/w7N7R43fiIeF9fRmueMEBjqSNEFSy6USzUYZSfJ5m9UR8aPkC59nB0wKWUHtEejRxWyLNKmI9pJGJ/Kp0SGKXUpRDuDDqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gvwbUoYd; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gvwbUoYd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciWUxk6/I44Xbg+mxhRtk18PCIc6a+mzBCd+mVaG/hDiTAKU+0ikxMgf2D1HFz+7Qmy6Psj5fyQPOrnGx3o6/q1LcqC3ut/f9F5MKd3OybhDKKjZW8IvC+NmWB2aW7kk8WdxT2b6sYQlNF75d9Fg8Vt14i4CW1LH9mFt+3L+yacDon/24oy5YQ/aP4Fw4afPES6KKWevvgUPQpcKS8l/3avJSHf9jg00XZlVd/rXDpzHL98kg5a03o6/lKnwS99wGPv367uxITLa0YZ8H96UvFMk+6UeUjHmFBtmn7lRxDGGVGMK3ScLyOEsb5EAzQiu2DzeWfN0X4IAF/dodf+zJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vk/hNVwjkH6//sivZjA6qsmeD26KGCQ/cMBFldYA6gQ=;
 b=voCwkrm4RnLb0l/lV/HQZJM9kS7xz5T4eKyNnFx/z2k5ACIKaDgUXS9SDMDXK2Bz1fTN3Agqps9YssRNEy1oDGaJxYtC1CE0iRly3kfHqqq1hLGH0sIgoKcRhmLwP+kDPba+YOpTRUFvhaTaDnX8JOhE2JGSjLnGJVdH03y9jdejHvhp/UFerTYPeG/w3/wS41ftmi55iJKSUGbaCH5mFjk+BTlQ9G+A1/QawRf29ESEhLDQQSTLGrkcz0K5wgF4/Rf8Ps7awR/u3Cw9Ph5ytM2RRg7dY+38gs69S2jCHvlZkX9BjXqALT8em+tzwg/kIB1YPVfLe3QgVZLBmGnXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk/hNVwjkH6//sivZjA6qsmeD26KGCQ/cMBFldYA6gQ=;
 b=gvwbUoYdoM8pGNQPQIThZWphiK86gk/g09+xtJpIv5n68a200dJ9LNQdV++0Aal6lHmNjxcigNBN1jaIpipCBlLAJkFuPEMIrux50DRw9qsoV0rxpKu4+NzqdvXKt8DwKtFEM1L6mqe0WW/n6DNd3XJPfmK3tmwG92G4LcLQYP4=
Received: from SA1PR03CA0024.namprd03.prod.outlook.com (2603:10b6:806:2d3::25)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 18:08:05 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::ac) by SA1PR03CA0024.outlook.office365.com
 (2603:10b6:806:2d3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 18:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 18:08:05 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 13:07:59 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<ubizjak@gmail.com>, <jgg@nvidia.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 3/5] iommu/amd: Introduce helper functions to access and update 256-bit DTE
Date: Thu, 29 Aug 2024 18:07:24 +0000
Message-ID: <20240829180726.5022-4-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd81663-9008-4122-cdbc-08dcc85587e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kuuFyklNwyBKLjpwQnbEFMcFHRhUuE7Re25iTDC4KZugOAGCZcr6S9eF3UVY?=
 =?us-ascii?Q?+oBxihqkuYyqwk09SvFOt2XEJNYKoVgF4ae5bDkfxkorCETnXpXXZVD5Q76w?=
 =?us-ascii?Q?3TW5Qp1AcN3vF6WiHIXp1m6A0+nq/ze61FqnGJQxHBukuNEYwHOgraAV0ugn?=
 =?us-ascii?Q?XXxttkTWLzcYXwR1HiPVFpKFs7Y77t4c03mo/xGs0drhEp5wMZinO1DPenYH?=
 =?us-ascii?Q?F4fiMuTrr/fu/YtokjFgqPlzU3K/po4HSQA0IhdEKAOpC7sBssNwuhBFkvll?=
 =?us-ascii?Q?769bAdX32h5BAXBSyyxgTpR0K9Xc1bkHfZz1tdg1ULeo164CbzQQyuPoU1LV?=
 =?us-ascii?Q?iXoKnKh2WC8s7QO+gUc05vGF9ozcOZcIEEZyQppUqpyaoe545E1rO9nR99uY?=
 =?us-ascii?Q?mK0fMG8OcrTh3DHmDa47mX0WVAiAOxw4NoV/cSoLGSjwAXdR6/In0OWrzdtV?=
 =?us-ascii?Q?go8hM+t7GFl3W332zE52SkNFAJ2SJP6zaeE0O/tp9dDoArj4qtVmfWJ1bicu?=
 =?us-ascii?Q?h18Wzuht+6g7bGGHJHlH0CDsV8HoJytVkbWMLM7x/AuDbDVUE3l3wLV9Gp97?=
 =?us-ascii?Q?yQhEgTVsOszhY6GQnnMx6cL5NU8blH4BAv3NHmGvJRTjerzzU2tMk+EwA89a?=
 =?us-ascii?Q?b9NpLSyG59bzinQ2U108OGVcuwJopX7YxR8KByfthmuBt6JrgYBf6x0shPtv?=
 =?us-ascii?Q?K1n6gjnah0zYMuOftMuWkkv8FdsdA3XVZoUMFUqHcwUZoAavaeEinhiv0Wgu?=
 =?us-ascii?Q?pUNBTsiM+Pz4JvIQmiLfCMEol87SlAUCRjAAYNv8pm5NpN6qi1s0PHDEsBan?=
 =?us-ascii?Q?+DWsTbalf7WnFCRupsxjxx5+fedC6pyjwpbwyahdQ6HDfO0fBMCKaQ9bXqqL?=
 =?us-ascii?Q?12Ad/0FejH4Z+JLP9wqnOXSpN1QEdogRYLoU5GUBo4t7AoTzeNvUdnmInx2+?=
 =?us-ascii?Q?0hwuSzsdxHLJ+V/88L11RHULixx8ru2xr3OHA85dZv1Hy8WyUEs1ihgNthL7?=
 =?us-ascii?Q?TUXO8Xa7w6DL7bECkrABZGkwZix7/6F3aXF3vSkleEVK2hk70P1KugsdjPYT?=
 =?us-ascii?Q?I9eFNHoEBDE+5RZ9DlvFp+zZ+p9Fj2uoO435Uj6S39rQWyONbUPH5gwcxp/u?=
 =?us-ascii?Q?W46PR4MaWoQilKmoBCWFLL57WQnT99yQrGH2PxemCgRTaUjlTm40iwxOmNrf?=
 =?us-ascii?Q?SvQgK9m7axiIo91cnbqqOP8+7cYuwEBb52uqkzW/uh6/ZSvm267J22oDhzQG?=
 =?us-ascii?Q?M5Jd2MNx4ZWv/Z+2MAwymJfajl2PLI66DjXOTsVDnvx0DHC22g8G8K+mL1aD?=
 =?us-ascii?Q?LI9SHk92fU1ZUUsWeUXCVCO6y4nNwkeJ/wCGDADVXH5/qVy+CYwUV5jYHqDE?=
 =?us-ascii?Q?bwVNIUk4m/4y/ZGA8+WMKFEfvBSptDu4p1DlHQ5myNYWfNfw+uGCMJwS0YHy?=
 =?us-ascii?Q?edrYfRcx4rUirRQc8dlhkmMCbp1SDqOy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 18:08:05.5274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd81663-9008-4122-cdbc-08dcc85587e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690

The current implementation does not follow 128-bit write requirement
to update DTE as specified in the AMD I/O Virtualization Techonology
(IOMMU) Specification.

Therefore, modify the struct dev_table_entry to contain union of u128 data
array, and introduce two helper functions:

  * update_dte256() to update DTE using two 128-bit cmpxchg
    operations to update 256-bit DTE with the modified structure.
    Also use the struct iommu_dev_data.dte_sem to synchronize 256-bit
    data update.

  * get_dte256() to copy 256-bit DTE to the provided structrue.
    Also use the struct iommu_dev_data.dte_sem to synchronize 256-bit
    data access.

Also, update existing code to use the new helper functions in this and
subsequent patches.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  5 +-
 drivers/iommu/amd/iommu.c           | 81 +++++++++++++++++++++++------
 2 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 65f3a073999d..2787d6af5a59 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -884,7 +884,10 @@ extern struct amd_iommu *amd_iommus[MAX_IOMMUS];
  * Structure defining one entry in the device table
  */
 struct dev_table_entry {
-	u64 data[4];
+	union {
+		u64 data[4];
+		u128 data128[2];
+	};
 };
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 994ed02842b9..93bca5c68bca 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -85,6 +85,47 @@ static void set_dte_entry(struct amd_iommu *iommu,
  *
  ****************************************************************************/
 
+static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
+			  struct dev_table_entry *new)
+{
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
+	struct dev_table_entry old;
+	u128 tmp;
+
+	down_write(&dev_data->dte_sem);
+
+	old.data128[0] = ptr->data128[0];
+	old.data128[1] = ptr->data128[1];
+
+	tmp = cmpxchg128(&ptr->data128[1], old.data128[1], new->data128[1]);
+	if (tmp == old.data128[1]) {
+		if (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], new->data128[0])) {
+			/* Restore hi 128-bit */
+			cmpxchg128(&ptr->data128[1], new->data128[1], tmp);
+			pr_err("%s: Failed. devid=%#x, dte=%016llx:%016llx:%016llx:%016llx\n",
+			       __func__, dev_data->devid, new->data[0], new->data[1],
+			       new->data[2], new->data[3]);
+		}
+	}
+
+	up_write(&dev_data->dte_sem);
+}
+
+static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
+		      struct dev_table_entry *dte)
+{
+	struct dev_table_entry *ptr;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+	ptr = &dev_table[dev_data->devid];
+
+	down_read(&dev_data->dte_sem);
+	dte->data128[0] = ptr->data128[0];
+	dte->data128[1] = ptr->data128[1];
+	up_read(&dev_data->dte_sem);
+}
+
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
@@ -233,8 +274,9 @@ static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid
 
 static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
+	struct dev_table_entry dte;
 	struct amd_iommu *iommu;
-	struct dev_table_entry *dev_table;
+	struct iommu_dev_data *dev_data;
 	u16 devid = pci_dev_id(pdev);
 
 	if (devid == alias)
@@ -244,11 +286,19 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 	if (!iommu)
 		return 0;
 
+	dev_data = dev_iommu_priv_get(&pdev->dev);
+	if (!dev_data)
+		return -EINVAL;
+
+	get_dte256(iommu, dev_data, &dte);
+
+	/* Setup for alias */
+	dev_data = search_dev_data(iommu, alias);
+	if (!dev_data)
+		return -EINVAL;
+
+	update_dte256(iommu, dev_data, &dte);
 	amd_iommu_set_rlookup_table(iommu, alias);
-	dev_table = get_dev_table(iommu);
-	memcpy(dev_table[alias].data,
-	       dev_table[devid].data,
-	       sizeof(dev_table[alias].data));
 
 	return 0;
 }
@@ -584,10 +634,13 @@ static void amd_iommu_uninit_device(struct device *dev)
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
@@ -2667,12 +2720,10 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 					bool enable)
 {
 	struct protection_domain *pdomain = to_pdomain(domain);
-	struct dev_table_entry *dev_table;
 	struct iommu_dev_data *dev_data;
 	bool domain_flush = false;
 	struct amd_iommu *iommu;
 	unsigned long flags;
-	u64 pte_root;
 
 	spin_lock_irqsave(&pdomain->lock, flags);
 	if (!(pdomain->dirty_tracking ^ enable)) {
@@ -2681,16 +2732,16 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	}
 
 	list_for_each_entry(dev_data, &pdomain->dev_list, list) {
-		iommu = get_amd_iommu_from_dev_data(dev_data);
+		struct dev_table_entry dte;
 
-		dev_table = get_dev_table(iommu);
-		pte_root = dev_table[dev_data->devid].data[0];
+		iommu = get_amd_iommu_from_dev_data(dev_data);
+		get_dte256(iommu, dev_data, &dte);
 
-		pte_root = (enable ? pte_root | DTE_FLAG_HAD :
-				     pte_root & ~DTE_FLAG_HAD);
+		dte.data[0] = (enable ? dte.data[0] | DTE_FLAG_HAD :
+				     dte.data[0] & ~DTE_FLAG_HAD);
 
 		/* Flush device DTE */
-		dev_table[dev_data->devid].data[0] = pte_root;
+		update_dte256(iommu, dev_data, &dte);
 		device_flush_dte(dev_data);
 		domain_flush = true;
 	}
-- 
2.34.1

