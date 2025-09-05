Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C633987
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097841; cv=fail; b=stsrs8K7Zb+GwR48k6XWrFp7Q/+KkJwxfIYC4ajbcZ8dPmNb8TReZK5cL8sEZt/3IRmSoA1vglDrRU4XqG03WSOKXN32Rn4jPBzOotwaq5VcjVHRdmg48WLr8Z6gmBGCF6P5CDspQgqxp/avau9An1DWQydCxVs1tIg8qWcMdek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097841; c=relaxed/simple;
	bh=fIG+lYC5OhMozonvvoCXIGmSednt6SVI8v/3jlxpCGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DJ/hCItqkLVV9l5joALpT7vTbrgaP7bILRdf/2CgMQfFffbajrP6+tI0bDlO9wvLd9gbB5jGD0H8UZHHx16U+d9wz/kBcawNmUBuomeZ9j0op9Iey6KbAYPEaDrhk5R8Hc+GyfX99tIfRY4lS2EPu6fJlVt+z/PZw4cWHhK7b1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hCSsdrTD; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hCSsdrTD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRiHGXMzPlpD1exAgExcGfM/Vf2/cmJsQAmDJ0Q2gYwR409BuLB2+VxaHGitEl0XbmkSFwWH2cfVDt9brkxGkGasyteVEZb5Yv9EUyej8g5pbhDrcWuRjqkHCEMtjl33c1gVgtz5tj3sAuI+LQZCdyGCgqB8mYz77K/n3xflkRweih7+CBIzTWRsos6XICgwAZB93oiIFBuo+ZZ4ObtXTQmBjiWE2og24Z6WqlFefNoe25nk0ZMNqq/STkKGNdaAr2qTn6U9L8wIIwtZmsB97U90yhbIB1W23/ydrGNduWXIBsdaFV0cwOBc8AuqN8nZAdBusIWhIja65nJwKVm73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnlV7IK54VMzcwDKU3L1k6plG49KaRrWH7aTY8P91bk=;
 b=P3diAITck2J6Q0ZbQX9zXx0fwPeMyOXT2cyjiBze/ywZ2/vzHeBGx8lHxNfBKXH03LchLLZWfIzGowxJNR4xBpY8ELRNYlQSHyrEj7nsGzq0tTxiIivdyDNXFDOw6o/ZORBOLuPETYOIAc/LIexnex2ovhkoENMZ5cro+S+QnLerUBTFFHRXIvo8kXN1HMLCoribLiiBJYjNJ/lMoWLXXgvRGFZxyPckb9ABDLi9Lf3E+Qs/E+3xmnOGGlUczhxqWhkWwQDpt79NxXXF99rm4iJps7cQZj826nvxZUu1EpA/SSoCVsrgjqNnxsgweDanhjTeDpFblzyDop6qETAGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnlV7IK54VMzcwDKU3L1k6plG49KaRrWH7aTY8P91bk=;
 b=hCSsdrTD+6T65Ef0IWjlXcGoFIm95PSvTqMbMSwZWssaBo2+zeQaQ8auoXsDi05etec/fY+vKEVq7qASVyMGXzplNZczSEAVrs71431dWHrx0fLtwcbEZvjTxeMWFd6EQd3sbKnrbgNQ0/zDgYJRyoH0L1YM8bi+uk/lH9bqzIqUxTH2kK524qsXb5Dn5h9s4kO6cu9UdvcAiRv3QSrNkln0CmlYLLnuK5sLz25dwSY2rtVIIKfclgGpg1qP9U4kXt0xCkH1QnFDVMPCNHEQ4K0N8jIafzoOt73FBZew3uNxA7Mf69A3jqzSNf8LPebA2u2qQ+OfNAOmeaZhMUxlYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 18:43:57 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 18:43:57 +0000
Date: Fri, 5 Sep 2025 15:43:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 6/8] mm: Introduce deferred freeing for kernel page
 tables
Message-ID: <20250905184355.GR616306@nvidia.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-7-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905055103.3821518-7-baolu.lu@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0325.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::8) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ab9773-8d2a-4a82-8fcf-08ddecac2bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F9JlHV2QNBsV3QEX5A30RYU04/n3Opg/+aV7FX0gZtWivzgqSE7/qqcL1fZw?=
 =?us-ascii?Q?yNxUN5lnfBwTSh9nb65do1lP8+faEC/VUbVz373ytHrHHK4sGPj2bktauo00?=
 =?us-ascii?Q?xkaZBuHuV4X9mxMGImc1UVgkbcPAF/wajUD5Ae4krX4ygnBqryTl5s2fL/EZ?=
 =?us-ascii?Q?PensMP+kkZGzFaVjgsYn+KaES+HmJF7rogS0/g/lPbLlfMxHr/pgkh+NSFBn?=
 =?us-ascii?Q?NbBPGSnL0elcVtKTwlxmqqBLZw1BZwFnbq81X8flkAOdrgVND9q0E9upoP0w?=
 =?us-ascii?Q?gH26tJMqeEj5H+8k121lz8UWRv6BAWvo72oPqV0leYDMVyJb7PM2o76+K+nX?=
 =?us-ascii?Q?scw0cuTeDBPsXBYw3u3Mqv+/EW0jedvIl5QEnGDIjRsoXt12NkgPhPlnVb+W?=
 =?us-ascii?Q?ORcIq6DSVTMgBpLEwpzuy5JzMt7Ayd0RTlQC1acKviiSFOFcCr1IONA1FaLw?=
 =?us-ascii?Q?c+k2Q52UAKL9rhhEa6C6SjAZOOBHZe6Ho+mcS9vrJQOllpg+Y3VsADI8mH+i?=
 =?us-ascii?Q?yEzZiPsuLgCdNwObziRT4RjnSayhELk3V8eIXTeMyh1cfw61E01O3g2hodeW?=
 =?us-ascii?Q?kWs1mjMCkVLPdcDtz/KGtuPvvV4vW0O0+06BTokVDHdcg8C/AXeoiCrDWcdQ?=
 =?us-ascii?Q?cH3hbJSDmW8ctg6xwr+zRskRgt1bYtTr1l7ZeHPpyd8yQkOCdOaSpP74m9Zc?=
 =?us-ascii?Q?4HgBIyyduy3UCP+gC6zZjzpy7PLNBz5dcLhyKP2s/UHxlgVo3cwg717A4SYb?=
 =?us-ascii?Q?M0mQEqRrBzynOBc2tKpjjwWaVOdRfeZz29vXLdK6O1QUiUaD0yA4Mxsvvzz6?=
 =?us-ascii?Q?gO3xSYAXynp3kRjx5O5kMG/EyR2eXGP7wnDFuG2fA3u3Ls5O94EFDQO4xwHD?=
 =?us-ascii?Q?Lcefr6xKCu8UiKeWul1dSE51oVlJRCbJ9x/jqVM0EfyrQDq57TyR0mHu+AwT?=
 =?us-ascii?Q?CS0zKlfWM0/rpvr3ob8DmztuSRlBW6G5NxZS4yhEdufr7fpi54nWwxuhpszE?=
 =?us-ascii?Q?xV3tp2xYTy8esen2bHwuzgTANhblLeGqwdNE4YBLBycN85w7kbTb3/ju4j+u?=
 =?us-ascii?Q?BDJvj6FWEFOPgH4KjfY/dWaHXVKheX6kD0BVprnA5pQoR5nKE3WngM4xvA/3?=
 =?us-ascii?Q?tBtpXEre46d9ZvQCGn+CTJwnrCgLv/hISEQdBlLVZ3qfgpiBXoMElCUNlbQ8?=
 =?us-ascii?Q?sU9SYepHWYl8ZwU2f7iCmV2D/i7GQ4Hn/e/4r2EwLdaG4DmdAYX9aa0yj8Ni?=
 =?us-ascii?Q?cqcuIYldQElUj3KlWaayU8OlTLShP4TJYyBsWgYlX99R55GnYcTmACFWQZ0f?=
 =?us-ascii?Q?KD4DD+erf8LbmGExnzlsdfDX5QwT2HvPFxhCe6zTWwWX0o0ADxcK3WuIad41?=
 =?us-ascii?Q?wZb1t/V63io5fr1n50BnAbIsDH4ON2hBKvJJhH49iwAfCK7YJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KHJOe0lkO+2VsEwo930YuRKM/tKh6bjIPmJDCKOixTCFXRsKtRU6bmpiRFtc?=
 =?us-ascii?Q?WGgk8qUXYzSQezXxbfRy7QHHz2usDiIGqKfnSJdb/eVcbxUSsECYTXTEz/L8?=
 =?us-ascii?Q?9aN+AsVpMPQThEDSW6mfveB0DuCib5MTjBametxwXawOKkS23EtdAEh6NuUe?=
 =?us-ascii?Q?iFMqTkRY9yXhSXt2XXvasQWYZQHJ/EdtfsWd4Hb8wYEWzm1HFK7TSOZ7q8UC?=
 =?us-ascii?Q?VhRXZPbzsoD2jfr+bW8ViDUwwnWP8M9kTafBxYcFSA9s7SFsT1AZwB0QMMQK?=
 =?us-ascii?Q?x34KnDR+df7igiWSqJz7fivAGcp/NFcjGGWypChJOKizALjlOY8mVXAvXUsf?=
 =?us-ascii?Q?sW6XzKrVCK3DOdxjTfPbJG/H6n8M41ctdLgjdRQLEHt2TB5rTalpePp8btzK?=
 =?us-ascii?Q?D/j3i/FeBRgXe47k2aJvRu4rLmk9xHjRlUbB7zgAOTqlf6ACnBeK/EtbnSmn?=
 =?us-ascii?Q?LRM6hmRBSnUtARl3rOQQMtgr0+8+/lQgIBEO3+czbKIYIlRzLPxfBl38pouv?=
 =?us-ascii?Q?nbbzy+dUUQyZnqOUWDu69dygECo3RZsbc9ARnSfsYezpRf4q7OiNrDBY6tNT?=
 =?us-ascii?Q?zhPoFG1vK5vIUCJOvYs2A+RWATWa5PdKcr8wbC5kgSNNzJA2cIY9eNKApA/U?=
 =?us-ascii?Q?vQqUjtXVmu6DfXPRDezJIdBeKi1t44W6xhoU5Bqlxw0BIO2v2RDnT6SW43r+?=
 =?us-ascii?Q?ONprk8uebz8/M1tbOECF914ozOQgz21WNK7hWiIgFFgpSqtjFEce8F6ai0/G?=
 =?us-ascii?Q?Gx9+xonrub/hKIiIQED5RXqIiHGg3MeFZoMkFFZnnvxUEiFDhl0h5IgDFROm?=
 =?us-ascii?Q?kbxrvipTLvaSSwWAm7BNItU4wanJne8u8tbRr29SW4X7Xs76zDnCNJtWqEPW?=
 =?us-ascii?Q?Gk+Xv1l8I0Cff6yplDLCYNgPdTVQjuZfokuUDamF3tO7rlLtUsFWD+DOLpy/?=
 =?us-ascii?Q?BSAEqNh+BI6TsSK5rINQXeB+QqiTNrbRUnmGLqnRHl/EG0jBBbYpVwd9Gru7?=
 =?us-ascii?Q?/D5K99cvdHHfIVMGXHUUbqOGNv8NhkTHx7t9tqCXcrnqXgSff7WEHOZ1azZi?=
 =?us-ascii?Q?SkJK34VL/dDbWeKVIqulZtLsYIu/Uobrv+hpIIZzqnjUl6dQ8j1Bfj+lqSBy?=
 =?us-ascii?Q?vf6xM+cKdxbc+Jgka2QXZsJenTpkdjGS8UVFT2sgxu21nSOhBo0ET4iUfqRK?=
 =?us-ascii?Q?C/HicZuybqD5ZuwEff8yHbzdTG7cm15V1m3l74RdLALJpjXEiF3S34au5Blo?=
 =?us-ascii?Q?0oP4xe65NQRbzCW0X8QhDNaweFymbgR/l2uPvCTGD0C9ZEvI+zIiTVUUCgzi?=
 =?us-ascii?Q?NflgxXnI1aC/Si15QdvUUyHK3f2NwzbBqdAx5xsiPo2fVYoRGYjycLRSCO6G?=
 =?us-ascii?Q?2UVUUzuFcIB+itHbGVN9LhGH8cdbhhRKhBsAD6B3t6RG8o29jAWRXst+mNYI?=
 =?us-ascii?Q?FeAqwqb7BPAgFmBReiwE7nTY7rrjN+ME0Lu8yEH3fzJ0juDKBjERiwV/UYNf?=
 =?us-ascii?Q?T1iVWP8WRCz6C8MM0Kt5njLHS2Sn94pgurNEmWz1FVEc2H1KVyR08xUWgeyS?=
 =?us-ascii?Q?RyhI7fTcqPZ9KwCgByI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ab9773-8d2a-4a82-8fcf-08ddecac2bad
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 18:43:56.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLAYxiLcvJ/s98Ip0AxO3AGKSRXwh2E4QUoxiP6QILww7zQUBSyP38p7OGZy9q5Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195

On Fri, Sep 05, 2025 at 01:51:01PM +0800, Lu Baolu wrote:

> +#ifdef CONFIG_ASYNC_PGTABLE_FREE
> +void pagetable_free_async(struct ptdesc *pt);
> +#else
> +static inline void pagetable_free_async(struct ptdesc *pt)
> +{
> +	__pagetable_free(pt);
> +}
> +#endif

I'd probably call this function pagetable_free_kernel() ? Weird to
call it async when it isn't async..

ptdesc_clear_kernel()?

> +	list_for_each_entry_safe(pt, next, &page_list, pt_list) {
> +		list_del(&pt->pt_list);

The list_del isn't necessary, it doesn't zero the list, just _safe
iteration is fine.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
