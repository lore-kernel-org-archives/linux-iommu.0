Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229BA21C9E8
	for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897359; cv=fail; b=OTPv9M+uAbtAOe2M6kWed7XC/s80VLhj4CtOE0JAhZCIklhdkU/zccJnXrYDpWcoPTj46z9dGuCj721jnw9y6tfHv8W+agaf2Sy7RJyc/znNrWNHem41e9r3L5IUx7nSwM3UClpM1/g5sFr4MKcP2dxukAKXAPhpEETfugQWk7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897359; c=relaxed/simple;
	bh=0cInyxSXsjIqJM3CjcTQ0VF87j4yCWuoXsIpRlp8L7o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQ1rGt7Pghlzwv1yBN0Bd61WW9cHODaZ54a0c1rO3+xYxjDqXZ78IouqzfHDWdsoacRNnil5dS9dM7ahHPoPTvCmbsGhCavMwgubNWtYs9bimlen/ljRX3/vfsU2QiQogLmLENxlf1Ji9/5Snz/w4u0en8DxQm9F/0LE9v5ueFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P9fn8CXc; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P9fn8CXc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hg4wiJv1nLr/nB/ib+b6SuOuttM9gqklOBh/1JrZpgug4IPKkCdrGzqufSB7mP2RdBcA9Td8qQ9PziCdJLWglaGk1nkU7j/XYXu0AdPbz9ccZE1yWiqXhL0ictQKi0nyFViHYVqNJYMp2WT/PDGNzAJE4S2OAx7NlnSfEafsu0NhZfHypTlpkQYtMXTn7jVkVT+a6xsbj+D/QWzN2KRRWLa/SAzNg2E1mwm1kpQp8y44Ur1/e7WQdFrNrNJX/H86bpKweU/DLOxs/mAdyamSlC2gV1YuL/jsmRoUpSyvAK/+gafybeSXnEhMvGu4h4XPZSK5adxEzqQlVVMQU8AfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qH+otf2bJMgdnir94clBIWNE+RPMeSqi/EnrethXwg=;
 b=zBchE9OxmUE7S/9syT+gaeu6T5oOFRDmjJpUBvf7zI+fNRLkrPLHHLaOD+4wbT5Hatq6Stsm79NozfV65fSI4tTt01J7nP6DAZxvyDaTodzI9ch/bxORZDiAruqq0awVPxML1H5b54mf2995kPzqQDY9TcHNiuvLWKaDmB2xi2vz/Tah/h02ZjUALeCl7cblPsy1g8N6KYNJkUw+DuvH/oL25Tdo0glkVkAqIuLSlCoas2rhi/cXcLtNFHB1MMgGdUTklktMLTxKJY7AnR0oRDdz2r5fuCqKWt7nG3xXWqwfQsgofekqbc5TNC9nP6kCTnxX7rORFwIwsuh6EOPHDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qH+otf2bJMgdnir94clBIWNE+RPMeSqi/EnrethXwg=;
 b=P9fn8CXcmOA2oMDn/In/Qb4Z2iv6PVX8aOX7OS6yGcs7CS2dGkOhCdXzebDTOr1ZYg+qAJFzZR6zIEXGdsswr8sOPYK/GjN2djkG6FdeRN2JmehLV7N86+GnaS1zhLQkCSV6iIAwtydEDTwJzOiBMoif2511nOSwBpw71d2cSnxooNuN/8POPZc5TrjZY3O4zonkN9qGGGqr7zUYuOqrJVOA34OMIZp1Bht9WN1v9c/dD2ZAEOC4K3eTI5cOC56lUFzEB/vZLspiJCyAJokxBvb8dBKUyD3drle9gC4KRNGO0TM6whHWQGoSyyLuJMpE4lSo+EdAXSsGHDq56ZkKSw==
Received: from SJ0PR13CA0105.namprd13.prod.outlook.com (2603:10b6:a03:2c5::20)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 23:29:13 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::d5) by SJ0PR13CA0105.outlook.office365.com
 (2603:10b6:a03:2c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.11 via Frontend Transport; Tue,
 14 Jan 2025 23:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 23:29:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 15:29:05 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 14 Jan 2025 15:29:04 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 14 Jan 2025 15:29:04 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>
Subject: [PATCH rc 2/2] iommufd/fault: Use a separate spinlock to protect fault->deliver list
Date: Tue, 14 Jan 2025 15:28:45 -0800
Message-ID: <56c73c27b572e9c677182e99b5244184bdef7541.1736894696.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736894696.git.nicolinc@nvidia.com>
References: <cover.1736894696.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c3d11c-790b-4478-2ab0-08dd34f34104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?va/AQBOdF/4acHVuPLwTEF/B0yFTWvB/luIa85PvgFfBQmLELr3yHONrwCb8?=
 =?us-ascii?Q?S3FLJgJkZ/vzS9mYwTB5PCD7harrXh6HNq8tVyGmQC3uIvNZF2TYL5G+1OCX?=
 =?us-ascii?Q?2rCibGG9575DtOPRwS/I1kdFJP8gF7DzIf+9/jXrBZToNCOhrlxUIwUCBPcf?=
 =?us-ascii?Q?lEPFOGKEZ8NFOKQVA3J+XvZPstHd7l9pk1XYubU5Xodqdz71xs2KAsRGeKoc?=
 =?us-ascii?Q?NuzDWtOD4aHClOCjR2EXyrdgaWlrwFF02Pc+0j60XJrH2PYgissbzWFm+5zE?=
 =?us-ascii?Q?Jr36jzBCKpUv1h4xoDHrDiTIkPu7v2nWBA4do3mCttxo/LYsXo+wOAgbTezv?=
 =?us-ascii?Q?vSd6IkhjqO9MAt/bX0Wk24yr8T0XhjakdK+KzLBRo52kabI/oyUz5UjQsgg5?=
 =?us-ascii?Q?Hn+YcjRs5LjEVoi8OcpYEPA3Vg7VHIZme7pCO9kNJ18MREbnDGDr6Bm8Luzw?=
 =?us-ascii?Q?Yk50zDJE+Cx4/78OLYC+4FiTy+XpqH8b6aM3HEqV6vd5+3lCeHFLIzBDLctc?=
 =?us-ascii?Q?/SRyrJlYqBXlIK5bnIJBuJB8ruzJgYI3L15e4kE6Nz2Ev5ABtktx3AFo29Bm?=
 =?us-ascii?Q?dBQ0fLvYpm3B1/mVfuEClGFnA58aQ7XTxrfZnIB+6C7lDe7an3DlkH5jQfrW?=
 =?us-ascii?Q?kKOGGSWrNSzFD5lLSHVRxjXZ6tDaZKHqJJ+aPkI28PoZ2Y1L5UBPYZxHsxhw?=
 =?us-ascii?Q?z1zviDf7pnEjHQT939XGODTEGwvI4y8MJppU5j1xZ4sMGifNeJsKn7Ka/EYf?=
 =?us-ascii?Q?M4p+kuFRfb+8ZDLZMtwghtPrOcYfzLn7e+n3cd3DmWaKfObaWJTUPVolRLbO?=
 =?us-ascii?Q?qS4U2+2b7bwVOAXxUNt908+R/RVzGkjqR+rLrpqWnzVnYzwp/U7QC1mfXMd/?=
 =?us-ascii?Q?geWC6r8wB551OQYVrv64zSGFXqgIvJ37rBKi573rG3melapWcOLaiykAsqIv?=
 =?us-ascii?Q?bnhoNFaVtRN3qn50cX+wqqqDE/n4yOhGTRecmJH42U/fpYFaqjnIMTtvYwSq?=
 =?us-ascii?Q?+qzSt9lidQiDgPqfWt6nzjeopCrWET/jIHD6LqveMG8iNZQCxgfYRAa7kaw1?=
 =?us-ascii?Q?9EPDgmunOrWjqAt5TfSdG3E6/eX41kRmyUrgsU1B6TOcOdhYFxtaZ98zHuiX?=
 =?us-ascii?Q?vnti80rhDZWABjkHu8ciVXUTXnHWLeH58a45NpYjNuJ76HG7w/1WQo81V0Ws?=
 =?us-ascii?Q?shed/WksXN1n4CHnjxvrPs9VuZ2uRvt1rbiq3cWf41icYLri0GtERJmJLt74?=
 =?us-ascii?Q?QUTla/+aT/Xx1vvdPFOBh1VjTPZ1VA3H9MnyH6EOKKnKlCqwiWq5Qnpf6mvr?=
 =?us-ascii?Q?soivWXXjbdcLY3ZxYSJe5WOx6iEl5hQ2XJ8UkNg0fLPN5I3eHyFdTW7U+3Xh?=
 =?us-ascii?Q?kHu/ch8wKiqNEF0vkZPZM/vsJMQOqGF696cJ76KkmBZgA8FirajTCkAftLLf?=
 =?us-ascii?Q?m70f2aJOhMW+byzAUisK6zweYxaPats0lZhh6qe7tXV5aFJnbU+BDmLMiquN?=
 =?us-ascii?Q?MDU4JwRgRcrGFNc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:29:12.8655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c3d11c-790b-4478-2ab0-08dd34f34104
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998

The fault->mutex was to serialize the fault read()/write() fops and the
iommufd_fault_auto_response_faults(). And it was also conveniently used
to protect fault->deliver in poll() and iommufd_fault_iopf_handler().

However, copy_from/to_user() may sleep if pagefaults are enabled. Thus,
they could take a long time to wait for user pages to swap in, blocking
iommufd_fault_iopf_handler() and its caller that is typically a shared
IRQ handler of an IOMMU driver, resulting in a potential global DOS.

Instead of resuing the mutex to protect the fault->deliver list, add a
separate spinlock to do the job, so iommufd_fault_iopf_handler() would
no longer be blocked by copy_from/to_user().

Provide two list manipulation helpers for fault->deliver:
 - Extract the first iopf_group out of the fault->deliver list
 - Restore an iopf_group back to the head of the fault->deliver list

Replace list_first_entry and list_for_each accordingly.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 26 +++++++++++++++
 drivers/iommu/iommufd/fault.c           | 43 ++++++++++++++-----------
 2 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index b6d706cf2c66..d3097c857abf 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -445,12 +445,38 @@ struct iommufd_fault {
 
 	/* The lists of outstanding faults protected by below mutex. */
 	struct mutex mutex;
+	spinlock_t lock; /* protects the deliver list */
 	struct list_head deliver;
 	struct xarray response;
 
 	struct wait_queue_head wait_queue;
 };
 
+/* Extract the first node out of the fault->deliver list */
+static inline struct iopf_group *
+iommufd_fault_deliver_extract(struct iommufd_fault *fault)
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
+/* Restore a node back to the head in fault->deliver */
+static inline void iommufd_fault_deliver_restore(struct iommufd_fault *fault,
+						 struct iopf_group *group)
+{
+	spin_lock(&fault->lock);
+	list_add(&fault->deliver, &group->node);
+	spin_unlock(&fault->lock);
+}
+
 struct iommufd_attach_handle {
 	struct iommu_attach_handle handle;
 	struct iommufd_device *idev;
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 685510224d05..fa69240daa28 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -102,17 +102,19 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
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
+	for (group = iommufd_fault_deliver_extract(fault); group;
+	     group = iommufd_fault_deliver_extract(fault)) {
+		if (group->attach_handle != &handle->handle) {
+			iommufd_fault_deliver_restore(fault, group);
 			continue;
-		list_del(&group->node);
+		}
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
 	}
@@ -212,7 +214,7 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 void iommufd_fault_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
-	struct iopf_group *group, *next;
+	struct iopf_group *group;
 	unsigned long index;
 
 	/*
@@ -221,8 +223,8 @@ void iommufd_fault_destroy(struct iommufd_object *obj)
 	 * accessing this pointer. Therefore, acquiring the mutex here
 	 * is unnecessary.
 	 */
-	list_for_each_entry_safe(group, next, &fault->deliver, node) {
-		list_del(&group->node);
+	for (group = iommufd_fault_deliver_extract(fault); group;
+	     group = iommufd_fault_deliver_extract(fault)) {
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
 	}
@@ -266,17 +268,20 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 		return -ESPIPE;
 
 	mutex_lock(&fault->mutex);
-	while (!list_empty(&fault->deliver) && count > done) {
-		group = list_first_entry(&fault->deliver,
-					 struct iopf_group, node);
-
-		if (group->fault_count * fault_size > count - done)
+	for (group = iommufd_fault_deliver_extract(fault); group;
+	     group = iommufd_fault_deliver_extract(fault)) {
+		if (done >= count ||
+		    group->fault_count * fault_size > count - done) {
+			iommufd_fault_deliver_restore(fault, group);
 			break;
+		}
 
 		rc = xa_alloc(&fault->response, &group->cookie, group,
 			      xa_limit_32b, GFP_KERNEL);
-		if (rc)
+		if (rc) {
+			iommufd_fault_deliver_restore(fault, group);
 			break;
+		}
 
 		idev = to_iommufd_handle(group->attach_handle)->idev;
 		list_for_each_entry(iopf, &group->faults, list) {
@@ -284,14 +289,13 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 						      &data, idev,
 						      group->cookie);
 			if (copy_to_user(buf + done, &data, fault_size)) {
+				iommufd_fault_deliver_restore(fault, group);
 				xa_erase(&fault->response, group->cookie);
 				rc = -EFAULT;
 				break;
 			}
 			done += fault_size;
 		}
-
-		list_del(&group->node);
 	}
 	mutex_unlock(&fault->mutex);
 
@@ -349,10 +353,10 @@ static __poll_t iommufd_fault_fops_poll(struct file *filep,
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
@@ -394,6 +398,7 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	INIT_LIST_HEAD(&fault->deliver);
 	xa_init_flags(&fault->response, XA_FLAGS_ALLOC1);
 	mutex_init(&fault->mutex);
+	spin_lock_init(&fault->lock);
 	init_waitqueue_head(&fault->wait_queue);
 
 	filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
@@ -442,9 +447,9 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
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

