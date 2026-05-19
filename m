Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE11226CFE
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779212770; cv=fail; b=gKHW8yYUrMatU5CfIRVqFjPAYz84TILjQA+rIenlU/VIvppLNqYHn+7HrLo14MOQYAKvplo5zo3mM1xyHbNqA0Y4J/eJa8U12BimLwhEVPuur3rzIAkaeW7jRuK9eNwVijx+ruKGIAaUdRCunkw02QE01+94bOqotIjjkagO6Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779212770; c=relaxed/simple;
	bh=oMI2XNSu4SiY8PglFmAc+pxp6/eJ1p2rDp38m6T9sMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JNgX0Pn3E/lT27/pvRvAQ1fQuTEDxLxDRhHBzfzSqtTDvaRt94HjaZlsN+8kaa4L2xUx6KE0IkxlldaZGj8SD1XvhdlErLMsTpVl9SVMceQqaA82wmGVGDB5fEDofy1P1LYkWPmZqlPahHN1iSFWcxT1t3KFODtRUyHjWcLK8W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HOEA5lBV; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HOEA5lBV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2Lg4+xNmuENz5uP3uJX6TbRGt7xxgNFNVRIMoLSBm8ykwp6F2ogSP/OVmweVAQDywkM5QEPBYolAE20creN6lXaEj9a1NIiae37i5coCqvTjc4R+cXw1b4XTs8zmi6+QHENmu6LtX8OVU5U2TZx7lfQNBP4D7Ac1nCBBROjKeL4kZyljqjrcjJwAZkT4JKRVqIw9jEJKPBlyB5TmIWlUtODt38+9hcAKc98bUruvHPdxfR3d7U+TEqguJgrS2XWWSdZostXkmTXnhOLzHcs4ip0oWcqX2dT/egd7EsxOreNlbjQ8nTPbf6IBqwRxOJWb+yKqgPGtaPFpda30iK3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZdLWT4ZuNOZ8mhVDAfvF34w326j7CFVPumen/4Cjvo=;
 b=sICvRkH9KZ9H7K6J8pF/2TuKnufwzMJWfyNaQBUqetHuD5UYU1LspU3Inu1u1a62Vy0tuxxNJzV3nG6lSD6OuF1Mf0giwIi3VovqRV6Ne5/t0Ra7d5sHW33Kp3Y2opdTf3AdRecRg8mZT3KlN8QUoKnS5R9hSAts987roE2IBpLdKZ0wsRu3L1qG9qOXgVc0YrLlGmUwCFudJdswMhAWQdsEhdS03fZVMknB76Ccb8wT877/tYWxzt9MZMuXozb1gTgtAymn4WfnIYxxSqZ6TDGXfE8zV31BIqUF9WXnZbSDlao6nkfUEesF/mLia+SMA1k3FOA6Bji0VgREYz178g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZdLWT4ZuNOZ8mhVDAfvF34w326j7CFVPumen/4Cjvo=;
 b=HOEA5lBVr7iL02uaG2tOCOHkS4i/yx2/Tq8DSdGXFTq42LbTnozYw+V6uOT5YKiX0Cq7Y9ODYl/yW68dfHkr4BuAyzjpD+rwqNE2bnKvlp5CJJ93umg9vslur+bQiQbtnqB0uBpwdXHjD10hrdyZA54ifRuJegyKD2KOOdsTC4P9KdA4v5FFufwEHSXKi8mLEyPMp9gOqvlOTIjDFGknLWy8ePCMnWqwm5r+VAKRIFia2mAO4qjukGoC5cXID5OS4bPfE8DPaajaSKyddub/stTfH18uydA4b7OypuH8bP4oZA0xYYpSTMgOKh4ryxCPyM9xYA6iCG64oeiduwaQuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.34; Tue, 19 May
 2026 17:46:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 17:46:03 +0000
Date: Tue, 19 May 2026 14:45:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	joro@8bytes.org, praan@google.com, kees@kernel.org,
	baolu.lu@linux.intel.com, miko.lenczewski@arm.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH v5 4/6] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump
 kernel
Message-ID: <20260519174559.GG3602937@nvidia.com>
References: <cover.1778416609.git.nicolinc@nvidia.com>
 <8de5639630e5723d6f371093cef93733f0ca534d.1778416609.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de5639630e5723d6f371093cef93733f0ca534d.1778416609.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4P288CA0045.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: b7625c8b-5f5a-4084-3e1a-08deb5ce7d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|11063799006|18002099003|4143699003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MPGXPDRRdYUAf3qBvpAIDKKUJtErX+3G+CHkrVoQY2qri8Vi4ubqoOQcihuXV2ZhDsrUVddYtZuNqKC3TJJlmme9SnhORD7FyQDgQFR5c1mcfL2rbxqzYJZbZ8vU7Bs7UdQNpkmT8ze2HIzPcZ3s5pRj8rq8jPsZxJp+LvRqNDlAVCiud9c2Moh67C2TDi77tNWGehilpZv8VIPa8n1auYwrGG6JwLldQIdhyhL1Nrj3lN9Ina59yTWZdD1WMZZC3iOFw8jH1TfUH0scMJ09z+ecEW30+mFNmh0g+JKmr65M/H8lJZLMNGm1XSIZfw3r5U4AspjJQXxBamN9OBw6ybaVZsXEvmAoYK8UhZXkseYiWo9Ul2yb8ZszmS9TPDCNoqEF7qSNmlOKy8UiI9FYxbu66rEcb0OKJ2B9JcA7HnIpLYoGWdSz2PWVwgjcv6edoO+hzrjiBLchFFca+2JSwdBm+e4uE2uOOx1W097SNgGCcrvI/OcT6txOUAOWo/HN3PP2VhsdUTRali/CGosR0BJZ4uZwJ2O9Jzel74npVz+IWSh9oLDKofY44ZpW1zQqpAw2Ul03/WAaTIhBmAT5ozMXaVCzP9+yPesNEurn567mLoBir5lRtYZ0IVLVG3cOY1FZv6E2/vQ9wT//c+R8nIOy45TQFAucwMBvWH1oB1LQebuDF3hidLGODCC1vl+Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(11063799006)(18002099003)(4143699003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YJoWiyJ9oqZvpGRccxHEBCl3/IClpi3/ZIO4uZUZzl6WDPkZx12Ww2OqnRxn?=
 =?us-ascii?Q?xkYr9v64VS0WgFqceapTloDYGNjWzY1iK3AxmbPHy8mmKiAfbTS/D+iU5TDC?=
 =?us-ascii?Q?jPljigo42BSbTAj7muNFI9x02ZjErig/+WB8ZPO94BuIs6Ktt6LezHuo6BEt?=
 =?us-ascii?Q?Jq1ghrwjsOBoS8dzeBe8cWTVgfxaPmVu+7ofkQhEZpEXgvWOCOe4z8TqhW3i?=
 =?us-ascii?Q?Cs3okuW2F9eAczPtg7SnMjsIy2HEH2uNPY2txX+/CFDAY3teMor2Gcdemzxr?=
 =?us-ascii?Q?lQUUnRWIb6SU9qmYlhEUcFxRabdvbeoBxW16uQD2Wp8gS3G3sLXcL6692HGG?=
 =?us-ascii?Q?aOLu3JwVU38aNypHjc2ny4wboOzs7UPluiMQN7EBclELfXnhKzvt18hUs7Px?=
 =?us-ascii?Q?fh5a/7GOMJHoCucuP/Qm0RwRdgeGQJEiiKv/GAHCfu7TT2lDhw5uFCob9xuy?=
 =?us-ascii?Q?ZerUnA32z+YpA/G+H+PiMhrtBXkQOeqQhTEiqQRwaXI74kS3vUh4Luf4haBY?=
 =?us-ascii?Q?kTLferHTAKTq+eJaOZeNy8D1OfJBqiHTs3Gpi4RbemfnTaJJkvTxvpsE+le3?=
 =?us-ascii?Q?+n2K1xxKSS5/Fp4uP0WKOVBplw/v7sNpdVj/Kknmb0khypsBb3heu/z2kS+Q?=
 =?us-ascii?Q?UCRMommAdp0BCKI+8nX9qK5QTOzTuzJ3x7ax6unRAlEodfWmOvMNPUd67846?=
 =?us-ascii?Q?jkPidL1bU6j6fWKPiMbBeOGi8JhQFsgJvn/028auCoP0+ki9GOpAvR7aGKTv?=
 =?us-ascii?Q?njP3ObUXbLMolRlaxby4XBOiYFrajvI5f0uMH+IkKB0EWqlS8gwYM6VXlYBs?=
 =?us-ascii?Q?bSwrb8HkV84nWmZpx/+7fs/CMKxELvPqBHRDLxjGM1d1WYDxgsQvGlHJ0zX1?=
 =?us-ascii?Q?bZYB49qkhGkFO5846USYuwSavtUE3O00gYbcWXcOZj5jVFWR6mw7+t8MrLxA?=
 =?us-ascii?Q?wrsA/G4ozKUXGeILvh9WPQfSsMuRxx7LjbW8+6wygu3Ay7FXF1hUrXsw0CwO?=
 =?us-ascii?Q?7xNfaCx5EWBMXckxsGZ164Mq33AN10zbu28Kl2wjRrS0ZygumjEbsH0VFTga?=
 =?us-ascii?Q?fBrWXneuG4eWScAqc3+qEvu3yhLjDdqjeWY3XChONy/mcsNvvl7xnTWVyq+a?=
 =?us-ascii?Q?NH/r20lnB7X7L+QXypgJnw4oPUZOgn/EaPKNNnqRiPW0FefZd/1qMvC0KFiA?=
 =?us-ascii?Q?h1SyZVLqjWGMaeZ/vmDon3oxvPmF+jeKP8twJVTxN0cPPcqZgGS6oR1k46qK?=
 =?us-ascii?Q?HaXOpMTv/5hniG7uyM8kUQ7tzan5SCZLDbe4lrlErnNYJAktwN8YNalQ499L?=
 =?us-ascii?Q?SPnyhgaesMpym0NDH8/a8ehYFj18reIeY20mSeqB5h7BgVD16QJVLpgDjPLq?=
 =?us-ascii?Q?6Tt+VeY9hJglGsSluxRgeMrQiHX8HWXyF/hVGodInhub1Bty7GPIsWUpJ06U?=
 =?us-ascii?Q?zz86VdYnkFs36B52B3ZIkYvqQerboJYttxXddDm8e2B46KerTU0EhVBv+sEW?=
 =?us-ascii?Q?OgYxMs4sShJo7LENASMFf7juY9/Zgy3b1C1wGZaMF7WHERm1iL9l8SX+bBZO?=
 =?us-ascii?Q?2vUXUiNDY1Vs60Q6cGnbj+O/yiDYf/RvmW96AJbu94BytfFq9U+kuyoHfDWk?=
 =?us-ascii?Q?kvv74Kal4uzprwx1DkLrqlXBOYYaUmm8KadLa7Ty6wHxecmwHd9Bu1B/6mlK?=
 =?us-ascii?Q?hnlyIwANfn8PJjqBb7wH8AJUejgv6oL+xGqf3n0KO7yu8lHY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7625c8b-5f5a-4084-3e1a-08deb5ce7d26
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 17:46:00.7977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMQ0HseW3leoBPErJKQMOwzVGlGFkx7QQeyFElplzOWuV7abXvNB/f+L3okyGhlf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03

On Sun, May 10, 2026 at 02:23:03PM -0700, Nicolin Chen wrote:
> In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
> which could trigger event spamming. Also, we cannot serve page requests.
> 
> Skip the EVTQ/PRIQ setup entirely rather than enabling then disabling them.
> 
> Also add some inline comments explaining that.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 43 +++++++++++++--------
>  1 file changed, 27 insertions(+), 16 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
