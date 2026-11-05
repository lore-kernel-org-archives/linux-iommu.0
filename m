Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793854272;
	b=2z2i1iHc5ceZ3cdpFLvZ0ONKM04o5n6rzMQ7dt+DhHqqC0400quE96BnQEd7S83Y4LAb
	 932MZrKSMS6kxZT+POuvK12b0YnWDL1I8tZxnz/8jzQaRanejSomWJ3r3jodhHI2I5Xnk
	 u/rzkZ0vj3D9ttnK5ttxLOXLY1A3Ij3MEOrkgtRVawwuYRdoHtKQ7TFKI6O1411UpcU9t
	 i+Ybs0MgPkTZzmByGE6CpqO9P9dqeIwbNGzBYFO7CNQoYWplVNiGMsNQfnrAZ5G/ilc6u
	 DOFHQU3gh8hkf3/Yzw4A3+PGQJeMNmHDDofubwLMjW3DFjnbJbfBv2qBWo9mhlr1krg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854272;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=MINM3I62gbvJ2yI2HgGSxutSACWZGP11U9vepZDHRQQ=;
	b=jAvxTFROhJxKC+UmFLrVQFosDJFuYWeraykzzPeqk1N9R8cMkYnJah1bjIdzaRj6wJhl
	 jhCnaBZcuYASsisIXRhnv8gLK9BQlbRQ0OtrjS2zh9ePyPbjkJYEkAKkU4tYK6GRi7SmJ
	 D+87F+26MwrQdVrmWyP5SE4ti7exCfRQWXZn3YVll00qmjXQJ2tqrxxt5EWea2Y16LPOe
	 sxbGKyM7Ymkr17wzpIEgJbRsldKL3FAB7RIOBX5XTDpXtvwtrK3K2Il1Nz0DOCLD2/DBi
	 gpMEON+cAdtaKFF6ZvWpKxWSKywCLrDSyiJbjjfgPUJZ21v8CmQOm+/Jd0n/1BriVbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rCSjlpyh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.46
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF63606A328
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFF63606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rCSjlpyh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMgxTR5+nGvBTeI+y87udRWIf8vOe+2VN8G26fPCREECiwjdA7PQX+ABR7SKqBaJxHF1VXjdU1Ulv7o/djr4ZZkzxi+Xs8OoCBeXvOLuRXjTbsXssnByZ1YTvG2b+bHGRbHk+xbG1fIbc8GhiPCBNe3wfvdNsehH9ByKMP+4NbmdRW+SzHbgm6I0wU8vftNzPdvjklaLjA9Bklm8t0Fb4CNFxQLWn1oLAXmLPTI0I1VXO560jUqlhBwt04rOztq3j+3meNyy1iQRe73gHT8GPWB4dLxwRbFekO1803sVJJyLHde8lotoNPnUoD+pusSnmbL1F3WjASaGk8jHceFO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MINM3I62gbvJ2yI2HgGSxutSACWZGP11U9vepZDHRQQ=;
 b=RZwvRTCFqBzCvBeiY3fzVsMAActtCNSxbPhCpBAE56GY5BtUBY8JgKSrTefGdM8K2p7hbek0SfdtkL8u8+EGKxMSHvfpBcFajW7P5S9gUDTmiLO6aygNCYz3zuukdYs6dES1p906Gj932k2wx/K5GvyR+XA+7J94r9L35SswhOoxjXr+6dcWC0wFe6HZ8v3NnL3og/1lgK0qt2dH4E55AbfDvbm+WILw/fPD7kHL5Ct3EyYXvGcxVdPQIkw0jSEp5go7AhB6frrDbYHaI+H8nH7mwvx+t1by/d5QT1IoxC+iVx+TloLp3ULgb6/a6Ec8NB9JPw2bW73wbMXueBOuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MINM3I62gbvJ2yI2HgGSxutSACWZGP11U9vepZDHRQQ=;
 b=rCSjlpyhQkSCkTRdo/5byQSR76ucqcZS1Wmatf/AoQA9NFwxKCoMqta14Mvq3ZQLl7ALCtBtA7Bbpblz/gnewC/LirOv/TLwpScEhaQGYw+tZyFZ9h2GLTS/yY2QfD6PjspvKDTXJVXqWjQ7iOYEq4KV7RbsZbGSsVOuGW17r7U=
Received: from BN1PR12CA0007.namprd12.prod.outlook.com (2603:10b6:408:e1::12)
 by IA3PR12MB373595.namprd12.prod.outlook.com (2603:10b6:208:711::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:51:08 +0000
Received: from BN6PEPF00000073.namprd03.prod.outlook.com
 (2603:10b6:408:e1:cafe::6) by BN1PR12CA0007.outlook.office365.com
 (2603:10b6:408:e1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:51:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000073.mail.protection.outlook.com (10.167.248.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:51:08 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:51:05 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 11/12] iommu/amd: Drain the PPR log before detaching an SVA PASID
Date: Thu, 5 Nov 2026 04:48:00 +0000
Message-ID: <20261105044801.399466-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105044801.399466-1-vasant.hegde@amd.com>
References: <20261105044801.399466-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000073:EE_|IA3PR12MB373595:EE_
X-MS-Office365-Filtering-Correlation-Id: 17687778-ef89-440f-8315-08df3af86814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|22082099003|18002099003|10067099003|11063799006|261026121527099003|261028144727099003|261102123227099003|261026140227099003|261009223027099003|261021123027099003|56012099006|261021121427099003|261022105027099003|260925021911599003|260925021311599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	p5/8wqheqlAlrgmnJwtN2Gv03dX80EXkKMsdklk0TPGyNtmI0lERanZ9AbYzp3F8DJC0pozdFoD6HJ5an4ErElEx3JHXr09CJUYrw3yl/Gqzbafom58kud11ootzHpSwm2PxxJGpX2aLlLiiNvsQ9nWZ3xyB41d415moTxpVnvZJPJChO7ZDFAUNWL0tq5JHpDladt/EVFnq+h6cPh36oPfCdJD5cjJU5ujrrwwX6Tvyu7SjHDynSxWNwfecP8Ghk/u3k7fyIpUkbf6o3Vwvie7n9eJEjPd99F7di+rXLRG/rp/K3I9c9gcSpAnGaX3eADtCW1WmiB4v74q1XX6DbFLGJ+dQuhPqJXIx4eTLVgimvx7iU838ZiJlcXMPbXNF84Fd+yfNRhtHTZ7tEYtsiE09JVR6dUL3djwDUyxcJRNJ73g86uE3v7/TxgnVQ1V4GidjMzTnPTWuYx0ca6vCF+4KOP73j3PmLx0lZQeAmGD2AjOGazcq4bgTeJjuccKS9gaB1nRNXxyVN/0OizM9t4MSy3jDQWElGi+tzO2uBT84GIlOfWoggMn3UULxi6DenObr0Jb/+7iYYlFVYBC5LX8mXGfmdXnjAfYGaOcMcs/WnbDYztgkUBBqPKwBjpwLeo/PxEo6ocXBXSKeXdCIXt4m4HrjdTK2slghBgPr56Jf4DnPRfFBGJ7A1DgT1vpIU3W1vR7+53lPDoc5kdn+bw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(261026121527099003)(261028144727099003)(261102123227099003)(261026140227099003)(261009223027099003)(261021123027099003)(56012099006)(261021121427099003)(261022105027099003)(260925021911599003)(260925021311599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eQIgQsuZLEbAnm3V/zNBTjczjRM7Z18yrnobRqPMnii07gr23Ep6fH43CcTVePQmUSLRn+hEtkfwQis4OftAIlXRBagcfdH8r5ftdhyKVshXzcFDhF2sZWIsZMASHIYNKntXHiPPD3qDd9YlBnZPRgi9WGknuUIM7zcgrEeeCq8dd67zocYh5+fWkynEC3Ss/+rjWv0LK28RzeggeIWg5vtJ1hPah1p93tchIjW3VKyr7bjL9WWGLw4qw7tz7fdA5ehEFxo2YnoUbMuZcqu2lkoU06Z0vOxpvpMItZdLR7Z93+1eSVZ/DxLbW8zPIEaOqLQvycoUG0qTD7Pzq+U/Nq0TeRG8CWdVkemKkfM5VZJ7mEfiEtbhC7HPhWjWJUvl3Crfrggcl74FYCHIkEctnugn0tlAP+GNRp22wyvuJCj5DrfpuhjwRSVdCjf5fcCm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:51:08.1937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17687778-ef89-440f-8315-08df3af86814
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB373595

amd_iommu_remove_dev_pasid() can return while a page request for that
PASID is still sitting in the hardware PPR log. The PPR thread may later
enqueue that request after the core has already freed the PASID attach
handle, and the IOPF worker then dereferences the freed handle -- a
use-after-free.

The device driver issues a PASID stop before unbind, so no new request is
generated for this PASID, but requests already posted remain in the log.
Process those entries and then flush the IOPF workqueue so that queued
work completes before the handle is freed.

Serialize PPR log consumption with a new per-IOMMU mutex (ppr_lock):
factor the existing poll into __amd_iommu_poll_ppr_log() under the lock,
and have both the PPR thread and the drain path take it.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/init.c            |  1 +
 drivers/iommu/amd/pasid.c           | 10 +++++++++-
 drivers/iommu/amd/ppr.c             | 29 ++++++++++++++++++++++++++++-
 5 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index b08df60afd22..6632d4b6ea49 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -84,6 +84,7 @@ int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu);
 void __init amd_iommu_free_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_enable_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_poll_ppr_log(struct amd_iommu *iommu);
+void amd_iommu_drain_ppr_log(struct iommu_dev_data *dev_data);
 int amd_iommu_complete_ppr(struct amd_iommu *iommu, u16 devid, u32 pasid,
 			   int status, int tag, bool gn);
 
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c5e66334117d..1eec495aadd7 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -691,6 +691,8 @@ struct amd_iommu {
 
 	/* Base of the PPR log, if present */
 	u8 *ppr_log;
+	/* Serializes PPR log consumption */
+	struct mutex ppr_lock;
 
 	/* Name for PPR log interrupt */
 	unsigned char ppr_irq_name[16];
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 5d2096910731..823af54ab982 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1914,6 +1914,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	iommu->pci_seg = pci_seg;
 
 	raw_spin_lock_init(&iommu->lock);
+	mutex_init(&iommu->ppr_lock);
 	iommu->cmd_sem_val = 0;
 
 	/* Add IOMMU to internal data structures */
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index 9e1bf3343092..c025ead1c307 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -159,9 +159,10 @@ void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 				struct iommu_domain *domain)
 {
 	struct protection_domain *sva_pdom;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	unsigned long flags;
 
-	if (!is_pasid_valid(dev_iommu_priv_get(dev), pasid))
+	if (!is_pasid_valid(dev_data, pasid))
 		return;
 
 	sva_pdom = to_pdomain(domain);
@@ -172,6 +173,13 @@ void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	remove_pdom_dev_pasid(sva_pdom, dev, pasid);
 
 	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+
+	/*
+	 * Queued faults reference the attach handle, which the caller
+	 * frees once this returns. Consume requests already in the log
+	 * and flush the work they queued.
+	 */
+	amd_iommu_drain_ppr_log(dev_data);
 }
 
 static void iommu_sva_domain_free(struct iommu_domain *domain)
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 795e31735fea..6d4b29905d40 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -203,10 +203,12 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 	pci_dev_put(pdev);
 }
 
-void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
+static void __amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 {
 	u32 head, tail;
 
+	lockdep_assert_held(&iommu->ppr_lock);
+
 	head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 	tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 
@@ -250,6 +252,31 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 	}
 }
 
+void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
+{
+	mutex_lock(&iommu->ppr_lock);
+	__amd_iommu_poll_ppr_log(iommu);
+	mutex_unlock(&iommu->ppr_lock);
+}
+
+/*
+ * Consume PPR requests already logged for this device, then flush the
+ * IOPF work they queued. The caller is releasing a PASID attach handle.
+ */
+void amd_iommu_drain_ppr_log(struct iommu_dev_data *dev_data)
+{
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+
+	if (!iommu->ppr_log || !dev_data->ppr)
+		return;
+
+	mutex_lock(&iommu->ppr_lock);
+	__amd_iommu_poll_ppr_log(iommu);
+	mutex_unlock(&iommu->ppr_lock);
+
+	iopf_queue_flush_dev(dev_data->dev);
+}
+
 /**************************************************************
  *
  * IOPF handling stuff
-- 
2.31.1

