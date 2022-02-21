Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27F5C43217
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 10:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D57360E35;
	Mon, 21 Feb 2022 10:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B4-lVojk_jD4; Mon, 21 Feb 2022 10:54:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3C98660AC3;
	Mon, 21 Feb 2022 10:54:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40018C007E;
	Mon, 21 Feb 2022 10:54:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8ECAEC0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 05:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DC7681378
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 05:00:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ARwzDv8MnNUU for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 05:00:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4445C81373
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 05:00:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSGcfOUbH/QJT6Aa7TonKz83sBUX7VGw0IiqRHU0xBwXPMoBJMk6wLQPkVAiBXfmADmM26kRa7YosS87G4CGkUdRreuHktigj3pNQyMOcfsZwbbn0umS4+3RMMljKxttCBptaqp1HMekjedm8yx7kwHP1o9GkaaAx2+UUwltADlChJBf9jq/4V202iSDPYDXZoFFCb+aVckvJhofVh/fc4D/TI0pHpmgyyY4olaFlwXNYF1i3Xfh8sONYCS9yXPDBkZwxzsZMThJdDbhU6vbq0EUJgkYxYFEMYsw2qVt63daSmECnBpGgi/KvatowK86mDMc6efNNFdSYG6nMEanGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAcX5AMh3etfyYhfkx5L4/0pR8JL1JKsEZGczEsYGms=;
 b=jMZo27mh9ay0JexDYZgKbms0FBNCUO7U5vWD94Pgt+cNisyb1+2dsgBtLrhp3h6JyNc6R+KQrRkAotEcCOlHKEdvVAcjplEQmIRUVBosHn+VBHfIy4mEKE6eTonn556JB0f0b+kfLvG/NqkkOwpzEgz6glYKPWsRM41wlobi5S9r563eBeM4Rkl+z1Xock2C3nlcd0kknjiHNr7hCVFuQnV+AD9KuQladVfICxajDzCQG2YxmDvws15uLnejJf9m1+FTsyPpxGkYkmKF/Vdv668wA/qZHY6gBqS1QgNbUjLBLfqX4HCNc4J5q9cxYL1o4ct6rQ6ESRyf1u8UPa/i9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAcX5AMh3etfyYhfkx5L4/0pR8JL1JKsEZGczEsYGms=;
 b=ESCMTC2ZMXq4yYZTAt+wSd1ztokMb61TKrIjnWDu470/xuOK8x2SgeR1ZkOf8rUAqId3FoZBqMZDbJ7qGgcpWSEwClREWkpV9a6xPQpHFvQC3TdG3z1DxN2Z4wwVzcOrRa3UXqrG0nv5QP9x2QiqAkk+jC6Uyn6SiX+DXe6I1Hs=
Received: from BN6PR14CA0037.namprd14.prod.outlook.com (2603:10b6:404:13f::23)
 by MN2PR12MB3679.namprd12.prod.outlook.com (2603:10b6:208:159::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 05:00:19 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::f2) by BN6PR14CA0037.outlook.office365.com
 (2603:10b6:404:13f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Mon, 21 Feb 2022 05:00:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 05:00:19 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 20 Feb
 2022 23:00:17 -0600
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 3/5] iommu/amd: Clean up function declarations
Date: Mon, 21 Feb 2022 10:29:14 +0530
Message-ID: <20220221045916.19701-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221045916.19701-1-vasant.hegde@amd.com>
References: <20220221045916.19701-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c55794cf-55c2-45f1-174a-08d9f4f70ee1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3679:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3679497184EBCE373BE8F4C6873A9@MN2PR12MB3679.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3P/lPK8IgfaHKSztn4c8pebBUn4XazTgskxZZox+1tHmn80muzxs6CTjK9iFYwkOVmbpDB32TcdAPpV8noL0f95SJqEqs44TCdoBlaBmwb9lMrM3bU9d/gdhLTaLvnsgTSavNjGxCYFbbkPmHOFAy36eFjv4o+Iuuha7wExqHXEkR3uygru2nkxPgKeLJg46uHnQq8qrQ7loRlSi7wqQhB55ZwkbNfNBcIh3L7ak/qhk2a2YWe/S/1iTeM/fo+tIH0ymMeD/ZYu670gzfJvbPVnaX2u5z8VhESQXYwu3qHAwryWTJDi+1TEy9dNEHavptfPS5C9NCauKQH1b9BSVbaGlmRJTmx03Ps/63FdjJBnoQMNJc9U3mY7Ff6MY+ey5QP8Iz2392wldGaXR4u3Da0nB9TylmxckQVMy3PtPc87zQ4q1B/8DXDG/WN24lrGy8BkQkTh6GvLxQlAatp8qA2+K56VSrRFIu0VxuaL4TuiEj/L7uh1UXeyNp4tpx0njMFcCfgSzqB84Q6hQJz+Z7hP1shDLoRgLRBu5PYpP7IxZ4qt7Kptp4xXddyEP3LCmD/f4JGwtxUx0xsp8VBRauh0+ocZ9UwIT84Ls92sWv5Y4MyaBMfF1Trfsva7pZnsiXk2Jp3ZuLHmy/HBsAtLz/+q8jGonW+SwOI2uJhBk36Z5hJkndRemS4TH3Zy6DpBET1WAmxOBIIrvWW6w0vgUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(336012)(5660300002)(2616005)(36860700001)(16526019)(426003)(1076003)(86362001)(54906003)(26005)(40460700003)(83380400001)(36756003)(186003)(110136005)(47076005)(6666004)(8676002)(70586007)(2906002)(70206006)(44832011)(508600001)(356005)(4326008)(8936002)(81166007)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 05:00:19.2742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c55794cf-55c2-45f1-174a-08d9f4f70ee1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3679
X-Mailman-Approved-At: Mon, 21 Feb 2022 10:54:02 +0000
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

Remove unused declarations and add static keyword as needed.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 4 ----
 drivers/iommu/amd/init.c      | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 416815a525d6..94d33626d692 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -14,10 +14,6 @@
 extern irqreturn_t amd_iommu_int_thread(int irq, void *data);
 extern irqreturn_t amd_iommu_int_handler(int irq, void *data);
 extern void amd_iommu_apply_erratum_63(u16 devid);
-extern void amd_iommu_reset_cmd_buffer(struct amd_iommu *iommu);
-extern int amd_iommu_init_devices(void);
-extern void amd_iommu_uninit_devices(void);
-extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 92c489c1467d..df11c50deb74 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -660,7 +660,7 @@ static int __init alloc_command_buffer(struct amd_iommu *iommu)
  * This function resets the command buffer if the IOMMU stopped fetching
  * commands from it.
  */
-void amd_iommu_reset_cmd_buffer(struct amd_iommu *iommu)
+static void amd_iommu_reset_cmd_buffer(struct amd_iommu *iommu)
 {
 	iommu_feature_disable(iommu, CONTROL_CMDBUF_EN);
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
