Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D108EC2BB48
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:34:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFA0222BB
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFA0222BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1C2D72322C;
	Tue, 15 Dec 2020 07:34:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4X2q2JLlNFx4; Tue, 15 Dec 2020 07:34:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 01EF020451;
	Tue, 15 Dec 2020 07:34:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D913BC0893;
	Tue, 15 Dec 2020 07:34:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 565A0C013B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 44D29873DB
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:34:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 27rlNvgHF+XU for <iommu@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 07:34:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BA15386E6B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I91SfHhKMyCfDIVFcJEjqHxSD/ROTifjnQHZEvej/6HpJu8Im/7ldzO/iF0TDj5qT51OmIn/ac42eZQD6CHM4WCq1tx7Jtfel9H6Gqj+cUhnGbWkrDGdP1GOFLQcMWpMDtkbi5sGMFqkw+A7gWr/L7C00ag44/5REbqTHwmoZ5wFxNmyRLWxgXgIcoOn1yVGSG7V8DS2XIX9KFfKvVl6pOX5bdl03hZOoYF4Imv6bBqkjYGEshbHTTPLcQ62EUINLAlDnsppco9Yf6OI8o3lZ25hFxIK/fCmcQkDxTSaHUtfs+XK+6iRMn5kBIR2pWk/GxCPQfJatf2BMnluxJ1/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhLG26ss5qCxUwEtUOIg6Nca4uzCRijszxReBDy2Rgs=;
 b=Ni7Wghu1ZSJvhOkoHSy3Hv8czEg2QEKqxPqWEfeSkP0DHcBKZtY3Kkv0N+AnzRS40jp3Fw3fWo1v/XMkRQgXQq5d0neFZ6/+4GiJ4wZ1xZuJJzwAhXy8zzewGYon+jWANm5L3m+q9g+4Ss8PIVGv8HAA4rEWbf0CnTVQ8E4FcnHMcUEEHXI0Cm4aK/1rUfDisMBHoIsmbPLWOX1z9ODzGM8VMD0Rg7EpuJ+5sbC6HY4Hxe9Oru9x6gbamH08e9Ia7jy97fD3HWjws8eZDglPl770X34GwMEgofBjMTMebroYfP+bw8Hiw5svH0KHiUXZPmlbFv25DK3UQuh6ry2hMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhLG26ss5qCxUwEtUOIg6Nca4uzCRijszxReBDy2Rgs=;
 b=HpNIQPQeSJ13QoQUTnrpC9cJn5/IXzsz3c/KAe+oUXB0BQRPoZlACkWf5DHe8Db9ZO/eHjHITwoGj1K4UwOAK4L4CI1EOfVMfGK4Wu7CqjC/OhKsb7wVUoCOi/D6rLbrcMIUSoNtRNcSE0bBeYmolFjXciqOyzg5Z7jMzvd7X8U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB3794.namprd12.prod.outlook.com (2603:10b6:a03:1aa::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 15 Dec
 2020 07:34:40 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3654.021; Tue, 15 Dec 2020
 07:34:40 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v4 03/13] iommu/amd: Move pt_root to struct amd_io_pgtable
Date: Tue, 15 Dec 2020 01:36:55 -0600
Message-Id: <20201215073705.123786-4-suravee.suthikulpanit@amd.com>
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
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 07:34:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d883e935-61e2-4f04-c5c9-08d8a0cbe214
X-MS-TrafficTypeDiagnostic: BY5PR12MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3794B1E0B28630307882F586F3C60@BY5PR12MB3794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31kQJZJuDTt4aP5F6TM2/abaYAJTYZnZbTRnVTvBeJy5O2jajhQ9gxaVnTLNfC88bbqq1thjbXYroA2jTOMKEgpmYzmshg9Js9twjkY8VunDT5LvU31usqB0Prolq17So0NLOApngsyfbcwqyegaKZOzdm+qIkvSOrwLM61KvUxKGJlnsqD3fstEk0yCX9jnWuxkj7pYWDkhh/G+xshKWo1uhQhomZ/RisTU9QWw4Z/l5gyEBWxcLg8v7O3Xhz4bp7zNreJ6zu3VZavHCej1XQx3RGqbrBJPKzrBwYjR+YKRDE1GkcNgP5F1OYzxi0yXXSt+f88G2BQRcT1UEONh8mbTl6rQfBasvolJpntn6+sYzA1Loyr37Y9v9Lop4WbA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(6666004)(2616005)(66556008)(16526019)(86362001)(956004)(66946007)(6486002)(34490700003)(26005)(52116002)(186003)(66476007)(1076003)(7696005)(36756003)(83380400001)(5660300002)(44832011)(2906002)(8676002)(508600001)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zMIW9omQf/gB+PpnlXcQY6OGhcs403rqWiZVtxhx+1ZTFxdF4Avx+b2EH0JR?=
 =?us-ascii?Q?F5tgQ51Rfc6nGyzUjW+aG7CHHsg9dVKky+RyYnJppT3nvqjLTE5vcAISi7eA?=
 =?us-ascii?Q?drzP7J8NPjQrp0pPOnBjvMB8n7cqzfRix/kWKbGqpfBrSo3F+0pYT2CtoBts?=
 =?us-ascii?Q?qMFifPm6vuS+AuhO5l9cbuxFjh7zuMq9oioLQfHNtDRUZuSQ4xk6iixLipa/?=
 =?us-ascii?Q?kIsqqXg2AqrsBKZXTrnQ3cHw1M/BWs0P3TCXDL5BY7Y4HXuLBN6AfFsoyt17?=
 =?us-ascii?Q?T4XoO+CAtykyLnnYi23xWsUBqa62Nu6vuE4BJedDMUip7YFwK78yluJZ1Ant?=
 =?us-ascii?Q?hCm9RLrJbRtORtenegHaj37KzYPEs3WfM7gqbLDeRtAICo2ccb6V30SaB7xO?=
 =?us-ascii?Q?WLhkonJcBTjxv6wr5ilGyRiGqgUzpVaqFiGGr+bQmG9lgCbm/lXS0brQRRLJ?=
 =?us-ascii?Q?vtiL801x2jojf7D6FgA7IuiuAhYn15R3dMEkWaxGgs8ZYRHOqb6cbaYwBz8A?=
 =?us-ascii?Q?KzZseEjwJrkuynm4IyMhtWjtWd7qIQQGyOj+G00D0zofmoE1Uw3ttnYQildU?=
 =?us-ascii?Q?Gv40WxHqI55E4OrIkDW6CLiyn4n9i6AQz9aiaG0WOQr5zqMsk5UvQYvVO1JM?=
 =?us-ascii?Q?5cN4Tz60zZXv9pspKg1A1NZlPmX9wAuKUMwav3O5J1m7DX190ob2O5rI06e6?=
 =?us-ascii?Q?lU3yZg8EMYEFPIJLnuPgwUtMY8QhNYDAHUqXl9FnSRuWNs14ELhs2d4tIcvQ?=
 =?us-ascii?Q?JXo1g9W+oZ8jr2fcO4KABUzLc86gHzIF2aeGEtwcT0od4PYVO7+CFk7acB0N?=
 =?us-ascii?Q?YNv3K9GE29/U2enNdEGZgONtRzHdXtHlupGIVIeE3GZAKUDQTgB09QwtF4Yl?=
 =?us-ascii?Q?prr3SWnwx7fYpOxzF9SE17CToEFSk8OGVfmMIpr29GWSEKrOG+w0tPJE9jrV?=
 =?us-ascii?Q?C5M5kqJfcBl07hn5kgbCTWtAi90m+16U7rY2ON6RDq8CZPTfy9L8TFbx+sl2?=
 =?us-ascii?Q?OOVf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 07:34:40.1674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: d883e935-61e2-4f04-c5c9-08d8a0cbe214
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYu6h/lktEuz5MJxa4TEhMvhDHdEjUAsqxGpd+TvffPsvkw901MHalecW12g7lLQqu940j0TuoSsEsItolb+EQ==
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

To better organize the data structure since it contains IO page table
related information.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       | 2 +-
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 drivers/iommu/amd/iommu.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 0817bc732d1a..b8dae3941f0f 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -105,7 +105,7 @@ static inline void *iommu_phys_to_virt(unsigned long paddr)
 static inline
 void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
 {
-	atomic64_set(&domain->pt_root, root);
+	atomic64_set(&domain->iop.pt_root, root);
 }
 
 static inline
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5d77f34e0fda..7c971c76d685 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -497,6 +497,7 @@ struct amd_io_pgtable {
 	struct io_pgtable	iop;
 	int			mode;
 	u64			*root;
+	atomic64_t		pt_root;    /* pgtable root and pgtable mode */
 };
 
 /*
@@ -510,7 +511,6 @@ struct protection_domain {
 	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
-	atomic64_t pt_root;	/* pgtable root and pgtable mode */
 	int glx;		/* Number of levels for GCR3 table */
 	u64 *gcr3_tbl;		/* Guest CR3 table */
 	unsigned long flags;	/* flags to find out type of domain */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 45d3977d6c00..5b93536d6877 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -145,7 +145,7 @@ static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
 					 struct domain_pgtable *pgtable)
 {
-	u64 pt_root = atomic64_read(&domain->pt_root);
+	u64 pt_root = atomic64_read(&domain->iop.pt_root);
 
 	pgtable->root = (u64 *)(pt_root & PAGE_MASK);
 	pgtable->mode = pt_root & 7; /* lowest 3 bits encode pgtable mode */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
