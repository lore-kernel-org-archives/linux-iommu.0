Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704773F4CD
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z3GCnabt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S746ox8OhHiKeO5xkVWE71vj9G2X5sZ3daRzPPV7T3m89LO33nl/llm8DbfLur4M7fwnU0a5GixOtAYArKcEUD/XD+EibhW5lMIlwxljuhrKIK78Br472SXjsn/0ZbsbSd8dCB369jb4msZ9UQpWR6YNXWAZpw7AkkveWy8bGcoGxZXmjO4HDJqMJfHxqnvR2dvMm93qesXLSWr0XwZgbb3twW0lGwjr2mUSGSzXrKLR3xItTARaXJ4xCi3HcXD5f1d/tRZFlPQ2vXy6X9HV+nL+wb+l3LzstHRS6oVQ/Y5IqlV+PIWF228OEqEYBPNAA0ynCULppK1gD3Gt/OizjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/rVY/VoNrRAhQGsnO06RCuVJ/4J3vnwW6B7/TvN8L4=;
 b=jEdvvSRvPXDM5LfdZglQil7sON+H03ioMivn/FnMOEww3yhvW+uMTS1Iglvp46mBpusqCnrleXg8QLHNjdBta6IxgAQz1Cs0wBtaloWsMG7uS0DWRvqq4Ee+Ku/QXzR1MSy1xrnxcuHU+l9SDZRa6sWx91feLW89VZSp0FFvj26yEB+sNU3XW/tu6gia5cPhzo+rt8DCn6fciLmytFKFl9QwW1Asj1rYYLPMNiTXCLcD0roZaQ4NqixEIIvX4LXnVOGskEQEaH4h0QNb8kFsdAq5O2ZLXzXkMWT0FNMALylYtlnifZbLycSutXlFFJhlscs5jzJSZ+GpejXTyYSdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/rVY/VoNrRAhQGsnO06RCuVJ/4J3vnwW6B7/TvN8L4=;
 b=Z3GCnabtnWy3jwHmSlkVwCcq3BkXBlKfxYJQLnmsKuuuGHH80RdIKeFnY5kE6LMbkxr6d15YMLja648epLfP+LqwNIyhkqsZgZJUXr/4BDhpqQgZ7PnqknhgYbhYR1elesq3Lq35Xayx+Z8SooXBe8r/tS0KrzhS0h29Dfz2ZoMf6fDb60MfckMjN9MDzzWKw58xwVRks1Q/qysnNvPdsPtDqV09zzvx1JWcsU3uJ1Bse2k5Zbru6g4zSUEOB2Xirr5d/YaWwQdRo/4zqwt+NfLG64phgC4MP1XL50wHo2A/nRx1oYZg9pZFm2KEQ4sKIcTUFRbl/5sFwB1U0PvY3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 18:28:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 18:28:20 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH 4/7] iommu/arm-smmu: Pass arm_smmu_domain to arm_smmu_init_domain_context()
Date: Thu,  5 Oct 2023 15:28:15 -0300
Message-ID: <4-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
In-Reply-To: <0-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: af19bf3c-e154-419d-34c9-08dbc5d0d9ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7h96yXkeAtFMwe4Wthf6UJHYVgy1rrvarSyXYTzvkSMOXR6jCNYqMVnTMFcBJxiTMl80yQ5/50LADfZ01zU892fSMrkZkIjAtzBNLnbed/cDKqFm9dQz1KGKlivkS8QpWeTqsrTjxVo0ilKf2x947wqmZVLEVCs/mJzVZwd0gLvTB4MIYNdm6teeXJmdTVIMwf62OLXeyLs5IXi3ZC8kTzHD6l0bKbm1KuIZFvKyCsU9M1brBnFO7KGROaCBNH0Bjj59wJHjn5vD5Ue/2Xirjoz0/u2+inaRPGywwdu+gX5ouxIvnugEZM8C38bbuIiqd1iUix06MwMQNdeG+Bf5eWO96OOJLNmU22zM2frB7TiQ6dKB/xFRkD1XUP2gPe4Xk/cESgspg9lgOIShFPjI8qft9+MOd5VDKgTBti3UpRIcWxTMsOZ68h87ukK59hNp9ImvDGakG3BiIgy036lCFPQEH735nBXO5VKqgS8niFGlsXOXdBJW15/bRVyvObmfA+eTw7OIqCnLNcqh2ubk0VU4UcGu4rTxjbaXeQpwBKDSEMG+EnzGKqc+i7VHu8qLJ00DTGiOgQZ+pyxxlrw6I8tIMadZtKbQCjhvDM7kFao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(7416002)(2906002)(36756003)(86362001)(38100700002)(2616005)(41300700001)(4326008)(8676002)(8936002)(26005)(6512007)(6486002)(6506007)(66556008)(316002)(66476007)(83380400001)(6666004)(54906003)(110136005)(66946007)(478600001)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AL54uT+WjQnLfZxjVBQxfQktHAXuhPyHfjThW08Cf8odF6muwIZEm1tmdLfE?=
 =?us-ascii?Q?sdYj+LjVnesAj/PT8zo8wjLZhEj/m7+bZhef6PvGrn4VlGMjIVo6qWWhozXU?=
 =?us-ascii?Q?4s0CpyJtd94VzqmqTr6wVSarmW3j6WRkQwAvhcS6pAdLp2IqmePGOC64MR6v?=
 =?us-ascii?Q?8qzUUseOiBeiOdUn7I7THEWovggirwFboKrjB/r+C8oNqkzNqXomy42GM+xj?=
 =?us-ascii?Q?yvFpe8nOpqDszhxMdlmOuL8RCDHfYuRtz81i6EuDQqqy12GlPnOcxONS8g23?=
 =?us-ascii?Q?wEYv+mI0aqy9kavt0TkXWGt+QW+ctWX8fyEYLJMutD3F+1JkQtt6f9kKSLZE?=
 =?us-ascii?Q?Yt0opZei3RzSu/32DpyQFWwoAsmffL0rO4mWn4dMfoYb0ba6jiTbPqE9yPJ/?=
 =?us-ascii?Q?xHqTvI9J820hX3bFpeelJ+iE4RgGWa2AD/lHA87rsE7yPCD3ZzxwSuxuEBol?=
 =?us-ascii?Q?s1ddvQB9fmkggX7UMxEkC+PhqaBlu8XiAazweS68CUWvqmt6w9DLJUrCc3ie?=
 =?us-ascii?Q?jEQZ/+TdX18ItEtwPAne6B6ixTd3vz7nXwW3bBDN93s93Bzfx08BmUD9w9S2?=
 =?us-ascii?Q?lqsdXTp1Vii4XqbVoFa4ytJCHsnjoFwkAHaaIcDJ8qaaKScJ0jWteC2V3KoZ?=
 =?us-ascii?Q?NHJIhs3fUi2hAlaKVFEG0WwZKfrK2cPdadyOEl+5qn7JSZGZH/XeHITn6EFn?=
 =?us-ascii?Q?9iPKBPcrhE7/83lhFI2ha2Ul1b5rx8BABrEnD4sHI57T+izsxccz49c2ssZd?=
 =?us-ascii?Q?Gq8x/oiirleQ5i3Wzqm/LG+e4OThqGEzL1AI36F7gW3qcthcEAgIWN/DrMbe?=
 =?us-ascii?Q?j/mTj7RV23F3Ph5Ueh+0pRVYerEayTQkhHlLfLAHrF48PnA/Ecerc/Ze6bkk?=
 =?us-ascii?Q?atkp9ek8mK6aM6Xryk9dp2Hpf7L0tq64MWM5b2A02fct2lnBNccTYrOudpP3?=
 =?us-ascii?Q?I5BrFbUBmxBfiPVVU2gRl3T64FqZhT5mYreRb7opvOHI5MpY1jv4HverCGeG?=
 =?us-ascii?Q?XfoX9i4FjQ2JyVFfBUm8sFCnITEH4mCAZhsZqWArxMlh4agRzDqML6WoEKJk?=
 =?us-ascii?Q?kvI73Nqj/GMIybxVvxrbpgpstJtfXqWXo3BU7f0tmXmgnvjRq0GE14A6yJBM?=
 =?us-ascii?Q?C5iWrileCSRGYjF6F4TKI8BNfr2RO+ntwUCxKYa9sFnMWu3NEah68YRIW0+K?=
 =?us-ascii?Q?NNo/r+BK/ZalneK1JUpaRtbVi42co1hQMDRBqZJ0lt2qUjJ+r36U5Df08c2i?=
 =?us-ascii?Q?wLBHnKdgZUYJ2/6dz3fFpfxO1Gs47wjh1d8PUNUGirDsKJ+uiER57VYOwUZ0?=
 =?us-ascii?Q?3g+f2FmjpAlOaS9Enkz9aS4NWGldHxLG5ec6c3CGebTok54F8hGRA7xvIMdU?=
 =?us-ascii?Q?jEcveHg2N4bWlJdHFO0NVgPdNwGazWmSvYSSHSwoSbgM8oItimX9oozuYRRf?=
 =?us-ascii?Q?0ea5XJeHzeaAOps0Wy7lUY2r8czjQpIYzuSMJpmFHxgZuCw9mTU7YBZ+mFyq?=
 =?us-ascii?Q?URBoGk6cSPRGCA8Z4/EX+OYWHV4gzR2VTqz5Y2YKNo8xcRUUaxRwJhheIAvK?=
 =?us-ascii?Q?ZV3gf/RYTeCK2N9wb6Rvo/eK1sGZWlpeh+PK4xG8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af19bf3c-e154-419d-34c9-08dbc5d0d9ec
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:28:20.4100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0ZJkYoCveQscr/j6QTI9ISAK1homAn/n4quVytwrwAkGKMJDHwTgoHMOMIWk4c0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364

Instead of putting container_of() casts in the internals, use the proper
type in this call chain. This makes it easier to check that the two global
static domains are not leaking into call chains they should not.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 28 +++++++++++++--------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 0fc4f2e8bf3ed5..bf5f541be2399f 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -393,7 +393,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	u32 fsr, fsynr, cbfrsynra;
 	unsigned long iova;
 	struct iommu_domain *domain = dev;
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_domain *smmu_domain = dev;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	int idx = smmu_domain->cfg.cbndx;
 	int ret;
@@ -607,7 +607,7 @@ static int arm_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
 	return __arm_smmu_alloc_bitmap(smmu->context_map, start, smmu->num_context_banks);
 }
 
-static int arm_smmu_init_domain_context(struct iommu_domain *domain,
+static int arm_smmu_init_domain_context(struct arm_smmu_domain *smmu_domain,
 					struct arm_smmu_device *smmu,
 					struct device *dev)
 {
@@ -616,7 +616,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	struct io_pgtable_ops *pgtbl_ops;
 	struct io_pgtable_cfg pgtbl_cfg;
 	enum io_pgtable_fmt fmt;
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	irqreturn_t (*context_fault)(int irq, void *dev);
 
@@ -764,16 +763,16 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	}
 
 	/* Update the domain's page sizes to reflect the page table format */
-	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
+	smmu_domain->domain.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
 
 	if (pgtbl_cfg.quirks & IO_PGTABLE_QUIRK_ARM_TTBR1) {
-		domain->geometry.aperture_start = ~0UL << ias;
-		domain->geometry.aperture_end = ~0UL;
+		smmu_domain->domain.geometry.aperture_start = ~0UL << ias;
+		smmu_domain->domain.geometry.aperture_end = ~0UL;
 	} else {
-		domain->geometry.aperture_end = (1UL << ias) - 1;
+		smmu_domain->domain.geometry.aperture_end = (1UL << ias) - 1;
 	}
 
-	domain->geometry.force_aperture = true;
+	smmu_domain->domain.geometry.force_aperture = true;
 
 	/* Initialise the context bank with our page table cfg */
 	arm_smmu_init_context_bank(smmu_domain, &pgtbl_cfg);
@@ -790,8 +789,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	else
 		context_fault = arm_smmu_context_fault;
 
-	ret = devm_request_irq(smmu->dev, irq, context_fault,
-			       IRQF_SHARED, "arm-smmu-context-fault", domain);
+	ret = devm_request_irq(smmu->dev, irq, context_fault, IRQF_SHARED,
+			       "arm-smmu-context-fault", smmu_domain);
 	if (ret < 0) {
 		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
 			cfg->irptndx, irq);
@@ -812,9 +811,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	return ret;
 }
 
-static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
+static void arm_smmu_destroy_domain_context(struct arm_smmu_domain *smmu_domain)
 {
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	int ret, irq;
@@ -835,7 +833,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 
 	if (cfg->irptndx != ARM_SMMU_INVALID_IRPTNDX) {
 		irq = smmu->irqs[cfg->irptndx];
-		devm_free_irq(smmu->dev, irq, domain);
+		devm_free_irq(smmu->dev, irq, smmu_domain);
 	}
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
@@ -875,7 +873,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	 * Free the domain resources. We assume that all devices have
 	 * already been detached.
 	 */
-	arm_smmu_destroy_domain_context(domain);
+	arm_smmu_destroy_domain_context(smmu_domain);
 	kfree(smmu_domain);
 }
 
@@ -1125,7 +1123,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return ret;
 
 	/* Ensure that the domain is finalised */
-	ret = arm_smmu_init_domain_context(domain, smmu, dev);
+	ret = arm_smmu_init_domain_context(smmu_domain, smmu, dev);
 	if (ret < 0)
 		goto rpm_put;
 
-- 
2.42.0

