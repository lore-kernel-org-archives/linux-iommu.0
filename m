Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5CDC433FE
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 16:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F336840182;
	Mon,  4 Apr 2022 16:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6YR6wo-iZz7U; Mon,  4 Apr 2022 16:47:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DDA134050C;
	Mon,  4 Apr 2022 16:47:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B53F0C001D;
	Mon,  4 Apr 2022 16:47:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1397C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 16:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D17760FFE
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 16:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pp_hNuBzVSe8 for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 16:47:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::610])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D49B360C16
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 16:47:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlAEH4kE4/6pmz65dlvoFxUYE78VTjOk4wNrPeb5HFdJlD6HrJWaKiWvuRJ4UsBlNh8MgwAsjyDQbMqmadh24EKqZoCqs4uclF1QwLo29/n4dhoGbEI3uk62R4OycjDyCpZzeK9V9VQVMVeNkw5ZUozSjgQAE/DWZv6UQgqDmpjGXnfnYuX9SiWD9MlxvIG7t2qjwkr5rZe9ONpFYGSW0rqUGknWPFGHhDAugApPmOOe97BaAs19CL213MgIyMQ1JG070uChSrZPLklr5NZB+bS2SU1T/AXv/wUd0KCKmse4tn12UKN7BRgxYdgmZcRxgoxpGDegGJrKRNuta+apUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9hMJlCRvhfC9XCtymsNu68XxXJSh88huRpW73wHGmw=;
 b=J5mN6aoBvjargmLMd1MD7eeBv0WXE2T6ICSKwVAl5mGSkip+IodCvpMoafwivqDq/xKk5OWdCesxn/8iv0La/o+SJFMcwWCcyPlBiB/FEdAnm/Zw58k5qnsdbWKBgAk/1k4WSVxW7KDN9koLHGTuNmFNT3xcv6aC4Ru/f00HBfDRvnz52ViTCCK9650KQwUnRsSi/v5bbHc9AO7CHSeePnZadNL6q6ogLi+jJl40UfUxgt1FlZ6TxJS/QgMPJnD2t/PyYgNBYR5KG02cXbggJ/Q95LI7BIUaQkOCh4bfh1SOZPHR4WzpvvpGa+UgA1Phdi+D0cM0mCUq/Alud0Pcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9hMJlCRvhfC9XCtymsNu68XxXJSh88huRpW73wHGmw=;
 b=3CqnLlZw2017cJ8YJkc2uYbCjVmrz99CYTUz1jo+7PD2h6RgW9cAz+xbWrBKUG+jsLAP5XIXsgeoGDjtfoLoxqpHYLU7a7ajKO0rwZaP9ojUjsyaQ9EQGrgnFYYXNm37iqMWDJKv/giSMSevIlOgdebjCSn5G9gZgvz6KqFPzg8=
Received: from BN6PR19CA0078.namprd19.prod.outlook.com (2603:10b6:404:133::16)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 16:47:33 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::c1) by BN6PR19CA0078.outlook.office365.com
 (2603:10b6:404:133::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 16:47:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 16:47:33 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 11:47:27 -0500
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: [PATCH 2/2] iommu: Don't use swiotlb unless it's active
Date: Mon, 4 Apr 2022 11:47:07 -0500
Message-ID: <20220404164707.1128-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404164707.1128-1-mario.limonciello@amd.com>
References: <20220404164707.1128-1-mario.limonciello@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7ace693-d299-4422-190c-08da165ad0d5
X-MS-TrafficTypeDiagnostic: CH2PR12MB4230:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB42302C53C188B078CEC74BE3E2E59@CH2PR12MB4230.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rFZAe04DMsCrohIHxHCpf94GyTovHB1w/RWjjlWdOSNL7m9/w0QZ1+fUKtJQqYWd6fzmOWNA8O5xKhb85MeTD3oQPu+4UN0ZyBIrO1Eff/3M4Ih2DZKJ2dRMv2W6YkKN4ZPDsiSjbL1L5ZZ3EUzV79MvaE6W+GESTMqE1W4BtJzfACqbm/RKHw1N8nfT+vFVJd1uOJCgfg7zGfCNHKtcep7QPF76rFjSYV/5eSberVzRKuIFUD84wmicza27SbpMl/Bv3yND06PU2lV85u5gvC0d6/IKWDo6/DntEgbjSC8s1n34oQmWtRk7eJIYBvohMcL8WCDxsRvcFW7vSpIP+HPXfcD4H0qVprO4tXbvA8yM0q2lcrFeaxM4B9lGqXeGSkcRgMmJUPXcGxY+Aeyx9FJOPuo3q5blHjFevVODix/eU3Q8jfjOU3NRy0OYQQtK+Y1+sDkm4+T3LOeUEHZjQ9fjiecarq6eFv6ou1lbMU3xw4LOwZCSmOz157bconqDy5ai8ZQBR4Q/tw/TwDjgnOEJbQqWjvgFwvWdXr6R26zZjn+saEv8gLsKOywA9jCbwu/aqZyHJaS9u3ciCot4Au/hrhlO9JVB42Sp/RRKJhFdR8Bkb6QRytxZ9b2sRaFQUVFUqV/23vj9pxA2F9xz/YQOXc+V+XSYoehfucZjR11Mcw3l5bPpSA1JeQNj7iD+xMYQst2tJSVLCvWAqCkaeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(356005)(83380400001)(81166007)(54906003)(110136005)(40460700003)(8676002)(44832011)(36860700001)(4744005)(4326008)(86362001)(8936002)(82310400004)(5660300002)(316002)(70206006)(47076005)(70586007)(36756003)(26005)(1076003)(6666004)(7696005)(426003)(508600001)(186003)(16526019)(2616005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 16:47:33.2215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ace693-d299-4422-190c-08da165ad0d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
Cc: Hegde Vasant <Vasant.Hegde@amd.com>, open
 list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Robin Murphy <robin.murphy@arm.com>
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
From: Mario Limonciello via iommu <iommu@lists.linux-foundation.org>
Reply-To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The helper function `dev_use_swiotlb` is used for various decision
making points for how to handle DMA mapping requests.

If the kernel doesn't have any memory allocated for swiotlb to use, then
an untrusted device being connected to the system may fail to initialize
when a request is made.

To avoid this situation, don't mark the use of swiotlb when it has not
been set up.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/iommu/dma-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 09f6e1c0f9c0..92ca136c8a12 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -504,7 +504,8 @@ static bool dev_is_untrusted(struct device *dev)
 
 static bool dev_use_swiotlb(struct device *dev)
 {
-	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
+	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) \
+		&& is_swiotlb_active(dev);
 }
 
 /**
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
