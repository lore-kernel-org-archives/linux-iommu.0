Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C172C158A
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159114; cv=fail; b=lQHA0n1XgjymMtaz7msAwgsh8zuiS02CIQ8wUoMDmAaJ/8sxdUjzOxbMKlEL7ugHAfXJf9FU70A7jYTSalqrKfnaHSpxPej/fJJavOv5fXHwW4QKRaCirpxt88rHCWIf4OWzUDvuWpTtTjt51vMeiAOQkOQUHRhgJVkADdaZuLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159114; c=relaxed/simple;
	bh=fbmNSAtJHTb3DxnmoCzJU1HqS/1RZlooleL1oMtS9A4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKb1J/8BIM0enIkdP9W+tml+WM63eFHfY10QVOzbR/Lr6mdWAJwBctmWCjN2uQ6TcYpWcW0TP0oLL1LRWmdpbn/WWKNwsHgCP2p4teELs1YOY2/lDnDA+NKwmgSMx9N8gMlTFqQFxZPoScfU7sprAoFtf4dlr6cPdiLCScSsscw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gP21XURh; arc=fail smtp.client-ip=40.107.209.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gP21XURh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qq4uzcrw4FxOldKmBMKwnrG6LX3I0YA0RC5LZk4lwtyr/xJFRDJTx5lfBMEJzA61219GjfeeQnm2MFc537lIMwzgRhe37WiQsMsEqGomf8v1O69vUAUspZ+3ilo4j5zPa3fF5u4DnAyjz1cz8pSgIZKZmgnCryhHPgq2mhSGVSoRgPydnr/iFjADk/xUCOsexGSK8hy/iXTUkOfIx8KQKjMtjXfJZn41Ior+Mqs2mwnVRzZRdmdmwPdLxhLz0lqK8RnJmWp883fxj9dm95exl/HvG8dbCr8JiSPqr/JIj4QtFKXsSvQGUYCsg7O9osBSHWdTGNhwCJ5IZqd9CuKv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGEx3/CjW+3KAmV7vaFrZTe+xuRU3auh/qIMIehAaxo=;
 b=PZsf1nOFaVkNmsi/iG+I7qexK/nzM5CLwGcf9viWxxVKXx35FclXpOIeBul4efrBKhpKzEhnsWKXnnEH/d6PO38oUHJUrKtKkuO3hlu0647I6UNhTN5226qKGqFN9VHmadcN09IHCMVE6VKFWNhbAaeRYJPNqCzxZhO4kXgULSYWujy6YlzcbUhomuj5iQkEQ0sMrquHS6ypr/fmZAT2XVTMz8gn0HmbEyL+x3hwiMEVr7RXmJn58cqfjqpSA0Ex1eLJ2j8EdQdqPW9Ti5qxbOJ6g3fN6US/yjPy5r+LNQ2YXS//0ip+kK7JtuUTiTwkBhm4273hq7yMvtUd54Bqug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGEx3/CjW+3KAmV7vaFrZTe+xuRU3auh/qIMIehAaxo=;
 b=gP21XURhpRkymiWafcyFkRFVNvOnasGnC5aR7hoo+v5uhZ85l0A4tceoYJNXgjlc0Azvw57dhv78wgJmkafKptsQzWkdIGOKjQafN4xOKR1YyGaeBcVJc2MDM7WFq0bZ8k2TM9+yivPp9w4d+S6FDfxHOH+/1mYdrzx01M7lcFw=
Received: from PH8PR02CA0041.namprd02.prod.outlook.com (2603:10b6:510:2da::23)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:31:43 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::64) by PH8PR02CA0041.outlook.office365.com
 (2603:10b6:510:2da::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:31:42 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:31:27 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 16/24] iommu/amd: Introduce IOMMUFD vDevice support for AMD
Date: Mon, 27 Jul 2026 13:29:05 +0000
Message-ID: <20260727132913.22475-17-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 59737f3d-71c2-4fba-7a8d-08deebe3659a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|7416014|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	K1yaRuVQ6UFAlb1E5SdFp+2A/vmAccZ8tpIe222HWXsIENByFP8vr+5VMQPmMWVZQ3ySL5DP+pc/BM12ZKTBnSJE6hFC7ZKnzlY4fDot3ODWwans0m2fP/n/6bNvopou4zkPo1VcP8b6aL1ndZK4vTpForDVF/3/CKBWycvxhwSLo8y3oKqyhj0U1gOespLtKOUF6pOiritViaAib5YJWmzaePAHN/hlb9ygeYOrPliu+epxNEImQIHpbInyJsYiwtz3yYTBwrbuYAs6lsigY0nZMrHZDZACrjWqanWINqayvKxv/bk3NOIIPq04IUZ67JpGwRj/BdF63SVfrn0slgaYNNuFkP3XFOGCY2nSFQchYI1Zh2IJJN+2+pqphNYMzUrnJz+YPbvLHqs0G8XeBQzJYuv771V+hiO6eT6gCQClJqcTQqTuydDc5rj6dvHW3nLug4YmkHpxEfzx+hptNllQNLP5kbA1+cdAFdDKjU/D26fBKWcc5fNuKHkLplEUIABpXl6Xe1VT1xtKD0gybwQwDM07ONMgY12I6rz7tsfyVqt8fpywE+McupJGsBRNAMAjugDJ+EA3lYkRROv6I3BsWVg3E61DZxil7HAvm7zEF6Mtzmo5zrAkrYD795G+Pe6nGYoUR7pLCyR1zg2tdDnFb167uH/36xDkgVgc0YnL4rufzK5umAQMVthd0Dy2NzyygqeZuUy45KNhF3fmjg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(7416014)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iqxacSU1ZlyyS+ut2aTqsXaLgp0zJuutaTCStLp9MlogdCROh+g37vfYkgnYXK3VpZj8LLoDKo3mHe8fa2EjfyP6ih+k+T5/97zROw9DzM2X4mXmZFOc+RQKsduVd7gW7IIGYTWK+kfHzFdByCG78yl6Qey7QEJ/tLip2LE67oKk2uiI05b0cq7le9uEMFW+jIVErRYlakkH5PNl2tCHbUfiQDb6the37gFbMdvBeMTmR0Ue5mnEJL3PrrqwwGDUSY7/3IIwEH2R897ydYJBvq3CtfjrPVzdhV4sD4/eIOHD5uLPkBUJgVGOq3KYW3kyxEE4eGsCIZlZ5LOu0LAbnZ46vdISy2fxw0JODXBJE9V5a6y053F/1tLXq26gxY2x9fALbw1O4mX/7+X6ihqVFMUEdERxaCD91ksOtG2EMltdZFDHBtQB6VZj4M1IefJD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:31:42.7475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59737f3d-71c2-4fba-7a8d-08deebe3659a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249

Initialize vDevice for AMD vIOMMU by setting up the Device ID Mapping
table using the guest device ID.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 10 ++++++++++
 drivers/iommu/amd/iommufd.c         | 31 +++++++++++++++++++++++++++++
 drivers/iommu/amd/nested.c          | 27 ++++++++++++++++++++++---
 3 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 03346258e2dc..39aa872c2741 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -388,6 +388,11 @@
 #define DTE_GPT_LEVEL_SHIFT	54
 #define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
 
+/* vIOMMU bit fields */
+#define DTE_VIOMMU_EN_SHIFT		15
+#define DTE_VIOMMU_GDEVICEID_MASK	GENMASK_ULL(31, 16)
+#define DTE_VIOMMU_GUESTID_MASK		GENMASK_ULL(47, 32)
+
 #define GCR3_VALID		0x01ULL
 
 /* DTE[128:179] | DTE[184:191] */
@@ -895,6 +900,7 @@ struct iommu_dev_data {
 	bool defer_attach;
 
 	struct ratelimit_state rs;        /* Ratelimit IOPF messages */
+
 };
 
 /* Map HPET and IOAPIC ids to the devid used by the IOMMU */
@@ -1122,6 +1128,10 @@ struct amd_irte_ops {
 	void (*clear_allocated)(struct irq_remap_table *, int);
 };
 
+struct amd_iommu_vdevice {
+	struct iommufd_vdevice core;
+};
+
 #ifdef CONFIG_IRQ_REMAP
 extern struct amd_irte_ops irte_32_ops;
 extern struct amd_irte_ops irte_128_ops;
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index bfc4b0ec22a9..1975b2932107 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -9,6 +9,7 @@
 #include "amd_iommu.h"
 #include "amd_viommu.h"
 #include "amd_iommu_types.h"
+#include "../iommufd/iommufd_private.h"
 
 static const struct iommufd_viommu_ops amd_viommu_ops;
 
@@ -126,6 +127,34 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	amd_iommu_gid_free(iommu, aviommu->gid);
 }
 
+/*
+ * Called from drivers/iommu/iommufd/viommu.c: iommufd_vdevice_alloc_ioctl()
+ */
+static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
+{
+	struct iommu_dev_data *dev_data;
+	struct pci_dev *pdev = to_pci_dev(vdev->idev->dev);
+	struct iommufd_viommu *viommu = vdev->viommu;
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+
+	if (!pdev) {
+		pr_err("%s: not a PCI device\n", __func__);
+		return -EINVAL;
+	}
+
+	dev_data = dev_iommu_priv_get(&pdev->dev);
+	if (!dev_data) {
+		pr_err("%s: Device not found (devid=%#x)\n",
+		       __func__, pci_dev_id(pdev));
+		return -EINVAL;
+	}
+
+	pr_debug("%s: gid=%#x, hdev_id=%#x, gdev_id=%#llx\n", __func__,
+		 aviommu->gid, pci_dev_id(pdev), vdev->virt_id);
+
+	return 0;
+}
+
 /*
  * See include/linux/iommufd.h
  * struct iommufd_viommu_ops - vIOMMU specific operations
@@ -133,4 +162,6 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 static const struct iommufd_viommu_ops amd_viommu_ops = {
 	.alloc_domain_nested = amd_iommu_alloc_domain_nested,
 	.destroy = amd_iommufd_viommu_destroy,
+	.vdevice_size = VDEVICE_STRUCT_SIZE(struct amd_iommu_vdevice, core),
+	.vdevice_init = _amd_viommu_vdevice_init,
 };
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 81a5ae00225e..6f3ae2496160 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -10,6 +10,7 @@
 #include <uapi/linux/iommufd.h>
 
 #include "amd_iommu.h"
+#include "amd_viommu.h"
 
 static const struct iommu_domain_ops nested_domain_ops;
 
@@ -183,13 +184,16 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	return ERR_PTR(ret);
 }
 
-static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
-			   struct iommu_dev_data *dev_data, struct dev_table_entry *new)
+static int set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
+			  struct iommu_dev_data *dev_data, struct dev_table_entry *new)
 {
+	int ret;
+	u16 gid;
 	struct protection_domain *parent;
 	struct nested_domain *ndom = to_ndomain(dom);
 	struct iommu_hwpt_amd_guest *gdte = &ndom->gdte;
 	struct pt_iommu_amdv1_hw_info pt_info;
+	unsigned long gDevId;
 
 	/*
 	 * The nest parent domain is attached during the call to the
@@ -197,9 +201,15 @@ static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
 	 * of the struct amd_iommu_viommu.parent.
 	 */
 	if (WARN_ON(!ndom->viommu || !ndom->viommu->parent))
-		return;
+		return -EINVAL;
 
+	gid = ndom->viommu->gid;
 	parent = ndom->viommu->parent;
+
+	ret = iommufd_viommu_get_vdev_id(&ndom->viommu->core, dev_data->dev, &gDevId);
+	if (ret)
+		return ret;
+
 	amd_iommu_make_clear_dte(iommu, dev_data->devid, new);
 
 	/* Retrieve the current pagetable info via the IOMMU PT API. */
@@ -227,6 +237,17 @@ static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
 
 	/* Guest paging mode */
 	new->data[2] |= gdte->dte[2] & DTE_GPT_LEVEL_MASK;
+
+	/* vImuEn */
+	new->data[3] |= 1ULL << DTE_VIOMMU_EN_SHIFT;
+
+	/* GDeviceID */
+	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GDEVICEID_MASK, (u16)gDevId);
+
+	/* GuestID */
+	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GUESTID_MASK, gid);
+
+	return 0;
 }
 
 static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
-- 
2.34.1

