Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9DDC4167B
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 10:54:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 138E8401C9;
	Mon, 21 Feb 2022 10:54:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 48R2-ydjcjE8; Mon, 21 Feb 2022 10:54:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BA41340545;
	Mon, 21 Feb 2022 10:54:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A739EC0084;
	Mon, 21 Feb 2022 10:54:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6851DC0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 05:00:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 56D6681431
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 05:00:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t5bIFu8xUmS0 for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 05:00:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::620])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1EF038142F
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 05:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+XiRQNnWZlypXeepPgilYxaoxynz+7rv5cKXQRXa8iIuErxUTpTkyy+OpRzlhjWwe4uVhblh/6h8UKq/1MsvRJuqYAIo73tiIy/PHHqeU26krfWM84inMNUiz1d+I02Lvf36jo/VaBFh1OAaPmu1UvHZnH59JhfDpaLd+Pgr+L0DcclxdlahGNEPpB+kIKT2HxC5lgpLHohK21wxHw9ZA+NW68Gs3Go2Nfo1QmVt1CF1ZItiQXnUJA9oSN3jOFWvyw71VMmPwvfFfveNM/pd8RZ8jss/m1vYjOaz9Svc0WZfetH9JcIyPcEIQvBmzGL6+4YJGaWPCnTeFH8UuSK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyhGL/e9IY5Csj5vKEa+2wbhNF7NoHXqVQHnNAgAmU4=;
 b=hb6RBwzy939bQ2uGjnyAqjFsQ+R4eAdEaufXu+VUZIO8jW5dXxSrUqXAd6xAvkUT7TLWUCu+Xlqklt/CnZ/3qs5SnCFyIGTc7CwCFnE+JjXcKKkjlzqYezcFjTLU9zkxpqI2ni/dHMNi6kpMD4DHhuQ5ii3/q9v9U6/dmeyBh9CFc/ORzDYtv3FsTyof/mjnqz9rP1lsWhv9Vx3EtBBMNFC+IizNsH4bI9YNX2w2QJ9u4kO/gTkx31pyjLX+ul2JlLd4+11M2pYFFeXUi9Ro6Fcfs0qKC/Rokw1VSrTQxCWd+eTlkc5cqqpbp6RvFBmsh9SfEN3IvkidrUQN9P07TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyhGL/e9IY5Csj5vKEa+2wbhNF7NoHXqVQHnNAgAmU4=;
 b=JOb+Lb2fcp9KQBrZ7mV07QIGujHimTDC6LWDky8hySBiLOd15x6trk4VHtjnYa9VGxjvpuN567Wradm4vXn+8Gz5z0dkMt4qTTBZtxUtp3ToA2GHLy92hzY/5TFyyJSwVNS61T/9iGt/sRBTa8DsIJbM5qBXzBUkLH9I75Aewck=
Received: from BN9PR03CA0166.namprd03.prod.outlook.com (2603:10b6:408:f4::21)
 by DM6PR12MB3708.namprd12.prod.outlook.com (2603:10b6:5:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Mon, 21 Feb
 2022 05:00:50 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::3f) by BN9PR03CA0166.outlook.office365.com
 (2603:10b6:408:f4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19 via Frontend
 Transport; Mon, 21 Feb 2022 05:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 05:00:49 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 20 Feb
 2022 23:00:47 -0600
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 5/5] iommu/amd: Improve amd_iommu_v2_exit()
Date: Mon, 21 Feb 2022 10:29:16 +0530
Message-ID: <20220221045916.19701-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221045916.19701-1-vasant.hegde@amd.com>
References: <20220221045916.19701-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 249da55e-5e4c-45f1-96cf-08d9f4f720dc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3708:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB370818079ACF5C9265818A5E873A9@DM6PR12MB3708.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4OXPZup9uKFObakAbWzNL9wMG+bd4IQPSPRoHTZNGR1wNGv1teTUKg67X8nxjg2J/y5Jf2VaDf+j5HGcsY/7jBk4NZzYvj5BJuUM9YI/DXL5IYzrh74wrrbvCPWT1oIjzLHnGsQ888uWNBAneE8p2hSH5Ub/Mgn94MmJvED0979jbKUir3u7GiXdWfxgpaCUkNyjr4InZ3iLdb2qG6JYa/inYz9IqVzCB3M0OZp8q1JdzNGg3D3bQ+/Bv4gdfFfN3s5TwMFJ5NupQ0NDG7/e7DJBEpkyTGw0TyZgrCTxlF+TAx9Xpb22x9h4ejzjZkeViObd5dDP1qvRpPk2hHXQlFgnC8BiaU9f6VAo0pi29pUv+Lkboqi1tDeE7ndG5ILEoS5hNK7UdfMJcUYf9367LgwISXVFZkzMl1eRrf+E/Sy49f7lF7oKCJmAZW+myGnkCCDo04nf+IEFRAPLCkJp/EVZnRCE+xl+CAD6AHPqqiHZFqFpIyqQR0TOC9+5GajI6yAr0eNWIYxFix2lVjCBfMrRQCr24fOEMh6TaF1bipqCaea0npeEZvxRsB4c17qmoe074j4vnZmlvjORyGGhc9NWD8j4yaOssI8JmfCBTUXlO6wQzg7+eeZs7V8QdKEFiWBGwGXQOiJ2nPf5xTIS938B+8w6fpQJU+sDT0yS164seD1sgPdjMOoLqbJXycjSIG8ltash9S91oUnhx1vSEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(47076005)(2906002)(26005)(426003)(16526019)(336012)(186003)(81166007)(1076003)(2616005)(356005)(36756003)(5660300002)(44832011)(40460700003)(8936002)(54906003)(4326008)(70206006)(82310400004)(508600001)(70586007)(110136005)(6666004)(8676002)(83380400001)(36860700001)(86362001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 05:00:49.4281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 249da55e-5e4c-45f1-96cf-08d9f4f720dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3708
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

During module exit, the current logic loops through all possible
16-bit device ID space to search for existing devices and clean up
device state structures. This can be simplified by looping through
the device state list.

Also, refactor various clean up logic into free_device_state()
for better reusability.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
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
