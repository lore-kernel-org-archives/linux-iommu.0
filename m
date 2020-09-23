Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E76C4727E
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:11:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D3E2083B
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f8HM9s2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D3E2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3D6D98614A;
	Wed, 23 Sep 2020 10:11:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CZiN3K-AY-mS; Wed, 23 Sep 2020 10:11:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 483FA860C2;
	Wed, 23 Sep 2020 10:11:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35693C0895;
	Wed, 23 Sep 2020 10:11:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A809C0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 66DC686101
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UmQXGXlXcPRX for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 10:11:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EDCA086113
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liyvUliCML1Rx7TFjFhSBYBanTp94BqipGgol0U7O+kOp+asMhdaQnQdHAydT2pzJWO1i3QzZo5Mk5W/FVstEpBBGRdJxB4MwncMXxhReTYfS3XHmmnpfA0f0v4Xo6xwupscxCo18fQ1zlYnaa60fb+LE+28na6A5JX838wUwlA7ds8qXP7OybEhZ2MTjBT6lnfPNENIek3DZi4TuxfvOPwohcI/0a+ztPUU+w3is8QZsha/Ov6XUynF2Rf2PqI/tUVBovoxXbDvupteXplZ2hJKS+MwsGGQ5Xl9s8ZIo80R0OMfHdtBX5D4nFHNfI1aQJEfsW/BOibORcQ/ZuntWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAtKqkUQt5AZCbq+HTxThWLh+nvVykeYB7yIuGMQscI=;
 b=NOrgfObSDbC4AeY2rpJCX7ERtFPY+rpJohElwc8CPer4jrb4u7/ddLHn67VZMy6gdz4otrykWbBCynPfq1uPLPCigGuT12TnOPwqk6SWKcKBUnnCXL/CbJvNfj7gD9Tw3ZFQtnJacK3sY1+8z4u5vtraN+UKri2lmqrJ6xYXQCDDAjHjV81B6/3bwcLa2iWKw6iXrvohcYuG9zPTVQ5Caux1T1ZAxePG1pM+UpYa+D0I6NtO5a2SvvudU5qDyOjTuMT6E1mnftdx/AnCkZkBXbuLvKQRH/LusntGuDkOFcQh5Gu3Lv7WcBd9kZuWQN13rJe8pjdi2ld3i8UpGlNEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAtKqkUQt5AZCbq+HTxThWLh+nvVykeYB7yIuGMQscI=;
 b=f8HM9s2/rEEOFmI/ctq37V1BXpquwD7+DOUptSYh5LGZYd3wQFhfbPkieFsUQE6V9Dyd/bflKkRXz+cy/78iyqpLNlSkzEJ4p6npcB8Ecr3cguNWYzD56GdCDNvJqoEYR2g552w1+yo6lK9YLTxvjAk4B2NNOz+nPZTP0aBP3J0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 23 Sep 2020 10:11:45 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 10:11:45 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 04/13] iommu: amd: Convert to using amd_io_pgtable
Date: Wed, 23 Sep 2020 10:14:33 +0000
Message-Id: <20200923101442.73157-5-suravee.suthikulpanit@amd.com>
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
 Transport; Wed, 23 Sep 2020 10:11:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d20c9ae2-bf61-428b-94a7-08d85fa91309
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3466BAA47679AFBBA8E92C11F3380@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BRHfbnVS+/Pjt3MATs8n5rPdLweoqrJKLxKOWNt27RAEOn6k9WwQWxxeeDjtajTztyNZpjGzVfd/Ty2KgD68ShnruagFtshv93Y8B+4ETRli8GwvyNWTir61I7/fvHG5WSNF6VEB+9ziAKz66HSYNcZtltlulL1w35QPTQkU2lxYBLQ7x0HU9V120yk6bxtoFIuSs899aPsFcqF1bYg75e2hOJ+Mcav0RLo3LfJZZ7BSM15DUAXlfoHiDezkEOyBm67e+g2qo+o8c3vaKLGf4TME/P3Clkn0ysH05Iluf1X7bUAr4CWb90ta0cOTGrSBZG4tTuYCDfaduKNFlTkiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(44832011)(5660300002)(66946007)(66476007)(66556008)(83380400001)(6486002)(86362001)(36756003)(2906002)(8936002)(4326008)(26005)(316002)(1076003)(956004)(478600001)(6666004)(186003)(16526019)(52116002)(8676002)(2616005)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: eX54vXWp4YK2bA10udpvQj4HVuZXpq5AEkmP5KxdPhcwsLwp+aaqPt3dYBFYs6S9NxiGu1gOqe6MWRjaI8BZXzWoulObcIGdwnxzsRiUWyzB4hgB3RR+BPNmtI5tEI2dinNIL/Id+RlQ3XeRysoNyL7F9YySRguko6Qv7XA+K6lWnRiEJI4FW8nK1ICGgLt2Z0RtawGW7wvmIsmZnsbXRgtJLVILacOEnJ7PD7Xd22kvDbFGYkKdYqCVMcnRlEtNcvUZiweg+R9EHtXj5J/HkvUkoja91tqsIK6m60yQgaNLqDsIyJ1egtCxaqjk/xh7w0TYtTTkGqtWTOCKUvEGbW5eHxjBtyWKCdxbu9htwMpRSF6jwvIqHFb1psKp5CGJ+zW96wuveHNEhJXWLs+m9xOvbV1tfOmCsK9VaAjtGFVWr7YOGAsPC16oqukWA1OpfO4ohtnNg8FKgYC7KLz2BsG63HQgZBFy3p2QsgaKuLkzyTl1BU0KjtjW0aN78/Kg8GMLgpNLE1r093gJhMOUZddmJ7hkrzVCKNMrPSBaLWu0k/sU5r2CW0VGub0kk8pAuetXtfCk6rWNdRqPcN2q7dA0qBFQe67qxxC3S/3tmEXHDvpUQgmMKViMn4sXmAYz9PjizTmJlDDvV2CH2YTTzw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20c9ae2-bf61-428b-94a7-08d85fa91309
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:11:44.9550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnbiBvIK3GiSE1XE7aF0lPBvu87PPV+vJwxyox3e7fEI0Re8TC0nR7XnZdyFwvFA3NlNDaJguiBiPXr0dSoMBQ==
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

Make use of the new struct amd_io_pgtable in preparation to remove
the struct domain_pgtable.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 25 ++++++++++---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index da6e09657e00..22ecacb71675 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -47,6 +47,7 @@ extern void amd_iommu_domain_direct_map(struct iommu_domain *dom);
 extern int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
 extern int amd_iommu_flush_page(struct iommu_domain *dom, int pasid,
 				u64 address);
+extern void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 extern int amd_iommu_flush_tlb(struct iommu_domain *dom, int pasid);
 extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
 				     unsigned long cr3);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c8b8619cc744..09da37c4c9c4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -90,8 +90,6 @@ struct kmem_cache *amd_iommu_irq_cache;
 
 static void update_domain(struct protection_domain *domain);
 static void detach_device(struct device *dev);
-static void update_and_flush_device_table(struct protection_domain *domain,
-					  struct domain_pgtable *pgtable);
 
 /****************************************************************************
  *
@@ -1482,7 +1480,7 @@ static bool increase_address_space(struct protection_domain *domain,
 
 	pgtable.root  = pte;
 	pgtable.mode += 1;
-	update_and_flush_device_table(domain, &pgtable);
+	amd_iommu_update_and_flush_device_table(domain);
 	domain_flush_complete(domain);
 
 	/*
@@ -1857,17 +1855,16 @@ static void free_gcr3_table(struct protection_domain *domain)
 }
 
 static void set_dte_entry(u16 devid, struct protection_domain *domain,
-			  struct domain_pgtable *pgtable,
 			  bool ats, bool ppr)
 {
 	u64 pte_root = 0;
 	u64 flags = 0;
 	u32 old_domid;
 
-	if (pgtable->mode != PAGE_MODE_NONE)
-		pte_root = iommu_virt_to_phys(pgtable->root);
+	if (domain->iop.mode != PAGE_MODE_NONE)
+		pte_root = iommu_virt_to_phys(domain->iop.root);
 
-	pte_root |= (pgtable->mode & DEV_ENTRY_MODE_MASK)
+	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
 	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
 
@@ -1957,7 +1954,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 
 	/* Update device table */
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	set_dte_entry(dev_data->devid, domain, &pgtable,
+	set_dte_entry(dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
 	clone_aliases(dev_data->pdev);
 
@@ -2263,22 +2260,20 @@ static int amd_iommu_domain_get_attr(struct iommu_domain *domain,
  *
  *****************************************************************************/
 
-static void update_device_table(struct protection_domain *domain,
-				struct domain_pgtable *pgtable)
+static void update_device_table(struct protection_domain *domain)
 {
 	struct iommu_dev_data *dev_data;
 
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		set_dte_entry(dev_data->devid, domain, pgtable,
+		set_dte_entry(dev_data->devid, domain,
 			      dev_data->ats.enabled, dev_data->iommu_v2);
 		clone_aliases(dev_data->pdev);
 	}
 }
 
-static void update_and_flush_device_table(struct protection_domain *domain,
-					  struct domain_pgtable *pgtable)
+void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
 {
-	update_device_table(domain, pgtable);
+	update_device_table(domain);
 	domain_flush_devices(domain);
 }
 
@@ -2288,7 +2283,7 @@ static void update_domain(struct protection_domain *domain)
 
 	/* Update device table */
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	update_and_flush_device_table(domain, &pgtable);
+	amd_iommu_update_and_flush_device_table(domain);
 
 	/* Flush domain TLB(s) and wait for completion */
 	domain_flush_tlb_pde(domain);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
