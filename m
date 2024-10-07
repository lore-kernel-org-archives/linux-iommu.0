Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9911D54FE
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310227; cv=fail; b=o+GAl028r583q57x1hshaVEJ/0tnHTdcCegbF+ZprcMKqx2wjIbGJV9gRHGw8fExYjc3ETSxmb5vGszSVe6189ARTOmem9308TpDyqsHpm7KCnnqXsi+7QPLKQbkZNu0qOu1o7pk5PDhR9Cioo09JZuONc11gIQUOH7W80mwJDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310227; c=relaxed/simple;
	bh=Sj6FEoeDfVlQTrhd3WNmtlg0A6CgWrkv7uMgqhX5TYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YmtnRVgQlII8uQoe8jxo/R7k09H1cdu9qgqcdSllpDZvVDjsPuDE/Syhwxq5+0VJPsbq0XNO197qTvZDQZweB8h2kKh4RznvyhGVpdwYuujCOQesiMd7SE300mS0o0k27TNsBLnmoxHGGo3UNd0bylO67NC24yLy07+YGqlmrhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pmla4otD; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pmla4otD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRaRajpRvdi9wPI8am1JeLIksUeyw9nwuOhtT/ZTwrMCnEFy/qRohV1v1m0bLrGAABMZTDeVnhECC39316o+WdbxiWLzsb3jyVq3pZJOLxRw2gxUWBW6REnFUw0t4y6v32ciqviz626NwjE2wkkpGlp6jGPU4Yu21ooZMi3nXYi3ejrl2cqC/NE5i6jRd/YDdXzUm/tUkJUSoe+WrcnBDQ1FKMi6tKO1Ftjdn3XzXqWDtRxJG8ehxltEt2rvRMPx2l2UwcNjUcNGmLPfs2+YnWLGv5zYmMMEzOlaFOANQOtVuam6QxF7729oqenNAiKcc9QTlCzkBRcVWzG+gJHQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TripPadSWmZ633hjf8UauxMYp9Xyrxveq0DUFpayG8=;
 b=bG7Mcsap5Xn0G9bgUz/nuhLOYHbXhrRf5k85LOytLrh3xHGXxOm5+8hFtMGceuxzgbQboUrbzVduL5FmBlmAO1LndHC6b1tQruZ4GQ614A0tBXFkIeYaqgWmbnUoO0NytnUT87EqZR9wycCiw65jb/dmRBV+m9sjOytbdhzi5YhUfy7eVY0ILwyDTVnV+JnL9+RVCeF1o+7L57SUq51d9xlVWl/DwmLp8yRP9t+7B9dQYLhV/0qcRJeZ/GuxEZjDyJUSrsox6P/RkeWzVU8Qrw60inNA5+rWADn1FcFXpTI12AIw85WuyDfmiDOU/hQbagppK3mlS0Y5/CbhD+xlVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TripPadSWmZ633hjf8UauxMYp9Xyrxveq0DUFpayG8=;
 b=pmla4otDgKh1jzor6Qpvu7pvzl3wQb2eN2KY7ayucNoK3cbPkWtmXSPIBf/ok5g4gcH6TmAICYif1yltTkDyfKoRpAKZ6Uz0uVjZHGbcOJge54jm7+HS/fZ2G4NmgHwJdRT6T59ovyo5Tth4kCraKzOhp0V4wI9uBTlJwEpTemad9MgKyhaG7q7iLtXncFpA9+m5cHUZIYdCMxIyVqvTPI26cGJZBrd3AQKkwJHmYgcRMXsvuS4GY34plyyVOgW1wNRNWRB9HIWZ149Vtmm4TzLhHWp/oO6sqlJeUBWf/EbhRNrCk2BogplCYiXes9PdLePjgvxyWkeWw3zNQ4KR1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 14:10:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 14:10:22 +0000
Date: Mon, 7 Oct 2024 11:10:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v5 5/6] iommu/amd: Modify clear_dte_entry() to avoid
 in-place update
Message-ID: <20241007141021.GQ1365916@nvidia.com>
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
 <20241007041353.4756-6-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007041353.4756-6-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:408:e7::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CYXPR12MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: 451b428f-a58f-4d3e-0832-08dce6d9c886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QRHQWPol2pswJqecmRCjmrjNoiuBPA6k5qnLw7zvap9ojUsTCXbGY6c5Fol1?=
 =?us-ascii?Q?+Kgcp2ctQhYSLMh5hoYIAaAog5RAYtnV8RucYK9gSqiiEhclEQRcn5yKqzPi?=
 =?us-ascii?Q?m7tk46uPZyXn1hsmWtez7E/kbYQ531JqzkBxvKcdUmH3LE4STL4wzXy/+oI7?=
 =?us-ascii?Q?+E4YtTYbrD2KinwRQzx0IlHWMwHUww4L0godnJ/Y73je+WAn6Y04A/nla68p?=
 =?us-ascii?Q?/rZX7MDZc6HRB8P7Z79Yx0aK8VuDKMFZ+NZlM6xLhY8T5ktQFIU+V/QfBSQ+?=
 =?us-ascii?Q?GhfoYTddlEvyyzGrzBvg5ekZh7rLeBA5cq9tDzviFD3WGsXo7T4bCPbevjfa?=
 =?us-ascii?Q?JHUScpu5lIoryFkd0/ItP8wywh8Wvv0ZGDXl5hrCd+ptEwUw0fMl6RJrjxEk?=
 =?us-ascii?Q?oipW9jal+7ayW4otgXViGwfgNSKSuKFmQw3MNkvbSMlKWAQYq4UQ/9QcZ5+7?=
 =?us-ascii?Q?QB5qe6LpnXughEzLMg8fTDLW1Tyhxg404Kwaxsf0w3GWrRl0LPzx3dPCT4yB?=
 =?us-ascii?Q?U3d32ZbfHabkvq37mr07qaiuhsCN1B7q008Gk07HhMmvo34j4sepIkBQSWMe?=
 =?us-ascii?Q?qZ6VFB0zsZq8hqC1D1LZfHOYkzH3NLfn5NhZHjvwvXlA1XgHTjR3JGcP+xu4?=
 =?us-ascii?Q?BMMEB0ENaloNrntKHggbiiXaUbVkUHBf441EyD4iul+iLwQ1mWHuezPLts86?=
 =?us-ascii?Q?0oBc/8ffaS/EiMkBVcji6Gc8mkX0h4PG0/OSY338sfqBaHyArR3x8VXgn3VK?=
 =?us-ascii?Q?kFk5kwzB5BTboM4nOPYtk5lSQ+kpCDCC80vp2FTUaDuWAiNP31xGxtukBCwL?=
 =?us-ascii?Q?i5KrwHHhTXpcTcqaEjiHJj6RY9JqIa9qQVBdfa9gWfUgAj+bgKDRQ82ieCRK?=
 =?us-ascii?Q?0NjwVZ+dureBDu8RS3/EgPnNcaDob0r8w8sthYhlZsrw+BK56uV+pf4oA7hE?=
 =?us-ascii?Q?6GOgwUK0eYAtXlwPCMVgKfT96JnbbrJbF9TRcCCZK0aa4YcqTFjrxlaU4nTn?=
 =?us-ascii?Q?x7023OerP22ckl6X8KPZKnnIz14hlgSgm+/aL0wFGPjGoLJOownDr1CH08jO?=
 =?us-ascii?Q?ZlMctXIvPM39HYfrlLR/DSCkUQyd1B+mmXUmrYuBP3gpPsi7uU3JxB6/gJ+4?=
 =?us-ascii?Q?Jqcej8urQVLHd2z62X7UMpWQloIpUYA5hZ2DskQodntVfmtXldhqlGJ7kksn?=
 =?us-ascii?Q?v+QSWEbVFPtYm/C8zFYx0g6jQcDaLbXiAyLM/lAV9Yv9QukR+PEz8zAtNxcX?=
 =?us-ascii?Q?xmslZl0Uy0mGeEQ2lvmJW16xTzaJlotBk/zwc8zt3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OH90TqfeLXnc4XgCsmMN2sbaPUGToYj83izYb8W9UBJgkhN0rMo7XmZjBbzl?=
 =?us-ascii?Q?wM758giV0Zji/3QBghRAZuLdFTjQwKAHHMPQEu5Cd/RsN0vBL0FG90PpN790?=
 =?us-ascii?Q?zN1NOSvjttD3rYDqrSg745tkdMCPTgN3T5gDoi+kDmQX10AAfdlwIPaHHvUb?=
 =?us-ascii?Q?L53Ielqp0IdEHzUFV4RiQj8QOsIYcG5PtUZZcBRHwJFaPEk01APJV/CSzcxa?=
 =?us-ascii?Q?l4ZxIe7HmO/W9P9FlCEjSr6omzjg0jdcp8rp0UMw1qBc4wz2Q4uPc38fOBRi?=
 =?us-ascii?Q?GYAmpIdFPo4p20P5EClyYFgfzbgDudecKFvsBkyTh+JjaycoOGSU8YMtgCY2?=
 =?us-ascii?Q?bMtp9wTnHqBWDTWtW//vbxxNLA3lexoKnWUc5WLxZEn3UyDQ299/hUDh63ht?=
 =?us-ascii?Q?7gvKTtYpETN9bNU/Om8OEkc3JbiruLNJRYVlK6V7YB2UwUYGpsnl2Bk8gS5I?=
 =?us-ascii?Q?XL9DnNRBuVv3SbPHFEO+ISxvEsxOm+aADUuTKghigXuEUFAgODk8kNGU9wQJ?=
 =?us-ascii?Q?nqb+2ftBqsFrtrGwPvTfFdodPI59Bk7QbEvCDpT4ZH6i+S5GXbVijD5XstWv?=
 =?us-ascii?Q?eWzXoJMKhgQPbDjPWx8T6C36hc62LljwRhDuPhsSDdPqv9WYyAdSErQsVKug?=
 =?us-ascii?Q?aXDOlHyqIsxlCa1Q//57j3U7k1TPfA1Rux7b8UKUSI+LKNNJKB7+eF5BKgJx?=
 =?us-ascii?Q?LLFhvqW2kAs+1J/P0/KFBgpilTlXnh/IS/+Ub+GTdEnwWMS3WHCUkFqFUDao?=
 =?us-ascii?Q?LhuSJprMb+a8XGYY6ApfSZeK8dSdg36IAiYg1o1uZvXkD0hKCRubAIbl1/jm?=
 =?us-ascii?Q?vaHeOCvfTTm4TFCcIhkmjcvHjl9xqpGE1HpFHdcBIzO2bUagFQdIyu2gBoQB?=
 =?us-ascii?Q?iQs622cFBUEluQo1p3M8S7msdwgN0LIhUqQJIlMEddOQSEWPFKtJO0NOBsth?=
 =?us-ascii?Q?nWHedzkgzv7C2xmwSIlXnIgoZ4oV4uJ+plTDCl2JCfhvi+NoWiTTBmYdqWcr?=
 =?us-ascii?Q?ADCaLRSadz8PtrFREeclx9olpQhXY+Rm3ZTkZGsj940p5L3/gchzM/wi2sD4?=
 =?us-ascii?Q?baYGkjWkcBOWpCsNNIWcpTF2e53PG5zwOnC4+Zv/jXOJkZds6vGDfh67YpJn?=
 =?us-ascii?Q?Vtqbzq9ynOYKLdffA3jKCKLeHgILY6+tNjw8b0zwc/xV2yFM/VEpjSs25J7K?=
 =?us-ascii?Q?nfXusdnYQ6HUtMov+VFTrCAMPWUVvZ28prGFfFLFwLn+t8/U75KEeYjDvk1X?=
 =?us-ascii?Q?Op/6ZKxGLdTKiUPZFmWB2t/dV3Mj0Fjhk1LwlCgtroxxL1M+Ng+5iuQggVtz?=
 =?us-ascii?Q?WTl84/L5MJIzJ0AqSOSTuhJU/67cUZj5Fqw33dfdzkLNTRFflljkHx9rTE7g?=
 =?us-ascii?Q?4IheAzDP57ESiD7823BQivpGB44sXPy0ATGDCpNb0v0+sLrHid/1arYcOJDS?=
 =?us-ascii?Q?c473pnKGFKSaFQ0iEweFn9waphPsBTqQEHDLihXUR5o+QuKLyyYbI6zl98zV?=
 =?us-ascii?Q?535LupKnWqKGNRfl4SuXU6gr/d869HEPV0+kNt6YI+G/FILiEe/Ej80D6R2S?=
 =?us-ascii?Q?rEQccxg6BD4VeZIrQrc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451b428f-a58f-4d3e-0832-08dce6d9c886
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 14:10:22.7657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eu4oz7Sk0rIPPAIpto5R8iDOfoeg0le4GCJuMGrCTuwDTotCqSsGX7BgEC0yN6qL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386

On Mon, Oct 07, 2024 at 04:13:52AM +0000, Suravee Suthikulpanit wrote:
> Lock DTE and copy value to a temporary storage before update using
> cmpxchg128.
> 
> Also, refactor the function to simplify logic for applying erratum 63.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
