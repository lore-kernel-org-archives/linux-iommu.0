Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F75C3B19A0
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860185; cv=fail; b=EeTxuBGxjNc4XRBqBDXfvwHT04mFbPnU9WPmNWq6ASmZOROIzkNp2Ghp9/YXGrnHP6jj45GDrV0KZESvBxAoTqZjaUSH8O9N4v5FW07F+kUJeLmbhflowYkMOhF/ZLX6ac270zgK1EpiY2zErEvigKtjbwthRQOZPEsX2QPkDqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860185; c=relaxed/simple;
	bh=CWFpxEQ9P+gntUB/mhKgwYMBqcKdVeCuZl6fpMKR2EI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R04IMp/c7QsVp5AyoBCFDW+dAr77uR93B/jjWrFscijotY1Gh1PjIS0v4Bxui8mHxU4r8ROnyihXo+7eOaZW691z1OtG/aX3tc5nwvd+uaP7DBZERuB5pt+w/YTGwacyw0uKbM0OmtqGIszGShE+1EntahXmQWl9qNEKS56G0Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a307JjPS; arc=fail smtp.client-ip=52.101.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a307JjPS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmjspYpuaxdR2+lUHvx3m123o08Cp83fmo+7JvBLPZ6LFtr8o/zgNrGjj6S7SpMj3XELI7eth5BtM0vBPEgCUVdwHw+qgTN/zNCkXF7mSl82SP8PypEy3ro60eVeL4N5nZ4b/mE6ivTX9p3q0pFQm0wJrhWvCAg6q6sZ/g1xFGUA+ViU9EYmkjdU6HG2CEln3O7ys6awBakBSiwyC8fpSP9RnhgzDEckm9kN4GjNduZWJMqSBkBAIJvcD6rWtfhq9U8pKmhMpKZzwFG3t/53ARW5e23jP+8v4ksqRbdhnYhX4a8JsAcKpGlhYp1APK/cnOZOkxcZ/ftKyxJ2t3a8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+2NNm58uBbyYuHaCXskgo9NGbGdP7iKuS/DEcZrNbg=;
 b=jT0+Vq3PIrEgbx376ZkohkN8SswSJM0b8EwBF9dejlYbdEzzG8lHi+/PyhfAbyTzfbzAKTS2a5qhFGRl6depR+LM/uH1kKKf0hvCZTaJ5rsSJe2l3McgyXSq4RIfmxKWSMob7MM0eG4OnR6CyfdIiQX21Jk/2CeUwzJgw96ECeo41KcD2Du5KBWygZ6pdkw8oPWBbAQ9HAjVC+bYvoitklBdgkf/HJ3d7bKbCCDh42QaMeDBgm7YzCynyEds1vDzeYP5jzgaZXuxbR+2YOhZJybMFn5yZ9HrhHmWUIi0W/oc9X0s8Ww22Qe7ddwJ4+wqgPgwncQfrRAMdJ+JMxlW1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+2NNm58uBbyYuHaCXskgo9NGbGdP7iKuS/DEcZrNbg=;
 b=a307JjPSjYGBV4zh/pSsXE3R901mu95iIimhd1Egr4JIdf9TcsTambqBlKV5IfDdd6y+Otw4VANtM84XTo5ldDaWHF2EUvUUvazxT5vevPO3e7r9Dc/3F4YNp9YqlHHzwHwjv3O6GkXCr0n3Tq2ums7Ux6J4TR+t3wAVOTBTiQc=
Received: from DS7PR03CA0234.namprd03.prod.outlook.com (2603:10b6:5:3ba::29)
 by SA1PR12MB999227.namprd12.prod.outlook.com (2603:10b6:806:4de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:43:00 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::f5) by DS7PR03CA0234.outlook.office365.com
 (2603:10b6:5:3ba::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:42:59 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:42:54 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 04/22] iommu/amd: Introduce IOMMUFD vIOMMU support for AMD
Date: Mon, 30 Mar 2026 08:41:48 +0000
Message-ID: <20260330084206.9251-5-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SA1PR12MB999227:EE_
X-MS-Office365-Filtering-Correlation-Id: c5532084-d425-4c81-9037-08de8e38593a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2W/Afl5F+PtKvkyxhx7RcFUuHjDakzqabAJSbDm/pIj7Se9vmufW4+T62LcaZpsCYgHZGueklA7e1Pc+Ra4B7K4LsdnPYaQfqFKETUKp9q2EJMoT7KUDWybJD/u748pKSJuY+vmIJntTWlObovFyBiIhsGTkmvV3521WH8BPmW3NSeQY9owjb4u4omDNilVjsuxYoBcIyy7vt641Q+ZjnvJqoh+QBGfTKKBe+2PjG06VSzDPWFWeDU+dxGGJeoz6owGZHpUA+0VlJayHseGq5S0gVv91t+m8725h0cfSk4CIugSoeMwzMnuKiV3IhV0riEQWTkJOdY8DX2RuXshMS21B3feQtSjU7iiJy49YNPHqlSJfn9XCdipqwNugZgUMQ2nYyb3nyTH2Q5NCOU/96VmYjbXWBStfY8rNln8378ZwNPME0JBQ5YTRr08GmX/iVbVM6QB6It1M3O2OQ/zunUCo5KtOefTBMxHPih9sbahh5agdKXHo/XMA4AqIAbfgxNqcTBW5osjnL3h+xKhPUKX+5ptj3CQoUJoSKT9O9ZVnDpu2neyragW7F/VvyDDHihDkB5TRa3KufQkjbz2I1tpGkEq+29m78AbotzLYTlRU14Q21kBXuVajo2PEXkI9BoZdxz32Z6cXF8V3Bp+p67tLzb7y+987CFggSMWAX+gZHEdXxDKphbR/30W+iiBpbnwM6IeLA/NPqSVx0spAzgfjv5FyT3tA4jnapCXCQiIRtQyWD2Z9FPlOYMj4B2JjgCIj3xvQzQwg5ZtFcijH8g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	swMBJe8fmBvh47Y7H5/ONNetyDHfJLuztsEjjFyudcy1HLahFFd/HGEioSxpoDxkvS3RpcsvJZfQrBd/laOlw9pvqp4VLLn9zBFp74MJXcoCjqOvv1Y23pQtcK6bXZN0wB67BSkCheyWwUmy6hl/EaXlYUcC+P1MjqAOrGX2+lGh3YFBi8lTQx/H6agmKByIgWTSp4iSGetMKvETFwoKKmeS3rUyCG9pOoM2lj5QMXz1ItdqJgQBQ5RXbNGcTSsHBPf3XpF5FKxP+F8MqowZIyonv940IHkxN9k542FhDoRGunWb0wGDEaA1D5pWXu4iSKlEt+3npSjibDUN/0Wyfbp4vLdhYFmp0sZxOGo9tE8OP7bVk/jKuXGtnmx74+xYTg75NU/DG0jFblyoW5ci2ogL0FBV/QHgGCQG8NfJLzBAFfEBzCLfhmpeaEWZqqNw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:42:59.8780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5532084-d425-4c81-9037-08de8e38593a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999227

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
index ad627fd5ccc7..e7ffa7e8915b 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -34,6 +34,9 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type)
 
 size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type)
 {
+	if (viommu_type != IOMMU_VIOMMU_TYPE_AMD)
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
index 1dafbc552d37..3a2ac7234b9e 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1048,11 +1048,13 @@ struct iommu_fault_alloc {
  * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
  * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                    SMMUv3) enabled ARM SMMUv3 type
+ * @IOMMU_VIOMMU_TYPE_AMD: AMD HW-vIOMMU type
  */
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
 	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
 	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
+	IOMMU_VIOMMU_TYPE_AMD = 3,
 };
 
 /**
@@ -1071,6 +1073,14 @@ struct iommu_viommu_tegra241_cmdqv {
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

