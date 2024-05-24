Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E7F8663A
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556333; cv=fail; b=T8TMCsv2jgsLYPHBXkBQoXPQRd7EM80MdVHmNfYbSPNOqINNdm4FEMk3ZceJISzlvYQyewQFDcQYXZvh/0WowCg4K0nxaPCkU602UuBGRf9PRC/zIMA7Z+8iQB10IBauSlWxFW64x3vPL8eh8k+2q7aEJnYU2BLGtrTHRMo+XDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556333; c=relaxed/simple;
	bh=mMf/z20ceeAj78nxq2LvqkDBCgqkLmNb3BoOIt1Ub/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q4b/s8OJiXk869UWCnLA8Q95ybnx0XAn7TakXnJ9OFKZA70+nM5gVNpXUwBv47gHf3yx0swk7RaDCJHAGIO/ghLpHSuEHrGjWoQfBIjS41X41Q55Up8wQHfl4XT//s9a2o0/i887diGfC+1BIlHz+lOKYJY0NPmUZPVl44NtJ58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J+cCI2pK; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J+cCI2pK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSR4bc8F8SBHblngrw91hdV0Z5K487WdHST15hhNxY6Elm0DZg50Fx7ePN2cLHJpHdXSYzOt0xlB0z+s345aeBddCTUyYpkAeTo3taqLaVeEriGkpmVIQG71U5+3tBi0jhQS/GdGsn7n4ghHkyQvNbINUKhoAU0HMhy+bEGn+3Wh0RmjpVgPTKLknIAxC89+CMCzLH6fWwgGchAuQjHAanvzk5Ew3SpXZxMH4E7hLqWRqSMLCcOQwOFAMEoYCJlxlG0Ee8m+5eUgqAKTqMihe0T7R3SUeN9HYXgDeefr8YR0tjHKeylg9XgZBf6TQAj4t0Ci3DaIjzJBrq7Q76HZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mjpdd+llMsfUIV2cBs4cynuoVCDqvUbhSYVpKkFlfsM=;
 b=BtOeJG4sfB+gzEisaFnaC3lDZmpHtGniwMzuHDruwgz39c/M2XKflw7JTID+APOw5NK7DS6vfTN/bLsUKRxaI74uQVzWR92fVFldHnf/Nrz/DsvPYh0zuMzZzRjA6ywow3C/Zs0qlUSO9750KTg4u9RunCXYldyz3puN063RnWmLeTq8pvH/qgVB0x2sznlCfyzlg1g1d0Wnj6Y12QfpE5qxcHKR/o+He7bHqVAo7vKM7TwxXD89KDPZMZZ6Wphi6G2pwJ7YY5e8qZl7QVaC4hJyGhF2n8f574cYqoE0T3fJ7WFZHinm4p9WvEDBaSxpezIQMYYzvYndFRNepbyepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mjpdd+llMsfUIV2cBs4cynuoVCDqvUbhSYVpKkFlfsM=;
 b=J+cCI2pKqFdhTQ96W1HWrHT7sPkpUZa3KKJYHoUEHcEz5JUKk1Yx0VSH/+k1Usf42madmNIw/WfogPuv1iwjmqfRaNLUevvSayJsi5DOaAqUUoBIwBWdxwL6b4vVHGkvA8RHGskRGP1F8huToUklhUdH4Z3XVc7ruWnOpgaXd5cle3XpdY9gDXKWDR0081+0Cf7a/u1CGVZYHtdOFQg2OLta2DuBl4Mkb6EYHerEa5/Ey7zpybPNE+iQqNI0wxdA1S3uarLvejWML2M3erjoHw+ucEVn8H3oYKSBjwwBCyCh4WBqA4D3EvMZb/EjG5YdVRUWJRoS+YCF8EizZfhz4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 13:12:08 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 13:12:08 +0000
Date: Fri, 24 May 2024 10:12:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Message-ID: <20240524131206.GS20229@nvidia.com>
References: <ZkOI8ztR1mUMJ8oe@nvidia.com>
 <ZkQW6/OAQ8MzN6Go@nvidia.com>
 <20240521182448.GN20229@nvidia.com>
 <BN9PR11MB5276EEC2A1DDA9C92F96737C8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240523150120.GO20229@nvidia.com>
 <BN9PR11MB5276A896D215E1FA61DECDC38CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAI5d6ktg7yncLE@nvidia.com>
 <BN9PR11MB5276422CE4B77D262CD292208CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAsXatxsopbz738@nvidia.com>
 <BN9PR11MB52765A6F6044EEF52F74230C8CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765A6F6044EEF52F74230C8CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0165.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::19) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c09d9f-f7c0-4ab2-8a29-08dc7bf31d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3/GuCjjCi1bt4nW3blkymo+HLavb4lFvXBF6htOUTxDwM8sEdRHShHi2jfYB?=
 =?us-ascii?Q?OXsvKZp8+fPVGV5kvRM00Z6ayA83aUEKgUTjIsfl1gdVUS6sup5DFDGOR0Ng?=
 =?us-ascii?Q?cN0bAzZ78yEI9ndTAYbovZAzDpS29XPFfCznG1Je8UQD0b5u+K5CMw/fpEiy?=
 =?us-ascii?Q?KOj86R8kDwq4J0KzrGUcIQ7htWv5/zJyudE5fMEG/pJ/lFrg+4pD8d4B/5z/?=
 =?us-ascii?Q?8epW/xuKcpk5RNwJI3QQgMW4UiqD0wZt56Rd6C5J05uOR1aZev5N94q5WtsP?=
 =?us-ascii?Q?LqzFwLHGgpCg5VdNMEZPBGi5USUso7BnE5ACgQ8DvfNHocXq5TAh7GGD33FJ?=
 =?us-ascii?Q?Pm+T2CjzkarsMJ88JLDbpEzebQt9Nc/j0OpnkYe915APXgeRAsoWTJUKCcSz?=
 =?us-ascii?Q?tuynN1F1Y/KknELoi/yBUsjc7QTb9hRW88HktGIpJ//ZZnVGSqkp9k65iQ+t?=
 =?us-ascii?Q?uSv1oacbCPxjtGXu2uYZhO61X/8sShOfxpAsj+UtIHgJSYzm6kzdTCFfOQ9j?=
 =?us-ascii?Q?aR5p0/Qm7iGRhLPbwlGMXzkvPbdsKqCYBnFa+e/gtQccetWrudbdMtbctdhm?=
 =?us-ascii?Q?/D+aqtyOlBv9QnN/lKsjhHyShOzHDFhnwCiHZGQnLrY00VgMoAP1G4flU5lv?=
 =?us-ascii?Q?Dq/F5zZYjzxzED1z9WoTyU3e55hCOTN/H6zIJBXtX2hNuzJBY6MtV171yAEV?=
 =?us-ascii?Q?AYbCTXYvKW7pojdXBP8lq3kYofNvEQGxscEC0IRf5sVyu2b0FWXoUJHhF3Uj?=
 =?us-ascii?Q?aS2NHw7lhseNGIlSmA6UffUDXuKdcf6V6amg825RBwvJUbKGT1GqkXZxoVV4?=
 =?us-ascii?Q?roTAD17ppavzjwsG4l9eynvISzjhORa+rRjlMm2JuFGuPq9fgG0W46TD4FuM?=
 =?us-ascii?Q?ncsav2cmc4pYP4XBBVU7SXB8A+lUQmLVcewcqHjfLtVVBQbl3O1rBosqEVKa?=
 =?us-ascii?Q?OWvtKstSk5ROqqjKhIwf4/o8LPsyB+gPe7nLM8cFuhisxUkjjbKwRtuiDjbo?=
 =?us-ascii?Q?5uBRfgErs2ZndxDx5AfnmYsSOrfE6azRYVURgvv8yPtZbHttWTkLlkZzAQye?=
 =?us-ascii?Q?nOLuTEjxAu7WOHumpo7e8PbpgueexyFijI7+aEJaefkxnQid0fftCmQtMnfB?=
 =?us-ascii?Q?qxMPGQVSD+KuaokznDMzqSd5Jy3+y9D3Q8FjdPmxM3Y8bv6BJrTZtNWlUDUc?=
 =?us-ascii?Q?k0irlQBcaas3qZYmT4epLt3+p6HeeJrwdUjuswNE3Inl3xMlU7k+gDtSndB2?=
 =?us-ascii?Q?hVNH6s3T1NCRp1cpEQxtBBe5YSvaDX7ZxdLBQFvx3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ccDLoTU9N9tP97tLPsl/a2EdhIZV75Et1yCJQQgS1718awwU3cG6gNFQ4VBG?=
 =?us-ascii?Q?0R14hoVstK3HPAkvjVoye7HLATk8Qso3GpAPlb43gvpIohcGryTBHkYXevF+?=
 =?us-ascii?Q?ERN1inWbth8XACUF/JBaaHzltT30v1R0NQNSUsQQzwBe/ZQRk4XD4kTCQt2W?=
 =?us-ascii?Q?9Mpbx7HAc2dut4Z6L5+Zgzj33z7oe1Wuw4okQlpcektxvW+/65mOEdCTRAGS?=
 =?us-ascii?Q?q4F0nsIx675w4Me+01gANHwv++Pvx7gJ3AobnuEycoZmj3u33TkD98zrwnZu?=
 =?us-ascii?Q?OvayopHiwffzI3aO/aGKUoS6hh5VH+4yvBYyMuQei2hM3e7bQGLlqrXk1MzX?=
 =?us-ascii?Q?resCMMYf2OxmuBjmQyh4HBxeMuvDWJ/aazBc3jttbjMkXJ2H1pSRv+gKhK5x?=
 =?us-ascii?Q?amjZmYEaR8q3p68uVrTK5cH4203offx6H2c97aUktQeCyqXIl+fiOsv+AyQx?=
 =?us-ascii?Q?UT2h2ED675c7SOytiiOK4+5q6HV5Z51LI9UE+Q4SHYkIIHWXIUrzh5hfSepI?=
 =?us-ascii?Q?aW66AeNeO91KQaA198ABwHboEcK9bSLhOB2+eXv+GQ5KHmTUznRhjhvJ0stE?=
 =?us-ascii?Q?C2cXEgiLgRxuPJ8ODlANXTeKdIvho9zzdQCmd4kkd1gTQBREoDK35kI7xWqu?=
 =?us-ascii?Q?Nq+hs7FC6B6wRZ2a+Kziv6rkse5DgM2RRL4joAREwLT8CczwDTG7VzT5E/CG?=
 =?us-ascii?Q?/g+6xKd/3m6qWF0r/6/MTf2Ev7Oe25ysTXa/OPWkkkZLfFYJ+ZDfMpY2Cez7?=
 =?us-ascii?Q?UOe1uWANvFxMKwmB9KVvS9OYS20PeDjDQGu8+bqWrR/Kef/drmDR1TT3XHKf?=
 =?us-ascii?Q?iBM9SXhIAQaBYSVgR54IFZ2303xiPt4s4MhAWLzvoO3sHnACSUx5jKOWSVTL?=
 =?us-ascii?Q?ZfnTJoPZiF7qbS2y0zocTiDUGMpIGvCGqj6LOOrLBG+HwF1kJD+wjk9mmuHs?=
 =?us-ascii?Q?bnexQMh2l2hKBZlKshIjM4Q3C9LnS1DRk2qI8CG23LETzYktKjffGH8TGZLB?=
 =?us-ascii?Q?bwT9Uv+i4foC9nKLOW3BYvSmyCZJsI9fN2kY1EbxfgiLbgJsOW09mpCuQSHA?=
 =?us-ascii?Q?CeRf7HapHjArorRjBbroW0uvg7b66HcMpP6UpCJ79q5RvUII61VmdFbgzhFb?=
 =?us-ascii?Q?LClGcDCA5SWd1O/DASOzVfbJ0StAGYIkhVa4t7q3MHBfApgj1tZp3TH2EnLF?=
 =?us-ascii?Q?wNxW3OZXLsSOHGG4RTrk+nqLoGNYOjfMRdMR2bq3aUARswFwWaMWIf9ifjIT?=
 =?us-ascii?Q?vghpIUnr39hZ8NRX/oF74BFg0Ur+EcitBRhN8Rxzpe0Kr/0dzgrPihVwu7NI?=
 =?us-ascii?Q?9ydlj27liXCVWEetbs/aT5HldUwXenehx0fGNDf36q5t9slphRaimklGXu92?=
 =?us-ascii?Q?bYdWXpzqUqMUgrS1U4OMDlTDUUS0CqQeQvGhlIbHnAdLDarsx9s7RtS+s0U+?=
 =?us-ascii?Q?H4fkTijJ/gg/2VqHto0ahxbZvvb2glktZKJHARgThyhFLv3+iSThv7jyl8LJ?=
 =?us-ascii?Q?dNv1Yn4gsLRkhGaueM54EqTGpi8bn1qjwYWdgD7LyT8D2FHVImqZ39D4FeA6?=
 =?us-ascii?Q?gwaOGE1SZve9N6KIQR895tR657ZOgDkI6UAHF0+v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c09d9f-f7c0-4ab2-8a29-08dc7bf31d81
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 13:12:08.4218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pc1mybJfwKoccYtu/dV6rpVgOIHVqW+pwMiNZBPqJlidtiYwi5kk40FXUPg/9Gv5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079

On Fri, May 24, 2024 at 07:21:59AM +0000, Tian, Kevin wrote:

> My point was based on Jason's example about 3 VMIDs:
> 
>    hwpt_alloc(deva, nesting_parent=true) = shared_s2
>    viommu_alloc(deva, shared_s2) = viommu1
>    viommu_alloc(devb, shared_s2) = viommu2
>    hwpt_alloc(deva, viommu1, vste) = deva_vste
>    hwpt_alloc(devb, viommu2, vste) = devb_vste
>    attach(deva, deva_vste)
>    attach(devb, devb_vste)
>    attach(devc, shared_s2)
> 
> for devc it could be:
>    hwpt_alloc(deva, viommu1, vproxy_s1) = devc_proxys1
>    attach(devc, devc_proxys1)
> 
> then devc will reuse VMID of viommu1 and we save one VMID.

I think that can work, at least I haven't thought of a reason why the
non-vIOMMU device's VMID couldn't be shared with one of the
vIOMMUs. 

It is all quite a contrived case, I dont't expect people to want to do
anything like this, it is just showing that the API is properly setup
that it could be done. Userspace is not restricted to a single VIOMMU.

> Does that not work so we need create another viommu to hold the
> proxy identity s1 then still need a 3rd VMID?

Yes, I think that can be OK.

Jason
