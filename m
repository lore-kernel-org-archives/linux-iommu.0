Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157AD15E83
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AhudyKM5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdyYBllWR0Iz9/OkpRyo/lZv1/1cB8O757SCytRjhwIm+Aq7/VbfbWlsoPPCXziUobA4BIF2sM+lpSNBn9EkL8OrW9au0pgxEKdl3upDR+K0XEKTOyIGB1wTFfqWlRe25ZtXI2Ki1jHogd99vzCboz+xnAxt0DphBIKl9S//B6QYfLBFAPwTr02ZR9DBwj0SuOxxzSVlUGIFGj/duLjlF1ErAkE7ZEUaoN8Yud40WtSMSDKQg9QdNEAnW3T+7kxYS8FzRPcLiaGECC814lV8hn643MnhT4qzDJV3JIMLctuEQm86jrtLLOyohvcYMQm4nVRechL926fFdPYYy0AV3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7bDrlPZI6Y65wR5i/lFN/xdOsZ2D4ZlegpezaVqjcM=;
 b=CGJ5R9mmtoDj2XIWrb7cJPhHQldJvGJ/gmsXM1x+TllNV0/TSBKrgG+qGj1W6u0r9olLxpfACk73wiXZryn5BNfLSJWNVi15y6GAMuCZEomMsDM75qHntgDb9GrTeEuupxauBAExL2v+kZAYXKhIxolOBWuKY0LBYX/36A46Z8c63GlzDpciD+a7GQhWOAUap9V3CvdsbBb+zpZOb9dQaMyXIJVlJ7jebZOYCfCd3cmUB9xUs9dOiCBV3pa9E2mEA6xZ3/Km7ohcujDIB4KVXmg9aduHwp6M2VqeK0L95f1f1bLZ6IjoPLyopS2HorgZoyS6O2db+sbdZIBiEvdvIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7bDrlPZI6Y65wR5i/lFN/xdOsZ2D4ZlegpezaVqjcM=;
 b=AhudyKM5VGFlB3sdCh99/3DnQA2+Z3R7O8kC5Q8aG8FnqVpYiRWsaLy3qNtlVMZwtr2MN5l0lJnz7AtGL1fGq7AeolfThnKEaginyow4SNmr8R6empN4FQHzEv3qRaDBveBFFxCiOFmtZVPjvLFYdUpG0O9oM0WNE+GTLLSNc6GEbLMPWl1QZzo9zJ9gDAYb/2QD0+vAbC4G5DwVfRFFO0REEePKo1Z72P0Bxte9yqJIAKuPc8V5J+sHEg3XJPLQWhuJhKZPx5PM/AzBHZopjVC5HsRtE8N3f1ci1Pg8DC3BOrDT8btbtpQp5ocyNgR2jjDUfHAbLqQWiOkcOcGvJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 17:51:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 17:51:03 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Janne Grunau <j@jannau.net>,
	Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Sven Peter <sven@svenpeter.dev>
Subject: [PATCH] iommu: Flow ERR_PTR out from __iommu_domain_alloc()
Date: Wed,  1 Nov 2023 14:51:02 -0300
Message-ID: <0-v1-ee4b137bfe3f+57-domain_alloc_err_ptr_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0015.namprd19.prod.outlook.com
 (2603:10b6:208:178::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6a9764-ba94-4c1b-038d-08dbdb031dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F4vT9ftenlG5SW5v45vQTblGQLSGYNFKKFRKVQq050bgiLeYx3gQASAmN4RRsBf6wq6C7zAxiVm/swOUq5fTE9CPxfnsC1laa3pq2FIt114SOyKb1pPzN8wolPS2CvSaAMtpJ+LzzxvV7D5//iwz1eNA1znyX2JMtcm2qke4vPkY+j1Mapm6nTbxk+oAVWtSlMjyBgl2vuDG+FyaX7d6Tei+iFGeKVpi8AzGwGlcXwTQXq8zZqiq2cxl1X+9KNjtYQnVxGRhXVkWwkCUDAUc+UzH+0j98o0IWvK3USv/eq5K4ISfgFS2oXeFgKKxNT9TJBnFfZHUiGwXWQ2CX0eCBHA+VWP3n8xR28clvz4jPpnqbFdwY2TpobUzv1w7TIBbAVgxtOrl668e0VcdvJechFpfjnDlUxdxKK3BMYd4ysVlHCxXKRC6sHKt1AEiInFK7UjZVLaU3mbbUu7Xury8XbQLoqxYwvX4nSYDHQxxd+zwg8h5Z/RPUx4BtyPXXAB5tyGkS4Wan3Lr/g6PMCTevLy6U+gKcSPHKNo1+ogAs2+IsHMTpguTEkhnhu6dBW8U4CdHMzFr7Wlzs2pUtq5LrTr4jDCdz7ocvHU0D993ml0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(316002)(110136005)(66946007)(66476007)(66556008)(54906003)(6506007)(36756003)(6512007)(2616005)(38100700002)(86362001)(83380400001)(26005)(478600001)(966005)(6486002)(5660300002)(7416002)(4326008)(8936002)(8676002)(41300700001)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1q0OtUvDBKcUCdz47TG5LmCXITyn4efxc8HPxZ8zIs8rOeXhxYzszPyEmmPq?=
 =?us-ascii?Q?GWXEl0BRa2cy6P7e1KwStOpvNHrdRsxCXxCqR17ca5rwLeusw9Ohd2TqwzF4?=
 =?us-ascii?Q?cjrE+AjE/4IrhPOe3hpDdonYemp9Au7+ncsxooHijQRzIFWjPA9n/fI4Sr0E?=
 =?us-ascii?Q?a4H29a/Lcv6b3HkGYps5iNH6KFMwKYNtfop+Lhh2zgETWztMn8DUb3BgNvDA?=
 =?us-ascii?Q?K7p6jBRPrmbtr4sULY8Q9CzbNRfAciPnAblS1fsTUkQk9CBHhJ6a7T6msVN4?=
 =?us-ascii?Q?SmnU14MimZgApMBhYvaWVHfm41+87AyLjqYkn0W55bey6KLn+DG8RF62BW/H?=
 =?us-ascii?Q?2Q8d3bn/uZNrIjsSBED8MuHq9WJrtP0pYjrmkmP+4Qd9VuVrRJSweG2/sKeX?=
 =?us-ascii?Q?mW8x2ggWxH+0yrqqEqBqTRpG7uf8F7WoK1q+FlCbNqi2Jo5wLOhjofxPmCpC?=
 =?us-ascii?Q?/ZH5ETCxW4EClwBImqMie8/pqdghXdBnbvEVb3EpP8T2Ho/QEAQme/aSU6bG?=
 =?us-ascii?Q?uDD8LF/dU8neDNOr/EzvwIJs8zDbW2LVuE/euk1B5r6r7j+O7XnpS+XFJAvs?=
 =?us-ascii?Q?fqN1BoC2insFhGcl2rZQf0T5Qkj3+S0sS0OppMtyf+bOockqQH4rst5i2k92?=
 =?us-ascii?Q?NNejYlsX9CA7qoqgnL7Y04Ip20W/RFBRs6x3bDFpzp7BfT+OXVEO2ZEnc/h4?=
 =?us-ascii?Q?LUpUEmodyMMuhS5CNXDpxJ2GsEySvJlNoBohN/UKh5RQ/ZdLw8bMoKB640sa?=
 =?us-ascii?Q?v/U0lu44Aiyzt2CO1a7A7k+ME8kz7RU+YyGRcMUMSoxIm2ZKcZ1CPdV7QmB7?=
 =?us-ascii?Q?5IIUld70iaFBTEJYZiHmkw2fIiKWMI90GgleT3IQvMitDPWIuEKrYMDpxr0V?=
 =?us-ascii?Q?drgZInqa5avlDIuuKYgKkHKh7oDybCMhPhh9WvElu6EK7DwO87eIcBvtubLV?=
 =?us-ascii?Q?tDR9UykxTDZnzlhi+Kj2CAOqn6M2gHAHCQ48/eLT8CFgtIMkwLkc4XUQBwkb?=
 =?us-ascii?Q?m7ES3IxM+WD8aHEjVLrtI9fCJvSC54Bv0Vog4CFJMkVaufdttlmdD6KXdTFp?=
 =?us-ascii?Q?EwnMfFFoFa6eFuGcsTi5Dl3rOetE+RF2skUVMMy78KNOKVuT2BT0/an90yzX?=
 =?us-ascii?Q?3kvwmpLZ9u/xV3ZdLA96xPfDf1k+Wy/WKmaCmJizxBfnigJ8h88bt42adiHA?=
 =?us-ascii?Q?vvuj2vokG4WYO+faVXh1Mzzr801w/a4E2/n0Exb54/5uqUIaIWBqG2iMRNE9?=
 =?us-ascii?Q?c7zxcgOD3VagM+/EYR2ySBncv7wB16qSYXDMkIhwR/H7NagC2vrR+vvjy2Rd?=
 =?us-ascii?Q?FTYWUATYIRUyjnB8GMC4+tUN7S91gPMfGd1g2cGCw9vjzaBwc9pCAAjiF4p9?=
 =?us-ascii?Q?fI9PFvsbZNLJPZZ8EEm5ETwEGPoZnqXcZX3r7s7lHXKCEoBm81MvTTLmhbrE?=
 =?us-ascii?Q?ysWiL7W21Hkyrs5ZBCjbPwzqwMSltUhU/OcIvoMFK8BbMmbtvyhjQ/inkLY4?=
 =?us-ascii?Q?dqWAHfctWfLbM9qt/zHMkuL3bTmTCudpjSR7MUCE7P6Ooplymw93SxiOqQpt?=
 =?us-ascii?Q?N6pjFZYN4bZW+wtIY56dgCoFsQ9NQ+1uzJnd4kk0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6a9764-ba94-4c1b-038d-08dbdb031dd3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:51:03.5861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8ye9HhFojLWqLctaNaVvZYRL3wCB2hlayfwq26H/rEvkBpcAAIaU4gzNPznYquN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538

Most of the calling code now has error handling that can carry an error
code further up the call chain. Keep the exported interface
iommu_domain_alloc() returning NULL and reflow the internal code to use
ERR_PTR not NULL for domain allocation failure.

Optionally allow drivers to return ERR_PTR from any of the alloc ops. Many
of the new ops (user, sva, etc) already return ERR_PTR, so having two
rules is confusing and hard on drivers. This fixes a bug in DART that was
returning ERR_PTR.

This also fixes a bug in iommu_group_alloc_default_domain() where it
returned both NULL and ERR_PTR, now it always returns ERR_PTR.

Fixes: 482feb5c6492 ("iommu/dart: Call apple_dart_finalize_domain() as part of alloc_paging()")
Fixes: 1c68cbc64fe6 ("iommu: Add IOMMU_DOMAIN_PLATFORM")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/linux-iommu/b85e0715-3224-4f45-ad6b-ebb9f08c015d@moroto.mountain/
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 53 +++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f17a1113f3d6a3..6bc044d2310487 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1802,10 +1802,10 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
 
 	/* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
 	if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
-		return NULL;
+		return ERR_PTR(-ENODEV);
 	dom = __iommu_group_alloc_default_domain(group, IOMMU_DOMAIN_DMA);
 	if (!dom)
-		return NULL;
+		return dom;
 
 	pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
 		iommu_def_domain_type, group->name);
@@ -2094,10 +2094,17 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	else if (ops->domain_alloc)
 		domain = ops->domain_alloc(alloc_type);
 	else
-		return NULL;
+		return ERR_PTR(-EOPNOTSUPP);
 
+	/*
+	 * Many domain_alloc ops now return ERR_PTR, make things easier for the
+	 * driver by accepting ERR_PTR from all domain_alloc ops instead of
+	 * having two rules.
+	 */
+	if (IS_ERR(domain))
+		return domain;
 	if (!domain)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	domain->type = type;
 	/*
@@ -2110,9 +2117,14 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	if (!domain->ops)
 		domain->ops = ops->default_domain_ops;
 
-	if (iommu_is_dma_domain(domain) && iommu_get_dma_cookie(domain)) {
-		iommu_domain_free(domain);
-		domain = NULL;
+	if (iommu_is_dma_domain(domain)) {
+		int rc;
+
+		rc = iommu_get_dma_cookie(domain);
+		if (rc) {
+			iommu_domain_free(domain);
+			return ERR_PTR(rc);
+		}
 	}
 	return domain;
 }
@@ -2129,10 +2141,15 @@ __iommu_group_domain_alloc(struct iommu_group *group, unsigned int type)
 
 struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
 {
+	struct iommu_domain *domain;
+
 	if (bus == NULL || bus->iommu_ops == NULL)
 		return NULL;
-	return __iommu_domain_alloc(bus->iommu_ops, NULL,
+	domain = __iommu_domain_alloc(bus->iommu_ops, NULL,
 				    IOMMU_DOMAIN_UNMANAGED);
+	if (IS_ERR(domain))
+		return NULL;
+	return domain;
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
@@ -3041,8 +3058,8 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		return -EINVAL;
 
 	dom = iommu_group_alloc_default_domain(group, req_type);
-	if (!dom)
-		return -ENODEV;
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	if (group->default_domain == dom)
 		return 0;
@@ -3243,21 +3260,23 @@ void iommu_device_unuse_default_domain(struct device *dev)
 
 static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 {
+	struct iommu_domain *domain;
+
 	if (group->blocking_domain)
 		return 0;
 
-	group->blocking_domain =
-		__iommu_group_domain_alloc(group, IOMMU_DOMAIN_BLOCKED);
-	if (!group->blocking_domain) {
+	domain = __iommu_group_domain_alloc(group, IOMMU_DOMAIN_BLOCKED);
+	if (IS_ERR(domain)) {
 		/*
 		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
 		 * create an empty domain instead.
 		 */
-		group->blocking_domain = __iommu_group_domain_alloc(
-			group, IOMMU_DOMAIN_UNMANAGED);
-		if (!group->blocking_domain)
-			return -EINVAL;
+		domain = __iommu_group_domain_alloc(group,
+						    IOMMU_DOMAIN_UNMANAGED);
+		if (IS_ERR(domain))
+			return PTR_ERR(domain);
 	}
+	group->blocking_domain = domain;
 	return 0;
 }
 

base-commit: e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
-- 
2.42.0

