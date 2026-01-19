Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C304121FF47
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842794; cv=fail; b=Ev7XdngSLRBoeX+SqlMYvW/A3trk7c8lbIz3x5GnGxwDkEwo7dN1J1kt1guVb8eAwBNrbEYLuvIAhHYNzWoXvZcTxkb+qqRaGTXM7HoSlcrwgEPeL4CX4P2RpztsEN+KOdOtyxDa+iksiQVjna+O6hyUQ2CD5k/NW5eTyfXJkYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842794; c=relaxed/simple;
	bh=ejrDYe/+HgRZehk9vFcu7U78ZVsFkTTg1tMUAtwBQhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KB59MzvLFCx2HS/CQ4yYfS+6pjyCkbL6CQfwWKz5hAgmlcbyLdj2/o2nTcKH8RyVYyPFiLBz/1c1pkWcvqfrATAhoFhr1Bm0mAl0NncaAaoRqaXGebhukDdF46aE9R4ZNmJoy1ZRAET9Ne/oXDCfMKfp+bPwmZFH1tjF9s0Dhb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=umyBG3oZ; arc=fail smtp.client-ip=52.101.48.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="umyBG3oZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYJ7S1PuVM6rcbH37v1Tunyw9KRbRrASbGggTvMzIe67oFyTwz7GauuYUL2oFI4NcmokRfABlRI1tlIl25EU8isM5jADhQeBlkOySpE8LUQPiM7NJXadV7qeqRKoXpzKd7CkU68hK5I1iDeZj5PvoBJvu62NB0TFQ+xRjhLcEkou2dIzlaH5wQSn7fA3Fh0Ny38le0jqA0se/0BnpfzBQwR1Lm9nrOlMht8Psph3kl9tVFCvjNQMh2tiz5WShMptarkNrOgk/S+e3N9jJIidj7sR0v2EjlUf+Q0meTH6VTVRp7M9KEIEDzOJ/e8Y5/8kCKnLqhE1IJKZGGinh1NUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vA2z5SPToy8KHS+UPB9JCqcFK13i360JSMHj0VXlEs0=;
 b=QdDIWCHw7tNu8FwIuFHtnxAIzBVWTyqLdJRpNziZED+1BrE9QluzvtWAXFqperi75xzhnSVPjPqELK9fJ8Jw/DglGUM5a786i3svJ4XaJzhq44VJFlXF9Ji4E79yLk3jHLimxtluxZ7TSuKzzkI4/ECBFBkWSh8cMQBhCZCaldaLSMYCwp7C3cZZiWDaxGYKioOmQwbjjn9tMOJFLzPHNheIAZbZVr0IeBAUqveFrXn1F3Xob5KQEnGh8j0jYXr2u5DHQRMePGEFTKsGN96bMmbVMqVL2WTxMni90RC5TcrLClnE2imh2f6oruDUYp3xUo9yENtyEhrqaveNCkOdDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vA2z5SPToy8KHS+UPB9JCqcFK13i360JSMHj0VXlEs0=;
 b=umyBG3oZkMlQc6+U/fc0L7Ew6vdWWJpDLriCLiSLjLHtfKCCtZvXDzImZRM/1ZuMXfNdva3l2bnpnfIa/BUyGymdb78QFYl656+LnFMF4NeG8Blxn5y1wQUo/m+2tD4dS79dpmNBFCCIVgCeoQ9uuD8TV1XMf8bx9GtX541EnQ5nImSxYdm+Q7UgXHgSgdfo/cjyALR8mF0fK40oaRzCW1/IJiybCVda15CfbxIBHy9z3i/VxXfs7u1tN5mZNCmMO0JXFl0TODPOlMuVQFhbtw/WCeG7M9j2MwPmND4MNRi0z7tXXX/Q2fjXRGCEsjjeIUDEc7wqNNI7WRnKkuAE8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 17:13:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 17:13:08 +0000
Date: Mon, 19 Jan 2026 13:13:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v6 10/13] iommu/amd: Introduce gDomID-to-hDomID Mapping
 and handle parent domain invalidation
Message-ID: <20260119171307.GJ1134360@nvidia.com>
References: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
 <20260115060814.10692-11-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115060814.10692-11-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL0PR0102CA0014.prod.exchangelabs.com
 (2603:10b6:207:18::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 325225ec-8fb2-4d6a-8ff6-08de577e0439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bZvuOkyT1qNBMJohzs9s0NSjmTm68zbZb3bdmHjy1w5azKJMt2VTkNbrMnXH?=
 =?us-ascii?Q?83CQOaLIZ+71APQBIhEJQtguZ1wozqT8yJqvCdvC+ZKQSGKlhiZ4qx1UrxKt?=
 =?us-ascii?Q?NUsQkFCwk3bplSlUXC5pfmmbxREGiY7sRkNJRL6g/8VtyxGVSruxlMsXsxcf?=
 =?us-ascii?Q?xIvLMyS5KhaTlxiqj86YdAgbiF+o3yXALrT3NsXD3gJyFQVrIdUlrwkIeDAm?=
 =?us-ascii?Q?WUzG+a9X4L1HRkAM7QlS83hHmfOThGv+1AQgUmoov7Y15nscsDUSfAMH4d+N?=
 =?us-ascii?Q?Jb/fNQijZAK1Vmz0YxnacAFkc05rC672aFe5aFBM23GaIpGbJerVL1Z9f5sK?=
 =?us-ascii?Q?3xk7CYwxpYmmbxJvXhhZiaAX5S1gFOCHF7LYcghi/9frCC0/+95h6jN0uQmP?=
 =?us-ascii?Q?MYpU1SY6m+BYroaANG7BOJFb0JhK1kTmdr7KJZrEOXihFrAGK5S0kPodF9Dv?=
 =?us-ascii?Q?mSMhN5++HrkHGj8mmmaH4wQAFsz1rEIOV1OBUiuHXzJwhqn00/OASzNnSk+l?=
 =?us-ascii?Q?LXAKPgzhSTrezEz6aNime2FyIfAe9IqxGs+nBluwg5s1CWQt8hXo3Ef1yqDR?=
 =?us-ascii?Q?A6I4WfV+P7gSosTZfu7YVUXX0kvr/63ZuSWOQSdrD+arCm3q2MNx52rKkLn2?=
 =?us-ascii?Q?8bo04BRD4k7L7j0KYChyyiRYP/3G7ZUYyeYTt3N0gPH0NKrMqCAVfjdZPpet?=
 =?us-ascii?Q?WxOeimyb6h9RDOQc9WA/e5XM1oi7xguqGCqmgtR94pUrvn4R5NVkWT5gd9C3?=
 =?us-ascii?Q?xyj+jGQlWlIY5wMJ55TTcuwA6xJBQ61B0Xz5ew3EXRbN9ICN7wGLSw1dQiWt?=
 =?us-ascii?Q?csjjjKZuIqXAHjyU4gxhp3uOT79sFkHu15xjGuNRRW7I551W/fxxCzFSK7ir?=
 =?us-ascii?Q?UlkAbPGIM973igZYsrTzFV2B+THAS0dQCFccBL5eRNyUzOvs7KNQT/ArckDN?=
 =?us-ascii?Q?jIWGeTmab4nIyFKQutdF3ipGmKhdnmqyWN0GNcyYp1EtwjckfEfPqTIjFz8x?=
 =?us-ascii?Q?UC4NecI7RFx3FU2xiAhSN+M2duafzH2c4FibxSzCZfeys3D6bFBQ63GDNfyg?=
 =?us-ascii?Q?G7naXi8BnmljGJ1Few7cLavE8nlnBykCAM8/zYAEEIIDoQAnxLiv4E5T+vLQ?=
 =?us-ascii?Q?LnaAAPsrhMExvr0/G3BAA6X85wkXBSkQsS7yBNY9r7fSkXnR8aRSatlCI5je?=
 =?us-ascii?Q?nGg6UXH5kziY3V2YA5R+7jnVDM7iKVa4CO4UzDJgPAYDD2w80kPlhJj0RNO1?=
 =?us-ascii?Q?YSDQkZZZGq/VPs/QUF1KHtBZuGFhBEVeZaRgB/m3IxtKI0uhyJyh+yuqozPb?=
 =?us-ascii?Q?7eS5Sdbue1uoh/rMFax0nwEqBcOlDPwfr2w7oUlr7MOnW5HFNjlJC2CPB63D?=
 =?us-ascii?Q?foAp/shPeM0o8nzsNsMJOkkFWh/oCJA+kzUTVnmIr6ap06aKanYcVh5izCIq?=
 =?us-ascii?Q?UgFZUskNAcpBxvhU279iL/4JzujyXkiVhH2stKil5KD2J4yh4AmAj3m6cH2C?=
 =?us-ascii?Q?Y1qU+w02CrPrwMUgkQF5ciDutGhfS97CUSEL9HplP+V0W2Gzy8ZiX8JAcM9y?=
 =?us-ascii?Q?JkP93E1pSgN2eru8WVo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZngAOL5x0Tj+z57RgHdF6EguhYmPGLd67y6a2huaxQI3SreblYLmVqLAgqGQ?=
 =?us-ascii?Q?bq6p6auzJeqijHKmTuYzRSJU1ajyl6APzzsVbQy1o/WAwCk6PLfEY7N+1BMU?=
 =?us-ascii?Q?qWxhcIcAc28RAMENCXmEbfs4LYwlT3eLlaHK2W9X6bR6WH9cKgN2ON59Fh5i?=
 =?us-ascii?Q?U0KGKJaDse6g9ePRbg1DDzL1NC38F4VJGUbeu1Cq9wE876D77bIkRDJc2tbh?=
 =?us-ascii?Q?vM+Pp/LfMduCOwTyxzragjlUrMMjB1dqDrXFA5rsK5xZxJu+qOyHFgjNdZWh?=
 =?us-ascii?Q?uuHD0zfEIBObDZL8kpYRE8rWXRET2iS0cwlzoRMTIFsWkWo8t7BkoepLzHyl?=
 =?us-ascii?Q?8HjqqtBaC6oksjtQcuBTyTUpmty0moG3qW4yypi0FJFbR6hGXfhMHbHmfh00?=
 =?us-ascii?Q?yf6uv7qzXxmhNQJ/B2KDGJzrmI5vLJ9Mi8t92QJ/gb26F1vvIyYJAkTKmZhT?=
 =?us-ascii?Q?T3TPOjgfw84ZDlQc5NRDTPPbSSpoz/FOxhaXpJTTMiqapFYS7VxhNw5OZIIb?=
 =?us-ascii?Q?SiVF51bO4k5sy1Uy+LAR43an+VZKHGqx9+t2eOm8KDR1nDvwvEnEmeeYvg3i?=
 =?us-ascii?Q?bSOa54EYNEtpyvIaf81VXLkah5wQfdf//vPdWvTdrXc5BqK33WpWxay+Snve?=
 =?us-ascii?Q?h8NhBhzFk4+38LPIr5Ox71eJcZN1AjkAWlPSBOu3p1wNfFjRFpwfbi1VsRR1?=
 =?us-ascii?Q?d2vtwci0BoeGaYUVkCT8e4SP0z/EjVEzZQRV7MRaCM4T4gTZ1tbR4uR16zmo?=
 =?us-ascii?Q?5RQ8O/TsDWLegp18Bv8mcDfHvsF+vzm0nhbcjP7dh72H9+eIhZjQaakaXCza?=
 =?us-ascii?Q?9Jp8hPnHjIwfHkTcDdl0V0KyroIoxIAs9dqzkry7Gpg834r2rpqE469zY5qL?=
 =?us-ascii?Q?g9KsB/9Ls5PKYq+3NjYIc8xWFwoF/eBPS5lu1XrubDRUJmB0xIJ/aZaVFoWG?=
 =?us-ascii?Q?RxXbUyehQMLU1FMN0rg0A9pqHwvARGP/Jv/xNa2ymB2UE6ZFKvZNEOEHRDm5?=
 =?us-ascii?Q?pw+MkUhvwnp/QkPCu08mnzdAOv+WlqZq22ZQ6+CLMaSWeswsHpPV/JZ/BTuJ?=
 =?us-ascii?Q?B/+nJKxVI5jhnA9m90Y+4EZ2H+7ySuQtN6Nv/5rK9D7k1T01zDmX9cuKeiin?=
 =?us-ascii?Q?TkI2ODI6g5ceAAYEy8AuO4n/iNCO0DyAWzHVC7lRkTmb5/W0n5WbioMBhnl5?=
 =?us-ascii?Q?9DZfr66gpVod/OiS8PL5WQvpZ4D3m+7KlmMujyI0FkC0gJWpYfJRDv7y9AMk?=
 =?us-ascii?Q?NdjTF4nUsd8FSqACPcY3Ap0AJkMZNAtlM8rUJZuqd83Q9SkdI1voWu9m/q/n?=
 =?us-ascii?Q?MI8TYnU2XI+a6PSau6GUXB9SPoljDvgZRnuudOPKPXWNqhm8LNx/gyh0tZKx?=
 =?us-ascii?Q?J36ntYKZKkkWms2/AUuwwvtnkp7KdQw+C/YH24BTqjJk9USVODCESYCGcNM6?=
 =?us-ascii?Q?1XHSTbBt5HJ3avdFkR+KB82kqEBWjcRLW7wT5sbz/b6seryLqN6lTtJRLwFY?=
 =?us-ascii?Q?FjRO5DONm2RetDdtbNJDXNX2KrIGeIMi/ouXHI85x6hFlXPHGcmqvu11naQ4?=
 =?us-ascii?Q?NLf0IUp3WmOzTVi89oZYJGdo+Fyje0K9Jv+dQsF2xBj/sxS1epo+mpOBbNRf?=
 =?us-ascii?Q?WY/ZCvIwCIVXLnS7X5rjRwdRDxAbd6bFvLMmecT80he1a4V61FtCNwS+Al/v?=
 =?us-ascii?Q?8j+rennKRwP/pKLNu3Ef/XIWTLdZXblzyLVysmVuoBN46UzD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325225ec-8fb2-4d6a-8ff6-08de577e0439
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 17:13:08.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lWuFHaY5AnpVc7RlD5P6Gy4rY/sthL3veIMZkNOMFmOrZv8DxM7BgC27U6SMbP1V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7099

On Thu, Jan 15, 2026 at 06:08:11AM +0000, Suravee Suthikulpanit wrote:
> +static int iommu_flush_pages_v1_hdom_ids(struct protection_domain *pdom, u64 address, size_t size)
> +{
> +	int ret = 0;
> +	struct amd_iommu_viommu *aviommu;
> +
> +	list_for_each_entry(aviommu, &pdom->viommu_list, pdom_list) {
> +		unsigned long i;

You should have some lockdeps here for this list iteration..

> +static void *gdom_info_load_or_alloc_locked(struct xarray *xa, unsigned long index)
> +{
> +	struct guest_domain_mapping_info *elm, *res;
> +
> +	elm = xa_load(xa, index);
> +	if (elm)
> +		return elm;
> +
> +	xa_unlock(xa);
> +	elm = kzalloc(sizeof(struct guest_domain_mapping_info), GFP_KERNEL);
> +	xa_lock(xa);
> +	if (!elm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	res = __xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
> +	if (xa_is_err(res))
> +		res = ERR_PTR(xa_err(res));
> +
> +	if (res) {
> +		kfree(elm);
> +		return res;
> +	}
> +
> +	refcount_set(&elm->users, 0);
> +	return elm;
> +}
> +
>  /*
>   * This function is assigned to struct iommufd_viommu_ops.alloc_domain_nested()
>   * during the call to struct iommu_ops.viommu_init().
> @@ -68,6 +96,7 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>  {
>  	int ret;
>  	struct nested_domain *ndom;
> +	struct guest_domain_mapping_info *gdom_info;
>  	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
>  
>  	if (user_data->type != IOMMU_HWPT_DATA_AMD_GUEST)
> @@ -92,7 +121,63 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>  	ndom->domain.type = IOMMU_DOMAIN_NESTED;
>  	ndom->viommu = aviommu;
>  
> +	/*
> +	 * Normally, when a guest has multiple pass-through devices,
> +	 * the IOMMU driver setup DTEs with the same stage-2 table and
> +	 * use the same host domain ID (hDomId). In case of nested translation,
> +	 * if the guest setup different stage-1 tables with same PASID,
> +	 * IOMMU would use the same TLB tag. This will results in TLB
> +	 * aliasing issue.
> +	 *
> +	 * The guest is assigning gDomIDs based on its own algorithm for managing
> +	 * cache tags of (DomID, PASID). Within a single viommu, the nest parent domain
> +	 * (w/ S2 table) is used by all DTEs. But we need to consistently map the gDomID
> +	 * to a single hDomID. This is done using an xarray in the vIOMMU to
> +	 * keep track of the gDomID mapping. When the S2 is changed, the INVALIDATE_IOMMU_PAGES
> +	 * command must be issued for each hDomID in the xarray.
> +	 */
> +	xa_lock(&aviommu->gdomid_array);
> +
> +	gdom_info = gdom_info_load_or_alloc_locked(&aviommu->gdomid_array, ndom->gdom_id);
> +	if (IS_ERR(gdom_info)) {
> +		xa_unlock(&aviommu->gdomid_array);
> +		ret = PTR_ERR(gdom_info);
> +		goto out_err;
> +	}
> +
> +	/* Check if gDomID exist */
> +	if (refcount_inc_not_zero(&gdom_info->users)) {
> +		ndom->gdom_info = gdom_info;
> +		xa_unlock(&aviommu->gdomid_array);

This is pretty tortured, the alloc flow inside
gdom_info_load_or_alloc_locked() should do the
amd_iommu_pdom_id_alloc() and set the refcount to 1 before installing
it in the xarray, then you don't need any of this here.

> +	/* The gDomID does not exist. We allocate new hdom_id */
> +	gdom_info->hdom_id = amd_iommu_pdom_id_alloc();

Then this allocation wouldn't have to be ATOMIC.

But it looks working the way it is so no rush

Jason
