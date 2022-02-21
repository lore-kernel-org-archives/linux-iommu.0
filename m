Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD517C4332F
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 10:54:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65B644053F;
	Mon, 21 Feb 2022 10:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tetTS1D8A3sR; Mon, 21 Feb 2022 10:54:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0429F4016D;
	Mon, 21 Feb 2022 10:54:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0ECC0C007B;
	Mon, 21 Feb 2022 10:54:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E976C0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 05:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D357405AE
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 05:00:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dHFMJOARWit7 for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 05:00:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::613])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8212F40353
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 05:00:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/lVSEd+7o43HovkkNHonbj6pQKK7suUszMUMAno9k6VH2HWgPpYn1TuM/wcNLaQmHVvGhjxQ/Y67Ku0ZBNXOq8orWHDOYP0BuqYYVY4obdVZlRpWRHM8ZL1qC6ZPGQtackl+WlM5n62AS2gu6TkKE2oqhqz8RvuQ9UkKAJGF8dyyW4n1F/gnBGbbZH1VsYFv/TKVYm4QF7hJuG7HKESsMHLSfd2WeTp392n6BmLUNxvBsLrs057l4MWtqkLTIdk/4V0jWPvq2OHinaJqM1KA0+Wi7j2pQanGVoA5YWaOeVSG9P+w5XzifUrFSSfKTayNFr0/nv0YFjNPdGCjnvIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P58f5gzAen5QKVjVZ384C1ohV432jeR6A3Vu4xAMhLo=;
 b=e6o4r6+VN/eFykTGcJOTHAonGDPDMLgcLzpB/zVNQADbksql4hO8jOVZihXK0f+IfVRLFM+sQJ+czPSjUCqozSQmQ2ynq82FxHOIgRZnk0sF9O7Zf1bNNaboZfLO9Zx4AWngg0zAMWFsXnKg5y6tpsZw0nqqIq2dF1J/piLo0mQf101MxVx0D4TLgLxXLuQRczFrKtrOttileHd8rhR00MX3cOM4S3Xe3YVwRqsJng3wOFHsG49dQKPPn/MEBKbrNdhSQYzvZ5EQz2HxD5t5FakiHpkuLp+lBCueGkL9ZRwJt+cN5+QOqYX7Ere1QOxptsAJqmyYdkP82vHL82JbgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P58f5gzAen5QKVjVZ384C1ohV432jeR6A3Vu4xAMhLo=;
 b=nbJQ1s0z2t/RyQBgCjLsaf3CY75pTyxlmSpErtw+XYhITQrWiHlF88FfY4kE+SxSJ47KX46ofDayZCWyWJVG2GqnBfd/Cm2Ylm/SW6J3TAQ6NJcKvwgYxjisy7Q1avFuFlVtICFSzRb+aFaRdQiPwKpyEb2me87u39INSRPn80k=
Received: from BN6PR14CA0033.namprd14.prod.outlook.com (2603:10b6:404:13f::19)
 by DM6PR12MB4730.namprd12.prod.outlook.com (2603:10b6:5:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Mon, 21 Feb
 2022 05:00:04 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::c1) by BN6PR14CA0033.outlook.office365.com
 (2603:10b6:404:13f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Mon, 21 Feb 2022 05:00:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 05:00:04 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 20 Feb
 2022 23:00:01 -0600
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH 2/5] iommu/amd: Call memunmap in error path
Date: Mon, 21 Feb 2022 10:29:13 +0530
Message-ID: <20220221045916.19701-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221045916.19701-1-vasant.hegde@amd.com>
References: <20220221045916.19701-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8247178d-7b9a-48cf-3222-08d9f4f70614
X-MS-TrafficTypeDiagnostic: DM6PR12MB4730:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4730676BD33B256A788BC546873A9@DM6PR12MB4730.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QqfaV0Xokb/rVmB7NW4cKEETHN8eBO3VfgQwnWP+GreGiYx0QaLjk16gcKSLX6oA9ys0ZC8cjFXkZGaQqS0oEm+uLsGNS0MSMLmMRUiqzFKSQHRirn5xyEvhdVwqgq5L2tqfZAEffc8Af/fm+/L6Tl8GS1D96nzTF7TYl8N5iqn/hsGCpwtNMbIMWMnX6SzZOOy0gjYpL/S+QgxgmlMicQRufNlLV6XKXiuje7wR9fQmCDuOuii/MXkvmz+X2embEYabVZ47QKPpNR/AObe/VXXvPDFcr6VV0reVCtNGALVgdHUQ41blEL7aQNvJfvgkYheaiLEtivR1XZSnOb3Gb/m0gTj8X8MqMBpEjVXC3sW65QXB/c9hIyPeqxOLo3t9lvmQo/26Fv4IhesEoGbREWkX1yZuGcTsYiccm/j+cUjY4jfIa2+8gV8nLrd5Pqci+9fVijtM8nzpmxaLH4ToIgOEETMRKH5242n8/k3UiWnH6sLMvSbBSifEveQrjHonzZJi3EhbxU6dngp6QcPBQG8v/19SNR14pXXgwxP3srzjddyb9Tgw6m0JKOqrmRLfD8Pq8ebGNeIvhUhlkRxXS7IdQBxhM0mmxkf0kKdzS2F+lwVS6JZmPNU2dyFWKXxMBrXRBc1MHxUT715V6LdwrvSVxytl0I8/pnJlMjlKBJ7MOD+RiUovxd9bxyvz+9MfI9pRFmm3bO+MpDsSxAyzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(316002)(36860700001)(82310400004)(70206006)(70586007)(426003)(8676002)(4326008)(336012)(508600001)(4744005)(44832011)(2616005)(5660300002)(356005)(2906002)(1076003)(186003)(26005)(40460700003)(81166007)(86362001)(6666004)(8936002)(36756003)(110136005)(54906003)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 05:00:04.5097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8247178d-7b9a-48cf-3222-08d9f4f70614
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4730
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

From: Vasant Hegde <Vasant.Hegde@amd.com>

Unmap old_devtb in error path.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 770ac679b682..92c489c1467d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -979,6 +979,7 @@ static bool copy_device_table(void)
 				get_order(dev_table_size));
 	if (old_dev_tbl_cpy == NULL) {
 		pr_err("Failed to allocate memory for copying old device table!\n");
+		memunmap(old_devtb);
 		return false;
 	}
 
@@ -1009,6 +1010,7 @@ static bool copy_device_table(void)
 			if ((int_ctl != DTE_IRQ_REMAP_INTCTL) ||
 			    (int_tab_len != DTE_INTTABLEN)) {
 				pr_err("Wrong old irq remapping flag: %#x\n", devid);
+				memunmap(old_devtb);
 				return false;
 			}
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
