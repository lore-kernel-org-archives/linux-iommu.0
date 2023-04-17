Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD9163DD
	for <iommu@lists.linux.dev>; Mon, 17 Apr 2023 12:23:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmTkykKeN3LTqT6lVCTtuqAuZktqJJRRdrRLTYBFQsxn+aqYedLSOVQeACCNrMoo5kgeul5mD6I4o7QrIkOu0e3ybgYPtBNmgZj3onEYM1ReNWFCqpB044sZIYC9t2+k2yzZQd4eb9EE2RygIH9+o9pbn+jgFVoD4WVI/gOB+F8OY7jq9+piyYCiKk1VPWyhvd4Y4L8nevytiCA5VL9IVAj5Kvyvg1kiJP58CuLpWa2SUQM7bkuUm8aHOOVjTlo1KzeRmc5lWLYb8zcERYgun3xi6h347fg9ngqO2lAdAOqwDHvRDPQ4Z8AxKG6+CRusMczobe2DwJjgJ6m6s80Rew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YxYnIav+PBUmHSliRkPqveFa8PsSN/NJYAa+jUkYTI=;
 b=bv7W5Ss3g5DPGZU7H566Tmc3lqBf7Vjn2D341uckljAir36QlML9goZR05VMXRaqCh+tV7K4TV5JCAVcfBJaq5H7OX7FVMqICX6ld0NqYwnvIRyPhSrL3qNgRKqZtoz13nnQbo2okX9rXvwtz5c4QNtBmidqkzCEMwSTsUi0UhNi4cYeVq508RjBEdXBjPh3yMe3gmdQgLDbGy23dpbtPBYVC9qryAAKm6IwoBKjgYvuXhe+Yi00wT8Tp4Rf4kFdsh0n6YGh2vjvRoCe2vOONthTYR8exBg6Gr31phGRc1ke1JPk4+Xk6yBk9BZfnJq1proAojRpVocFMKG+0qZ5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YxYnIav+PBUmHSliRkPqveFa8PsSN/NJYAa+jUkYTI=;
 b=BLilqakUvCZ08yau6WZC8Pb5S610KXWUJAhwkEjsCzKISV51DwTuAGbvDf1TMCNGZF06SAtB5OV/jknpfE53ih/8N3Dr6wDGGcQDU51WB8f9vjQoJRWbhnAS4haURPyYcmGPdZjBBhtVY2aRJBR9iKDL1d3CnjkcEOq3fv9KKzxiq2CfQ6Xh+QEdNeFjwlZZqUiyw8+KXMyu/z0aTXZoL9YbCagGJ0yX0IfT3pTtQsoCxXht71VYO8Xr7fiummwJg4i+5iukL2z38oVBQ3BjOSkEmFGiesAYmsABvowBMVWGaJmDpMZgBdKR2kZbfgTrMtVEn2kb9u1/NdRaAsKD5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 17 Apr
 2023 12:23:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6298.030; Mon, 17 Apr 2023
 12:23:31 +0000
Date: Mon, 17 Apr 2023 09:23:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH] iommufd/selftest: Catch overflow of uptr and length
Message-ID: <ZD06QshDIsLYLh3W@nvidia.com>
References: <0-v1-95390ed1df8d+8f-iommufd_mock_overflow_jgg@nvidia.com>
 <ZAuJB92z/6XIriZ1@nvidia.com>
 <ZD0EoRVqdfYkOtt6@xpf.sh.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD0EoRVqdfYkOtt6@xpf.sh.intel.com>
X-ClientProxiedBy: YT3PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: c793f9f5-b7d0-4218-c843-08db3f3e8e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RhrcBGgTjp6JNRHO2/1jhMe/vfb8Zy+I35Gd6vrmiiW7wH/qST6lm60fUnS8AWyynbjHsTUjpx73WPMmibQqHoDV28nAmeLD9Uiolo/TL0T0Mz4XXe7pop9jdmjt4f7Mn5o7H9zuGTwaCX1OfJmQuL1UxvRGYz6eDvpGVR2ZgnIUcYXfdNLV5hLKMOYyoRpQgRZmCC8X4V7CBWPcyZy7RZPWKE2fyge0PwyWEvXi9faRgpsbD0aoCY2Qr2u1p5zle8oCAuevY4BSEy7JE7sI0sgbUFAX6GxqP9m0oLSGpA/nw8DilW8pYMM0CHFbQXLFlw0v6GIrbpEWqBFd22XeHX8WlMA/KM7TjZbDF10pQiaqvTs11htGgWP8vabzWjXH4+qgCwCREY6wIUwTEDB/SHbBXZKLI8xffq6FGpoCHSJHYdlDMN1UPtCA/j1FI/KfaEt6R54WV6Yp8pXypSsNvLZLwDE6Dizdv+gfBgZJYYruJn0R6AYNYbaotRUo0wZFLrSPiK9XzQNGZAyV0d6GQaKOFq6RuGkg2Bnkt1yv/rnk+x0tUCUccd7tG4eWEWu0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(36756003)(38100700002)(6916009)(5660300002)(4744005)(2906002)(8936002)(86362001)(66476007)(66556008)(66946007)(4326008)(41300700001)(8676002)(6486002)(186003)(316002)(6512007)(26005)(6506007)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TfUlMirenPkblU3VmQx9DVRHuqd9ANBVd56UTz5sZ/3LFTkUq5El5+PKpvEx?=
 =?us-ascii?Q?4OmXO0HkNKJkZrYRuMynvuTnXk5bOlQVsM83ripEV2kBp6ozCOuwcoXpjDgt?=
 =?us-ascii?Q?OoEpj0oO8jZ91+ridX9mtc2b5VFhQrwCWniAMPRI+FAAC/JcNfHow8radC+h?=
 =?us-ascii?Q?qqqxl6OyL7lG/iNloF/PDLrTKG9DjdLyzjQNzzrAGWebhpMjwlKAikeW0Ouu?=
 =?us-ascii?Q?vk/k0LdlUHMQSa5oA7yC1TJlYnY8DBzf1hjRshFPjkQl0NYG2vCtvLaj1fnu?=
 =?us-ascii?Q?0Fzwa2P9vOppUw9bzRE/wF1rHSISs7ur2VF09WuiQYtdfoEQrtrNLW4pTfGH?=
 =?us-ascii?Q?2zxV2Q6xdJ61bCe97u0rdESOfwADtTdbmAcYnxAN+vo9OVebOdmX+otS17t7?=
 =?us-ascii?Q?Vktib3giPUjVECXikNzPDAIeuDw3/vnnBX78YAdGUpfR55rvBmSblHMwBpxY?=
 =?us-ascii?Q?6iRut/mvAPZ3745bd/xUW2rHXhUeuUKpKUqPEHOaOxzOHfo0SjpmRXQGXjK4?=
 =?us-ascii?Q?X8/Rszq5JVCiMOvPtKHQDQzhk/pmmQT02PfJ5Hjx2CJC+yaaBzlyshWGJTGC?=
 =?us-ascii?Q?E/R7ua7M20nk3lBva0IHWtetKT4PwCbhnTnDE8xe3NPChXFyJ3PKt/82/yRw?=
 =?us-ascii?Q?V8MZPfY4+neM0yDI3TzJ3Be1HJQLPcPPVM68qVvKZKdsM68YuchmgIORJFuP?=
 =?us-ascii?Q?8uwLI8HvF1WAHw8CKydC2nMXfCcDHvOsuClsHatwpjS0tRgItAMrbW2CKC4G?=
 =?us-ascii?Q?g2U1UVobZyfN3nDdSCHPGHc5oHXyTZr9ZVEwe/wE23wQ4tak/TzOmEyXeMWL?=
 =?us-ascii?Q?MYcqCkT8jvYW/O201b5uPi2EVccPriqS9iD21bs/ZOgf4W3ait1vo8HeRzLl?=
 =?us-ascii?Q?hIGpKMFPABOImp+YGNbWZEU948py9H38zHYDB93v5cb0xZPsqX88PJPLvr4L?=
 =?us-ascii?Q?YonTb9hiAaFQ1edU88VU2K5a/1SdIofSd6Jh0gXMtCNs1zcKGlP7TJ1UJqMn?=
 =?us-ascii?Q?YkXL0L/AWE3MOQ5uImSie+M8i58Q+ToDmyoiY2DXIwpoQj/lhkuuyD9eCIbu?=
 =?us-ascii?Q?2teyNaelAAAm45n1m6IDt+25Z3Wa5eGoooM/Y6gaemXNY06VwR3tFdfuLdF/?=
 =?us-ascii?Q?ZvvJn3hvBK8HGs3WtNyctf1auY4+KFhdNZ4TwStbHDoE87LOqn8NAN3rSjed?=
 =?us-ascii?Q?ywGccpV+4su6oLQNPBWQl6RVpCLgcDQsQK0Sd/RUvwCPav3hvbBtkiTeLRVv?=
 =?us-ascii?Q?DqR22mHjqiCyeOyq2X8Klc0n2bIMG+WKb3nOtZHOqNdgHmK2t9wbHQRZdBk0?=
 =?us-ascii?Q?rKLvtgpeerg6RRi7Dnn/kOC0LFzqcKmEvFQpypvFr4ChdBd+tm388I4twMZC?=
 =?us-ascii?Q?TJ5EK8/HHCANLBJbCVFmnIRpfC+8D4mRouAeB8N2dI2NgG/p8euBux/GBr/K?=
 =?us-ascii?Q?kv11mgxkVoBfc7n1DLLOam2xYY7WkDGH/1RVBpuOJ1bRn2XhF5gynNHHNQjG?=
 =?us-ascii?Q?PkZx69ABDxLqRW2ZC7+BUTsx0Py4MTYZi0oU68+tVY21NJNkSRuxzLNt3Q2r?=
 =?us-ascii?Q?HWnu7Nx3xKenI1ASUyM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c793f9f5-b7d0-4218-c843-08db3f3e8e91
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 12:23:31.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mnW2EIjkjSxbQhgaovhBsYUxR3u5ogkz99A2LRRu+IrCyr7Um5Ltvt7F5hy0P9nj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

On Mon, Apr 17, 2023 at 04:34:41PM +0800, Pengfei Xu wrote:
> Hi Jason,
> 
> It's a soft remind.
> Seems like this patch was not merged into Linux kernel main line yet for some
> reason?
> And this issue still could be reproduced in v6.3-rc7 kernel.

Yes, since it is a selftest only issue it will go into 6.4

Jason
