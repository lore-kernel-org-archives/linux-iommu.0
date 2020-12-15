Return-Path: <SRS0=8938=FT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECD3C4361B
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:34:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65A722286
	for <iommu@archiver.kernel.org>; Tue, 15 Dec 2020 07:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65A722286
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 42063875F9;
	Tue, 15 Dec 2020 07:34:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9V2TwsABJ8Vi; Tue, 15 Dec 2020 07:34:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3290C875DE;
	Tue, 15 Dec 2020 07:34:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 188B6C0893;
	Tue, 15 Dec 2020 07:34:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A983C013B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 01C5086E6B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:34:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6VB6IbOSuh8w for <iommu@lists.linux-foundation.org>;
 Tue, 15 Dec 2020 07:34:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2EF2F873D7
 for <iommu@lists.linux-foundation.org>; Tue, 15 Dec 2020 07:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyOQHHdgeYPTHEZyJLAUn+h1MmpGgC82+ybnP9rcAeknOXsxRDPuaJQ8iCJo70AZfikI4JrNQFJk99kcqr17KWzZW1TpSRckk5G5TIu2La8VSXanTpu2IpH4wUIPYUfBqMZ9zkorrzxV1xYmTY/NPwqM08ryMpboUcGkhELiXD8KsdP1Nt02ju/XUhG7sUnlwBHIg7wRYCyC2zS0CSEUBig3lK13tPuSkk6zz1HMNiFcVLMQM9eW4QnEu1MVV5GokNJqDpI8CaJXjd8aytMYLYlX1HchmuQK9joU24NIFgJlMnyzUNUpMMB+1XWD8IRBZVz/rGG1bN36IRuUeiYw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af+rlCBJMrJdP4rweyhGZzf7ehC7hLt/FrmDIgDktDg=;
 b=AeKWa3rQ7O2e9q2YM4dsVC+7hp/20hBnegYHWez8UVmoCP0ABvLwRQq0muc7Wu9f8aicFZZNn2d4iolFBovojDILeizZBA0KZ1VEa+sP++7DQBQQ/kQ1WDHMyqmDCXOn71Gwp077UOuMEK7Rqbqf6ajjo1bBv4J8liCE4z33ONfwGGFmO7aCCSS93KzYSICr5UDBBR2yIBdH32GESwomccrU5gUyvsnX38UQLbSKbCfw82my0KbOLB0oa7ZPZ1zpmod3usVLGn1GUF7GoP+gNsQFxWiV0r9fqA4PMIzUGJhvUhQkP9p+EHh+e/YhiBRL04p16hp36AgjLayLrC2sjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af+rlCBJMrJdP4rweyhGZzf7ehC7hLt/FrmDIgDktDg=;
 b=KQkXGhcVURylj9qQKHSeprQxBgKGPAI8lwO5K2N1icKJM2V9J6ROaUZhnHUI37dr0decdifp2WPq+EG9e22HfqnTY9MX/Yg8/CL5bFgzx7Jq7h6WPWeTrFFTurahv6PpmFzpudVW52zI6RY/qcsmqbEX9YBZpijLdmsTAESoM6o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB3794.namprd12.prod.outlook.com (2603:10b6:a03:1aa::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 15 Dec
 2020 07:34:41 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3654.021; Tue, 15 Dec 2020
 07:34:41 +0000
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH v4 04/13] iommu/amd: Convert to using amd_io_pgtable
Date: Tue, 15 Dec 2020 01:36:56 -0600
Message-Id: <20201215073705.123786-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
References: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN2PR01CA0060.prod.exchangelabs.com (2603:10b6:800::28) To
 BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by
 SN2PR01CA0060.prod.exchangelabs.com (2603:10b6:800::28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 07:34:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9141819d-7afa-4519-ff27-08d8a0cbe2c3
X-MS-TrafficTypeDiagnostic: BY5PR12MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB37943D38A8F62C487C4AA753F3C60@BY5PR12MB3794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SUfJNQSyzQWpUe2c4WRkgf9B3MRU9YKViv1k6x42FGYrwgkh+S2ipGNcNcoxfenYANTnJHi99NmZhFK6deA5R3C/tDWmmeOfTVOaPFbesRpMt3J50jj1HGdyU1v6A4OJ4PRA7usjhLS4CfrpgvcvjaKG0HuBlDbxUuy0AuqCnRmzr9XNyNRde3yDsyObH6KVUO4RaP4PYVbdN5UXqIE23T3tWEUqcwPryshjKZR77tEiacevbghXIfHJDbw4SJoBs1SLvEFp9VzbwgVR86o5qDEW9BT4fhVEsD9anzzwHH+wtfSkLYriUiB7tIz3vzC/StEkdaFWex2kh+VaOvXfuq1CEXkuynTkLDkrqso1PTv192ZtukV3x1arkBcvjB7C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(6666004)(2616005)(66556008)(16526019)(86362001)(956004)(66946007)(6486002)(34490700003)(26005)(52116002)(186003)(66476007)(1076003)(7696005)(36756003)(83380400001)(5660300002)(44832011)(2906002)(8676002)(508600001)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cLi2jGAQL+/CoyJZLInhS9jeqGHjIqxU5ndJXNSC74ZQ1xtZqVr9JO2XFoXx?=
 =?us-ascii?Q?ZDx/xmzxi+J+KuXT7bt1QG7P0Pe4n2Zn5p1UsddPXAT7lFxldf9HpvCYUjM7?=
 =?us-ascii?Q?5s/6yREZNdHK2a8atGw31afpO+R3juAAVUcMqMPlQgRULxwH87TrHtSuCzdK?=
 =?us-ascii?Q?vquqeZl0cA3Zn5WAOKZFN6KfOwUAKbyxTxHM7TEAbLVMlgSu3/3UZe74yWpD?=
 =?us-ascii?Q?kdDXoyoPYbRFbVtUefycXQjh0aeoCJaYVL3NZOWi/BAEhes4NEo2nJvAXG3z?=
 =?us-ascii?Q?YPk4EyUdf6Yz8SLNYpO7JCHh74Ro+bgAz4cL4ss9fZ7ppbe6MIae5Nv1Kf/Z?=
 =?us-ascii?Q?Wx6J243xwrbpIT/YRByDcJ3QIbgStCp8MKh+6H+xRKSV+n3ozkJjVCz/ycMT?=
 =?us-ascii?Q?bYuC7zum5bSmGb6iwn3DKJMSVqnFx2dqVQBrH5C9aJEG81pzALiw6OYQTSQp?=
 =?us-ascii?Q?NKRKBRQ5+1v+6jVz9BuehqblgCTniiMI6TpWyQDT/FJZfEop1Rr/Ixbv/Gbn?=
 =?us-ascii?Q?W18bO9mpLqLn0n6YzUsmfkNqihS2dSE6A3at8RyHs1ktn7y3luaDJnfZzgKF?=
 =?us-ascii?Q?JZa9JNmXSZlDE1/pxiXrEBFwVnPei9iL4uCJSdmkgTx1Ac2l++G727q3IRz7?=
 =?us-ascii?Q?nkry0PBX3DX5rvFmo6N9CZCnox3FfDY0xdQSYOFdsFdw8QupIbr9ob4JtGFF?=
 =?us-ascii?Q?0C9rGzLChpq7GxIqA3gIJZJDuvx1QmAkXydcST5UoX4eb09thHigqXtMv8+7?=
 =?us-ascii?Q?51SOaS3k1msm7hB/+T9Hp8QMylpDbWxkdKSt2drhQO2N4kZNx4fc5QFz6j66?=
 =?us-ascii?Q?vzQU9wsGjLaVUO+eHbeS4GShCXcFpUB4d9RTVmZeyFvo6kG8+wI+eYk6nJRn?=
 =?us-ascii?Q?6npGBuN47XR8qdU4gL1chIeNrn0AYzzZ6I8S4GLg9x467MgG1t7D0y9GemVU?=
 =?us-ascii?Q?NJfX9dv/2SEvesP/vLa9siCGqZQgWdYc+5Vc3NFTtfaDerRbNYHw4fcqN559?=
 =?us-ascii?Q?8YW2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 07:34:41.2498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9141819d-7afa-4519-ff27-08d8a0cbe2c3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V+05KYigkgqhZ7iMMGPviU3ireC/MYEZvBx2uNOfG2K8yDvugprdRjFGMxGhjosBU2RAvPSlUEIZ5Lc9DMS3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3794
Cc: will@kernel.org
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
index b8dae3941f0f..bf9723b35e77 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -56,6 +56,7 @@ extern void amd_iommu_domain_direct_map(struct iommu_domain *dom);
 extern int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
 extern int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
 				u64 address);
+extern void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 extern int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
 extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 				     unsigned long cr3);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5b93536d6877..fdb6030b505d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -89,8 +89,6 @@ struct kmem_cache *amd_iommu_irq_cache;
 
 static void update_domain(struct protection_domain *domain);
 static void detach_device(struct device *dev);
-static void update_and_flush_device_table(struct protection_domain *domain,
-					  struct domain_pgtable *pgtable);
 
 /****************************************************************************
  *
@@ -1502,7 +1500,7 @@ static bool increase_address_space(struct protection_domain *domain,
 
 	pgtable.root  = pte;
 	pgtable.mode += 1;
-	update_and_flush_device_table(domain, &pgtable);
+	amd_iommu_update_and_flush_device_table(domain);
 	domain_flush_complete(domain);
 
 	/*
@@ -1877,17 +1875,16 @@ static void free_gcr3_table(struct protection_domain *domain)
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
 
@@ -1977,7 +1974,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 
 	/* Update device table */
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	set_dte_entry(dev_data->devid, domain, &pgtable,
+	set_dte_entry(dev_data->devid, domain,
 		      ats, dev_data->iommu_v2);
 	clone_aliases(dev_data->pdev);
 
@@ -2284,22 +2281,20 @@ static int amd_iommu_domain_get_attr(struct iommu_domain *domain,
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
 
@@ -2309,7 +2304,7 @@ static void update_domain(struct protection_domain *domain)
 
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
