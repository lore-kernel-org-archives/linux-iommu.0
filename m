Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786C6AA9
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 13:44:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8hLX3ULpJNWNC294UzBRqmxQrQtNmpk2oUCWNRj7kXpqWvjl/7QSm3EUXNXy9N1T/UPhN7g95gYuoFxxWsQ7mRb5zukn8TxkWHLG31gTjgUjpqsFVwbh9Gx6BuuPZpnVO+NuOQyOWJPKJtC3B0WnnEvWg0DbtsSyKsIQaETs6f4VczWmtceVuhjhayUUq2uq1palvjQYijaDY9gb6W2WNQ1yC9wTaymxV/r1o66AKI4K/iabwiEOnC8f1GgwAG/OLNIMssfsGdM6/wtWGtWm9LEMZaNz/gzpt0ZWEOiV/ZWpqktFk8XT9fS68fdyPOLhWMBbP5rJzBHp2M96H/WpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2najHbnHRv+L/7U8ckxp5/SbxiNPBWbKx6wGG/A/r9I=;
 b=BE0Ck7CRuh6tuEeDPtsvH5ZAr7ebRGFw1GY5t7GtJq8HV/NEdcCiUQJwcVN8ixiMJHvoePH2d09qwnzdSS7Kb4xW0AX1ddiyNjeglf2AB8at5i/knVK7as2uneAY/dyByZyJYX3gwWEQ/IuBTUhk1uFEc+FQLPmytic1H84UP63qPiBuArtktJl6KrfgYfeJyaHPucj4d9u9/ndtsnHU+z5bjVK29NYDtCIRjI25TOwsJbOA6LQQkjn3QdZ8HCM+sg2LI1S90pztOD2EOrAw2ESM8bphBECdYyJrP/HTXmpfsl6/ZCTYdj6iWyLFnz9XJ7YtCyFSPZlvnrjC0cLtqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2najHbnHRv+L/7U8ckxp5/SbxiNPBWbKx6wGG/A/r9I=;
 b=bDOORwX8zaEXqNhWNza9ZGu12CTXO8FdK1Q3YudUhIGIT2DH7jb9REhxMq16ZOz8/EfezmHUk593gVIp+BkiCJ+npWoTYcmD+DyZ6X/yaqubNPVgWCwy8874LAsSnjqz310bqsHEGXTyJCAqryPI7NC4C2O8af2rh7NPXcM4GLZ4Ym/vTObogzUFWYDu/W5WaZSq7KWt/8fG/2fAojL+951J259u1DQWCQJOwIhJX861c22CgS3eoPujSd1GAvFVrOUemOzgdsfU9qS6uzHPDCnXtV4sF7pRT9sleIn2bgoj8rrsl9SJXomfYEo2GP95UHC4wFeE5Wefp2UuhQ4jPA==
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Fri, 17 Feb
 2023 13:44:39 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 13:44:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 13:44:38 +0000
Date: Fri, 17 Feb 2023 09:44:36 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	will@kernel.org
Subject: Re: [PATCH v3 1/3] iommu: Attach device group to old domain in error
 path
Message-ID: <Y++ExJjI/RAy99Cx@nvidia.com>
References: <20230215052642.6016-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215052642.6016-1-vasant.hegde@amd.com>
X-ClientProxiedBy: MN2PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:208:239::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|BN9PR12MB5368:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 995f582c-2320-44ea-ee98-08db10ed1ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ONhwJ0D6O70AoE8dWHjZDY30yECVo9GL9XPSW2zDii+S4jnhLTFSuJSrGqfqORx+RFFiD0AUlj95z3JFKJfvmyUBqvg8cebcJomq+IvkijBgJz7xzzz+Ok53Wf6o5bZMM/Q4UCcd2geD52V/YGy3/3aSKAAEm0g3huxOmstb5aMI9rsL8yQSkAktFH+NET/5AN3fzbxx10ybhMLyuhMxjcfV+Lq/4HQiUwQiPkyJ10YobRfzNuDHgy9PvKj04Q5K4M53ppPA5e5Gpe9LcXjMNht6GT94lJixQeLc3CXWC0CijN63GkM2DTPGSomCkUTyp5BkKHxA5IJiM8FIl9CAMEX9PJaAawlOONnevrcNOBeYIhLCDl8JocbyFCAmt697jSq7WbgwfgZsJ2Zhw/j1a9YcRWdO+xZz+RTYecvKnE987bO4lcmU2hxWszWa+PXFhukQgSaueGUJOJl9morc36WNZrnd5PQxR4NLuWKHtyug9VV3YEfMRxCFf5Xd5e1mrzY9Y/H6LCiPiyPjJhKyCN6XaC0ZEWvwzmurvX7YniFPxxL+AHpo+8xpmm8dsgVRHKrFHdLs1oWkWfB6icsQZORXAnApk3GUbly5l700AYnaUbB4/vvwBxZg//lnzuKkRk96e95866mhp0nbrZ1mIQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5368.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199018)(66476007)(66556008)(8676002)(6916009)(4326008)(41300700001)(38100700002)(66946007)(8936002)(316002)(6486002)(5660300002)(2616005)(36756003)(86362001)(2906002)(6512007)(26005)(6506007)(478600001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AcHxje9XluTzHAyBFJeSauKARBldBO2Q2c9/hEfHqkrULXHlv2zW5e7gts5v?=
 =?us-ascii?Q?4i8yss9zspWB7IoYe+ZnCPF+EspPpGZRfY/Ej/RxjOcgKrFmY2kJOJ78liUm?=
 =?us-ascii?Q?DsZLiTO79JOn6BQPNjr51hmU7mLV9Ym9b1skknCR+jMOV06/Zz9Mw9NRq2KK?=
 =?us-ascii?Q?+zKO1zMdzBckRQHSJ06FlkkgVINsduWA0Gv2E3aP93pzhlxiqJN/JxsfFqYJ?=
 =?us-ascii?Q?FR3mXKARsYyxiYvbi2UqpTCaS8xOYaJDXnLtn4taRddxMyC+X1VaF0CrDdxl?=
 =?us-ascii?Q?j0cZwBb2DW78pAZ/2Dr6eX4prv+PYPMG1kOC/O6R51PuOkMmWxWok48yR1u7?=
 =?us-ascii?Q?jm9qxG1AcMnssE6idUrAAfdRFLH0zmknSUuH1wIJZyNdApbDb5ffJNRVt0HU?=
 =?us-ascii?Q?oX1OHecex8H0HpjLPNJvVCiaCq+8Uf/hW7mvfQnMZKdqE4bx5cdpie7xxzKV?=
 =?us-ascii?Q?0oEiheeXNW98NtWBaPMcyf2ZLs6GjKOq9c/WfCPRPS/kcVC54kU3SWdrp/vX?=
 =?us-ascii?Q?7nuuELBkF6q2dZPL4S5Vva2iLtauK601eA5ZWruMK0Y2j1kmq/ukNRwMR7OD?=
 =?us-ascii?Q?dhkL+yjCygQ/MFO5iH4wayjK1oXLVNhzosuAqQcBRqWfvbJ1M8Pex9rIzMYX?=
 =?us-ascii?Q?ELZmgX8QVQKklkwCwGia4q5RcX4JFS/bQ9azi5zCeOneX8RBHacP50c8/dNV?=
 =?us-ascii?Q?1atskIQ81r8G/S3FeOwsZi63xq1ST+wTqhWzsBrYydqJJq2o3UxIk/LWrBpK?=
 =?us-ascii?Q?ohb6qtY03FuyT6cznmWLF/TjqLajqJ+WjMJ9mdwx9V39xYtv/QvmTC13uOYw?=
 =?us-ascii?Q?smtjBm4e26jsD5uOkvql4aqSvcI4Q9MBKQGQIR9pZxuxBy+hmg+I9UOG+KtK?=
 =?us-ascii?Q?JqHerX4hOhBFlz3vB+HpbaEeuzVcIAsejWc8HBEPjQxsCmjJtP154DhSDsc9?=
 =?us-ascii?Q?LSgaWXPDB5Wq0kMHQ9XayOT1U4TrGUxllQaY+yZokNJ5wgR7sRHLMX8GpG6m?=
 =?us-ascii?Q?hERLD8+E3eWqf5fn7AGJwHkJRTgqMTd5izBCz5kSzQy/zHl5ZPL8O4J9Esk+?=
 =?us-ascii?Q?QAVqJKQikqZ83C80ZXFmHTqzN2tZY+WJhUyJgfSrZGBb2+OaD2tQwb4qj6up?=
 =?us-ascii?Q?XCVL2Po1Z8CE7wFSdjBCIyGCX5LvTGkx7wsA21XGaSdoOjhhZr5GMvN3PisF?=
 =?us-ascii?Q?FZPFaCkEMuPfYrUtsJ//+kSKGm0hwU/w+pnkvQHu8kko/ePpc1vaSMj3/l8T?=
 =?us-ascii?Q?iVA8WMMept2wlR/coNJCbnloHeEhm3PrLPTk69RbwRlI0Kb2uyWEu5Pc/ZvO?=
 =?us-ascii?Q?rJ2RISFp9kumRvkXugKwYWczL3QiwLshcZ5lqiT3tKSEBfA9LGfOXi9s3+/6?=
 =?us-ascii?Q?iqjBSS4tIr6RfsVJyQoa024XlQn+UFa+ltBJFONMnzBb501fsc3Rp4Q850qM?=
 =?us-ascii?Q?LXcaN08zhoDaR7Z52krRmVaap6LOGO2T2P4jFbjEqy0OLASiZvrPfcdShmJ5?=
 =?us-ascii?Q?2ZwYw0KtB8kUQsaKwGgqynhlnfM+nX0A3FBdHjqQngu4poteC/E8KrKQHncu?=
 =?us-ascii?Q?g/xzt2Sonae5DkNUXmNe0J+dzGVtdnLOfF03R1Z3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995f582c-2320-44ea-ee98-08db10ed1ca5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 13:44:38.0580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZY1IKksOVxuK0k2pbZ77yNM8COqB/XDGdWtRRJHqxolZMfY3NFn8JSn0eAr+cd6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520

On Wed, Feb 15, 2023 at 05:26:40AM +0000, Vasant Hegde wrote:

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index de91dd88705b..e3336a11b6b9 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2124,8 +2124,22 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>  
>  	ret = __iommu_group_for_each_dev(group, domain,
>  					 iommu_group_do_attach_device);
> -	if (ret == 0)
> +	if (ret == 0) {
>  		group->domain = domain;
> +	} else {
> +		/*
> +		 * To recover from the case when certain device within the
> +		 * group fails to attach to the new domain, we need force
> +		 * attaching all devices back to the old domain. The old
> +		 * domain is compatible for all devices in the group,
> +		 * hence the iommu driver should always return success.
> +		 */
> +		struct iommu_domain *old_domain = group->domain;
> +
> +		group->domain = NULL;
> +		WARN(__iommu_group_set_domain(group, old_domain),
> +		     "iommu driver failed to attach a compatible domain");
> +	}

OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
