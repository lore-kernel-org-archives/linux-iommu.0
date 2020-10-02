Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05710C4363D
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:58:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A20D206E3
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 12:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZdvXbavn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A20D206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 43EF8872F3;
	Fri,  2 Oct 2020 12:58:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tHtF3rrOP6AO; Fri,  2 Oct 2020 12:58:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 301FE86EA3;
	Fri,  2 Oct 2020 12:58:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C4F3C016F;
	Fri,  2 Oct 2020 12:58:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF18EC0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DE76D84518
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:58:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F6Ev9ebZZBGl for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 12:58:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750080.outbound.protection.outlook.com [40.107.75.80])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EEEC284476
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 12:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6wpPqh3Zp5p/auByBEKKhlROmzI8UUJmUZ59V51RirwraYg08HWi8ROKqYh6rHe37iChG5yLjQjgjLgkWDZLm9fTYjiMGte5/IBCT3Z2mX+rN2190hqjmTUDmAnCfW6cW9ChvwgOeVfOU9dvf3WrHhiGFfGpK6Vm9ABXdXHmHIavCrHcxTaaqNH400i8f29FJFBuzLQ1OEPSRjwW0Z/sfip1R5QM2Gz9HcD43E+B6hzMkMjDBorf/PvnSHCN72Vsi7c6VHKo3gltPkpEPjt9p7VfNT/8L74iqiAiTK4JNT7QbJWEEvhOjv7lVEVdiwUlNRSNY9o5Cf9g+zKVev40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44DTs3hijvjAJ9A9IEYp+l1fIh1HFGHoIjCHAsn/YT4=;
 b=JOiaSw9z+cHO+IelD/ZJ67/E5yGHfWy5BI7BR0IzG77W4gk7zksnY48O9cxp1W5/1UMenXw7o2iG/ew/+VqVVEGOQIx0l9bzc5K6y+hNm9cTd5H17zGh7TZ9kLd+5fZB5DLYoVvuEko0SsbnA5RnDngOVdzR4SJSDNqHzsX7RwpT+2l46yqD2yfwAe5soEyUFT3WbNHVHNhaViWCgg+A1hrsXvHW67GxMGNOLKV+KDFOmVyAcUTjRpu4+PhQAeRT/QTRFdKhGEuSNKk3sMPQLq67BcBk7eEQSsx9zHD/mF3d+inApuhzrAyEeqBgA6JK5UkEk8xHO5aIfpjSJujFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44DTs3hijvjAJ9A9IEYp+l1fIh1HFGHoIjCHAsn/YT4=;
 b=ZdvXbavnpgtasf62Pi2/VWuASi4BIxzdXr1uOBnphL41P1oq23mD++z6y6qhuA5sV6onQERdLZnjFY0wbqBBMbhY6ItFpLS5B//+awzLCGDp3J8LJXKqS1bh4lHubNEMyL0NFc2oNh17SN0bKFWAwloi8e9wrb+UPTKrLCaV6ls=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Fri, 2 Oct 2020 12:24:50 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 12:24:50 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v2 03/13] iommu/amd: Move pt_root to to struct amd_io_pgtable
Date: Fri,  2 Oct 2020 12:28:20 +0000
Message-Id: <20201002122830.4051-4-suravee.suthikulpanit@amd.com>
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
 15.20.3455.13 via Frontend Transport; Fri, 2 Oct 2020 12:24:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2adbec18-6636-473a-dd21-08d866ce286a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11632B162B7C7AAFA70D6E6EF3310@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rfBaleWH3bLca1r8tWAdTs8112UXNcCT7tUsmbUDsHD5tbmzctxnBjTB/4Dpp3psL22InC+tQ6Zy9JCczweL0TeM79nn2jkAPK+qSeHGb662nkRozSUGAl+Byv6jKrqakc6iwzScziXiKFnaxJIBVqsrB1D8PUNjbfXCTeuFcvLHil3hOA5mcdb31BKGedG6wcUf61rW3ULNhU4nj8B/ihUlUxJZc2P//aSO+DqnN3mXu+LxCsp5k5oc+ikKpjbxYmG83/ElQnD8di88h2Hnru3O1s2pYcpNLcFuutgCRVn0VkBES3fSc5MCGrGmkK5ObmhPRIN21uQ9sKjwEe8LjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(66556008)(52116002)(66946007)(66476007)(7696005)(5660300002)(8936002)(4326008)(6666004)(1076003)(26005)(6486002)(16526019)(186003)(44832011)(316002)(2616005)(36756003)(956004)(478600001)(83380400001)(8676002)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ic+X9hRvn1dYMaSP7rXIYeJGzgF6HdSNsuJQ5KXcyKdBH2wuuoeu+j8AdRdqG90dFQpQN8wbaYQg4sPbNt3qVmPPR1ImCphuZdW4kjURt55en3EKp09L06YB+0/3CRmp61XSMJsdsb4ynAc43q5CVq5dkR5qJbA2d8bBxZ8VBkarzwweWSHsp/OuzdIxUU2ZLsKlvTiaus52vWYQtNJP2S/1YZxQwlNipm6IcIBVR4AilpCMburvxubKkhdCfjXDOTSiuWZ/EWvWOoj/p0UQWqXlYLNY++GXz7apFf1qRCLyft+Nc6zGdy3K7sKX1yJNuMteBGy3hQZt2mVJvg0Mu/ZMRgPXtU2mCRcjr6U95ZLWYnufbqctwQpBDq0h9Q0aB7YRh6Z3IXJNrzWLio7ROIlkBdIJ0+hXAPCf4P9vdLmA8hSZ8dUVUb6H3SvSvUuSPAid5LciTq89bJH3Zl6hQhMJWmFUMmcPPpNeT9ZdgNoSNceUhm7tRfAksbfG2IBFOJv99OAulqPhCG/YmsXfpWmZHru741CToDqEpb7550f5f1TG4UF2pn32x64IcIxT36r2rnq6ASkOkm6gsMV+TsqAAe743HvZRe2FtEJzOaa5L4RsmaEyUXOgU8sbXxcTD1yE74WQ/HwDkFHSnLUqQg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adbec18-6636-473a-dd21-08d866ce286a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 12:24:50.2982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9JhdtUO4W0nhvI45APaMP2bRdrhTHoPr1fdYTG44CCuKDzqQ9jmi3LJXMqUf3LDlT5o473Dj10+DqbRpi2rOQ==
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

To better organize the data structure since it contains IO page table
related information.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       | 2 +-
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 drivers/iommu/amd/iommu.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 97cdb235ce69..da6e09657e00 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -96,7 +96,7 @@ static inline void *iommu_phys_to_virt(unsigned long paddr)
 static inline
 void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
 {
-	atomic64_set(&domain->pt_root, root);
+	atomic64_set(&domain->iop.pt_root, root);
 }
 
 static inline
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 77cd8d966fbc..5d53b7bec256 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -490,6 +490,7 @@ struct amd_io_pgtable {
 	struct io_pgtable	iop;
 	int			mode;
 	u64			*root;
+	atomic64_t pt_root;	/* pgtable root and pgtable mode */
 };
 
 /*
@@ -503,7 +504,6 @@ struct protection_domain {
 	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
-	atomic64_t pt_root;	/* pgtable root and pgtable mode */
 	int glx;		/* Number of levels for GCR3 table */
 	u64 *gcr3_tbl;		/* Guest CR3 table */
 	unsigned long flags;	/* flags to find out type of domain */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2b7eb51dcbb8..c8b8619cc744 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -146,7 +146,7 @@ static struct protection_domain *to_pdomain(struct iommu_domain *dom)
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
