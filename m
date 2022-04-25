Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CECC433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CDCB81A65;
	Mon, 25 Apr 2022 11:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uR7e7xv_6K7v; Mon, 25 Apr 2022 11:37:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 94F4B81699;
	Mon, 25 Apr 2022 11:37:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63CE1C0039;
	Mon, 25 Apr 2022 11:37:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1320CC002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:37:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 01C9D81A65
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:37:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3mvtxarwD1xw for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:37:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A17481699
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELBBeZact60NkLSDmEzkDCyIsAOcUdcZf63cxrTHmF5Ce8SUi09E8cUJOe7/wAsX2eRNfYzPdeguIWWBCAnfvaRK5SEk2+K/46cHqOTzzxTu6qQqLhm99ftib6zxRRPq4v4A8wHqwSs6p8P8B3fQLQFgLo1pEnAXe9KCFL6Cpr8Q2PDn3gqiVEgvj3eT60c6mlG5K2Ojynv1VWvyktMb+vr3zdsv8ThD8rN9A/zFmaMc/R7RjoRdH4fmNiv47FiwJnKfVfSyOeX+IM7D81UO7GJ35cHPOHeI13eZ20AMAArHHsuBAA/HXC81Hh5X9tOjBrng0atmO4Lq3CixOZ8zmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IajpVcjO8h8eoS6fd4d11l9UxZbjyeClUWmfJVOXPI=;
 b=hqOZhWQw6B+h8lmQM+Iy8dD/qujU/q8RSuVW8ZLTurlbWspqSLMOPfsTsQTyjSsdJgvooJuZXREyKxXJSvDDp8hEgUhkzTADDnWWKo0Mse+tFmUPTP+sODLPx6MgU+/wilNJX+vVqLLJCKvR+mM92gzZRrsCj2hTqZZmmue8X+a9iEGUOZBXfxMnpyAsSo+34Qs9Dc0N4r0cCcbeGLvrgqbGBdPTpl1FGNRpyx/vqqjrD1mAvNzOgsxT0VI6LebLmtq07Rr2x3DeZuDZN9+ZgxSLE9ixYEmzIA1EcGlfr4jXh7vjzKR6C66bH0XwLznQzuuRqdt52Gv4Qa6pEDVfLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IajpVcjO8h8eoS6fd4d11l9UxZbjyeClUWmfJVOXPI=;
 b=rGDOXcw2en94p0I5M0Lm4WCxX26ZEM0Y8I6jaqX91qqmEgPOzSAtt7qkkcIeoRPVdNEo9ZRHrWe9vY09e1Mt1DuIF2UNob0GuCSEb7MUanDvTNAXACZKeObE30mVlzRGZ5Kg/3rdWgHMt6U7BcnX4/ijEEBNS+XJ/tjA8X0qaok=
Received: from BN9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::9)
 by DM6PR12MB2874.namprd12.prod.outlook.com (2603:10b6:5:15e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 11:37:32 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::e9) by BN9P221CA0002.outlook.office365.com
 (2603:10b6:408:10a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 11:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:37:32 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:37:30 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 10/37] iommu/amd: Introduce per PCI segment last_bdf
Date: Mon, 25 Apr 2022 17:03:48 +0530
Message-ID: <20220425113415.24087-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e66a7446-ef35-40a8-84ed-08da26affc78
X-MS-TrafficTypeDiagnostic: DM6PR12MB2874:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2874E617B409ADBCAB9B514587F89@DM6PR12MB2874.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QpDYo2LLOOG10BtYmJZtJTIVnyjlGrFS0zmrmF1BhTbsO0SgZXJYSUN0u4qvvU/LUFsEp1/U/+dGUjJAafZIx/kn5HG87OQ9kWkycGk4zE7F6sPvaGQOHnS69qMqYPUDUmgZ6tjod6h9yvPP8USUVNv+BiTRUTbDMEoal7gGMJ39cSWXtdKMmpE0nzN7AYYyRGNwJCkXMbrsY41Aw6fUj/PtIdyUt2SquYDsyxtfBR+fUIGJzTedwGDhgYdBgkQw2e2r0ukQJ8I9NvtNc3yRkNiUW8IiYwvb4nLWHRQKgEGV3v0eu3/ejjv48kKIMW3d7nXsEuQrcrxyorLCB5aYr1yqNvnRaiAZz8MGqtkzOX+gThi67aeNFX/2pXX2QW1DpMXAYQgXC/6fpj/6KZ/2sXHFItkeR9dBhvlI77nsNDVYGmn+ae1y4PsuxJEOMQaSxdQn5QOXmUSvVJYFKilCbxcpvbMyHnqbZR29gOs2m3ovw4DW36vOJ6X1D7bQc16kIsnl1WMrUQjx9MsZfIVCyjMKLnc4u7os6QUbwnFtF+QKZW8UUqjAfnlIUS3fbUMnF4Zbo3zpOJ1/t706WFcf8y9yGQFstZk4acHLKua5JOrya4ij6dUzNc/zC1CC70w3SmB5zO1rRYj5BizMwUHXF8eJZSfScFE7mfc36kK93CLpWZuaohNPEsca/iR+dEa2qkpZIpqNLH4Bw20QXESpnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(82310400005)(186003)(426003)(336012)(6916009)(54906003)(8676002)(83380400001)(356005)(47076005)(36756003)(36860700001)(40460700003)(81166007)(4326008)(5660300002)(70206006)(70586007)(6666004)(316002)(2616005)(26005)(8936002)(508600001)(1076003)(86362001)(2906002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:37:32.2610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e66a7446-ef35-40a8-84ed-08da26affc78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2874
Cc: Vasant Hegde <vasant.hegde@amd.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Current code uses global "amd_iommu_last_bdf" to track the last bdf
supported by the system. This value is used for various memory
allocation, device data flushing, etc.

Introduce per PCI segment last_bdf which will be used to track last bdf
supported by the given PCI segment and use this value for all per
segment memory allocations. Eventually it will replace global
"amd_iommu_last_bdf".

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 ++
 drivers/iommu/amd/init.c            | 68 ++++++++++++++++++-----------
 2 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c4c9c35e2bf7..e39e7db54e69 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -544,6 +544,9 @@ struct amd_iommu_pci_seg {
 	/* PCI segment number */
 	u16 id;
 
+	/* Largest PCI device id we expect translation requests for */
+	u16 last_bdf;
+
 	/*
 	 * device table virtual address
 	 *
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index d613e20ea013..71f39551a83a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -550,6 +550,7 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 {
 	u8 *p = (void *)h, *end = (void *)h;
 	struct ivhd_entry *dev;
+	int last_devid = -EINVAL;
 
 	u32 ivhd_size = get_ivhd_header_size(h);
 
@@ -567,6 +568,7 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 		case IVHD_DEV_ALL:
 			/* Use maximum BDF value for DEV_ALL */
 			update_last_devid(0xffff);
+			return 0xffff;
 			break;
 		case IVHD_DEV_SELECT:
 		case IVHD_DEV_RANGE_END:
@@ -574,6 +576,8 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 		case IVHD_DEV_EXT_SELECT:
 			/* all the above subfield types refer to device ids */
 			update_last_devid(dev->devid);
+			if (dev->devid > last_devid)
+				last_devid = dev->devid;
 			break;
 		default:
 			break;
@@ -583,7 +587,7 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 
 	WARN_ON(p != end);
 
-	return 0;
+	return last_devid;
 }
 
 static int __init check_ivrs_checksum(struct acpi_table_header *table)
@@ -607,27 +611,31 @@ static int __init check_ivrs_checksum(struct acpi_table_header *table)
  * id which we need to handle. This is the first of three functions which parse
  * the ACPI table. So we check the checksum here.
  */
-static int __init find_last_devid_acpi(struct acpi_table_header *table)
+static int __init find_last_devid_acpi(struct acpi_table_header *table, u16 pci_seg)
 {
 	u8 *p = (u8 *)table, *end = (u8 *)table;
 	struct ivhd_header *h;
+	int last_devid, last_bdf = 0;
 
 	p += IVRS_HEADER_LENGTH;
 
 	end += table->length;
 	while (p < end) {
 		h = (struct ivhd_header *)p;
-		if (h->type == amd_iommu_target_ivhd_type) {
-			int ret = find_last_devid_from_ivhd(h);
-
-			if (ret)
-				return ret;
+		if (h->pci_seg == pci_seg &&
+		    h->type == amd_iommu_target_ivhd_type) {
+			last_devid = find_last_devid_from_ivhd(h);
+
+			if (last_devid < 0)
+				return -EINVAL;
+			if (last_devid > last_bdf)
+				last_bdf = last_devid;
 		}
 		p += h->length;
 	}
 	WARN_ON(p != end);
 
-	return 0;
+	return last_bdf;
 }
 
 /****************************************************************************
@@ -1551,14 +1559,28 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 }
 
 /* Allocate PCI segment data structure */
-static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
+static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
+					  struct acpi_table_header *ivrs_base)
 {
 	struct amd_iommu_pci_seg *pci_seg;
+	int last_bdf;
+
+	/*
+	 * First parse ACPI tables to find the largest Bus/Dev/Func we need to
+	 * handle in this PCI segment. Upon this information the shared data
+	 * structures for the PCI segments in the system will be allocated.
+	 */
+	last_bdf = find_last_devid_acpi(ivrs_base, id);
+	if (last_bdf < 0)
+		return NULL;
 
 	pci_seg = kzalloc(sizeof(struct amd_iommu_pci_seg), GFP_KERNEL);
 	if (pci_seg == NULL)
 		return NULL;
 
+	pci_seg->last_bdf = last_bdf;
+	DUMP_printk("PCI segment : 0x%0x, last bdf : 0x%04x\n", id, last_bdf);
+
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
 	INIT_LIST_HEAD(&pci_seg->unity_map);
@@ -1574,7 +1596,8 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 	return pci_seg;
 }
 
-static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id)
+static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id,
+					struct acpi_table_header *ivrs_base)
 {
 	struct amd_iommu_pci_seg *pci_seg;
 
@@ -1583,7 +1606,7 @@ static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id)
 			return pci_seg;
 	}
 
-	return alloc_pci_segment(id);
+	return alloc_pci_segment(id, ivrs_base);
 }
 
 static void __init free_pci_segment(void)
@@ -1684,12 +1707,13 @@ static void amd_iommu_ats_write_check_workaround(struct amd_iommu *iommu)
  * together and also allocates the command buffer and programs the
  * hardware. It does NOT enable the IOMMU. This is done afterwards.
  */
-static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
+static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
+				 struct acpi_table_header *ivrs_base)
 {
 	struct amd_iommu_pci_seg *pci_seg;
 	int ret;
 
-	pci_seg = get_pci_segment(h->pci_seg);
+	pci_seg = get_pci_segment(h->pci_seg, ivrs_base);
 	if (pci_seg == NULL)
 		return -ENOMEM;
 	iommu->pci_seg = pci_seg;
@@ -1864,7 +1888,7 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 			if (iommu == NULL)
 				return -ENOMEM;
 
-			ret = init_iommu_one(iommu, h);
+			ret = init_iommu_one(iommu, h, table);
 			if (ret)
 				return ret;
 		}
@@ -2408,13 +2432,14 @@ static void __init free_unity_maps(void)
 }
 
 /* called for unity map ACPI definition */
-static int __init init_unity_map_range(struct ivmd_header *m)
+static int __init init_unity_map_range(struct ivmd_header *m,
+				       struct acpi_table_header *ivrs_base)
 {
 	struct unity_map_entry *e = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	char *s;
 
-	pci_seg = get_pci_segment(m->pci_seg);
+	pci_seg = get_pci_segment(m->pci_seg, ivrs_base);
 	if (pci_seg == NULL)
 		return -ENOMEM;
 
@@ -2481,7 +2506,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 	while (p < end) {
 		m = (struct ivmd_header *)p;
 		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
-			init_unity_map_range(m);
+			init_unity_map_range(m, table);
 
 		p += m->length;
 	}
@@ -2905,15 +2930,6 @@ static int __init early_amd_iommu_init(void)
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
-	/*
-	 * First parse ACPI tables to find the largest Bus/Dev/Func
-	 * we need to handle. Upon this information the shared data
-	 * structures for the IOMMUs in the system will be allocated
-	 */
-	ret = find_last_devid_acpi(ivrs_base);
-	if (ret)
-		goto out;
-
 	dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
 	alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
 	rlookup_table_size = tbl_size(RLOOKUP_TABLE_ENTRY_SIZE);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
