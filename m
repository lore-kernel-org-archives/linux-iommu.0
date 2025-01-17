Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35E62E40E
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 02:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737079639; cv=fail; b=L6bHjfhvy4B7DQtWcvlcci1XgzZVFw8tbMa/jvxMT/mLxBgy7gnmSv7MB/Zwqsl9E87EfFLIe1uKS97uK7JQSQuZctV49Hdz/QXGD3wuSKh9wYEBDfEcGuViTxB5jsxJYC5325gCSPh2X/aL7p0BzSiFjSV0XumUZAoETpfPL4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737079639; c=relaxed/simple;
	bh=i0aDqv5s5afTWV41is6PJUYCW+4BuvHpW5c/jMQrI3k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MbdldxIW88DoUChHxIeOuwUnTFbIQHBpzWL962F9pGSsqbK7ETnPhbvez5jk1tlHy1nbdMPihBt+zUFOkfxCd2aV6Wv8hqMRCu9eiLiBu7KV219TAT4qZT7bXPhwCcKxkQ8Zp4mPIsk4gTsgmtaqD24fwqPgsGIRSKZkOh0I1q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d7sOedJS; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d7sOedJS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNOstXCnSFeXcPwDoc0h1p8rUub4o1r+4i/6FsDVLWG9yA7exd2EiK9Dq4aOMZNg8avsdwcY3OlDkPxHAPh7Nm0TGwE2ISkPu4CZZUDhOJhvCwfKIAsZ9Ls0pnL0IJUSpp17achJTEnFzGVM+pkZXeEue1wWEiJIryTo2zo7HLQxd+hYwST3Bya3Muam9Q47kC671xSJLqssGlM9EFWoU7gxpgrSaLJIIvqB4vibqSYI1cqM68eUksAs2i2fqRcnkRX2MXF4eWJj3K2AQ249ptA2ND/gAmi9/Og6vrNsHiSko1Jwj2PjaH7NwyjPgc0idNN0F77GQq6eZzgIU7AfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smAI0qGexo/gXoOkQwczr3t2isDsh79KLSa+ckoKX+8=;
 b=Ef2xUhjO8CYGmbu62j7J5Xa6XfvjTfY7buVka4uYVQNidWFUpZAootJVc2kI22Sh9QJT8qpP+XZsb59Vr3sSs4kqbrHifZJ/Ffxovrv/JlTZqcPtlzdzIXjvq8gEz3fhr9aU0rEvgEShCTlmU9dBZiY/Ziv3AFkLyM4gCYcZ2Y/C8JjwpiepKf/RS+Wvnh9Iak76a/g5fAqxRqUz7pPSG6K4OVGnBV5XbYurxaup/X1mXs9sl5/D0Xa6kbb1qMG6x8tYVudSafDYtYuJnn8NEuss9279wXxFF4gmhAVp+h1mK/KlLuhL6+SR7Obq6NA+NCmJI9F5To64eUuIwEC/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smAI0qGexo/gXoOkQwczr3t2isDsh79KLSa+ckoKX+8=;
 b=d7sOedJSI7Tnd0IAnSTdSwZ3q6MFcpG2VzxSkNrm9E5Cgrb/tuB69g0YYk10BramW5Yz6ucLGl6J46SYk1cAC2LnhgG687YhYlxccn6y2xnz35F1BjSuTgr3XNGzGCalX4KMmrJC2f+cpOjq7oYSMkGgZChLttzFnjPEbcJxrqNAcWwjSRDmmiQIl/hwK+/k7akAvBruFxwFBjUcCEUfYeE3A86YgaRRlIxcqd9rHdVAOUMlMLx7amwcUzq1LpYkXw/m6jbxnQ7gWseyVUTe/s/jw4HwUsm9LadqdQHJ80UMwE5GKKnOn7GkNonwPjNDWriFw++YfwRx4/JFCWoZHw==
Received: from SJ0PR13CA0014.namprd13.prod.outlook.com (2603:10b6:a03:2c0::19)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 02:07:13 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::3a) by SJ0PR13CA0014.outlook.office365.com
 (2603:10b6:a03:2c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.6 via Frontend Transport; Fri,
 17 Jan 2025 02:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 02:07:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 18:07:02 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 16 Jan 2025 18:07:01 -0800
Received: from Asurada-9440.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 16 Jan 2025 18:06:53 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH rc v3] iommufd/fault: Use a separate spinlock to protect fault->deliver list
Date: Thu, 16 Jan 2025 18:04:49 -0800
Message-ID: <20250117020449.40598-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f4b2a0-21b6-4904-2d4a-08dd369ba896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bEcyCDm9jTCw7KCFA+QulUWPJ2hOz6GnuTq/3kXBee/CgsvX67NQjeVYju+b?=
 =?us-ascii?Q?yVdrb3MCpvhqk2IZSZyw1Nw1QCzogdxx2R1z8N2+42hyuH8IY6n5KZGZKO+T?=
 =?us-ascii?Q?26Y5v2QejxerMGndQzq4t5RlckJMERHSFhl0U5TN3LA5Yo5QsLZzUqffCulT?=
 =?us-ascii?Q?5LAYTRFu47GZe149c+701H2li1P02JfYIJlDklg+M26jg48l9YxNPJsLDGoX?=
 =?us-ascii?Q?k5zj79sgm0EiAsAY5mYXoorLJOk5c7WxmUWx8pIDPOI5LRg1M1KdQ2BB288E?=
 =?us-ascii?Q?0ohyG98z+hdaTiJ3jIjZK2uv7YIRqW5khjBRzvRzQiK+6dUxWvdqeT3YRCvK?=
 =?us-ascii?Q?oT1NCXsZcbpMQWdJsryNoI3zP02gxRfTSmatWXuDwhPV7nDLlOH/nVYp+8xq?=
 =?us-ascii?Q?JuqmPK/JaEEkdu5bsdH76H4HH7xXedhPmhr4bRsW7vQcYiYn1APT/pBTxzpU?=
 =?us-ascii?Q?JGA940trYr90esCL3PkWRptGgVArjz9Sionpfm/vgqOU/00YO/6KZLF/7dr8?=
 =?us-ascii?Q?cj61Ysn0doNTr5UqI1imvEDtKF07Z/ZdlQidPUrbuzFe7AD6MUkQu5gqRyND?=
 =?us-ascii?Q?d0LMzOIsqmvTfCE+iEq5N1uXfWzu/vKk5bK+g/4UWTsMQ2NOq5VE/A+cn/fz?=
 =?us-ascii?Q?qreqI5M8hSn/Pu03jDeGsUdJZtPnlDoohrr3TuuOi0AFiAm5V5cDkgDaFZmf?=
 =?us-ascii?Q?7HIuFfyFeLMH11adG4a36JncxhUaZXQK3TqZeVk/4BD4OrhTPZM5kjiepACn?=
 =?us-ascii?Q?4MRozv0IrRCzj9GGoxA5q/KHi6Y1joeV6qV8klkiOGOHQEOwksEEFzTSAuUU?=
 =?us-ascii?Q?tPEFfteYMHKegF3Y3UbK/QTH3/PXIHx2MjnxTVgZXO8hOCdSOR4PNxY51/w+?=
 =?us-ascii?Q?08MvKsFGt4wCW0eTaZy+Qnn6DMGsy2hqsRV3VzqdGRknedjLWBMdCKa4Ey9v?=
 =?us-ascii?Q?l2/8V46tCE/lNzrUHQigN+iItrPWj4Wa/8SFeKx1fj5g0SH2SJtLfJcMwMWw?=
 =?us-ascii?Q?C6YfSy8Jdj8vpnWaQBTi7Uz9Ht1JK5c2SxO85qJT8QWDEAEwFuoW1bFzpJ5n?=
 =?us-ascii?Q?r8owQUt8J7BcQwLpzlovtUdMbkJdWoNPuFqh4nkGR6n5wKqWLGQtiT8mJt6q?=
 =?us-ascii?Q?Fa3NuagoOawOjMmfsxzV50osJrEej3Y0nELFMNIrBzMI793E51U/w8u/SiL8?=
 =?us-ascii?Q?+IksadnVSY8cCd/1cBf/qGWPG2bD1Ja1qqY9fZhsEZCIkwkGJdhfkx6KjVX3?=
 =?us-ascii?Q?wKyhIHMZnE3d9iHg2VCnmEYcQ4y/ZSs2YepT5o/vScm3FqLfMvy17i/HPLZ2?=
 =?us-ascii?Q?t2i/3NQXgELXz/99wesq0yAJgKvEDpPeF7f2xsEIxDk2jLTZkaUguibd5Tdy?=
 =?us-ascii?Q?JXu68pBtnQjLR+7cgJT3ErX7gu4h+TV19+VNCaaLGNmBqEXvsoh9gLx7LBDD?=
 =?us-ascii?Q?AzoSOCB6q/0b0Jj0n6tJZVFT0nG59+4pfwYAEaoLpLkdOOb8CdbgwuogQ5ZB?=
 =?us-ascii?Q?PRzfKFYHeXkQIx0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 02:07:13.2567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f4b2a0-21b6-4904-2d4a-08dd369ba896
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622

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

Lastly, move the fault->mutex closer to the fault->response and update
its kdoc accordingly.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
Changelog:
v3
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

 drivers/iommu/iommufd/fault.c           | 40 ++++++++++++++++---------
 drivers/iommu/iommufd/iommufd_private.h | 29 ++++++++++++++++--
 2 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 685510224d05..e93a8a5accbc 100644
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
@@ -265,18 +273,21 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
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
@@ -285,15 +296,15 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
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
@@ -349,10 +360,10 @@ static __poll_t iommufd_fault_fops_poll(struct file *filep,
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
@@ -394,6 +405,7 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	INIT_LIST_HEAD(&fault->deliver);
 	xa_init_flags(&fault->response, XA_FLAGS_ALLOC1);
 	mutex_init(&fault->mutex);
+	spin_lock_init(&fault->lock);
 	init_waitqueue_head(&fault->wait_queue);
 
 	filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
@@ -442,9 +454,9 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
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

