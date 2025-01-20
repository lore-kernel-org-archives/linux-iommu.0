Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC231DF989
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737391321; cv=fail; b=pDAhcIxFTX59PAHls6TAkG0i3iKRuGWSiScNSfqpF6Wcmqn1tLsuA0ns9gy+1tqVqXmu1GZIEkNTcmcn6gIoCgjJnIH5fkdRPEGMvyvkRWq2u7vfd4yiZMPKW99quD/+gRecDkYRMiElzFxsB8QbZtLGfpFsDD58eFw0tugJ3Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737391321; c=relaxed/simple;
	bh=K1CAXPIuKXOsnrJ/UujFrw59JDRSrCSTdPMXglXSRlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UcU6cjr9efILIfaTrgPeGvLF28cJu/6I4420gAs/QhEP8ajhFXA1dFXklPgtbnCEz6LoCfxK0ZY9QNJoPhBAsG4Z/F4f7fv8cimw2kOHDhFocskOKznSxYCjdU62dNavkSt2EeDgU9u6EEwzovamgTyPDitWstc7rSROGwOA4Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VBOkMqp6; arc=fail smtp.client-ip=40.107.96.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VBOkMqp6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1BLy55SZM+jWrnQBc+5a12Tw0xYrDWLHZuxQK5aoF4QA6X2W5kSD4T9kLfT9BIQNN36qYhujNrebNEXkoNSR4Eqm73th4LTE6cbkaYOH97+7Up+PXpqYpePN8Iw0vCrezF1Na252Z5UXcYDVF5pvmZJEQbz8vWIf37CMaCd8QxnXWFqwO3pym/tZHjtOLwRL2NrJ0xpeEL72J9orDr/P3ypm02bnflRND1gURC55OtQgUh72WA4EY5BtGGwaWBMsci8WRPmyQXZHcBI6+u08XczaSx/95jXRWe3ZPjCqje/0nPbe9HuAGsNhOVoG6duWxJJ2iTAE5fcBtpJfVMp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QH7YkNu3O0v1RjzO5kbEpcFlA5Zlgdc0qh0w3p5l/fk=;
 b=WP6bjYvstnn//7xdPKtX5roIKuTABQGi25VDtLcN9QmyJziPDi9quTbIUoLuR+ks/MSKu4JEc2OJtjPaVcvKAyIDGXxhJZ3Q0GmzIHHzkCzM4op8WtYOTS4KYmn2e5PFdLVy3irAJYBR/BpER210OOc2E/sNmNfjfnuNdfQyOmJAEBYZXckTruHrBBYjPZkFYxK63ZCyPBPJ+/SiCgTyIztiBdBT0JCCkOMC3k6WkSHCIo8FWZ4DYPjbO0n/qhueQUrnOdvngxzbAKQBEgXtflhFU5p6QWwFWdM7K1VD6L2lkTFiM5m7IPOuBW/areLi6RvFzQDRlKedaN6pLMgURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QH7YkNu3O0v1RjzO5kbEpcFlA5Zlgdc0qh0w3p5l/fk=;
 b=VBOkMqp6lkT1psNZb3DLEkVzEpD9Ds4Ci/lvmh+OZPGEw2xFoapdBDqbD9Cwjgwa7vVwJRgUmJQ/iNe6LVHNn0b38tlFPkD2RfzQf99BUAvTOOTDt20CkBq2WxOHM1k5NwzkTFfK/FwyDFHiuBCUP95rvwCuW1uyHXO0tzOUV2EFdY8NTtA8xo0RYS6P6ITJ6cK09iq1AXCC6WnqoiP+vQPUJH0EBqKTWPQ8lx79kpVAk5gfR5BdctwCLhpJntym5Px/OJndlXtE9lAM7mKgK17phoIshHnyfI/vDWmFTisa9lIr0cdN/gY6Qx6IxN+hJP6cw2gkFMaIljsNfWb6ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 16:41:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Mon, 20 Jan 2025
 16:41:54 +0000
Date: Mon, 20 Jan 2025 12:41:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc v4] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Message-ID: <20250120164152.GM5556@nvidia.com>
References: <20250117192901.79491-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117192901.79491-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BN0PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:408:ea::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: f88280a3-719b-4ba7-6a1e-08dd397158bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8WC9IDpIr+kYo+L2JOiB6UFrt4bK8KI/TNqJ7tIDljmRvg8hwU/wRyc/0g0D?=
 =?us-ascii?Q?8n00L4jfvtEy+yeZKQLUiVIQWeknZs4xWD6MScnvRkO7za2A3DOb7gb4nL8d?=
 =?us-ascii?Q?GwDyRGX1yqbFTLUfjrX8JxEpfEgEVLvRvQWA7sPGxZBZr8obCCqziGXtGYjj?=
 =?us-ascii?Q?jgqQPwPtjRDJwDhTE/CoHpIvKnM23N8b/9uBVWbZDn+EX1aDI+MolsgubHCA?=
 =?us-ascii?Q?p+JiBcDmJ4jqEIfGNu4A1F/OT9P5lpLoGMsmEh+rt/zjaPz9l1Ooul5jeVWR?=
 =?us-ascii?Q?b31JPGy31pIA8YOMOelpi1OLZ8Q/giEA9K1IvfvLWYYJzxHbUbIvVW8cg8gr?=
 =?us-ascii?Q?C8r+j8Pd2JUFkxSqXEL1Cibf0SXLM0L7pNrECeyAM3+/hBHiY9wNqLrCx8yR?=
 =?us-ascii?Q?Ik1f2u66Z2VkpMbYptgsPag7QJjKGThckUNMXZ9cgLSLB/nMECCR2ke7dl4K?=
 =?us-ascii?Q?B9AlHGzpXt31JQR02oD2AWjrgIzcFljKveT+SQZRy3s0l55aHFlqw50dERJ2?=
 =?us-ascii?Q?29m/xBVHqCk1N3yzhYxjjXn3mb8Kiahv2eaaF+Me0dyo7mNBWiza1Ur2fEWG?=
 =?us-ascii?Q?K+zwL7q8hNO3Zc7S5jcKebXLzveZqbWl0WJp4WpJOTo8rKdIfyd8ds57x13D?=
 =?us-ascii?Q?7kDAQKyhKLCyOqCwkcAL9BYQlGrOdxFWAVkqcbdS+EWCrNt78iSlZ4NR8dXH?=
 =?us-ascii?Q?pmkK7zBS0kkY4j8ToFtWZuh28I3I3ZFikgwSJhh12ZXxPvjLkwEdONIsY5jY?=
 =?us-ascii?Q?0bgy7wSevXPU/iMIbV/gITmaBBtNIbi4IhRMdRKgPzpa4RyLK1YdkBHbmxla?=
 =?us-ascii?Q?aaRErHBmDSfygxHl7JD2CNUPdk6GsuKeANWOG0H4ULCJQZrnnGeqIPt+nm9g?=
 =?us-ascii?Q?YxTiR7hocK7srEJhnZGGN85HMG+cSzw+TPmtsAZ94+rf8rKDxT0FxNKZpVpm?=
 =?us-ascii?Q?rqJH1l/NYk1e0/a7hxIja/xU1uk1I9hG31MS9res/Jr4SenXYcw1Wf0sDXAL?=
 =?us-ascii?Q?duWPrEC2GVcZ6OPbEWAWW3kq6CkoF3xWI4UHN73pTj2vibq9O5VoQt+SmkTO?=
 =?us-ascii?Q?l98zAzVVQ89EIlAe3QCHf1HuPXYcG4o+Dq8obb/I9D6TEU/kZRij08J8Ro1Y?=
 =?us-ascii?Q?g0tZhmIwLFPv3J4YY+AXqaL2aDyeyCzZVtnw7ld+Nx6PrF29/fKIhu8Tzinc?=
 =?us-ascii?Q?0eO1wRXbKCncTh0/sRXT2rKKTdQg5cTtR9zurOfQvAlcMkPS0ln0ao9s2o1A?=
 =?us-ascii?Q?vh1OEpyX6RQPjHfCC8W8qW1iWJA96xdydUeHajCCG2hcqGj6GrOVF0uOcuBB?=
 =?us-ascii?Q?3mbukrbxeWNnCh1/54R/ny3MaM1lcqi3hTnNnOTL2RlDWZpw0H/XEjebDzFi?=
 =?us-ascii?Q?7EXfAcZUldjL9wzgrvUExelk7hst?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W0ha5tVnYpODoc08+s4Zgk1Lr4qCfrtBqEFJ21kGBhcXBHppHr2sN/ofqjCq?=
 =?us-ascii?Q?PnSPgon8tGPVrYJpVpdaDb6Lo+Hb2uHwDlS0g4w/VLzftapNncPAc7RC2ahc?=
 =?us-ascii?Q?wFfgo+Hm6ZBr7Mn+EOqdUtmVlVhkVXo+cg93zKc/IUcWytQWEml5mAFlUymx?=
 =?us-ascii?Q?1c8ozbG+HB4DuUGaQEM/H5RV6XRxQu6hTWoavWubE9SWx2wxntVi5Ks/J+fU?=
 =?us-ascii?Q?bRzMAlHBU9JfZFtu3UZbz/qbNiEmdKo32FQRaj0r4f8ieKnqwQT3jqiOveUJ?=
 =?us-ascii?Q?A4nciLLxh9rlOsf1E+w0OnIHocO2s387rUXAigHu1Kusw7iZZjkVnH4K+ut/?=
 =?us-ascii?Q?yLloM8TKiZzR2Poa17L7iJozFjAic6AAwKGiY3yQr7AwxhRw3VAGji7xOaYW?=
 =?us-ascii?Q?Jd4B6mtOZ4uwGmka0Kocwbw+be+WjuYUU3BVogcz/Dp/OTzOC2upLTYDFVPX?=
 =?us-ascii?Q?08RJ1fzkzflRTlDjvaYwz3lJSHfb0KjMZFjM8m7tAISjt+ik0mRJhqrbOA8Q?=
 =?us-ascii?Q?A63mPr1uSlnrQgyiLsNyTnP3jpWsD9Cc4C1ndnSp3iq+0vPwPoS/76L2TrRV?=
 =?us-ascii?Q?YjKr8WeB0AJ/t94a3Iy8qOLGx7BnRecJIS/W+sfX18Wasea3MI2vP9kuMajr?=
 =?us-ascii?Q?fP6VcFQ/uscY+nx9iHyYsxEW1+s0w5a11drLKjNDCgyCU7olTfKTswMlfY68?=
 =?us-ascii?Q?l8ugUbashq9hajcdkdPLXrmu0USWyHgrXr8Vkqrf150dkqyDMJGMCb7/skBT?=
 =?us-ascii?Q?17ZpJTYupV3jGOL1EEyg1gPhiwnTXJ2mOcmbz/pgk9DFnYVSJOoCS4SBN1iI?=
 =?us-ascii?Q?rlZtx6tFksTG2rrelxSN6tY5tTk6gQ+yMxIAUxdwK8pn52tebHC4ycfhuEV9?=
 =?us-ascii?Q?WlAkSZKVPDv6yjWzZwL+Qa3V/VYCpA4ibWLFa5+J+5+AMksI1WyYpxaeJJDi?=
 =?us-ascii?Q?uUosZI1sL1r19m9UL4HEX0ammlu7wuNmDYSEsUwKU91S25DiE+DHytWeaLwC?=
 =?us-ascii?Q?J6zsQ1F/Lwcdd7LAdQ/hC4jVRPdyYAuy0sPuHMV3hOAhmykifgdirmthv3cT?=
 =?us-ascii?Q?X+w2havTUnsXq5fIezW6/gKt5Yq2C+Qp3jZxHEJkRkohA2HrmV7+Bgwuab0g?=
 =?us-ascii?Q?FDKYTZRV/u3ZxWGAImvYovzXJd6FimbElhxC7iEr2Ow97T9yKLGaqSngKTqU?=
 =?us-ascii?Q?p2GkMWvnYYAI6AgoYVhLGusO7N/jmfgXRKTNP4iPfn4ypvpdnDVwR/Uou4QL?=
 =?us-ascii?Q?M1n8T0mcgTPz+gZqOnCddoR7SH12nnCkBuO74rnrsoXJt/NMdnS+yZYNttC4?=
 =?us-ascii?Q?yVObfHjGUvLRtNF2vgqfnd49woOPEYjxp+2s93WwQWzIxdXFAqPDsrwsY9JW?=
 =?us-ascii?Q?4dc8d1rAc0Ks1McbKSJI9qmX0beJejjeeUjDsW9IOXC0a0I1NDVQ+q73PC2/?=
 =?us-ascii?Q?qabl9ofqa4hQhVp+A+QJ9+uf0uNjDqo4KKPhaEgwFOxDF0oYv16mFiKli4WK?=
 =?us-ascii?Q?crOGcSsP1XBa/8WMTDw/hfXSDg8qohi2OWHeM3LiAyeFxnM9Ntvajnar5irI?=
 =?us-ascii?Q?DQTbr2Fif+kVHeTFUEDVkLzWonpJD/o+o3ttdcNY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88280a3-719b-4ba7-6a1e-08dd397158bf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 16:41:54.1077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzNtK8dCgxnJ0n1rT9I0b+6qMEEu8VjIUU5Ja6ghl2KIG8o6kTus0c2VmiNTUjeX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196

On Fri, Jan 17, 2025 at 11:29:01AM -0800, Nicolin Chen wrote:
> The fault->mutex was to serialize the fault read()/write() fops and the
> iommufd_fault_auto_response_faults(), mainly for fault->response. Also,
> it was conveniently used to fence the fault->deliver in poll() fop and
> iommufd_fault_iopf_handler().
> 
> However, copy_from/to_user() may sleep if pagefaults are enabled. Thus,
> they could take a long time to wait for user pages to swap in, blocking
> iommufd_fault_iopf_handler() and its caller that is typically a shared
> IRQ handler of an IOMMU driver, resulting in a potential global DOS.
> 
> Instead of reusing the mutex to protect the fault->deliver list, add a
> separate spinlock to do the job, so iommufd_fault_iopf_handler() would
> no longer be blocked by copy_from/to_user().
> 
> Add a free_list in iommufd_auto_response_faults(), so the spinlock can
> simply fence a fast list_for_each_entry_safe routine.
> 
> Provide two deliver list helpers for iommufd_fault_fops_read() to use:
>  - Fetch the first iopf_group out of the fault->deliver list
>  - Restore an iopf_group back to the head of the fault->deliver list
> 
> Lastly, move the mutex closer to the response in the fault structure,
> and update its kdoc accordingly.
> 
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---

Applied

Thanks,
Jason
