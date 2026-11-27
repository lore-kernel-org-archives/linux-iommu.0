Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779633;
	b=wO/3gg048nEFfZLtV4FtpEGJF0YNqp8ckl9pJdMJzqUcUTkjOdFhUOZWoGt0VPVzXXgq
	 GM+P8S6T8VLNMjE2iPqwJFxYIM6mQaKeJromu3i9B9VYX+osrb3ZZ6JyGQf7ac8//eoF2
	 XVKev0vgpiL5DwA6S23HNNw8UxF8u6vI1zNLXYiyS0C23PlccJdHEQBPHikU8/hMfafP0
	 CQzgIzs/OfnyDJWL4bEWTae5WT2EgUe3z4ixJokjTpXjijVkE5stXONv9U5lBHJDppdAr
	 AG5E/xDSwUgeZPR++Pcs2ypnmLfhcCfSSCbFa025yK5JOJgBRH3Xs22Jc1hDSCgvG4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779633;
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
	bh=M4YQr3/nPlVKJicA3r6JKyJHjxQzWv1cSmplMGa05ng=;
	b=k8hx9tgI0WBrnGZVhwJ2N/NL90g1cp/Soq2QTa0BobUy6v1166Kd5MeR7WKINsftioaH
	 mGPgwFw9XSGXkvM2jYmRJfu7mSRME6Sa00fOFV3MaeUHxeQw/FNlLXQMXR3qbRzNp5Rlt
	 NBiN8qkBNKmHdvgeFz/UaTx8bzt9L+sLxFJb6DO63IT0vnjDrIDF/ykfooNwwifuCspTS
	 tVRG9YyCqs970OE8LzXk5lhH7hiRfe29Ydmn3ol4Jhv03wDrCz27UJ5K+88wLxZDj6YxC
	 QgiqFnhf+PfxgIXwdvnJyBDjJee6IgoENeRZbC0TVd+q8i9DZn+pl/X2dJ1c/c7DCKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qOJnjv06;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.20
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C017606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C017606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qOJnjv06
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFY5cG90J45MbLVMH+PPwbuJabuZVcWWKDu+XI1YMP7dECy9oNPcloVo3kmQmBQT7oYJTyzqGywernxR8JbDE4XT5YFXGbD1Chq71SBUUvA4+5B1unocogYw8/PIgsuKnO7SpUu9hg5Bx1wXQtMu8cDqzOIPjMUFmAJFt/yU5J7KAO2H2vtwC0UtlJiur12/DMX6kW+KexK1UTXC/sSaROet9ZnHqJbog5stvZAsqJWY0jFEIJZB07OJFWS288oxxOfj4Tw1u1ATshfnP0DxLcM6cy+/FhUv4EHEqPaH6Pcka4lA6xTmAYIkDdHduKSMO854eepLRWNPXE9glIMqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4YQr3/nPlVKJicA3r6JKyJHjxQzWv1cSmplMGa05ng=;
 b=MgNWKbcYI8pA3YgebCBbOoJ9AC4mI25mv4LeIUmzsAX1JkC4FEdvvNjoWp+kssal7IwALmMMH+6ZbtzoJF8sFKbrXVXxLR0PZ18qMWZ+nQjmty8qiOKPeQdrdJqPw9Bmjbf5ddWz9jk/qwTYqVIe3Q3nt/ce/jfBzk1KRYOqvztPIXtqOEX5QhWJDuWtPJw0kx0dHlXkaNy1QJumJ9lidz8RQ7MXudKf1BsiA9xGNiM9LliDVeN4H/+4+nH7ThXe2l7Agt2Mjq1iuPRto7mSJoQ0Af+qdNSK7cFHaUcVMovEjk33L2VU/47P7Q6tlVy9sxoLgFJ5pGere/t4r2LBCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4YQr3/nPlVKJicA3r6JKyJHjxQzWv1cSmplMGa05ng=;
 b=qOJnjv06laYIONUIHWFlTPxq/bbJp5eXQotnS7++SrwLYFoHCPYaCllcZTJxRuZBwbX5Wnu8+0VXwMbIzpv5y3z3OoZuNbibyyydaocjHFlck+5bHJxMj0BYfcBRs9vF8rvYuU1gTGV6/wKbgV9WVOCQ3uuNInqRat5HYTiNAD0=
Received: from SJ0PR13CA0122.namprd13.prod.outlook.com (2603:10b6:a03:2c6::7)
 by LV1PR12MB365848.namprd12.prod.outlook.com (2603:10b6:408:50d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 11:40:28 +0000
Received: from SJ1PEPF000037B4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::a) by SJ0PR13CA0122.outlook.office365.com
 (2603:10b6:a03:2c6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.6 via Frontend Transport; Fri, 27
 Nov 2026 11:40:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B4.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:40:27 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:40:25 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 RESEND 2/3] iommu/amd: Identify a DTE entry by its DeviceID
Date: Fri, 27 Nov 2026 11:39:33 +0000
Message-ID: <20261127113934.209373-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127113934.209373-1-vasant.hegde@amd.com>
References: <20261127113934.209373-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B4:EE_|LV1PR12MB365848:EE_
X-MS-Office365-Filtering-Correlation-Id: 388bc2cf-d513-496f-d949-08df4c7b3bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261102123227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|5023799004|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	cmNzGtfsZX1KorCB5nXUKBYgsQDAT6zIjf8GcnaCI8vPPEZS47DfEJUaAWu+bB2KucM8VzEaC54K5u4sI57TyMoQZnCvivBf9ZiDxA/AXxmWnprxt6BKeSYieMb3wZxRSEk/Ou6M9Ie5qu9a/1Lq7VjLWRMoT06b+zQSV6oggxLF3QnDAkHWFpr2rdjMz9qbPWl52M9Mut5UVuYTyQa4QRm0niqNqoSje6Q+C9r5pnTTNNU0qOJxw05091+fCOYJgdwYua2ZJqz31vVRreKzOO6zQfEmJsRGKAL3ZYL4oQdgL8kY7UG2v02zIES+ufFo4Mj14zn++g/MGiQrDp+vIsHBIUm7pKw3g1a/K2SQRW6jiXp5lQlGjCf3KeF7rUvZbh6qAuz1NDmVevm/tCgpUCr/8FpwQ2cuwqkhYCdZCoi5X8zepEw9OkrZ2KiZxz5VTw6f3/k/a1djsDautPnsmE0gLqgnDKjKY5Ivama2aOUCpd9qnOM6Fuk04E3OpwTmzyNjrvqYFRYOt+GSgAtIplkyUvcUPwYI8085LGSIh3nt8MiZnSnssDCUquILPGAIGbZnpuFQ6YbfQDb3qG/CDMKM55Vp5BQMxuy4OtatyJaJ/hmuXMW/zCXBjM/Y/KPIh3A2KieTB9V3m6AlG/NFOyJqI51FC2Xx9IW8++/zzLv5sBL0hsNBUKa7JbygSHwLlEbPumyD4TccCP76uadGRg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261102123227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n2LRwjSYPQXtiPbwIINtksNr4fB4fUBUZtl7R0uA+H4mFj5uV11mw5y8CnjZUVLrhd4yaURDAAm/H9wE+zUrOAcKvQNntK3UcGX7zmBzUz/Wqf95MfyJoE187hu4d2O4PbpwJR0nhSlvonMn1IuwQB3zuEypPwuIk4fPhG4x0RVwKB/+4ZdwQVLRHEp5CCLnjacRUkXJEaGptYs7a2ft9Ko0K8RDsyuQvQ+76Y+CfDiZIXFD9MH9POpxeeYvVC+hzmmdfpsExb/1GcLT+X034Rq8A8vBjDPR8KKTSiPPdXhMWCbcGKS0O57RqYj2qhv+WBn+fdqJubF/U85+iGE4bIwscKhQ0zXp17LLy3B4f3hjYpO1GJJEmxeh0vUp88wqa56p96qwsSNzLx0vkUeSy4tWb0oEH97Bw5MyS7E4IBNuUptgpIE4nhBKobG/ulXz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:40:27.5016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 388bc2cf-d513-496f-d949-08df4c7b3bb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB365848

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

Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8beb23e96c8e..a1a07bbd1545 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -145,12 +145,12 @@ static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_ent
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
 
@@ -158,12 +158,12 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
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
@@ -171,7 +171,7 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 		 */
 		write_dte_upper128(ptr, new);
 		write_dte_lower128(ptr, new);
-		iommu_flush_dte_sync(iommu, dev_data->devid);
+		iommu_flush_dte_sync(iommu, devid);
 	} else if (!FIELD_GET(DTE_FLAG_GV, new->data[0])) {
 		/*
 		 * Both DTEs are valid.
@@ -180,7 +180,7 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 		 */
 		write_dte_lower128(ptr, new);
 		write_dte_upper128(ptr, new);
-		iommu_flush_dte_sync(iommu, dev_data->devid);
+		iommu_flush_dte_sync(iommu, devid);
 	} else if (FIELD_GET(DTE_GPT_LEVEL_MASK, ptr->data[2]) !=
 		   FIELD_GET(DTE_GPT_LEVEL_MASK, new->data[2])) {
 		/*
@@ -193,12 +193,12 @@ static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_da
 
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
@@ -215,20 +215,20 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
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
@@ -431,7 +431,7 @@ static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
 		ret = -EINVAL;
 		goto out;
 	}
-	get_dte256(iommu, dev_data, &new);
+	get_dte256(iommu, dev_data->devid, &new);
 
 	/* Setup alias */
 	alias_data = find_dev_data(iommu, alias);
@@ -440,7 +440,7 @@ static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
 		ret = -EINVAL;
 		goto out;
 	}
-	update_dte256(iommu, alias_data, &new);
+	update_dte256(iommu, alias_data->devid, &new);
 
 	amd_iommu_set_rlookup_table(iommu, alias);
 out:
@@ -749,9 +749,8 @@ static void dump_dte_entry(struct amd_iommu *iommu, u16 devid)
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

