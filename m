Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B4BC433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 08:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9272A40273;
	Tue,  1 Mar 2022 08:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YB0zSaIzcnRZ; Tue,  1 Mar 2022 08:58:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 56E4040257;
	Tue,  1 Mar 2022 08:58:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E57CC0033;
	Tue,  1 Mar 2022 08:58:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23096C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0238240268
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:58:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OqZrwNUkN9rH for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 08:58:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C1FF40257
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz+7nB+yBksJ1EBxyIHsU2DVdm7FfB2zIwLtQAFvIhbELJ7UPHVZuJ5z6C2hovYPkSgj7Zg5Rjmqi/zbFu0rA8f9c815poH+0xpQzE2ODz0TkFgxMa3twY0znC/qiTSmTb4oFsR59qhCyKW0/Ik5DYG3OzvmO3TS1+jw9ozQnlNZnGzg5Df3rlPCG2pcio79488gMVx3zRbHlRAfpDR+93ziRgZQD38e8GQtUItUBtTHnkmyFANv2R5Oczsz6OwqOyGZY9Qb+Ccehh8AcdXvYvPcqKXuz4L5MAELsKVCHImb2ohRQeGvAJCZldvMHDJ4okgEIwYxdxEBVl5/BaWThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqAxm7XOGanUsLl5lf6vhmV6Z97/sujuXeOodHymgeY=;
 b=OxFzLyRXaWGolyZ2O1INADps+NOUDk/qdAZ/f7bCKB+k4NXeKBjAuzN6Np9DbXHn27CCLYw6LJOQJPQaCqvonu0dj+3NsMHriingrKQHHkzNE0CcJ/MalhCCg4DT9L/juQkwXVrRTiEv8cj7++kXNi/32YZijRpIVahltnhKsuO00tpnX3WDJYqSyyDnKh6XPIL6zOyaxe5uBn9mvNP7e09xqaVD+HO3y+4YEV9lf0pV/FLkPxoBvUi22bw7g+65CCVYvD+tFrvpDXrQAa71E/Hy/OowBZ891Cmm44OxqHLh8ZKVqdry38yh6YN8OA0Ua9+FmkrEmIWPfOlfe+4V3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqAxm7XOGanUsLl5lf6vhmV6Z97/sujuXeOodHymgeY=;
 b=38Pp6YbQLRM6TwPE71yJWmYQtghCDuvEKOQvdTzYRJgadSWy6WAK8oab4MK/PrMopos9nkkbsNn9pPH6skkb69rsGbzQwEA28+TXvvZEaElwtfqKJFYFDSbZLi1kHSGKNCmQC88xDT1MX0wtG965oAJtK/4Jbl57pQThajL1BHY=
Received: from CO2PR04CA0102.namprd04.prod.outlook.com (2603:10b6:104:6::28)
 by CH2PR12MB3831.namprd12.prod.outlook.com (2603:10b6:610:29::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 08:58:11 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::7c) by CO2PR04CA0102.outlook.office365.com
 (2603:10b6:104:6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Tue, 1 Mar 2022 08:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 08:58:10 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 02:58:07 -0600
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 5/5] iommu/amd: Improve amd_iommu_v2_exit()
Date: Tue, 1 Mar 2022 14:26:26 +0530
Message-ID: <20220301085626.87680-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220301085626.87680-1-vasant.hegde@amd.com>
References: <20220301085626.87680-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77b65ae1-c75b-49e4-1733-08d9fb619c87
X-MS-TrafficTypeDiagnostic: CH2PR12MB3831:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB383151D94FD475E9954F1B1287029@CH2PR12MB3831.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8xUHnnxyEzkc7hopRcZfRP73/z9bj8ZpvDNq2BA3686WqzIRwXUHJsK/xkV/0XW01/Mq4S8/46YKOTNbyCTWJy4gy8qHBJz4BSwyYjeKiV5n3FU5LEckxduZeHQ9SHv6djzkzrUm7mi2Uk51uN1NY8tcQfjVPjXbFWFqKpFFQY4nBFMHb/yfDI3fgwJLlfiZPvk7x60cIYxy2zYn/pGjJR7eO7PtIJHkpWf4pwvemggDVvEF5eFBrqyQxfx4N8RivxLztsSTUA+/fJrAuUnpC2FIBvtQ1IYlTIfCzNq1vGEIfvfpWk7gE3uBj+WQySMDMORX7e732QroG6qcU5vf++3hGHRvkIWKHndZiLrG2C3tRaNCrYY+quxpTryqXSa+3xmhRvdPij6gQQV06rN6fgXiSrLC7WIw/BHEkO3IPaRBuXIazA+oPJl6Ai1uMMiyX0jQ45XgfJVdu2KL4zZJClV53FfIN+Yt2KF/gpTYqovoWmwRjxoUNY/5p8VTWx//rigaqvNg1ij/8iuQVR3z/mYR8eo4hz3OelZSjOOIcGUe4T9APNizSB5K7uNNbwDg3IY0P2yZbZCGeBzmIPfPIp7eh2jzIDdckUEPV8HPvDNHADz8Nsr0PiTHT/wYMYOiToC+yT12zT+ZMS2Xu4niN1WyGQlrmqd9o+45BRWZqg95h7QCB+uGfW9kfxet6TGg3TgHvZEUHqSHuOW1LMXWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8676002)(40460700003)(6666004)(36756003)(508600001)(82310400004)(26005)(186003)(54906003)(2616005)(110136005)(86362001)(316002)(1076003)(44832011)(83380400001)(356005)(8936002)(81166007)(2906002)(5660300002)(36860700001)(47076005)(16526019)(70586007)(70206006)(4326008)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 08:58:10.4259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b65ae1-c75b-49e4-1733-08d9fb619c87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3831
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

During module exit, the current logic loops through all possible
16-bit device ID space to search for existing devices and clean up
device state structures. This can be simplified by looping through
the device state list.

Also, refactor various clean up logic into free_device_state()
for better reusability.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu_v2.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 2daf37c21b85..c72969ac4956 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -24,7 +24,6 @@
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Joerg Roedel <jroedel@suse.de>");
 
-#define MAX_DEVICES		0x10000
 #define PRI_QUEUE_SIZE		512
 
 struct pri_queue {
@@ -124,6 +123,15 @@ static void free_device_state(struct device_state *dev_state)
 {
 	struct iommu_group *group;
 
+	/* Get rid of any remaining pasid states */
+	free_pasid_states(dev_state);
+
+	/*
+	 * Wait until the last reference is dropped before freeing
+	 * the device state.
+	 */
+	wait_event(dev_state->wq, !atomic_read(&dev_state->count));
+
 	/*
 	 * First detach device from domain - No more PRI requests will arrive
 	 * from that device after it is unbound from the IOMMUv2 domain.
@@ -849,15 +857,7 @@ void amd_iommu_free_device(struct pci_dev *pdev)
 
 	spin_unlock_irqrestore(&state_lock, flags);
 
-	/* Get rid of any remaining pasid states */
-	free_pasid_states(dev_state);
-
 	put_device_state(dev_state);
-	/*
-	 * Wait until the last reference is dropped before freeing
-	 * the device state.
-	 */
-	wait_event(dev_state->wq, !atomic_read(&dev_state->count));
 	free_device_state(dev_state);
 }
 EXPORT_SYMBOL(amd_iommu_free_device);
@@ -954,8 +954,8 @@ static int __init amd_iommu_v2_init(void)
 
 static void __exit amd_iommu_v2_exit(void)
 {
-	struct device_state *dev_state;
-	int i;
+	struct device_state *dev_state, *next;
+	unsigned long flags;
 
 	if (!amd_iommu_v2_supported())
 		return;
@@ -968,18 +968,18 @@ static void __exit amd_iommu_v2_exit(void)
 	 * The loop below might call flush_workqueue(), so call
 	 * destroy_workqueue() after it
 	 */
-	for (i = 0; i < MAX_DEVICES; ++i) {
-		dev_state = get_device_state(i);
-
-		if (dev_state == NULL)
-			continue;
+	spin_lock_irqsave(&state_lock, flags);
 
+	list_for_each_entry_safe(dev_state, next, &state_list, list) {
 		WARN_ON_ONCE(1);
 
 		put_device_state(dev_state);
-		amd_iommu_free_device(dev_state->pdev);
+		list_del(&dev_state->list);
+		free_device_state(dev_state);
 	}
 
+	spin_unlock_irqrestore(&state_lock, flags);
+
 	destroy_workqueue(iommu_wq);
 }
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
