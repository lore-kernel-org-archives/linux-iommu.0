Return-Path: <SRS0=qGVY=DL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F752C41604
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035492068D
	for <iommu@archiver.kernel.org>; Sun,  4 Oct 2020 01:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kxjkRsm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035492068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B0AE886406;
	Sun,  4 Oct 2020 01:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nEDV7DEnGuDF; Sun,  4 Oct 2020 01:42:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C5F09863D0;
	Sun,  4 Oct 2020 01:42:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3061C0889;
	Sun,  4 Oct 2020 01:42:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23CA9C0051
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 12E0386234
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zHioFkODnV2a for <iommu@lists.linux-foundation.org>;
 Sun,  4 Oct 2020 01:42:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F3AD9863D9
 for <iommu@lists.linux-foundation.org>; Sun,  4 Oct 2020 01:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfqZXE8ZE3lkhExwhIWNX4h+ZJhDk8qYl9Q6S7WGUTGUGdwXhGcUYWrQinJIWlr+xGQBRuZS82IuVmSCQ21+Cr1S1dFJAqotfJfDIaW7ZTraUECHIPuYXkiJ69oSnuwOi9gt77MAUaH0P41lmqHGDoFHcARaO/B0PILe5FqBouU1Wq0snnOpUDdrQZx3yYd9x7sLhT6/cm66o/K8IGCs3CVVyPLYJP6cQJcwi/Cn8AjDBObIJzTbFyPgKSkeNhXJIDcu07L2yWV8bweUPvchglzIUlDmgyDsgFMK6uyIz4B55P3U/wbWTTT5LFcS8OtBn9/DX5A5lD/AB9VQ0zbpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1XM3ANa0043iEQnD8Xu/Qxf/LOcQRtzD+QFLA3f/00=;
 b=LlxGAClz5z6B+Lempb2lePV8n+F4W89KlNYOv1CyvYkLCTz9NPU80W2kW/+BFMYxz2MBv6HetmbZQS0dVxGJJ/H/TOhISncTElspmTeqVWoQ2+YbojUGQCTqVDoaE+FBTzMGmltkNcFhQOYh0RZsqBFSBN7K9eQZi9Vk2WoTLksnMnh1Iy2A/4Y+B7YWSLe12Pmm/ZuSp82jPemDR+21EVNNvo74oVbFEwJK9arzaSBkXv6oNMDceNc6IsLjaSQskxeh1TOmAXUM33NeqBC39XjCGJF4YpdYMcr/Dg4JMNNzLvAA8BXhzCcX5KjgUuDxDRp4JxJlDhNYa2hwagTfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1XM3ANa0043iEQnD8Xu/Qxf/LOcQRtzD+QFLA3f/00=;
 b=kxjkRsm1i7zs2UAOKGvpEZ2EBr74an2+cwjZEL3CNy2ir8aeWZg9HqZTZY6AVfIu8Cpf006uKmRl+Ipkv4fU/j50BYbK1PZuXLDKP5XQbFHTV2N1at2pJafT1dUpc9D1E0H80jz75IeTJ7geWsTmqzEXoJCLG+1CNyU/252cOco=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:42:01 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:42:01 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v3 08/14] iommu/amd: Remove amd_iommu_domain_get_pgtable
Date: Sun,  4 Oct 2020 01:45:43 +0000
Message-Id: <20201004014549.16065-9-suravee.suthikulpanit@amd.com>
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
 Transport; Sun, 4 Oct 2020 01:42:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 54e536f9-fd4c-4901-38a6-08d86806aff9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1451C721AA21BBB2C6206BF1F30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hR++xom5UUk0CzvODgVwbk68s05CHeN8j7yaR+BTEG2dTzhbdIsqNwJPqltNYd4pcgiq+Qr6Jz3UodbEURwFvJdPC5u8iw+Fp3BdZusZ+WLwVmvbjiCnUj53wpGEyNxAwntZP7oPFF7Bgbq34Vm+vKFxEF5q7Pa8F+rsd4F8P3wNtlgTlskEgnKPTJAOATitBN9m/Sbju0NDqzbJHuEQW5kccNkFpchIjZnz5JSk3N92boRCm87AS2z0YidQjIUTvzsivts5eZvV1hbzkQzUmykyb8zb5oIx9S5dq295jnHpUsF3OI96/xaMF9W4HczL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: rste610Gp18YiJNygC/dgUa9PYNmtpRAc+JWV8QjwsHh5MUzv6lZoDRgbzwmJt2zMgZYs3kJFjGRuL8G1NXe+u66ESgQPhjuWAuF9mbkbIGblZg57RL73PU6CZ4tqBtF9KeHMRFgvgXdnqlA3NYkr3juY/XGRO/DVByJ3ywUg9naR/hqLT3s1zYwxw4zBGdbPQXEzBheDAhtrWfQtVZcvlzPGN/m9TzRxFjZ+e/gOIcLkZ1sdraRdZSu0xuvw3XQ/s3ZW/5+SrTL3sFfBZCjJ7CreZrSgJz/eoEQ2g6ueJM01et3vaTj+V1Cfibmg1Uz96M3mv7OKcCztCBuGIw1UawvtuT/sl3HahZWQi229T9SLsEh4UBM8/v0MNhTdt00CZ8iWQayKvQD/UEEY1zNt9cLH8urf+yYvAkmer/LrYwA7dNeqrA54Y3GWh88trbQ6p9w/DWhM0JNaF18OFzWw9/aEf1dXJU26bV/BUmgCXJEohTmmu0s99bhU2z0SLiutxJul9cyfN1jLytxc2T6U91xESRk51hJI2pT7esIPwTu+DzPnsc1IR51NZp2a1mJYG/PMVhjtW1NXV9KCcjC1KwAPqlqPmxCKt1RGnuMyNwXnN77vnJcXCPiBG3YEwdgUswMU3504v2OqzZ0aQHQXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e536f9-fd4c-4901-38a6-08d86806aff9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:42:00.9731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoVlGnlxhRIENetldGzn3x+KOQ+cO2itLf2aJsu1EDXEJc8zXyklOKSBqtf0NUZ+RG6iFDvpfAdPCZCyIQCMTQ==
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

Since the IO page table root and mode parameters have been moved into
the struct amd_io_pg, the function is no longer needed. Therefore,
remove it along with the struct domain_pgtable.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  4 ++--
 drivers/iommu/amd/amd_iommu_types.h |  6 -----
 drivers/iommu/amd/io_pgtable.c      | 36 ++++++++++-------------------
 drivers/iommu/amd/iommu.c           | 34 ++++-----------------------
 4 files changed, 19 insertions(+), 61 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 8dff7d85be79..2059e64fdc53 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -101,6 +101,8 @@ static inline
 void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
 {
 	atomic64_set(&domain->iop.pt_root, root);
+	domain->iop.root = (u64 *)(root & PAGE_MASK);
+	domain->iop.mode = root & 7; /* lowest 3 bits encode pgtable mode */
 }
 
 static inline
@@ -135,8 +137,6 @@ extern unsigned long iommu_unmap_page(struct protection_domain *dom,
 extern u64 *fetch_pte(struct protection_domain *domain,
 		      unsigned long address,
 		      unsigned long *page_size);
-extern void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
-					 struct domain_pgtable *pgtable);
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode);
 extern void amd_iommu_free_pgtable(struct amd_io_pgtable *pgtable);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 80b5c34357ed..de3fe9433080 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -514,12 +514,6 @@ struct protection_domain {
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 };
 
-/* For decocded pt_root */
-struct domain_pgtable {
-	int mode;
-	u64 *root;
-};
-
 /*
  * Structure where we save information about one hardware AMD IOMMU in the
  * system.
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 23e82da2dea8..6c063d2c8bf0 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -184,30 +184,27 @@ static bool increase_address_space(struct protection_domain *domain,
 				   unsigned long address,
 				   gfp_t gfp)
 {
-	struct domain_pgtable pgtable;
 	unsigned long flags;
 	bool ret = true;
 	u64 *pte;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-
-	if (address <= PM_LEVEL_SIZE(pgtable.mode))
+	if (address <= PM_LEVEL_SIZE(domain->iop.mode))
 		goto out;
 
 	ret = false;
-	if (WARN_ON_ONCE(pgtable.mode == PAGE_MODE_6_LEVEL))
+	if (WARN_ON_ONCE(domain->iop.mode == PAGE_MODE_6_LEVEL))
 		goto out;
 
 	pte = (void *)get_zeroed_page(gfp);
 	if (!pte)
 		goto out;
 
-	*pte = PM_LEVEL_PDE(pgtable.mode, iommu_virt_to_phys(pgtable.root));
+	*pte = PM_LEVEL_PDE(domain->iop.mode, iommu_virt_to_phys(domain->iop.root));
 
-	pgtable.root  = pte;
-	pgtable.mode += 1;
+	domain->iop.root  = pte;
+	domain->iop.mode += 1;
 	amd_iommu_update_and_flush_device_table(domain);
 	amd_iommu_domain_flush_complete(domain);
 
@@ -215,7 +212,7 @@ static bool increase_address_space(struct protection_domain *domain,
 	 * Device Table needs to be updated and flushed before the new root can
 	 * be published.
 	 */
-	amd_iommu_domain_set_pgtable(domain, pte, pgtable.mode);
+	amd_iommu_domain_set_pgtable(domain, pte, domain->iop.mode);
 
 	ret = true;
 
@@ -232,29 +229,23 @@ static u64 *alloc_pte(struct protection_domain *domain,
 		      gfp_t gfp,
 		      bool *updated)
 {
-	struct domain_pgtable pgtable;
 	int level, end_lvl;
 	u64 *pte, *page;
 
 	BUG_ON(!is_power_of_2(page_size));
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-
-	while (address > PM_LEVEL_SIZE(pgtable.mode)) {
+	while (address > PM_LEVEL_SIZE(domain->iop.mode)) {
 		/*
 		 * Return an error if there is no memory to update the
 		 * page-table.
 		 */
 		if (!increase_address_space(domain, address, gfp))
 			return NULL;
-
-		/* Read new values to check if update was successful */
-		amd_iommu_domain_get_pgtable(domain, &pgtable);
 	}
 
 
-	level   = pgtable.mode - 1;
-	pte     = &pgtable.root[PM_LEVEL_INDEX(level, address)];
+	level   = domain->iop.mode - 1;
+	pte     = &domain->iop.root[PM_LEVEL_INDEX(level, address)];
 	address = PAGE_SIZE_ALIGN(address, page_size);
 	end_lvl = PAGE_SIZE_LEVEL(page_size);
 
@@ -330,19 +321,16 @@ u64 *fetch_pte(struct protection_domain *domain,
 	       unsigned long address,
 	       unsigned long *page_size)
 {
-	struct domain_pgtable pgtable;
 	int level;
 	u64 *pte;
 
 	*page_size = 0;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-
-	if (address > PM_LEVEL_SIZE(pgtable.mode))
+	if (address > PM_LEVEL_SIZE(domain->iop.mode))
 		return NULL;
 
-	level	   =  pgtable.mode - 1;
-	pte	   = &pgtable.root[PM_LEVEL_INDEX(level, address)];
+	level	   =  domain->iop.mode - 1;
+	pte	   = &domain->iop.root[PM_LEVEL_INDEX(level, address)];
 	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
 
 	while (level > 0) {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cbbea7b952fb..3f6ede1e572c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -140,15 +140,6 @@ static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 	return container_of(dom, struct protection_domain, domain);
 }
 
-void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
-				  struct domain_pgtable *pgtable)
-{
-	u64 pt_root = atomic64_read(&domain->iop.pt_root);
-
-	pgtable->root = (u64 *)(pt_root & PAGE_MASK);
-	pgtable->mode = pt_root & 7; /* lowest 3 bits encode pgtable mode */
-}
-
 static struct iommu_dev_data *alloc_dev_data(u16 devid)
 {
 	struct iommu_dev_data *dev_data;
@@ -1464,7 +1455,6 @@ static void clear_dte_entry(u16 devid)
 static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
-	struct domain_pgtable pgtable;
 	struct amd_iommu *iommu;
 	bool ats;
 
@@ -1480,7 +1470,6 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_cnt                 += 1;
 
 	/* Update device table */
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
 	set_dte_entry(dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
 	clone_aliases(dev_data->pdev);
@@ -1806,10 +1795,7 @@ void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
 
 void amd_iommu_domain_update(struct protection_domain *domain)
 {
-	struct domain_pgtable pgtable;
-
 	/* Update device table */
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
 	amd_iommu_update_and_flush_device_table(domain);
 
 	/* Flush domain TLB(s) and wait for completion */
@@ -2058,12 +2044,10 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 			 gfp_t gfp)
 {
 	struct protection_domain *domain = to_pdomain(dom);
-	struct domain_pgtable pgtable;
 	int prot = 0;
 	int ret;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	if (pgtable.mode == PAGE_MODE_NONE)
+	if (domain->iop.mode == PAGE_MODE_NONE)
 		return -EINVAL;
 
 	if (iommu_prot & IOMMU_READ)
@@ -2083,10 +2067,8 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 			      struct iommu_iotlb_gather *gather)
 {
 	struct protection_domain *domain = to_pdomain(dom);
-	struct domain_pgtable pgtable;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	if (pgtable.mode == PAGE_MODE_NONE)
+	if (domain->iop.mode == PAGE_MODE_NONE)
 		return 0;
 
 	return iommu_unmap_page(domain, iova, page_size);
@@ -2097,11 +2079,9 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long offset_mask, pte_pgsize;
-	struct domain_pgtable pgtable;
 	u64 *pte, __pte;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	if (pgtable.mode == PAGE_MODE_NONE)
+	if (domain->iop.mode == PAGE_MODE_NONE)
 		return iova;
 
 	pte = fetch_pte(domain, iova, &pte_pgsize);
@@ -2470,11 +2450,9 @@ static u64 *__get_gcr3_pte(u64 *root, int level, int pasid, bool alloc)
 static int __set_gcr3(struct protection_domain *domain, int pasid,
 		      unsigned long cr3)
 {
-	struct domain_pgtable pgtable;
 	u64 *pte;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	if (pgtable.mode != PAGE_MODE_NONE)
+	if (domain->iop.mode != PAGE_MODE_NONE)
 		return -EINVAL;
 
 	pte = __get_gcr3_pte(domain->gcr3_tbl, domain->glx, pasid, true);
@@ -2488,11 +2466,9 @@ static int __set_gcr3(struct protection_domain *domain, int pasid,
 
 static int __clear_gcr3(struct protection_domain *domain, int pasid)
 {
-	struct domain_pgtable pgtable;
 	u64 *pte;
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	if (pgtable.mode != PAGE_MODE_NONE)
+	if (domain->iop.mode != PAGE_MODE_NONE)
 		return -EINVAL;
 
 	pte = __get_gcr3_pte(domain->gcr3_tbl, domain->glx, pasid, false);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
