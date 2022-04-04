Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F45BC433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDD5882B24;
	Mon,  4 Apr 2022 10:08:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s_mX5gxrBHz1; Mon,  4 Apr 2022 10:08:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D27A182B21;
	Mon,  4 Apr 2022 10:08:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB539C002C;
	Mon,  4 Apr 2022 10:08:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C9B9C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ECC8882B24
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:08:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T96YeHBv69lP for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:08:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F13082B21
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:08:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S16mULNGP8Iveia4SNqHSTPJ93tahMJ0M4a2E+s7PpymPgjaTlw90mCbpW7fRucO5GlWIOpg2hsVzKswrqAxB5L54oBd5fFOrj5Wie4OnBUfxdNkSZ6XhGyhOGjT8WDzdFFpIoNqzanRuaBZn1Qb9/PcVqbem4wwyK+d6KJoQFahYMQxVDDHzvClVWFhqokXTF9uMPz5mieZuitRMMdRBxH8YJW21IrUN3l0IrCbG0jGsuWyiJbg4MPwv6fc/V7veXvVoOTe2hPW62TNGgBIdnPh9d9lz26D1fQDKTzFpZMZuhQCUunpuDV2a7W0DQG5KejO7AKtPR6KF8+/4njASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAM3SCUrsHIATpSf7uTmK+jT0jugHatWXfn7OU69e/c=;
 b=Z80COn9ZKDn0y+PnOlU+PYWxvx8gP2FlllWKtMjUxvgDM9tXzpOlKil91pBAkWfaD0sG9W4IwQpEfq2f5BhXiBycOEVoTq6kUvbFP+CqUleRDAAZ7Fokkqiann3q4GrdglYe08t2FV1AFmnGvJNkZrw84f0U6YgcgNXIhPzR62wtm4bmKgrO31RihARTkvK+f50e94kvBZfZ5iLmKIEF+Yt/2H24HhTAds71ALPDUYsDhi6GOwzNaFEZRCDaYghrJeyZJG4Ik5/84huOuvIZJ1eqtMbKmlwv+JYOO0GC5Zej1OBpa4T+aC3AeTQEAOhqp2DjYT8wPP4EhUPmSkidpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAM3SCUrsHIATpSf7uTmK+jT0jugHatWXfn7OU69e/c=;
 b=PvRD6pnd75CgkvzzcqaYnKio6MSTghMOo4dNlKh4S4cJDNK4WPV4YT8LoGMKhrwVzr80nHerL2BXOCULjldL8qjGbGKzptXCm2Z614KhiGzv2rHwUQnFVUo8fGDVidREiBhzgDJSPHn3M6+ysSAXiLPmyLqbXMZ+eMnKeVg7s9A=
Received: from MW2PR16CA0054.namprd16.prod.outlook.com (2603:10b6:907:1::31)
 by MW2PR12MB2363.namprd12.prod.outlook.com (2603:10b6:907:f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:08:21 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::e) by MW2PR16CA0054.outlook.office365.com
 (2603:10b6:907:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:08:21 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:08:17 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 30/37] iommu/amd: Flush upto last_bdf only
Date: Mon, 4 Apr 2022 15:30:16 +0530
Message-ID: <20220404100023.324645-31-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d76ff8f-50e7-48e1-f92d-08da16230c52
X-MS-TrafficTypeDiagnostic: MW2PR12MB2363:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB236367E4DDBA47449CF76DBC87E59@MW2PR12MB2363.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MhQlAvaNf96cV+HnlAM0UrvCoT9Lp0wczjIIhtKexkvPmUeOFhpsdx44FtQgT+7G82Q3ut6BMr+2a2Vk45e6i+ZAGmjl3a1MdgXCZSE5QAyaE1qZPNHwDUgEPCVBvGpGPzo+eEVdMVrLuLJUoVa7kI+XM1Wr7SgK+lCfWio8GFyC4fQ8JJ2dcVDG4h1TPH48uhKMr+mn2XkEOhose9leG6eHYJb50o46Wqymf08SOX7HffQxaXY3vM1h+H/GolNU6m4kkEsywLMxisN7w9yJpjhRTm1FyG4xIf6dBKqks3zKfR5RcgYcwN/vvmxx0iuj9/wC7TyXyS65LvH9V/vDUiGEjQYcdGAlIiAuOa8A92DfyKHifAJYypx8rfq6SPDHV3m7Q8ru6Vbu/F2KIQG4yKCHWkDMXcIxupX8smpz0MOqWo/6kBGsdZtGDZ5erxW0IbxcBg0xFnU9v66lRaFCQW4dL5dWTq2Ka8KzjUElMLK5Bv3X6KEbA08qWHj4hjeabqKSs4cTW1iS8a+Pe4pAGIMv1ME9v9XNk2BzmNYVPF6By3y1EdC+rdh0KE+L7d/VR+uFi+2aJk6sYPiMY3jZKDyQBpO+Lavf6PQLgVb61te1wxQwyESaNkLCz3J8vbzjZ4qN/+LOqWdNDL0EQgewRMoc6vO7GNepXZ4beLkCtjUlNUToJGMYyT65xtN/81cFthRsQjbw1CsGbMSdSs3kvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(54906003)(83380400001)(110136005)(36860700001)(5660300002)(86362001)(70206006)(508600001)(70586007)(4326008)(8676002)(1076003)(82310400004)(8936002)(47076005)(44832011)(40460700003)(426003)(2616005)(356005)(336012)(81166007)(36756003)(26005)(316002)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:08:21.0902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d76ff8f-50e7-48e1-f92d-08da16230c52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2363
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
index 69c88e6c9fde..60fbb1abb15f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1190,8 +1190,9 @@ static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 {
 	u32 devid;
+	u16 last_bdf = iommu->pci_seg->last_bdf;
 
-	for (devid = 0; devid <= 0xffff; ++devid)
+	for (devid = 0; devid <= last_bdf; ++devid)
 		iommu_flush_dte(iommu, devid);
 
 	iommu_completion_wait(iommu);
@@ -1204,8 +1205,9 @@ static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 {
 	u32 dom_id;
+	u16 last_bdf = iommu->pci_seg->last_bdf;
 
-	for (dom_id = 0; dom_id <= 0xffff; ++dom_id) {
+	for (dom_id = 0; dom_id <= last_bdf; ++dom_id) {
 		struct iommu_cmd cmd;
 		build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
 				      dom_id, 1);
@@ -1248,8 +1250,9 @@ static void iommu_flush_irt(struct amd_iommu *iommu, u16 devid)
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
