Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8187C433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72102611EA;
	Fri, 11 Mar 2022 09:59:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IEUvVl0mbHnC; Fri, 11 Mar 2022 09:59:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3503060D80;
	Fri, 11 Mar 2022 09:59:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18547C0012;
	Fri, 11 Mar 2022 09:59:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5199C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D33CA4018A
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:59:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d_PoWq74S8Mm for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:59:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA1CE40521
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaaLtRhqOG+fH34PTCT9qnWa9LXOnqlBivcEF+vEOrUfgw/Qo409OHEKINu/GmPbuBRzeb4JRWghxf+4bYzjOFK30571ctUWIY1bsKZnSdT8zbXTU8FKAQpVI+GOy4XAIeH4nVNRqp69up8OkDfHiab+QZnnnA04NP4W2mQGPDFSHTROWGRZ6qirwuyTWa2720ZEXW1dThG69e+/vG+LGpq/eb2udrPV1cETF2qyPPTnlLeMgZL7IJV7h/a4t9ggqlf1aLQWBu9qfHSu1y9pXJGVN0+L7xAdi0h9B1QR9MflEj71wU9ujkHy9jFZzatbVes2QFgQx7NLHUbEuXhRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmjqR77T7V0anYKRGWpYdfx/JY2bPCUZYOAb3upeSHQ=;
 b=ErnM7WFn5zZYK7WWE511JfUdEFTC9KSC+IRxcufVNLwWsSQQaknKpCRDHH70++/6kGFPm6ldNOAt3yrJ22ooF1CD8W93enhtI0yYcDKNGBUKzX7UCHvbszJ4KaowKw14YE5NUoaA9tRU8Gqh1Lk+aXstftQ8tIz7bEyO0hdMLAdV9UkztKJba5A6VmNGp8xbmNUUjcYuEd/Kt1vaAi20fLrRqaJ0mvK895OJ3GPIKlnC+GG4wWp66YmJW2LD7REynDth4s45S8UQOFSeVElU3YDFi72aPCp4iY3szVjqdzQ9sLz/VDgog9nl50y8l7saks3wofjO+1Jv3HIHVNdmUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmjqR77T7V0anYKRGWpYdfx/JY2bPCUZYOAb3upeSHQ=;
 b=WSI/Li1xql9FEV7jOX4f7SVY29q0lKH+YoFY9AuU/VWf6jh4Lvo3wDH49nNMFn5FIdbdxep8ZYsjJqVIwlIPp8//mAyZa58WMjOz5nxMpCyL5jUowEasaZ8XqP+zg40u63jxifIj2pgqonAkVlN64phEo4FezJvBU3t6y+NyXZc=
Received: from DM5PR15CA0043.namprd15.prod.outlook.com (2603:10b6:4:4b::29) by
 BN8PR12MB3028.namprd12.prod.outlook.com (2603:10b6:408:43::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.22; Fri, 11 Mar 2022 09:59:49 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::ad) by DM5PR15CA0043.outlook.office365.com
 (2603:10b6:4:4b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24 via Frontend
 Transport; Fri, 11 Mar 2022 09:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:59:48 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:59:46 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 29/36] iommu/amd: Flush upto last_bdf only
Date: Fri, 11 Mar 2022 15:18:47 +0530
Message-ID: <20220311094854.31595-30-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffc3e3a9-5464-48b1-88a4-08da0345e0bf
X-MS-TrafficTypeDiagnostic: BN8PR12MB3028:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB30289AB91F7C1AD671C05E8B870C9@BN8PR12MB3028.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jj7vp4cH9f6ZzKK/0xmF0XhDd/kNsMRc+QeXKCw/+pL9mup/PudUrfVTxUHdlYej6vI3/ff+l0EXJH0wZ1xyt4P2QklsEbBCkeNTf5RuTvncyTzNSvWsIUot+ufIW8/PW7rb8v5Jvbbxpeu6Z3odeSA7vK2y8a4z30y3o5RvjehoBV+ooI+zzYkCjcdK8t15YaAohNrMCqiC1hIvDJ/TkQxuaW1CU71SyfF1ET2HSKae/EPgtwZpHvcQa6fMkb5GIdh5RUiKnG1enE1E84jbjMvdU8O5ecvZCo8ywQ8R8daBKOklCpO1e5XPDfiyCZh/+Hq4oUf1fDmWuR/eDqX5f33L3ISZZwR18umLkMLsLW7vDBljmS2VgH6Nm1HmzNZPLyyahIMYxCUWc4hKL7QoqPaKIV2i0Q5DsPtMq/HXmni6VRhAxeM8tkslRjtpz4sX5gBZt5OF9iLjCDg2T+UykJwRHrosj7YxCjDqlZ0uCPf0PL1SOD8nITApnIeMFGmy6YGKxCfVs9N04fF+Dzd8fhAR5FFNTs7XttCUhd/vV6l3hMZf6LMR+2d+3tle9yEFgelrGt3e8hQSRq8RUse+lqQJnl31OHmHKUngefOW2wPoCWGQzObj3m6NXrXNzzDv43CBHUynSsQj8CKWbIGQ9rRjiTmXSPjdFrwYqn3nCYtjW/ooYYZ+rFCfxorC1GriN0s7mUcqhb41VEgT0Qh87Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(40460700003)(81166007)(47076005)(8936002)(2616005)(5660300002)(110136005)(82310400004)(54906003)(356005)(26005)(316002)(44832011)(86362001)(1076003)(83380400001)(186003)(70586007)(36860700001)(16526019)(70206006)(508600001)(426003)(336012)(4326008)(36756003)(8676002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:59:48.3528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc3e3a9-5464-48b1-88a4-08da0345e0bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3028
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

Fix amd_iommu_flush_dte_all() and amd_iommu_flush_tlb_all() to flush
upto last_bdf only.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c4e17f11fcf8..d44f2cfa5b3d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1189,8 +1189,9 @@ static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 {
 	u32 devid;
+	u16 last_bdf = iommu->pci_seg->last_bdf;
 
-	for (devid = 0; devid <= 0xffff; ++devid)
+	for (devid = 0; devid <= last_bdf; ++devid)
 		iommu_flush_dte(iommu, devid);
 
 	iommu_completion_wait(iommu);
@@ -1203,8 +1204,9 @@ static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 {
 	u32 dom_id;
+	u16 last_bdf = iommu->pci_seg->last_bdf;
 
-	for (dom_id = 0; dom_id <= 0xffff; ++dom_id) {
+	for (dom_id = 0; dom_id <= last_bdf; ++dom_id) {
 		struct iommu_cmd cmd;
 		build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
 				      dom_id, 1);
@@ -1247,8 +1249,9 @@ static void iommu_flush_irt(struct amd_iommu *iommu, u16 devid)
 static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 {
 	u32 devid;
+	u16 last_bdf = iommu->pci_seg->last_bdf;
 
-	for (devid = 0; devid <= MAX_DEV_TABLE_ENTRIES; devid++)
+	for (devid = 0; devid <= last_bdf; devid++)
 		iommu_flush_irt(iommu, devid);
 
 	iommu_completion_wait(iommu);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
