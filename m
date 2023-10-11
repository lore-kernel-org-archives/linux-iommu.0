Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F0D30F88
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 23:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kt2oRRwv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lf83AqQUEibIfvB6hvFZCL1o0kI3okM9insBV/KB5nzkkl+Jub/a9DkAcpkoJcsF8EQab677X28d8aD+hwL3fhbmlSYoFCCtSzyZmQnyeFaIsM83qMOFM/+eo0y1ADSHls92UBxO1E8rq5jUfEAlpZo72AotwyXXKV3+++hCt9fDmAgO5dopMq9WCWmvmmnpRd/CtoZsX315+QISPG/RW4/Vl9qPrh83kWoIXSIZlbB7hbOw/ejl2ikFyz+CodSvJ56iOJfdK4fo8IKpr685Ayy527rissAF8FB3Jb56TI3UZ0puzDaTompHnjKq69irgppVNq0gJIuqljFdR1Wltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faqLUxZh7NGFr2pnYkK/vyMmkHr32wqLExBAGN5GGAQ=;
 b=H3hgEvZnly/ddAExmIR6IXvrDwGJDk+ZFJGlaJ8koZfhaQG4zwsDsVGOjBpmgvoIXQdchbHd0KjFD2EpNafQQg/9p7NLkCDo9wktYoq9MF2Mp/79+dDAVxWJ2k0W96vvHH13rSrufERMjET5O/ysB2rXuxFfpGA+dhWpjQQWVYmLtnLVjNV3LVNRdJtKhZTiC274UdxT8CZHkoqyUQ/xKngJvNl++msGxfB0H8ezKoNle59EbVc32kTHH16oJTpWyzkechruMfFtzC17bF4CsA9KUrDlBiyKc1Fj4UaLB8igU7XlV3BLhZswyGGmqAxFEA5eZrxmZSTN/RHwSIrkiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faqLUxZh7NGFr2pnYkK/vyMmkHr32wqLExBAGN5GGAQ=;
 b=Kt2oRRwvkvHSrr4UXHxm2ch5SBp1jgRJ1sJVcllFVCLul7Dj1jOTFWO6n5JFs0rdMoMllayWE7QqDLXkxijnnhdftykGt5LsNBKxY8TvJPtAlgvJlQl4bPm+pmFbWZvPxBbaVV3ctTABizIG/wAA9Jo/mpEASkQPoKE6k6KtqIAm8cP5adwhvYWIYhfhm2180hop/iZ6+292T64VoQsb/Y49qBpZr9bmcjMZ4Mv+2EJbi22/4zUYwkdGDgTdvZqxtuQmjyqjGYw3d1WutqFqXarYBulLn4SqYjtPr+3C9l9eau7pOOsKh8BUCm4+n3u4LWd4JjJVn/UczwXdF/Kwbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:26:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:26:09 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 01/27] iommu/arm-smmu-v3: Check that the RID domain is S1 in SVA
Date: Wed, 11 Oct 2023 20:25:37 -0300
Message-ID: <1-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
In-Reply-To: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0277.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: a128b72a-1010-4ef8-f3fa-08dbcab1705e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PD3q61PB0HMSGZ0jXooUiNRerKoU/gEgZC98daXIjtcBohpS/b8aIYB06QCvrvFes2v1M+BYZrlZAj3Xmt8q/TrB372yRNkwo8uSSiYPxsvqYXYDNKsdLYs1RLDRnJ8egFNCYE+OPmS/l5MDnYdC6dEv4fiCL367xMdWZPWbkeMAqjmxN6i7eWkMln5ouymhnNQDTHWt02lyW0yqcv/Ilvy9CkeiJsgV2RnhoaAgWVO4xpIS9twAPH3insn7EzUkucJyIPr1CHNCzfcFaawjnGQPsf786TP1ZgIJR27d6eOopeT2+GkC0c+DNEScmhHKICvF3bVk7xuWTBjBKSYMGgzuQiPdc1BtscgoIMgtkqSK70BBdQUQikefpU8k6V0LvkbARVJ5zBJsl7ALa/+q2RvRhHRmDFVujTWbId88Vg8loE+N/0wu+87RYvfbqCzTmzcA8RelAtMq34ip8pQQIQXMo4M5I29LmtAzXB1cFOq1ZIh/0KVcTU+c/CLbPT9uHSSI1C7apZL2lMOR6SAgQMrAWEhcTa4LVZOBspHhA9LqYk+cCy4C69F/Lcs+uxTfhaaU3eh2zhwC59RcmxKJ7w0rmyV8TPe6+UOjvVIZgJ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(66476007)(66556008)(8936002)(66946007)(316002)(54906003)(110136005)(2906002)(5660300002)(41300700001)(8676002)(4326008)(6486002)(38100700002)(2616005)(6666004)(107886003)(36756003)(26005)(6512007)(83380400001)(478600001)(86362001)(6506007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0z+zWeFTm4pf1JcArytT0b8BzXIDduqsqwyxREvuI26UbObuSGf2Defp5dSd?=
 =?us-ascii?Q?ETCDZfHnmYBrB4Sy86KfP0QkKDuZUC+craGrtcoUUBazeltZFX2PEvFtTgVI?=
 =?us-ascii?Q?xmIx+1a1W5Ug52Gll6iV/hsM07QKN2g8rS8VY5mo2Q3kmetyvnbsDWfSCWJS?=
 =?us-ascii?Q?V2+0Gli9zv3A8f9qrp2DllIxRM0P8XrIBs8+55ilPWrLQj9WAagCrKD53dm5?=
 =?us-ascii?Q?Dz6BbaYdESgTasWHHPZ74XilDibolFWtNZnkIJPNxikLuVAEXOEt8ijYQSGb?=
 =?us-ascii?Q?jLeOw/J9K2bX1CPv1qFquBeZd5gYdhITuGxhJlczqhZcOCmrvuZIJZzgBeWd?=
 =?us-ascii?Q?9SzsnBwf4Z61onC73dcV4Zf1iGvwqxPRORgaXctSHLkcmcEpV7Ae/AwEUMk/?=
 =?us-ascii?Q?OSsBT7M+0XIpOyNBmclW1zhKtX5FN2jTw1CZNtPaYWFNSPRfP9mjRD2F1EGS?=
 =?us-ascii?Q?O2/i8DGQIILRSEhKjKcZ8mgLln4EegWBvL9iXmn5l3pjz4drkxIDhDZGMJpH?=
 =?us-ascii?Q?QYk5jlpVMxFkkr/izzHEf4jZtYaJTAyXYbn1CaFuWyDr8HK+4HlcJJ5GuoKt?=
 =?us-ascii?Q?nnZ8JTpr8sDK4aEUD5lZNZerdtnm2kDK8YdfakujVi3irR85EGFfbtIpt+ij?=
 =?us-ascii?Q?Cfm8gxkXaPpce0T9qzAxNUvWkyqaTr3Mje0X9I6dXcoI48GjE8Mx3izwFx0Y?=
 =?us-ascii?Q?CYH7GEy1jUqtOKGlYfk+pMRswLa4R8cjwrhgqSzGgywA0gVJGSA17sJ154a/?=
 =?us-ascii?Q?LX6fvVQuTGsaln7aXD/4nYGPMUuKMO+MYUbQBbd3lp5v9fhPQO1ECqYiI9iJ?=
 =?us-ascii?Q?IrBs9plqQUg/6C4r0l3oUVRthUXDesclQsbYy4dwDYix2c0m+2E/bBUSxE1c?=
 =?us-ascii?Q?ffGIMUgCKj8XTCbwzqmHS01uHshHRFkzhoT32JmPDIcdg4oPzahmAqlomNX0?=
 =?us-ascii?Q?rqI6En9h6QpAUPhiN/gAyChytPa5yqRosVKBTXB3+7502/c9Qd6VCFRBU5fB?=
 =?us-ascii?Q?S+61akD1dojHs2WyubJ+jcLd6eXGjHzuuVZRPqOC6EwNBhl9Zg3VmyjdfSqp?=
 =?us-ascii?Q?JSkFo0f6AlRbvq9wckm/h3shTkFbuUH9aWt4aYi2Yb35xhxoL0HseEMVCf7G?=
 =?us-ascii?Q?RRdS/zdSJ+4/QdJrC0BzEkh8os6vlJkuDa0RUJGkDjaC0+jDIMwrd4KRv0CT?=
 =?us-ascii?Q?NT3SyuBTRGdgqSdnOomIcuSNaTM5QgL7JwVftxFSXtnGFYRZ/C1d08gxashu?=
 =?us-ascii?Q?WkOogFl+rmd3GLMI8BaWsnlSaum4dbqq4yh36SwOyMDC8Ttp6ZUvqnyoZ+Wb?=
 =?us-ascii?Q?I4183IaQEKmtzWCcbbqPRGcw1L9Mm2qkh2lCcm8suYHxZ00sL2v3CRfU8UB0?=
 =?us-ascii?Q?1/6IsY82YJL4XE5F/hikYmvU3ezONxUcyVLaoqsuceqdgEVuOUPYlgvcZQLs?=
 =?us-ascii?Q?xIdk9E08Nz/VyGUTnV/K9OnuwohpfKJFTYFPmjEBYHgPhVCFG9yJklIaIL5k?=
 =?us-ascii?Q?pHp1z41t4b7A/0xV7q17KAwePbJNO1V40iW8Iz+ufhlR7Ov2kycJBGkmQ/TW?=
 =?us-ascii?Q?KVsOvpoyBcGZKjvcjjuX/PhGss342QhPIDKl/wip?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a128b72a-1010-4ef8-f3fa-08dbcab1705e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:26:04.7724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tH2yg+YZlT2Mi/4HFF3bYs/vVrHw5LPUEf/8t0rpVbY/jS6ubUhNL6jdyG+FuVn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

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
index df66fe43a9853f..6b1896b18d54c7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -382,8 +382,11 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	int ret;
 	struct arm_smmu_bond *bond;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_domain *smmu_domain =
+		to_smmu_domain_safe(iommu_get_domain_for_dev(dev));
+
+	if (!smmu_domain || smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return ERR_PTR(-ENODEV);
 
 	if (!master || !master->sva_enabled)
 		return ERR_PTR(-ENODEV);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3952fd062c523e..b527e635a3043c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2461,14 +2461,13 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 
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

