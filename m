Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795781065;
	b=q820J1e0fUKd1cm1hJCDWNIwtY2t0Mto3t6CbMjfztDoiXJ8eOrPr0bl6fS1qb49O4sK
	 0fIUku0vry1v7hwto5HziiAC6a1AnJRii5GlpfoFGSVA96PBa/fzuzwzztg6vc7UQv2h3
	 fnV/rdlfuyJmmQmMoMoA6bQrYGk9pcxdZv7nGlH6eoYaLzPAhma2Agp2ziAHpYV2uOJKd
	 QS1vHVZUh1OZHL2t2wpzzlOzDszUSTg/DlIjiQdjWdpppHTXDtlLa7zch4qDGzbYwpoJ+
	 85JxpK3KwdhlbU9CYN4Rm4ZzzNReHm36Ck0EADMwnuBuCjIdnAjea+QRIm/HpV38b8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781065;
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
	bh=cR0qSl5NIRX4SpMB6edE3LUkhjY7cKTTKtxP0wCbwLo=;
	b=krlbFQK75zgzKx7Z9h7u6xaGvznUfzFpDj1vo7tPvZhDgYllsWJ+mzXYYyH9+AUpBExo
	 ZDRzJGmU9hwhd44NndJ8tZfPpFyLM+4lo2pCWKVhtqXTAf1DBrXShTYiuYFmmZesKnUzo
	 h5El75Rl4IrPhDK+Im3wtNp/F0PQtWcrCcVhueM8/ur1AlF/T2hgx9S6LmAZcWAC8q0CB
	 PoET7WO7tNLXOc0Lo9MUPT3v30/G5gwHumuOLra5JW3+fu6Pa6CH3NMMywnRrxH83Xgeb
	 5PrfeJV6d8EVhiBTe1INRynCVHqwLhOnopso0SYCjDyix1HBrIhiTvK8GswaCcnO2Dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AionSqy0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.16
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F57606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 12:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F57606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AionSqy0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQ/eld1qGIC5kACbS7NXiZeZwrq7EHn1k9ZHm10AjtUzsdwnWTMa2Jeqvf6qtBFzgPrt4lyhhU0QAEyhPXnBZzrHbWURtrxPtPqoRHAl3j4TFjBMOx/OX19Qoop4mPx52IjcgOmldG1Kz2aEdxZ/yiGRA1iVH3i80/S7RdSnYMCoNNH3GEW8JR+P5TDTz9u84aBdMNAcp7SqtOWqpfMIARSqCCrplEmtQ6ztT2wcq2dIdzD6SaR+DpS4tFmQ1Cmuvvjiqs6VMeFGhVVovt+indQmrUxEYsYoJgDObw1T92KMdag9jk1KMvox/zYpqWXY5q11VGA//TvCPl/upczV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cR0qSl5NIRX4SpMB6edE3LUkhjY7cKTTKtxP0wCbwLo=;
 b=KumLPHcUPhWQz/HnO21Bz00uyMLXVDyjlfb6aeckSEzBbIp8XksKrJ0dhfnTnScreMvo9n6VI1KZ7Q2lQW6chRRlBvo4DYESL21F6Yus8081X1hTtefBIpzCRS0gQIJzOCQz8jjjAkTanCkRWCps3x984aVQVxaDxYxFMcU/wIdbNFHdJ0/LTNjLx9zwQA0UJmgLat/x6KyXhEWFLdjf8TmRnwZWZZZjkSC4sTEnDoYL/PZlww3Qqqf4BuTzBRd2kazStaVZcNcK0tqurK8mRmz+8oEPG/0MvWDHhraEVtN7LOPymwFYDTfGmhayV6bbx1KRjb+sN2P719OM11yqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR0qSl5NIRX4SpMB6edE3LUkhjY7cKTTKtxP0wCbwLo=;
 b=AionSqy0bNGd1isQ2oXef9FVnDonjIeAWhD//UM0iWtLQiFOkC/xjQV5knnYiHLci46iFe9a4XhCa0z5Z2MBXqexPXdqMe9gJKGzTNHyxC2qClzTKCpEZzBzDbcsb+5eYre+fctlQeoZ8+I8Ez3OEw3mFWHVcRV3oLqm6A1P6Pc=
Received: from MW4PR03CA0141.namprd03.prod.outlook.com (2603:10b6:303:8c::26)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 11:56:34 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::8) by MW4PR03CA0141.outlook.office365.com
 (2603:10b6:303:8c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 11:56:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:56:33 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:56:31 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 03/12] iommu/amd: Complete a PPR from a device the IOMMU did not probe
Date: Fri, 27 Nov 2026 11:54:38 +0000
Message-ID: <20261127115447.209792-4-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: df23dc18-4e69-42bc-4e4c-08df4c7d7bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|56012099006|260925021911599003|260925021311599003|260925022911599003|261028144727099003|261102123227099003|261022113327099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261009223027099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
 xkUZGQTmqik3WrRBFcot/HiL4eFUyR2tp54n5Mvio2z3vgtSmmyIMGzYcdduzjG0O5/EzI+Wx/1t6l03g5HYMqfKr5bbxVcqNR0dDWbIvsdU5rILcuFH8HBMaNHweFSeWmsdPmT8SfCxwZYi50Zg21DbyODQdB/420GE1sHe8EtqhRxdQKMwuThJed/5c6F7D3Is/Mg7i1srm//wYbe5jvu68PVdjDEW5ov2wQ3eSxJLwBxXiuiafUognsdKUGIjrJ+JiJZ5cqgI4VgsgRZ0gFdUE5XQ/KckIKkYqZoVUpSSr79UazUbMGPkaAKApmxmIpC9LUNYE2/Y/DWV7moKWR2ZToC9aTXTQgqKGzEhfornY0BtkeJp9Ci075npoEF8BprG+d7gmdXfBI+ZjKDQchUDDo0lBUHB16N2QHA9v66BMWj3XSiWRmYBbC3CqBlw0zubw6oIpGhGyMMxe90g1PE9yFmgYfzToK0gZb4tk+Mi2HgIeBYIoOxANE1apVgA0LJinyR3iwiF1+Ni6aFNH9Jvvs6Q6myy1tf3MwyVk2DeHYMFtRol9VuIf1FDT1omanE8bJCNUsWE7nBxBj4YffWd+7/LPm/U7ju67u3wfGeITaCZOwQBg65asLVUF/Px8oAF/jl8DVcUk6EvOJsLZIFwkHnUpvqzv4Sz6C10rejAIZRnLwqr83k8IcGQbUT/eakThupA8LEQSEz22Us/PQ==
X-Forefront-Antispam-Report:
 CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003)(261028144727099003)(261102123227099003)(261022113327099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 Pj1Jw3LUsIeu/p4zag2HTUT4pkm38ctJqrtbkyG4rLsBRVeqQNhPdbwgdgfkMpesCkT7gvb7mU9dLNhVJCQ3lYaTFCiE4ZilrhhL/Wl93JOjyDMu2bOP0cgzChZlotjC0aR08+FBMt2bmQcNXtOwNAvVrrf35PyQexs6bYHzI5s6y7rfqj80Nzs3MrLsf2SH1Do9geIN0mCZNwnlp6sI9w5Cik09TXST1o06mzT8IX6XhGDgGEglmv43MAheHOCF+wIujYaQQSFB/oogq/xLLQtBZJeUxWQHKsaVN1HuOl+t5k4EonGdFfZQ2thx6BIRhknPOjThdEXhb+Evj9qBSup1iwL167xAavty4SPq0gr2TTTsMaS+Yp+LT8zkxCT6RPFMh3Z/6+r4zQo9CDk8igfl/nKLOQ95SJB1KgNhgMKPT7dOVdlYqddJE+//srzP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:56:33.9971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df23dc18-4e69-42bc-4e4c-08df4c7d7bc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
 SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090

iommu_call_iopf_notifier() reads dev_data->max_pasids after looking
up the PCI device. dev_iommu_priv_get() is NULL when probe failed,
and the abort path then calls amd_iommu_complete_ppr(), which reads
dev_data->devid and the device's IOMMU. A kdump kernel reuses the
previous device table, so a device that failed probe can still have
PPR set. The invalid-PPR event path has the same dependency.

COMPLETE_PPR needs the IOMMU that owns the log and the DeviceID from
the entry. amd_iommu_complete_ppr() takes those directly. Report the
fault only when the device was probed. Otherwise complete the last
page of the group from that DeviceID. The invalid-PPR event path
completes the same way and no longer looks the device up.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  4 ++--
 drivers/iommu/amd/iommu.c     | 27 +++++----------------------
 drivers/iommu/amd/ppr.c       | 27 +++++++++++++++++++++++----
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 0b79f44b6744..c6adaae048b5 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -82,8 +82,8 @@ int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu);
 void __init amd_iommu_free_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_enable_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_poll_ppr_log(struct amd_iommu *iommu);
-int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag,
-			   bool gn);
+int amd_iommu_complete_ppr(struct amd_iommu *iommu, u16 devid, u32 pasid,
+			   int status, int tag, bool gn);
 
 /*
  * This function flushes all internal caches of
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1220891e3d90..0a1722110934 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -877,7 +877,6 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *event,
 				     u16 devid, u64 address, int flags)
 {
-	struct pci_dev *pdev;
 	struct device *dev = iommu->iommu.dev;
 	u32 pasid = PPR_PASID(*((u64 *)event));
 	int tag = event[1] & 0x03FF;
@@ -892,20 +891,9 @@ static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *even
 	if (flags & EVENT_FLAG_PPR_RX)
 		return;
 
-	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
-					   devid & 0xff);
-	if (!pdev)
-		return;
-
-	if (!dev_iommu_priv_get(&pdev->dev)) {
-		pci_dev_put(pdev);
-		return;
-	}
-
 	gn = (flags & EVENT_FLAG_PPR_GN);
-
-	amd_iommu_complete_ppr(&pdev->dev, pasid, IOMMU_PAGE_RESP_FAILURE, tag, gn);
-	pci_dev_put(pdev);
+	amd_iommu_complete_ppr(iommu, devid, pasid, IOMMU_PAGE_RESP_FAILURE,
+			       tag, gn);
 }
 
 static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
@@ -1850,17 +1838,12 @@ static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
 	amd_iommu_dev_flush_pasid_pages(dev_data, pasid, 0, U64_MAX);
 }
 
-int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status,
-			   int tag, bool gn)
+int amd_iommu_complete_ppr(struct amd_iommu *iommu, u16 devid, u32 pasid,
+			   int status, int tag, bool gn)
 {
-	struct iommu_dev_data *dev_data;
-	struct amd_iommu *iommu;
 	struct iommu_cmd cmd;
 
-	dev_data = dev_iommu_priv_get(dev);
-	iommu    = get_amd_iommu_from_dev(dev);
-
-	build_complete_ppr(&cmd, dev_data->devid, pasid, status, tag, gn);
+	build_complete_ppr(&cmd, devid, pasid, status, tag, gn);
 
 	return iommu_queue_command(iommu, &cmd);
 }
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 1181dc31795f..7d660a81df3a 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -116,10 +116,27 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 		return;
 	}
 
+	/*
+	 * Probe never attached this device, or it is no longer on the
+	 * bus. A kdump kernel can reuse a DTE that still has PPR set.
+	 * The log entry carries the DeviceID, so complete the group
+	 * here and do not touch dev_data.
+	 */
 	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id,
 					   PCI_BUS_NUM(devid), devid & 0xff);
-	if (!pdev)
+	dev_data = pdev ? dev_iommu_priv_get(&pdev->dev) : NULL;
+	if (!dev_data) {
+		pr_info_ratelimited("PPR for unprobed device: 0x%x\n", devid);
+
+		if (PPR_TAG_LAST_PAGE(raw[0])) {
+			amd_iommu_complete_ppr(iommu, devid, PPR_PASID(raw[0]),
+					       IOMMU_PAGE_RESP_FAILURE,
+					       PPR_TAG(raw[0]),
+					       PPR_FLAGS(raw[0]) & PPR_FLAG_GN);
+		}
+		pci_dev_put(pdev);
 		return;
+	}
 
 	if (!ppr_is_valid(iommu, raw))
 		goto out;
@@ -136,7 +153,6 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 	 * PASID zero is used for requests from the I/O device without
 	 * a PASID
 	 */
-	dev_data = dev_iommu_priv_get(&pdev->dev);
 	if (event.fault.prm.pasid == 0 ||
 	    event.fault.prm.pasid >= dev_data->max_pasids) {
 		pr_info_ratelimited("Invalid PASID : 0x%x, device : 0x%x\n",
@@ -159,7 +175,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 
 out:
 	/* Nobody cared, abort */
-	amd_iommu_complete_ppr(&pdev->dev, PPR_PASID(raw[0]),
+	amd_iommu_complete_ppr(iommu, devid, PPR_PASID(raw[0]),
 			       IOMMU_PAGE_RESP_FAILURE, PPR_TAG(raw[0]),
 			       PPR_FLAGS(raw[0]) & PPR_FLAG_GN);
 	pci_dev_put(pdev);
@@ -245,9 +261,12 @@ void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
 void amd_iommu_page_response(struct device *dev, struct iopf_fault *evt,
 			     struct iommu_page_response *resp)
 {
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	bool gn = evt->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
 
-	amd_iommu_complete_ppr(dev, resp->pasid, resp->code, resp->grpid, gn);
+	amd_iommu_complete_ppr(get_amd_iommu_from_dev_data(dev_data),
+			       dev_data->devid, resp->pasid, resp->code,
+			       resp->grpid, gn);
 }
 
 int amd_iommu_iopf_add_device(struct amd_iommu *iommu,
-- 
2.31.1

