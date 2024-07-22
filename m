Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEB616CD18
	for <iommu@lists.linux.dev>; Mon, 22 Jul 2024 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662639; cv=fail; b=ojdJcGNS8/UUgDXwNK1MeiMaj+TTWt5uG2Rl/ptBedg/KVA101WGfL0qETlGIHZ8/WrPP5px+EGZDyh+tcziQZYlFyZrMK2i05VCtx9CrCQ/cijwyglVQu3JWaIuqIxdOaAj+gXHjl3SvWj43gbXNl7xb1D+Iu/rPwcvzZqGn+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662639; c=relaxed/simple;
	bh=WG/u5LNHMJxvXKNZ1U8ANWU0xWl+UKgzXtqE4wN2e0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lnQNuR2cR9+wyIs3Q9RKTctrMcOW1h82JRBvD4tK1Msv1b9MKBcOBjhnBvVEJucEitx4HIKCW9ZXLDPQ1kRGNv3LDfEQ94PU+gB8/xCfFjYIwXVpvQYD3NdJmhbaQ75Ybg0RZMhqCsyyC1TfDP7QFEQ4oSSGG9AG7XPAxClhuqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AuU2+L1a; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AuU2+L1a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMCWQSvwBb6ZrOEKaOZW9tCJGmZKrRyfbFuY8R9PBEy4AtCkNiMIFGyD6l47rAfG6lMX4IHMlMRWYza9NnLe02eeFH9eAsAok61tvJYer8phsTWp8teksHG0d8/C2GKicY2iERyTA5LTrgQ1a1/Ue5y4KvwtwZ4L69pU675YrEg2URBeOhhrBvR83VvrHgiSSlkO+4qylSUnD3/mpPSlepzoypbj+Lex6XLSbOL6oUIfH2unajAkJ/q9xc7dmoSmGFSAneHeNOwLLhNuVU8ntsmtR/P3iqz1IwI/7sY3Ndd1t2fCRfuGit/uL+RXNNPSBhgkVdRzjmrpr4aOFbbV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vwdHikN1Au/6JyBRvJliBWpZ6rCy1hA8pe5I6nnQsE=;
 b=CY8S+7ZpTVE0uEiYsJjaMq+4Dm9hgBM9oYsUeKafi9LBee8w7fFK+pC8/v55UxL8Xpw9Nf8ElbUQmkqM2vWzxJX/M03kzWP3a5AUBpwQkd0Z3+pmTWWv3p3hdJDQUVD97nvWQgll9E2Yi//PI7Ep6laoIqBeeY65xfyqDa5fQIxWCa4udAcQnQjQpm0ElwM3ReKBsHpb2DwcrFNiZMlrls41qiB8tBhQdG8NqbydFuRizF164KWdGO/eI4A/dF3zbRzSMKVS7BRVYLFm48tueW/rA58OJKkAuetJ21RJpOPzmJFy6qLZ1fpYmH21nPzzq/fPuRuib7a5X3zxGIU/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vwdHikN1Au/6JyBRvJliBWpZ6rCy1hA8pe5I6nnQsE=;
 b=AuU2+L1azPi7AbEuLvH7SxrSs5bWIxEco1O9G5KwnF61lM0iBSNRGIXo0HrIT78Li1QQ/86NhGoveIs1o7xQ0taR4mCCyS1iDbA2Isp5LmVWRVO3ECRdFdIXjMAFnQ5DX0yPvjc5XuNhhUFAiExWEpHkGorCQu1jECbYDvawgvN+szKH4jgW3lDVqdsZy8cPFMaBxxJrwvrbU4hHJnQphrkAGKecZz7DL/HnPHtqJU9SDVddQtXmKGDmnqesDJBdMOUBS9M7EE6h7qzwxPnu9lWFOuMV75/XiVaX7begqoDzI7Uh5roX1Cc2+w5dxcXmJ0h2E9w2lmxWHqPFowdKJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.32; Mon, 22 Jul
 2024 15:37:13 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 15:37:13 +0000
Date: Mon, 22 Jul 2024 12:37:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC V1 2/4] iommufd: Lock all objects
Message-ID: <20240722153711.GG3371438@nvidia.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
 <1721501805-86928-4-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721501805-86928-4-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: BL0PR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:207:3d::49) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: a731844a-bb56-4ef5-8cf4-08dcaa642876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NKXlNj6JfnLugsEir0zUHth+8dHVBtlYRSeJSvi5UG4FPnhL7pHBobGL3Q51?=
 =?us-ascii?Q?4X4yZH65D64uUOk9lav/TQqtNtLkREWbVsbLuec/JDYtilp9nrAFwJp3CBqF?=
 =?us-ascii?Q?loU2XJRqljeG/HVBJRmaR+fu5ANU9Seo24+P6kdhd0MCX5N7WpWQt1H8OJ8j?=
 =?us-ascii?Q?IaLMrcxDekviDsoYMAaRxZvTr67+zgXNUQAf88RX147zdkDvKL/11x5lFOp2?=
 =?us-ascii?Q?SwsMHCRgmHBujl+d5ZZVW9L+xY2Xf2GjfN6LQi5qWovYfIBU9ygY4OSbuW+4?=
 =?us-ascii?Q?LDzQVCDHp2QeeB3aWU+8FO8hoL7YiDuu9blJ4P7GlI67mos9IH+agV8344Sp?=
 =?us-ascii?Q?VtRGSGdVaYJNUnldvRcsn3p6Aka/Yv5103Vr2/uGlKhmnELymKKAXsUxnNYv?=
 =?us-ascii?Q?3PsYJK1QzZRrbJXRI/uOwZLz5YddQ9cAj0PXWnriupjvrCbuejFqgubMP1+7?=
 =?us-ascii?Q?ZN8iss2tIv1VexRW7/64wedNneIPvDR4F2cR+GMsgKLU+IUGAOh1/WINmFxj?=
 =?us-ascii?Q?Ljj5/RMzITP/+A1RA3CAmcAeQQoKgVvrHLrE5WIl11ByrcUE8ZtuUwj52PTw?=
 =?us-ascii?Q?l07sEJD3dPWERVWs/U6cBbBPkpF6q/eCEdnbYjLSWx2JCkaJYq7WPZtyU4Dg?=
 =?us-ascii?Q?FzleB+k1gUOPCfcScgwF1fC62UiqWze43lctncWJJ/QV4L/lD4RzSVPDcEqJ?=
 =?us-ascii?Q?vcUJZMaFECzXl5h1ZypYbr+yBF79cNlkpoWu9IZI5od+exO6zpr+x5Tg6E7H?=
 =?us-ascii?Q?yRBYzhjoQBEQ5GXkLWwskzIpB/GkrCoTLNWMB7bXyi7szgKLYXXUvHqe4K86?=
 =?us-ascii?Q?OmFrnEIexqbBL+smyi6nWNObLaJIjg3vUFH7KwaGsEdTybz1YZZodhmALIMK?=
 =?us-ascii?Q?mDxQSh2m86PH+Uubvs2UtUS7RKb9ROMzMygaVygPYdxGmpcGIpq2XQ9quyOO?=
 =?us-ascii?Q?jHsmRbNVh2KarKpFMvB6A0b5bop/AQeEN92/aElkSxf1+Yqy2hW6vxZJ0fN7?=
 =?us-ascii?Q?mbiCLB5X3/bsH2tpbrhgMyxW1ayO4Hrsct2Lo4sdDEE4JwIa4fRf+be8sOJI?=
 =?us-ascii?Q?IDGoriboONnsP/46JVhoJP1K4t4juvzYgTn7GjEGIWB+cb2xDvrag6GIJoGU?=
 =?us-ascii?Q?MuDcbxS0/lTo4GMSkiqjXiUuVjRYGJvmC0yG++7w+ym4B6MfzTZcFMUtSEQY?=
 =?us-ascii?Q?L3yPxCHmurwkGNsnRzMWBIX8gUNElqOkFWS5fFNdqnGyiPAtihPRZjFy22ZA?=
 =?us-ascii?Q?Y5AfL6xL60qUVTVsw/+V9DN0hOgXWp8XzKVZglOaCjea7MYhYxaxtaR5XGW8?=
 =?us-ascii?Q?ft3Tc0olImPrqmeOllenBWudNulClDGoL6d6fWYV9n5kbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FoqjKfn3Ytw1V2rbmvuL706uv6G/nS1imWAYKqdReSgdR7D0N/uNZZ5tRAWe?=
 =?us-ascii?Q?8aQ9yxr7qah1cBVyyCwYAGkDTuTP2Vu/4FliE7fIc/5Ce/Iv4t63YJ+oyvQ/?=
 =?us-ascii?Q?tvKKe3Ktah7M6gMapa7wZ82FB4D7hvCyGge/Xyi6L+T6TFFVnZNB5MOWFDCc?=
 =?us-ascii?Q?iH3lEsqLmxVSF68m+7R3NGYrgfNnDMFRSCCOQtXJWEO1QVVwCfMtAr1udyo8?=
 =?us-ascii?Q?UxCKD/wYrOpB4JiwnSEPDmAsX0m/X7t6exk2FT9RxTfRHp8WmaR2cvoTo573?=
 =?us-ascii?Q?NY+9jkTGbhjJ2J7+1MXW5kTXl6jXNIFEI5ba06s2S/zpVtAsVpHSdAaRjD0n?=
 =?us-ascii?Q?Smlr0hH+nYkyXvow4LYMfEuMrerUJE2iXsaOVvtpPiC9NAKqX2em/+VLwaJC?=
 =?us-ascii?Q?PXE/OeoQRtwuuyCThW1XwpIfYHPehswXMlMNmVGyujoWxgDZ1F77Ml7CgunF?=
 =?us-ascii?Q?6lGy2CD1H9PapLJpP6KWZTVaqPnG91Tw6JLU1hKYvZCRV+f1LnKP8HXtsGM+?=
 =?us-ascii?Q?+XCNJGDB2NFf/dDBpFAfmkH620nTdxKt2coS19Xj5IFaWjPBfadVTmdyEZzk?=
 =?us-ascii?Q?YLOTb+JcdpCC+ozvqr+CzZ0QJBc6R9JYp8yn/hsgRWTtXXwDGT6vR7TJrcga?=
 =?us-ascii?Q?aWjpaQTAnZTuztmfbT/XoTRJYOluBKQFBeKjXS9SzC311cgeniGymimpTOq/?=
 =?us-ascii?Q?ez0A092X/F368GVqVJ0ZJyTP8a5UEi/UlN58D6ugpYYQczhb6PuDpb8SBK+9?=
 =?us-ascii?Q?9YRhYcy8cPqNX8wdY/IT59A7TY8hbsOGS+mgmY8eLCb7oY/qGJw6+jKv4sWJ?=
 =?us-ascii?Q?TC7O+a4nkufUCH53VvUoCfJh6C24AsM49MSoWbjMQ00xOHUGEOnB8JV1/vaW?=
 =?us-ascii?Q?AF7OVbfa+NdzEYfJLT4rnpaTva0AA6hpz2++wut3XQ7VVnOY2Sli7YnsWjgS?=
 =?us-ascii?Q?T9tKEOHTSyQGqF27HCot0B6hjqClX70w9MbyJq2E7fyVwbtA3iLaqvC7aDuZ?=
 =?us-ascii?Q?z93G2e++zKAGo+tHXmkD5+B+VUbO80uZD49roJESe7GALuZWKP1jI73M5UQb?=
 =?us-ascii?Q?9N3ER9ycMAvDGzJejXqabI0mzRORPZMHEYZSeRvnQcfl2PI3h1w7JqVtczBY?=
 =?us-ascii?Q?kza0gk66AVcD+9C7MrzF9tret30lrWHO+dZl284w1dDe16Xn/IrR1U4XxkBx?=
 =?us-ascii?Q?98+lVqg4sZyFbmtueCFmN6gc6LKP/bnNJ4DL5S9YSfXErZF0RTMHSNSt7xtd?=
 =?us-ascii?Q?R/1Xo/sInXJQ/c4HxcWXYEKhgLmmbl6eBJgAshhGwMP+C8CcEV1Vq9WulTdb?=
 =?us-ascii?Q?hYxGXd6sM77NymGOtKXmuUTv17jZlyOyKVn74epQwtMkWnAhq4PjWTwg2QRq?=
 =?us-ascii?Q?xhSGXcbPoXHl5P47u0iG3L+71NJCflbSMCa5qmvIbV2meqEM3ce6GwLi/cmR?=
 =?us-ascii?Q?9c6dL9qFd1Py2kFAI44yYP9m6ZISdxG10A4tFRxquAf82cs1qA2ulNoPAtm7?=
 =?us-ascii?Q?C0cWMaAL4rTaZdu9T7fbCKDlp4UV/I4za0jmslqwb3mf5xspPCe3cWy2Bx2P?=
 =?us-ascii?Q?jzgIm4GgeJbF534237Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a731844a-bb56-4ef5-8cf4-08dcaa642876
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:37:13.3433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jn62xM6hhYxgdjWeRckBxzPsjHU6CNuTuGD8OljVNm8MSBPviFzIq8KhIoWMuZtR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270

On Sat, Jul 20, 2024 at 11:56:43AM -0700, Steve Sistare wrote:
> +static int iommufd_take_all_iova_rwsem(struct iommufd_ctx *ictx,
> +				       struct xarray *ioas_list)
> +{
> +	struct iommufd_object *obj;
> +	unsigned long index;
> +	int rc;
> +
> +	/*
> +	 * This is very ugly, it is done instead of adding a lock around
> +	 * pages->source_mm, which is a performance path for mdev, we just
> +	 * obtain the write side of all the iova_rwsems which also protects the
> +	 * pages->source_*. Due to copies we can't know which IOAS could read
> +	 * from the pages, so we just lock everything. This is the only place
> +	 * locks are nested and they are uniformly taken in ID order.
> +	 *
> +	 * ioas_creation_lock prevents new IOAS from being installed in the
> +	 * xarray while we do this, and also prevents more than one thread from
> +	 * holding nested locks.
> +	 */
> +	down_write(&ictx->ioas_creation_lock);
> +	xa_lock(&ictx->objects);
> +	lockdep_off();

IIRC we used the nested annotation on the down_write instead of the
global lockdep_off? See how mm_take_all_locks() did a similar madness

Jason
