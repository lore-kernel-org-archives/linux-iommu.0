Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D6FC4727D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:58:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47CC206DC
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MiZq67il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47CC206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9441A869D4;
	Fri,  2 Oct 2020 12:58:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yd+t6PzJYhJn; Fri,  2 Oct 2020 12:58:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EF1E9868FF;
	Fri,  2 Oct 2020 12:58:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCADAC016F;
	Fri,  2 Oct 2020 12:58:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C800C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 38608869BF
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:58:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cuyePMDyRUF2 for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 12:57:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750074.outbound.protection.outlook.com [40.107.75.74])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1E29786924
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRrg4RJjMt8c8fw5dHcJFfvHsgeL8t+sHRCsE1T+xeCm8sPIlqX1dRqJqu1pE7tNxchjpMa/u6+uPpb1gPj+9mWvF0hvfScItoKme6SEoR2D62Hdy5RqTbpcTb7I1weZFj9k5SLeHytousLVgX7AVfbYORz4eN7Cufi3Q0zxhBCL62r2uZ/qtlwx4Li+v5w9oSWDgUsJYYZmb00gZHm0h5tU8NnmI7zwNbgJCEKzYbwwB5icCK7/zxlUBQAcj28ekODmSoqxPUJuxqalhtP4OwhtzsmT0DzWv/a/RofVBN+JyeFbZ6AOToIm8FvIdqpy3asKIjKQME+fhQ3wQ5UXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAtKqkUQt5AZCbq+HTxThWLh+nvVykeYB7yIuGMQscI=;
 b=ZIbTqm1CH2Xt+/hhbW6r9dkSbslcMKKoIeVbo5m/gwMZ+pLe9ZxKne6yKKmiz+0Wz+H/HjrfPrHS7QhGTqU83NVm5ysMp7Uys6IrXNY4dVV0MlN7WI5jvYC9Ud6XvjFC6sa1XcyBqi7fU23Mr3P5NN1x4OwLPX1WuFZ/Qb8dLLWFSjRwJOW2lw1lC9SWduh/BkRh7zxVgmm19usq6WOJzWdlC+mWh5Abfz2iy138DRprWwt/9Rg5v9DmV4zqGc23FUw4LABXLhuJKF/D/tBoon7x1ICex7QrRUPHH/vL2T+4oS17irYjL3x/iGv+q7UlQOIgXoQ6QePEm0dH3sCtzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAtKqkUQt5AZCbq+HTxThWLh+nvVykeYB7yIuGMQscI=;
 b=MiZq67ilxfbJNwlXWebL81JcpPq6dPvuTq5OcwwupFupFVZLA5eN7dQp3pgamXFDvZP4MSryYjKTPFRWnTTFAwYLisujTKCJD1m8oEzMYNrD/eF25ypthFMXM4sHu3+4A4qIzpparHMSF8SddhwzhNHbXwsI6awmnWiQjjH5m48=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Fri, 2 Oct 2020 12:24:51 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 12:24:51 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v2 04/13] iommu/amd: Convert to using amd_io_pgtable
Date: Fri,  2 Oct 2020 12:28:21 +0000
Message-Id: <20201002122830.4051-5-suravee.suthikulpanit@amd.com>
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
 15.20.3455.13 via Frontend Transport; Fri, 2 Oct 2020 12:24:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c2bf5e22-4588-4447-261c-08d866ce28f2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11636A2F62C79FD3FC8AF0B6F3310@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vPC3YAdI0Hkn4ClWgQn7Tk+68DTBfnyERxcGx/rb58fEvzZ2cG/mjD5DNy/wtO9uCyukgzLmj+HZAngGf540Na0MuHH6SGLx2z8bKIDBwUWDbVRt72KlroADTdl7e23FUPr+coqhN0Izo8LTQ+J9mY5ZVBb0lEQQxiJQ7M8+k3TO04G3Vc4+4jYRXV5UpNQBqXoa9keIln5+88/NnWgRnbTwvD6apfc2JYIrgQ5bl2EC6ir/fKbgyLYd8JtBQCWW/dPdWXiMJSrQAmlCORolarNOa78/W3tXKJhFDoDGjajEO734klcpijx5LxkDRJgS4jNLvJDV/XAFRYZ5mzMh/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(66556008)(52116002)(66946007)(66476007)(7696005)(5660300002)(8936002)(4326008)(6666004)(1076003)(26005)(6486002)(16526019)(186003)(44832011)(316002)(2616005)(36756003)(956004)(478600001)(83380400001)(8676002)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qoexITToqs5+OazCZm4+O68MH/BEs1gUcLfuHGF5eVXslP2UmDYsg7JNN1qnaU8QWO5gO1ajD8fwest8whkIIwIFiJjRIxr5F5tYkVWijZyB9Zwr2zZ5kYaDebQHNeGoxjqOC9+hwAeFTTRge/SQOsCTzsD+DxxRkxr+WEQcAw/5okABJqbAc3GRlqG9NFNDohNO46G3En6nW5OfsKX2gfUS+CNabPHDiSIk80aVzzyUcjBV2GKUlaZCNOi3IEYWbZFwkhOg0JwBZ+efArrYT5XbsyN92r/9CO/+2cDriCO2o/fr8VmucjfT0DLOdmSR5Zxi8VAJwv7M49CoPsO2lElnqQSdiaQ7bGhpVNOom/OW+HYBXdVfhhXluLGFV4tVF7hD0xQTPMzcNPyWXBN1KonZ+7klgnm8eFpzrMkUAuHkytXfrD3kYpIYHNEjIbKIm3kPlV9zljn7KsCkKuGfRbAuLBXj9N3XpHlDT2KyHKzfJEz8iJWd80xxvgyR4pZiKM3EB7FaAZIhy260Opkf4cJdhnNR0IeDU1ftiuQxviwnjtqdDnyWR17CJ2Fqa+EruyhuEYevMETvMxqsIZFV1+6GM3hIiWkhxK8ZDkxhTO5mkzO9a4UDiJw/QYgAzgpuFu8dMZVNOAa0JlYJft2OXQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bf5e22-4588-4447-261c-08d866ce28f2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 12:24:51.2328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nW/odPjn1HhCPz/+Igyxthh4TwpY5vr091IXj0V6ns4bO3kVQMTADj0SoqYU1Mn9RAws9verxEbVlLHhoBPX5w==
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
