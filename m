Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1B3A5E65
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411739; cv=fail; b=uOhzXtZqSWOhENe2zS2b+M7OMRxMtQI22eDdpA6pRkhthUyIrDWGtE4aJ++shRLQ2banqMu5WT66GjauL2IKTtm+NDefWmaK6JQYFd5B0krYQUQFQEnbA6caEkb6ZPEaUlp8iUTbvPdepuMLirRbVGz6KziP08Nzf6RidTXwcj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411739; c=relaxed/simple;
	bh=h9hPEstwnPX73bbaNjUlO+TJPWmhB/fx8KehDfHKVE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ha13fyXsCMw+Ear85xTklmSNHrizD0LfCntVAjDrQs+uV9JVKWpW/Me0ZGmZYe4S1yzkfM0BdmNVyga9jaGTfVUjBICmpkTah+NVjy4JpvkkTkFAexQnO0Y/9MxWK9RhFxT90QkVhiRgyWLBvMBqU++mQOK8NU2tZlz7gR/pBO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wsb5gPFN; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wsb5gPFN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzzV8eMa3IdRvR/QjTxP/MvKrIkoG1XdArmVJTpuhCIQ6vevRGwgaI4PpJ2K8RuTSj1jdIluN60qSuOpEBH5UzakCKU0cH5iQR4oH7E4BLxYBjNlkzOcSnnhAtPnxsSE9wFS9fNAwC8DQmOF5pZaD9ZGWLlQVu0EkpQIZhTLlXG/4X5CYBUnixhliL+Gc6PCSMIF9Zm40W7MkqN2JTX5KIcqRAU5EPuErCr6UA1A0ORFLxqPEqTJ4cAyjKSxGA2wl4fyeTKbKhMA5WR2kvgONsr9OJOIo0uQw+Vy+ybg1LpoTzpM3sTy8T3c07r0Ad5PEP822Lg3uA0al9Z/lzrqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7jGhohnvJ5oSUeaMh8uYvPNW9me3d+YV7TXMn79h1Y=;
 b=Nr3veHpQA0/sEvdiKqf3bNmKAn7F/ClDzLoCiMa8dOCXJe+hGRlHbNx8b1yUH/+pRk/RAzZKESOe2e6yp3+SAfTW1llTMgoCRoJy5jWLalrflW9RjirQcjkA6Do8dbIIr/TNC63VA7rqLaDp8kai3FyvamZWynC0ExY8pT/MYZ9PVyHs21yvlZ8JAwSoRKLy30pMRAsCzclFHUG/DDT8AtbuzctluWldyRjUN5O4evW64fMIkiGuVe/cHGANZGcj6ZAZh/7JgzUYIWdqZs8iUQMYB0R1iXh80jUoSzdPR95gPMpcydk4Qvx1Ou+1YdlO+/HyI3INNlSEBpv0XMEeCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7jGhohnvJ5oSUeaMh8uYvPNW9me3d+YV7TXMn79h1Y=;
 b=Wsb5gPFN5i5kCBBmlyhmYoJ9yTnGB2AJ5VKrgFzZoRN2KeqqexlVwNTUUwk+wqTRGcFtyfbmxPkYHe+bMPMgLWEWiOxxJodtGexoH5nY9+UToHvbc41lF7eI4BD8aST4es/zVB/G00XKDCIOwJP9JYF3MLzfzLcYBVGRoyIPhC0=
Received: from BN9P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::32)
 by SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:48:47 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::d) by BN9P222CA0027.outlook.office365.com
 (2603:10b6:408:10c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:48:47 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:48:40 -0500
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
Subject: [PATCH v5 05/24] iommu/amd: Allocate Guest IDs for IOMMUFD vIOMMU instances
Date: Mon, 14 Sep 2026 18:47:31 +0000
Message-ID: <20260914184750.222939-6-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|SN7PR12MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 034e3151-e83a-4e85-cf2c-08df1290cf83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|82310400026|36860700016|22082099003|18002099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	h+KEyujVKyNDE+LAJNcFo+ZtkZGUPG/YMEQ5S+FwF6GPNfdbIUIn92cJH0282um1XkSrKdkl9ygLOvJnkLnuW9u+NHBwntMXfIOniOtBDOMDLvjpO3TLRzZva2AzCCGH2+W/YQyQ4BIwdb6SM9pl8Pxi7o7YsEIUcw+x1TpMKdIBfIibrukyj254lvRqAILdznZZBSLjXxJoz/ptEvELg3R0S1xGFpYZLNwkuAyEKQiN608k6bwO0d+bt/cObdAEiqm1mXZtOtru0iZ6IENBncZTu7XgF+HanQlPQsmTQm5bZxBMztxmj4TNlqFvYn0n6+TZd9rGHGf1m4dxhqdd0vCdmJwLmnekK65QFkQex8LO7XV8zRNMehozzWaR8SGO2qJL+9aLSjA1IwuPyw7gO5Sb92XSOAR+y/y/5O1rIt1sLEurg6pzhNkIs7qEvRxIorq0gxmQv5UQEwJnjXwuJ6O94Gro/6GiGNU1LHxw7cChmHmdc42vYbTRz6H592zx4EIGeHcrMfHoBMbq4ockYYr56IASNpKomCyEPPtBIWDGFEeRJW6d3WQZ3E1kDYdRwtRenVjTykDDGwX9KSaC5SFKxCkRZP3FFxt3SVu/BfF0m25lOW72edyUknX4mP9Yeisl1pw4Pb6f3odBlDZB7LX6o0Fj67lDqOim82X4++9864s+0IyuuiEWhfxf0wBWwomw9hAqPU5xuMTxaGZ9ng==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nIZvUh9vryKExmqNURMROMGrLF66rWz/rr8RI9cAtbAfc5DFOBF/RnaMGOhYahshASrYAI19EJXevcw1L5UtY7fozRAKY7qOIttJamkxALXskc+mhsOs6z7dZ3DywzN7NKRFMK0Ywg4ySYL5J8/Yf7w6tPmNxvxAvos4cOW1zJ9w+3wmCRsa3FNsasHFsX/oJP9tMbuDoB5xsxeBQnDGoggHZAw1PYqHyZsRw+NyZO+x/OlBT6kcjfEwneYioiPlMM+H11WZsJLgZj/PNZb+W1E2SLxxz8MVKXXNq+THMQlKo+Gr9uZagpStPq5UHvF+wogo/hQtSFSXthUexcT1okLaLWIG5PgDtxJ94IZmg0r0IDE/oZbu1+Gyp3N5QHf1eGJn+VrcEvT1U5MzAEfuqtdiFGpQ6vPXaGPC+xf4/K9ejGsLNPfFRwzGvt0znFf/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:48:47.5562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 034e3151-e83a-4e85-cf2c-08df1290cf83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028

Hardware vIOMMU uses a 16-bit Guest ID (GID) per guest IOMMU to
index driver and hardware state. Allocate one GID per IOMMUFD vIOMMU
from a per-amd_iommu IDA (unique within that IOMMU; a VM behind
multiple IOMMUs may hold more than one GID).

Add amd_iommu_gid_alloc() and amd_iommu_gid_free(), store the ID in
amd_iommu_viommu::gid, and call them from amd_iommufd_viommu_init()
and destroy. Initialize gid_ida in init_iommu_one() and destroy it
in free_iommu_one() with the IOMMU object.

Reject amd_iommufd_viommu_init() with -EOPNOTSUPP when the IOMMU
does not have AMD_IOMMU_FLAG_VIOMMU_EN.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  4 ++++
 drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
 drivers/iommu/amd/init.c            |  2 ++
 drivers/iommu/amd/iommu.c           | 16 ++++++++++++++++
 drivers/iommu/amd/iommufd.c         | 14 ++++++++++++++
 5 files changed, 43 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index b2ae17e3df34..f6cf412a9820 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -227,4 +227,8 @@ amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry
 struct iommu_domain *
 amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 			      const struct iommu_user_data *user_data);
+
+/* Guest ID for vIOMMU */
+int amd_iommu_gid_alloc(struct amd_iommu *iommu);
+void amd_iommu_gid_free(struct amd_iommu *iommu, int gid);
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 688cd9240790..8c38775ff5c1 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -21,6 +21,7 @@
 #include <linux/iommufd.h>
 #include <linux/irqreturn.h>
 #include <linux/generic_pt/iommu.h>
+#include <linux/idr.h>
 
 #include <uapi/linux/iommufd.h>
 
@@ -404,6 +405,9 @@
 
 #define MAX_DOMAIN_ID 65536
 
+/* Guest ID bits 0-14; bit 15 is reserved for secure vIOMMU. */
+#define VIOMMU_MAX_GID		0x7FFF
+
 /* Timeout stuff */
 #define LOOP_TIMEOUT		100000
 #define MMIO_STATUS_TIMEOUT	2000000
@@ -501,6 +505,7 @@ struct amd_iommu_viommu {
 	struct iommufd_viommu core;
 	struct protection_domain *parent; /* nest parent domain for this viommu */
 	struct list_head pdom_list;	  /* For protection_domain->viommu_list */
+	u16 gid;			  /* Guest ID for the vIOMMU */
 
 	/*
 	 * Per-vIOMMU guest domain ID to host domain ID mapping.
@@ -760,6 +765,8 @@ struct amd_iommu {
 	/* IOPF support */
 	struct iopf_queue *iopf_queue;
 	unsigned char iopfq_name[32];
+
+	struct ida gid_ida;		 /* guest IDs for this IOMMU */
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c80872ce0b60..7b4cb473019d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1797,6 +1797,7 @@ static void __init free_iommu_one(struct amd_iommu *iommu)
 	free_ga_log(iommu);
 	iommu_unmap_mmio_space(iommu);
 	amd_iommu_iopf_uninit(iommu);
+	ida_destroy(&iommu->gid_ida);
 }
 
 static void __init free_iommu_all(void)
@@ -1885,6 +1886,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 
 	raw_spin_lock_init(&iommu->lock);
 	iommu->cmd_sem_val = 0;
+	ida_init(&iommu->gid_ida);
 
 	/* Add IOMMU to internal data structures */
 	list_add_tail(&iommu->list, &amd_iommu_list);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c34a0f5a9540..fa9708af258e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -257,6 +257,22 @@ static inline bool pdom_is_sva_capable(struct protection_domain *pdom)
 	return pdom_is_v2_pgtbl_mode(pdom) || pdom_is_in_pt_mode(pdom);
 }
 
+int amd_iommu_gid_alloc(struct amd_iommu *iommu)
+{
+	int ret = ida_alloc_range(&iommu->gid_ida, 1, VIOMMU_MAX_GID, GFP_KERNEL);
+
+	if (ret >= 0)
+		pr_debug("%s: iommu devid=%#x, gid=%u\n", __func__, iommu->devid, ret);
+
+	return ret;
+}
+
+void amd_iommu_gid_free(struct amd_iommu *iommu, int gid)
+{
+	pr_debug("%s: iommu devid=%#x, gid=%u\n", __func__, iommu->devid, gid);
+	ida_free(&iommu->gid_ida, gid);
+}
+
 static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index e8e7807f2a33..69a0e61bf83d 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -49,13 +49,23 @@ size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type vi
 int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
 			    const struct iommu_user_data *user_data)
 {
+	int ret;
 	unsigned long flags;
 	struct protection_domain *pdom = to_pdomain(parent);
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+
+	if (!amd_iommu_viommu_enabled(iommu))
+		return -EOPNOTSUPP;
 
 	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
 	aviommu->parent = pdom;
 
+	ret = amd_iommu_gid_alloc(iommu);
+	if (ret < 0)
+		return ret;
+	aviommu->gid = ret;
+
 	viommu->ops = &amd_viommu_ops;
 
 	spin_lock_irqsave(&pdom->lock, flags);
@@ -70,11 +80,15 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	unsigned long flags;
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 	struct protection_domain *pdom = aviommu->parent;
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+
+	pr_debug("%s: gid=%#x, iommu devid=%#x\n", __func__, aviommu->gid, iommu->devid);
 
 	spin_lock_irqsave(&pdom->lock, flags);
 	list_del(&aviommu->pdom_list);
 	spin_unlock_irqrestore(&pdom->lock, flags);
 	xa_destroy(&aviommu->gdomid_array);
+	amd_iommu_gid_free(iommu, aviommu->gid);
 }
 
 /*
-- 
2.34.1

