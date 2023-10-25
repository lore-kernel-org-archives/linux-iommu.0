Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127FE26E3C
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H9h/55+6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHb0ixRJtr4rYGL1t51Q8MtxobtpTMYpxqJ6WfThOaLr7CRdSl/zOHahddGReRO48H0hs1ge8MX4Wt/ruJ2jny/W86z6h3J46eM982yD99cEVsgf9tPejLzoNAUReNM0iGSfqZaYGKkYNAX1ItQxVv8liyYu6YOPjqAXKDSw2WqHCMvQDIgz6l958zZWQzwMuoXDy7Ozq9HGZZb9blR1xvqiIKxWXZcHMwBN+zhjA+BilB5YUaufRLrROMSwVQPN0UsD7P4ONsTl22GOLCaRXknGU1iVt3++zw3BiL4tVvZeoQ3X/O6TLSYS57s6sV0ttQlhlVO08Jwo+zVjEVV9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vL4hhcdEh7Mzasz2Kkxv7wiS6nYYcYsBlbyRgnkq7vI=;
 b=Ydz/pfmJNcvLlJYhcXp9H7I7VVMDZUmUmJCzz43g+Tw3YSEN7Y4OT41rODbpjR49eEc5Cp1OdF2jNzOKo73ouCwLfx6xfGYba+da6u1G1nZBtqIHdVkg6JNdrFVnEkt2Iaxe1n9UO+Gcu606zVlL4JbyZnfRd/AgvR+5Jxrg3i/ouNVIFmPQ/RlU08qC0mfvInJvdlzAz4O0pcDiyUs9oUMGmAW4XJpM2yxfgyQmWzXLq0+7M8uazyVgt6fMelXlAlEj1Q44wcHsSWexyz3tdTLaDtpLh9ZZYSisHJLLVKZ3zjkmGjlhu52jnEv1LSXwVNFHo8fJsI+ghvBOHx/SXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vL4hhcdEh7Mzasz2Kkxv7wiS6nYYcYsBlbyRgnkq7vI=;
 b=H9h/55+6i2He7X09jgL5OkIEPiWoy/uGv+n2+6IBrC9lLWI1SCicfoy9Gq+3yBoC9HvjfJyPRfY0ZgO3iut8pdgU/oW9o/M0tWzBPB2PTLqow1fRaKVlNvCBju0MyAQNw4srlqjzpI6dQP82QZ9+LmNsLxE2+cdN6Cucg/tcid9d/wqqqAZ6+dApPQ1SmX6bKm7CHdQ4PwYg25MxkUmI4wX+JzNsSW3wBCuhflDkQ3uhQ8WXm3AOowcMc6OsWqDhh9YUnWp4njD/4I89Jdbek0gDYPFwLrKpCXKMwsuJaZIvowJSKKG9lyRUHchDrvCzBN0W94bghkYclC7DdHuNsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 16:23:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 25 Oct 2023
 16:23:41 +0000
Date: Wed, 25 Oct 2023 13:23:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 21/27] iommu/arm-smmu-v3: Put the SVA mmu notifier in the
 smmu_domain
Message-ID: <20231025162340.GA1168645@nvidia.com>
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <21-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
X-ClientProxiedBy: SA1PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0fe179-d101-4095-f1e5-08dbd576c076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S78GH6bzmyw0EIYedVAyfdjDd4tKfUeY0rUyKzWatSLcnZRkc4jQfDdclBEWsmOpQeqP3Ivw2eZEtbf5F/IL0kat/0FZCj1JjggnG5u9qirFqXpZOkPCYLTmtHw2fxwhnCvJ+NlNiwtMtYbGhc6BFLBP8k339eUg7Lz+ZXJQgkeJ//3Bn8oDPXsTPMgqGKco7FqxJvVJbEIab3Uy1qs6A4ggDHD7zvHDxPl1tIXlWnozxlryRtuQDNxI//xNwjiD2jgrdsT8tOUbiw2Uk6WphIZOt6SSyzwFkBw+7qDb96MtHK9BmaxndXRDWMwE+Gs0oqBJZiJ0t7vGpQGTZAwaAILyImj2JVKI/wyiGi0jc1X/mG5DwzVH4YEcNgQH0etS+8pMaEnD9SSzIG++Es4y58coK7tAUKnUEaNPT5YaYicHsCxS9mmJxnKdD90PFCqIvpRl94ns8yIKzwH0kLce16R4IyzPmh+c6yreEbcJzcaMBpO0QLaiP2abUvMEHfB7wXEApnT6yG5lAdlJaUxATs3KQ3wjtU2HmTUv7B3lYQ7tZcPjTtrE8PSixVqmmAmF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(8676002)(36756003)(86362001)(66946007)(41300700001)(54906003)(66476007)(66556008)(316002)(478600001)(110136005)(6506007)(33656002)(6486002)(2906002)(8936002)(2616005)(4326008)(5660300002)(38100700002)(6512007)(107886003)(83380400001)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JiZZoDnAi1d6wStzP5bO9B3+476tj2Rnoh2DJPUaSbK3Jj4Gl2xfLSSMqsBU?=
 =?us-ascii?Q?pT1A9GwZKahCuCSkk9zgoEQHaRJl76O1oW96VUtsjF4XSvAXUtGqrY7jGXZB?=
 =?us-ascii?Q?f05aTeExHIVhOxhmjdGrzL81xHAC2ROORudeCdd9ztB9wrKGNclcqhsNUvYy?=
 =?us-ascii?Q?7aiFQLa3PMutSj0BZ28p8yWt6dbDbM+v7hjmpr4C/QFQopFTHKCZ95NkFcTq?=
 =?us-ascii?Q?Sg2Qjw31FUNbPbd4xUzC6v5a7pBKjls5l3K85CJutYXpNEw+wL6UtZyriJeI?=
 =?us-ascii?Q?a7x3i6avKucWL+NM85rXPCf8+n1LwbSWfQjDj0J5GNcJk+lDrufolaDNQoeT?=
 =?us-ascii?Q?VKlmLiz6KBN2lyXQe3kpHa1P/4/D4FBDsX1FzZJC7zbYTRLif/JF95SptTmP?=
 =?us-ascii?Q?+J2TIF+O0hy6/iKKgGKgAorlqMMzfmzdswA73K78v0DeLRXTQ0e4zUCszaVu?=
 =?us-ascii?Q?+3JBxJ3+vA8xY6PP0OV6TrIFy+dvEgmdgH+6rdyViNt3EB5GcylqtodQzxun?=
 =?us-ascii?Q?u7P8aY//K4pKVvnahPUYDOVlhNqjl46qCKP7j6MsLZtR3NRgtpKrMiL8bvlR?=
 =?us-ascii?Q?Lz3oYkvp1i3PyLqKn+4dEpHbYPPzPZpes1cwo50Qf9KM8zpZ9QZAVDe3QJsT?=
 =?us-ascii?Q?rlZ/LOVJQ5rop0Zn2RCv6/R4atTnGq1BDwXNyJ0IfcEsZ8bBveggq56uMmeJ?=
 =?us-ascii?Q?HVglWev4Lbf1sBSrbnw19BiyqQz1BRIwL2D+J35x8VHAL/EKpmc0rTujfLux?=
 =?us-ascii?Q?e/7/8iqmeet39Kt5BaIOfPJdNvH2rXDOmqqY1dNELdJIjf+BoSAeHJzey8rN?=
 =?us-ascii?Q?Wg+ddQBGsDthOpH2PMv1SQDx542Wd6isd9iiKKknx/wE7pHvXuaWumzUgpNG?=
 =?us-ascii?Q?wE2lFwN95+VAjCsjdSvqa2COWxDybFvud5QJbFRMc07eU21w0VPsv1AgJY8Y?=
 =?us-ascii?Q?htOPPzwgoc+lJWpzKx66OHm2xHI7PHd6EExBDfjVqtCh45Mmo3mf7iv16jLC?=
 =?us-ascii?Q?DlOpip3VLyfhCqGtT63NgkZU+pFMWpWiIaSSB3dAcB/+1D6gbfbnHXQo7Xeh?=
 =?us-ascii?Q?esWOTV0ArC5NKmLcotn+rSF1EmOzJBtn5z8bmiiI+mcTXGBtsec7icF6YVoO?=
 =?us-ascii?Q?Fp6gaid/Ue6hQyDqH5Y7/vN1JeUylNLQqkmyYHg3IGUNv2saB/4qk3Ys4kfq?=
 =?us-ascii?Q?Ld+kyO8+44PZ3H9yzjxfHrgNuFh7b9uR9/BJmZ4Agrr5EuZKK6hCl72wy215?=
 =?us-ascii?Q?kTeIwimglh4itH2G3Na8anyMO9N0dgi6OqiPXZhZgD0SiYA5oUNJHWCXauM8?=
 =?us-ascii?Q?HRnGWBIS5yPUzB+RxUSvoLj6YFriDlrR9K1V0RWLWynAYSVCTJ86Mq2P1YiL?=
 =?us-ascii?Q?O3aXmbBm6yyRuxjRo6uIXOdZk0q+no5VbxOsjQILd3nsLh5tIfKUcwDsDzpm?=
 =?us-ascii?Q?AGne1yMM1vl+bQgtabOFY4lL1G/Xp8Fk0P0AinCNhjJg2IQrwOSxvaEQCQFi?=
 =?us-ascii?Q?PilcM68eIvHD423TW6JFt6I1NYlMe2sXrFcf0x9YS2m8E+f08PUTi+sA6crO?=
 =?us-ascii?Q?n8uFDDYEs7JumTUAuEyCWdnVKFM75fCknutsx2hr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0fe179-d101-4095-f1e5-08dbd576c076
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 16:23:41.6604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/aWF27LbXHmAjj5tqwhyISdIhRrPQ4nNvrhzU0gwFMEFD2A3LDvmOOXf1WirgbP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318

On Wed, Oct 11, 2023 at 08:25:57PM -0300, Jason Gunthorpe wrote:
> @@ -675,6 +401,8 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  	struct arm_smmu_device *smmu = master->smmu;
>  	struct arm_smmu_domain *smmu_domain;
> +	u32 asid;
> +	int ret;
>  
>  	smmu_domain = arm_smmu_domain_alloc();
>  	if (!smmu_domain)
> @@ -684,5 +412,22 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
>  	smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
>  	smmu_domain->smmu = smmu;
>  
> +	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
> +		       XA_LIMIT(1, (1 << smmu->asid_bits) - 1), GFP_KERNEL);
> +	if (ret)
> +		goto err_free;

I found a miss here, this patch removes all the xa_loads and this
xa_alloc changes the content of the arm_smmu_asid_xa to point to the
smmu_domain, not the cd.

There is another store in arm_smmu_domain_finalise_s1() that needs
changing as well:

-       ret = xa_alloc(&arm_smmu_asid_xa, &asid, cd,
+       ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,

The following patches assume the xarray is filled by smmu_domain. This
only impacts the hard to hit BTM ASID collision support which is why
it hasn't been noticed in testing yet.

Jason
