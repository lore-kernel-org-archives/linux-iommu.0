Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFBB4746CC
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760354; cv=fail; b=P9ICum9cK1hpGoC7vy3itOYbf8hZWdOFXIVqfpskM9BdSvmC9lU+Td/iBgIWn4YrbTwnxG1vz452xD9Iuabcf+GuPxlU9f5TxcVx/CJLzLp/J7rNORxpFA1lk4WGUv9Ipk4CO16FZp6Nyqyn2nTTlahRCZcDZWSaOisXtImS51Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760354; c=relaxed/simple;
	bh=OoDb81Z8TGGiAu3y5nWTxjvSYbHwbcMdqO3rVaLDKY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5eQRcamYShJEquUqCUgg+ZM6thGFi66hy907ROYV8pHd730sjzQN6+4aT7HqlE+xTKM09cPIKUwt4+24pF/9ocB8idg0UyIFV7FNRHZ7TZKfC/DpUVSGsakGkPEsXyvoXNcZZPlLkSGWFCzGZqHxOWTqkJ0uVbFY+RswMgwxzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NMNFYGyo; arc=fail smtp.client-ip=40.107.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NMNFYGyo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxb3xO90PuNKMycayCoxWOcQlw5cAjKlRGyWYIO5s6KTbh/UV3OVBVSG38FSGqX1FLoTxx05zpx00vOySyIRdGoL/yQRoGhPiB89GmIWhHTwgEy2YRHH081QNwRBI3MC8uZr+G709aymVoiV3ri2OuGZwMusJRFhMf5L0VULilQ6A4un4yK0E+PJjvBE6Xt4lKZm8CPEEZvEwV2kzWakMxXuWfiVU5fAO6QQ1zusKBZ3FdL8vZ8MOYi69Pbs8EzvvqJPW1Uz73F0E4QMQ316RCvWIVD/CuU0/XsygXVcSJvBqrxDXfbOpK/wpoYQ6cVE1vr+KiceejuOZ2vlwUXcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qz2mxaJUwu4Jxz+4Gce7xYGVhd/MPM4fBgxUNGOJnTU=;
 b=J1OaYF/3YquAYhksyIhQHrzurKb0MTf8FxqnZ1lXPcav1+PmLGVt0ksmXVNb1GPwXY/Tqn3O7FxXvUDVallPuXjiYJ0jTW53rVL5GqFAkFBvztHzCUv5wFV8742AVOx383T7lx1fAEWpm4qOcAPPu7IKGF8RB50cU5wbQ8dje5Py1Zfh6T/z9oPIlzrZvxmdkFJheY5Xsz6fTqk6PtDKcIPVZMgVvltcRvuhlASp1rC/BUJjxXEjb3MNCTrMpbOVl5fnxwMAAsUCkEY5tI6cdM7mVdF+3CpYoSM1x+VON4jImpVFf4hO9oUmvwhvCThheV0kNhODcQMAdaMR1Q7XFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz2mxaJUwu4Jxz+4Gce7xYGVhd/MPM4fBgxUNGOJnTU=;
 b=NMNFYGyoYHRnEGMwL3lv2mvF1+/5IwVy1F+V8Ams6H5jpxOCYil9JZaVtb63TaocbmQnO54HdP91rtiqWmi5Ll1fxyudb0HKWIvOvOUPxa0cojfe3AlVm4IMiHjUlEoIWaEY0S4h9MB6bBlpYfMBxvcdViQxsXvpaS3/FNkqPOQ=
Received: from PH7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::19)
 by PH7PR12MB6563.namprd12.prod.outlook.com (2603:10b6:510:211::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 09:25:44 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::7a) by PH7P222CA0025.outlook.office365.com
 (2603:10b6:510:33a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 09:25:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:25:44 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:25:17 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <chrisl@kernel.org>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 13/24] iommu/amd: Program IOMMU DTE with the private IPA domain
Date: Wed, 30 Sep 2026 09:23:33 +0000
Message-ID: <20260930092344.5616-14-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|PH7PR12MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9e2b08-03fb-47ec-e7a7-08df1ed4cdb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2e46OdfegOnVgdoMHEd88B2UJv2EMRuRxtT+yNCOLAGCteZNDuaWVrLSBKNL2qy0alOdwdoqYVnphjtfmA/SwOx0/hpudtN7azUYhJDnDQvssV1beSxPL0wf84iYaugLyEFQZgnCgbIJH7/tkHFULfiIxxcrI7xQ247OkqFM1b2Jii4OrDzQ08oJtZredlbeTsu7nyQx7buXIHy+JXNIRP4kaa9rW4fQQkuZMHJ0GXkT2mcLaWxa2MmgVVFlBtw1hf8MXrrfvsJ/QdT6k6kmNQFORbuco8ClQAi44ZLK5KRPmkDpdRQqffBmmb5CakiHhJq8Fk1v3+YHngNt6u5Ar7l1b+Xl4qIXoIcd3NDTBq8aF524gi+K5qhvrvbOTXDxrvVEVY3TPTPV76gsc/Ie519jAD36CGI5mBcRHxbxnaTvvU9H7wjucNYOjJAfRiIXW/dz6AZ+t40t2DuAnt3szdfq37/wLgz7HPF6Kdo4/KxDRJB1cpZeuUgGTxB1ELojXrzKrlhngvWjSAP6I3z4JrxsJ3ESAEPtnKmEaJhpuR2xyohj7BroFYsnaGRQ9Yr7BkYj3UHpP+p3K9hjziqgO5+Z4gfPF8zss2Fvjxo4k5zgBzKajc5+Z3cKpRdyj8jmzLLSQg6P+etlPBzzA+qaBEndpSViCE+25xinZTrJA28+ZQ+Z0NM+ZEXD8pAZPwB5L2+zmADc9KDQChTTFAMhow==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8XpMnFDXreQ52lhx8+7rU/HLrDtBsfjJe4ohG7M2gvXaLKi+vhLCDcEpHW13jou/ua7Dvw0atQ0SVB2l8ikGS2u5oEzU59/IkzWkQdkjzmJ8Lm+S2Qcv09MwP65Efgm3DJ6c3mk3u8y6H5zV0fNilMo5h+CeEtRmfMAVTKjBgtmSOJAgnXIhaDGOd4QvQursQl7zQGU9AAZsQxude8Rq/LNt7T1KrU5Ik9TKv0OiyBbSRCo23+XnymGJoPa+wo1fIiixP2tzDI9wIP24gZ7rqYh80whVoaqqBmBjwtLrAtH7Fs76k+rkuRCcqLz7vYl26sB8+dpbLA622xqxZLqwNonMDUVccNM897RUbkIQiTFTDbBpQkV86fwSRI/ZyZUI9XLJIHhoFGSGZGNKZgZHWlbOh9PVXMhKDzHbhpbIbNogA+gz7+lAA8P75r+3vmKT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:25:44.2930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9e2b08-03fb-47ec-e7a7-08df1ed4cdb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6563

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
On teardown, clear the DTE only while CONTROL_CMDBUF_EN is set,
then free the object. After disable_iommus() the INV_DTE flush
would time out, so skip it and still free the object. Failed
self DTE allocation unwinds through amd_viommu_uninit().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   4 ++
 drivers/iommu/amd/amd_iommu_types.h |   2 +
 drivers/iommu/amd/init.c            |   7 +-
 drivers/iommu/amd/iommu.c           | 102 +++++++++++++++++++++++++---
 drivers/iommu/amd/viommu.c          |  57 ++++++++++++++++
 5 files changed, 161 insertions(+), 11 deletions(-)

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
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index e73139ba7d91..96299f10b2e8 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1809,9 +1809,10 @@ static void __init free_iommu_one(struct amd_iommu *iommu)
 	free_sysfs(iommu);
 	/*
 	 * Tear down vIOMMU before buffers and MMIO are released.
-	 * IOTLB invalidation runs only while CONTROL_CMDBUF_EN is
-	 * set (amd_viommu_init() unwind). disable_iommus() clears
-	 * that bit first on the boot-failure path.
+	 * IOTLB invalidation and the self-DTE clear run only while
+	 * CONTROL_CMDBUF_EN is set (amd_viommu_init() unwind).
+	 * disable_iommus() clears that bit first on the boot-failure
+	 * path.
 	 */
 	amd_viommu_uninit(iommu);
 	free_iommu_buffers(iommu);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f9b49df4b90c..edeaea48d434 100644
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
@@ -1833,7 +1869,11 @@ static int device_flush_dte(struct amd_iommu *iommu, struct iommu_dev_data *dev_
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
@@ -2777,6 +2817,51 @@ static spinlock_t *amd_iommu_get_top_lock(struct pt_iommu *iommupt)
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
@@ -2799,6 +2884,7 @@ static void amd_iommu_change_top(struct pt_iommu *iommu_table,
 		device_flush_dte(iommu, dev_data);
 	}
 
+	update_viommu_self_dte(pdom, top_paddr, top_level);
 	domain_flush_complete(pdom);
 }
 
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 89d6dc520b2c..e9554a3e9591 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -40,11 +40,64 @@ static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
 	}
 }
 
+
+static bool viommu_cmdbuf_enabled(struct amd_iommu *iommu);
+
+static void viommu_free_self_dev_data(struct amd_iommu *iommu)
+{
+	struct iommu_dev_data *dev_data = iommu->viommu_dev_data;
+	struct dev_table_entry new = {};
+
+	if (!dev_data)
+		return;
+
+	/*
+	 * INV_DTE needs the command buffer. Skip it after
+	 * disable_iommus() clears CONTROL_CMDBUF_EN. The init
+	 * unwind still flushes while the buffer is enabled.
+	 */
+	if (viommu_cmdbuf_enabled(iommu)) {
+		amd_iommu_make_clear_dte(iommu, dev_data->devid, &new);
+		amd_iommu_update_dte(iommu, dev_data, &new);
+	}
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
@@ -319,6 +372,10 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
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

