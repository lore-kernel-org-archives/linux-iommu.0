Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2546172BD1
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914423; cv=fail; b=M7xRkjHHfsgQn7GOOBJc8SHawFdSlIoTeo4a31yjUd8aYH2flaPboutfSyZ/FChzn3dSzMqrtX3ZJFL/zmdZpjZnvZ+UAFyfAwrYke0ZGnrm+37QY97AMh2hBP6GYo7zBWb9/gc1szVIMHT9fLJ3jsFunt+QLVjR0fN5iPBPnDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914423; c=relaxed/simple;
	bh=R+onKSX50BOhyU4hpPG3T5gbjlx3cs2s3YZJQJX4M1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ac1aZvN1LS67LRc9RCP16erLLsha72c8/m2HoG9eIZBDVrlbydOD5EJYG/Ec46G/1ep/4aVdsCuzRSNI6qPCcMLBJb15c638/Fda5iGCegm+jws+bHiR1O0cYGhfTSewmCMTqbU8mmVRByoyslCw8CoCTiUQChkrpvYprB0yQsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FXvrviV1; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FXvrviV1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrRMBTr083UcqTWydx32onbyqREkVSDH3GWYDkASZwsXGDEnJDVqVQH0CVWiIETV7uI2HgUnjsmOdbMyGRhlOG7ob0QeJCDeVQdmZHb0IF0llsg73utLSUAGNq4rB/Iuh4dUpcNV7xr8cKHEhLXxL6E4ZWjSN4bLEbMuNbTrYh6RqTQZbtINOL1SBAdQl+gpsvrrKj/HaacanJgdolC6meJyYL3FcHtWVPX9439mTI9gv4cFYAufj4BAazn5pGsTGpdKLvz9U+d7blSCILTKwaXepzKFEmOPaMhyhMH1UvawGJtVMD1DtQPHEuYhYmfKAZrzB+fmn4YySl4KXiLOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A22bLk71fMVE8rYJsrZnajMR/Sfxr7LqH+SHqLZNSn4=;
 b=mssRNWVfgXEKNbTfi8kwGNqVjZS9ajvu5XoX1Ht5DfRsfZpb++Iy9smQ+mydweHE/qCDCGZROamJ0oJSCHIM6CDWQb04Ouen+dsRny7ibLzWn0V8iygqyMw4LwjPPY1ExospH6ogQOGlkOgacfSdz33gFu8vTpxkR1jt0+J5D+UQRgc9UAYmT87G1NY91spbfikBwSU8gMR4WJ4p3zfiz9Sh0eDxrDeEviT8RRhaUsl75B+V/WYG8wjHorOvyJh/j6KLobBvtKWlUIFen0yIDyhlSEdN1ySZlNv4c3Q1WnNxZpsjRN4PTY8/pB1Tb8TV6KZ0alMJFxwudBAY6vrDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A22bLk71fMVE8rYJsrZnajMR/Sfxr7LqH+SHqLZNSn4=;
 b=FXvrviV1KV/PXLjqyYjjmrM8TI8qSDZsGrascO+mag7RvDfud5VPDGU1Yo8P/CTAZ/cBT123Dw225TwZflulzrko56zBi8idITGYcD0/5d5YaZdWY1iyAO21Cwigc//S8Njgp8evXx+IZ7qYAWIfh4fl/yDCVrp4IJAZXtI3kX0=
Received: from PH8PR22CA0018.namprd22.prod.outlook.com (2603:10b6:510:2d1::24)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 16:40:18 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::36) by PH8PR22CA0018.outlook.office365.com
 (2603:10b6:510:2d1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Tue, 28 May 2024 16:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 16:40:18 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 11:40:15 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Borislav Petkov <bp@alien8.de>, Mikhail Gavrilov
	<mikhail.v.gavrilov@gmail.com>, Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: [PATCH 2/2] iommu/amd: Fix Invalid wait context issue
Date: Tue, 28 May 2024 16:39:40 +0000
Message-ID: <20240528163940.48789-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528163940.48789-1-vasant.hegde@amd.com>
References: <20240528163940.48789-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d9f5f9-2d57-4ec4-1705-08dc7f34dc07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aNhFRwocXvt5JYb9pXnJ+NuzQemq9DRGmnQ6LN1sGIdz3eUlEZLkoQw19e+R?=
 =?us-ascii?Q?NCBz2cGs348kqHbeOef/5hd7R+TUBtWK+rTGq20Gn5LyFGhltatwKv8gle0t?=
 =?us-ascii?Q?vpG7FNUyupKSzqfvj1s+zoQIMLbuBOpEzyYT1aUZsw+MLhbFl7730Vg+XZC1?=
 =?us-ascii?Q?jrgr8dX58ZxxhKZHLMb5fqheqUotnUIXsVWKhOSpfS0VgvxM4dYLhQIIP8gN?=
 =?us-ascii?Q?bZOIQm+mzt8zbHo5howE+g9UB6VGZJDTakkEogMOFN6uWwpiRTs1Xj1+q8DL?=
 =?us-ascii?Q?HNBgJb7esnfy+4JObvmksByBvNsLc3vgvPSeGFJGbB4i+SRHgTU658coPKS8?=
 =?us-ascii?Q?2/Xr3GExVL3arlnBEg8l4nI2R6O7ltlHWD1WGDpLlf8VbMgwY54ZBqJjqMC0?=
 =?us-ascii?Q?xLYplWYcPCOpqA17kCZyVAqrKchGJksYZby07pS9rzR4++hvT8RMXwBQSAc0?=
 =?us-ascii?Q?3rLlt3sm9lvN908PR/AxqUnDjWI9fJixJhtZl6TDy89KeT23MNXB8wcKExO4?=
 =?us-ascii?Q?0ipzBwlhluguVnjDF0/C8ADI47M8+ttQnj9yzack+47ZE5JDHeDmPeQFi7YT?=
 =?us-ascii?Q?mUk8W6izR8dSck0FDdr7WKYvtgL9uNyyCqHBaU+7lTpNS9/ijtBJiMOPY2cI?=
 =?us-ascii?Q?Bk3m9HS5/yFHtsDyrrOqumUjHIx0TK7j+dCrG/ShloUSdWpY8Bnn1TxKg4tJ?=
 =?us-ascii?Q?Ngg/J4zaxtMIzbw7M5fgIj/k8aeqtbR3MfIp4If47UrA0QNkVwQCEeF5Khqv?=
 =?us-ascii?Q?2Vino93wBxz5WMOmq9QwbPf7knG2fGLyGIpf0Xg8HER2k28hoqCmFdEc7YUV?=
 =?us-ascii?Q?V+Em0pKPfn8Fx8pGzYrcijZoSCdKiIMvPA0ttEXDeI5NbfRCzNVrWYQ5c9NW?=
 =?us-ascii?Q?a5IvHk+azNKCzvV/SEFH5BPKSHqIXZwBDETMC+zWKvwUL0vIxXuPVJFCEZQG?=
 =?us-ascii?Q?PuSpp8OyjEbQFoJffY8qwuLliT+tDcAbeQh0aMwrixIZymcPXUak23ltylDr?=
 =?us-ascii?Q?md6rvmdmT3EXgPaHaA0uixHLC5xnYgrkCwPxXZ0TlERtySQ5vsjW//Yzngk4?=
 =?us-ascii?Q?HiYif8C+yMwj6YOqNnLZHDxaodkwMAdyNyMXPd1Rmrgv/cpMmDLfmE5/RwAa?=
 =?us-ascii?Q?AxvRrlVAEtsOJncPzvMwY1Uep0YXgpy14Y28K0VUyiomaYRcTGJmGQihduN1?=
 =?us-ascii?Q?swuXlhDQY4zFH8aeMxg+JwNH8RxZns//dRItKtCSoc0msa6cjXv7GAIuXLU4?=
 =?us-ascii?Q?H4PuWtmrO28RIg0qUsINu0Jjdgazlm3a+9YL/97O4bRRuAoUJa4b5p4yqgLI?=
 =?us-ascii?Q?ox/A7qwRnts8/I09kgXGiyvCz3qqoRr2JFlHXeBE+1+JbkSYVJ0GIWQIrQpL?=
 =?us-ascii?Q?TmTcvh84AnN7ogPYh4Ez0LSay/d7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 16:40:18.4840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d9f5f9-2d57-4ec4-1705-08dc7f34dc07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810

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
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
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

