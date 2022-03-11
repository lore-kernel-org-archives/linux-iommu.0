Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB908C433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D7E74093A;
	Fri, 11 Mar 2022 09:53:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UglMt4BbpcKS; Fri, 11 Mar 2022 09:53:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2F63A408BF;
	Fri, 11 Mar 2022 09:53:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FB65C0012;
	Fri, 11 Mar 2022 09:53:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70DDCC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5150F408BF
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:53:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UoIHx00D9TLP for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:53:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::604])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A7BF40866
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6Dk6kkvlO6wo65XKpprzcTTLoe571otfkZteZaqfbB+hyci47V26XaWfElhKOHvfvkVQZA2Tn7bwyhRZ5Jn0rHk58pf50fu+mDxYQxAB2C4YXhIUsEJlX937veQjjSi+OltPmxBTkw1ny8ANe7PuILR8niG4cDEOJhyuSDZ7cHJbZCMYPShxaZ0lK4ruNeYrKzrFX9ts0rCUTiO8hWkYkStZLhCdVxK+XTix6WJMP9MC4jUk0ym/NWqX04f+UJXFJwRskwHmUBMsUab7b22M+WuWh+Wy1oCc9dufQUOCl6gPfSlECNcf/7qm+nqrKZ54wP0J1xVW35hlx5j+MsZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAVIjfqM9A8O2nDXw8h6F6nCfVsCThTANpEUyqf4k5k=;
 b=FvDmehhm2FgAiEo3k6JOJK2m1KSDcID8AHOEzaVV1Lo9rJ9GOuYkTG1hyi2GBl/0k8IjxEljNfJ7qfA/kp4guGAMSsKi1ABXTO/PObbdue7Ke9QDP50q6aShNOzIXMiw/cmokhtBlk5oMEcA49qRR+bu6LX0EVbeiEs5RAzlt0vxu1m0f44X9bZX5V4tkyppbsd/KIpDsSLNZ3eQuayjcp2A4i3JOMVNV3Eb1wVu6rkV7VTE/y8QfXwrTnkHwYPcfFuhin01TnSZE5ynwr2XH9CloxAmMHFVpgXigiV07epHlce7u2rilaC+61RPqkdT1ZlXRGkv8dZ2eMGRoXuA3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAVIjfqM9A8O2nDXw8h6F6nCfVsCThTANpEUyqf4k5k=;
 b=I3aWE3GtG7hruy/VlMvKuXgZbZ5YfB3N3c9d8YmSaSDUS5uT3Um1oxD/aJg7KX623utJDbu3Lqsbtp9sgvtSQ3G3wEK3kS6ikmGf7zrDQ2LRMAR70OnSdW1xBeuDbxHDRxVeszJLrxNB43v5iFdwQpxgLNY4A8CIvbWIE8Q7hG0=
Received: from BN9PR03CA0621.namprd03.prod.outlook.com (2603:10b6:408:106::26)
 by DM5PR1201MB0155.namprd12.prod.outlook.com (2603:10b6:4:55::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 09:53:18 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::67) by BN9PR03CA0621.outlook.office365.com
 (2603:10b6:408:106::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Fri, 11 Mar 2022 09:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:53:15 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:53:13 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 14/36] iommu/amd: Convert to use rlookup_amd_iommu helper
 function
Date: Fri, 11 Mar 2022 15:18:32 +0530
Message-ID: <20220311094854.31595-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 079863cb-c271-47b0-33c9-08da0344f706
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0155:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0155A4516517584767A7803A870C9@DM5PR1201MB0155.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAjJwz7X98bCmFGyqDH4pgff9VskKY358Qp/KAcccjl5hBlNOrDxzjP/7cAu9aRqwTqOLRxeT8EyLiC0WG8+mRoife8KWzdk/qiXvkeYvRcNPHAa/YWJRiF/RuOYuaex+GnbT7fp4/9LIqKTxOHvRnbwekOaEbcgfL0zjFdlSnNejvBcCrsyB+0/rufgkBWb31UexpeEVGLriywuBB51EelNUik7RrJWdMw7vuI1GayndwUuwqVsvw/agCFVi0yUKoqL7oAx8AiJvm/kF2W9xP2AlfPLz/Sb+Rszi0643L88gKctaG7/yr2t88FlfWzZCC3432PGKis97COvpEYA0xV1rEPi8h2NzB+HrKg2Ny6xp/+ELbrFO8uihuw0XncGZUd2sEAhSBHntgF6duYvxbU3Cc7UcQ3igPD9zwskUeLA/xOM1qXeHFiiI+Rq7J7qCItjCrqIpxVF0bw4MGUzFE+bQiYOSeg+R9UVP8H9QGKY4qjda6ZGpKFHnOB/UbLyL8H6AEQJ6b6g/sWo6g2h5ZMO85+dBY8ZUhRNeNwhsI8PDHeyE4ec/h+gBBJrGTjux9n5+tT9zKa/ZmnYYo243QV21yuYVGe2H6VhjfIfRcCbU9M7vLq++Wrb+FNs8gax0YCvEcZBOfDbdBR3S/BbUNuWwypJ90Jz0isM0BXT3GQj0KBEYW2dTSIxV45hFKWW0mRsPbQTvkWirmFirn9yLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(110136005)(5660300002)(54906003)(26005)(8936002)(40460700003)(2616005)(8676002)(16526019)(186003)(316002)(356005)(1076003)(81166007)(508600001)(70586007)(70206006)(6666004)(36860700001)(82310400004)(44832011)(47076005)(4326008)(86362001)(36756003)(2906002)(83380400001)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:53:15.9010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 079863cb-c271-47b0-33c9-08da0344f706
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0155
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
index e5867b27a47e..51cf83aa04c1 100644
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
@@ -1268,7 +1272,9 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 	int qdep;
 
 	qdep     = dev_data->ats.qdep;
-	iommu    = amd_iommu_rlookup_table[dev_data->devid];
+	iommu    = rlookup_amd_iommu(&dev_data->pdev->dev);
+	if (!iommu)
+		return -EINVAL;
 
 	build_inv_iotlb_pages(&cmd, dev_data->devid, qdep, address, size);
 
@@ -1292,7 +1298,9 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 	u16 alias;
 	int ret;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(&dev_data->pdev->dev);
+	if (!iommu)
+		return -EINVAL;
 
 	if (dev_data->pdev)
 		ret = pci_for_each_dma_alias(dev_data->pdev,
@@ -1519,8 +1527,8 @@ static void free_gcr3_table(struct protection_domain *domain)
 	free_page((unsigned long)domain->gcr3_tbl);
 }
 
-static void set_dte_entry(u16 devid, struct protection_domain *domain,
-			  bool ats, bool ppr)
+static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
+			  struct protection_domain *domain, bool ats, bool ppr)
 {
 	u64 pte_root = 0;
 	u64 flags = 0;
@@ -1539,8 +1547,6 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 		flags |= DTE_FLAG_IOTLB;
 
 	if (ppr) {
-		struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
-
 		if (iommu_feature(iommu, FEATURE_EPHSUP))
 			pte_root |= 1ULL << DEV_ENTRY_PPR;
 	}
@@ -1584,8 +1590,6 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 	 * entries for the old domain ID that is being overwritten
 	 */
 	if (old_domid) {
-		struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
-
 		amd_iommu_flush_tlb_domid(iommu, old_domid);
 	}
 }
@@ -1605,7 +1609,9 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	struct amd_iommu *iommu;
 	bool ats;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(&dev_data->pdev->dev);
+	if (!iommu)
+		return;
 	ats   = dev_data->ats.enabled;
 
 	/* Update data structures */
@@ -1617,7 +1623,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_cnt                 += 1;
 
 	/* Update device table */
-	set_dte_entry(dev_data->devid, domain,
+	set_dte_entry(iommu, dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
 	clone_aliases(iommu, dev_data->pdev);
 
@@ -1629,7 +1635,9 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(&dev_data->pdev->dev);
+	if (!iommu)
+		return;
 
 	/* Update data structures */
 	dev_data->domain = NULL;
@@ -1807,13 +1815,14 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
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
@@ -1843,13 +1852,14 @@ static void amd_iommu_probe_finalize(struct device *dev)
 
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
@@ -1878,7 +1888,7 @@ static void update_device_table(struct protection_domain *domain)
 
 		if (!iommu)
 			continue;
-		set_dte_entry(dev_data->devid, domain,
+		set_dte_entry(iommu, dev_data->devid, domain,
 			      dev_data->ats.enabled, dev_data->iommu_v2);
 		clone_aliases(iommu, dev_data->pdev);
 	}
@@ -2073,7 +2083,6 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
 				    struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
-	int devid = get_device_id(dev);
 	struct amd_iommu *iommu;
 
 	if (!check_device(dev))
@@ -2082,7 +2091,7 @@ static void amd_iommu_detach_device(struct iommu_domain *dom,
 	if (dev_data->domain != NULL)
 		detach_device(dev);
 
-	iommu = amd_iommu_rlookup_table[devid];
+	iommu = rlookup_amd_iommu(dev);
 	if (!iommu)
 		return;
 
@@ -2109,7 +2118,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	dev_data = dev_iommu_priv_get(dev);
 	dev_data->defer_attach = false;
 
-	iommu = amd_iommu_rlookup_table[dev_data->devid];
+	iommu = rlookup_amd_iommu(dev);
 	if (!iommu)
 		return -EINVAL;
 
@@ -2484,8 +2493,9 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 			continue;
 
 		qdep  = dev_data->ats.qdep;
-		iommu = amd_iommu_rlookup_table[dev_data->devid];
-
+		iommu = rlookup_amd_iommu(&dev_data->pdev->dev);
+		if (!iommu)
+			continue;
 		build_inv_iotlb_pasid(&cmd, dev_data->devid, pasid,
 				      qdep, address, size);
 
@@ -2647,7 +2657,9 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
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
