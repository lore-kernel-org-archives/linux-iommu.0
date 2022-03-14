Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B50C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 02:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F414A82835;
	Mon, 14 Mar 2022 02:07:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O1RssRI75cMg; Mon, 14 Mar 2022 02:07:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DD14D827F0;
	Mon, 14 Mar 2022 02:06:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE35EC001D;
	Mon, 14 Mar 2022 02:06:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF851C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 02:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5D394049D
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 02:06:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jI1jvLHXnHsq for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 02:06:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::621])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12822400A8
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 02:06:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBYdhUjNiEad0w3JzlwDiFDS6YN4YezJg0yrkxCIefeFduCvRq/5qAJl5NPvonPMbByxhI4FWd+i3SV9PDpmTiUvoyU+R6THLgDY3Mz7bheqNQkGzY+BpLvNWSIcTpYfx4dwbWeBlNNtRX44Y5BQ0bQ7mjhWTHfL0MNjkOhY2fMeS56T3RzV8NBA1txxbWHQpFiNyBq8z1Ec1UMePM+Jek1VMMJOLDh4al4C0tGNINMesoPIRg2DRhYmY/us/GqZM7pFA/E0QDBNjOJ0uosx2dReqbSp7CCs2owYOAmk5Sh5XFi6jdeihOECmOi4vxrQJHcETfURCAFa2FxG+KkjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBwukwF7/Z8AC4bweTLT+Cd2Q2ei4XZHgRVmMCH17h8=;
 b=V0kv8+wBgfPvR3G6W5Xx+gjozXJKTPIrza1qCrWrsWAysUVvPIIoxwWymaCcNa71NqY+tLHKwrsdrNeLcZR4GlpkmRvCOVUkmD2ghIVa+9ZAD7ceR0Nd/8Kiisqr3pF4FrSi+ITX8Yvq/0wwrnB6n/LoIpRN57HYA6XcMHDb10oelJVwjMjUbv73T1TyX7WWsIlr6ipUwzTPIx6F3Hzk2lsGgxlmxY8GYp/cRju8ReAk/FijNr8zKIKWd2G+tpGWPcjJcSnDzJMgcxNO6fkQb4fvaJDC8i1W9FZ49qPHY2VaFpsPFEXFXd84n0794x3zDmcWF/YIDsUJksquxgLZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBwukwF7/Z8AC4bweTLT+Cd2Q2ei4XZHgRVmMCH17h8=;
 b=463YHb3qvNb4SDAkuDpeGhj6pouGY6ZS4PgqkSTqXcDjUWfJ1Ko0ZGMuV+X0Vt02Pe5ANCrc2RXdqoDwspWus04UqgYo3OD0I6XcPpm5ra/RuXJhWuL2PvVW4UIDfZi8dGIkuTBymg5LplZaRg59R3/g80z+3MV4lpf5hbgExYg=
Received: from BN6PR16CA0003.namprd16.prod.outlook.com (2603:10b6:404:f5::13)
 by DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 02:06:53 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::6b) by BN6PR16CA0003.outlook.office365.com
 (2603:10b6:404:f5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28 via Frontend
 Transport; Mon, 14 Mar 2022 02:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 02:06:52 +0000
Received: from ethanolx5673host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 13 Mar
 2022 21:06:51 -0500
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH] iommu/amd: Do not call sleep while holding spinlock
Date: Sun, 13 Mar 2022 21:43:21 -0500
Message-ID: <20220314024321.37411-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1d76887-0aed-4501-43f5-08da055f4e95
X-MS-TrafficTypeDiagnostic: DM5PR12MB1947:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1947C339A86348DE1DF24434F30F9@DM5PR12MB1947.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMK0wGLwOeHGJslPw3gVF/VubYqYzp9MQpfAZBFyeeBT1WYQiT+4wwtEMN+tNeqZzmztnrhG1q7weByY+1R526LrZ9EVjpk3fXgmZbNvGcyl7nTnJaJLW6gnPmB69Ilk0Ei9IxatrIgEuEY35H5cuHtInf7/TQmknqsuRPJ26vnMVCddKSmsaeB4I89VCSctJ/1lVo5l2bvdj3Og+TiNt1Ue0FMJcFdHvYo+By28ygkScTH4m6iWMAgJO+9eSjhKrCpRZfHy3KNHVpH9aLZrEWICSV/BbPMQq/cHgcPEyymal43JQvKD0mTVjwxkh/1DEnc4gWRUuOIxQw0d+MMZaEsmqn9+/ACBCSMZ1nwfdTEHJr1z1NuD7R0dBvWn6eyf8I7b++9zAx5woB7LuDtLcH7Bhmn+UjJdLvZefdxmBM20PphrVqvqOPj2YbfJgY10ffl95umLzfBgT19ug1eww9b0bY1l5wtsXXn9C4ANAYsRgEmWSDbxhZQq2mE3ySKeIx82VBADVpZYyLnqHTafCMe9Ex6rTrlll1R9BF/s/9QLulrGvreNvj9Q37fID6XNrEvaAUC441tL62j2JNxezmO1zE84UbMrVyxX1MmAN7yaQI1nT8oiFcyeddm5jFTjCxKENYuqujPcyGwpPAYQT6aCNwfWIYADzOFXDKNfjN4k2GNUOqCqaNcvyvfxtIBLdqBrMMha122hjURnzgUzOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(36756003)(83380400001)(44832011)(16526019)(26005)(186003)(54906003)(47076005)(5660300002)(110136005)(6666004)(86362001)(40460700003)(8936002)(2906002)(81166007)(2616005)(316002)(426003)(82310400004)(356005)(36860700001)(336012)(1076003)(508600001)(70586007)(8676002)(4326008)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 02:06:52.4158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d76887-0aed-4501-43f5-08da055f4e95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1947
Cc: jon.grimm@amd.com, wei.huang2@amd.com, terry.bowman@amd.com
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
From: Suravee Suthikulpanit via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Smatch static checker warns:
	drivers/iommu/amd/iommu_v2.c:133 free_device_state()
	warn: sleeping in atomic context

Fixes by storing the list of struct device_state in a temporary
list, and then free the memory after releasing the spinlock.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: dc6a709e5123 ("iommu/amd: Improve amd_iommu_v2_exit()")
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu_v2.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 490da41c3c71..5a6e4f87d875 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -947,6 +947,7 @@ static void __exit amd_iommu_v2_exit(void)
 {
 	struct device_state *dev_state, *next;
 	unsigned long flags;
+	LIST_HEAD(freelist);
 
 	if (!amd_iommu_v2_supported())
 		return;
@@ -966,11 +967,20 @@ static void __exit amd_iommu_v2_exit(void)
 
 		put_device_state(dev_state);
 		list_del(&dev_state->list);
-		free_device_state(dev_state);
+		list_add_tail(&dev_state->list, &freelist);
 	}
 
 	spin_unlock_irqrestore(&state_lock, flags);
 
+	/*
+	 * Since free_device_state waits on the count to be zero,
+	 * we need to free dev_state outside the spinlock.
+	 */
+	list_for_each_entry_safe(dev_state, next, &freelist, list) {
+		list_del(&dev_state->list);
+		free_device_state(dev_state);
+	}
+
 	destroy_workqueue(iommu_wq);
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
