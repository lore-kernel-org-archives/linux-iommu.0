Return-Path: <SRS0=A9HU=KZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D77C47089
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 07:51:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF7661108
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 07:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF7661108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A93383B41;
	Sun, 30 May 2021 07:51:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ty2JXbj5b_mq; Sun, 30 May 2021 07:51:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9EF6839DB;
	Sun, 30 May 2021 07:51:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BB74C0023;
	Sun, 30 May 2021 07:51:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 311C5C0001
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 122F960712
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e6UwvNVVeIfz for <iommu@lists.linux-foundation.org>;
 Sun, 30 May 2021 07:51:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 711B76066F
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5GHPYmeLj+I0N7Vx1FVoea946ZZ8MDFctIwsPY+aMV14AihTHyj8cri3skLZa5J8IOSqKUYgpE/uuAA8FLesyZ3B/aZfawXP/4Z08KJU9vl0RyLEKMlPNEYeCg0kz6wgsClhPGNUs0rf6UAfh83K1yMlA39cb8YAgHxwywacu+YCQf2ELrtEUr/32ePyCsrEldB6uZyAkhCpzh40R/LVxLe1NHuuuzqg9tzlebsZDnSSy55hwfc71uhyAzO/MFxkNBg9SAj2kuQx1mPpLt4sFxIAS30aQBu+78a1R2qVERZa62buGfvj0JDWYsx51xRuoggTzSkM2bNBUDgPSbhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrxB/6Ey+BdEuZ7s40GxqZ+1MWcfTx8KLqgNME+S8zo=;
 b=D4FTN2EO6FyOGKYyOdaoPNh4d2kiR14NUgGhxqUcF85ydI/5bp1Yz7tNztYLB/i0+d8gmI7qIeAk0RDrCi/JZBj5/frZburYzfqhafgCEjV+07/VXB0wjdsKL57FCZ1ycTHERYs5ula+6HyncJ2vCHu2EE97x40XTArZNMy7T/u5hHFqthnw51O1iyDTWsJbKySHbUhHjwdI1dfVLeASEc/TtXCJiIz9HBTx7lglM3hHJjxZ9RlyU3RYranmp4vndoowz17ibhphbmHeoE6xqwfm5pKZV6+jwiFPsZgV3g6CvMOKnOg295PhAG6CivCBtlzOBV+BmyA0fkk8HfSCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrxB/6Ey+BdEuZ7s40GxqZ+1MWcfTx8KLqgNME+S8zo=;
 b=jwedJcohj6gZ1K9A2Wqwpa5SOVvf0u+4sFwivjmRAATxhdoY0iu14V7ejQJuUx4cRwsLV3ak3yWdh1Du3i/LHiIav9Zz2lUTIRg0hHPV5DemnKD6ycYTz28xJiVP6kLDEnrvSfHg3XZ6fWyPqLtAmm+DmgiVk8kKrIO9TqlpMYW9PvMfYO+jtabfULewehTAHaBuIj8oLITfp5kc4WOerSuXkpGC22K7AvgGm5VPLMdDe6x8WAasUGdM3MHW+R93ZbcUWBuWXZFfMIoFDMh6Cnm2qfxE0rSlRSKRJMv+6UBH5JLlZQwBPKRR8RIEDSN0kAB6Wi+ma1BH1boZ+EEuWQ==
Received: from BN8PR15CA0030.namprd15.prod.outlook.com (2603:10b6:408:c0::43)
 by DM6PR12MB3674.namprd12.prod.outlook.com (2603:10b6:5:1c4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Sun, 30 May
 2021 07:51:15 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::eb) by BN8PR15CA0030.outlook.office365.com
 (2603:10b6:408:c0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Sun, 30 May 2021 07:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 07:51:14 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 30 May 2021 07:51:12 +0000
From: Parav Pandit <parav@nvidia.com>
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH 3/5] iommu/intel: Remove unnecessary braces
Date: Sun, 30 May 2021 10:50:51 +0300
Message-ID: <20210530075053.264218-4-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210530075053.264218-1-parav@nvidia.com>
References: <20210530075053.264218-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e71ccf4-cbc1-49fd-04bf-08d9233fb35c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3674:
X-Microsoft-Antispam-PRVS: <DM6PR12MB367456F8FC87BB3AB08336CFDC209@DM6PR12MB3674.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iP+mwQOJrWLWBslSUAk7slr7ATdV0/trk5X065fp1xp0gMmiMUTIPjRfN7GCnKwlcTCzgokzRRi8xbgKNSgL0SAEIf338vDILEqT37zfKFPwkiTj6Zc2XpuJNO7l5kClmKDFxdG4Zkq0lulx8J/Jqpb56wEy72v75taoMpdHURLr0vCMffwkX7rubP3oNa7+yLXdKcGhvXwTPttAdStOn3b/xLpFY5Rtyghgf/p+H3xHX1no1xgcovU0ponk5H73P0t19G4AAxNj8YCkcZyQiELUg4tvs31S1ESF+PNsLIQJfhvCWz9phg1iz5/vuoLWvjrdD/lUVScpwqThxtqHUej/wliZYqqFpQAiACbiCPt/QMTfbc2NUdAo/remIai2XS/yE3TS2Hg5O45wrJOaXpGYnZKHSFv6EiglF5hO5bbwWjZutOsB8Q1RFMybKesC9bkIidd+tSymU/48H9E6YkoQDd3XrjAvPC5xeCe/qknvTFiDSzzfdfEgmKNHBizrysXzz+5f9Il3vfw+pN8TU+APV4mVdZ9xhPI9BFHZ1xjRSMxxkEW5D/m6RXDnrebbVF4Bg05WGUjFDwYVYfC0LrVJjbA1sztNwjoAaZXPAjeXM9dUfE3/1qHycmgFEGwwPru43so/orkmQ+rZCXzApFnbN3w9WYgMmZUVpeasluY=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(36840700001)(1076003)(70586007)(70206006)(54906003)(2906002)(110136005)(26005)(8676002)(82310400003)(8936002)(478600001)(36906005)(7636003)(336012)(16526019)(186003)(83380400001)(82740400003)(356005)(36756003)(107886003)(36860700001)(2616005)(5660300002)(47076005)(4326008)(426003)(316002)(6666004)(4744005)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 07:51:14.6980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e71ccf4-cbc1-49fd-04bf-08d9233fb35c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3674
Cc: will@kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

No need for braces for single line statement under if() block.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/iommu/intel/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 51be77c48108..6788d10d0ff6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -682,9 +682,8 @@ static int domain_update_iommu_superpage(struct dmar_domain *domain,
 	struct intel_iommu *iommu;
 	int mask = 0x3;
 
-	if (!intel_iommu_superpage) {
+	if (!intel_iommu_superpage)
 		return 0;
-	}
 
 	/* set iommu_superpage to the smallest common denominator */
 	rcu_read_lock();
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
