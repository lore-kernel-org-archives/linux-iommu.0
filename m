Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793851630;
	b=TwP9sG813avXCRTPg+odtOdyas3FPH+msijTJ6G6HyW5u484nFcUI+6NhQz3kgSHugIq
	 yXs8TA1walSL9/i4ksHpVTyPXlrP68blD9f5oBhus9CwvoYAlYyNbs5c2rpVo74YeeFtJ
	 yeENVDHx2mbnRJuAbaSQK8ZHuVsnVdhwWuKLeOcf3Ic2uls5r8LCMG59620WLKTV8kD8G
	 Gfvz1wQhds+t8rJOT7BFpAHqPke5+Aqc14u9qGxCqi3Olv35w9AasZbsoYEJTrk3RGZaP
	 oZDttYPEuwBxd1DDfF7kmgEBb4yqh/jHzN28RlYglhSAK0sovWVisT+aFyCQGIsisug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851630;
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
	bh=IBt6+br2Viuyzi3zXEX+hk8ZQ549At0nA7KklyVtxyM=;
	b=vIyptXL4dlUG18LMOLWkUI2NI4ZSyKIr7eVB6tlcouanv4epbJMeMlClA4ulsH64CIjF
	 ZcgGhrHqyNhhqz0/ZE+TmIes9UckaPL/C8u/w4tEINcfDm0CfG00DWCUruPzGbMyj/xXG
	 U5h8J5YWQCsIh9ui4U35ir0iFMuAvHsqj8S1YMfI1UfV+qsfOHtiyiGnY1m9qUAAJrKec
	 JumqRCBiu67JSNZjNI1C/J0UhXWQflVRvokKhTdsROUdyxhmt/i8VWf9DqWMj982wWGDA
	 frXTnG6hmuB3YBxT5pQC4N/PzU7z9xABPaJBulobYJ79SViVqL7Crq9FSbJWqq6bWmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=V4eZcOTX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.58
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B9606A329
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D1B9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=V4eZcOTX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PP+uJEl1vo5wY+MJV34N+uj/JWVWGeEkuMSA7Lzke+3r3D54BBHcaNwfDACKvguML6E33vFVYrkljy9wqcnuBKcbYjzhVtFrLk2iEbmdTaNRE09UBt0QLEiyMGLYg1ud+yGvq3SgZadBVsDxb+R5pfZbp+8QbKD9AdmDiyYyW6UGGoIkDWelHPeu6fXWK9XzrKOP+U8Jpon6cRjcocKeynRBl5LSViIUFCvv2OeO8DpRDfCdp3uhylciPJ7tK1rBSrUhg0VEcPo0eFz048NJv/+nxga+vwZto2A4qaK3M9R1s/NL2ToaguXyRFhY6IyL3t7PME0DVFlzUkSV7eWoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBt6+br2Viuyzi3zXEX+hk8ZQ549At0nA7KklyVtxyM=;
 b=BjFYoOdD0vO4cOQMflo/AsEG2N9rHqtlYK0aaOW3tmj8xzVvt7oJPinD8UGNKxdjyka2L87RVtB5XhP+pBdeEJPRv+IfJQnEsj0rEoaF4w21R/byMMexsFYMN3Ig0SScuxHtPqgiS8580AWG3tIt/rkvF9KCb9WwinufreUI/k7b7EOZBp7MZlAHvLNakx1cLBquDCtVKtU2SHodB0EEtLDKGzlTOzzQJz0bcKvkRKTZFg6B8KOMOXeEZP4y4kz3mMKLcRqOhEA2NfnSWJ28fQQVSZxHabmUFRmVMHJlXXpYEUZxOThPNPijC/nR+lxl0iWiUWJjTHVfzkkya24JXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBt6+br2Viuyzi3zXEX+hk8ZQ549At0nA7KklyVtxyM=;
 b=V4eZcOTXMGOKIhjaoe0O+P8vsoBhqQukvK3ZzAA3obZA8BJ8kJ54wgjBUm/vTD8wnN4k/Eiwp8SmzP5eKBHp/91MKTCj8ylD2hQD7KZK32yrVcD4D1BOdAGonKXpvndTItYNe4fTZ7AfYLCFNWlZZpta7uBFCSeCuUTSWa8LU5Y=
Received: from BN9PR03CA0453.namprd03.prod.outlook.com (2603:10b6:408:139::8)
 by PH8PR12MB999298.namprd12.prod.outlook.com (2603:10b6:510:40b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:07:06 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::a4) by BN9PR03CA0453.outlook.office365.com
 (2603:10b6:408:139::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:07:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC0.mail.protection.outlook.com (10.167.248.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:07:05 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:07:03 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 2/3] iommu/amd: Identify a DTE entry by its DeviceID
Date: Thu, 5 Nov 2026 04:06:16 +0000
Message-ID: <20261105040617.398870-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105040617.398870-1-vasant.hegde@amd.com>
References: <20261105040617.398870-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|PH8PR12MB999298:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1c4ec0-2d53-491e-f66b-08df3af2410c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|5023799004|56012099006|261022075727099003|261021121427099003|261022105027099003|261009223027099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZeuJkQ4mn0d9RGCuvmrvpLAcImoqHgxqlNPDo3nE1trP7/2mmAlO5blgSo/CztnFW8mInIMFrdG96CJkz+EoHQfGHaolh25XyfPBaxyfzAjRm7XOqnhZW7gEfAC4SjDt6Gn0rbwWY7Q6c3YgNprQuXnEkKkQ9NMgeKYL7KccEMxjLahBj0kEKc3uL6X6q0CRN1cRPcBTiUn6ljGoeQTdBSvpB51f+GUkPEyD+VK17qv89ZuOZF1ABPNmYZa6LD2Fg2TsFN9Y7EhO7n89zRoDauP8M8M/Cn5osKJG4stpduuDLi8h7FVG/iTeVjZh6i+cwpgEz/AR1uHNpe/OM6uaJ35YCLKbrYQNRdkol+wQnFdq+/ngkE5tCp90Cco3d1jcJ7nUsKae2oCC1xfCGVXvocqzunUYz6p9CJeOln/1i9nkCXFgf0Uqj5rYUrTEHw5nxLPROFBTrbYx+MZrK7qw+5w6JUPlJgycH6iSBTD5gnKPO0r8/INm4B+awG7oyGOMIMSJiWk/WXODXzNjxojhoK013Mzd8Wb5A50wTOitX/d/5X2rWVMi+qM9D1K4XkCOCUK2tGNOPou6LGSUP3zP66gAHczPI3dvOjl6gIMdTIx0ZoX06aaAXptA+hwW3nsY6ofU7CKINA5seQAylU3we8EouNGKqhIdLEfSkT9ahacOZhA8bIa2NvRQiy63xTTaR/Q5PhIWfBbPYrFTSEeClQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(5023799004)(56012099006)(261022075727099003)(261021121427099003)(261022105027099003)(261009223027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rox2ZSbsUoo+K7JAXVpNoHNKkfBoSqmApxmWd+MhPuV/+AoZGn/93X5sosefQxVBsihukfysQEi6ZKJqssiGJxm5uIGjZ//wQLjJs2ScMN6b/KqpqgUxd8hO5+IVltpWVMG64nybYZhp+pOGPD0MAo8A3+A8hN1PohUMlfWQc3yRgnxjW97UTPcuFFf387n9XZOPXVw527AYvnE4KBE1ByYiBFov+1rqqiTrE4jP78WLRscmUA0tlk3bcBWOWuR1GfXmQU2w9+SiE8bmDVveoO2TB2Q+SCc/Um7qoebVWULuVltcb90LJ1Wl47VwqOq9HeoPt9bYQz1WRojOwCkPuc+qBlzK2ptXOCF9Yc79R8EjZvYuh8RcvANPPWTOda2G03/WcNQ9D5YzpFPmkijh/MC0txmd3vrg0zOYkK9XyW0BKrie+uGakRdAwwG3/sa8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:07:05.7317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1c4ec0-2d53-491e-f66b-08df3af2410c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB999298

The DTE accessors update_dte256() and get_dte256() take a struct
iommu_dev_data pointer purely to read ->devid when indexing into the
device table. Now that the DTE lock lives in the per-PCI-segment
structure rather than in iommu_dev_data, nothing in these helpers
needs the dev_data object itself.

A DTE entry is fundamentally identified by its DeviceID, so pass
the DeviceID directly instead of an iommu_dev_data. This removes the
artificial requirement for callers to construct or look up a dev_data
object just to program or read a DTE slot. ex, dump_dte_entry()
no longer has to call find_dev_data() before dumping an entry.

No functional change intended.

Assisted-by: Cursor
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 668d6ec208c4..0720f82dbefe 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -144,12 +144,12 @@ static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_ent
  * This function is used only by code, which updates DMA translation part of the DTE.
  * So, only consider control bits related to DMA when updating the entry.
  */
-static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
+static void update_dte256(struct amd_iommu *iommu, u16 devid,
 			  struct dev_table_entry *new)
 {
 	unsigned long flags;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
-	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
+	struct dev_table_entry *ptr = &dev_table[devid];
 
 	spin_lock_irqsave(&iommu->pci_seg->dte_lock, flags);
 
@@ -157,12 +157,12 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 		/* Existing DTE is not valid. */
 		write_dte_upper128(ptr, new);
 		write_dte_lower128(ptr, new);
-		iommu_flush_dte_sync(iommu, dev_data->devid);
+		iommu_flush_dte_sync(iommu, devid);
 	} else if (!(new->data[0] & DTE_FLAG_V)) {
 		/* Existing DTE is valid. New DTE is not valid.  */
 		write_dte_lower128(ptr, new);
 		write_dte_upper128(ptr, new);
-		iommu_flush_dte_sync(iommu, dev_data->devid);
+		iommu_flush_dte_sync(iommu, devid);
 	} else if (!FIELD_GET(DTE_FLAG_GV, ptr->data[0])) {
 		/*
 		 * Both DTEs are valid.
@@ -170,7 +170,7 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 		 */
 		write_dte_upper128(ptr, new);
 		write_dte_lower128(ptr, new);
-		iommu_flush_dte_sync(iommu, dev_data->devid);
+		iommu_flush_dte_sync(iommu, devid);
 	} else if (!FIELD_GET(DTE_FLAG_GV, new->data[0])) {
 		/*
 		 * Both DTEs are valid.
@@ -179,7 +179,7 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 		 */
 		write_dte_lower128(ptr, new);
 		write_dte_upper128(ptr, new);
-		iommu_flush_dte_sync(iommu, dev_data->devid);
+		iommu_flush_dte_sync(iommu, devid);
 	} else if (FIELD_GET(DTE_GPT_LEVEL_MASK, ptr->data[2]) !=
 		   FIELD_GET(DTE_GPT_LEVEL_MASK, new->data[2])) {
 		/*
@@ -192,12 +192,12 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 
 		/* First disable DTE */
 		write_dte_lower128(ptr, &clear);
-		iommu_flush_dte_sync(iommu, dev_data->devid);
+		iommu_flush_dte_sync(iommu, devid);
 
 		/* Then update DTE */
 		write_dte_upper128(ptr, new);
 		write_dte_lower128(ptr, new);
-		iommu_flush_dte_sync(iommu, dev_data->devid);
+		iommu_flush_dte_sync(iommu, devid);
 	} else {
 		/*
 		 * Both DTEs are valid and have guest page table,
@@ -214,20 +214,20 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 			     struct iommu_dev_data *dev_data,
 			     struct dev_table_entry *new)
 {
-	update_dte256(iommu, dev_data, new);
+	update_dte256(iommu, dev_data->devid, new);
 	clone_aliases(iommu, dev_data->dev);
 	device_flush_dte(dev_data);
 	iommu_completion_wait(iommu);
 }
 
-static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
-		      struct dev_table_entry *dte)
+static void get_dte256(struct amd_iommu *iommu, u16 devid,
+		       struct dev_table_entry *dte)
 {
 	unsigned long flags;
 	struct dev_table_entry *ptr;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
-	ptr = &dev_table[dev_data->devid];
+	ptr = &dev_table[devid];
 
 	spin_lock_irqsave(&iommu->pci_seg->dte_lock, flags);
 	dte->data128[0] = ptr->data128[0];
@@ -430,7 +430,7 @@ static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
 		ret = -EINVAL;
 		goto out;
 	}
-	get_dte256(iommu, dev_data, &new);
+	get_dte256(iommu, dev_data->devid, &new);
 
 	/* Setup alias */
 	alias_data = find_dev_data(iommu, alias);
@@ -439,7 +439,7 @@ static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
 		ret = -EINVAL;
 		goto out;
 	}
-	update_dte256(iommu, alias_data, &new);
+	update_dte256(iommu, alias_data->devid, &new);
 
 	amd_iommu_set_rlookup_table(iommu, alias);
 out:
@@ -744,9 +744,8 @@ static void dump_dte_entry(struct amd_iommu *iommu, u16 devid)
 {
 	int i;
 	struct dev_table_entry dte;
-	struct iommu_dev_data *dev_data = find_dev_data(iommu, devid);
 
-	get_dte256(iommu, dev_data, &dte);
+	get_dte256(iommu, devid, &dte);
 
 	for (i = 0; i < 4; ++i)
 		pr_err("DTE[%d]: %016llx\n", i, dte.data[i]);
-- 
2.31.1

