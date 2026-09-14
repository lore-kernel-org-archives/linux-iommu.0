Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B696B396D1A
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411782; cv=fail; b=UvLLh1AlJqIjGfi0kjS9DU9FTX2g7GDChOvh3fPeGa4HEZ/L6agANdSWW95oZB6ot6xCzdqAOus4yCIdozo3Bf2KNNp5O7823BWmxnkE0Ksq/tUFBOc+eBOykXXSpftXXWxG8kzNAT+1zMbOwf1T4Hu5Ha2qr/cMRn+pe3M8RRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411782; c=relaxed/simple;
	bh=WFfuKZfi90wyK8+/fvm9RPWlktW5gHwu93+5rBBGZHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfLgyk9jOnlahuHwR4KdBsNI74MVWR8rRvGEbLPPy6khVN3y2sEYjtlsnF4pmDTa21t/bY8JxLTU0fntuewe2BmVASKPpMNUST1YL/9l1e2BUF4JyPX9fYx0XHQqWGvhrOUQqsZnVMNi5nUk9SQm+Offn5Aj77GnJbazjqsoAZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5d6HrNrT; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5d6HrNrT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IicpVXmaZAZyKSNEGD7u78aEskyxm34HWQQbKvt/rS4UEjs6x8Yip8hwvI9/ouZaUCaAe5FO8Hk+yUAtkiIKZdqyTsPK9QPTQ6VIe/CfzlQDEpBg9FLbWvXRxN+zFoGBpuLg6DieAG+MGd6bZtvv+UtxdSCCb3wBDOFwOt/mVO0FuztUO1kP9CuliCsY6VrcBu8yfJuhtBWyQZIdVJ3Ax8wJPOANxcnDDdXqe31IMNnBqMuosr/olti+oF/5xwDz2ces369JZJj5FU4jaSPax0ejbWCma6yp2H+Io1qoM5rKKNG3PZ6dAY2jjeYwZUQBudqjNew0KiefSVREed2v7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6ea9NZeTrpT5tZEi1cJ/qwgOTWOalwyNdQdILXQEQo=;
 b=mRFR7XdMrXC/w3gUUwiZWvpH15pw9bVtTUWz62eaGTYYwW+B6bwGdg+CPapt62rk0HCRSvlTsqH51y4bwLJRs/MZCNMIbzSDu2d9BpAukzKYnFcsuoEmWUvEVUNu2LIXWoaNPuVFPWlEDyKd1zdR+afOidrL3Ncjq9JrKUZC/O9BD/4zVVfloWgpjPvapfWpeze0l41SCCRICvLcreRKb18tXS7zFuvBfU4A4A7IreOutH2vC26VGDuVi57//yVWjonpUWT6ctsysm3ANw879ja7dodVFx9CAj7Lba/vTzVrFaNkv3rb0MULfjwLy6rM453juQS8dzCLSrXQZiYz5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6ea9NZeTrpT5tZEi1cJ/qwgOTWOalwyNdQdILXQEQo=;
 b=5d6HrNrTy6duFOho+bFemwUIFx2qd2SYonaF4hZ8f7Sm/f9+D74IxNJi16goFLYHLquVhN9INzZpr/LvVwV2DzS3YuRTU/jpuxmzcNLO+zgECM9da2FC++PZWXFbIa8TPe/PzEFH5dxtyYBalaubcPDGzCru2+KZufn+yYIVh5k=
Received: from BN9PR03CA0204.namprd03.prod.outlook.com (2603:10b6:408:f9::29)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:49:35 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::11) by BN9PR03CA0204.outlook.office365.com
 (2603:10b6:408:f9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:49:35 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:49:29 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 13/24] iommu/amd: Program IOMMU DTE with the private IPA domain
Date: Mon, 14 Sep 2026 18:47:39 +0000
Message-ID: <20260914184750.222939-14-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbe8643-d4ae-4b2a-ed40-08df1290ec25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|36860700016|6133799003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	i+QfI9PrHq+sbvg989uhAoYsrHiwpMLhRiduIDsywvR60ypfB/TIunKegVQWGzJLPYWlEjkv1xMVjoqFXctKgkJJESTiLkhhjLCyOeDIXND2FP4UtpbkFKxpsBH8i1No1xj/OVDE58Q3wh0AMrOiDrNoe2Aj6uy53L9CiDsOSp6Von26HQvu8jdCZfyjhEYYbjmAjOa4QzL9n0yT8LdfHOnhZJl7n3PPeK/AhPR62HrPG3AWSpamlwXr0BP9zGKcLEW3+kNAQxnxjTA1wzbPubRIwEVSdqrLrWrY6eMaNsP21Mkbaqjl9jmRiWU6VwKfUfZVVO9GUDafpw//u3hqNfXb8zjVxE3HtK+TB2dLd6bOmWWRAwHiF0+woRyokc89AHN2E/GjAl0H24JjI+gH4cEYEuZXYsrW8h9lJbaUIFN6TkQgdgWrKFQ/3hAhDsjlbaRb1QMX2H0A+WvIED141ADc4wBGywfnNDW8s1zJXXu8CgKTC1lfJVgHcwzEEB9bTbPafEYUl00kgS+rSxL6EMUzfPzG6M+5QzcYuhZjhXJr7LVbJ+ZQTWuZoyIETp4oDUJCAY+XGSOOmOO+2wZLIdHoUmtGm3mTzXHiIr2kc7keu0cgWIpmKJFEqw5Qri8gvzE5bJNvpCZvX/ttAnbexj+naabFFAYs16MckxZE/RDn6XY2s5e29TfG/X4AgVrRiK1ebzIzoQs7WseghYUNuA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wYcpqU6tj+BrjavN1VLG7qnnUPTVBb3ITG93plkWrmJ57f/ciNZXY4dyvFTj0Agfln8Q/z66xljpuISIYLpjvFfsuVvIpePPoebfet+2EkGUtJbnWBsZti7crg+K/N5/tN+6/hcm1Yq8wgdmYsZU4UsQYrqKyZOezrLfF+0WdRGYqiqsz5EnFhItDmbcRicjwHk5oJbtn9SYL54Qki3Td3+bIvwylC22txSv8JvoRpEYvTnrslxarFoJvum39+CV71W2uHjb5QZLUxXLDExED6sJQAJ3nMThG5xZEpTgRrRcvXkmD2k1XSLr0a0g+bKQchiaM+C8saQMd22DzHXKG/8k0ZZaN2h0eUOtGRs2eJOCzHNPC0H5/dtclTY+BbKWrwzLyxOpo+6iqDy8UZg1aKSx/ijPvz8RxfDE/NBEj604G/sX4krbOA7sxyHEn+Ry
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:49:35.5959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbe8643-d4ae-4b2a-ed40-08df1290ec25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173

The IOMMU PCI function does not go through the normal device attach
path, so it has no iommu_dev_data. Add amd_iommu_alloc_dev_data()
and amd_iommu_free_dev_data() for a synthetic object that is not
interned in pci_seg->dev_data_xa. Program that DTE with the private
IPA domain's v1 page table so the IOMMU can DMA to its own vIOMMU
backing store.

Leave the synthetic DTE off pdom->dev_list and with no struct
device so clone_aliases() is skipped; it is only iommu->devid.
Rewrite it from amd_iommu_change_top() when the IPA table grows
so later high maps remain reachable.

Do this after viommu_private_space_init() so viommu_pdom exists.
Clear the DTE and free the object on teardown. Failed self DTE
allocation unwinds through amd_viommu_uninit().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   4 ++
 drivers/iommu/amd/amd_iommu_types.h |   2 +
 drivers/iommu/amd/iommu.c           | 102 +++++++++++++++++++++++++---
 drivers/iommu/amd/viommu.c          |  48 +++++++++++++
 4 files changed, 148 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 9cc5da745a73..6ac64524208b 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -50,6 +50,10 @@ extern u8 amd_iommu_hpt_vasize;
 extern unsigned long amd_iommu_pgsize_bitmap;
 extern bool amd_iommu_hatdis;
 
+struct iommu_dev_data *amd_iommu_alloc_dev_data(u16 devid);
+void amd_iommu_free_dev_data(struct amd_iommu *iommu,
+			     struct iommu_dev_data *dev_data);
+
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
 struct protection_domain *protection_domain_alloc(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d02f49a39a90..4b48ec8bacd6 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -814,6 +814,8 @@ struct amd_iommu {
 	struct ida gid_ida;		 /* guest IDs for this IOMMU */
 
 	/* HW vIOMMU support */
+	/* Synthetic IOMMU-self DTE; not in pci_seg->dev_data_xa or pdom->dev_list */
+	struct iommu_dev_data *viommu_dev_data;
 	struct protection_domain *viommu_pdom;
 	void *viommu_priv_region[VIOMMU_PRIV_SUBREGION_CNT];
 };
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2b039f38f9ef..bcbd5af75d00 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -217,7 +217,12 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 			     struct dev_table_entry *new)
 {
 	update_dte256(iommu, dev_data, new);
-	clone_aliases(iommu, dev_data->dev);
+	/*
+	 * Synthetic DTEs (vIOMMU self, translate-device-id) leave
+	 * dev_data->dev NULL so clone_aliases() is skipped.
+	 */
+	if (dev_data->dev)
+		clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(iommu, dev_data);
 	iommu_completion_wait(iommu);
 }
@@ -391,14 +396,13 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
 }
 
 /*
- * Allocate an immortal per-devid object stored in pci_seg->dev_data_xa.
- * These are never erased: amd_iommu_release_device() keeps them for
- * replug, and IRQ/DTE paths look them up locklessly via xa_load().
+ * Allocate a synthetic DTE object that is not inserted into
+ * pci_seg->dev_data_xa. Lifetime is owned by the caller (vIOMMU
+ * self DTE or translate-device-id).
  */
-static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
+struct iommu_dev_data *amd_iommu_alloc_dev_data(u16 devid)
 {
-	struct iommu_dev_data *dev_data, *old;
-	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+	struct iommu_dev_data *dev_data;
 
 	dev_data = kzalloc_obj(*dev_data);
 	if (!dev_data)
@@ -408,6 +412,22 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 	spin_lock_init(&dev_data->dte_lock);
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
+	return dev_data;
+}
+
+/*
+ * Allocate an immortal per-devid object stored in pci_seg->dev_data_xa.
+ * These are never erased: amd_iommu_release_device() keeps them for
+ * replug, and IRQ/DTE paths look them up locklessly via xa_load().
+ */
+static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
+{
+	struct iommu_dev_data *dev_data, *old;
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+
+	dev_data = amd_iommu_alloc_dev_data(devid);
+	if (!dev_data)
+		return NULL;
 
 	old = xa_cmpxchg(&pci_seg->dev_data_xa, devid, NULL, dev_data,
 			 GFP_KERNEL);
@@ -428,6 +448,22 @@ struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
 	return xa_load(&iommu->pci_seg->dev_data_xa, devid);
 }
 
+void amd_iommu_free_dev_data(struct amd_iommu *iommu,
+			     struct iommu_dev_data *dev_data)
+{
+	if (!dev_data)
+		return;
+
+	/*
+	 * PCI/alias objects in the xarray are immortal. Never kfree
+	 * those; synthetics must not be stored there.
+	 */
+	if (WARN_ON_ONCE(search_dev_data(iommu, dev_data->devid) == dev_data))
+		return;
+
+	kfree(dev_data);
+}
+
 static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
 {
 	struct dev_table_entry new;
@@ -1826,7 +1862,11 @@ static int device_flush_dte(struct amd_iommu *iommu, struct iommu_dev_data *dev_
 	u16 alias;
 	int ret;
 
-	if (dev_is_pci(dev_data->dev))
+	/*
+	 * Synthetic DTEs leave dev_data->dev NULL; flush iommu->devid
+	 * rather than walking PCI DMA aliases.
+	 */
+	if (dev_data->dev && dev_is_pci(dev_data->dev))
 		pdev = to_pci_dev(dev_data->dev);
 
 	if (pdev)
@@ -2770,6 +2810,51 @@ static spinlock_t *amd_iommu_get_top_lock(struct pt_iommu *iommupt)
 	return &pdom->lock;
 }
 
+#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
+/*
+ * The vIOMMU private IPA domain programs a synthetic DTE for the
+ * IOMMU's own requester ID so hardware can DMA to backing store.
+ * That object is not on pdom->dev_list: it is not an IOMMU-API
+ * attach, and walkers such as rlookup and clone_aliases assume a
+ * real struct device.
+ *
+ * amd_iommu_change_top() therefore misses it. Early maps fit under
+ * the initial page-table top (PT_FEAT_DYNAMIC_TOP). Later DevID and
+ * DomID maps at high IPA call increase_top(); the old root stays
+ * live as a child of the new one, but the self DTE still holds the
+ * old MODE and would not translate those IOVAs.
+ *
+ * Walk iommu_array (from amd_iommu_pdom_bind_iommu()) and rewrite
+ * iommu->viommu_dev_data when this domain is that IOMMU's private
+ * IPA table. set_dte_entry() skips clone_aliases() because the
+ * synthetic DTE has no struct device.
+ */
+static void update_viommu_self_dte(struct protection_domain *pdom,
+				   phys_addr_t top_paddr,
+				   unsigned int top_level)
+{
+	struct pdom_iommu_info *pdom_iommu_info;
+	unsigned long i;
+
+	lockdep_assert_held(&pdom->lock);
+
+	xa_for_each(&pdom->iommu_array, i, pdom_iommu_info) {
+		struct amd_iommu *iommu = pdom_iommu_info->iommu;
+
+		if (iommu->viommu_pdom != pdom || !iommu->viommu_dev_data)
+			continue;
+		set_dte_entry(iommu, iommu->viommu_dev_data, top_paddr,
+			      top_level);
+	}
+}
+#else
+static inline void update_viommu_self_dte(struct protection_domain *pdom,
+					  phys_addr_t top_paddr,
+					  unsigned int top_level)
+{
+}
+#endif
+
 /*
  * Update all HW references to the domain with a new pgtable configuration.
  */
@@ -2792,6 +2877,7 @@ static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 		device_flush_dte(iommu, dev_data);
 	}
 
+	update_viommu_self_dte(pdom, top_paddr, top_level);
 	domain_flush_complete(pdom);
 }
 
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 89d6dc520b2c..3ec907a498c2 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -40,11 +40,55 @@ static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
 	}
 }
 
+
+static void viommu_free_self_dev_data(struct amd_iommu *iommu)
+{
+	struct iommu_dev_data *dev_data = iommu->viommu_dev_data;
+	struct dev_table_entry new = {};
+
+	if (!dev_data)
+		return;
+
+	amd_iommu_make_clear_dte(iommu, dev_data->devid, &new);
+	amd_iommu_update_dte(iommu, dev_data, &new);
+	amd_iommu_free_dev_data(iommu, dev_data);
+	iommu->viommu_dev_data = NULL;
+}
+
+static int viommu_alloc_self_dev_data(struct amd_iommu *iommu)
+{
+	struct protection_domain *pdom = iommu->viommu_pdom;
+	struct pt_iommu_amdv1_hw_info pt_info;
+	struct iommu_dev_data *dev_data;
+	struct dev_table_entry new = {};
+
+	dev_data = amd_iommu_alloc_dev_data(iommu->devid);
+	if (!dev_data) {
+		pr_err("%s: Failed to allocate dev_data\n", __func__);
+		return -ENOMEM;
+	}
+	/*
+	 * Synthetic DTE for iommu->devid only: no struct device, so
+	 * amd_iommu_update_dte() skips clone_aliases(), and not on
+	 * pdom->dev_list (not an IOMMU-API attach).
+	 */
+	dev_data->dev = NULL;
+	dev_data->domain = pdom;
+	iommu->viommu_dev_data = dev_data;
+
+	amd_iommu_make_clear_dte(iommu, iommu->devid, &new);
+	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
+	amd_iommu_set_dte_v1(dev_data, pdom, pdom->id, &pt_info, &new);
+	amd_iommu_update_dte(iommu, dev_data, &new);
+	return 0;
+}
+
 static void viommu_private_space_uninit(struct amd_iommu *iommu);
 
 void __init amd_viommu_uninit(struct amd_iommu *iommu)
 {
 	iommu->flags &= ~AMD_IOMMU_FLAG_VIOMMU_EN;
+	viommu_free_self_dev_data(iommu);
 	viommu_private_space_uninit(iommu);
 	amd_viommu_vf_vfcntl_unmap(iommu);
 }
@@ -319,6 +363,10 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 	if (ret)
 		goto err;
 
+	ret = viommu_alloc_self_dev_data(iommu);
+	if (ret)
+		goto err;
+
 	iommu->flags |= AMD_IOMMU_FLAG_VIOMMU_EN;
 	return 0;
 err:
-- 
2.34.1

