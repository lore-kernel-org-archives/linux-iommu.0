Return-Path: <SRS0=qGVY=DL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD8CC47420
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14A9206B8
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Wq+tR4zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14A9206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B698085550;
	Sun,  4 Oct 2020 01:42:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IJNbuTQF93eh; Sun,  4 Oct 2020 01:42:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8F2FD8551F;
	Sun,  4 Oct 2020 01:42:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7727BC0890;
	Sun,  4 Oct 2020 01:42:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62897C0051
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5E75C863D9
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aa2NLxAwt1Ie for <iommu@lists.linux-foundation.org>;
 Sun,  4 Oct 2020 01:42:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1AA3686388
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hme0ti5qK9NTSjQwoqXloEevIZBufOZnWKkUD6SSqcxXPUsfp+RjtNHfgDmyKrl08JvJLYfZHZtSBKTC8sHzRqTDHhsm5sj3sXBlB/vSkt6SDHToypqmY7X28R8lJpqAmmBi3oK4R/f7+hlAx074FefSS3KRmCOuq4QLhfc55Ms4lpmC98LPj4HBjFPJDtBFn17VXNcuxJmX0/BlD2ynn1l74hGV4fQUZCxZswhcDQgi8AEJDPMsMJxDcEsRoMh9ABvaU3STPMxHwTDJSK2HOQ/ox4cj7zDoma5wYn5EnCNlB1pVU3KZ77MsU4zJLbCYXHyZtpXQ8RkAzAiglQ6SAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JznXSzWNgm+vVD9CENgtzG9c0Ld58bA+ljNrILOVock=;
 b=D8FYTlErtMQYx7MVUqFFKoz3zEKOLpTQiYC+GrrlZCJWOMmZhBry1eCD3JWzdfg2Vre3+vqSayTD618SHpfkcBO94ZZiGJtOzQ/+MJ67SNBxXWyTYFk74bqhRM/2YPmrJM8Cupxo+qOtnKezln+Z8Z04HnDf/cB1btqdbQ9r7B1Zq/WTH7TX7SgWyVrQkUOCcN+xOsFoGKY4bNsFE1Hc0QMP/J7BSGC6vQoalRIk4t9qTuZZ7zoM+zFKenn0kBthn2YhnZUwMGsYjzDaanBIPfgLocjXUt2UO/E9bvAul8/1N56O8r8JYXQGqc18sSYkWJpOoODw6TpE/989laExlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JznXSzWNgm+vVD9CENgtzG9c0Ld58bA+ljNrILOVock=;
 b=Wq+tR4zuw8ObDxCAJ1c82txRh30fR9DbJ0UTuvGeaxPBru8O5Vaxewzie181glSdNXVnBEdlOp7TBl0q4/ld6vrf3Py3yLvOnMhgdI0QPpfqeFxTc0hgkXwCYO/GeP1WMLZeIYIhK4jA2o9W+h860ZsOmQ++Q7DGdGlAQDHkhvo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:41:59 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:41:59 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 06/14] iommu/amd: Move IO page table related functions
Date: Sun,  4 Oct 2020 01:45:41 +0000
Message-Id: <20201004014549.16065-7-suravee.suthikulpanit@amd.com>
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
 Transport; Sun, 4 Oct 2020 01:41:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a80e2b9-8742-4a4a-257f-08d86806aec3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB145145804C7969F968382F00F30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8uykGWg8u+VEILCfHiQSQPuUhBe5opRGVwo+HI0o+ZLUKuckM7IGnaq/nOn7mhG+Cwj1plIhODRFdHUMFrUq7knnfEWsbJw9MoIVYN/v+JuGlvKOClCAAR88Z1eDbOIH0m27wJ3xv5cXt24D4RcJqYRy5y9W8oDD+q8v8JQe9ZbmI//PgZ6FQq2Shznt/DQwsEqakVKBSuzAq9RSrjUJvfyswKDyq/DLmh6FBzKbbDUy7E4O48qyKrOLn0K3+sKgEDk2vaBGIIhkdiDmCSfPW6rrd0OmjtDLGXhAj2adDHUEH34M4EQDb2yHl1jEsb2tIeOp9KDX1Dyj+PzA8u8xrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(30864003)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: D5B3KSlwlhRxENaDz5pToiAc9KPR3uiMnUGEBmj82GU3oym0oO+u6toQDA0z3Uq1iewJf8DyIaai6uDTN8hIiQhcfR4xv7eeSQ9Gmr4oROqGWccbtmWTpnFHa3maMqkOrjJFMOvqW4QnJe206RyoHvxeiz/q2zoByHvfpLl4ui+3kskSLlHl0ulVSyr1dvRMh2XKLBy2spDN/6Z/XB6gas/odF9kdOpgc4PTtrAcM9xu9jQH4sR9/1SkoQ0JQYs/LJqeI5a1noJNS+rPG/GwlpFjnrqf5n7wmMo1Ljl+6FlWM9XbxZ362q9mddDG2b+puGBUOeRbAa7ZqqzFzUIeYidgmVHYDJXGv8YbcNzUc6/cmDfxt7lYKkwNdQdRGkLdEWMmBEMfnEQ2917HWY/S+bu6kngZPQfCOR6pNzulwQXC1zZfVKMBwiMem4C5lj/jHt1gQ0A/7pP5gt1RpbfgLogEGIsLtCsqfEX8msCZhJ6Uj22LTIgAMR6RarT9X13UmSxOtwfrJd2VTFLhaxhmBUwcaU0Cg8YHDY4ZT6hjl6Jh5Gw/k2z8o6KwskUQFBYLrbmxse2s93qg0gd6KdhP/l11Jr6eQGo4aZpleLdRjy6W3f8M5XjDr8kwnRq9D8M5GTDOHTPJzNPlDj3wYDVluA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a80e2b9-8742-4a4a-257f-08d86806aec3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:41:58.5991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHy8amCQVdux5h8w3lToaVi0dl+6WDh9S7imkcfcjNBudixGFjbGyTkWSvbLJc6PsNgIVoHlH3ZkN0nv+EBtKQ==
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

Preparing to migrate to use IO page table framework.
There is no functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  |  18 ++
 drivers/iommu/amd/io_pgtable.c | 473 ++++++++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c      | 476 +--------------------------------
 3 files changed, 493 insertions(+), 474 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 8b7be9171030..ee7ff4d827e1 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -122,4 +122,22 @@ void amd_iommu_apply_ivrs_quirks(void);
 static inline void amd_iommu_apply_ivrs_quirks(void) { }
 #endif
 
+/* TODO: These are temporary and will be removed once fully transition */
+extern void free_pagetable(struct domain_pgtable *pgtable);
+extern int iommu_map_page(struct protection_domain *dom,
+			  unsigned long bus_addr,
+			  unsigned long phys_addr,
+			  unsigned long page_size,
+			  int prot,
+			  gfp_t gfp);
+extern unsigned long iommu_unmap_page(struct protection_domain *dom,
+				      unsigned long bus_addr,
+				      unsigned long page_size);
+extern u64 *fetch_pte(struct protection_domain *domain,
+		      unsigned long address,
+		      unsigned long *page_size);
+extern void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
+					 struct domain_pgtable *pgtable);
+extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
+					 u64 *root, int mode);
 #endif
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 6b2de9e467d9..c11355afe624 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -23,6 +23,479 @@
 #include "amd_iommu_types.h"
 #include "amd_iommu.h"
 
+/*
+ * Helper function to get the first pte of a large mapping
+ */
+static u64 *first_pte_l7(u64 *pte, unsigned long *page_size,
+			 unsigned long *count)
+{
+	unsigned long pte_mask, pg_size, cnt;
+	u64 *fpte;
+
+	pg_size  = PTE_PAGE_SIZE(*pte);
+	cnt      = PAGE_SIZE_PTE_COUNT(pg_size);
+	pte_mask = ~((cnt << 3) - 1);
+	fpte     = (u64 *)(((unsigned long)pte) & pte_mask);
+
+	if (page_size)
+		*page_size = pg_size;
+
+	if (count)
+		*count = cnt;
+
+	return fpte;
+}
+
+/****************************************************************************
+ *
+ * The functions below are used the create the page table mappings for
+ * unity mapped regions.
+ *
+ ****************************************************************************/
+
+static void free_page_list(struct page *freelist)
+{
+	while (freelist != NULL) {
+		unsigned long p = (unsigned long)page_address(freelist);
+
+		freelist = freelist->freelist;
+		free_page(p);
+	}
+}
+
+static struct page *free_pt_page(unsigned long pt, struct page *freelist)
+{
+	struct page *p = virt_to_page((void *)pt);
+
+	p->freelist = freelist;
+
+	return p;
+}
+
+#define DEFINE_FREE_PT_FN(LVL, FN)						\
+static struct page *free_pt_##LVL (unsigned long __pt, struct page *freelist)	\
+{										\
+	unsigned long p;							\
+	u64 *pt;								\
+	int i;									\
+										\
+	pt = (u64 *)__pt;							\
+										\
+	for (i = 0; i < 512; ++i) {						\
+		/* PTE present? */						\
+		if (!IOMMU_PTE_PRESENT(pt[i]))					\
+			continue;						\
+										\
+		/* Large PTE? */						\
+		if (PM_PTE_LEVEL(pt[i]) == 0 ||					\
+		    PM_PTE_LEVEL(pt[i]) == 7)					\
+			continue;						\
+										\
+		p = (unsigned long)IOMMU_PTE_PAGE(pt[i]);			\
+		freelist = FN(p, freelist);					\
+	}									\
+										\
+	return free_pt_page((unsigned long)pt, freelist);			\
+}
+
+DEFINE_FREE_PT_FN(l2, free_pt_page)
+DEFINE_FREE_PT_FN(l3, free_pt_l2)
+DEFINE_FREE_PT_FN(l4, free_pt_l3)
+DEFINE_FREE_PT_FN(l5, free_pt_l4)
+DEFINE_FREE_PT_FN(l6, free_pt_l5)
+
+static struct page *free_sub_pt(unsigned long root, int mode,
+				struct page *freelist)
+{
+	switch (mode) {
+	case PAGE_MODE_NONE:
+	case PAGE_MODE_7_LEVEL:
+		break;
+	case PAGE_MODE_1_LEVEL:
+		freelist = free_pt_page(root, freelist);
+		break;
+	case PAGE_MODE_2_LEVEL:
+		freelist = free_pt_l2(root, freelist);
+		break;
+	case PAGE_MODE_3_LEVEL:
+		freelist = free_pt_l3(root, freelist);
+		break;
+	case PAGE_MODE_4_LEVEL:
+		freelist = free_pt_l4(root, freelist);
+		break;
+	case PAGE_MODE_5_LEVEL:
+		freelist = free_pt_l5(root, freelist);
+		break;
+	case PAGE_MODE_6_LEVEL:
+		freelist = free_pt_l6(root, freelist);
+		break;
+	default:
+		BUG();
+	}
+
+	return freelist;
+}
+
+void free_pagetable(struct domain_pgtable *pgtable)
+{
+	struct page *freelist = NULL;
+	unsigned long root;
+
+	if (pgtable->mode == PAGE_MODE_NONE)
+		return;
+
+	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
+	       pgtable->mode > PAGE_MODE_6_LEVEL);
+
+	root = (unsigned long)pgtable->root;
+	freelist = free_sub_pt(root, pgtable->mode, freelist);
+
+	free_page_list(freelist);
+}
+
+void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
+				  u64 *root, int mode)
+{
+	u64 pt_root;
+
+	/* lowest 3 bits encode pgtable mode */
+	pt_root = mode & 7;
+	pt_root |= (u64)root;
+
+	amd_iommu_domain_set_pt_root(domain, pt_root);
+}
+
+/*
+ * This function is used to add another level to an IO page table. Adding
+ * another level increases the size of the address space by 9 bits to a size up
+ * to 64 bits.
+ */
+static bool increase_address_space(struct protection_domain *domain,
+				   unsigned long address,
+				   gfp_t gfp)
+{
+	struct domain_pgtable pgtable;
+	unsigned long flags;
+	bool ret = true;
+	u64 *pte;
+
+	spin_lock_irqsave(&domain->lock, flags);
+
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+
+	if (address <= PM_LEVEL_SIZE(pgtable.mode))
+		goto out;
+
+	ret = false;
+	if (WARN_ON_ONCE(pgtable.mode == PAGE_MODE_6_LEVEL))
+		goto out;
+
+	pte = (void *)get_zeroed_page(gfp);
+	if (!pte)
+		goto out;
+
+	*pte = PM_LEVEL_PDE(pgtable.mode, iommu_virt_to_phys(pgtable.root));
+
+	pgtable.root  = pte;
+	pgtable.mode += 1;
+	amd_iommu_update_and_flush_device_table(domain);
+	amd_iommu_domain_flush_complete(domain);
+
+	/*
+	 * Device Table needs to be updated and flushed before the new root can
+	 * be published.
+	 */
+	amd_iommu_domain_set_pgtable(domain, pte, pgtable.mode);
+
+	ret = true;
+
+out:
+	spin_unlock_irqrestore(&domain->lock, flags);
+
+	return ret;
+}
+
+static u64 *alloc_pte(struct protection_domain *domain,
+		      unsigned long address,
+		      unsigned long page_size,
+		      u64 **pte_page,
+		      gfp_t gfp,
+		      bool *updated)
+{
+	struct domain_pgtable pgtable;
+	int level, end_lvl;
+	u64 *pte, *page;
+
+	BUG_ON(!is_power_of_2(page_size));
+
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+
+	while (address > PM_LEVEL_SIZE(pgtable.mode)) {
+		/*
+		 * Return an error if there is no memory to update the
+		 * page-table.
+		 */
+		if (!increase_address_space(domain, address, gfp))
+			return NULL;
+
+		/* Read new values to check if update was successful */
+		amd_iommu_domain_get_pgtable(domain, &pgtable);
+	}
+
+
+	level   = pgtable.mode - 1;
+	pte     = &pgtable.root[PM_LEVEL_INDEX(level, address)];
+	address = PAGE_SIZE_ALIGN(address, page_size);
+	end_lvl = PAGE_SIZE_LEVEL(page_size);
+
+	while (level > end_lvl) {
+		u64 __pte, __npte;
+		int pte_level;
+
+		__pte     = *pte;
+		pte_level = PM_PTE_LEVEL(__pte);
+
+		/*
+		 * If we replace a series of large PTEs, we need
+		 * to tear down all of them.
+		 */
+		if (IOMMU_PTE_PRESENT(__pte) &&
+		    pte_level == PAGE_MODE_7_LEVEL) {
+			unsigned long count, i;
+			u64 *lpte;
+
+			lpte = first_pte_l7(pte, NULL, &count);
+
+			/*
+			 * Unmap the replicated PTEs that still match the
+			 * original large mapping
+			 */
+			for (i = 0; i < count; ++i)
+				cmpxchg64(&lpte[i], __pte, 0ULL);
+
+			*updated = true;
+			continue;
+		}
+
+		if (!IOMMU_PTE_PRESENT(__pte) ||
+		    pte_level == PAGE_MODE_NONE) {
+			page = (u64 *)get_zeroed_page(gfp);
+
+			if (!page)
+				return NULL;
+
+			__npte = PM_LEVEL_PDE(level, iommu_virt_to_phys(page));
+
+			/* pte could have been changed somewhere. */
+			if (cmpxchg64(pte, __pte, __npte) != __pte)
+				free_page((unsigned long)page);
+			else if (IOMMU_PTE_PRESENT(__pte))
+				*updated = true;
+
+			continue;
+		}
+
+		/* No level skipping support yet */
+		if (pte_level != level)
+			return NULL;
+
+		level -= 1;
+
+		pte = IOMMU_PTE_PAGE(__pte);
+
+		if (pte_page && level == end_lvl)
+			*pte_page = pte;
+
+		pte = &pte[PM_LEVEL_INDEX(level, address)];
+	}
+
+	return pte;
+}
+
+/*
+ * This function checks if there is a PTE for a given dma address. If
+ * there is one, it returns the pointer to it.
+ */
+u64 *fetch_pte(struct protection_domain *domain,
+	       unsigned long address,
+	       unsigned long *page_size)
+{
+	struct domain_pgtable pgtable;
+	int level;
+	u64 *pte;
+
+	*page_size = 0;
+
+	amd_iommu_domain_get_pgtable(domain, &pgtable);
+
+	if (address > PM_LEVEL_SIZE(pgtable.mode))
+		return NULL;
+
+	level	   =  pgtable.mode - 1;
+	pte	   = &pgtable.root[PM_LEVEL_INDEX(level, address)];
+	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
+
+	while (level > 0) {
+
+		/* Not Present */
+		if (!IOMMU_PTE_PRESENT(*pte))
+			return NULL;
+
+		/* Large PTE */
+		if (PM_PTE_LEVEL(*pte) == 7 ||
+		    PM_PTE_LEVEL(*pte) == 0)
+			break;
+
+		/* No level skipping support yet */
+		if (PM_PTE_LEVEL(*pte) != level)
+			return NULL;
+
+		level -= 1;
+
+		/* Walk to the next level */
+		pte	   = IOMMU_PTE_PAGE(*pte);
+		pte	   = &pte[PM_LEVEL_INDEX(level, address)];
+		*page_size = PTE_LEVEL_PAGE_SIZE(level);
+	}
+
+	/*
+	 * If we have a series of large PTEs, make
+	 * sure to return a pointer to the first one.
+	 */
+	if (PM_PTE_LEVEL(*pte) == PAGE_MODE_7_LEVEL)
+		pte = first_pte_l7(pte, page_size, NULL);
+
+	return pte;
+}
+
+static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
+{
+	unsigned long pt;
+	int mode;
+
+	while (cmpxchg64(pte, pteval, 0) != pteval) {
+		pr_warn("AMD-Vi: IOMMU pte changed since we read it\n");
+		pteval = *pte;
+	}
+
+	if (!IOMMU_PTE_PRESENT(pteval))
+		return freelist;
+
+	pt   = (unsigned long)IOMMU_PTE_PAGE(pteval);
+	mode = IOMMU_PTE_MODE(pteval);
+
+	return free_sub_pt(pt, mode, freelist);
+}
+
+/*
+ * Generic mapping functions. It maps a physical address into a DMA
+ * address space. It allocates the page table pages if necessary.
+ * In the future it can be extended to a generic mapping function
+ * supporting all features of AMD IOMMU page tables like level skipping
+ * and full 64 bit address spaces.
+ */
+int iommu_map_page(struct protection_domain *dom,
+		   unsigned long bus_addr,
+		   unsigned long phys_addr,
+		   unsigned long page_size,
+		   int prot,
+		   gfp_t gfp)
+{
+	struct page *freelist = NULL;
+	bool updated = false;
+	u64 __pte, *pte;
+	int ret, i, count;
+
+	BUG_ON(!IS_ALIGNED(bus_addr, page_size));
+	BUG_ON(!IS_ALIGNED(phys_addr, page_size));
+
+	ret = -EINVAL;
+	if (!(prot & IOMMU_PROT_MASK))
+		goto out;
+
+	count = PAGE_SIZE_PTE_COUNT(page_size);
+	pte   = alloc_pte(dom, bus_addr, page_size, NULL, gfp, &updated);
+
+	ret = -ENOMEM;
+	if (!pte)
+		goto out;
+
+	for (i = 0; i < count; ++i)
+		freelist = free_clear_pte(&pte[i], pte[i], freelist);
+
+	if (freelist != NULL)
+		updated = true;
+
+	if (count > 1) {
+		__pte = PAGE_SIZE_PTE(__sme_set(phys_addr), page_size);
+		__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
+	} else
+		__pte = __sme_set(phys_addr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
+
+	if (prot & IOMMU_PROT_IR)
+		__pte |= IOMMU_PTE_IR;
+	if (prot & IOMMU_PROT_IW)
+		__pte |= IOMMU_PTE_IW;
+
+	for (i = 0; i < count; ++i)
+		pte[i] = __pte;
+
+	ret = 0;
+
+out:
+	if (updated) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&dom->lock, flags);
+		/*
+		 * Flush domain TLB(s) and wait for completion. Any Device-Table
+		 * Updates and flushing already happened in
+		 * increase_address_space().
+		 */
+		amd_iommu_domain_flush_tlb_pde(dom);
+		amd_iommu_domain_flush_complete(dom);
+		spin_unlock_irqrestore(&dom->lock, flags);
+	}
+
+	/* Everything flushed out, free pages now */
+	free_page_list(freelist);
+
+	return ret;
+}
+
+unsigned long iommu_unmap_page(struct protection_domain *dom,
+			       unsigned long bus_addr,
+			       unsigned long page_size)
+{
+	unsigned long long unmapped;
+	unsigned long unmap_size;
+	u64 *pte;
+
+	BUG_ON(!is_power_of_2(page_size));
+
+	unmapped = 0;
+
+	while (unmapped < page_size) {
+
+		pte = fetch_pte(dom, bus_addr, &unmap_size);
+
+		if (pte) {
+			int i, count;
+
+			count = PAGE_SIZE_PTE_COUNT(unmap_size);
+			for (i = 0; i < count; i++)
+				pte[i] = 0ULL;
+		}
+
+		bus_addr  = (bus_addr & ~(unmap_size - 1)) + unmap_size;
+		unmapped += unmap_size;
+	}
+
+	BUG_ON(unmapped && !is_power_of_2(unmapped));
+
+	return unmapped;
+}
+
 /*
  * ----------------------------------------------------
  */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f91f35edb7ba..4d65f64236b6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -140,8 +140,8 @@ static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 	return container_of(dom, struct protection_domain, domain);
 }
 
-static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
-					 struct domain_pgtable *pgtable)
+void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
+				  struct domain_pgtable *pgtable)
 {
 	u64 pt_root = atomic64_read(&domain->iop.pt_root);
 
@@ -149,18 +149,6 @@ static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
 	pgtable->mode = pt_root & 7; /* lowest 3 bits encode pgtable mode */
 }
 
-static void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
-					 u64 *root, int mode)
-{
-	u64 pt_root;
-
-	/* lowest 3 bits encode pgtable mode */
-	pt_root = mode & 7;
-	pt_root |= (u64)root;
-
-	amd_iommu_domain_set_pt_root(domain, pt_root);
-}
-
 static struct iommu_dev_data *alloc_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
@@ -416,29 +404,6 @@ static void amd_iommu_uninit_device(struct device *dev)
 	 */
 }
 
-/*
- * Helper function to get the first pte of a large mapping
- */
-static u64 *first_pte_l7(u64 *pte, unsigned long *page_size,
-			 unsigned long *count)
-{
-	unsigned long pte_mask, pg_size, cnt;
-	u64 *fpte;
-
-	pg_size  = PTE_PAGE_SIZE(*pte);
-	cnt      = PAGE_SIZE_PTE_COUNT(pg_size);
-	pte_mask = ~((cnt << 3) - 1);
-	fpte     = (u64 *)(((unsigned long)pte) & pte_mask);
-
-	if (page_size)
-		*page_size = pg_size;
-
-	if (count)
-		*count = cnt;
-
-	return fpte;
-}
-
 /****************************************************************************
  *
  * Interrupt handling functions
@@ -1340,443 +1305,6 @@ static void domain_flush_devices(struct protection_domain *domain)
 		device_flush_dte(dev_data);
 }
 
-/****************************************************************************
- *
- * The functions below are used the create the page table mappings for
- * unity mapped regions.
- *
- ****************************************************************************/
-
-static void free_page_list(struct page *freelist)
-{
-	while (freelist != NULL) {
-		unsigned long p = (unsigned long)page_address(freelist);
-		freelist = freelist->freelist;
-		free_page(p);
-	}
-}
-
-static struct page *free_pt_page(unsigned long pt, struct page *freelist)
-{
-	struct page *p = virt_to_page((void *)pt);
-
-	p->freelist = freelist;
-
-	return p;
-}
-
-#define DEFINE_FREE_PT_FN(LVL, FN)						\
-static struct page *free_pt_##LVL (unsigned long __pt, struct page *freelist)	\
-{										\
-	unsigned long p;							\
-	u64 *pt;								\
-	int i;									\
-										\
-	pt = (u64 *)__pt;							\
-										\
-	for (i = 0; i < 512; ++i) {						\
-		/* PTE present? */						\
-		if (!IOMMU_PTE_PRESENT(pt[i]))					\
-			continue;						\
-										\
-		/* Large PTE? */						\
-		if (PM_PTE_LEVEL(pt[i]) == 0 ||					\
-		    PM_PTE_LEVEL(pt[i]) == 7)					\
-			continue;						\
-										\
-		p = (unsigned long)IOMMU_PTE_PAGE(pt[i]);			\
-		freelist = FN(p, freelist);					\
-	}									\
-										\
-	return free_pt_page((unsigned long)pt, freelist);			\
-}
-
-DEFINE_FREE_PT_FN(l2, free_pt_page)
-DEFINE_FREE_PT_FN(l3, free_pt_l2)
-DEFINE_FREE_PT_FN(l4, free_pt_l3)
-DEFINE_FREE_PT_FN(l5, free_pt_l4)
-DEFINE_FREE_PT_FN(l6, free_pt_l5)
-
-static struct page *free_sub_pt(unsigned long root, int mode,
-				struct page *freelist)
-{
-	switch (mode) {
-	case PAGE_MODE_NONE:
-	case PAGE_MODE_7_LEVEL:
-		break;
-	case PAGE_MODE_1_LEVEL:
-		freelist = free_pt_page(root, freelist);
-		break;
-	case PAGE_MODE_2_LEVEL:
-		freelist = free_pt_l2(root, freelist);
-		break;
-	case PAGE_MODE_3_LEVEL:
-		freelist = free_pt_l3(root, freelist);
-		break;
-	case PAGE_MODE_4_LEVEL:
-		freelist = free_pt_l4(root, freelist);
-		break;
-	case PAGE_MODE_5_LEVEL:
-		freelist = free_pt_l5(root, freelist);
-		break;
-	case PAGE_MODE_6_LEVEL:
-		freelist = free_pt_l6(root, freelist);
-		break;
-	default:
-		BUG();
-	}
-
-	return freelist;
-}
-
-static void free_pagetable(struct domain_pgtable *pgtable)
-{
-	struct page *freelist = NULL;
-	unsigned long root;
-
-	if (pgtable->mode == PAGE_MODE_NONE)
-		return;
-
-	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
-	       pgtable->mode > PAGE_MODE_6_LEVEL);
-
-	root = (unsigned long)pgtable->root;
-	freelist = free_sub_pt(root, pgtable->mode, freelist);
-
-	free_page_list(freelist);
-}
-
-/*
- * This function is used to add another level to an IO page table. Adding
- * another level increases the size of the address space by 9 bits to a size up
- * to 64 bits.
- */
-static bool increase_address_space(struct protection_domain *domain,
-				   unsigned long address,
-				   gfp_t gfp)
-{
-	struct domain_pgtable pgtable;
-	unsigned long flags;
-	bool ret = true;
-	u64 *pte;
-
-	spin_lock_irqsave(&domain->lock, flags);
-
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-
-	if (address <= PM_LEVEL_SIZE(pgtable.mode))
-		goto out;
-
-	ret = false;
-	if (WARN_ON_ONCE(pgtable.mode == PAGE_MODE_6_LEVEL))
-		goto out;
-
-	pte = (void *)get_zeroed_page(gfp);
-	if (!pte)
-		goto out;
-
-	*pte = PM_LEVEL_PDE(pgtable.mode, iommu_virt_to_phys(pgtable.root));
-
-	pgtable.root  = pte;
-	pgtable.mode += 1;
-	amd_iommu_update_and_flush_device_table(domain);
-	amd_iommu_domain_flush_complete(domain);
-
-	/*
-	 * Device Table needs to be updated and flushed before the new root can
-	 * be published.
-	 */
-	amd_iommu_domain_set_pgtable(domain, pte, pgtable.mode);
-
-	ret = true;
-
-out:
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	return ret;
-}
-
-static u64 *alloc_pte(struct protection_domain *domain,
-		      unsigned long address,
-		      unsigned long page_size,
-		      u64 **pte_page,
-		      gfp_t gfp,
-		      bool *updated)
-{
-	struct domain_pgtable pgtable;
-	int level, end_lvl;
-	u64 *pte, *page;
-
-	BUG_ON(!is_power_of_2(page_size));
-
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-
-	while (address > PM_LEVEL_SIZE(pgtable.mode)) {
-		/*
-		 * Return an error if there is no memory to update the
-		 * page-table.
-		 */
-		if (!increase_address_space(domain, address, gfp))
-			return NULL;
-
-		/* Read new values to check if update was successful */
-		amd_iommu_domain_get_pgtable(domain, &pgtable);
-	}
-
-
-	level   = pgtable.mode - 1;
-	pte     = &pgtable.root[PM_LEVEL_INDEX(level, address)];
-	address = PAGE_SIZE_ALIGN(address, page_size);
-	end_lvl = PAGE_SIZE_LEVEL(page_size);
-
-	while (level > end_lvl) {
-		u64 __pte, __npte;
-		int pte_level;
-
-		__pte     = *pte;
-		pte_level = PM_PTE_LEVEL(__pte);
-
-		/*
-		 * If we replace a series of large PTEs, we need
-		 * to tear down all of them.
-		 */
-		if (IOMMU_PTE_PRESENT(__pte) &&
-		    pte_level == PAGE_MODE_7_LEVEL) {
-			unsigned long count, i;
-			u64 *lpte;
-
-			lpte = first_pte_l7(pte, NULL, &count);
-
-			/*
-			 * Unmap the replicated PTEs that still match the
-			 * original large mapping
-			 */
-			for (i = 0; i < count; ++i)
-				cmpxchg64(&lpte[i], __pte, 0ULL);
-
-			*updated = true;
-			continue;
-		}
-
-		if (!IOMMU_PTE_PRESENT(__pte) ||
-		    pte_level == PAGE_MODE_NONE) {
-			page = (u64 *)get_zeroed_page(gfp);
-
-			if (!page)
-				return NULL;
-
-			__npte = PM_LEVEL_PDE(level, iommu_virt_to_phys(page));
-
-			/* pte could have been changed somewhere. */
-			if (cmpxchg64(pte, __pte, __npte) != __pte)
-				free_page((unsigned long)page);
-			else if (IOMMU_PTE_PRESENT(__pte))
-				*updated = true;
-
-			continue;
-		}
-
-		/* No level skipping support yet */
-		if (pte_level != level)
-			return NULL;
-
-		level -= 1;
-
-		pte = IOMMU_PTE_PAGE(__pte);
-
-		if (pte_page && level == end_lvl)
-			*pte_page = pte;
-
-		pte = &pte[PM_LEVEL_INDEX(level, address)];
-	}
-
-	return pte;
-}
-
-/*
- * This function checks if there is a PTE for a given dma address. If
- * there is one, it returns the pointer to it.
- */
-static u64 *fetch_pte(struct protection_domain *domain,
-		      unsigned long address,
-		      unsigned long *page_size)
-{
-	struct domain_pgtable pgtable;
-	int level;
-	u64 *pte;
-
-	*page_size = 0;
-
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-
-	if (address > PM_LEVEL_SIZE(pgtable.mode))
-		return NULL;
-
-	level	   =  pgtable.mode - 1;
-	pte	   = &pgtable.root[PM_LEVEL_INDEX(level, address)];
-	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
-
-	while (level > 0) {
-
-		/* Not Present */
-		if (!IOMMU_PTE_PRESENT(*pte))
-			return NULL;
-
-		/* Large PTE */
-		if (PM_PTE_LEVEL(*pte) == 7 ||
-		    PM_PTE_LEVEL(*pte) == 0)
-			break;
-
-		/* No level skipping support yet */
-		if (PM_PTE_LEVEL(*pte) != level)
-			return NULL;
-
-		level -= 1;
-
-		/* Walk to the next level */
-		pte	   = IOMMU_PTE_PAGE(*pte);
-		pte	   = &pte[PM_LEVEL_INDEX(level, address)];
-		*page_size = PTE_LEVEL_PAGE_SIZE(level);
-	}
-
-	/*
-	 * If we have a series of large PTEs, make
-	 * sure to return a pointer to the first one.
-	 */
-	if (PM_PTE_LEVEL(*pte) == PAGE_MODE_7_LEVEL)
-		pte = first_pte_l7(pte, page_size, NULL);
-
-	return pte;
-}
-
-static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
-{
-	unsigned long pt;
-	int mode;
-
-	while (cmpxchg64(pte, pteval, 0) != pteval) {
-		pr_warn("AMD-Vi: IOMMU pte changed since we read it\n");
-		pteval = *pte;
-	}
-
-	if (!IOMMU_PTE_PRESENT(pteval))
-		return freelist;
-
-	pt   = (unsigned long)IOMMU_PTE_PAGE(pteval);
-	mode = IOMMU_PTE_MODE(pteval);
-
-	return free_sub_pt(pt, mode, freelist);
-}
-
-/*
- * Generic mapping functions. It maps a physical address into a DMA
- * address space. It allocates the page table pages if necessary.
- * In the future it can be extended to a generic mapping function
- * supporting all features of AMD IOMMU page tables like level skipping
- * and full 64 bit address spaces.
- */
-static int iommu_map_page(struct protection_domain *dom,
-			  unsigned long bus_addr,
-			  unsigned long phys_addr,
-			  unsigned long page_size,
-			  int prot,
-			  gfp_t gfp)
-{
-	struct page *freelist = NULL;
-	bool updated = false;
-	u64 __pte, *pte;
-	int ret, i, count;
-
-	BUG_ON(!IS_ALIGNED(bus_addr, page_size));
-	BUG_ON(!IS_ALIGNED(phys_addr, page_size));
-
-	ret = -EINVAL;
-	if (!(prot & IOMMU_PROT_MASK))
-		goto out;
-
-	count = PAGE_SIZE_PTE_COUNT(page_size);
-	pte   = alloc_pte(dom, bus_addr, page_size, NULL, gfp, &updated);
-
-	ret = -ENOMEM;
-	if (!pte)
-		goto out;
-
-	for (i = 0; i < count; ++i)
-		freelist = free_clear_pte(&pte[i], pte[i], freelist);
-
-	if (freelist != NULL)
-		updated = true;
-
-	if (count > 1) {
-		__pte = PAGE_SIZE_PTE(__sme_set(phys_addr), page_size);
-		__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
-	} else
-		__pte = __sme_set(phys_addr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
-
-	if (prot & IOMMU_PROT_IR)
-		__pte |= IOMMU_PTE_IR;
-	if (prot & IOMMU_PROT_IW)
-		__pte |= IOMMU_PTE_IW;
-
-	for (i = 0; i < count; ++i)
-		pte[i] = __pte;
-
-	ret = 0;
-
-out:
-	if (updated) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&dom->lock, flags);
-		/*
-		 * Flush domain TLB(s) and wait for completion. Any Device-Table
-		 * Updates and flushing already happened in
-		 * increase_address_space().
-		 */
-		amd_iommu_domain_flush_tlb_pde(dom);
-		amd_iommu_domain_flush_complete(dom);
-		spin_unlock_irqrestore(&dom->lock, flags);
-	}
-
-	/* Everything flushed out, free pages now */
-	free_page_list(freelist);
-
-	return ret;
-}
-
-static unsigned long iommu_unmap_page(struct protection_domain *dom,
-				      unsigned long bus_addr,
-				      unsigned long page_size)
-{
-	unsigned long long unmapped;
-	unsigned long unmap_size;
-	u64 *pte;
-
-	BUG_ON(!is_power_of_2(page_size));
-
-	unmapped = 0;
-
-	while (unmapped < page_size) {
-
-		pte = fetch_pte(dom, bus_addr, &unmap_size);
-
-		if (pte) {
-			int i, count;
-
-			count = PAGE_SIZE_PTE_COUNT(unmap_size);
-			for (i = 0; i < count; i++)
-				pte[i] = 0ULL;
-		}
-
-		bus_addr  = (bus_addr & ~(unmap_size - 1)) + unmap_size;
-		unmapped += unmap_size;
-	}
-
-	BUG_ON(unmapped && !is_power_of_2(unmapped));
-
-	return unmapped;
-}
-
 /****************************************************************************
  *
  * The next functions belong to the domain allocation. A domain is
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
