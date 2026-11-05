Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793854245;
	b=sCSQz55OiKE9OmXOXvO0QzSv+iAjti14yn1UmMv2B6cTt3Mtxd3jZytK+klpxGnKR1aB
	 U64cjSbNonua93qieizFdNMqotKisWe89nk9TX0watu+CtOoqg1Yb2EeGKRcIZgEY1qg+
	 xFmXa370CiIuByFodOdpXpWM+PI2p6W2orno8+UNhEF5V+0RmxTTZhOrrLs+TZ1f4SB9I
	 XvkxxBWxapT9nvOpCt1GsQQBYyap+ne2oFLCqgz1XeepyhxboWjsiHMXJBFRctuzQqFh1
	 x2FAd4e/Ogo7ZGXtrM4r2VpzQrBx9SMNspLbGaUl1FUEwrk6w3orixlB8LoeqTH/XjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854245;
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
	bh=wNsKZuljl0kL6fudJF5fKDrSEvQfOlvWWHW/DK+ofUs=;
	b=3VedfV6k/xE4lry2zGAJFjCIoACn0cnU2DVsODCNeOo71RHXC53BMFJm7p5SQOim7QtO
	 HkVFXl5vPwvC4pEOaQtJHAbtN6L/CMAV9kJi1q/hBjkLEbrAp5SpMynqeFLG9i7F0OZDP
	 lSLrGUPCNRkEJQ/usV0E9MGD/I+Bur6muvhibyG4HTAHHfyAazLrmaUIgaUNtVSyTUKMr
	 MWrFvwlxe8iyY2LdnJsR9QcYf8+AMnGMkHIu6pvanioiuS0syvN4Z4xIpR5Rv74AtikPz
	 WsS0jtMpiW0yr9yN4L8vank5J2WZeTv57qDHUAkNxCOES9MXJNM3CXpdmQWxx0BsxkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sR1vDeiA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.45
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517A606A326
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4517A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sR1vDeiA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLLCgjYd5hy4Kp1vGVoLYzy+XvcTh/KB3NsB9yqM4OAQwv9uiED3jqtls4osIukTCp/kNVB4EaNmaQNd9eXYDcJ1YK+2YGPZWxiZwrcvXcFvFVkYn6otyIVg1mhFv8oFg1wKbNJxHq9goSJURA4w8hWCjCq6yQs2Rq/2NaE0ORuBV7gWyXEZm9+db7xRblyxTT90be3cd5G4SE3nqu8jVmNmE2YP9yCEhNdh/FRLNYg+Q21CQwpmbPoIeQOmZYE10vm2Cz8AOqKHO2OR1tly3PPcwGuccCq+DXTIPZPeUPtiVuc/riTcDKVwb0zczL5irhKQNFHNgMWhDxGuM+D0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNsKZuljl0kL6fudJF5fKDrSEvQfOlvWWHW/DK+ofUs=;
 b=ohOl/cgUfNtaEwGn3BF+s+KqeW5VzzFHuj0gh630GjdiXCAbDQQbzK+MntuKim/pJyX3/0Bnhd/VuGnn2R3CSS/7RnvQqBcchHuIymOH2KPntUbT+cB1mDFItxJCICFTK0x3s27jWzyg1aRSCfg/KduiivY40/Y6yZey5LwTc1gyvUKVoCuHs/WYID0Tgd29zTvPr+p3n74piaeuzPnG9yX09Bt0R6jECnYxUR+2z/UJ6Uh8L/Rj0epJcctH2LAl5N2MXnALvNU8LA6ej4BQt9L2s+te8IaGOapxDptLs46FwoTAQw82MPC6kjOTXMYwabJewD8GgsieRt8ryr3xlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNsKZuljl0kL6fudJF5fKDrSEvQfOlvWWHW/DK+ofUs=;
 b=sR1vDeiA1bI5v0+Q1qU4Ls0j+TNR1xTvInHwLPXxJu0+6XWEqa19vwMOJ3v5ay1OYSt0O9/KXzgT4RjJ1f5P3gF5oZz2KMWlAsSUF0vuaUJDmQ7L0QhpmS7Ufu9PHGE4N0alKdBHSfIcdR2WufmQhgswuRp+JAouPdcICKxfmt4=
Received: from BN9PR03CA0488.namprd03.prod.outlook.com (2603:10b6:408:130::13)
 by PH7PR12MB9204.namprd12.prod.outlook.com (2603:10b6:510:2e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 04:50:37 +0000
Received: from BN6PEPF00000070.namprd03.prod.outlook.com
 (2603:10b6:408:130:cafe::2d) by BN9PR03CA0488.outlook.office365.com
 (2603:10b6:408:130::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Thu, 5
 Nov 2026 04:50:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000070.mail.protection.outlook.com (10.167.248.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:50:37 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:50:34 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 09/12] iommu/amd: Allocate the GCR3 table from the device
Date: Thu, 5 Nov 2026 04:47:58 +0000
Message-ID: <20261105044801.399466-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN6PEPF00000070:EE_|PH7PR12MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: 32575f52-7b56-4ef6-6338-08df3af855c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|261026140227099003|5023799004|261022105027099003|56012099006|261021123027099003|261021121427099003|261009223027099003|261028144727099003|261026121527099003|261102123227099003|261022075727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Yu04JbkClHln45snKK6Rxmkywb9EPoMSgs3AiGvWzAIT5wPusJ95JbqbZmUtxuZmojbAKw023o8DMXVMfgcstne2PHbt9/cqZ7W3rB5i4W2AT7YQdRbUUl5JOgCFvUt2DIoIzoS5uQ1mvAgth2sw97JoCXD5C0hh/d6yxX1oHCQP3jPn241rumhIvm82tx4FoycC9K+w2x6zyQ8SrnHh8ktyURnCowIjBuiVLlU/oc2jKxrVrBPjmqS3zvfA0UErZhAshN/v1f12yLjInavtsxWrUXtn5pa9iacO2J9fNYMu79ld2hOOgKh4WW8KI1HBGxadJZV3oqQUuQz7S6IrlNgmapzm5AOrHKCF7IEi+dgr+n4TwD3/P+OdGs4U1ewbcXecFKquU4SvOcZL8HVB30Y/s13muhFYZgXnzVp5OvYW0A9yncHO6F7O1F/O0DNyZ/iQQPxcYM8bG1w5ajyq14wPpMwn9cnKfH1OmUT//Pm79iWCOz+8SKkZomiYQTXm0pSjwrwo0ytBK1y6BM0tFaDg0lAi7kKAMgM3HzSIB4CgvDu88CHpn+VHppvLEgiEYBNzjT9wwANno5gw18oQAdKpeBKbFKQwlr8YvFKSZaCP9jjm1SjNaia0gNF3VmRCFjr+K5Z1D6wgNGLA0mq3hbz57pWIvhVQ4HZjS3Hu72csNoyWYxCRPHmTCR17Qce7WquEizWgPe+1WdPNregVLQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(261026140227099003)(5023799004)(261022105027099003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UVqEfmH/OhWymfvuMv/qpCrsfLjWI6W2vcKXNk92LmSw9KlrMDnvutLLmuPPjhhpR0UrkQcrJD/A7b3KhCYpRpxUVsIEjGmI6DpYuZylMeNiSC81oJq9K+kBiBFzO1yQKozqB/y8uSB+ERmhtIHdRuX1VBA8AgpStcjlaywM1xlCAKsJ6evoZPfk2BRfiLyMVstk1bHZa5QC4B2K1CG+mELHpnb7h2rBOqsB41bykwfE9GTeiFaE/v8SlpecKu09jWrVQSlet/LPNELwCJ7QxITR16WwfS+zJDUtQdxppQ5dcuz8Lart1JsxTGBhno0rCjtpvsr4W2XwQ2WxBRqKSyU1vTDoLM0t/Tg0b0GpdsETQSQ9a1bIQmFlxXUkEa27eEPY77RiJzfjIPCtWpV0f1EaedLKa3TJxRzITYSvryCmdoFpXe5PStaItOyUPOaM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:50:37.4558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32575f52-7b56-4ef6-6338-08df3af855c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000070.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9204

setup_gcr3_table() conflated allocating the per-device GCR3 table with
programming the v2 RID GCR3[0] entry. Because the table can outlive the
RID domain, split the two and change where the table is allocated based
on the device's PASID capability:

 - PASID-capable device: the GCR3 table is allocated once in
   amd_iommu_probe_device() and kept for the lifetime of the device. It
   is freed only in amd_iommu_release_device(), after the DTE has been
   cleared.

 - Non-PASID device with a v2 page-table domain: the table is allocated
   on demand in attach_device() and freed in detach_device() when the
   domain is detached.

With allocation handled per the above, attach_device() only programs
GCR3[0] (via set_default_gcr3_entry()) for a v2 domain. detach_device()
clears GCR3[0] (via clear_default_gcr3_entry()) for a v2 domain and, for a
non-PASID device, frees the table there. set_dte_entry() installs the GCR3
table in the DTE only for an SVA-capable domain.

Rename the helpers accordingly: setup_gcr3_table() becomes
alloc_gcr3_table(), and init_gcr3_table()/destroy_gcr3_table() are
replaced by the narrower set_default_gcr3_entry()/clear_default_gcr3_entry().

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 108 ++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3ecab557f6b6..8750ac32f382 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1942,11 +1942,14 @@ static int get_gcr3_levels(int pasids)
 	return levels ? (DIV_ROUND_UP(levels, 9) - 1) : levels;
 }
 
-static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
-			    struct amd_iommu *iommu, int pasids)
+static int alloc_gcr3_table(struct iommu_dev_data *dev_data,
+			    struct amd_iommu *iommu)
 {
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	int pasids = dev_data->max_pasids > 0 ? dev_data->max_pasids : 1;
 	int levels = get_gcr3_levels(pasids);
-	int nid = iommu ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
+	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) :
+					NUMA_NO_NODE;
 	int domid;
 
 	if (gcr3_info->gcr3_tbl)
@@ -1964,6 +1967,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 	gcr3_info->gcr3_tbl = iommu_alloc_pages_node_sz(nid, GFP_ATOMIC, SZ_4K);
 	if (gcr3_info->gcr3_tbl == NULL) {
 		amd_iommu_pdom_id_free(domid);
+		gcr3_info->domid = 0;
 		return -ENOMEM;
 	}
 
@@ -2165,7 +2169,11 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	amd_iommu_make_clear_dte(dev_data, &new);
 
 	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
-	if (gcr3_info->gcr3_tbl)
+	/*
+	 * Update GCR3 related info if device is attached to PASID
+	 * capable domain
+	 */
+	if (pdom_is_sva_capable(domain) && gcr3_info->gcr3_tbl)
 		set_dte_gcr3_table(dev_data, &new);
 	else if (domain->domain.type == IOMMU_DOMAIN_IDENTITY)
 		set_dte_passthrough(dev_data, domain, &new);
@@ -2209,58 +2217,27 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 		clear_dte_entry(iommu, dev_data);
 }
 
-/*
- * If domain is SVA capable then initialize GCR3 table. Also if domain is
- * in v2 page table mode then update GCR3[0].
- */
-static int init_gcr3_table(struct iommu_dev_data *dev_data,
-			   struct protection_domain *pdom)
+/* Program GCR3[0], the RID page table. Only a v2 domain has one. */
+static int set_default_gcr3_entry(struct iommu_dev_data *dev_data,
+				  struct protection_domain *pdom)
 {
-	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
-	int max_pasids = dev_data->max_pasids;
 	struct pt_iommu_x86_64_hw_info pt_info;
-	int ret = 0;
-
-	 /*
-	  * If domain is in pt mode then setup GCR3 table only if device
-	  * is PASID capable
-	  */
-	if (pdom_is_in_pt_mode(pdom) && !pdev_pasid_supported(dev_data))
-		return ret;
 
-	/*
-	 * By default, setup GCR3 table to support MAX PASIDs
-	 * supported by the device/IOMMU.
-	 */
-	ret = setup_gcr3_table(&dev_data->gcr3_info, iommu,
-			       max_pasids > 0 ?  max_pasids : 1);
-	if (ret)
-		return ret;
-
-	/* Setup GCR3[0] only if domain is setup with v2 page table mode */
 	if (!pdom_is_v2_pgtbl_mode(pdom))
-		return ret;
+		return 0;
 
 	pt_iommu_x86_64_hw_info(&pdom->amdv2, &pt_info);
-	ret = update_gcr3(dev_data, 0, __sme_set(pt_info.gcr3_pt), true);
-	if (ret)
-		free_gcr3_table(&dev_data->gcr3_info);
-
-	return ret;
+	return update_gcr3(dev_data, 0, __sme_set(pt_info.gcr3_pt), true);
 }
 
-static void destroy_gcr3_table(struct iommu_dev_data *dev_data,
-			       struct protection_domain *pdom)
+static void clear_default_gcr3_entry(struct iommu_dev_data *dev_data)
 {
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 
-	if (pdom_is_v2_pgtbl_mode(pdom))
-		update_gcr3(dev_data, 0, 0, false);
-
-	if (gcr3_info->gcr3_tbl == NULL || gcr3_info->pasid_cnt)
+	if (gcr3_info->gcr3_tbl == NULL)
 		return;
 
-	free_gcr3_table(gcr3_info);
+	update_gcr3(dev_data, 0, 0, false);
 }
 
 static int pdom_attach_iommu(struct amd_iommu *iommu,
@@ -2351,9 +2328,18 @@ static int attach_device(struct device *dev,
 	if (dev_data->perfopt)
 		goto skip_caps;
 
-	/* Setup GCR3 table */
-	if (pdom_is_sva_capable(domain)) {
-		ret = init_gcr3_table(dev_data, domain);
+	/*
+	 * A PASID-capable device already owns a table from probe. A paging
+	 * domain with v2 page table without PASID allocates one here.
+	 */
+	if (pdom_is_v2_pgtbl_mode(domain)) {
+		ret = alloc_gcr3_table(dev_data, iommu);
+		if (ret) {
+			pdom_detach_iommu(iommu, domain);
+			goto out;
+		}
+
+		ret = set_default_gcr3_entry(dev_data, domain);
 		if (ret) {
 			pdom_detach_iommu(iommu, domain);
 			goto out;
@@ -2433,9 +2419,17 @@ static void detach_device(struct device *dev)
 	list_del(&dev_data->list);
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-	/* Clear GCR3 table */
-	if (pdom_is_sva_capable(domain))
-		destroy_gcr3_table(dev_data, domain);
+	/*
+	 * GCR3[0] belongs to the paging domain w/ v2 page table.
+	 * A device without PASID has no other entries, so the
+	 * table is freed with that domain.
+	 */
+	if (pdom_is_v2_pgtbl_mode(domain)) {
+		clear_default_gcr3_entry(dev_data);
+
+		if (!pdev_pasid_supported(dev_data))
+			free_gcr3_table(&dev_data->gcr3_info);
+	}
 
 	/* Update data structures */
 	dev_data->domain = NULL;
@@ -2716,6 +2710,17 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		return ERR_PTR(-ENODEV);
 	}
 
+	/*
+	 * PASID-capable devices own a GCR3 table for the life of the device.
+	 * A paging domain with v2 page table without PASID allocates one
+	 * later, from attach_device().
+	 */
+	if (pdev_pasid_supported(dev_data)) {
+		ret = alloc_gcr3_table(dev_data, iommu);
+		if (ret)
+			return ERR_PTR(ret);
+	}
+
 	return iommu_dev;
 }
 
@@ -2732,7 +2737,10 @@ static void amd_iommu_release_device(struct device *dev)
 	}
 
 	WARN_ON(dev_data->domain);
-	destroy_gcr3_table(dev_data, NULL);
+	WARN_ON(dev_data->gcr3_info.pasid_cnt);
+
+	if (dev_data->gcr3_info.gcr3_tbl)
+		free_gcr3_table(&dev_data->gcr3_info);
 
 	/*
 	 * We keep dev_data around for unplugged devices and reuse it when the
-- 
2.31.1

