Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07523905F5
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411729; cv=fail; b=ipEdgAtIkYc1DSQuUF6+DneBn69Lr+9QGuNj4xxgWcXiPDL4TyYTAcdTAy+z6ePQGhANVf3iJlofLa7yjQm5v+tPF4Mv8b084j4QOuBNK7JCerGGiIXWaPmSK9vH/QNBGmzOQPDKCYOmfIVe1BrXz2Yks0fb/YrJ2OLSj/EXKI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411729; c=relaxed/simple;
	bh=aM5YyIs2+bqiLRrppmSnsqCD4aP0AOClDbnE6zYrB5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pI1Q9nFPt2H5KJx4M6lHryV8viqYZEsbDcFPNcec3CvKs9pqOOTf3CQwEJ0ggtFL9zaMVVkjg2hQ/u7S6UalEw5TAjOEuv22ftN5dGJWLfu2gcwh9gzpm7rwBm3b+GYNJ5JNY+azYSbXN9JLNtzC6eu38lr/6Jm7Cl/RVFGTZFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FyULOeez; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FyULOeez"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ip3iA9Stu9lMq6ojI/6H+b/FGkETp9RktdY/5KK9AC5KYNABYi3r260F+KnZQtIxdGjGYgzn4o+gT2QL1RCUcjOShPb099GtZu5i4318C9bAZSMRSkrqM/5Gu4JU3WxMSOKP+vZ5bfomhwh5lIJlT5yTzA7RBlQqzjfij6gEub/Wo7fM/vY8SDyAK7Ey2Vojmgzp05GQAC7wzPyvSvuy+L/iHaZICvr7nkIpFPecK8FHJXnQDzSgpQzGe9P2BdoKYH0jA1YlH33E5Yqt0Hj38YlDmO+aaGF89WUSakM0xLlgIyx7SHx5nkDbGb4CFL/8eeMaqkxB7je+2trrucs1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19sO4iDheBBltlk/+QgZNz9plcUhwScMBtiKHphznMQ=;
 b=BbW5iCFbZITsl6aw7QX8/4NuIIxOrsUovw+HBKZLkSvmc4fbQySQ9zWnxwnpayG7Jb7MTvnPvv5qjosQNM7crkWlrGdPEtHMRmY9yUW5k9r6o3pFLDRxh2wdf3IggeAZC2ACPNVxHflW0ZabTfRdlZUsOd5eD3PyT7ZeuSkLI9QUO2OhrTcDIoswxJ2ay0m49U3Bv/KI+PJevQQSD15KThjArP/0x9KjSUC01WJLg0k+oqvcxxuqQpzykjW3j9pVzPea/74FwzzC/TxqvuAJugt4WErz1uRovAmxID3lTz4Il0uMunnRcehTjI6cQvM17oTA+FeDdBL7uQ6pczmfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19sO4iDheBBltlk/+QgZNz9plcUhwScMBtiKHphznMQ=;
 b=FyULOeeztVrcd0cjfks6vLSfN/soqY6ovJGh40YjeSoRcf0+4tGDC83+DQbH3mMRmryQRpk7c44gjAqJf2PlPY6on491EEHih1oIMqx76d+1a3B80Q/tKXN6Cx1nneDQkHbXdD1INU/znQMIyMHsrpR3OMvE+c8hj8WwaP8po40=
Received: from BN9P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::12)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:48:42 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::f) by BN9P222CA0007.outlook.office365.com
 (2603:10b6:408:10c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:48:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:48:40 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:48:34 -0500
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
Subject: [PATCH v5 04/24] iommu/amd: Introduce IOMMUFD vIOMMU support for AMD
Date: Mon, 14 Sep 2026 18:47:30 +0000
Message-ID: <20260914184750.222939-5-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bb282b-0928-4073-d9bc-08df1290cb4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|82310400026|36860700016|376014|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	haCv/p4CVrOmXwA/Invw5PhQebNFxsixGuSEYrGjIyg2kstqRmTNP/RLvn1nXb/5NH2uIT6s0xhi02eAU9V3cfAkH9/+F6RVD7jzLdhbss9BJ6MFhhdIaSSp4bYUAYoW9WFxAktUh3SiwmGYhSkmYm8JvcGpXcxdJcqDvMbdd72vkEBTe7xcYk+AhvoLp+7i1cM9O8PVzRCmv+eGVtBug2GxczpQfkU9N35rV8GknkeBw9gx+mnEbhWn4iE8LZzq7RECgXluvU8XmEiTRaXDyVLxN4wyoRNk3aWF+bPjC/zK0ARLRQCrL+irPjlQ0bowFN+VzG1bY6S//sJ1ABKVIYyxcNUNqwj+OpL7y9iI6Vkzjfq4f2L4PdU6jWR4nkzYr7l5gO8zqlBzF5YiYhUvgo+uKKqXG3BY1nopvJGxODSoWMHFCbWef0IoEdZ3lMBjegeM++BtI68aPccsSYMqUA0vffJTAMNL37pNWd2Beui4NUhNb8Q+u+6aYRlxW9doppKqyTpDV6T4jI8KM8JP/+2FdaFPi1bHP7dpzsHMdzHQVVACdyqHS1YXgCKVCPt+c2n+qLg0m7nXxqaQk+sUCkFpLLNJKM9arHXJoOPg+MjNwVmPC1nUeLwxKTV76O5fvi8yut0tE1sBNNX+Cnui/tDPKHpPqnuVYPecXSoaMqkyfoixfF3xJ/H/xOEuNQxHKiJqpQj+6dv3Qx/xv5UUsw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(82310400026)(36860700016)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uTRJIFyb4Oe8/ZeliCGecQAIJ3m50mTVu70Dw1DGeyg4KgjGbBi/hTbCWzCcvBDBIbhsKc/MsP7taC0KYlRat78GGZeSq3U1QMnZJnPnhtl/ZlUeDqcUVHfPC3uCR5vaybeTZz2A4qq+V3YWjPSTbnlOwPyIBw/KVi1ocmEX2fO/K2vR7H8stKBMkBJQDY3XfjlY14t8xzSwDWWEP+rkHqIanA7YUIVZaLm17JhaWnoVjaArRV5vgUx5/y1G5Pn1IIhiGVW4fnc3OXvF2q7cLK/32Bean8rQdnAIOnHrpstDIF/jKkK/h3X8Wfqnl5K/XI8lX6tTM9DMimskxekDaYZuo1W9mTROY2aINQwNiw6XXzlxFlE9h60CPWvhYGDCh+Yhrh8M7UZQthlqitdPamNowP2XQCgPtdw0UJoOY3+JweIGB9lkwpCtsTwGgixP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:48:40.4845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bb282b-0928-4073-d9bc-08df1290cb4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814

Introduce a new enum iommu_viommu_type (IOMMU_VIOMMU_TYPE_AMD) for AMD
vIOMMU along with the struct iommu_viommu_amd, which is used to initialize
IOMMUFD vIOMMU instance when calling struct iommu_ops.viommu_init().

Also, hook up struct iomufd_viomu_ops.alloc_domain_nested to connect
nested domain allocation with AMD vIOMMU implementation.

Only report a non-zero viommu size when the type is AMD and
amd_iommu_viommu_enabled() is true for the device's IOMMU.

Additional initialization will be added in subsequent patches.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommufd.c  | 10 ++++++++++
 include/uapi/linux/iommufd.h | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 52300b867c1f..e8e7807f2a33 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -34,6 +34,15 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *length, enum iommu_hw_info_ty
 
 size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type)
 {
+	struct amd_iommu *iommu;
+
+	if (viommu_type != IOMMU_VIOMMU_TYPE_AMD)
+		return 0;
+
+	iommu = get_amd_iommu_from_dev(dev);
+	if (!amd_iommu_viommu_enabled(iommu))
+		return 0;
+
 	return VIOMMU_STRUCT_SIZE(struct amd_iommu_viommu, core);
 }
 
@@ -73,5 +82,6 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
  * struct iommufd_viommu_ops - vIOMMU specific operations
  */
 static const struct iommufd_viommu_ops amd_viommu_ops = {
+	.alloc_domain_nested = amd_iommu_alloc_domain_nested,
 	.destroy = amd_iommufd_viommu_destroy,
 };
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 206fa667c782..e1080b997e8f 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1095,6 +1095,7 @@ struct iommu_fault_alloc {
  * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
  * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                    SMMUv3) enabled ARM SMMUv3 type
+ * @IOMMU_VIOMMU_TYPE_AMD: AMD HW-vIOMMU type
  */
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
@@ -1105,6 +1106,7 @@ enum iommu_viommu_type {
 	 *   VMM must wire the HYP_OWN bit to 0 in guest VINTF_CONFIG register
 	 */
 	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
+	IOMMU_VIOMMU_TYPE_AMD = 3,
 };
 
 /**
@@ -1123,6 +1125,14 @@ struct iommu_viommu_tegra241_cmdqv {
 	__aligned_u64 out_vintf_mmap_length;
 };
 
+/**
+ * struct iommu_viommu_amd - AMD vIOMMU Interface (IOMMU_VIOMMU_TYPE_AMD)
+ * @out_vfmmio_mmap_offset: (out) mmap offset for vIOMMU VF-MMIO
+ */
+struct iommu_viommu_amd {
+	__aligned_u64 out_vfmmio_mmap_offset;
+};
+
 /**
  * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
  * @size: sizeof(struct iommu_viommu_alloc)
-- 
2.34.1

