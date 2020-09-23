Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BF8C4741F
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:11:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9312076E
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ltgm2QLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9312076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 87A10204E7;
	Wed, 23 Sep 2020 10:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4HVIP5fpHli3; Wed, 23 Sep 2020 10:11:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 288FC204F7;
	Wed, 23 Sep 2020 10:11:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1074DC0859;
	Wed, 23 Sep 2020 10:11:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64119C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 52D0A86BE2
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VQ3tL2M8UFlM for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 10:11:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 96856866B3
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+I7e0vCDG5NLeBfcPKhb9LAW1tOIhX4rXGcALPZ0QjQsaSfyvY+iZiIeBxQdWAAvF7Fw66il47z2TnojcoFG33iZ92tphLhBPJRTNemA25MfxJ4jnUpDoOuoizN4dW+apGedmlva3mk4BHFBOSMfOeJCPL3z9KelUzMPX7EqPAH7GV4RDLAnfHR0d5m18iK2s/QCTn7kG+dIhKp0Xa5TUvIV4/Q/9FSJfiGAClwsqOLk79w+C5INKGJBdEDuZnD1vt1H73sUR918mGEi/wwGR2l3Ayx8njoyZCyKq4bw6jyMMuruJS5usicQwfdyZHb6OFA4SPwH+Ta73phBDmphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44DTs3hijvjAJ9A9IEYp+l1fIh1HFGHoIjCHAsn/YT4=;
 b=gx2onKJUgWBJhKwO5Ma0rpsOWwDNNMA91/Zs0wXOvuz9UZcf6PS4JtewjF7eq9ibHJMcCeDvlZcafmQKtsBfwtlbGVbNuvn51rW2YD2CczBGCTMOr6kcJmx5OKfTaRJYz+8GfE4LvD0HhcDeSPfTm6/H1qnJLtlLr6BHvcnaqNpjMt51B6/doAkmq7R5AOPxeEWBH5S8F8kSvuR7CZaFHPJK8BXdqfTOcmfo4byIyron7Tqnh0tBl/ot1mfTFRSpXIr9Qf7abUK2FAgDu/fMS9Qv5VsFJDYNt+ezmBUiwytaJTimdQeV8BWqX0CA/b4grnHEHPb6VpfY5zw9rgLN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44DTs3hijvjAJ9A9IEYp+l1fIh1HFGHoIjCHAsn/YT4=;
 b=Ltgm2QLY+raG+YGErhVNIKtltGjDXBkIkN7dWKQq49pSxFAcn1t7b4XLZO6Y1wgQCHY4EY4+VPQCkf/saxQObLb/Wg9xFazIHSR4M/oXRP8JcGXojx268S/aX5HusD7dhPUaeQ1Or09J84zeiZQarSGosidLW4BUd7Qn9vb4Ukc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 23 Sep 2020 10:11:44 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 10:11:44 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 03/13] iommu: amd: Move pt_root to to struct amd_io_pgtable
Date: Wed, 23 Sep 2020 10:14:32 +0000
Message-Id: <20200923101442.73157-4-suravee.suthikulpanit@amd.com>
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
 Transport; Wed, 23 Sep 2020 10:11:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e5140eda-5329-46cc-9184-08d85fa9127d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34662BCE150142D0907E0DB5F3380@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRi6Vs8cXpTGl57EIUSHVe8pU2m+Ke5um5KOkFPJy/acNy/MPH7R//82McXB8wllcEpHYb47Ac9hu9sB2mzvA5yrfaZiIHZKy7puzQ0YH+ECZh4cCVKJZfgXNtH+HeLq9KXBua80km74FeWaF9/vcFNH2LGl6PrCKRCXjbqQbKVZyuNBuHQJrNKX/owhLBlIe5K1ExXT76FKwUt7LEisUfre+NCdIHt5Ji50xDfeqP03tGiBcn4FAYdp/VD//6tWgTENwaIDOgpXaZjwESzi4X0jPCW4+5HtRmrTLi5t2/uT2hTWexPOCCuInHY6Xg+lJHXOScM8JDlm1BB5hB55zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(44832011)(5660300002)(66946007)(66476007)(66556008)(83380400001)(6486002)(86362001)(36756003)(2906002)(8936002)(4326008)(26005)(316002)(1076003)(956004)(478600001)(6666004)(186003)(16526019)(52116002)(8676002)(2616005)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tQNuSbWg+W9iLpmisVI8MZPFCTLhshD52rFVh8fut4+4gLvauaHWnjoP5/CppOA9aN8oOmOgdGUV83boo1ptI3rJRQitQy8F3HOQRd7sF0ozRdthQ+M15Z3hR8RSVxuLUHuJrvoIJtxx8Sy+0gh2dUxV0p+c/KC5zIEo8zrJufagjh8c6YqxtJID1DwssAl/bP4HA7FxchSEKQ2xfBuz1Xc5l9Q1q3dnKaE/fDw7CsDcVm/ebvMaHIAUNmZ29VQpeM0TA9aysRvCV33D/4KfNwcMPtPoLTnBUgIQFC9zA34cRbv6QpfW6MohZnzrQFPkPkWrWlnX9bX9VzJi+ZnUOn+f9KU2FF5sBw9lWE4HMz/Fe79Ujs5pTD/vu5rI73ZrVRm7VyWI5RGxY2bkmEnNrbZInNldSplG5ZnDG3p735IJN2fPgddJuqMoR3sN/Ol5+KB5M90ogIhtZ0a2ARWUSAgsLYUr1PjCrBCPmFLejWRpRZaYs/8iOIGfFRatTSyiFouZDOLtRwPS/3e5zliy0ytb+fo06tHjDx3TpgxwEmQU3rCNTup4iTi6A3BBP0asTLMSHyofVXPgrLGKAdKSmfjJ8W/7ieyCBnmZBAOmHj0sa2BpPQL9acKqDr4g5N0GfbnrhSLcGthqwgb4EDJPhQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5140eda-5329-46cc-9184-08d85fa9127d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:11:43.9924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zne+yN57yLK2ZyKb1bUIj68IH/RFbXqiKSp1GhDApqxywxBbZAJ6Yj+s758wYDab5RpPXS0/4nlThfAgQsWvxA==
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
