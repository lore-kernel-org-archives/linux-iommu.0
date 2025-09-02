Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2F42DE704
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818774; cv=fail; b=MNkUEkHRn/gg5LkaO+mR8XFcqooxYVWbzKZ5Nr+5cJIxapbiR3RswQUWzFw10LnyKmdUN3vcE7hocckQcGrjiDKogSBFhA181wv5JYOrQkZgkfR3k1pLkIWIJZt39hbztdgkW8KAh5cOZua4YBQuvjA0HJp3VfY++nEfAZelYFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818774; c=relaxed/simple;
	bh=vYRc0M3dR5m1Acc76bOULiO6Pz617AyZn+VcuMqyQpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l39rDQ5s9VlZPxd0aol0gqDgQ7sLygLhrv6hLqhOlUBY9abpPs693koTUyk89BIN0uAW7RWTYDKhfC3CZE9FEZopQHBYMPYIdqfaWsQOH+tu1RCn5bJ/Jc9/mZMrO6rfa8S1pyCpofsKMI45ZhF5ReqG/9T3KSe6qDTbq6KLYPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ou2Z6CpK; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ou2Z6CpK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gc/CM2q434yLauy6omWRmpRvD+fIsyCqKJrvlxlI35pT9X8XNiFPxV9ddvBDxYr/95HDyl/PC9Xv+taLj32W1rbKevySZ8pUpxJHJt+PfjxTLisKQreYA8ad4j3C+VyA5Zzs+bb+gJFOLvLgZ80Lg45AJyYV7Xnx49658BGdI8ltv7V1x1wKn6yX43uI2daST2BCuJd4/AIiJG8kzD2eLPTckqIJwJsS7nPBkuc2YuIcN/h3v073SxexR3aa8Q8W6bQYBPtyR5ejDSEnfq6FE8bFXoGhLs1VCBAxhsJcmqGGoCbdmdk5vUF0sLoIx+HMHoBUQDCD18cCnWvlGFGJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPLHhjeo7VpCH95rfRq1FRDuZifRblTtuAUv58/QZHo=;
 b=ukY0zI82JULWCNPPE/NhkHmPWaef5xyIPoDbjSYib/Xc5Vs+1ptZ9zskGivjWIYgBjRf4d8ert0urR/YLMO2e6cBhZ9y4lTEKvNivTvLMKnctMw3iNIWlDiPuHSOPpdzsdEjxy9Z7I7aaG0vd0eXcDoETq9zBmkicakwb5g1IP3N7rKyq7A1clXd7wrj9UYZ3jeseVq29n9OSulAqInor6Mce+dpE49VxW6DnJAi8+M98DptHRyPXZpSgs0do7m44oviPO3wjQIjMfRVJ2TJ/A2R66JATQ95wMZx4pybMoWwzUNp11YKk7/Gjsl17+8Eixl8nruD3VIf3n6K/TZ51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPLHhjeo7VpCH95rfRq1FRDuZifRblTtuAUv58/QZHo=;
 b=Ou2Z6CpKVEWHYZRADG+dzy7UTfPNSFxp/qD5b0C+Py3e4tmfs7FMOig5JZRmlCPSeqdWeXfEUbD9Y/NLkFXh91B9CIbaw+vTu03uuuyLDVHZ2lA79ZxqLdU5lvr5GC7pVfvgfADIBWicZ53WT/rGuelCxgqNM2xoM0+5dSU+aQwb0eh2wfEippHl8SgiYv7i49ybZOceJCdOivEIEgcCLob+xOyVAYPwjCBSfyH+K6Z+/JSyrhyXDlq+4R/RRJ3GrWWyA1Bzag3bC7Qf7OfA0P8fdFFd9YpCEVXLZQnv1k/LBsBLvtP9l3N5vljcvZ3Wnhnbt86FPepRmEyyE+1zfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:12:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:12:48 +0000
Date: Tue, 2 Sep 2025 10:12:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com
Subject: Re: [PATCH 6/8] iommu/amd: Add support for nest parent domain
 allocation
Message-ID: <20250902131247.GJ186519@nvidia.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-7-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820113009.5233-7-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT1PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2f32b9-3352-4efb-4665-08ddea2269f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lkUkX3gSbh87Jp3bg9UewpyFNzzDWmgQa5fQn+eyDeNlEAFOvDVccyes/F7Q?=
 =?us-ascii?Q?V1OOES5H4qNI8frft5kok9X1mlL6s3hBvllDBFKWyka01M6oECl0f596415g?=
 =?us-ascii?Q?JBK1BtYOHwqoI7aSaFTJyG9RPZxfNKlFxScCNvZSEkuCTb4I4EmqXDbNXpsh?=
 =?us-ascii?Q?tCCJyHZ2n8oeyNlRTmKKUL+B2rAggE3xKzRIEYQFPHt/YzY3eMN+wxhQ0Ocu?=
 =?us-ascii?Q?IIn+vdLeBPYpUfaRSQ9eGn+/G9T/Zv0DNdVC5N8ZY1Dv6ua9m7ZwRhFSzWd+?=
 =?us-ascii?Q?gzNL499A8QeFg+6rj9WQsFollxA0OFLrH/Hy2Kc98u7J43mZ6MRKztQW3x53?=
 =?us-ascii?Q?NqajPsXfkNhcXS5V/6a/WBY0lVNq/SWSAE6kuvlmHR5QkvypXQHEo4Gdnzq+?=
 =?us-ascii?Q?rmGY2ToKXW8j1esgrbIYvVs8O+gtS5/oB6vJcoQdVf3iMNPtJN1aNIPLJ/x3?=
 =?us-ascii?Q?Up9hgnDZCAWGSxnQbBe4OEzqGnA3JDGH8cNkankVMuKgVp4eam+jlwQo1UZM?=
 =?us-ascii?Q?5YIL1S2NMFJ5hU8gu4RM4/Fs1dxMJE3nXbn3fseztP1WTdDPZjIrVF+IYcVW?=
 =?us-ascii?Q?sVaq8eQoB8vGWFddMi5MeXshZAu9YT//dqwXMsG657moRt8x3sVpROkaL7os?=
 =?us-ascii?Q?mGuFHxSknP2QkVGpERZN5zzmIOnveLxuuBo9JgeZDAixLbVQvaAwc7o7gvKX?=
 =?us-ascii?Q?IXtzQJTwSgT57lGOS/Kb01sgLBp6OkeQq7Y9WZCqhhglzF2geVrl1utO7LRR?=
 =?us-ascii?Q?Xfk3nhmwnKyH8Dh3xEhvD6ViqtHSL33SHsoCle6PjS5ND1HGZPp2BC4ilgaX?=
 =?us-ascii?Q?aft81BCJ+7d1g8H64zYiTaodySRvyMj36HFjZrVus/+aj8yKhcvxs8jbvq+7?=
 =?us-ascii?Q?ZbgSeIEqqzDrTCHF5smm7lrg9Cl1gs4vAXTT+La534uq/izQ1346YNyM1NbQ?=
 =?us-ascii?Q?u7w0QHrLAh4jPooUSPw98A1m4W3LabLwqNO3vgxXyUeSJFDmBN2BHe8BbPQt?=
 =?us-ascii?Q?+iG7Ty/nWbRdTVP3Cv8hgBRqBTO3CgZALjcjir5J6V6XjxG4/xYmsk8gzEa/?=
 =?us-ascii?Q?avH08NunlgrR8QpBlHjU6KuPFsiDhg8InEa6J4oEhRd8JUTLKOyNIdV+az+r?=
 =?us-ascii?Q?qbFhm2gN8znB4PmL9eSawNrEztr2aIlLtID72roF3Toc62yZ9iE2CpUY3d/x?=
 =?us-ascii?Q?DWo/nW2Vb6hxAwZXeNkS0EsAYmtRbv6/eZnqqQ5/mQFQL4OP7zUGLo27fDEg?=
 =?us-ascii?Q?Q6buMxLUOHVy9/LRqkx+CJadww4EILwEslnOwrcDldEkGkkY3KEAH2jLB1zn?=
 =?us-ascii?Q?p8+SUEl/XZUzzjRRMMA7A54p36KWTlwBoXD5pLCzkg0A6svnwFebq9md9MWZ?=
 =?us-ascii?Q?B58SR0romQL2qGmPBDyMnIDZm9Vq240ScSX87WYToEk1msCGoT1KdkSDekvm?=
 =?us-ascii?Q?CxEnN3KXsIU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3cjIxCckhYYYSj6VDt1TIs1sAtLJMG3ScS6Xr/8vrVUnxecrrGPi9zd0M5ld?=
 =?us-ascii?Q?p/FCGW29qeDXbi7TeulhL/4JIs1IdJhS9e3qW7xmsyk8Li7u8fdVB5t5q1mr?=
 =?us-ascii?Q?VWuyvdZ0fG/3BeHGna8606PYtpkEo3HRbwwUbGwXSANsH8vZwt/tcHzWQMy0?=
 =?us-ascii?Q?Fn55AxU7uDQ3+zq0Z1wRhh6WgIdUnc09SNRIRr0UwM7d1zh8evwd0BkbQmBI?=
 =?us-ascii?Q?EBhRqTJzwZ1D6ZYCDpoAgN9x8deK4wbNae6alBD0LKIcwyLTI4JgcTsiqPgA?=
 =?us-ascii?Q?xJ7iceGUm767QzZvSo/vYm6kBquMQK7AR/b8JxXd0ItPz/Enm7yjOtTXuE/A?=
 =?us-ascii?Q?bb32mZbzAH90ulHsoSi0OWGExgmlksxqphI0HPX1Zz8hw9AiQSeuY7o/rZfH?=
 =?us-ascii?Q?jH4gxH+dzMp471S3T5F+YhKNI+LUKMQAMbDSFUVVtT+vCICzBKA4UgtgPEVq?=
 =?us-ascii?Q?MEyumT3OYwmPDatesmt5WKOmT2fNuYxa9sDMEs4JR1FYcBeP1ct9rJufEsoN?=
 =?us-ascii?Q?XdZl//ItbgLWwttOZ5LIivxrbWpi5lUQvfp6+Iqe0UjFrS7HUrxPnv0yUSni?=
 =?us-ascii?Q?kRJwGqL3brSx2vvvm1H+oSy3AtlyIfL1/qjtvJNyy1Rr+Xjxq1JtMjrN0S7P?=
 =?us-ascii?Q?QJUarKmta86LR6OgDusoBGrQRai77ijHtEd7A+U/4g2+PVyAmN1JkzKwwwgB?=
 =?us-ascii?Q?ELs2QZHSk3D7a/6xkePQ7PG2BnbMDBo+9EadQxQbPZWpW5YDCBQqdp+GxSp/?=
 =?us-ascii?Q?a5lg3GvKcWmIXDh3HajsgVZZtZSz3ktl/nJMbhpL59rN0g0nw1zKQSCyBuci?=
 =?us-ascii?Q?nSlBboFA5sV/yrfUEeJ/sApdHMIqKTqCsNppZyz9GdWOU6SPd0qc0xtR8Uqu?=
 =?us-ascii?Q?qgT3IDUyI6KtuhbVZwbIMJcXS+I83bVsIy3wiOHVRkQ3aLr9FEDMTivgT21o?=
 =?us-ascii?Q?B6DlYgEvUzD0i8lYTm5/eVZLVPzkk02hFII8owlfE5jLT95XfeYlhA5oOzRE?=
 =?us-ascii?Q?1gbqIC5xn1zQ3ZiiT4YCMX7lWvXleyC3KThQMYutMiUSTxr+jcsl1yPujnUW?=
 =?us-ascii?Q?tX9FXh0ktP9V21Z8phn8EJZjXgv+RwNt71C17aPA5Dhsft5AAM5eanHCf6Ec?=
 =?us-ascii?Q?BeTQ5MvMEd22fJan3Z0+XyXNolIMor4EuPqIt86cH1m8WGck5jXEcaJOdYzB?=
 =?us-ascii?Q?oZHFErkcVRvev8iyfTI7ejs9l0I66mjlfAeX0t2/ohpCGftfjj3NO1+CLD66?=
 =?us-ascii?Q?1pfM++6wmOWbpvHeAOAsmIW4cMMQe/TEWIWqSKwaiWzxAcXVlmRF3PNYN0Dr?=
 =?us-ascii?Q?gk3ysekYdiSVTIrCArH4KpoRRgJIei2z3idGur4lXGs3RRWnWFeepVY7WSEU?=
 =?us-ascii?Q?bGnRnpPeYhvJtZH5M8XxhabJYrm9+a698JA6LVWsfyPh5vD2sMjTFL5F7TnC?=
 =?us-ascii?Q?KWkEeFYabX4rOJvozZrHXRgfA5X0gfXz5dCkqq3irZxPDZxlZfV+PpMPMoE/?=
 =?us-ascii?Q?J9TXVXZLgPK+VoaAvl1bKYh9FY0SmNwg7UqeMPa4XZ0lhNb4xM8KnEoGedAL?=
 =?us-ascii?Q?3pwXbSCz8E5u633pHzw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2f32b9-3352-4efb-4665-08ddea2269f6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:12:48.6697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GBkY79gEDRW83GW2xol3FWatPkWEjYkbhcopUV62W+slq+FmDi1EYDoA4IMyY/+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458

On Wed, Aug 20, 2025 at 11:30:07AM +0000, Suravee Suthikulpanit wrote:
> @@ -2626,6 +2645,7 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>  		/* If nothing specific is required use the kernel commandline default */
>  		return do_iommu_domain_alloc(dev, 0, amd_iommu_pgtable);
>  	default:
> +		pr_err("%s: Unhandled flag : 0x%x\n", __func__, flags);

No prints triggerable by userspace! Remove them all!

Jason
