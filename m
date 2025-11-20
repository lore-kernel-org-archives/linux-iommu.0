Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3903332C306
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643654; cv=fail; b=BAIjPjPJumYUMuFRedVryyACqoxbLrEWL+OfNUw3awqIod5ob13UTEEqgBStmQPKZYgMdRQZBhgAfvKheGoBTqISkl4qj4L+jFkILgef/0OggBcV8LEXfI68oDhSXHhwMQ8xPIQgNA0YcH9y8isOrbWfHJnS6paWX6QKvtDK5wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643654; c=relaxed/simple;
	bh=hv+FS3twGsrIzz0p4dPbb8Y+LIeQOkdGaczudatDPLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hiON+spP1XqJSLa/JDsRQ2SEtP8ujf2Z9P3mjgjRcQK0o20xP990CZK7yK2Zm8xi0IapXH9rA/Hr/pDROTOlW7NjSe8XfCHfiMfqudQDSmq+ZiKweE5uyWDVbrQOxM6gALpCSBLbN9Y+NTPzeABDtCmYtH/6zhAnXIOXyZ0V5to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XOQscaru; arc=fail smtp.client-ip=40.107.200.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XOQscaru"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7YQrLtnYzPM+ABY/WSNoudaQTF9/a7RjBrvzemGtokpo6X2twAyv+Q4w4uuPC7ADp4NI2ke3C1p/HM8mtpkm93UbrYeHO6hSQ7rPn5R7o/Sj+jkKi+nbTrAKZ4s8RGoezDt5QnwtqZpx9W6n++ftKqtQZvTtlPjNbMjxmvaztb046PjoVonAE9L8yYOwc2H/v4HhQjycwESyXdDXN6wCUPHc4GH+qMc5fbgRg8wW/oEvFfQiQX/DwKsSYn12tOD+nMR/Ksxhdxzplj4cjG2Ebxxz0dzaw7fnb8tGTbIeo5U2vLe5IrlrsvVmuhNJDfPCKk9mWLYExhlosL6DoDdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krWT5tsiv24LlOs6Iqf1OWeGL1zRdWkx79+oQf+in/A=;
 b=mTLzC3Bx/BcX5/rMVFTOBuT2HObEpOo520PO4p5wGfev5oMAZ0pcxlT0ZY7WUGNMKL/KT2zy0T2Q17il45S5QNU36+5tK8jgC7OFV89FeB5k7kZALykxcAROu4aCIxiHmOQXwgr5mnLjpjab8TEr7Dlf0XCnWNvfe4SLisDnQkntihm7mD1O8em0jXGAyYWz2aw+1wkYKkLTwnBdwaOi6qtw1bZt8VS0tbAdZ6fjdxz8usIVPhv7fpUdikA0D8YaPhCoXLjgPFjR8FSSxiTBf3GWAhU6Cii/cdz3HjWGRsIodX2LT46vPBapk4ztYVzOx2zpfQHdvNTWJH5bu4W5Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krWT5tsiv24LlOs6Iqf1OWeGL1zRdWkx79+oQf+in/A=;
 b=XOQscaru9h+2dxCLquxj+dBrm9CUMvMc0DltTUzTim6E0VeeufniV5E6ShgZ1y1AQ3D1xtqZI9zHDSc4IoAlLMHN27OzPVKwFVXCd9x7svIgaUPf7dB68cLf7yydRmshdJpz1knkTOGr7zT3yjiAzhcROQrKq6C9LTgsDHYbqgo/EwuO2lBQo73+ZNJR9nHvNRznHqVulgrfzS1e6+PkzCWsvbRLzMfMjMlsJm2+elRxml6RYH+39HrfG4aBXwjOijMStJ00ApWsxvg4JernKAQ6E+dVOJqFsY96c1R9Ir5E+W9hti33sBKT2hXuFIFCZD8SW/FtwzEFgxCB/YxqxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:00:46 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 13:00:46 +0000
Date: Thu, 20 Nov 2025 09:00:45 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Restore previous domain::aperture_end
 calculation
Message-ID: <20251120130045.GB153257@nvidia.com>
References: <20251120072524.3218282-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120072524.3218282-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BN1PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:408:e2::11) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: a420806c-80ca-4234-80dd-08de2834d204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8sySu1Q4vyYgy6yyAsRcxXOuMqXK0O7kOOS8AYo7zpt6H5HhV2MJiBRpXOB1?=
 =?us-ascii?Q?vysYem8dqfMdEIZZ1XulYzGkFcj+sIxtvuJv4Pl7P0Ul3LQszMDxpSxXb3G3?=
 =?us-ascii?Q?yEVYyTa1jvqRL27uB/mIk2cnZeSO4lThAQwpe/Fzjrqw50C4E/eu3tD0PySt?=
 =?us-ascii?Q?VrwaBIPv8M1yatBl6ycfbTOHsG/4mpl+sXjo71g6sBeZglV9YK4nVojumLMo?=
 =?us-ascii?Q?UkZLuWNQK2/KvKr90Vwwp4WFqZIRU41CsOe0soOOHa4bSY5UEySRaa6WqxDJ?=
 =?us-ascii?Q?zlRgsnAWIK6kJjpnxbjn05rIL4D8o3eeERu1sVJResgcvcgx5t1PFbjzK6ru?=
 =?us-ascii?Q?UNpWof2YExquuV2xk0Pi+NwhA+21nU9wyaefN5OT75gOh2K96D5j88stxOoq?=
 =?us-ascii?Q?XrJ/O2pa2msM3yq+eaOdgeDJsnXFwrSz0/1YUS5BrupOWiFPELRVpDkPPYi6?=
 =?us-ascii?Q?1gXRuG90ymUkBIOUfQ7gkaJLTtXI5Zc5uPxTbMfFUn3ocQGg37pCRn4gcaVx?=
 =?us-ascii?Q?AqixmAZbO25PYjARjg2BAj0jU6wqgDCnivpRAprtsDsxTllMxjUSxQz/qoXa?=
 =?us-ascii?Q?MJ+I8kxaNl7UQsQBxrK3NJoN3fZkq4cV3cth5mD2YBlNEzGooJuRkptyGfDA?=
 =?us-ascii?Q?Ylz2o0rOGrDCngUc//7zHlpd1umC/9eyNFryaqQtuG14zJLIfslAGrV8x/WX?=
 =?us-ascii?Q?pxJIWCXwOMNnKlpIY62l2xU9LdT1q/CGsbBNImALVFZ66UzZgNqy3k9PQ/U1?=
 =?us-ascii?Q?+7MRweHsLC0L8nPgZVDMm56G0i54N5yCfq6xHC2qNQ2ald1GwWooATHbrmtI?=
 =?us-ascii?Q?084UMePIx39fvuwwwBS4llKwAqQv9cN+SpRAw24/W+nGv/0MBTRE0f59P6sX?=
 =?us-ascii?Q?LaX+042G12+CYdX2LIbcbhBnYWNWZxoQ4wHSGdyhZkewRi4bZwjSkcp/EeD+?=
 =?us-ascii?Q?pqy4GJQtQfQ0XQ+FMDCLWcsS5i5pxLg6RrXjlnOfhj6Cq/fqdBU07s0l8WXi?=
 =?us-ascii?Q?FsEME6GRslRPAyR0AoOvKwjPtTRGhbL8Y1wfh3oWJl6i2/sT59hI06YAxerV?=
 =?us-ascii?Q?/ug1HZ1OEoAJo3WmwrSqQnnS04TmZJ+svKr2rGvHSHWSnQ/Bn46BHwpzX7MP?=
 =?us-ascii?Q?pS5T2kJ56Fj70Rmf1zl51S7W/WULzDHIris4aZmbtUmX/CIMxTbiaCiQKYGN?=
 =?us-ascii?Q?1yEl2HzkcEJA07qKLqRSYx+UPEQnOrCN8ie6ffboKkcr2xKlRUlN1jXrPGKQ?=
 =?us-ascii?Q?tnDSo1JRYA4U3WvhMCdYSs81sH7E7HDec5l0Gibm6lxWz4hLu6Q80AybNIf+?=
 =?us-ascii?Q?bM1vnnRXj7zbzuUeaMbuUEFgSEIisNj9S9ERlJioe0PA2i4N6yXt5GKxroE5?=
 =?us-ascii?Q?RGcenk3HLFXqdpjt0NZlPnDwPSO9Vy0aYnRfk5K5uRcSH0KvvVha6G35Igo9?=
 =?us-ascii?Q?1cY0jQo8aUU0EVyxbupTJfbYFjXjvX6V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ncx05kkqWu1PJOjIWBebpZwTO1w3ojqvo2JHTUXDMoNw4sHBjiMkByFckMRF?=
 =?us-ascii?Q?Q+dZm6QOM9BoqHkYD2soC3WnVYSeb524EdT+EhPnxSylgRO8UiNPx5hBMWCF?=
 =?us-ascii?Q?MhjtBSutAlzZZbMKJGpA4CYyOoyzGvmuH0fb0kpZXmWzbht4xbF9Yb8mfkLm?=
 =?us-ascii?Q?w3+86CoWra+WIP2Fheoi9akBcz5Xtly57RVnoqfdAJFdJM3W0ucUWmDpJ6xH?=
 =?us-ascii?Q?j/qXpRz5LiXK+XQ4JCCrBJhua1a+G/FrpCx2MhPLFOdw1vi9cVmyCuDDXNzH?=
 =?us-ascii?Q?c+LIiegYwS/h4XKvZ2a4hHHHA5uzYCfIJXiRo27DEaS9GkTzyqOeqKwVoF0W?=
 =?us-ascii?Q?YGgQxBBFDtzrK3irNcUbqL9N1OCWE9NfM34haXvMoAzQILckqpemY285Pg4X?=
 =?us-ascii?Q?c1XOwqNv9lHDnk1mexouo2XkLNiDPiSB5nQ59b4dydccDVbKABUVf1Ojs5Qk?=
 =?us-ascii?Q?232GD0hw9RxTBeaSUS8YAdch30ZSiXUdupPeR7idO6aPQ24KlnZgND6smJOp?=
 =?us-ascii?Q?f2wm0BgtjpCsR2497cZXFveoF6dMlY8YJeEfIEp68HZ7pD5imRopL736E0bv?=
 =?us-ascii?Q?Zm2wsJHWYgyvv95+oJO1BeskdnWmOQjo7hVqyN0v5pok5ljKbfTSJ0aoBFWZ?=
 =?us-ascii?Q?WCVnS+1kJZ+LM7ldynuwxYReloIRqukfEiel+DC3gngxVcYlz3WWsUe7Ba6l?=
 =?us-ascii?Q?hPV32+KbyWlZLGbpA42zlDjVMObB4pQtofhXP40tCEe/3ObzL+waBdCFR4P9?=
 =?us-ascii?Q?Ce4/QkgROGbMHv6dPItnmV3RR4fEZjI9eh+zPjj76ot+qVMns3R58O0qt7eG?=
 =?us-ascii?Q?vcFz/NcIYPjfZqoZiDvrcQi77vscjwMXTtVADC7K/z/AosasVAaXwoEZzlfT?=
 =?us-ascii?Q?pjdNeBI9cBzn7qD3mL5/e9KPyJtJmyCm3+6aTgKtIkodca/9JZOVod4HsI7R?=
 =?us-ascii?Q?e8sVX4WYINOuuQrVeLnMRFx5LzsrWDT1JlQ00XWMb+qDL3RcWGUpGd+TxWEF?=
 =?us-ascii?Q?+HccdXXmIRO5BriB2TvnK8HpZsPxUSWr6bi6Ro9AqExrLPNGVuRKmQkUiMIU?=
 =?us-ascii?Q?uWN9wk6LhRTRwQ6+9mJWSV+/65XeDkpqz55hi6t8h9SFr++fmpBqeoY63zNG?=
 =?us-ascii?Q?evy52r5HD+2d2cWuhCgMEQ8IejBxSyzxC04FxHRnO8Em/1E93qLxQQjiSMIX?=
 =?us-ascii?Q?DoTF7K6JwGieUWBMagL20lxGo0rVcbebAWknHVson4uRUMXwOsCaTrHcMEDk?=
 =?us-ascii?Q?M/f+4jumRhK//d/WNvrRY7MXMmrq1Zs05MCesTXXqfYOAi+zom5JIhlsjMM8?=
 =?us-ascii?Q?1UvupgYfxfatekJIF+X1wOcLLYxpdBDLxRXmpg6cp6FW1tVkBUUbPHxeG52d?=
 =?us-ascii?Q?LbUJlSBRRdRt5p0WbLptqYM1PzqRxY5rHv+sp0ROLb/GAFh//jEyrA81ng/C?=
 =?us-ascii?Q?C5k6CN4HCWYn08nBU94qudUBIV5cTLxICxIkvS155492ASFJTf5YdFq3pnh+?=
 =?us-ascii?Q?HjKapVdHQ9UA3XBQHIe4Fe44wIyx+vDi58/8TX8fpQkzLPyxuOH7ouFN7jbK?=
 =?us-ascii?Q?Idt3eXoeaqZek2e8UEY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a420806c-80ca-4234-80dd-08de2834d204
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:00:46.3946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4q3Jksb50hZInTcZXxK33qe9EO1kr/f1udMehDkuFw60C1WYwSr910z31pt/Z9D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751

On Thu, Nov 20, 2025 at 03:25:24PM +0800, Lu Baolu wrote:
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2817,6 +2817,16 @@ intel_iommu_domain_alloc_first_stage(struct device *dev,
>  		cfg.common.hw_max_vasz_lg2 = 57;
>  	else
>  		cfg.common.hw_max_vasz_lg2 = 48;
> +
> +	/*
> +	 * Spec 3.6 First-Stage Translation:
> +	 *
> +	 * Software must limit addresses to less than the minimum of MGAW
> +	 * and the lower canonical address width implied by FSPM (i.e.,
> +	 * 47-bit when FSPM is 4-level and 56-bit when FSPM is 5-level).
> +	 */
> +	cfg.common.hw_max_vasz_lg2 = min(cap_mgaw(iommu->cap),
> +					 cfg.common.hw_max_vasz_lg2);
>  	cfg.common.hw_max_oasz_lg2 = 52;
>  	cfg.common.features = BIT(PT_FEAT_SIGN_EXTEND) |
>  			      BIT(PT_FEAT_FLUSH_RANGE);

This is missing the hunk for paging_domain_compatible_first_stage(), I
think that is important!

Jason
