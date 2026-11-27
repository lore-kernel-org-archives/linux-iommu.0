Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780694;
	b=k5SvfaBRVLOMIjyiwAtChC/vWbes32MzyEqwOaMzxdCf2CzTBKqHpSjLKUnzw2TjUqeG
	 Xwvm/MLq/nzlL6dYIHBIIbYt+DLd4ciUGdnlTdYDrAbx6qEEGN9CS0wf/2+7EhstvN+0F
	 CDMgADAoPZFiy9/dcapxXJJHxFYkHU/v/BrqGGZBwzgqhSJxSiJ64j+UWNWJ5v6WEo/iD
	 GuggCq5zFz2ND4Z8vw4Q0mcSnfdXBbB8/UNaomqJ1mKnjggSPAg6pVB2zJRnIVWvPJbjv
	 QPmuiF+C1ATnijFf1M0Kzdm+lHUSwCwFdsgDvfT6904KFxe9NZLomxQ+epGtEvyVB1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780694;
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
	bh=jILjQPg2lFQyMyHBX6/PRveJxsZjq7yMhn31Lzf1pNw=;
	b=Y8NVwWnqkQtJ/3HZsqzJGyFa2WIkK4NdJILsTilBEVs3EZjUMduWWt58ap5YOpd4YqI9
	 bxFYIuA4OAx5BQwPF2zxbuphHJhicnYkazwKPBCB7m3dNDJInho1+o7IP/nfHKBfnnkO4
	 qMhmUwwcOrdnRNZgU9E3DcE4qEmf690YiQ+YKKiRDEtMKH9K4n+6H5IhpCDQYbtbOvjbX
	 YLCr1As3gNHSjjN6SXDnmbxTjsWW4pQ6G6QmPWvHot2Lsa+3NR3eST14WE00Sbc1n/ydJ
	 1JjPiPJ48ATOoRVZSl3I0GmxqNZmAHdkGUL3GfSJffKjjHbPGsL9x2qfMtikW9BaLZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="HhU/f38c";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.62
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013062.outbound.protection.outlook.com [40.107.201.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FB6606A31E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6FB6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HhU/f38c
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s3/AccX7Xz3KJnLGl2M2Bue4QuseoFaR8iQacSWGascaWWIMw58OHNPDblyECAKanUXzBLxv+xfErpjY2yz583FOr69sB2gHOs8Rqtsa9oXsaIwexCgXrUjSVDTfLbmJ3dj04gDvdHXen+FMzLWeclNi5EMqR8AAT6zD2TGCRbmE2C92qbR8eOkXbtyK6ddvNUko/BpKgdbxfRbcrT81k2Plykk2fHTKfbqSzlcnDznwfUpKcnrTaTqYPj2hDojxSf9xsmBy94iOo8/9ayktTXn0SkCeLYsTmq7grDDI956lfLGGo+TThmu7QVZLDtQ3G73djFTvjZW7vbQm1dzBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jILjQPg2lFQyMyHBX6/PRveJxsZjq7yMhn31Lzf1pNw=;
 b=Tbh45CLRu48/qH7NC4FE6WVqF0aoPPaWCNgu4xM18ANW2nvSkSSpSItUAdFEQDRFNTZMgtvEaiFjLANFO1xjC8MFhDHn5QYjYd5tLG6bQPjVXNH/AKriiUPWJJ/YStbSCBoeuY8ibbnBwETU3Ts0dbNRXzi4soRSXGig6eKWigeGJxD4rF6MBff3KGQAlbm3f//n6xKqgm8GZ3XJOcZdqR4DFKosSl68COCg2LghgCsMY8yzIVM+4j0qWU2cbraW9VGOqRaAXkmVITRuISU7F5f6IKUOSPcVCZdDKMU3smK8QvrEdGEowU3oTZZThAjK9S52Ar6p6fqGkd0ezKA3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jILjQPg2lFQyMyHBX6/PRveJxsZjq7yMhn31Lzf1pNw=;
 b=HhU/f38cGeuc/kd7DjwTEMaTZkjIWnMpPW0cRxNu8MtlW/t27bpXLwYlGVWAhB23Bp6miorSxu203vZTY+CYAVN1Daz8JRGULhBQbhSwJZceON3mR8I2OrI/d0TbzHT3cI0DpSjTUfZIor1ZuOxmUEvGz43Qt3MB7h7z9DWeMTo=
Received: from PH8PR15CA0002.namprd15.prod.outlook.com (2603:10b6:510:2d2::29)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 11:58:09 +0000
Received: from CY6PEPF0000004C.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::93) by PH8PR15CA0002.outlook.office365.com
 (2603:10b6:510:2d2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 11:58:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004C.mail.protection.outlook.com (10.167.247.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Fri, 27 Nov 2026 11:58:08 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:58:06 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 09/12] iommu/amd: Allocate the GCR3 table from the device
Date: Fri, 27 Nov 2026 11:54:44 +0000
Message-ID: <20261127115447.209792-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004C:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: 970b3a6f-bb6d-44f8-b42c-08df4c7db455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|56012099006|5023799004|11063799006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JzCzBCYlTRzDkK57AKjjTHBPkPu3dFZx91dzAK14jl08GT3wBJJhZlwMMJfMLkebegTYTZlKonZcM7qn3v+AtZfiOYB7LUzA372Xn5EmopYfMJ/tI1Dcxu36Z5SrB5YJjTd+2J816Eb090I2233AaF0/+nNR+8uC1RElDcESQCDRUX0o+AT24vWPI2/38W5/zxO2uVMFiRqmBuZP4axoYzYxPS79CmBamALLYCf8baclWr0cwkEDLnuvdIbzCRJn30KWUKweOuaYbZF20cTWOwNno7wCMELPH+KsW/lMdaJNpdU0TLwS09A/MZW+sckZn+keUmsbh5G82u45QgSPF0hltuCDOuZjHxvZy1hbQpEqyyXN/EVPg87RBLw2VAxGjHsZV5H3kORNyJYFnBNzGRXmCBA0ETHKz51BOzPjduTqnWv8BjOCz7wmf/fTR5rVc3ENfvCH1u2upQv2VRXNow2u0QAzTbj5xK6sJhtZKiYsd09Fsp2MZaXL+9cwz/luZwF6h3IyWlqMyLBmVtLPOM5kJiUCziDfb9PnxKECqqaQ7bt/JrLnyLsqFpwdCqZa4Q5Hqcn55oD0n96IY3lE6pH+47KQQ/wpaPgsayV1CLcKbvO54W/C4hCTRqe4UJJSytYBl9DBrELQHTgkVBTFWEmoVs0NMJTHwsYh3aieeZiheq5qs2wkWqHu6QlmHl5VsBMEQ3T8exnyiBwd+vNDeg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(5023799004)(11063799006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bPndlBnoyQk12hcbGDYzWKUU1xOLaRWmEwBmE6T5hI2bZYvduZs6zS0rnRMqvb1QnxIN0KiD0UP6WJWuUeFIUYQItEVl3oN6a23irADaDwAxa5L5x4ud9cb12kjY4DLvZJYI6aeaQCUTUOF0oJkDT92AH3RvoOQfoCr3ui8T7y2eluYa8zgvVkQyzqgXMq2088ZYZY+I7rQFJ16E/h4fp5BFYEu3xXDWZbJ1aFWxhYKFdqhpVi4vWG8apj8YEHc70zYrcQ2sToyUfklJfaw51wWuJPwQBnbNgYor0ROqAPB31Gr4rZpzvmaVC6hGThFDXLer4Y/LVs+3Zxl+AyMy6FOWB5IeSQfbzwr8+xfacE1E9q7yjvsWf8Y6/sMRiMOSglXqtG+RsE96cKjo9KUIYM+iNGLU0oXa1HEoFZlPOXuIU/iT5ExncLpeSuPt7OAE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:58:08.9139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 970b3a6f-bb6d-44f8-b42c-08df4c7db455
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330

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

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 109 +++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9c32dcb921f3..4df3f242b364 100644
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
 
@@ -2155,7 +2159,12 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	amd_iommu_make_clear_dte(dev_data, &new);
 
 	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
-	if (gcr3_info->gcr3_tbl)
+	/*
+	 * Update GCR3 related info if device is attached to PASID
+	 * capable domain
+	 */
+	if (pdom_is_sva_capable(domain) && gcr3_info->gcr3_tbl &&
+	    !(dev_data->perfopt && pdom_is_in_pt_mode(domain)))
 		set_dte_gcr3_table(dev_data, &new);
 	else if (domain->domain.type == IOMMU_DOMAIN_IDENTITY)
 		set_dte_passthrough(dev_data, domain, &new);
@@ -2199,58 +2208,27 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
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
@@ -2341,9 +2319,18 @@ static int attach_device(struct device *dev,
 	if (dev_data->perfopt && pdom_is_in_pt_mode(domain))
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
@@ -2423,9 +2410,17 @@ static void detach_device(struct device *dev)
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
@@ -2520,6 +2515,17 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
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
 
@@ -2535,7 +2541,10 @@ static void amd_iommu_release_device(struct device *dev)
 	if (dev_data->domain)
 		return;
 
-	destroy_gcr3_table(dev_data, NULL);
+	WARN_ON(dev_data->gcr3_info.pasid_cnt);
+
+	if (dev_data->gcr3_info.gcr3_tbl)
+		free_gcr3_table(&dev_data->gcr3_info);
 }
 
 static struct iommu_group *amd_iommu_device_group(struct device *dev)
-- 
2.31.1

