Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A51CA9A
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L+QJ/GGT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIH5k/GiNv44RrG9teHuJL7MTON7He1QCbkiETBaGfVH+pnv7w66WR707tZByRSxtfZ9rK8K/EdVD3LpTQpMeAch6fUvSiMJiLzgk3zLYOX9ovFVH4cPZO4httslVegQYVjWqplTQ35yQJVHYZ65xDWyRgE2W+ZxEohMOhO+n99yFpboOcM5lc0Z8sYLGQgOpzzDkexPXcNegL7zIqw2RgzXChu81eEXzUbaXT4HP93E3FlncQfIjewzmbhPhg3VYGI7mHUQqLPDDxEmNLKn/akNGKl2jCpcwI05IEuAQun2qhPdCiinkICJqq1XMwuG7EWsJFrgi4Y+4BEtZgC2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hE/ACTBLJxUNf40il2FN1rWkfws/LLvmJ2UG/AOKJ9I=;
 b=fCUyKTu436OW9Tw3GAlUY3hjTFvy3V3JJ0Ng83HBf6KorywsszyMIVlWoEeXeePnpPWTHdFOBWKNNg42bqhL9okU75q79JZtAXFi4UO5CCY30L5ZinyqGAt3kcnqorPs03bRpDFaN5Vo4R6fxXSvWqoh8Cwj6Ftt8IqoksGlY0BllJ38KOubOsCl1PieIxIopZ9wCG83ew57qFz5ZoSBjyMHZYTBxTIJOM+2o3VY8wHcrKgLTrYqdhriOLI0uf2qPeA0nepLzRnSO3fmIyyX5xSe7r8MUbb+zHeEofa4RJNRNf29drHEZNrTbyOyAR/JjK1BPlF9EMmiyIvAEqUEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hE/ACTBLJxUNf40il2FN1rWkfws/LLvmJ2UG/AOKJ9I=;
 b=L+QJ/GGTrkBGsnT7Gy2FZGcmyn8JbUrDQzSyMnCWntqAr1i8wLt3btJLKE/hCKCRf7dPlRVv+K4M+lIbLa9EYCYQLR0hu9O+Crds7ANcihgl4A/Yvsdjmo+5Nj8I+KKCChIM6+Ml0XJqJ6//HQjcGAT1HUZCYmuEk4YFlInf0ejfmRPGk57cTygV/0Vx4tbCtpWqbXFcVXeUycfRl1QRl9elqcKIAhP2w5vrJyOPOLznaiI1cmzSQoxkUfJVou/jV9xRU0PNaX+SxKHIaUhg1vA/IjtspoMjvuXtrJ7rGgUOnKTvM9UXK0bOuAtbElkHkKhSMJ8ewMw0w3LdkfRlkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Fri, 6 Oct
 2023 15:03:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Fri, 6 Oct 2023
 15:03:44 +0000
Date: Fri, 6 Oct 2023 12:03:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 4/7] iommu/arm-smmu: Pass arm_smmu_domain to
 arm_smmu_init_domain_context()
Message-ID: <20231006150343.GS682044@nvidia.com>
References: <4-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
 <db259336-1203-4d12-ac80-3108aaf5ec82@arm.com>
 <20231006135347.GR682044@nvidia.com>
 <161e4152-9213-415f-8315-4f3a73b76022@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161e4152-9213-415f-8315-4f3a73b76022@arm.com>
X-ClientProxiedBy: MN2PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:23a::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d81a6a-820e-4d53-88f3-08dbc67d6f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zOJ5pZaWTzLwjJNk/slIv4xSML+Uk0QTIGmw5pyrHU8TekGEt7sjjB34osskX5oRkNNQxslWqvaOCMuA+yr6Lrv5ouk529d4eWoQ463QMVOCfZqu4ytwJUsimbRCFbRnM9tBrTPxC/k7JHkZBl0V+rg+0vVizPh4UQ9u07XQ6rl39N3An8HIYRDAFwM60myvB+lfFWeYDkKOlJrHPnGuUpbGD8bbAxGAwJVth2oJRhhowwKeWYUGyWfTE7fijfupRP5nr9kkfaaEmHxeofus2G2TARXru1JXi2A7AjhLxHA5XV2Ce92AnPnzAdmchBtbfpH1fMjRBcVokvffx+aZXpsxobmJQqpWlC9P6QFL/4yzLbPrZx3F1p4SyNpQk1rgM73nas9+85xU7iRmYgrMWDzHoaBvoXArFGXjxH0SpSMMU1uMPlUiSS929OmErQR+RF9ASsBNCqwzOEkncL70TJTzZqxcmhBsdpj01bCsOSNtPJyhqQard0ln/ocJmiP1L5NGAvh4z/fNir0jvatjxbRY9/NJng/Lfh7hk4bwWSVcI3kx92UzF1oMJDMypCHNZOM2pmuDp+WsyBSB7COdPf/6HMFcdpoQbMNvshFcFydcpmWX2hXkUOoMRMgyX/d6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(53546011)(83380400001)(7416002)(316002)(2906002)(36756003)(41300700001)(8936002)(5660300002)(8676002)(4326008)(54906003)(66556008)(66476007)(6916009)(86362001)(26005)(66946007)(33656002)(6486002)(6506007)(6512007)(2616005)(1076003)(38100700002)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?64ujaHsGO42j/+JugLy6YkBEuHfyVTiIhH9FrOkLY7RunZOnrNeY1mmxmb+v?=
 =?us-ascii?Q?iJUjWLJOYauv951ey7nQsTvNDm57W2vVoqII2EYyHrSN3mPaDAg6DDA5Oans?=
 =?us-ascii?Q?eoQtqj0XQkw+IjaV23l3jZHY+qdBaRpot460iPnKntlkMJugjUBwbwU6utsk?=
 =?us-ascii?Q?nUEixLBiGmW1iqih8ThuBaCihbkFTFMio+GusVgW8CkXFHBzDa2ahg4ypyH7?=
 =?us-ascii?Q?QzpiMEm7PttFiRaE5SVINdwn2mYlljiiZuk+MC0KDEv3QuIsn/U2tz4lIRcb?=
 =?us-ascii?Q?ohuA0H0PAiO2eBuSmViw8pSgcpE8DEIlryN+reOUR0KeRAsEGsOYb9YMFAUH?=
 =?us-ascii?Q?3Uv5WT63Pn08xpa4DUJ5OfNq3pDx+0ERxbLTvXPI7JJ/GW4evLnS0Ngg+sn2?=
 =?us-ascii?Q?hVqcJPdkKz3iR7Ox8f5bhLOor4JKvRVJ51I4p5SnJCsUvDm73Fuvy3HfMyCP?=
 =?us-ascii?Q?Z034Heqrqg9cNRZope3E0p1xTa6yZ6Blcke5PUlIbDLcf3AWBeHl4d+h8SfZ?=
 =?us-ascii?Q?+Y5HFwLwB8Bo3JFQX17FC894v6bdBNRMa+6M0qElpEa35EaT2hxqA07W0FJp?=
 =?us-ascii?Q?FyjyeRf/4cEglYw2UjTgk0m5jzBYkwa3lDcsXbJAvUmE7+hdKWQVB7NwhAjf?=
 =?us-ascii?Q?Wd/QzlLD3Ixvh9i/PzbF0xBhin3FDYjtLMq8ldfjkbCh/MxOgoAQ7JphbZe1?=
 =?us-ascii?Q?NUz2CgdmzrfNuWnIfv1TDUl374Vubfga+nqRWPEG4w7RVm9Rv6Y8X01wlEvA?=
 =?us-ascii?Q?+ixDIGyOuAzf0Oo4NQRTfJgXuHEcwL2CNStba7qHMR4ory4w9/SCYHVjtyZW?=
 =?us-ascii?Q?IPn0JLEVxXlHRSiTtx+vUs0l6sIkeOV6yQhZGpbeClRjfeXgw0sSHa/LOUl2?=
 =?us-ascii?Q?JVPq/lsWADW0ECjGqLrwE84lAmwv/GRLk5VOgNAg7mNzz/mYFjK3NJXwCqVJ?=
 =?us-ascii?Q?3Hz6WHfPFWsxLojAcE2GsbeI6v2bcgQgOPX7aIi2xIj5wecmRE8jqHNN+Fmu?=
 =?us-ascii?Q?7vEcO1C5T9d+t5DD5jLvwnAbZ4R7NDPdGanQFl9UjOast2OuIldLs3KIRN0t?=
 =?us-ascii?Q?L/8McNtvYH5+4tTdXMT6rTZ3WrxhXwr6dxQFaJG+b7JJEG3Z6xMlTJ92ztgo?=
 =?us-ascii?Q?kWfcuWL09D13Q2NzLh8/Lfb+FDnRiK4Eaj5hDbxcRDC1kBPm36hwpr74f7Re?=
 =?us-ascii?Q?krQSs5xkBEEt7xdNSkZRkvIIfR8woNEoQ/sczuVCLYmEuwkTd6svSOq3apgG?=
 =?us-ascii?Q?T6/3eOJ+tmyMmLtMlk/+BI3pgKmSJwhXfYfBdNlHQGEh2mrrp9oB1cVDqb/J?=
 =?us-ascii?Q?pev67gvYiYHp1ayozNonK9vQt7VuUHkCKCrN1slQgmfEi8VynV8yrfLXN+T9?=
 =?us-ascii?Q?hP2Tr9K77/kaj9FF3tPm3vGb8dpDbSxvZgNx+bjWOqKt5vvHGua+WsIlWFXI?=
 =?us-ascii?Q?1ow8ePL/r6D24yEKMcPFmN+5Gy4t1S+gXiFjWHh76yq0E9+v9eKzZGpbLVj3?=
 =?us-ascii?Q?+5m62mD9sV5We12rQ2ZtTcLIAeVM54Zs6VSPG8JQ/lpnSDHzQu0GMDh9+W1j?=
 =?us-ascii?Q?w/D0x1Aep4tVa7xykMchZFGsic060fLyIGvAEYsY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d81a6a-820e-4d53-88f3-08dbc67d6f35
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 15:03:44.4655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+LJez2tmNWfVt8WT9o7rvBxZq3UIYrJ1NbdCiOvzod1NYuy2Z7iZfEG2Hvny4Oj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4574

On Fri, Oct 06, 2023 at 03:56:15PM +0100, Robin Murphy wrote:
> On 2023-10-06 14:53, Jason Gunthorpe wrote:
> > On Fri, Oct 06, 2023 at 02:43:51PM +0100, Robin Murphy wrote:
> > > On 2023-10-05 19:28, Jason Gunthorpe wrote:
> > > > Instead of putting container_of() casts in the internals, use the proper
> > > > type in this call chain. This makes it easier to check that the two global
> > > > static domains are not leaking into call chains they should not.
> > > 
> > > Is there something inherently difficult about to_smmu_domain()? It's hard to
> > > tell how the aforementioned checks might expect to work since they don't
> > > appear to be added anywhere :/
> > 
> > ?? There are not added checks, this is talking about static checks and
> > code auditing.
> > 
> > Let's try the commit paragraph again:
> > 
> > Now that we have IDENTITY and BLOCKED domains that do not use the
> > struct arm_smmu_domain it is important that to_smmu_domain() is only
> > called on iommu_domain structs passed to the paging domain ops (aka
> > default_domain_ops). Use the more specific type in several call
> > chains and remove the few to_smmu_domain() calls that are not
> > obviously in an op call chain.
> > 
> > This makes it easier to audit the code that the two IDENTITY and
> > BLOCKED domains are not leaking someplace they should not.
> 
> How? It should already be trivial to confirm that the driver is not itself
> making any reference to arm_smmu_identity_domain or arm_smmu_blocked_domain
> other than exposing them to the core API, with no more than a simple grep.
> And if the core code does somehow screw up at runtime and they get passed
> back into arm_smmu_attach_dev() then that's still going to use
> to_smmu_domain() on them and propagate that to its callees, with exactly the
> same effect as if they did so themselves. I fail to understand what you
> think you can achieve here.

I had to audit all of this to make sure. The to_smmu_domain() calls
here required some extra work to check because they are in an
interrupt, not a domain op.

I went through and checked it, why shouldn't I more fully document
that I checked it and it is in fact OK?

Why are you objecting to this? It clearly makes the thing easier to
follow to use the more specific types?!

> It's never worth doing anything for the sole reason of trying to make it
> slightly harder for someone who doesn't understand the code to break the
> code.

Maintainabiliy is making the code easier to understand as a merit on
its own :(

Jason
