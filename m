Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA331D75D
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030788; cv=fail; b=ojj+k9rmRKGenqmUHzRzcQOKUUdGe6Q27SD/kyG3tqvgsF3EIIq01/DCrOkZMuZS0i603SRlZdN+Z20hVCj6PrtaIyTtN/prlV6VN2t+ipIK+GiJPWfHBUlHJ37oUE0NBH2nu/Z2qWb8h79iFy0Q1TJsrvlbCvQ+C8cfODYGMDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030788; c=relaxed/simple;
	bh=b5yQZFnY4gDGL9tOM0hGoraU6h7dY94SIuB3TTHXRDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QV5xPVnHEM5EwixVUmlq6d4D+aHpBlU1k0PR5sDRGydephwa6HU5FgNhI/Z8gxDglnIzuIa4B3mkBxwvvn/TiaT8SXc0ZuhYomf+Wk3BOS0f69tRD9n1W/ojXGIOAOk5F6oACBBT6xh5GzwJWIUX748Z/+7IlOQclj86XEcbF/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l755Vy0Z; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l755Vy0Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFf1bR2+FgjeI8VZC/j0yqLhhtl0igoH7hH2LxWPC56zFbMJkawJo6K+0yLVqukcg+BDtsWBW2wbuneCZ9wWSDOzYMDWkQwI6eZVzt6YX38h1n9eTHBidlg8K9c4FHxMCYAfVIvycyxcyO0X0iocwf2/fJhjTzCQozt6gNZRLKfRwKMGTs4hBodxEbqZcx/Blw/l4tVTOlf3FzMcG33AOmnWNApmAVAha6eYlIh0yiPA9F8/0xhbEAoDELtOe1jL28q0h5XJ76JKkqq4Anlwnv5w2r+2hLT/jNVWiI9zulEzbCSWObOifAtaYbvqCD6AtHlaBZD5zHpho+tPwDs9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpWQqRi2zlZJY2q8jPCrZZWoLvxn54qCap3kKcdIf7U=;
 b=TmjS6jFLKmRRvu30uwiKx4YU/9lepuQ9O7u82jF+TrhqRDdxKOvU5bVNHeEP1VEt475Q6GMFcLkW434nDDhy/VaALKibKrhIIi1IMsv3mYhPyPKKE+Iz2u+L18WAWmjGe2o1EV5ZN6RfvFAhnDM3bNBYjEKA3sEhf2L0+9XqObHN2/sk+lpQkKIEb/jup69wohtYYU58QfT9L1vJ6iU4pnu87ia4/C4FAK7bZef2vPP0UYcb7KOMRNJeKpWekr+RfjJO4Be58/ewCEwvsvgVcnCtM1H3O9Teg1hHioRJh+hYnjvYFA9iauyhIbCOmuBQ3ftKRXDGNKUI2Ofmpwy61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpWQqRi2zlZJY2q8jPCrZZWoLvxn54qCap3kKcdIf7U=;
 b=l755Vy0ZzQpnYkINitKVJJ5eghwa9JQhuWnY1MpXqCW5gWL7kHQ3oRvM1JpgMuoqjgR6r4rlTEJr2apcmdwRymPUgTo4pwl30oXQEkEq8OHpO4RXh4BduspAWzWbSLWfffDToPFH1O/baFe9crdpr74NSF1MsmjNQHNegIBt+CanaQLAIUUO7W21VXDHR9rCraQ3+7TWSlKbIxSz9PpAlBgc1dNEuwBWsmHndL+vI/JLyNd2AT8uzwUPAf6Ym8vZ3OL97D/D0SxRQi5euM+XR9fve3xiB5X8RIyAVFWN+u15XMbMWnvcJmC334L3S0C8wZkAAuppVGqeKpOnEbGT1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 13:53:03 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 13:53:03 +0000
Date: Tue, 16 Sep 2025 10:53:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 2/4] dma-mapping: convert dummy ops to physical
 address mapping
Message-ID: <20250916135302.GE1086830@nvidia.com>
References: <cover.1758006942.git.leon@kernel.org>
 <3b54fbe896086adc0f3fb90a2a1a2e3bb3ff9de4.1758006942.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b54fbe896086adc0f3fb90a2a1a2e3bb3ff9de4.1758006942.git.leon@kernel.org>
X-ClientProxiedBy: BN9PR03CA0689.namprd03.prod.outlook.com
 (2603:10b6:408:10e::34) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 990c2b0c-4b5a-4638-49b4-08ddf5285b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vqSUULIVC/Nfxsi/2D20sD6TemlAKpCt3EEuupIh9klcfmX4KgmrO3cEAWx7?=
 =?us-ascii?Q?wodi1eB/RISP5TFaH0MaEcMUstz38LuGvLYwfHPpiZRGOn5Imrwh3kke4R/B?=
 =?us-ascii?Q?aBJbO/D6qDirNG3FBJ/+aQpkNMGLZD0k7LRsPAk1kGBmINY86q6HzsnvAg7x?=
 =?us-ascii?Q?oZtiqPUSkFSNR1HVsIrl6dAJ3+Xg2N5dAQV61eTjv7EZLtk6R3rnVy08V8/X?=
 =?us-ascii?Q?NCxANrXUeKVJJPlqWDhMdSjrc98xnY+EsUy/Kxw6skyUgiX2DenKfIoYw5/K?=
 =?us-ascii?Q?SOQNl28ZF2xp5m2k5bAtuqjbhI/GTTkBJhjUY1vmY8pcOnZaLZRjdhBWPhsj?=
 =?us-ascii?Q?Y32yRmZTOMM2b6iGODW5jkXHrjoaEwPVfruubsSyyvEed1/Nu6S3wrFHG0Ms?=
 =?us-ascii?Q?cI5Dl3SqfHjNowH+c68Yen2sG9k4gD6zwC/eL0jug6s3xlErVWBMYuyKo9DS?=
 =?us-ascii?Q?ma2f89Dl1Bo391SwszGljOK2tPpCRwujS/ogi84t13co1pbvkMrk8yLlXGnb?=
 =?us-ascii?Q?Y+AP1ZXefLopmM8J/1TME8SVcquJ3T40GgFuTw9ZqB4JYxIUWLz9zW8sHs8D?=
 =?us-ascii?Q?Ds/LE/4RIrDpAo7kHKXGx2SkaEx/HHMl3q+fZJTUGJln17ZDxNSB74k64x2N?=
 =?us-ascii?Q?KYAnTwv1aa5YDba8squOagY8Dck286CRuwchkik7UoiIPamF8M7KWzPdBXim?=
 =?us-ascii?Q?1+lk1Pj/cJNsi+z9j/tqPEVhCYS1LLXhAUqD/N5c0eIE9aypS1lsKdgDKrxI?=
 =?us-ascii?Q?v44YkqLD2qK3GcWm9NdtGuLi1DcnEG6QVA+iNh+USKYK7++ijWEZ8wS+gkoJ?=
 =?us-ascii?Q?vp/Tf/TbiKzqsW/p0KjvhXBj44QsI6/elW66WX13RmX2TsUDn+l807AMg4D0?=
 =?us-ascii?Q?8qHiAB4lK2outVwfdm/LAl10tirhkwBL3X+zsWCvcwImbWOQTTjiX3y2gt+j?=
 =?us-ascii?Q?yBhP55JDI9gBwE5BS5rtCfJVDdclWrum9awmCk6r6Hlg3vUsrSVBEYWO+afq?=
 =?us-ascii?Q?ffIuvcI5rCqtHS8wOq5Dgu7/5RK3B3/hbdJ1/bp1hJVCOvLNHXPb54P+BH1e?=
 =?us-ascii?Q?POmJecqUS+/zvgkdAqvUENdNZ7FFnKqS6V1zXMVeLRHKMWxS4H0shGPb4zm9?=
 =?us-ascii?Q?1586bgBVaig2gaCYz9uakPGCd8c9pMpJdISduzjSLY0Kn1cqnYVMVjVoE2zp?=
 =?us-ascii?Q?625zgtVMEEQ4rmUrZK1zNPrYJLkS98PhrdO4l0AAvRhszaM0EcpQaqETX/SO?=
 =?us-ascii?Q?UbuPa8x6kpnVcvJaabBnQRr+D4M4uNySt+vD43qYcIY+i0XKGV/bjmvjdeNg?=
 =?us-ascii?Q?kLGrayvLFBCUVcMoC1Amg6JTCeV7lA5oS38vLOYi/pHf7QMOSHtDhZqriswC?=
 =?us-ascii?Q?MS/tHgZwnUdTCgl2Er/x20zcK1hk6l0Fj96Xu3GL5lx7zCc6a3Bt37c7f5tj?=
 =?us-ascii?Q?WJ1AxF9HXKc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YqGBDYTv1/6KtgqCO2u1Kp04zIn8IFOyGbpc19Kua0cMFj8kq3DPHkIputlL?=
 =?us-ascii?Q?MIoylLsGvSbQ1oEZPSwNJIFlYUKI+b4cNLDCAB/IPf6q1+vEB/Z7tR6JGGf5?=
 =?us-ascii?Q?2i7Y9P89yYozsDhlzdBX1zEKi8Uv92tQpJmiFiPyI7//mSEiWOPWls0+hjAw?=
 =?us-ascii?Q?ea78FiNpoNqrIWzYYhslhcH+SDcBe34A2wVBuqSJ6NXa8oU0+3Rdvnqh72yS?=
 =?us-ascii?Q?k0cOO6j0fezTChXWJl/f2dVHSDZEK5x4cE39MuFw3hjz8sS09G27xh2JVxuK?=
 =?us-ascii?Q?61fc+FY1+oZMTbdUXtfllHW9dtZcfE2Vrnr9n5BDWaJQk+x8/+yNvRF2bVtL?=
 =?us-ascii?Q?nrEvkG1z9Ktqb6PKXAn9paLbYLmtM00MTsjsRT4AsjmzDY7tQlSmkCpMgyR3?=
 =?us-ascii?Q?EKdPDxVS/X6WUdGPGGDtpRDfP5O7tFLtKmSsDZXYXcf30k4ckiZzyfrQ7zB4?=
 =?us-ascii?Q?//q8LhIDaMfUimO0aOPZh4Y9sZkmm7oK3HMsniHsDEUHS5CcDq6Ug/OF6wnw?=
 =?us-ascii?Q?U6/RzuFNT3UVu4qT1G+CS0hzxa8Vf58Ah1R74faihT9L/vNu/nR+wAw6cP+Q?=
 =?us-ascii?Q?8QPV4kKM3kW2umSxsRQvfFhdbZNKM1UWv5r+9xmZf9upmzeYKNXQARcvNJqN?=
 =?us-ascii?Q?2+RCqfuB39P6C0Pv5e+2VfvjfJDbKn1s3MV4U9PqUn4+EkVrAtcBmVDO1uK7?=
 =?us-ascii?Q?c9Qb6Dn1Y0ARWwt1I2rPtIbfqiSpaebhH1XU/HzK5hEJeNkc3oFOW9UeIPNX?=
 =?us-ascii?Q?1ypYG3/Ckrh8v++AeAfRu6k4uAZEuI+WSpmN/fOmb2IzFCKPJsD9DSRqKYGN?=
 =?us-ascii?Q?xHMZLNFTCvh7MCUjehqCoQFBzjm587DwnCtEKUqJtiA70U92FtBSEmC53vo/?=
 =?us-ascii?Q?McrNwiOP1bN6kadcRsfK3Zm5ukB0cnhf7TYsuAmFmGuRjy+/h6/xWubQ48fD?=
 =?us-ascii?Q?lol1vdOil5RJCcE4/cNscxVfkWhxej6tfPWrYG5TntP3UcI2AZS1hYdUiYR0?=
 =?us-ascii?Q?7dsaz+OJGLQJk4bQRRlEDnsMfsk7dGqPqwUXdrScPMcjnHwZ1+1dDOJWL7H0?=
 =?us-ascii?Q?VgM+5NMr6Rt0kHOoUx3Qfed3AhVNxCfzob4HVGFLMJ3cHXyPuKL7C4JFXUh0?=
 =?us-ascii?Q?E134ZSUgkS1G3RHaismRB9X9NA7XW8G2S1GExPdhEvRm7KL/kMLFMLfyWc6Z?=
 =?us-ascii?Q?0/BncO9zngyQN492a6ohDttsa7fkTFjaraTGnR1waIozgjSy3a8m4geEXmqF?=
 =?us-ascii?Q?1MEDw6mVTYLuVwqVF0yNCdcINK2M/eZyC87NXnBKABr4cY3oVwnbzo0LPMv0?=
 =?us-ascii?Q?+Ni7Rm4wcuIEsDWSEQ9TaIFBHKQVckImje1SurdHqpIEkVWiCcxw8CUzBOLH?=
 =?us-ascii?Q?nZOUy2HgnobJfBv6EFtn7CAodbakD0w7+RbAajzOVduR28Evjmd5sunkIpPo?=
 =?us-ascii?Q?UxsBLXaGmUYnCY6s1d5NxWFYgK7l/K0nmIQE3Oo5t7WNrlePAYwnPwTLbVeW?=
 =?us-ascii?Q?gWLnsWajbKrefG/lyD21G72NMzxNLSzypdWicIXS30+zsCzqQR2Ndz71t71S?=
 =?us-ascii?Q?LxLITJZz+v5yEsko+x+SnBaDL+DGl6cH7LjOnwll?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990c2b0c-4b5a-4638-49b4-08ddf5285b33
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 13:53:03.5692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctni/v4BPKkzzlWmE/jqvvBpJb6O3ptdfE9os8SEFqFHSLRLJZNouRUs6uORvcN9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250

On Tue, Sep 16, 2025 at 10:32:05AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Change dma_dummy_map_page and dma_dummy_unmap_page routines
> to accept physical address and rename them.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  kernel/dma/dummy.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
