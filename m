Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453A19F121
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193726; cv=fail; b=YAhsKLnmXvl42CsLCY3v7g1SHYIoM9TwI0C+9f/J7g8mwwYSnH1sLM/sfWxfgO/+cNlJArKuNG9t7YGfmLmW98ptUE+ratKae7oH12mfcrHg9b6Ok3GXOHDEum2zYe2/WjzMnsIGA17oaGmNNPXHaUYeuo6jQMOWqazGVOzCW14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193726; c=relaxed/simple;
	bh=EUXagF8w53aFFRs9fg4u8fjLDCnVYcO0sQgRnpppN74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TlRSKOLIs7LiXBEVHkpby1NbyhAhkkgtL2mvqRvvsMHjIKICPPaTzvCxlroil+6ABf0nCWwRxcdq8A7AwFqS2UVS4+05mo6+yOFe3Y02hdmKlbENXtbQRpZHSb8tp0/blm0A9IVomzQq5sjPVP5/yQulw292M9TE6TPME2Rzed0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MgseTR0X; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MgseTR0X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHt9fFI2tfCqdtpSh4YN/ke67aIK+eeLyhozgkSGFYr3a/9MxoVGcxAHw4R+6wa4grGi30uK6jMEJMDHLO81+lwz9D1juva/yLmShcvWaFLLfdYHpkCU6o7FWjgXbE1JAns91jSmF42IjJ96x3Tu8D84WKwhqxKynwSDs4gb4MEUPqoR35XLlG6GAl1jA6PcxM40QzaHh0OnELha6+PwSrVzRZ+UAP89iwb/wUHZNR0KOnpcocXodc4fVt+Ga+vdTMR5W7Mu0Ei+n2w2Ks/ud1SBxfcQyG1C10rNKHrotVW/HughXftwwq4FaHClx5gM4/12Dglmzv2jYQnj5DNf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwTS3VV/nqgqNtjKahWstSrBLUZEmMZnUHk09Mnvhqo=;
 b=P8hmca47iQ2T93cnz4VVc3daxZ8c/S+XlL0Qq4EQ6OYo02OQEGVddrS8dFBdWspciVOTL6Fad/osA3IC9CRE5Z80UXszSkSo2dH14BEHm70CBF///oiZhhQzQQq/fFnX6AjmOfAD+YMIZiKM8VPUc7jXUZeC5/2V2Eus8O0llSEC7y2CoeuRX35/ndyeak2QxNr2qoia0IkeQpCy4HVB9Asn4aMYGvHFwTk7Tpmv7iQqHiJL6YJCp+RhAkYnMMiAn+Rj91rIj9U1TNhFJjpdHYwPQsJhmVua5PDDh9lnZFRdxBNuWmEH+/agyLAAXzvWxSQBP4ZHlWExgtGAP0ZQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwTS3VV/nqgqNtjKahWstSrBLUZEmMZnUHk09Mnvhqo=;
 b=MgseTR0XGj7klxrVMSXjgNe3h4UBBZbj7e9Lz3IeCzRPu6fuK89xA6xwzKGG4/7vDzfiw/0JP6oGURQ3n8we+jfyfUIDrtJ7x6R6wha5687IggRdxF9y3q+8KufVQ8T3jfYOcvjqKWzdxiKPVNAOcuFrMiec+M6+un2/6OV4zgSRzOnyWoVKVRg9ZcroKg3yENCHOyHJpBpvkox6RcWDiFicm76GFwe12YYDveBlzsKaWyiu08pUIjBv6Gy9uvr8+Z3wyMAOvoCa4Qa6mhHyAjSvMjQWq6Gtw7eP/HJmXj988wAaLq9unTS+QKnR4ZSjsqy28PKMlJtuyoWbNcWk2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB9023.namprd12.prod.outlook.com (2603:10b6:610:17b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 16:55:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 16:55:21 +0000
Date: Wed, 5 Mar 2025 12:55:19 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v1 1/4] iommu/arm-smmu-v3: Pass in vmid to
 arm_smmu_make_s2_domain_ste()
Message-ID: <20250305165519.GZ133783@nvidia.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <214b10db02f1046efdc70e2c4803111357f60070.1741150594.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <214b10db02f1046efdc70e2c4803111357f60070.1741150594.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YQZPR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: 123e3f2d-939f-4c22-81f9-08dd5c0683ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mCvSKwUy5sC0e0nRKopSQXjED58Vlq0mphXPXgHGZlN3zWgQvRrNdUgA3PXU?=
 =?us-ascii?Q?FBDkWNq9uhaNHNL+hQ4jpeKs/CD2sFOGkjZt6S3tLp56r/uVIWe/IkR1yph9?=
 =?us-ascii?Q?bI/NhCQKvMr1YsioCEKfZFoDVKTruaEAlpPJrZKElWVouQvAFkfGvluws9o6?=
 =?us-ascii?Q?aU9CJCRloWo9qJt3oWvLYEZSrtKmxeqrM6h59UsoqogWGTXe12Cuaia5aYld?=
 =?us-ascii?Q?uWUppnr43HsajwoUkN+xj7bfbHRaC4qgtFGiN5EbUJcNs4dzBTFwMamONE5N?=
 =?us-ascii?Q?dKvs9+hjADNBdOOM3pPYcN15iPlYYFSY11IDueojnz+mKzjYO8oK9dKe/KC/?=
 =?us-ascii?Q?NTJ/5LRDDneSmHjQNUlDokHP/kvU2I9SAZqs5nmhEF5Naomep3MN1TS/x1vp?=
 =?us-ascii?Q?oP9qft58ZMwdqFvnhFnU0/0aqXAEeVsRnS/yT8YtcXAxh8QkjpxVDp9nnWvA?=
 =?us-ascii?Q?2XFCdUHgFRZIJiG2lwIYRG/QVgjqrs1q9gZf1no0Qyg/mRuvBhQf8IlfMKF4?=
 =?us-ascii?Q?TUYnZSvWW10+YC5jR4zA1ze/HtEu0EeCpeQ91dD6/PYU6UwSEKLzcyovPMQt?=
 =?us-ascii?Q?apXuMNcycRaj4xjSLvJ1CF/79Bc2LyYdghkP7ifX/p6h5oFiRj/GrIgnw0Ok?=
 =?us-ascii?Q?sGruc9dhnbDT6XCkpq0brCWIiXxL8b+aPp0QwtPxPK5DU2Rv8DwEmcvpxfvu?=
 =?us-ascii?Q?rrJCVt0m1njwgRmvd4O+S2WwXCwv1OdagfKxVGB/5F5UynGbmGgLIn1ocmNJ?=
 =?us-ascii?Q?caCYjqZwxseQwjFBfn6032gCRHw6zp0hnF6M8aQ7f36VOx1gTlVFjiFyGhqm?=
 =?us-ascii?Q?WfkS/boq+C1bvGYjoJuKdJEq/M4pb9OmWHdrJQ0AgG7cQ49e2oJ7yrmsINbE?=
 =?us-ascii?Q?/FF2Jny3kpEAGbkOwIiOUvgo13DvKxEXDBLRYmzV7SIX4cxG3dgDHOR7poxY?=
 =?us-ascii?Q?KDpWcxtIQonBIxJNLIDeMaabItnbMbw8s54q5nmYISXT0CqQv2R6AAOOuCXP?=
 =?us-ascii?Q?ewakmZKRqBPlfxI5s+uSG1RuNyGyzt3o8lVx+gBhBCKI6T4Y9xXmDZHnkA4k?=
 =?us-ascii?Q?++UYrGbuElawCN6J3ShkRonT3UkeLrgVPSu50eSJQgA4WDSV3/hmeSbxYFSi?=
 =?us-ascii?Q?kogEMNHu4ZEH+04wlZ20KesqLCYIpbovFe6gJ4MW7Acm029YlTVgHgBY2pNr?=
 =?us-ascii?Q?ZG0eQWCKNE3tfz3RvC6zDmf+AkNjxwYWkda7AIG4LGFRAdVwlZcf4Ui2yftC?=
 =?us-ascii?Q?VafPSlElCo7vwfFU0NmnKIwPALGtUXcYDh/9kcDqtK2OpxynzFgkGWwth1tc?=
 =?us-ascii?Q?xE10/EuuAGVD9XhOpixZNh2NB2LcYAEewGx3dhmIQhmbfIP3yrZXy32g1HRj?=
 =?us-ascii?Q?4KRsJPI5JFCq33vOHT3duccF8imN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u2R56D3BJIPUeXdEXL2vAl+uEaEhRoBUMCKK7rcXc/MJmXSllH6Fg8j1Jn4m?=
 =?us-ascii?Q?Qk8gSSsY8b7WLu4BBeKvd/IMstwLGfverAiMXb1zSp6wKByM9AqYhOfZ1Wyg?=
 =?us-ascii?Q?E10PQNCUJ5F9/IvXtKfv0uIbPbKKJWpG/fsqOfrMDLTq6mNON0fJ8vg/l0n6?=
 =?us-ascii?Q?ayKFphDatufLlz9ue6dL8FgKE/OqcJ61IjmiI/l1PZ36F/qiWq041PeSsedh?=
 =?us-ascii?Q?RiAu57YfioKpFIgTSVGWOAq6CJ2d6yT9fJ6N545Vzsr68Wb9CbLwtg9YlWIz?=
 =?us-ascii?Q?4IAG+7w+4NolzDEZ2p7vjfm32QSsf7ymoeg6dSfuBFnXVf56Bo3FyJKY7D2e?=
 =?us-ascii?Q?2MGfJEnm1UaAXvK5Eq5mZ4w9xl2lyXbEwSraz7ZX3b+xt0FD/w6d+5OpWthk?=
 =?us-ascii?Q?3fShI9sVRdmLEaTPNqU8pjiXSPLeZtgYVM1WHxNkOC/Gs0rnGSU2o8genTtB?=
 =?us-ascii?Q?5xFd6UNoQWpP04t1hD9kokPAuVzMK51bRkg/FfqaIRxJlC32+UfMmmeyQKVV?=
 =?us-ascii?Q?HoI1gA8ERcUgNi+7iv78EPjRba4gtFA5jFxtTYxTSfzOAZENT9fVfSLPhMOZ?=
 =?us-ascii?Q?jPUEn3qYFbwFixq6+rHv16ZKKz2aIiMiHz7DY3S+Gsu/pv9h/Ag5IvTWXkXm?=
 =?us-ascii?Q?VlfVml7O8cgWqAupPrkLHV3QeerEnCJ7N3butkhkSmHajHxnmhjR5iVtVGzN?=
 =?us-ascii?Q?u4/WMiMMKootDLQb4kOmc9vIukFca5HY45xixtvdnBUnKtBoPnY2ZfjEG2aO?=
 =?us-ascii?Q?eQBviEV1/OmEHeyy1NuijF4HWgvT4vgOmXFmtfppV1d4kUKWval/3nmbz9ry?=
 =?us-ascii?Q?s0Y9f2SWJ5ehrMWVBCgZPBXg+aTDvCiDutxGsEOySzrXM8H85GHoMUSmXXNA?=
 =?us-ascii?Q?I8lnbbkwN+77ZBOzWGDDuAW39MMTA+jsllAwgfgjLRQh9UpwM74StLS3Q4G2?=
 =?us-ascii?Q?oh6uiGS7Wxay5Ptn6D9TkYxbYEKYLQAf+t73AF8zY7aNukH/Bu5befEoVuJV?=
 =?us-ascii?Q?NRcKrjLyu5k7nPgbPz/cBNtL/4fNMm775Smpt1eDLxxV43h80opYpZABilok?=
 =?us-ascii?Q?/d/Ed7vXP4QtBtCt0ZUA+4CUSuAECqwepwSHWSPZ4lbhihrKzuotHEDJvabA?=
 =?us-ascii?Q?nz/m9gEVaaepMlO5o2pjZN7yOmnJyDCMjuewgJRIoXb83dbLw2l6FKmy0h45?=
 =?us-ascii?Q?eMSDDmBZA7SmNp3lan4UD3ILbtoHcPWbesmUOdt8+Q2FpiCBsZFXUgOxk4Bf?=
 =?us-ascii?Q?VGvkIKruhmjj0TGyT3I2UtyvCuo3dFqduja5sE1LCTCBFdYkxJxiv/S3xch4?=
 =?us-ascii?Q?kru+Wr4oa34C9TKN9Px9f6qaALKlo6L9RFhk1nr+lU0T1u8ew1M04BuAwuVP?=
 =?us-ascii?Q?jWQQAsOHPkqCNO+5UbZ09RFbP49RebcBIbNk6ma2EnVgOg+OmM/vxkxiYBOa?=
 =?us-ascii?Q?9D1EQRVdQtlljH8qntH5Ew+Rhvs9y1oBW9OYE/5XGoQ9vi1S3mI7gB6nuJfc?=
 =?us-ascii?Q?QD1Qf1a3nCTaO30RoT+tUZbAoEAmfXzjnc8RtH+hK7oSO8w/vz3lpT2fIITD?=
 =?us-ascii?Q?g8CMfLBif6KKXnopFHUdvXgv2Dh71Lxh0Q6YfCFD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123e3f2d-939f-4c22-81f9-08dd5c0683ee
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 16:55:21.1022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypZEVKNEpvU1/aLSoFfSMLQTYNylV/0SP0hZASHSW5Yz+Qz6psOSVbXh7BYYg3O/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023

On Tue, Mar 04, 2025 at 09:04:00PM -0800, Nicolin Chen wrote:
> An stage-2 STE requires a vmid that has been so far allocated per domain,
> so arm_smmu_make_s2_domain_ste() has been extracting the vmid from the S2
> domain.
> 
> To share an S2 parent domain across vSMMUs in the same VM, a vmid will be
> no longer allocated for nor stored in the S2 domain, but per vSMMU, which
> means the arm_smmu_make_s2_domain_ste() can get a vmid either from an S2
> domain (non nesting parent) or a vSMMU.
> 
> Allow to pass in vmid explicitly to arm_smmu_make_s2_domain_ste(), giving
> its callers a chance to pick the vmid between a domain or a vSMMU.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 6 ++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c    | 3 ++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 6 +++---
>  4 files changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
