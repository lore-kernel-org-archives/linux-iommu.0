Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBEFC433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2047D40566;
	Mon, 25 Apr 2022 11:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gBW5L3jKmaly; Mon, 25 Apr 2022 11:40:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E4B3A400CE;
	Mon, 25 Apr 2022 11:40:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE9D5C0039;
	Mon, 25 Apr 2022 11:40:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC7D9C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9ACBB40566
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:40:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6QAqu8gv1SKe for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:40:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E83F2400CE
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li30/fcKXfLRI2E2eExKxKZh8+CA0A35UZl/IPnr4NpTq7+/DPqN3J+rwdj4iSoXLBUCqtRfBO8uxZkz5PO1stRLemNgWhlL+Sm0X4teYw41bUZlNL0W9z6xphpZgt50z/pR1moFM/uc0nlOtS+4ZwQQTRxuQGqG86RdDkhvj12G1tUk8A37gUjLNKQzUd9H7wvDkb7Pv/Z34f3B/F1C8MQytVWz5Kp9Dj9qfB9hJI5k05d04RorCdvpjRtR9qZ2fiallA1xzchyyLg/BBQeXOkKKyoC86Z2CZI8um80bY+Ziui33Fqg4cahu+ObaOA/fZoxH85UG33PoahYQal3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwkpX0/N84IqRhqug/4LaqjZ7w06ytquFFC4J/rmbjM=;
 b=gNohuhlcBK9nqt3Gw3eE37ssUmrYUF0oSuZ9mQkmukMbzpFbBS+YVhyly656Xgv+cfW77VBezcS6guP1XPXoJdbDD+mjAWsb1ogYZ6+JJ+59XbpFPSfVOQN81fSHqnjWG71AMUoCWlhWOn0P51sRaUxQ84gOn0KvCk9EtVkpkYk22hGZlCzVovrILo1MqEzu3zpK0dCEeW9CK108vAfO2EueoYXG8rNKvfg9Eg49Ao/4bk0VHk4C2bxdHuLSexLPrMeyItDYmif7/ibIZix5O3Lz4cCvmQHB/wpdZlCZXC0RwKIaWHc6NKKEquyKboz0ViOhRbc5kr/2FKwRYj9SLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwkpX0/N84IqRhqug/4LaqjZ7w06ytquFFC4J/rmbjM=;
 b=yL0DZyqf9EudwSjjfIjNXkluZHBiLJkw7y9JRY/5dD0ll4V5KkzY750acwjC/xBineutTsHZYuUQbgykC5LEKmD7+5B4QP7xJmnIZ7g+hG8v84HNEFokDUSqGVFv4K08R22hEc1rp0JgJho34xfTkJZviOMv9wiA/bdlQsBVF4w=
Received: from BN1PR10CA0013.namprd10.prod.outlook.com (2603:10b6:408:e0::18)
 by DM5PR12MB1356.namprd12.prod.outlook.com (2603:10b6:3:74::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:40:45 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::86) by BN1PR10CA0013.outlook.office365.com
 (2603:10b6:408:e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 11:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:40:45 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:40:43 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 23/37] iommu/amd: Update dump_dte_entry
Date: Mon, 25 Apr 2022 17:04:01 +0530
Message-ID: <20220425113415.24087-24-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d314965-7eab-4ab8-6468-08da26b06f9b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1356:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1356AFFA086A3C1DE4233FC387F89@DM5PR12MB1356.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3nL+RvTRiv9+UlMjfGxNetR0wJzHuhF2hhdyQxp7Bumw54MVcbkrCDIA2zi6anBKImvM7FHs54+N7gLVoGnq3Q45ZjipWS+3aQbO/gPZDwznhXBinyDsoEOmIiNtAn5FDu5ig5eUec1oxmQ4Ot3/LUw/OKElkSgjsBwPiaQGtuAQ/9dxRf9PaJ1w9jM7DtD1S/ZT8rFWg+QBoLQ/dh9vjz5NbbHVaTXSk0Zn8Zhgl4KHRIwhVQ1PSk2XsDToCqHG4T5dm3TImJVMhDkIJtrAwaRebQ9sW4gqRwNy0rRDt8Nh8j79QjO7nB76HoAjQXaa5J+KMhD4MSvYt+1q5heTCAzcQiWWqbEqP2v5dxk9S3SYxmQ3YkylA+llfKjkil/EFgd5qGjPHloYXnCgahazqxr23B3QqF+8bDRHHXgy7BH9U01xq9f2Mt+HLNbBbjFsL0RAJy7d8wB4ECWU7WRGtJl7g0YZg+w73Alc27yFDu8gjpaOlI1M2SaysgWLS08JMqJfTRYmCk4Ki8NfM2xWcJQyPhqIwZijHW1j71PzwsDr7YddtOmM/iJ8nAjlZ8eEcWo67elaIxqGiKIfr07hia8/KwyjKBFJ1X0N34kZstSYV+CQmw8NkdZHJOIoTTuluqttko9+J6bUDzSfo/ligPY/mn8HKYY//a5lbnbeQjxPE5HNbJC/v8AjeG/Z52kbtPOsnfkyPzG0ZTvFwZB+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(16526019)(186003)(426003)(1076003)(83380400001)(336012)(81166007)(356005)(86362001)(508600001)(47076005)(36756003)(5660300002)(8936002)(2906002)(44832011)(26005)(54906003)(6916009)(2616005)(4326008)(8676002)(70206006)(70586007)(36860700001)(40460700003)(316002)(6666004)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:40:45.4275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d314965-7eab-4ab8-6468-08da26b06f9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1356
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

Start using per PCI segment device table instead of global
device table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f2424a72100b..5a2a4a08da2f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -451,13 +451,13 @@ static void amd_iommu_uninit_device(struct device *dev)
  *
  ****************************************************************************/
 
-static void dump_dte_entry(u16 devid)
+static void dump_dte_entry(struct amd_iommu *iommu, u16 devid)
 {
 	int i;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	for (i = 0; i < 4; ++i)
-		pr_err("DTE[%d]: %016llx\n", i,
-			amd_iommu_dev_table[devid].data[i]);
+		pr_err("DTE[%d]: %016llx\n", i, dev_table[devid].data[i]);
 }
 
 static void dump_command(unsigned long phys_addr)
@@ -618,7 +618,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
 			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
-		dump_dte_entry(devid);
+		dump_dte_entry(iommu, devid);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
 		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
