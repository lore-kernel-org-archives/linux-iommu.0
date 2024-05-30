Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0101761BF
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058913; cv=fail; b=SJDrcME0epoQYndhqv3nGpNupcAzWL2xqDZnt0O6X3lSLuG81cTpdy5mEoNMV6Anxnbl5+bKrUFK9dLobXK6uWkRbHYlNAxcUyAckfydXc4yjCKMGCoMd+ibEFIbeFN/iCc64h1gdM6IYSeCVeZbfhO0kmXYl9LmRAtjwsiKtHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058913; c=relaxed/simple;
	bh=oN2Dh7slYntLDO/z8cEO+7dVSP8LmzpHCOOfpa9qkIs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u6qp4DAMdwXokkq1o9yVgydNMwMesFY/XHTfUI/s7Wb/4D7UTTyciPFoyCkeNwJxkTiyQK3q9yaG1zxZV/ohzpMVP9nSLueZxfEnZPbRW7djMcH26jyrTmB2daKTBC5MDUd3a8qrD0OFjddow5w0x5Kl0BwI12YNguG1tXRhK5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AGPxK1oU; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AGPxK1oU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVJR1/frjOgH7HHtzJCzS6ezxDe2f5qurlltWCUVKwtFYzkmdBgXZIL3gev1RpfZIZQ9CdXjismAutNt6yo/Ew8oyB8MbUKOT6YSSMsjIJCmtpBtweyLNNuEJtxNIx45Rjh83LRKD4xUGQsg0WXQIddNwzDJFZd64sLQThMW4stFahMbtBnc54eYehGyLyrK5jooI4tXka/7mYtladvUIskyT/9Ei6ZsQAgaaRz47W6TEaFcWWKBretPV1pv6+TGH8lH7V08F4pZL/KvSbkbuG6x82gbg6avuMUHw7puDOERLL9SNM+TqNqeHNdHmzEGOaMLQ5BQZBBplKHtGv9GXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sn19PSAUIvu428PRlJeC9CNMUry/lmeIe6iORqHU4So=;
 b=ineuR+b9UYy6D9Vl2F4K4Sy3ekcB6osiU17TbarvEt/nN/NVj93S+mnH575D38WtxylGnp5Ncyw3a6kUA7I65bArbk6ZGekgzPBL2rpqZlAO7wq86614548i/iD9I5aTYgtslUmgKdWpCSDdtyYJidGR52mahv0lW4FuQZwLzDhEFO4LRHHHgaozdfi+xAhQ/m4budBSDU2nC/jFHilfdR7WmsnTCWjESvVl/nQu5QfbSS0GUOuB4QezBb2kLYeWM2csgiCPnWCGrdxFajTeEhecnsagu1tdBOG3tj/00Hduj9NGXjym30620rQGG3w/QYvHlJL+bk93lwsyvQQ7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn19PSAUIvu428PRlJeC9CNMUry/lmeIe6iORqHU4So=;
 b=AGPxK1oURQr8Y6gaI4UOK2XixRzYRIJP8e2Nseb3LYpK/JeA+Jq8VRxebXhNv1pbXyqrI8akucjFXV1amWMTt1xfPa03065yL3L4NFd3bAsdmC6dpAe5hQmtLhPmfeHPQ+wn/bAFav/A1YTgy+Bvs0fOg7o38buYmAY23Wg6fks=
Received: from BN0PR04CA0003.namprd04.prod.outlook.com (2603:10b6:408:ee::8)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 08:48:28 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::1f) by BN0PR04CA0003.outlook.office365.com
 (2603:10b6:408:ee::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Thu, 30 May 2024 08:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 08:48:28 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 03:48:23 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Borislav Petkov <bp@alien8.de>, Mikhail Gavrilov
	<mikhail.v.gavrilov@gmail.com>, Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: [PATCH rc v2] iommu/amd: Fix Invalid wait context issue
Date: Thu, 30 May 2024 08:48:01 +0000
Message-ID: <20240530084801.10758-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: e637390e-1405-48e0-aacd-08dc8085469a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cQuvT35OQz0I7jW/+VDKuUQ/d3qCva7TXt/vgCIBZyGCK5YzZTc0wUX54cKc?=
 =?us-ascii?Q?DmCS4xWfl1ukncm340sBjIPtzgtxQajKjXvNKK9EWwEsjkJOnKQoc4ontEGr?=
 =?us-ascii?Q?EqO24k/xeGU7MgG813181zVyzamQZ6P7CyWGqTqPHgi7Bw27cnkMW7LjmJOJ?=
 =?us-ascii?Q?1zXvKEVf3L9ZQqjfS/CoMdRAgeKf5XUtGeDd5bpNnYc6P2ZHeWmvkDw1jFtO?=
 =?us-ascii?Q?Uh618TMCryd0H3zFJTKsMOTXjgXEu4shMSNPb/smrs4IRWBuYuvj95StsTNY?=
 =?us-ascii?Q?Tw+tZkjcrzP9lmoSqNsvDEoO4LCxdUfIOOXjx3aZLFp7Wog7H2H8MEwGiYdq?=
 =?us-ascii?Q?rp1bXRA0Q3QcrOZL2IP0dOiIiBCZ2kuh53E5+hMgZFoPFssDyWiDQibbApNH?=
 =?us-ascii?Q?Da/bZRzvPGdjpusSAaKk9ow/+vc9QgBUmua+ZU6Q81Mzbva40vh/8dgqb+Vu?=
 =?us-ascii?Q?t2ozY4lg/cISTSNGD184fiej3NJOv7iLtBQEzjfPhhcUJUQXMe1mA64VOeuJ?=
 =?us-ascii?Q?30hguo/0olRjWvIkWM/S4bBKKXi1AFyVA+3El8NM0atpxYTzacLTDezLICu7?=
 =?us-ascii?Q?5gdrEl6jb8CIlehd+JYewly5J7I/RqScPjA8h03aaAneJ7MfZterIeOLkFiA?=
 =?us-ascii?Q?ZywbOVRCxl6MYwzgZQRzSQvU0qebDl37XlrKB4DOuaPZ72W1tdkb1rQYFYLX?=
 =?us-ascii?Q?vClyj+ghhyE2yQVJ8IbgFlbKLCLJ09WENC0brLAHmVRVl7IdsF40Ijp+hWbh?=
 =?us-ascii?Q?++lOqbabUSKKeLWEQNc48I9vmXdWsGAkFDGHGMyV90KqEmt1UxNifhhyYuHG?=
 =?us-ascii?Q?y55uxwdTPj1WX8pM9LzWImDFj66aEE0CkPdN7ad0hMu1Uy3/lQSYBrHCJk5B?=
 =?us-ascii?Q?8v1KIl4xsTH9o5D5bGDhj0HAsZJEcpWr5GDc59jDNKY/mSzTQh2W9jkiGEs0?=
 =?us-ascii?Q?l1lQWlFjscIaiKszrfWWDfOHLc8K43eDTJApFAxJkUcC1aeZbZyf1ile1ptW?=
 =?us-ascii?Q?ACKpQWMiysq+JiqTuSE/9HlM9l8K3GKHe7Xdb1jwHodK4kEC+R/CZlIek0v6?=
 =?us-ascii?Q?5iqFxjn9C9Uha14t+eG5SUpcChxKhYn9h4N5AXhRN7aL7kxhdx7wH3ATqA0p?=
 =?us-ascii?Q?5b2mrBVkKAIEkHwhuQB8ibTm2NfIFIz3UwVev26jEb9NSL9NR9sF/SqXi3FJ?=
 =?us-ascii?Q?CCFyRtUy/m+ROt4Wi8D7Z8S4pegBDWvdjWGHO6gOKKBTG6vSSNAg++Y7O8yF?=
 =?us-ascii?Q?fgV6q3R/LfsajihlpIt9oggQE8hTf991ScH4jWoIZzfX1p7ec08Z+9aGFmRk?=
 =?us-ascii?Q?vf2+tH272lK1MoVCch69/EOAllIdASzIlejBZR11uNBMzgiU3HLMyJWSdXPH?=
 =?us-ascii?Q?7VbtCH0qQc3N+tMMfyHxlsVob6EX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 08:48:28.2846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e637390e-1405-48e0-aacd-08dc8085469a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150

With commit c4cb23111103 ("iommu/amd: Add support for enable/disable IOPF")
we are hitting below issue. This happens because in IOPF enablement path
it holds spin lock with irq disable and then tries to take mutex lock.

dmesg:
-----
[    0.938739] =============================
[    0.938740] [ BUG: Invalid wait context ]
[    0.938742] 6.10.0-rc1+ #1 Not tainted
[    0.938745] -----------------------------
[    0.938746] swapper/0/1 is trying to lock:
[    0.938748] ffffffff8c9f01d8 (&port_lock_key){....}-{3:3}, at: serial8250_console_write+0x78/0x4a0
[    0.938767] other info that might help us debug this:
[    0.938768] context-{5:5}
[    0.938769] 7 locks held by swapper/0/1:
[    0.938772]  #0: ffff888101a91310 (&group->mutex){+.+.}-{4:4}, at: bus_iommu_probe+0x70/0x160
[    0.938790]  #1: ffff888101d1f1b8 (&domain->lock){....}-{3:3}, at: amd_iommu_attach_device+0xa5/0x700
[    0.938799]  #2: ffff888101cc3d18 (&dev_data->lock){....}-{3:3}, at: amd_iommu_attach_device+0xc5/0x700
[    0.938806]  #3: ffff888100052830 (&iommu->lock){....}-{2:2}, at: amd_iommu_iopf_add_device+0x3f/0xa0
[    0.938813]  #4: ffffffff8945a340 (console_lock){+.+.}-{0:0}, at: _printk+0x48/0x50
[    0.938822]  #5: ffffffff8945a390 (console_srcu){....}-{0:0}, at: console_flush_all+0x58/0x4e0
[    0.938867]  #6: ffffffff82459f80 (console_owner){....}-{0:0}, at: console_flush_all+0x1f0/0x4e0
[    0.938872] stack backtrace:
[    0.938874] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc1+ #1
[    0.938877] Hardware name: HP HP EliteBook 745 G3/807E, BIOS N73 Ver. 01.39 04/16/2019

Fix above issue by re-arranging code in attach device path:
  - move device PASID/IOPF enablement outside lock in AMD IOMMU driver.
    This is safe as core layer holds group->mutex lock before calling
    iommu_ops->attach_dev.

Reported-by: Borislav Petkov <bp@alien8.de>
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Fixes: c4cb23111103 ("iommu/amd: Add support for enable/disable IOPF")
Tested-by: Borislav Petkov <bp@alien8.de>
Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
Changes in v2:
  - Dropped patch which was adding mutex lock to deferred attach path
  - Added Tested-by tags

-Vasant

 drivers/iommu/amd/iommu.c | 48 +++++++++++++++++++--------------------
 drivers/iommu/amd/ppr.c   | 22 ++++--------------
 2 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 52d83730a22a..c2703599bb16 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2032,7 +2032,6 @@ static int do_attach(struct iommu_dev_data *dev_data,
 		     struct protection_domain *domain)
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
-	struct pci_dev *pdev;
 	int ret = 0;
 
 	/* Update data structures */
@@ -2047,30 +2046,13 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
-	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
+	/* Setup GCR3 table */
 	if (pdom_is_sva_capable(domain)) {
 		ret = init_gcr3_table(dev_data, domain);
 		if (ret)
 			return ret;
-
-		if (pdev) {
-			pdev_enable_caps(pdev);
-
-			/*
-			 * Device can continue to function even if IOPF
-			 * enablement failed. Hence in error path just
-			 * disable device PRI support.
-			 */
-			if (amd_iommu_iopf_add_device(iommu, dev_data))
-				pdev_disable_cap_pri(pdev);
-		}
-	} else if (pdev) {
-		pdev_enable_cap_ats(pdev);
 	}
 
-	/* Update device table */
-	amd_iommu_dev_update_dte(dev_data, true);
-
 	return ret;
 }
 
@@ -2163,6 +2145,11 @@ static void detach_device(struct device *dev)
 
 	do_detach(dev_data);
 
+out:
+	spin_unlock(&dev_data->lock);
+
+	spin_unlock_irqrestore(&domain->lock, flags);
+
 	/* Remove IOPF handler */
 	if (ppr)
 		amd_iommu_iopf_remove_device(iommu, dev_data);
@@ -2170,10 +2157,6 @@ static void detach_device(struct device *dev)
 	if (dev_is_pci(dev))
 		pdev_disable_caps(to_pci_dev(dev));
 
-out:
-	spin_unlock(&dev_data->lock);
-
-	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
 static struct iommu_device *amd_iommu_probe_device(struct device *dev)
@@ -2485,6 +2468,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
+	struct pci_dev *pdev;
 	int ret;
 
 	/*
@@ -2517,7 +2501,23 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	}
 #endif
 
-	iommu_completion_wait(iommu);
+	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
+	if (pdev && pdom_is_sva_capable(domain)) {
+		pdev_enable_caps(pdev);
+
+		/*
+		 * Device can continue to function even if IOPF
+		 * enablement failed. Hence in error path just
+		 * disable device PRI support.
+		 */
+		if (amd_iommu_iopf_add_device(iommu, dev_data))
+			pdev_disable_cap_pri(pdev);
+	} else if (pdev) {
+		pdev_enable_cap_ats(pdev);
+	}
+
+	/* Update device table */
+	amd_iommu_dev_update_dte(dev_data, true);
 
 	return ret;
 }
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 091423bb8aac..b3b690410f2a 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -249,40 +249,26 @@ void amd_iommu_page_response(struct device *dev, struct iopf_fault *evt,
 int amd_iommu_iopf_add_device(struct amd_iommu *iommu,
 			      struct iommu_dev_data *dev_data)
 {
-	unsigned long flags;
 	int ret = 0;
 
 	if (!dev_data->pri_enabled)
 		return ret;
 
-	raw_spin_lock_irqsave(&iommu->lock, flags);
-
-	if (!iommu->iopf_queue) {
-		ret = -EINVAL;
-		goto out_unlock;
-	}
+	if (!iommu->iopf_queue)
+		return -EINVAL;
 
 	ret = iopf_queue_add_device(iommu->iopf_queue, dev_data->dev);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	dev_data->ppr = true;
-
-out_unlock:
-	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-	return ret;
+	return 0;
 }
 
 /* Its assumed that caller has verified that device was added to iopf queue */
 void amd_iommu_iopf_remove_device(struct amd_iommu *iommu,
 				  struct iommu_dev_data *dev_data)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&iommu->lock, flags);
-
 	iopf_queue_remove_device(iommu->iopf_queue, dev_data->dev);
 	dev_data->ppr = false;
-
-	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 }
-- 
2.31.1

