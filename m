Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545AC313527
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378443; cv=fail; b=g17vf90eFxqLPr2vN+lVKBqSsNo/z7y20U/kHgtvQ4/9D8Kt05Ay4ebYs00eIQptk0nv376T5yU83XEgqJwbCuCeBIze4qvPsvzEEZo+IuqCHf1SQDEIMBATTRqLEWdyqiZEu8d1fpIBSWuB4iH/moKuK9bbbzVPKfs0t50ACKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378443; c=relaxed/simple;
	bh=xV2a2SEvE457iN0KgWuAa9VO+rWkrAZoRnUZ1JBgpS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tdLQtstmHQsC6qkkRKFaV6J2TCe63jt0Jb7o31yp+O+A0HtdmPyR1P+3zVvewoyCzFlYX8wmnyemptD9Z1yrUxPgqT5Jt8iKMjVcpplhuUKJv6g4JUBTrtsrjfAoG7nIkDsoHUtk2po0JWHPpXh5eHFtvZuvmcKGf+AIlhv79FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BhOrog7+; arc=fail smtp.client-ip=52.101.61.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BhOrog7+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmu1rf44y8OhmJjpGJqMO5eqRnzf2jdI3PEpK8O+3CcC/O4Uj+SIEzzm7Omw7cNFmXbPAuGJpFoYwtvaKiwcaImlrhCcaWCHQzk8Ps02FeRcEhL55WhpHs6TZF57dnLKgetikZD4e6FcHG7QmzAFffeyYZb+KcDxFM2REj7O38BkfULONmfNGtLMXhDL0ntxyWzYQMYoK24afKWD2oMmoBwPqTCPYopfnLQrQ15yEYCcx4fa1PwLFjsHKIB8y0F388XnL9WBsATAw5TaJ51oDa0wRQV0EyYiqJQQJWQuI5uANDFT/UYERyncAdDMI73IjAhC5iGGnkxuRSnsCbXY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VV13yNtQeLh2dmtF4IroQ1rT7w9KLnewn9F200nTBc4=;
 b=JvMdaxT5cV6VLQm0QGzB5iK7d432x46l12UvFFsZNQ0RIKvDABrMaj8gzZVVcgYMx4tGtP5aSr9uSaEw5H8T6ahsbBnmrklX7bELaOQRwZ9VtS/g6uKV+5G0s3jfMnn7/fpvBwyhNl3kAiJgxyMRNH2nULrCLxRaGebokgJAtZgj9t+Krl0EorKnoqpCItEAZ0E+5Xu7qzB1ez7pj6EP0mdAj7tVAnrk7OuuB3mZyTgBUahrg6dieVsKlMCsZITIxCVieU2uCJMeezUFWCFJz8AR3xzB7JYFmgS1sWs6/zKZSF6NJreJIz+SLpwomtKzu3cDO63OWW/ogL4zNvk0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV13yNtQeLh2dmtF4IroQ1rT7w9KLnewn9F200nTBc4=;
 b=BhOrog7+CnRsjiUUgJZKgqfbZK/B2dMS4OVcAnghcKOcMq8s6tMK4Uq02QyeMN282v1PzgitNKIdArz89lGhTnKTgwbfsagDhq2zh9RopBjObeu15ykF6kuQG74dA4A5Rp7brJMYL/6KU4guMdzOmZ/hywgMsW2ph7OHf1RoFxQV0PaHWyZRVwMnxv6kWz3uQvBU4gcTIilvlplVv7RDInNn6j8BUWAAiqP8Fj6v2XxiejR/7fxryimhndT9zOlvChCggUC+SkEDSWtFSWbbA321DmlL4Oo2VkwZiUGEVAiS0Im3+nnjXpSmffqjf3QvP1i25bg9gpFEHxknkBXyVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 18:53:58 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 18:53:58 +0000
Date: Tue, 24 Mar 2026 15:53:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, praan@google.com, mmarrid@nvidia.com,
	kees@kernel.org, Alexander.Grest@microsoft.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, bbiber@nvidia.com,
	skaestle@nvidia.com
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Drain in-flight fault handlers
Message-ID: <20260324185356.GA67624@nvidia.com>
References: <20260307001723.964956-1-nicolinc@nvidia.com>
 <abLE3rdM9YAu81tq@willie-the-truck>
 <20260312142509.GA1586734@nvidia.com>
 <acKZ0wtfi5R_dHm0@willie-the-truck>
 <20260324141716.GB7340@nvidia.com>
 <acKhIh-s3pglUmEL@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acKhIh-s3pglUmEL@willie-the-truck>
X-ClientProxiedBy: BL1P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 2559e0f6-f225-4682-4a32-08de89d6b49b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Nxa0IX6q5H0ZHceA2pDrpf1ECV32VxqxP3+3I0EQcMCQRicniDaD9R/cN0O+89sYphMSAe3zdqOHiPCQgrEswU5xK3qQyEwAlqr1bGV0modtwdzKGn7zbr8NkV8UzPxTOfWiua8Ve7JMXPnLQduBsKUjsoqgsYid0dhCDtVTQMhKTkdx/NNeDorI6BHJlZrnPYOhU22ZArWi3CZ826ClkfeTPFbHGEfUNvxwcDRiQ1UdCmf+xpo5DjRWH7dVmVK447jt7nAK8RxWuot+unahB9U5ruN4a7quO65BiAKathccl0b46Cuis0hq53mryvD0/TUda79zwSQzL0cEJCdPI7qPDWBrPXmb49HKCKiCmBx1fe7YUsGCxcTWMVshmJkkfgvPLzvtlC14aT/5fuvHlkyIhWwJhkgRJCrgMSWuw0VuZYDP1ckrnH673UZJ7JV5t2e1yS6SZ5PTeV8lj9S0Hne0cEysoecKE26ATKzBi04r5Uo9xOkNAnprli11C3T8kTz2YpSmQeBPKlu1K+SZC/0b8Rx1SFR1TbqwgGHh0Dj6LpwE4QElo1DaeE2GiWe0cfGBGT/sabPZjh004EYUnN6wHndD+WlU9ZeqVgccy395hQYDxiKMyKOvWbDvgjSFIDdwkbfsSK3b2A8mM+YtPQfMNiaVqXgnQH+L4oGx4dBJdsFJnKX3hIJgRwQ43WzWg2LyqQw/AudO0fkHwnKeqFVBzZDT4mBbNc5CA4WNKfo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h1xPvd5oQ7fRW/87GQ1wyWcDDmMrJw5PoRNcWCewJZyl2qApouybHfdabZ7S?=
 =?us-ascii?Q?pVcuf0XLQk5f692fW/PA1TRzQ/ZhVmH1c3RkIsBldHl/GtV1jFmiCDqg7Oq2?=
 =?us-ascii?Q?JZIeMMHW29u5xHup5ycAH0JwchSpUa6foYuS2891Y6eoq9UoqHtHfxZNVn6G?=
 =?us-ascii?Q?jTsjQP3itX2hyBSJ0yusoxKQ5WjqhTB9CTesNevtEL4H/Iu2HGoSywtK9gcW?=
 =?us-ascii?Q?g6t7jIlYRpvonE9uxMkJqjbS1Hfgmbo9+VPdcFV74gKuS8pu//arw1KVqJIe?=
 =?us-ascii?Q?hLlOdNJPxEIbAlOoZ9VUyWIqA2FNh1PaiQZSmSSu/iye3eJmARCacnc0PrX4?=
 =?us-ascii?Q?/ugzz+MFimlqnpGUq2326BtFnJJT3l1VJ+yLg04Id8UY5KZSzCldmQzp9ABp?=
 =?us-ascii?Q?DmGgbqYyiR0P7jpE4uLILXGyVuEIWwWli6KIQaJHtWc4948odKO33SD5NDS3?=
 =?us-ascii?Q?kJtOr6cWbMogi+fquxEpVKVDr7SUU5+CkiiiYg7WT/Ti9VYCVOm2zQc7eTwU?=
 =?us-ascii?Q?lAwgFtfV2lOLSyXOBU5YbnHlPM4yv2yHv1pf9AxgouaZz3+57509z4AncV4z?=
 =?us-ascii?Q?yp2tY7iIHjvxNFtM7f+SIlRwVG9oEveec/l61l1OU8qlIeqHB7c6nrB6vNDn?=
 =?us-ascii?Q?gNWPHrfANtV+Ucclwdb9zUP0U/esGgbVmUB3TIc6K7Fw6SseLb00nQvsbTL7?=
 =?us-ascii?Q?oami+q9Qia6kSOBF2jTXK0qQgw57yL2Jruv+pycIcB6+xizlla19t9SaVd3m?=
 =?us-ascii?Q?lQE9uTydPAiKNXer8H9DSkzlZnF+0ahC7RSwAnYeW0AacjF+kjuVmFs0OA4Q?=
 =?us-ascii?Q?osybobinOJ7mWVzmfj32YicMCVpc6GgPmtq3WlDy7getqIU3zXq529sELFtO?=
 =?us-ascii?Q?geFHlJZW1arMC+tscRajVAXZVGHDt7ZNgHcGGy2d+HW5xYilNBJi8YU3GEAQ?=
 =?us-ascii?Q?BXMSZ+T4pwLX543D47uUhDVQGvsVjn7+sKazodDE+sigPDfKRg+uf/fFvayw?=
 =?us-ascii?Q?kgmb2IO+i79NUdFn6NOWunsbN34ODFHwvVfSKOnKm7qw+R/oHZRZZeq59nFH?=
 =?us-ascii?Q?lFlst2f8a+0deRokXaC8kW/z72Mzm1i5L2CyD4mL6Lay/Cs5VpPktlul5Ze9?=
 =?us-ascii?Q?xrlex+qveIIKR1wdulH7y+YQCQmn/dTTD0jK7isSnafX1wZRVOFd4x4xUexl?=
 =?us-ascii?Q?Pl3Aqsu3l3aLhH/TVdZJ8ta2WCYqxtc3wpovpJ4Ho+WSkkp+XjpyvkwxRjnO?=
 =?us-ascii?Q?hjGooUxMVtLgjzRAUycxdpyzAXV7J02JXucJyjz8mHTPZGytmIt4gBN94LSa?=
 =?us-ascii?Q?PdakhYTQRF5WsYwRVGSw/nEhXYIZjo+cilVICD7fbHMm3UGmdnyrMN3wweM5?=
 =?us-ascii?Q?GbBiUKfnZWOSIqfuhEmgytGHkqEyfODF5/ncutuNhhA5kgrOK2ahXwArPJtG?=
 =?us-ascii?Q?OBrQsXEcXJFK6dgeijHcsV5BP9Sk1ORTT2zQOzBNaAkoellC21eo2eQjI8X/?=
 =?us-ascii?Q?0r6fOnLeOel4I58CeBzk6iJRhWIw5G7ndCRpqvpGbzJbMTwNSM8FqoChB0+X?=
 =?us-ascii?Q?r0fKS20440BhvD8AMyz8QB0SVwwxTHs0b/j3XcNtKMOLeGtQ94qtRloV447c?=
 =?us-ascii?Q?tD0AFZPXQMkHWRaa0/M/1uyvdGAxbidXYu+sFn6AJDKtHP0JNm5VeyJi+tIS?=
 =?us-ascii?Q?N37z+Pv4v2yldXcVfexxWlSrdr3GABigMjmbzbjVyOM6Jkbr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2559e0f6-f225-4682-4a32-08de89d6b49b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 18:53:58.2865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsskIfXrl5Iwn4lH37ryp9yMuWHY61JWQvuzA4BVEs0YriBk5awRvGdgosvsMVyN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105

On Tue, Mar 24, 2026 at 02:35:14PM +0000, Will Deacon wrote:
> On Tue, Mar 24, 2026 at 11:17:16AM -0300, Jason Gunthorpe wrote:
> > On Tue, Mar 24, 2026 at 02:04:03PM +0000, Will Deacon wrote:
> > > Sorry, that was sloppy terminology on my part. I'm trying to reason about
> > > faults that are generated by accesses that were translated with the
> > > page-tables of the old domain being reported once we think we are using
> > > the new domain.
> > 
> > It doesn't matter.
> > 
> > If a concurrent fault is resolving on the old domain and it completes
> > after the STE is in the new domain the device will restart and if the
> > IOVA is still non-present it will refault. This is normal and fine.
> > 
> > If it is resolving on the new domain and the new domain has a present
> > PTE so the PRI is spurious then the fault handler should NOP it and
> > restart the device.
> 
> Hmm, I can see that working out if both domains expect faults, but if
> I'm switching to a domain without a handler 

iommu_report_device_fault() still handles the event and generates an
error ack.

> wouldn't I be better off draining the outstanding faults generated
> on the old domain first?  Otherwise, won't we see a bunch of noise
> from the eventq thread as it dumps unexpected events to the console?

Yes, it does look like since iommu_report_device_fault() handles it
but returns an error code we will get a print.

You'd need to double flush the the event queue. We always have to
flush after changing the group->domain since that is preventing a UAF

Then you'd have to flush before changing the group->domain to avoid
the prints if faulting is being disabled.

IDK, may not be worth worrying about or maybe we should just remove
the prints..

Jason
