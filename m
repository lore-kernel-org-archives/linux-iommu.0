Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8114AC4361B
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:50:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267B92228A
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267B92228A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D0E9F86C7A;
	Tue, 15 Dec 2020 07:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bqdeO7gnUmcU; Tue, 15 Dec 2020 07:50:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 53A2186BC9;
	Tue, 15 Dec 2020 07:50:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C645C0893;
	Tue, 15 Dec 2020 07:50:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 996DAC013B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:49:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 87D4086C77
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:49:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kfq8FNdWaoOL for <iommu@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 07:49:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4AF0786BC9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Esv7BAtBPkLPGQlXootKLuVlDIEvytZOOancJHvVkGaBQlUa7BUS2bjnxsjBaYjg4WHvZU0ALHCtEPapU49ysXZhm+4vqtuNjnXJruJ4zFkAO1uqCSPouqkA+rie3l8CIqrxJZxt+0gI8u865wN8W/Rdxn0KVMVvXC0P+agAy4n9+/O2o9BT0c0euq1Iga2bsbLWYzFucYBxIRkQS3LlskCJKPM3WZD1k0muaSIo9Yua+0lr3V4jvkCr3XealdduRe8WbOc9b9SctkLqg+MtRVUEDGfZUdrxObEhsFtPIL30kCV9MtyTQSFrQv4bYnA/2CxHx7x9gYzJDpdF2E+mvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf8lxjeXIhkwTR35IPlsDPxJvymskOa2FAtLJmulFgs=;
 b=KeYKE3wJHCW0ZZek6OzoVnO3paFp5vkmdWiCo87SSzmchUNNWiBdIjmAMw3EiUCjR9zf1meNLJzey012WKWEFFVdKOLBR8The7odt1MJdcpgJ4Nhs4UfGtWO2D8HBy5HCb92yOrdpQEfeTh6VHUNsN0nS2NGVpGr/GKb5Vu+au8GBHq8/5r6q36oqZS21N/xjPC1XDSpopdAERmymWCY3eDmSIfuX/AfDSixKf6Xd7dq8eJBQEEWstYCjjOuM+NkUToxZLm9MEHzAFSopuTgXy439S6Va9mDMoZQ4oYXQtIqL3ZKE4lM9IndVskLitAQ6wZy4PJ3ztMaHI0VovrRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf8lxjeXIhkwTR35IPlsDPxJvymskOa2FAtLJmulFgs=;
 b=WiCQB2foA1jqNAwkrwV1z2a2Vq1rLcO11e8JP26Juc15kFNoS9fVhu8EJ7JKIC5rPoJxvP6ugP/d6f3P53ucyAP1cH0eZkq/uPjha0QTY1CVjt+AY8K2O7PGviThlsM4w7Ohbzv7VcwvjaYYrc6NZ+M2VnxqoqQqZpRYrIyQvrA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB3794.namprd12.prod.outlook.com (2603:10b6:a03:1aa::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 15 Dec
 2020 07:34:37 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3654.021; Tue, 15 Dec 2020
 07:34:37 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v4 01/13] iommu/amd: Re-define amd_iommu_domain_encode_pgtable
 as inline
Date: Tue, 15 Dec 2020 01:36:53 -0600
Message-Id: <20201215073705.123786-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
References: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN2PR01CA0060.prod.exchangelabs.com (2603:10b6:800::28) To
 BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN2PR01CA0060.prod.exchangelabs.com (2603:10b6:800::28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 07:34:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec4d75a6-6032-4d71-0365-08d8a0cbe04e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB379445B86BB87115A50EC2A0F3C60@BY5PR12MB3794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cESSP+nJh3lg3WG3h06tcM0NsXpkhV2rR7aXm1huec0grGLWzIujUpWIHYL4EXPtNtcn3/f/YYwVDCrD4vtOpjTlCIi9A2JJ4AIgnuNAvKSH2nn3j+FITRx9kY3x3uPmQGlMyLF/9qHaQF/W+VkjOUbC1vV3z7PozNMQumGHYAt5z9/yThcoRcUlMP3x4a4OMbLTZVCvcflh4WYGiYofHMaNeamfFo97FpzYxkX9nood01ARu/GfOAz07P/tKFRsVpKNgqxR6iEM7mojKOWW4xBuktCHwDCq1yP7kf+fvhqrN3oqU7hXrqC3f+Ds4thUpfbYv1+6BhtSaNxYDlVo83lFryyc88G1iKolls2/E4wNWGhufnzCY+UlpHY2/X5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(6666004)(2616005)(66556008)(16526019)(86362001)(956004)(66946007)(6486002)(34490700003)(26005)(52116002)(186003)(66476007)(1076003)(7696005)(36756003)(83380400001)(5660300002)(44832011)(2906002)(8676002)(508600001)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NsnsXlB2/IxG18/pWb/y0Om0b5JMjJDhwFRLBroQNVw29znBUkY6U8uFAskC?=
 =?us-ascii?Q?kJsN5+pF1VdYLIzdiuvjrY8OXEBl/i4pqDVt3xbSXdsto7et7Bm0xWnYgqVI?=
 =?us-ascii?Q?wwGxMWpjzuqW9+JnT4YXJDFbLXWE6H55+kHkhEAKnj1x+T2p6EPv1iNHdZbv?=
 =?us-ascii?Q?e0cELG9ElRRkGhxVv6BH6iWQRhbEci4j3ByY0QEzGWDo221hHrN/emIt/peZ?=
 =?us-ascii?Q?LImUJU7cQCqpqHJPa6AtidoOfmfLIsa6rFo3iWOniGt6vKyXVvTFqyl0n5Wn?=
 =?us-ascii?Q?xC5OPgNU0CbgM1dsboRWA3q1O+GkmsMffvysDre/gALjamdz1y5Jux/KGkCf?=
 =?us-ascii?Q?/Dnc0jm5E6gi9Tb6wTwYmKfQT7ZYU2iFAw+DvpygPVbI38y4SE9t5Xziv/bD?=
 =?us-ascii?Q?0dneieh5rqdiIGQ410wQuC5ksAqcoiNnNdUqYRjRx9xU+RvPosNINuRH+OaE?=
 =?us-ascii?Q?wm9Tv5R9XRA7fRPh2iOlG4AfzwvEsdES2VMqkp3CNa1PYtiuA7Dc17KaIsYo?=
 =?us-ascii?Q?0liW8TTi3hHT5EGVQ7Ejvg6t+gAwsJhXhv6dYDL2PHmXh+le1qoMEvevAl3S?=
 =?us-ascii?Q?cfT9/HaLjx34OZW8iZHKVwJlIkzdQ3k0bLhvSyp26ZX8AI1LhuxOHl1K74sp?=
 =?us-ascii?Q?muPFi76CxtLZKvzlwMWmajN3b9W+zuAn1d6cP+6hLv5Hq8P2qSf8owgJ/zku?=
 =?us-ascii?Q?dGWVbplyHq53S367+dShbF+V5fPzN/6N+1OZMGER9x4BqjWTIh2K5vH7GSDx?=
 =?us-ascii?Q?zhb3q4WFVgxRCsgBG3ZLoIz19LQRxmoviyLAZXX39VXJT79p8T0B12ZfY1s+?=
 =?us-ascii?Q?gcRUKd2+mxUQul/jxJSCNXbBkKhloKNL4eVamUQJhS79HXKWkIS8BEC+/vjs?=
 =?us-ascii?Q?rUdbx1sHy/OFImxKUnFC0sWZppuW9JN+cVwm8/njbm9aPtwtXtwiShqOiJVv?=
 =?us-ascii?Q?zOhxypFrsBfwhAr0Ucr4IoMrr4ezQ6Oh0VgMYqc6npJ/kEgaFILbMd6xzl63?=
 =?us-ascii?Q?D3rk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 07:34:37.4020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4d75a6-6032-4d71-0365-08d8a0cbe04e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/ZxTssgIez54SD/hOX048SF1BiHrpnjJ/FNptE8pInsrQQqlsyzIP9ys8aGpPDUPeSyYT5VJaAhSrD8d6w4pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3794
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

Move the function to header file to allow inclusion in other files.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 13 +++++++++++++
 drivers/iommu/amd/iommu.c     | 10 ----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6b8cbdf71714..0817bc732d1a 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -102,6 +102,19 @@ static inline void *iommu_phys_to_virt(unsigned long paddr)
 	return phys_to_virt(__sme_clr(paddr));
 }
 
+static inline
+void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
+{
+	atomic64_set(&domain->pt_root, root);
+}
+
+static inline
+void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
+{
+	amd_iommu_domain_set_pt_root(domain, 0);
+}
+
+
 extern bool translation_pre_enabled(struct amd_iommu *iommu);
 extern bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 					 struct device *dev);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b9cf59443843..7f6b0f60b958 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -161,16 +161,6 @@ static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
 	pgtable->mode = pt_root & 7; /* lowest 3 bits encode pgtable mode */
 }
 
-static void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
-{
-	atomic64_set(&domain->pt_root, root);
-}
-
-static void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
-{
-	amd_iommu_domain_set_pt_root(domain, 0);
-}
-
 static void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode)
 {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
