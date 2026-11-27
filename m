Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780741;
	b=nE2gfWVhiBvVYcOk2DTcgboWT9kiZgljiHkUX8Y+ALurChlDRCRac+77YPnHa2stFEHA
	 b+FqRu3Jkd7ID+I7fSatBox/Epipsz7x7NC/SMTQ07ZssOwJxb7WdXUsubFlBUkg8mIyG
	 EC3o+4FPOL77H4M+8K7ya7U3ua4+OB0nwSc4qIh3ozCxssd/Q5/zfI1slDIkbHlT+acGm
	 ImKuZoIBzK7dmKXhFc2pwU3ynS7Q0poKA4ccp4cdm7gO1otoYdxvX5WAAa8g0Sj8ni4oz
	 Q4FFm1EjCXusd5FqllVWWnh8iBA4XpWPPAtHLzW8RgWiIfKqBkHQb+FxhYY2OiUKfOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780741;
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
	bh=tOVTmGLedFGACEkbRJVm1BgonHePyReQtaEhZx0dTm0=;
	b=kftU7hgKVDoMYljelKYtQM4x5M0yjIMsBoDs2GcgEl/nHX8pvu2/1IRUmlwaRZqH44xG
	 QJEuZAC4yezdiiX9cNW3C+UIaxVovmhy3WdlzEjNp2CtH9w6A4qEdGaPi7uCqxPDqeduF
	 e6TBg1bh69fpG3Ko2FGRmkfilW0QQb+qVWqEREWsBmt9sQ/gkkwyqD1TVoDWsQXN7OGAS
	 ZypD8pAqqEvMU/9nu6hsuqh7rHU/F4NndakeVL4aSGH+gk6MHHkUiwCYnKVvb5/8EnBbN
	 fRxdDYAxNNoX8sSmoiaZ2cxeoyAigdKcBiqy0jB1EteR1f5oYLNv5ufH9swvcbN0n7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=id1qEdct;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.49
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF38D606A326
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF38D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=id1qEdct
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4g6xv8VwU59GAL6jCyuXMf5nOm+lBAtm40+OSgaY+RMFLjrOZ/JJF3BbAJtM5af02x4mqaWgrtbfGZn1hH+agoqy606znIAtMrhSX64P1mQpZTGKS+18kHyFNQNjtTRSU2GeuewVW59gINr2lNgjRMXDfcBhMNOx3+N98pSpKnPBR6mLBnawMcybU2AMZZMryBUwZqlwh6113tMRkYyIXszZUZir9uPLGkq9MtIbozQ/B08gEtetMz2dsyDGPjekZenatQ3lSHaUaAcFlNbp2AJLdCQxEgiJWimYDgaFMgHLkNx1u5wDDx3qHW7CFFYyVCkZiYt7Cfs9EbgvEeTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOVTmGLedFGACEkbRJVm1BgonHePyReQtaEhZx0dTm0=;
 b=HaQPhsBT01L19X6LSukTCwl0NLBopCMXOQkEULxRw9Y6GV7NyBiM4UymKq1C/KFEbtdhl1qWyhrdMeWY3+TF0rmebLPF0fPmuHHMoCfkpFjFXPWprEbwh85qYM0wkbQRA1iXaYw0G5pYF6So7Lnj+i2d8qMVdt+m6v230xdsn/PnEZusCpkn3aCGCUb36LnSa7F7OsHNf0tNaAbxldkLJu2DNhIYfbVfpBISFcY0LKTqOYi9oDkvwEPnPncWJfZ83TkBMWxpKGjfqBxMfr7ZHaQ57tHGeKbKOo4DOrwMuStUWsVLGYnQLBTJLWYCxSuKxCZWNd8NKWenxNlLxKct7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOVTmGLedFGACEkbRJVm1BgonHePyReQtaEhZx0dTm0=;
 b=id1qEdctLuMY+50zpcj0kjFSmMNumelgRbaD3BSb8unIYxVRphojpDqVl0mZ3pN0JvrOJKEKtqxp7H1J1qvW98/vkPI8SZoPohmSBrhSf2ByEfBa20vsUCNObivUZ8KVmbGjiAh8JtPXx0pPFDAkhz3qWmh8QSR4+gJLPUv/UXU=
Received: from PH2PEPF00003858.namprd17.prod.outlook.com (2603:10b6:518:1::7a)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 11:58:56 +0000
Received: from CY6PEPF00000047.namprd03.prod.outlook.com
 (2a01:111:f403:f910::) by PH2PEPF00003858.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 11:58:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000047.mail.protection.outlook.com (10.167.247.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Fri, 27 Nov 2026 11:58:56 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:58:52 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Max Zhen <max.zhen@amd.com>, Liang Wendy
	<Wendy.Liang@amd.com>
Subject: [PATCH v2 12/12] iommu/amd: Don't detach SVA PASIDs from the mm release notifier
Date: Fri, 27 Nov 2026 11:54:47 +0000
Message-ID: <20261127115447.209792-13-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY6PEPF00000047:EE_|BY5PR12MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: 9672232e-2b27-4e54-bff5-08df4c7dd0ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|10067099003|11063799006|5023799004|56012099006|261028144727099003|261021121427099003|261022105027099003|261021123027099003|261009223027099003|261102123227099003|261022075727099003|261026140227099003|261026121527099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	BtgDHfQACfgfvEILi3J2JzYaWJ4/o/VRnbcFEY/7YtYLPNZx/VW6B6pTAtnyNhoq9/IywZqNzfrCQPHgAJ6y/cL6RYEyscYn+KIM7DrkbUme0BMAiPNE3L7IMN4FRi6axzO/k0toYj5SL0ZgJ5qpe/Eu0H+4jNFU+7/SPf7QPPTxqBLg2MZAMGF9wu4+axBVLtK6wgyKzNGIuFOPahI+/d1spBfn7+knTJc5NbWh4Zca/Q5D40lfh4Y43aBJD0C3NMoWc7zGXckcMCylYVkwm5zmitom4s7kNyNLLnX3QEOjdSMxrijfsP1Io6QGEbUiDIfEBG1Xc9d9HOjuKOdl2hvXSJ3nwv2B1GIZdxZMt1qq16jvAOLw9Tu23RVgbB9kXUpvRTEmarBm3FvTW9WSf4xP058SXdrjvns5wwvUmF8dHHbQ6lgcfrjFOrrF+J35PSiM+hvDfzQQaiPjBPUGsKr7s91N9XsYP4T5QTMJpcWUS8jNKMFtKpKcpjWLACQaNHQ6FXQULe24T2Eb9P/gpCl4QcDWPtrEV54rvka6LCduKVV0YeqS22EKmJcuHW7hFuZkj+pX35g9Yu0W+SVaNeu1DFG8sLOpgy7E3fKDgGWp++iohQYcCYn177qLch2bprkxJHC32YMChxYeSCMFWEXtM1+OcbiO04R8naIl/rgRBf1TbZCij+gJDtdeTY19Sf23xasIpCPmc2pECDfxSg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(5023799004)(56012099006)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022075727099003)(261026140227099003)(261026121527099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1A5gtjCNH0SwPis93rgOf5qPgyD9FGIRMGKVlG39GuXOAp8WNHOZEgv4uDm2MRWVmDPAKYaNsux3+BbbvWoYZrZz5TqoSu5quYQ3G5mg5dRdbM+FaYKWPKgJRLyjI8JWrvyfTCTZhkJlox837rqdzt7FCBhWD7Ek2YED19c9BNU7LjTNeeRtUBjPeQ5UG3PaTiRY+WHSX+R36SLpY/n73KhPUeU4oQe7P+6fIlIRf1Su1yXGsEchL36dLMq+xYCkcfCh1W6Y6RDFpLNog584aRRczlZ6lqFMIn4Z8LXpCK5Bap0k/7Tr68oF0EC9b+vDnXxVUcZQDa5azlxuqU5UtpfyzOJqLe6fA9/Th6otpnakc/WyikVJ/Kle2x7+AwSya2Qbf9BRoDhf428dEF3kBZ/R4nqlZofyyJwa7hXzZ/nliNU4+WN7z4g2eazxDamX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:58:56.4748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9672232e-2b27-4e54-bff5-08df4c7dd0ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF00000047.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115

sva_mn_release() runs when the mm page tables are about to be freed. It
calls remove_dev_pasid(), which invokes amd_iommu_clear_gcr3() without
the group mutex and trips its lockdep assertion. It also tears down the
PASID attachment and driver metadata behind the IOMMU core's back.

Stop removing the attachment from the notifier. The notifier only has to
keep the IOMMU from walking page tables that are about to be freed.
Leave pasid_cnt and pdom_dev_data intact and let the normal core-driven
detach take the group mutex, clear the entry and remove the attachment.

Do not clear the GCR3 entry in the notifier either. A cleared entry does
not produce a recoverable page request, so a device that still issues
PASID traffic would report an IOMMU error until amd_iommu_remove_dev_pasid()
runs. Instead, allocate dummy page table root, shared by all IOMMUs.
sva_mn_release() path replaces actual GCR3 pointer with dummy page table
root. A walk through the root faults instead of following freed memory.

Fixes: a5a91e54846d ("iommu/amd: Add SVA domain support")
Reported-by: Max Zhen <max.zhen@amd.com>
Cc: Liang Wendy <Wendy.Liang@amd.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  4 ++++
 drivers/iommu/amd/amd_iommu_types.h |  2 --
 drivers/iommu/amd/init.c            | 11 ++++++++++
 drivers/iommu/amd/iommu.c           | 32 +++++++++++++++++++++++++++++
 drivers/iommu/amd/pasid.c           | 13 ++++++++----
 5 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index bbfe92356b47..649643934112 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -76,6 +76,10 @@ void amd_iommu_iopf_remove_device(struct amd_iommu *iommu,
 int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
 		       ioasid_t pasid, unsigned long gcr3);
 int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid);
+int amd_iommu_set_gcr3_fault_pgd(struct iommu_dev_data *dev_data,
+				 ioasid_t pasid);
+int __init amd_iommu_sva_fault_pgd_alloc(void);
+void __init amd_iommu_sva_fault_pgd_free(void);
 
 /* PPR */
 int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 4b683026e9ef..1fa84559de02 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -452,8 +452,6 @@ extern bool amdr_ivrs_remap_support;
 /* Making iterating over protection_domain->dev_data_list easier */
 #define for_each_pdom_dev_data(pdom_dev_data, pdom) \
 	list_for_each_entry(pdom_dev_data, &pdom->dev_data_list, list)
-#define for_each_pdom_dev_data_safe(pdom_dev_data, next, pdom) \
-	list_for_each_entry_safe((pdom_dev_data), (next), &pdom->dev_data_list, list)
 
 #define for_each_ivhd_dte_flags(entry) \
 	list_for_each_entry((entry), &amd_ivhd_dev_flags_list, list)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 7301359dcf4a..b642cf6b4bcb 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2449,6 +2449,16 @@ static int __init amd_iommu_init_pci(void)
 		iommu_set_cwwb_range(iommu);
 	}
 
+	/*
+	 * iommu_init_pci() populates amd_iommu_efr from the IOMMU, so check
+	 * PASID support only after it runs.
+	 */
+	if (amd_iommu_pasid_supported()) {
+		ret = amd_iommu_sva_fault_pgd_alloc();
+		if (ret)
+			goto out;
+	}
+
 	/*
 	 * Order is important here to make sure any unity map requirements are
 	 * fulfilled. The unity mappings are created and written to the device
@@ -3279,6 +3289,7 @@ static struct syscore amd_iommu_syscore = {
 static void __init free_iommu_resources(void)
 {
 	free_iommu_all();
+	amd_iommu_sva_fault_pgd_free();
 	amd_iommu_pdom_id_destroy();
 	free_pci_segments();
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2ef7233c46c8..33bcc049fb2a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2048,6 +2048,38 @@ int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid,
 	return ret;
 }
 
+/* Dummy page table root, used in sva_mn_release() path */
+static void *sva_fault_pgd;
+
+int __init amd_iommu_sva_fault_pgd_alloc(void)
+{
+	sva_fault_pgd = iommu_alloc_pages_node_sz(NUMA_NO_NODE, GFP_KERNEL,
+						  SZ_4K);
+	return sva_fault_pgd ? 0 : -ENOMEM;
+}
+
+void __init amd_iommu_sva_fault_pgd_free(void)
+{
+	if (sva_fault_pgd)
+		iommu_free_pages(sva_fault_pgd);
+
+	sva_fault_pgd = NULL;
+}
+
+/*
+ * Point a still-attached PASID at the permanent zero root.
+ * pasid_cnt stays put; amd_iommu_clear_gcr3() drops the slot on detach.
+ */
+int amd_iommu_set_gcr3_fault_pgd(struct iommu_dev_data *dev_data,
+				 ioasid_t pasid)
+{
+	if (WARN_ON_ONCE(!sva_fault_pgd))
+		return -ENODEV;
+
+	return update_gcr3(dev_data, pasid,
+			   iommu_virt_to_phys(sva_fault_pgd), true);
+}
+
 int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 {
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index d0e2bf7921bf..6d126246d850 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -79,7 +79,7 @@ static void sva_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 
 static void sva_mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	struct pdom_dev_data *pdom_dev_data, *next;
+	struct pdom_dev_data *pdom_dev_data;
 	struct protection_domain *sva_pdom;
 	unsigned long flags;
 
@@ -87,9 +87,14 @@ static void sva_mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 	spin_lock_irqsave(&sva_pdom->lock, flags);
 
-	/* Assume dev_data_list contains same PASID with different devices */
-	for_each_pdom_dev_data_safe(pdom_dev_data, next, sva_pdom)
-		remove_dev_pasid(pdom_dev_data);
+	/*
+	 * The mm page tables are freed when this returns. Point each
+	 * still-attached PASID at the permanent zero root so a later
+	 * access faults instead of walking freed memory.
+	 */
+	for_each_pdom_dev_data(pdom_dev_data, sva_pdom)
+		amd_iommu_set_gcr3_fault_pgd(pdom_dev_data->dev_data,
+					     pdom_dev_data->pasid);
 
 	spin_unlock_irqrestore(&sva_pdom->lock, flags);
 }
-- 
2.31.1

