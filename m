Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80310208D78
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083609; cv=fail; b=av4Fe1opYsg1t282ACX4tRXfzS+9PxJTce2uxBefAtvfUOPxHmcJRdi9pinxx72jldGfGYfbfbhhTWvd8Uz1nAXdK9f8PrPJ/eUNszHRdgQzYrl6vj/SNsDiOy20MYsKMFLCmKiaYa3oxk9x7NEF2wK7JU5RQuaSEyw2EzrVR2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083609; c=relaxed/simple;
	bh=lpCrBQtHixj4RPuOl+NeosFv4jJEYUd9huqq9t2mA5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BDt1cK4+tQ5LJfoieQAvRmejm5Nbof1S3hYddN6GwGmqZ9nJ8gepkabI9xwCBH+TO2sM/M/p5/v5JD7YCtbbHSNRqts1lz7JMNL6NjnEKg9niPoZ8ZN0hduUmjs5knjab8ivEiSiE1k7l2DHe9mie29xeeXltAd2IGt+byqUxzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hM1nW1++; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hM1nW1++"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rhv9ms+57OB1Bb31S92h6T961xkEQ4tfiSUwImw1SJzrKWRYV+wLHq9KmzAXrEsBKRNZKRGXp3VS7b54ZFXqXk7hdb3NYZBh13nBOidp8XUmhiJa4XWO5iBY263H8mvcKSKbZo0agl5kVcl00Y8hmyge/+qTqB0S+AuuhykdtkESLX/GahNy8lkmgEeAwloghbZluavUL8zOXhIGqNNVKTqTNLjlec0X2z32+tLbzkLafOtbv6UrslvJK7AA0tGRvAKF05Su2x68l56772TqEqJiuGDaGDiFtyVUSwSWkXfXnkaqgKa7hz5XS0pGGJX9uO5lK9nn+ZqEwG+wd5AF+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lik0kvlt8Q6sXrBp07dFjNHlWQa0/w3AlpqwoBqaTc0=;
 b=mnJk0xuLUq9+WLqNFFIVwhrMfoYMXWDX6NVehXtaGJqmC0K3erYH26BvUClakv5GdjuT/1tjPOD/d9+rVf9IDVFmJOU5H73u9Uba314KSY3zsu3Hw1e3QO2PzgAOPzzqoofOicCwq6Wd+OhemMU0FaK6KRyIBkdb2Ph/VzXZZ2EG0ZhAxkT7DTVP1S+5YzdqH6COau/USrOup8GpCQL3TK0ucb6KlitoeBuyhT78JAlZMsJcia8Rv6rDnUUk2sb0n+LrvsJkHHOra3twW3+lSONGpo3pcsT7ygqZnvyBZHezbgaK5PJ2HGwqEXW3lgo+lBwLoeO3E1tBD5tqvu/Ezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lik0kvlt8Q6sXrBp07dFjNHlWQa0/w3AlpqwoBqaTc0=;
 b=hM1nW1++bF0Ge87ib+6d86EKjXwuc4uWrND3ecC58wQJrY1XxBnX9GR4hFEjvWnUYmVJzenrAkN26L9IRKl8dGBbQC8AmZnifQpKl19YAbs2GHm5C6tNHvkgzGopw8utztbf1a0tFsdqTOTjouYfED1/n2BpHd+LYvMTxmUp+8ZiNRm7ASPkLGXyCSg6i2wj+KTP+svT0VTPgUBH3XShK4+osxWDHlYOqo5hbuGg+l/Iy6UI5vPn8xbYXvGe+so01Qb13C7/vmfqqXGN2UsTF63zI09SjwKNs5Sgi0Uuk6WByF6snsLy0ZWeG4R8d9V2mpeZWP+tw8b3WjCRrQf8Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 13:00:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 13:00:02 +0000
Date: Wed, 16 Oct 2024 10:00:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
Message-ID: <20241016130001.GI3559746@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-9-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728067700-32092-9-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BL1PR13CA0283.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: f4584d44-6441-4172-913d-08dcede27290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OgspYK02glPcf/HwVcZo6fwokO/WaVhxBsixhKp6AX3qa9jK/zO8t0Oqh6Q1?=
 =?us-ascii?Q?IK+5lvIEqG99uqo1h0cak2N7jJsrMjKXA1/XQTi6NXFf8irY3gXMrYqOb9PN?=
 =?us-ascii?Q?NqaHQuLT7kNWGNekg7/qvV3j2xODE7HYj8PLnkpxsy1RvA2/cEgepqvjBocC?=
 =?us-ascii?Q?OXv0ywng2TQ40L1k1/5zn0OFTqhfoVjmo5nZQyvP1JkArmyqHWUbUppFMmAI?=
 =?us-ascii?Q?dQ5YxaU7aDCZDdRHHeMoHXXv4gPypFkumg67UpMpAixZYI21GRp4tvrDxADc?=
 =?us-ascii?Q?c6572kznlG0+z8Ajh6aazoGfBiAlr+ftHsi5NdckUDwsP6u3rBj2v/8j3kSx?=
 =?us-ascii?Q?ZXJT1XAP+90o+Qn8TPOEFGbXuP7nzHQfa2mYca8Y4csUccYesMhGkscPzZWM?=
 =?us-ascii?Q?q7NtG3HDYt6+OM0psBvR8aGZVekOFeP2eWIBs+8HnhXL2SAeBwI4vuEJl1IA?=
 =?us-ascii?Q?ljfZXEk+KEqCcBpmFBhyBr7ejG92p8utJiXVpqyBb+vtfVd0nvuM9RRmuUdN?=
 =?us-ascii?Q?CVirx2r/7FBi3oFW02/x5K15mTlQHYgRYLG/WnMjLVPggKb8P9bXcdYbAb7g?=
 =?us-ascii?Q?PKgr/1paJQwmquj+ennFccLLcLHddfXTl3XvtoAUQaeV+Lxey9BEfZcjkXv2?=
 =?us-ascii?Q?2K+heOhJ/OAU46RvBQfVazZZyMJupY6KDUyeQDxZXAQUz70nWdWUQ92EEiHc?=
 =?us-ascii?Q?qQ2DcHJHO4tBTD4wdM+UQcPbWwU3ps1rOMZpdVWmwHQ/viTIupJL5tyA3sSS?=
 =?us-ascii?Q?+pcvxsYIlURF2vRkSwom9nXsypZrdG5jv4TJh2MV8Rnn0LKeroxNLkD2r/cV?=
 =?us-ascii?Q?zVRh8ZJMYot4qrjCbw2OSl3EME13mgity/W7WeJSDYCnh/+qqXvn1Bfxl5VV?=
 =?us-ascii?Q?THfQzZUGtGcefEfXV+qUIlJms3Og6AfueJkvdf6bagEOv2RSFcN1HQq9N9yE?=
 =?us-ascii?Q?LYlp8NlB65YxGkI1hDv6uD5Cm2ydUwcs+VkArjoa/IReQHYr8utax76eO1Re?=
 =?us-ascii?Q?Qobg06iantK2HDnVmnTqElZUoGWVlIrPm6TxnT0A7+j3K+/FsblZyhvEQj9r?=
 =?us-ascii?Q?xle/bPUjFIyCPrUqCAiGYAqqVKb8QjlGD+aGgaqCpz3VqooY9MzLcLr8JHGy?=
 =?us-ascii?Q?dVn9nvR/l0OxQlgJem03/0dCoeY8fE0BrapDhqbQ/GEzDMNsKilZN4Bt5cGs?=
 =?us-ascii?Q?C3qW7a3AMCpXK0DqozXnDc16K0vxMIeLPwIHbg/3BQVs2qrScFyU1yehU/y4?=
 =?us-ascii?Q?S6gShmVXTdOkfHMXioFlPOALOl4NuDxMVFxwoLf/Aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZwSTsLLleqCVJh1CVkMiWF2V1oE0iJjpN/fzKBpuxvF43ysLJGZT6XOxkvDk?=
 =?us-ascii?Q?DRdlqsBwOogpllk30d61Yw5QTzzf08pTR/Wx1l9Nv92+pfR2AssOusEgA32x?=
 =?us-ascii?Q?DVZQ7JeTK9R4LxMgYSxFmjvQZEXvf+87qH7wXbm1dEOMEne2YMLv7RpNLTO/?=
 =?us-ascii?Q?lDEtlb06soCkLxRyZhP85nbfshvKrTGi6jG78m8tyAv2paN3rI4WInGLzaDy?=
 =?us-ascii?Q?6/C2Lzu7MXXJ9qC2kuu1G7dE5/2UjAKq5B2MK4q2zmZQnWLnrYjJ4vqWhYMW?=
 =?us-ascii?Q?EAIKLTcaEOEHmwrkvGqdWLNCk/tRSnhc9YBLZF9AOZ+7icD7ZYJcvfY0r3w6?=
 =?us-ascii?Q?PaaNu+p9rK05IgJOKjZM6pjCPCWA8lcEhiupF3SwB1hee03vt/IbjYqx89uB?=
 =?us-ascii?Q?pCX2hnqtsRSJczFkxvSAyPD12lrmKjyfX+obhl97WaTsEbXFiBSYgsatrAEg?=
 =?us-ascii?Q?v7MV/Pf4CXWYGwnaacnCfcnxFONWUNMyXzW3KsnqGIbaetwdGzBfQfE7CWCB?=
 =?us-ascii?Q?gz6hicONnFZLkuFyE1/9KqgHwVUG+KhIu5xaRIzP86mFnxWqha6KHafZTLSF?=
 =?us-ascii?Q?L9YeJb+JB8GXv+n4PTJMcUWS2Evps+giC0O73zrwZCBnH35KLzBtRJEngm23?=
 =?us-ascii?Q?r8A4UlWikW8g22lm/Kj3Iy8fcePRRnwxmF9AkkLEpyFbf0J2p/caPOOz/+N+?=
 =?us-ascii?Q?bd24kj+gE+V327tuaG2no3uRs4wrcz7cJKdTZ3qxas1swrt4BT70hNvvR0KE?=
 =?us-ascii?Q?lG/tWP3blXT1UWeL3uPH4bBQN4ouH1ycuQoj974SSrblAq005hNB8NLT02g+?=
 =?us-ascii?Q?+D5IMRGrLz400Ojz2eQFzBO5mzyyCFN5RBGY9H47HrBMmiczUxD5tlLdg98X?=
 =?us-ascii?Q?XJNMhv96pLZaprgx47wp825cGpCMxKLzhRj4NJOGqBruco719Y2lBRG1TPQk?=
 =?us-ascii?Q?NfE9sjK/QPW5H/PQJhKtj2KbXQvgz/p5hyYqM70vgK3leH0lhhQjxMf1bbvg?=
 =?us-ascii?Q?DPLhxdrphU1j/tOnvINOR+QxDD3X3ByeJJWL4LFy8JXcwHaetmujwMXWM1VR?=
 =?us-ascii?Q?nkReS3RZa1qlWmIvDnRiRtKnUNOZ9YIVoeulKyzsGNhukxThAf7iJZodDxVw?=
 =?us-ascii?Q?cwbzurFJIHVEe1LOIZ8ATNAacBhSVgpbE/ZtIibXHTw6GK4BzW0lky/M2pLh?=
 =?us-ascii?Q?tCNrma/uMSDRRff2S9X3Y7+6/sDk2lo25ni1W8NEhs4mAEpBX6iJTOEVhYpw?=
 =?us-ascii?Q?S85fh2AQElMTNHJVzGZGwz8fHG1e8ncVKybP5dc0SQkNWsg9wfQRIsxE2vfB?=
 =?us-ascii?Q?+5B+cpgCy49PkN3aELHlLdi7iuBy5ptbJOz8GQwVvJhVKjRJWENNEmDC8GTj?=
 =?us-ascii?Q?ztOus3HoKJP9keA8zBxa5Rg4TT4l7BO771P9QBOIRZzxMGzHJHPhj3V1+QoV?=
 =?us-ascii?Q?YJQ36WSGpB4C8QGByqFo/gnAgwnpOXt9cJndBFK79GbjVOsGUaU9gxQhKwC6?=
 =?us-ascii?Q?l5B8Yi7RP1cAHRQq6THqX91sJkGLzAu40l+QnbrZxYcz+EMxz0Bi75e2D8XH?=
 =?us-ascii?Q?UfroovtyMjJQLFDVt9I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4584d44-6441-4172-913d-08dcede27290
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 13:00:02.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2RHLJK76tOiYjD0LJE0j9OthfXm27Bx4TObTanpxEQlDn6OP4Uw+BsLvW4CPeBS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572

On Fri, Oct 04, 2024 at 11:48:19AM -0700, Steve Sistare wrote:

> @@ -347,25 +347,41 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
>  		kfree(batch->pfns);
>  }
>  
> -/* true if the pfn was added, false otherwise */
> -static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
> +/* returns the number of pfn's added */
> +static int batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
> +			     unsigned long nr)

This return type is truncating unsigned longs to int..

> @@ -623,6 +639,67 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
>  			break;
>  }
>  
> +static void batch_from_folios(struct pfn_batch *batch, struct folio **folios,
> +			      size_t npages)
> +{
> +	struct folio **end = folios + npages;
> +
> +	for (; folios != end; folios++)
> +		if (!batch_add_pfn(batch, page_to_pfn(&folios[0]->page)))
> +			break;

This function is really weird, why would we have a function adding
only the first page of each item in a list of folios?

> +static void batch_from_folios_huge(struct pfn_batch *batch,
> +				   struct folio ***folios_p,
> +				   unsigned long *offset_p,
> +				   unsigned long npages)
> +{
> +	unsigned long nr, n, pfn, i = 0;
> +	struct folio *folio, **folios = *folios_p;
> +	unsigned long offset = *offset_p;

Let's make more use of scope local values please (put folio, pfn, etc
in side the narrowest loop scope) and the style in iommufd avoids more
than one variable per declaration

I would like to see this patch when it is applied but I can't apply
it..

Jason
