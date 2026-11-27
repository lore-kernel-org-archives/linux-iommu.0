Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780733;
	b=rxG13C535zwgzE4WmzwSSixgFlDcnn/eZlDtwYpNpA1FUDeduZTiIfrMaaSPQFgrtxqc
	 VVccmP2Y2xI8crMxIgm/qrIwDIeUYMZkUp55wvCFs0vl2PBaokBv6rQoR8XXI0xF2Kd/N
	 SRr8LH5Uj45xKi/CrcKiGTlRhr09gWRW6P5QaVgjttVXBAbYSYPAzKAt5ljoe/CX3ubpD
	 Bu7C7AXJXGD1gPWDZXWM04jipwLmJLzlowSKBrik1IRxCuPDJ3upKXGEKohihLJyEIQxd
	 YmWSjxD1GD1pY09odPCLpmTbYAXdXOelpQH8BXUqSGqnHlgOcaQiVI3ZflUFZai5vzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780733;
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
	bh=2fg8QV/abeaji7/eKhVWBJIzfYdZlf+DSORsLXMEFXU=;
	b=kl4Y9ulR/M6NIsNH2Nc4Z353HXrTmY2+V6WlfeMULVBmRy9r2P9VFiZ7KKMOHz1t0OsJ
	 8LEOrXze9nET+1diO1s1TtlZuAF3tUUWfIiCrwTJVrD/R28fOj4zZRSvrsO3T6SDlLIn7
	 IuHma5ziLWquvuNvVJn/Slz+NqFuU0vG/dHgp4yF9TB96R7sMr+iplczFy/ucbMxz5LBQ
	 zpsU0Lp1fhrhSNC5uljwDA75h2buaVDyhTFuCy/U8LvYYMwI5QXzMqgH35W3tcLY+SjX9
	 4cE2x04HNoxPaS1zQiIbsEczK9fvTq412ibhq/lN5DxZmGD8Wk6tf3EOLewQFv4s0PA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lrYeZNsA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.60
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013060.outbound.protection.outlook.com [40.93.201.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA1606A326
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05BA1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lrYeZNsA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNdLWHx8auamOuZh/W9pIlpoe6/7qpo3LaqTjwUjTVKI49IKiuNL5nuucNSSC6lZLIQTZxp146QTzqEaRARQp++H5MG1KqJQxjBBueLT/f3b8LzEdEY2sPSV0q6weca1h9GXnauHNI/ZZ71NphHAm4BOkmy99WM3pfhGVjuvvype47YcDDAbnv5ulVmdxTpxgxWd/08bePvrLcPL+13B+ZQGF1eqlpj1zNr0oMvIZXvyjMalgeBz8P/eqsLJe1nBi/Gn1SqsVD0cOo/RXTcOYzJ+hfgkLXJ8pzLTrqjXgXuYIQ3T34sfls/icNG2+5p0N/60+9qGY2jXkvHPbQ6VWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fg8QV/abeaji7/eKhVWBJIzfYdZlf+DSORsLXMEFXU=;
 b=mc2y0o1+CjTGT1SwVdEuECTxmNW+9ftmFNCkmnsXf+tzwYXxU4KRNtEbedIYvSSDt1wpEyTbwtIT9GVu5JUAHBqShGvlM/tnrqTMGFyjqM3LZXmYl9y6A6ZwQbXY310+Z7+kbRXu12QGwyf7WOT7D6D7g75IC+2I3JlfZzABnWTZ1NcSQc8BbSS+Y4FTbvQ2ATZqo9jhE09MXnfgBrb8p/+td+8S+miZTFL6O9JSLuH+gZHsONtahPpncoh7HBdurSmZWHZWMcWR8CmbjuQuFEsbBGiOpt/mURioES477WF/9K5avPd9OdF1BaG29HzKFuyp0/Ufgk+sYbk+yULXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fg8QV/abeaji7/eKhVWBJIzfYdZlf+DSORsLXMEFXU=;
 b=lrYeZNsAhkEvLP7u9hY2hSoeQ7upwOQ7VFxszFrDxY3y93M10Z2hg8o4Hi1OlfOYPYJD3/XgEoPHJJERtXJhB0Ma32RXS9HnHLkX1K2L2AdQnKfYamI5IY8/5qOkmMJ/4iBAewLz/iWk1SD33VFsLWJI4hKPXNs6vq62BotQxe8=
Received: from CYZPR19CA0020.namprd19.prod.outlook.com (2603:10b6:930:8e::12)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 11:58:40 +0000
Received: from CY6PEPF00000049.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::1a) by CYZPR19CA0020.outlook.office365.com
 (2603:10b6:930:8e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 11:58:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000049.mail.protection.outlook.com (10.167.247.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Fri, 27 Nov 2026 11:58:40 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:58:37 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 11/12] iommu/amd: Drain the PPR log before removing a device from the IOPF queue
Date: Fri, 27 Nov 2026 11:54:46 +0000
Message-ID: <20261127115447.209792-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127115447.209792-1-vasant.hegde@amd.com>
References: <20261127115447.209792-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF00000049:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d1d637-7957-4e25-06a4-08df4c7dc70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|261028144727099003|261022105027099003|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261102123227099003|261009223027099003|261026121527099003|261026140227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	V+DNVK1AoEZhzVWwGs2tVJX7HeFzfMQ+IX0muEWl6A8MhtCixf1fdamkSV6saMzZEmOr9aWIVyKZVawaBycDpmoYpdUVuyF13jT64QM3akUdVExdXusMLFslMx0PJHqKxWTvi41GMfXtoE47pN+a3p8ErsGRPAMcd87Q2uOLXQ8vGyGaAYAEbGUla7fuiCd/vAAktx1NeELxSpd16WOG7H28aKOkOGx/r+S6XSYg343bcO6QfqEcPqTLKny+5a7ZAuOkc9TicUtH0q0qYpPuHqA5EMjUoNZiAASmdhl7UaVigOKsfU5UqKMrPl4VuOGoAr0NUo9HheIJvxDVsc5oisFoA3IVjbQwCiNjiswN1xpd8n2PPboclRDVAzfVC/+9rhAxtJCOk+ozkUlcOmBhaqpGcSM5gVWfyWg8DkGhoiKG/ccZyV10n0ZrchGiWE1v2ZQ2hzPVhqMaPjwieS2LqONjA7RJszhsYx63ODgzZv6gtXxCfomiikvjFaTnvdodTbWsgwxtKM1jlRXgCcv3OCym3SLktcJgVcTHHXBDHXXcQc3w0vg3pxPJqh2qJ1OFuWJ5yjxjIMoeROmJc2ko8RjcTq0eeN7sTaT1+pG0LtOtDKAftMp4uMryW7CKdaD4J3Fx0l2bUwbpUsV3FS3sOOfW8+5r98ifTRfk3DAeHvjsW9+nVvMQwxaAqVH/GGSh4KSMLPLFuuWafZMi8aI8Ug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(261028144727099003)(261022105027099003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(261026121527099003)(261026140227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UzGxZBeeVuZ86f7UBrhkQplY9qTQqBidgjvKI6KJUW6uSsjjUEsG1fxky+dlTva8cj7jlp23GToz/ThV/2nwXhXRlxnYlCigZWJfR+o9g9qqoBTo0ZX7DRRP2S4CCklGd4XUDgx6rfcwTPBNjwMkax14Mn8lHrFrKjE1pXnzz99TBJz9oK2sR3DsRf9AXbV7fosltwDmBxQ31hE4ZXqiYpaaFTfbg8nINTS7gESFaM1ENYmM9VtReUd6H7y8lDkDd7lizbo1NsRqiVBBhjHroe64xPgZl/ImYWbhPLYRXSObAFXaS7Zu5fWZxoq0laAUoFmeYla6UPmVzb/6E4KGcqGiw4+j9dW2GKWfcUqBt6JqUYR4jWYC/Y5mop8Z+KavN2HpFVfJ0rWNRykSvV5mFEy8CPyLtDna6lvmwacTtN1uyyppkcyYx0bLbiHAeAjZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:58:40.3231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d1d637-7957-4e25-06a4-08df4c7dc70e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF00000049.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447

detach_device() flushes the software fault queue and removes the
device from the IOPF queue before it clears the DTE. The DTE is what
enables PPR, so the IOMMU can still log a page request after
fault_param is gone. iommu_report_device_fault() warns when it finds
a handler and no fault parameter.

Clear and invalidate the DTE first. A device on the IOPF queue then
drains the PPR log and is removed from the queue. Disable the PCI
capabilities after that, for every device, so PRI stays enabled
until the logged requests have been answered.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4df3f242b364..2ef7233c46c8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2391,25 +2391,25 @@ static void detach_device(struct device *dev)
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

