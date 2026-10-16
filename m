Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE42877DE
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164235; cv=fail; b=XTseMv4Z9Tf889GI3UHqxY5c8w8lGZRBdbFWr0GLbXlwC0PBjnFpV/DmPNEayK6m9Wwrh5lZXcRvv9TFp/zdBNDYPZ7/YN+bGASBN0teLnUcy9xWB1tD+Wjmz3ofzSys7TfcIDWvjM5766OEc8JqtbI7w6IuGkElCdQdmqmcIr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164235; c=relaxed/simple;
	bh=y4lFu/jKO4sKnhkle5aWNEg5IJ4s/HdOn1qHTKIj5MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i1mUhRi2i0pS/vcsdf/ZJfjBaeXgLJcbTx4ebpBOtAurtxVlP+gA8X59w2r7jSwTEcRsNXT8qeNi0h063wBo3Tm7nM/jFS7MQXEnqCFk3uDSwoMRo1p4u/gSQBJ6JuQBcR5CMMmZzsc3KHncM/d96oPnqDKpelxQw6/sCaZoUCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TMIO8pWa; arc=fail smtp.client-ip=52.101.46.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TMIO8pWa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=he9RUR3FSCG6Buk3HKBEHKxtyLXB7QDWHIeZFNx+d9T4/TOAuE0KvwR/IJw8/3mU+9bb8qyMVWEqtQuS4QlMX28vbi9LdPgD9jWJFsakSxnHeZ0qxlM7Js001klvC6pv39BEfsVeoJJDmivJfAhlln3OMRo1KnJvSb+o1cc3oaRgj0o0o3MBBtl3+lncWfSsYoiAIEWQNTQkpNb54WSlwRsc7gWX+/u/2b1VipbqPhql2TSUcdOGm391JX8osrdbVFEKTJhJx/hAKwONJfVRKGPdoWBwHlOZT5MfZb28unkUjxqOJYS2l9wxT+uc9JKZ7qrfC0LMnWJbpBySuGBYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc1hOto8i2gw52XDO1vJBtLotiKpdpZEJ1aifxBCFdU=;
 b=Oa4PVH68EYTcdnS+pN5kl9swBGs03I9fy4Y3IyWJoH8vjqGLhWYU0mN6BQZ33KGRh0A5vA4Us3HaCb5KIz8QOc6rFCtfqqY5kOIrQZTWnInBxg0gxqiD0bx7y2SzksxNBQ0fkIWzdZz6psUu4eUAykvRa3a265PAmls8PbdQGzfRffPoP4XLz5XL+vZE+O77Oa4LoX9kAyHvmtfB2Xxft0euSFUgfcnEdOxpO9lKR/hbtTsUr8WXS3VApUAsFqXW9icWVoWligx657bMrvZF6lqnD8lHiAMfpKOlGHD2rncItGFROxblZZalFay0YnFfRKD5o0hxF6csiYCYICJwaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc1hOto8i2gw52XDO1vJBtLotiKpdpZEJ1aifxBCFdU=;
 b=TMIO8pWaWC8ICeoLqKFEnkf6Cku1BKOwdslozdoflXvUPKSdzQOoUSnQwZ0lapZDahPJYPkmlFcBk8o+bj06o6eD9NOqA03GNFVwvBm5V3wLPo50l/8dsClyLm1uKt7ooQvh5MsTTDUiug/2PrKgyutE0cT8E6+zZrJtlvwOHnWD3l+kAFYHnmUvnkdXTjKqMrdj80uPjtgYDL2YA4k3YclQgrOzVZWlba9ARbmcMI5rXcJr9yrJ4Kt0udY1jVBRcXJfywe0LRGwkXlgkLc4iJKyKeC22qJrFzO9XU74Nvz1PuSDNx1CZuKxhEHcPZQi3TgUjT0NnU7zucOP4wmWIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by MW4PR12MB7214.namprd12.prod.outlook.com
 (2603:10b6:303:229::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 15:23:45 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 15:23:45 +0000
Date: Fri, 16 Oct 2026 12:23:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: fangyu.yu@linux.alibaba.com
Cc: Ankit.Soni@amd.com, guoren@kernel.org, iommu@lists.linux.dev,
	joerg.roedel@amd.com, joro@8bytes.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	vasant.hegde@amd.com, will@kernel.org
Subject: Re: [PATCH] iommupt/kunit: Read an exact NR_SECONDARY_PAGETABLE
 snapshot for the leak check
Message-ID: <20261016152343.GH13920@nvidia.com>
References: <20261015134048.GB13920@nvidia.com>
 <20261016011229.71498-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016011229.71498-1-fangyu.yu@linux.alibaba.com>
X-ClientProxiedBy: BLAP220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::14) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|MW4PR12MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: b673307b-d74f-40d1-db38-08df2b9977cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|11063799006|4143699003|261009223027099003|22082099003|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	pI34pvUrMBXhjwZ3zTpDuL83NfepET3yM3GK9McLmGKiGxVNy1AiQ0bhC8ANlRGNNPPMaqR7jRP/WF/hJavLvKROVKgrjfubP9zgknKw3ZqtYef6pJ6W0eU/6EhWqQ2PyeXhewAm0rLlEbtNMkkimOtymqLZUoGjsQ1R7TLEGR06mTniME6b+AqP2PUmFNsM1OpQkJaqigTJn3FAyjz5D0+JgUwCrCGp/LkiXpJMx4Uc+Jh7gexRfhiCsqXLVOvWGAMIppqjJ96xXq5GippenkRODEanRmf94aBwgUQIQLSTLRrZ/YZy5PA56yLu2C2sF6qibihzlrTf3ucWfdzwln83hb8gq9/wgaacyc2KdUYEpuiKINu0vIprv6exLxUszye2ORFhO9OlELCaJBkteChfzpndTbY+ZeusEhkqObX6aRynF9f68qGMsUEmhK7Fgvb/T8Wlatq21LZmC4MT3xEXknAh6nPYp7leZIuZw0CIZqXcFjuKVqiJcjru6U2RTwFtvKTbheiemevgZvz4+NDfaC8pUjJ234NCPIBWIIbbz8W6yDn/TbfyMqqeSdk+zuWoJBWK2udNfgwwsFgVDaC/qLZElYfBFmXc9ObNveqYt2DFX77mPGTxJHScBzVtsT3+i98jGH5LctWOW4sYdnn3VVkdwe0oCJJRdGMvW2A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(11063799006)(4143699003)(261009223027099003)(22082099003)(18002099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ShlQ7o4H8YsMwhF6bt0rB15Y/0Rj7oyKuZ11iSBk3+eVgo/YNarsOSTAYhix?=
 =?us-ascii?Q?gFfcxXh4N54TxT71gxFrd7IFBV9SIPzCYAYg8/M1bSGUIG11EJh/7IVvfRct?=
 =?us-ascii?Q?LCW1IEUnyGCYuaKPP+IWwVD8zi8mc8BjZHx3UY7WbtRaXsL8sEpA1PcpQWvA?=
 =?us-ascii?Q?yzvahwcIFvghFMY5+VGmHyiJ6jWAR+HstO0/BBHh4547021Webu3JELHQcHt?=
 =?us-ascii?Q?WQpMO/ynVES/qxUDzFyBo4Fuw0qkHU/elthBEobcurOPYBssdfreVbWL6M5a?=
 =?us-ascii?Q?NFZG/Z11YrO3oxf72UH7CZi8u/QAvBP/iilYSgZm9M0pH0a60FJH0HZspLPO?=
 =?us-ascii?Q?u2rf/f2BdD906yFDC3ni9vBk0UMC8IiQ5WEwj8/A2jvWo3Od7lK+HgwqU5Te?=
 =?us-ascii?Q?g3adM/G4Tee3//0a1Vp2FDu+qXcKawcoyBzbWHRvaiAEro9jBiWUB35aCiEP?=
 =?us-ascii?Q?0gQjSbQKAgHp6eUX27BFd2ZWVuSJgQs9Ds4iprvxw6d0fb6+xHxIHpQaMXkZ?=
 =?us-ascii?Q?L3WFxHckKs8UrSTUpLpJbwIv42cLJ/bZU14pAM8kEROlpKgojCadTglwEcOc?=
 =?us-ascii?Q?N+qoY06d72B9Ntw8s0AXnuHm04NxkOI/IKzfP6/zpH5bH/YyPi0kENC7Fjxv?=
 =?us-ascii?Q?3bdgPw+RpdP1WsQiDhXKK+2ooL4wT2mqRU/x/vqHCNyDDiTmMoj06xEUvJ1I?=
 =?us-ascii?Q?7o6AfJe0TyHyBExUkv32BBjIFCcA5E9WYEkc9pt1Z721W6BldKki5wDcaJcm?=
 =?us-ascii?Q?kkwhzuQdBljsyF5ZIG56SN0Ucjs7nDHg+YmwCwsaPStwzsXwsX2S4PDCTw5p?=
 =?us-ascii?Q?LvX2dSvhR9qVXqgp/4JLpzPu2QG96jT+qqsM7Q0RbvzrD1MleJ/c1UBaMvCJ?=
 =?us-ascii?Q?R7kIeCYXbJR/TY4MQo3XTpvwNEvqN4UUad969LXzbLQkbxzanZoMwVPB7Gc+?=
 =?us-ascii?Q?TmpohuSXku10Wa5pUfVtnsiF9K4+40V43QEglGQ2UF1H+ZCKn1QwD8qPSanx?=
 =?us-ascii?Q?F/N3ifnF7cVTJe3PwS05WPlEBa55K9N77mh1IwGsHMyFKTCfUq73D8Jg2kAR?=
 =?us-ascii?Q?5yKzlXgS2QJiYQl/53QGWkTca6Phl7bTrG8EYt+LD3N7b/axBDICkuf7pmVo?=
 =?us-ascii?Q?BTqzSl9Bn5zUwxx3vzpifPud8CwIYDkNlb19NL+o2qiyRiww9G2eQdsRney/?=
 =?us-ascii?Q?p3ENNAjsKvbpeguV6Myr1kk4GW0fLRkLS8QJHcYAv3X2ZJthiz3acZ9B5Siu?=
 =?us-ascii?Q?U+5XBt2Q9e3fq0ICiYpU6qpuu34fdhadov7mf2z28cZe1Et75xyI/MpapAZn?=
 =?us-ascii?Q?iJk0hSkhLZirw8CiB0268pAQO2TAhbcQmUsjB5y/oj0EQWTMCQzCCmQdoG01?=
 =?us-ascii?Q?w7Vw6UKyXpOpB8FpZHJWAMOw90Inda/AgKveFGY808JqjMEneIdclDmuM2k/?=
 =?us-ascii?Q?EvA/y6xT907KncNujvfA188wi0cErrR7PYnTPcEnyv70nE6Y90X9JEFmwxMe?=
 =?us-ascii?Q?kGu+E7g/nAxj5gKqm2OIZ+FFcEwFvqBBDYb7FSMvK25vc/UZyiubkEmPRcP+?=
 =?us-ascii?Q?oLgsFNWw7n6HMFveTKgWF3blRhBUZDxH/AfvHFIsT+R4Uhopdhpk3PurEO4j?=
 =?us-ascii?Q?cxow1U4168JzqVKPXRHO+0ufi7iIwHayWfKnEA0W9lRb/UaIDnQShtOdLjF9?=
 =?us-ascii?Q?KhpdRUgLk+FeyQ2z1Isvn2pNUL0mdFqk6WyHbaUxP3yLHuFx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b673307b-d74f-40d1-db38-08df2b9977cf
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 15:23:45.1125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLS7gFJQTjbggMPldJinm2zvKVHcajogmGpnYmvzzY3Ej/DWyGyj3lng+x9Hg1Ar
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214

On Fri, Oct 16, 2026 at 09:12:29AM +0800, fangyu.yu@linux.alibaba.com wrote:
> >> +/*
> >> + * The global NR_SECONDARY_PAGETABLE counter is batched per-CPU and folded
> >> + * into the global value asynchronously, sum the global value and the per-CPU
> >> + * deltas to get an exact snapshot.
> >> + *
> >> + * The global value must be read without the clamp of global_node_page_state():
> >> + * the raw counter is transiently negative whenever a folded free batch
> >> + * outweighs allocation deltas still pending on other CPUs, and clamping
> >> + * before adding the deltas back would overestimate and report phantom leaks.
> >> + * global_node_page_state_monotonic() is normally reserved for monotonic
> >> + * counters because a raw negative read is garbage as a page count, but the
> >> + * sum with the pending deltas always restores the exact non-negative value.
> >> + */
> >> +static unsigned long pt_kunit_nr_secondary_pagetable(void)
> >> +{
> >> +	unsigned long nr = global_node_page_state_monotonic(NR_SECONDARY_PAGETABLE);
> >> +
> >> +#ifdef CONFIG_SMP
> >> +	int nid, cpu;
> >> +
> >> +	cpus_read_lock();
> >> +	for_each_online_cpu(cpu)
> >> +		for_each_online_node(nid)
> >> +			nr += per_cpu_ptr(NODE_DATA(nid)->per_cpu_nodestats,
> >> +					  cpu)->vm_node_stat_diff[NR_SECONDARY_PAGETABLE];
> >> +	cpus_read_unlock();
> >> +#endif
> >
> >This should not be outside the mm code that manages this data
> >structure.
> >
> 
> You're right. However, I couldn't find a way to solve this by
> modifying only the iommupt KUnit code.
> 
> >I think the kunit runner executes this in some environment that
> >doesn't trigger this delay? At least I've never seen this assert?
> >
> 
> I can reproduce the assert stably on an x86 machine by booting a
> 4-core riscv64 QEMU.

Possibly kunit runner doesn't enable smp. Can you investigate? Maybe
we can solve this by disabling the check on !SMP

Jason
