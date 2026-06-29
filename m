Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A564B3EF0C8
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747710; cv=fail; b=PKsJ4CD1kW7abtunQkg07ztU3TGX6XPtzFYiN+QiYZIkuU9RyXtFtzR3JpsW76g/cneCffB3nZshIX7wCWvZ33Moz3xr089HBsIaLUm4GsiKYu58BXqhLahy1CSJzVvEUwt6vrJBSs9qGvwrUvC0a6CZmRnP3sUisUuXNdhg1cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747710; c=relaxed/simple;
	bh=bcNqSFK+jyu7WuZo0qoHhHHuFJqGlWGq9RQG40rrBO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NeNQ0jR/c+gXlynnrTCeOb791NI0Z3ReNfCEfFjDf9kKJqqBZm8HdAZUceF23wGrPbrU8HLI82B6JvGQjHqgX1Yfozk4g4K8sGOvnRZc6Pn5vpop7wufQa6vSNomC6zlI+tksr1JuerCHjNesoLb3521HF+kaQYDvTQIUuLfWPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jzgacfqS; arc=fail smtp.client-ip=52.101.61.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jzgacfqS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9RCI0OxlQZodP4xw/EKxUxxoeIoew6PZEpmVLuSXrTXbC87z+YmH4Ur6SGbBOJMg8HvYDoh+ubChNRtP3Yhj0FZ9nkgmCgod1FMZoB/Z4BUtlvi99mMy8QlkcjvEKqaO+5rr5Z4H6NUUrGftbsCyVGHzCSYKZcQfnSNA9CkjsMJJfZHR/taHLiU5uLGsHdEa8ZHdb65ZmYZmV5pofDZcy85ZNEC8zF2Vm/p8+QRY5yoS5rqbnynwsf0hgCmk1la2qhKyN/9dZP/Exe5M8/CU1Jlgtllqzg5r6pEA1CwbhI8S4LnVjCYdkScmJ780e8mOJXyqd9PBR+a4Z6DIkHPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJvRbG0OiLwh8iwqwcvRpQPx+WwjYbLNYQeWToblASc=;
 b=nI1h6JCk8bR707WMeFvEkEY1wjOtroKydlQW+g49UXoZemCm2401E0lRZa8yS4xP2CtCJYz0BsjDadh13G9tq4mgafl1oTskOGTdjILiIacM61zmLKRX/mh6Xbl18OQdFhP8MLXthpL+4aYCH9DCf5xBcY358eLtyFQ0wv4F3JZ8u4OQDOarOg6dC2k3uvltD2mYBsSda6srmJEMeNvYsE9aThinWlVHM6Te6ClIAaLLijdS43qyrSx702HFsmv3jPVX7DtAhmCoMkphNx0/wYn6YhZoCKIsd7FCu24+H5ys0bKOzLPoEJPpcozQ68DYo37OTXMS2xq5VhQPQQ4Q1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJvRbG0OiLwh8iwqwcvRpQPx+WwjYbLNYQeWToblASc=;
 b=jzgacfqSLyYxIniArzjlmby+6c17EWlkYbFjJiYBByxZt9y7hM3Brf8Ebab1x3Qa4e2V7wkBmf5A34XI+VQsDIAqJL7flb/Uj3Y+nh8S99MFTZxCO4BCbUxJVA82XSNjkZQUAgYQzOK5kylBZGRPDNLbmo7ZCFiH4/bbyoqh314=
Received: from BN0PR08CA0030.namprd08.prod.outlook.com (2603:10b6:408:142::9)
 by SA5PPFAB8DFE4E8.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:41:41 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::5d) by BN0PR08CA0030.outlook.office365.com
 (2603:10b6:408:142::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Mon, 29 Jun 2026 15:41:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:35 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:37:32 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 21/22] iommu/amd: Add translation DTE and VFctrl TransDevID helpers
Date: Mon, 29 Jun 2026 15:35:34 +0000
Message-ID: <20260629153535.15775-22-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SA5PPFAB8DFE4E8:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9d6cb4-02b7-4a93-a89f-08ded5f4ea2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|7416014|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	x+xMJ8KNY54SHQXpMTuczd/UtUufLH9IWXyN2gbju2yuiGT6r1JG+1Zz4fhuHgjHnEAPEhlpWSB1jJ1ND2b+buA/C94QJU+XHhKEhM1xFlohDDhJShZUm56IqoVS27ZJpumYS3kX3qPtTediR4Wx7uVKTmgX9psXbVXAEOf3eoLl1io7eu4wH34D7e79dhcKApJTnVWIaJIPe3ZnFElu9/8+Kcbnv9dArxli+RsvZyEtrZRh7fr9HvHz02ccbg2ylnLkMY9g4cIekBErsaG8CBgxyKtmAPOgc5MbG+9jVP5WGSmUHiOMOVL67fXBtGs24ZtxyIJoj7iR5F0i9SJc2OWpDdQSHIG3L7dA4teRsaBzMQcvbbEYMRy8GTWxMJeJw9bGJpp7Oi8Cnx+UUcOp55kXjhQlGPbKmN+swnHN/qwEEAe8NobpJARSLwt6nQIIapSfizHikm/nfiBo9hxp8p3npMLCUWaFnc1Noeo182jt7L1Ou13nkhiNszWuZaWtiSx0Gvn9t2K4Jmjy8W6mcRADuMh3sJi4t8DEgRlLRvJJu0yyOmPqty2oF3MQkh1RR7kX0TpphaoDjPIhkVpjBXAGOOWsJmb82pM8mkgXVEXPzEM4EjP5chFGKtTOlQSQw/4EsZjNxsB9TyI4nmjTJ3DUtCbuDjLRFvhTGONWQYdtDFbcRIO9TH6JN82D4T7v7xMfVHZIrsX4tohq1nn7Vw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(7416014)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p9JzuIWpnfkePiuknSxmeQ0j/RzkUxKYAbUWFckFvq2q4Zt0tJL3B30QgVhNhAHyYqv01bw6uywz49g2p5hzHQaq30/1Y1NWv/jIAOzUPr0kJmNKlvMSOpwbppCAiWjcWuucaTDod3LOs47YIRt26ltTWzy3LGvztyZ71lApcW8EFTrUHWGd4XoO162ATFPkJdAzEw5ZOLcRh/eyRWAibUVD+fSu2pH52WnjtIpNfkYDReWsnvj7mJJfn0NF1smu5ml0/3xddwbzPSNQBtHgOqmGUhzqbiWD2y4cCsmLUP9uPnP4k/jXCFId/qcCaeeJM/4jwM/5IMLHUt6K+BjiLDojGvVluzmRtIb/nFwKyevgNV3batKiTExXo3M9sx4StOKhnYmg+0P5UhMgsYEHg9T9WGIAqHwA22PL8W7HIvJLj8mYSzn7DFYQeffKbzMk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:41:41.0383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9d6cb4-02b7-4a93-a89f-08ded5f4ea2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFAB8DFE4E8

The hardware vIOMMU uses a per-VM translate device ID (TransDevID) to
index the host device table when guest IOMMU traffic needs GPA->SPA
translation.  The VF Control guest miscellaneous register tells the
IOMMU which TransDevID to use; the corresponding device table entry
(DTE) points at the nested IOMMU v1 page table that performs the walk
from guest physical to system physical addresses.

Add amd_iommu_set_translate_dte() and amd_iommu_clear_translate_dte()
to install or clear that DTE for a given TransDevID slot through
iommu_dev_data and the existing DTE update path, restoring IVRS
persistent bits via amd_iommu_make_clear_dte() on teardown.  Add
amd_iommu_update_vfctrl_mmio_translate_devid() to publish the
TransDevID in VFctrl guest-misc MMIO, and
VIOMMU_VFCTRL_GUEST_MISC_CONTROL_OFFSET for the register offset.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 78 ++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 91cdb61b5254..cd10e33c1317 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -495,6 +495,7 @@ extern bool amdr_ivrs_remap_support;
 /* VIOMMU stuff */
 #define VIOMMU_VF_MMIO_ENTRY_SIZE		4096
 #define VIOMMU_VFCTRL_MMIO_ENTRY_SIZE		64
+#define VIOMMU_VFCTRL_GUEST_MISC_CONTROL_OFFSET	0x10
 
 /* Host ioremap/request_mem_region sizes for VF / VF_CNTL BARs */
 #define VIOMMU_VF_MMIO_MAP_SIZE		0x10000000UL
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fd25c4c361f3..410c2f91064a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -213,7 +213,12 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 			     struct dev_table_entry *new)
 {
 	update_dte256(iommu, dev_data, new);
-	clone_aliases(iommu, dev_data->dev);
+	/*
+	 * The dev_data for trans_devid does not have struct dev.
+	 * So clone_aliases is not supported for translate-device-id.
+	 */
+	if (dev_data->dev)
+		clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(iommu, dev_data);
 	amd_iommu_completion_wait(iommu);
 }
@@ -1747,7 +1752,11 @@ static int device_flush_dte(struct amd_iommu *iommu, struct iommu_dev_data *dev_
 	u16 alias;
 	int ret;
 
-	if (dev_is_pci(dev_data->dev))
+	/*
+	 * The dev_data for trans_devid does not have struct dev.
+	 * So, it is not considered as a PCI device.
+	 */
+	if (dev_data->dev && dev_is_pci(dev_data->dev))
 		pdev = to_pci_dev(dev_data->dev);
 
 	if (pdev)
@@ -3281,6 +3290,71 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
+#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
+
+void amd_iommu_update_vfctrl_mmio_translate_devid(struct amd_iommu *iommu,
+						  u16 gid, u32 devid)
+{
+	writeq((devid & 0xFFFFULL) << 16,
+	       VIOMMU_VFCTRL_MMIO_BASE(iommu, gid) +
+	       VIOMMU_VFCTRL_GUEST_MISC_CONTROL_OFFSET);
+}
+
+int amd_iommu_set_translate_dte(struct amd_iommu *iommu,
+				 struct protection_domain *pdom,
+				 u16 gid, u32 trans_devid)
+{
+	struct dev_table_entry new = {};
+	struct iommu_dev_data *trans_dev_data;
+	struct pt_iommu_amdv1_hw_info pt_info;
+
+	trans_dev_data = search_dev_data(iommu, trans_devid);
+	if (!trans_dev_data) {
+		trans_dev_data = amd_iommu_alloc_dev_data(iommu, trans_devid);
+		if (!trans_dev_data) {
+			pr_err("%s: Failed to allocate dev_data for translate-device-id %#x\n",
+			       __func__, trans_devid);
+			return -ENOMEM;
+		}
+	}
+
+	trans_dev_data->dev = NULL;
+	trans_dev_data->devid = trans_devid;
+	trans_dev_data->domain = pdom;
+	trans_dev_data->gid = gid;
+
+	amd_iommu_make_clear_dte(iommu, trans_devid, &new);
+	/* Setup DTE for v1 page table at the offset specified by trans_devid */
+	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
+
+	pr_debug("%s: gid=%#x, iommu_devid=%#x, devid=%#x, host_pt_root=%#llx, mode=%#x\n",
+		 __func__, gid, iommu->devid, trans_devid, pt_info.host_pt_root, pt_info.mode);
+
+	amd_iommu_set_dte_v1(trans_dev_data, pdom, pdom->id, &pt_info, &new);
+	amd_iommu_update_dte(iommu, trans_dev_data, &new);
+	return 0;
+}
+
+void amd_iommu_clear_translate_dte(struct amd_iommu *iommu, u32 trans_devid)
+{
+	struct dev_table_entry new = {};
+	struct iommu_dev_data *trans_dev_data;
+
+	pr_debug("%s: iommu_devid=%#x, trans_devid=%#x\n",
+		 __func__, iommu->devid, trans_devid);
+
+	trans_dev_data = search_dev_data(iommu, trans_devid);
+	if (!trans_dev_data) {
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	amd_iommu_make_clear_dte(iommu, trans_devid, &new);
+	amd_iommu_update_dte(iommu, trans_dev_data, &new);
+	amd_iommu_free_dev_data(iommu, trans_dev_data);
+}
+#endif /* CONFIG_AMD_IOMMU_IOMMUFD */
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.hw_info = amd_iommufd_hw_info,
-- 
2.34.1

