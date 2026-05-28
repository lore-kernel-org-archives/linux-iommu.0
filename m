Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013067.outbound.protection.outlook.com [40.93.196.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF9030C63B
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945510; cv=fail; b=Ce/qOd+roVDR6ZZCk0KbL1AH2XqJnW5Ap9v+WrWRYE2ahhhmFjecZK/5FabXbOmfCjXkMfioFujS1lDI1AGgMkLc+rIVcteeN/tiAaBiJpj/735TPyLExfDsxI/AI61Qzi2NCoPZGz6/TOcgKmcQGwlvAThPhcKrWU9s6JJ64D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945510; c=relaxed/simple;
	bh=sZwA1Cen4R1/by+HFkCx3mTTvn9egd/WRqSVkYBOX9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRuUr6MsGLmcKtHUw/fwjM5cWF0KPhUhMoz+6+N0sTMTtPgRwdYOPXCmD2Zf02Ersy5Hbw9M/UfMI7x8IDBLAF0HX9Zf+t5Y4KoHN40TXoTxgjuNfWco1BnoIysP/EnWedrDibb1CrYs8KiUyDKzc7nta4MO+z1B067SLhuSV38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q6IJvYN1; arc=fail smtp.client-ip=40.93.196.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q6IJvYN1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUhZVpSKUc6vw1Og4b8Rv3xnaFdvN5ck0qxqmsQU27JYHkxM++8kxnkRQa36ZFNw7kI5SQTHms2IOFDqGnIdlSwsceiXUZKWXTSjz0ejmVqUNSD78sUXhKpjeo4o+SSXOJwf2uJ6uZb/cb2bxXwXMKnVAp8uS+xGE3kqQDsfccFKrxXfPJMLCxNP+ppoNLQBxlsElkmDkKpbnm4lgIEd7FkEYymBUs0qx+IKOpe+NMoAxCmygVX7MBT4JtAQMcQRaKqf+6qFNXDyX8CdAQ1ztY/BwW+n3MBNbG8+GqEAK48+jgEzeOT+5NlLdyotkRVKMRiGIIcLqj/sB5IrEJnHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/KJaHbi21kfCEU2Wy9JJpPfLvx4o7nl9eO+5MEc8nY=;
 b=GH4Sx0H6fdX/8iqp5DOQlXBV4olVKyKDnlauArRB688Ax83Q6MbSRh+rHpYBxjcx109zxZEpyzBUhyjTB/QaRz29eZsWIuFyivQFS/suo8lMCDUIp3ArkyE5RCdjsavLbcarIUUzAPY2ddi3s/QTiNIEs0mqLSVFOFU6tTTCL3BzHSGV2H1Es494+86Oyh5SsEg/t1KX2rmVzQsQFhXOSgZsd343qyi0+QZUJlHVeWzEiGNTe22rVWppHEn7htp40fHrczurc/R2n2D7KxIcxToKmjfE7dbGPiIZSJCLlb8BHfAip9sS/22vdnhFBYv3+G/ZynpZzS7/o4VEquoLpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/KJaHbi21kfCEU2Wy9JJpPfLvx4o7nl9eO+5MEc8nY=;
 b=Q6IJvYN1u9qDneuTDgykrKTuMde9mUsfa+f7JFhU1VOZk5E5/RA9NdMcDIobyzztKX1UvxF6neR6Y1drFUmPX+Lg0IntmjoZQZ6lrnGaNpu9AT386u1mYtaHQ4oIZmEfh6qnQ+8LibHCBRqKZP3C1Vc+ayQMeK2IqqXsu01OfKY=
Received: from SA1PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:2ce::20)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 05:18:22 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::70) by SA1PR04CA0014.outlook.office365.com
 (2603:10b6:806:2ce::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:18:21 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:18:16 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 04/26] iommu/amd: Introduce IOMMUFD vIOMMU support for AMD
Date: Thu, 28 May 2026 05:17:16 +0000
Message-ID: <20260528051738.596013-5-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: 740237b5-2347-4e26-3cb5-08debc788933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700016|376014|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZOCvBoRy8Ql1D4HlxA+FYMZ0/oISDpf6HjiAxjSDOdPjMVIxoWRsYG0Qs4yna12M4Fepq4x5aMi3A7fe3dF5S7qPep66OIkOc7EP9B5F+YZBLnUcR3CpAq5wSL5z1rUFugBEdwmaVotNHjUP5TFeVaWiohqpGRaXjGZhIRioSU7RuJef8599CGBKxU7F0D/2sZV1sY6ARoubaQEfh4Apr4Qa+M0FFxl1DIfFXsHxipRUedfrowA6vXLStnAhGtu4BOv/tV7041A5sl1myiK+9nrjZ9xIMw9MN0KoQedKAAIPoIlQLgpkwqbmtdNvLmQQnhS2cXerrXEJSymq6B6Uv909iI6Tu2TCKDQF++zowrLfGsYl1lli+xN7NqlOxsPnWbHJfaQVZgLh4bhwWdDCDWMva+uA4DqAn8f56K01HrCXxt8LR1advwwygVnR1RkMVYULFjkl+zvUFfB5gyAr1qiRSqsaf1wM2+IiGVq3+xUmFfWpoQ6sLqI71BKrQf/me3uzdBq4nzuAB31bjqbFfIDe5JanW5gfyB7K/ghwDettRvufGMwN53R4vLWQrX8UbMslK7cek6mCrAplJBoBGxgoHNl1sJZeP/09ySF+S8w4VMxTHZyRyvPGy5+zXGGGw5b2knNrYtn30BT4UNNULlXHMYLMbz3WAi4ZosfZYIp3RDQ8QZltX40t0Rx8j3O6xrbX6BudWzfFYAGhpSZGbEjr8Fq9TeujXrBziXJvjn8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mHxJ8eIGcJOpmVpX4PoEjreG62XRH9HLbrcMAOsFlGWv9l2VnQh8yTMfzWJNt5GWaamoX336X1b5NBF/tigo+RrvtINJ1JZIGZ6mjWRJrjVH5gMRPWbXAkhU9Km/7KE6FM2p7FkUdy1M4EXNBgSp2I8pkYYRY+uyoGNKHxeY3cqHHnwI4t6p/iegyo/MKgwmMm7xer/dfWlvM4kR38ckyQZDEKDESAkZVprjTYR7Fd57UYw99ttPRyobxmSaIv9WszCjgiljo0Rqf6fF323UbvLxofzH+LB2daygvt7PpWrcTpGrYGVzaJ19v5TZqYtxy94OygxB0oP8fXYLa8uv9xCUPWDhXv6jyc2IvStjhrj95HLSNwNZtI602CF8qTVMTPvsC68YZBd2gOEL/MqTQhi9hYnn38lWXYl1PyNIzmRI5uPxllUyqvJHKhkEbZfm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:18:21.6734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 740237b5-2347-4e26-3cb5-08debc788933
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100

Introduce a new enum iommu_viommu_type (IOMMU_VIOMMU_TYPE_AMD) for AMD
vIOMMU along with the struct iommu_viommu_amd, which is used to initialize
IOMMUFD vIOMMU instance when calling struct iommu_ops.viommu_init().

Also, hook up struct iomufd_viomu_ops.alloc_domain_nested to connect
nested domain allocation with AMD vIOMMU implementation.

Additional initialization will be added in subsequent patches.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommufd.c  |  4 ++++
 include/uapi/linux/iommufd.h | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 52300b867c1f..eee29c26169a 100644
---
 drivers/iommu/amd/iommufd.c  |  4 ++++
 include/uapi/linux/iommufd.h | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 52300b867c1f..eee29c26169a 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -34,6 +34,9 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *length, enum iommu_hw_info_ty
 
 size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type)
 {
+	if (!amd_iommu_viommu || (viommu_type != IOMMU_VIOMMU_TYPE_AMD))
+		return 0;
+
 	return VIOMMU_STRUCT_SIZE(struct amd_iommu_viommu, core);
 }
 
@@ -73,5 +76,6 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
  * struct iommufd_viommu_ops - vIOMMU specific operations
  */
 static const struct iommufd_viommu_ops amd_viommu_ops = {
+	.alloc_domain_nested = amd_iommu_alloc_domain_nested,
 	.destroy = amd_iommufd_viommu_destroy,
 };
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index e998dfbd6960..83ed10610957 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1052,6 +1052,7 @@ struct iommu_fault_alloc {
  * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
  * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                    SMMUv3) enabled ARM SMMUv3 type
+ * @IOMMU_VIOMMU_TYPE_AMD: AMD HW-vIOMMU type
  */
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
@@ -1062,6 +1063,7 @@ enum iommu_viommu_type {
 	 *   VMM must wire the HYP_OWN bit to 0 in guest VINTF_CONFIG register
 	 */
 	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
+	IOMMU_VIOMMU_TYPE_AMD = 3,
 };
 
 /**
@@ -1080,6 +1082,14 @@ struct iommu_viommu_tegra241_cmdqv {
 	__aligned_u64 out_vintf_mmap_length;
 };
 
+/**
+ * struct iommu_viommu_amd - AMD vIOMMU Interface (IOMMU_VIOMMU_TYPE_AMD)
+ * @reserved: Must be zero
+ */
+struct iommu_viommu_amd {
+	__u32 reserved; /* must be last */
+};
+
 /**
  * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
  * @size: sizeof(struct iommu_viommu_alloc)
-- 
2.34.1

