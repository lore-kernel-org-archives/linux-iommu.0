Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2B732ABCF
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406933; cv=fail; b=XhPz7WXlZ6Uz6dIzcC2HpNUDj2P+ZrK7dfDZ42cuTWo90KvPrkhT/QbXCBhaBoam7l7LPeWrL89uhl1b81euBuyoY/94PswOeWqqSDgxp4s8SoXzhutp6cFW4iU9QjReDTk06DdvO9KFIOYx0kzlJdHxvMiVdD0q/iQ0vQvXnSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406933; c=relaxed/simple;
	bh=4uXhciZBB+sh7JbIMREVgXmYOxoInmbtwZ2qiyufyXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PZPWYqldrsa+GVMW2m32H068YcN/FGPV5yvGWT51j1JYEHaXDypbqFqHD4Tau229JwZCmQvTI/vVwncGcKoDwTKRI5wCtmqqt3Zkv3kf3CjTarc/dVN+NejWV4UR7JgTl0HnXmGNm9MQTpiZc+3JU3pVKOcsZTfZdx6NMuPO0wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tNh6Up6J; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tNh6Up6J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYGeQyhbmv8aJ5kMSwBUrmF67kIRfE4xffb+/UvQW2/m6TfF4FFDD10o+ASOfDcpJtVnQCDWwP1iPgx93uCEqbJAC9IcVG01pxhZmCMXy92MUnyyNC1vSOd/I7flssJpNt1vs5FYZq4+vMHBZYDdCr8D5t/1V3j0nMcPkCFon5/Q2oGJ07ksMiASmFGZQ9G0ttiYoq8xOGdCK3JrAka6ULElGvPwpxPbEAKJYvFM9NyCgKD85ihOJi7PLHqp/VIdGwqNFIWLp/Y5uUSLeQArF2kQ/t8cl2P7VgLJgRKuEN+t74WGrVSzcoyx7bVjXreI0Bv/dv1vKQbd9NmC10rCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlniBrzxUEkXjR0wp0jmn/AH7+REV7YRx63oBvcwspA=;
 b=Zps5h4wmGsyfM+y9alZgAb02XE0j4v/pLwqogW7K8U6tQ1iu+Uz5COnfPNC23Mbadno/UA0qahWlzz4+dZWC8w7am3c22Od98Zbfxu353Q5q/9b2q2LBxB8TOgFFJHWXy+bhADkxc5xqqorEPQcAU4YV9hACe/DKKArYuJ+RVgMCHM2buC7vUc38i4rv4JcZqbndswPJ85Ttca7PmwdQaPdcp1RB43xagMDX/Z1nHIP5D3ttVXgPQkMH2xPkkUje19flRd9LtL98rPRBCf8broxO/a9LsHDTT5K2ML2RsiToZZ0jBb6ZUuKYHDzvhoSMnvmlewYfsijWOAA91hQfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlniBrzxUEkXjR0wp0jmn/AH7+REV7YRx63oBvcwspA=;
 b=tNh6Up6JHI2vJvn728NA+HEuMZBPOrrEUo7vNIT2LV4YoNUhW5DqZQK0Ir6Xyt7yZlw2lg/wNckekUOXrXeuW8H2+q4ed5dCWhNr2O3MxVX6EXf2RL8kKQx244PJQJNIN8l4j89fmFxlcPv2k6uCPZ3YwBaGaSTxPsZOQgWc8U2tCbnnzlxQuKsav30oYF2MB0gR52qswI4nYleg1tfFyfCUh1rCs9izkUJpVU+9c3s9qEis6eAXUi6GaV+wDj4p2f+gW6IkagktI0Jh6gnpbwW135o7jZQSUn88AdVdu8SNA4o+0pSclhvhLSOQfQ4Gk/uJL+GAofnWYrDdxkL2Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH1PR12MB9621.namprd12.prod.outlook.com (2603:10b6:610:2b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 19:15:27 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 19:15:27 +0000
Date: Mon, 17 Nov 2025 15:15:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: alex@shazbot.org, thomas.lendacky@amd.com, vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org, aik@amd.com,
	kevin.tian@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v3 1/2] iommupt: Do not set C-bit on MMIO backed PTEs
Message-ID: <20251117191526.GI10864@nvidia.com>
References: <SI2PR01MB439337D5513729BAC122F526DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393D642190C5C04A0543236DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB4393D642190C5C04A0543236DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: BL1PR13CA0266.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::31) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH1PR12MB9621:EE_
X-MS-Office365-Filtering-Correlation-Id: af7fc3e6-071a-4433-ee3b-08de260daa8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tnA5wixtNlGPNcXLxcbtrWvsdBRsK6W1f17dfhkcKUjXQdWh8htGU0bQl24k?=
 =?us-ascii?Q?4hhby36iNlINWEmHDnCwwAZm7Qaz+dg2SVLYV+kMTElE/Gbnq4WBlC0bTV+Y?=
 =?us-ascii?Q?n9K7M01/TEclnQ6P2ny2zQMPb5Y2FSpVnq0V9ibuhPuZTGlB6RrMhlAHNUA/?=
 =?us-ascii?Q?uRVezqkxR58CYodBWZexKmSWx5gBSDRWgPg+BYVuMUHVCIAjeRxDFAKzfT7v?=
 =?us-ascii?Q?2CwUMpQBQVgBF/KPovKSIIQc00sgh82NYnS2Xh/U9ltx6R0pkgdDFANpXYct?=
 =?us-ascii?Q?9inSFpCUDk9ZJVN63GRqYuSObN3m4d8LW6Gu2Z8L+JJnGFKrt8EtkcXnreC+?=
 =?us-ascii?Q?t/QgpOSuAE1+W0h0h8FaGgpiZVkEt70KY5r8ozLV5OLG2kt1uhP5fAyK03cG?=
 =?us-ascii?Q?NeF7g/sqVAwoWbC71ByW7NJYzc5ZlivpUfoxsdV+NkCsBBNFL3WqA9C0HZCR?=
 =?us-ascii?Q?zDRITvLL8SZuJjdOhqUzZEMwAfgSnr5s+QuENHMYy/+n7nmoKQB0lcjlC7QR?=
 =?us-ascii?Q?/Rz1jcnJHfAgFYPrHLTtjDCnN5ctqVXn6lDPyScUnshn6aizJcqAo8klGt8t?=
 =?us-ascii?Q?cEw8YCaFeAhxp0f3dDVKX7+cfUWMaMW61qpHp2XeOj+nO0fNGdloPOb8qSRq?=
 =?us-ascii?Q?mj+a+KElXw5F8DPqBWTJ9cMsY5n+sD422/o1t5KqALOLM3+RWOwbf/bzpV50?=
 =?us-ascii?Q?WxmqkKC9T1e97hxZ6P4EnlWI1I1rZipwTkAZeCNlfbxGk5umVhdoLh93pjtV?=
 =?us-ascii?Q?IVPOQIsgO25rzvF8Q8rgNXgqN506X21wzJsw9ATbhGiKhvaB3UfQGdKHjay0?=
 =?us-ascii?Q?WABUNwY+UMZpY87EMq5xWg9dTNuOD8cNWFCNwbj3yaGl5Pi22sP06T5dLmmp?=
 =?us-ascii?Q?IQDB1Y2C+sPNYo4jUcZ/x3Z6W38m6slKGXVWjZFUvjmQWx6RbeIVI0khkQCk?=
 =?us-ascii?Q?rQiad+3shG06gnWDG3ApF8NmqvMOuD05ECK+6ppOiMHTtb8BGe3d1gMGyVAZ?=
 =?us-ascii?Q?eSXV9haQz8jZfx+GjZLJmBW/CUDpk4rrPHXk9WXyQanY5dTJB1ny7sa/UG38?=
 =?us-ascii?Q?FaM31yaudO0ZX9j87cFcFC6IN7Mh2uCgDNjOkxYySoCQSnOWSwgyRMqMOosT?=
 =?us-ascii?Q?CSFIHTe7sMWnEja2XB54tiMkT6Z8kkZP/6sxHp3cvxIT7RMo5SbwDRTy9gyP?=
 =?us-ascii?Q?O5KolOJmEAnPW5an+rjv2TTnYx1mRDBG5l3YPHQqn2hXFKh5BxwoG37zhF9Z?=
 =?us-ascii?Q?k822bHx1978n0iUlwplu/9Aj1kevvbszOHOWmYyGvHCCnj6EgGMRtj91gZuh?=
 =?us-ascii?Q?z5QzqyduEB6Hu4ilfUlxGPGlgmpSruJ7vLN40qS9j1ZA8n5htY28I+t0qy+P?=
 =?us-ascii?Q?Pjt+8TnjxBSF37t5cNVz82m4R0BwcJP8Am6HvtOuTunu5WFZCJBSaXITv0CE?=
 =?us-ascii?Q?i/BPoYZyl3PMGoDxWh1EziTDnbsio54r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tu60XNF7RmrT9YafleRktlDa9jlk+VW2V9HhLpwcpu0MFDkz7CHv5eOOnfYt?=
 =?us-ascii?Q?Qr+x9QkAwjRezJp6R5pxJelOJQGkVpgex2qUbTsdB+ibNbAhzH+EcwqM1PuP?=
 =?us-ascii?Q?eCAliTSl2gE/fleuRkYy3GXw4sf1nBNQRfTOnxVAJ2/m2CWRDlXIRnGWLQ5K?=
 =?us-ascii?Q?FZ+KlK2P4LWNzITsIekNLsZCn5qelpqc0Vlxmdws7LGxFOcaKR5u1pfAKgmU?=
 =?us-ascii?Q?wee0f/oCqzmXcpImJHev38e0LUb1kDNGkfpP4LMs97PNj9PPZGfqvGkCfn47?=
 =?us-ascii?Q?g+zy/+J9bHxYIeI6tvzECl7SeZYP63148yI9shbfBjzmAPkwYmv6KpEx3TN8?=
 =?us-ascii?Q?r5Lr1FV+6odx9gFAtit9E/5QzwSpEA4JGWD+k/d167ZvcZ0EqzFfEgwg4MLk?=
 =?us-ascii?Q?NpzViK6Q41e1JdpaNGEeS8z9A9mtqFalD6ZLqV/oOkMpFNEWjeie9RLjMO3E?=
 =?us-ascii?Q?k2TJGb4x2GwbbDdV2eXfjdHusfTp6Ni0LWXHrO7uYJsy7X7myIRgIAxGQURo?=
 =?us-ascii?Q?1I0VpSG8pR4OPWFm65lyOM5iQqlf5LWV6aFZhcCVPDwHrpm4QvLDov/vDaMt?=
 =?us-ascii?Q?bqyumI0/kIY3eb0DHg2/zVAO9J5Gi+kzsRuz9+CMtEgxugL1Sb+Xvd5i6J0U?=
 =?us-ascii?Q?Gpe1tcgHRI2ka4ZaFkcOogeYNjFNWnz63iQVkufbUHJahlTcbYwz8o4hywaw?=
 =?us-ascii?Q?RWx8e0seLzYtPLwRpcA4q9kdCSN+0AR4BdO1Ud6ZuDurVUNeYhMN67UslhSm?=
 =?us-ascii?Q?Zd3FsTaNLRCClo8HF9aT1stLDirXCSA/VSzz0bytBCVz6Y5qpMjX0bkWYO4N?=
 =?us-ascii?Q?b3cTLqAojcejN5MUSLY3nWp/hINb4qWKv4yOyrS5EgM/wvnhadZjG/628ZpY?=
 =?us-ascii?Q?T49KYjn1O2E1x53pCkklXRmcRe9z51ntEjh9lFg+TaakRmp/boK8QqNvMSUT?=
 =?us-ascii?Q?9W2OkiypHFQJi7zyVJaYOW+EI3m11kjnosivUxn/C/zfQjRgAhVQEr3f9xtJ?=
 =?us-ascii?Q?O0m9/v3TaBGZt03TeWzTXxmny4LddGprOelILZoCu4DZ8TML1VJiJ/GKfNZo?=
 =?us-ascii?Q?N3oVo6V8QEnEH+yJhV5h35CcwlJ5wfzw+4MFN417gk2SCtMICamwts9DH2Gf?=
 =?us-ascii?Q?Zh4AQkbpjK9JmAKMVfEaqORsPZAFUWkuy3L+4Uyvp9tsnmeOXtNLGkuagYCT?=
 =?us-ascii?Q?AJuxeAuzPVsJCqv5gIqhkqBNlBM8EZQ91JxXxHbdwab6Pu0ykc/Jhzhr8rLk?=
 =?us-ascii?Q?9JFmldQ5Qn6QESWYR7CurOZHMk49fj1aUABLsBD1iAdQu8f6K2Yx1UDpFkdP?=
 =?us-ascii?Q?kJ3neehb8veKqWe9TIoKiGEsjlJXwCg6AVUuw8G+DyVlbeuM7JedBqWKgypY?=
 =?us-ascii?Q?0zFcC+XdsxYSToYW8szffFMK0Ns1lJydbjjcdit576FtutgFqY/AKl7SdYvW?=
 =?us-ascii?Q?Bb9Rqk2+51bbOVPOihGytKmBxwN0R8oBrZmQ4vu6g6NRlwUdhzzWRc8mFgo5?=
 =?us-ascii?Q?saYXsTrmuXi/B6Zgmh4NMVegy6gqPPpoEFWlXOkrXLHb7ZMqijxg+t/4oBoU?=
 =?us-ascii?Q?4Ld7v149HWuD0Xcj31Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7fc3e6-071a-4433-ee3b-08de260daa8a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 19:15:27.2861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bgz7aLxGHoFFdc42NMjtT1Plia4Md8ziR2Kqu3a8NwmXlbb1Sb+pcFj2v8OWYP2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9621

On Thu, Nov 13, 2025 at 11:54:06PM +0800, Wei Wang wrote:
> AMD Secure Memory Encryption (SME) marks individual memory pages as
> encrypted by setting the C-bit in page table entries. According to the
> AMD APM,any pages corresponding to MMIO addresses must be configured
> with the C-bit clear.
> 
> The current *_iommu_set_prot() implementation sets the C-bit on all PTEs
> in the IOMMU page tables. This is incorrect for PTEs backed by MMIO, and
> can break PCIe peer-to-peer communication when IOVA is used. Fix this by
> avoiding the C-bit for MMIO-backed mappings.
> 
> For amdv2 IOMMU page tables, there is a usage scenario for GVA->GPA
> mappings, and for the trusted MMIO in the TEE-IO case, the C-bit will need
> to be added to GPA. However, SNP guests do not yet support vIOMMU, and the
> trusted MMIO support is not ready in upstream. Adding the C-bit for trusted
> MMIO can be considered once those features land.
> 
> Fixes: 879ced2bab1b ("iommupt: Add the AMD IOMMU v1 page table format")
> Fixes: aef5de756ea8 ("iommupt: Add the x86 64 bit page table format")
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> ---
>  drivers/iommu/generic_pt/fmt/amdv1.h  | 3 ++-
>  drivers/iommu/generic_pt/fmt/x86_64.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
