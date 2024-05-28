Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E697416D4FF
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914409; cv=fail; b=qmrUxkI9o4MWCNUGuJ1wuCs6z0EyIlHi34gj5RlGdRhSOeDcoOL/OdT9oOL508N5lMjvghlPxxcmL1mGDrFB7d96Dwlb6IUzrt0D4r94qAAEhKxlSjtn9c0r9MIdsecDNah3h6XZ7fODL+iCALoRg4qgr9j1vxgR1XAZcUVAepA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914409; c=relaxed/simple;
	bh=VJRhGDWhAZ/zuFYAyc2dGvCErZnPdX2g4WzcMhFA1Oc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bb07Xi+mtjB7urzeJmsTc0rBC6uwXsoFcvMpX6YUPYOx/eZaiCpVdD9tfuQsrtf/Ih2cXG1YdulPJuUi6R2U4tDIeDJpfajf3ElAZPEJNyhXG5CLuds6//fZjZ+fwpw8ALRYltbz8tRCQIhcBuoqxX9vsGYQhk1djbSmLXCQjEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dnpbt/DV; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dnpbt/DV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1drYtIx0YVp0pAubycvNuyy4CV+vB+FSqp7lTlG/DSMl85FcJAZ+sH6kIh67mp7+G3m17QCvW4gvDyzOW+9K7poF39qFj+rGK6/eo4hQRzUB1CrfVGnq1ZJLvnbRDDjSRuA/JRvcb6QcUzFO8G/I5kQOQzMQIwTTVwELlvyRUmV1AZfmJQYIe1dhBlOb6V6yQ/vesH7dgN5szrvVMeJmwax4155T/p1xEZ2aTh5wdH7Y2k+T/s/GOfB/H7DENIMsQbuf63m8ab/kg5JkwPBf2cQhi2+Uo2AXIyRjb0fMXICmQnXyyGVdyiGEPPczuooI8qSocPDV0VJmBzA61TDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSGGMA2vZzBZSAo2rjJGAiRxcRz0ynsnRpip6bi1Eqc=;
 b=F53vSPJcqi31igao2tkz3tHQcHUHhJ53mquGd4QxBaru6Dqng5E99zXcexB1XkhcS+d0YQpYzAsNQnvA46biuQJV8D/b2Qf2vGuEh9Otlm5bIeRtjdNrMSxLYdhKKPrQobIlkRtCYOk29WwyHftcwNGPslk418oRvZq35ROxjZwVIoYk52VDNv82fIV8ASoD6vYwQGSmpWsfuDdpOViLzViunsqH8VC5A1wezelABkxAexXJrSTyIqPDmAove98szwMIwSa1usk7aJ2oK3nZz6iCRtDII8YPQpgO98YRtlt6ZekqD5CPqWDXf02u5L6/hKebnfptpGpOIuSKdAdnVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSGGMA2vZzBZSAo2rjJGAiRxcRz0ynsnRpip6bi1Eqc=;
 b=dnpbt/DVkiNOSns334/wONx98Uk8dVwYa0eew9iEP2LxUA975dyaA1SAtILcX3qHXMPfdXR6A0Aez2XRYbROaoPKykkeNdX+Ln9j0RJhjRi3QloyK4S32A/0UYuIvCrY8B+DLg3KGlMMjfQACinT/lc6iPD9rxM9/fo7qWIrwJs=
Received: from SA0PR11CA0131.namprd11.prod.outlook.com (2603:10b6:806:131::16)
 by SA1PR12MB6994.namprd12.prod.outlook.com (2603:10b6:806:24d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Tue, 28 May
 2024 16:40:04 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:131:cafe::41) by SA0PR11CA0131.outlook.office365.com
 (2603:10b6:806:131::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Tue, 28 May 2024 16:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 16:40:04 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 11:40:00 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Lianbo Jiang <lijiang@redhat.com>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 1/2] iommu: Take group lock before attaching device in iommu_deferred_attach()
Date: Tue, 28 May 2024 16:39:39 +0000
Message-ID: <20240528163940.48789-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SA1PR12MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b170064-7adb-4337-422d-08dc7f34d37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LSDEz70ntbitb+M42HCZC5TnXdY5/TpUmgdvNJzaOwxClSwpg/FyHA4z1FMD?=
 =?us-ascii?Q?upzgTLJdDdHUqJxpcJ7VSIx6ZIGEbhLmDv/f5jhgRnqcjM9Su9Txwrdfux4W?=
 =?us-ascii?Q?ZmtsjL1K3k9xYLgxXbMRa7LeNJdoI29JBJPvI5vwxckF0DqDZaJVqQZeUD3N?=
 =?us-ascii?Q?8bEVhiNhbz+ivD7HMKDCo9B5+qN6Jt6DQ9zHBSAiqWljbeWrDlyAzVGt+UtA?=
 =?us-ascii?Q?kfDkrhXnjpD4jCSSVpA38psXuBbwBzlJaX/l54zlyMpumQSJIOXwjUGyBO+C?=
 =?us-ascii?Q?RyAyr6xlcdMwI5EL7y/qi53rVjHXMiWXRxX/pTgcjD5y7OZaMe7wBySiHlBZ?=
 =?us-ascii?Q?/kUu/RCW2jSes4aSIPorpLKRMciuDhaYgUnxEisU3c+E0kcHRd7iBZ2sU1z2?=
 =?us-ascii?Q?xw+6jTXIVzBqnuqJ4n81gyQYDZTUhUYtiN/YvW/HVdpnD5Zp+N7pgNCQvmtz?=
 =?us-ascii?Q?3nc8GeqRFioSkOKqWvk9vhhd0Nz5G8SRlAuME1wZJAhakB8eo8sUgT6OqYjw?=
 =?us-ascii?Q?6/eIhFdLH6Wi9pYIJwabx6XiAY/0lDBYkJBX5cUQW+q6or0smuLjHs1tf6DQ?=
 =?us-ascii?Q?xY9dpyKOjKYIixHjDPhVDH6GjiOXwI0rNcbXhNobAIwwmWcEAeRs2z0AFzj+?=
 =?us-ascii?Q?QyVvoB4/sM+2s48WNTT3SdProN6rSOpUcKex4SAfwMqqbi/89wB4bX+q7jS4?=
 =?us-ascii?Q?wcR8A5hE/T+1g4uQr2pPCAX62+ntbL0+206hujpNxWyJ1g2EB612lNTcD73A?=
 =?us-ascii?Q?f3AOlAxlgBPNt0JOn9B/KOoXmpf18F9GVfAYpyE33FQ+0SmgLi8lAzgF8iSg?=
 =?us-ascii?Q?0pe56qOFmE0IEZZpwb4M1TdO+PS8EtX2/geQjAhjV2ZwbMDaFhIHa5qtPLi1?=
 =?us-ascii?Q?4HlN25RZk6yIlujlhjwA9cNhT+iDpyyUhvdhRO+ZIgBXuLiCBny0FJMDlMTC?=
 =?us-ascii?Q?uHaU3oJqOyqv4LMrLt/yU5F2PJxnhxNP0jN44sJX0a+v9rFq/SiAQogOB5vY?=
 =?us-ascii?Q?nwS6tfGytZYh3whjzI6bCJmNcIGpi+YEB+PeEGtbCO0teSoA7tQkmCLeIqBI?=
 =?us-ascii?Q?rrX5nVIbl3t/zrH+k9w6RCTI+Z9rgL7dLFyaMOS+7oFmhVDv76OFlV2Tce+w?=
 =?us-ascii?Q?IgNcTtQwgKpCiHAaq5wiqvEJB2N6UHnzrN6hXqf0bZ9DqDADRKz9lOuyAw/b?=
 =?us-ascii?Q?vcwNWd8TGjEh0ibz3TnuFvg+S+T6Zlr7Nf/xGADH6FOrgZBzcBorU9PoGyiv?=
 =?us-ascii?Q?OhxWIdG8jqAmTAQoPCafv8e4g/mRdLmESmBo2VLs2Ix7vkjbTOf1vLI0bCuM?=
 =?us-ascii?Q?qROQSYICz0/75qEDt653Pa/K0ik9rqo4EM8aqIjfW/0M/tmRYuXUDL14Piif?=
 =?us-ascii?Q?38RAkrzwX3fiXQSSyT79u/t/LohA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 16:40:04.2502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b170064-7adb-4337-422d-08dc7f34d37f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6994

Commit 3ab657291638 ("iommu: use the __iommu_attach_device() directly for deferred attach")
replaced iommu_attach_device() call with __iommu_attach_device(). But
missed to take group lock. Take lock before attaching device to domain.

Fixes: 3ab657291638 ("iommu: use the __iommu_attach_device() directly for deferred attach")
Cc: Lianbo Jiang <lijiang@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/iommu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9df7cc75c1bc..1743dba023b6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2114,10 +2114,19 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
-	if (dev->iommu && dev->iommu->attach_deferred)
-		return __iommu_attach_device(domain, dev);
+	int ret = 0;
+	struct iommu_group *group = dev->iommu_group;
 
-	return 0;
+	if (!group)
+		return -EINVAL;
+
+	if (dev->iommu && dev->iommu->attach_deferred) {
+		mutex_lock(&group->mutex);
+		ret = __iommu_attach_device(domain, dev);
+		mutex_unlock(&group->mutex);
+	}
+
+	return ret;
 }
 
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
-- 
2.31.1

