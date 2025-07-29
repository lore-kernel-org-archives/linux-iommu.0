Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA30247288
	for <iommu@lists.linux.dev>; Tue, 29 Jul 2025 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753828062; cv=fail; b=aKOn0vNxrRka/Ru1TPy3KMIgXK/gvkvH4vYTFZ6eaGW6gaeIlhHk23MtqcuSvTujS/XE4slAmdY2MJsgieYdmGOtPPrHUaisNkBcs6ERiCXy5WDytlgKHJd2ibFNjZxy38B7N8ZUHKhuUafsHaUDJ9b4ochgfneYV7PDAHnEHzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753828062; c=relaxed/simple;
	bh=OIvpbQ+lsbeNIbGMq2dA/zyhOU1Ft0gPlm/r2Eo8tZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=td8zsvTB4PJU/02DWIUOG90uyAO2CpoDZOjOCYRNFHuVGY0HancQmqAQij2X16M0c0xfD22GaYzN8crTmxbIlFmzu6oJcg/XMrFmmWRuPju5FpcstKN35Qa66to5seN8/QbATlV7NTu9Y+RW+YcwEMjP0pIv88yM+DCi34ab+3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WOfSd+3t; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WOfSd+3t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgyuaNlM3Hvv6so48hrnnkkDuP2nZRohq9VN2d+I4SrW81QgODaurkivVwaii/kw6PXV2AxehVM5yVJwrTnxko2S02HyGMwMjIZ0MxVjK2gqk8jm6oKFByKLZNblDZIGxaC/7Pe7qCvuXfjhO0Zgz3+j24F9asixr5u5X6jt2zoyniLRjZJtDYbG9lCxwTGBG6UfGCDqmNyYQGTBjYl2ILVBk8jPLjA9EW1MamF6bc0eQO5dFBN1GlTEdaRJ1WNrZAc8I4QwrXS7EEe9sa9SiZ0FfaPHJY7SPfI9sNIjb1UVp6DeD9ckc1U8yS85F85SwEtOYDqSafiSf+jKaoe1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZQjowNb4JVoFtA0hNUBM8VIWtfBf8v/p2r3zPHZxz8=;
 b=Q1xlrFuxEZEfwjYGZl7rl/ojt1jFTh6Y9HenoqJXz3pzLbOpe4IbuD5VPniHF7cfkl06c3PFX/tqjuducw516CNA6poD2WkBjG1cONvHc4rWg779JdjenMULB2Ahwsz/mC92wFvC512MyRJdq+BHCbQF3mB6hfRZb1wGNzFdj+rTvQpV7pvLaMCOzVzYbiW+D1ZxZNzs9t5WTVEnuxz8rM+x8h9Q+iux06L9yPZApQ+W5nIUP1+vMMb0FRLclIiwK0Q17dMe7t66mhVM5qInsUa4vSvm62p+R8RUWwUFq+aCkXs9b3LB+jrp0PDicElT/uDf+fD8WiGI76TFLuJkkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZQjowNb4JVoFtA0hNUBM8VIWtfBf8v/p2r3zPHZxz8=;
 b=WOfSd+3tomYJj5X+qb7HFGq2uNf0gVNVCRHTsm+wIXSlbZfec8UW+TMJZ2xgzZZCPae3KEvHg9X+B9xNidQR5Xi916vuLBoXa5jGSUYEvei3Jqinxry50q1TJV1dAu8FsMA1/Hic3ThnIQOm7p4ucvAPVhLgXNJfXwwXtM5/w4JJEhMuAlNR7VaK3vD5fDv7akime3aR+RKrhEkb0YRtxL2EFspF1Mqin8QZYPYJTDWFqK9Fyhr7FL8ZEaQKV7gRdxiA1YgEej8qrJunOJQxWdlglEbTxecix6nWZWslATkh4+1qj36ECD2qlaogbCDyAt5+lZC29pYeVbrg4vhYHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 22:27:31 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8964.024; Tue, 29 Jul 2025
 22:27:31 +0000
Date: Tue, 29 Jul 2025 19:27:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	praan@google.com
Subject: Re: [PATCH v4 0/2] iommu/arm-smmu-v3: Two vsmmu impl_ops cleanups
Message-ID: <20250729222730.GV36037@nvidia.com>
References: <20250724221002.1883034-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724221002.1883034-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e32945-5acd-4784-656c-08ddceef1bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ajZbhDamGAkVQ069oQDf5ez9eBxaoMTxpVNN1FvE4a0/0F8Zokje3WWs5V5?=
 =?us-ascii?Q?UjQuEGLbMPTLGebmF6UuzNyYiHy9ovCRQL/HpmJcJQ0VPuaQNuMeLCQvtq7K?=
 =?us-ascii?Q?IkNYCO7u/yLheL1Bi/eJkYNBBuNfM4GIUqIuMf1C0qeGsGtVvSXx6IncgyDX?=
 =?us-ascii?Q?tG6OO5cTLxa6dYr+hd9hXMuEiAUOERhH4neG4L82Tk7HArwi/7RASk9Giqp7?=
 =?us-ascii?Q?5K73r0AAy4K97s8DKi3mwYgFDWRIxQeWWfI1bhBia6/ANcgptMZYM9Ki7udA?=
 =?us-ascii?Q?zVpBV5JBcQyAfyrsmv+ns6uWtF8WmzaQBKxGJrRlBtmLPBw/XsMCu8qIyMy7?=
 =?us-ascii?Q?DoMBe0nhxgjoig+9r4VEVFcthfV2n4V8b5bm9kgNTMMj3CqaFkhc1ID+3HSO?=
 =?us-ascii?Q?H7h8I1zXxygGa/NR1sFNsZVv7xNzEI1Nsw40ORNoXV27af7tieYOsiQxdCX6?=
 =?us-ascii?Q?7XUsZrCYy4rZKg66gAbWXajGC9aoX/Buv/qBxSyIL3Y0pU8kSG58NfUyczob?=
 =?us-ascii?Q?wryUbwe9jJmspoipWRz1iT1TKGjOjthsLK9oGYzQgzDZafJfNIy9Z7Y71p5l?=
 =?us-ascii?Q?q7bAX5bhxKHdBIg23z0qBzMqhvwBPcyVZPKCTshqp5lWd7Q+jqNmiQIFkZyW?=
 =?us-ascii?Q?qdqmBdfLi6PgsylidPS7/Vg3KwfBsX1zoEEH/BOdOI24cKzn+FV3SZyr8180?=
 =?us-ascii?Q?E2oQPAA1mnxb5P6eoaSjRItpzexT3uiX8jr7qbZPsWuvqqLLFKAQkM83ayuu?=
 =?us-ascii?Q?OIG5K3liP//tYMJ0WFK8COb+aV/qsKHYCfSnfqHSP2A5wsyG+azIw4jJnYoO?=
 =?us-ascii?Q?HfCUughcPXzQGANavM3jF+dK+ZZ2j9G55TU+sesiqbn31fiWcm3M4wQnp9Ie?=
 =?us-ascii?Q?yQWXvWAYdgf9KzxpH9OJkcoVa3kJSGUSBqQY8oQYLWa409MXiIAOgjUYwI+G?=
 =?us-ascii?Q?+Ndn6cb+BaVqtDvC2raQC0EJy4VT/12S9ixIhZsqABU5I6lzGdHgOcyOmsH+?=
 =?us-ascii?Q?FpvtwhB641bX9tT5/jlrNvtj8AZueYAt91+akDVdqQ230V2pNd455dm7FWmR?=
 =?us-ascii?Q?TNg3HwX9Z3y90hXyVLxNOzXnX0266/NDA/GBCNDoCl0jgwJ3bxfqPPxUTlsZ?=
 =?us-ascii?Q?1WrYBSsTr+c+tfktCKPNg4+mD6SEVWiUWWjBd3afML8565HUo2YtgM4wJlgf?=
 =?us-ascii?Q?op5fAZa8mGBFHscMqu1rnaLWdBuk/14MKO4rDEdrtbx7JWu0uPYJLAfUlTKV?=
 =?us-ascii?Q?eJfoLz/r0KybVfLj1V6FRFIRNfu2VndEghU4PAW2bBwk7Vr+Wmwmf0yHQRtl?=
 =?us-ascii?Q?C75JQGBlyzBPwz2dMl0sBW9vrXnr+Ji601UNF20ZBHeAw6t2jUv+wEsx3tmZ?=
 =?us-ascii?Q?9N17Xq6rPr9yVoDyiAEe/LOyPBrEmWtBwYDRNtktwt1hDQm+giLv5BiKiffL?=
 =?us-ascii?Q?AceRDjAdVrc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Fhzt8aqVU9qINiMl0sXXGVWSEMOuqfZ7sJS6r8LKYCSXgi8FENy5aFUxXVF?=
 =?us-ascii?Q?MnxyN6Ki3WDRjliOBy1PI6eB2BCmAOlkJSbD31y3Z1TieFUmmWJsie+0mK+b?=
 =?us-ascii?Q?1j8nHlckN3LnhGuykkUDox5TBOwRDBk9zZ1vHPVEFbJi9baTzX9X3e9mpzn5?=
 =?us-ascii?Q?KvoFGoTNEWuNkenyDfk7iuN8oA1yXP1HyjxD12N7snUnEyf2xaN/2b8vvnXd?=
 =?us-ascii?Q?Tf+Olui08IVjfx7k2y0ChvA6kcmVT1k3SIjRZZzNWhW9iyn12l5BmnvPbjLr?=
 =?us-ascii?Q?eKOJsiL8ume9NRRz4M6f1x657M3q/fuIZ2i9grb0zqFGTKbDtlxwZIBoSHae?=
 =?us-ascii?Q?zG6AkTHktp+Bw5bnFdhKj54xy3yCZ0usexgJ7p3A13RlIdbFUFNgLGKUaIWo?=
 =?us-ascii?Q?nNJwdb1T7iwcKkxgHuKriMoavUoieB0IlG2T4VbzekviRJdAG9KTx9k7okm2?=
 =?us-ascii?Q?j0Uda22CYO2duilviULv818THG8/bll62CTrX2RWaj8S4/HlkCPEfp0GL7As?=
 =?us-ascii?Q?M0y6ZdZ7m+8xwhz6Z56HS3rg04/BGiOO20EHCJDZ/n1qARJCanopS4GyxoJw?=
 =?us-ascii?Q?17YAjNo1E7+Q8cHyj3mvSx/7yLMOWoVB0oBRbC+Q66/xRMdCseTRHzllv76j?=
 =?us-ascii?Q?Vu7D2eMAqmcXmwG8BbQQE+q+GKYK3vQFRDW0Lpy/W7tGSakl0mhzsOEFwSF1?=
 =?us-ascii?Q?WtrZL8gFyObYC8ZFRrYM/GNecwJyo84TqKOoIKXdY9GThISkWZ/8eHcnHjpx?=
 =?us-ascii?Q?zcT0B1/JhKNHCpTRr81RSw10c9ytidQGvCt8OAziz+MNXO6UJp/Q5Iuhyjb/?=
 =?us-ascii?Q?HfQL4VqkuA0+zby0IaviXp+x5TfI0oNqUvr82Q4xP1e7wosH/FvXNjgo9Wvh?=
 =?us-ascii?Q?KnaMBbVQe4L2NnCDKoQWipHXE0D+um54G75bu4Cgt/Lty7OWZM+gNbaGuapJ?=
 =?us-ascii?Q?sIhO9pKk3TE4U/P6EaVz9SRcMO/aMFmW2ZR51NvMeqMrcvjWSWvzhPSHsm8d?=
 =?us-ascii?Q?KqAUUbKrthRI6f/MX402iootc9+L2IZxNId4o+DddiA2SeWt5Y10cFafQBTK?=
 =?us-ascii?Q?Ey6PHo3/AYlUH1njw57xn2G/LnKyCLbqN3C8qMm3Aw6QOYfFg4SvRQv1xH6a?=
 =?us-ascii?Q?aHaXiiBB4ZPjdT66OxDmx5fq8YZBVzkdtQSo2Y9J49CmfxnmEOocXGKsZ6aP?=
 =?us-ascii?Q?1kbeYpzKnibFywg6TmsCSoR4zUnQi3K0c5fi9MRdkP5UAVlIjVlNF1Hy6mzn?=
 =?us-ascii?Q?XhClVcCT520T/hajthHGaIdTMkBiMPWTrH7a81IjJ1bgsIMI9EQ0VL2djSZX?=
 =?us-ascii?Q?Xe8midr9IvoK/bqSzMSjqaDtqv/9L4NNpGJr8Ugr+hmGckmEJ+f4tCG5Ekpn?=
 =?us-ascii?Q?S2p+4lCcBBJfaz90ZRVE4Wmiiht0ZGe25XRhW8jA5jwIKwIzPG3vXTf8jose?=
 =?us-ascii?Q?8TVEiACxRFNk3VYEVTcUpDY6D3nwXk4L8SmvFH+pw9Q/NLNSMIH7xfQB+rap?=
 =?us-ascii?Q?gNqFPyVax+NRNnhTM/RIlg+M2oDf0xmjhRH0dMP5mXLQ3zmd7TDVwrIjKEsW?=
 =?us-ascii?Q?LbElHDg902wm7O3uj2o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e32945-5acd-4784-656c-08ddceef1bb1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 22:27:31.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wR8gwjxuZ3rwe9sEr3QX767UgjwN5m9N+Mb8IpQuyziC6PoAYSvRj9zq9Ktn1s9o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810

On Thu, Jul 24, 2025 at 03:10:00PM -0700, Nicolin Chen wrote:
> Nicolin Chen (2):
>   iommu/arm-smmu-v3: Do not bother impl_ops if
>     IOMMU_VIOMMU_TYPE_ARM_SMMUV3
>   iommu/arm-smmu-v3: Replace vsmmu_size/type with get_viommu_size
> 
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 20 +++++++++----------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 14 +++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 +--
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 17 ++++++++++++++--
>  4 files changed, 39 insertions(+), 15 deletions(-)

Applied, thanks

Jason
