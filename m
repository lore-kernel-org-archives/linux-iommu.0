Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B361BC4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:56:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2712F206E3
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s19YWTRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2712F206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCE4E86DDB;
	Fri,  2 Oct 2020 12:56:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RMmFDWlWVKcS; Fri,  2 Oct 2020 12:56:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2B61E865B8;
	Fri,  2 Oct 2020 12:56:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1624EC016F;
	Fri,  2 Oct 2020 12:56:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7AA9C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8B82120471
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:56:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rTClwC61dZ-o for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 12:56:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by silver.osuosl.org (Postfix) with ESMTPS id 253C720459
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:56:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+o/1ZTOI7+cq7I5ZGk/E9Ysh+Gk32kSZAaY3zcPXCdQCeHcjtTj0y99hBEAq4YxZGBiRD7gHKRKBv173AlhG5gCFYFcwhDp6wTb6Vb6I0OssorGMKk/FRlaiBDcA0sEwwYZWjotPBYCL32dFfbCpdD7EA8tt7+KJz2td3i1tbDWmmB/3yH+x/zMkQE69+PSaAr7AroenUfEbOH7RISKliOYcFKdr/CswXXXWhZP5C6oNQteLm7L71k28WQfrTVVJ3dUHQFHJUommTbfvL5Hfi89tBupexnxXLIR0KGySrGBmyumudTu2oS7j+GqTP8jIf2S5KcR9PESmV6JIyGrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNX/JM2v2SQH2Wl3rW9HtjPDYQH/+fxGNy79UqPhfFk=;
 b=N9N0XIVzmi8Hht01iO9I5hRyLSjLjElMvd9CKZQQTngOsxWjwlJfA3H8paZW8pecIH/kjSt2vy//mxdHBaVr1En7tQxJNLqbEUmSMnRv3yDsWJ3nvoK/oIdo5SmfcJmyAZAoON+AZTtJFIyt+aazsUGb/pXBMcxQunMYVBIbPr25akhPPhcGq0630Vwoax6Y/Eoh6MnUDMk91NzUcOMCTmYT7gwzvQUeWNd/mEaMQilEVtydZb2GqK9kuJSTH7iko+pyTFxpSaq9U+wupRE9uqhPUfpKPBJe2ggZAQd3yC4DK8URZMjW3oUWgDi+7tzk0wnYzgdIcgINOLuyOU9HXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNX/JM2v2SQH2Wl3rW9HtjPDYQH/+fxGNy79UqPhfFk=;
 b=s19YWTRuuhHzCVCUaegbxRTRS4t//Byy+6XgIPIa8ZYITYg9wROi6xrffReIHYXlPp3AvUSYXfPbN1EaK3hbP8Pk/01H4Vlh14NEU2L3itSXCMA3fUmc2Kw21lYxudUuihSW3xn5hd7mqygZcSFOHK2cp+mFiyvXZRcUHlSTQow=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Fri, 2 Oct 2020 12:24:52 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 12:24:52 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v2 05/13] iommu/amd: Declare functions as extern
Date: Fri,  2 Oct 2020 12:28:22 +0000
Message-Id: <20201002122830.4051-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002122830.4051-1-suravee.suthikulpanit@amd.com>
References: <20201002122830.4051-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.13 via Frontend Transport; Fri, 2 Oct 2020 12:24:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3fa70959-ebdf-4501-db16-08d866ce2986
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB116356A65F15154B23BCDFDEF3310@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKgdYO1K7/93eYRDs8O4lWNihPqq5GWA1rOqjMjFtqpzlSGBld6dfGAdM0RZcHFGncl2TW9wW/mnsOMxjZLxs3yajo/26KB7EKkFKIeWibklPrXZKDyrIsvKzh+dZnnn1zTBAJM9vycpNgLj7H2looXPfr7I6p3Mz3uqqIGN0l3ZZImy3OpPglqRx1MeG489GnoErl+HV9rGtY/O+RDfawO7f42N8s7bTyikGl+rRXKtgu+5RLBeHJJ5Hq6U1WhPcGVpdBXpcDSV3Y3FkmhsCFu8ECqTfuujaWd6HgHzA2e4xVma1fd4Cnnv/WG40+hqTLYpsx6tvMqardogLPoZPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(66556008)(52116002)(66946007)(66476007)(7696005)(5660300002)(8936002)(4326008)(6666004)(1076003)(26005)(6486002)(16526019)(186003)(44832011)(316002)(2616005)(36756003)(956004)(478600001)(83380400001)(8676002)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jMZt48qNHu2gTSZVhEwntoRPEkgOQgY1oRAGBe2ZAIHotydqCar0rUTBcW/wKUmolHjyTmYTHUsBz5Bkx+0AijfYRLDgKyKh/ENyUL3O48PG9rSvVPwBg4YV8Q6BdA1IQ2RdhYDpRvurEPzevmKMwM8q2V0xEQ4AH0q2KsTz2KB5SlVbe3HZGcgaryXVGe254UEczgyr/hS3stOnq4KwHKCr4WGt8bO7kL9VVHY7T/50as0SNevdGbxoKMVrgcRQ505aJiRKNL1BA2ODWaYmKDzPV6xM9xFHkjoxRoNjZIpLI+tm3WAFxfvdH7WX4+JOD/JqUbHHt0OcIs+Fk0CvK1q0i2v0jLOCp0VJBJ20HuJZc6L8IMfOjF8OgeSs9coyCRlrJQdQZOLKMSA8p1ChRdWeJoPXqFdN1KdQhaNdGjnuo8ZQN4tsIWh9YhZ0P1TMZ58fYqAsVK/gI9vbriaTzyST/1MSq3FToRQD4c4ff4n0Rx/EyEBm1rqM9tTVPENAHpp1JTi7JhqetWtWnS1poS1fTM3UoCyCSaus2H0VHjCmOh1GViBxnD2cCmCCVhso+DNOYUUQ72ygtv4Nle5tA6DFJWvQkbeSL88mDyPP/7zciIstU4R8Te+EKspJELUrH2Gm8j9ws30gNlBObdaGkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa70959-ebdf-4501-db16-08d866ce2986
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 12:24:52.4342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38rJ3Q5peYr8Ouzx+AXxP8RBlSjPME6YGKNTqT5j0UuTHwU2Q/p+auP4NJZZiOJBXdwS6SF8GDDnEjdxYKAJHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
Cc: robin.murphy@arm.com
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
index 22ecacb71675..8b7be9171030 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -48,6 +48,9 @@ extern int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
 extern int amd_iommu_flush_page(struct iommu_domain *dom, int pasid,
 				u64 address);
 extern void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
+extern void amd_iommu_domain_update(struct protection_domain *domain);
+extern void amd_iommu_domain_flush_complete(struct protection_domain *domain);
+extern void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain);
 extern int amd_iommu_flush_tlb(struct iommu_domain *dom, int pasid);
 extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
 				     unsigned long cr3);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 09da37c4c9c4..f91f35edb7ba 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -88,7 +88,6 @@ struct iommu_cmd {
 
 struct kmem_cache *amd_iommu_irq_cache;
 
-static void update_domain(struct protection_domain *domain);
 static void detach_device(struct device *dev);
 
 /****************************************************************************
@@ -1294,12 +1293,12 @@ static void domain_flush_pages(struct protection_domain *domain,
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
 
@@ -1324,7 +1323,7 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 
 		spin_lock_irqsave(&domain->lock, flags);
 		domain_flush_pages(domain, iova, size);
-		domain_flush_complete(domain);
+		amd_iommu_domain_flush_complete(domain);
 		spin_unlock_irqrestore(&domain->lock, flags);
 	}
 }
@@ -1481,7 +1480,7 @@ static bool increase_address_space(struct protection_domain *domain,
 	pgtable.root  = pte;
 	pgtable.mode += 1;
 	amd_iommu_update_and_flush_device_table(domain);
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_complete(domain);
 
 	/*
 	 * Device Table needs to be updated and flushed before the new root can
@@ -1734,8 +1733,8 @@ static int iommu_map_page(struct protection_domain *dom,
 		 * Updates and flushing already happened in
 		 * increase_address_space().
 		 */
-		domain_flush_tlb_pde(dom);
-		domain_flush_complete(dom);
+		amd_iommu_domain_flush_tlb_pde(dom);
+		amd_iommu_domain_flush_complete(dom);
 		spin_unlock_irqrestore(&dom->lock, flags);
 	}
 
@@ -1978,10 +1977,10 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	device_flush_dte(dev_data);
 
 	/* Flush IOTLB */
-	domain_flush_tlb_pde(domain);
+	amd_iommu_domain_flush_tlb_pde(domain);
 
 	/* Wait for the flushes to finish */
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_complete(domain);
 
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
@@ -2114,9 +2113,9 @@ static int attach_device(struct device *dev,
 	 * left the caches in the IOMMU dirty. So we have to flush
 	 * here to evict all dirty stuff.
 	 */
-	domain_flush_tlb_pde(domain);
+	amd_iommu_domain_flush_tlb_pde(domain);
 
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_complete(domain);
 
 out:
 	spin_unlock(&dev_data->lock);
@@ -2277,7 +2276,7 @@ void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
 	domain_flush_devices(domain);
 }
 
-static void update_domain(struct protection_domain *domain)
+void amd_iommu_domain_update(struct protection_domain *domain)
 {
 	struct domain_pgtable pgtable;
 
@@ -2286,8 +2285,8 @@ static void update_domain(struct protection_domain *domain)
 	amd_iommu_update_and_flush_device_table(domain);
 
 	/* Flush domain TLB(s) and wait for completion */
-	domain_flush_tlb_pde(domain);
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_tlb_pde(domain);
+	amd_iommu_domain_flush_complete(domain);
 }
 
 int __init amd_iommu_init_api(void)
@@ -2675,8 +2674,8 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	domain_flush_tlb_pde(dom);
-	domain_flush_complete(dom);
+	amd_iommu_domain_flush_tlb_pde(dom);
+	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
@@ -2766,7 +2765,7 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 	amd_iommu_domain_clr_pt_root(domain);
 
 	/* Make changes visible to IOMMUs */
-	update_domain(domain);
+	amd_iommu_domain_update(domain);
 
 	/* Page-table is not visible to IOMMU anymore, so free it */
 	free_pagetable(&pgtable);
@@ -2810,7 +2809,7 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 	domain->glx      = levels;
 	domain->flags   |= PD_IOMMUV2_MASK;
 
-	update_domain(domain);
+	amd_iommu_domain_update(domain);
 
 	ret = 0;
 
@@ -2847,7 +2846,7 @@ static int __flush_pasid(struct protection_domain *domain, int pasid,
 	}
 
 	/* Wait until IOMMU TLB flushes are complete */
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_complete(domain);
 
 	/* Now flush device TLBs */
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
@@ -2873,7 +2872,7 @@ static int __flush_pasid(struct protection_domain *domain, int pasid,
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
