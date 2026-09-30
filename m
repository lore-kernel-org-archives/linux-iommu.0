Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013057.outbound.protection.outlook.com [40.107.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8E83E3DB8
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760338; cv=fail; b=Eb+2LL7M9p9PDAfnQvH1zG1ZaVfOydMlaH6v2uZDhdgtYrsizXTn1x5VYz++UvfZXZfVh4j2QwIcZ861gOEP1EsU7c9VzqA1Zta55fSbK5ucfR6MRZm2oxsMwBuSh79VTFAvm+0CzAhHLK83d3pAnEV5d+w82gNBS80p1iVYczM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760338; c=relaxed/simple;
	bh=kcCYteR+oqDRKfGAwPk400kaA60zl0tMOCtE72QBdlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRggMdg1zZ9m9O6rWwCpTShg14ENhonY4No8dRxQgzlA3/rZj84wECI3vAG2Z75XCujqPVUqlCay3Qyui2zLcUJ2PKqCFDL6RkuLhWag5po5niZ0XDNXE1XJl/gfeLf6ZKjU8hB1PkazU/lNxeIuAtb0j1vwIm0EwPu4ipskHCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dWymQBMt; arc=fail smtp.client-ip=40.107.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dWymQBMt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yejyJ0xl9uypE+/9kTBLZqJ2vt0CiY/t1BcfNmht/oAFcP1eXlieC8lbJ62yvRz0LC/jGGEMNvwODrKUvVghjP6ojYgCQ+B46KsoFdicqUj5gO5pOtKhK0zw3z2oD3fdL+2udS/U+hjL6yVnElCFC2uatb7uowzfM80FJsMYPjhR96q93u+M8qvWYYv171XhN8556XhZQl6c2qRLP/H/cEaD910pLLGKMWRk1Y8Y0rH41N6RtHJCnvJ3zfy1qnDpPso7YbAStwlZHWTUwHdxlUxTUonH9FN8qtrPEngg4AsAmSFfIOVxb0nkfn1+v//LQzBCyZ2Fe2ILsIPXq0ji9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u76kwcZZ0h6zNCVj5jfUSx2fFXcTNZke9f4wzXBXlMQ=;
 b=Xz4BrhLqgfHgfrHXdfTtElR6zeBerbSsJZevaQLVuVQbIRoeXf43fzgx6vxHv2Y6xh8SVTk1c1ETYRIsfASrCHOlTx3nb44in5qGxFWSIsD49OJHbL/EAQKG5rhTS/I23CuGB1E062CsZ9uG5iBwhbQ+V8o3iIbujgfGQ9hvdmCkedUwLRFIL+CB7XP91+y7pgGpqI9pr9dBzwoxkkqOORjutH3CbwEr6WCY/K+Cn5MWuoRKY8m/UCJwANkm5p1IG995unx3ID8HV17Y+3JesZicHZvgiStDnT+qYUa7Rcn4hA+rZ4uCyNWoimRa4f9+FT4GcqhV5HklSb8ufKUNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u76kwcZZ0h6zNCVj5jfUSx2fFXcTNZke9f4wzXBXlMQ=;
 b=dWymQBMtOyNd3n4nY8yWk3PJuZJKgUEM9NfXA+OtOKBMC9TUckGbc0rM+unlX93KSH3YDjptXNO7NRsv6naWVgvPp14hNhB8NXMw0zcHEG85Xbnp9jX1RCEBLOidDtT+EXGoQwo6GKeOLiwQhWBtlFuG1O5mAp2FqdKkad5C4eo=
Received: from PH8PR20CA0007.namprd20.prod.outlook.com (2603:10b6:510:23c::9)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 09:25:30 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::48) by PH8PR20CA0007.outlook.office365.com
 (2603:10b6:510:23c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 09:25:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:25:28 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:25:11 -0500
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
Subject: [PATCH v6 12/24] iommu/amd: Store per-segment iommu_dev_data in an xarray
Date: Wed, 30 Sep 2026 09:23:32 +0000
Message-ID: <20260930092344.5616-13-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e17b5f-e97f-4a59-a030-08df1ed4c440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	C8JABkQMm+IkZNlDzu7HlbOBBmULmd6NVg0h7gCMdLPXLzI90RjOpHsN0a+mk8gTrWKVaJSR/iwoEEuZV6X743eSpRS0l/S4PzMEjpqyvy7TRSzNC2Jc62JTqWX0jzR/uiaUrQv/b3taPII8mp+x+RylnrUq+MYjyA/SslS1rX0KL0TYS7fH4joOupzOapfyrNOZRBwRb8AHuLoJVfBOmZqLeRixqINk/eAKfEDCd1Wf1hbi5THnk0rQ+ZuKTMraMKaREOXRtCei1tXA7ptskrrGURgKl6VFKsVt42J8QXoJH6bkmxnEAV6GJ0sfcdTpWX7UH/x1VUVpAZe/G7SxC+u4Jro4CvrOfUD96RzoOoL8Jo4Vf+UrpWbjJhNnSUyX3vAqi+e2f1T58ZfOzBWcFDPqbzUTI7XjSu0JUc09eDTQZHvbHqaBxBj9LvRwhTGppSEfRyJ0HaJ8m6i+w+2FTj3ldn2bk812+FQZQwn37rSF0dSNPSQjawb3t3b0nXwRlt3NptQMbIFJ0y+rslefd8Br7CW19suj8wiGf5M4yLfDPO1bFVyVYn/A9R3Vh8fkmIBSj7/I27ioXY1oTYo5wZJn3pM/+wKEtIXG5Dzng8nMjajlrX1aiyAoxF5iby5E3fJ9/JnCd2f+hevtmCJi7NFQGJyvMa9+W58YsqtWulBGDERjkog2PWTiS3Vji+Lb19kaIjB1NitWt/6yfAAUSA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rPgEqoUjCHkpKnaEQIvXKQO+f9A3AyWGpJ797y9ddSc7hP94f8vVuF6Ggb2jwnkynVuKznbkUndugu8w3TLMQSNuVvfhRQfEFxBWwPJeR9W4cO1cgszmnkT0VdhoDdn0PINHNi8KISg70BZagJf+ypq7tQR5dAnjTgBeGDOBh/EmTI0rwXRXEZPaqfxb16JrD/oZdYs9RKg1eezVwB35GYzZeeWP6LfkQZLv5fJYKY8o5FCb/y+ARn04CiZNKEQE2J6JeYu1PBmtdkzI62JvgiiRInMXmOEUzBIe3xAYsHR2+RfYRAyNtilpTpYfcXupsz/0kY4wS2Hn1K4clwcgUTY04Xv/gB1PDYOmneQPtwjSWVJKKOsAwGdN1CajwQxGe0aZAIMXQrpJS4pCwyOOX9E+h42DaYhJrnFNJAR3retHvZNATnex6Y504M+hJTM6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:25:28.3722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e17b5f-e97f-4a59-a030-08df1ed4c440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654

Replace the per-segment llist of iommu_dev_data with an xarray keyed
by devid so lookup is O(1). These objects stay immortal for the life
of the PCI segment: amd_iommu_release_device() keeps them for replug,
and IRQ/DTE paths look them up locklessly via xa_load().

Same-devid intern on xa_cmpxchg() covers replug and racing
find_dev_data(). Aliases still get separate keys. Intern remains
local to iommu.c; only the lookup table changes.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++---
 drivers/iommu/amd/init.c            |  4 +++-
 drivers/iommu/amd/iommu.c           | 34 +++++++++++++++--------------
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 9a90b8fe0fe3..d02f49a39a90 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -22,6 +22,7 @@
 #include <linux/irqreturn.h>
 #include <linux/generic_pt/iommu.h>
 #include <linux/idr.h>
+#include <linux/xarray.h>
 
 #include <uapi/linux/iommufd.h>
 
@@ -605,8 +606,8 @@ struct amd_iommu_pci_seg {
 	/* List with all PCI segments in the system */
 	struct list_head list;
 
-	/* List of all available dev_data structures */
-	struct llist_head dev_data_list;
+	/* Immortal iommu_dev_data objects keyed by devid */
+	struct xarray dev_data_xa;
 
 	/* PCI segment number */
 	u16 id;
@@ -861,7 +862,6 @@ struct iommu_dev_data {
 	spinlock_t dte_lock;              /* DTE lock for 256-bit access */
 
 	struct list_head list;		  /* For domain->dev_list */
-	struct llist_node dev_data_list;  /* For global dev_data_list */
 	struct protection_domain *domain; /* Domain the device is bound to */
 	struct gcr3_tbl_info gcr3_info;   /* Per-device GCR3 table */
 	struct device *dev;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d34f991dee24..e73139ba7d91 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1744,7 +1744,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 		    SZ_4K);
 
 	pci_seg->id = id;
-	init_llist_head(&pci_seg->dev_data_list);
+	xa_init(&pci_seg->dev_data_xa);
 	INIT_LIST_HEAD(&pci_seg->unity_map);
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
@@ -1763,6 +1763,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	free_dev_table(pci_seg);
 err_free_pci_seg:
 	list_del(&pci_seg->list);
+	xa_destroy(&pci_seg->dev_data_xa);
 	kfree(pci_seg);
 	return NULL;
 }
@@ -1786,6 +1787,7 @@ static void __init free_pci_segments(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		xa_destroy(&pci_seg->dev_data_xa);
 		free_irq_lookup_table(pci_seg);
 		free_rlookup_table(pci_seg);
 		free_alias_table(pci_seg);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d4de87ded457..f9b49df4b90c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -390,9 +390,14 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
 	return __rlookup_amd_iommu(seg, PCI_SBDF_TO_DEVID(devid));
 }
 
+/*
+ * Allocate an immortal per-devid object stored in pci_seg->dev_data_xa.
+ * These are never erased: amd_iommu_release_device() keeps them for
+ * replug, and IRQ/DTE paths look them up locklessly via xa_load().
+ */
 static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 {
-	struct iommu_dev_data *dev_data;
+	struct iommu_dev_data *dev_data, *old;
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 
 	dev_data = kzalloc_obj(*dev_data);
@@ -404,26 +409,23 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
-	llist_add(&dev_data->dev_data_list, &pci_seg->dev_data_list);
+	old = xa_cmpxchg(&pci_seg->dev_data_xa, devid, NULL, dev_data,
+			 GFP_KERNEL);
+	if (xa_is_err(old)) {
+		kfree(dev_data);
+		return NULL;
+	}
+	if (old) {
+		kfree(dev_data);
+		return old;
+	}
+
 	return dev_data;
 }
 
 struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid)
 {
-	struct iommu_dev_data *dev_data;
-	struct llist_node *node;
-	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
-
-	if (llist_empty(&pci_seg->dev_data_list))
-		return NULL;
-
-	node = pci_seg->dev_data_list.first;
-	llist_for_each_entry(dev_data, node, dev_data_list) {
-		if (dev_data->devid == devid)
-			return dev_data;
-	}
-
-	return NULL;
+	return xa_load(&iommu->pci_seg->dev_data_xa, devid);
 }
 
 static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
-- 
2.34.1

