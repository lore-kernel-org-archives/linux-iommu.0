Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343860;
	b=l843AxFqDEEVpCt2sa1aKl05MyZMmnveTrRzUC/awLVms8lgIhYVXMSbNo1ZaSKf2GQk
	 BOlVMHZGlDVsVHdnu/4l0iSjdMV2yCTtVKp7sXkJJOH8XzI+AgsuYWkLCX5ZrbzIqeKWG
	 5IAJz53SKtEnied4y81ZpiC61mycD9SuEunr0svJrtE7kkP+QMV7nDArHcfusCkByMhMO
	 KmABWs0OloUwfj2Uypb57KjXGkyXCz+tIGV7FLyA4QVBN/0znQxzHHor/HqSCYg/KieTx
	 Ehm6NEEjYqMcPaJMr2gsx7qDhpwadIsKobCDjadduboynX0yrDLIGMiNb+iQyz+sSqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343860;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rdS4Jyv7rWrxiPFPlbig6aTJ4TLhhUJRfLMLauv96R0=;
	b=HXSzIe7tZmB1HuJSm6FH0zeeBAxLJ85LyvRIVe6/i0J6/SvSn2CA/mOken4nQkPiiueF
	 uXoC1SETVVrQMFe4dhcBefr2vweHgVjqHhNWXrjEz34hzU+4JjTjgp3AFWy1XgGCCENZr
	 zCXg+57hLpC+9/Yp/Sva4It9ckkug0x6WZaAp+zMuvGTjfbcxoOwNaNROvCdfz/olEd76
	 BO/PcwupfhQa1KmkQyzoiNU9XpH2yXO+dSIEHpn3358rmQnFLdDpfqOq+xrSSODzbrg2N
	 xLfk9eCNkjlhv7DXJc9pplBVYF/Px7Q8zItGK9aZtImy0YOTRlQU8uvgMPNRkNYLhcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="o/dtL3DK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.16
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC23F60A260E;
	Tue, 10 Nov 2026 20:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC23F60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=o/dtL3DK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4maKjEOSxF4+ooeKPP1k1kMRqedDs31ERciJv0uT9uKutM4uWiVUOo+uH7BwoJWFZ8VPHP7iW6091vi2Ja6/JhCU0sQgLeTLa/P+Ez+i/7i8ru0uzwKs0qvpibTx8d9L/fSqblcURZ/57B4pKe200lGyOfQGR/Sm3UWGSyR/D9/spCBxPytYdnU+DGE3VNPGJZuobs/BPv3vvSdFLz9j8TC/dynR2fdysSO5+CMq0wDknILZb8GRlv3eWbEDNBetlp5duSvYv8LvYMf2rRZ1mFO/IJu6XKL6UERALhebHdl6lk+2o3wHUYxD5KI+hCOoznCq71z+2XkpHEt7KMj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdS4Jyv7rWrxiPFPlbig6aTJ4TLhhUJRfLMLauv96R0=;
 b=ehRBjWGTmhSbHMX+jTZYyocWR0zZQCIWevJn+WBllxCRVOTDBULuAleak8pKbYbSmDJ5zJ9G7Lkh8Q9tiQNnfnJZO/mCgKZel8sH/M3E7LrdAx0ru+hE/kSyRmhgfBkoT1hYa0MjdB2hPkHGAmbCTVQOYkbrvONnPpaBFk9NH8HM7Wlnr44cEKNvwQxPO05YJFWLRANTGuB0/Zgiug+YUaxfJoAuV4pSkMJh+HtTOajeuMiPbCF7MmBQ62rX0ZAwbttlSH+xh2H6KEKIuLqll5whV5fyYmQBsgK/1Ar8VMZ11xADHj6JDLVjgYGqGonNc/hRz7RFoxlj5kYl/WH8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdS4Jyv7rWrxiPFPlbig6aTJ4TLhhUJRfLMLauv96R0=;
 b=o/dtL3DKfJDG/+6zyxIuBWl7eKLQKvPPJcFnnrerCsaD0OijuV036O09mHDbijOo/eXOvrGfC71WvdOrgLXerA5y/m1xxfBgqF7ve38SZP6QGFbxDw6QjVTa6pDTykpNgyZgkFr6pSKOr/z2xUt2HYdRU4oK1CL/EWY1pwe036CKXrEp0Mu1prCnlPcPqf7yPazEDUUswI58YCpp7db7SREC0E6BXOy1j0+CPjSQynEY6w7/75S2rOcOIkYVr72GtuAfjm0Fwx4c8nPWcfZGhrgEl+nkmHzguAGfatY35e3yxtDmgDlGfp4Tzyl1e9hWAbzFCa++klylD+cDr0mAzg==
Received: from PH7PR13CA0012.namprd13.prod.outlook.com (2603:10b6:510:174::18)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:50:53 +0000
Received: from PH4PEPF0000B60C.namprd21.prod.outlook.com
 (2603:10b6:510:174:cafe::8a) by PH7PR13CA0012.outlook.office365.com
 (2603:10b6:510:174::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 20:50:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH4PEPF0000B60C.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Tue, 10 Nov 2026 20:50:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:32 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:32 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 10 Nov 2026 12:50:31 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>
CC: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Pranjal Shrivastava <praan@google.com>,
	"Mostafa Saleh" <smostafa@google.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <driver-core@lists.linux.dev>, Sonang Patel
	<sonangp@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v3 4/7] iommu: Let a driver mark an IOMMU as confidential
Date: Tue, 10 Nov 2026 12:50:09 -0800
Message-ID: <0f84aed0f943d1a66836ee9c21fdd5f1669f5c46.1794343501.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794343501.git.nicolinc@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B60C:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 0287e0e5-1c11-429b-0c09-08df3f6c4f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|36860700016|82310400026|10067099003|261009223027099003|261026121527099003|261028144727099003|261026140227099003|261102130727099003|261102123227099003|261022105027099003|261021135927099003|261021121427099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	t+DnXkTO0fWef11vl2gc/mxC3UaP0S2wA0KHVdbmqaHUNIuXe971McjvsFNpHFwN5yJ6+yWeXMeSX/oMFkFhl1GJBiveCCLty3SNMd0BPFhfSwe22YaeC9l/vZu1xB5RR8K0gTwCsIzwTT7bQxAg+n1pAVmmJTDhv5YLp4pk8TzBwRuxwOaeDsLX/oO8gZj2zdG8L6PKgmGXmwXLIPhcQM46nCIMzDyYcu+xUYes5wH2PkJ5hIPxs7AxckJMGg9IgtfKcxHLEFdd3+FNBQTjK4cmCoNU5ExY0plIeLwtZiHwjVTBCmY2qPkSZfCRzqJf7rKaVBQde2eO+Ts8uIjLH8hClhtW0n5Hx+m5S+o1QL49H97OZsZBzeJb10nha4Z9pMmPrpv7oXGgDCppJrACEakJZwqBQzsLTI0xKE3B85TFn1Ju5AeAA5HrC61cCENQYk59ZJMLXJiOkvb0iJskEXN6XnjKsvpONVYY4uF3tvUlKSzwgj56Bmy3wr2PusjjWcMsQ3Tdt72/S1GBz0PFinRtW69zs2+C02dV+pZCHB8nl2Y7pRuU5/YHbZT6zHq0rcQDsnYfuacaeg5A3CwShPG7a7pNJbNJayyuvmHi2BvIgLrAOD4c/58vkPbRz3+HRAchBUughOz4ytdUKQt6M/S60LJ90uuyNhNu35uAKEc8BIRR5TSZRpscRZUFZO59XvwCJU3WnzUk/yFyzmmq4Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(36860700016)(82310400026)(10067099003)(261009223027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261102130727099003)(261102123227099003)(261022105027099003)(261021135927099003)(261021121427099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4szqUs79hxg8A5SeVgfzGyajO84q0gLYWUXaoQiz6Zw6YOIWJgaveGk98fW82Hmq1XiBCNRqPFLArGokT0pzSVrpJlxP0dJVaG/qThoy2jXWbt5PBcN9GunzhRNjH5LOl/NmHSIa4JMr9VduLTpUY+v6j3AXOrUMy1tWPEKNeP/1J9uJvxbyYQin3/HiYgbn08twtBrKB9rZvKi7DNG1+5kEvQjtL7Z/2zlfZqcAIc5P9SR70lRGHK12t0sMuugNZf3289oNdABOCvoEG1HUeG2iZCIqAp9YOS8Le43zX3Ky5J/ynYpOgUul9J9xyWbJfrWPysRNltR5d6Gpk+JAsYs8NCYMyU3j6F6aFGLzMLq9enTmu8sbQDwbdDunDNwnNmOST+HaNfxPTwGtbbbpaVRqDbBbpC1E6UJO/Br1CiV/pIcaJQW0e8YSCybOKV6F
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:50:52.9647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0287e0e5-1c11-429b-0c09-08df3f6c4f60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH4PEPF0000B60C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952

An IOMMU inside a confidential VM needs private memory for its queues and
tables. Later changes also need to identify it when handling TDISP devices.

Add a confidential marker and a helper for IOMMU drivers. The helper also
marks the IOMMU device as able to access private memory. Drivers must call
it before iommu_device_register().

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h | 10 ++++++++++
 drivers/iommu/iommu.c | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef5043752a365..e8fb5ee59883e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -824,6 +824,8 @@ struct iommu_domain_ops {
  * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
  * @ready: set once iommu_device_register() has completed successfully
+ * @confidential: this instance runs inside a confidential VM. Set by the driver
+ *                before any dma allocation.
  */
 struct iommu_device {
 	struct list_head list;
@@ -833,6 +835,7 @@ struct iommu_device {
 	struct iommu_group *singleton_group;
 	u32 max_pasids;
 	bool ready;
+	bool confidential;
 };
 
 /**
@@ -892,6 +895,8 @@ struct dev_iommu {
 int iommu_device_register(struct iommu_device *iommu,
 			  const struct iommu_ops *ops,
 			  struct device *hwdev);
+void iommu_device_set_confidential(struct iommu_device *iommu,
+				   struct device *hwdev);
 void iommu_device_unregister(struct iommu_device *iommu);
 int  iommu_device_sysfs_add(struct iommu_device *iommu,
 			    struct device *parent,
@@ -1423,6 +1428,11 @@ static inline int iommu_device_register(struct iommu_device *iommu,
 	return -ENODEV;
 }
 
+static inline void iommu_device_set_confidential(struct iommu_device *iommu,
+						 struct device *hwdev)
+{
+}
+
 static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
 {
 	return NULL;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fcd..ba98a0bb800a5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/host1x_context_bus.h>
+#include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/idr.h>
@@ -313,6 +314,25 @@ int iommu_device_register(struct iommu_device *iommu,
 }
 EXPORT_SYMBOL_GPL(iommu_device_register);
 
+/**
+ * iommu_device_set_confidential - Mark an IOMMU instance as confidential
+ * @iommu: the IOMMU instance
+ * @hwdev: the struct device of @iommu, whose own DMA reaches private memory
+ *
+ * Declare that @iommu runs inside a confidential VM
+ *
+ * Call this before @iommu makes any DMA allocation of its own, and not merely
+ * before iommu_device_register(). Queues and tables allocated any earlier land
+ * in shared memory that the hypervisor can read.
+ */
+void iommu_device_set_confidential(struct iommu_device *iommu,
+				   struct device *hwdev)
+{
+	iommu->confidential = true;
+	dma_set_cc_private(hwdev, true);
+}
+EXPORT_SYMBOL_GPL(iommu_device_set_confidential);
+
 void iommu_device_unregister(struct iommu_device *iommu)
 {
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++)
-- 
2.43.0

