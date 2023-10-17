Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA32D7A8
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L3rJJ6hi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AY0Ao26eymeAyspN1UfhMvUV1U/zYpPt4kM6T5lCLt9iQ0DYF2XJVIQhMnspyAxgiBNOLRfumLxLEe3IkYRXVDz1OmV7Skhg/dWoE6j32QTLZlqLznUVLOyskGQ82N1gvMqayAECJsaGXgq+PzUGVtJ+rBUMuJ8AxhRCTLdxBdDTIqd5vHuFxHvoDeCaBD7v4ORMo7Yse9G4SpPMaiyheUZOqkAb9d0PSoqMRMrlxJLpW/on/Vwcswl/Mg9hAz4GR64e2mXs8h71xHflJKbIrR0vTVkN99ylmlt9rDXAmsCXLT3JYlut7ozAbohoItZwdpOsVfFULpx8pmQ7PnJ5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxEV1WTG1l3HCh03zyyKxcnuf9NEqo5SmpXhN+Xt7Z8=;
 b=SBNNaPGbyGsST9brO/+ytCADpIM0VMQ7GA/wVKroMksECQllNpW7vXJitQjI3It8pXd5L86q5bd16bVTTEBZw7CCEXB2QBaJs+OPUpakmv1yYBbRj25hSBWOsX366zGpbAcec8V7LWl1HX5DHuX6Gq8PbAhfJBo3DXdv+zRV2ztpCAzuIaTDZfDEQR1E7H7ARcmvFx42SYwJkVV/dHoF9L6l0MWXMrQpguzzyl+RcensjtU5sFHwe25gKLX7WBbzmir/+4PfxWeDIjM6CUV7CMRZpAdV8l+ZjwbaahesK9+QAJX4kJSlnGkJGJL58hdeaN3HsS1fVsVZ8K8cztmnoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxEV1WTG1l3HCh03zyyKxcnuf9NEqo5SmpXhN+Xt7Z8=;
 b=L3rJJ6hi/5K5WnsXQDwwKdthyW0lXjFM2uoT5+Ah6PTNa0p5faig7b8y8uPU4MJ6pSFzMk0rCyLfk/nZG4cSczOZfJhgHMrVeI6bsX70r+dU0phFpxoXdeNiW/NOKmXYPWOtcZ1DzQKg3T/qF5IjNw2/s5QVnLUJPtesWdqJ6ZRUwzhrkSdHvNWaoKYnksPfQ1gs/Dpd+FcUyr8ok8tEI6QuTy4szLtf7lSeXwt5LNbsZBdbw2+xFQtkB54t7hDSwFWBxwIdpUM8EoULf4vif8ucppI4UmNpW3M3sv4RUc41TqHi3K4dS6JoMRvJJ9wVF4ATLE7l7C0eD+yQuBHnMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Tue, 17 Oct
 2023 18:11:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 18:11:47 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH v2 4/5] iommu/arm-smmu: Pass arm_smmu_domain to internal functions
Date: Tue, 17 Oct 2023 15:11:43 -0300
Message-ID: <4-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
In-Reply-To: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:408:94::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0328da-3541-4af7-9368-08dbcf3c8660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d1EaUp9aE2zDuJIo2uDj4tqk0tI95UIw5zULWU2ZRl+zEONhB3uNzvglpMsk1lwEDMrMOlN9MHImcTFGwbxJU69tPyjW9qlTZMYAtUklqufVpX7gwtrj3evSneksUWLZPQKd0UtzIIYH8gXgnlDaoQWXa1Wjd7TEwq7gQYvNc4JUQKbJeI8xNip+L8fn7Tv4OMYs1EGJrfuUqP+drzE/Kb1s2ylJHpWmaQyTTC5cveomO6ZyTAY7/XDSEtCwLirVqbi5hyfgE04l2IHr2U+gIEqOMJLXjJ4Y0kVJI5DHmBrggq7CIpq0l0KdYRK7FihWL3jLPrNr0WgKTGfakulfeDNA6iLegCyNlnzc/6DR/irYlZZ/eRS7oYUbJJnq2hGNsEBu6rshN9fWYIonp5esroYK/aBFKrnIGMjjToPyZHgW60RxaS9DdxSmboNa2YrzAENcGgLZnN+Ox4Gg1YAHpL8J+9MhYGNWdFh9nGrR0yenqPnb6oWRkiXCY7Uz4mfY6Ln/MSS/9v1s7Va11bVCySgQaPxHdT6ZrOODRLyKOiGoM3oW0O4xn/YV4Pu5vy+8TaW+R1J7mGYNS8oqzyZVOcG+cqdWby2kSqrtA0I5v2w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6666004)(26005)(2616005)(478600001)(66476007)(38100700002)(36756003)(86362001)(41300700001)(107886003)(6512007)(4326008)(2906002)(110136005)(6506007)(8936002)(66556008)(8676002)(6486002)(83380400001)(66946007)(316002)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3GB3/JmRHV7X2FDcTKlE+0znPjp2G2r25M668tP3+9ygc8WYzTMNBcMOHkHF?=
 =?us-ascii?Q?/2HSAnkaoz1CNbckOAHpS+3jniCI6aM+TlsWHRjRdxxOW7F9sfVf0Pt7yQD3?=
 =?us-ascii?Q?0EWHCFrZzm1d6rlHoE0fc3rm6uTJmh4zOFHh7sUIkn/YrUGscrB+AOmc1Pvl?=
 =?us-ascii?Q?QhnGxDADsfEFOd2n3RR6NimmMouD7Ge4DjbMfhx1/4nCh6ClRtNdSExnDJYP?=
 =?us-ascii?Q?+sY8dbhimPEvhFlJiAJByk7LsZ+tDXVUSh1xrn1/FaFUERMOV8v6g88sqjc6?=
 =?us-ascii?Q?XxF39corHUzi1MdjgnR98uSxXMEi0oAfZe+yN5gN0isteiSpNZHK6wsXpwtY?=
 =?us-ascii?Q?z7yF2nOPq64VhLc/XLB99tDc4EOdFPUqp1Z9EOrqb2TyaOVTzH9+uSlpPHyz?=
 =?us-ascii?Q?MxBbRH3bZ4esd5ufpvk2U+aEFAL7eeVbvbaAIHEF+GKtdQIG0upg7kH7elSo?=
 =?us-ascii?Q?bd5q9hdWxZgyFI4QzNHd0uRC2ZxAXXtxtF6Qfgf6cKAD4TShh/+cnrtvq3FO?=
 =?us-ascii?Q?vLIFEZbSSZAU5QMunBCYQxxd9PGwlgdce4CfqICo9Pt9diRFC6IDmCw1ofxU?=
 =?us-ascii?Q?WzZaq+J2Dp0M8hYLtTfgok8De//uFcB65Mt20t8ZdwdL/a+9icA0KaaSsZpn?=
 =?us-ascii?Q?0EDS4Rkj+AJ3s/kM8kqOf+sBpTdauW1liULX2tA7iD4h3y3GSe95FiaINNen?=
 =?us-ascii?Q?P89twWUKYfzBiqVQu3aFxuZbpLL/axwUT4syV5mDiMiJy2fCeKhHAKO9YMjp?=
 =?us-ascii?Q?5+p2U2ci+kCiMXYzz8fhFhjc+IXNC2xE9hm3IZawUSd8Qc78cppwqXBXRWsm?=
 =?us-ascii?Q?/RBG1lpnIS5hhGE9o7KCV7VXx+Xxc17XlhCSAZ5RzHPDhLWWOejicIh0Ro3e?=
 =?us-ascii?Q?565AmJD9iEgv1KVVXHhzj4B8J2ZNALlvNn/FMH6DcQ1pGkHGGuWbG31Z0Jiy?=
 =?us-ascii?Q?N42k1A5JObchrHVYlXkCyMjJqNpyAp6zovC4y/tegh/yI4prsgiNOjCWRRRM?=
 =?us-ascii?Q?L2b722VJPigi9b8JCNAfWOEaKVwk2rNoQvS/+TIj5ZZUUIfw/K/LFHylnYay?=
 =?us-ascii?Q?Jl4hdGoBjHyB/CONtptPWvhz4NrMXV1QpoTokAKhkeOsugjEEYjgab9ojVmV?=
 =?us-ascii?Q?s0EEIyyXV5LN1xa7sSHffUhuDQEPQQ4iE6MygcMsHFp7hBvsVZxSOeGjaWVc?=
 =?us-ascii?Q?49cDI6iySpUmpUpoxzI7Pl2y1aFEJxmVG7JqyUXM73ck/y2RECKX3aWgHkUg?=
 =?us-ascii?Q?fsSp5YcX3iIxQjM2tERQ/cD+7g/o5UgZKUmyyolp0ecVDaO8peczlJ4bMO6K?=
 =?us-ascii?Q?YnouWzWV8vUuz984APWHCEP6xkJRpsA8hyP0NjZWWYeUZe/B902bLuf29S+z?=
 =?us-ascii?Q?QLTGHg0auw+YHLONP7OCARCMnc+saWDcTsdlG8BNAdCSay9cYfo/8IaLU3F6?=
 =?us-ascii?Q?k4mOBTbTwbn1k859llXxmhJ9gQmcQ8PJIN+nkOjBOoR1ox9FbfoDuY4cHVaC?=
 =?us-ascii?Q?iAaYtM+i9Er4iBso0VnBf+9v+gNp38H+swbz5/Xb1j1+tEALcpQXzpVhI/yU?=
 =?us-ascii?Q?1jj+aqcnBvIgWIawdsasgSV+/6tqQ2yPwyF1Mh5T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0328da-3541-4af7-9368-08dbcf3c8660
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 18:11:46.4526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nF+2Av1YBzylLojfuDTEH4POuF36y6liJtOHLvLoRBBOgVVj0Uui7e1dj7dSdpQD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265

Keep the types consistent, all the callers of these functions already have
obtained a struct arm_smmu_domain, don't needlessly go to/from an
iommu_domain through the internal call chains.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 421f3a13c6a9b7..6340ee8ab7c482 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -392,8 +392,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 {
 	u32 fsr, fsynr, cbfrsynra;
 	unsigned long iova;
-	struct iommu_domain *domain = dev;
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_domain *smmu_domain = dev;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	int idx = smmu_domain->cfg.cbndx;
 	int ret;
@@ -406,7 +405,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
 	cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
 
-	ret = report_iommu_fault(domain, NULL, iova,
+	ret = report_iommu_fault(&smmu_domain->domain, NULL, iova,
 		fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
 
 	if (ret == -ENOSYS)
@@ -607,7 +606,7 @@ static int arm_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
 	return __arm_smmu_alloc_bitmap(smmu->context_map, start, smmu->num_context_banks);
 }
 
-static int arm_smmu_init_domain_context(struct iommu_domain *domain,
+static int arm_smmu_init_domain_context(struct arm_smmu_domain *smmu_domain,
 					struct arm_smmu_device *smmu,
 					struct device *dev)
 {
@@ -616,7 +615,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	struct io_pgtable_ops *pgtbl_ops;
 	struct io_pgtable_cfg pgtbl_cfg;
 	enum io_pgtable_fmt fmt;
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct iommu_domain *domain = &smmu_domain->domain;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	irqreturn_t (*context_fault)(int irq, void *dev);
 
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

