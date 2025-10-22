Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356A92F3C26
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163326; cv=fail; b=vDj5zBGSnbdvTz9MaubZev3u/qx3p4OdIto8kTX5Fek8cZso4TEySwmwwdGnQu0eQKegQJmW1PKFdsvOo5UxYwprT9FdE3E5ynmEcJWiVT7eE+IZgFAUDoBfSoiKpRYHTLmnqkzjfP/jSLiTSs7zkNsJUc91vwwtUBadcaHGHvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163326; c=relaxed/simple;
	bh=WqUnESKPxHL8lvhNKFdAwzWnGscaaut6tv3gcosoGpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VFF2mdJNlqDOgcQDEqKLfCOcVoFASmIl3OscR4VQX5seWRqaPwxLGRXsWnWCq3DFWSHOsLNjyB+u8Iy5Vn0lRTajUFU0eGI5nKlUep5P2X9NO8yNw6m7GalChn/8zFAMm6TCXcjRkO4FnztkwOxbUONWPWWID25fGFnnGYYpXYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PSGhhpLg; arc=fail smtp.client-ip=40.107.209.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PSGhhpLg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pnr2Na2rZNoCBpPcrv9MB0DlTKcsTe7/CsZ/SpOWoKI4mTw+maYAmyRc2nFFVjK728v9m/PjQTPhlXgHZTVr1SqVX2Vvrtm3QfNzrxJfGxOQbk2Ei9bC4TOLUPIDJsBwPruNzJLS7ywXb7A317POR/jzrTfCheQwIee1pG7dn+AN50vOk+Vnl7qRF0sWdX9OueCQUSuslaAhRV3R3JkzloKSrbu6H3gCA3oumdTfEVMvF01fnuSRHnyAdVYsyobPLvFPtrmg5Tr0ag5CDXdmVpjALHpyaG0YiR5z5cEbKpXJ+DqxGrE/aOIx7ix+jGX69vTZ0sxntXIN6IxsxDDkJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcJDc7YRtFQCQdDECOmHHxhcxG17yYvvRabwXtPRA48=;
 b=EOP/7hrf1VrCw9TGAqnRe4o3oApYNS4OJuZPE91jYYxqojSukELIXvuZz0Rdy7B5SG6+Df7ayFJ9i9e+cy3iGnasSCAWeD7TtcPtgmjoFt8o6FZ8FsjG2UX+l+Jw0Okb4o6A2ReYAUUcAPkQHzdx2/iIxo6QeoxA46kclvhDuZBtqZy9m0fUkL6HZnDSmY9+HHetwHD5Hr7XOXHErF+QcMKlbsGPcJh41Kh5rzOUvjIVhQfLdP1/S0Dl5yT5RnXA0qr/snrTULQUBNtXSbrZFRtQ49fadOt4Kxf+q3ShskjJCrnp5pN+FpoxBg3ZRTQWHHrI3sK93jRwwp8AIMqR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcJDc7YRtFQCQdDECOmHHxhcxG17yYvvRabwXtPRA48=;
 b=PSGhhpLg+T1WoW9PncL/3B26vyQFDQktslwi5XAEqVKQt8HghmrQGDQnpw38hiRyBcLg3LjNxJ6O588jTieTsNvDsnBkFMQlOKxmrM/PKihSISJdkpsiQSoagvhR+8XTrCw8MBrY/nkdBW1wIVVEGdwVTJCg5uCPH53EagGTwlUR+DoAfWSW49xxCLWco4EQGy7XU5Bks0BvXhK7hB7j6cWblfaJT6t1Ex0T0I6lCOuotWTUs8VZaNL/5aTX1sVMBPTF8sdw6UXFKs+1hTaiUijYW92kCpykJCvJre9qUEb9LYKZoXLszV98vQ/L2stBns0JXA2gUkrX2EXD5YzlXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BN5PR12MB9486.namprd12.prod.outlook.com (2603:10b6:408:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 20:01:59 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 20:01:58 +0000
Date: Wed, 22 Oct 2025 17:01:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v4 12/16] iommu/amd: Add support for nested domain
 allocation
Message-ID: <20251022200157.GD262900@nvidia.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-13-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021014324.5837-13-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL1PR13CA0406.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::21) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BN5PR12MB9486:EE_
X-MS-Office365-Filtering-Correlation-Id: a4de2d53-24bf-44ab-6daa-08de11a5db84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YotzhSzqIj9uqKmenBkGI8lou0kPgR7wTkOsLWJS+3WH8csNu8BFfmNNw2kl?=
 =?us-ascii?Q?QWznzk6dxqEWiJvnTDhAxD+6CwVg0Cf9CJ+MF2vu4aHZ4SEmy0RSkwN+9Xtu?=
 =?us-ascii?Q?g/OzQaAskHsnYIyoaiNNEjs3GKhql3gEsgiRlW2CRi9cXo6EqAWV21nknUYZ?=
 =?us-ascii?Q?nWqRk89rR9DEIBMYgXgzn3y7GYv4p33fYhPDkVl6HkEo9jD00DsjrdB6GWhX?=
 =?us-ascii?Q?E05zqZbCGaL6arWdQuNG7vku55Z1YLEOuHLOUNaEuEz15dY+mclm4/dHUhyG?=
 =?us-ascii?Q?1TA/VqB53lPhrXh+kKSuARDAv8XggsqEPf2mkmVAtjl2f7Ds2UIM2ThLbKSC?=
 =?us-ascii?Q?gArtezBrNvVSOTsVmkeChyw+hhWiegT+rBQ5bg4OtnUyT98Toh/ZbG2mRVOm?=
 =?us-ascii?Q?7SZiF6wt3YPjCExOxFqtmsfdEzqCzmcBhLlrPzlsP5pfMpWIIGh+ZWLFXsYa?=
 =?us-ascii?Q?vWBfJ6WV+Mn/6r4Nf1yXqwnvIkjhsln6U2vomKvwl9kzHMyltnceavGbhH+c?=
 =?us-ascii?Q?hTFwcd8GyCINvs6E/0FpfQw8KDUrgm9/bjaaJoiJpNybAIVLIGBo/e5BoB0B?=
 =?us-ascii?Q?oS2cXcsz7pfzLvLQeRSjjUHvS7dkDprC8joGQldb+uFWHKS64myA/CvANpne?=
 =?us-ascii?Q?W8qc3qrXh61cqY5iYPv7/ApqesKO9S4Ov3y5s4UfjLRBbG04hIEecBr20MXa?=
 =?us-ascii?Q?B+QXewDULSZzuX+JtjdAGJfr3+0QZGd0T9nUUYsRTsEyKIikXgGPjtqM1Bh8?=
 =?us-ascii?Q?RPFp3Rkk04o21isJ+sBZptIYsHEuwuHnigczdsCNZgaLBxJfAWoURbm5Ccpa?=
 =?us-ascii?Q?5ic+ymwzXOTk77MMEouHbVgQjuI7xhXtDna3KVorm99AjMtuz+f6GSXoFSg+?=
 =?us-ascii?Q?SGzjTiFtZJoYUQmYyvdWYlb0pJXLfFiTw/xD7fs86tznDvqinwMl6XbFW4A1?=
 =?us-ascii?Q?lMrnVeRYZUhMDFApDxuHBQlntTaiolnS52cdf2aiQjl7vs6264wyXhsDxceO?=
 =?us-ascii?Q?dSTbixTqwtB87KFaKTNo2/0vBS7wJ6MY1vpkQt6Be09EXynLNUwNHO5d3tsS?=
 =?us-ascii?Q?ZHZjNN/YxzHKs0lFvsYKkLewj/gPdeMiXjPTciCAnW6C6LPFmD+o2WXLKFlv?=
 =?us-ascii?Q?F4haeh9O8M3ihRmbtOqU6yb32na0Uo1g02yUBihqK11px4tfFZ1XHqQxTGzt?=
 =?us-ascii?Q?dT6L2CvKuN0LzeDoVEfxHW4C0FCqnQTkZ61euZoqXa3YtHUGSHqkjG2mPJA3?=
 =?us-ascii?Q?darPLFLC8fpfekbrskcPDRcfza8agh15/XIRG5jNN7eClkaQXLZOzei2emWu?=
 =?us-ascii?Q?2rwpoGjGbanZinBvWexya5ixDRD5BWx8kDYV/Nwp48QgNZDZwCWwQE7sNEyy?=
 =?us-ascii?Q?6hJjer/LN6Ad9idnp0Ft0lYh1/3gP+jn7Sl6Zwhy6e7Qi19vj/kvV4yRtL3T?=
 =?us-ascii?Q?EqbtJV2/wCm9KRlx7q0z88eJ16GvEJfi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XbJKcfXYDkdFkEd/lapSb5g5sDbUmRJHDzltbCUi/TDW0C7A7YI3wgYG9WOy?=
 =?us-ascii?Q?nu1lxUt/zF9zGO5/N1y7g5g/UadrRoHW2odml9/VLLzIQFHZues54iQ2GnYj?=
 =?us-ascii?Q?U34FlcsQ9Qewq+QUzGvwB+xcsG1LBYw+4PoU7lbpGB2HHb9DlOqkf08pOsAh?=
 =?us-ascii?Q?znRXS/ZOoFY7KtEPqKJdRp9qy4WmuWhwZ+fOm/Zf2w7PvHo2uqFlb1TuOWPj?=
 =?us-ascii?Q?7yXcSQHVeCS6tQv8PxyNJ6MGUYQIG0d4TMDRJshVjLjnaK8a6OvXvnle8teT?=
 =?us-ascii?Q?HJE8AHaK6lVz4tj7fxS3OqZ4KPeeEV31zyag1U22LDWXEvmC4a+bzyjp1PGC?=
 =?us-ascii?Q?KF2/f5NjJL8l/iiv7Yx2HRztiCG4EEbcLhXAeVPY95ttuH9dBHulbpJ/9lFL?=
 =?us-ascii?Q?SzKmdLBm9/bl6uXgwV207sekiRcoYEgWmVsadQ+IT/bkE2nIbX6nw96M1ZuY?=
 =?us-ascii?Q?Tarr4q1R6Yh0yGPVpIkqeBzI/iWgM1if7iPhcZ9bBIm0FjhNqWDp1jvwblQM?=
 =?us-ascii?Q?PkdKV2lXPDQixtXO27eh04EOgYPlVMWDYbrTSj3Rdxbl+NgCL6VKiFB6asuV?=
 =?us-ascii?Q?UNvH38RdPsGx+NmleuPPfEPJ5WjF7SlTvPGrQM6/aEasR6ZQ4p2VzW+mhWbx?=
 =?us-ascii?Q?y5PHxZBoGEs6gAy0OUpkeliQHEZY1iTD7Rr7TuhvtfGIKEFxb/LL2FLbJ4pt?=
 =?us-ascii?Q?b9QErmC+pUs8hXACCHnf+e7JTM7P16Km69N2gA54yLvuMTmrtgZNfI/1sdlk?=
 =?us-ascii?Q?i60a8gWAwEIzuDADgu/2kvE8j56CosDzaLPy1TdXYdz6v0KUCQeYYPEW9zer?=
 =?us-ascii?Q?HtXa3WgETRo+r4qcS4zTsYRC0kSSF5Wsyfpjdl561cUvy00oR0/+Dwkg6seE?=
 =?us-ascii?Q?m17nova+JH6K72yS6BTN6+f1LbqZlTvxSp9pENO2vvuAaSjpV87XC0Wwa/W7?=
 =?us-ascii?Q?OPFDEGLvEqt5ohf/ZngzKy0RefYTZizNM/YM/1eQFII2vRzI2PC4TKAkBnvH?=
 =?us-ascii?Q?00WYeWjnmA2FZ9KBImWBRx0dDJU6MDrMMF0UubN4wLgrK+iWI8a02TQzpQXl?=
 =?us-ascii?Q?wVyxsOubwCOonv/GDcvBsBG6sWIZYl7vOUvK+cBpcVErwZuBc95fjPvYIcFL?=
 =?us-ascii?Q?2ID1JzCXF3gEd+gWiGB826BbePa5lnMMmIRiEjiRqUokI4+S0a9ayztE6let?=
 =?us-ascii?Q?4OCnE/jyrV8aQpcJgpCq828SoKggwp0auWYLr1mblRWXvJY4OD3XKgLjqMF0?=
 =?us-ascii?Q?LH8x07FXiawiGahJ/pptc3b0PDSMVfRTOYE9mdHXoVHYYnUY4Bg21KEzXKkH?=
 =?us-ascii?Q?DlGj27jnP2oP1TTHM1OKVRGma3un7UT9zYzPg5tu81LMslC8cVPpJRWUti6g?=
 =?us-ascii?Q?1P4Ji39a/eJbKd8m8eqfzm+g2IuQ12xapNnGG5oHn/sz9jfN5OGcaD/2fjFd?=
 =?us-ascii?Q?ST9EvIbrbf+2NZaxhtqs+df0zFL9uzygnO+BshJCMkggo58Fklo2KHnZtE6t?=
 =?us-ascii?Q?isFk2d4j2EmtNInq62Mzjr2tFPkDXlj4oZZho0gnn7b7+TgF1BDibDG5u1+0?=
 =?us-ascii?Q?R/3IA70mmX1BcVyzFkE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4de2d53-24bf-44ab-6daa-08de11a5db84
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 20:01:58.6571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLU04k9RB94273NDOg19Gtuz8lzzwOWwfeg0/N2XDI9suH0iK8GrgvvhwnmznNMt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9486

On Tue, Oct 21, 2025 at 01:43:20AM +0000, Suravee Suthikulpanit wrote:
> The nested domain is allocated with IOMMU_DOMAIN_NESTED type to store
> stage-1 translation (i.e. GVA->GPA). This includes the GCR3 root pointer
> table along with guest page tables. The struct iommu_hwpt_amd_guest
> contains this information, and is passed from user-space as a parameter
> of the struct iommu_ops.domain_alloc_nested().
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/Makefile          |   2 +-
>  drivers/iommu/amd/amd_iommu.h       |   4 +
>  drivers/iommu/amd/amd_iommu_types.h |  14 ++++
>  drivers/iommu/amd/nested.c          | 111 ++++++++++++++++++++++++++++

Might be nicer to put this in amd/iommufd.c, but up to you

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
