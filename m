Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B231C432BE
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 04:44:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4EB60EBD
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 04:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B4EB60EBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEBCF401B3;
	Tue, 10 Aug 2021 04:44:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HQwzfASIJuai; Tue, 10 Aug 2021 04:44:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B4819404FF;
	Tue, 10 Aug 2021 04:44:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F41BC0010;
	Tue, 10 Aug 2021 04:44:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B05BC000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 04:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 588778001F
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 04:44:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3jukQv8x7J8q for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 04:44:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A260481842
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 04:44:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7TkkNavvIViL1gInEUzuVjclU0TEkZFIy1x6cti5onkigAjUIOlczebZaFopnnveRBgKKaIUe0TERGk7p66EhMIC8/cBwcNnZGEUbmacKPh2YFfOEmkZ0/zXJXI7XA3ldEOUn8+z5KEw1nj3Q96gM5gAm+DSyk4OcsNPT0Udhvv4eC6RXk/psfL1WEEcJPo9umRoC5pgho+AyF6JEufGRVybEFavueb9BnTk9yD0d8CuruGC1f2uozcQKgWRiitBfBXIlVPqU/IvqoHGX3f+FZzkU+xkd10ewdb5Mia61SbKv54caEJUQWleL61V2wtzCmnf7oQhV9QoDO8+uTAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR46JoGEZke9JXnF+4oFi7ZYoZeS/I7xlF4nQxXsmVU=;
 b=nIX1ElYRi9Ma++gooQfTCTTagLcsM6S7Ngzy7DKQuk6w84XdqX/msWF6Dx7C9chDgper4rntuvcbolJsAEFE3nChBfXfkboVNQ3iHHXttJQTib6c70VhJwovStB04JMudRbM4V2LEtZdlAZYeosIwSXqqnFqlpOv9B/+KImfVayUuQGBG9Z0MV8eLLazoPy+WYxq4PsfNk4cBwS1vUO7VLR09aL/CjKn+cpf+j6fmZw2w7aK/dAqdYbF+aowYZHfxZf64APARuRFYr2TTFwFrtytBAf/hYZRCtPH+3GuuqYtIdKctD/lN0ALicD3/18MDg15naI69T80sfhgTJh/uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR46JoGEZke9JXnF+4oFi7ZYoZeS/I7xlF4nQxXsmVU=;
 b=HR3Ctb1Kn4cs43g6sAPpXQkw+HfD5rwggvP8DAi1vjn+7M14y7DoUZmjo28YeTW0nrAaSzkbfAcdH9fk3w5ekTYEYlvU3YIoEfCfLa8E5Gha1ZcImlsJdzP0Ub2B2jkrzJj0s/9VLK3RmA/s6knSIX7qGfYQWNph6qjfgz0pUF+MowhJdo0itB71G4sSvVJ1VUMgB44EYNxDD7R9q/bWHqmj4D2s2yQf7uZ5GZTzROH5Aqh1b8rIsQxCS7m+YA2NcIhWXUocv7cScj5V0DxR1HIZDrLt9jwEZXddKjVnA0oeZJn2OdECmDhhDALoyMxij+dQkOmf8pzuk8M5XwBGrA==
Received: from MWHPR13CA0021.namprd13.prod.outlook.com (2603:10b6:300:16::31)
 by DM5PR1201MB2537.namprd12.prod.outlook.com (2603:10b6:3:eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Tue, 10 Aug
 2021 04:44:16 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::51) by MWHPR13CA0021.outlook.office365.com
 (2603:10b6:300:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend
 Transport; Tue, 10 Aug 2021 04:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 04:44:16 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 10 Aug
 2021 04:44:16 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 10 Aug
 2021 04:44:15 +0000
Received: from amhetre.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Aug 2021 04:44:13 +0000
To: <amhetre@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
 <vdumpa@nvidia.com>
Subject: [Patch V3 1/2] iommu: Fix race condition during default domain
 allocation
Date: Tue, 10 Aug 2021 10:14:00 +0530
Message-ID: <1628570641-9127-2-git-send-email-amhetre@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628570641-9127-1-git-send-email-amhetre@nvidia.com>
References: <1628570641-9127-1-git-send-email-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 436a7218-c48b-4c99-ce10-08d95bb9826d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2537:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2537CDF513325A09A1DF4C99CAF79@DM5PR1201MB2537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DHU6LZKkhHI1NlEMe034UgfhrubKfH0PAs4hqWnzYTo+K78rltYtP6ylH4oW2gRqXhDOzS641U6DmnoQRo9rUIXmfCp4QTBtEdSOkl6GtQ4OegGpr7XzRsXFRG75BT6u6pYT/6Cf8ymDTQ38hD9iV0C8CPiyJY1eYlaoAKCVWdQId4asQ8NlzjtbQ0XqbjQsT3G+Uw6AOOh6kgUcUWSgXmT0MFZVNoW0OMG1f4rQIqcNrNuw4IBD4qKrgmLpQ8ibVpSMsQDSMmJJUwF1Pexv+z08NxomHp48UE2OHYDK+gJQZmy0gRejXPDxrFtfPzQ3T7kfh6vovJOmSO7kUar3sacjllz/FLsAlsJna6vd1orFSKTngOAGg7OKr+9Hsx0cv+pLB/5bkr65Rmt3TO1a2vw9hDF3laOR8BqxXaUQ2AcT19i8r4LXhEMTCZOzQMadvJHLizGsZmCwr0o6xLwyLU2TG8eWfZiYQNdXhmctsuLN5V9tnbKCCdZrt0RF+n2DtacIMOlzKYn50SDkNXfvoJvYqo0PoDmEa2XvlB1MnfMYVEXioaDFINERH7bmitlkFfUsrq8vQEZBO+C30FiouB+cGUMicfo+33z7tIZG+fcRXcnwOaAXcaIOwfQBiBxzs38etMJD+Ymv6VpYipQHvtoydyFgZi21zmFyX5qIq3i/Zp+5ryOIP+d+kqCVN1lrIsucM93U7FYwELJLEGQsDQ==
X-Forefront-Antispam-Report: CIP:216.228.112.36; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid05.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(36860700001)(2616005)(4326008)(6636002)(82310400003)(86362001)(7636003)(478600001)(82740400003)(2906002)(26005)(186003)(316002)(36906005)(336012)(8676002)(110136005)(36756003)(83380400001)(70586007)(356005)(70206006)(54906003)(8936002)(5660300002)(47076005)(426003)(7696005)(6666004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 04:44:16.3768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 436a7218-c48b-4c99-ce10-08d95bb9826d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.36];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2537
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
iommu_probe_device(), the iommu_domain sometimes is getting allocated more
than once as call to iommu_alloc_default_domain() is not protected for
concurrency. Furthermore, it leads to each device holding a different
iommu_domain pointer, separate IOVA space and only one of the devices'
domain is used for translations from IOMMU. This causes accesses from other
device to fault or see incorrect translations.
Fix this by protecting iommu_alloc_default_domain() call with group->mutex
and let all devices with same SID share same iommu_domain.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5419c4b..80c5a1c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -273,7 +273,9 @@ int iommu_probe_device(struct device *dev)
 	 * support default domains, so the return value is not yet
 	 * checked.
 	 */
+	mutex_lock(&group->mutex);
 	iommu_alloc_default_domain(group, dev);
+	mutex_unlock(&group->mutex);
 
 	if (group->default_domain) {
 		ret = __iommu_attach_device(group->default_domain, dev);
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
