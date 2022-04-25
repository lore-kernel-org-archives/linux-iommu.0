Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DFEC433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65B04410A2;
	Mon, 25 Apr 2022 11:38:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z6jaOC29ZdoT; Mon, 25 Apr 2022 11:38:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D08EB4109E;
	Mon, 25 Apr 2022 11:38:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B824EC0039;
	Mon, 25 Apr 2022 11:38:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54824C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 32A4981A6F
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:38:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5HUvn1rQUVRu for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:38:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C64581A8E
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMVvhnXUGkA58Fo0esk2EOjH2v+I7cDCvAhflLhaLJcxkYEl/t/u/2hhC4+b0VjwUo6npp44sHbCFzn2qEbaFKN7bzUp8lMAFg92u6CS0v2FiEn870eSzy8wTsuva4+2ZCDtrfj5p+y8/F5oRu/xZV0RfjjWyMii94dWdKKyKzQ3VF+0bhX+oLCj4vKkaB3tPBAvtkhqaxt2I7P6A0CUZT80jaSvjLL6NsjfudZukEZtswsspri8C4Exz93XQxCgFZZ4vJ4Uv38BnMaLqnMSPMrQX0PIbjqKMqo3g1Th1fkznHyh4BplxGoGn4/xevR/R9NBiE22NfJUU5DAO3VOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z50/mLdr28RyrOp+l/PzUtAHXddCD9sC58FMA/wF6yY=;
 b=ezlhiOmDeXgkT4Af1nNKGSVr86s5ppgVm2tx5Bj3vkxnPCSHMbpUT/lFEZyh/6eJl6Z3hVBJUnxYC4+QGUL1vQxRRmBnmNCqFyQehu/Bl2Lcsqiw2GsBulF/24ELyuoSvMGbxbUrOVVExsait0v7ivB7FKbbGabbQfoV8JPlUCjXvjuVqKLR9sQV4gLMw2CTE+o9/mYGuCAFePimJ+zm885KositSYQXL1M6BSH+3J1fxwRsp5mrkpnmZFv825iXBrSc6qvKoNm4gCiYC3I9mFV0JPs/Xo8x4PxnOy4wKDPrcR/eBhOGk8daujdE3IojHyPqkGSgC8KvnEuk007ZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z50/mLdr28RyrOp+l/PzUtAHXddCD9sC58FMA/wF6yY=;
 b=en5Xv+O5QMOU3Cd0S8BLOMDC32aLbGECBDdMFdu79q5cCkqv/TfeUjbELXKrmutJ1KxKK1FEtYzM/vKsr0Sttlyr70Vnt9KJXzqtVaKJCV5Jh6ZgPyjxOmVsAnkT4W0Q+gdO3/VA3N/HLxgVabv1Am1r5/PZRJWBwOEYJdGi9MQ=
Received: from BN9PR03CA0614.namprd03.prod.outlook.com (2603:10b6:408:106::19)
 by MW2PR12MB2378.namprd12.prod.outlook.com (2603:10b6:907:f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 11:38:46 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::47) by BN9PR03CA0614.outlook.office365.com
 (2603:10b6:408:106::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 11:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:38:46 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:38:44 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 15/37] iommu/amd: Convert to use rlookup_amd_iommu helper
 function
Date: Mon, 25 Apr 2022 17:03:53 +0530
Message-ID: <20220425113415.24087-16-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 150d5c2c-a7e8-407d-f2c2-08da26b028b4
X-MS-TrafficTypeDiagnostic: MW2PR12MB2378:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB23788D1341863A79C4EDA58787F89@MW2PR12MB2378.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBkBd9ZIp9SbHBlDGjT9HbqdLYtPdyhVBoksysLkTgjeFRi+3+0htiZuBjOllz3VjSVQjq9J+yVp8C4aH3p8EnGhR4ob5C4z6bIwOns1qg97kEc04zdsvM+gv0h3Y73I4+J0UjkzulREWNRxEA2CT4lpWIgd01u7VksnD3MpTRMDX8NXyDMkZ0r7GIFz6SysXtapkmyZkKYbdXdevlEscC/Cklu8KZnCqdlyTGoNeyfiFNXxnWA+XtJsfU7WmQsZSIwi4Q7787jPCmzIWZU2i/3XcxeUzLnS7qy2pXf30pdG+flGv8zJ8gPMpbkTcyECup3zGJ5+FUsh6KxqovtqxvG3iwfgny6zY01ABjBVcmqcqcKYvfPv2+Swls58xPD+7iPuHoh03/s2F1bq6d4gLm2KKK/Cp+xqtunbihz05Bwli0neFxj50yh4RVaFxQUxk9GAKLv8nfCqctsVNn+XMHB9XHAJtjDb+iwPK6NN9ItJEg63ZxNl5FncYzPItTSLwb8jWPKVWJjG2XUVtE84HYN/ATjlbLepCd+0QPtG25TilJvPsmuzR3VeL58FADd6HBhRr+rekRQE/8jn0+i6kIT8oJl3cRdcBYmcMKQKEfOqS1FWZCNlyvrXppe82Y2tNOEJKiUx/FG7R3IPRxDZAnzV/z/Rv4s4yc4L4GyjK1sZAW4Togy0o/Kh/1y1rKYIwgkv9p7FEhfNsBfmfIgG6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(83380400001)(40460700003)(82310400005)(508600001)(36756003)(336012)(26005)(44832011)(8936002)(81166007)(6916009)(5660300002)(86362001)(36860700001)(47076005)(426003)(2906002)(2616005)(1076003)(4326008)(6666004)(8676002)(54906003)(70586007)(356005)(16526019)(186003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:38:46.4768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 150d5c2c-a7e8-407d-f2c2-08da26b028b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2378
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Use rlookup_amd_iommu() helper function which will give per PCI
segment rlookup_table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 64 +++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a105ccacce91..445f583795c3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -229,13 +229,17 @@ static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid
 
 static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
+	struct amd_iommu *iommu;
 	u16 devid = pci_dev_id(pdev);
 
 	if (devid == alias)
 		return 0;
 
-	amd_iommu_rlookup_table[alias] =
-		amd_iommu_rlookup_table[devid];
+	iommu = rlookup_amd_iommu(&pdev->dev);
+	if (!iommu)
+		return 0;
+
+	amd_iommu_set_rlookup_table(iommu, alias);
 	memcpy(amd_iommu_dev_table[alias].data,
 	       amd_iommu_dev_table[devid].data,
 	       sizeof(amd_iommu_dev_table[alias].data));
@@ -366,7 +370,7 @@ static bool check_device(struct device *dev)
 	if (devid > amd_iommu_last_bdf)
 		return false;
 
-	if (amd_iommu_rlookup_table[devid] == NULL)
+	if (rlookup_amd_iommu(dev) == NULL)
 		return false;
 
 	return true;
@@ -1270,7 +1274,9 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 	int qdep;
 
 	qdep     = dev_data->ats.qdep;
-	iommu    = amd_iommu_rlookup_table[dev_data->devid];
+	iommu    = rlookup_amd_iommu(dev_data->dev);
+	if (!iommu)
+		return -EINVAL;
 
 	build_inv_iotlb_pages(&cmd, dev_data->devid, qdep, address, size);
 
@@ -1295,7 +1301,9 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 	u16 alias;
 	int ret;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(dev_data->dev);
+	if (!iommu)
+		return -EINVAL;
 
 	if (dev_is_pci(dev_data->dev))
 		pdev = to_pci_dev(dev_data->dev);
@@ -1525,8 +1533,8 @@ static void free_gcr3_table(struct protection_domain *domain)
 	free_page((unsigned long)domain->gcr3_tbl);
 }
 
-static void set_dte_entry(u16 devid, struct protection_domain *domain,
-			  bool ats, bool ppr)
+static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
+			  struct protection_domain *domain, bool ats, bool ppr)
 {
 	u64 pte_root = 0;
 	u64 flags = 0;
@@ -1545,8 +1553,6 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 		flags |= DTE_FLAG_IOTLB;
 
 	if (ppr) {
-		struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
-
 		if (iommu_feature(iommu, FEATURE_EPHSUP))
 			pte_root |= 1ULL << DEV_ENTRY_PPR;
 	}
@@ -1590,8 +1596,6 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 	 * entries for the old domain ID that is being overwritten
 	 */
 	if (old_domid) {
-		struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
-
 		amd_iommu_flush_tlb_domid(iommu, old_domid);
 	}
 }
@@ -1611,7 +1615,9 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	struct amd_iommu *iommu;
 	bool ats;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(dev_data->dev);
+	if (!iommu)
+		return;
 	ats   = dev_data->ats.enabled;
 
 	/* Update data structures */
@@ -1623,7 +1629,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_cnt                 += 1;
 
 	/* Update device table */
-	set_dte_entry(dev_data->devid, domain,
+	set_dte_entry(iommu, dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
 	clone_aliases(iommu, dev_data->dev);
 
@@ -1635,7 +1641,9 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(dev_data->dev);
+	if (!iommu)
+		return;
 
 	/* Update data structures */
 	dev_data->domain = NULL;
@@ -1813,13 +1821,14 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 {
 	struct iommu_device *iommu_dev;
 	struct amd_iommu *iommu;
-	int ret, devid;
+	int ret;
 
 	if (!check_device(dev))
 		return ERR_PTR(-ENODEV);
 
-	devid = get_device_id(dev);
-	iommu = amd_iommu_rlookup_table[devid];
+	iommu = rlookup_amd_iommu(dev);
+	if (!iommu)
+		return ERR_PTR(-ENODEV);
 
 	if (dev_iommu_priv_get(dev))
 		return &iommu->iommu;
@@ -1849,13 +1858,14 @@ static void amd_iommu_probe_finalize(struct device *dev)
 
 static void amd_iommu_release_device(struct device *dev)
 {
-	int devid = get_device_id(dev);
 	struct amd_iommu *iommu;
 
 	if (!check_device(dev))
 		return;
 
-	iommu = amd_iommu_rlookup_table[devid];
+	iommu = rlookup_amd_iommu(dev);
+	if (!iommu)
+		return;
 
 	amd_iommu_uninit_device(dev);
 	iommu_completion_wait(iommu);
@@ -1884,7 +1894,7 @@ static void update_device_table(struct protection_domain *domain)
 
 		if (!iommu)
 			continue;
-		set_dte_entry(dev_data->devid, domain,
+		set_dte_entry(iommu, dev_data->devid, domain,
 			      dev_data->ats.enabled, dev_data->iommu_v2);
 		clone_aliases(iommu, dev_data->dev);
 	}
@@ -2079,7 +2089,6 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
 				    struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
-	int devid = get_device_id(dev);
 	struct amd_iommu *iommu;
 
 	if (!check_device(dev))
@@ -2088,7 +2097,7 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
 	if (dev_data->domain != NULL)
 		detach_device(dev);
 
-	iommu = amd_iommu_rlookup_table[devid];
+	iommu = rlookup_amd_iommu(dev);
 	if (!iommu)
 		return;
 
@@ -2115,7 +2124,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	dev_data = dev_iommu_priv_get(dev);
 	dev_data->defer_attach = false;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(dev);
 	if (!iommu)
 		return -EINVAL;
 
@@ -2491,8 +2500,9 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 			continue;
 
 		qdep  = dev_data->ats.qdep;
-		iommu = amd_iommu_rlookup_table[dev_data->devid];
-
+		iommu = rlookup_amd_iommu(dev_data->dev);
+		if (!iommu)
+			continue;
 		build_inv_iotlb_pasid(&cmd, dev_data->devid, pasid,
 				      qdep, address, size);
 
@@ -2654,7 +2664,9 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 	struct iommu_cmd cmd;
 
 	dev_data = dev_iommu_priv_get(&pdev->dev);
-	iommu    = amd_iommu_rlookup_table[dev_data->devid];
+	iommu    = rlookup_amd_iommu(&pdev->dev);
+	if (!iommu)
+		return -ENODEV;
 
 	build_complete_ppr(&cmd, dev_data->devid, pasid, status,
 			   tag, dev_data->pri_tlp);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
