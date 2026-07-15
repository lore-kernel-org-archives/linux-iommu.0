Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8E23C09F8
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784146529; cv=fail; b=KMQJDc1bmumuSZphdDtkvrQOPBi+PJU6xrcBBNgEnm7F84x8wvl295Akwg35nJBgcRYQ6TkCxp0PkxjZoYRdRviWoFKySP+4lcbGiWahkKQXDfkWJSR43finAat93yxFtgM//6lZy2u1heaymBiLGtf9xNvhGuHUn9ZUVjIpc3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784146529; c=relaxed/simple;
	bh=DdnTKhSlgI5g24eGamMvS0aEWCFR0v6Lwz4865IdLZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qzYVNG6OjhWGpPfTgNPQ7d7z3fNf8WiT//TPeEuxZYuCZDMNHUrVt2twccXTOwxrXylnSW9HM5kMYOL2ilxiUpdzjsNNtCMUbi9OTxIuSy9Z19yp8FUHE3a/yga/k6J0MDwcJ7L6GOPPCkHx5qKrqAiZfKcG5UNr/hxjfwW4UZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pLZlRdEg; arc=fail smtp.client-ip=52.101.48.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pLZlRdEg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nxebb+nEm29kiJ0WHdfwSN2GTxq4G+bwaGf+dWm02VV4gxzSGRiMTNcE+dPcajc8tdWdKlGzfMhR94D7GEFvCvMZBuEJvqDJ/LOWAMUNBVtMMFYmQVnVFbH0PGIa78kWUWi2tLEb8vT6om+IIAxHYnHg4uC4x+BbWNJ/OS5n/NJE9v+JjE2lOrX2VaHo7bslT5TpW/mawQ0KF6aIMg2U87sPC/6ZpobnXXi0OG2eqdcLp2wW+NNivssp1dn3uXVkeM1zhhnyLmKobYqCV8elhG8dEXwV9gR3qFXy+VZzfqnpDz2BolFr0lH+7FCnbSdDoyq8oBr1lgMafoG8gEw+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4NxUrwSE3ySOmkfTAlnkRNWzciOrZ+vYM8vAeh+DvA=;
 b=n67Y+8/v8Dba9UuOegi9qzm7NCTpCq5ERjJtkJ39c9Ktv+rVKIS2tREeMqX2M3vbr/4uMB8jt8EOi+QJTd8b+SZlO9VQE5cZJpSlsash8y3S+lSp/CkARKbkw16HS34vApAfekjLGZw1phMygDfHFM5GjpIYdEL60J79/qZbxqQ1Z9HM8AVIqpU7dciwQHSUurCWj9jkPgPKPGhOGVpOmgg+yuazj2IY2mKSRDr5R9GN57n8vIsZoHlzMagdBvTzVz2JPotqvfqrfXdmMFfqjamBcLlDiw8Jr9F07UOvMrYfmnOv2lniJjIYJfqKTEmTQd777hn9dntf49luVBe+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4NxUrwSE3ySOmkfTAlnkRNWzciOrZ+vYM8vAeh+DvA=;
 b=pLZlRdEgxRIjABtmlflJsjHdvxkQ7c8dDR6eEhgYy8TRhDQJIrEvpLpZH2k07jMJ2mP9+u1PMGv+P0pkq2s3E6P6UIbgfsYkrmOO+4zTuQ9PRUHquieZFHzJbO9ULq1+knxw0B1Nq0aJX9MLIMmPJ7Dcq/Ue5G6SXkHuWYz/Sj8uH5zhSbfBSJ9aU/oCwU9AnVZKo/IAKAlQ/s+WDq3DZ8Ph/QVzSZjMsNhzG50g3FkbMnfU68fq7M/Ovlm7Qxa84MSdbCjGN1XyMYJDZ7cIomKwspDHFKsCrstMM4alpycBx1DM3Vh97Y3MqeeSrpOCQOg0AFy+mD76aqBgNLmmsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 20:15:23 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 20:15:22 +0000
Date: Wed, 15 Jul 2026 17:15:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
	joro@8bytes.org, David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH v4 0/6] iommufd: Iterate the cache invalidation array in
 the core
Message-ID: <20260715201521.GL3775915@nvidia.com>
References: <cover.1784054606.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784054606.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a65c4a-61a8-4322-b60c-08dee2adcca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|11063799006|56012099006|3023799007|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6F8QcduMqzlrqMr0sdNUh9vltBKla2LsfgNZWIMeJPbAuBZFogdts7SwdWmI+7U0eTRLHV0T7FOuQAOG/dnPCaHxnqbi8IPgX6zWVarjvDceOemKNutiFMvecWEk8mvi7sjZ9uqOOdC1CUi1vpEN59ot1OLcQfMQUbmqgkQXNkzYQZSoMZHZ1J6dTRepV38RNplDkQBBfaSdeZHYKnVvi8mUBiHBTrFds6cXkwhbGwKefNQcWlmzllR3wNTuz+csu25yG4iwOMI4CU4joERUD/CTLdieAm3mFgnXt+x8w/ery41PbWq7Jxz5q9v5sukgMXH0J6qGWHDQzcU68qKxzAsmOqbjGYXZ1/rHSPHqpOt/WVvVKH5czhJlpghjXXVAraKtVewynHz3Q6/pTLFdpOmTzBp94rdyGrqVbavmNMpjM91SiEyFC9NQgWVQ2b0yN52RSqiEpzAsOOXhkczkyaDEhxL/UelTKdtIl2SdXB/aYceHwUtpI9XVpMiytzh10hL3WJmWIRjFgATSOB2i2CHFuitIBR+mCpxY/WpLpu2KIeb6T19zWVp0a0NNJ/rUF/s60jD5tIjpjUscDVf99IWwnSBrmU2Jlm61Cz9AuX+uqdNZhN0VfkSCzMMcdJlJYRFGVSndpvOCmRDBuAJYs81tdrW7FfIVbAZc9haLM0s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(3023799007)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ygHh8Mp/SiWn/Itj8tbyWqX+sLVs8y9ajWM41uFqVd+/8UjIXJscHOjhNng?=
 =?us-ascii?Q?hbqd+yY4aii78MUqn0gqYnDZSkDaYtUrUiN+Lwyx6FxIO2Tt58ErHCep2CnU?=
 =?us-ascii?Q?309uzTl7WiehYLh2uDErmtcjjJsEoT8/V37c1EmvmlmWB1xOgXlZe73rWtU4?=
 =?us-ascii?Q?rTiEoeH/mj43dkkhmlkdxrfriO8RAuJ/jqVP66+m2BZEGgFB0Hgmvg3UMHi0?=
 =?us-ascii?Q?jx9bePT5I83+3lAmfk9qEl5jUVIpyTtqJXF1v7GnJHg7SgIQp6icvmC8sOAN?=
 =?us-ascii?Q?scxYt7wJlL6OEIMf+epuij+UjTtH++4FkPbDFIuHElIZzWUVmqVALFQP4Voy?=
 =?us-ascii?Q?X479IahPYLA535Q2EUTXzKYG36IwsWP/4v66Spy+Mbz1Q5tbaRGG0rmnizdu?=
 =?us-ascii?Q?X4y0Hf/q2CPNAfcYZk3HXtCBzckPU6xu3o9OultJgB4waVerCZ62UtzpS2Hu?=
 =?us-ascii?Q?iz69ZCa1pCZnroGdJn28Ex21ACYBpar1c9uX8ql6JIq+E7IYlHlhNmNo2VWK?=
 =?us-ascii?Q?TpobBDU3Qd8PwuNVtu+xUiQv4Ej6WK9cYbMgsUZx8g7KL+6YOAcetxFnVkYd?=
 =?us-ascii?Q?zpwOyWGV7YLqw4uuD3JPiVxw1a/foJ5Rnl5hfvixzB1AKcBoKipmDHRbFtxP?=
 =?us-ascii?Q?IIkR3+HVmVQtYwDHXzuT5pY7oRuAINoBItVy33d6q1D7DkxKvt5CUEQ/ZfW5?=
 =?us-ascii?Q?dvCXgTZ9NMdPaMpswVLaotNq0h2aJ2jnXY7TFvamLHcswVQX/aJGZTyyo3t4?=
 =?us-ascii?Q?RXkPcsZq+IvDO/9JXemF7UlNxNLnDVosn+N2qPC8asuqwXxzf2FI42IKGe6A?=
 =?us-ascii?Q?zjCAYDZQL8ORAlXUQjySOjC6/vKC0umNsT08SyLAturdcHFRGQCf/z08Xevx?=
 =?us-ascii?Q?7RjqENNHFwGQrn2wNpjULf8p84GK/0lO3uav3ehrWOLa/ZViwRYulJy39p+i?=
 =?us-ascii?Q?qYTMsak+eNnMaR8mLEaXC7TLlE3kkGdRDqx3rYiQ3V6u7IO8Xn9ymWnFYste?=
 =?us-ascii?Q?tGrQJ8x27P2pQkcuhQrrBWa/LmVH9iC95TpZ0fcZ5VV/dcxfQa8iBjXSP1nq?=
 =?us-ascii?Q?IjpTYvjn5HBp/aC40ROVnFFBbWnuk2o0ybk/giou4G9vX7dl0qAmhUz1PMZ7?=
 =?us-ascii?Q?LOil2rYPPjf0uo+TyIe+I5cgr7yMfinFNNoXV+R5bT4CmQI6JojQY7kR0MT6?=
 =?us-ascii?Q?aX1exZwW3Jv7LNdIKe5mf+UDkOkgoGElMz6ebhNUQoigb/SYOuJXoJ4Cf2JJ?=
 =?us-ascii?Q?KwxY/Ff3+XD1MAGHrkoGPxRHXO+MH8c74XSAXlrFIBuzOJK/SlTsqDx06JX7?=
 =?us-ascii?Q?EJKLu75rODDE1VFgZnTVB6OBgXiggdBd0MuvPouhxYlYowrU8kZpsRqpS8OJ?=
 =?us-ascii?Q?+thbkBTQ3ocRGtWVaKlfhCra7CRGXnLOtSoP6WroU+8JbpLTXMQaI6rB7fh7?=
 =?us-ascii?Q?j3HbjiSvEMmyraBvq/0vPoEMSaEeNViKtMYZZRdehcD9sAJdy1rQ3Rw+EjqT?=
 =?us-ascii?Q?/9+ly/CDEVvZAiw1gkngRFyA5Woy5rjpDdheQCb3jUpe+ZywVUx8wprarJy1?=
 =?us-ascii?Q?twNDngvt0vgSibvnO7DDHLlXpLU9tx1s70BehGL6bYpqV1OHlVMEo+ZnG/83?=
 =?us-ascii?Q?ODx2scc/rcu0fO7uvA5YChocIW59s5EyNM4Qq1aEaGoEEfXNGJF0Gr1/jvXL?=
 =?us-ascii?Q?4FiOQ7nrIflGxPfHNDmRAudxOaGD8a+je7O1qH57R0y7T02u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a65c4a-61a8-4322-b60c-08dee2adcca5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 20:15:22.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TclscZ9+M67SURa3x4iWyYkXWpDqMC/GFH8hPW3qRKVFVdJuwKbxpNoycxP+wq9b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172

On Tue, Jul 14, 2026 at 11:48:46AM -0700, Nicolin Chen wrote:
> Nicolin Chen (6):
>   iommu/arm-smmu-v3: Support IDR5.DS and widen the TLBI SCALE field
>   iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation
>     commands
>   iommufd: Iterate the cache invalidation array in the core
>   iommufd/selftest: Convert cache invalidation mocks to the core array
>     loop
>   iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core
>     array loop
>   iommu/vt-d: Convert nested cache invalidation to the core array loop

I was tempted to take this through the iommufd tree, but Will, I think
the first two ought to go to -stable through iommu ?

If you do that then maybe I'll pick up the rest

Thanks,
Jason
