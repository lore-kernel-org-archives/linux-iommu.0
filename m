Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779896;
	b=yz8/EoQ5N6ixjBfpIbJ2jGVqwoXcRR/KW4QU6L2oUr22ed6Ik4QRTgfzioEKIjrcA05+
	 wvhSLrD5mNvOuApf5qSyJzcDKNpeYcwizgrQIDktDEl3sKjGjWm0uS1aE1Ns4MZ3S2Yr7
	 BXlI4SW3Kz3642ImJpo8jwNxAJ2sfVbqyWOHM1hNxpUHaLDTfkvbFN1gkc/Y7EfU4gJM6
	 U3Bo13YJAUG8uhMw6ELtQrrZyIleP6jn6cKdUcftrZhkkAybdUDcDn82eMEj/rCvG5PV5
	 364Xi0/ZDj0FNB1HeoA3uPEJegAwgg5W/VnRoNfeEvWXZQFs2qi2J/BtgRcNE4bZccw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779896;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=hCQIkBstd30UQ0ujMnhmpvkENPlRonuzTW6kprcwcGY=;
	b=t2DLJQ2mS5j7gFWMVFlTJuiNUGKzpO9xS3uICd166K/e6Xy7yt4Z+1tbTluRs/SHZJql
	 UWsv7IwYGB6BpLXNLn5xF3Xcg4GeNVh8BEKxB6eHH9R5/O9Cer8vFnvWvF8qCO+My5SA3
	 1u2dQjCjf/+K4vqnfV+ppyLG3qLspnhl1BbvdjIjIWk1LMLt36RzR9DqOl7xe/Iy8tAWL
	 kzhdYSCV9Isbhizw+gKBVKL/weyLEzpfmQmHIFX8FjK7Cnebe1Q9H5b+1MtfJCRF+3NcF
	 OBhHNqGCYA0mTlZp78psc71bQ+0keo/BrdgKGTOyuil5D452G57xiqQimi33Acj+R9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WBaF3Nmc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.8
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A76A606A31E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A76A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WBaF3Nmc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYUs9Eqc4W4eXQjilgKSBFQrzni4w4jHSUHhFGRr3n56SiIC+aGyie8eRRfwS9rF6g/4RSmI+X8vLZa1Q8uydvSFf0lU4aSagDBRfOiCrv/UOAh8zSSUStwXW5e9XT08eFHzOgyQfB8eNnQU8f3MYB7YPAdUCy9Qq9dNmBUNKkZrUs3HkNzd/2odv1wH1d8kDXEl03vcaOyYRGYyXtN0SyLw1rZ8HK7FmRMg0BvK5SSQ9cKKVfq+5+B6k0r7a6cbAJuM65/p4udTAllYTcSGr1OyrTKtnm0CzvbAu7Ge6yPNUo2fNeuZg2V9Ksu2n0kTvRZ5oALzvS4EYSZjs7kg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCQIkBstd30UQ0ujMnhmpvkENPlRonuzTW6kprcwcGY=;
 b=LQ6vgY3oir1RTuYhz4IUZ57j5e73VZ3yq9rfTSbVCOvz6o4SvA2zQDGXTdacmtBQqS9wbz0VMDAfml9iLdmINjZoic0CqqLHHW3AMunHtMGjsVCnR1jUrRTA3hjE7aaOyImV98g53xS9khvipl5OkEbX+XGlNhgZUMwx5/g1F4NVl+SkTSMxawX7IdfPiN/Ia+MtpShF57Lod/iEPxDAFfAMlGkvolb2nIvPq9Ks3DQJXfLOX4hg7N67CFAfcV5QSdmQx+n054ERR5goG6wCJLullhzM8veZoXLLzxYCf+b8E8eCOqCoX4XYV/z6xfqf9G5aBrixZSyejC1hZyC0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCQIkBstd30UQ0ujMnhmpvkENPlRonuzTW6kprcwcGY=;
 b=WBaF3NmcquZj62tlBtoVud+e7Tby1HNQYZZygOo40zoc5zqgZWDSfNVhuaIdnmLdCj+l295vzau9sM/8bQaQq9IWa4JqTgpJVbIpA8IsAkLqifCc04NR2w7LUzq2U0XPyoocNZcApD+ZeVxlEMe6FrvjEBNyk0nAReQQqxwNd0o=
Received: from BN0PR04CA0142.namprd04.prod.outlook.com (2603:10b6:408:ed::27)
 by CHBPR12MB971693.namprd12.prod.outlook.com (2603:10b6:610:340::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 11:44:52 +0000
Received: from BN7PEPF0000009C.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::8a) by BN0PR04CA0142.outlook.office365.com
 (2603:10b6:408:ed::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 11:44:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009C.mail.protection.outlook.com (10.167.248.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:44:52 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:44:49 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 0/7] iommu/amd: Improve updates, GCR3 teardown, and completions
Date: Fri, 27 Nov 2026 11:44:28 +0000
Message-ID: <20261127114435.209548-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009C:EE_|CHBPR12MB971693:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1bd872-8409-4f60-7125-08df4c7bd95a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|261009223027099003|261009221227099003|18002099003|3023799007|13003099007|261026140227099003|10067099003|11063799006|56012099006|261102123227099003|261022075727099003|261026121527099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	dsnJRkbhCUo6qb8aZ/iQWQBhozTwYB0IEV7EmhTUM0l6aElDcHl8sKcH2X8+Tx3ep6u37jGVqTeOzrL6u1IPAbuiJLDUapKBIZjnK49+BvLuS5wfl+Wpj8V2qQ1wrql5K/tVAdIy/uWzf45kwyBrR3VQiVVJYx9Kjf9RK/cbRrj2vTegnJ0uEL4XezwvVL1Hi29dMiOvIq0cJBYe3AtPKuTPA56DDQ6hc2Z3tig2CHMyxU62YFITsPy34CI0fp6fCmmDznS0HHNlYFlEv3NQcK3J3gXzFq0/MirDwhqF/L0FGUlpnmZ2a/S5S6Amt+kGoyQvi1AdlxDIY8/4DP5Cl+XMhyzHe4WjAmg8g4PHaixijU+yx5b3BB3ujoPoumjXPOzhV1q+Dql3po4gn1mbHT4hl1EyXLiJ3AUQ5OWQWIRY1V3Wfs5yhvp4udZhtFHV3BcrtDIkMwC5Fg/CAxTbMMGJ8D++b5CW1hFRBdQ7aTCDXB777YP2oq4+RqNK6ZcQTgfDBP6Q4/Gj7qmZoiW39c6hYpR17mIB4XkCXEOMjPZD6gj2CzS35fzQuqze8XG2eXHZfKqK4ysGe81wLIqV8A9athCxcs5kSWbSAsBQmKk/hrsp7dVly7xli3J4B1EoT2TMBbcuzKWaekKxLuvQfvrrl73mwipUfZyMYdGYFLs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(261009223027099003)(261009221227099003)(18002099003)(3023799007)(13003099007)(261026140227099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261022075727099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VbSRw7Ceqch8gaRNr4ggRAKsabpJJoGkHqdPqXPk/GV7xoRHrcZQSaXQIoUAoLAu/BdKX4EyJ2K4D8nqIGxHxKmJtAolSzDVia4Txe6/pM3BdEAqvhTsRq1kwRCYyLnm0Vjg2ZQn9UEPxOalxMG8Wy8o/yfHpW2d9ybpV1/FejujB9CUvWyH0plxx35TRY2eHZh/5Ei06+CkMBwX4zXAQ8qxZuADDj1UMkPtAN5bKksDVuyfQC/V33jyLdHIQSAa5MbjGjI9/DIfCzKjCBdcs0e7RaNhDrLzmlaRD91yEcSy8ggOqlr6S2VlmfSMFH6yV6xxAcEPwM2SNT+fn8xZvm3CIXkv2UAAYr1HSaVwbeSL60sE1qw5sbDTm3bfq38XSR6EyuUwn9Vpho43FjrgJoaNktu8pEhpPKZRDymbQ6VxEy2TgZZrVRQTMOsnEo7t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:44:52.0734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1bd872-8409-4f60-7125-08df4c7bd95a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF0000009C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB971693

Various enhancement to command completion handling, fix page accounting
issue, remove redundant dte flush, etc.

- attach_device() publishes a device on dev_list under the domain lock,
  then writes the DTE after dropping it. change_top() and dirty tracking
  walk that list under the same lock, so the new DTE can store a stale
  page-table root or drop the HDAT bit. detach_device() clears the DTE
  before taking the lock, and a concurrent walk can make the entry valid
  again. Hold the domain lock across both the list update and the DTE
  write. defer_attach and use_vapic are updated only after attach
  succeeds. change_top() no longer repeats the alias clone and DTE flush
  that set_dte_entry() already performs.

- GCR3 intermediate pages were allocated with get_zeroed_page() and
  freed with iommu_free_pages(), so the IOMMU page counters drift on
  teardown. Allocate them with iommu_alloc_pages_node_sz() on the
  IOMMU node. A clear does not allocate a missing intermediate table,
  and a two-level table frees its level-1 pages as well as the leaves.

- iommu_flush_irt_and_complete() reserved a completion-wait sequence
  before the invalidate commands were queued, and dropped it if queueing
  failed. Reserve the sequence only after those commands are queued.

This series is made with the help of AI (Cursor).

Full series including other cleanup is available at :
  https://github.com/AMDESE/linux-iommu/tree/iommu_code_audit_7.4_v1

Changes since v1:
  - Rebased on top of v7.4-rc3
  - Addressed AI review comments


v1: https://lore.kernel.org/linux-iommu/20261105042254.399163-1-vasant.hegde@amd.com/

Vasant Hegde (7):
  iommu/amd: Drop redundant flushes when the page table top changes
  iommu/amd: Fix page-counter drift in multi-level GCR3 table teardown
  iommu/amd: Do not allocate GCR3 tables when clearing a PASID
  iommu/amd: Allocate the completion sequence after queueing commands
  iommu/amd: Free the level-1 tables of a two-level GCR3 table
  iommu/amd: Update device attach state only after a successful attach
  iommu/amd: Write the DTE under the domain lock on attach and detach

 drivers/iommu/amd/iommu.c | 97 ++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 48 deletions(-)

-- 
2.31.1

