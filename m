Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D10C4361B
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:35:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E5A22286
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E5A22286
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 66B61204D5;
	Tue, 15 Dec 2020 07:35:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S95I2FjFIC-p; Tue, 15 Dec 2020 07:34:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EACEA204A9;
	Tue, 15 Dec 2020 07:34:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5FC7C0893;
	Tue, 15 Dec 2020 07:34:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2701C013B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AD9CC204A9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:34:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ODlV7vGIcQIR for <iommu@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 07:34:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by silver.osuosl.org (Postfix) with ESMTPS id 93DAC204E4
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMC6I4WGtN2Srd93ScvmU9dsm+oG1DPsAEFDo1A04lvrVpv3o3aBDa/m8bzcoJhivQt2SUVrBduLc5PsmM9zl9e/SfiIMA261md8KVi73pcS7D/GkUkwwxlrB696X/bwW7abTeqyxO2p+xjCWtfRGha4OgfvuUb5Ew3CbEMfnYKmQJXox0NyHGst1mjnt+DPwLUayXElH9eTcPSUGVSAkeXhc4xqBTiP9iNdgZbMhR2AW1RQAy+4wveVBTk1wo7hRXQyNF9IvGYMRNw78l/IrpYNxTCmQuhDcCtP+RgblSh7GQvIpYd+F0x3BLADfaIIsECH+nTBKwWrlslMOxgJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V61DaMvPa88N2/Xb5xL/57oC3hvd9sP1BhmFQh0vQRA=;
 b=TQXeHmhO2XOPWb3gDUSK6tskW3cuIQX3CYT6sxWK1IS/3zxFFdjTnbhoRi4S0IjWRR4G+VnaHHUk7/e0d7odWZWVmYefXLTIHulYGd8JF/Xp5cVulHTmOpZG8aJb9v2u8aNJKGceKW2ejAC3+ry+tqDHYLnb7YTSXRpail044LXsU0P6g8yM9XZQyKpkE3tQVAIkUSxQQkVALqT1gORsaKyp+GIbMwJ1Zv1ByTmVlcYRIXKKfCh9c+BoNRjtoHvLzPRDoV5nvs6DOoNkYwtJhYdSFR92nJCfwMwOGOLrYvQnO+UnKWpz449ydHAHHV/2YPs0X8z7qHHY4L04Je96SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V61DaMvPa88N2/Xb5xL/57oC3hvd9sP1BhmFQh0vQRA=;
 b=KeAWilFFOmZBu2KSrUzRksTLb0GrWJZKCmfewpbohWiRleqaKg037IAMIZbh3QkJhHKoZohWfzj4vEI640Zb4p+fpmFCvo6mnBOVWHyJk1XtlLp4fdXKjzzoHzTZHSesiCJW2O71ALEqxLKf2iTzXiPInKORY4ccTGvpFE4j8ZI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB3794.namprd12.prod.outlook.com (2603:10b6:a03:1aa::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 15 Dec
 2020 07:34:45 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3654.021; Tue, 15 Dec 2020
 07:34:45 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v4 05/13] iommu/amd: Declare functions as extern
Date: Tue, 15 Dec 2020 01:36:57 -0600
Message-Id: <20201215073705.123786-6-suravee.suthikulpanit@amd.com>
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
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 07:34:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38925a81-9a0e-438b-cecf-08d8a0cbe544
X-MS-TrafficTypeDiagnostic: BY5PR12MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB37945D45D0835AA4B1281FCCF3C60@BY5PR12MB3794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmbxLDRmhxjt/6V5ctW9NOzzGKja06Qe5E4a9Q/q3hNXlt/OAaxzXLKhrWsMHx8hb4q0FXZCIbhDDmPkoy5ZWzRlwTSZoAphJFVl18r5McTLJcErdsfW1+NbF7FtbQn2xk8oSev0spO1codcF09N/wE7Afw81H63LswST1Y7pvDIosOrHf059orl0Urv4776ojCfBDMg/UkUIqtpD7xeVeRHpNcqAUweL32MFT61gb/ejFI74+oSKMGloZoA/vdT1CGYB1WOWutYbLgvp7PyAMtek9R+oDmpMB38oras13dDQxZgjYb5NFDYClDrerOuvavUyeZb6YCQnolnYKxMp2VyqZLUV+YRGlIAlM6BJ+Owo/rLl4oU/TR6XhQIgHrq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(6666004)(2616005)(66556008)(16526019)(86362001)(956004)(66946007)(6486002)(34490700003)(26005)(52116002)(186003)(66476007)(1076003)(7696005)(36756003)(83380400001)(5660300002)(44832011)(2906002)(8676002)(508600001)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?d3RCSpl/ToKDs62gXT7JaWETHVVK1IK1t7ZwpKdwstXiKtZ2tZYBe21EeoZB?=
 =?us-ascii?Q?RpnKNwDm6dX87IxLOU7QS8/epxy2bk1mVfCYcQ7DTHXRXOfZe7TBitPhuqiO?=
 =?us-ascii?Q?ANPfT643D0f1DpR4H8ShnUz83VkqgZewaOl0MVEHUltzPFUAw685doUVax+3?=
 =?us-ascii?Q?gl06KAWm8204Knc3/uyqhJdpv2dHpFehiz07j/vA1vBfxzOI6JeuQ+51toRW?=
 =?us-ascii?Q?BtQZYyVnzDjkT2P4WZdlN1VwfQYe7xXft+h2jzOD4imwK2PCFyaUC21QD8Lh?=
 =?us-ascii?Q?ivgu/2eY5RFSAdejKnVR/l9Y/jh8wSj3bKq5yBxnohEiq3y8K1A/16mVfsbM?=
 =?us-ascii?Q?OqphMVn0NF/b9ZLJfl3VeLAky7NpI2bt1BfJXOMX/ybYNwZdfMP9QuEnjOpB?=
 =?us-ascii?Q?gPY6nkRgj5OztdfNIFaEW5CwvXGup+AERP9sLVhldrCwnPv5duTtXzgSmDP1?=
 =?us-ascii?Q?2Y5I/H+YHmTTsuinqrbYp287hgSpsUcC11qrWwqWDo9U+cKXYMSye1RYA+VF?=
 =?us-ascii?Q?Rhtx1UNjQBxUCMab6dq4zBTxMWlvLmqRsvKXWdr3IVSmVUwAWgxN8reaOlf1?=
 =?us-ascii?Q?mXYtScRe07GsQYvbNxRkYqJVWjTftHZ57JKTm5Wt2IaHV6/5YeSXGu1XtAbB?=
 =?us-ascii?Q?GEfVlAP1e861iPVqZq2uRCVMTqCl/dKJNeN5ijx5koLv95q4z8VygccZTD3p?=
 =?us-ascii?Q?wr54xHjDbhcxKIXCnfWdd1L5p/R4OmK0RLVr4HjfvyaCwXOfydrgVrK+6Soc?=
 =?us-ascii?Q?CB4AYj8k2XMVlQTKs37fr0qM0xvmepP9C3cv2Tn8YGriMchf5sZkg30Inbbi?=
 =?us-ascii?Q?55Ek/Fxh0IwOpuCzNV9D0itxFwEMNsScQ1M2fhY1MNrWBPpapa3zBmdBxHnj?=
 =?us-ascii?Q?4rFlQMPNGLBnlz7tMmNA1sb35Y/5QSQqNAFCby09aYaREfmMYuufz2ENmvIr?=
 =?us-ascii?Q?Q6QvNY5PdCBuyVNWK0N81rZogVsDGMN07/znDfACZ7Hm3OdYRSEWGPgN9TVz?=
 =?us-ascii?Q?OSet?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 07:34:42.2782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 38925a81-9a0e-438b-cecf-08d8a0cbe544
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cT5uZ61yMN0iUWmX33h6MlPYN64RvnmuNobgeqszZZZ7UNZr87xj6qM0dSxe0jmVxbRNKMOHwWvNoAb2ZQVU3A==
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

And move declaration to header file so that they can be included across
multiple files. There is no functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 +++
 drivers/iommu/amd/iommu.c     | 39 +++++++++++++++++------------------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index bf9723b35e77..bf29ab8c99f0 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -57,6 +57,9 @@ extern int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
 extern int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
 				u64 address);
 extern void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
+extern void amd_iommu_domain_update(struct protection_domain *domain);
+extern void amd_iommu_domain_flush_complete(struct protection_domain *domain);
+extern void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain);
 extern int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
 extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 				     unsigned long cr3);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fdb6030b505d..1b10710c91cf 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -87,7 +87,6 @@ struct iommu_cmd {
 
 struct kmem_cache *amd_iommu_irq_cache;
 
-static void update_domain(struct protection_domain *domain);
 static void detach_device(struct device *dev);
 
 /****************************************************************************
@@ -1314,12 +1313,12 @@ static void domain_flush_pages(struct protection_domain *domain,
 }
 
 /* Flush the whole IO/TLB for a given protection domain - including PDE */
-static void domain_flush_tlb_pde(struct protection_domain *domain)
+void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain)
 {
 	__domain_flush_pages(domain, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS, 1);
 }
 
-static void domain_flush_complete(struct protection_domain *domain)
+void amd_iommu_domain_flush_complete(struct protection_domain *domain)
 {
 	int i;
 
@@ -1344,7 +1343,7 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 
 		spin_lock_irqsave(&domain->lock, flags);
 		domain_flush_pages(domain, iova, size);
-		domain_flush_complete(domain);
+		amd_iommu_domain_flush_complete(domain);
 		spin_unlock_irqrestore(&domain->lock, flags);
 	}
 }
@@ -1501,7 +1500,7 @@ static bool increase_address_space(struct protection_domain *domain,
 	pgtable.root  = pte;
 	pgtable.mode += 1;
 	amd_iommu_update_and_flush_device_table(domain);
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_complete(domain);
 
 	/*
 	 * Device Table needs to be updated and flushed before the new root can
@@ -1754,8 +1753,8 @@ static int iommu_map_page(struct protection_domain *dom,
 		 * Updates and flushing already happened in
 		 * increase_address_space().
 		 */
-		domain_flush_tlb_pde(dom);
-		domain_flush_complete(dom);
+		amd_iommu_domain_flush_tlb_pde(dom);
+		amd_iommu_domain_flush_complete(dom);
 		spin_unlock_irqrestore(&dom->lock, flags);
 	}
 
@@ -1998,10 +1997,10 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	device_flush_dte(dev_data);
 
 	/* Flush IOTLB */
-	domain_flush_tlb_pde(domain);
+	amd_iommu_domain_flush_tlb_pde(domain);
 
 	/* Wait for the flushes to finish */
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_complete(domain);
 
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
@@ -2134,9 +2133,9 @@ static int attach_device(struct device *dev,
 	 * left the caches in the IOMMU dirty. So we have to flush
 	 * here to evict all dirty stuff.
 	 */
-	domain_flush_tlb_pde(domain);
+	amd_iommu_domain_flush_tlb_pde(domain);
 
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_complete(domain);
 
 out:
 	spin_unlock(&dev_data->lock);
@@ -2298,7 +2297,7 @@ void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
 	domain_flush_devices(domain);
 }
 
-static void update_domain(struct protection_domain *domain)
+void amd_iommu_domain_update(struct protection_domain *domain)
 {
 	struct domain_pgtable pgtable;
 
@@ -2307,8 +2306,8 @@ static void update_domain(struct protection_domain *domain)
 	amd_iommu_update_and_flush_device_table(domain);
 
 	/* Flush domain TLB(s) and wait for completion */
-	domain_flush_tlb_pde(domain);
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_tlb_pde(domain);
+	amd_iommu_domain_flush_complete(domain);
 }
 
 int __init amd_iommu_init_api(void)
@@ -2696,8 +2695,8 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	domain_flush_tlb_pde(dom);
-	domain_flush_complete(dom);
+	amd_iommu_domain_flush_tlb_pde(dom);
+	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
@@ -2787,7 +2786,7 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 	amd_iommu_domain_clr_pt_root(domain);
 
 	/* Make changes visible to IOMMUs */
-	update_domain(domain);
+	amd_iommu_domain_update(domain);
 
 	/* Page-table is not visible to IOMMU anymore, so free it */
 	free_pagetable(&pgtable);
@@ -2831,7 +2830,7 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 	domain->glx      = levels;
 	domain->flags   |= PD_IOMMUV2_MASK;
 
-	update_domain(domain);
+	amd_iommu_domain_update(domain);
 
 	ret = 0;
 
@@ -2868,7 +2867,7 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 	}
 
 	/* Wait until IOMMU TLB flushes are complete */
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_complete(domain);
 
 	/* Now flush device TLBs */
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
@@ -2894,7 +2893,7 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 	}
 
 	/* Wait until all device TLBs are flushed */
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_complete(domain);
 
 	ret = 0;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
