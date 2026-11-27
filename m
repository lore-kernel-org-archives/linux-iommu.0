Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779071;
	b=Mie4Lcfdb6XQYxjeogYP52EF+VosGSkoH5SCM4otEQsFK+zQnEEZ/MJHx+kSiYY4M+TL
	 oV9VTCd3erbo0t8CYNnphmGSWqjprwZAMlWDtQdoRRtCdVCnYuF4AvDCYgrPNKp3FnmSi
	 IXFtSxqQnmyrSBf5cayr44sUHQq9i4mh5Qa5ElEcjZWWfxrUvzZoQTHuKSjVZCWGclQF1
	 jI0n/KNCHRLwYGfGFFodm7giVhsFXi1itmt4iojnoUzWOMR9d/ctflNJ4oy/FSujPWDHO
	 dos9KncUSaOgE3Ymo19kWhdsfJqLxEuiBZjFWfSDetRpeCxp5ygFn9fX3+hSd3Opsqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779071;
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
	b=ATNCVswmYGDrRQxWeMf9/04l2hvAvJNek0HS/+IjcWLR+KqjTxO/JKqdlY8RIiQsMhFj
	 iN9Uxv796xu5KJ4VILkndriJMraq78Xrg4GtHEFg+2U92ICvGREglVGvyiIfUnChYdKtZ
	 CnyB11V9DQuU9AyOZqPH/gj64DXzaO2QmfZpuU+AWUVIO6PL+px+R+uzPZz+I71vux2AI
	 1QR7+0GlJozSIlYAeWLmsd+X1PXJqXzGbBuhUL+bwXV0k893DDeZ7bpgouoz+MOBaHyfo
	 xrTDw2e/kMYG7X5O3W84jGKD0M24SzUKLuSYYPhq+1uZgwA5fbSuoyp0gh7mkSgG3YQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KEJB5xM8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.0
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC68606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAC68606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KEJB5xM8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8m3NFfyPh3f/X1/YCbsXhVEUTDyyJ1mdsZ+/gjtDUQHSvpXVK+qoiRRWrVyRYCw99F47P61BBNxV5pQhyj6UJyzIqrcehJFn7+u9N5MRTLJYoqmzZjq36QBWsBcccdno4USJSKrobTyl0SKs9he0T7fmcI/8l3eWoi/D/OM3ugyctE6HW5r28z6AefT8PhUNerFiGS5QV9HpiyPXCAPZ0D4RfwYZu/wQUd7nsjD2h8SwvB+VOqEfbiko5AwNmHj22gRWQ8FOodSk1HkqQyMDhvORgMoQ3mSl+BHO4kecjN4zGHhpB1UZ+Um9nmFqJ4Y2TOnMzRI3KcReF1+BHpfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4YQr3/nPlVKJicA3r6JKyJHjxQzWv1cSmplMGa05ng=;
 b=FBz6NAJVJtc70J3/WcPSrH/Rn9C38y2uZTFJbonOvsQHFD9fZfteS54hKitDyfFfISovQy6XOUPWTAhBvMEBJzuxDI+OEHaSOhgM30uFIW81xA03dsbCzoBEhr2DBPHyNwjXAxtwmqTYN7Zl07EvbQVxgD+Bdb4rfXNCN8a4O1am+iS8h/YqBrlefRrqpcuCnyN1QXvnz93aXtwBgVADcbVeSfJ39i+NAGotKAqw/sO9ZgfLuFStBLgyAK55ILLGX7Vvk9eXlUnMD3WZNZZ+Vlkb05N/pkjsULpas3c+cTwEaXqsPGs06RTGoj2thpmKAXLhq6VqyHxyE63SAb9Z2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4YQr3/nPlVKJicA3r6JKyJHjxQzWv1cSmplMGa05ng=;
 b=KEJB5xM8xByeWcv15zNK2A26ei3xGxCDGfHPd5/ZGBbuLlRwEdHGeoD9ulNy1OWEgWKfVie/Kgyv35xC0ifUubrs9FQ60rtS5v9ge4HEvPVGNwGnC1XEkG5WkzKvxgXFTKvuKwZ4LdKH6he9s9Gz8OU5l6GmF81O+KCrFc6iGwE=
Received: from BL0PR01CA0026.prod.exchangelabs.com (2603:10b6:208:71::31) by
 DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.11; Fri, 27 Nov 2026 11:31:01 +0000
Received: from IA0PEPF0000003C.namprd03.prod.outlook.com
 (2603:10b6:208:71:cafe::40) by BL0PR01CA0026.outlook.office365.com
 (2603:10b6:208:71::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 11:31:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003C.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:31:01 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:30:58 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 2/3] iommu/amd: Identify a DTE entry by its DeviceID
Date: Fri, 27 Nov 2026 11:30:17 +0000
Message-ID: <20261127113018.209034-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127113018.209034-1-vasant.hegde@amd.com>
References: <20261127113018.209034-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003C:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2e84b3-74c5-4177-2f21-08df4c79ea37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|10067099003|56012099006|5023799004|11063799006|261021123027099003|261009223027099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	kWTpi2HX0uPpL4CpKXEiW3hVQU6QmRTcY90uDgAteqEQTkwdRK9gcBenWExWd96f/l9/u8oBZW8ZD5nKSg3qttnXDgy6RwNg6g/rnoQ5eVr4pfwqTu/EuXveOJouVK6uDXvAilB/MAjIn8k40/G+P4Jp/NHsPf/rgb83obYOtGjFPOmUNJdkUuEYDj1HW8/3LfNvLpv+BL9yAmje5lY6AqqgtgEuNUlTEoRBj49NsNu5kpuru5vD6xJQp0cGhldXuk487ldb3wSM0TMsDdTtUxaQ8H7FuKh9eZI81Eir3wXAQM9epBHBh90drBiBXqg+G1FOglZzuYOaLr1xUksPMdht7DIDXbatwz7zD1r8dgNZ5/SFOQ1+WLITRa98hQYwkY+u+TKqSQrPKGEZ9Z4wddWb1NZiHBY3+vgy4tLCED779O9bBnmzkH8eKlN8R9WjBBt8nRKsZ2zzWrXxqkvudljXMI8LRbil57x2EDRv91ejKLLsgcl3wFHcSH/DFwAgKc0lCUq5+ZbpZPpnMtJ/VB97urOe3kewDJ8aUnYKyl6m/4fsGUgAjlBByYme5dYb+k4zQTbb0mUUAOHcl1pn2+6w68i5Qt6XzXQKiViQag0f9ojOZVdOxga4yRSyTybVovANDhF1A+XD17WROKm6E4cg/GtnvSOZG70zjxDQEdpHTgJacMS1mosKFa5o+AAV+lTKrcYzjnj3AiQZ0tjizw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(10067099003)(56012099006)(5023799004)(11063799006)(261021123027099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	41zS6tPd8GQA/rQph3Lk3oODvHloOuDygtCV670h23Z5onShPLNGUH1yPV5gMIc5FVrRlfPKP4nzkGLaldIXaEA9DmKqJBHCUfO197FGhPTg+J2TsXqw07SeJLdZgNF4fWJh3WJhP3s2Wlj9GiKpKM2UGjWIdPoRPt3PAjOWr5Yxabe1wu/7mrZ73WOI3ya/wNsWSQIA4cpPkACgVE67AX/q7i0dfqUtOhBNHjVW0oRWkAZ2X9yCGWCRFt9ZnWQufn0u6EN3IX0lts605Aj2GneQuD7oXhmTMiFpYXt1cXEebXFB3jxcQi4fK1AbDksqVd2iVIR20OKqe6V1o7FGzdw7gni9mhyATThZTbN8k3esQKD/a1xUsYaf53HvcGgMR0GqmIzcv7+n/J9BqbKiGGJFxW7ADHhWFmIEM9y42MFVMIzpWhjjia3IH3FtjNB/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:31:01.3782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2e84b3-74c5-4177-2f21-08df4c79ea37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420

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

