Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CC331A81C
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945606; cv=fail; b=TDfJhmVUcH7gWmMXtM2m67v0sSuLmKJeUdoPGL1GrHIDa0usQTrPjr3Nv6MKQYpG049Bbm6jcH+x0PHwb9z015fCBogYLlHic0Bfozwtph/T2VvnV9ReZiCcdtr5pv2YpfEHB1fp9wEY4E/0PHboRxIPa/3SaT6VTCFvL+8dGu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945606; c=relaxed/simple;
	bh=oRL2AQPqEFbVB/j0LKqLT70YJx9wT43cMo+Q94hBFCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awL71QNt7bJARAr9sph1ksXZQJM9iPlS9a2t3OxrjPx9K52FckkNpi3lAqgmL7uB8WV7i+DhWFufIq62jvyFgpulHFNvTHARa+hd51Eq7SbkC1FnDqBOSsrsl/5ypxf4HCz1JtInLd3l7OUhmzsb3NfEkFsNXjSPcgKlibj2tGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pD5zCTM9; arc=fail smtp.client-ip=40.93.198.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pD5zCTM9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8+Dzp80se1tbuE/UN7dxWBBYWAh+2IBy1uY+AKSJ7QwDKOCKQ3/zoShagJ17Tpvviish0aU02paJ73UwtRRqwbn1YHQ/EM/bzZFSQtyH4whepbSqQUusNLtUYp9lynRdk2p5H2Keqq7HZ1US9DsZCzn7xRyf96JBf+CzbWRf+pfuq78iQour+hZJKuYMybOoVxmMXRuPsslEDI7avtG+UZUHB6Ta4sDrbBSKyVRdRhUD2UOBEXeriwb5X2kYyf+FeJNEs3tm4+9A65qKnjj6asIlP9iMminV7whza40iIiMCzK8M+PfT314yIyC68cu7u2VqMdqQRNIfx9j1r4MLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7ZNJuy0brnwnWX/5TFAZBfiQfXzJvYKMJiyLPmphfI=;
 b=j9pqZBNt7eeCN/6YFLG0ivN4SePfaNRqWPkoggGRVJIXNPtSSyBI5mjuurOUqX99j6KiOMHf2Y/dKURihvayyCSaylZBeRWQQ8/yS09A5fmt4FY86290PRtjeJdOjdIr1Q0Kh6I0B196lBWEmo3JWfdQAlUFuIELTNebY4/dB9DEqwB3xtYBTmY3IaRwMgmuoYu18mTDXu4A2Fi6tKHbGFbppkQGAcb/Sx9wEyIUJQjdvC4ayPLB5kxtlwr+Q3/LMx3SsnokXocUVTVTsIebuzcGWTWi72uy83F7CSviLD1xt4r6Yh9PVfmQpah0og13+7DCz6eOlxSNIk8R7WdFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7ZNJuy0brnwnWX/5TFAZBfiQfXzJvYKMJiyLPmphfI=;
 b=pD5zCTM957qKobb6LF16xBXOspmsaLhPCJytuZ2UwnTS2+96vNZBSfkfSp/bzmXh4BXJ0k4q5jjxYX1Mbl4sGXk35r0uum+v1aw/UbA6JZtmKzgIpufXahrH9HQTq3gQ9s0JIAR1fG0HplvpF9y0LRejXRoB55cVTyOlR4nCzhc=
Received: from CH0P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::24)
 by IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 05:19:53 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::a6) by CH0P223CA0006.outlook.office365.com
 (2603:10b6:610:116::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:19:52 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:19:48 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 23/26] iommu/amd: Add support for vIOMMU HW queues initialization
Date: Thu, 28 May 2026 05:17:35 +0000
Message-ID: <20260528051738.596013-24-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|IA1PR12MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: c02c5050-4438-4b6a-9424-08debc78bf81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fw30T5PXSeG0iNpeYhbLXdWcRgewTrEBTWZmnMCmJQXHOdff5F0BJlu/wjiXQ1BH7iAMHMfTbjzQGbVlD790OYPE23CyJTwmrYpUH3V4Lc7TNdaEWSNdM5icVLUiROpap64kOpDsBvyJzaC4Ei7t/KAv6NJtTO26yWTUJo9sGaKaKzDYDri1QGazKXw8rCcyH62XbBhnqh54qPx/20bXIDpfg+LGqsouL0J8cbGJsJBH7kSfYlOq4di5lhHne3wuc8UF5UkuzEa697gnUybakcv6GxSlNDO8JF4p5/T+v4PcU7uhptRUubZvYoh4lbVYgUlLzFDYai06ovFr1mFvYkIJSdAnRspndozxNVBpcW59NbX8Ejv1stecw39ICP5/BrQRtXo7ujU8/uPVSnnB3pJPvxD124VIE9b23rbGd0hfH6/zKLLc8+6RPIpPBaUghC9shDHZarU5xaa9rVgqJhGf37vjnxvnNkX0CIwd8x0MRtG9oXu3UnnRFi4cJsMYVFTe9uSkgj4MX/G3KuuG+hxWScPg+NeFRiUZ87cucse6nAmhTJ7ainWyqywbAdCF3z5wckhd/9DxmDsoCdliSaXptuYm/8bLexbEvqrc+VFs9qB6tbbFyTCUKyRgda3+mTekoWzLHK+kKz/yj6KxvMEFbjjhFmdkTDw24RQ5aLOWzyLXV5yhAmzTiTTlEEVRT3a/KwrjIHm8Vy9bvnjNnnLQP1pMPFHaUFjeK6pUXKg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1skURhEQhrSFGJ6gp7/d2nif/1pmZQPZIX/ZMQZSfzSJdRHGiXgLXDgiFHtPWfHO4fRjdWhgPLw4js1r4TCURL+KQSg2A8eu1ULaeB3E00Bdtaim1evF/MOcB8JGvHYYKANJmau+mcthWcidfWD98XLrWcuBDaDLHYvVixTFWZHKitJAAfKExaSFnv2P0jWuXeh/mnZ/k/8Nz5bkBsPhlceLdDL0gS7MoeDqrE7qNa1eDB2Vtmd9o1WN5aoBwy//dv808v0euqwmGdGZazEdwH8zbeKAjcmbtqRjPSXHYYxNbzGuH3NOuIW3wI9pQQANHUkoF7KTKiVRKPCOiVKuTg6UAta/Wl7+sfJ3suHzHdWOo5Lt8ct/LqYp1NYGRU3aIXgwgDR5tLYvkx1JIvOXLCGJWPnyLam4K0fFg5V631hFncvxt7tAACLtXAN2TOYo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:19:52.7887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c02c5050-4438-4b6a-9424-08debc78bf81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460

AMD HW vIOMMU supports virtualizing Command buffer, Event log, and PPR log.
Each can be initialized using the struct iommufd_viommu_ops.hw_queue_init
to communicate base address (GPA) and length of each queue to the AMD IOMMU
driver in order to programe the corresponded VF control MMIO registers.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |   8 +++
 drivers/iommu/amd/iommufd.c         | 108 ++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h        |   3 +
 3 files changed, 119 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 92c83c68b2b1..70d060a85e66 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -507,6 +507,10 @@ extern bool amdr_ivrs_remap_support;
 #define VIOMMU_VFCTRL_MMIO_BASE(iommu, guestId) \
 	(iommu->vfctrl_base + (guestId * VIOMMU_VFCTRL_MMIO_ENTRY_SIZE))
 
+#define VIOMMU_VFCTRL_MMIO_GUEST_COMMAND_CONTROL_OFFSET	0x20
+#define VIOMMU_VFCTRL_MMIO_GUEST_EVENT_CONTROL_OFFSET	0x28
+#define VIOMMU_VFCTRL_MMIO_GUEST_PPR_CONTROL_OFFSET	0x30
+
 struct amd_iommu;
 struct iommu_domain;
 struct irq_domain;
@@ -1166,6 +1170,10 @@ struct amd_iommu_vdevice {
 	struct iommufd_vdevice core;
 };
 
+struct amd_iommu_hw_queue {
+	struct iommufd_hw_queue core;
+};
+
 #ifdef CONFIG_IRQ_REMAP
 extern struct amd_irte_ops irte_32_ops;
 extern struct amd_irte_ops irte_128_ops;
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 23a2c8c20365..7e6381e5a06b 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -200,6 +200,112 @@ static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
 	return 0;
 }
 
+static size_t _amd_viommu_get_hw_queue_size(struct iommufd_viommu *viommu,
+					    enum iommu_hw_queue_type queue_type)
+{
+	/* Currently do not support Eventlog B and PPRlog B */
+	if ((queue_type != IOMMU_HW_QUEUE_TYPE_AMD_CMD) &&
+	    (queue_type != IOMMU_HW_QUEUE_TYPE_AMD_EVT) &&
+	    (queue_type != IOMMU_HW_QUEUE_TYPE_AMD_PPR))
+		return 0;
+
+	return HW_QUEUE_STRUCT_SIZE(struct amd_iommu_hw_queue, core);
+}
+
+static int _amd_viommu_hw_queue_init(struct iommufd_hw_queue *hw_queue, u32 index)
+{
+	int ret = 0;
+	u64 val, vfctrl_mask, base;
+	u8 __iomem *vfctrl, *vf;
+	struct iommufd_viommu *viommu = hw_queue->viommu;
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+	int gid = aviommu->gid;
+
+	vf = VIOMMU_VF_MMIO_BASE(iommu, gid);
+	vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
+
+	switch (hw_queue->type) {
+	case IOMMU_HW_QUEUE_TYPE_AMD_CMD:
+	{
+		/*
+		 * Capture base and length from guest Command Buffer control register.
+		 * and program onto VF Ctrl MMIO Command Buffer Control register.
+		 *
+		 * Command Buffer Control register field mapping :
+		 * - ComBase[51:12] = vfctrl[51:12]
+		 * - ComLen[3:0] = vfctrl[3:0]
+		 *
+		 * Guest Command Buffer Control Register field mapping :
+		 * - ComBase[51:12] = vfctrl[51:12]
+		 * - ComLen[3:0] = vfctrl[3:0]
+		 */
+		vfctrl_mask = GENMASK_ULL(51, 12) | GENMASK_ULL(3, 0);
+		val = readq(vfctrl + VIOMMU_VFCTRL_MMIO_GUEST_COMMAND_CONTROL_OFFSET) &
+		      (~vfctrl_mask);
+		base = FIELD_GET(GENMASK_ULL(51, 12), hw_queue->base_addr);
+		val |= FIELD_PREP(GENMASK_ULL(51, 12), base) |
+		       FIELD_PREP(GENMASK_ULL(3, 0), hw_queue->length);
+		writeq(val, vfctrl + VIOMMU_VFCTRL_MMIO_GUEST_COMMAND_CONTROL_OFFSET);
+		break;
+	}
+	case IOMMU_HW_QUEUE_TYPE_AMD_EVT:
+	{
+		/*
+		 * Capture base and length from guest Event Buffer control register.
+		 * and program onto VF Ctrl MMIO Event Buffer Control register.
+		 *
+		 * Event Buffer Control register field mapping :
+		 * - EvtBase[51:12] = vfctrl[51:12]
+		 * - EvtLen[3:0] = vfctrl[3:0]
+		 *
+		 * Guest Event Buffer Control Register field mapping :
+		 * - EvtBase[51:12] = vfctrl[51:12]
+		 * - EvtLen[3:0] = vfctrl[3:0]
+		 */
+		vfctrl_mask = GENMASK_ULL(51, 12) | GENMASK_ULL(3, 0);
+		val = readq(vfctrl + VIOMMU_VFCTRL_MMIO_GUEST_EVENT_CONTROL_OFFSET) &
+		      (~vfctrl_mask);
+		base = FIELD_GET(GENMASK_ULL(51, 12), hw_queue->base_addr);
+		val |= FIELD_PREP(GENMASK_ULL(51, 12), base) |
+		       FIELD_PREP(GENMASK_ULL(3, 0), hw_queue->length);
+		writeq(val, vfctrl + VIOMMU_VFCTRL_MMIO_GUEST_EVENT_CONTROL_OFFSET);
+		break;
+	}
+	case IOMMU_HW_QUEUE_TYPE_AMD_PPR:
+	{
+		/*
+		 * Capture base and length from guest PPR Buffer control register.
+		 * and program onto VF Ctrl MMIO PPR Buffer Control register.
+		 *
+		 * PPR Buffer Control register field mapping :
+		 * - PPRBase[51:12] = vfctrl[55:16]
+		 * - PPRLen[3:0] = vfctrl[3:0]
+		 *
+		 * Guest PPR Buffer Control Register field mapping :
+		 * - PPRBase[51:12] = vfctrl[55:16]
+		 * - PPRLen[3:0] = vfctrl[3:0]
+		 */
+		vfctrl_mask = GENMASK_ULL(55, 16) | GENMASK_ULL(3, 0);
+		val = readq(vfctrl + VIOMMU_VFCTRL_MMIO_GUEST_PPR_CONTROL_OFFSET) & (~vfctrl_mask);
+		base = FIELD_GET(GENMASK_ULL(51, 12), hw_queue->base_addr);
+		val |= FIELD_PREP(GENMASK_ULL(55, 16), base) |
+		       FIELD_PREP(GENMASK_ULL(3, 0), hw_queue->length);
+		writeq(val, vfctrl + VIOMMU_VFCTRL_MMIO_GUEST_PPR_CONTROL_OFFSET);
+		break;
+	}
+	default:
+		pr_err("%s: Invalid type (%#x)\n", __func__, hw_queue->type);
+		return -EINVAL;
+	}
+
+	pr_debug("%s: iommu_devid=%#x, gid=%#x, type=%#x, addr=%#llx, len=%#lx, val=%#llx\n",
+		 __func__, iommu->devid, gid, hw_queue->type,
+		 hw_queue->base_addr, hw_queue->length, val);
+
+	return ret;
+}
+
 /*
  * See include/linux/iommufd.h
  * struct iommufd_viommu_ops - vIOMMU specific operations
@@ -209,4 +315,6 @@ static const struct iommufd_viommu_ops amd_viommu_ops = {
 	.destroy = amd_iommufd_viommu_destroy,
 	.vdevice_size = VDEVICE_STRUCT_SIZE(struct amd_iommu_vdevice, core),
 	.vdevice_init = _amd_viommu_vdevice_init,
+	.get_hw_queue_size = _amd_viommu_get_hw_queue_size,
+	.hw_queue_init = _amd_viommu_hw_queue_init,
 };
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 69aa44bba95a..e08de6ab8209 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1326,6 +1326,9 @@ enum iommu_hw_queue_type {
 	 *   emulated vSMMU's IDR1.CMDQS to log2(huge page size / 16 bytes)
 	 */
 	IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV = 1,
+	IOMMU_HW_QUEUE_TYPE_AMD_CMD,
+	IOMMU_HW_QUEUE_TYPE_AMD_EVT,
+	IOMMU_HW_QUEUE_TYPE_AMD_PPR,
 };
 
 /**
-- 
2.34.1

