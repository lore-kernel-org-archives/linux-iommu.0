Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AB11E1E16
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410230; cv=fail; b=uCWVR7AI3Melytqwha6edKfi8ltJkvvsxiufMHD00Sb4LxItrrISSLedIO/slQp8+NsFVrLqw94IO9fBHvppel2wu4C1wYOkuYZUd6VO2j5P9hSe6om9zWZhKv1XO6vjX42Vj0cBOeU/CXHmWBkgSdfQE9N3lqQK2fwPLKXA1/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410230; c=relaxed/simple;
	bh=lpIapICeCUAwsHL9Jok+DYYWiP1wgr/472BTetFhcHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJPZNo3Y17EK7RwmWvOBrmc+D9deRYCMIxHclJHhn/b9SMqOSjkkOdesLMHRIRhONMpUjeod3JWoOxNbT/upOE9V7x69QcVUDMW7LoxMZJLiFhhBJFW6rydPG2UMhgBeVNrANOG3fNA3lvTxyTg4Bwej1Hsh81Bu546O1nC/diY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fAGRTU1j; arc=fail smtp.client-ip=40.93.198.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fAGRTU1j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/8fQLUmxzbZtMGSQ3b0CGlIWWG0eF2vIdWPL8wOOPeJv1yRh7cWBcrHjoxrJ0Bjm5EeshzYVSQJPjwy9Bw4UaABL86SypbLY9ifvryB5dN2KtF7J61eoZtBTPaK7Fzq6FbhTxyx2eH+3cqg2U8BYw/TpmyWnEggtVbZWNAM4SQmSR4ZBNFkk3u8VmhEZdvW24ofTDmUzMy2AeRcn/Zg0LDUzHydP3zGDEyhuMsyzFUaRl802KQxGGMFXnZV3Y0yEonB+ToilOd+Wn+U79Qq5GqFPD0ke9Y4VOUWf09yrYHx10RKUU/NVspj/jCBwAwo1faXFD/91wz8mLdFCgIqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfUrXoe1NConvoBjdPyXyojNhByhj4h7V/o/E7LVQ38=;
 b=ZfgjhSz/DpfDxX8NDOYh9nn+MMJZL5j1PSbEep+uEd7jLYVAWXwDAEfZb3dFBRW0MAiO6AJIL5HC7sv/6hGg+lqnl1m/cDu7/iert/VAz0vON0xZ/mzR9Pj1AFw5ecnJ8OdQ+dynqi8YZh9YrECF6K3oMAF2sJ0rLCCCThmWVrMHuw+DQZv9liQJJBvoNppwr9lZ2YZXzroHc7vOxpKiSygYGNbd7se77cPFML9e0yJ0JV9Bq9Hyb1BpJHF/ACu3WO6/nvk/cMZwScjku0FGjZNgDbRQ7vWy2y7uIyi+VuGVJ57I1v3id0js2ZID2o/B7ro4TIIeqMTgRZ7om0scHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfUrXoe1NConvoBjdPyXyojNhByhj4h7V/o/E7LVQ38=;
 b=fAGRTU1jMC0aBsnX8h5Dszj5kK4SIJRMLeM9nvtbDNOPgHjp6eMYhe+AkFYVfNIFS39NHmVlgbkprtJlN3CC9fRDNWZ48oODsgC5r2TaL3PvqUUoWgV4nJAzLGCRjyTSbpzJhDCF7aeK5wv60uHyKO0hHpXDNMSq7dYq4ekG1r5QE1moa75ZToESP2oCzC/eWb95kA8YrU8tnvsvBm46Ad5iY4cjmARLXCvDCPPfmdYubefFSaZWvegEuzPh4TYOxsu0hpOMqwI08GLq3+EzSZKNpDKT6luPD8KPHsJbrmE2o2bUQ1JBeSiJ7sOcejqFc9Wf+lQyLYXDBBOU8pPkTg==
Received: from PH8PR22CA0016.namprd22.prod.outlook.com (2603:10b6:510:2d1::9)
 by CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Fri, 22 May
 2026 00:37:01 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:2d1:cafe::69) by PH8PR22CA0016.outlook.office365.com
 (2603:10b6:510:2d1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 00:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:36:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 17:36:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 17:36:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 21 May 2026 17:36:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH rc v2 2/4] iommufd: Move vevent memory allocation outside spinlock
Date: Thu, 21 May 2026 17:36:33 -0700
Message-ID: <5ff36b5d80f7f6299f851be532a5195c1d2f1dae.1779408671.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779408671.git.nicolinc@nvidia.com>
References: <cover.1779408671.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: cd687478-c3ab-4491-fdf5-08deb79a3bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KUtISB2XNC3JM70QwbR7PL4gLVbwtqYK+wMtI4+QjWENS2oaRJ5CYOFJvUgekhOfb4B4ynEadfiXW4e/JifIkHcNTH0zVtvP7kI99ESMhAR9Elctc+KBMaZ30P8M4828cap4WPMrIOruZl8grs0K4ISwEp3eUP5IVp85p5m5KD9eT2RlBmr+IIajfhrbXXA1MVwQoEuZIIsfVD+C25k9ayyizFJDt/FVrCJ+r2FbU2iIK6oJTxdeIGYKtaqah7WCu/XbhL0s9a7n8l+EA4aeL9NXfWQkyl4jV7jbyDsfshXtf67jNSiczLFhmvHzrKHa4eNnrZ5nRfG/G+bD4XU4osM7jSFlhftaUfvJ+erR6d6932xJ0NXRykAsrYzy3VSuLMh7XBKYin/MiOTmsFo/o6wJV4BiL4+PORqzBEEnJD+XxbzOfzrFD5wvS2SGGlg+t7pWCr3zchl8ZxI8RiCYAHNUBHg/b7TodnaXq58Yqn7wHne/1j2xsyP5MB+6UcKv5l0Mq5PosDpHI+nWqkdE1HXn880TlX1e1jg3GxUucmr1hSE9y6/0mLd/1xVhYFlhEZ6RkanjUY7ZxBUPOrKBsW53xNqxU5qJFhkxaaC/tuXPkSwGu0WtvgPlZ7l5oSIfUEsYRL6ctabLJzOR1jqXD71g8VNlWxTETGJu74GcdYf8AFtos85UokLoMfZFJNOYU9DpWXDDqkICnxbUew3ar3Ie9OgKtt/4jcYjbeneE0g=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(11063799006)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ivKZD+5cKcuHOHeBB67edg4AO2n/4OnqQzgIVCzg95qnUi9KYwFPEquSoysbOG4Vq7UHTno7jXa8epN8Bg2jsQ3uWaZRCH1jFfBC0JwGP8WMnSnYcIuLFXPTDyifTmazxr6zbLrRiSEqs90VgL7xRKAhkGv6R5yAb/OZj0RRZnBCsIlAFwX0TCILYmQkUC9wku2l8M/gnz8iscIDReASRe5k5KXFT7ZnBRikDGUbwsR3Ze/rsK5piMGADLh5BJadhS6FaCx7BpwRXYHljwGV5VolK2sV5ys62ON4s8V4H8HVIxKmIm0HcHv12o4oXPy4UCeMKbPmZ/Y8Qr5DZ4JYgbsrhQbVk7F1fpqB10t4ijJwEf08AQVtBhm+IL1Vis3vzHk0HFEKzY7cy1g3onTx7/YV4rwIeyUBQZg6sfRqqXOHwe3y3ugFhGkzuiO3Zvc+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:36:59.1039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd687478-c3ab-4491-fdf5-08deb79a3bfb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550

The veventq memory allocation happens inside the spinlock. Given its depth
is decided by the user space, this leaves a vulnerability, where userspace
can allocate large queues to exhaust atomic memory reserves.

Move the allocation outside the spinlock and use GFP_NOWAIT, which can fail
fast under memory pressure without dipping into the GFP_ATOMIC reserves or
direct-reclaiming from the threaded IRQ handler. On allocation failure,
queue the lost_events_header (so userspace learns of the drop) and return
-ENOMEM so the caller learns of the kernel-side memory pressure.

This is intentionally distinct from the queue-overflow path, which also
queues the lost_events_header but returns 0: a full queue is an expected
userspace-pacing condition rather than a kernel error.

A subsequent change will cap the upper bound of the veventq_depth.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/driver.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 61e6b02601d1a..3b8067976eac0 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -149,15 +149,18 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		goto out_unlock_veventqs;
 	}
 
-	spin_lock(&veventq->common.lock);
-	if (veventq->num_events == veventq->depth) {
+	/* Pre-allocate to avoid GFP_ATOMIC; use GFP_NOWAIT to avoid sleeping */
+	vevent = kzalloc_flex(*vevent, event_data, data_len, GFP_NOWAIT);
+	if (!vevent) {
+		spin_lock(&veventq->common.lock);
 		vevent = &veventq->lost_events_header;
+		rc = -ENOMEM;
 		goto out_set_header;
 	}
 
-	vevent = kzalloc_flex(*vevent, event_data, data_len, GFP_ATOMIC);
-	if (!vevent) {
-		rc = -ENOMEM;
+	spin_lock(&veventq->common.lock);
+	if (veventq->num_events == veventq->depth) {
+		kfree(vevent);
 		vevent = &veventq->lost_events_header;
 		goto out_set_header;
 	}
-- 
2.43.0

