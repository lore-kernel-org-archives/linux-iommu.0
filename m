Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73544C433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 10:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 170888174A;
	Mon, 21 Feb 2022 10:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kbf0ZeJF6C_4; Mon, 21 Feb 2022 10:54:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D6E2581374;
	Mon, 21 Feb 2022 10:54:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF270C0021;
	Mon, 21 Feb 2022 10:54:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 878FEC0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 04:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D97040339
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 04:59:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d38mgQUEBp8i for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 04:59:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::612])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2611F40331
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 04:59:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KksJ38z2XsZLbd71WeGjv1P1YOJFbl30B3PnqoRdX+zwmmyMzFJuv8x5f0dNb3CYamYK7BojUmk2wP3tglwR25Hxi2eCEq3XR6Ynt3E87Jtcvb1LrYrXe1Hzwl9+UJpxh5Vj0WNO362N5vTxlWvHf9CL1VeO9Q6iHjS5ZOL8AR7FdfzaURL+D/KQrD1stdPqTqcClIKH69PoVFrFmIp8pfHNS8AMa+5n3G5APHYxFN0sRRrLizQRNrlQ9OIEDYRA7DYCBUZAn43WrAoIfyS734CSt+I4VWukzrEPaATVqJs+K0cGWDazDfAiKcJtQ24aH23HfFJ/iIrTcjzkxDPayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKWMLVjs9XHpxFU4YEa+VIBqiUt4Qosl+HNDTgWU6N8=;
 b=n3BgWHm/nRWh/wJgwTdmeOHcvw4CPRKaOifjJkOkZyOQp4inlwOmrxAopPp85Kibf1CIbt3FYZlR7WKoQeVtlHMLP8poW5A10a4YANtad3IuV2cgOz8kO6sKoakGo7JGnHeFjZkbT0iuR8X0woBOpqnpriYCc8Gx4VoORH50eSHtnpFcr5MlPtbuL5YLlWOFT9tL+cF3/bY5MOJfrK3lz7pEBsC1UNpOBHpbxPXNZBJ4GonNTmSZeXS+r7D09Y+pkiepNHLf49J4zuzETJDXmibGzScKnviMePCFSqFPbK5z4tbawerMgyvxnRaYtuoPWH1BjlYN+m1dMu/WjoU4LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKWMLVjs9XHpxFU4YEa+VIBqiUt4Qosl+HNDTgWU6N8=;
 b=0wI2roXYiKyJunY82qLQ9rIxPPg7pdUxonMwbduxZl8ZM8csf+18dhxXZOSI7/hmpb4vpDYvu3P6XMl2fVwlTmHAEdsnxghyZzBZrGejAjrl1gbmumA0C4teU6Iq/az3A3Dg/1xmcred7z/mLgs8lwZhtmy9cxx2fBJfrmRtOPE=
Received: from BN9PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:fb::7)
 by BL0PR12MB5012.namprd12.prod.outlook.com (2603:10b6:208:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 04:59:33 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::54) by BN9PR03CA0032.outlook.office365.com
 (2603:10b6:408:fb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Mon, 21 Feb 2022 04:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 04:59:32 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 20 Feb
 2022 22:59:31 -0600
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 0/5] iommu/amd: Cleanup and fixes
Date: Mon, 21 Feb 2022 10:29:11 +0530
Message-ID: <20220221045916.19701-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41618a2d-9079-4cb6-c70c-08d9f4f6f351
X-MS-TrafficTypeDiagnostic: BL0PR12MB5012:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB50120AC710E6BB91186938EB873A9@BL0PR12MB5012.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGvAApdc1H9OjR7WtYY50Q7Av1/gtOwbPNgq6MsXzq9rOHp0nsn6ZYKwkx084PnHB9tgPRjKr8Ib9QsQWQXSDyvTUwOnXsk+4BswGkuP+Og/5l18kV6Y1HVsHVa/ZuGlzRkAin7lqPojsfoBgVlKFlXqLwwMG6wNO/v/Yn5MbQyDfPdDPmD8EHpJt+/pspglDsxp8Q4NrAEiXJ4udIWyohT0bNMbr5Wi410E7cQmJHz/4kdMkJykddKVcB31Kp5kTG8iM9SEjTm9a0s6yikJuHf6QwO9oZo24XvaraW7hDjyhnef/GfkNHdnT+vEe7JNIGYmZ9YEd6t1OGWhNK4imG/cyr0/6p4SlTGWQd6r4eu+KwNUf3L+m1L1ypH9+cO9OSaMXajQ7bOZ1G+8KgYFMFxl8FJEJShAX8jCWFQSAuuDfryulleNz0ej5NJ+uDnnotuQ7STfIagdG0R5NjLrLLjrQFsB76ctwDAjmDZDn70NPkUgmdzcirESmpY8Ackgl58N/KkPsGs9vYSjBt6JploNFkE/GWPaIo6Xjb2pkBMh52/o1FPliYdcpnf5wvbUoNBiBqMEmg0kjyI9MPO3yppFnzeUIU9r/3cxdvIqAZWcVg7vK5r8yjdZOe5OebJ2cbi4iPFgG5yLq8bCAttwnG6yEX0HetdXlLjXDSjQmqDea2oD24uxZe33X0cnjU+Ofs5TkR25XZSu1Jc3ocfdBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(2906002)(40460700003)(82310400004)(86362001)(81166007)(54906003)(356005)(70206006)(2616005)(1076003)(316002)(26005)(186003)(336012)(426003)(6666004)(110136005)(70586007)(5660300002)(4326008)(508600001)(8676002)(4744005)(44832011)(8936002)(47076005)(83380400001)(36756003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 04:59:32.9584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41618a2d-9079-4cb6-c70c-08d9f4f6f351
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5012
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

This series contains various cleanup and trivial fixes.

Suravee Suthikulpanit (2):
  iommu/amd: Improve error handling for amd_iommu_init_pci
  iommu/amd: Improve amd_iommu_v2_exit()

Vasant Hegde (3):
  iommu/amd: Call memunmap in error path
  iommu/amd: Clean up function declarations
  iommu/amd: Remove unused struct fault.devid

 drivers/iommu/amd/amd_iommu.h |  4 ----
 drivers/iommu/amd/init.c      | 16 ++++++++++++----
 drivers/iommu/amd/iommu_v2.c  | 35 +++++++++++++++++------------------
 3 files changed, 29 insertions(+), 26 deletions(-)

-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
