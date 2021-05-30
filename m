Return-Path: <SRS0=A9HU=KZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15482C47092
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 07:51:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20B86052B
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 07:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20B86052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6433D60787;
	Sun, 30 May 2021 07:51:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rRgjSyYT0JAv; Sun, 30 May 2021 07:51:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6751560662;
	Sun, 30 May 2021 07:51:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5263EC000F;
	Sun, 30 May 2021 07:51:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9042AC0001
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7092C403E8
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8A1vqwQXPN0L for <iommu@lists.linux-foundation.org>;
 Sun, 30 May 2021 07:51:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75C98403DA
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 07:51:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrHPNbx+3g3LUlYUAryiOpyoxWiroTAWFJmwbLz56TU3otA4ojG12W9yo7qNoj8PP83sYBf5zJR0aV68lvjQaSt+y94CdoLLq7W3+PUJ8lkM+Quw+Q1HwgN+BpC+AckyHCUVL9Ua/Y6jB7yovGLE6zHpTTEodAg8IbauFjQ49IaRg8WkHUpJmMWqkyAmX97HSp8xNjvVRS3Cmo2kX04LkCbzh1kumaKmE1lrJdN5SuS/FJwTmZAZhkY+X1xK6jKFoOJcSFXcTeVO1kSGoB12gkhp8a4LZ2mkST86SVWez29UgEi8N610e0xYI4ZBHojQ8xlG7UCkLJfxLfS9RfYpmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm1WoTKU4mkyuT0eBh/WQlOsWmeukpMbzYLC00xMCts=;
 b=myjmZrg6lIbUcH/SVyrej9sP9ZKDh7X2RhqdGCBbubDyTWfjE2txq/ea/jJ4shtJgkfYM6BZHWKDg1KJdxZYgZToTozo3u8OChNcBeuh/6l6otoP+1nNHu63Nt+A3TYlYxMnD2R+vlV6H3LsEetlUBM1eJ860o01ORzlNbIhqwUqHQm7y59crfVvQxznu5/kLf/ZasM0yIAulE4HXUjPdeJ/NenZE0WS+TxK+0/JSlyDsrub71TU6Ub1SjPnjABa4aHb7rihjZTxgQLqCdXUZ70Ie3K0dXSTh20N32arqPfwZsBJ6J6woY3p/3BHwRYs5cCQi55hXuoiJ9L3tpm5nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm1WoTKU4mkyuT0eBh/WQlOsWmeukpMbzYLC00xMCts=;
 b=olENgp5sBHNuTreEXNnrnvt7Mdl79as1zACaQNLR2J3dGScDPcZpcRFkKmtZnRsz9LR7C0ApXNxJrWXmz8XlkeFIFtnYIPEM4WZDhYrK+g6PXGxTnLvpHzLi84/pQMIDL5GLbmL3yQHdGgmIYe5Tgg5KB6oZn6g8cfO8qbFr9HEpLQxNfbQVDtLuBM9ZXLmGitehRnGWBWYtjjAiV5xwBgJT/oKBwODjfeQFTrRbsQ7gJadjscUAC2ft4bxxmxEu0QX+zphFVdlzKBefNNa9yCXdvWN5fcB35Ynuz3Y0ZocLKPwfgQUrg5UswMYFy/7LRKW34lG3uoTjTlot8bC/Kg==
Received: from BN8PR15CA0008.namprd15.prod.outlook.com (2603:10b6:408:c0::21)
 by BN8PR12MB2930.namprd12.prod.outlook.com (2603:10b6:408:69::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Sun, 30 May
 2021 07:51:15 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::f1) by BN8PR15CA0008.outlook.office365.com
 (2603:10b6:408:c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Sun, 30 May 2021 07:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 07:51:15 +0000
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 30 May 2021 07:51:13 +0000
From: Parav Pandit <parav@nvidia.com>
To: <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH 4/5] iommu/intel: Define counter explicitly as unsigned int
Date: Sun, 30 May 2021 10:50:52 +0300
Message-ID: <20210530075053.264218-5-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210530075053.264218-1-parav@nvidia.com>
References: <20210530075053.264218-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b0637d0-58d0-4450-aacb-08d9233fb3c9
X-MS-TrafficTypeDiagnostic: BN8PR12MB2930:
X-Microsoft-Antispam-PRVS: <BN8PR12MB293009C412D75D726FF0668FDC209@BN8PR12MB2930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqr0PbMCMft34XNFONIFmf/5x0C/UM3qZgBoSMn3LnEJThbB+Q43E0s5e0qdcDeugOHrzn07xIyp1s67Jj06OrkzxBaVZ7U6hMprD/emI29IL9INkfEwH1Szg6zSRqRIiXWD3Mtjgecd9BkxMcmaDUUfu7JTlwEURYHoPMAZuHWAmyRiiQr6hqH2rlfRy2Y0oEygzqubWa65PEbZtPNoTw7OVp8bbn+eBu+7RFwowZlqJddQLgZKkdHdgJlpSUzwlgKgfS+bevul+j/+2RvDpzRox2mcEqNRVr7SVD/Ha8yXpc8S8SbeSAOhrkoz/EfELuuLrwjjQz9UwBF35GfPECh3oOFNwMF0oOxjZiKKsLyPVE6/tTlULvRjiLyI2+xQI7xy8FiouIWlKa3782ZaeNhqKxvzGGmBaS1zY5lwKa61n2Z7x5UGmMyUxhWuumjrrIAcm1QzFYeSlPtOVp5LuIlt714VnnO+ZBP7JU3MMlQwREPOJl6K6TJPeBd4zHJQStJvB0hO7s6OWdmz7i7bbcHQo7OJVfRZOLbd7RPWBhKGEWtTm1VxBlh2m6YZ8WBqj0zOD6b4GhFiPC+rm3dlRn3mDR35bOT0UNAaLBTLHLU16DcYfh1Cfz4X5EQy3Vf2vUch4UWbV9bmBT0RUO60fXmso5usUPUo/hMylMWHyMs=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(36840700001)(186003)(110136005)(2906002)(54906003)(4326008)(16526019)(70206006)(82740400003)(70586007)(6666004)(316002)(86362001)(36756003)(356005)(8936002)(2616005)(26005)(478600001)(36860700001)(426003)(82310400003)(336012)(83380400001)(5660300002)(1076003)(4744005)(36906005)(7636003)(107886003)(8676002)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 07:51:15.4306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0637d0-58d0-4450-aacb-08d9233fb3c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2930
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

Avoid below checkpatch warning.

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+       unsigned        iommu_refcnt[DMAR_UNITS_SUPPORTED];

Fixes: 29a27719abaa ("iommu/vt-d: Replace iommu_bmp with a refcount")
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 include/linux/intel-iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 50a006cc8c05..1b3c22e030c9 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -537,7 +537,7 @@ struct context_entry {
 struct dmar_domain {
 	int	nid;			/* node id */
 
-	unsigned	iommu_refcnt[DMAR_UNITS_SUPPORTED];
+	unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
 					/* Refcount of devices per iommu */
 
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
