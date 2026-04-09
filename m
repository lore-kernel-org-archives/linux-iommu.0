Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D939C003
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778227; cv=fail; b=Fi/LhC4757i2YUW57/gO7QQG1x7QqiMi43/CTqk6SPQCk35uNKsu9UCPs9zNLREGtUNrNRpJvS1dnNGvtqX10Bv1Sd6NkX76D9hR9Opn5QNrO6YMcEIv5zopIu5CWIi/2/o3OpFCMS6buNUdQdph1l8c1Ouk/dqnQxdL7g4ZikM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778227; c=relaxed/simple;
	bh=h8HwXAluqmxFyldeNL0hsVSUIpOuIz7Ktn7Ow6l1vcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fXJp7RrbNbyRgC0dIfuEnDB71b/1cEg43QX5D1TEj5wpmX1JYGiz4wilHW4lnUqEiXraOI7G9McJO27aL1xyjl5cOVZBvQQ74ZdGmJZDeBUdsFf9q8/rIvDWujPIKMsB/VqbwXGThW4E5iS9C+7giT5+LBqXv0ieyJSmaqGs7kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KY+eEBT+; arc=fail smtp.client-ip=40.107.209.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KY+eEBT+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBmqlB/LyO8LMBbqFMey7GgGP4EccA1/I+aK3Vl12+GpTpIfN2mrFFsx9mx27fxLyRMM+Uc9ya6IvgR9rN40i4rKDZMeHpR8tM/gbud1zuibb+f95q/eDFblwAAOoB/rsWSY5b2AgeYmjUhIDhhGu8Kw7BPn4d1RF38RZmCi+YtSW1qy9fW5zt3VLA1iXELrU5/8u5y9ccc0qTw0qa7Op8W1Xn1+kUqP3tFWZ1k6KvuFP6DbQTyJlc9FVwYBTO+BP8HAc0SJ/zs1PYOE5ndpKkiv4pqKTPk4TG66d7le6PtZsLYWJ+WF8ieLl7aFG9db5EY6OriI+phZdq2vrsQ53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0TnjXh3NP5Agu+yJBYFOEgfSAduMFzV6VuwzTqPjBM=;
 b=owNwy2s8HMa/ULPb+G1d7DoryI+E4dSyD+KYuHbgXeeKLz/g+8v3WI+cqgcJBGj+RMqSwHK4ipUGYD2cKQKjlDUOVMpQLnPTF0o0ZHRN9fkqLPB2zw9PekOfyx7Uu632dXomVi5RHBHA4xjaHihVFpgxQ/r2X9N1SQF49psH06x4nnYy/8evskYDffN8dbk2ke6zuSreCnhkVtMlLWBajvzsXg33T0pP6e/dB1ndakEfDJD5BFrxEalIBT9s+dZEnC2ARSJcIod93VWopDbngpUb5Ql2JWESsXTr/XGRb5SmXfJNOk//aj8otTtfbSRBeTpSiEbdghZWyIezC7VOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0TnjXh3NP5Agu+yJBYFOEgfSAduMFzV6VuwzTqPjBM=;
 b=KY+eEBT+2zJApgcA6bmN84thWVF6cXexNDzEr9/KMAQ1ZQWaU81PX1tiBHX4vwoPyNXxCwV06rOMF/QQOrYxawQJgr1GhA+F+cb5KQmTtjVcuAyrajPxQokssCYStN/TYSI2Id+NGavr012d9O4wmrpklNxRDp4z+NOP5DQXYtO4mrTtl6iV45xkKWWoB/NYtHDQtWW3eQW8jUjRRU3iVWm/D8wVGfPWRpGvQJbChaqlhgDd3MJMKbhtT4eCuktRG/Y6GXqzUjv+pH5ni9Ysj8gMuDLnB9lA5qjSLZhWMmOBFhKI0qrFcE+fl/Rs5oK2Hy+QuSe/gS6ZHgdCJnsNXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH1PPF8423FDA82.namprd12.prod.outlook.com (2603:10b6:61f:fc00::617) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 23:43:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Thu, 9 Apr 2026
 23:43:40 +0000
Date: Thu, 9 Apr 2026 20:43:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
	praan@google.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v4 04/10] iommu/arm-smmu-v3: Pass in IOTLB cache tag to
 arm_smmu_master_build_invs()
Message-ID: <20260409234339.GY3357077@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <87419a1f7371643959a037f1ee7119ffa054a9a1.1773949042.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87419a1f7371643959a037f1ee7119ffa054a9a1.1773949042.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0224.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH1PPF8423FDA82:EE_
X-MS-Office365-Filtering-Correlation-Id: 8223eac7-b089-4e31-6fda-08de9691d3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5ejgYd3kzC9cA5AKTGazAKo5m2K4Xh6sNgdOrFbHHcJbq1zIuNy7zdrg6TZcRJtNO205gRonkI20L+VW2HmxZTmUlZBO04delWCN2EktQHRgYSis0dBObGIb1hen/NpaWhCBuInTy1fbuRu4SqxZd4QqCesiQ4zp5C05GEVPtBu+kBh8YPfBTtikrWG4M9kq77gqYQWSiEg3ynitk/+L9ei7IE0Fg2CNnk5/eJqSU07yedkomRAC/79oU4f/eSdh73rMdG/mCoqasMze34Jtn84glRLIqkDr4U61+0PQ40LbRFjPHNH+bM3w3tFAjYQH8J4PPZJqgkHmgaAjdhspt2x3ug+AmVTpjS+XEqSwlvfubdVSWmznSQkUS5WLbE8WIpw0gGqSyLYU2/JEPdr5fBjaqmCo97iQuoYxKlr1UHqrXq3hkeHqNyo6NiyMMQFHP9vyMTW+CwO2L6HhbpbfJz3zLE1WVGYVSwRbdxQQrczCFDfMDHYYOHZmU0DaqO705mwuCZsA/AzgSSB8s296zBEsdFWT4kyjOuQEohg4N5UqAdRru3w4EzBAd67jCevYwYt70T+vic+FPAUMrD5gEYl6GRO9fhQtRyeyxZi83i+rgy7iyqnRpzsv7JOj75vZUG6MTIYuG34ufegYtkhbiPX4oLqRZgKZmPkBvOqNjDXuyOVZHEC3sxRKpLA90+GUnbGc9V8LcJUabvPars8J5NXaM27WPiAoFZ4O20M3zOc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vz/su1qZUzB+EjIi/OSNK1Nuv/TLC+4flS7q0GOK1ToaWQdrf11tYsH+DpKt?=
 =?us-ascii?Q?2ehgQcubpHM70V0gDSu1/RrUGLyCv9368bo6k/Cw4lGaU2nstfkGa28enbEe?=
 =?us-ascii?Q?gDH0sUtbYsAMjaNWmdkhRcR/rvcAeTXKUhXDL31mcneNxqgsKSunqv+LAvxZ?=
 =?us-ascii?Q?s/JS0Th6e2EQckAhv6FmEN+1Bx8N+xItaHAAFroFbUUtwBDfXmFfFjyoPvvU?=
 =?us-ascii?Q?cOmbH6qaIadYw8q6UevvOy0O4qylBmmZnTqbGujP1CmQXxHNyrbm043ae2W/?=
 =?us-ascii?Q?6HOiGepNVQKLgz/M3emi/VLBlBfTf8e68ZrM/5ZwnWhDYyIn9bFvi+Pp+f/h?=
 =?us-ascii?Q?jJYeWdG1CloCY/dXVa2jDnACoJUZoAUJaqDbD0iIuHqooaoh5cLN0y680RKH?=
 =?us-ascii?Q?5SA6bBj66qKuxtoniv+D9AnYWmq1EmUhRaUH8kpmeSqZ1vqXK8CcBASmKGLH?=
 =?us-ascii?Q?dlp6/LsHhZRTsoCe6wOnMIf/PjInhs8RUO0QK4KFjiWX0f25JTAlCPq0ATnW?=
 =?us-ascii?Q?CQ454WYaprs36b/ym9rqlKWXphUvf3zOKjpSMdGKA2App/zlSGgrTewKVWQl?=
 =?us-ascii?Q?ef0OH9FUNNaPU+Zgqy5BbpbU6fGpkhuF3Q+6m6r0DiMbhiXjWif9N5E8P51H?=
 =?us-ascii?Q?p5mHNonmLFJB1yl3U2P5HSfWJ5tIFhGhOtE//+oExQp5emvlLijdA3533VDj?=
 =?us-ascii?Q?vNvA1+Hp+JW7jHdrnk3ZriBiv5UvR+RMjzFHw0XBnMIKYpT8xa1LaRPoQRrU?=
 =?us-ascii?Q?GOytIB9KxU+KvL9w25EUJ1ShLh//lxv0jGeIeD9LFE7M3Vl91Nz6GjleJzjt?=
 =?us-ascii?Q?QD0NwSlBiZRvEdMWqD16dlpMJJ4FuFoeWNumn0jE6yi4eqqawycsQ0ZpdwBG?=
 =?us-ascii?Q?utpvptPhnXYB2ur/I/s0pPmIJG1/VHDReaUn3w2gBCfzlSoRtt0hqJNXHRIa?=
 =?us-ascii?Q?YT6Hrc5x31z8zRO714v+/D6+RdoBawVmU0X0QIpwZWlngbqrcrZ5b2aI5y1d?=
 =?us-ascii?Q?4ftGl7MFJevpfhd3A5CTxQv3PHVIfyOldu9YXZczmHfAvFJ5uKMsg2NxAkTQ?=
 =?us-ascii?Q?06wB+G3xfZ/QFcvqS+vmEC13AWKfOCHYiW+p/QSmfaEeKRcrCrkDeBRPhdSk?=
 =?us-ascii?Q?uH0Jjks1plsKm9R6nXWTiZFwlyfWDI+A8fUt8fPlhJDZuPyXUV8EPQRvefvH?=
 =?us-ascii?Q?yo8qXq52rxCBF9yNrPD9ZDk67MOGELUBR8EjQ/YiKZd9zy2SknXkMGoGLe3p?=
 =?us-ascii?Q?muVL1tGBy44O7REp3TUbqRmfLT586Ty8WHuXsOVYJRtlRpJA1sCmBawBnS9q?=
 =?us-ascii?Q?vj1OfIKxmuwB9TZybk3CoFSNRd4OAn2plWA0XZovfw7KNXlPIm0p0JuLeenk?=
 =?us-ascii?Q?agxrrzz0rsF5AAygBl/0q30f1p8UCdMZTVf6Jmbr/0fN29WGidMPzrnSvAHQ?=
 =?us-ascii?Q?ehw1Gd6dVh4C1h5VbXK/LeHx6yjiPWf584GQWXkyvvluYXRGq2/Hl57nF3ds?=
 =?us-ascii?Q?hvviTdQOeIYAEpwS1E4YF6eeFmwUtgvZT8zQVzzTJVOBFuU9CzxmAlRNW2tJ?=
 =?us-ascii?Q?/o9CR95D6HJLYtED4KV5e2lL/naOqDjZfjDoO0YkPtkx3LRQ+U2mpKDtDnot?=
 =?us-ascii?Q?5WUSh7a4Jx2yZHNWfIhhWNwEzhho4BJJWpan6a30TKtv8oykG+UkcFF+gK7R?=
 =?us-ascii?Q?2pt+LZe9H03XPAt6ujTUpAyAis2GafdTOwFrAcbTXzr9sr8x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8223eac7-b089-4e31-6fda-08de9691d3e8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 23:43:40.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olLxhfnS5L1EPVc+Gs5MamhIc7rWgyVKl1we8DPavDpbwTFNL6CXkQSBEc0nSPCQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF8423FDA82

On Thu, Mar 19, 2026 at 12:51:50PM -0700, Nicolin Chen wrote:
> Now struct arm_smmu_attach_state carrys an IOTLB cache tag in invst->tag.
> 
> Instead of getting the tag from smmu_domain again, pass in the invst->tag
> to arm_smmu_master_build_invs(). This could simplify the function.

/This could simplify/This does simplify/

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
