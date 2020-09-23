Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15482C4727F
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:12:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8202076E
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 10:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kbI/OvN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8202076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7F642228E7;
	Wed, 23 Sep 2020 10:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SrZroQY71tFj; Wed, 23 Sep 2020 10:11:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A890620411;
	Wed, 23 Sep 2020 10:11:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A090AC0859;
	Wed, 23 Sep 2020 10:11:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC420C0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A8AB1866FE
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 68ReMyi7xIFX for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 10:11:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5243B85EF9
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 10:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSFq1Djang+MMztHXsh5GSNNcE41CbItJJGS/Uh/HrO7QsIxzm3tAGkE0gVPYPsEaEOcJquBCosERYApKxmNtmj5y2V6OC51ix6ZVmEQwaZYbzsZ45jgkTwQlrmzIfNnYnMgLEgR9egQAVG/o6dXgYg2vwKWv5CtdWTUt/xLSIqcSdjLL2LSYZ/eEjjTpwMuMCWfwK9rpqEAQNUr9eIvggfrEI3KtBlOIQOqdC3j47IUB7nIH+5B5jDOS694tecaTlWdW9yUPIWM57ejezRQ/oUx+2BNYJRp9IORQTcPDorSg1SOvjFwtLiZ1wlPeXB+T5D6wE7hOnChK+YQOyaPuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV7RMGasH+xkhZAIPlauSZxlshOgJaF1s60QlDnw+Tg=;
 b=SYqm1RQ5u8ivHr+rDARR67xAeSlgVx5R5dRw+u2kYcuLTSA8ntDfy8v9adjTqMgiNrhTZt80wOSKiru2qafDRD1T2h1rmNmBQ007eMtleaf2a2/UWMx7KSO3gFGn8yl/GK681ApSjOZ6uNMSbzOyKhBjr+i0F7SPHjoMY7Qeh89TcIWiSS277qUb3ZR5/9vpCqwClikpNFhxIVOs2kiNfUQhMSPaUMZ6joDW4JZ0+ZJyIes/d7+D+SkiwVFSgjYTnvZdLR53V4enAyA2DnQSG2Hq1fzGgJThJ9Y72YmlWxZUfC1WMqL1xgUarmbj8xAthfJajm+YAAbr+cAWngK5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV7RMGasH+xkhZAIPlauSZxlshOgJaF1s60QlDnw+Tg=;
 b=kbI/OvN0hbxV6FtGIfOGtde1hqKyX62vGcMpLrGozqgEWEHg39MA+WVw4vVUix60Rds64R1ywApyfkI8iAqqMGJPa7ylA5zqsvPRBe4C9l2Hw9iKPAbm3ggwV46w5wIGlbj1QACkJgm1RQtXlxC+It8YQjMi5Rhs9AbIQLhEriM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 23 Sep 2020 10:11:50 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 10:11:50 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 09/13] iommu: amd: Rename variables to be consistent with
 struct io_pgtable_ops
Date: Wed, 23 Sep 2020 10:14:38 +0000
Message-Id: <20200923101442.73157-10-suravee.suthikulpanit@amd.com>
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
 Transport; Wed, 23 Sep 2020 10:11:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7ca3353-a081-431a-29ce-08d85fa915e2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3466085EAAC0DF243FF582C0F3380@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:120;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Teu2HSvOiN0cbLBmyxZWc2jf/JKR6OQOJQFtdDWW6v3TFhCqk6MSwAIRSRk6pXiD5bfw5sTa9Mhy8K0eDvS6ZJKALnq75/Rk+omouOSBSR6QxZ3Vx6lTeHHo7HqWyOJFPKPOf3MjWMNF2SmvROAhaygaGXrLyCcpHBR4qTk7kNuSxiaG/8ODzbLIwl5kNVDIiVXus+4YC3TVQITlHMRVLnLB9e6P/asHrKN5KCxg+MFtXYbE8Eoi5Fsxyr6IkM+Q8cmAFI+cgaMpRJqLEEd746eVjHtKyF/gY4DZ08ovHq+WTI72kEBdVX4ddsYIB8giKPcoTp461x/sd9OwuCTZ6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(44832011)(5660300002)(66946007)(66476007)(66556008)(83380400001)(6486002)(86362001)(36756003)(2906002)(8936002)(4326008)(26005)(316002)(1076003)(956004)(478600001)(6666004)(186003)(16526019)(52116002)(8676002)(2616005)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kJ7tJvxkc/iK3DD+UP/ltTGPa/yDjxoQtIF/StaV9ZFJTYrhCiKp74PUVroKNOF8UlJ9lDvW1x6PrV8pICbWb79IsdY/7Aw9y1TpObAFtJpe7gngEpKN0V9B1VWlSfpvIOD3vIxhVifZxPgRhClqdswhn9bjE4uEq84Cmz03k0e2zj7SA/48w7HM7j+VD/BvnRPQL0j8OwwYBdEN4WqQEfXyG15Z8KHb6GYfAeRxlwkm4HIbssbnOzXQSvX3GR1BQBrR5e2x6YVtQh1KLh41zLsiS0puQW5JGPSlOC2JMms1DeXNrS/EYh4ehRki5eW7hfPln0D8w3QF39Cgxw5VLQn0QGooCZn+ioAQDY5yLBeelysWswJZXIDo3QcHJU1dAFdwbw7cWGDHdUvKFI34wYnVFBWXqlKTq0n/XDDiYbkjbkKGibOh7PR4EEHMc0qQiTQ5Gs9qLRRbXhCRW33GUkjTQE5AAUqL9GzE3/pwEUByYV9NWorpIoN3e0p1QizDsl8HVGP/gxbOFoAKorBi3JKInfwMYUQTOKpATaOir5Zfk+JVOX7vqWXeczl1yvW1YL7b0LrG6Nlm3ZTcJ54byBef6PIIbuAD84vq1nzbTeoJHExg04+VkZxWxY/NbNer1Em0LF21vwcVHbHGc/FPYA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ca3353-a081-431a-29ce-08d85fa915e2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:11:49.7298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCEwHReZFm4fgizgN91nRasVHJhtPnoaMpl2P7NMgExH1mK5f1OvENB4j+ZZqcGkyDCkdVpYT9jJF0wkKx7YvQ==
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

There is no functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/io_pgtable.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 524c5406ccd6..5da5ce98b7b3 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -424,9 +424,9 @@ static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
  * and full 64 bit address spaces.
  */
 int iommu_map_page(struct protection_domain *dom,
-		   unsigned long bus_addr,
-		   unsigned long phys_addr,
-		   unsigned long page_size,
+		   unsigned long iova,
+		   unsigned long paddr,
+		   unsigned long size,
 		   int prot,
 		   gfp_t gfp)
 {
@@ -435,15 +435,15 @@ int iommu_map_page(struct protection_domain *dom,
 	u64 __pte, *pte;
 	int ret, i, count;
 
-	BUG_ON(!IS_ALIGNED(bus_addr, page_size));
-	BUG_ON(!IS_ALIGNED(phys_addr, page_size));
+	BUG_ON(!IS_ALIGNED(iova, size));
+	BUG_ON(!IS_ALIGNED(paddr, size));
 
 	ret = -EINVAL;
 	if (!(prot & IOMMU_PROT_MASK))
 		goto out;
 
-	count = PAGE_SIZE_PTE_COUNT(page_size);
-	pte   = alloc_pte(dom, bus_addr, page_size, NULL, gfp, &updated);
+	count = PAGE_SIZE_PTE_COUNT(size);
+	pte   = alloc_pte(dom, iova, size, NULL, gfp, &updated);
 
 	ret = -ENOMEM;
 	if (!pte)
@@ -456,10 +456,10 @@ int iommu_map_page(struct protection_domain *dom,
 		updated = true;
 
 	if (count > 1) {
-		__pte = PAGE_SIZE_PTE(__sme_set(phys_addr), page_size);
+		__pte = PAGE_SIZE_PTE(__sme_set(paddr), size);
 		__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
 	} else
-		__pte = __sme_set(phys_addr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
+		__pte = __sme_set(paddr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
 
 	if (prot & IOMMU_PROT_IR)
 		__pte |= IOMMU_PTE_IR;
@@ -493,20 +493,19 @@ int iommu_map_page(struct protection_domain *dom,
 }
 
 unsigned long iommu_unmap_page(struct protection_domain *dom,
-			       unsigned long bus_addr,
-			       unsigned long page_size)
+			       unsigned long iova,
+			       unsigned long size)
 {
 	unsigned long long unmapped;
 	unsigned long unmap_size;
 	u64 *pte;
 
-	BUG_ON(!is_power_of_2(page_size));
+	BUG_ON(!is_power_of_2(size));
 
 	unmapped = 0;
 
-	while (unmapped < page_size) {
-
-		pte = fetch_pte(dom, bus_addr, &unmap_size);
+	while (unmapped < size) {
+		pte = fetch_pte(dom, iova, &unmap_size);
 
 		if (pte) {
 			int i, count;
@@ -516,7 +515,7 @@ unsigned long iommu_unmap_page(struct protection_domain *dom,
 				pte[i] = 0ULL;
 		}
 
-		bus_addr  = (bus_addr & ~(unmap_size - 1)) + unmap_size;
+		iova = (iova & ~(unmap_size - 1)) + unmap_size;
 		unmapped += unmap_size;
 	}
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
