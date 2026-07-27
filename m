Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010044.outbound.protection.outlook.com [52.101.193.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77521418A52
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159127; cv=fail; b=fKbxWz4iaUuNCAJ3YTiXt3whGUfWpnaV+9rKdhy11K1wUZmjzSS20/YEjhSLotrvEQ9SoDH/kZ5atd/453Uv03FPCkDoBbmIEPVKRoUow/PJKo4CvDb9zcC6VYboPorgB/MAuno+6X03OZ10Dnn74LWd+y3Lw7hi+Whx8lP9+lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159127; c=relaxed/simple;
	bh=ypFVIKlSPhGQ1lLmVZYLrLEGCKfBlrCYsN94d0GPT0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqPzf1yfSRSnUmhzprbn4+FNaOAOuB+o4COfKDPTurfdxg1pOA7RS+dtSMso92c64vBP6YUrh4rWbkeUQxJF12Rgl/Tw4LC3clg4sdqDUe09lAf8ZB9RZRIuvS+9My9Ydo0MA4lkflvtai3ZTioTw0WDWgHlnsMHcAEJZRlQlbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aY5pbg8F; arc=fail smtp.client-ip=52.101.193.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aY5pbg8F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1X5ABA5sYtENvkNL26qgwNFnQOjqomV1Y8vpgNtl5TjDQ6JfAPWVQPtRN9CI1tMLnzZPj8YfbwUJ9ww5cEpsWc8j4E3OZrLwgQcvXOBuzUjbXikXC0xgLwM9cAXoIs0OT7G1doyJK13y1SPj6l7Y6Vq7qkthwrpPS5+9+gNkX/rnx7ks0c5DdE3nmZyqH9AxhI1fpzQ9jIeJklUoI2hDnn445l+kw9BEFVxRNjfpYIxZJAMFbf8eak6uoQRTeBWofn6RK9P2QQRMmuS1cI3GTC4OxNxBFX6OZjg7pLaqU7Wrm0hc99PpIeLS2/3IjO2VYiFNz/uHKI5KszFTy5Dpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewpdNDFgOwhFRvi5BHkuMxdTRZSuf2xB/XfCm+WxmTY=;
 b=OiIexTZ4Vd2FY2CM0yOnaRSXMOlxczdh8E39NdL/WX3INxLntrX9kIYBswYiCPG2VVxunXA6B9JBdJC+uXnjbwskCADvemUWnXXFCuRG0pTDXgxBI/jX1afEPSiQXr692r09dpHXQ+x3XPzU14koXHPnZ9O9OB13Szlpaac7HOfvPqodqyxWjFokVIAGeBZ6nVqvKbX6cU0uTnfuveMyhno6yiaNUh/hZ3UnTiS2Sl72zb/OuFoVX2zViJvsqXPwpd97mWLu7fPglCI7ZNfVgmgdtsBXUG3kiquSCKG/YBjOk1RhUZPqg9Ds3mFMNf/lFxrXnsOHmDZrHXBcYdh2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewpdNDFgOwhFRvi5BHkuMxdTRZSuf2xB/XfCm+WxmTY=;
 b=aY5pbg8Fu/wgwpACz/00q2ZxonRV43KtGmXJ5C2AAmv0yxtq5f8PkeFxykE+arsAcREo1s40SFllyXfePHVtWk8kVdVFy823+YWHU+0GXJ22y36udEW1f9ElCByaab41TaKPts1goZ6Lq1PiLEbExosi8l0W8SBI/P0Aiu9AHys=
Received: from PH8PR02CA0029.namprd02.prod.outlook.com (2603:10b6:510:2da::27)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:31:54 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::58) by PH8PR02CA0029.outlook.office365.com
 (2603:10b6:510:2da::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:31:54 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:31:48 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 20/24] iommu/amd: Reserve translate-device-id for PCI requestor aliases
Date: Mon, 27 Jul 2026 13:29:09 +0000
Message-ID: <20260727132913.22475-21-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 713baa5d-98df-471c-6bbb-08deebe36c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|7416014|36860700016|56012099006|5023799004|11063799006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tdIUCgGgrmGdI03iwTsGDzpFWytHRTunQl5sHsdzLW4pshu9w3iSW0xtfpOoHAnmo57rcj3N5UkseC3V+ZjsSyGopAayOstOpalEuzOVujv41KFY0L7/K8+gIDbSNEIO8meCzwbNdjT09pLh/tpuIKepS/IwoyUy31I36xepQSdERzmZaSGMo0vDpmiFRKCuoDT2R8L4zq422PbLn4j4qdkNjbvC3nsmHJKgc8J5oj2lKsoguoaQf4R+44wApsUbRal77b85ZJI/m7qzqPKcYhlsQ+/cBQ73Rp8hDv7KQ3WXxs7+tNnrthDbW3I9r8zNdfgk/XdGn0fGi4SH0x4Jfs9PDONiPgvSHzeiA7XgqnbIdsy6HzpWRsoKNt8PRwOKmY8J0h0GI/ZG6Ma1D10CPVhrPs0bBmDB++b1SGdBMtENxX8GLJKT6US2tC4O8tMqyPi6OLd2aqfN1CYfTTU0A/B0Nn0zxJ7ingAzMPOyzMa2ZPQm+E08jAWVoRXRdYfqHnRRK9jncWmFlJsBXIXwG0rypgJwY6KDVp8KNMcFKqauU6zkFXldG3MhVtD7nn4Qp516jWSaWx3SMp/p6lJ5NlTiqoGFgWLHE9DaHAhFlVhcuLBizLsdjtC34qa5xnRSTSaDFQZEn1xiadK9Z/Hxf2PC1fxhhfW7/+4VDHQiOPRBR6QpkdZaivA3NM0UonTRYJhdKQ/cuP87AiWYzrvrsA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(7416014)(36860700016)(56012099006)(5023799004)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PV4QXkHXhjp7Ih15NarzoAPtAUAuCGF8qdfjo2F2VBAPsig2u9RirL0CIWcAlu3iLzoL/lqfbvgFNZAm5xP6sqR1MArmW7+ddGvzF/Y2hPLck9xhpEiMSyjThkqdLA7WsyvlpN+CSuPUrzPRduD7YkJ1v8yNMQ3SXZV1GVluOBYhM5J4+/uOs8WEEHzVtkUj7IwCFMtzWBZ41wqXHpw7NH3m2escmQ5R2oVA42s1kfDFV1cbspXGIE+5I5ewO3ItDeYMxbgf18raGxJQ1IRBrXga2+0dd/3EeuK6/+yWeFUhu7yC5JzX2AHWK3snue83gd6rkJs9tGDVXfJnl1DcI3ob0EdgIHw5exH6XDUTmpgZPaefOYNDaoeBbLlnLNXe8MTAhfpLWpR0qD8r20TB0KspPGdC3DPjPYzmEacM1tbkKmu+TNaKX4QCszCYndZy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:31:54.1611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713baa5d-98df-471c-6bbb-08deebe36c6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031

The per-segment translate-device-id pool tracks which device-table
indices are reserved for real PCI functions versus available for
dynamic allocation to vIOMMU translation DTEs.
amd_iommu_attach_device() already calls amd_iommu_trans_devid_reserve()
for the struct device's own PCI BDF so that id cannot later be returned
by the allocator.

That is not sufficient on its own.  The AMD IOMMU driver programs
identical DMA translation device-table entries (DTEs) for every
requestor ID that can issue DMA on behalf of the same PCI function: the
IVRS alias from alias_table[] when it is not covered by the PCI
DMA-alias walk (different bus than the device), and every alias visited
by pci_for_each_dma_alias().  Those alternate BDFs are not separate
struct device attach targets, so they never received a trans_devid
reservation and could in principle collide with a dynamically allocated
trans_devid.

Introduce amd_iommu_trans_devid_reserve_pci_aliases() in trans_devid.c
and invoke it from amd_iommu_attach_device() immediately after the
primary amd_iommu_trans_devid_reserve() succeeds.  For PCI devices the
helper reserves the IVRS alias when it differs from the device BDF,
then walks pci_for_each_dma_alias() and reserves each alias BDF.
Repeated attach and overlap with the primary BDF in the PCI walk are
handled by the existing idempotency of amd_iommu_trans_devid_reserve()
(a second reserve of an already-reserved id succeeds).

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h   |  2 ++
 drivers/iommu/amd/iommu.c       |  7 +++++
 drivers/iommu/amd/trans_devid.c | 45 +++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 284830673a87..f61cc51ef9a2 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -223,6 +223,8 @@ int amd_iommu_completion_wait(struct amd_iommu *iommu);
 void amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg);
 void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg);
 int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id);
+int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
+					      struct device *dev);
 #else
 static inline void
 amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg) { }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 02b3d3c19936..6207879528bf 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3079,6 +3079,13 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 		pr_err("%s: Failed to reserve device id %#x\n", __func__, dev_data->devid);
 		return ret;
 	}
+
+	ret = amd_iommu_trans_devid_reserve_pci_aliases(iommu, dev);
+	if (ret) {
+		pr_err("%s: Failed to reserve translate devid for alias of %#x (err %d)\n",
+		       __func__, dev_data->devid, ret);
+		return ret;
+	}
 #endif
 
 	if (dev_data->domain)
diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/trans_devid.c
index 42ab19180e1c..a40686a576ec 100644
--- a/drivers/iommu/amd/trans_devid.c
+++ b/drivers/iommu/amd/trans_devid.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/pci.h>
 #include <linux/xarray.h>
 
 #include "amd_iommu.h"
@@ -76,3 +77,47 @@ int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id)
 			 pci_seg->id);
 	return ret;
 }
+
+static int reserve_trans_devid_each_dma_alias(struct pci_dev *pdev, u16 alias,
+					      void *data)
+{
+	struct amd_iommu_pci_seg *pci_seg = data;
+
+	(void)pdev;
+	return amd_iommu_trans_devid_reserve(pci_seg, alias);
+}
+
+/**
+ * amd_iommu_trans_devid_reserve_pci_aliases - reserve translate-device-ids for
+ * PCI DMA aliases and for the IVRS alias when it is not walked as a PCI DMA
+ * alias (different bus). Idempotent for repeated attach; see
+ * amd_iommu_trans_devid_reserve().
+ *
+ * Return: 0 on success or if @dev is not PCI; otherwise an errno from
+ * amd_iommu_trans_devid_reserve() or pci_for_each_dma_alias().
+ */
+int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
+					      struct device *dev)
+{
+	struct pci_dev *pdev;
+	struct amd_iommu_pci_seg *pci_seg;
+	u16 devid, ivrs_alias;
+	int ret;
+
+	if (!dev_is_pci(dev))
+		return 0;
+
+	pdev = to_pci_dev(dev);
+	pci_seg = iommu->pci_seg;
+	devid = pci_dev_id(pdev);
+
+	ivrs_alias = pci_seg->alias_table[devid];
+	if (ivrs_alias != devid) {
+		ret = amd_iommu_trans_devid_reserve(pci_seg, ivrs_alias);
+		if (ret)
+			return ret;
+	}
+
+	return pci_for_each_dma_alias(pdev, reserve_trans_devid_each_dma_alias,
+				      pci_seg);
+}
-- 
2.34.1

