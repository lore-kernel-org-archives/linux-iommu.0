Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC1C3B3898
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860234; cv=fail; b=YVsluSan2SPWZ91YEEj+WDj1uPOpDD2AdVIkpkzFZ9jy/2Qvg+iNSxc5hds4ndamqgEAuBDjpXxYqhzUxOYuFYBWmyXqjE4DDi9sqEPbu8iSVFuT2wt0In1KJOofK/cR8NwTlXXCqLtrZ4SNN5pGgprp5VvJYbvntY+49svWvoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860234; c=relaxed/simple;
	bh=m4vHLxM82kocWO9EPfI0A4R9DpA7GepxrkfnPHuz6RM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKZvnBiHfnHUqUXjvO5P+I15oMgsipVudq63Sx5mW5h95BedI39t4pB5avuiAhlvL9yjlSYhUGscanuQwLaBUd9NgQh/2hffoqscMnS76AIE+GiAGx9nEKOtQNqMbqFmbVrZJ/AwWyTm+J/zQCtjgMcG4JhP3jQDnFzFHdB8UOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fhSbckhM; arc=fail smtp.client-ip=40.93.196.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fhSbckhM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qoGDUb6voiW2zusYCY68u0hxn7zzQcGWuCVVspMwyeLWYCxaK7OMNviAH7tgrbNfrKeqICiKqEqiryMVfY6FyQk/m8idXm2wDfMsSOnKcDef216W9psMj61e7Wmt4MqSyUraOSGRCjUVOdrBUKtaSFIQGf6jmE0sjyB++ZhzLEfC/02nBmXYoQDj5yo/R8d/9InbLEHFZ+GuXK2cBHo7TRikeRbG5j8WcuSsez/i4hgTDbDeeJIZfeAaoVFLweEBiDnGLGmbXCEYB8YHZYSatqMh/HKWH6by67ZrZzl5BUXvzTIUk1trrX93HdUikCFUoqKCQ4Ie/fak1nXSY0wPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PT7+wr3y1BDnThpNW9M99u3497ogTH8KMBq3ubxEpLY=;
 b=WFJefgVbTk/ONL2tcRyMUP4AAyvXMV1xTmLWojRRWPR0YGc3QQ7QMZ9zxv0w6+dAaGFXidY5ksQvkmdL5yPuY55xA34+GG0oQvAXUuy+rtiAWEPy/H0P6H531Appdk/Tr3khCQPpQMuj2F0EhtF1FwJOJdPtM+XkLLwIXTiawHK5AthAc3qwLK1aGn+1kh7CuN0to3/+OuCP+Ex5vYim3fgpcASVYdxruNvKVtWfql+r1kvzJ7sp8rAHb4igr0OT3AitTRaWVOu2eT3qEei/cTbuRKBJ0jrfh/4APOuFnOQLYVQts7laSQxAQF0eJ4SFqI7e5clOGevb0AGdqGAxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PT7+wr3y1BDnThpNW9M99u3497ogTH8KMBq3ubxEpLY=;
 b=fhSbckhMP3CCqWbf/LirJGRatVrgC4s7WlUfPy+XMVPZysio0C+Aq+kpzKwscTKJ9uQDbP8+VuEdgGWi1XLje33UWsgG8EzI8Cn5mVajnq0BLL33zsa/315Ogonhn8L3x8I+DwDHGdU8RYDNQxBXZQ2EYLs5adWAwQs9tvgqmcg=
Received: from CY5PR13CA0015.namprd13.prod.outlook.com (2603:10b6:930::24) by
 DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Mon, 30 Mar 2026 08:43:48 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::15) by CY5PR13CA0015.outlook.office365.com
 (2603:10b6:930::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:43:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:43:48 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:43:42 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 14/22] iommu/amd: Introduce IOMMUFD vDevice support for AMD
Date: Mon, 30 Mar 2026 08:41:58 +0000
Message-ID: <20260330084206.9251-15-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e64280-fe68-47ef-c8db-08de8e3875ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8/55DMH4SvkMOL6FMerbJfzSYGlHb5u77zG3bt1tlypLbN1R51RJDZv2B/qoYvpDVInFmSPPvkyd8EtpXOFCK3FW6yy63WWN1PbYDj8Df4lqnP+CZ0dBnIjYaUOeAfX7qVojb9lANYEqhpncKfe7VI/yB+H0RdU+GmXtAHGSfccK14Hx7YpI0OuwUqYJtvOm0f38ry7VC3htbxSqrJnYyPOtlxsyiJ4JRiB9qXzKlWm6cyBGfPtzW/LsXlijk4y9F6p4/2PVQNYN92fsst5jGk1EMcAjdGttscFSdirS8xMy0XRTtrL5LLHmq5XzEufHAGjd3XW4V9zqSV0RKLjsAyTds/gdiHSYjm5tMVJJdMKXA04B3WSYFUYejpmZmCNbZdDT3e1gsD6z3cA8Q3NTtms40NbrMK6q4NpZIgRy71PHDu4Lt4ayf2hxrjxzO0EtFPC3V9oO6Tx7o2vb+yz/fQN2Juc+/Xrka1v0VGqohFB7luO/15gCJ65queUb5Zu4ITmkF30MqNnv9U4mjN2rK0yBM//LMXtNXvU/4iL1U2SoFk2csyeImduNRwEuSQIXWttDfCDvWb/oOHEbyOtmamISALE/PF4pHUw20qZeJQrrGdz3P45C5mrcQrzbfbgkHwMGRhZJAdfqe29wA0HSzA+sllKYaTZYXOsMdozjm9zvMN9AbmsvTWu8PcEV9zVZFn834Wt0cozwxr9e1EmpWDP/8uNfcuYiPam9Ikj993x7Pjpxl1uV95mfZXg6P2dMIoXfoazHRsFg7T5MZMzIoQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	otWpTf8DysUWeLBddNetGQFnMGif+zGilim0TxFju7PtYFCbDgsgctXsw81QXlPLDa6KYOZBGaB+oIkV6iy6QrPOqSrL7u+wNteVu3w/t18q9ScvJufZWYUcbZ3Tao9eOREJs2X3V3DZmBEpb9kLgZzSoJg1dTe/iFn6Bfv36HfV+4cJ1WOmT2c/VjtFNg/bB3xwbOxm6Tj+8okHrlA5g+ImbPa75QA/1d5dhxh2vDFFDNWlX43tgEJBK4VGsv+Gq/pdNkgWZnPiq/Gjgnh7dixYYJhALS35oQAh5ORS4HBf8gt2Da48scZq8j0CNds44YP4XWoQ5B+wteXzfUVjuM6slUHyhH7C3XEsM1XJ9Si34SSUL6tcGSEGjJe2kS6YLQL9+2NandYUGP4Ge/keP5oVFsDAy0NPqYkDngdcrITF982N/w2op7+skgpqhboA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:43:48.0051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e64280-fe68-47ef-c8db-08de8e3875ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183

Initialize vDevice for AMD vIOMMU by setting up the Device ID Mapping
table using the guest device ID.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 12 +++++++++++
 drivers/iommu/amd/iommufd.c         | 33 +++++++++++++++++++++++++++++
 drivers/iommu/amd/nested.c          | 12 +++++++++++
 3 files changed, 57 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index fda7109766f3..c50ba5cda82d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -386,6 +386,11 @@
 #define DTE_GPT_LEVEL_SHIFT	54
 #define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
 
+/* vIOMMU bit fields */
+#define DTE_VIOMMU_EN_SHIFT		15
+#define DTE_VIOMMU_GDEVICEID_MASK	GENMASK_ULL(31, 16)
+#define DTE_VIOMMU_GUESTID_MASK		GENMASK_ULL(47, 32)
+
 #define GCR3_VALID		0x01ULL
 
 /* DTE[128:179] | DTE[184:191] */
@@ -887,6 +892,9 @@ struct iommu_dev_data {
 	bool defer_attach;
 
 	struct ratelimit_state rs;        /* Ratelimit IOPF messages */
+
+	u16 gid;			/* Guest ID */
+	u16 gDevId;			/* Guest Device ID */
 };
 
 /* Map HPET and IOAPIC ids to the devid used by the IOMMU */
@@ -1113,6 +1121,10 @@ struct amd_irte_ops {
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
index c2281557b3bf..a047bb45aa14 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -9,6 +9,7 @@
 #include "amd_iommu.h"
 #include "amd_viommu.h"
 #include "amd_iommu_types.h"
+#include "../iommufd/iommufd_private.h"
 
 static const struct iommufd_viommu_ops amd_viommu_ops;
 
@@ -123,6 +124,36 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
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
+		pr_err();
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
@@ -130,4 +161,6 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 static const struct iommufd_viommu_ops amd_viommu_ops = {
 	.alloc_domain_nested = amd_iommu_alloc_domain_nested,
 	.destroy = amd_iommufd_viommu_destroy,
+	.vdevice_size = VDEVICE_STRUCT_SIZE(struct amd_iommu_vdevice, core),
+	.vdevice_init = _amd_viommu_vdevice_init,
 };
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index c210b8003fd5..70af39da9360 100644
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

