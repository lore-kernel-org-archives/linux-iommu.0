Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CBBC433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 09:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 46E0740376;
	Mon,  4 Apr 2022 09:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fK5ofuai78_6; Mon,  4 Apr 2022 09:47:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DE80E40183;
	Mon,  4 Apr 2022 09:47:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1C2CC002C;
	Mon,  4 Apr 2022 09:47:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7FD3C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9791240423
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ruqgro6FIrlK for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 09:47:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::624])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD09540376
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZjC+sinL57uFjacYU2/x9kS9rxj+bsOS+N1Nf3jKk7Z2ZUlvzfpdM37LSZHSEYuf523eTpUkl5dTGAv2yJmve1YLyfcYjGM6E339gwuP7EudeKY9mjKrKTp3kEcRk0zL5632ctVemipQ2cgGspcBdJrLCIlGQzbqcsjWx6dNpHNr42LJR/DMRglEVa5Pp7UizaKNUQC9YDiJ3N7xtuSPrne2byMxgjCPgL+qaFUoCr/ARGx6nBCgSDeE574It6a7b8CD8KB8rQyw4PEb9+5qH9kRqEdl+zaxNJTgFiymlj0c3Viywv9YEFEt8lViLEGRnM+Ag8Djli/RHsmCXws+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yp1tzps46R+86dTf+1hOpx/53j6VSrnRRL2gyo7ASpU=;
 b=NbasOe8djNoQF5PW5lS8/xJ5LE61VkVnkR8PsJU48a2CWPpk3+LoiHCfxBPVBqM4qEMKWfEqvyDGZMFJ/hkdokSTs9d5grF84wny94qH+dAlEqGKvB659WU83b+V9GEiDCkadplaHjQuYbu1UDwTulAtU+MFSUEFhJi/vw38EaiIDWpbgvLv4gXcSpdeMSoJ9SrVbJmlj2sKwYBIrcLJPTFwfuufapnInwy8vSDQ3K1QdWHHbgfT83K7DdB71r/IB669d+qDtp6DZpviPlY1x7JaceRjF1AxCtMYUoaKKeXOz2XCRx2QuQvT5lXtX1m2bHcX0EI+MGT+HH4IscQ/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yp1tzps46R+86dTf+1hOpx/53j6VSrnRRL2gyo7ASpU=;
 b=ExCd3RJrbg90qDqcxwS9rL6gRA+bBk634rKwAxXQWneAlcHrlqeCK06nsuwCo1lHU+dMJHx0am0KvtJbAJkSE7b7oIQwJQsu64kwkWsRTL248tOLchjVZJ5deD7hzdOmrhYt67ahiygzYK6QGsbH9GyMG0gl0Ry51XvyTzv5ouk=
Received: from DM6PR21CA0004.namprd21.prod.outlook.com (2603:10b6:5:174::14)
 by BN6PR12MB1859.namprd12.prod.outlook.com (2603:10b6:404:ff::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 09:47:04 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::78) by DM6PR21CA0004.outlook.office365.com
 (2603:10b6:5:174::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.2 via Frontend
 Transport; Mon, 4 Apr 2022 09:47:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 09:47:04 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 04:47:01 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [PATCH v1 15/37] iommu/amd: Convert to use rlookup_amd_iommu helper
 function
Date: Mon, 4 Apr 2022 15:11:07 +0530
Message-ID: <20220404094129.323642-16-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404094129.323642-1-vasant.hegde@amd.com>
References: <20220404094129.323642-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 675e2966-d64f-4792-145f-08da16201334
X-MS-TrafficTypeDiagnostic: BN6PR12MB1859:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB185930EFD746975AE2DC795387E59@BN6PR12MB1859.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTs/sGjVmDk4q/ofynR9/Xt5GWyv+/Yq+/7e/IkAwjCpZ5NlqxVjJomBRR51DPymIeJwmo11dyn6gJk22zXcA0krofu7oSbPz43Wmly0kcJBDfj2XIgNoCknr/yx3MiKFi+/DTGjemcgWRwR0iS60jJNrGE8xNk46BXNGo3BmAKIbCzRSSNx2y9PcbW4FUCRQxMKE6+8bJF9mrhCe6+aF1KfBHLbIdbEQxpqWE2b61zjn6j5UA64nMQPPp9vndvqHBc/NbxZk1RHdQD/dFGI0Rl33MzrJ9FnjC9R7kls0GeJHiwtCy64PVPoRIWdD+3sYwO8e9jXstegu33CJnY0ag40SDotlG/2cTVDtAzi+jPzSN3X2aVFpbJpRjf2PkxxDfW9BS0ETvT4/+0Q+SnxBJHCj73jHAYLYxj9CPk3YP+FeU3RvqlemxnlPgESRFsJX+pVVry0oXs8CGkX3DteVpp1mPeSvdg9CVfFRfiAuvZnnwy8HB5YmiWHgy4KwIHXTbiSYKn8i+7ojARgkfrCOyL04R1kFNee3yJX/CPSVwFEQh9l4QEkmnO9+I5mvG5zQSE1MLUmgGNQctYtxshmoBmPt/ksh4gYexkTXhZOS2hSZbm28Mh83fXoQ6X88GGtJH1QW/2oWOXFJGIjLrjpQZUuyOzbFpmx0JlhokcN6LQGXfyfoEvtxnGW2gE702AyjcrL1XfWhCm9/jIF5bemoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(508600001)(36860700001)(47076005)(2616005)(82310400004)(2906002)(44832011)(40460700003)(54906003)(1076003)(83380400001)(316002)(356005)(81166007)(36756003)(70206006)(16526019)(8676002)(70586007)(110136005)(4326008)(186003)(26005)(426003)(336012)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 09:47:04.2197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 675e2966-d64f-4792-145f-08da16201334
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1859
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
index 2c18f45fc13d..cc200bfaa8c4 100644
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
@@ -365,7 +369,7 @@ static bool check_device(struct device *dev)
 	if (devid > amd_iommu_last_bdf)
 		return false;
 
-	if (amd_iommu_rlookup_table[devid] == NULL)
+	if (rlookup_amd_iommu(dev) == NULL)
 		return false;
 
 	return true;
@@ -1269,7 +1273,9 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 	int qdep;
 
 	qdep     = dev_data->ats.qdep;
-	iommu    = amd_iommu_rlookup_table[dev_data->devid];
+	iommu    = rlookup_amd_iommu(dev_data->dev);
+	if (!iommu)
+		return -EINVAL;
 
 	build_inv_iotlb_pages(&cmd, dev_data->devid, qdep, address, size);
 
@@ -1294,7 +1300,9 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 	u16 alias;
 	int ret;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(dev_data->dev);
+	if (!iommu)
+		return -EINVAL;
 
 	pdev = to_pci_dev(dev_data->dev);
 	if (pdev)
@@ -1522,8 +1530,8 @@ static void free_gcr3_table(struct protection_domain *domain)
 	free_page((unsigned long)domain->gcr3_tbl);
 }
 
-static void set_dte_entry(u16 devid, struct protection_domain *domain,
-			  bool ats, bool ppr)
+static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
+			  struct protection_domain *domain, bool ats, bool ppr)
 {
 	u64 pte_root = 0;
 	u64 flags = 0;
@@ -1542,8 +1550,6 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 		flags |= DTE_FLAG_IOTLB;
 
 	if (ppr) {
-		struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
-
 		if (iommu_feature(iommu, FEATURE_EPHSUP))
 			pte_root |= 1ULL << DEV_ENTRY_PPR;
 	}
@@ -1587,8 +1593,6 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 	 * entries for the old domain ID that is being overwritten
 	 */
 	if (old_domid) {
-		struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
-
 		amd_iommu_flush_tlb_domid(iommu, old_domid);
 	}
 }
@@ -1608,7 +1612,9 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	struct amd_iommu *iommu;
 	bool ats;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(dev_data->dev);
+	if (!iommu)
+		return;
 	ats   = dev_data->ats.enabled;
 
 	/* Update data structures */
@@ -1620,7 +1626,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_cnt                 += 1;
 
 	/* Update device table */
-	set_dte_entry(dev_data->devid, domain,
+	set_dte_entry(iommu, dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
 	clone_aliases(iommu, dev_data->dev);
 
@@ -1632,7 +1638,9 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(dev_data->dev);
+	if (!iommu)
+		return;
 
 	/* Update data structures */
 	dev_data->domain = NULL;
@@ -1810,13 +1818,14 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
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
@@ -1846,13 +1855,14 @@ static void amd_iommu_probe_finalize(struct device *dev)
 
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
@@ -1881,7 +1891,7 @@ static void update_device_table(struct protection_domain *domain)
 
 		if (!iommu)
 			continue;
-		set_dte_entry(dev_data->devid, domain,
+		set_dte_entry(iommu, dev_data->devid, domain,
 			      dev_data->ats.enabled, dev_data->iommu_v2);
 		clone_aliases(iommu, dev_data->dev);
 	}
@@ -2076,7 +2086,6 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
 				    struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
-	int devid = get_device_id(dev);
 	struct amd_iommu *iommu;
 
 	if (!check_device(dev))
@@ -2085,7 +2094,7 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
 	if (dev_data->domain != NULL)
 		detach_device(dev);
 
-	iommu = amd_iommu_rlookup_table[devid];
+	iommu = rlookup_amd_iommu(dev);
 	if (!iommu)
 		return;
 
@@ -2112,7 +2121,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	dev_data = dev_iommu_priv_get(dev);
 	dev_data->defer_attach = false;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(dev);
 	if (!iommu)
 		return -EINVAL;
 
@@ -2488,8 +2497,9 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 			continue;
 
 		qdep  = dev_data->ats.qdep;
-		iommu = amd_iommu_rlookup_table[dev_data->devid];
-
+		iommu = rlookup_amd_iommu(dev_data->dev);
+		if (!iommu)
+			continue;
 		build_inv_iotlb_pasid(&cmd, dev_data->devid, pasid,
 				      qdep, address, size);
 
@@ -2651,7 +2661,9 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
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
