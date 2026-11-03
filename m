Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793677828;
	b=nR2HqQ9xhvumSSSMyfFyevPy1riMubzDlNFD0cIeY9+GWaWxvCv61/qiKCkowjdlEWbL
	 9hT4UTsg90Mcv3qN9hpema7L3eQcpn5E4NZW1yD+LCm/zpTJdbxIhhgDI6zRETo3oefan
	 F72CR6pGp48WSICXL88GgsEKqHMWt4Ph+9Zw6vrFLDdJGQ4XhSCvVJv9yX7Mo9pf8Eq+a
	 pJ73BqVWNN+lHO03PB0mvZ+Xso4SMuikIjd2Dor1O/0QMitiU5dxPY/YrChBuVKfdakwa
	 rqEwmwJYF4PSnG6CVkkh+SLWj4d7f1jj9uOSql0zskUN/BnMA7gfc8Akhb9tyuwz/0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677828;
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
	b=LrjbPs0TtVvGR/BOneICyRQvKRjc+Sen/IA6e8eP7hrh7B2QFvDgPMJXVCEU10J7dJPt
	 Tdf6tSIrj3US2PwK5AuzvTzKGlECnd5cHWxIqTAVDnrE6zd1BicVIh+7X13R7qG0S80FF
	 s57Yica+eA4B1ZmWWP8zGc2BQgGbhB56OGCKxCYar2/lCRW8QsrMsQbin6SJTcdDXrNnL
	 jdrzpu1COK1a2vS04ZIzYHSX9jk3WP7UEbb8dLLwUeflQlopS69GYoR5tuBT7qfVkaI1m
	 E0ezsNxtvZrhLj08hJMCVYSiICeqn7Lp1lIEdauGRx+1vwOy6u8Sie2MS20MFCoGmTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cjp3zRnK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.60
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5FD606D815;
	Tue,  3 Nov 2026 03:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B5FD606D815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cjp3zRnK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bv7Ztt2OVh1LjrjfSJT7cHaWGMUo7Q/JgQPIbkNo7CeGcocLlVfC5XdMMqM0eOhEevAknsKcrOCDb6B4k7kU6ZILljz3mlIm/CKRf1oBEVb3xdDq9OynQPGhO+owjiHmRJ7Veiz9Ftx85Cs+7DUv82RryNBD6rPnMbidsrqKCpW6z50JqjctZaIriFUKbZ3SXimBh8inM7p44oWr+Aq1lpkhwjse6l/7SNsvh8upwx9jGC7SV5/RDKU392BLkkDRcT7endM50rGyxHJPw806Cnp9paqhbLsLDQFbcBqAXoK5CZvCoL8mqBnAIlO7Joh9qZFPhDfCtL4kUi41WlH5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdS4Jyv7rWrxiPFPlbig6aTJ4TLhhUJRfLMLauv96R0=;
 b=m5C+vyQ2dZWd+s56ZdOGE78NCLz0WVVRWhlejyg+Yu2UXKDBqctvwaFye3gSYqctdLKD0yrOxZdI9N5f95Ts0P7I+i3CUz3gRpSDC6H6w43swy7XRFpmnPT7pUXjhtXuxHW182+IEPxwi4SbvaN/Sgs6a/BdAD1nvMOo9jdwwffiigs6XVngR2P//6l3XL84b7h8+elfPyivkSrQitnNbNEkWB/0MrVzRHVzKBnObXvun8VoeYXC88zTH7acnyjBYXGRYHffgA66hRM5o9FLQFv8FNiCNAl+C8Xd/z9xd9jMVUeJIH23ifCN9U3p0HugaqkX6fOsY1mtrbctzco2Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdS4Jyv7rWrxiPFPlbig6aTJ4TLhhUJRfLMLauv96R0=;
 b=cjp3zRnKDx+yMK+Qth+VFxpdqkHzWxtNq7Dr/F1rpYsZK79xBUy6uw2nYtXpMKZXazLkPVcgkHsBvLcOZEBYySo4YlcqvHrmbIpCseQIEuFAQbPN5yYT+OimOQD6hHt1HL0XmN7htBHZ/xfEuWd7BR4iJyXnkGFcTqsONy+MjTxwhpY/mmMAETD3y0S4ho+rZ5Oxu2kGc4bEdh23/h3328Jd2SMgSPPMh6RrfLVze6f2rRNthYJyivXhKYmDryArmBMZPu64lC43hbssksJpmm2XqExqI50d2byCCqSsK13r08sMtcntx3gaO7RWjZ+7XIuQlMQW0QaliaaYOZKVSA==
Received: from MW4PR04CA0267.namprd04.prod.outlook.com (2603:10b6:303:88::32)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 03:50:15 +0000
Received: from MWH0EPF000D894E.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::1b) by MW4PR04CA0267.outlook.office365.com
 (2603:10b6:303:88::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 03:50:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000D894E.mail.protection.outlook.com (10.167.249.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 03:50:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:50:03 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:50:03 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 2 Nov 2026 19:50:02 -0800
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
Subject: [PATCH v2 4/7] iommu: Let a driver mark an IOMMU as confidential
Date: Mon, 2 Nov 2026 19:49:47 -0800
Message-ID: <9b53a42bdede90e7166ccbe7d06ad7e3d03a5ce3.1793676742.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793676742.git.nicolinc@nvidia.com>
References: <cover.1793676742.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894E:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 4546ee34-634e-4256-7ecd-08df395d9188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261009223027099003|261028144727099003|261102130727099003|261102123227099003|261022105027099003|261021135927099003|261026121527099003|261026140227099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/xiGz1aFmCo1hQoerjzHWJfh+RV3BKSEqNkUSpN6wAUoI+FY8sMGLe8kiacxN2FfDrySoTk4yZevGzS9GwyZbwPKkwZ6PuvV3+x1uU6y6MA6v9PXnwu6ywLdkZBJyRkTNyCcfkSAVQ5cfcjbmEPLd7dwRuilT5MnHQ/mexLkq9RGwRhkigWdL5t910V0DEc/roMdz1Ew65K11oxKmEIndPyoFrCbADPV7Ep2QDXNmjzlvnr1fhLdW6mVDPMuXhWhgRyI/TFd/oSEfv5uZ+HBYtUfuQPabZyb4bMsvgiDLWFuko/ON/vqdTz8z4v09NRmk3Bf2Oe0lwJ3emflrIANmzi2+g0CzSVwY09st0uUh2tgmG1wKYBuhqMF4vI8p4Y+y8MJbAFI/K9zhvHWWE7y767gsQ6h5EvDL96IyeZF5JelghGM36Ntu2s2mZ/9OUr8/2KvYOQU4ZVbD4JFkUFjWSotlS1z141ZmI3oGSeEJWAVH+BJqTTG0t23jOks7D9P/gwxEXUnmr0wDbm8kFs9Bj1Mqv9kvk2A6mSBuXnwiTC/pxn6xKK1pV/lfapgWLlniFBeBJvH/SJsJ3+ToCMhaixOwmdK/YV3AHW9tb/htYKh30c9QkVILlaXkMg1UmoiGgc79RDSMhXVWkQ3NMjUvQwtXDyGkvLzWyjOVjXaX/7RkL2gMVyoKqzbkS0XioAVXW4OwTcOclnHxc/MD1XOrw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261102130727099003)(261102123227099003)(261022105027099003)(261021135927099003)(261026121527099003)(261026140227099003)(261021121427099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pDtUftcw/2jSWON6HNzAk5Rzq+fXuOxO4gaTNVN3UmSJBOUeRNe8lOxKUdYBXxaRGHba3zqJ2Etx8DtLUew0exwULKhrDNFYC7XU6WqU85ngI4clhWObaeb7BMtzoK7FGHkZuukOdQhcv9NrrLmrp7e0d24URF1fjYWM9aIiaO2EZOqAjHqNQWd9CS9HkJjiuhhgnhL1LnNOG2XjvCPM4veIE98tYvdXaNShIyEi+n6UsikpihrKe62TQlVd+Yg9jwdkoUzlHOJb3EPQsoHIIemQ3wusfus8RlwtgJlGqZ/Ujn5PRQg4OSMYIroxY9RMf73zxU1KhiIZPcXQ7fkyz5AQo76gvlxBSBEtTmJp4CIZnxMawL0ZETvN4y4VLQR4mjKEjfNEXVtAQQhcJ2ORTbUWYGqRWGK+uVnPasNhtJ/ANzgKv+4L8hU0iMbN8IfW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:50:14.4900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4546ee34-634e-4256-7ecd-08df395d9188
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D894E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868

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

