Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210B7C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9E59607F7;
	Mon,  4 Apr 2022 10:04:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eD-oEr0RvFQs; Mon,  4 Apr 2022 10:04:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 99C61607F4;
	Mon,  4 Apr 2022 10:04:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75170C002C;
	Mon,  4 Apr 2022 10:04:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F05BDC0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D117B81A16
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ofxzfaIgND_A for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:04:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 90D1F81A0D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fu7xqPlTo54NqIqQfYkpR7cfE5mkgOVUsghJCg5kX92K1M/vkc2uvzeu8puqtseUSV+BY/h7BWtyUSkuhn3hYenrBH4Ot7Nu/3WzGUJzv1DLnssr2XjZxcb6fvzr7IqcIR/2EFVH1QfG4T5ekSfgz9KyN7MyjN4QPwRqoLJVchuhDABH0UW9lPApJDsUT0bHlBAc0mH0Td1y6WM+/dOgWaRP7aBPDNWHkBSCdoZqL7kTQd90jmAbLUM60JveLpR/OwQYrKnC8Qbty0u+2RuAJQmcg0WXi9BIH3R1p23hxslAgo/hi+ZB40uui9YyRWjwpd8jFTrU3sE6S/nUMdpr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yp1tzps46R+86dTf+1hOpx/53j6VSrnRRL2gyo7ASpU=;
 b=ZJgR1H/IMeta+/2VLGm1/Cfd0+civwnIiE3PIJ4ft3fxItCBVwnOHyjHdImXUNytW8XktbSmusiCTQ9PaM3B5q47EMJ2jqfW3XhG+zJaRqEvo31bmnjqKkC8ucQ3GZROls1MdsHI82VSosicC6I2lqyAE5pxHkihOUYl/OU/mlioyeqp6uEAMOb76veAGThZLK/2VlIYZ1uHrR47jOpHXTFsbwVjMTfSLUNX3IVGSjbl+Sa6rac8W6d7IDCdIhEW9kk4f9vkFVB/8iKvp4J9+KuW1QCl63zJxdpbPWqIobYrh0tb9G9fvScAFo2sYnSez3cWFkQCvJJB6wAhwmyA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yp1tzps46R+86dTf+1hOpx/53j6VSrnRRL2gyo7ASpU=;
 b=I0+lCedAldPz7gaShBaQ8stbhivwX+UdaLTmVc1mpl3L87zQW48bwQShEEKXpI5TlIUxAWTQn7GtWkrDSMqH5PouT7uQ2pNxHJCYwUgo4oB2KmZFp44f9UlwajxVgIgWchli/8Dfl/nb01N5rByJKprIv4ae2Iqxeij8ocgeQ40=
Received: from BN6PR22CA0040.namprd22.prod.outlook.com (2603:10b6:404:37::26)
 by SN6PR12MB2670.namprd12.prod.outlook.com (2603:10b6:805:6b::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:04:35 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::8c) by BN6PR22CA0040.outlook.office365.com
 (2603:10b6:404:37::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:04:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:04:34 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:04:32 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 15/37] iommu/amd: Convert to use rlookup_amd_iommu
 helper function
Date: Mon, 4 Apr 2022 15:30:01 +0530
Message-ID: <20220404100023.324645-16-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8647d123-be94-4466-b93b-08da1622856b
X-MS-TrafficTypeDiagnostic: SN6PR12MB2670:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2670CBA04D342BD87DA3107487E59@SN6PR12MB2670.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1N7nadtrVwUrRnX9jtIbxFDZmMXplBROVjLsno6Jm2g/DwVmgnzVOf57hUT0JNm4yweTv3q1DBphSLfvtXtcE/jkSFO+RrqeRdNS+eMF6PVvihzUQr1/Sao4c4s38bhouUzvAPzlY0l1vXHbAaMFgZxqXBeH5k4sq7XGv1Cj5T4Pff+iHbd8oagOg2b61bXe2Cnm3/pb5udrffHWwNTIxRxwi+0LpB7i60yoJCfHkKqYVWOzuouLKvSVrC+zprt2m1Q2/yOmab7tzG8uBb77TAoUQVpQNTsGxKrMCkyG86+YqfFjHV8AQUDdSOGFbTxBkF37nCKVesfBKh30gNgaR3HwbYBVjk+Rjn11Bok3s309I7+aYT3LzQh8wZ9YFTvX6/P4Kcn77SHrOiUexviIezN/ioSoqYyzZqXEwafGK/+P01OGlpQ7NFKqlF8biDfODHdLL+miQ+yPHZCN3sDeP/JWJUdcc1cj/xmVk1gsVSRrvP0YURqNtEbfmq1zNN+j+Fm2+Uo0kisQafF2pSTm7wjlXgJfAiOvnGsi1YT9dkh6B1zECSy4+RTaKX1K+I6Q4RZrCBm7opIprHfEon+Goiv8z30MKhSlR9aaAfg12BHZWgYOXTPkDelFUmwzAErD8wsFdl6rTFtUmdCxj2tf9cnqEYZrM77CSSYoZbkAI+/g7lHX5hQD1No/n20XoFCFX1qNt/FNJOQLbjVB5yVsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(4326008)(70586007)(36860700001)(70206006)(110136005)(81166007)(86362001)(186003)(426003)(336012)(16526019)(36756003)(26005)(2906002)(1076003)(2616005)(54906003)(47076005)(316002)(356005)(6666004)(8936002)(40460700003)(44832011)(83380400001)(5660300002)(508600001)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:04:34.8850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8647d123-be94-4466-b93b-08da1622856b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
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
