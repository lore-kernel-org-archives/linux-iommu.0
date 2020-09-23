Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB71AC4741F
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:12:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B5912076E
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PZYeMWjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5912076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5744786101;
	Wed, 23 Sep 2020 10:12:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RgSj8OoaB1le; Wed, 23 Sep 2020 10:11:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ACD23860D1;
	Wed, 23 Sep 2020 10:11:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A35C6C0893;
	Wed, 23 Sep 2020 10:11:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3091C0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C612022E89
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YPxmh2Dq7erq for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 10:11:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by silver.osuosl.org (Postfix) with ESMTPS id 9B52622E20
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3gt5e+Ojw5OJicOG7YHR6mhhAI82dqLAdEIrYM3Cr0kn3EtQIyC5vgsci/hLQFbQv4mNwaXGNbPqko5Gnbe1qd0M2M7q4rZTkE8rIaAYttgjOSvQVdjG5hvc/keVMgmEiUDam+UCXnLjBYDOJgpl4ubOl5Maar6jqrN4g+qvwX5WNC1xtbSbhD6ifiQdAxSCKKNR3nzXMAJr6nbHi6XinBS6JvFjW4Xbp7nKWrh2rWNnVsYUPgfIthlibRPbyzTaGYMq+RLt+nmFuXBhOg2qWXvE3NYmgIAP/pGSNqYF7gQYsTh5ohmwSHPDhpeC7uNTCLtRYXKXuFzcQpiQzDyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NjQATjihQJiEnCZBPa82s2t75rkoNAiocL0M9ONJlM=;
 b=CczfEOGyUxPI+FYMBYYgebWhoZ/y3GR91p+0UwJKOQbOYq2wnxflik3kZOWsq/P6BjinwBtbxS9kjJY34ZcJ49IEasHcCQXb/fJ4FuRGPDZMuEK80g2GHKG7KGbcuRqVcn4IKZXIg7nV162VrNupUloNsse1bkJ1ktykKzJHA12KthaFmNs4JLH4uko+kdkb4U75+a0CenZt8KhMaN0KXCZJtUk+wM7JRt42GCiPuYROqDrtRjhtDit/VhetRgPldC9/mYKcnRaanDyABP2tqBccr0VDonn8ASpt3v/aOErqolSRojXYuWDZOktyCS4baL2xM+TfMHhxOaNSzi08Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NjQATjihQJiEnCZBPa82s2t75rkoNAiocL0M9ONJlM=;
 b=PZYeMWjTIZEhzg0pI23LI8DkNrcTuyPUDgR0oGzp2AxyULj49qOSMTFxDOtx9+XFuWqELFfkC7d34EJloXn77OaLE6BKOAof0HzSW5M2B3ZbFTazkPs+Bb5Nt6EOoJirRJy1FrZrLLUfr5MhDq9BvE9EwuvPSr8NGlQ6jK/+8hU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 23 Sep 2020 10:11:48 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 10:11:48 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 07/13] iommu: amd: Restructure code for freeing page table
Date: Wed, 23 Sep 2020 10:14:36 +0000
Message-Id: <20200923101442.73157-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
References: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0601CA0003.namprd06.prod.outlook.com
 (2603:10b6:803:2f::13) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN4PR0601CA0003.namprd06.prod.outlook.com (2603:10b6:803:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Wed, 23 Sep 2020 10:11:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f20f2fb-6d62-4be6-19f8-08d85fa914e0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3466BEC557E48330354FDFA2F3380@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWFBnt2ZzI4DvyXPqVM1rKFyBkv7PFfu+ELrMOJ6+mR4n1ZcYBP86/LdQH1JYveEtRqEkTziS2q4hNzbRHYdW+NzcxBGw0SO6+d3Sla+xORteLVVJUcx0FV3HmI8Q7wiETHZw40ANmx4ZFBmYBAVlvH5ASrpd/jiy9POVvyb57BuzJ2r4C61cOvbuRXG5LgnW2ZHHelu7azb6S0DnGAHCLYaEQ4W9LvEe9SFUJ8aI4N8Xw5RLeB6N2CTGgQmQcOIJyV77Q4n0z6iifNPcLUCYFN+QonhCtUOQGzXb/uOQYMWLyyyIL4PRsbiy5W+qj46Go0pPlR57dRQOM2bmyFKwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(44832011)(5660300002)(66946007)(66476007)(66556008)(83380400001)(6486002)(86362001)(36756003)(2906002)(8936002)(4326008)(26005)(316002)(1076003)(956004)(478600001)(6666004)(186003)(16526019)(52116002)(8676002)(2616005)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bJmVe7wBorAxX5znok7H3LYfXA2MkUfmXuN+lIxwFeqWRNZV0kr95nqHQsyPQxCgvnOx8vqrlzl5j4fS6eaI9rvTjorOH+FnOOQxEqk7C2n79bx9ss50sda7l4ZU9yXW7rBjmLJWeVHMqQq3Kk3fpGon4MBepPZmkqMfEA03wsSJcqEwX9Fcgw1B+MWyxi0ZiM6jZOQJ3XZbYp/vcYFpqn6m9bcc3mN9wvN/67HoqFDOhMWBtZGO1kClfPRMht9X2Ebo12Usm7xri91KQsYE1kfTnFX5l6pB60Xcbtu8Q48nXJJOnDHCQu1z2wFpDV946cHtqtJ4QUGSWaAo7ctmXiPA+MPTo+0NN1J4i1lsE1EKwLibXQdZ59MWF6N4MXh9iWA0kz0jqQwstNzW+NP14j3UG4RNJCfAOlo7Li6ftXPJ2EnM+0/1+a9Z9FdtdZU0BS+EvhH5pycSRgJAFIlto3+MhXz7IgEbbXCSUCAJvXSNGLJlk7A7d0pFjF842UWzVA+mcHrTJlGuklQGW1udjWbqRYls48OzqVha3A+m6zyZl6ULbp1UlNrcU1wyPYVqFE4LAmUSwp0PLoJ12czMs5wzylX2uovwgZNsSrnGrh/dE/4wgr9eLS+m0+W0uckz61j8K3WZg42u2KiEEejd6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f20f2fb-6d62-4be6-19f8-08d85fa914e0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:11:47.9726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYEKs/tDdSiK5N4ECZWhBf04nJt8PWNSMhlY3pn1LCycoTdnz2E4RDkj+q5QRoVq1ohokbPGurohRkyc+byqEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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

Introduce amd_iommu_free_pgtable helper function, which consolidates
logic for freeing page table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  |  2 +-
 drivers/iommu/amd/io_pgtable.c | 12 +++++++++++-
 drivers/iommu/amd/iommu.c      | 19 ++-----------------
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index ee7ff4d827e1..8dff7d85be79 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -123,7 +123,6 @@ static inline void amd_iommu_apply_ivrs_quirks(void) { }
 #endif
 
 /* TODO: These are temporary and will be removed once fully transition */
-extern void free_pagetable(struct domain_pgtable *pgtable);
 extern int iommu_map_page(struct protection_domain *dom,
 			  unsigned long bus_addr,
 			  unsigned long phys_addr,
@@ -140,4 +139,5 @@ extern void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
 					 struct domain_pgtable *pgtable);
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode);
+extern void amd_iommu_free_pgtable(struct amd_io_pgtable *pgtable);
 #endif
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 7e4154e26757..8ce2f0325123 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -167,14 +167,24 @@ static struct page *free_sub_pt(unsigned long root, int mode,
 	return freelist;
 }
 
-void free_pagetable(struct domain_pgtable *pgtable)
+void amd_iommu_free_pgtable(struct amd_io_pgtable *pgtable)
 {
+	struct protection_domain *dom;
 	struct page *freelist = NULL;
 	unsigned long root;
 
 	if (pgtable->mode == PAGE_MODE_NONE)
 		return;
 
+	dom = container_of(pgtable, struct protection_domain, iop);
+
+	/* Update data structure */
+	amd_iommu_domain_clr_pt_root(dom);
+
+	/* Make changes visible to IOMMUs */
+	amd_iommu_domain_update(dom);
+
+	/* Page-table is not visible to IOMMU anymore, so free it */
 	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
 	       pgtable->mode > PAGE_MODE_6_LEVEL);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4d65f64236b6..cbbea7b952fb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1882,17 +1882,13 @@ static void cleanup_domain(struct protection_domain *domain)
 
 static void protection_domain_free(struct protection_domain *domain)
 {
-	struct domain_pgtable pgtable;
-
 	if (!domain)
 		return;
 
 	if (domain->id)
 		domain_id_free(domain->id);
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	amd_iommu_domain_clr_pt_root(domain);
-	free_pagetable(&pgtable);
+	amd_iommu_free_pgtable(&domain->iop);
 
 	kfree(domain);
 }
@@ -2281,22 +2277,11 @@ EXPORT_SYMBOL(amd_iommu_unregister_ppr_notifier);
 void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 {
 	struct protection_domain *domain = to_pdomain(dom);
-	struct domain_pgtable pgtable;
 	unsigned long flags;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
-	/* First save pgtable configuration*/
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-
-	/* Remove page-table from domain */
-	amd_iommu_domain_clr_pt_root(domain);
-
-	/* Make changes visible to IOMMUs */
-	amd_iommu_domain_update(domain);
-
-	/* Page-table is not visible to IOMMU anymore, so free it */
-	free_pagetable(&pgtable);
+	amd_iommu_free_pgtable(&domain->iop);
 
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
