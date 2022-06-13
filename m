Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B06C43334
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 01:25:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 902EA4060E;
	Mon, 13 Jun 2022 01:25:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tZFstsSXZWwO; Mon, 13 Jun 2022 01:25:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6C90B405F2;
	Mon, 13 Jun 2022 01:25:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5610DC0039;
	Mon, 13 Jun 2022 01:25:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C550C002D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B6DD4010D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wuE9bbUT7z61 for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 01:25:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::608])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A37F240494
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4aL9J2VmUYlklHZ/vdL+bufN+ouZ6b9uZDTZ8TTDn2JGN2HV4hcv9GaJhA7q3OwdMKOgvxF8Z1ispGi1e0nyz30y94t6D8CAY386T7QubRG1P28Qps5ocfynYqvKnsK0EfhMWhQV+G5t51Y7q0vbkGAkSECkYHqvQx7eUp73TF890wKTCwMYh1NzKdOuygW3uKvaPBZ5NIodwZHYjY/h0ezki7CgZdMe1jZlST78kDMH5bVkx+WO2fFkLBB1GjudqCptl1kn6lP4c9amjKc8UlPE/ZSYVs43TGf+0BCpaNKk9f7GS/4BaBoxyMly32MFAUp63ozCae61/B8dSSrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jE3GaS6UL+EZPMYaNuzgIugGmZdR4DyenNlvRw1XpE=;
 b=K7c7BxEdhmsCJSRfJnwOFf11BR2wciaPke9E50+rjWb0Rv55/80ekELezYS6RGqWtRVM8mc72a8BG4G8/7CcFVm6gDQw2UXU162RYAG065NoLBmmZiCAdU2LRgOTLe6begttdz5KckUJCWw/T19E82hOoN/Jy42wp1QnUYYC7GCMVVy2+46yHxf9BqKHDTjaAwA9fVJ0Ckrz9s/mIlNlI/0lMb79syJpQ5AzSIepZChp9xBFuY1RyNz5Dv1WhBt0Tk2dtu49wPpLVq46SqSgXNItWPFB/XN3WzzlnGWuv/bbdP/kTYsaumjEwKFmCZe7roU27gI8/ye/kmxIlupruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jE3GaS6UL+EZPMYaNuzgIugGmZdR4DyenNlvRw1XpE=;
 b=BybJQIfcdEPSwBLEj1SomdP9R1e6kvE9qNPotiu3KH3khHcD6ovFPxU4LtZeB/J6HSMuce9F2CWLrgXEcIwDEhKvfjtnK+b5Pv+9pORBnvy7iYZ9RxoDwwPeWtB0MQm0wKclUukIcEyHeW4NQbMHVNif7lNB5aOV6r/9bX9c8nc=
Received: from CO2PR04CA0003.namprd04.prod.outlook.com (2603:10b6:102:1::13)
 by CY4PR1201MB0165.namprd12.prod.outlook.com (2603:10b6:910:1c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 01:25:32 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::51) by CO2PR04CA0003.outlook.office365.com
 (2603:10b6:102:1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Mon, 13 Jun 2022 01:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 01:25:32 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 12 Jun
 2022 20:25:22 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH 7/7] iommu/amd: Do not support IOMMUv2 APIs when SNP is enabled
Date: Sun, 12 Jun 2022 20:25:02 -0500
Message-ID: <20220613012502.109918-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
References: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bd93e9b-defa-4a89-e471-08da4cdb9bf6
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0165:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0165ABE5945623470A561631F3AB9@CY4PR1201MB0165.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6dD6DZIegP65VoUJQZ442hU2Bi/CqHbnqp9Mx+UB44nuIurzJXJtUIo2T+STsDrqE4b3wFzj5Qo0Bj21y3tDX2CotHepDlXmljAtcQMbRbtSsdZT1QNyHsdmUSd0sUCSbMgbqI/8Yf5gJlByhPkQmw1LqGlqkGT4MqZnPJg76/u1aqdaZ4uXFN4X1Bpm7hgJKqyySsH576wFFHwajfKqWpGRcfQ3JeNhj06JWUULnT2HLsj4IWLeytPEoB3CHVeH1uhilC5StNqSj1oanNquVzAPcw4jUfEgbQYfalutMmJOIqpr9GoaLzsnZuo0xK0TBViUD410qPSY9Lzn/RxsaIPi1EI/PJXY6i8oXkElvH/5vynQ+1vZa6+bm70O0DNcCHd+Gsre5i1OB3Qt+WQEiIMN8JjFxg0pe+NjVjN1EKDkjNeDykOG07ij6BXhHpYDCTDnUToYtFKRUimqCinFisoxT4woR2BNgit1KWG/x/QIoFZ/cEctZaAWRUKyTU5hAKILD2VcFRiYnQdDTV7RrNOikr8XclWq8hRxEA5muuJep49bGHTbShLwLz4lZlV+2EWjpePICAyyRelTum4g8G1R67TJYyIB/FcuPq6lFL76b71uYLk73VDhYC4z0c66JOqWs9tlLsZnnxIawTJ6ocAf9xz6o2Zdc4JOSDK7nziQ5efsE13nwNrKAaoQn/2EZJByD6invnaK0Fg0ofdKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(54906003)(6916009)(6666004)(316002)(26005)(7696005)(508600001)(86362001)(36860700001)(356005)(81166007)(186003)(47076005)(1076003)(426003)(16526019)(336012)(40460700003)(82310400005)(2616005)(83380400001)(8676002)(8936002)(70586007)(70206006)(4326008)(2906002)(36756003)(44832011)(4744005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 01:25:32.2669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd93e9b-defa-4a89-e471-08da4cdb9bf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0165
Cc: robin.murphy@arm.com, ashish.kalra@amd.com, vasant.hegde@amd.com
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
index a9152d3f33bf..1565f0fb955a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3435,7 +3435,12 @@ __setup("ivrs_acpihid",		parse_ivrs_acpihid);
 
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
