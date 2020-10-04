Return-Path: <SRS0=qGVY=DL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D51C4741F
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0218206B6
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A/ab5qc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0218206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8FBC087077;
	Sun,  4 Oct 2020 01:42:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cWP4rWYsT7ft; Sun,  4 Oct 2020 01:42:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C7A1F87058;
	Sun,  4 Oct 2020 01:42:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA5AFC0889;
	Sun,  4 Oct 2020 01:42:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 240E1C0889
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A589B20412
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OaufcgY6ykPc for <iommu@lists.linux-foundation.org>;
 Sun,  4 Oct 2020 01:42:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by silver.osuosl.org (Postfix) with ESMTPS id DCEEA20349
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzCD7SfSziL1xB9F9RHwpV7vV4jVxTxaJAx1s4/j+hgoDbhS6/iRJyoVsk4GTbrx+XxLzXGGw3GIxSdLjrvRq2i9W96bnrxG7oV4Dbhn0QXoypu7Ko3oC4hBqKJFDThkp0OU4WcOrEeoGfibfSmaJmG4HDGIN1ut7UBv3/pZwMhoL1L/Hq/A4DpfdnLrmeNC5PZwUkMZic0ong32hp+wlQe5V2lZ6tzrcE8KU5dlWRLDixGQIK+w1IfdsLNDodkXILLj0/HsCGnANAICUS44gugaZH5mfd2zT00g82MDwgmoF6lGIHQ858xwrX2t+LkOpw/kXCI6skEWju6hTz3tjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8Vj5RrMhQ4eQ9EsaPWoiDZDCk7ErYSNcBpa55eU2D4=;
 b=cEBZL/mVHN1IVdJvisIZQWon11irjDmqarzcUUpW3Ff62TuG45Awg6gRe2GwUcJc/s2lCWszLl6DIj0KQW45unTaWbF9EcNTmmDgL2n+kjzVN8AKpz3au5RVQa9ZSuU2DviOtbCGZcONs68jzJVixGsYIQ1pb56SVLB8xM24fOtPXvDFYcgxqa6OwlYmuvQFl1Pf1ATl+m4svNt5eoMalgzQ1Y9OJTJQAlGxCg2r6KRNcG41vyhIVDvS/Wau8jq67B14KzbVr7lAP21Rq38oo16w+6uj0iW9QpaVOyXAC19cSqc3kfnf02TFgZo+BbVq0rRDWuo2skRF1hVOgb0vCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8Vj5RrMhQ4eQ9EsaPWoiDZDCk7ErYSNcBpa55eU2D4=;
 b=A/ab5qc14yqv2sAIJ/wpl84NYJSKLjmkOCfucL909OTdU0YDkKp7IzHZZwycmdpxu+Rn3V3irZV72lbrC5xZptQDVJsKoAu5daIZwoWW4H2qOuKwQR6S7ERC6D8OiCIPJUSVU81o5C7x3YWVR7eqnAaSYexKk7O1OHe7jbUw9r4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:42:06 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:42:06 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 13/14] iommu/amd: Introduce IOMMU flush callbacks
Date: Sun,  4 Oct 2020 01:45:48 +0000
Message-Id: <20201004014549.16065-14-suravee.suthikulpanit@amd.com>
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
 Transport; Sun, 4 Oct 2020 01:42:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 732d38d4-f6e8-42e1-4e57-08d86806b341
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1451B31DEA638DF9CE3747A6F30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5vfgYqnvb6CAW4IbRR0j3UOp1hboLdifZtr4vnas9Ta2eK/lXEj2wg0YdtH3dehPz/TImeca6sUdnz8bs584yPc4cy3yoGv/dVi04T60AUAP48ouNAzPSzQmLfOpOdlHguRJy4+U2sfrhJO9RyB7uH/k4C+uCu/eqT2EnRMVl0KuiAz2xydIrR7qtyLtZAk1CRiKwZ6tsGhJcQJgtD4Q0Lnx1ctKNv0jcjb3TLYgVb1tNAUcZyklY6Of5U3XGm0sI20YENKbhp/HEfTOTolT7e90Xi/amd1zTSoYm3/4dqLyNk0yTFSz79UeA0tjQ38JeVyrqs3ORm3dnCwbOsbgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xK1EZ06Sqt4JrJ3LTw5n50KoYjcOosqYngvGK6hnRXSkyc/6yXRl0malJVf+VO8glWvgSmQe8qYG1yk/SOQ/bKPX5M/Gb4aUyR2CIYz5bOnmXuX3SWMLQWsr4UcrpJbXfC3wQS5f13T3dO1xdMdoH67VcAPFQMfNqluRRsuViRheCCPQZraVeCW4zSjNrRDP/HvJczZDi707tzQ9pOXkKWXCMHbPPc8NyqrbwwouCFpP7LDJvJHOxojQ4+UOrWHKKTRnLzKKspzs0hkF1RM6hDQLx83XJdycE1xAW4Y7nEa/JUi2xCCvIDewfHHfZu6vrWokBhgmO9E7lXCAjrhhM4N+R9JMv6Bs45hu2Yl0ljc6PeNkwCSSVvthKZahiFsd1ujZvyALUAQNjNdE/a2f9XTrpXi84m06Ku4klYEFdnkOJaQYXvMtiNQVxx3PXxtzEBQKzFQqlyLKkZau8ZG8W06LO83sTASjz+zJrUtd3bH9KcmNfrTwrMbnjrtzJG+WDipK8YK5Un6IsVo8zNdknSPBX13FdocGSOjXwwVa7IFuPRTdz11rYOlaolw9srkrg230Q7wl/v9TKqoJOO3zQQiLTLj8nlHD9LiGAafZyiek3Vnhp6nPJ09MXBGaWtDSPL3eOsWoYBZmSa0dE54UQw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732d38d4-f6e8-42e1-4e57-08d86806b341
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:42:06.2407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZroTXfUQKC7zuBSof0zyjUKyoP0CeDC4x7g/evEyVTQn+P6I00nomenO+r23VNJ6y/jEILVTV8NpCHJ6s1Klg==
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

Add TLB flush callback functions, which are used by the IO
page table framework.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/io_pgtable.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index d8b329aa0bb2..3c2faa47ea5d 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -514,6 +514,33 @@ static phys_addr_t iommu_v1_iova_to_phys(struct io_pgtable_ops *ops, unsigned lo
 /*
  * ----------------------------------------------------
  */
+static void v1_tlb_flush_all(void *cookie)
+{
+}
+
+static void v1_tlb_flush_walk(unsigned long iova, size_t size,
+				  size_t granule, void *cookie)
+{
+}
+
+static void v1_tlb_flush_leaf(unsigned long iova, size_t size,
+				  size_t granule, void *cookie)
+{
+}
+
+static void v1_tlb_add_page(struct iommu_iotlb_gather *gather,
+					 unsigned long iova, size_t granule,
+					 void *cookie)
+{
+}
+
+const struct iommu_flush_ops v1_flush_ops = {
+	.tlb_flush_all	= v1_tlb_flush_all,
+	.tlb_flush_walk = v1_tlb_flush_walk,
+	.tlb_flush_leaf = v1_tlb_flush_leaf,
+	.tlb_add_page	= v1_tlb_add_page,
+};
+
 static void v1_free_pgtable(struct io_pgtable *iop)
 {
 }
@@ -526,6 +553,8 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	pgtable->iop.ops.unmap        = iommu_v1_unmap_page;
 	pgtable->iop.ops.iova_to_phys = iommu_v1_iova_to_phys;
 
+	cfg->tlb = &v1_flush_ops;
+
 	return &pgtable->iop;
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
