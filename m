Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E43020F8
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 00:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H0AwupG7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQakWVh24CRHpuf1A2Ery0McuUxnWlthosvfXv9mENOK4hUP5SvuffyNXXJlVjq1wDl+Fe0zE7dJ0LaSAWMMEUKQbRsghVVTCFNYbewBc08GCWYspQ+IhN0Wlb5o4S2capLc/LTQX8hW10zRgRywWMzUlgg6zG/OqvNf5vfaXyylZ0ZjucEq8y8fWrIg1+dWeSfQmIrG0qieCWboO/5iX4X5FJ1mrJADtsOUDSdbd7wuHzsO0pQMs/8LtO3s+LW0YCU7ao09LK+wJTEEqlycwQ51M5wGftm03AwYmzx8MDdbVz5cH+IcXNF20pP8kEYjgZG0ht4F2fGYJCINQPQCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72o3XBxKUaRgMD+8q+wJGvaPfgY/xZUTxdrbN9ncAhg=;
 b=AGCjRTLW1sk8o073RU/1tOV/qWHyG+xPCUL/uyJTqDYqJnn5zXo4JBxgBzuI18XE+l4YmDnOeNYGPmw+9SwIlewpN2QRG6jvKWp7vbp4K+Aasq19kiHCc4Q5a5BnHMP4kc/7/VOkesWdwRaeRuSQE6/2gMqDDXZuul4mNf/lfpd6Df175ggRuO8syzgGyiDJevF1zjgH9auNV9RuMDtD/rkk9d98KwMINHQdnKDbl9I6/ZzFH2nhOi/m54ELEEyhYfrZxC3/t6O56VJz/HMqBm6heuRln/Hh1mvpTMWU2pGK8L7BGx4OYTx+2nuIGzRAMLF/xy0SHQLwSVXyJDCF5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72o3XBxKUaRgMD+8q+wJGvaPfgY/xZUTxdrbN9ncAhg=;
 b=H0AwupG7PNAgIMEKKsClbDWiCu6PcpwpB30efnvkXL4zXuzJozFaRRGdReYDPbH6VfXLEwSWq/j+CBB2AQmfO1aNt5ewqu7Ug3M4G33P6CaFFZshaGc6RzHVa7msgS11htZhiuMI+g8ITKr8VGDP/pjB8oUH9uGZU8iqoBkCXV5W+XZ8EKckOXfOIJGp42pEfZudtRUNGEhO8xzaVE3St14T/DalODKq72aMjSeoYs4XwAb37nhRXw+lNcb7ANjWCWOZ+Fdn7dR/S3rFcCNMoEYMHoSanm8NWK7YsUguSg/M1eqckF3d5xcAXtG+wn2Hy/aExE/kmYRjwogQNxjSsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 00:33:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:33:29 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 16/19] iommu/arm-smmu-v3: Add a global static BLOCKED domain
Date: Tue, 10 Oct 2023 21:33:22 -0300
Message-ID: <16-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
In-Reply-To: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0397.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: f4457024-743f-42af-d7a1-08dbc9f1af13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5Tx1Gbl7SflGCtUYSwkA8UiqB+++DYqyhkKKYBxSdU14S7SkR9+en12QYvzzAqAITmIEkExi04yqj0jlxlEuiUkE74qeTbNYHgoVZzF56EU8EqjqQHucAv/KXMBolsjiDVdzgJRldm1b3JfyYdUjE5scvexIh/y3CaBKronYHgB7clyOXVSbJzfcs2fmS2V6pMRMwV5R/f+NKRv4s3g6R9DLCvNLFpx/S4+NOuY7S2lupamd5QDmUY0gSO18Aka7bsp9d2xq1363uHIaBWamRbX0hrGP2p7QnuH3QoBQHZMn4pH0AXQu+2Y6Yqx/qiYW7ehe1z5rgSgmrSbsveP4RB+WWvUAWkmm68D0jjv8oAB9PvUuW0lTuRi7ApRHcx5Y3JJx5Hlq9+dJ+I02tfjSgnf5/lXNM3cchAdUx/rn6RAvN+tgKr4qKFwrxZJZz/ncpP0Sm+/JqKnrkPC+10nHlbKRuz1tnmEhMBbtl/cwBQOxrxY6P7GNIZ+MtDxcNLw16dCktFfpJWZ61SyciCZ7Rz86S64WZKG8ujw86den0hDnHYNBefe7nuiQv0z9m02/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(107886003)(6512007)(36756003)(38100700002)(86362001)(26005)(83380400001)(2906002)(15650500001)(6666004)(2616005)(6506007)(478600001)(6486002)(8936002)(8676002)(4326008)(316002)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xgEw+0zcLCVA7LAvpTXPWyP1HZCgNf5GR5aPIe4YmO0vKiR7CsgN/ytFAlIg?=
 =?us-ascii?Q?l67EdSYG3Asx+JOmKjciGeEbDVvCTCEdQ5pe6aO3nAt3L2OvOeQCiPq1CATG?=
 =?us-ascii?Q?Eh6pRIe4+N1G8dz4JQIBOghnOgpgPhqtxOc6M0VJIlYLZ5diOgHdXvX5DV5M?=
 =?us-ascii?Q?dom9ylAE9yUyWV1WBUPatoBsfn0mBEfotyoV5LIyvxSdUCAhiBRJrNxLWUH5?=
 =?us-ascii?Q?OSd1m7V5Mpup1s4K/62f2V5GQWxOC5DDtewoBm/CdJBIr3rgjG3ZXpKHspor?=
 =?us-ascii?Q?+bY28guENdWQruTG0x8PbODaosjA62etg0qDP5CNKz1a48MtznCl/QVQS/iA?=
 =?us-ascii?Q?SeNgXon6rlMZ56zHK8roLorC98/CNUY5OOk1DCcEj0Q8ZYtYfbcr3UUXYVDB?=
 =?us-ascii?Q?O21K7E7s+Fou12AwhLyEUSPPRXv0HrGq3g2iX0T0kLj5Tl9uW+jChD/Dbmjz?=
 =?us-ascii?Q?mcDJjXVC0biHvsv3GI0fdJCI+5K1ANEnKNUNXM8FTYimw7PPlM89wChp2CWB?=
 =?us-ascii?Q?xiae95GNEh/fmq3V7o2oWQ7/IeNJDkPn49KmbXFxAsRSXK49UqKt8D+n5f5y?=
 =?us-ascii?Q?VVKEszkYnPdX99qy8lKSXeLsJD31z3RjhPnbfEpFaLGBdnRdNdOLzuvQNJCo?=
 =?us-ascii?Q?KenLkUePAqTObYTum2HuSxBPyLx9Iqa2zdbE9Ov+9m+XBrzmoLM3eEIOQnJe?=
 =?us-ascii?Q?9XMqhyyWuzspSyKtNjqjA6AhDIl9zbpg+z4w6mUb11IYKeMXICWV9g9zRFYC?=
 =?us-ascii?Q?xfWp0l9v98Ja3RxXa29FU2XhYE7Yw11AgFjbOZX2FC4Uvl5XU+ua92ur6xCd?=
 =?us-ascii?Q?CvJbp8Ta9lXHssO5vbgdWn93mIvY4iGEh4CQUWcdakUwbX+xEyFboXYzm4H0?=
 =?us-ascii?Q?4UHSNdp2+n7Bdzz0oe1eg3/m42XnK5LeNwryj1QHdTP+Zd39pc96Z4yVdkYv?=
 =?us-ascii?Q?PHqHLC1Dim7VbxtiZ5+u5Oq7JYZve3FAYLRGokQi0GwPPzVkzkn4AZGe3vIC?=
 =?us-ascii?Q?YeK34F6qC5zNpvmFACvLb6Ap1DHh9ItzW9UDu1t4aj03gLoT53ml8mH6z9t8?=
 =?us-ascii?Q?GQ+2o1OyhmIimy5FDuNfaJ8Qem4VnYnz690RtkVLKZhSV93/LQa5n0SFS90P?=
 =?us-ascii?Q?NyniwU9iMllshwYk02dAlJOk/Uk/gJ9Ys354rseFRQuBehA6pTozqTm8sMBF?=
 =?us-ascii?Q?Lfp0h9SYbnrXPgbtw7QJX5T8C7eNuTxlxRTVu4TzneFx0PDQM3NJVvdk686a?=
 =?us-ascii?Q?nTUuHB2HGKSvxfnOBtgVIP/EalcCYawx3YdTEDlAoWO9Pf9I0se3pN8MET/W?=
 =?us-ascii?Q?dyK2IHW7RZIGeWbSqDd0TfswhZpPvGyb2pvhmJtKioI2criIUyJjdCJysJFB?=
 =?us-ascii?Q?cxvAlBsn4A1RB11TU7+nqeCvUgInM57bJoIB5zMADMYcUhSHIwsDCuHxPaRT?=
 =?us-ascii?Q?ubSOsW4nZAc3ADXEeY9ptwltDYY7x1HNT66l3P+f53M2XIBA1dVQVwDvN8mx?=
 =?us-ascii?Q?BgAO+8M8nOSgq3LYl8IKCTEdWa5AgKnTW2qH9oEh7iElnEjTmcn7RiQ0qyuw?=
 =?us-ascii?Q?lSTp+GL50JJk60grKTHY6xafbQGGsCfmQ1msQEHh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4457024-743f-42af-d7a1-08dbc9f1af13
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:33:26.5762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPd/c1FhoqpDM1QJnunohPX2jDtJtJtNHAKtUXh7q7ZwCz4z6Zn7Ul+kXFmEOgIZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

Using the same design as the IDENTITY domain install an
STRTAB_STE_0_CFG_ABORT STE.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1e03bdedfabad1..d42d5d0c03f812 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2622,6 +2622,24 @@ static struct iommu_domain arm_smmu_identity_domain = {
 	.ops = &arm_smmu_identity_ops,
 };
 
+static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
+					struct device *dev)
+{
+	struct arm_smmu_ste ste;
+
+	arm_smmu_make_abort_ste(&ste);
+	return arm_smmu_attach_dev_ste(dev, &ste);
+}
+
+static const struct iommu_domain_ops arm_smmu_blocked_ops = {
+	.attach_dev = arm_smmu_attach_dev_blocked,
+};
+
+static struct iommu_domain arm_smmu_blocked_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &arm_smmu_blocked_ops,
+};
+
 static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			      int prot, gfp_t gfp, size_t *mapped)
@@ -3015,6 +3033,7 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 
 static struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
+	.blocked_domain		= &arm_smmu_blocked_domain,
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
 	.probe_device		= arm_smmu_probe_device,
-- 
2.42.0

