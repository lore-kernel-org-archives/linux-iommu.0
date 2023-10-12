Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C6724A0B
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eMoR3rKx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl+UWDCvk6UA6qQ7RbZDtJkoHwoasnKkjcSUO4ISBnRGCXxpjsj2+1E/Ov8D5mtjD492k2muS4Ss/xbkdxJIt2VkMSdruTPp47k1hEOj8gu2buqsK/RLKW/xbgcp1BbDUbcxelnEQ4xkFaJsfDcsxERM3PDu7IpojGKZxj1TMDoANc8DExnzTb3djOsdXt9UY2aeaicFE/C759sqKyyjzy4mtJztACuLiari3fvMNj5uYA6+QgyO1nm1XmYSm47yPfljDbBYeCQs2e3ou1Ykq8l4Z5nOXaJn55/dHv+RPbyDIf1mwBo7Bg67qWfUnvVRf5wHBaT7yiBSZPVOGw7p/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6C2Av+fJPig+C+p1cb4HSxaK754Z/9IRYoyXQAWojo=;
 b=GUPhUVNqJ56q5ommiK4tvDAaeSA6yAz0n068Uj3a5mr8SuhiDDLaBn7C+7b4SWnBUULgw8T+LyBLT+/pE1uZBUU/0L9nMHw9xxiMfS/wshYtsVAUeW4kEy1me8mup9FqcBGUnByrJ6wZALebHsKmb749JV5vEcY/SLZSKUHIqVxXoP9xmDdKwhGEC4WtaAUS8c3Dxx2d72/Ov57vcwhPBD0zDXm7xRKHKxR7DKSy2utOBDEbXR1G1ENEAWrfsJkm/cu94oTfX4iyJRLvTRAyMlnvzLJnOPF5MkrCL0EPWLFlFoObmPiYxs35ymvt1UizF50yTpPsoOSzeMQdXLpqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6C2Av+fJPig+C+p1cb4HSxaK754Z/9IRYoyXQAWojo=;
 b=eMoR3rKxoNrcnDDlXCQFFlg5nv2VBaSWybwpPu4NH8Ndy7BiJgw1dNbR4jJ7O0YR7GrdUVjE6dnH6/g50D8XOVopEa+eM9aQhcU2p+rHrBZCgDu3cp5zftGlRc3jwvuffvaSpqpfV48wOPkF0wRUCAbJk0lVWieVDIY5KxMR754XAOeouC3yfq1I+X4keI7ct7vNbcOEtJQqaP9HJfwh99MSj7LIJHJ0gFsHanO7LM0g7MFVo7SlWmgbokHv9YGSQvdUP61ijocEMp7KnJpDSvjssq+7419/K4a+R7BdbgHSs96hYQncIVthxz4J17W5tkLY3NL94NNdrKsYhZdGxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 12:16:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 12:16:17 +0000
Date: Thu, 12 Oct 2023 09:16:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming
 independent of the callers
Message-ID: <20231012121616.GF3952@nvidia.com>
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <CAKHBV24UGZuG6+J4cybadJCTyf9hN+e_VgAC0NVOPotmEur7SQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHBV24UGZuG6+J4cybadJCTyf9hN+e_VgAC0NVOPotmEur7SQ@mail.gmail.com>
X-ClientProxiedBy: BLAPR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:208:32e::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 568088f7-40b7-4831-8711-08dbcb1d0934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pllxt0qI8SzBYk1tXt8pd9v/qj9piOEAvRbHKFzHiR4G8NUh2tDu14m77eAUMnHyG9x+B+uMUaewyH8mC+v5QXpDyn0zO17Tm+znOHiiQy6Gs5xGyTdIqSw7DGEuZCfOS3EfQ87Uhob63gy5smKFIfFsie5f3OlUxdkmejfnTAxGuOGXnrRsHVUcK6hWTdH42sXCfLBktquZYCVrk8FE6Jm898farRkLf3A3egWH7ydBgLEqhcIefWG0ZGexh3XIo3sEw8jY3YcsxIs50RKwbmDBNXoS6AwL24aEjMbfRF25l43VXUPHoQlLaAkU7hhI63Y59QcDt4O24KFQNvYlnJUpqhXYm7a49aiSjN+R+7sfGsfkZF9xSy9tVZZYw84hRpnEU+yqiQHIJmFWl3wEyHriU9Swyz1AefOMdji8Dx/Y6xp4rSApxngTU4NyQzMnZlooCcJZSxLMttiwk094bbvqZ03UW/OTteT1JFOWzcrlCzGru/oQVfMJWnAVgXP8zHaAgJmMZBI/dIvJ7Mfj2AH51MMirJUvsgES8505xX8moo7J+66FBZLOsAIFacaz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(1076003)(316002)(2616005)(107886003)(83380400001)(2906002)(86362001)(6512007)(6506007)(38100700002)(5660300002)(33656002)(8936002)(8676002)(4326008)(478600001)(6916009)(6486002)(41300700001)(36756003)(54906003)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QlrUF3ZpVvLiw71QqbvJKWUMGJ/HCfHX+rZWOAVuyM+r7uettnG1IVul6lt4?=
 =?us-ascii?Q?DEn89ahjLIMRyqkl10CU2iiuX0SYGFDim7Ri8KadTKaqFT8srCmqsuJaKqi0?=
 =?us-ascii?Q?1suOiqmjQbMP56nz8MLH8JR7DDehPIvWKq1duuIfS/xIWm0qKGrl9bwhaw/N?=
 =?us-ascii?Q?0DPrLfcVncT+6Ui4ye2ZK3opKW21lhvH/qG/JYcnnyA4iE6xVq8V3sjlIY9G?=
 =?us-ascii?Q?Fkkkxp2gJkZuHIiHRmMtpjy73Bm6dlRgWXtOEkJoKIMIqabfdeHfBNN1er4K?=
 =?us-ascii?Q?8TaXzEYVvS4dxPEUbKjNSnEv1xQVbRzz7OpWWqTck9fnVRQOWNg2TKCGb+u8?=
 =?us-ascii?Q?eAZKwmvZ4lpM1kEy3kLBJCLLn7lffOzgX5Qx5KiQQZ3i+6PA/MNWsAtWKdm/?=
 =?us-ascii?Q?U9vxa8w6RnsM7xRgeC2eImr5kOMsvGtBjaLFw8pEn5eteyXR00LVy9gs8fz8?=
 =?us-ascii?Q?ZKFWfJ9StD56A5pRu8wz61WstsW3Rt7GyoiCyS1UAJSqNCWx//qiHf2v5vLN?=
 =?us-ascii?Q?cCHEQ3pJLXc0PW+X1/QqdFwm5G6fSLPUe7wziwFsEJx613SyOhpnxNiw6+jV?=
 =?us-ascii?Q?AY18TGnbS1cx0Envtg/Y4Vh1fvrfkkf0PnEH5VsGe9W90Dd8bGUB+VbFWe32?=
 =?us-ascii?Q?DFOnje+QGqAtV7q/NJX7Ci/20c5tvTcgqdxsOaAwvGGS3Y99ND6SIA7rFMHo?=
 =?us-ascii?Q?Ab5NYpK6OUW4I8l94c2324PpkMWRNGcjc3zrMilcqh42ux0uwXpyh0ADRMMP?=
 =?us-ascii?Q?PwVJiVuvZrnkP+D/babd2j6XKJTIKG3rXkCKDj1Wezp21HrgKAwT8KzUK7uO?=
 =?us-ascii?Q?WrkAtfqv+TaFZGhDfJGA7TXVR2PULrdAEy1ag8zzwvGtj4dmV7gWhqnb/GxI?=
 =?us-ascii?Q?OomxqlxhW48JI3zyIVjKcSb4K7v3/Xoqtu5/WctgkohmADTcgHC7au8N+TSL?=
 =?us-ascii?Q?3QO+m8FZOkLTz7FotLGLYWYmjNXT6TbIaRjYMOnfznGE/885SUDyvMo2rcVQ?=
 =?us-ascii?Q?niP4CsLAzVlJ/vZ/0GpLdAgnq/ofcGw0qSYr8FXFvoCnZUb4ZX9ddbw4x2YE?=
 =?us-ascii?Q?npiaiTvnkBJ8HlTKXVSwx2PdQ7N300A/EAaChGMv+yiNmohMyQL0msDDoLUF?=
 =?us-ascii?Q?vNj+/FhTSqG47zS3DH71kJqYLaCaWvUbP/sG5FtD/JQkCvF5eQAJcbhWcV1b?=
 =?us-ascii?Q?t+4AoKXXQAXYvL9LmOb6t0z0v6nb2KhekNq1LoiCzo1tPvdCV7m22NntQvLE?=
 =?us-ascii?Q?fuJEmoTodiKvXSo2rVp4cTPHxtgx2HW283aFuj0xH20ibGOzyuBwTi9e8dXV?=
 =?us-ascii?Q?l8Wsy3cmVg68a8WCm1YIdkTaqklyVTucN1xbtV1e+CjFhElQ9suQF6tTfJP8?=
 =?us-ascii?Q?MVhr+LadQip8lzgfsnr7T6jqONYV5iA4+mcuUm0relcCfF33JRn4bG6CSeyb?=
 =?us-ascii?Q?/S4cez1WiCXk2LzrKkhcIycGcTqEoVNf9KMcrs12qbzRif3fIWtqyoz2J0r0?=
 =?us-ascii?Q?zn6LzR4vyJCVjaHmEgH7LS13ihsqVARrSkHcDtljZjZ0dLpLkfF8W2zL7rGS?=
 =?us-ascii?Q?yASoMXNQ6Q1SkbO1kbNeUBb3eg2NKOkOBlqkAZPE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568088f7-40b7-4831-8711-08dbcb1d0934
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 12:16:17.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBjP6QgoT2l1vzmNqZCsNnIsyaM/uxmRUVnYRc8AsXHUMtEEnraSs5MVMhRBxJ3I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986

On Thu, Oct 12, 2023 at 04:10:50PM +0800, Michael Shavit wrote:

> This sounds pretty complicated....Is this complexity really required
> here?

It is first needed before 'iommu/arm-smmu-v3: Do not change the STE
twice during arm_smmu_attach_dev()' which is a couple of patches
further on.

Then it keeps getting relied on.

I don't think there is any simple answer here, the HW has this complex
requirement. The current code is also complex - arguably more complex
because of how leaky/fragile it is. There is even a couple of pages of
text in the spec describing how to do this, and it doesn't discuss the
hitless cases!

At the end this is only 32 lines and it replaces both
arm_smmu_write_ctx_desc() and arm_smmu_write_strtab_ent().

FWIW, I found the most difficult part the used bit calculation, not
the update algorithm. Difficult because it is hard to read and find in
the spec when things are INGORED, but it is a "straightforward" job of
finding INGORED cases and making the used bits 0.

> Specifically, can we start with a naive version that always first
> nukes `V=0` before writing the STE?

I'm a little worried doing so will subtly break things that are
currently working as the current code does have cases which are
hitless.

Then we'd just need to change it anyhow in 5 patches or so

> This still allows you to remove requirements that callers must have
> first set the STE to abort (supposedly to get rid of the
> arm_smmu_detach_dev call currently made from arm_smmu_attach_dev)
> while being easier to digest.  The more sophisticated version can
> then be closer in the series to the patch that requires it
> (supposedly this is to support replacing a fully blocking/bypass STE
> with one that uses
> STRTAB_STE_1_S1DSS_TERMINATE/STRTAB_STE_1_S1DSS_BYPASS when a pasid
> domain is first attached?) at which point it's easier to reason
> about its benefits and alternatives.

From memory there are many cases that use the full functionality:

 - IDENTIY -> DMA -> IDENTITY hitless with RESV_DIRECT
 - STE -> S1DSS -> STE hitless (PASID upgrade)
 - S1 -> BLOCKING -> S1 with active PASID hitless (iommufd case)
 - CD ASID change hitless (BTM S1 replacement)
 - CD quiet_cd hitless (SVA mm release)

Some of this are fragile and open coded today, eg the CD quiet_cd and
ASID changes both just edit the STE in place. At the end we always
build full target STE/CDs and always consistently store it.

This is a nice tool because we don't have to specially think about the
above 5 case and painfully open code a FSM across several layers. We
just do and it works. Then everything else that can be hitless also
just becomes hitless, even if we don't have a use case for it..

> Can we get rid of this line and use target.data[0] everywhere above?
> 'val' isn't exactly a great name to describe the first word of the STE
> and there's no need to defer writing data[0] anymore since this isn't
> directly writing to the register.
> (Feel free to ignore this if it's already addressed by subsequent patches)

Subsequent patches erase this function :)

Thanks,
Jason
