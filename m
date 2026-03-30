Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655AA3AF676
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860267; cv=fail; b=LwZv6gCRda3e/Ir4YR8AapJxrdCrM1Y3NlKRjo5M+dYHut+ioUCebjL7IzVRNOZ/rRyffo5ipXZ7Lq4SF+h35L1OUiaQ0Np30IC8NIhmjCAanA0cU6BylcLoTWjl44waba2YwCZua7BSslWYfub5MDlDIk4Nrjgs8TQi4wE5JBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860267; c=relaxed/simple;
	bh=TNP8q5ARiZMcYNTLm1HMvSJEto4POmaL6kofNhdP428=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpGC7oOc3K0AbkDULIrDqcmz5VN2ZRAAH08YsOuBspysKALGIP3UhzpsWgCgGDpy+bbDd8h23L8bZ3k4ZT+yV5hMVRPY67u+EeBF/CTBt3l2JfclsPVBPV80xnxSQYjka4/IfvlzQ03NtsHy0RxAfHbZ3s7OSDhmXkFISM+3+jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X3TCxG1K; arc=fail smtp.client-ip=52.101.62.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X3TCxG1K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFXXjgEp+OcIJXUlwUM4WROq5QP3DXUBLzTLK00bndBaEo9hIXZSoAtwxsxyuMmuJtqiXU10ejHrmZu19Res7uqE37KOrd1eYtYc1gFXiF7XNY2xGmy6bcnum33PtFtmbATZ9/FurAo1M36Ft17O7tnBomhTXKk3UFhWAPSEHnZDBE2GdsZmo0PDMsjlXnNJt87kpkvDC1n11ewz2FucBSX1vOANDX6KDNny7tKoA/DrjZth2sKRW9JyWGIIRXf2dmGxTn82OAIT3W4eWlXsKO2HfzVwrFHR5dSh7CFPJresrAuQfALlEbHOijAEZTCxVwf/J1x9qSi7tNV4EWYq5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfiAUETrOTP2VPEVwAv1uojpODrywbft4HijCuiaix0=;
 b=VXBKosVx2lZiHIYywz7jMCfZstaVuGvGUcaytrVRdqg08urCs7+3XkqFmKbv2Sm1/k1PSIaFVfknYEIW1VueRmdr/Jiw82zh9o/3fRf9hzz2q4gaS5SIKz0+Q2lSeR/vxmd3X0GpbGXuk9eVajd5JuDLlwr3v+0OdsiqGG+JQ4It/tMCeTY3KaSbj2XUfR4Y8buk1BT65TK24cYva5W1YnhpTj3QkexXceEWhcThAd2ZbR528RTpCYVqN7dm3gm6ttO7sFZ2XgzuNE7EmXnFRMkaqh9ggHW388may+WMpgjO6kveUmMEnhaNQKSpdodrNOgMuWkeFnAJES7/8Ntdbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfiAUETrOTP2VPEVwAv1uojpODrywbft4HijCuiaix0=;
 b=X3TCxG1KVCk5EfHiv2mTKsqzyA/RhrM39domyawLQs7Dtr0PEsI8XaVCtK4DTi8IDQBCdTP2N64kunmaXvi5x7HIw2+EXyHC+gEz34ubIIdEi25J4U7IAHMllcqa57yfS6fJQ9sD7hw9XAXTcyl7oPdyFVVFLOoSZJ60BJ/BgNo=
Received: from DM6PR08CA0016.namprd08.prod.outlook.com (2603:10b6:5:80::29) by
 CY3PR12MB9702.namprd12.prod.outlook.com (2603:10b6:930:103::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:44:21 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::63) by DM6PR08CA0016.outlook.office365.com
 (2603:10b6:5:80::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:44:21 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:44:06 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 19/22] iommu/amd: Add support for vIOMMU HW queues initialization
Date: Mon, 30 Mar 2026 08:42:03 +0000
Message-ID: <20260330084206.9251-20-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|CY3PR12MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: c6cfcb42-c806-4b5b-176b-08de8e3889df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	or5eBS06arArNYZrVvfPbPwLwKNNdfaUwtaZssdHb45iP4Ruggf+ATr+lURfmjCz68VCpiH4AC+A7R55exp40sTh9PP2UFBw7kBPSqoPenL9IfNLfqt+6pfJJJQCp+GjN7PVUxnrO2Ox9/KLdKKtRCk+YWw3sIIYnQPbGdGju/WezJD8RBvlXb0tdtRvHu07xuHBXEkM0S/96HH957ijJo9AGciKR0M0Wh+2vpBfq9+kp6WGjT2jj+UE+BjmOxzGwxba7374n169pVTthgIvg1CRKhwps3YLi9mFXr0zqqXBPlCTkSXxgvNjrA+lg/eyqzoz86yzU9gzgKU8uGUUiS4K9A96sUqaGhlBtyyYiyyjYtc2H5ZfwkUSDYpeSqYxWZ21l5S4hYzfln18ww88uzWWVVINfIA4k5bQrs9+jKth5TLR1HAD5rPyxcjWXFD5gGHhYb1wavrlUPopyQeVnuXzInE4Fk/C4b2WUuzMpWsFEPOmHEVnJvC9Td5siPtSLgGStXPk5ZM5ZYtXnmxtih3sTgFWo2Opcq2VyThTBLZ8fALtFAx7X89Hhlj4qaNgNg2lCCiuZlHtWnOGRWSohHwulPAtR1+8OF0WWxG8GiXOPTiSnF6FizWeip0qNWVFc7eNJW+mszvf1T+Add4GheIG/qjuw8Xm3GDJdLqIrJItl+PimF9L+qbg3WfYGFvMW+qodTu0gvU/2EPqhCyB3AxJ3Va/H0AKfREO3PSqhhAO4Zz2fr6uawLbHTIME2l5/Z6snEFiTGWGoZpNMEVyUQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m9G//J2UBhwBUq5aY+5lColW5Jq95PaW81ERO7Bod3dJ9eEBXmJD3srmF/03/LKwzWdz5VEhrJro4k6kxQCEAb/vaQij8TKD7rcMcchR++XvOP9gvUc68h2vB8zEKSpu7j+55WuFlnslzWNUJN5Xc0A9uT42GgJP/Dmh/yzQ7buTswswLUccpbi2SmOQhdmnYseW93v109cvY47ZIH5JP9eP5qkSjLE0Z6gEZk6C+GrWHe7Em4OWA/nMA6B7XPe3m02O7h7NLiSj3E8nzbsugC/lJxpqhbk8Lkkt5/5+efRDt3E7vuse54eydtzBgY7PbXTBuQ3/lLRD4behBXil6mrapC0ZH3nTXZUx4na+PrZ4BBehygwWjs0jCSzBnH5s1suUWBk/xhFvm/SwbbHqayuhREA9fhmipz3XUEK/u7tpNzg4Ws9baZMndWj12H/J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:44:21.4746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6cfcb42-c806-4b5b-176b-08de8e3889df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9702

AMD HW vIOMMU supports virtualizing Command buffer, Event log, and PPR log.
Each can be initialized using the struct iommufd_viommu_ops.hw_queue_init
to communicate base address (GPA) and length of each queue to the AMD IOMMU
driver in order to programe the corresponded VF control MMIO registers.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  4 ++
 drivers/iommu/amd/iommufd.c         | 68 +++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h        |  3 ++
 3 files changed, 75 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 2c4844b44caf..1cd50a4008fb 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -1127,6 +1127,10 @@ struct amd_iommu_vdevice {
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
index f83d69716eaa..6f766254a390 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -165,6 +165,72 @@ static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
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
+	u64 val, tmp;
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
+		val = readq(vfctrl + 0x20);
+		val &= ~(0xFFFFFFFFFF00FULL);
+		tmp = (hw_queue->length & 0xFULL);
+		val = tmp | (hw_queue->base_addr & 0xFFFFFFFFFF000ULL);
+
+		writeq(val, vfctrl + 0x20);
+		break;
+	}
+	case IOMMU_HW_QUEUE_TYPE_AMD_EVT:
+	{
+		val = readq(vfctrl + 0x28);
+		val &= ~(0xFFFFFFFFFF00FULL);
+		tmp = (hw_queue->length & 0xFULL);
+		val = tmp | (hw_queue->base_addr & 0xFFFFFFFFFF000ULL);
+		writeq(val, vfctrl + 0x28);
+		break;
+	}
+	case IOMMU_HW_QUEUE_TYPE_AMD_PPR:
+	{
+		val = readq(vfctrl + 0x30);
+		val &= ~(0xFFFFFFFFFF00FULL);
+		tmp = (hw_queue->length & 0xFULL);
+		val = tmp | ((hw_queue->base_addr & 0xFFFFFFFFFF000ULL) << 4);
+		writeq(val, vfctrl + 0x30);
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
@@ -174,4 +240,6 @@ static const struct iommufd_viommu_ops amd_viommu_ops = {
 	.destroy = amd_iommufd_viommu_destroy,
 	.vdevice_size = VDEVICE_STRUCT_SIZE(struct amd_iommu_vdevice, core),
 	.vdevice_init = _amd_viommu_vdevice_init,
+	.get_hw_queue_size = _amd_viommu_get_hw_queue_size,
+	.hw_queue_init = _amd_viommu_hw_queue_init,
 };
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index d9e5c5f0d997..f71a4b979d52 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1317,6 +1317,9 @@ enum iommu_hw_queue_type {
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

