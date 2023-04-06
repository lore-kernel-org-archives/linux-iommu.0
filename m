Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC1AD47;
	Thu,  6 Apr 2023 19:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9LxkgDiiGT7eJwZIpe6hfsaPdHu2lzxeiT5BpVn9/s9RynWZpchMZrSn/5Z7Y0SW4K+Wk4XBMW7WUsLF+/rA4gRHzWIipW9m5HLcKzIt6x8UpFChzAr+GK4hbre8c997aj3WQJ2iEzeTcp4j/GHIZQbJQ2L53PSJ2oMNzFoGpwo11r8FWoAR/65gQho9SvwtEM4v+E6j4KsmVUsqhgK/00SX7GXnPBfPRfVAxvBR9Ppj8TgvdeT30K0OvnQB0MPKoA8ZwFHqQyupTqUazvzoTUKvCwtED6OCB98ZOnRf8tAE/84uQwR2eSvxO8qV/aotHKcLmRHlAK2xgfWP2wxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRi27qQG09kWNchqzKqTZBra/TNNK0ehzEvJThcTVgE=;
 b=mGW5kaGzDrITgoiHXli6uW/ciRT+HDf9wuf09KQyGQxwXm0HytR3X9FissNT5JP5/U3t9q8v3WmQr+wevqVfj0If+W84WGSoA57q2JDAV/0nXHJW5pL89ip7tvHp/JQBSbQgaY8zMeKzdsu4GljL9CUTzLWj/MWV2ClXGojB0ISQa/lNtyslJ9FNO0v/d+6H5KcGELy45do1T7Bjm6UOW25N2wRN4MrN6PfonFvfpaBf7OIRLkgKi4tkZ9Os5ij9v17R0JoRwRrB/NtU3lw8ZvPla0R6vrBJPMoRMduCeh4o4myTqlWUAHplsGTXvRvSiCSht/uSyhz8bnxq2yktdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRi27qQG09kWNchqzKqTZBra/TNNK0ehzEvJThcTVgE=;
 b=KZ9xrKCtZfCy4ZwugYHgZDKCMocs/2nkXjSaAx5YYaD9gzNJuQ8qU2FzhlZksc7ZVLcVKzEa7HE41FSVXAVKza6IhnJClbIXKgEBpzlnfTkFjM7R98NAzRLXpuEpdy32wjVKEII8QoxgvXVXw6eCbLZn8YMI/MRQfgrBmlkfA+Z7JeZWh3d5EmnsPx5pBN9rb/CSOhB8xtb8wln/lhpZ/C+uGE5mxM4c4QYhXtDWq1RvI6KRoG12jDNKrApynL4jD69RcMEf9IZibOBHzQyBS1F1f93eI+bLqd1YgL5Bv0KziWUmuUoBXfUCQY3j7JUw7MYvHF86zSIOR9ytA607eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 19:34:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 19:34:46 +0000
Date: Thu, 6 Apr 2023 16:34:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v3 08/17] iommu: Make iommu_group_do_dma_first_attach()
 work with owned groups
Message-ID: <ZC8e1QKO64pDdPfk@nvidia.com>
References: <8-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
 <db92f18c-e2ed-78d0-db7e-83d8ee8a4dce@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db92f18c-e2ed-78d0-db7e-83d8ee8a4dce@arm.com>
X-ClientProxiedBy: BL1PR13CA0280.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8245:EE_
X-MS-Office365-Filtering-Correlation-Id: 36cf8645-aa7b-4281-5778-08db36d5fab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dvPZf+dvMcQgf9SlqtILQldu/IYU+Tj7ew0dBim94en9nahgiVjJJv5FT7vBaLPw6s6bWscGSZTOO4VasPLcEBhsUyEDpFbqiu7HMu5XNby5ru0UaF6JbPkun61r94ZczWTx+Yn1xKpeLCdyOzkOMxFHvC0Kk96SRKkVPl1IiwWc7PY6eHcdWcpNw/P0KxMtjf1AuY+7uGP+oToCBEtMOqCtf9WOKQKg3kjCXTjIHUTkbzHLQbLtQcAO6Rst3WAMQ9XUxDmNwBaP66b9hSJ1L3bQSs+IxVxZ+tcDFcery2CqCwohL49GM01ZfDWisGkD06oAEwFwuqfsi95DoAzusIZKi7Im8Lagn2WINpRi1jA0yHZb45DJqkWl21EdaqravUpdAnuBIkW07j9ewIi/94AC2tZw5sDAdTs5A5yzTEpBmAXSAlybNAqmP26ejKiudNkghRKek/TKkAuVQwObyJXqloh2K7YDLNTh9nBJ74tFWzwiCee7/Q0eCnRzgHE7jqQOBJ2KOVY2xUrbC8Z9D48XE5e/5Lyuhkfz8pL7nx57BLnM756yqWyK6LU6zNJM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(107886003)(41300700001)(86362001)(36756003)(186003)(54906003)(6916009)(4326008)(8676002)(478600001)(2906002)(38100700002)(66556008)(66946007)(66476007)(83380400001)(316002)(6486002)(8936002)(5660300002)(26005)(2616005)(7416002)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/a8pTbi4+ZVwyJbCA6w1qB5kZPoWx4zbWzmAGOrhA3JhSnFXUZnU2+f72Ok2?=
 =?us-ascii?Q?VWTp35YMJ5/Ybx+38GH1IsMMIrVU1D9cZU2OYBtXgUUG3j2aRbWkjzDbXITt?=
 =?us-ascii?Q?ruLm3EfM03ZaFrPXcMsn3DgrNIndiY3W4oB7mnK1B9gjxaSOfPfk+Te/TFv4?=
 =?us-ascii?Q?twvc8LBSVTaap0JhLA0VzOswAc98r+6dGNrhUC5JxHw/jhiHi8FccGzVl7tE?=
 =?us-ascii?Q?QERNywhvHT0hE8aNoeczOkGuNpRDFd3RK2CREcUM7X/Zovnr12Vdn21fREBT?=
 =?us-ascii?Q?8dAlgvtNhD/s7mcTKvNKpvHL9F6SVs9jruqZ/0vwT+DySoGEhj7lJbIQuaZt?=
 =?us-ascii?Q?qzeAL+E1XbRJIDXFTtbe3tvFaBquwDFxJoQk7ZhTZCQod51LabqEM5GixSap?=
 =?us-ascii?Q?S5M6B+53v3d9p7SKDlYlY7k9/mQ8Nia2Kq+D/0cdvDg8soTiWYWU42uO/6j9?=
 =?us-ascii?Q?ZIHvY17Qjj79qbscaubqk1FJdiX3Gzaq7Am9M8lx+XFP+zf87MVzkGoLJsiw?=
 =?us-ascii?Q?h3PFkCrGDI5YqcS+G554BIEAc59ZkUs3897Ut+G1UsifsQQbDWf/LQSTCXpe?=
 =?us-ascii?Q?peBRcG31mMBtns+U5V2jc/jx3xjhwq+MckZjqDBnjxlrhuYI1XZmiE1uWYVs?=
 =?us-ascii?Q?k0Xx+QY3bdhuNjKC9tlJPqmIQrrk+BkgLzSUSXt1g+tap3AaLGlMVDuIBC6x?=
 =?us-ascii?Q?a3OycjTtkK3b19PUSUXRzuSoUnOXK44az9tUtNoz6ZSHYkbSf6m4vxeFs6ep?=
 =?us-ascii?Q?Kue8KS63M+mF+OaphdKuOK+NZHnhxR2MuIYIDjVAFxMasiDg4lTIhIAF4uAq?=
 =?us-ascii?Q?jQDsq0dOmT5Ej8Lul+WmQ/an3yLpK057ZuG9tgbGLTIwoDTt32JdzkMzEjj4?=
 =?us-ascii?Q?mLLMhv6lCC0NUztE6j4jnR8kaH+J8DlsuR+HoyszFMD2pIYXjOb/blMBnwKl?=
 =?us-ascii?Q?xShKPN5P1xuOd9FKYUgQgGIB2UoRlo7z07D0jCwf+nfKAbMa6qVw6vg2Wc/Y?=
 =?us-ascii?Q?HsYeJ/PDpLwRb+mmZNv5ygUEbRMKdKDTeL9dT9NKu9m7OaXPiq2IIVMOG+lU?=
 =?us-ascii?Q?BExHQLIg+JwryrDrEQ0UdroEz0Jxb0NC2xY0mVLlM3IFSeNC34qgo47eVpo/?=
 =?us-ascii?Q?HOk2I+BI7RCIOs4wSsoV6MS7lEAQREsmDHA5nPc0oMvJNExrY9oplExK8OhJ?=
 =?us-ascii?Q?4D8wrz5ggG6Poipu28dE+mv/97aiDheNjcLdgAg1CAn898OS0Beon6DLB0Te?=
 =?us-ascii?Q?ukfuBIchhaDQJWocsu9kVseA/A3f4UxYi1FepPH3NxkfWbge0iye2ft+lr4A?=
 =?us-ascii?Q?YO77IpFjK0/uyu9n+x7ld7ykV5yF7ksV4YMtKfMX4/W7KglLIBN87LTnkaqy?=
 =?us-ascii?Q?Z5n9hmNXY+LDf9Yh6E/wh8tfUTuZvms5qXFRCpVBedT1SsT8yZa7URoWfBQv?=
 =?us-ascii?Q?xDpzIQWoKJb/hc3rrJKwpCQ14g2igC+4QpEZD+V9uu9iLPTrGaG3nnzn0p+/?=
 =?us-ascii?Q?ZC0uayUZ1yuLI5JFYImKUPcc7qzPR5oMNxv8TAhkDfiDK6UAe0Z/7I5ZHfyw?=
 =?us-ascii?Q?0tRdX6/mTIXpvevVyFEwtiy3fNmNIIpOo5m5azfw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cf8645-aa7b-4281-5778-08db36d5fab1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 19:34:46.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3noSqZTQOeuXncCDg2dFY0QRFEyk418ZIol56anziHiYy3cS/kunmOr6lcajCgBk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8245

On Thu, Apr 06, 2023 at 05:37:57PM +0100, Robin Murphy wrote:

> I don't have a particularly strong opinion on changing this behaviour, but I
> guess what's nagging me is that we could do a better job of calling out that
> it *is* a behaviour change, and its implications.

This patch got dropped with your other suggestion.

Instead this distinction is handled inside __iommu_device_set_domain():


	if (dev->iommu->attach_deferred) {
		if (new_domain == group->default_domain)
			return 0;
		dev->iommu->attach_deferred = 0;
	}

Relying on the owned means group->domain != default_domain thinking we
used elsewhere.

> slightly better if the device binds to the same owner, in that it could rely
> use the current domain straight off without the risk of being in ACS limbo,
> but also slightly worse in that if the attach fails for any reason, it will
> now trash aliased RIDs of devices that *were* working OK.

The functional issue is that iommufd uses iommu_attach_group() - so
conceivably it is possible to hot plug in a new group member, add a
vfio driver to it and then hot add it to an existing iommufd. In this
case it is required that the core code set the iommu_domain properly
since iommufd won't call iommu_attach_group() again.

On the alias RID side, I would say a driver should be checking if the
acutal RID is already set and not disturb anything..

> the device could bind to any *other* driver with driver_managed_dma and have
> a much better guarantee of having access to the other owner's
> domain,

Right, this is what the 'owner' argument to
iommu_device_claim_dma_owner() is supposed to allow.

I added the above note about iommufd to the patch "iommu: Fix
iommu_probe_device() to attach the right domain"

Jason
