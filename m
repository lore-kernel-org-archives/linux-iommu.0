Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E3F32573C
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538235; cv=fail; b=LxEpjyh3X7DslcXPq+IQhCWSJiEj/PcckOKyPba6NofTlyd1ZgYaoJbaV3IrOsDPa/rJd/0VW9nlHs/pikBfrCFuBLP7uVJCVbHnLfTftRlQAdngDyQ8lAzOUUUnZbLqcTdWzSDzCtdD8GmGT6EG+v4CBpfH0IW9ehzCe2eo+qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538235; c=relaxed/simple;
	bh=5agEVoGx9Cx360zvkf+W2C2gZU2z0MAHwJ1m2o+63n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r0kINPBJCy1JB9i2VY4x74kqwpPBwglVg2fRvX49yjy/FAlGTOx5UoNqj5dK/AxhfwO2TiLbeAOpsWOephv5FHNqIehz2zZy3EervWIi3Blc6FbvpJSJsFhwJSuAU7mcM8hDi8RalDjV/CrUcnRZ1vLaEMfPd6UcpISwsy8oCLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gy6MC8PF; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gy6MC8PF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBi99l2NWG2BDdMuVETANOnY69vQ1zxfdif7Tm+dgHKLTsm/MrZu7Bw8jjdeozAUXAV9arw3XHpH93TRfiuETPpGyYluvrtrsHeS49/0SD55RwRH4FdfXXL+qkuOUdibHgpxze9Di46OFDAs8ll9TbWQxJq4sY9upDJW6VKFjy9vq5w8NH0nkZjASgZgHIFdf8bWMsTnFcgNTdpBjYcDBs/7rwWp0uYmeojNluuSVA1wtVS91CGwfMQmH07fbyvmbMw2RPqRTd+r8INbh+i2WcQ6QVsys4PCs3INLFTOk4QQC+mdKvCl2bLCP7leJN3/rqidoF6MXd+5LZzN9ek7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjEl2Oldr44ok6SfI92J57r7ApnREgX+tAgrP6Ngg5k=;
 b=EXlC5L/0uWWLa5zbh3BC7SH/w+i3cvJVDgQANb4PvNO7KRhbheuTVVx7kJmonxtW/faf0MEi87R8BzN3dD6szBofrezeiQAJoQOtHA+jelvKr3zVKoqET339kBR/mf1sjWhKjBZhohlArJoG9sbSjprll64oBvLKS7KjrYc53v5zmM17kFip6xs/qBcPlwH4jlcA2+aME5giFzeBeliIwjLwCEfTX4WTrePomOIIWUIV57AbLshMYap/FNForAppNYmKYwqNU0XHsOVK0LpczZJSXMN0erE7/fPLjn2s2LicqHNSQJFHxbiXLXGoGSNMQYprnTjTRD76dBgHY/rCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjEl2Oldr44ok6SfI92J57r7ApnREgX+tAgrP6Ngg5k=;
 b=Gy6MC8PFTbTRIWXU45UyAdSnD8JYBoml7d7PxiUcVVJAJ0TJTGfmUQPsZWjP+R8AKIDw4BveiGC4gEHQYpNTZQYVHOISmGwu7Cz6z+dO7tIuoWR7NGm00TSkzodUniOx13fy6gkxXl48riWumhVgSAXURk0K5ByItlAfcQQ0H4FFTcEHiNQ110LidKpq/KSmwSUAHus7W4yvK8vLMU4ePyIJb3y1D0rtvKZ6Ha+ikoOfQ30Vr9Te4YDmuEsg0ET75ESD3WVjKrJsSg7pVPn0PPinYY5vteyZ5fl/rq1m1EOqgmtm+60aRULrAwQbD2SnaOjFUWjJ7yTOP21qCq+n6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 27 Jan
 2026 18:23:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 18:23:49 +0000
Date: Tue, 27 Jan 2026 14:23:48 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	balbirs@nvidia.com, miko.lenczewski@arm.com, peterz@infradead.org,
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] iommu/arm-smmu-v3: Add arm_smmu_invs based
 arm_smmu_domain_inv_range()
Message-ID: <20260127182348.GP1134360@nvidia.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
 <06999367d001283744fd98eb7c1823afd516ce84.1766174731.git.nicolinc@nvidia.com>
 <aXND9YJTwm6om689@google.com>
 <aXjqBy2sWAUMm/aY@Asurada-Nvidia>
 <20260127170837.GM1134360@nvidia.com>
 <aXj+zaLoh/yQmHOH@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXj+zaLoh/yQmHOH@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:207:3d::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 88af1657-c052-44d7-2c98-08de5dd13753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M7flvLktPCZWTL9eGP3MMKGWs/Uz2Xgi2wexRUpkZXYUa8aqp8LuG2pW9TcR?=
 =?us-ascii?Q?pkFU/AA+zB0GVTifCwf8otuZoTUjaAPSnjE6L7CeeOkDzdHV5d8pwMhtDkd9?=
 =?us-ascii?Q?zsRQvWzJ5BrLASue5+Pi1+1GROBr52tYHxHtcOVrCbs6IicNxXz4Q7YS3we3?=
 =?us-ascii?Q?yvO8CITWVs2ddQmz+wygK9bBVFxYbMewDT53RcNtsbNhLt37Or1a/rmwVFGk?=
 =?us-ascii?Q?qD6hwcGBCcfPZYAaeUNKVRO3dtGrBZOMw42Pjw0T2oX++/mCzj4zvu33mA67?=
 =?us-ascii?Q?k7x7iJr671Ia9j6qtGjyQhcB1gfhtz5u/OWuHyUXbePqw352QvTi4PwqDUC4?=
 =?us-ascii?Q?upSBbYSngdEMlPV3vZ7h6j/fC8lHuPTaGnMnhwqrNoAAnQwMn+42VIK/TEUT?=
 =?us-ascii?Q?6GQqj+VESNcJS4JBQGMeLHeROAJDMfnGyZfQrzPJCx31jTHeUIUggquLzyBs?=
 =?us-ascii?Q?etRWky6HIBm65/UkINJALoGJla3q2/nn3zS4uUlYFCa3SEf6RiGQlPoTtQeQ?=
 =?us-ascii?Q?6ahNlUufqrNbzQ/1Nxhpn3MeP7VOKUsBF2pd+V8ASof9/0s68hWUVwXV0ZLb?=
 =?us-ascii?Q?EebS8B3O9WHpHMe7vUQNZpnYKt68fRLVk851VXio7GpYWxJK7XRv8snWTJu+?=
 =?us-ascii?Q?PKAoktsVo/SX51ciy4RJXYe3baT6QNAQ8LpiZ2r718LEi8Ypg0lFTCbU5qpk?=
 =?us-ascii?Q?O1tdfEvKTLmYCwzdEt3JShGY/thJAfBobgG+71fo8DB2A9MY3QDKl6nM0bsH?=
 =?us-ascii?Q?gQEjaEOfkqfJxpn9p52whWDzhDAVSPGrqHuOBMIpTCQaguwU0bUbFr97UDLU?=
 =?us-ascii?Q?bUcz67oGuzmR4BGnM04eIzSJBsGU/hi1TsVEk1MnXcbuRRg950ZpnZpV7n1i?=
 =?us-ascii?Q?6TUDl4qKqLWx7aBHXcWE4wsJLioHJKYpuQDuzffGIoCLC4GBb8NcS16ZCGER?=
 =?us-ascii?Q?UpA8Mfi+6fTYdlyUDpmmdFUIeJvRPhztlljQBTdvdbcFDJl2RlJEtDWgTvIb?=
 =?us-ascii?Q?Ggck5Tqg9kqd7Nn8r5zYP+paZmLYLo0cFPbnkfKBOHmcyRvix7ZYXS1Xt4Il?=
 =?us-ascii?Q?qcRqRQK63j6nrmpRNYOagusTDFvkfLV+b0/SAxusbF+O2fibzlgpksE57Jup?=
 =?us-ascii?Q?utJIyGvt3Dx8P2rr89H9Nq0IeNL3wTwGOByFdQJoaZWi9m16/exV7wMCQS8D?=
 =?us-ascii?Q?+CFV2s/q5m9sZnTCJnUlMG/5k7qxuUj6ueCG5uYG19X3TYV0xsE1okiV/nJu?=
 =?us-ascii?Q?FBKsMpOgxrwDaD8FDrQV0/DlUZ5xf1OL2wrh3uDFuDvaQ83GmL0KlKDf+HcZ?=
 =?us-ascii?Q?z7Yh34B1ZvT9Eou6NOSv+R2hWinjtzvVjUFIRFbA9VQddSnk9C+piPgQa9G4?=
 =?us-ascii?Q?aFRvbFdWvZDXZukwlt1aVIKTdVaroD0QjP267w60hTTRMcWfNPyMJ7ju43aq?=
 =?us-ascii?Q?5E6UM7IESWMvrpyRpJuo5tPnlN6FqwQjnMi+pv2qRMo85PeuVFO+G7LcIXgF?=
 =?us-ascii?Q?WGluMlSqd219+2m6ERD1lmWyKYOMEbrnyUvRHkIg8DfOr5V8VkU1+khbt5B5?=
 =?us-ascii?Q?d/7emTcYMZpdqDtjkSX011WILapuaobMFh5nf6j1GuRSRqX5UT57/iR8ql9y?=
 =?us-ascii?Q?wq7ghDlnMC5b9rUn55QRxkk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kcyH45Fju9FyvhNjzUxRA9jOVQvCQIILCehWgSNy6ToVgNjZpJZvFJxTdqPL?=
 =?us-ascii?Q?Y6jj3KCkBsmGsh8g3vfC5vvYpOp44T5jiUZXTaHT72odv44iQWdOBWa3rQQ7?=
 =?us-ascii?Q?Bnj8jzsepp1BB1aLSf4WEL9tbZnIISokBmxMIqhTi/s0aCpwfjEICDDrPPG3?=
 =?us-ascii?Q?zwZB2jxrgh4Kc/mK3mBEwcOw8fpMXHimt9TyajufdG7se+TZKnPNKVY3CGSu?=
 =?us-ascii?Q?yv5gY3EVdC31akv+Hu5965UE363hm1Mb2OggWu/awzNHQcJdehsUAjWK01PY?=
 =?us-ascii?Q?/SvCP308ed4cyqO99Xb5AEaxLT9OcoK+NBC8DBAujyYsV9ogHIvtOmrbTlSy?=
 =?us-ascii?Q?+yBYcXwIExygb8r19DOR1+vtTH5ri6NeR+2zkdLBaae6CO78f85IA4bCzwya?=
 =?us-ascii?Q?iZvlAqzPwSGWbyVEsD1jECveiPJvRE5zcE1rw4dqUz/mY9TNajlcUMvbwPDB?=
 =?us-ascii?Q?xs+LyLOIzX5Kif6DOF1IeILVamMEVERb9f8UBeboYemiRd3yXFqzvkzdWad+?=
 =?us-ascii?Q?Kxhekl/T+oZsJ+nqwJGU4gM9E3rQ/FwrTwQINU/AzQN5MKs7hLW62T/JdGvT?=
 =?us-ascii?Q?prjpQ3gMybdoZEMmI+BEtbytoZ+V5MjYj6sxQFYLumZPKwk1IGBx8r+YgQPO?=
 =?us-ascii?Q?vIysI4ZSfiwnROKIl1mue+qh3oUMIgGuqR1Ui1Ct2ctAjHTJ1nNtSA988jJp?=
 =?us-ascii?Q?tuh/SFYGxDsW5JgtSsobp5QAQWePhQkRv2t7qAJUmJ9VKQK6ZOxi2xCwlu4T?=
 =?us-ascii?Q?I3jWDkSrBayR5B/behKjBqjglt6j4kQkCI8mAH4e3JJhtppKCAWLEN9N4eda?=
 =?us-ascii?Q?wHUo9cCZhaiL9RB2q4ezI1KT9mx96CzpdwOU0i7KPAzYZzNaTUeriK2q6ZdL?=
 =?us-ascii?Q?PzO9I3tlUVkOHUNwT4CvrX96WzdNY8wVOnGzEgTIfiVNNzN8CMWF6xxer6ro?=
 =?us-ascii?Q?ApRkaV3WsWHXSMBUK8BOlTo53buBBihZUk/D4W2BFEd7qZoFPpgpx7ZIrpBO?=
 =?us-ascii?Q?EX8z7UotpCS2NwW7s16YVddTAV/JKRduPtRMsR6AURGy8HxephwL9XS1bfY6?=
 =?us-ascii?Q?h1rYNUOJc0Ys+FYyVJa1JH2jZ0exc4K44SjREwBYaRFIcDpAwK8EtyP5IlEC?=
 =?us-ascii?Q?MWO8ep/VOQlXrWdUzA/+EzET1207criB/RbGnfbGeE2kxMdBzinlEM2L0nWn?=
 =?us-ascii?Q?qd+fYitiCRL9queJPZG8/lzUGRTyzD5vG9Cs9WEc8cfgv/4x8/TMsohJxsm2?=
 =?us-ascii?Q?hW09bIK0t2N8BJ0vpYiomd3FhngSMk3vIczgPHq8JuQLiz3HyrGIMKIx/mZ2?=
 =?us-ascii?Q?7gWwZJfLqjTEEAGGF44gTHMSr0Aj1/KnK4ucJRpKAfPtC2k+n+c9fzWtWg/p?=
 =?us-ascii?Q?PuQWnq6GJ5/ZyjFK8FHESV95O7zaV2RYN97YFLE9FfFSLn7PTGNerTORr9OB?=
 =?us-ascii?Q?rdn/Z14DTxpNEUxITfjIxxtY2KmXPzrBx3+1RsGls7ULpsnLhoKAt8ZUcUEx?=
 =?us-ascii?Q?/1hhFkmEhW+bct6bpH5JI9djQTK6ABV4bfi8WbStuDAyAtsuxGN7IPnK3xVj?=
 =?us-ascii?Q?TlB+JIVbLOVe6ZHjoO+7kxxLIA6Mpdx0qz+NR+mG6vCptRoUmreRazyl6Dxk?=
 =?us-ascii?Q?g+1Saox4SGlhHdA/h0xl7qqwF9vE3eGjtzW4MoZ15EB80YYN+ZaBOiukA67e?=
 =?us-ascii?Q?p9j53G6z9s7d/bhNY314QmlY/IX3egllseaV5bTYT/oEUndZXi+UY48lRzyu?=
 =?us-ascii?Q?AmGmyNkkjQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88af1657-c052-44d7-2c98-08de5dd13753
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:23:49.5066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3Jc24B8i7lHB9nUKbl4f+q3liGnNrqN+NQJunWfJwCFbxwV/fMvAuovKYdirhcQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588

On Tue, Jan 27, 2026 at 10:07:09AM -0800, Nicolin Chen wrote:
> > My understanding has been that this invalidation can run from an IRQ
> > context - we permit the use of the DMA API from an interrupt handler?
> > 
> > I though that for rwsem the read side does not require the _irqsave,
> > even if it is in an irq context, unless the write side runs from an
> > IRQ. 
> 
> Hmm, is "rwsem" a typo? Because it's rwlock_t, which is spinlock :-/

Yeah, sorry

> > Here the write side always runs from a process context.
> > 
> > So the write side will block the IRQ which ensures we don't spin
> > during read in an IRQ.
> 
> And, does write_lock_irqsave() disable global IRQ or local IRQ only?
> 
> Documentation/locking/locktypes.rst mentions "local_irq_disable()"..

It will only disable the local IRQ, since it is a spin type lock an IRQ on
another CPU can spin until it is unlocked.

The main issue is if this CPU takes an IRQ while the write side is
locked and spins, then it will never unlock.

Jason
