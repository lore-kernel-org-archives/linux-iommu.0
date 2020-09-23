Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC194C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:11:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AD62076E
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wYUmwfIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AD62076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 671B08607A;
	Wed, 23 Sep 2020 10:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TKAl29dIyyJq; Wed, 23 Sep 2020 10:11:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7C34986130;
	Wed, 23 Sep 2020 10:11:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B53BC0893;
	Wed, 23 Sep 2020 10:11:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE78EC0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A176D860C2
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fx-jVak1x-Y2 for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 10:11:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4CBFB860B2
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ls8uueWEDLQ86DmXaAjuVQwBqph7RXLcW/VefOcczN4JU0kARS6KJUmsdDBrsJEdw4ioSdp+x/de37yGwlFq3D7RK6Nva6pLnOt6HmCJ2R1pjLddsx7IIG49H44yLQthYDSjlhy8dXsSztyvoANKnhdAVSZnyD0GV/p0a8i03NRnyXD8f95E3mBTQjc767ts79UFdV/ZYWVCVkhPBX3cy42+hgZu0tDx9ktLHGtrkuvMcneiL2QKWmVrUp+Xf9A2Qz7DIL1AKjPpPF7nDxmRXO922NAqAwOA3teHl0IzooL0qyPhbSvI9XIHnyfc+PEbB4kBKSCJyeuGzP+nlWHTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNX/JM2v2SQH2Wl3rW9HtjPDYQH/+fxGNy79UqPhfFk=;
 b=F5jPpM7PE9SGso40xwV+Ig2xMGMqM8M+LxbccCx7rAiNLW/fONU/TgLMLkvUGe9Kv98FUXUumSET/SYBR1279xB5Ql5YgAm1dQJfmmdDcp3ASnjiJsGlwpoMmn86MQA0bZ0+g6ZX9/mCxNRg+GkQp7r35jJ6Sbndh8WlDaK0W+f07bGhYOn5YP9/A3/IxVQFCi/x/lVn+ndgoDh/TzOE2Yh9G3511Odavp3HMajBqvlMfb/lvHe6Va6PAo7tJAuJ2uxqJKAxdlKU5ugF8Dbns6ZwmJIk1AFsyn6AGGCudTDzLHmiMFDWpu8LCdJAV1yP6r9N+clOSobv/2OlhlFT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNX/JM2v2SQH2Wl3rW9HtjPDYQH/+fxGNy79UqPhfFk=;
 b=wYUmwfIzlzzxe5E7THMLGsIFWpEaSkDmqJx5BwOKWGw4sPVEaSXhoyW857P5X/bSq5WjbeXTEh0cOq+abfbfYn+BDuu0xHB83gaQQ++QONUxdXYF2I2weHSOlr4iKALoIE/DeGzirZtclqmWFuNS3fcf2bcMrdaWcZEhulVF/BE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 23 Sep 2020 10:11:46 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 10:11:46 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 05/13] iommu: amd: Declare functions as extern
Date: Wed, 23 Sep 2020 10:14:34 +0000
Message-Id: <20200923101442.73157-6-suravee.suthikulpanit@amd.com>
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
 Transport; Wed, 23 Sep 2020 10:11:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10c33805-a93a-44c4-e942-08d85fa913ae
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB346634213DDF068774FD9634F3380@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3IF4PH60vaUbz7Mf+erqde9hDAf371qiDs23NBFjpNIA9U9HH4rzEgMOpFsNh+u5RIDaWCfJiuDhGTESlNUw5M8u28n2g2S4Y91tJaA2Fvv3+1FMgk9Xje7CqcSEBaInYIpel4VXTR0wCL4iuZfyYQeybkZsGXwUbhptUD98ZwWDr9u3vT8pxFdNCOVY7s9ejeZ3WMn2CYjRfAkVQ1/aF8Q3uoAYxFz4LOKjKN9Uf+vh3klcbSVl4HJ0ZWR1CHu4UBgtbSOWm77Nw0Plwk9Ft1pZ5/7R6w0sAWtUlyFQhiX+p9oMYMDpGTy/KKWxQgOujEV012F/YSHD2M1k5LlsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(44832011)(5660300002)(66946007)(66476007)(66556008)(83380400001)(6486002)(86362001)(36756003)(2906002)(8936002)(4326008)(26005)(316002)(1076003)(956004)(478600001)(6666004)(186003)(16526019)(52116002)(8676002)(2616005)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pj4niHOlC835cBbEOnzqwB0RJB9rFVSow8jvWh3hBmrSDxsQdIh6RP4kMrkZs75gZURPWDzfARotY+tNoPK3VFpD7RqQrQA2zBsIjEiRVBqqUKatuUloc+gY+xpK8afSJFspJEBdzHe+eWBIdP8QaNsjxPj2N5jXx4Ii5tqBdz+zt6q/wBICJUs9v8K5wpHv4nKNUCpnp9+hqOiw+PgFinsC6MM6VeVDuCpHK/eBVkVIrUvRf4vflQ28yeWJdiMpQZX3XuEQEiDXtqS8304kG66qpqRenKok5BEgoh2pb6H7fZ8BsoagNKLxVMYTK0hqE/gQ1R4yYObwf+ngjBQi3h7CfdEPgQjKlCT1z0PwtGZtua1ig09uk+vN/KAVdTSzNgYoyso/IGNk6sHKLwiRovJ6+gUQE71DfEoWFkjuf833vzg1W93hDTuQb80Wlkp7zlp9kz+tHrVqOXhANVYF2IuyF1t2arqUpQB8NBXamha/UcJwve6eMx8/++EkG8S86ThJpF7QwFAUKpr34m+0cUR5A6dPkvridk800Xcq8BDSGD6IoQvPfWz9W1aeBa+K0MO/DiwLVqK4SmX1MrsSOvUhDkETplphN4hkv0ldDMnZHE66YDgLMYHOAbd13o+mve+Ji/+MRx7Ta3uyB9rHiw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c33805-a93a-44c4-e942-08d85fa913ae
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:11:46.1185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ds86uuDUt7ewWQQ/bYS9SYn7BKUXmHyBaysV1EyOANnX57tZEil3qyrTuNqzAOq7leUyK/NfrOOpayZCATlEgQ==
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
