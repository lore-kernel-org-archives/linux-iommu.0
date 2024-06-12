Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FEA17083B
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195380; cv=fail; b=LQ8qBrNs3j15QezyGd+wNL2nauKfTtYU4EauvryUK37vuvZJ08KwFE5JEa2ppFeU+esR0AGF3SRg8ABUKH+yHu1K+fhkMO2IMpSMlGr27s12gU9rBTZDH/t0n9FWh+qD3qRzp7lYmNWgSZBtoa5GYxz8QQ4BzoPzqbxdv9j8nGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195380; c=relaxed/simple;
	bh=IKCBTuFXCb4aLgO6D8WPL5gvh7z+R3CWhBVs1461xxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hKPjDLFXKpKa73Cog57DZPrDHvgcCisIczjcYDKUqlGf4gEPAbwwR+IAz6CD4Uyu9NOm61KzA7NYPkv8Shr4D6GY2V+T68X02nCQUmM7AAtHFgC0PfC29BfeuBfOwojE3yv1C70ehtmICjV4qRHk3tLcDtW5/TONyxCwj39Y4M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cnb93r0h; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cnb93r0h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOM92iowVJsmYl3ZHVEIbZ/cjiTwlYTCTR7hAqYydG/Exu9EKWv+aYNObameAIlxH11NLXsBaUVJWCFva69+m9g5o5xI4NA9Z/c7WfVRH3spRRfG5PpKR1PnrHof+R0xjp6R4+iEWYgYmn9PqeE3lQYzDa/qKrLpC3Jz828bJ9BiS77/0/CVfHRk1FAa4V73lejpWtOo94+FrwNvx3MyTYHpEqfOyogH1VaccuV5/fTVTj14MD95TpRfExXdXFiFxVDxC1rcE0WtF4cV9Btd/T9/wSl/9/uHokLO36M1LwO8VRav8NB5o/WBx5xNt9bdUu1SdIUsqRpxG4G62yVy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xrw/i1OPbtzNYGbUoWslMUHqEGrdu/ieWhMtinu6zyU=;
 b=fAcy6Q2B6Gv+456SVI49SrZXY6GNBHdAPl5bGQuzzA1uR6hM9FAHni/v2U3LNSdBkBfxYq6PwYArmolVoDR9x+J2b18SmmvTZ2jBsAyiirBiUB540VjQOvVrIRUje2gi6MgyqPGJGFGvT5feYF7I1qVo5FiBmTJJIATIrRDXMLdatSkRvPXLjNtHAsDPIm+dLgAOCbOfW1MjX3ltgVG2zwJKdPMfWy8b3oRks0NlZW3wE2k24rhLHqju1Ko7nZfo/tU5qiLW6Z6exa7kPxtJt6wreL2IbtCIYFnBickio9/Yx8u4gdaQwzV+jaRUOvzAP4Po9dD4EpKW6nGB8E5JoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xrw/i1OPbtzNYGbUoWslMUHqEGrdu/ieWhMtinu6zyU=;
 b=Cnb93r0hvpAzAml2ovDtaJYbs42ljTk8cKWeda7n7PLUzkuufzCeXaafwdnsrXjlkswEF0TWjMJjk9S4NyAPmqOVrUeO9vjrUQtzxPVQOnHwzPD6wfaAw02KlJ8duN9rahj2rLYu6DX6xLhV38PUAqndqyyd31QIKdEonZsYVH7CpX+p3sOeVmUDZ+SunsSo0yvVNVQwc0rJRnVuFJQXeNzrbvfgV1UNlwGj4Kn3We/pgKjgdJ46ozs9Fmkzb3KMx+KNQ5nWxf9nHzkvd/JPMdh6QZ/Fs7Jx/K7WF8PM13r+nIOeomV+IG38AZFJzd4GoFDvy9Orwo0+Wqyw7zh2ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 12:29:27 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 12:29:27 +0000
Date: Wed, 12 Jun 2024 09:29:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v8 5/6] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <20240612122925.GA19897@nvidia.com>
References: <cover.1716883239.git.nicolinc@nvidia.com>
 <e7dab374702aaac8dc81b95ddf89c94befe409dd.1716883239.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7dab374702aaac8dc81b95ddf89c94befe409dd.1716883239.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:207:3d::34) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: e50d5fca-b95d-44a1-3441-08dc8adb4d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oSVwulcCRonY5QYbPCHNQ25JD4myzfQLDmddkqSYJ9jv4SnXdOiObfDUXyTB?=
 =?us-ascii?Q?HsiQC9PpOo1LQOWRg1/iLNCP4Ps/ahkN9zjMBN0nuopeoYu93tGGZ9ymhG63?=
 =?us-ascii?Q?GJzToRlwAiFxYqSaoQxDbqx2WuUZtEJ1u52r6W1bQ/YXU4V/bIG8Fmzz3o1n?=
 =?us-ascii?Q?5kJt94/6NLXaeP4NCGjmcRrhL50UkwiUUe4yeo15qiKlJjPeYZBUTpBS6bOP?=
 =?us-ascii?Q?SBjndVDxWaaDpK/IQjnqw3iQMIh+CxbUP/v7mcprOoFKNdWMvNmvijh0OuNk?=
 =?us-ascii?Q?SWkjh5fzWNFQ+DAmFyhB0jre3kMBoQMG+pt6BpfZqRBeAbqOc2RNLY8SJ+IX?=
 =?us-ascii?Q?2P8im2rXA6reGldtlfq+ddYNoaJil/oXIj1oxXh4AzpozTPqfocc07lVOlvV?=
 =?us-ascii?Q?PDcDx4iYFbAtmU2DrOk37QBoXaOXwmLc97LzvN/GevJtuzYVtRiMoM6mpsHa?=
 =?us-ascii?Q?cLpfSi6B6kctNcI+LLozM+qPfHNCpZtNMHVQuykLjzC+89k4Krf/T/JLDfHc?=
 =?us-ascii?Q?H6K1LRx1tf6ewVQm9RQaiNaCUerPP9nI7CNt0eWJjJxFvEfpzjWYPZHy5fD2?=
 =?us-ascii?Q?BXrPWZbcHEqSXjFZ6yO3CHlXcQvDlCEukhxN+OaJqNpiUvpEZoe7B7hfeC08?=
 =?us-ascii?Q?h31EaSQDt6S0pLyqkbtBUbrfobwsxdvshUaIfIgy1W1YxfSxtYRHJhTDc4Xr?=
 =?us-ascii?Q?c681f61ar2y/0mAIv+1dATm5mCOZxuPaVhP+OMmA2iscjj+TzHPrp/qtMw++?=
 =?us-ascii?Q?ltPytEseI2hmuiq6JEYzJgDkv2944GhA4hLVZjTxfdJ7gi9m079D9h0xRll2?=
 =?us-ascii?Q?eZ4a4FYXWt9nnEbqNdk//YhGoVpe8GK01fm9AB8uzne3MJema2ssinnmtEtK?=
 =?us-ascii?Q?HqA/SakgWVhrrUv/Cb/XgYsLBtwHBtiP2GSR7xeezdefvlco8kKrXEBw0Aja?=
 =?us-ascii?Q?ThQnNp6yICEqI0yn2uXg5zxyKn2L/HjSg9wP23yOFT0yAMiNm24eLGx9uh6V?=
 =?us-ascii?Q?rfOpeAi12De2rJeN0yx0LJMoN1/KdGeTuJOeXPH9SECzhe38XHgFX3B7mPXc?=
 =?us-ascii?Q?aF8KlSEdzRabCUJXn/cFW7TbYooumei+HGwI/WXuFvA75saZnniqdX5GYc2M?=
 =?us-ascii?Q?etuaHiRoR/Zeg3gHK9DtE4a9YNQqedMisi3cRJVk2WhBSR1M4bxNLo5LnxsJ?=
 =?us-ascii?Q?KCerNgKRxUzhLeNrz3eJ8llJP8Q1hSKKBdhGyA4XXPCELh4ThkABz3b5Wx7z?=
 =?us-ascii?Q?lG7lkzZF56x1JKSX4rrx6aqLAxZwD6FEfC07DC8zUapRluOJIXy7XFEbb4hq?=
 =?us-ascii?Q?8xIdfPbcIu4CveosN33bM92y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QuLqTRIZKlz5lULHJdvBTqCngBdUj/k5PnwTL/aUkEnO1nnOhtKwhleMiJmk?=
 =?us-ascii?Q?fyiBKsdRgXrd2chiO065ju0Fu/FgalWinwI+jprPN6x/XJlDMsUOaWaGkAnS?=
 =?us-ascii?Q?fliy4W3C8lFgVokRmNxGVvD8KohNK/VeDdXuVCEM30Pc3AdV62+rccal5a2A?=
 =?us-ascii?Q?WQhx5fb/xcvN9rCtZTa+8/3raEwYSjDaXHNHCqQ0NPnQ0o9PeL50JvDoXVtG?=
 =?us-ascii?Q?+FZE9hRhGo9pSXZReaMjLjol6DqFysXcG2ZzkrN5us3tppWqyw2dPqhpMJtF?=
 =?us-ascii?Q?aIMhoE7jVwfl6YcHib4c+f8BfcGEk30GwBkA/8WAI18l+0JIMS1Ub5j+rMmF?=
 =?us-ascii?Q?A1OfjhTs9wuJe+TIg7C9GKIXnNlwyiVHhaSEu0b5Od7KlEILD8/tv9r8CRH9?=
 =?us-ascii?Q?PuL8yP9jM9MNQ2b5kziJ+whxoKmfGdgLcOCk3f1xMPJ4ytHYZMLRq4p2LQzs?=
 =?us-ascii?Q?yUlAMdQ/SU/UEmu1YWa8hs8qHcwb+2nmCAYvbfdwfYlW602QwPUXDlLhykU6?=
 =?us-ascii?Q?v3HPV74ilqzjF1N0a354aPVNSDFaVAAeQPk/DqMVB6zHKVfiWcAE3lCPMkGa?=
 =?us-ascii?Q?uL0se7Uw3XvGdGpnN+wunGzET7mWBcF6uvQobfWPDqEDVDPqfNM+zdQBYJnV?=
 =?us-ascii?Q?DMKVUh4ECiamvNtb5jPiyXnQvftqlrzHrAb85Vc9ZqNmtdxKFj+w+pL6Dwqs?=
 =?us-ascii?Q?LnMn2kX5NVmWAS+agbC1MH4ZRDeqzx5OnDD4RQmuaKpZ1VD3trvrfCbMMqzA?=
 =?us-ascii?Q?tEICdsZ5a4Ud4oj7E8adnAv1aRBzS5UigSfbHbJvXP0XlMTfcgLu5Tv5FGo1?=
 =?us-ascii?Q?e4mrrdeObuXlv+jxIvsk7W+IrgzIraLYrtbaKrXNy3LA6Z3OOB6BGQxsyDba?=
 =?us-ascii?Q?bSmhRslX10k3eQp8AGwZ6/k7/Osx52lQjkDjlhEHNT0F/j71g/+d/cOOCAqG?=
 =?us-ascii?Q?HZ3r4bWjHRA6zBKIPDwHvUHNsQACXl7Lp2zbgaPeKlkMyXgJzC5sNARK8DXc?=
 =?us-ascii?Q?1L15NPi5Ik/7o39zOv+R/Mhj9VimM5xf6oaOS+B0exbdR1gmNQFxyLoLjBVk?=
 =?us-ascii?Q?3n3DIzgM07ymJiLKHAmPM7lSNnpD6p2fLvJYLXmIfJCrb1StNj6doIYDWMLg?=
 =?us-ascii?Q?OJRkr21Dod7j4ys0dZy1MJZNoMV2DpBaPAVXiKHB9Q98QY7oQSpnSt5eJLb6?=
 =?us-ascii?Q?StQfVCZTcAS1z+Iqxzz5p9xgIa1jQYpNOGZsQu9cAxDqKjPZne+4ypV5vOF9?=
 =?us-ascii?Q?dzmtbX6mJrpSPWU9X9L+nBF2Zaw3qSMhCyX06lMuTZSYL0IvOSANjWo/KXwD?=
 =?us-ascii?Q?QgVZFK2cW/zQdoo+nsZO2x1bgaGjT/G8XI2Na/ORJQf/SRpA7nDzgwBF2paz?=
 =?us-ascii?Q?maRAWc+MveNsjMzpcv1JS8MMBYVBcLbQTFHSON8/EB+p0QN6MOx2Z5xS2WyP?=
 =?us-ascii?Q?Cp602kWhGwjViqzdU8ocMVNrU3elDGYwnnvg+yKHZxAb1Z7WIoZ8BVwB6LPm?=
 =?us-ascii?Q?WAGh/1vTlSTHPk5MGwGg7cmcH1yrvEV/5McVB+a8yYdfW63M0Ru69LlxAHSi?=
 =?us-ascii?Q?gSYCTR/onMPkYIlOWag=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50d5fca-b95d-44a1-3441-08dc8adb4d0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 12:29:27.6055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5otz7KFcQdejhsR5m2x+NgGRaJrG5J0MV7w1O+iA84xdbsFhw2fJbOBzzdpwfTn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130

On Tue, May 28, 2024 at 01:09:53AM -0700, Nicolin Chen wrote:

> +/* MMIO helpers */
> +#define REG_CMDQV(_cmdqv, _regname) \
> +	((_cmdqv)->base + TEGRA241_CMDQV_##_regname)
> +#define REG_VINTF(_vintf, _regname) \
> +	((_vintf)->base + TEGRA241_VINTF_##_regname)
> +#define REG_VCMDQ_PAGE0(_vcmdq, _regname) \
> +	((_vcmdq)->page0 + TEGRA241_VCMDQ_##_regname)
> +#define REG_VCMDQ_PAGE1(_vcmdq, _regname) \
> +	((_vcmdq)->page1 + TEGRA241_VCMDQ_##_regname)

This looks OK now

I didn't see any thing else really important in this patch

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +static inline int cmdqv_write_config(struct tegra241_cmdqv *cmdqv, u32 regval)
> +{
> +	return tegra241_cmdqv_write_config(cmdqv,
> +					   cmdqv->base + TEGRA241_CMDQV_CONFIG,
> +					   cmdqv->base + TEGRA241_CMDQV_STATUS,
> +					   regval, "CMDQV: ", NULL);

However it would be good to go and fix these case to use the REG_xx
macros, I noticed several.

Jason
