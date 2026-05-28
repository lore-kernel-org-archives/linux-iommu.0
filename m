Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6140431B83B
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945557; cv=fail; b=HKlLKDuncn7pTG7Xa/EF/FQvIfJmpgThl3oHKJQjgPKpKsFMKUfYNrVrK/d2OorZIYbjsFybgRZx2V8pfIz17JaoQ4FGtpAsmaC6WMjbDodHMk4Iy1RGVzzwe4zpNy/8AYE1M3Da3Cg+XRGOjgvwJ5pJDHeR8Iz0xEswsxGkPyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945557; c=relaxed/simple;
	bh=pspvVki876oVGW/eNXDDWqMLMB58kSy+IaoDHlFXqWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIfj5x0lCDgJvvwBV3c6SlC+dHH0edJPkfwju0bbdDWeQOi1ij/CommDNaUHOTUUZMpf3272bNeTN1MF8HL4q/7KAYzD9wa/T6z+vkfz32Pv0ikWjbREuYzyoDI23G/xqQtCZj02bgM1V3XPlH3qRP13oHnV9kXAzSaJPh6FRDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E2AjTLdV; arc=fail smtp.client-ip=40.107.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E2AjTLdV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewuWmKhfvxA0uWjLehj0xapTdykbiAG5Q/thhjzfxuLaTREXRyBWIsDyHDyfKeSFzJ6cVyEJE4sXpraBdgUc1sIXaTt5HRelUddcjgX6SY4ud2cKYjt+PgwSXOXVf3MWLp+qhFWjmXul4hpThV3vhOfIu1ptAlCsCVwRa1Zc/pG1N+k+Cey2h47s2xyYgY9KCqWGFeu8qh/3whTvAJYWmht9JBUt1WL4GmWznf1xOftMvZp+Dp5fN/8RDPnM3x+5u0Ur61EQUSP+pfaZuAK1Ru2nod8w9QAnHQq9eGQeGdTXkiffMD/bwX0+eCH1tLYLeMQFKCkY8IwRae6KD8TssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSSdfmQtTyg5GhsJWQQjHr8On5E1LNZetsqiV6Wqtyw=;
 b=L2wj57DzKqSKrOXwEA3jtLpQbW5e5n8+a9j9dwL/eh2o0yTlflyByGBxv4HhJFBJ1jQHr0rly/DTXd1Xaq2Lz0yLeliJgdXTiJcaMo3M7aS18qlG1sONyVluZ9604eQp6eNLTUuDMGexTib4mzp2w2kin3UdhhDyU+VA2s5tYSdOPjiydG535ISaIj8dtICoPKvma7DwYR97khlG4rTmbUCzufQcmjZgEJVWvMFeT2viYvOKRTbBnPKjrFilKEV0snM6UBwLi8xlRN0qp4SwNm2z35qDFzAJOiI3t6bgdgg6S8uEnY2qDXu3GWq2EjRs0MttXmKZGbfLhyVvRKR+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSSdfmQtTyg5GhsJWQQjHr8On5E1LNZetsqiV6Wqtyw=;
 b=E2AjTLdVqzIemfftE7yA51RI8yY5T19CLze9RHHGagivb3+hck9eH0dwmKYaiS32pQwiJiYLTDzkVDj8pMTLBZ/jgGQNWBAMChVJsdnoGUESLGFtwUPn6hVeSTt50U8Oal1p2VoD/+SvUXdycBfBsrV6YiwGaEHIQMmjOsdQBiA=
Received: from SN1PR12CA0097.namprd12.prod.outlook.com (2603:10b6:802:21::32)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 05:19:11 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::11) by SN1PR12CA0097.outlook.office365.com
 (2603:10b6:802:21::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:19:11 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:19:05 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 14/26] iommu/amd: Introduce IOMMUFD vDevice support for AMD
Date: Thu, 28 May 2026 05:17:26 +0000
Message-ID: <20260528051738.596013-15-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b79f779-337d-4abd-c8d7-08debc78a6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|7416014|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	h9BjNHRes7Y9mzw7kpXqRReUo3cKTJvgdlFlJIvClATH1eDtEL/agVk9FeFlV9JiWyfs2O1rlyPgJ/2lVYQu2fPo1DJRvSfl8Gi8DzkNl7TOckBCHAREh1ifZfRIQg+mWOh/lPmwOWgkxCgxXDLIfywCa3lIzoHmH1saFjLeun/Nuvedac5hs/gPa6yjX8bdRiHIREcjEprnX/h8LoN3JpY5D6CdFo84IVryHw1OABDTw4n2Rlr1RTKJpyuY1zaC8l66KuVhwi5nGPHIyzMoSYqDqKFnb3pMyXXEUCwS0lMbgG4aDS82RV+Htn8qSD1x8XbVFoIDT2gN9283ipWq/45dXQa7M5Fz6cL9ZUytGNFO1yJmMGhng0ajTWafCxbtWNnAFe3bgR8ZK3kCJfOXa5dJPuE45/uXTOm69AZ5KwF+tbxvEoCbNhnP0uRlI26d2/lBmKDlnwfN4IT9gCEug6SYVGIThKZK4mRKtdICgsFHbOEuhBK0N2VbysjgSqWidM9TfI6HfBrj95pJVAYUBQRWWATY26boh/v8RH8pR338yVEQ3EvEMP7f6BPAcwr5sdeKBe7RM0Wfgh9RrUXCPXuvL2L7VQAFYFaWs1W/tUaKBLvRpbGfCLO030DENut9Y6UGlPHc9M7cwECrgPpYdpcSbI6uQ5UodmEz/zXgeTLXJ4IDCTnHazNnv2iU8Mx1bh/psHj9V3QmIp2HB05AJfHoYNocL42GhyfzWRBBc6I=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(7416014)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JiXGDjt62TMJf3X4u7DNuAuK18+Jh2PmE01cHGjkQ03aSSmJFGkgKvGsh9qIB8A29tH3NVOXZyJBNuYtVE6aKPlbHWMqNgtXf6vMKl8Wx1fbKhwokxVTsZ246/zUELRfCEJocIJx0kCJ4gZdndIYbglEiSChifGz/T5IgxRuoEmElU5/RC11WO3DaKA04HTrG4NFXQW/4SgUTrLcednHIYt5Jk9V06IhOlc7oIntL2kRbSRc23H4uSNMgmgbRykUrVs03RzdZ9CzxyfedeSUr4mZIu//MwlIzWhn815x4FQdnWuRg3OX27Zblpq25jRoY3jbmWlRyZbah6kTTxQe3Pho/NsjXKZcWQUt+FnijUXvbDbC3R5XQBRR92LOQC7N5bSSyO0rUusAFDadF4QBLi9s82FM2gpcv9LcaKguTBMi8jir2YxOxlSLkwKzapwB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:19:11.0225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b79f779-337d-4abd-c8d7-08debc78a6a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157

Initialize vDevice for AMD vIOMMU by setting up the Device ID Mapping
table using the guest device ID.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 12 +++++++++++
 drivers/iommu/amd/iommufd.c         | 33 +++++++++++++++++++++++++++++
 drivers/iommu/amd/nested.c          | 12 +++++++++++
 3 files changed, 57 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 63410028bae3..836d5cd08134 100644
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
@@ -894,6 +899,9 @@ struct iommu_dev_data {
 	bool defer_attach;
 
 	struct ratelimit_state rs;        /* Ratelimit IOPF messages */
+
+	u16 gid;			/* Guest ID */
+	u16 gDevId;			/* Guest Device ID */
 };
 
 /* Map HPET and IOAPIC ids to the devid used by the IOMMU */
@@ -1121,6 +1129,10 @@ struct amd_irte_ops {
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
index efa9e1f49550..eb43d02371a8 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -9,6 +9,7 @@
 #include "amd_iommu.h"
 #include "amd_viommu.h"
 #include "amd_iommu_types.h"
+#include "../iommufd/iommufd_private.h"
 
 static const struct iommufd_viommu_ops amd_viommu_ops;
 
@@ -127,6 +128,36 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	amd_viommu_uninit_one(iommu, aviommu);
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
+	dev_data->gid = aviommu->gid;
+	dev_data->gDevId = vdev->virt_id;
+	pr_debug("%s: gid=%#x, hdev_id=%#x, gdev_id=%#x\n", __func__,
+			 dev_data->gid, pci_dev_id(pdev), dev_data->gDevId);
+
+	return 0;
+}
+
 /*
  * See include/linux/iommufd.h
  * struct iommufd_viommu_ops - vIOMMU specific operations
@@ -134,4 +165,6 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 static const struct iommufd_viommu_ops amd_viommu_ops = {
 	.alloc_domain_nested = amd_iommu_alloc_domain_nested,
 	.destroy = amd_iommufd_viommu_destroy,
+	.vdevice_size = VDEVICE_STRUCT_SIZE(struct amd_iommu_vdevice, core),
+	.vdevice_init = _amd_viommu_vdevice_init,
 };
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 15dc57cf7c5f..08f74ebb3523 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -227,6 +227,18 @@ static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
 
 	/* Guest paging mode */
 	new->data[2] |= gdte->dte[2] & DTE_GPT_LEVEL_MASK;
+
+	/* vImuEn */
+	new->data[3] |= 1ULL << DTE_VIOMMU_EN_SHIFT;
+
+	/* GDeviceID */
+	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GDEVICEID_MASK,
+				   dev_data->gDevId);
+
+	/* GuestID */
+	new->data[3] |= FIELD_PREP(DTE_VIOMMU_GUESTID_MASK,
+				   dev_data->gid);
+
 }
 
 static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
-- 
2.34.1

