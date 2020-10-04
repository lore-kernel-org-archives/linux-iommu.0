Return-Path: <SRS0=qGVY=DL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF3BC4727F
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826072067D
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WGLCEv+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826072067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 440A2854CC;
	Sun,  4 Oct 2020 01:42:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CXInvm4CHs8p; Sun,  4 Oct 2020 01:42:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8098484EF0;
	Sun,  4 Oct 2020 01:42:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78E00C0889;
	Sun,  4 Oct 2020 01:42:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50234C0051
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3F7662033B
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gZ3APjNPKKd7 for <iommu@lists.linux-foundation.org>;
 Sun,  4 Oct 2020 01:42:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by silver.osuosl.org (Postfix) with ESMTPS id 4ECEA20410
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfMlxN3mY8NcShkojK9apXoZtOI2sByHHVVELYtMmC9oDSGKw40Ia4/pmGDsi8he59WPsFbLDhYbfVXf8X4VkDc/8lyv5CWUWogUqIKumAEzxRj04J3EMUGohBS4pf4Vstbizm1+4yo2nRc8vLrBp0ftMZII9vHRAm+5ujRZ9tK5TqPz5jnJdcIHnhWBFZFjj/luMQlaetZd/Lmvwl2y6MRrisTRheKkxFj/BBSY9jEFB0MIhhm6QkGVjj060df1E2exviVRXw3u2L3sWDqV4tqlWohU4wX//bxSdkQTDxY4QqSd4jWX/ZiAlpB54wgZptrP2FJWvv11vGu073xE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAtKqkUQt5AZCbq+HTxThWLh+nvVykeYB7yIuGMQscI=;
 b=cExu/iv0uvAE9xHCeI948yIpZXs7YZ6K6elJHSw8JK1SGpOgAa3/N5UR5uEzh3lDrEj9yiyV0iEqfQHpZKHKS5QpYabv27L6fhy61NmjUN1GEYWIjo2A2g40tHFwODVEhmQDLjRUw7ZnLooLTWwxuXklvuYClbPrnipLxfdS9JAyIP6rCl7YgvBgnZHLlyplP6NK8sUeryOxlQ6TQI4/z87RS3M2SYb3QGt2Bq/jYro1i1OSIfFzv9w/EJjhsDvrjp/Plowh6AHKzYtwPOYSQOYsHsrRiZjDWQZ0MEZvRp9zFKfGwzchK1+Zsjr+QvjuOF8YOK33hA+wwxsuKhBlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAtKqkUQt5AZCbq+HTxThWLh+nvVykeYB7yIuGMQscI=;
 b=WGLCEv+J2UAqpSwx38L4ikaXN9Ys6p07YTPIer5zBlQk2Kr76uCA1VT+g5mMBqv+OcWavaOTO5U96ePFB+Z3+sYcu3v7QOhlnRGphEJcoZGPRfbyqOzI17X7Urw/qETxBAUilIzOnbDfJq7XV/V6n9ISx83gRs/W7HdHad0dAOc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:41:57 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:41:57 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 04/14] iommu/amd: Convert to using amd_io_pgtable
Date: Sun,  4 Oct 2020 01:45:39 +0000
Message-Id: <20201004014549.16065-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
References: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0701CA0004.namprd07.prod.outlook.com
 (2603:10b6:803:28::14) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN4PR0701CA0004.namprd07.prod.outlook.com (2603:10b6:803:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend
 Transport; Sun, 4 Oct 2020 01:41:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a0a5f27-eed2-445a-9a41-08d86806addd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14512F7AA504E5D3BAA4F206F30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CudIXm20QEtB/XFOu1ojhxGaYyLpjEggZeBO5EE49BCrZFFC23EwgAAo3qvvthw2EfPDMiYWlaAxJGY/Sq3HVX5pxcM9Jnw6fbX9+x5h5eogc8eSHPFDoGiOgy7xBUqWqg5wAt2idoBhPNNPaOxQut7ss8tPoJ2dakLG+fPXUbHkOwwChHRsC+hBYPfiWdyqn247EtmnMB6viD1mfGP/0/wtvhIi4h1ucelogsu2DdPlpc07sbxVTtL+HespnDX4yesYOXCjvrbK1q4rrdVQJ+WFwVcDlseZpmOIDFSGeLGcS/9wVNaW5KDqA8cUjBgM/Jn3jh35Spw7MginC10kNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: FtuB1/tM1GHldThbndv3iOXZa48z5MiC9aXS+50+1wliV6lJjU0zh1SNoB4PoGusiMFhTFwM7NMDGt4O/bfx2jge6Li2PYb7LUwSDdJYjXevUgLY1EoEnq33+BqHyIw+Od1XrXGULyopndug8JAzVQVwz+5RBzZk011yb+d05+jIqPql3p/9RsHEsOhFIQrZ5+zvGIqpQ9wtbfd5/yOrBD420cKN0QLJbEp/U6z9FkI151+4CtX+tc0dzMMWCNwHAhlKdq9zxtZP4qjx5VzbMsLnyMsgObeshnEom64GwDmQzh/MbngcNu4cVL+BUtimXjZz02FqRlKvADkhZ1D5pyvlVFoolRE0jkomiU9XXo4SOdl7EeaWOTZwKg/9f5q5CamKCtrV7q5XfS9DI9+NVQ/lOJPG0fZrG1XLSIw3GUpk7YmkakOi0o4lWhY/NxfrZGmlnRbBx+qWFSSF9Rpmf9s6UbDc76RaDeaJf1Z+X354W8fM99Dzk6tjuvSIjDcvsT2+bGhKmvWu3WcYHiI2y7r4ysMfm4DiWbZYosbLXc65BE3iI9dk4kgvMsRKW2TIsy6MFzz9CleMYEk7TirMgZvIVQK0aNNuze1pMzbnBcXtVFB4agQ6MMLupis2iqJUa778ez5/0zc9bYxZ5fPyqg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0a5f27-eed2-445a-9a41-08d86806addd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:41:57.0958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0Yo66vlJy+5qzpxw18Gs9Gw4HhwqLLGAPK8IVqobj+cdrQoeYDtjxc/gtruPlAiONMVV6nKlbNpHX/7e0rH5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
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
