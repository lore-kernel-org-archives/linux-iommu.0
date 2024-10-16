Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF8205E23
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087945; cv=fail; b=rjRxbkNuqeSU1E3gD6LQL2SmsY6n/arOVmbOtYywHL7jWTsRtzNHycVZ8mtgwLhea5nMi/j7Nm22vyOKbbRnwb34jtsmoi/LeDqnqzzM9ylK6hvG5lBziVCvyNiFtwsly33o943SqTwLqtiVc9E07IYobt7V6wI4cNecznnGudM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087945; c=relaxed/simple;
	bh=l2YM28PlVVzVh50RNWQpPIDacq2hGev4lqOkcIppUxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HyGXZcVzitdqCiGOG2GfFmJFMNyb4f9XhSpcxUa4nobSUVbdVKluRMax+iNGB5Zc/okcogoAWBh4zN6ucpIpG3vYfDvgag0WbR44cKkarudn6T/2v7c35OSHmmBNdlnSpME3F3zubUGWieq8sszZbdY5mKeQ11AZ0rMfXR5Ri68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EYl2QJCO; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EYl2QJCO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gog0/iG2jvYnRlw0+amgqMVijv82Dhk4yfr+i4K+vNOO0i8zCqehmUyjzuO5Nc1TLjy3iFwaU1wwAcneCDAuNW7aGQntnilJkJ9akjdiiUJn+mjNHMHxnHXa+XE1WSd87RiV8tCKnkxKp7M9XORbPWVH61oIjJsC9ntbyimsH9IvR9qVmsqs9Q3K33chR0Iaw9d5REwSCOftjanEsOzhyTkyZUupxHTQse+P2j/84eW6P6X6A0Nib3cCTPxO0XCHZuFnUxMoEdwXthRmHhbXvxqA/E7liTV+4jcfcrhfAk+Q71S5fefbsfflrY6tmT8Zii8E58qW3L4o3FwH03QMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T63Z04Op4JeDj9rqFGRrj5KxnDKb85QGnlVQXLnKkLg=;
 b=XRYiQm9t+s+7O/hMjvDfAEyyHAtiHouGV9ez1CgDUtdWOLKaBubSAXAF2gXYqrX09SCr00wZiCLice2w/GWNlUkCipnn8pKGKLbICY+SrDffHrXxFm/bHhN4dPO8j9yF3PjL56b4ntfI7hVweqtuYBjvtiDwUa5L1cPEX7xw3av3JXM/vvS8uIAYSX6kC0bs371EKx09QjGWK3Gwl1OjhQq/4JKoKDbldq2PevuvsKYMje/Z1CaS1pOflBB5QUxvdtK7XB3okHfi2w1iOd1qMgFWxKmHBBXRtcQSFErzgHaJa7P8+8XdGRJq3mzlPl+2dn/DHAXJ5ZtqLu79VYXl+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T63Z04Op4JeDj9rqFGRrj5KxnDKb85QGnlVQXLnKkLg=;
 b=EYl2QJCO05leFBBkjB1lz2xuk0FTjgQ/CsephdC/Bpfp7IGnQfG5sbk2tsKQF5q9CpxirmFHigkzxyfjV2xoLS3n2QqvRaUtE4nTHLyPHE/hlWE7/UW+hDSherVba4+Nia1Er+PnPn9zqkAdD8uf+afRbUHy0Wj2VqWI6ZxZgeh0UHQre3LQ2yfNVtYwVRcpdsQYUMzRN2wSmfjWY5nYF2AksTpkbgCabS78FZl9pjXzr/gjqW1cwB2EhSe+94PENbaYBCWOdv0uIoKgUqh6lMdUAvV+KOQ35APNGnY2pLr2iOqithdflnuEA7GS8lcnlIw91aTvaogPTfIeYEdyMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 14:12:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 14:12:20 +0000
Date: Wed, 16 Oct 2024 11:12:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v6 5/9] iommu/amd: Modify set_dte_entry() to use 256-bit
 DTE helpers
Message-ID: <20241016141218.GO3559746@nvidia.com>
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
 <20241016051756.4317-6-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016051756.4317-6-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BLAPR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:32b::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d407008-3d15-4c9b-987b-08dcedec8bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yJF8HVHFE5b+U+X5zU+usRgukzC+R3MaBzj5y9WdJNcoD/T8LY0xgcEqcX6Z?=
 =?us-ascii?Q?cOXQ4It4ftoXIq8eHHLaAo+W092PstnOrRu8k/m118i+DBF7WXTIR1uvmqMU?=
 =?us-ascii?Q?i8nKOSHyt0LGoa3mi7nixJzOCiTwc+sbaZU9X6y1Xc+EWCvkdFdztge8B/1+?=
 =?us-ascii?Q?xazu0da5pgvS8/wH8ocnD5PdtodMRxKjv8lJQ8vkDIT9RTlSHy2dyGAM2V0r?=
 =?us-ascii?Q?pwcH+GYZ6UyPhmCna3QG7NGaNlL6Lq8wUcaT51UX8KkSHzPG3cbQNxSXExFo?=
 =?us-ascii?Q?uudJm6QOxPEUERZUcVq5fWzC5CKsS6lmylycDQkj9vVe/+FRl368nMdBoUhz?=
 =?us-ascii?Q?T4HBQbRBMt67yxaJQOaf7DRUYW0+KCTzENDPEprDE/ZXgiJjoE8dPmefNpeb?=
 =?us-ascii?Q?C34+20iaIJflmjtiJNV+cqaac4w2DbPiuNXoj6VfOdhU3paSo9op9KYzLy1q?=
 =?us-ascii?Q?KYONhIVv2o9yNKEYwnkPuklaCAJHpdfpkeqflrNXDcUbwyYXx8DEHgZ1J2Lb?=
 =?us-ascii?Q?XIFS/5arD+xZODhD98HMl5yP1NnhYnNQVf07mKuGkCSE1GlDdQ8yl+7nVGwz?=
 =?us-ascii?Q?cVSwILrvCWjsFKnfFHBthHinZBrdtmJGbmXjSXKRphvU+fml0Ax6L4Co78Nf?=
 =?us-ascii?Q?5K01GyjwOLP+AY2UbMdlRDIvTzN8bvf9GOWB1AAIyC1K+R2dkScJqYm70bB6?=
 =?us-ascii?Q?Rtc1fpVrVPBzdgmLhbhJWs8J9Be3JPQKYlSTlOVNYIdqfkj8N/d78dDyGJ5g?=
 =?us-ascii?Q?JKT8ccjSNHa6cfXpgHGs7wk+pi+TRnwPEAPZDoJ/NXpcD+5cB9ncw6Hz/x0G?=
 =?us-ascii?Q?W4CfMBEmgaOueoPDeZvFbhvPGm9ZIZaZmYGkcH9oLpuZxY82vss4ydvMLpUQ?=
 =?us-ascii?Q?WCkjlNfvDte0AKnBSpiKfPLjT4FNshg3kAvOvNmnudKfNr5voGdWH+Mq0had?=
 =?us-ascii?Q?fEgVxe/ZcEa1wHmHif8rm9SBkhYoD5dawwtH4cjOJvzMf4o2q7Nm3NbL6Snz?=
 =?us-ascii?Q?3IQu0vV1a2hlFO+2grgn47fnI877DOR1cU6dBTJjpjPc6a4YJKSeYRVfz+9P?=
 =?us-ascii?Q?7ZcFy6dbJaD3eba8s0tphQFcC6/NtGYiqFBA8vwDJziqJWXQDQFZCtMTbZnc?=
 =?us-ascii?Q?nvjpkljWaplBioLaj0WLinK4Onc4HXODbKj3DuhkGyjS/l3SikyvlBx9t6/E?=
 =?us-ascii?Q?Judt588UjwDV4jba2B1riRWewoG+nqPmbjcyKCYqEHZMLVpT9i80Ede5YEeN?=
 =?us-ascii?Q?h2SHicTH5sNgx+wA7w2uSwCBFfe/4QycVIs+BOsa1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NxD5rl/X+ELU1/KOuQGWODM3kvtXhSyKbn3JJIIfhCN9g8IPoHiYhaNH6K/g?=
 =?us-ascii?Q?eTeSPttd8e4NPZCUXGNH0Xxq+5UWgp3gUK7C7EX9uCC6/ZwN20jYK1WqiW1k?=
 =?us-ascii?Q?reXA89U79ad/9DWja01Ws6bf+9t5iJmAwaYchgac2+7o1HKqMWJIdEFI83W9?=
 =?us-ascii?Q?T7i3rFYXbU/vEIo7BEaQ1Xy6+xZkYCUEZuDoOfNmixr4kl6fBOwUgD61P13I?=
 =?us-ascii?Q?OPPQA/9zNzvj1dB/R9nfFsz9ChZvHVuyT/4mW1FFwkV8CUkDvxgmpoe/lfBA?=
 =?us-ascii?Q?Yn792Dk9BGGR8qTW8slf4/AbHzScqlbz2EkAaBO0h5vBu66BcL9R3PKnxFDo?=
 =?us-ascii?Q?z9yvSbBiRpuyCQftaeUOTWwPHYaq0tC3Ktqr0iiv4i3itNRbrRVgnc6Py08X?=
 =?us-ascii?Q?8ApusfQztfoG0Twz/jnvFdcW6VqSALdr/5iz/EVXeAVKp3LVwjVfMn/2Shmi?=
 =?us-ascii?Q?TakNdf+QqZTOyUloMdHINecsHelfyiu60rpX+mSFLJSiE0c+ntP1Aje/MpGw?=
 =?us-ascii?Q?LJJLiPmFF1o5UN9wC3kOiKLvxrEzBVYg4BZI18ix883BzCxsioGAyk/2AooD?=
 =?us-ascii?Q?2QE6+JGcxtOwQWFl+93UGlpDfABYqSkLrJeJYYkbWi9Clw1eBmuZSWKVQv/J?=
 =?us-ascii?Q?oH4OFkuOVSnsQ6FvEEfOgzwjVDshOmqB+SDL4qCf08hfgNKgpSkHKJhM5s5u?=
 =?us-ascii?Q?H7B+u8mzquxLMccwnbb7Dn44226RI1UqrCaHeohnf1nA2b8Jrqy3xanHO4TD?=
 =?us-ascii?Q?spxd+raIflmTKCDWX2GPsQIsYro7woLte6W9KSm9XMNBxNDHLRnEKHoFNsX8?=
 =?us-ascii?Q?dEqy80rAP2ef8CQMCmn5Ae5UsOZ4bGKPeRcMmWnbZ0Rrl//8w6WVgSO2Pftn?=
 =?us-ascii?Q?Qei4kOe0MNfOKGj12b3EkPSQ9euoiP0CWmM2gJrmh+2DrXmaz8aeRlaxKiaS?=
 =?us-ascii?Q?JzaNqo4Mp7hgvcUXQJL4Fycd+jJ8KeDcWo1nlmqKtk6LVyJv66HgrB7baSlQ?=
 =?us-ascii?Q?sH8MTXUIVKHSxAQR+M6t3qvZVNnmJaFXP54fBFQofQpxqJR7J1Ka68O9beic?=
 =?us-ascii?Q?pw3WK4kj5iRQSr1rkH/XFdAbUsZxZ+RyL4fZy0YqncofIrYJLPaUlrln6Hzs?=
 =?us-ascii?Q?eilNkN8FkmBLNUNdW/R0qx8gy4PAlm1tCLal71IrerxhMWJkcGRadjyUSoiL?=
 =?us-ascii?Q?puQ6YtNRGDXxiJP5TiZJRv1DUXtDHEnCV3lYgNIJbNh+vdqKHQjJVc5vaWlP?=
 =?us-ascii?Q?W7fnS0V1uw2lVMkev/nMpkBrpFrrGqvrikgnT7j+IHDjOIvjwWdYMfcjTeWz?=
 =?us-ascii?Q?7ES2xgAzr0bfjEu6CYu2RZwwrpHNt4VxBNx28WV8LEhnck/7XIelnbCV0I8Q?=
 =?us-ascii?Q?E57H+Jw+WCrNgXhSqdLRXtXGQEy1wEI0RxUTIpK2VQ6BOeYVLzAn5RlwE5SK?=
 =?us-ascii?Q?nuyY6twBpl/33bkb1pxGgr3ncNKRRynD9Kb0RV1QObwvB7WHyhDEqFSyw/EH?=
 =?us-ascii?Q?AssH3NkZttU6CKGMhCLvGKcS3xmlfJabZfgGFfSRBLoVLL2eJ3pv4wkifM1H?=
 =?us-ascii?Q?u2bt9gVkGitX1QutUZw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d407008-3d15-4c9b-987b-08dcedec8bf0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:12:19.7256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jIWUU5WXJ1m9nvE3tSw/lCsBB/TsM6Gyn3OXWoDST/sCyQlw0IMIGk164BffkjK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217

On Wed, Oct 16, 2024 at 05:17:52AM +0000, Suravee Suthikulpanit wrote:
>  	/*
>  	 * When SNP is enabled, Only set TV bit when IOMMU
>  	 * page translation is in use.
>  	 */
>  	if (!amd_iommu_snp_en || (domid != 0))
> +		new.data[0] |= DTE_FLAG_TV;

This one still doesn't seem quite right..

Since the blocking domain path now uses make_clear_dte(), the only
time we'd get here is for IDENTITY,

Except SNP does not support identity:

	if (amd_iommu_snp_en && (type == IOMMU_DOMAIN_IDENTITY))
		return ERR_PTR(-EINVAL);

So this is impossible code.

  /* SNP is not allowed to use identity */
  WARN_ON(amd_iommu_snp_en && domid == 0)

??

I guess the original introduction got the rational wrong it should
have been "Use TV=0 instead of TV=1/IR=0/IW=0 for BLOCKED/cleared
domains because SNP does not support TV=1/Mode=0 at all. IDENTITY is
already disabled."

Jason
