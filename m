Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2437F19923A
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697476; cv=fail; b=pInhTNazpkokxpgKas+HaaUpv4j5J2vP5sjBatNZ8wQieGu/7Clfc9PNc4VYLHUr66iIGaS/4XHYgtUUqt2BFWcAPpWs+4w8i6R3dTYBnr8KVMBrgdRwD3NJNZZD8MHJJpPOneTyz/PhadFtYyICj6bTeITr3/1snGc/KBkTeIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697476; c=relaxed/simple;
	bh=KvtFhaLCNnzDyQGpoeqmGkvIws/74+cfUbJkZPhIo80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ipQoD47Iyun/zNWxMMLZsozLvj2Fm+B6ZWTsj3Dxbk/iU+TkQgYIoyWIiiU0eRfxk4PErmiyMJqMeX8lMohfw5wof/Q4PahsH06O3K82YiS/KtNYulZLbovrpI6/dNDSu2LlBA/QaMoRHOexzhPuaLQ7PR6/Qk7lZVKneA7HmDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bjgnOWWe; arc=fail smtp.client-ip=40.107.212.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bjgnOWWe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARwqgl8qAcDIBxM64NZ1jor3ew8Gb+wW9ESB8vZnGcdt8WGzGPGaGw2bs3GQr1J+Z2289N7nHsa4u66lbhvEQkyQnMcmw8Cfevb4w3a/26lEwV6w4ImrCHl8ccICvSPVILl3uyE8ePxjIAFq0zLpJiJMAzilJP0jxA8rbsuGiIBzV72ONtfQqKJ4WDpmsZNrXfEWw2S7CioSVAWWc3GBeaISTszf1EfFZJvSeyvFA5VbA29TZpNH1wr25QVN6M+Mt4lIybPSR1EgYOaA7xRJZE6YNh+A85EA60rrZfEgyswz7Yxd0DS+t9UtIM/66xIUG99eL1Ca/iTIKo8wFL7xZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5q9uxq1E5RqQdYsPczsVDYrpaktyB68etuidAQ0LFE4=;
 b=gkUn7u9HrFWw4OopNCij9FK0utEp5VnGwvbyCMozGmy9K4zjKXjRkehMCChdp1+RxuS1CmlFsn3a+0ZL46oRxEv2pv1Jc+ShqiVjKu21MGz09iteuhGFoL93EgD9VrX0nom1SvFGUrz1Eoe/6BcBje4DT/X3Xu/xM2/jXXaqbu3cyB5PTtSwH5Rlc9HPFkQEPKZU71IvDbaFvrXXBxd21sytF/ezVAzztnIpemScp7M4yxek3XdfTcxvyVKETEMP40p5RQo8CC90AsByiotL7yC27znSqQw1/YsXqWf4raYU4NfZSQMI+oOqotUkzOMTPiVSWFOGAgJQuBjpxwUqBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5q9uxq1E5RqQdYsPczsVDYrpaktyB68etuidAQ0LFE4=;
 b=bjgnOWWeWHZ9wRW/13IZ8mMz2w+KeWK7A/+gOfZekay1FESzy9SvWRU7FjYoVvIRfsk0Fwrs69wMA48fyzPKo1eG4/gY6VurRxg24k49DrbBYkzVemowWO8LksiyGussOBOhDwJQZEfkiENp3wXQktf9p8Bs8+KfQMB+jxV5ey0aKKebJrsUhoS8EqTIklJ4bBuTM9txoCfNTuJfLjobxvUdgq8g68IJTIahrfuLs4DINensISn0uqaJENy/Fxm4zBeifxuVVSQm5fFrFiCig5JqQpKkECViw3LIIKXAVZrTQ7VTO60l1oSv4N+RVeiuQdM7mDstZnviVT3VRh1GxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 18:11:10 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 18:11:10 +0000
Date: Thu, 6 Jun 2024 15:08:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	ryan.roberts@arm.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	mshavit@google.com, eric.auger@redhat.com,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v5 1/6] iommu/arm-smmu-v3: Factor out a common domain
 alloc
Message-ID: <20240606180846.GE19897@nvidia.com>
References: <20240606133302.17540-1-shameerali.kolothum.thodi@huawei.com>
 <20240606133302.17540-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606133302.17540-2-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: BLAPR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:208:329::9) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: bab5213f-92bc-4a33-a994-08dc86540ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SMGJPmOjHF8yjuZvz+bb6LODjv+lYRZB+dXNSIJvndVq/Osjg3w/mcuiwmZ+?=
 =?us-ascii?Q?eLdwaiApoNl481a8pofEGGzpG4PqahTO5IIUZFN7jLRMyWpADmuAnA78l9TW?=
 =?us-ascii?Q?NmSwlwNksDDmGNox0QHMbFTx1PSt2N+Vy0foczhw+d+exY/j2ChzmhPE5X2O?=
 =?us-ascii?Q?PRalWfC2aGbWGGOtd7cu+5+Gd5foFCxT1ioeW71xlZt0tK+k0yixaEONELHM?=
 =?us-ascii?Q?bqpY/6vR555IC4XWqH2DCiyuQxevZ1H5MP7V3SrtQaScVM02iNkIthm+Bfh9?=
 =?us-ascii?Q?VjB6+gIcZm6ZRaPeYTYw6AfMBMhA/vf9XrBHlXwrIDTNAJOXwoqO//MmhpUy?=
 =?us-ascii?Q?u4dxx1/wqcpjtET8QncKvgLyzQJDh1PznCOHwM6ZGjIQuGzCGx8FkPccFD7z?=
 =?us-ascii?Q?PDpf1cZXOZYqhYi/Fp96U6BSkD+H4xLYu4rkUxxk5d6iI0HtnlUNmIhtdJYH?=
 =?us-ascii?Q?xtq1/cvxwuLLp8J6Di4gpp5IT2CHOUGLQ58KQcVEGtYGuywvhSem5cLeMFzh?=
 =?us-ascii?Q?iQrw0xTxQpiOdUG2Or7xiJ2mViRiWtGXSttgbAFnQ1Iw/pC7WaCntpvZmx/9?=
 =?us-ascii?Q?i3VujedYo8ZVjkNO66XBcOq8QCtdBTPGAeJzwh0pgiJo4seLZaF/c12MvwPS?=
 =?us-ascii?Q?t8xFJjf6PBA7ar7MZ4cSUWQxBixHMHUqsK8RXC95WgD9yyncLQ/P/VIJh7l5?=
 =?us-ascii?Q?OKmmGnI4a93yD0QtX5sefjsyH+li7nswlxFHEnMIHeZ7uJo+JwxwN4OvR/0J?=
 =?us-ascii?Q?AHpKbgsNiLrq54PQJdkKOtdTRz+4EuYOVVnQ22olSrnK7I4FLk18AmzzFynX?=
 =?us-ascii?Q?p11bNUsh3e1xexNvJ6WIMmZTfVnUjr1Z6rX03ishR9YQzdR//Zfmcc0wDRPF?=
 =?us-ascii?Q?xbXF03TvivzfKAez1WRyNKCKoXxRCY1Key9QYYKTAELj+qHaIWp2DDFY/HP7?=
 =?us-ascii?Q?6In2JSZMjDuPgUm2/pyIbbt9pUnHH6BfG6Li9eSJu96bg7xE+rp3eon+7z8C?=
 =?us-ascii?Q?5P4fDVUOXxb/dBDMBDI6SALnjlDgYm9uQuEZO8fiaxwuzFNVXogrBuzg9I5v?=
 =?us-ascii?Q?xFN9hzBKd41X0rgBpNy/rS1gQOROiloRBbjklEyVktbymyTBe0sLDhwxPewW?=
 =?us-ascii?Q?6z4gnxDDHTB/jI8HkBRm1P/QDr6EyjCxiZ475sygIlkPROldZLIezB68b6Hd?=
 =?us-ascii?Q?WqRbwDdyw+5peML1hxfOx9qntAe3vzB2X6+38+B74FwkaSo+GybxAyG103Aw?=
 =?us-ascii?Q?OJMX3Hs5RyJXmHYC7YsNHX52XpCMJtSobkrsIwZygLU0ugqgo7DFtX/TVYao?=
 =?us-ascii?Q?p1cx1NfWapA9dK2mALkJ+qG/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4mXYG346ojqXePy8RbbcG9kfmsefi2pctzFA2an9dsREriuA5zrgCAFi/eea?=
 =?us-ascii?Q?zxHLau1v4L2os3je0tsptJBPABXjQGPpCs6cJRE5iDI3ye5GbieEPSL6GrMu?=
 =?us-ascii?Q?P8Swu3VyVvZFcyAuvos4Pj/lo6i/AYq/ygXcMfzFUX6TzTv/K29wLsqfw0an?=
 =?us-ascii?Q?8v02WwESh3tFzTnyV7ViVqwigq+8LXBZxN4vp/xd4x5cGkVBRjKLrc7akv27?=
 =?us-ascii?Q?xRhGWMA289RnQnZg/izbyt7VB/7eT8VYt76L7YxVuDIv6q6+UElmI1k1WvJc?=
 =?us-ascii?Q?52ZukhDl8nnX/k2XfCYW9QuqCGO4fcL20zkMLNhr+laeyHkbAHcI4tFhcj+r?=
 =?us-ascii?Q?MKQ2WP0j4Ke+yPgwDs6MoMVtWutlFb0bLM/zLyGDM7NDghPppOiUinogITOV?=
 =?us-ascii?Q?zAp2c6cMLZURkc2EOAftba2XwY55cHuwnkXEf0o2iNJlNa5olyGmOE0988IV?=
 =?us-ascii?Q?jl+mSkHcoUYCWzSQqGk3wDGYsTZuZPHWXbqoHygAaOOg5lxTU6U0b8SOi9I8?=
 =?us-ascii?Q?Dh2mgYOl5qcesi64gk/dz27ZXnsPtRMBM6xcfGHgOLI09Hrj6b1UhC9aYS5B?=
 =?us-ascii?Q?vL6iE7/djdEhhQnBw0xkz9o/dHj2H6s8+RmtL8nbot3FDu0jh2rcUWgtWZWd?=
 =?us-ascii?Q?Z+pGLhoFuHSO7bJERX3MiZuz4L/IE5b2L76mpcpdVQVDtJ9IcgmFGvX/jiBq?=
 =?us-ascii?Q?x4Aq1vNGEtqHFLttHVd7hTe5XqCNojY/ilJyVd2ik60Z2dhCSjxI7bUB/nNY?=
 =?us-ascii?Q?ZTjdt0UqrDiqra5IMP1xVJBhxu1pZUlsHMu30AS5NsCW6NtHgXW1sz/79JcF?=
 =?us-ascii?Q?qXv0U4rKK940oeCMP5OJCFoNroFo7zjSzFhiJKlzkpY7m/tyuhsEq6MeULaV?=
 =?us-ascii?Q?g5qrgYm2l0aVKmj7xVfOjNVKjPUz/prvzr7QwaHC/GbCbUtaHCTMMkh89DDd?=
 =?us-ascii?Q?3wLTtEHex7j2eO23PKpHGNNYcZtayVOkgHJ22/I1WLjr5QKXGNXmnpt+nPXA?=
 =?us-ascii?Q?2cyC3xZyJV+fekg7+QsBjLr2oZkwoQw2CujvgUvu7tt51aSibsCj41slYEvG?=
 =?us-ascii?Q?NiV85k4yLlmgl0EmAn77ecJ8jThQ/54Cs1JznW7ww9cz1Hq+byra/Av7OE3/?=
 =?us-ascii?Q?80Ilwb/oalfWeWqTk4SB97g/gn4NSJmU7Dj75VZrkKfJmtAJuLSJ652TIeV3?=
 =?us-ascii?Q?zWHo0IOqbaeRdaYubI32IYiBcgC3LgEBFP5ff8qO2hnO6NCdT5wdG84gd2Qu?=
 =?us-ascii?Q?cvCaQB2o3bWsh54QpjokiR+wVSgkG/qund9jDNUFSQ6ethQwrphXmKFa+eeo?=
 =?us-ascii?Q?9em88qp/PdLKzT8ZilQbtRWs+sB1mAZl7cO9Y5DNWXh2oWTdFvVDCQbiG8bH?=
 =?us-ascii?Q?DdL5zuF2woRhVwdhBUb1UNsB6BDH3swHl2G4jnhLyKt6K7b1IUYWEZFvToF5?=
 =?us-ascii?Q?UIcE9JFBZZ17+nSg8HlikM8VbzPvQFrbINfEvi53vGT54URprVKD21wlk9Pg?=
 =?us-ascii?Q?+Dsf/pw/xpd9rIujKlYNjgY/SgwRk9++Se8n4bWwfIfpzl1YkhgTREc2qmfU?=
 =?us-ascii?Q?TshsfdwNxgEI74dgp5EMd8uhj3RmUNjrs7u9aVTC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab5213f-92bc-4a33-a994-08dc86540ae6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:11:09.9718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neKA7SxbCQQT2vluLyWJOlIEGt8/45k8Z0aQdDnUgopn+927yYOQnE1KPfM/6o9z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318

On Thu, Jun 06, 2024 at 02:32:57PM +0100, Shameer Kolothum wrote:
> And use that for arm_smmu_domain_alloc_paging(). This will be useful
> in a subsequent patch as well where we introduce support for
> domain_alloc_user().
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 31 ++++++++++++++-------
>  1 file changed, 21 insertions(+), 10 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
