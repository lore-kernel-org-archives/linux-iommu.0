Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A9F7082F
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763511622; cv=fail; b=flBfxxulNLlIiEZIuzmXX3QLdZUvlwnZlT80eQdyd3fBE9gaQ2PbbOgQkB73I7mGUisb5qC+AdBRhBTKETdPE10g8urajGrq2iQvlFqVaawTc1E+/PbojfzL5pHPD6CBHcdKY2Fxri9BHPf5VyKf2ITA1Oohl3mMCX0xdSSaC7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763511622; c=relaxed/simple;
	bh=QgJEwkjDpQ/GvDdEBTM31VZ+iUkz/fbhlFHOl2VjUsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DT4K3dnkiSE+y6/vX56d1G4OFVTojjhcMPno/FztoraqPW9gLS/0z4BayzwVWmn296jTKhNdSMJn7WGxGNVWkLqLM30QkGQWE5wPVwHsgG4t/NA946Y4kbw95gNs3gPyUmGPOkYi60mUyhRRDXfpAbRAj2CcZFThVY1gEz9fBLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qmhqqWfq; arc=fail smtp.client-ip=40.107.209.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qmhqqWfq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM8XkzuSA4GCs75uSnPits36E3qZ5gjBM1tcnPfP3ujwjvTur+dEcLvV6FSLetqqqOMT/fNpS31LDmrVspHseF3kl67EzaBqBfps8xrdGee2NGEZv33ncRgWm03K/sFWT1nV7wLaqk4EPEIxIjKWYGX0isAB9DO14fSyo3UayR+6q/75DRZ9Hh+YKMbTmJJP7lQDt1iTj/zdk+chqK03hvg1rar0n+OqtwetrDaR4P8rpxA1fTW+/+s9JCl2xcDkrBd/kG/ChyAhdXN2ssQpHxw7oYZpbj/LVHzpEGvZTNVSFiYILW1TmpgvpKLoVv5e8kYq47iRekSnD3KoFr04Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=695t+1R2c3ufgacdcjLAQjPZ8+XN+kkbd18yG+D1wWk=;
 b=k+G3RXfBaTvVzZg+JoYEY6vD4qRts/rBEkGcSJoXYxRwyWQvHfN0sm4Vr+/KZ3IQ2jv/pujqwu9hGtRWkSZo+SdH3MoWQSuV+A640dMsIdmLv+TSdr5O4Tmrc8WivrGTvgTPVbC1YhUqGS7L+9IXHlOiAohf0iNvdNo3PQEg6kIGLsvTuA3X1zPmqEACGYFvDjxDZbVghCXzbExM5WuTkPISWLP8z69xE14qyC+/xKQYOK5qmUEajR21u5qP3EFTEFesVqSTnjX7n+TY5HYSMkctak4NROXk5nJecie7zBpkl+W0YndgGg9CyTGe2CfqIFQDQ93UCPqQX6sd0jr2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=695t+1R2c3ufgacdcjLAQjPZ8+XN+kkbd18yG+D1wWk=;
 b=qmhqqWfqHxWEOgiO6R8STYr2voWgcO+cH9sHcEpAEQgA6eU6/OIU9jaE0Dq7mwyHItzNcx7MEdgq0YpRYyM5Wdeq6G8IlIa9WUA+LznqQTK6QbxnLvjl+tqRjH9Z2aDeEPzDZ9/+qSrB6lf0aMk/3gc7gpDwcvRaszVx+TzDAXp3fcVgYT36Ggph7NuBSwGJasEIvDhf8PU1EQwAVOo1eDvs5PGJaGBdoaDsxNqRQpFn4ROtbx2N7TbvPbp8HKIKv+jZ8GU6nDBIeQVDO+71Lqt2+NmQwK4Hv2Tt8f1WVlcxJKfP8neVJPCjaWR1eBTQwPtAuPxsJKriNxXSowS/Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS4PR12MB9588.namprd12.prod.outlook.com (2603:10b6:8:282::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 00:20:16 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 00:20:16 +0000
Date: Tue, 18 Nov 2025 20:20:15 -0400
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
Subject: Re: [PATCH v5 13/14] iommu/amd: Refactor logic to program the host
 page table in DTE
Message-ID: <20251119002015.GJ120075@nvidia.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-14-suravee.suthikulpanit@amd.com>
 <aRZLUc1hvFXEC/iG@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRZLUc1hvFXEC/iG@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0432.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::17) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS4PR12MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec0f45a-7be4-40ba-46c3-08de27016a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UPzo3Z/iz1h66055asCQMwELaVmEsb4YYCV++HwNwts3AqKdryyaIznm6HtJ?=
 =?us-ascii?Q?pReyfCDXz4bho5CqEjP0/wzfBTbwQDbdc41q+vCT07OOT96suTC3FuDUptLJ?=
 =?us-ascii?Q?G800Uu52n7gMaDE7q206GNJpsZgc27KAiw3H1UYpxk8OgXwOc8OuvuppTAvU?=
 =?us-ascii?Q?JGV6R+KtUi0bulg4kS5dqjXkixkhn28IjjgAVfB0xfb92QbIVKTSerSv3Cg7?=
 =?us-ascii?Q?qr1KDDsOnzThrPUyUXHnpW/Z84p26ocxoLHGkuRqleT2VULI0oC6EzBh001U?=
 =?us-ascii?Q?58wpfOqgpSqoqgY2UyVGHeyLnqUy0ZYliTM+G9bZG3NHvJSbOwzOXoVybiC/?=
 =?us-ascii?Q?kb+vXy6TiGUs41yvqGsmzvIvrEKElj0YecrXayXyMDUKG4nsDI9vy4cGjJWG?=
 =?us-ascii?Q?fTK4YVIKEY621s9eTrC+zMj90qMJc6E+IVBIiqWhJ5EDRQdyfjTnJPPORrfT?=
 =?us-ascii?Q?5KaZoOsxVzx0JNOBtEtsHoBBGlSlVngJAZihTvySBfHr3GjgT2qg/X4dJPQy?=
 =?us-ascii?Q?pC7ZY1eDDwDh93LX5IjwlhAwb7PpRjNQM5/BFriDytq0xEDm9hOHww1NM1C7?=
 =?us-ascii?Q?7e8p9P9zmokVGiYI4tYd2DLpGF8xXQ1fhq33rUnU7yvcz9BnSq9EwQ3vE1Cf?=
 =?us-ascii?Q?7tokYO5AJ6Mbva85vSNinY5+/xPo+GJoXW1MMqofmie8aE8Xe+EHDxs/yJDh?=
 =?us-ascii?Q?BNk3LU3TD2K0+nSfEcleSJJAqkK2iehN+7K+Yl1RrKWFkOtTBUo+5nKta6GL?=
 =?us-ascii?Q?cE3hF73GBuPwz4CIgWMwHL4r+PprG8cR6NwcBBmO/s5TVb7lhFYknFMtpS3P?=
 =?us-ascii?Q?GYbQxaL37XL+VOikM4PEWTZlInWx2fgyFCL2e+JN1wevZsZmMzXKKQ/Fm3U7?=
 =?us-ascii?Q?plhnsq7XxkjNBjk16MfvXVSG03f/PJY17AFJukL67fuMou/ZzNyeJyXtflgT?=
 =?us-ascii?Q?FaE4eAAO6jKNcP0Rf+Kn2ydC2yCuGsLRPNAKtWpxTQ7xnTqZ3/pieVOOi8lB?=
 =?us-ascii?Q?y1fxZY5+Sb7xC4aMOdxhnfWmUtieIZn5wxRwp49BYd+4GMH4vI5pCW+9exh2?=
 =?us-ascii?Q?R7RFdka0WcAzuWC0XBjULLDMVJ3u2QrG/SgyLjmea2oxoualxISRA2kQSgcI?=
 =?us-ascii?Q?OeWSyCRfdbh2Gl0bOE3JBARikulMQIj97EUs8P492QNZu0d3NTn81uc/WNSK?=
 =?us-ascii?Q?QmI0tgCMYLcv73YSyNN0esXHyTWZdzxBSx+ADaHsHRkQJSNh/WOF0rTMRKzA?=
 =?us-ascii?Q?rZhD/8h1Up9oSChzd/M9dr8bfRRZIVyOxEyCQn7CKOioDoXmSuMQ1QgEMFFD?=
 =?us-ascii?Q?OVHNB0IW07Z3kB5IrmdWmxzOsMcappIN7bBmE0GqFLkiz1zzoCFpVviva8bX?=
 =?us-ascii?Q?dzqQLwnNbciQJjCEdRR2KHl7VcpAbD7oJmZNkc+8/TwPpA84VQOC/AUNuwyQ?=
 =?us-ascii?Q?JaOBsE2BBzestOlIjYbgrsZzb6QsIuqP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D8iOGfkR8TVK+krLY+zj9usZ1/aQTPulCN8fjZ5Dx1FMBoseicgnH0VRSNBO?=
 =?us-ascii?Q?Ju9jQd9s+3vNuzyUeYJZmoMbljbiI4UYlntmD6JrP78kdAxEogIiN11/6VwM?=
 =?us-ascii?Q?NJav/t1nGu14Lz7XQCiCFcaCsIa0hZ8FzYY+QGwSznRGOBTgWAeKA6oAK6zT?=
 =?us-ascii?Q?a0TH5R6hFI7qs4EKGuV8Fz8tLHIWZjGhAK1NN3LjYxDHYR5GuOOIF2JCeZuc?=
 =?us-ascii?Q?+dNQMqUxMgPLP40Yi6jCxFjTOy1ltebjXgNhbu2n8NgaVzZ/z9dUN4GwI9g+?=
 =?us-ascii?Q?XLugbFcbfiQgxRcsXwMK7hh3dnMA2fms32zks2EO6e0/NVbMQS6NJnRgqusD?=
 =?us-ascii?Q?XU6K6Mky+if9yv0y0WjSX3eEwXaglQkKjIUxN6EPheJyk7V/Il19auedMRsf?=
 =?us-ascii?Q?jU8wUCLpWK7K848XgvGxLOoaH08aDBwmUsI9o47tj72xnh4MpRZwCIuqP+FS?=
 =?us-ascii?Q?E0vEehNFVQdZOs0PnS2TlKybfz319x3wyFOXWVBCSr7Ihm1lRx22MstfAJ1h?=
 =?us-ascii?Q?9VG3zku5nB3nWBHKIkIf0Vm9nc+yxk05K6T++vswDQ+p7y7QG9fIjbU0rySD?=
 =?us-ascii?Q?Lz0dQUD+uxaXevppjVe2AWhF6W8jd5fam5b6ag7etukGnZJ/aoCoONtZH8Z0?=
 =?us-ascii?Q?9yd9FdtJuN8RX63ow5VYbV9Sm0X9fwYgQAraWvHKVuUcSp5yNkGtWFOOjnFG?=
 =?us-ascii?Q?iPX7yc7aWxuT2ySH0ULU1iwlMXNjy3dBWMXQJZuEC1DJ+eot4gevDVIgH+SG?=
 =?us-ascii?Q?2EQ/wvlnfGDmbxkCYFgzBOAgliaZNXfJjQfaG/C2IVpBGYS1fVnVqLHDKe8C?=
 =?us-ascii?Q?7IESDZPGmaoNLTncyGK9TmR7YYzbcbG/5eZjc0woT2RUGFiGD3SrtVIvo4cH?=
 =?us-ascii?Q?z/Et2cHJ6FDL62ba/qqjkzn0tuiSJ9Jc8QCtfFn+f/Q/z78dslEEJPSLOsJt?=
 =?us-ascii?Q?7Y8JtGjMNULakiaZ163VLg/FS2JWzFSQs9RLrPwbi7qgE3fMo6PeA8ZVl8IZ?=
 =?us-ascii?Q?GYBcUKNo/6ZiwPzcCt1YI2AsrgW2lmpu5OgdtXO7CwRfJSTRrbs+fwIWR1ua?=
 =?us-ascii?Q?j7MHyPZ06qUooYnSaQaH5y7oZ+yUy2zG+1AdP1lddhNMEq8+U7yDtDoAqjAC?=
 =?us-ascii?Q?67DxWNXkffd3qIwCr/KnmAXQ+6X3GAapGC/JbSGAGwbOb95XaIlLtLd3YWSS?=
 =?us-ascii?Q?nBpznxwZr6q3hwbrKhvSu69tv81GhD8e5iQMHZIC6kTAtCRVZDTQXQ5OtDkw?=
 =?us-ascii?Q?A37jlUwbshCWXRdYTgTmPWxSg4m3tUzjFybM7s3tFOvQquk7ZWec/Qz+qLPw?=
 =?us-ascii?Q?OYjfdT4RCXcSDjgti0UYzOdZVm6A2Ag9dlkdnCrCYIb5MPcZ7392UAa5xXot?=
 =?us-ascii?Q?qNQFhxYo2Rmphw4kGS1kMv6Strp5ZqI1xqZitOCq20P7OnaE9Xp+dizDpg/K?=
 =?us-ascii?Q?4KYNF5iTv1+qsE/AsBMDw06z6qSvLsl/BKIuUMOWw+TZmzExFTtJnPs2sQQq?=
 =?us-ascii?Q?32GBqt5ma99nGBBtOD1LFxeObNXMpYMj3MbVsqvP45gEig7xdAG+rwJ4Q2YH?=
 =?us-ascii?Q?67eToBWGGSMtvHgg4pI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec0f45a-7be4-40ba-46c3-08de27016a44
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 00:20:16.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLAQqG79po513GgXfEThHjDMTPEl9P/GVPC3Uy8QejXhol7hG2OT05MyT3kOXfor
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9588

On Thu, Nov 13, 2025 at 01:19:13PM -0800, Nicolin Chen wrote:

> >  	else {
> > @@ -2097,35 +2115,29 @@ static void set_dte_entry(struct amd_iommu *iommu,
> >  						       &pt_info);
> >  			}
> >  
> > -			new.data[0] |= __sme_set(pt_info.host_pt_root) |
> > -				       (pt_info.mode & DEV_ENTRY_MODE_MASK)
> > -					       << DEV_ENTRY_MODE_SHIFT;
> > +			pt_info.host_pt_root = __sme_set(pt_info.host_pt_root);
> >  		}
> >  	}
> 
> And this __IOMMU_DOMAIN_PAGING path seems to be used by v1 only.
> So, it could be squashed into amd_iommu_set_dte_v1(). This could
> tidy set_dte_entry() further.

Oh yes, definately should be done, the whole pt info grab for v1
belongs inside the set v1 function.

> >  	/*
> >  	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
> >  	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
> >  	 * do_iommu_domain_alloc().
> >  	 */
> >  	WARN_ON(amd_iommu_snp_en && (domid == 0));
> 
> This, if it's very necessary, can go into individual functions.
>
> Though I am not sure if it is accurate as it seems to imply that
> IOMMU_DOMAIN_IDENTITY has domid == 0?

I never quite understood this comment myself either :\

> But an IOMMU_DOMAIN_IDENTITY does:
> 	identity_domain.id = amd_iommu_pdom_id_alloc();
> doing:
> 	ida_alloc_range(&pdom_ids, 1, MAX_DOMAIN_ID - 1, GFP_ATOMIC);
> which means it never returns 0.

Hmm!

Jason
