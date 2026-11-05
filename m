Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793854535;
	b=XNeTK0Lub1K1hZSVTMyKKoCxHSTysuSUbixHCSFB9WD3WuG0hoFlQYd+XTh5Ru+KBqJP
	 bDnqRiUTj1FkXZy4qu+uazMAn6d5P/DjVLqmYwG5cWveL0cY4Nc51T3+IlX0lmC5Kcaom
	 9OHhOggq4ZmpPvQ8gEu2uDUWKroNg4+1jzP+mQzkBQ6yZQmVjVnuM6d3pqlHdv4fMFs2c
	 /iTE/w2Qj8dHQO9RB8u9/PvDShhj5yDeh1C4jgS4EtxaPLGQOJUhIItcEb2xh1Q4oC/q3
	 jnwjRR1TiKPqhHGFfv1NEWEwj9n/gN9ojvBJu2JdQU/RHfX6UlLqudcjLtnDC/v87NQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854535;
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
	bh=atHOi52IHl34610mBWXg8PudsIDahL9bdk0UItircRw=;
	b=2lhrsO4q7xNIBUGzoGdGAvVfLgIEFh70qB+wYzYX/piLKMk/HFu08LptH8INM6fOKefv
	 kSl3JTmISR7DBaWsiN4MSmVL1pZGLbS0KrsLhehPi6udQeflbLrBY/d0dXDiF2/HkK+nU
	 VVuWfr83fRnZg1PVeYTtrALU3US7HZdSrOvWfSBe7uRCS8Q9s3FWZQv0QBBsZ6Prssg7a
	 S7mnZo+ISqsZRYTAopTj5hGCYijmR0uTb+XAqkISFeDdtfrRdOwsQzDSXGV+/BzuuUKY8
	 Qmc5YEP1pOiH01E8VI3O/JxtUSdyLLfJK9eak4py9ZOwEv8JDGRI5PWfPOtmO9Kv9sA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0VTdqQe5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.67
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211A6606A32D
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 211A6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0VTdqQe5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqSiOqgWxcbChwUOr7dehi5P5gd26Vnw7vaQoZsYp2hqZSipXor7F7wjUyRYt2tgqeqUofievGUUD+I5BLS6STuZKIBkBswFRF2kZ57rNFDyQqaUQpYYAWoT8qSOyS6Ix72jbBMFxP9oWAzGApKlGcuvQcaMTJq5KBNQIWkeQbEtFdSk9vh3BIvV3YT2mXUduSNHAn7MC4h4aBMeyXS8EN8wyMQWSESa5e/hUIe/aLJdTrJxruT4xiT2h56ALVmJl6CV+PJhT57WnpdcWQ+/f4u739pxnett8Kn3d/TOYj+OkZFTtVBaGWuHuCv65eAnxEQFsWURMbJshz30DuA26A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atHOi52IHl34610mBWXg8PudsIDahL9bdk0UItircRw=;
 b=g/ImDf8HeANt43VV2M8hGEybekoV1ncuwQMWjdY0sJ8ih7FxFcZSlwKep4A7b9EbfcG494jkXPiicYdsaDbEgOPKJsVhd/saOZTfe7ygYkzhSjltEcCbgmMIXglD4HR/CMxgUmc5BGujenp5yzhVcyqbR3r5EqdnF5cjD9Cztdhn10uNZr2icdUAyLLQicGPH8wEute0tnrLmX6DY2bKf7ciEqvPgw4cWz42VXzoZ3DtV/w38F2wuLkSwAm3etFS8VzZ6EsI167PtQwzsWG+MSbawYkOPd5gBEKbl1JgvDq6DCbqqBSZ6iYVV8JkeIr6ur3Iret8k/Sg4rWTVfgm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atHOi52IHl34610mBWXg8PudsIDahL9bdk0UItircRw=;
 b=0VTdqQe5TzSskdFk7bzIOOyPupZBX6mWvlkKxE04GqaQNytCCm/cWBZSfcogwlra7gNbegmteysBXnubFAX5fEJP15jdp8AQgHKEE4kgiPbmodR0T/FvSkUaIUgXfBKsGqQzlqVifZpm1NneslTrzVGJpKh/i1JN7Ey7iAjPf8c=
Received: from BN9PR03CA0846.namprd03.prod.outlook.com (2603:10b6:408:13d::11)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 04:51:24 +0000
Received: from BN6PEPF00000075.namprd03.prod.outlook.com
 (2603:10b6:408:13d:cafe::8c) by BN9PR03CA0846.outlook.office365.com
 (2603:10b6:408:13d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:51:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000075.mail.protection.outlook.com (10.167.248.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:51:23 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:51:20 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 12/12] iommu/amd: Drain the PPR log before removing a device from the IOPF queue
Date: Thu, 5 Nov 2026 04:48:01 +0000
Message-ID: <20261105044801.399466-13-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN6PEPF00000075:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d28431-b055-4eca-f391-08df3af8711d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	xZUnz0gK2gGXqqM6SrYM1+WWrHL71PduR5o3+dxuZ1laeAHwOeqtL2Rbs67QslxsDgDbnlzzISSWQAMNoaNfXh2aPeukbrrypGkeT3xsweu7Zk0BBSvqJHKgJkMmWh2yDfF8+u+qaAmdLe0pqsy4mRzu+5jMXj9Twm5yJFcl31j3jA/0GHCf0iwR4aCryq8h0fgo9VwWVcfz7rJa8nWx+fDQh2yHhqnbvDDlhpT7dj7TmF9U+bJTLhXuLbir4UyOoJyP5u4Qo23taeMdHP4p13REwYcw6wtxFRIxOZZmVf3vEl/VqRj6UUEo25Q19n56Vv+Tnuz8qYH7wCWq7mz58jqV1hf20ggz0YmjxahMaNnqB9PdQN/8FNLmbwu/tHJdIBQBi10QRaYRftOAA59v9WEbtWeAgKOSlzpGIjJkGaRbKj1Gx8rDtW8FnBh1pdzcCd/wtcFKrmuPp9T+EnxJV29SBjRiFQswPcdqF6BUu8vg+eh9+VPsys2ZYfZYaKDVYcMzKAcLQ6GjKfvEBNYC35U0n/+mSuwe5wdYEVXl+/Mm3mtQIUWW8f2WXciuE1fQk0mZ+LnlQNxSEJELRnrKBbapWHZjnP70HzsGfq+wn6y2SF7Qhani+2LJbXvo/OtN8CPjj/tSeRoCZmK/YLjDiWnu/P6j9jeap7ThKP5J3AmRIcaeRXw4EaPoU73x7lbrCZCGm9b9DpapDcIcvWYvMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DEaxCM3pLntnlhHYAui06ZolOPvxift7PDNW6sImMc1YUw7FLR8WimYMO+BQFiajR3e8NAHRGM41rFI2/d7H43JbfZLSFzfjtPHtc1+DV5X1T3OWVWKIbHp9SuoUS6fyFYxSsou42aT7gHDTPMIYL4CBMhrI/5A0IXJXLVtj3QeQloXory+MUbemvkKGK8oLKB72PYLTp6eMW0MEBLDgAAGtozOWPXALAKMleOdzKnOLpssu+wpPajatvdFR5Yi2uafP1qVUWJuCPtSFbZiktOCZAfU3ERlFKeZ5vpnjyOY9NF8PXcVjkz/rPla6deRzihGEYYZTd8uBNvSpR2/C2zca88u5KeTNnv7NjWgX34N3sTLwfPpRSEvsuPKanEaDO+qO9kqOmWpcEd2IDjcCEznfm+r+ed+8vyNYvbjCojOM0sTYdsIYq1HIeACTNZSM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:51:23.3546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d28431-b055-4eca-f391-08df3af8711d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000075.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720

detach_device() flushes the software fault queue and removes the
device from the IOPF queue before it clears the DTE. The DTE is what
enables PPR, so the IOMMU can still log a page request after
fault_param is gone. iommu_report_device_fault() warns when it finds
a handler and no fault parameter.

Clear and invalidate the DTE first. A device on the IOPF queue then
drains the PPR log and is removed from the queue. Disable the PCI
capabilities after that, for every device, so PRI stays enabled
until the logged requests have been answered.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8750ac32f382..df37b4bfd15c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2400,25 +2400,25 @@ static void detach_device(struct device *dev)
 	if (WARN_ON(!dev_data->domain))
 		goto out;
 
-	/* Remove IOPF handler */
+	/* Clear DTE and flush the entry */
+	spin_lock_irqsave(&domain->lock, flags);
+	dev_update_dte(dev_data, false);
+	amd_iommu_domain_flush_all(domain);
+	list_del(&dev_data->list);
+	spin_unlock_irqrestore(&domain->lock, flags);
+
+	/*
+	 * Stop new page requests, then finish the ones already logged.
+	 * Disable the PCI capabilities only after that, for every device.
+	 */
 	if (dev_data->ppr) {
-		iopf_queue_flush_dev(dev);
+		amd_iommu_drain_ppr_log(dev_data);
 		amd_iommu_iopf_remove_device(iommu, dev_data);
 	}
 
 	if (dev_is_pci(dev))
 		pdev_disable_caps(to_pci_dev(dev));
 
-	spin_lock_irqsave(&domain->lock, flags);
-
-	/* Clear DTE and flush the entry */
-	dev_update_dte(dev_data, false);
-
-	/* Flush IOTLB and wait for the flushes to finish */
-	amd_iommu_domain_flush_all(domain);
-	list_del(&dev_data->list);
-	spin_unlock_irqrestore(&domain->lock, flags);
-
 	/*
 	 * GCR3[0] belongs to the paging domain w/ v2 page table.
 	 * A device without PASID has no other entries, so the
-- 
2.31.1

