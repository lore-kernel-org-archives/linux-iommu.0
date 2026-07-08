Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270DC3B2FCE
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 01:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475838; cv=fail; b=p16a++aSrpRH3nWVRkza3mCC61T6KOAm5pMQyfKFhALfvs1PJGIC1tQG5Ox/ZsV7j65juXJ+V8o+tRTNqzoas35DvRBPWp4FA1C662ZRhjrTVyFMFZIbMBEgEII+f8zLPNc2q0mkt/PQoWk6CqDUZEysXeH+Px56fbge5xheUTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475838; c=relaxed/simple;
	bh=XMhbJ8ongTGLpdJglWYe+rTadJDafCkYg+PKmlpg2fU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMCsWYSW+zY+acQJ1q09IBGnwBt4OBu1GiVYBb6JxTojwuIQWdHpq6FYY5mrIetSSgnNPo4HVIVhNgWiKtecxZ5VC49cArZaLP9hnowZL8AaKDFyUAxcQ5VD6iqEfo+uTZpOoXlqWhxS6uQpRCkM0Bb4VpIm4zfmJVUKmYdD53Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w9U9mP/+; arc=fail smtp.client-ip=52.101.61.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w9U9mP/+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfpe+1aqK8jBh2Pmy/1rhJpyfnMi6PR+qJHScU3dOg0f1LpSsPDZ4K9B+n04wCgbUbZQuGS56J7m9P6H6pyliomHMe2RmRNSqGxtQKlBxA4iDFQ3PJil5MBL2MlT5AzZeWbZLyv21LSfLkUpipEM8FmS3uessTTRhShEFOzKaFX7QHMsOL25lKFrRUssWBILmWanBDj2Jx3JCSedMSWiuwlfpzBifjhZqlaRP9yR0PzgDdMMbrKe47THhzV94/2oArSg5hv72oQP8zwrGwn4WLxZSObjzuHt02r/3j80IPrZA8qzvDvaHgIhfwQzqekCgr0no94ZfISJ4qVO+Yy64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R116htDrE/8I5738LsowFwIdS4OsKOEC+atDb/XK0XU=;
 b=KkyzScyirOqABSg8YpJ9kAxJ66yotTyFQBG7jaA929ZDBAWntu7ZGiIi+dUwKkgH/Mfrn5eJyNhW/Y94j/oKkS8mQZ6q5ox05Ap/VkiiCmc2vOaFtgwxOhjYE6/6hijYu2zs2Wm4x+9GCsF3xY+MVKJYUNjHgNW7+D8zgAQT0CpsPv0DTeYQtcQFSXVguppmjH61F9EnvghUnhgxMhSo+OT5Ad5Gfo74AwuQDHx8qfz03mLYAB4EnFbJAJCaTYr7sbD2iUTO3eCsH5H0Zoo1QGH4sRr90EsK6gsghnBWVqlJW+/FjJkj96/x7u7K19mB95se36oKgW+Q7YLo0wZJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R116htDrE/8I5738LsowFwIdS4OsKOEC+atDb/XK0XU=;
 b=w9U9mP/+YeuDaGBNTR2OVH1oFS6QiDPw6saEtRdZejCrdrnjie14vKLigPSt6HXnHrmYEau893gjeD1oAjjM0thT05FUzpCFKpzORWayEwPxEj74PCSppv6iXiOoUmEi/e9RBmhelFWO4b7i4v9zIoFaz5PO3RWCAqB9W1rYt5Y=
Received: from BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::9)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 01:57:11 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::37) by BY1P220CA0024.outlook.office365.com
 (2603:10b6:a03:5c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 01:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 01:57:10 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 20:57:03 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.k@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	"Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/2] iommu/amd: add vIOMMU HW queue initialization
Date: Wed, 8 Jul 2026 01:56:28 +0000
Message-ID: <20260708015628.255088-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708015628.255088-1-suravee.suthikulpanit@amd.com>
References: <20260708015628.255088-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cae5e38-303c-4f25-3f6b-08dedc943972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|7416014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	U17RtwEFILSMUNbI5DXhkn2vJLB8lH8VmH+xCp3Ky67QPQxfiRYWFjI9rkTUOlSI6Kar8GdSUGMyaDNiBIBMx8f9dySwzfUEYnDdE+cX+ET9R6mcJW+cxFjbYzSJ58Bm6xie85mvi69WGSsCwzJQrvohDRVrXrIIUs/WPjWdmO3zu9wTd8wYbBVDkM69BxUhFu7e66vdPGkXSCiWzkB7AlQaHQjxnIH3KYLlUxouWUxC+05fO8vTb18gPKqarsDO+Sv5k2CRyzhzApT67vQPE5AXDT/4D+5qeocQfiy1b52ZarwBLY7GuwvMSZEayfqz9MfQ4dYQl43ll5YeA5CJARtRFQXnoGtVpj3lahqaXeQnSltyGYdRA/smXewKCAsRojnhjBetMGEBl5wTtfBCbb0EDVj6HaDC2cnXajlq0wzW291bijSZW0qQVWawtf/2FHNnX1+xoBdw2FcqmGRg2lTlLWP9TS611B/7qgV/qZOU25y3bgEdzI/+Hufx9CTERVLgrTTHKVia5zxE2O1Rja5HrUQHueLByP4u/x3wf5Ee/xpD+kS57KtrqbM1q0zrgSUw3xteEZb6hEHVV7Ex1I4HIwAviTdKn7mfsx/kbap64MWs+G4QVE5KFZp3IP9wnAVb9eYTMY8vBL8ZhmhPxMkGok4hDBr88Zp+T7bOs/gvobyn3Smi3x0/Z2yq6ITSLQla1pNxXRlYLz5CMsm9jw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WbyE7PTMng9manV6K7ev9b88JL4WQPJNmn4uINfQR6Dv2yUyT44QsoY8KGnVBuA0RymPWZ+8RIquPZtnq6q8Bvg3sq4gADV6tJVwY/T7rwcQT/S78cG7lautC5Sn2D4pK8auU7FB2r8jl5sAX0t8/FJfVuR3fBgCKaz26scYEUCjRLaci33+8RPZ7pPQSPuuA0EEjViBT6WFNt6ute5HX5fZuk3rV0bf0j+Zw47e/8stwgcWu468ONxY3c0OirfTdBIHFrXg6G8qaKKM2Jx+n2C579VodKw1AH3Jw6CsNkauIpUhPMC0cQ0/mKXctCW4RyTOu7rgXVg2TiNhHvUL1VN0olRmjyeU9GHrywyzjSSTUsErx+bAV40Fr6NKLF7pbnEjBTq3wP025oDSFSn/2eKLalHtBGjP4EEJCa0HAt5jYTPTx5e+F/dKGArZ1dol
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:57:10.8897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cae5e38-303c-4f25-3f6b-08dedc943972
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563

Plumb HW queue flags through IOMMU_HW_QUEUE_ALLOC and add AMD HW
queue types and flags to the UAPI. Program VFCTRL guest command,
event, and PPR queue base addresses and lengths during hw_queue_init.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |   8 ++
 drivers/iommu/amd/iommufd.c         | 129 ++++++++++++++++++++++++++++
 drivers/iommu/iommufd/viommu.c      |   3 +-
 include/linux/iommufd.h             |   1 +
 include/uapi/linux/iommufd.h        |  31 ++++++-
 5 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1090d7796ce5..ffd28f2a72b2 100644
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
@@ -1153,6 +1157,10 @@ struct amd_iommu_vdevice {
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
index 0d80eaeee662..38b2fc4d79da 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/iommu.h>
+#include <linux/amd-iommu.h>
 
 #include "iommufd.h"
 #include "amd_iommu.h"
@@ -185,6 +186,132 @@ static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
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
+static void _amd_viommu_set_cmdbuf_flags(struct iommufd_hw_queue *hw_queue)
+{
+	u8 __iomem *vfctrl, *vf;
+	u32 flags = hw_queue->flags;
+	u64 val;
+	struct iommufd_viommu *viommu = hw_queue->viommu;
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+	int gid = aviommu->gid;
+
+	vf = VIOMMU_VF_MMIO_BASE(iommu, gid);
+	vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
+
+	/* Clear fields in VFCTRL MMIO */
+	val = readq(vfctrl + VIOMMU_VFCTRL_MMIO_GUEST_COMMAND_CONTROL_OFFSET);
+	val &= ~(GENMASK_ULL(51, 12) | GENMASK_ULL(9, 8) | GENMASK_ULL(3, 0));
+
+	/* Set Command buffer base, length, enable, command wait enable */
+	val |= FIELD_PREP(GENMASK_ULL(3, 0), hw_queue->length);
+	val |= FIELD_PREP(GENMASK_ULL(51, 12), (hw_queue->base_addr >> 12));
+	val |= FIELD_PREP(BIT_ULL_MASK(8), !!(flags & IOMMU_HW_QUEUE_FLAG_AMD_CMDBUF_EN));
+	val |= FIELD_PREP(BIT_ULL_MASK(9), !!(flags & IOMMU_HW_QUEUE_FLAG_AMD_COMWAIT_EN));
+
+	writeq(val, vfctrl + VIOMMU_VFCTRL_MMIO_GUEST_COMMAND_CONTROL_OFFSET);
+
+	pr_debug("%s: iommu_devid=%#x, gid=%#x, type=%#x, addr=%#llx, len=%#lx, flags=%#x, val=%#llx\n",
+		 __func__, iommu->devid, gid, hw_queue->type,
+		 hw_queue->base_addr, hw_queue->length, flags, val);
+}
+
+static void _amd_viommu_set_evtbuf_flags(struct iommufd_hw_queue *hw_queue)
+{
+	u8 __iomem *vfctrl, *vf;
+	u32 flags = hw_queue->flags;
+	u64 val;
+	struct iommufd_viommu *viommu = hw_queue->viommu;
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+	int gid = aviommu->gid;
+
+	vf = VIOMMU_VF_MMIO_BASE(iommu, gid);
+	vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
+
+	/* Clear fields in VFCTRL MMIO */
+	val = readq(vfctrl + VIOMMU_VFCTRL_MMIO_GUEST_EVENT_CONTROL_OFFSET);
+	val &= ~GENMASK_ULL(51, 0);
+
+	/* Set Event buffer base and length */
+	val |= FIELD_PREP(GENMASK_ULL(3, 0), hw_queue->length);
+	val |= FIELD_PREP(GENMASK_ULL(51, 12), (hw_queue->base_addr >> 12));
+	val |= FIELD_PREP(BIT_ULL_MASK(8), !!(flags & IOMMU_HW_QUEUE_FLAG_AMD_EVT_LOG_EN));
+	val |= FIELD_PREP(BIT_ULL_MASK(9), !!(flags & IOMMU_HW_QUEUE_FLAG_AMD_EVT_INT_EN));
+	writeq(val, vfctrl + VIOMMU_VFCTRL_MMIO_GUEST_EVENT_CONTROL_OFFSET);
+
+	pr_debug("%s: iommu_devid=%#x, gid=%#x, type=%#x, addr=%#llx, len=%#lx, flags=%#x, val=%#llx\n",
+		 __func__, iommu->devid, gid, hw_queue->type,
+		 hw_queue->base_addr, hw_queue->length, flags, val);
+}
+
+static void _amd_viommu_set_pprbuf_flags(struct iommufd_hw_queue *hw_queue)
+{
+	u8 __iomem *vfctrl, *vf;
+	u32 flags = hw_queue->flags;
+	u64 val;
+	struct iommufd_viommu *viommu = hw_queue->viommu;
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+	int gid = aviommu->gid;
+
+	vf = VIOMMU_VF_MMIO_BASE(iommu, gid);
+	vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
+
+	/* Clear fields in VFCTRL MMIO */
+	val = readq(vfctrl + VIOMMU_VFCTRL_MMIO_GUEST_PPR_CONTROL_OFFSET);
+	val &= ~GENMASK_ULL(55, 0);
+
+	/* Set PPR buffer base and length */
+	val |= FIELD_PREP(GENMASK_ULL(3, 0), hw_queue->length);
+	val |= FIELD_PREP(GENMASK_ULL(55, 16), (hw_queue->base_addr >> 12));
+	val |= FIELD_PREP(BIT_ULL_MASK(8), !!(flags & IOMMU_HW_QUEUE_FLAG_AMD_PPRLOG_EN));
+	val |= FIELD_PREP(BIT_ULL_MASK(9), !!(flags & IOMMU_HW_QUEUE_FLAG_AMD_PPRINT_EN));
+	val |= FIELD_PREP(BIT_ULL_MASK(10), !!(flags & IOMMU_HW_QUEUE_FLAG_AMD_PPR_EN));
+	val |= FIELD_PREP(BIT_ULL_MASK(13), !!(flags & IOMMU_HW_QUEUE_FLAG_AMD_PPR_AUTO_RSP_EN));
+	val |= FIELD_PREP(BIT_ULL_MASK(14), !!(flags & IOMMU_HW_QUEUE_FLAG_AMD_BLKSTOPMRK_EN));
+	val |= FIELD_PREP(BIT_ULL_MASK(15), !!(flags & IOMMU_HW_QUEUE_FLAG_AMD_PPR_AUTO_RSP_AON));
+	writeq(val, vfctrl + VIOMMU_VFCTRL_MMIO_GUEST_PPR_CONTROL_OFFSET);
+
+	pr_debug("%s: iommu_devid=%#x, gid=%#x, type=%#x, addr=%#llx, len=%#lx, flags=%#x, val=%#llx\n",
+		 __func__, iommu->devid, gid, hw_queue->type,
+		 hw_queue->base_addr, hw_queue->length, flags, val);
+}
+
+static int _amd_viommu_hw_queue_init(struct iommufd_hw_queue *hw_queue, u32 index)
+{
+	int ret = 0;
+
+	switch (hw_queue->type) {
+	case IOMMU_HW_QUEUE_TYPE_AMD_CMD:
+		_amd_viommu_set_cmdbuf_flags(hw_queue);
+		break;
+	case IOMMU_HW_QUEUE_TYPE_AMD_EVT:
+		_amd_viommu_set_evtbuf_flags(hw_queue);
+		break;
+	case IOMMU_HW_QUEUE_TYPE_AMD_PPR:
+		_amd_viommu_set_pprbuf_flags(hw_queue);
+		break;
+	default:
+		pr_err("%s: Invalid type (%#x)\n", __func__, hw_queue->type);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 /*
  * See include/linux/iommufd.h
  * struct iommufd_viommu_ops - vIOMMU specific operations
@@ -194,4 +321,6 @@ static const struct iommufd_viommu_ops amd_viommu_ops = {
 	.destroy = amd_iommufd_viommu_destroy,
 	.vdevice_size = VDEVICE_STRUCT_SIZE(struct amd_iommu_vdevice, core),
 	.vdevice_init = _amd_viommu_vdevice_init,
+	.get_hw_queue_size = _amd_viommu_get_hw_queue_size,
+	.hw_queue_init = _amd_viommu_hw_queue_init,
 };
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index b278cbde360e..e81948f3402a 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -392,6 +392,7 @@ static int _iommufd_hw_queue_init(struct iommufd_ucmd *ucmd,
 	refcount_inc(&viommu->obj.users);
 	hw_queue->access = access;
 	hw_queue->type = cmd->type;
+	hw_queue->flags = cmd->flags;
 	hw_queue->length = cmd->length;
 	hw_queue->base_addr = cmd->nesting_parent_iova;
 
@@ -417,7 +418,7 @@ int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	u64 last;
 	int rc;
 
-	if (cmd->flags || cmd->type == IOMMU_HW_QUEUE_TYPE_DEFAULT)
+	if (cmd->type == IOMMU_HW_QUEUE_TYPE_DEFAULT)
 		return -EOPNOTSUPP;
 	if (!cmd->length)
 		return -EINVAL;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 5285d96f1d8c..7a3d11f03dec 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -135,6 +135,7 @@ struct iommufd_hw_queue {
 	size_t length;
 
 	enum iommu_hw_queue_type type;
+	u32 flags;
 
 	/* Clean up all driver-specific parts of an iommufd_hw_queue */
 	void (*destroy)(struct iommufd_hw_queue *hw_queue);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 52bcd92975da..3f9c972e703a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1322,12 +1322,41 @@ enum iommu_hw_queue_type {
 	 *   emulated vSMMU's IDR1.CMDQS to log2(huge page size / 16 bytes)
 	 */
 	IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV = 1,
+	IOMMU_HW_QUEUE_TYPE_AMD_CMD,
+	IOMMU_HW_QUEUE_TYPE_AMD_EVT,
+	IOMMU_HW_QUEUE_TYPE_AMD_PPR,
+};
+
+/**
+ * enum iommu_hw_queue_flags_amd - AMD HW Queue Flags
+ * @IOMMU_HW_QUEUE_FLAG_AMD_CMDBUF_EN        : Command buffer enable
+ * @IOMMU_HW_QUEUE_FLAG_AMD_COMWAIT_EN       : Command wait enable
+ * @IOMMU_HW_QUEUE_FLAG_AMD_EVT_LOG_EN       : Event log enable
+ * @IOMMU_HW_QUEUE_FLAG_AMD_EVT_INT_EN       : Event interrupt enable
+ * @IOMMU_HW_QUEUE_FLAG_AMD_PPRLOG_EN        : PPR log enable
+ * @IOMMU_HW_QUEUE_FLAG_AMD_PPRINT_EN        : PPR print enable
+ * @IOMMU_HW_QUEUE_FLAG_AMD_PPR_EN           : PPR enable
+ * @IOMMU_HW_QUEUE_FLAG_AMD_PPR_AUTO_RSP_EN  : PPR auto response enable
+ * @IOMMU_HW_QUEUE_FLAG_AMD_BLKSTOPMRK_EN    : Block stop mark enable
+ * @IOMMU_HW_QUEUE_FLAG_AMD_PPR_AUTO_RSP_AON : PPR auto response on next enable
+ */
+enum iommu_hw_queue_flags_amd {
+	IOMMU_HW_QUEUE_FLAG_AMD_CMDBUF_EN = 1 << 0,
+	IOMMU_HW_QUEUE_FLAG_AMD_COMWAIT_EN = 1 << 1,
+	IOMMU_HW_QUEUE_FLAG_AMD_EVT_LOG_EN = 1 << 2,
+	IOMMU_HW_QUEUE_FLAG_AMD_EVT_INT_EN = 1 << 3,
+	IOMMU_HW_QUEUE_FLAG_AMD_PPRLOG_EN = 1 << 4,
+	IOMMU_HW_QUEUE_FLAG_AMD_PPRINT_EN = 1 << 5,
+	IOMMU_HW_QUEUE_FLAG_AMD_PPR_EN = 1 << 6,
+	IOMMU_HW_QUEUE_FLAG_AMD_PPR_AUTO_RSP_EN = 1 << 7,
+	IOMMU_HW_QUEUE_FLAG_AMD_BLKSTOPMRK_EN = 1 << 8,
+	IOMMU_HW_QUEUE_FLAG_AMD_PPR_AUTO_RSP_AON = 1 << 9,
 };
 
 /**
  * struct iommu_hw_queue_alloc - ioctl(IOMMU_HW_QUEUE_ALLOC)
  * @size: sizeof(struct iommu_hw_queue_alloc)
- * @flags: Must be 0
+ * @flags: HW queue flags based on enum iommu_hw_queue_type
  * @viommu_id: Virtual IOMMU ID to associate the HW queue with
  * @type: One of enum iommu_hw_queue_type
  * @index: The logical index to the HW queue per virtual IOMMU for a multi-queue
-- 
2.34.1

