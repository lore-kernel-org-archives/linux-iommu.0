Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EA3318BA6
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945586; cv=fail; b=kOMGL1GFpbl4Ja5G9O3nCzO5YRMN3AoHUGzcV5oK8fW2gTRqJgU4NiScgSuUJDlP0teILy0LivqTtoznGjgw7ourh2Ogh5eBF4s/Rm75MKq2ODYwAIEmd9CPWBzAXQc1uz4Aw6b4ERPKIn253fWv2ipFauCYMdbE0icJwPDAigg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945586; c=relaxed/simple;
	bh=7jTN6pDPftsxuCcTtPKEcdmR4mup/b6LLVOYLuWGZqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3SNH3dC6Am3ZbI3T3G9UqkDhT5BuXERj9qwv82BVVlTl1iovykydYfc0C5T3w12PDT6xQzX+GQ776yAcgUI5sAlcwlDgWQEGvSDVAbhj6iSiajEUX42eH6LtK5GbQEqlwhiOpbx5ITOBxZ580LhhsOFP62+XbI4PXkyL40tr2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B06TOyrp; arc=fail smtp.client-ip=40.107.208.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B06TOyrp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKgGvuDv6D0ahMeEnrGa1/qrj1l2i0pof5919ROuj38LdYQ5UQxoxanCmnz1V0xrbblXtNRZabv/qU3kyDJgNri600pXZ9xyZrqrBed9vkd4u3Sga1ol2xJDQu5fiwO2X4BYSDFcjp9XOiIcuB0KoV+0HTAkUtqu1NbaJXJRM48OT/UZIF2zTiItuS6YafuHHpfF/MOIt3DZpTnKX5qTA19vrbt7sscJT8nC7NoG8kfwFg1aCN63Lo6P986hDtSzqSr7eCk0O6Iv8pqxLQygwqd8l5Z2h4o4UN3AkdJ7Nc33tj+lMxwYsBOlPHqwcjBexR/RWbWhWCc3vuSq/LLIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oi3QrDtfIqcniS2971sGVoX17eJtytQBRYiFt8qLOaU=;
 b=JOWiJzMRO5SLGkhwYoLEyEfcjwdL7TmdjWA2bH0n/6QWdz7u8FxFh6lyHLeSP6p4itURdc3xX8ptPv5nDFbPQkdUZWj/ZzqB8XLygIn8oKEtdP+5JBpcA+OZMd8A9rGZWnsppOsmVppsfk5r1fp/uIMuYyjVwdoOcjHA4FjQHu7TqQAI7yO/spOGadk39gS+S1dBc0VrMn02HK5dhHvXxIDfEwXJSQOJRZc/1ti7pMg2z6z2Z1R9HJVAH2W6oySuhT3RHJNJGl+f1RIFE7kUCk9CHYTPxwNjAsKH40hHBW+8Ug4YmV4bkdhZ2sMf5b22vC1049b02wJ7kBUfK4IBeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oi3QrDtfIqcniS2971sGVoX17eJtytQBRYiFt8qLOaU=;
 b=B06TOyrpLQAWR/gXbU9jafyz/Bos42vSWiTWMxK5a4MyScCvJkWHxrLOSz34b8Qu2y902PB+TPYBPA/gqkCIrxsLA9ziRORvVUe+0uvmIcYQlysZScj0rp/j6ZGEVZUf8+MV8wTBEillNzaI+MODIOWvxGK3ItOBQfilf74xBow=
Received: from CH0PR04CA0017.namprd04.prod.outlook.com (2603:10b6:610:76::22)
 by LV8PR12MB9666.namprd12.prod.outlook.com (2603:10b6:408:296::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 28 May
 2026 05:19:39 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::85) by CH0PR04CA0017.outlook.office365.com
 (2603:10b6:610:76::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:19:39 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:19:33 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 20/26] iommu/amd: Reserve translate-device-id for PCI requestor aliases
Date: Thu, 28 May 2026 05:17:32 +0000
Message-ID: <20260528051738.596013-21-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|LV8PR12MB9666:EE_
X-MS-Office365-Filtering-Correlation-Id: 25851409-32b0-42a6-6c70-08debc78b753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|22082099003|18002099003|11063799006|56012099006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	PBgAL4SuSj53jYoR7Z6tq7ebBxt0260qOw2BxdDv9qy/YlWPUXbQPg/sl07UXDN1uwohjmkF+pHn9mF/OdL5+nus+UWir00bphQ3DAHiUeG/REvTZ0w8XZuFmsUExTldyxM1/NbjjOI0t1LSoKw4LEUtdJwovn+WX/V5zV9S2nnosjFMX4Mrrz7kOqcJFjj3ZCPPmrshSB1O+TvAdrwo73td1UCLOoA12pNyi1kgX1BiIYg3LsvRVfjj8/zT/aMUjHJUKldcgVIOQgOqri79r3pYQPdmW51BHoNRcAT4N/mPOkmEAu7llT2u5IV5znRNN0fXfvvwRZpRCCQYx1hyNXBFR2zEwDc3zP63ylTZ40qm1DWUD+dyyO52EuMihtkf+0vTqWPWgkpGxc0QXf6Mvi3e0DGkIhqU9tOaam+/t8jhbsOYAK3XSLEhcMk2F2oeUQ0UpfmpGNP5kWmF5mm3KErn8RnPTCuvig2R/IeUtwMCFRNSbF6xuyVtsJzsPmVdVWh2YpjAzMxYoVytSopawIMP+tJtnwCW53565uQalnLxeet6YMutxtGr9btsQ2amurGTkLhlLH51BOE3IkFd9rfsPKUh+aWkbXsjt5uQsRlQu1TiVkEQOsjJvvPj7I3KGnALjzQvCAcO2tXbBOQ1Ez0oLU+VVt+Lf0UKLnEGcdH+HJYHyNtQko58JGYwZV6YZG3kcJypM2KrgBncqsBcc+DYAGCvuJ5ULfIZFql3lmw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rRKb6DznDWe4jTBzSyhHXJbBu6dsUC7FXYJSpw2lsmTSxF+quM7RUrG97IrnzAuW/giG0MxzHxM8vjLubOkljwNH6cLy5zrngrRCzbi0PJk7uaRwaaE/JqKB+N8/3zrM0jvWcjjCB0qNm967R1WgYZ0Vb1jiIjRX+9ZY84yK3aQOyqrYir+cc4NR4efTwAtaCUWNrlwKBFsUa5amUZzYuTONd30Tts4IE/H+tP2eByP+Cuzl3XR+/z1gf7A9SWC4GJxE4ArNFjtzCH57HKqKGBOiyN+4Y9teDhAYBmWNIY1qKd1H/sc+SCvLRNG8Tce5rfYlOP0VHewcW4lFbeT/4j+tdabdD/IfDiip0U7YThU0DqI0xrrd5vJpk1XGiVIJSsJ56W53krAyq8Iom03kogggb6yzFLiI1WmtxdhGz8G4WC+US3yhjkH7IoT5TdDI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:19:39.0667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25851409-32b0-42a6-6c70-08debc78b753
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9666

The per-segment translate-device-id (trans_devid) pool hands out numeric
device-table indices used by the AMD vIOMMU / iommufd path (e.g. mapping a
KVM file descriptor to a shared trans_devid).  amd_iommu_attach_device()
already calls amd_iommu_trans_devid_reserve() for the struct device's own
PCI BDF so that id cannot later be returned by the allocator.

That is not sufficient on its own.  The AMD IOMMU driver programs identical
DMA translation device-table entries (DTEs) for every requestor ID that can
issue DMA on behalf of the same PCI function: the IVRS alias from
alias_table[] when it is not covered by the PCI DMA-alias walk (different
bus than the device), and every alias visited by pci_for_each_dma_alias().
Those alternate BDFs are not separate struct device attach targets, so they
never received a trans_devid reservation and could in principle collide
with a dynamically allocated trans_devid.

Introduce amd_iommu_trans_devid_reserve_pci_aliases() in trans_devid.c and
invoke it from amd_iommu_attach_device() immediately after the primary
amd_iommu_trans_devid_reserve() succeeds.  For PCI devices the helper
reserves the IVRS alias when it differs from the device BDF, then walks
pci_for_each_dma_alias() and reserves each alias BDF.  Repeated attach and
overlap with the primary BDF in the PCI walk are handled by the existing
idempotency of amd_iommu_trans_devid_reserve() (a second reserve of an
already-reserved id succeeds).

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h   |  2 ++
 drivers/iommu/amd/iommu.c       |  7 +++++
 drivers/iommu/amd/trans_devid.c | 45 +++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index d411bc326241..ddfc6329d235 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -221,6 +221,8 @@ int amd_iommu_completion_wait(struct amd_iommu *iommu);
 void amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg);
 void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg);
 int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id);
+int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
+					      struct device *dev);
 #else
 static inline void
 amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg) { }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2600af84c8ca..2f9ca8f2d3c6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3065,6 +3065,13 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
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
index f15cbaae9118..76450d1735e2 100644
--- a/drivers/iommu/amd/trans_devid.c
+++ b/drivers/iommu/amd/trans_devid.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/pci.h>
 #include <linux/xarray.h>
 
 #include "amd_iommu.h"
@@ -78,3 +79,47 @@ int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id)
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

