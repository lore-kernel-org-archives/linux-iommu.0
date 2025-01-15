Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D5622FDFF
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924194; cv=fail; b=XXMoc0XG7THQVNsrZsJ3egsBtu6JgWtJfG4rVJRQaO8bUDA0t7ICbf+c0I//pUU76mCZ5ezBHHVpXZMEX6PYadpwYO4MDfna8teDQl3Ub2plmrnGQ4hJWl/qcKeHlt2bePvhMoLAeqoZ5Ivpx2QjZ+FYl8i7eLKA/4ObXssV6gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924194; c=relaxed/simple;
	bh=NqQXmJSYlD9c/4Y3CZmZTLcdc6VSmBy1aFLc2Xxqalc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7dG8llOqz7ULrDP3Xk+KhzmW4Hvy04cOAiUbDsyjhjUoDZub9V0eyEhjq0n7Jmf9tR/uvgyk6Ogol8HuIU+L/3gi8sJvCJvx6Bs9XGFZKamOVBcvO/tz5DPcE1vunIo8FGGuq7SVRGALLa1w/BWSuBAKgiE1svQrBjPyR040nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FDqhrPlL; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FDqhrPlL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZltAM2JAdcxIaxv3Iu6BkLSmZGXmlFOALMGKGsaRoyo6S587krBmLwPBTekAcBqy64POZ0z4Hw2WNICNw84AuhMXP3N74vEmlOpI3xbpbFd7ZpK4UYw1FRQpOjYQdY6xHuAsFRQs4ou4MsPjqRHo0cVyuKMRZ1NFQHwj2C1ZMWrTHmE7+mphKqFUlNk5TA24CsmScKArYpzBR7apmjLqfpswUE3hbAVl+fgNNuTO8ayi24Yx1b37nuH7AKrXew3phxaS+Do+7Gg3WVox60PTvO17PqK5A94iuD7w5PdBlPw0nZ+9CCbgj7wRdP/mEr9KbzO525UlzS5BPHmkz9r7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WxOhNPvTxLG01UPWDiJhW2cbn1SNq3rNnqi9KkRGpc=;
 b=daak5DxBwAXaatuqYah8rbYF1Y2HR2ebhw/Xu3ah+Bo2KBdWDwp2JdWDwDoDBSVD5hoqh8z4ATyPhsKTT1TJ8CgM/LabxWna+HiF6tsEkkq3liV6JwwcQyP1oPHXzsZ9x1qxWQRjRNtNTQT3ofvxqXERmCslag0hQd84vrkvKGFab8N+I3JzlAm7DXaByVwe/qPP7N3a7LIpS5ICZ/0BEIRDWS3c24Q8V0XF0+TKzHxnOiMngD6mnBJqWm09p7VG6B8IeARYbS6PbOUBcswszOX1edx1VzvyMwxlR7DoYi+6y7K+tXSdCKeRFmVRMW8h+Y9ggVe6Hi82XYrcR85mFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WxOhNPvTxLG01UPWDiJhW2cbn1SNq3rNnqi9KkRGpc=;
 b=FDqhrPlLIjA13z95FY5GP+Q9zCCydvatIKFsgRGxxDh9472pKKXR4SwwpAEFzkRodbCsWZYd7vWL3nYwSNflOIwoqpi/D/Lx3Z11SR1VGzqvpoF7lZcH14ATpoL2oZ9Ic6wdXkxftZcGBYDzcz6ngy7v3vu6deOivgAeGK9CguA19G5OTKt9DN/DphSbFBb+eqTh/5hCGWPdRd+RAHGMn0ErCceo5X7BAtuzY+DntamnoeShFVVneD7M/nnGnlG2P73TvA9Th+I6nQgpKpQTK5l2MmHLtZUvnSknuFIlfAX715kiud4nFQJpCuH5eoUOHQeAwx7qJ2+qc3s0qkWdFw==
Received: from BN1PR10CA0026.namprd10.prod.outlook.com (2603:10b6:408:e0::31)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Wed, 15 Jan 2025 06:56:25 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::f9) by BN1PR10CA0026.outlook.office365.com
 (2603:10b6:408:e0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.12 via Frontend Transport; Wed,
 15 Jan 2025 06:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 06:56:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 22:56:09 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 22:56:08 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 14 Jan 2025 22:56:08 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH rc v2 2/2] iommufd/fault: Use a separate spinlock to protect fault->deliver list
Date: Tue, 14 Jan 2025 22:56:00 -0800
Message-ID: <b727b09df331658f9bead42d6340e942e71a4cb3.1736923732.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736923732.git.nicolinc@nvidia.com>
References: <cover.1736923732.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: abced9ce-e999-45ff-26af-08dd3531ba40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8E+jhWiwbsTJtupYbXL1xFbdCPbSon53SXAbE6qXobFzyIHkmh8wGLXIK2/w?=
 =?us-ascii?Q?fTJ1ePYT1Q1lsLrSoKl0NgPbiJEZ2yQxE41vh51YWsnWwpi/SGve2+N/kfqQ?=
 =?us-ascii?Q?VIPqyOdvy6lbFtuoomV5I5RgzJKpkJl1khyviBdTGUcRN05NXrjXHtc4ErSe?=
 =?us-ascii?Q?L0a6qzP9YpOvy4ziup1/0mUNasrZ8kKVB52S7culT5bWrpyxGKsWMep2esa1?=
 =?us-ascii?Q?I45nAXATsVS0ospXTUorXW9AoZLScljqk5ik+PlpeDmdVA8es5i9cTEqHDcC?=
 =?us-ascii?Q?g8OaFSMw+8DhBb/dJIGkX6clf47rTbRvh8McBS4Z2gSwaxhwx1oVv/M33P2E?=
 =?us-ascii?Q?hFqiKgomnkGpwBYJUGGHNqYQ44MhMPeQTgH5TVzZO/0VBz5PchjaBKT1SgUC?=
 =?us-ascii?Q?RYhMHGnlNGczs1OmxTe/GmxPWipfT2ZFVAb/6Ml+SS5FtGHxmYN0UHgCFz0b?=
 =?us-ascii?Q?zdEf4RHRsrmKqA8xT4ylDIzISK1zue7kqE6nz6VsOQTRUZLPuAYwKAqmYbXO?=
 =?us-ascii?Q?kxjvmBcIVSNKoOw0+pajm0Y8A4wvuI236HZGi63xKAX60cyilMaqSv1eyV6E?=
 =?us-ascii?Q?gCIZ2Z07gFNTm8zP1wdlGdPXAAPG2RMW2xWJh0qEcgazCr92pbrkwDUfR3GA?=
 =?us-ascii?Q?tkO+KlihzZTBF4da/TAQSjmc4YqEC6p6pTFk/han7MqXkDDwxOVKOB9sU+WV?=
 =?us-ascii?Q?RefoJFq6Fc3tVIv9gMabWkOkxztm6IzOuYmnSD1EZd2qLnQd4G3Sj/L5Etk6?=
 =?us-ascii?Q?cKRCGuzpG7hacpo8E/Wt0EYk6B3PzqDjudI3WtKKkoPKv/MB6mN+VWn1culZ?=
 =?us-ascii?Q?2J76mTUi1waM1iR3NqfnOIpYXXoMpRTTHbjTKCVggfk6s8j1TktQfTji3mG+?=
 =?us-ascii?Q?OakpQswczA4Frbba90lU8gd+VqM3tPVcT7qPKT1fu7zS0vLan9y1uoGb1+4v?=
 =?us-ascii?Q?nyVAZivnyYyrcX5FsrUuP4J+cv+Gnafr407WdqrS1vLJcNl6cIIukCNJfZ8T?=
 =?us-ascii?Q?dvyRXn3E60I1jIJKjk8y9v1SuVL+/deVh+/67ccgcQNg90Ds9AsXzZFhHHD3?=
 =?us-ascii?Q?UDSLHklO1KR4byr1cjN9EOC2VmrYVcw7UGUtaHqEKXroWYcwV6RFGBWrzOIA?=
 =?us-ascii?Q?q13B1duykAJqtfV3+/lAWkTrWRzZlJmHuO9pbvvy2QRZaVvO8mhOXOfZjlV0?=
 =?us-ascii?Q?cE4mT2p8yktr42FldH7IOi38w+AT1P4xo9sWCiXUWPMHtIFDCxh7xV1BR2B+?=
 =?us-ascii?Q?2uEq+AfofFPK6INfoOaGprnSa0Vi55TxO4TQOPEq6aYcIl1+7kNu+l5ss7kc?=
 =?us-ascii?Q?ea3TsiaiekQtR2GHM0or0P/PNXDnN61s2MN3g0jHCFk4GuWZdY3cVckfWwXk?=
 =?us-ascii?Q?xTl1fYGfZkW8kZIB57FjcDlpBEJMjSNNnhhHHue49hjaKdcg0zbR5RmvH3+t?=
 =?us-ascii?Q?yqIbOeWtc1y3lwXAQGTB75Q+EBfwR+DQWtv19px7MpKvuY81HY7nluKwLmAV?=
 =?us-ascii?Q?obQTR87AdWoBn+o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 06:56:24.8883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abced9ce-e999-45ff-26af-08dd3531ba40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814

The fault->mutex was to serialize the fault read()/write() fops and the
iommufd_fault_auto_response_faults(), mainly for fault->response. Also,
it was conveniently used to fence the fault->deliver in poll() fop and
iommufd_fault_iopf_handler().

However, copy_from/to_user() may sleep if pagefaults are enabled. Thus,
they could take a long time to wait for user pages to swap in, blocking
iommufd_fault_iopf_handler() and its caller that is typically a shared
IRQ handler of an IOMMU driver, resulting in a potential global DOS.

Instead of resuing the mutex to protect the fault->deliver list, add a
separate spinlock to do the job, so iommufd_fault_iopf_handler() would
no longer be blocked by copy_from/to_user().

Provide two list manipulation helpers for fault->deliver:
 - Fetch the first iopf_group out of the fault->deliver list
 - Restore an iopf_group back to the head of the fault->deliver list
Then, replace list_first_entry and list_for_each with those.

Lastly, move the fault->mutex closer to the fault->response and update
its kdoc accordingly.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 29 ++++++++++++++--
 drivers/iommu/iommufd/fault.c           | 46 ++++++++++++++-----------
 2 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index b6d706cf2c66..0b1bafc7fd99 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -443,14 +443,39 @@ struct iommufd_fault {
 	struct iommufd_ctx *ictx;
 	struct file *filep;
 
-	/* The lists of outstanding faults protected by below mutex. */
-	struct mutex mutex;
+	spinlock_t lock; /* protects the deliver list */
 	struct list_head deliver;
+	struct mutex mutex; /* serializes response flows */
 	struct xarray response;
 
 	struct wait_queue_head wait_queue;
 };
 
+/* Fetch the first node out of the fault->deliver list */
+static inline struct iopf_group *
+iommufd_fault_deliver_fetch(struct iommufd_fault *fault)
+{
+	struct list_head *list = &fault->deliver;
+	struct iopf_group *group = NULL;
+
+	spin_lock(&fault->lock);
+	if (!list_empty(list)) {
+		group = list_first_entry(list, struct iopf_group, node);
+		list_del(&group->node);
+	}
+	spin_unlock(&fault->lock);
+	return group;
+}
+
+/* Restore a node back to the head of the fault->deliver list */
+static inline void iommufd_fault_deliver_restore(struct iommufd_fault *fault,
+						 struct iopf_group *group)
+{
+	spin_lock(&fault->lock);
+	list_add(&group->node, &fault->deliver);
+	spin_unlock(&fault->lock);
+}
+
 struct iommufd_attach_handle {
 	struct iommu_attach_handle handle;
 	struct iommufd_device *idev;
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 685510224d05..8c82338ea303 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -102,17 +102,18 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 					 struct iommufd_attach_handle *handle)
 {
 	struct iommufd_fault *fault = hwpt->fault;
-	struct iopf_group *group, *next;
+	struct iopf_group *group;
 	unsigned long index;
 
 	if (!fault)
 		return;
 
 	mutex_lock(&fault->mutex);
-	list_for_each_entry_safe(group, next, &fault->deliver, node) {
-		if (group->attach_handle != &handle->handle)
+	while ((group = iommufd_fault_deliver_fetch(fault))) {
+		if (group->attach_handle != &handle->handle) {
+			iommufd_fault_deliver_restore(fault, group);
 			continue;
-		list_del(&group->node);
+		}
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
 	}
@@ -212,7 +213,7 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 void iommufd_fault_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
-	struct iopf_group *group, *next;
+	struct iopf_group *group;
 	unsigned long index;
 
 	/*
@@ -221,8 +222,7 @@ void iommufd_fault_destroy(struct iommufd_object *obj)
 	 * accessing this pointer. Therefore, acquiring the mutex here
 	 * is unnecessary.
 	 */
-	list_for_each_entry_safe(group, next, &fault->deliver, node) {
-		list_del(&group->node);
+	while ((group = iommufd_fault_deliver_fetch(fault))) {
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
 	}
@@ -265,18 +265,21 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 	if (*ppos || count % fault_size)
 		return -ESPIPE;
 
-	mutex_lock(&fault->mutex);
-	while (!list_empty(&fault->deliver) && count > done) {
-		group = list_first_entry(&fault->deliver,
-					 struct iopf_group, node);
-
-		if (group->fault_count * fault_size > count - done)
+	while ((group = iommufd_fault_deliver_fetch(fault))) {
+		if (done >= count ||
+		    group->fault_count * fault_size > count - done) {
+			iommufd_fault_deliver_restore(fault, group);
 			break;
+		}
 
+		mutex_lock(&fault->mutex);
 		rc = xa_alloc(&fault->response, &group->cookie, group,
 			      xa_limit_32b, GFP_KERNEL);
-		if (rc)
+		if (rc) {
+			mutex_unlock(&fault->mutex);
+			iommufd_fault_deliver_restore(fault, group);
 			break;
+		}
 
 		idev = to_iommufd_handle(group->attach_handle)->idev;
 		list_for_each_entry(iopf, &group->faults, list) {
@@ -285,15 +288,15 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 						      group->cookie);
 			if (copy_to_user(buf + done, &data, fault_size)) {
 				xa_erase(&fault->response, group->cookie);
+				mutex_unlock(&fault->mutex);
+				iommufd_fault_deliver_restore(fault, group);
 				rc = -EFAULT;
 				break;
 			}
 			done += fault_size;
 		}
-
-		list_del(&group->node);
+		mutex_unlock(&fault->mutex);
 	}
-	mutex_unlock(&fault->mutex);
 
 	return done == 0 ? rc : done;
 }
@@ -349,10 +352,10 @@ static __poll_t iommufd_fault_fops_poll(struct file *filep,
 	__poll_t pollflags = EPOLLOUT;
 
 	poll_wait(filep, &fault->wait_queue, wait);
-	mutex_lock(&fault->mutex);
+	spin_lock(&fault->lock);
 	if (!list_empty(&fault->deliver))
 		pollflags |= EPOLLIN | EPOLLRDNORM;
-	mutex_unlock(&fault->mutex);
+	spin_unlock(&fault->lock);
 
 	return pollflags;
 }
@@ -394,6 +397,7 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	INIT_LIST_HEAD(&fault->deliver);
 	xa_init_flags(&fault->response, XA_FLAGS_ALLOC1);
 	mutex_init(&fault->mutex);
+	spin_lock_init(&fault->lock);
 	init_waitqueue_head(&fault->wait_queue);
 
 	filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
@@ -442,9 +446,9 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 	hwpt = group->attach_handle->domain->fault_data;
 	fault = hwpt->fault;
 
-	mutex_lock(&fault->mutex);
+	spin_lock(&fault->lock);
 	list_add_tail(&group->node, &fault->deliver);
-	mutex_unlock(&fault->mutex);
+	spin_unlock(&fault->lock);
 
 	wake_up_interruptible(&fault->wait_queue);
 
-- 
2.43.0

