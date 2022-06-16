Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5752CCA473
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 01:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D64B40C8A;
	Thu, 16 Jun 2022 01:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8kmq4tNRlFZa; Thu, 16 Jun 2022 01:56:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6BBC140C7A;
	Thu, 16 Jun 2022 01:56:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3EF3C002D;
	Thu, 16 Jun 2022 01:56:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3713CC007C
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 00B5183F9C
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aVN0eZ41FQCy for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 01:56:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::613])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5715483F99
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYHQILibu3nljnKs4us0p97gvN9gr9jv5MpAhohJQJMYYLLHFKMUZDfPzFQbDbprwdaNh9iWvw9yLu9UP2mPvoqz7/OiChG3do2zt98Aq3GBqw9W75Lmehf9+rugkDV++kYVVUtqxKZrpt3U2F/lUhERr8aB8WvpM+mJuyV/yXRJ3UiaCYzTa1qxsyKZeOh42b7OCV7sS+CIY7EFIw2yNiTGI0hxVMNAAFnQAi18Sz2OkfrSx4h4t4ygSWuC1KEecXE9gbMq6hSwpCNMKljzkN0qY0RyN639B3b1O7i5erIvkPQA8Q7FbA68P4+hxP5jF6WN0Gpc3pVibZ6GLzy8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSgRIFA0RF+bR6Qcmwr5Sep1iXBGd3+GRmnCKY/eXgg=;
 b=gSX62COBAC92LXorflOjURkLpmJazp4V1hYiSTFj9QOsW5oV34qKpKVSW1aj4WfAzfZ5JGEOfV74qNqtSNnclFIu5ONDQVcc96qciJDl8cIJKGfn5T1Nmbp/A3Cxc80s5Kw5IsERnZC8q4RI2ctrbqUwifSHILdVPFJRRCqEVfhPeda4ry4LhaPsTYbZ0TZUp2JjRnEsUzU4h2n/pnKyAdlovX0HOLADZ2D41sgxY+Qc7TGZoPLnKj2Kf+UNmfZPTyG/Tej91JqPRUT/5H++M45KIzmyL8l/jpyCgCI0/a9gCHsY/9vcpj0D7DcyKi6NF+GKweXPV7I7KT3EBxpGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSgRIFA0RF+bR6Qcmwr5Sep1iXBGd3+GRmnCKY/eXgg=;
 b=O8pUUQLBmJdjVSwJUpajlPg1VgujetvlpKLf/f0nZwKwRN2sD0qjT0ip5VN917i1jvRu8MAyoQxujHd+mKjeU21suKXEjVQfWM6XYVNswnI8EUqPnFIFBJ3Xfh9lFo/bQ0g6NtKmKW1hiB6L3DuNQtdjA7mIGwbuRSQBlV+bcPg=
Received: from MW4PR04CA0219.namprd04.prod.outlook.com (2603:10b6:303:87::14)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 01:56:27 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::cf) by MW4PR04CA0219.outlook.office365.com
 (2603:10b6:303:87::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Thu, 16 Jun 2022 01:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 01:56:27 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 15 Jun
 2022 20:56:21 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 7/7] iommu/amd: Do not support IOMMUv2 APIs when SNP is
 enabled
Date: Wed, 15 Jun 2022 20:55:41 -0500
Message-ID: <20220616015541.11207-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
References: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c2d8bd1-631c-4daf-9838-08da4f3b6cea
X-MS-TrafficTypeDiagnostic: MN0PR12MB5929:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5929163A54519D4B0BB5BE7CF3AC9@MN0PR12MB5929.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Da1TCY5/7iL3aYeaNDf3ngmOKfMAXoWMp25mKbtXAB6SVhGBOKvNFYoU0SeW/rw2hlSFfaH/03wb8k+0BiJz6fdgwmTriVp/5xNdE/q8rlNcxMCodF8KFzHLuxUpx9Qy6swIdgpBTwhJQF9bHc+tY1JMOjibftJ2MifrmIgvLAn7ZY9V2zqrrWDTg7r3LSAITvX8Pvt2SfnZOsFwh1FGm8M9LXQ+WciYDObtQjoYPWmhJcIrm3jiw+Z1lZcBXXVzHPDRe4Fdje6/LDxHXOPPBqD+xeSijRSwVtKHtGaTkJUPnndqiQ+OgxRVBcRUc+pe75BmWX2N+Xb2Qh9/6AaIKLIrW/obb21lUMibkLwaRQrLJ6WKaoCjDD9XZq9IJMeVLfk+Cl3eyJj8/WH1pdmpgM/esYwR9WlgykKyl5I6e/pV204wef6Y820cJB/3vlIgx1egtNnB7qxIQYHC86wGUt/DHHOh3+3/CQhKAX6kasltWaMXOErXk1DJMHqNWhorqdTOs/TVxI4nwHsMgineHq1tlICZrx2XMnkd/v4UZhkZnukEdDJCDxI+Se4xIB77jP5ZuQaIiUzUKkGZcMR0QTrE3RzzV17ZbIxDgigv691rkO1v7XAbM4/Dvaw6NEG+S47ZEIZXWGeXq7JVsD9SWXiZ44cFq7CgP+FUbeqJ75GZD0BvAw/Itc6XUdT4HkkTW9uKimDMPUYq+zqDnduEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(81166007)(356005)(6666004)(2616005)(16526019)(54906003)(336012)(83380400001)(2906002)(186003)(36756003)(82310400005)(47076005)(1076003)(40460700003)(4744005)(8676002)(5660300002)(316002)(70586007)(86362001)(426003)(4326008)(26005)(6916009)(70206006)(44832011)(8936002)(508600001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 01:56:27.3450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2d8bd1-631c-4daf-9838-08da4f3b6cea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929
Cc: thomas.lendacky@amd.com, ashish.kalra@amd.com, vasant.hegde@amd.com,
 robin.murphy@arm.com
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

The IOMMUv2 APIs (for supporting shared virtual memory with PASID)
configures the domain with IOMMU v2 page table, and sets DTE[Mode]=0.
This configuration cannot be supported on SNP-enabled system.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index bc008a82c12c..780d6977a331 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3448,7 +3448,12 @@ __setup("ivrs_acpihid",		parse_ivrs_acpihid);
 
 bool amd_iommu_v2_supported(void)
 {
-	return amd_iommu_v2_present;
+	/*
+	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system
+	 * (i.e. EFR[SNPSup]=1), IOMMUv2 page table cannot be used without
+	 * setting up IOMMUv1 page table.
+	 */
+	return amd_iommu_v2_present && !amd_iommu_snp_en;
 }
 EXPORT_SYMBOL(amd_iommu_v2_supported);
 
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
