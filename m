Return-Path: <SRS0=qGVY=DL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F7DC46466
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF75C20691
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="inX7CEBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF75C20691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9919E84E7C;
	Sun,  4 Oct 2020 01:42:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lc5RWLbPxp9U; Sun,  4 Oct 2020 01:42:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A519785475;
	Sun,  4 Oct 2020 01:42:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89C0BC0889;
	Sun,  4 Oct 2020 01:42:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E333C0051
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F10118640E
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SqIPpoK33515 for <iommu@lists.linux-foundation.org>;
 Sun,  4 Oct 2020 01:42:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7B0FA863D0
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9NRiq7YyvCWenZlpjOEtZ8vCKT2gpXNnCJaktynhDRc1PFZ6M8S146MKGqa+D/SwpNSIiZg8cUywsTDyxfiNxNpd+twiMAr2IqV1nT8dliFQp0MX+eriR3kiY9Z4LrfxTeZQ2pg6colY7Ev1FZkEAheiXXPr6RSmGXmJEiaAXLiR4BoJt8TFPuZgyXXqSfIXyeSrSntAgVKBPqDOCtBIh7U01jGXXteVsZMZVTL1pO2u+eO5Dk66FDQdmp2WuQ1B0lktxySRFGf7we5mmvf6D9Ggh7khBIA6LqAIxP+38pNeXqK7Z5GROpQ0mBEOI6u/3SYxrsp8SnRuOhaHMJoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBUlJobXxVu8OLx8dZsueuEJKoJHDViOVdl1vp4LHoI=;
 b=EWFhGJImnXqxY/OpEUXS7lVdWo28rFTnx199/XoPgUI+ZHvwQ5vYfnIY7m3wg0PR39NWfdoRop6nVfc4LzVLtrLoe2bqEp/Df5/Z0xB1JfPxwCDl8v/Opuc2yFIJ+XhNV3uoC7n3YYsit7RwyBZWyJ7lctqvGBuRPkstNXMbIcUQDbYHMSGJhutCCjX6a0on0dO92a8n9PiNEUTp/dEScMi1/O9BkQYSFXjfTqEAS8y5HoSbjVwoy89tJCPJB80PfincwQJiHNDa1KhRijWTl2faa8Dl0hFzoICtdc5iX2CjbK6w9H5bDVVxTji5FLR8F+guBoCRHY2VgexmOAIm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBUlJobXxVu8OLx8dZsueuEJKoJHDViOVdl1vp4LHoI=;
 b=inX7CEBziqfro7SYebgO4HBOwZdMGsdT4oo6BhFgvDJ0CPc5s5j0jIGdAEFxPhruS9Zj+uzNVzNYVzK+R35vaEXbXhfNPQP2L4COnVEVL8LYvbnV7M/cvfsv4AvoRe+vsBoCosxI3Tpi4TZU2IwL3TqCNi++FXLCUrzwvtn3Iv8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:42:03 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:42:03 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 10/14] iommu/amd: Refactor fetch_pte to use struct
 amd_io_pgtable
Date: Sun,  4 Oct 2020 01:45:45 +0000
Message-Id: <20201004014549.16065-11-suravee.suthikulpanit@amd.com>
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
 Transport; Sun, 4 Oct 2020 01:42:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 021aa64f-bc80-4d90-33d4-08d86806b16f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB145114DAB31FC4317060318DF30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bx3TGLrIu/DKOqZ3ZxOjZd6+FjsxTIgnpy9VYv1MwqBghBjZlpy+Dcoqx2DNIT5SF7Ksa/9XWzf3SlquDMlHmHJlQBkg+jk8dBrfnveXIXUrkI36dr0zIGoXmanD1vZNzAv7mYCFmc0VCovctEyGd5TbaPVVok1OuLencpRP5dMILY+BDpjKlOU+wxNR3EogaLFHJrZR8d7jG4FHmgo2y7YWvkf5+lEH1OYIQMvSUhlbjv7YSiKWBXf3Yziv2L2ok9Pt1ggb5bzpZKACYo74kqVXG0YpdP4Ma63I40ks2bDWha2wTg7t5wIvjCNmL2bUljcePCF+r3BJn+LRnhF6Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: q+Z8n2/wNtqKv200zGz9pWZIU/zL4W/+C9ziiA5nnDx+gCRdkG1GedHIxSs4tPOVvGh9q9ilRipVBD3s9eRxUjF/nMXZKGZIM2p5mcvzY3BYnDxVMWLpu/ofLBsTcV7oZrlsqpksJkcapLGuqNDC+tRd+XsHizUpzzmiGIY8mYxEjHpcxV2vuNc5K+7+7aK7QvxfQOEWvNR7+HCtRctV20vewvDikcR4W4brXK8GtZ015eMrFR3B3jqTjjk9Q8ABom4pQKVTGNHqS+RIcMA69MQ9FrTm+J5VyPA5Iy/pEzjwVhjaJAOit06Ve4UP8uTiDtOw6IvVE1O5v8hr0PAXY5CwNWfX7leJRnILLkW/dZszML58/36dgvj1MuZ7yH9q11dHWq/JkcwioX0oCOaRSNX5m39XDKq6g3usLnDEUQrSZSi3gCRDyYUzV4LM9/JbmuDzJ63UrJeZYtA1qNOFA/vWHqyTjdoBT6zEq4lebGxMqGm2Bgzr4qK3eZ7WvsuUHAf0znvh3sGNxGVXIZWCF/M4E8sgHIrb+LL0IMydjJKd9kmxnxnF9K8BEIMNokHfFn8FGM4JdffDU/JG85BpdY4aCcQET/8ychxhfXdHSpMsVRdpgkocrJkQvW1M0rk2FYTPMhoB7/XiIConsKKNMA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021aa64f-bc80-4d90-33d4-08d86806b16f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:42:03.2860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6QO50mRb3RUH893Zf4ifEmRUdvqzpseT2PmQa57fzsel+4u3EaZJaOTqEKeGuK69oocMKtOtmPvgTrsqW4nxw==
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

To simplify the fetch_pte function. There is no functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  |  2 +-
 drivers/iommu/amd/io_pgtable.c | 13 +++++++------
 drivers/iommu/amd/iommu.c      |  4 +++-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2059e64fdc53..69996e57fae2 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -134,7 +134,7 @@ extern int iommu_map_page(struct protection_domain *dom,
 extern unsigned long iommu_unmap_page(struct protection_domain *dom,
 				      unsigned long bus_addr,
 				      unsigned long page_size);
-extern u64 *fetch_pte(struct protection_domain *domain,
+extern u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 		      unsigned long address,
 		      unsigned long *page_size);
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 989db64a89a7..93ff8cb452ed 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -317,7 +317,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
  * This function checks if there is a PTE for a given dma address. If
  * there is one, it returns the pointer to it.
  */
-u64 *fetch_pte(struct protection_domain *domain,
+u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 	       unsigned long address,
 	       unsigned long *page_size)
 {
@@ -326,11 +326,11 @@ u64 *fetch_pte(struct protection_domain *domain,
 
 	*page_size = 0;
 
-	if (address > PM_LEVEL_SIZE(domain->iop.mode))
+	if (address > PM_LEVEL_SIZE(pgtable->mode))
 		return NULL;
 
-	level	   =  domain->iop.mode - 1;
-	pte	   = &domain->iop.root[PM_LEVEL_INDEX(level, address)];
+	level	   =  pgtable->mode - 1;
+	pte	   = &pgtable->root[PM_LEVEL_INDEX(level, address)];
 	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
 
 	while (level > 0) {
@@ -465,6 +465,8 @@ unsigned long iommu_unmap_page(struct protection_domain *dom,
 			       unsigned long iova,
 			       unsigned long size)
 {
+	struct io_pgtable_ops *ops = &dom->iop.iop.ops;
+	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
 	unsigned long long unmapped;
 	unsigned long unmap_size;
 	u64 *pte;
@@ -474,8 +476,7 @@ unsigned long iommu_unmap_page(struct protection_domain *dom,
 	unmapped = 0;
 
 	while (unmapped < size) {
-		pte = fetch_pte(dom, iova, &unmap_size);
-
+		pte = fetch_pte(pgtable, iova, &unmap_size);
 		if (pte) {
 			int i, count;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3f6ede1e572c..87cea1cde414 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2078,13 +2078,15 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
 					  dma_addr_t iova)
 {
 	struct protection_domain *domain = to_pdomain(dom);
+	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
+	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
 	unsigned long offset_mask, pte_pgsize;
 	u64 *pte, __pte;
 
 	if (domain->iop.mode == PAGE_MODE_NONE)
 		return iova;
 
-	pte = fetch_pte(domain, iova, &pte_pgsize);
+	pte = fetch_pte(pgtable, iova, &pte_pgsize);
 
 	if (!pte || !IOMMU_PTE_PRESENT(*pte))
 		return 0;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
