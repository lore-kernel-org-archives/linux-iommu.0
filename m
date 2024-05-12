Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B571317F3
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715518291; cv=fail; b=WRZOr0sgEJdWhHG/NXV/eQUxekyBwBM7uWrk4MBOaZVm6zeyE8Gjr91P5z7jalvdqLyVaZN5xqD9QvtmMCRIsxS2LFClJlBUpbv8fGFqtZh7gACKesi/kkSkwMM/4R1FxwCi6VlHlJK4A/+BQjhSiyvR6G2KbD/eE3510B/D3HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715518291; c=relaxed/simple;
	bh=9VgTfnzVY/un7RGjYJssUQsgRht10gXAO/jIgwuAfXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UbwgwHCpredNkIZ5zVSwsEciB9K5dU0thHOZZ2dPMwIqFLtUdm9lg2SdTj92wq8Sr9Iom45X34tavPAJTpOGkK6FQ1KWw3EfUhB5+zUG87GTPFZ+wHnTXVtdtlp26DCcEf6gH+uqZDsoV0y2A5Tx/dN1oN2XdToufGg/G20+gE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cRAC26eb; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cRAC26eb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0Jr+FSMHQY3JFHqx2Vma0aB3xTT3eDic/tOR2pxaYC6l/geqGCFSnOw3RgL72mRHQT65ilVafh1IW1UXa8BWnP991fGEDpFa/+r/MSkLCI0XHND0+NdFOv1EZJhW6e25/q6t56N75a5afdCOjAQsidlF+0NeKHHBwh17kbqzObM+9UVLgGEPxYKmUV7Ljgl3i54HuZtajSEXgB1WuZGC1dNmXAbVMFkjNBm0wWlau26U0tqFC+X6gRW9wppoMdcOiBOIbBhyhxWFZiVqT9WxHpQW/ZQ+IOqvvCTkJFolrMQHW+iqQyAwP9stACtjn3nGYuAQ2QqQqyww25tg2CNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0j8VZ16ItXxX2oG00ZWAqBj5RrpcMhkcWOqGcjIGe8=;
 b=Zo9N23tHuqwUVSHibinn/hdmemQjGWi7NVNJ6RUL+it0a/+EFbxZl2YDRU5Y3tHhyQQMty3brAOBrBwiEIztudOyXyBHi+YnKlo8Sr0S+/IdauPbUZv8N0Uf1yM8zblex5rPLPEYdQbLcI6Tbdt+y3emriF/X5NvpZ+17kYu93Q5Od8da++JDVeU374UIRkF7z8kgVWuiMkTVG1TQSAfc96IC4fQSuQB9oSv7lofULN68FZkn/HALGqn6T8oAQVA40U36SQicUa54xZrxPlkhmscBcV9yRULkmsV1XFWTJP3LylH0Zb5/jJ/54jQpPN6rHHGE2xvqOvY0GKsBM/qhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0j8VZ16ItXxX2oG00ZWAqBj5RrpcMhkcWOqGcjIGe8=;
 b=cRAC26ebYsE2MShcWJ8Kt/pLh9JiCjIyEz8MFRA3izKLHI+fVeEyFUpm7sOcsRykMo7hSZSQ0N4v0pNpFkiirk2ZT1mwJT6z2qA9BIFu0qjcUF8HVOn18GRFsCcqAAbh9GDauqLK+4jVE0f4/8wVg/x1BgamUulKcPbisjsU4G/gkQ5V9cw3WzPPu3m1BX5pcSXTxpVwsH+MeQPsf+K3/JYV7OnSyxQBV7CJNsHD3nhnN+bFLd9iPKTJwEG2x35qtq6CvEq5f95smf07VMw7X4ta6Gp4X40Ym0/ISUY9++viWKFk5axKnVTLJEQ5/1zo+CcU7q6SKhCobcVuV9a6EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 12:51:26 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 12:51:25 +0000
Date: Sun, 12 May 2024 09:51:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	ryan.roberts@arm.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	mshavit@google.com, eric.auger@redhat.com,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Message-ID: <ZkC7Q5bynT+WAO3t@nvidia.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0119.namprd05.prod.outlook.com
 (2603:10b6:a03:334::34) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd3e337-f915-4fc4-b051-08dc72823be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fdUnrsacFOwlo3fTEnJIEyI+XgxnAkXwWjPDJ4eEMzxgwgoaykV3cT0v8HDn?=
 =?us-ascii?Q?wW9vE/krIcn0cUWZdi66/Pzm9bbQDG7ydrVdpxmh11eKgZa5rnvUKjieITLj?=
 =?us-ascii?Q?1kkx4v3aokXvC+PGjgjPePyaIXf/b7i3EECi5Rqhm8IHu30gqAp04a7PvQJN?=
 =?us-ascii?Q?XEzuvZ51hbgZXLqYof8V+UcsRgx5NxUF8eAG7obe5U+0Lr907fU3M1s8Jnc2?=
 =?us-ascii?Q?1qWRZLOoO1TDm8U2fth0HUrYooWz9479GRBxOGLoDfYvtVE4qMKvlFCKONth?=
 =?us-ascii?Q?Nw382fPikEKEzAHfwhlXOJkSoCmoRUonEyY5LXiERScHLnKp4qkQLjtQJ220?=
 =?us-ascii?Q?V2XDl8AWEoQFX+sdjUhXrhvae78WBe8m+z5IPrWPxk3nNdvatg+swpd6tNxF?=
 =?us-ascii?Q?K01IviGDXSaFGRAvtNx4gD3jfvAXP37IIQVY0imJyRXpdJUXuYc5eBYw6FOx?=
 =?us-ascii?Q?f3WC/U9ke3IA3gWXLtrx1lNq7RlfkvBzmIGluQqiDgAw3gRnMhJZyaXFADq0?=
 =?us-ascii?Q?5+2etlziqhF0ORP4oAME46dRwCCr/ZsMyOX1HCEUgXdqvtybGYrWPULnEsyZ?=
 =?us-ascii?Q?pY702DZnd8MQEgCEO+VoV6H0IbEfMY6uSmmvu7pETciu3CTQGlvKWCMk/AYt?=
 =?us-ascii?Q?uFsaLEyzOcR6SC0EvBTU6ay58vO8t6wuf0f7j3cHCFZakGqEIU5q4LXY3mif?=
 =?us-ascii?Q?bcPaDcKLYw2Y0kKjrvVSC/zZhJMbdpH0nQE0qC2MiQzAEV+COo8YO+x1Jcxx?=
 =?us-ascii?Q?zpAoBPvwUPaQEABP47khMJkeVtniv7/UdHdAGgyUcPHk7i51DJdomSXa/2g9?=
 =?us-ascii?Q?6rUn6xEUq7EPSuEFuQ6VfW26jg7fgA+qNOFDtIGMKC3wUCjTq4gjVYMLEwwh?=
 =?us-ascii?Q?ACNxa7utrJhMrH0VEcH0YoMhXVHtyUsNcxCuw0rt4bPgSuJsPTf0ee0OBaGx?=
 =?us-ascii?Q?c9LWnh7QbfR+mzEuwdb295SivNPoWzxj3KLoy/NIWUB1XtnPtfy+T4tAAQM+?=
 =?us-ascii?Q?/g2t4e64helAFrUg4cO7yZHqfe/J5Pq64zLqqUQ7LR8iwxwV/tCMDNxOhIxY?=
 =?us-ascii?Q?/NpGpBCAGsSIBkGIOEJalin8UMzVUXZCKjlQiovhLrQfU/5jjL7VjIycc5S0?=
 =?us-ascii?Q?WFobTcu712FBoCcH/X3TdTuj29NygjJxfvP2Zali7HAUrzr+fiweFoFd718U?=
 =?us-ascii?Q?pZjGmQXegz74yMXO5NgrY/Ns3nD0vyC9fWkxWKuy3zqtWUCcH9YKSAbkCNkQ?=
 =?us-ascii?Q?dxPy8472hXyHG2m5Kd3SY6RgjQhR2+9uL44ESHtn9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/dqSgDZpny7wjL/uKeUDHD1119pxl4v+VfoaSoFnDN0J9hlTYwOOIRb74W+Z?=
 =?us-ascii?Q?NNvjw8ezlj3RRkeRiUZ6+WAeitgAYKU2UU1EA0/J2rV9GCp0nmi7PyEwGlBF?=
 =?us-ascii?Q?8vM0qc+fBWIcr609w0Fpuq6JAxFgodAS8BAqQJNv2qLxEL2E9EDDjqqF//JY?=
 =?us-ascii?Q?b1WHjV3kTeSBc23nH+lN3pwLjVJRZyFsLiDBGgY3urJWA/ML0Ycm9EOGVJ0N?=
 =?us-ascii?Q?dCMvzJ50/iH7Joyt51UNFom4fcrjqQvKDOncXt8zFVbG3Qa6FnGKGaqD9WxF?=
 =?us-ascii?Q?7l8q7e24WfJGZDCskQPoa+lUxV2JejVVFhOyKO6yqZogNIwArhNichkyMYgR?=
 =?us-ascii?Q?p4n/mWvUAlSPmjipqw1Z19ybUEkldcmrPPPB2XJoP6qSgVoY96ws4U9JOiMl?=
 =?us-ascii?Q?DwSKu5tkruC1KuE1Fsmdg503KmHM+a7ogR2pvllkVZtbiQxMSjDCkf0so2Fx?=
 =?us-ascii?Q?AQpZNyYgGVlS9Cso8EC3y6fKz/4gsgYBs9ey7wghs/9hQEsrZguK2TLoOI3X?=
 =?us-ascii?Q?8NBaxllM4DBxJ9plzp9N2dj1SUQCCmX2hlWUXxLztoOd4wzTPRgXEnnDEsa8?=
 =?us-ascii?Q?/3iF9q2sHq6LicjH/qQ4NP3mK+WLvrZ+vUNtRwzflrAAJPmUgxRF8cBu8/hi?=
 =?us-ascii?Q?gvGczSzzbIPZ00cenvnzWpxDv+yHJIA4ZJMxt9J7668Dt1d21gTFZ4IHYxiE?=
 =?us-ascii?Q?fcoX9JNOQ0yLFx+nwSKKst7Y4PDvempzxwJTJXIFA2q2GzgJp+pP6wiZkUB1?=
 =?us-ascii?Q?F8dKxv/u90XlHp6aWtOBX/rZVb5QKuRGcxOKf+C71dUwkaia49EqdF3zh3f/?=
 =?us-ascii?Q?VdRk7tRo4uwXUTsfR48o7jqoj+KgUDUM/fQeTBYwWGc/jHJ3Q8HDWaVgrz1t?=
 =?us-ascii?Q?bdR1z7+u3PsI8coOqnd2KvRMQBYh1Og1/iQ7dsBvnIisbPn0e5ynnmJ8+KBn?=
 =?us-ascii?Q?1R1DHqpU8/bR/8vUebxg5/K/xTV7JuNmglyDRPOiaOHatZAmzjL3k1xSKVeq?=
 =?us-ascii?Q?yFUwtQjgjVn8bolrFBYFw2zu/3HERiDTIwRYyUtk62jD9LdcrUUztl8pA1Qs?=
 =?us-ascii?Q?IwVKdPn3aBcPZFbSqXg4xW+vGbkpqgQjt/zGZnllc7ZFzjsJhuFJ8B0019dM?=
 =?us-ascii?Q?4yh9HNr0DahVFZmMIHRWEAvc2ss9jlYcZdDUcDjGaRz4c7Tcg0Iz7FYMz0fy?=
 =?us-ascii?Q?BNjCtVsWbT07V18dH9eH/chs6C77zCDro0AOG+gqRS9fY3Fz9JTU7qHI13pn?=
 =?us-ascii?Q?YAvdqjLFs+UnNYzaEgbTAYLWFx+p1dEHzXg9FBVEdFrSgi4qu+fWoT5YkJQs?=
 =?us-ascii?Q?frzdjUOM2APEMZypXHaM78g9zMn59l1Fhlu/bI+GEcCw4cY73gHY57/60EFE?=
 =?us-ascii?Q?oXO2ivGQHVdBgEVLt/XgOYg+/Ds25VB1Fjw/y1rUjG2phspFrMJjQ4l7tH8U?=
 =?us-ascii?Q?SM7Xr34f5zaRn3VLK4t+uSkV/jEVlo+EkyS0gQKYrhAw4rzK1zNdkwDjp06J?=
 =?us-ascii?Q?bfdM4y/FgxGLxspRxu8fCVTlGH/2o6UjcCAWMqvflQJ+Ll5NdYL0tPyTiKG8?=
 =?us-ascii?Q?K6MetH71VUT7fjWVINQJI+uXGtjEJBJGDandtOnd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd3e337-f915-4fc4-b051-08dc72823be2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 12:51:25.7394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qV6deEGFdh/9/TKuT7V2iw0rNgSdaH6JodMAjCHmCcZWXYdL2/flR9ppGn4STsm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140

On Tue, Apr 30, 2024 at 02:43:06PM +0100, Shameer Kolothum wrote:
> +static int io_pgtable_visit_dirty(struct arm_lpae_io_pgtable *data,
> +				  struct io_pgtable_walk_data *walk_data,
> +				  arm_lpae_iopte *ptep, int lvl)
> +{
> +	struct io_pgtable *iop = &data->iop;
> +	arm_lpae_iopte pte = READ_ONCE(*ptep);
> +
> +	if (WARN_ON(!pte))
> +		return -EINVAL;

This seems poorly placed, why would pte ever be zero?

> +	if (iopte_leaf(pte, lvl, iop->fmt)) {
> +		size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> +
> +		if (iopte_hw_dirty(pte)) {
> +			iommu_dirty_bitmap_record(walk_data->dirty,
> +						  walk_data->addr, size);
> +			if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
> +				set_bit(ARM_LPAE_PTE_AP_RDONLY_BIT,
> +					(unsigned long *)ptep);
> +		}
> +		walk_data->addr += size;
> +		return 0;
> +	}
> +
> +	ptep = iopte_deref(pte, data);

This would be a better spot, if the pte doesn't indicate a next level
table then something has gone wrong, otherwise the returned pointer
has to be valid.

Something like this maybe?

static inline bool iopte_table(arm_lpae_iopte pte, int lvl,
			      enum io_pgtable_fmt fmt)
{
	if (lvl == (ARM_LPAE_MAX_LEVELS - 1))
		return false;
	return iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE;
}


> +	return __arm_lpae_iopte_walk_dirty(data, walk_data, ptep, lvl + 1);
> +}
> +
> +static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
> +				       struct io_pgtable_walk_data *walk_data,
> +				       arm_lpae_iopte *ptep,
> +				       int lvl)
> +{
> +	u32 idx;
> +	int max_entries, ret;
> +
> +	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
> +		return -EINVAL;

And if the above ipte_deref() could check for a valid next level (with
no valid level at MAX_LEVELS) then this can never happen either and
can be removed.

Jason
