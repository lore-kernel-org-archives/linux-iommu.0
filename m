Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0936643DA59
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747738; cv=fail; b=JDouzaMljlmePl2QYVuEYW2Df3xNErqm7e8w2d2OJjzNXGJXS1wKM3wVhXOmz/fWqw7S9MKxgA4PXHRhkzue9KOmADp3B3YSeEWNhtRA4JDvs6hZeS//EWHZ67SRp43Ktavv3S2q2/7RYOGE7yQS1IUOsTZPAQ+JCtKsd/6Xn90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747738; c=relaxed/simple;
	bh=H3vY/84w/zfSnZwWawYgfc27T9af3sbMlJiXTgN5Kxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlZJ06aA3Y0qtnFavKaFU0u1HFQTuudOwejefRaBgEytDvWgzfPFx3qkzQb/FVpc2nMQ4hQm/T5dGloQJmik1iVjMZX2R5BnLdz9o2I+8wltKLZj742SNQ0kj/v71X513GKTCfUkhWVNyD1j1YVswT/CS8D5pqbAOuEPwCBsOzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Gcc6NX/; arc=fail smtp.client-ip=40.107.209.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Gcc6NX/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hO/88MTVy352pQMDtl6SpMPsNQkP3OshDL6AGdNGMx8qHZA3mANcaG2Cm00uOfFYx46xeL/ncCDUrnnIh6cidpBChLNkABTbggvKoyX6hP72b2DbPunSrRYKuDnvx/I1An2qfd3t+aMgOfT2V7NbzOodS4E9fcf2D+ya/QxHEFTz+biKFj2tJ90mVxDMj8st11him93oWuXagdwMf6ttI8r4qfJBoBJ7JKWZ/Jh5lx4ZuUMMAC1dYpA08ZibcJ0NVSRaj03MQRPHPqKL4FipmMSGPiXzFA9w5SUdZe5WYJUWSarmKEqkaPIvQ1V09dcnHjlH1LyDw1M2HVSdjy/Opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ff/1UCsEYkg+7F/lBrZvU27hGsVaX8hEpS2jcp8ucE=;
 b=VEIC6tkga56QymoDmeQfGQIoRrhFExQQXm4hKA640RaYk1+PEHA7hI+z5lSdxWX+xfMZHSGg8cNUHeyq4FafY7VSx+7EMsRGVbyo3AkOp/N8AeOeVUyqNVOP0JDmxjWuCHKNh+5e91KCyJxIyrhGorH7snNpLXOQeSgsE2LC+m5fI3bOYZwG8XmezfXg6ZGUL/1eGGtJWoYvhbUOpEeRVP3ihkDJ2COahft8L5EM8Uvbdrsp0Fb8WF6hCgO+TDLZAZJpeyqqZ80e6SEPoo1Vq45l2bwo8eKYK2c6XR2tia0D0RkAorVkZCuADMoUWzPUiWu4r4Xfiw02PdtS2W9D0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ff/1UCsEYkg+7F/lBrZvU27hGsVaX8hEpS2jcp8ucE=;
 b=5Gcc6NX/Y0Xw5/pw+NsYNHi+xvuf2Y6JAvH6ltXdArPtuqoF8Df+gxuiHrGy9++ejlxshj7oVRIL2Oz6FIR+AuzK/0r6PRNJhL9yIMG++saiHWG3jXEjMHfE78Tho77vZu2yMHA7/XTzj+yXdw9qr96RUXTg9Ru2w48pffzC/T0=
Received: from MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16) by
 DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Mon, 29 Jun 2026 15:42:10 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:23f:cafe::87) by MN2PR01CA0047.outlook.office365.com
 (2603:10b6:208:23f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Mon, 29 Jun 2026 15:42:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:57 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:37:13 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 17/22] iommu/amd: Introduce helper function for updating domain ID mapping table
Date: Mon, 29 Jun 2026 15:35:30 +0000
Message-ID: <20260629153535.15775-18-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 06be1450-7113-4a56-d03d-08ded5f4fb6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|7416014|82310400026|56012099006|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	za9TrAcziQ+4S4nEW7aGhNfs5uPsCgM5Odrw/EqxmZtfVlDx+k1Md6bnJ2L0Gf/aV3sfFUCh3ejX5DcObFdEY58yFLUs0Xflyup/No+GFIPZ/7t+lc35JnopQEvjqE/4Aim7yN8p6Wv/jLvdX56mtzLK6XDAOOlZp94gtO7hwqm/cDhemXnKSLdEtfhdylRYmpwsgdTV2WfHMlj9nCnnWBxA8xXqb1madBjNooITheAhTp295r5xwBkf+wLajZLaXl3PaNhiaQ2yw+JmS4L62AT5Zspzc0MgyUZvCR9sVqr5TZ/x8nJdrUBqTIrfj4zHUXwhi33SgHCN2hp3sGBgouqG05DNqNj91PiWHoEOdmJLhfl8fsf41fL6GwubvmUfAisJPPdZQHOk4Aoh3H8QKQLpSyySmoN31lteE9YsWVWJv8sEYyp+qlROS6Fry4uz6b9lnN6MldiRJUDD+jtR+rXxFtujTNowIswVYiHwxLwXgyrRuyv+e6gTSi3t9lfWGdXppJ+rYH/YKYsd6+TDgJvD47yEAiIHKw9/MyuhXtiWqlaypEn6wcew5cnvARACOs+4tckgAOX+bIO3P2+hS9MP6bnwKlxlLuRMe2Mjmt3mlcwpILblFwfk8UkJ6oitAbDofahf/LYj9ATxifBTB5cDrJXDWrM2Wpua/uiNNZSl1FDwOTB0v8muXW7ILL4wGhuixw5zF0oUME7hwGA8xA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(7416014)(82310400026)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J8DNGDMh4vxR3xtm9MXFti03XUKPVuPKaeROTsCEC9fkugZCk4iQJrE7OThJzhwAqtvfNzSyiolSrrRFJv7qeD7uYdl8StkLQRdbWs1Vy5pTUprHLMhCv0fkZGn5U3hqsKDN6olOHRA1PQSBmHnaCbhv7xFZIAjG0/6pQq0CxY547A5ok+Vke+Jil32ieyTefDRY+XlmFxO/9PYkLa5pQPJEXXiuWtE0lHGj4FZg2g7oSv1IDisVJC1NhLwD60ZbgeEqHOmPn8x1ASh293Ca50qQi/SWj6/3hkdGowhs+ar2PmZY4jQb1IHBnGZvAs5aoPBWcHGlfA7cUKi/7ELoQqVqcaYQc6nOnwsN5f4OXqULwLD08noQOJFtdQGwRRNFCtTsMi+LttePP4+pJ6gOmxo3JDTZgh7cR8eFpkoFJYOllLie+MY9kOeXYIIWQiKO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:42:09.9610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06be1450-7113-4a56-d03d-08ded5f4fb6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655

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
 drivers/iommu/amd/viommu.c     | 46 ++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index 8b57717c22a6..b6fd5ffc3b82 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -18,6 +18,8 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
 
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
 
+int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
+				u16 hdom_id, u16 gdom_id);
 #else
 
 static inline int amd_viommu_init(struct amd_iommu *iommu)
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 524362aed269..6fff9e67bdd8 100644
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
index 27b17edb910e..9b471aadd5df 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -40,6 +40,8 @@
 #define VIOMMU_DOMID_MAPPING_BASE	0x2000000000ULL
 #define VIOMMU_DOMID_MAPPING_ENTRY_SIZE	(1 << 19)
 
+#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET	0x08
+
 LIST_HEAD(viommu_devid_map);
 
 static int viommu_init_pci_vsc(struct amd_iommu *iommu)
@@ -427,6 +429,22 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
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
@@ -439,6 +457,7 @@ void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *avi
 			       VIOMMU_DOMID_MAPPING_BASE,
 			       VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
 			       aviommu->gid);
+	viommu_clear_mapping(iommu, aviommu);
 }
 
 int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu)
@@ -459,8 +478,35 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
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
+
+ #define DOMID_ENTRY_GDOMID_MASK	GENMASK_ULL(61, 46)
+ #define DOMID_ENTRY_HDOMID_MASK	GENMASK_ULL(29, 14)
+ #define DOMID_ENTRY_VALID		BIT_ULL(0)
+ #define DOMID_ENTRY_WRITE		BIT_ULL(63)
+
+int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
+				u16 hdom_id, u16 gdom_id)
+{
+	u64 val;
+	u8 __iomem *vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
+
+	val = FIELD_PREP(DOMID_ENTRY_GDOMID_MASK, gdom_id) |
+	      FIELD_PREP(DOMID_ENTRY_HDOMID_MASK, hdom_id) |
+	      DOMID_ENTRY_WRITE | DOMID_ENTRY_VALID;
+
+	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
+	return 0;
+}
+EXPORT_SYMBOL(amd_viommu_domain_id_update);
-- 
2.34.1

