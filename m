Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E21CCA483
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 17:12:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90CE481449;
	Wed, 22 Jun 2022 17:12:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90CE481449
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pUFPS6tT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7OHPH69jPa_v; Wed, 22 Jun 2022 17:12:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3D429813DD;
	Wed, 22 Jun 2022 17:12:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D429813DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27DC5C0032;
	Wed, 22 Jun 2022 17:12:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 574C4C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 17:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A64540A96
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 17:12:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A64540A96
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=pUFPS6tT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ekw2PtElnFqi for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 17:12:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5579E40A14
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5579E40A14
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 17:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyMAf99CaIjdV4Ki+zY5ba7TB34JVJo6l/YVz1E3VlJY5nBG62nk47iEt7j3rNRlW+BDLLebwam7bveMpYY5X+81UeFH6suy1zOnrRxf2dfvku5UeUGELuZEZndI8spuKpuOkRnZNJDez/Gvhed5VtusF2AKwTNOmOdyxJLoMzwV5ou7BWGhlG1CMx0WOszlNdOMfsdc9kIU3N34mqDME+wZsa/m1tRusyrUV48zR2hwwZBPOKUpJnYZ44YiFewM2avEWeCERk+A/0zMy4N+duxdZddvt38Z4SFQyK4flIQQpwwd+eHLeKGWBBQ6Ktoxv5Pi36Xt6h//kvnZp9prfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpJ7bkErcFqXegMKSsjREmOcNrSuahL+cgRI3UL9bro=;
 b=BehQ3VK2PjyYz9nWkGmZYf1et0/Qu+svi4/8XLLj+pB8vBqDiY8PboR8SFvXIN0aw1Mf4UarOLSxGMl62apzT80fHRODabO3weoqlf+tZVx5O9gOlqbDlLmvVNWblkORbg39oGzf1gG8kJWBnMh87U8Gi8cCYQfG4CAovbDhWeJtd+8u/L5AID7UWhsdRlHMvoVqnZgHAKlQvPVkuD6m+F7kZK6KgLmGnx2i95k98sKHRMWIAIRNmgo/DTtgK8V7vVe+U/yTgy/U3SopgyA1vbDf6MYijTH6+cc47OfuIjbkXBUeN+U65sWu7wK18ifhOYMo893JPCC318lURX0x0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpJ7bkErcFqXegMKSsjREmOcNrSuahL+cgRI3UL9bro=;
 b=pUFPS6tTHYSEw0kK1U+UHR5GAOGYKc6v5qDtCX3BK6lXUb41spgW+FCCc5f0cbSYGNzUgnQCG2tdhbgpQ3CAqVSa80MPTefz7xCVjw5tLX6WSiY9F6iFqp3TOocnm1qfvmtik4B8wDA8zuyULh+6ol2fcPGN34F2Oii51t0r4EM=
Received: from MWHPR08CA0038.namprd08.prod.outlook.com (2603:10b6:300:c0::12)
 by CY4PR12MB1527.namprd12.prod.outlook.com (2603:10b6:910:5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Wed, 22 Jun
 2022 17:12:41 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::b6) by MWHPR08CA0038.outlook.office365.com
 (2603:10b6:300:c0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Wed, 22 Jun 2022 17:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Wed, 22 Jun 2022 17:12:40 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 12:12:36 -0500
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 7/7] iommu/amd: Do not support IOMMUv2 APIs when SNP is
 enabled
Date: Wed, 22 Jun 2022 12:11:31 -0500
Message-ID: <20220622171131.11870-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220622171131.11870-1-suravee.suthikulpanit@amd.com>
References: <20220622171131.11870-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13066489-84b4-4d34-0697-08da54726a1e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1527:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1527E47A04242997818D674EF3B29@CY4PR12MB1527.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfFVSakdbJ2V2l40tZL8ehWdN/CbCJYpVSCt3i0s7Rx89p5ZW/z3FxJjnIo5PRVmQgYhH8cB5XIm4YPmpWCHaevwlOnTpgKxRDO9m/zjGUPYv9KMqvOsKqJxf5qqTfPK9/CIGhVe4I2he0FhgOJh68pxoDTcU+Y5dQPBrRDJ/3JzwDIZYMd1fVIuihRaHuNsqnfxPBpaNI/1RLMokH/H4xmyk4ZZa8kUwv4xFnDDEY8eDUTfeI2MyonUFdnReDbDm74OmL2vK6V8HyYSbBDYA7u1VZBsn2hDnti8QQdVDYiLXY/5/rMz2SQEx4jx0plLZsIhKSz4ZwwgboRrBROgJkm+vQzz7curTR7Lhu60Tw4EVvc2iyWGSv0NyD1l96ugusr94sf6qF8foOirEeuOnolMN9yvVctuuIiZYbZe3QrQ5lVFdtcYm252cWJuo+JiqZi2wuY7O2Eyocpw5TH7+e9UPMq9F+GqiB+2dCCjrsHIMJ2MvZCEqOXdzq6rW+I6/eEzACLppofizIdWcETXz9CPGpop1sXX1Bzw0RqiwXZ+7xPxFqPkTwOPSdFpmuwbuuM01dq3gtlxXtWhRJ2zOkWRatW1fG2wic3tmrDGs/Jc5kd0aXCfu3s2WfBIt670lipu7vBLHNvgF30IU+fPkp6nGn4i3LrEh4p+nc5dhsjUbHHdZAXdzKvzDzhYRwW23983tGLZBmbXq7Hyi7hCAkB2vROI49tBjI2mJlRKkB6clQeq81qT0GolO/EKkEP+/p+oRJ49+CwZgf6xmYKXWDBNcsFwmVPIZx2tPqZv3MI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(46966006)(40470700004)(41300700001)(82310400005)(83380400001)(186003)(1076003)(81166007)(16526019)(426003)(2616005)(40480700001)(36860700001)(336012)(356005)(47076005)(82740400003)(70586007)(40460700003)(4326008)(36756003)(110136005)(26005)(5660300002)(4744005)(8676002)(2906002)(8936002)(7696005)(316002)(54906003)(70206006)(44832011)(86362001)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 17:12:40.7829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13066489-84b4-4d34-0697-08da54726a1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1527
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
index f5695ccb7c81..4c9b96160a8b 100644
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
