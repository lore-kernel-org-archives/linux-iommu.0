Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EFF1C28A
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UzzWdB4p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBXxmUD2h6ptv+qZMCsu4+rbkoLQrdWITWK5J3P8IuCipA1GT+wfkkneQ0TEdhDttWgBO2nOXv9NdtQ3nwDglPUMHTNzOuvkNWLOrNnDuXywjaWW7f8HYFdhFGmXtBiVjmKpT1StMpFCwyOYvX+X4cab3QERkXcuT2nAM6DWCOiDLsufyE3rPjPuGjIULMq4OOfRzcUp2pN4319fkfNsqngrUp2ItoeMrkLGMDkDaHqr1n6F30kzDv9baKpHfm7u5suVHQoQbnvEHaGH0N9C6DhReFMPHIecz3MQI7VMDU5AcDuowVYeo5l2LV9NldM2OcQEOfNnxDFK+XlKojRtXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKjlQdEbtFpmWK/cm09Lx7F9KngqmRiMtDiqJUitsfE=;
 b=OgLqYyk551x706af/MebaBLj66HKpNb8UjrCmU7b4fYPkRiohC1XdwNpcnHH34IxsB88PeLIl8PKlFeQayDKMjCxsg1IBciinrR+e6M7KZIkUQgXKRxIgmazItzWjWyeVvQluMsB2o/mnmquWvXNLBXopmeckno1k83kMP9dHE4UWqEgqBM8WsCsyKyRHipqjesHKf5cqawOcQ58EQcfCguif1I7qfPI8zIOjZHG671T7li0myt/u0iH64sWRxTWYEhFozSpt8EepJPzP+U8QGYianFGLF+ydcZ1OuUga7ra0TDZCeRSvIlIqfAP71sZq63BHVWiwYVQAxH6f8vPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKjlQdEbtFpmWK/cm09Lx7F9KngqmRiMtDiqJUitsfE=;
 b=UzzWdB4pObyqb1MsZpCHK8cb91gh6NodwRoY3ImzT/rJzAREqkorqi+rrVenVvRvqj0sni36G5kRwGJAroASM2hAVdHVoOX/SQzfQ7aeEhVFUL0u2mfZos3upkDUMJyUJq/PQW8Ldy/WZ/A0Ud6yGgBLOP2CyU8Em67gkl7ghJ1NHGrghc6pcqeqgmFHs1KJhEo8oYrZref0snMb7XdHsRzmwbx7LeMJo843xbu/ZDP9CPnbv+beZIBqMVKscdA8KCqw3Us6N+/7Zh4w/qw1D2zhgIWP6OgGdN6x4Ub5rCu4TTdmjzFVhbYDx+xYbglHraRq029QpyI94KhCn5eyfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Wed, 1 Nov
 2023 23:36:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Wed, 1 Nov 2023
 23:36:49 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 01/27] iommu/arm-smmu-v3: Check that the RID domain is S1 in SVA
Date: Wed,  1 Nov 2023 20:36:19 -0300
Message-ID: <1-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:208:fc::43) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9ebfce-0b2f-434a-55b5-08dbdb3369e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OgicdbPfSETUI0sskXKzc0rb7lerWXswQ4hEHZO0D507GXKofcxZMJYB4wt8Ugp6L+VVpIPVDohrmnWUxflYdGX1B1vGS4fsWOH7XY8QyBvUnWC+vPzbjlo0sToMSRgt4t6xZlL+iBCsjNzBVU+rPgWGkUpfRCHfYrKqF7mkUM65yR4dMdmh9ga7SVXRy1xJhyyX1Xj3JOccxPYD2kDyS910ESex0JKEUWLEgyt9YIwkewl692UfsfdtGqp+efDrM+EUnPF7N3Gb+lZ136w8Tm07wQJpplchl93wXdrox0WveLKtCHFxDZnfcEKiBeT5NQgcGUi+eZrfrQ5MYmxwM/mZLdMpFSBmmxw3xI8zvbz7U3hjfPWjQ2IigSZsK7jAovNqS+23q3QpBI/x6vwX5fD1bImEvFDZDKM76LmicYUkrOn/16Fn3YvKS5XwQEjwDqDMreh9SoW5Ua2sAqoqRhvl3vb5L28I/6M6H+B7c9gRH/8KVW3pcwJNvi+Q8v7QYU23PfTQg3obe+UnIElYsIQfYS6VPCDhfSMLWwCXHHqpiMg5dLKbe93XwbNqSenPuaccmVYJ+xRKpL54h/0Nkxpo22SWD4rVocArwiqe7BU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6486002)(2906002)(478600001)(36756003)(54906003)(66476007)(86362001)(110136005)(66556008)(66946007)(5660300002)(41300700001)(26005)(107886003)(2616005)(38100700002)(83380400001)(8936002)(8676002)(4326008)(6506007)(316002)(6666004)(6512007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qIzzX0nVQrnuAJzndr1QLwP6MfX0qkFNun+xCsTtUQH2qH4h7XhZSaUCFEcT?=
 =?us-ascii?Q?So9x+K7vi14wqf0rt6BtjpqDYoxW/b5XDsfswguNgBKSscj/qP93AnW3VJyb?=
 =?us-ascii?Q?Yx/L3hg+BwyHc+VyyCDLRZTHA1X1swhg4N1lY7X2Fop9AHoPkGMbc/oi3lug?=
 =?us-ascii?Q?mxcEckxy4vOl4fvg5+JKVPX4wVIBHNH6+xPTYf5yvcxQoUoJxbM+zB/e2eE1?=
 =?us-ascii?Q?aE/Qe+h29Q2i7VzGAG00yjtgEBmoTMUxXcTZc8IwBNX8Ydd5csxhc6c3zVWo?=
 =?us-ascii?Q?peqwJKPdKgAXv+JU5opIIy0rWOrXHzGSYg1yHaMfLdY2lPvEpVFTEwQ4QE29?=
 =?us-ascii?Q?Rf7Rg2GDajZqHcggzBL3k3m+/L8qUF9CBY+R1/Qb6UosM4YfXTSRTu6ng0Hz?=
 =?us-ascii?Q?v7yfq1ua/yrAd5rTkRMBf1hPA8yR9OkR/llfzTWaCtMEDeBOk8DuMsEmtSMm?=
 =?us-ascii?Q?vsWesAEX0J132wph3atKELHyLd0/QPkBPzscLtzP5Gq86/ECpCbORpX/8YeD?=
 =?us-ascii?Q?NrRcYl3Hr7ueLWgcNNGOXNVf0dpdrOYNL9igNJTzM8ofHX15Cx7LUZbsdQp+?=
 =?us-ascii?Q?/P0AFDonfBBnXV3aHwYC4N/XLhrQ87nNMhF/OhIjaEgcHJrT82hU3SXULK7r?=
 =?us-ascii?Q?jc7zr8pWgUTqS3Uoh9jdbKWTTz8ifSUC0eEsS3PxI+48f3h2ekWAAwuh6j/h?=
 =?us-ascii?Q?eiqHXjrFpwqyp3pQHr0karxiUpcEQ3ozA08F6Vd5m/SwRlm4by1B2Mkbx+TN?=
 =?us-ascii?Q?XaBEiCjtVGcs5YgNuRxo4hBcm42fdyzbEMyBteCN/dNSBsL1eEsHnNNroXYx?=
 =?us-ascii?Q?QNivu0ehjX8rh+y6EtNYP6jIEKS64Rhl4wrNScr3yURLeQUxS4c2OogRyC7j?=
 =?us-ascii?Q?a8p731QEvbeksZBgBEI0pOav3AZcyFKLizWYArPnsOuh5bbU6gW5EHlk8sP2?=
 =?us-ascii?Q?R5GGO8RSZQGcDtrw90DNOQ9DvOKwax4f0SM20AA5WqFoBludbCmRlJKNrWez?=
 =?us-ascii?Q?wV3E6syNPk15bYV9ngnjT0SYzHLbpYOWKzoTK8P9Aq72gWXG8I6Ewh49pPwp?=
 =?us-ascii?Q?VcMcft/g2+ElQF0k0sJ5SSRRhiKLCGnZT6qTdy8scpA32UtoKScdvng72kyY?=
 =?us-ascii?Q?CeelUUGzc+a6onl00VCeZ69g+UMRcRyjWXRW1Wsaa4fOJbYA30Csce8Ce4m4?=
 =?us-ascii?Q?v3sdgUOMKSDB7D4QzzfqzZt9WE0Svars5vuojgXoUyj5PY1KYsPLRRZaxDpG?=
 =?us-ascii?Q?7vloSXAebXPCA5vobpwlFdIOIgd00KCJNZ6hqze6pS9uIma0B15ggtlT1ynO?=
 =?us-ascii?Q?nf4E3U06hrnws3gpAJLf/8+SOnXPjRjlnsAtibY2aEGZZ8UADOPby97i3ir9?=
 =?us-ascii?Q?juGpro8KCmoc8oHb2x+2EiKppCm1fvNVvpTXaXffL+5Yy8Le5BK3QtjBmgnV?=
 =?us-ascii?Q?7Nf+NaumnAdO9E6BNs8k4/y69VAvDiNnPtADzCwftPZxenyVP0YVKWnpUuyF?=
 =?us-ascii?Q?MmJGAxVt50WlDPB5PR5i4BYVCOwL6w5r6LhpZA5mBVeQlLcAv4UapN+TfKm3?=
 =?us-ascii?Q?CgCNOZX1LQugzhkUWTefTe8Fb79Dzt4HbLRR+Jeq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9ebfce-0b2f-434a-55b5-08dbdb3369e3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 23:36:47.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbhaoeqwhBM4hJZFwBphq7JtkGaUG5QEkfznV1mFnUgUljpScdSc/Jf2XwPMA68x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

This code only works if the RID domain is a S1 domain and has already
installed the cdtable.

Add a to_smmu_domain_safe() which does a robust conversion from
struct iommu_domain to the struct arm_smmu_domain.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c |  7 +++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     |  7 +++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 14 ++++++++++++++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 353248ab18e76d..bd0566381c58a9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -379,8 +379,11 @@ static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	int ret;
 	struct arm_smmu_bond *bond;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_domain *smmu_domain =
+		to_smmu_domain_safe(iommu_get_domain_for_dev(dev));
+
+	if (!smmu_domain || smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -ENODEV;
 
 	if (!master || !master->sva_enabled)
 		return -ENODEV;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5667521bd18091..43f5531795f0b0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2486,14 +2486,13 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(master->dev);
-	struct arm_smmu_domain *smmu_domain;
+	struct arm_smmu_domain *smmu_domain =
+		to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
 	unsigned long flags;
 
-	if (!domain || !(domain->type & __IOMMU_DOMAIN_PAGING))
+	if (!smmu_domain)
 		return;
 
-	smmu_domain = to_smmu_domain(domain);
 	arm_smmu_disable_ats(master, smmu_domain);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 154808f96718df..6f62184eaa2434 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -740,6 +740,20 @@ static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }
 
+/*
+ * Check that the domain type has an arm_smmu_domain struct. The global static
+ * IDENTITY and BLOCKED domains do not.
+ */
+static inline struct arm_smmu_domain *
+to_smmu_domain_safe(struct iommu_domain *domain)
+{
+	if (!domain)
+		return NULL;
+	if (domain->type & __IOMMU_DOMAIN_PAGING)
+		return to_smmu_domain(domain);
+	return NULL;
+}
+
 extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
 extern struct arm_smmu_ctx_desc quiet_cd;
-- 
2.42.0

