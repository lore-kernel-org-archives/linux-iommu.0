Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12EBC4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:57:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485D0206DC
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fsNNVulf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485D0206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F19EF869D4;
	Fri,  2 Oct 2020 12:57:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4jfSiqtDqqtN; Fri,  2 Oct 2020 12:57:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 55DBF869BF;
	Fri,  2 Oct 2020 12:57:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43467C016F;
	Fri,  2 Oct 2020 12:57:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7C0DC0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A5FDD86594
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:57:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GOxwqCNk_009 for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 12:57:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D081986432
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUu6YAejIfgLMzrzN8gT8EsMFD8yfrXCf+vSKbO9lO6582f1tO71gZ/8CBAYxqI5afcrRvhn24MoiEN5iGYVKda1giZWoV30tyI1DvA8uBEgVyr1dry6BzHViAxGDZu6AIjbjwWImYWCDboxqwCuuJYSGAaX454V1ByQFvu/ndY0xz3S6AE0E6BFu+81PxG/UtUHOZLFr3iH+XGJtTcCks105i+7UWjIrKvCtvIf3sXhJPDB87qnyAZicvw8eEvDX5XnJ6R3du2SYH696JRMJyKj0/Y5B81cngola2NGKiy1qqeg61gA0NKcLCdsyv2hwf+kLKSy7mA0TA1Evmjz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNYfRxFr2lHj+6XUrW+YPfxDuN3vHBirnqdMyTJLQCE=;
 b=gBr/wO3etjkXJhD5XgVeEnQmGzDrhZtOoeuAt8wuX2caOA/BF9m7ytq4RVaDYXRP5nuEVJiGHfhwQzNRcAikN27EZc2ewshZ3G3ubCnpYzp6BWy9UOlXUz6zLOSgFYo2JM4DigvtteN0hgXL9NTjZHWgC34a0nFAL33m7O3/+mQpKsPFDW3F+ab6rLvlU6exj86Dqp/3njzXmgREgAl2NVKKAAj5UXaXN6fJ7pM+8yQchQwaDFotkHnFTCJVONrr3Ua3sHt6upY7ZCj3pQigVMiwN6J2K3TqtX0ZLf6IIboPsdpjxNk37+lFBQJ9psZoVhrGkbIFJealvkcdz8NO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNYfRxFr2lHj+6XUrW+YPfxDuN3vHBirnqdMyTJLQCE=;
 b=fsNNVulfKurRvUPcOb3LdcZchAhfJAnVX78y9/Xv0E6bvhEJ1TceEJh09sQtxEh/3lqRbuHX1OCVKu5tZPpPu5bOA9kJb0pVLdYrbVi4xHMT3sIcz18uz8pXPOqCFxEq7V/+k0uMRP3VUDIh1QgaxUUSMGVKVWBsD7RcCl41PEA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Fri, 2 Oct 2020 12:24:49 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 12:24:49 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v2 01/13] iommu/amd: Re-define amd_iommu_domain_encode_pgtable
 as inline
Date: Fri,  2 Oct 2020 12:28:18 +0000
Message-Id: <20201002122830.4051-2-suravee.suthikulpanit@amd.com>
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
 15.20.3455.13 via Frontend Transport; Fri, 2 Oct 2020 12:24:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a7fc32c-1afa-409a-b872-08d866ce2745
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1163EA88067B251463355D49F3310@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OO7CM/ppsbdCqG11jY9Oa0IzaNTrQqh8EN6DITi4tIXxY0bz4ABmD7j5RfspUKkyN0cWVm6TMsIhIBQ+2MPEsC+A6Ve9sShTyuLuy2Jl534krkU0DXSHTcGsZhmXqv43Su2D6eroypxtOPGOzorivEXDITs3Q/ywNCkFR3Yl61UDvQrc4SDUfdnAh1i1Rsb8+9x8sFiPjbkJJ92cPegTFKQMVCPRMsVnMK7GnhPRg9Ms0nEiC22iqOe3Pz2eat4tdSVnSUkCHTMcBGY/11FIkq5jB7Xy7bKuOZOAmhOKCDNme6IW97z4NlJ9LoZ9cAw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(66556008)(52116002)(66946007)(66476007)(7696005)(5660300002)(8936002)(4326008)(6666004)(1076003)(26005)(6486002)(16526019)(186003)(44832011)(316002)(2616005)(36756003)(956004)(478600001)(83380400001)(8676002)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ND9UJAUQMrUlpA4sgxM3ME3ul0HZPhSk7GBEkHzzbOLDkajlPCDpSDmao6wfBkhzbFaZA+hVdjmNV43R17fVHI61Akc7wq1GXFyZjQxYgxibPp4IgqwxfXtdfzOeZjGu9BoKKxXMGe8/HygbnhD1+uBo4dYWHHfPQKWynVb6YsihTuWYhlfU1fpOx4AtaKkbEHL0f3Jc8u++OdCL11GjutAFTKSssXVy4HvFglSYC78zu+z6N9ATbJv3r5+am2a1Jvnv917oXjB0Jf8ifJybSSkuGFwQAdGlQzM2u02izd7+f1hJttDf67CPT3IcLwtZczJHnCPKAuD/KMnI1brGxUSswTYntkv3OatmnWPITnYuc/SlMw8UpBvlXyERsowyqX6pln0P1IcNpiCyjlTYZy1uMmXGnsmaD2dW7oOyO1XXMOwZuDlgFjZyuvrmvco7JE4yEceZNPKCFblFJfkk37lVDwpAGTpsod9/ey+5TZixWXqrMxco65ROFTsfC2EboNqYpLaB/zr9p5BrVnGYPGH4arr2/UJk+u++Ng/ZwNjH7I5PW4xjZHrl3Kh8yxnCCBHkbKHjWG3Bc6ZESFnmO9zNsXXhR+3tOHfUrEusUPQry/9tNkOAOtExIV4FWOomXRP0nNVD8XBvOmlVDUAIuA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7fc32c-1afa-409a-b872-08d866ce2745
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 12:24:48.3860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKt3uIZWX1clCn7S1lnhoYzYaIlyXFEeR8rkSuurroDbLiprsw3IskEbJ/D8RYvLHvz1/XAECoxWgVdBE9EVaQ==
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

Move the function to header file to allow inclusion in other files.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 13 +++++++++++++
 drivers/iommu/amd/iommu.c     | 10 ----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 57309716fd18..97cdb235ce69 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -93,6 +93,19 @@ static inline void *iommu_phys_to_virt(unsigned long paddr)
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
index db4fb840c59c..e92b3f744292 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -162,16 +162,6 @@ static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
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
