Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322526ACB
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763510543; cv=fail; b=LmJSaDWPD52FxKHRQxQJfNXv3OJ2dO2JsMO8LXMm+xTSI3eknzyMw12Y6ZRSCdGXBWWR763PWrOI5WrjI4ko0kk/g8qhdgRuqScgwroiASvHdbWk2W/ybzIVcuy6hv4n6WnFbghdDiySmPSISfl+8jzcle1eqv1QakMuhnxQIwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763510543; c=relaxed/simple;
	bh=XnEoIU1mkyhfDYHKpE4PTsiIXn4GWm0y0UoGc2KuDq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XgpkGlj3VfJq+Pagbj+yABTR6SBwjiu/kuE6AN5lll9m6Gp6XVcJ310QkR7rjrk1P4yI8lzpPylZ3S5/mDuDLEpFmOVCk55UZrGL9rDA3okkHI15v4tWZp+PbdbTY8dPGWosQRNxb4o5I1GN8VNRGu3r2MAFVIuhVcShzHvcc7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eOaSiJXt; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eOaSiJXt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xB37vHreS1lpZHCy46QJRekygC7Y1SuLgKmllRVfTEogat1r5ZcCH3z2tBlCqnA6BU5FrgV4iI1KPtHZwYDtGuAEMG7clbg4kPa+dMWj7cEYkD3rQCb58gf7tYbu4D1ifhfQXsX2260aEky+FQSd+W8nnLzQ7lpMA+6Cy5cdDPj/6NbC0J0e5iQH7PdRqG25h181PLZauPykvf3K3lVcD7PGAOYG2dVY6IlRE9hCtE0zOA8dK6jRq11znpqq9bGRsrEF5nKygrh9iy41dlKptyBdPm7dY4SQAlWQMSy6oggSNn1iwE9gsBVYhCRfnciiF+U2Ax6ORZ1tko9Mv2uHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hIc2qH9Z4OZbZCvwwVaoH6ufUP4p2kspISDsvrEXcM=;
 b=BoQmq8DotEIN2M0ur0OBJ9xdTH/45DQzkodX8E05T6VTV8T3ZcOolIu2J8Q+s+aa+I7y4SEXJqXMRQfhCQBWVrmGk12V/3yS0z+oGI6MR9LyxNfdbIfUtLWFy8o8AD9CrteW7Fux1FnYWp+06jTtF7VlfoitRdBfjgcqV+zrUfvet0KDfQuXAQOLkk6pqpL6wCvYi72aqvi8g1FhzanVCLoOI7pebLGW/NCcl8E5z5rQCJrocRxlBQt2hM0+np+rZuNUJ7vwq6H02X1AXlmZo9s/jsLI+CGSImDdocMGlJYBlBVSd54kwdvZjyVSadRZCPcUgkisxshV1cqN6hodlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hIc2qH9Z4OZbZCvwwVaoH6ufUP4p2kspISDsvrEXcM=;
 b=eOaSiJXtCQTkcghH5y/IHXEeYtni33Z+c0ol8bl5tZjFNlRWTWNQCmHaTxi1Wo9OL5TMLnXTFRqxPxMACtt4V9s511xF7Ux0sAzmkmv9AUycAvZqOVaYvWUvaUCCIILfSp2aEF4R6FitsXrWmfFjhYE/ZjBG0jYyKaQCskGcg20cAU0pXYTKED71HbQZLxHTjCaXcf8jgyicwLEIWmuNOporEMq9+7X800/FTJaNBxtUSTIzhyfBxQj2Za61vHgedw4dsMlNsfPwb+2Wt0E2Ftr4DSI9aiyTJaz1Xdsfe5vmivVuKghRhecoomBAQmIoZUShqsSb5hydA7dgZBl2YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB8473.namprd12.prod.outlook.com (2603:10b6:8:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 00:02:18 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 00:02:18 +0000
Date: Tue, 18 Nov 2025 20:02:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
	vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com, joao.m.martins@oracle.com,
	alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v5 11/14] iommu/amd: Introduce gDomID-to-hDomID Mapping
 and handle parent domain invalidation
Message-ID: <20251119000217.GG120075@nvidia.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-12-suravee.suthikulpanit@amd.com>
 <aRZBN/nBz6lqTzmt@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRZBN/nBz6lqTzmt@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0351.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::26) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5d7268-e53f-4b12-b3fd-08de26fee7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D2bhePrmjsxIrqP2kGLWxSFQZbfx7EoSOXs2TDPo605JVqMNtnpCkRB5URQF?=
 =?us-ascii?Q?nBht/kzFB0D9yVbu2tpwy2pVXMNilmLNUlpdGMVzJeMFRsu/dbBgt5zJ/rKp?=
 =?us-ascii?Q?RPqSExnYqkjiOrlPzmEhCeSeWC2FoihKZLO8tBnuCXRmgAMjfXCRuDaiClxk?=
 =?us-ascii?Q?aUG/H8yzBIcpk1FVqHiAay+oD6Da9TDf34Uthu9/SvRrgGhZ37awIcRVWeAj?=
 =?us-ascii?Q?7G4Cx2HnUaX7WhbYLzLzZ/pJ5TXGmKuQGSnXugqulj07VgIULLX/hw9G8cF+?=
 =?us-ascii?Q?lsZsZhS7YmjbMWSbbkO1btluuDpDYDFDauBQmuPJP9k83pPaimq4kHrA57Io?=
 =?us-ascii?Q?XLZ7eB2rCgdip0JQ8sSJZdaMnyzNB5FP8xU/MvuMWOQ6Fug/oTafeOs7+3fS?=
 =?us-ascii?Q?ca+Moqn2JIHbOxIIGIb7Wd2SUrOErBIXXK6sXcHWqPCDP1slQg/ooSq7eKT/?=
 =?us-ascii?Q?PbfpM3tfmboEq6XJD26SkdZxwMKS5y4PauSWy96f5guic/xkGfcqlPvrAVEi?=
 =?us-ascii?Q?WaKLcXgWSBeDa3YKNr+GBsl1nIRQdSADtoojtTiOM+MPaspcnGW+FiT+orQw?=
 =?us-ascii?Q?LRrhLmd5/nLQVnMPgTeHZ3EYh4CEMvf+q3pZNIt59/SikgcuO3ghQV7EQlVm?=
 =?us-ascii?Q?vtfVGHmrKMEnLoW8CGpUbJ1HST/BeevHo1QutGiGt84W42l2kmM5Box+S4D0?=
 =?us-ascii?Q?LPTpen0P/TJwJg1t+AC2FwjH89kMa8+l7GoK3CZC8PwhBHvbPuXPqTdzaYFX?=
 =?us-ascii?Q?klzMtaNLXdYauT8EPzNkfVXNRrpHKFp0X28uW2ygBAW1supf+QNhfescY/KQ?=
 =?us-ascii?Q?vQxreHlsChDUzyUWoFLyvyMKdSbQ0FBcCxcLGN9JJXZP5HgXPbhZq+CEkeLC?=
 =?us-ascii?Q?13JHJ5Y6LO2/eahUJjFrI8XALRlOIO1kSlCONBy3YwZBlr6KKiWbwQHFsXZp?=
 =?us-ascii?Q?3Ejo3Xzv9GjFfWKxLl0F3nLM1DWrboIVmBHnCJFVHdjXpbhcshNlISxZZP6G?=
 =?us-ascii?Q?oMibfA2w1/BAzXjs/6SLQk+dNVnpS9velZfF2xr0LtgCrKJ33++iTcrhew1r?=
 =?us-ascii?Q?J7ntcN4+56Q1A9GSujpxhP2RZsvZ9hOuD8qOKtrow2znrodO2a/nZC1Z8vDH?=
 =?us-ascii?Q?k2lyIScICAvb2pvdczIk+Z0j4+HQfbgXlBIltvLU7uiLwdC4uQ2sxqJb7Npk?=
 =?us-ascii?Q?NKhsto/9P46X4+3hgS/dPIs4HZPWCg/CPN27/oz7SbKhEPH2c4hGZcdP1Iyf?=
 =?us-ascii?Q?7/Yr6p6XMC1Z4k940xbbuGg3/d7P2lgSO6b5N569a1gYgsu3FcqL3SrjhQpp?=
 =?us-ascii?Q?xLw7x+Dver7X5EAwX3NyePk9EX24z36YORk2z2eV2QX0PzhYLch9C/zD7XCm?=
 =?us-ascii?Q?acRXzg8qfC/q7+buNvRZRRMV9ku4jsXkGW30Ss9lGqFflc/MIYKvvPlGkV4a?=
 =?us-ascii?Q?Nw+oOn486o5CT6B2TQifziZ6zIn+iOLx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Gmz5qohy00O6/8tFhrjvNXFMDlUXLeYL1/HffK41sWHgcKaV149WtkAp5Wc?=
 =?us-ascii?Q?PpDHZE8N6aO0Z+ZuYHBktSfE0NVYoepMAtTmDS+tjuIQkRkBhDfGgByLTIJB?=
 =?us-ascii?Q?q32G9jjr3agielZ/UPic2DI2+qG9pjMzf/iUe5cD1t7TixDysQWXQUQ1wOiM?=
 =?us-ascii?Q?SverLNcAgYWTiGA4qwxcphL5uSNWq5/1GLq0kLGtHk5AJ/20n8ozft7+OuF/?=
 =?us-ascii?Q?WpoYpN8a38ZWsDhscq8/WWCxwibiZsqsFQ8rp957TdwYHuxPqiZEl0BObLOS?=
 =?us-ascii?Q?VQDV6e9NAP8pgP2mtkuz7Qy8ud2deqxbWhXXuIj3q8zcUxq9zpj1wNcGx96n?=
 =?us-ascii?Q?Kfc18QH5hTuZsO75xf/wCkKMmtaMNj2BtRbxAN93h+j4RnLraY1dJivq93ai?=
 =?us-ascii?Q?1BUf2KCCAYsmv1zyr3jXM868Oo1UQ+5j0haOkU8BrkeUbrY1N+fYcdy/inwo?=
 =?us-ascii?Q?fVWBRjbDQk7pZ1h2LWdmtNNPCT2/8rvCtmF8vZzfTL3rvuVBe3GmwcSVzbmo?=
 =?us-ascii?Q?QRyToSovwLm6j7o/rd14ii7/raTXbaXwoQW5YZ6bUJv2SwhbGm5RM1MgBzG0?=
 =?us-ascii?Q?7naZ2EkzK31TWHMRB+CWolXTmZ6DH2U7Wv/rZcGlnMDYhFFUu3OwZluQnmpp?=
 =?us-ascii?Q?2W5qFEfF0oFhO6xIGB6ulBykOO0Nib3fjWjXXG9ZVXg+CtPRlwJiOHkG+14D?=
 =?us-ascii?Q?LtyFPkOpB0iF9v/Cr8seQV8YHoJQ4CPA8ekTU342VbvdYP0Bod80R19WV/+1?=
 =?us-ascii?Q?bf5q66AacmVJLjclqbNqlIUW2Z/ZflpyUHIizlk6UHhp5wpUkRCbNkJ50Drd?=
 =?us-ascii?Q?ArsxXmXhxAgeUQp5HxeHw5IpGNYO5TwtcwxMmr1qWs+vNcizf3WXg5XUdpSz?=
 =?us-ascii?Q?VO3fd9axwWAevngU1MDDIEHrMTkUQnePzN4VZxJaxCGcw3eXv6YAOQxsAkOt?=
 =?us-ascii?Q?jsLCcdo1T0O34SGHkchrGoktp3DbxvFU1nxiw+YPVbKAcMz+T3AvH2sU1LAb?=
 =?us-ascii?Q?pqQ1nUrmsXNQ9O6dI7Gto4KExs7rAJpUX1Ywh6Bzif/cmqhlm/aiH/iWdURu?=
 =?us-ascii?Q?c3p8EVgdWfH4jm4aY+SruJlrq/+TySISNy7zyNtufI18rP1WG32kVH6M1IH+?=
 =?us-ascii?Q?RTNtZm0XIXNxHTMYhJZprF3fjLhJrk090JYKTmkTcZsUWX53PmHqtl2zPjUs?=
 =?us-ascii?Q?UVjEKCnouscS7d1wG3eLBSOIfvdrzb+LziKBNxteSNr14pbacYyijy8W3IGA?=
 =?us-ascii?Q?JLSbDGjpvKKDA+Bt6pk5s4umgZ3b5qxAQY99tcDNY/Wh57ngsmkTPFReqMEO?=
 =?us-ascii?Q?uO6KP3d/2t9tbmfc7ulnu301kpjxYHCM4g+Ovt/VmhgpKIK6Gm1/AWXv11BG?=
 =?us-ascii?Q?+WPRJYRw/6s1TR+BJtTzlJYsx4i+OTr1ZdPD85WvW9+7g5WSDKnMuabPs3BL?=
 =?us-ascii?Q?T+dNoV2iW61roGsMLgd09S+IpD19eIdNuSdyGXexd5dDpGPlPrDpCxhUb7nN?=
 =?us-ascii?Q?JJAIiC6u2Qq2VZK0p3wauhXp6V4IJsHMSCtNmrZAzSb1AXBnS/jArWPpC0CC?=
 =?us-ascii?Q?/k/ZhyWoesp5zFiUSGE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5d7268-e53f-4b12-b3fd-08de26fee7dd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 00:02:18.7972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yA7laFF7JG7NlX9M68DbSMK8QzqK9/L7xVf5aP5rOqYadcmFGE0V9vGSgs75sMVZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8473

On Thu, Nov 13, 2025 at 12:36:07PM -0800, Nicolin Chen wrote:
> > +	curr = xa_cmpxchg(&aviommu->gdomid_array,
> > +			  ndom->gdom_id, NULL, gdom_info, GFP_ATOMIC);
> > +	if (curr) {
> > +		if (xa_err(curr)) {
> > +			ret = -EINVAL;
> > +			goto out_err_gdom_info;
> > +		} else {
> > +			/* The gDomID already exist */
> > +			pr_debug("%s: Found gdom_id=%#x, hdom_id=%#x\n",
> > +				 __func__, ndom->gdom_id, curr->hdom_id);
> > +			refcount_inc(&curr->users);
> > +			ndom->gdom_info = curr;
> 
> This looks racy..

Yes

> When a gDomID is shared between two nested domains, a concurrent
> nested_domain_free() could enter before refcount_inc(), and call
> refcount_dec_and_test() or even free the curr and ndom.
> 
> Then, this refcount_inc() will blow up, or curr/ndom will UAF.
> 
> Actually, I don't see where amd_iommu_alloc_domain_nested() gets
> used in this series.. I assume AMD will use the iommufd's vIOMMU
> infrastructure directly which doesn't mutex across nested domain
> allocation/free calls.
> 
> So, the entire thing here should hold xa_lock(), use xas_load()
> for the existing curr and use xas_store() to store gdom_info if
> !curr, and xa_unlock() after gdom_info is fully initialized.

No need for xas functions.. You can use the __ functions..

A helper function like this will do the job:

static void *xa_load_or_alloc_locked(struct xarray *xa, unsigned long index, size_t sz)
{
        void *elm, *res;

        elm = xa_load(xa, index);
        if (elm)
                return elm;

	xa_unlock(xa);
        elm = kzalloc(sz, GFP_KERNEL);
	xa_lock(xa);
        if (!elm)
                return ERR_PTR(-ENOMEM);

        res = __xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
        if (xa_is_err(res))
                res = ERR_PTR(xa_err(res));

        if (res) {
                kfree(elm);
                return res;
        }

        return elm;
}

Call like

 xa_lock(&aviommu->gdomid_array);
 elm = *xa_load_or_alloc_locked(..)
 if (IS_ERR(elm))
   ..
 elm->refcount++;
 xa_unlock(&aviommu->gdomid_array);

Needs more bits if you want to use refcount_t

Jason
