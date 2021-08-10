Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F98C4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 04:44:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BED60EBD
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 04:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33BED60EBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E96B160817;
	Tue, 10 Aug 2021 04:44:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9yijUNPwnAiH; Tue, 10 Aug 2021 04:44:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9578860632;
	Tue, 10 Aug 2021 04:44:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 690BEC0010;
	Tue, 10 Aug 2021 04:44:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11B4EC000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 04:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E0E1D60817
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 04:44:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xHCLnNkZV6ml for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 04:44:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D14CC60632
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 04:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaM+jBBBrqFPvBa8gGtRorzFGD+4iAnSmrSS4fMBO/iTQBF3HvKW6NeyuoYn5ylwfpLRwnAcrBz7XdOsmd9hBoahE0dR19VBPGa7QMuGndmhSV2YidtcqCEG+jW7UAHQwoh5JR7sloqF0RoLh3SsGAVOMMb91K/nh9jEQaifWrNvDgKlT4c2mtBkRDVAceXdLWScRoavpni0SbDtqJJV8221Yiz1p7PgqrCaJ5R3FGoMp1ZgujZYjlp6+BvGffuWWFp4vk6HYQprzKlPrws826elTjPNI4OyUPjigW+hr6YDVgOCTjQDih+V4xsL5fBpCCnVyWSODtOkiYX0f3Pj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETBMh5z/LwFMxjha1LoleeujkDs7tx4aOx0AtRHC6uM=;
 b=Rn8jW6vHUaKkdjLuHsWuQwTtlURarxXD2NjV+ZeEi7GWrAjkIOTDFnIR4wSJXrLaFdUwgl7VU5V1+eRB41PgaqVAog7miVzZGVEsCFXpzxwWgciarDrGzVN3fMhgJM4/3ekIyB8KfT4FKemPrp3hlsdI6tbqXLETb9Byp/GLJLDFKG1suG7Z2d7xSrZj0CM5MiJEXvGf36kXf1FH8itbirAwq9NuyF1PpN+3AgSR9BuWd4kL36TqiPriBhW445fWS3P616S5cbS7hY6I95JZ663pZ/nwqmjp6w4HnQPf2zvYyqDwcSljZhLMbjOgsTI8gRQ4RLuKVQRxc1lDtQRalw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETBMh5z/LwFMxjha1LoleeujkDs7tx4aOx0AtRHC6uM=;
 b=HezCQ5+NF8hMVrWFrKvww6Ihqy+QZ3feL0klbbL2TNbbItJTifa5/I3Nd27+Ks8yUIDn/LcCbd5fAKc3rhtnJy+lT9hdw38xoXGfZ3i8J2R6JLUNOI3f2Ip8QX1IzkwocOI4Rb0IXAbyqJ4Cc2JCycZG+ufxDfIF+HzPVHmdqqUsfKEOnc/WKndu+edNvvQWgRs5Nm1IupT2PLrg2U5VzEeHTYqVA3wrogc0cYiijX7mVvBAfONyKnksaYwJGRvQyweOH5r0dAMnzsa1Qy1/qaXPQDkUja33K/fc5ZVTyerTcwdE5LHpVqQ7kIR6JHib1eJBakWEqJ+1h0ZJYEuqZA==
Received: from BN6PR1101CA0017.namprd11.prod.outlook.com
 (2603:10b6:405:4a::27) by MN2PR12MB4440.namprd12.prod.outlook.com
 (2603:10b6:208:26e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 04:44:09 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::55) by BN6PR1101CA0017.outlook.office365.com
 (2603:10b6:405:4a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20 via Frontend
 Transport; Tue, 10 Aug 2021 04:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none; vger.kernel.org; dmarc=pass action=none header.from=nvidia.com; 
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 04:44:08 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 9 Aug
 2021 21:44:08 -0700
Received: from amhetre.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Aug 2021 04:44:06 +0000
To: <amhetre@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
 <vdumpa@nvidia.com>
Subject: [Patch V3 0/2] iommu/arm-smmu: Fix races in iommu domain/group
 creation
Date: Tue, 10 Aug 2021 10:13:59 +0530
Message-ID: <1628570641-9127-1-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 054297bf-08e3-4fa4-caaa-08d95bb97de5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4440:
X-Microsoft-Antispam-PRVS: <MN2PR12MB44408D3E59228AD7CCDE94D6CAF79@MN2PR12MB4440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jd4suFMPYqV+XzIbkujrfCF130+8z+NlIsmJs7pS865CgxTLLGaYLgoW+rRLRGW7eisKbq64AmpXUeKHyonJCttIbbjv+rjmwu8Wpu4Q4jPG7ES67d6jc5rpEpwQZygZ5p8LjwljyPj8AYo52CysPkwpffcwUrDVpiJOaVfLjchONHxCeejx0iT33N+9yRkWfoCcHMFuVee5d9kffgjMcdBaeE9B6ku8qKRhPkZQjy8T5UW1PFZi3xkQeyyKCr617D9YRqb4Kjrz2+LmZC8LJsEPbsh5SJkZk0cx9aFLoT0ecFNDl8toRGNpSSakTVzaryYX9lkDEN/5BMLC1LdUPWXHb3FFg77zLXU7Jd1UHXvSIleJKo2ps4x2YcwM9PU1lw5NqiDSN4yCaLQ83dD95izAjDxY4zdNIZRckjPInSml+EiTW9PRqgh4YhGwoQVvaUwi2m74acWgSkxk8YU/RkGGNhn1jorxveSHi7cz5lHsi6SIf3vn82A9JUI2I2vNKvtXgmNB6X5Stv0EHYRBwk277o9v4LQB0c33R/OmH0QAFvCXiZyBmTHmZu3/yhFJ/AIB2dT3O9TY7ColkwIFiBixjnTlAeOFjLc3Iym85h+JKvD7rQ/bp/rcKPW+IwT2td3nIZa4J5YezcK2X6is4u2HrkzVaR/s3dDhyegfWZY1ahwN6YR7hWeLtO72Z31ImmFAHRRi6+5pnyH6352o7A==
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(39850400004)(136003)(396003)(376002)(346002)(36840700001)(46966006)(47076005)(82310400003)(4326008)(426003)(110136005)(5660300002)(2616005)(83380400001)(336012)(70586007)(8936002)(4744005)(26005)(8676002)(82740400003)(478600001)(70206006)(54906003)(7696005)(6666004)(316002)(2906002)(7636003)(36756003)(186003)(86362001)(6636002)(36860700001)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 04:44:08.6596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 054297bf-08e3-4fa4-caaa-08d95bb97de5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
From: Ashish Mhetre via iommu <iommu@lists.linux-foundation.org>
Reply-To: Ashish Mhetre <amhetre@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

When two devices with same SID are getting probed concurrently through
iommu_probe_device(), the iommu_group and iommu_domain are allocated more
than once because they are not protected for concurrency. This is leading
to context faults when one device is accessing IOVA from other device.
Fix this by protecting iommu_domain and iommu_group creation with mutexes.

Changes in v3:
* Updated commit messages.
* Added Signed-off-by in patch 2.

Ashish Mhetre (1):
  iommu: Fix race condition during default domain allocation

Krishna Reddy (1):
  iommu/arm-smmu: Fix race condition during iommu_group creation

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 6 +++++-
 drivers/iommu/iommu.c                 | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
