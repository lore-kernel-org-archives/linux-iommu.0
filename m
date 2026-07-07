Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E7B33F390
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451616; cv=fail; b=BcSogEtDi/QGoooBGtnVnTKXg6dHw6vJYzsuqlm3n4Z7LYYaQRuwo6n5oqebqqDeyFQKzuNn/tQuf/wcvp9BGEUUBt/fAYG4Vw6YkdoSTz8oRXSPN/Z8eodLXa46JjC7y5Lc5RHhWoTGOMAwAwboHzUNk51eQ7vEKPfWiLnvvhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451616; c=relaxed/simple;
	bh=D+jT5gJOLpS2aZ04DCHweaWmvZIGbo0m1+bjHvvQ5nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SL799VdSLexcSRzFVH/9VwJ7zaOmH7+H3p1F8A0O3dU2Ykjk0C9BFAUHVzRDbT5xeXKI/8lv8z6fJ8Fm0w6hWCr/2IHxODMnLP+V23FTsBo38k1f1xMyjJWznBBiP8FMyB/eD4D0w+V7aBu0/HJpcIXZrdXC7T76sTi2nfg2Exs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P8EMH6mk; arc=fail smtp.client-ip=40.107.208.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P8EMH6mk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdnKLBVqHoPF8lz+zx9ACVeicuaTAczjyRwbwBkVtwf/OKeZsinCN++eGOCMiaqDUcdFryjCTDKLulpfwqauRyb2n1+AcdPjACG5ONRGQPsSx2X5+Q+SASjFNYTaM4sOIjGvm1oILSV3MSrEcOloo4TVzNA/tqVMFL02gj3FBO+dVm+TNAxn6hzB4sF9GPHb9GA6/y6yTUD3OtOyoGyY0XQm9k2gjLnVTZsAdB0IfJvGUSTQCSOc8Rnplfji8Rs03gmcvLrJ9jKm67hJk9jvF9WYPucLcfAvwdxQ9o+KfERJf7AQjM1G0mB9oDV7gVjQh0dN/kJyD1/8CbLv2Ao5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLN2+iqI8a18whHAVtRGGtjtyQ+A2YyciR07zGmuPEg=;
 b=d1c1AbUXD2SfDjyGv5ZKQbnMtPEZUGcleyBMCLaLrLlD9i7cKmqM3OnaUAmuvPo4Fb+6Sa9RzVftuU7P1us1plmI9nxdCefHubgmfK9UKQpaC2jtcNEDqvAnb4v+t1ES3Pb9lQdrVh3iF01pVXVwt7NYIIZv6kjVEpRTY++Mb5dyzuIi6Zvb6rWDHpdGfBLREJ6blvLRRp8DC2hNbVfCwenQoCeUTDPsjyljGEnJOz5l1G4ciibKgE0US3zctw9iZUfr1Q0McesmwHrfn+wOziOr4COmPWDN40/ual0RIgCoL2eOOOdNjvNuXwx8qwwtyA1Ekwp97LU7oWlIJ5FB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLN2+iqI8a18whHAVtRGGtjtyQ+A2YyciR07zGmuPEg=;
 b=P8EMH6mkPm3vz8hnbEPquKGtLs7gO6IOlLF5z+NF9qKuNrbqR/sIqPyAEYYr7Lhy9DQx81PRAo/ww9w45Dl9He7Oa1unoANE6uBwQAN5/F7ZWAfmRiFLFDiJULO1IJXLlPdJERe2RQEQv6OtDZQUZCgQsj9U6E+JkNchywf3MUkqOZ8jQDHyCHpzN4zz7jJqs7JOXmKh+JVR1oKWljuTn+QeIbD6jfqGtzh5h33bdFeQ/ijtbfQxW4HFDJMRcup1cq++GN/L9oHqYCp9U9S6H2pdaBWvIOXbge2QSW20V1e49kLnUYXBz96jgR8/MBqLIVU8kDB2yUemkSHNHe604g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 19:13:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 19:13:30 +0000
Date: Tue, 7 Jul 2026 16:13:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v2 3/8] iommu/arm-smmu-v3: Optimize range invalidation
 for latency
Message-ID: <20260707191329.GC226829@nvidia.com>
References: <0-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>
 <3-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>
 <akyqH7f5h42wru8a@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akyqH7f5h42wru8a@nvidia.com>
X-ClientProxiedBy: BL1P221CA0043.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 12897d11-7dda-42f1-8fa1-08dedc5bd494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	YyQ+nntvTQ8NUFSVJOjSbBN9cZecrFWiopnKmpWXhejErFoToN63Vpwd2vNdAM96y2xe89zgR4nDo1bsFRRRVpVR4TF3Wd/pJZaVvUabZReLJCuJAWcs71Y3Q1WlyInIicV25Wbir/3qZiO0YCc5FJiGt8JImKCwQF4JwF06bKDuNFAyZXD7txaaFczgj5yxAyMntY3Oi8+pnqZSrrPUhlFpMTdWYXm38QrfDJrxLciebBR2u4CJ5zxThPXAhjNlaHAk9e12swAsK/GeoFXf6C1n8HQZfZm01hYmFpyryXzIG96ZkuwEHdEDqzKXriwPpmw/jGx72K6xsWbDQwDCtUN8VGii0dLuGxdpHX7XHGOPCiu/YUTkCnn9RM+UR+nBINP8h69clZ6+5yOdQGv92ySB7rtVx4koUI7ysrkYWp/Jh8w079s1neUgDcOl11IHVBWm887ZkFIbKXqYKHEfLMg/EVgukn2QG/0v2yQSvKKZ66fsCWBskXhv8VCsGW8TLRFewMxGDSjIJ5vPRQEjxqB+O+TkJbcfBPGenNLYHY/bxL5UF0fEBv8krYo6mu17b7Awg86crao2AEoPrg1/+p+GbzaJOYwZwkmEnzoTaxLnYvQwn0OWEbwR7wfsTz1rJl84GsoORHKWOnzKepCcfw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RTwisD47tdyQLq7DouVHEuGolUTAI5oyl1zsGrqSzWjrBirCrgnH8ALIuggi?=
 =?us-ascii?Q?nlC6gPs7pX8fi7DPILpTU6DjCQGqoGR+6d1GKrM3BZW+2CfjHlidIAGa8VGW?=
 =?us-ascii?Q?Cv/GmSlCT7taS5ylV1SiF0bfiEeUscaW/7dTJhROJQP+XNBXbSMkTl66AmBV?=
 =?us-ascii?Q?G9QM5m1+hYg1i0KgvKF0ppEwuz+GJugmLOpm8aZl3JGlWB/C2vmCQNoBJ+qN?=
 =?us-ascii?Q?xuzONmA9eyhR0sVkCMO9ZWtw0jRTzVPqJxQS7MUj/BgH23Y8Oa96XM5YryU8?=
 =?us-ascii?Q?zd/hgXTzSNnYYhfhCnksSxqnVpYQniKT0XEhfPg+C+G+58BaGErLL0rNT0t1?=
 =?us-ascii?Q?Fj14cghLbyU3xsJ/xwInfsVpvYozZHNJ6bmqgZGBdf+bAIxbVos/8EsXroWJ?=
 =?us-ascii?Q?1rNk+Ne1kzcIig2mFHh3c71aGVqKNelcE2oLX0Kc8V2GzIptdj0+hE8hQHBi?=
 =?us-ascii?Q?sNGHBUdSfyps/7BPa9QsPIQjVBSkhfDX/nA5k+eXRCKIyHTUcHZuRgpSMcTn?=
 =?us-ascii?Q?eitbtDw2W+xA5VRY5OYsciiAm9DvUlD6LOBbiGcbeSxgK2e1xEu7qMFunKQs?=
 =?us-ascii?Q?aTGUHz/CCzxWrhn1EQ3O+XTStrV6EyXhgoEvDjp20A6+s0BT7Uiy0rK600gq?=
 =?us-ascii?Q?93D1Q7D7RKeRnOaAIlxgSlzXSwLXVCr9XeqW9EoiZ2beBLq8VK5W2d2nqyqI?=
 =?us-ascii?Q?eJrdYyIzwjrXGGQWLiPBZsM9NtDJc5RX4AeNJ5/ERNQyjuwhht+eLOAuv38y?=
 =?us-ascii?Q?iIxsH7BhdVoMKB5ZRRgE1Jt72zIWo73LYmuVUROvaeqq698lOdZvUPjBi2UE?=
 =?us-ascii?Q?St3MrbZ8ghzuDKzPsdYosQOmth9ydu38YUGJdoRTWJJIWdBYo6zx+xDX2uiM?=
 =?us-ascii?Q?t0GbOiO85jzzp3LwR5Lkq7UJ7/sIiAyPv9TEn+DL3krXQwHVFpVB+lZzw0fe?=
 =?us-ascii?Q?4wLB2cl6s+rA+sHcXK+HoPLpzVhEMqXfoVbapWRHCFIcfiea93odoh9EqjdK?=
 =?us-ascii?Q?wMGABIkzvbV5sj/E31KTVlzbj7T0xA74x6iwtT5+hfHvC0zZ2OsymjWLu+EY?=
 =?us-ascii?Q?sfSo8mww2+PxBBVQCJJ2mL275e6TUFndtnNPAuP5T3cMikEjVucXvtWHNIQR?=
 =?us-ascii?Q?hzoOozal24gUQGHw0WmW87x2DNMzXTI/w76/yZDzMcyCibhyZogIiOs1Fqz3?=
 =?us-ascii?Q?t82a5iiofoHC1S8FVzR66XgSypQdKPi4ZGt9D+tnV9M3fFRM19aT64WGN4Ed?=
 =?us-ascii?Q?4zlSc4Y44azcyMi45ZzwDu/Xd3QHTJaH62CtP3fnlgNBNYvXVgDszFnNfeH0?=
 =?us-ascii?Q?Icv3lGmeek9772d73snFjNH5nMdTjEqp9oD2fGbh/y85P5rtYtuoDDFJRkhL?=
 =?us-ascii?Q?t2pjacNhkycO6czIZnpuO8DSyyztM/2Fk6NlYjfzThQNSjKlTNI+XxaHL9cF?=
 =?us-ascii?Q?2O1S8sqzBxBvsWplPLysFGLCmBetnFYkFNd2Y0rX4jmPPSCePuXApiF/xluZ?=
 =?us-ascii?Q?UazRmqC/H4gML618Hexp1aRTtumq74Jk3BWmzpEDnLcPWBYNWbtP0nyB97rh?=
 =?us-ascii?Q?sABDirJHMgrHT/wOjZ0fAuMGa1Qw5FIWCmcG6cxdwICfnNsIpakm6xZcc8qf?=
 =?us-ascii?Q?6iDTHTk4Ap7T4uFXV6u3K6KOUup2Zckq9ZApJmQuvMDfrETD3f4xPLdKu60V?=
 =?us-ascii?Q?vnyuQ1T4P006zNZc+oC9GA0RqmAQG2SwpZsyTk0aHcMvMiCG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12897d11-7dda-42f1-8fa1-08dedc5bd494
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 19:13:30.1698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hb3ldEqyzR9mEee/jo4zhE/Zg6FfKmhzYxaqLVqB0eD9JCpTdbyDg+UsNEwhpzIO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306

On Tue, Jul 07, 2026 at 12:27:00AM -0700, Nicolin Chen wrote:
> On Mon, Jul 06, 2026 at 01:26:40PM -0300, Jason Gunthorpe wrote:
> > +	/*
> > +	 * There are at most 5 possible values for NUM based on SCALE. The
> 
> Mind elaborating the "at most 5 possible values for NUM"?

Oh, I guess it is at most 6 since it is +1

How about:

	/*
	 * The spec defines the invalidated range as:
	 *   Range = ((NUM+1) * 2^SCALE) * Translation_Granule_Size
	 * NUM is 5 bits, so (NUM+1) covers 1..32 granules and SCALE scales
	 * that by a power of two. We must pick NUM and SCALE so the range
	 * covers num_tg granules, i.e. (NUM+1) * 2^SCALE >= num_tg with
	 * NUM+1 <= 32. That constrains SCALE to:
	 *    ceil(num_tg / 2^SCALE) <= 32
	 *    SCALE >= ceil(log2(num_tg / 32))
	 * Choosing the smallest such SCALE gives the finest granularity and
	 * thus the tightest (least over-covering) range, and equivalently the
	 * largest NUM.
	 *
	 * Unlike other IOMMUs the spec has no alignment requirement on the
	 * address beyond alignment to tg (so long as TTL=0).
	 */

Jason
