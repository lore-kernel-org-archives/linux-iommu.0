Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C843CF69C
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071658; cv=fail; b=ADz0X1yfe17oGJZDeNs6KkOuYi96Pjf4h7S7ERfFhMK0DFv6uATky2cX8PG8o6slSjdu2tLc7pWJ5jh4nWeoocqT7m7yHqfzn1rnL4OtHmu2vqj52t7d2gMaYdaErp3iEGyrBqZFxPu9I1YMnAvf1oUtOEHZo0empM2k/q27Rig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071658; c=relaxed/simple;
	bh=qbU0h+HyM2YqLn2EWbtYGlrBUxnI6fFZoDgItXoDxqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e6Ej6KuJm6EWDEkKlD/s7d5J1fT7DWFWrJDwCK2sI2Nr1nGIc86S1TpBnT5KgW7RJorYjJGQ+6jI8PndOs1/IkcUZ04+ieA+ujEq1RnS+s/slrmk6+cHKvRH7asv0QoZVMkss45H+VI3kQNd0xTQgvbxryfxNVNoerPe4AahXTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WJNYVwac; arc=fail smtp.client-ip=52.101.193.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WJNYVwac"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQEZuVBzr9ERiZpYA4KyrFGytKgrZFIK2EGHiXZlFnKXsicXcYKB0Z6CfbkflS5wAPRN736yO3Z3YWcm4gvt8AwlOG1K546KNfFr1tUyCkcSyHH/0Y4Jgx3jZOMvhWJsmPcBmVe4rEPWLQI3JtgKun9ICdROgsH404PN2Eys0iALF66/rp05kq0KNkG9Jt0XUiEiAptRXIFPK7kvNCm7FKcUjqksVAOQnHEZn2RckjMxZpoy6wrcAC/DShpDhNnOqwj5Ap5i0TXI9XRHeQdCnJD67rT2ZqPg2hzHBbI3uEASMVA+4ewURf3bRnlhlpcuHFsGawKLDDjF+KXnthbrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vs6rPn9agh2Vc8z63hmqjpR5ZxBDKOI8l7kXmBJvuOg=;
 b=y/KYobi+sae3A/jcQlzD+id+Y/8SJhQ7Jfs2u/JO0UVWv67Qc+7POwk20tELToIB+urg4dSfonw/2F3CezvrNiNvyazNJ7jtPDOzx/QDlHGItKObHRRGA/c2J4gi7fEhszGFTWARoyKnNYKWGFqlryNJ0XMdlLuN7fK4z/4dauDvRbilkIrKq0IjBe/Ah4ZHIpwr7SHiDHMypUjvud4dd908PqRXGsOWxuisyhZZmkMPGLW+uA4oUH9BpIzMVjLZcAo6t7Jsqi84Y5qSuXBspbgf/ZVn6HP+9krskHKvGxGk6xpP6DrHaSsug3GoF5pBNymRpshT3XKMTryHZpPdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs6rPn9agh2Vc8z63hmqjpR5ZxBDKOI8l7kXmBJvuOg=;
 b=WJNYVwachw6D32wYbA0NGSj+288k7vL5wbbJZGFrmw1K4NYvjUfM5ZnOmE7l2tCniKBEHQ1DtvdZv08iUb9v9xvuYUGYEBdJQBHgL4U/w7SAERGGDhsz3V5e6Dys3QzCdHDCA59xuvervZKNCmuCjIGFUS91bBkgoXOzFcbYfYVOOrXP/7xVl4UL60IYijgMJHUXtp+BuxkJ1AQ05ua631elVRO4N4uYFOJXjHfHRn8FunbNiekZ7zKdBPsumD4wMaSdrmpEsG+ou5xAmrwlhW4YA7RvvAoLV4OgVg5lc0ObT679xolFp2/3mVkGjWyn2pbBs/wVIEJaIOHEOWl3Gw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CY8PR12MB7707.namprd12.prod.outlook.com
 (2603:10b6:930:86::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 13:40:49 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 13:40:49 +0000
Date: Thu, 15 Oct 2026 10:40:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	joerg.roedel@amd.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	Ankit.Soni@amd.com, guoren@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommupt/kunit: Read an exact NR_SECONDARY_PAGETABLE
 snapshot for the leak check
Message-ID: <20261015134048.GB13920@nvidia.com>
References: <20261015132024.43998-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015132024.43998-1-fangyu.yu@linux.alibaba.com>
X-ClientProxiedBy: CH0PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:610:11a::12) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CY8PR12MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: f370077a-7151-40eb-868c-08df2ac1ec93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AVGyXkjpKuse8TOyYTsiIlzq03b9gbSuXE2K4i/60eR8tqyxjLFQ9GfJkTxz/fqPY8wHFf12hwNeiyY0qHU1QJuO/QEh5xSTjFV5BcT/NnMThj0TtQk82OF4ZeGDqLA7d8b22mk2q/6cRg3tSEXuga5FsRyKE9paosmz0xBQqZs+wYcDvbNTP1mxXCqdgzH/7q4R2oxfmh1MVg7jj7gFUa9SuyYDGvjIlcZ5jyLUOmElPTCTjS++0ThW6MJ9wuPtFC+CXOIL5MK2oZE0ZmLnTOtwyYlOLwl5kQt+l42UDTTHE2ziQ1jLzL75hqLP5TGjrEmRTy/UNMXlH/Sqy88WrATOY1MQDfC72lZEt5dW1u6aL6ULQk47ZsnfqrOR27LnYKnqUVQYOYAG3sR67O815gRmmQ43impKNEUnPElVqeN4HbxB0lIaB0zKjp3kdi5iT4Ho3K1Pjr15BAZYLNWYjlWkdIG+c7Dz4s+oBQ1R1wWLi6ovsKcBfRpibrNtFUF5hhiRIrk/u9H6jLHU7dii+j2VRPZUQd1JFv8GBdm90aenOC9pNW30Viaf6vOtyCC/lhTvXz0a7on65E0rHAhRa3Kn9+H+C8WZ4hzGuzeQRf63lv8dQG0G3djhm2pvL++A8bbVYQ97MckEOCovn6s86qTDjLR3EfFDlTk683VPekE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hPaDpzjJj7XDg0qufz0bmmplrbblLJcoxL689K7m7bOxDOGG1uYw90OU6pHS?=
 =?us-ascii?Q?bsaFUtMXlY0wpPfvzZhV+BOXiJA9F2vYw6XYqvBkPxsdQHDpXFiiCkgz3hZ8?=
 =?us-ascii?Q?Gcd6NrFEMc2TGQj6RS1kqNw2/XyHnz/HYat0p20LiRxyY1w7ABVlYFRCQWQb?=
 =?us-ascii?Q?yiOXtneKNHePt0gBjHxXKP3bC6v7gN2siuCRWCBw474nrmK2S1RCJYRpTTyZ?=
 =?us-ascii?Q?TGzl0uvbceRU6usH193meTXwk2vntNQu17+aK7f7YIJYVKo+yilvrVLUD6aC?=
 =?us-ascii?Q?XyS3fJZcuxJclAWG4niKyLXki6rDyHubwM7jOvFCyCem7xkXdqUmFDmByvV8?=
 =?us-ascii?Q?XKQLRFB1vK1p6tnV5M0QAgoWOE+MjP4M6Bezi1UqGINYC/ddHTD2kJqYyt84?=
 =?us-ascii?Q?WyWtd1kgvS+n1jFqmrsWkeD2GdwDd3EQNB3CdCRgup/0hD4A0o04wjh1M66i?=
 =?us-ascii?Q?gy0Vvff1XSCbkySRs0Mv4rnsr/CNcxCTI3KE38Fzar5vTtcfGdvPGyzAxL4J?=
 =?us-ascii?Q?NMbPb3YXZWa6V9HNPpuwPi4X9a9bNU5zAndo2e55/sTTd+lwNEcnqlsqq9AA?=
 =?us-ascii?Q?TzizovLDyZxMF+VEyhzc5UWQFAUrBj2OU/lvFI78VjjdCABZ+VKFgCsSi0Wf?=
 =?us-ascii?Q?MmCb3fHpYP4ZVDXz9MUEW99RPAOg9scPcSvT0NiTnXa5LnDgvwV5ViNmFvYo?=
 =?us-ascii?Q?3Yyv1LG1RY5ZJ5c9ZwfQp3j2LVxbSmYBpBFXdw8EuiR+mXG/XVTL3WhjVn2O?=
 =?us-ascii?Q?+XV4jxKi6sq7Tm7TJDsZ5Kf7LmIHPCDGtwWW/JNgGjG8YPapiZjyDm3q8RAh?=
 =?us-ascii?Q?z7yKgfhzDi8Dyw8t8B4AYGpyfm9817SQxEGthituRcl4KfP18CpraC3QYnAy?=
 =?us-ascii?Q?OG+EF/EJHjQ4H9RaTcrOrZnzBN5mCL+xLSnTwh/zM30OfpkHEVhr477xzX5e?=
 =?us-ascii?Q?vpPnGmJHA/gNvdHrVNXUr2PE4zfY//swzBC2VeLKuEbDsLQsGGmwFzXwH/ca?=
 =?us-ascii?Q?Aw9Y3niUWw3vz4jr7cP/TM2fIuiQxoEiaqd/bnWlQ+e+tCew4dWAuSo2ckxJ?=
 =?us-ascii?Q?YioCSoO3MzedC/srgYKOV6FOFmwoVxS7XHbqEauPUTUuE7KLGd7ET49lfBIt?=
 =?us-ascii?Q?K9/ZgjE3Ra3Q+Ka2/3EREYvfeX3h7bqPnGwqRBhZGKZPz9YGFAaTIkG3Ln/k?=
 =?us-ascii?Q?Uh08JttUFcQVUbtUUMpAVrrPckpJRf2pLLblLTeFlBXako6Mia6bDviz5ZSX?=
 =?us-ascii?Q?qn6sUrHPCqVTfBhQ1CCQxkfPV4rZOQSdkWE718hjfJRQ0PaQLgzMKsw7P5sl?=
 =?us-ascii?Q?v9hJa9UOPaeRztItD9BzpKg/ASdW30OzVLyXHF6LxNfXrfYQhbpMq3R149x1?=
 =?us-ascii?Q?4F5KOxPMM3/BrXRR0quS+VFXSkRlxbv+ESsVij/Zk6S68DRq46WWiBz5hpUW?=
 =?us-ascii?Q?BPzA8371p2auDmktyXH5F4FcGJylhceEFOY7mvjnBvQbufMlwupdaTZZ5oT8?=
 =?us-ascii?Q?PBAZYOK0NLI8jy8I1hNTQ7XqOEO1CP4LhAo87giD0HuV3Odu0V20RdG61tjv?=
 =?us-ascii?Q?4E3lOFNySfaGBUiNeY/IJTyH5/cPf1kYV3abiEPnGkSKT1dUgcLGe7ccH/1z?=
 =?us-ascii?Q?pgq+HGMQauFXR7KoXgoSTsNPjk6/sFXczjQV9nn6WkMe+YQhehRx6xMD1FEu?=
 =?us-ascii?Q?hUsftrUAmezvB4clPZEKxTgJJgTxRj7m4v0AGzJKsDvkxssu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f370077a-7151-40eb-868c-08df2ac1ec93
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:40:49.7039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVzf+AsNp2qCcJzu2z5gDJx0P+O2MLvaNmdWaCCvSx3PIZ37EFDv/RMC4/I7qAMH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707

On Thu, Oct 15, 2026 at 09:20:24PM +0800, fangyu.yu@linux.alibaba.com wrote:

> +/*
> + * The global NR_SECONDARY_PAGETABLE counter is batched per-CPU and folded
> + * into the global value asynchronously, sum the global value and the per-CPU
> + * deltas to get an exact snapshot.
> + *
> + * The global value must be read without the clamp of global_node_page_state():
> + * the raw counter is transiently negative whenever a folded free batch
> + * outweighs allocation deltas still pending on other CPUs, and clamping
> + * before adding the deltas back would overestimate and report phantom leaks.
> + * global_node_page_state_monotonic() is normally reserved for monotonic
> + * counters because a raw negative read is garbage as a page count, but the
> + * sum with the pending deltas always restores the exact non-negative value.
> + */
> +static unsigned long pt_kunit_nr_secondary_pagetable(void)
> +{
> +	unsigned long nr = global_node_page_state_monotonic(NR_SECONDARY_PAGETABLE);
> +
> +#ifdef CONFIG_SMP
> +	int nid, cpu;
> +
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu)
> +		for_each_online_node(nid)
> +			nr += per_cpu_ptr(NODE_DATA(nid)->per_cpu_nodestats,
> +					  cpu)->vm_node_stat_diff[NR_SECONDARY_PAGETABLE];
> +	cpus_read_unlock();
> +#endif

This should not be outside the mm code that manages this data
structure.

I think the kunit runner executes this in some environment that
doesn't trigger this delay? At least I've never seen this assert?

Maybe the test should just be ifdef'd off if that isn't the case?

Jason
