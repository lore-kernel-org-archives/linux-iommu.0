Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7554C433DF
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 10:13:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B59C2084D
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 10:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uOlGsvzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B59C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 42E1688218;
	Wed, 24 Jun 2020 10:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2--p6lTWdTwa; Wed, 24 Jun 2020 10:13:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B5D4A87F19;
	Wed, 24 Jun 2020 10:13:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F09DC0891;
	Wed, 24 Jun 2020 10:13:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C245DC016F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 10:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A99D087F19
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 10:13:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oXGcBvOwkFpJ for <iommu@lists.linux-foundation.org>;
 Wed, 24 Jun 2020 10:13:05 +0000 (UTC)
X-Greylist: delayed 01:31:24 by SQLgrey-1.7.6
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7E92288305
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 10:13:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhXmuFLJTV6xsyUc7PPlUhDmZIYuc2wW2tK3Fee5e1kkMkjwQBCKACbJSz2llN+naK4zU278BaBIOLNkzQWwN8ndA7kbJR20bW0nxq108xMdCRPHnxaBMPCF5Pu7NkFShQQEFfWZbbbuZwQd5X2U93Zmpbig6BreXEOaM9qcqEi4MeT+h5FsRqzj90YYyFOdtyn4WKauub1aCJcwbcN+nBA21AlWPEkp+N6MKEKMBupWXJSnZ4SaXMJXVWivfRgUmVPy/HWiC/tqbXVY2cSIig1GRHwRc95JgDyskitLNRKxJ4XE65U+kFpYrJw9lyPkmpAPiXuO6LjVG+yf+Mwbig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnFsav5BWyGtppTcRD07y9hhbgnGQUvomzojpPPnB54=;
 b=DBGLG1h6cnbC46vr8n6B2EhdCntanyCLK7y8OVHTmuRPgPrP0JRfSMOaOB7Y7wJczIqbRqIKAnfjIO+FcxLN46TQMtYa4Z0ntqAdxeCIxR4Q/buK93lBiwiSDmZaqhDzNPFBtKFo6OKDf16LmT10FHZM6X3XcL8OVeLZKd0FshmG0piDEfWU526LwtW+fyY488DBenLmOZeHixdEUU4Kq3I8jaZ0L279P+8CeI5abXbAtB9Xbt1r9BWUlAlSb09srwV+IVI+/WjZ6Yd4Ob4dz/c6EXbr/IsLhMPLaQb4k+RP6efKw10B5UHgU/Tr3esCiG+F1EaRh63j4ib5UFqdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnFsav5BWyGtppTcRD07y9hhbgnGQUvomzojpPPnB54=;
 b=uOlGsvzP7doyeTxHz2RHdDQ5y+QG/Tbap/UNvf0awCT9ErDv7MW6eB2zeU3cLNwBGV/Od52kXxuG6krEKzQwC1mcKYJ9DR5DvwHYDqQ7TqtaasWfGhPyA0xfbN/XpcOKazBaIFZzRc20v2rGkVWmiBqG6xxBGfqspgIz1cjcTWg=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.23; Wed, 24 Jun 2020 08:41:40 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::c1bc:8ef9:9ba3:99bf]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::c1bc:8ef9:9ba3:99bf%10]) with mapi id 15.20.3131.021; Wed, 24 Jun
 2020 08:41:40 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v2] iommu: amd: Fix IO_PAGE_FAULT due to __unmap_single() size
 overflow
Date: Wed, 24 Jun 2020 08:41:21 +0000
Message-Id: <20200624084121.6588-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN4PR0401CA0022.namprd04.prod.outlook.com
 (2603:10b6:803:21::32) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN4PR0401CA0022.namprd04.prod.outlook.com (2603:10b6:803:21::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Wed, 24 Jun 2020 08:41:39 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73695901-e774-4ba8-d9f5-08d8181a69e9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB135547F746A3CAB2633D9B40F3950@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /A7WaAlwtl/2dizn5wMisBCdxfWKu+8J6LqBGlk4x/PpVFLKI3dd3zuIIXXP7bpNyFeEId1Pe5oySvzRpWdAwPmPgChGcSGqIyt9QTVayzAYUk9NVyIE0ml3pnS977CD/n+3O+qFxbVeezA6UC2+HmyfQdV3u+9abMo5gtCnCnDHJ7LMzusxhF+i/uTHAWc3owaFwrYbEu6pBhtOtDQZeKOMFZNGtlkq+sHgzqOrGQCArYxI5aW7RW+Djf0GmH7Z1gDY71qbtchXAnwOrXCJQGAEVEhuEiPzREQdgY5zXpG8aS9IL3MRRa4rGDsVA/BR2ZnOPuviP3Dk8hc7s4IeNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(44832011)(66476007)(316002)(86362001)(66556008)(8676002)(5660300002)(66946007)(8936002)(478600001)(1076003)(956004)(2616005)(36756003)(6666004)(16526019)(83380400001)(6486002)(4326008)(6916009)(2906002)(186003)(52116002)(7696005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hL3E1Th50SVPtd8nv6ceXD8AX72UnEYyNloYmmcp0ZAWENz9VweNSVPpNkac/JGM1qygYIwyqWS+yXeTGm+d361aot+F/YiInklMRBW/kjdAcJO7sn9tO5OK3dmzE5C8rKqW0UkwFRSZXOxW7dhViDDDv0pIqwNPeAkE20dhuqo5lumsdSQtMBZM/9VSjSe+iAooeuftpdk8T7AeIeIYOuIvWKHcL/vtRC4tm+PiYe6JLlycolfR4UH7vd8wlM0CMmaEyhNTZE86bGOYFbNYa5qrteBxdeGLStihixf2v5WO1vzGvOLS66kAr9O7Tx9sTi68sK42naUUnzczP1jzVZFmwiX+QWAa1fQEJr3Kx8qSyTAlUQYkuVeryRX08jv/WowwByelcdAPTqmgCfQI++vFeOCbQOPTvGNBv10JGL/pL5Yb4Txbm9omHBAyDzmTNJFNlpViUAevdI31tjYBYLPUHKUqwR3uAARCHHRMV/w=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73695901-e774-4ba8-d9f5-08d8181a69e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 08:41:39.9975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paYMsJ2/zj56nYbY08BN+b10C1Pmt7sL5B59vJm732rh2k3L2/jZufK9LCij64u/hIKEaTM9737TfvBOG0ra/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
Cc: iommu@lists.linux-foundation.org, stable@vger.kernel.org
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

Currently, an integer is used to specify the size in unmap_sg().
With 2GB worth of pages (512k 4k pages), it requires 31 bits
(i.e. (1 << 19) << 12), which overflows the integer, and ends up
unmapping more pages than intended. Subsequently, this results in
IO_PAGE_FAULT.

Uses size_t instead of int to pass parameter to __unmap_single().

Please note that this patch is only for the stable-kernels tree
because the commit be62dbf554c5 ("iommu/amd: Convert AMD iommu driver
to the dma-iommu api"), which removes the function unmap_sg()
was introduced in v5.5. This patch is not applicable in subsequent
kernel versions.

Cc: stable@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Reported-by: Robert Lippert <rlippert@google.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---

 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 32de8e7bb8b4..7adc021932b8 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2670,7 +2670,7 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 	struct protection_domain *domain;
 	struct dma_ops_domain *dma_dom;
 	unsigned long startaddr;
-	int npages;
+	size_t npages;
 
 	domain = get_domain(dev);
 	if (IS_ERR(domain))
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
