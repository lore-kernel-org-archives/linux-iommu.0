Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918B242D99
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511896; cv=fail; b=Pqajy0jIgSppIIVIwmSAjLCKNBw14AufatymGtPwAUMobLvbazOUQh8e1pukpeKCYGIsAtQScjL70iT3BNaQg9eh7tFzCqOhdeZEOuutfNOpX1HKK+i8W65+Hv5zAbYHc+bQzmUyhpQioUvDGqgjN6zwPlpuj0ddnA/1+Lc05ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511896; c=relaxed/simple;
	bh=c54rsXeniap2dz8JFKbkKWSi6Gmf9PopHFFGzKF9Ujo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JosGxuTKtgpQIJd1kIyQg9vgyByAGyrtyCfBT89uQtC9E5BZe4K9Git2p/3QEOVi09LHjf3kt/ZTyLJl5s8aaQLoD7aFiLzEn6UtzOe1W2zwLUIj98zNahKoH/9VM+07vb/gzpzpNuJ8H2J+H17xDTx/xbpJKMJGnxs5QFsSLak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cSWtiRJx; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cSWtiRJx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCRXfkQDLJgQA7bFoScNUgnG3BEp99BSVJx+YaiGlEnUb8fgx/7ir/jZrLT2ovXOX9ba1oFpjzlTU+6K9xXxzA070kUUskPgaYDwmfuWmKJuO4gEb1jl/2aU4DaQoD6JZ48tu32emfTTwMUxk5eMY5kfb4cleRUQAqv2AohY4OJ0PbmT/gqVhYNh0i9RzvkrzP7JzovEdPwnvPrxLlZ0BibMFM2OZmAUbjIcLNIpzu20rpz1WSzy0MUlzWalp6Uiuaif9cfY0lFOWjV0c8zjCVRqgOMerkd9lwZo43gphN5h8eMTaDc6uFvDQHvxooIUCwdgH2RGnyd6Vz0b8wwutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdJsWctb0tkA3nRofXotzB6skSQzEncevlhns45dolQ=;
 b=jU4vYASaQ5MyOaq3yqPtMVvcOsc8J+e1Lz+cWjfJ5mj0neJOtzjCnhaqCh+DH0tj3/icoqWGFnrUyHehpAgM3yzJxrORF3I9/bKxFUO/1nelyrNR6DObybrotWWeHBVm2Xl12C+Zw2F644Yefrlvfoep8zbvEAplz7f9G5zIWNo0DxbK4RTXQaUU5xSPbTrL9e1QbquVsuYmqqbVYsVPiBE2UA7wyUBy8Pp/yk8ikrmWlyDda6ZZoxUbR8HWWrihJZbsDtTmuWhSJ5D3RSffmpj+R+pRXp8vuA06fcv0h6MzBPQHaMcg9h9s35WN5HTCzkK61ryWYHwmDF+em9s6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdJsWctb0tkA3nRofXotzB6skSQzEncevlhns45dolQ=;
 b=cSWtiRJxCgPE4DxUXVtAP/3dGz0OAF9Kk4rs1/pV1QXrXSQSkQ3F3oZevMaS/a4dFEit7k6Pk63futyGt745SbLl+gqPecVE26fTpsbgknOnr6pRLejRpaJdCgkScS48b7EbrephWnwAAYI/2WYZmCtupAFrRbXLzJeFO1EkWwOP2N1acx2kppwc0R7flCJpHQXOtwiCESAJdd5Q4ZprKFLenFTiLsLTEkueaL4THdZDviXUubIpQgtj9JY3eQmT5/8SSha5E2C5cINpIYOu1ojXO62tbcj/exBpMyKgerJ1KgUxWCdrQCwg9vEDuA8zW7067j1stlc3gfAUSdUtBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 14 Jul
 2025 16:51:29 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 16:51:28 +0000
Date: Mon, 14 Jul 2025 13:51:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, yilun.xu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd: Do not allow _iommufd_object_alloc_ucmd if
 abort op is set
Message-ID: <20250714165126.GH2067380@nvidia.com>
References: <20250710202354.1658511-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710202354.1658511-1-nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef53e30-1aca-4b64-b19a-08ddc2f6ad23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ziMjJa01KhMl7GuM5QqNT3TLHYKZplfTNMdHYfTPVN3i9m9Xg7miyowyyEiN?=
 =?us-ascii?Q?li5+DcckA+HNe0OoBfPXw5GpJcGNkJCJAhLdiMnMVzpB5DL/SfFArsrSyh8y?=
 =?us-ascii?Q?DyDRFRokIGWxxyT4KZvYfFHcZpJfnQLI80lVz1K8CiCvPFo8pJlDpf9klz1R?=
 =?us-ascii?Q?rK3lH00//6LfIcZAJ23ujNTwdSuw3jKuw4bVWBci/FuGKGKjBJuA7sAa0yq0?=
 =?us-ascii?Q?oGPOgWkukRQ08+Z2Qqj19n5zH2uO4TSyY3SKx6xsXXQ0R8S3/kGqgAeWNMrz?=
 =?us-ascii?Q?t+WUQDk8fphtjicqbdqsZxe8thMAhxRZff0pMIEMpEYiwcIVvVZuhvUGcjKg?=
 =?us-ascii?Q?9jREaTlcLsFl/U+BvyyOm1DGLcbAr7KJo0GRHsT8FMQFyTwSsByPJU8KDCbJ?=
 =?us-ascii?Q?sRHwHP7v0LOV0gjOsVdhFbaI2O2hMAr4qh2zvVauCkCzkH7torupelcLTuJ/?=
 =?us-ascii?Q?2gpQJmji7MUbfJycB7FzGdjoep75qQIa+bS7+KAVIOKxY2xsp8rCrmEIX5fV?=
 =?us-ascii?Q?B+Df1m+vxnz2HUd03aq2ImOtR+xxJpPYVWjbIfk/wvADs38/Zsx2CZaC/IbV?=
 =?us-ascii?Q?X4dwBMj1S9lima/J8a8TpOmeYJ6GoJIrHCV7NNgkK2akzm5LUnZOgkSPNmDr?=
 =?us-ascii?Q?48z/lCqFVUeL39xmbIdD5S1AaT83WD6spHKTi8idcIiZCF1NG15gkCK/qDdc?=
 =?us-ascii?Q?YqR2Mn6Xx7JTOR3MQQlu8FJ469R5KfQHVRKSzgeKxeCZy4gL2ZcNo3PXYOD/?=
 =?us-ascii?Q?sbEF1YOLwM9JS8yZgmEK0LWRzZLKpSZ23vRxh4a3GxssTj3Mte3trz6BjuTS?=
 =?us-ascii?Q?r2lFuyNRb9Ef0sGoJsMqK58vdZ9GgFjFIvzQjVgcMxrJVTAzeeCIIXozsS23?=
 =?us-ascii?Q?+VWaWMKsXA1BAPXeI6lMqvCqfVi66NI0DfGmU2mh+9oIXG+OSGUMaBCz/Szy?=
 =?us-ascii?Q?0DxesA/O4F2r3VT8Fp/Q6wo3WP+cr2ZDFT5c/ygYzeMBSqpMEKna++WasL/2?=
 =?us-ascii?Q?7bc/goIR0RhQ4wB8mmHrfEkzA4tYBM7xLVEf9IoBGe8C1azPBiE0PnyhIff5?=
 =?us-ascii?Q?bjnnICIswqeGBQBwxPvpPlVNt3w+ZPW4DTN77hjpyRHn4reccibzPzg1KJnj?=
 =?us-ascii?Q?eE6fNJGLDC0sCNNtqrEMisTDLXuribNeFXtqnd9h+JL/HifqkfUWQmlBAThF?=
 =?us-ascii?Q?e3ZYadjA/A0+7kI1Vb05fnhtd8B4p1HlPdiDba0jfhhAuL4xELh6dtTTUsAD?=
 =?us-ascii?Q?FRtjsbq7NbelkxvfU4lY/+c0T17vG+zXxiozNs9apONDAezKReX8HsJRWJ/X?=
 =?us-ascii?Q?I4iv0svdApTYIxrTYIyfYml+VLtHtQ+cOt9TlTt78BbG3FSJY6j/ecqJpbZy?=
 =?us-ascii?Q?J8PABoTimHnhB7ydlFbx9JWWqa6T4ad+ixZes3gPOfykzDbuGo4tCu5KmnJC?=
 =?us-ascii?Q?Xb4DMZ7kaYw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LNh5O6fzO/vb3Jw+SGoAOkS1cTVK5PU4XNiDIjc4LzIZuUlPsT4/EEVr7Pt5?=
 =?us-ascii?Q?EIukPxvNsJozZblYpY7dwzA4ytB1a+aMNBUdPgFrOud2EaEKTC/CMeasa+s6?=
 =?us-ascii?Q?px0mpYfa5OPCE5R+ME6m322OeMqYhmPPuPdJGRWnfT94o5+QRv6BRdMNQg74?=
 =?us-ascii?Q?3zJGXig1a3tXPIIN82IfiJagyCuk5bAwNITMlvm61WGISr1folQOiJj6kkYx?=
 =?us-ascii?Q?gzNRzwhuiqP0aqeYyXVOpmj2n5K7Jwt3dkEe3YHh8YEqx1SOTLabsg89ABBS?=
 =?us-ascii?Q?3abaL2d4qWGD10Chjvs42jtzaEcnmqqlWI41PcvZ03n81bopXflN6R5ihHVc?=
 =?us-ascii?Q?NJ6gfTf6J99nnx+2GIj0CM4YhfSRSs+QtYTPkjPF6n52QElv3PBDIpdyeAH4?=
 =?us-ascii?Q?3NolOShOzrghnoHhAryhitlgf2C4t68EBEx1ySZc6kbvW5j9raIU44bWLa9q?=
 =?us-ascii?Q?X/I7kzo+OaumlcLyBPNYBnUP5XMpxXYZwXLVlnrMigSPYRPmX2bX5UuQ6xzF?=
 =?us-ascii?Q?jm3Qhprcl6bnq6/agP0O1IbFF4qPJ7kEXcHikFP7Oollutz1lu91jCG4Z5E/?=
 =?us-ascii?Q?GwOWSDA+UHnpVieBKs5K5bx73koaPEwZhfhhJO8gMtX+b/xWz0EnGi0yMbfT?=
 =?us-ascii?Q?SRfJX8SWq1lc3Svs/J+xTq5PoccyvLLzQ4/x923odtplvIhNkIiS7B6vpKEc?=
 =?us-ascii?Q?eJiu8pTNyJTsDbLYy57RJ7hAFyNKMyTD3yMvxaOrPK1bwmp9oryV/KPxDx5x?=
 =?us-ascii?Q?/O+lPgC1wpn83TqoJIQIoyLwiua/ygfTMl67ul4Dq5xjAjpe4zgHENOaVBcS?=
 =?us-ascii?Q?vebHBclpQRW/nxAwDc3yYi5ti/+gVZO1lEcPaC8VsOtsfFuixzOpH6GygIQh?=
 =?us-ascii?Q?udKVmQDXGVcgRI3yMRqMsHg8TABDFwH9P8pFsak6a53v3cTgh8r5kVA2AQWT?=
 =?us-ascii?Q?pw4k+KLW2b7qmqDuEoy9qSryrKc5AOt0mQ16823pmKpVJKsAXLVu2QnCQ0uo?=
 =?us-ascii?Q?4QVTISrs20AzCzhODgZK3fecLWZUWXHKGM27nv7qtZ5IInNlln5LooiIdaRN?=
 =?us-ascii?Q?yL84x3ZkZa9mdUmdhOxc2Jl+kcbBidqm7FcDemR93sle8J1W3kldsLAumXHG?=
 =?us-ascii?Q?ZdKOIfpS6eN42qOuMVvA0BsLvAZM6Q+Ut2ugXXz2C/F2s5VIGWorasFJoVkr?=
 =?us-ascii?Q?rq/1gZHCJkh3aDk2QgjFNttb9dAK9c+dvatfzxSmrKNjf1tkQtKVirQmQ4Hj?=
 =?us-ascii?Q?LcEJuNUqKWExIZnxL+0h5UF+efnfahyTf2FPqz/10nWXf7+CTY0gG7Ysiwvg?=
 =?us-ascii?Q?UHxbECre2BEu2PVy5lpIF7vu4ZrLuaV3CPzzCBve2/AwziVlqOM81TusGiFH?=
 =?us-ascii?Q?TBAB9ozrM5FX9ZHvUIW1qqS0R7D4XxXX2dunqKsm7iT7iRJYDu20CHa3VplF?=
 =?us-ascii?Q?vkKw/UjknjgnzHKGS36EObyIELZeEJ4acqFK5IeF9JYuPeSBSF/Hr8sB6XiA?=
 =?us-ascii?Q?8Yq5OtogHmTaq16gjHdp8POWIL2yVgEWeZoAaMwFBgWfvldMlS/KLOrDctBk?=
 =?us-ascii?Q?z3x6dm1kplkPOWIzGjG1+zcqwWHO0MD+prryGD8K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef53e30-1aca-4b64-b19a-08ddc2f6ad23
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 16:51:28.1373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEOSmhGvPw8m9HzLx7oukmF0Zf4SU5uDk5oRHUJ/mj1+qIduWD74jTfXh42iXor3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207

On Thu, Jul 10, 2025 at 01:23:54PM -0700, Nicolin Chen wrote:
> An abort op was introduced to allow its caller to invoke it within a lock
> in the caller's function. On the other hand, _iommufd_object_alloc_ucmd()
> would invoke the abort op in iommufd_object_abort_and_destroy() that must
> be outside the caller's lock. So, these two cannot work together.
> 
> Add a validation in the _iommufd_object_alloc_ucmd(). Pick -EOPNOTSUPP to
> reject the function call, indicating that the object allocator is buggy.
> 
> Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied

Thanks,
Jason
