Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA08C4361B
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:50:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8643E2228A
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8643E2228A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3E8C3875DB;
	Tue, 15 Dec 2020 07:50:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5HuiWikY4hDv; Tue, 15 Dec 2020 07:50:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 870778759F;
	Tue, 15 Dec 2020 07:50:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73F33C0893;
	Tue, 15 Dec 2020 07:50:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0F21C013B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D5866204A9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:50:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fQvcY5-0PrUt for <iommu@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 07:50:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by silver.osuosl.org (Postfix) with ESMTPS id AFDFB20004
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T14zy6flJow8AjX8tzdsW6BnsG1W5txj4vBXPn6YXpz0G5DbWe89vvVJv/IbL0NdKc2OOjcwQLA7OSE9O7PKivx4TpLexk/4J6HGFmVq5klJEOrEjMnHwKBp2dws6NW+cLVzRXmV4xhAmMN/THj9Xxc4AQbh4BhewPSMd1FO5XqIiy1LgCzHWM6xtsU32fM+VY6RJFUsQleBQzjEfJBMdFBzUARcTKCGzYDyN0tdIPgrkfs21WiKpM+kOUtI8ERZd8qkb/wll4xbJwkJOmwrUxnZe+dMJpZbmhz/TpDMWaz5o6ydnbwbGkUou7062dqszhNLR6ZuAcKboiPI3ObePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j20cs2xxBCH7+YRis9xpxmLsxCDFLkBh9K6UV9/TsSI=;
 b=HmUZLTHSrNIK6DYNPAMm2X2rp5qOn9RGa3Fa5VqktHe+sBi25lUrhLmsOPpSYBcTzTRwpirTAYYQZFUUUEbMcqrK4uyDVx5EkFAXpUnhvlbvtkGyL2uzH2sr4RsnZo6fbvOjtX456QmYPDeT9nl3//YRAwrJxAGs5Fd0cXHerDK+BLen4qjP88GN8O4LRJMW7TFZH+vz85gm0qdgYwEJ9G5L+gOjiI38wT9Ap2e+bsVogPJXc61ZQNEDMYzx1v1K6byuwzJRi5PQFBA78CuXOe1LuYRNj1OwxeG0mtl1zv1uWe9qg4mGxTdsfKO2P3QY21Mlvwjl5s8/wovtDe9v5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j20cs2xxBCH7+YRis9xpxmLsxCDFLkBh9K6UV9/TsSI=;
 b=IN4ZdZqnZD6TTPpuacnMfdsDZUrlD+z+b4gXZBUDJeiuXdj0r/kP6EoQviNShpH7n0h8ED2dy3wXgucTaZDVvMEC7Tg8ZqJL5bRuHfAWW8192j4RXO4Nmk/Srpawms4eZDFacMTCKPom5MBZnYE3AJAaUgdr0xl3VMmWMCOzqSY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3127.namprd12.prod.outlook.com (2603:10b6:a03:d8::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Tue, 15 Dec
 2020 07:34:55 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3654.021; Tue, 15 Dec 2020
 07:34:55 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v4 13/13] iommu/amd: Adopt IO page table framework for AMD
 IOMMU v1 page table
Date: Tue, 15 Dec 2020 01:37:05 -0600
Message-Id: <20201215073705.123786-14-suravee.suthikulpanit@amd.com>
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
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 07:34:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a3323fc-9102-4a54-d100-08d8a0cbead1
X-MS-TrafficTypeDiagnostic: BYAPR12MB3127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB312758B9BEDF816532EA25A9F3C60@BYAPR12MB3127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EoON74h/dC8A5FaHwyu4A7e7FHnJiwveyd9eOOdw9PN9UX6dHVA7EunWLrrpWddyjkILh6Hn1psMQRjxfnKqEcQWkN4O6y3eBEoOv4pGPiy8wkCnJvwLj5JCrtYewmcofO+eA8Ws68yNPPQmIVOC3BAuAu3q4mHttNCTGGEksPkWMMV+2omyfvvu7sDRbMJkCbYeRHDLOKJUWaYVq69uyPZRDqvCbplDdrv2pkwk3qxdDK7KEfPZgni9O2mkA5KcnfjVCCgzTPCh5kIm6UV8AGBbEWdYsRxszutP5VAfRrHCLXm91pTzLw1d1E0NC85Cdc7KoNmToR65IvVwHAGUx9nKg3w+vS4wyoUXZ/kUWYUYwhlUT8jzEbq/mYFf/m92
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(66556008)(66476007)(66946007)(6486002)(34490700003)(2906002)(186003)(4326008)(508600001)(8676002)(956004)(6666004)(86362001)(2616005)(52116002)(7696005)(44832011)(36756003)(1076003)(5660300002)(16526019)(26005)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IeCcKWsc/2+qvcxVQYthZAK0mBrinRG4lIh8Gmoqhlu2wEJBUYn48izj7gwV?=
 =?us-ascii?Q?DbwzdaN0rB+7lHupez37UR67KkRPjByR8R20Jssbf+xR1tl1Op+DH4jxVBvv?=
 =?us-ascii?Q?9XYhaN9C6rMb3DlOt50m13VNhUmCGP3hSvlbk+WKThf+xDbewlcpGxJjrjjA?=
 =?us-ascii?Q?Xe/7+L7wJ+I0s8gWRAxOQ2z2osEikzFdbLcZeMmL3pxktlGI4hm05YxhtlYx?=
 =?us-ascii?Q?oLXjPE+DJspcxWGHOnwqK5eoyoKKh5WL3GuM5LkiqMcaiZXD6H6W4YUrX5xk?=
 =?us-ascii?Q?P2jDJywgjOq/RlbfLCtVAp09fbtpEUX2+XYzW3wrGfeIfRowfiBlvrmB6n9n?=
 =?us-ascii?Q?+DRF1BfDnOZwHzlAypqXAYQXgWFEqYdlUIMXb19BR30P/RH/rjZNowLtJlu/?=
 =?us-ascii?Q?BA0YJi2eOB+ger+hn24NC/CJT+rJ46/0uVW4OBXsBVUbDpOFMQZ1dbex08I3?=
 =?us-ascii?Q?7FXIdiLh9M/fk2hO7QW92o/EbCVzhRzAo7xzrTHQMuQzfzybv1FJQf/srdk2?=
 =?us-ascii?Q?ihALWBUv96gnmAThxBwPsik9FuFFLN7sTPQJBmv6KEck/3tswNE/RBo8HOUB?=
 =?us-ascii?Q?sPCEIg1fzUoNJSC5I9r8V5B+/BCkkwvSaCQN150TkfC3sq0/JWDgd2ytoPoC?=
 =?us-ascii?Q?NNGkQ7iJ6SWaQZkMbj3xEUKubApIYuPYVu1VgLtMkYM/js902WaSe6V0s3+V?=
 =?us-ascii?Q?oz5zl6Ck2LAlsIeZT+BWQFfy/eaLn2OkEJr4h0G5lK+AHn1RXLUJ7FAPMtV1?=
 =?us-ascii?Q?y2Ymu1lahlSikg6QllowmJnKBkxMowK0tPRljR1tj9rtOMJvKuDUPTTqHuLM?=
 =?us-ascii?Q?FBYyb/bXDx0/xzbgi2VdT1isabywuVxWiJP2dEia6bvpwPKrQ7lRk6eQpLSj?=
 =?us-ascii?Q?ug6NQvU98fyzf934FH9d3+IvJVMPMXI49xl13IouH/VNBjqqi+4Iqpu/tPzR?=
 =?us-ascii?Q?U9N46CoBYq5xXr7tmwAZdzGeeGzvwZX0GzWK859unqs/iavlszG5v8OhY1No?=
 =?us-ascii?Q?pS8P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 07:34:54.9310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3323fc-9102-4a54-d100-08d8a0cbead1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HJiSmdmPqPPPUZ6fw6uVHb4hvv+vumA4FQx62KDuGaXXYneEWU0Q5ndm28cyXldru+xUNzttBni71TFCo3BkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3127
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

Switch to using IO page table framework for AMD IOMMU v1 page table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/init.c      |  2 ++
 drivers/iommu/amd/iommu.c     | 48 ++++++++++++++++++++++++++---------
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 3770b1a4d51c..91452e0ff072 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -36,6 +36,7 @@ extern void amd_iommu_disable(void);
 extern int amd_iommu_reenable(int);
 extern int amd_iommu_enable_faulting(void);
 extern int amd_iommu_guest_ir;
+extern enum io_pgtable_fmt amd_iommu_pgtable;
 
 /* IOMMUv2 specific functions */
 struct iommu_domain;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 23a790f8f550..5fb4bea14cc4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -147,6 +147,8 @@ struct ivmd_header {
 bool amd_iommu_dump;
 bool amd_iommu_irq_remap __read_mostly;
 
+enum io_pgtable_fmt amd_iommu_pgtable = AMD_IOMMU_V1;
+
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
 static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1f04b251f0c6..571e8806e4a1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -31,6 +31,7 @@
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
 #include <linux/iova.h>
+#include <linux/io-pgtable.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -1901,7 +1902,7 @@ static void protection_domain_free(struct protection_domain *domain)
 	kfree(domain);
 }
 
-static int protection_domain_init(struct protection_domain *domain, int mode)
+static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 {
 	u64 *pt_root = NULL;
 
@@ -1924,34 +1925,55 @@ static int protection_domain_init(struct protection_domain *domain, int mode)
 	return 0;
 }
 
-static struct protection_domain *protection_domain_alloc(int mode)
+static struct protection_domain *protection_domain_alloc(unsigned int type)
 {
+	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
+	int pgtable = amd_iommu_pgtable;
+	int mode = DEFAULT_PGTABLE_LEVEL;
+	int ret;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
-	if (protection_domain_init(domain, mode))
+	/*
+	 * Force IOMMU v1 page table when iommu=pt and
+	 * when allocating domain for pass-through devices.
+	 */
+	if (type == IOMMU_DOMAIN_IDENTITY) {
+		pgtable = AMD_IOMMU_V1;
+		mode = PAGE_MODE_NONE;
+	} else if (type == IOMMU_DOMAIN_UNMANAGED) {
+		pgtable = AMD_IOMMU_V1;
+	}
+
+	switch (pgtable) {
+	case AMD_IOMMU_V1:
+		ret = protection_domain_init_v1(domain, mode);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret)
 		goto out_err;
 
-	return domain;
+	pgtbl_ops = alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl_cfg, domain);
+	if (!pgtbl_ops)
+		goto out_err;
 
+	return domain;
 out_err:
 	kfree(domain);
-
 	return NULL;
 }
 
 static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 {
 	struct protection_domain *domain;
-	int mode = DEFAULT_PGTABLE_LEVEL;
-
-	if (type == IOMMU_DOMAIN_IDENTITY)
-		mode = PAGE_MODE_NONE;
 
-	domain = protection_domain_alloc(mode);
+	domain = protection_domain_alloc(type);
 	if (!domain)
 		return NULL;
 
@@ -2070,7 +2092,8 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	int prot = 0;
 	int ret = -EINVAL;
 
-	if (domain->iop.mode == PAGE_MODE_NONE)
+	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	    (domain->iop.mode == PAGE_MODE_NONE))
 		return -EINVAL;
 
 	if (iommu_prot & IOMMU_READ)
@@ -2093,7 +2116,8 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 	struct protection_domain *domain = to_pdomain(dom);
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 
-	if (domain->iop.mode == PAGE_MODE_NONE)
+	if ((amd_iommu_pgtable == AMD_IOMMU_V1) &&
+	    (domain->iop.mode == PAGE_MODE_NONE))
 		return 0;
 
 	return (ops->unmap) ? ops->unmap(ops, iova, page_size, gather) : 0;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
