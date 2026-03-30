Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012018.outbound.protection.outlook.com [40.93.195.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AF43AD52A
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860239; cv=fail; b=bqeaF83BLFN7wZDZORHcSfjRgAh3zRmXlrKd+Kjp46AGmhc78jqTpOzhrL4bytdjQ5nDgDwYljGDz6Mo3RqWHE01EC/N2/onQM3VLb0fxWsMrAw3DZIVKxN+J5JCE/1QV6GtoHOTUQBEHeVRSkVHru87bbrSiNd4GlPw+sJmel0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860239; c=relaxed/simple;
	bh=yVxfDK4P05A0E7piD9tI42lG2FP4t2qfeTQHZX7EEWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4BEIRCF9BgQKiEDa/6/gp5+iYS+Lmna4ZJV2qHhk0wvOd8XHFQMYM88j1EfTICKeVgSYC8g/94yXCswo20LMu4IjT4WpwLYe84nGWz1V0G6SoKBHsy/Mnj3onLB3AcGgfuM5W9qbK9orb6LasAOF4Ebvu+LGBCVr8sWqIOF2Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EPFzK0bV; arc=fail smtp.client-ip=40.93.195.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EPFzK0bV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMjKfBIDzLx4FN4jRoz2cGZ+oqgLq0i82QmyoeMReeok9f1eoXBujZudFYEmKpeqs8rvUcLQSc4nG/L9+wspRUilnW+hy1v8nz8WMYWeWq7DsNm9F85sIo7K1C30kJkXO0fPzJyyZnt6mc8iTs5jVBRuW6aHw0NwAZ6sK7K8o+nm/QigTE9eWyiwASsvoJv7upoXMBwbpaxzM+7rX9emug9K6qt0OtJ8qJUMdvkTywPnzi0x3foQGE/AB7mCZUKMRtsm0lOcCEq/i9+p7OXoyFPZx4VXcM79kz7yZOutTJ/vokVUZh0zgfTdUBsInZpG4Hq097uvw8hjSber+5uDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGRMIbUVxx0GjvKpvnyy8KOu2CshlUIVxwhoUzruHGM=;
 b=IjtxBx3hUsa1LzPS3krnrgco9ji6bhVhiNW36MmRS39MhG0+EME7vinhpP48O1OPPn6gI0fr935VX7v60KlisUmJiVXy/PZyRQxB5DJylKzMyBxlsEoAuKl1IoJuaOYRRKIlzekc2OakXrWSrhOHVQls9iRTGRe1ulupOnslem8JbYBzSTVhRVpOUiQlzI1wSgdraWgHqtYgkYKl4bWKIfSZ12wPGpZNdKnHx3cIuF+AXGhnZJIgY/dCg0TMxDufk8/m6J3oru5QiVaPLAW6vRFK9BeexyRIrmw1u4OLIAQgMxqhjr1XfsHeIwC3yP3BDiytmnrhIWuaKhG9lGFTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGRMIbUVxx0GjvKpvnyy8KOu2CshlUIVxwhoUzruHGM=;
 b=EPFzK0bVyCghA6JN4rd4AyYuFH1QwgU1U4DoZyExjnjvgMP/8Ue8/o3iPcnVyrTijnxfi4ddyIgx2yJUaPc1VgkhHvR0zkhG51ra2PCcNqCEkMYZ1fwYhnXO3wBiB+G1qKGhb99FN0aEJfAAz85gKrRk3WMN5+S8XARLyXthaEQ=
Received: from PH8P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::7)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:43:53 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::78) by PH8P222CA0029.outlook.office365.com
 (2603:10b6:510:2d7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:43:52 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:43:47 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 15/22] iommu/amd: Introduce helper function for updating domain ID mapping table
Date: Mon, 30 Mar 2026 08:41:59 +0000
Message-ID: <20260330084206.9251-16-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: a763a25d-9368-48ca-a63a-08de8e3878b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Z3mQ5vcts6BUJsQ9/4C7Wh66d3BB8qyR5X3rKtyILsiGrx+DloFeb199Lb3Mx32KuLTFg73uosibbLkpkDC9TTzrwd1QSMY2cpjhG5KnqlBhw1k+T2fNrGlUsFTRQGWogyWshVdMPVVEZhrZFRbo1arzBgfHuaW3WpTCJQruEs4eEKcZv7MpDQNLYZ7kr5bSO6X6NUmv8cQZbjks/jii+M6eYLb844NM/LfLeWtTv+o4C8lFxJTh/6AQ280vpA3kXurgG+qKlv6Z7XKmiqJA2RruiAAowNeryKN3auGF/NCnC05CXRYfR9wi/hkkH5j/d0nFci9MwACAfAvci9sse94jS9R+brMHXwxpcvvTWDN00DYHkddII9cy1zBy9du6Syj/25y/RYVT/HaWh8Drrjvu7nPYnlX0zFrhey58/2UlfKDqEbUR0I4VDLH+0KqCtc/6GQWx5OjADXzF2kvrrzR6Pz8bcHiFkP2SY1KbBygknTy5E79601HUENS+g2xZro0URkw3j5Xzcg2xBmG9cKW8uxMD4EmFlu/KtfM9aAACx1EjL9kJaY4EpWHLVBRv7FIWYDa3EuP+r7r72BM5sNKFE6auz3FTbHy4PBQXqH9DOcIwY3K/quOnluIp86YgQlegeO3lDOuLp84fSL8sUeyaUU+Y2/txQy/ZK80jW391GxfPLCtV1XbSXYwRnRanWZA+agkOyYys+N03YzMzm/9VrGa+GYVSvLF51cYG/BY+Xl8ivq6idVjVCXxJhl2tfMDDk3MfnO78F0716scabQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5vBqMBD3SHSnisqBVsWXpDSx3JrJqGx+OB6FPgUfONuMvihXKkRnwFYzV7ZU7iPexsqfmtZ3KiFloLB1xB3pu3WxbeSB2kMrESqWGRCbtxnGSAuTYfy5YqBp2+zaDAnp4GfLCpHvnDdoHKpTOIchC3kzJMyM7ppxvGArjtP6D+HxsiFoyE1nbcSFbNs58ELGGxpcIYBojbuEQODWuwmcxntBy5SMaTn3bak7BucalI0t8jaTUwmdtxOYA9Dfh1EwsH6ADVfZJLmPtmFO2A8BF51o7YWWtWqN4HqWtjATOnTY91ovRzI1HkRd9WIK73Of1dNpCpJhQ4V3kbdGbA0bPC7Y9n1aKF8pjFdKXBB2NPBIcEhpQfqmx12nANviwlnroLhAUba608Vn4Py2XayJ7zrJ3pYVI1Aru0ux5GpSKeU3brDiKKD4mG0Qymy95UIW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:43:52.6461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a763a25d-9368-48ca-a63a-08de8e3878b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110

AMD vIOMMU hardware uses the Domain ID mapping table to map Guest Domain ID
(GDomID) to Host Domain ID when it virtualises guest IOMMU commands.
It uses GID and GDomID to index into the table to look up host domain ID.

Linux IOMMU driver programs the table entry using VFCntlMMIO Guest Domain
Map Control Register.

Introduce amd_viommu_domain_id_update(), which is used to set the entry
when attaching the nested device. Clearing the entry is done during VM
destroy.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_viommu.h |  2 ++
 drivers/iommu/amd/nested.c     |  5 ++++
 drivers/iommu/amd/viommu.c     | 42 ++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index ccdd1cbcec36..e1387d9ea97d 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -16,6 +16,8 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
 
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
 
+int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
+				u16 hdom_id, u16 gdom_id);
 #else
 
 static inline int amd_viommu_init(struct amd_iommu *iommu)
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 70af39da9360..f38813394a25 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -10,6 +10,7 @@
 #include <uapi/linux/iommufd.h>
 
 #include "amd_iommu.h"
+#include "amd_viommu.h"
 
 static const struct iommu_domain_ops nested_domain_ops;
 
@@ -245,6 +246,7 @@ static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
 				struct iommu_domain *old)
 {
 	struct dev_table_entry new = {0};
+	struct nested_domain *ndom = to_ndomain(dom);
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	int ret = 0;
@@ -262,6 +264,9 @@ static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
 
 	amd_iommu_update_dte(iommu, dev_data, &new);
 
+	ret = amd_viommu_domain_id_update(iommu, dev_data->gid,
+					  ndom->gdom_info->hdom_id, ndom->gdom_id);
+
 	mutex_unlock(&dev_data->mutex);
 
 	return ret;
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 53cf6ab2db04..80873bd62c52 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -40,6 +40,8 @@
 #define VIOMMU_DOMID_MAPPING_BASE	0x2000000000ULL
 #define VIOMMU_DOMID_MAPPING_ENTRY_SIZE	(1 << 19)
 
+#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET	0x08
+
 LIST_HEAD(viommu_devid_map);
 
 static int viommu_init_pci_vsc(struct amd_iommu *iommu)
@@ -350,6 +352,22 @@ static void free_private_vm_region(struct amd_iommu *iommu, u64 **entry,
 	*entry = NULL;
 }
 
+static void viommu_clear_mapping(struct amd_iommu *iommu,
+				 struct amd_iommu_viommu *aviommu)
+{
+	int i;
+	u16 gid = aviommu->gid;
+
+	/*
+	 * IOMMU hardware uses the domain ID mapping table to map gdom ID to hdom ID.
+	 * If the mapping does not exist, the hardware would generate error in the event log.
+	 * Therefore, initialize all gdom ID entries to map to parent domain ID to prevent
+	 * unknown mapping scenario.
+	 */
+	for (i = 0; i <= VIOMMU_MAX_GDOMID; i++)
+		amd_viommu_domain_id_update(iommu, gid, aviommu->parent->id, i);
+}
+
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *aviommu)
 {
 	pr_debug("%s: gid=%u\n", __func__, aviommu->gid);
@@ -362,6 +380,7 @@ void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *avi
 			       VIOMMU_DOMID_MAPPING_BASE,
 			       VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
 			       aviommu->gid);
+	viommu_clear_mapping(iommu, aviommu);
 }
 
 int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu)
@@ -382,8 +401,31 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
 	if (ret)
 		goto err_out;
 
+	viommu_clear_mapping(iommu, viommu);
+
 	return 0;
 err_out:
 	amd_viommu_uninit_one(iommu, viommu);
 	return -ENOMEM;
 }
+
+/*
+ * Program the DomID via VFCTRL registers
+ * This function will be called during VM init via VFIO.
+ */
+int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
+				u16 hdom_id, u16 gdom_id)
+{
+	u64 val, tmp1, tmp2;
+	u8 __iomem *vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
+
+	tmp1 = gdom_id;
+	tmp1 = ((tmp1 & 0xFFFFULL) << 46);
+	tmp2 = hdom_id;
+	tmp2 = ((tmp2 & 0xFFFFULL) << 14);
+	val = tmp1 | tmp2 | 0x8000000000000001UL;
+	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
+
+	return 0;
+}
+EXPORT_SYMBOL(amd_viommu_domain_id_update);
-- 
2.34.1

