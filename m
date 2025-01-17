Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C8B1A7AFD
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737142185; cv=fail; b=kH3dzstwITMgzrPv1fd1wogeRNx5jySmz+IoSW2Wp1iEjucXvcy8DBw3uv34bCxYpAeVTEGy/diwvURAC7w88xwKZQmm0t1LIlYH0X7HnlyCKEQYOk40ctxEPsHY5wU68C/zI/MaUbTj8bhZ94uiqLQL03G9nRYqYQh1kEvYT4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737142185; c=relaxed/simple;
	bh=GjXlPM4v3NaHuIzk9WuopHeg2+QWk1X+cYe/kXKR5o8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K+nMNnqPERBAt8s3KASWaYx40NSrnAlw38QLLDjTFcEi37pp7P1/Ji/yqJwe0lGua/kNO4wZhONELII182Oz0nX++HM3Guh+DumHbn+UEeYIyDclYVHARiLCbYKLPWBaGR4Mp2uQv2lAwo7FJG3/h8yEfjED/fXH3bXgFpxQpIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hn45pUeB; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hn45pUeB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZDYexsbQKBXIYo4qNcXpujKQmJayjKYGRNEfMQ5ay4WdVxAzhneSxl5tCy9PmyjLYBpdreNxuoxkhlMZhDcWbnEgw43H4CKA2eE/m/7eA5Psoyhbp6BruWYpYL06LGlqMmSMng0FDT49ymOQ+EOC3qJniOYHYEpc1fP0rU1AXrtCFlRGLTFU0ObQ9oZF/GP9nF5skaeBPcZGvgOgJ3ETlH7GyCVRCJOgwOfVUu1edwRANnxzyRDx2YL5sGBQgPnk2diCJ1mlgBfD0PPJdZ4MA83qBVaFgswvYRXduHaRroBLA5vDDHEeNKlhYIC2fq6I0OufzVAvL21l4rZXoeqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2moysp3Esj3Ctqlo72rk9Kk0UToxuCpEk0vSlB1EoE=;
 b=ihBNhlPkgob61gWPKfI/bi6x0mOhFtcQt25s/DJowIC3I+AE6a3xe8uzhNGGXazWVxzNmPgA9LG0ODG82YRAjwPHnfAlsDUDxDWNAJDVGRCIbt8XN4kYrvQm7wgYzzx3FUrzNIYb3g68qxcoHMHLDmfOJuLhCuj/fXZDdNL6Ar95H8mX4beKp7RxQs84OcMRISbiSb9ISCVvs9st7W83YAcTUQkL2XPSXFc5Xpu/L9xX3p5fZTSMLbqIwi9W1aBRCniESeZuTUkrJmtOn5Q022qTStbZjb2PPFak0aHlTNRnhIccDFPlrdrWZU/kUXvXSl4D0aD5Da6qXgHlP8VzIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2moysp3Esj3Ctqlo72rk9Kk0UToxuCpEk0vSlB1EoE=;
 b=hn45pUeBuz64vKljLrYwUxCMVwglLs0P3TWKj9vVDe0bd5JKruOlIjtsFpWUjrpyGD/QJwVKLEeMGOhWqXK//cvQYIfCoGNEGyE1z2Z0JQ2g8OTBp6Fj9Q6TQc2048vXK/ioTseITxgN1BWn9BWZDKUxlakN3Jho0uvpnUr3dRtkm3iwo1F2031yDH900P+7wLJJRWeMdNwxKT/WftTz8oW184MRtFc1jWgMY3Ae3kJ9Js6BBUe3TdfNh6mgz+FdVV0A5s/OYiTg7ifCluYhH11370JNJCGtxk3bfLuR12g+E9lg+nqid/1gCZt5QqtGVHGAHAWKZFzmusO3NeoWsQ==
Received: from BL1PR13CA0099.namprd13.prod.outlook.com (2603:10b6:208:2b9::14)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 19:29:35 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::4d) by BL1PR13CA0099.outlook.office365.com
 (2603:10b6:208:2b9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.7 via Frontend Transport; Fri,
 17 Jan 2025 19:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 19:29:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 11:29:14 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 17 Jan 2025 11:29:14 -0800
Received: from Asurada-9440.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 17 Jan 2025 11:29:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH rc v4] iommufd/fault: Use a separate spinlock to protect fault->deliver list
Date: Fri, 17 Jan 2025 11:29:01 -0800
Message-ID: <20250117192901.79491-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: d1aece68-068b-4b59-0e45-08dd372d4658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?posOKTONU+FC4qErq7DWhBWmyxwsDEc/GYz4oJonfYXwBvoo23Bu3DdilNBJ?=
 =?us-ascii?Q?tuTyIWPAmu13truASGBVD8MDLmX2rZxLb7b80uVVYfxbos3jI49dbSwesyyV?=
 =?us-ascii?Q?O4MlHWV6gtD7ohK2VWJ5Jgo6Yn6WLbWFYLfW9SYPT5/8tUvRbRm4KzE/lkGt?=
 =?us-ascii?Q?yMVEZiP0/Lcmol7Nu0x7tNMYv82OoIKEnk5LjUlG80ax2TOXOceL0z3vbk7U?=
 =?us-ascii?Q?AKDqITm0UxoVX7LgtA/WzkpadVjbg1O5qIkn0fqdW5rgPwGQ3Mm1Q0WO/er9?=
 =?us-ascii?Q?42R1gZk2EgtnPhrN5G38FEMO1vz2PROItwHHb0Vp9xAHi3LnchianmajJbKi?=
 =?us-ascii?Q?vzzGkHwvPAjcDk5d6GWmpWIvIiY34oC0bTXAdBjaF5DD4I/uTx8NwE7shGEg?=
 =?us-ascii?Q?3L930PQhQM6VySoEnd1eZRGKHq9ZOjYH/kYICxnRsvFhlMs4SVgyToFBaiiW?=
 =?us-ascii?Q?cIJTQAIl6cpQM6rcpj5wtKBhimQ3tCtnU6fa4TXVmUd+P2VJxHVPXqydd3lr?=
 =?us-ascii?Q?CCSfNcVRGOfy7h04gi6gh13rjifgxBKRPLf/81ia49jhqNjW5iZZzChsVr5D?=
 =?us-ascii?Q?XBcLR9E97CsB4Rm4W7R7hELpYziXp/QdiGhUBSZ2ex1YWpO9WPBvDZPjJicD?=
 =?us-ascii?Q?H7jiyd20/TqNWnotvhRVCbhkReCSz0rmJXRO4Epq48hJFrAjZ5a/Hu2qz6VI?=
 =?us-ascii?Q?barjPYVp/tj4vC1Y2h8ekmUkQNBj3OlPFsNJUbcVdwW1eojlV548F92xGLyo?=
 =?us-ascii?Q?Did7oNct9iXiRSZdM8eGBXl7d7duRvnVLqDoYc0cLsKQkM6VWpu3YAZgXMud?=
 =?us-ascii?Q?QM5cyQKXckyoiHz30iki2IeD5ffmJWTb38GjxhDI5VyT90GvLdMnqz2U5MDH?=
 =?us-ascii?Q?Oy9lBbKt2cH8i08NYnbZV1ZdFbaJdfjQtshlKg30fJQq52HUcW2Dvv9wFIs0?=
 =?us-ascii?Q?8F158tgNUjbDgk26j4TiKI01x8eFeF4XdJ1xWmr8LxFn89T8RdITRRIFgjNy?=
 =?us-ascii?Q?NygooH6294wTP9Kgd0GM5dZUoTjHsDZhjGrf6N4q9SkYujpWmH+Z/Bu4NhO8?=
 =?us-ascii?Q?k0jXfObrDl0QsPfmwKrt/lDyQGJ8gpTOtzgE1oGFMz8SFqFmS82ylqSxGX/b?=
 =?us-ascii?Q?19jIX9YAJGVhMjNpL1UwWikyN8Ws1+RVjLsBVnk+C0mVUIP3lByJupAjkJP+?=
 =?us-ascii?Q?4c6jmzAcOsr8YeaIn8XHIYonYRYlEvSMylGGZf0oXg9U3JtZx7Lz3geD0ofA?=
 =?us-ascii?Q?GdxDYEEWnXuxPXH56Jxb72ZoZym/KlVS8oNBb0is88MQXvuZgswavpjtgYxp?=
 =?us-ascii?Q?gvHUL/CtElOqZmn1rrSpMumLHxOjF5js5dWvlPtfiyO3elPFR2K+XTlf+y7z?=
 =?us-ascii?Q?zuAkX8VFpbzfrROENsCdAGZEB0ocD0oA72P6bKiakMj7QMI6cPUWWzE/eyoo?=
 =?us-ascii?Q?sUztBX4ugvrwi5QrOwAJ99fAhOWWQR9NdA3uU/pkD9xIcA1+Tvdhq31jtjQZ?=
 =?us-ascii?Q?+fTGFPqEUnkd+gU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 19:29:34.7679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1aece68-068b-4b59-0e45-08dd372d4658
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914

The fault->mutex was to serialize the fault read()/write() fops and the
iommufd_fault_auto_response_faults(), mainly for fault->response. Also,
it was conveniently used to fence the fault->deliver in poll() fop and
iommufd_fault_iopf_handler().

However, copy_from/to_user() may sleep if pagefaults are enabled. Thus,
they could take a long time to wait for user pages to swap in, blocking
iommufd_fault_iopf_handler() and its caller that is typically a shared
IRQ handler of an IOMMU driver, resulting in a potential global DOS.

Instead of reusing the mutex to protect the fault->deliver list, add a
separate spinlock to do the job, so iommufd_fault_iopf_handler() would
no longer be blocked by copy_from/to_user().

Add a free_list in iommufd_auto_response_faults(), so the spinlock can
simply fence a fast list_for_each_entry_safe routine.

Provide two deliver list helpers for iommufd_fault_fops_read() to use:
 - Fetch the first iopf_group out of the fault->deliver list
 - Restore an iopf_group back to the head of the fault->deliver list

Lastly, move the mutex closer to the response in the fault structure,
and update its kdoc accordingly.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog:
v4
 * Do not shrink the scope of the mutex
v3
 https://lore.kernel.org/all/20250117020449.40598-1-nicolinc@nvidia.com/
 * Fix iommufd_fault_auto_response_faults() with a free_list
 * Drop unnecessary function change in iommufd_fault_destroy()
v2
 https://lore.kernel.org/all/cover.1736923732.git.nicolinc@nvidia.com/
 * Add "Reviewed-by" from Jason/Kevin/Baolu
 * Move fault->mutex closer to fault->response
 * Fix inversed arguments passing at list_add()
 * Replace "for" loops with simpler "while" loops
 * Update kdoc to reflex all the changes in this version
 * Rename iommufd_fault_deliver_extract to iommufd_fault_deliver_fetch
v1
 https://lore.kernel.org/all/cover.1736894696.git.nicolinc@nvidia.com/

 drivers/iommu/iommufd/fault.c           | 34 ++++++++++++++++---------
 drivers/iommu/iommufd/iommufd_private.h | 29 +++++++++++++++++++--
 2 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 685510224d05..a9160f4443d2 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -103,15 +103,23 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 {
 	struct iommufd_fault *fault = hwpt->fault;
 	struct iopf_group *group, *next;
+	struct list_head free_list;
 	unsigned long index;
 
 	if (!fault)
 		return;
+	INIT_LIST_HEAD(&free_list);
 
 	mutex_lock(&fault->mutex);
+	spin_lock(&fault->lock);
 	list_for_each_entry_safe(group, next, &fault->deliver, node) {
 		if (group->attach_handle != &handle->handle)
 			continue;
+		list_move(&group->node, &free_list);
+	}
+	spin_unlock(&fault->lock);
+
+	list_for_each_entry_safe(group, next, &free_list, node) {
 		list_del(&group->node);
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
@@ -266,17 +274,19 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 		return -ESPIPE;
 
 	mutex_lock(&fault->mutex);
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
 
 		rc = xa_alloc(&fault->response, &group->cookie, group,
 			      xa_limit_32b, GFP_KERNEL);
-		if (rc)
+		if (rc) {
+			iommufd_fault_deliver_restore(fault, group);
 			break;
+		}
 
 		idev = to_iommufd_handle(group->attach_handle)->idev;
 		list_for_each_entry(iopf, &group->faults, list) {
@@ -285,13 +295,12 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 						      group->cookie);
 			if (copy_to_user(buf + done, &data, fault_size)) {
 				xa_erase(&fault->response, group->cookie);
+				iommufd_fault_deliver_restore(fault, group);
 				rc = -EFAULT;
 				break;
 			}
 			done += fault_size;
 		}
-
-		list_del(&group->node);
 	}
 	mutex_unlock(&fault->mutex);
 
@@ -349,10 +358,10 @@ static __poll_t iommufd_fault_fops_poll(struct file *filep,
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
@@ -394,6 +403,7 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	INIT_LIST_HEAD(&fault->deliver);
 	xa_init_flags(&fault->response, XA_FLAGS_ALLOC1);
 	mutex_init(&fault->mutex);
+	spin_lock_init(&fault->lock);
 	init_waitqueue_head(&fault->wait_queue);
 
 	filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
@@ -442,9 +452,9 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 	hwpt = group->attach_handle->domain->fault_data;
 	fault = hwpt->fault;
 
-	mutex_lock(&fault->mutex);
+	spin_lock(&fault->lock);
 	list_add_tail(&group->node, &fault->deliver);
-	mutex_unlock(&fault->mutex);
+	spin_unlock(&fault->lock);
 
 	wake_up_interruptible(&fault->wait_queue);
 
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
-- 
2.34.1

