Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07908BEC
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763511118; cv=fail; b=gYmAavCMHugSQ2wKb84FcnogKs+OoXYD6RSovLY8oHiwDmeS8loVPYyNWsJQWrukh05GseXyvILxFINVrH20gw/FGe5BUdupWsTE/t98yg1EldicRSdDHjNqbgq+fb12ZhetKHUsUwImpAbrm1AMOIA7UTS1Zeb5TjJv6sTqLuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763511118; c=relaxed/simple;
	bh=0N+jVfROqB463zEUSo2+pbJCrIGSPMtFaLehD5Lsq+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DmS+YFRwZivJfCjBOTdpNx8kIET5vtUiZ5yNzdW8PSQJJNRJBcgucDXdFMNJ5S4JQbxcSGL6O2V4zyTQ9cVttrQSWPBvkcIyaXYORcl45tDCHrgjYCU9SXtDUu5YQzLOQxL6nh8qG2Qyu1CA13uEKl8T0uLBthX1bwgp+eVXI0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mo8gR8LI; arc=fail smtp.client-ip=40.107.209.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mo8gR8LI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3eFOpfnHw69xL9BFcwdOMruBAgJjVs+im5ijE4ObomOR0fpcBv7A2/gwNlor58BvHDJ+YlIcojEjPHXR14vGmvf1cOCki/NfO+DXQckitQCD8HxkUem82Oqck/Qlt8zn9TfKrQPGwTuB8AWYWokup1OJACBypTRIJqC4rs6RTDrg2q/CACTujuVT7Ll3hVYxyFHnj+Wn5FGBC+MaH4jRrXL46/qKS7T+QwDmrVg2dNp9YlT9640GyQLwLUY/edrZgCearY/9WorxzLFI2ebbFUrhTOLm5dR5y0qHTPjLJUpmbHD0OKPgnwWAha3UQK06ITEEh1k+Xwy2jKyfJLftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rkfLU/6pbr2MRBpieqYowZeaST81A3RqrRPFCT/srU=;
 b=uN/TW8ROF0uzKM2dVSdKXiY5ADi+x/WqYPUzR2TtoTh5GkLace1JJ63lx4Rg4/5tl7x/dZWXQ5INbpJmjfocrBQcmFEylw0k0SuDHdVtzfofA2c2XCVnQzfxEE+QfDnqPw0gQqGJR58T0uzj/SMR2HvQ8tu1BAm9iWiBMERowTDmjPLOuWXuyrETlMLgnCrz8LuJwh+j5Rq5W1MV3vXrdZ/1XjFpGZ3Fv5YHxcInP9/86uoVjpuOW3MJ16SM8KvwsaPCBcMjVcoiGcTLpTBH2kqq5jo0DNxucuDq/gwbWmHex4UvRr5h/K/p7qH3Drb0sIhE4BrN/MyHJWZVynPCxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rkfLU/6pbr2MRBpieqYowZeaST81A3RqrRPFCT/srU=;
 b=mo8gR8LI10foIShRDb8NzN2xRPnibegOUm0vORn9VQVrKkq3QLLklsBU+2Cym08LwSTGppDAcLjLDPWKpRE/PQ0WSj9eAzEdV3bF4Y5HzCin0+MFzp9FoM1UB4CKj8dw2yeH1Q622BsFJ2bI3p1o2pwajIQ6MOcsUPNYAGPWehTJk75AAzZZIqcldf//YqHOW4QJ4Jte2Aso4RRlsTjyLgFR9qJ5Z18D9Cr2+CKB0dZe2E1KVtLn7FQIXpSz2nFzm+g4RozRnc/EiQYominuaaSfOmsLwD+xKeTS9k2Akd2FPklYK/ICyJrT8J7uZrZP4jEjCqu+H4csxRc3jIE84g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 00:11:53 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 00:11:53 +0000
Date: Tue, 18 Nov 2025 20:11:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v5 11/14] iommu/amd: Introduce gDomID-to-hDomID Mapping
 and handle parent domain invalidation
Message-ID: <20251119001151.GH120075@nvidia.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-12-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112182506.7165-12-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: MN2PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:208:e8::27) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb63091-24dc-4d9e-10ef-08de27003db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d0mqyyN0NvUjKDQxsky9XiUkJOaz4MsZeJ7IIiwGLwALPeNf6DqMqvg+qFBx?=
 =?us-ascii?Q?CwY4EsE0F28PbpoKlTT+AL0btUQog/NhcIleaNe6eLevFXs+bZtnKMcavkKu?=
 =?us-ascii?Q?eH2iWnWHLdbOd8KcCkjOgcbb7kuUpdDMd2q5O5fQd4zqXd/OKIK6f38jaCV3?=
 =?us-ascii?Q?m5nUEKVUXyzswS0BmngdtotKeGd84hbm6hl+8GgD6xWz/eBIhvLEmjQW03n9?=
 =?us-ascii?Q?C/Rotp3hl+Wn0QY3oP6mNzwRljatKDYcvPmJ1zTkrinPaWhPowkCPV6Rhnbi?=
 =?us-ascii?Q?UX8Q3I8AfJ4pvXeoyXsxYaWTFwcezejXTgYPkvymgpD39HThNStuzOSMrG0k?=
 =?us-ascii?Q?UucgV0rwGtPFCL8LKFgaRevCWFFy6rCEMb4BU60HFFM9xNHMcUdr9amm32Zn?=
 =?us-ascii?Q?5dl6ipU/wau2C+Zwydvn5+02D2q/WQLqFUAnXynAQz5FwcJQournSVSYjQuV?=
 =?us-ascii?Q?NkoYfr98EKbWRPWtjjX5FURQoUedk+wiGm+PI06YDMEUgxDQz3nQqsdN6Kkv?=
 =?us-ascii?Q?14qTK7f19fFjU9BLFkFkFAd1fBvv0fRRRefW/haewMMhW5xfWm92cW893Vnv?=
 =?us-ascii?Q?tjeB0YaBVw8XGTJwynsrdfN5rVcraQK3eBFvU1OXz/DZtrP+p9WRztBEiELw?=
 =?us-ascii?Q?57cLXjSr4ak+89TImGiVrKnSctvudVnKw/HgetVHYBVfvf05UiXD44XpncPm?=
 =?us-ascii?Q?a/SCjXZZXcof/b6Jz8Feeix4mVnykIecGSayOYOQqtBYon/wmZP37bfObfeA?=
 =?us-ascii?Q?fDdgb+tJvy7KeOzI+jlAISlJ3qHg4sxGkrRTtfCvbGFRSP4k+gf21joZw8OG?=
 =?us-ascii?Q?ddk43et71G6sgr/gb7IAEPg2myBlCkBQQED19mrq4eBD83Ks/6KSRVab3RT/?=
 =?us-ascii?Q?A66fbah4BrR74YOx0weJOleb3bgtxfDk1kcCTZAi3eHpgR3UOXUlfUs/IdKW?=
 =?us-ascii?Q?hL9isvHyB30oYnDcfAFh6AuCFK3lkAjv/hCCI67rGFspiR/6xzBAFBoOun4o?=
 =?us-ascii?Q?vVwyR8efi4ZWyYSs/8h/9RylM/wizvb0mMn5tKj4O+mTvOMMtRFWCpJYgNRu?=
 =?us-ascii?Q?M/xcbcxkvQAKV3FArnwHum81Cl42DnjX2SzjFAg4eOOQaZVAyFnfCK9odrFb?=
 =?us-ascii?Q?0JtaZrXZwbOLrke+9JQBwPdMt+ajvZeh/hEs6zWdGdgbylDiK/pKKqxEl87r?=
 =?us-ascii?Q?6OR1DsfhPAewunNUFF+wjZ8MgpTlKBWvbSnAp5PjCxT6jTBXJyhIvjZtaetM?=
 =?us-ascii?Q?DVZyouLo/8zwJYr1tuyELdm3+Hi7eT72pEntcgT/ylnDQcK4Zey5/NiQp9eE?=
 =?us-ascii?Q?HSsumilbboBwNiguayRobYEqdDMDtB4VAbh3UbuxSHxBn583A+G5VnVuJ9gW?=
 =?us-ascii?Q?g84AljFlcT/SMfKqYYgZaRNcuOwp6pr+3YsnShfBi/VThOtAu2k+35NjWd/g?=
 =?us-ascii?Q?enNiy4ye26uErsy0OmfjIeZdswrGfU/hWCFClR4kaWffGWSqZGg+3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SSDTyc6mruMv9Zkj0mV87DE5YxKAqci1zKlkQGHeNbcCniPzCbxQrtIsW+dv?=
 =?us-ascii?Q?ayUl3QxuZHJt3X7rWKp38sCnmKIwQXfySBUfYAxZlqX7VjpflFql+lA7LKoV?=
 =?us-ascii?Q?KukhPVo7wrSQtUbDysm/2jP0dEWs60EDhNL9fBwr03aNXZV/f/V3SKN3GZ0z?=
 =?us-ascii?Q?aSbrf0cIWxJrX5O3Q5tSrrzTmlbUWzV65u1pCyq/b8QtppckC5KnbhLH+Cjs?=
 =?us-ascii?Q?3A43fQ4H7lKKX4qiq9ZqUOfKJPzweyB3fA6wHsPlBqowmkvrXJPY2HLqjkUF?=
 =?us-ascii?Q?5p0Sd3F3UjwQLvbwv/4ZhctdBikPRPlGnDco4YuE10eyxuborGfSBzi7bVy/?=
 =?us-ascii?Q?W7SncaEpxaufk7kC/vUf8UvxF3bmSL+9SAQYWjDhnCpLJ4xwW/LGeisW75y/?=
 =?us-ascii?Q?fAP9JlRotJ9Ch47716SrTvdnbQTgh3PtAEH9eebeRl07Y8OqMy5tJ++LTKWH?=
 =?us-ascii?Q?P0CDm/03EUR1xEn/HU1gLu795MHUC6Vzp1nrw78k1zw5TL23NNYG0VefnzjA?=
 =?us-ascii?Q?XKlfaisZFurIfUeebFblCxIQiZQlrBd5nFz5EZtZvf8/Xi1lovu+dsXJtYLK?=
 =?us-ascii?Q?wFfbWsRbE0XA0+HlBT4QOK9zAzFMhcwOENwmmafVpRw0Vb29z76+y+hXMzjy?=
 =?us-ascii?Q?s7X9wKrMTm1n765AYxVPuvB8Icz0DxPhdHKn9prF34jef4neVrnFgiBFHCX0?=
 =?us-ascii?Q?Br/n60SNlMJhd0p7E4j3gKe8LYD/uuE8Wz8wai/1R1YyKRU2gjP1y2pJWiEM?=
 =?us-ascii?Q?Y4wNGuWb3zZA02kDotISN1r694jzFjZrqhRFuqmyCYpFRg1K+XhLQnXWdmWa?=
 =?us-ascii?Q?F9dKIwkg9FXIVQJyHzC/AqEM0e6idfFkcH96LrLtoqBCKNV/3CzvEaEgwsUx?=
 =?us-ascii?Q?/F88R36kw+WrcoXBhHKMPN5BnAD2E19+Nk8rqVPqq2ZXGylAmn9tfXZ+4UWQ?=
 =?us-ascii?Q?syUw13EIxn2w5pMl3FqqjnoA5havQLM3g2b325OBVHlQbFWAUUy9qAHpIuDN?=
 =?us-ascii?Q?dV4dVZWvZCOlgyapyjoBch/iQTyvC2ZKpEZ7SEnwjcUSLK3BoNO6V31bN/Ln?=
 =?us-ascii?Q?q501cmU+ImVGuVTN57AAZA/OtKlblFb+L1QUilkKESwSDNvzgmOhVTxFcFec?=
 =?us-ascii?Q?wHbcA/mkn9K2pSzjDFyuuWjSNl5qOTIrDgb8zSy8lNHptZAqQ8hZvrMk/+EY?=
 =?us-ascii?Q?mnkxVkGVbAq8e+G4aco2RbbaMNT2mPoijpVRk8RyPqFk479gZOJc27VU7mE8?=
 =?us-ascii?Q?0HMPVUnwDmiZA5OZaUDoCsKhbd4xJ3ARW5Lm0yqnWqt2em9snD5lkBheRePF?=
 =?us-ascii?Q?WNoFD6exrzgu0SCnQOBfIBOyX7jp7ZpqjHd3iu3oEwMqOFgfd9rjAQ/TGL/c?=
 =?us-ascii?Q?KWtbYXwqyqMA1//Fr69ec1mAnQbt6yJiwojkUvYq0KcdDCdjwB3cEXNzcVbP?=
 =?us-ascii?Q?g0Ptb1rHdGf6vv4v4q1pV0axGezPjz5YCj+7VxjlJi34GUlKJq5YIQuUMaDp?=
 =?us-ascii?Q?yz1vElQWBKD2vxdIsxpmhs3kNlUQkdyofE15fTAYH+SJKtPRogJ+I/KtoHs5?=
 =?us-ascii?Q?wuEGooPso8SUa3GabwY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb63091-24dc-4d9e-10ef-08de27003db9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 00:11:53.0538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+jlEi4FAtgW8+v9RzWcRDrp0utnUeYUryuEYH3k58nWUhsyUBjo76Lf9Tj34kav
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352

On Wed, Nov 12, 2025 at 06:25:03PM +0000, Suravee Suthikulpanit wrote:
> Each nested domain is assigned guest domain ID (gDomID), which guest OS
> programs into guest Device Table Entry (gDTE). For each gDomID, the driver
> assigns a corresponding host domain ID (hDomID), which will be programmed
> into the host Device Table Entry (hDTE).
> 
> The hDomID is allocated during amd_iommu_alloc_domain_nested(),
> and free during nested_domain_free(). The gDomID-to-hDomID mapping info
> (struct guest_domain_mapping_info) is stored in a per-viommu xarray
> (struct amd_iommu_viommu.gdomid_array), which is indexed by gDomID.
> 
> Note also that parent domain can be shared among struct iommufd_viommu.
> Therefore, when hypervisor invalidates the nest parent domain, the AMD
> IOMMU command INVALIDATE_IOMMU_PAGES must be issued for each hDomID in
> the gdomid_array. This is handled by the iommu_flush_pages_v1_hdom_ids(),
> where it iterates through struct protection_domain.viommu_list.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 23 +++++++++
>  drivers/iommu/amd/iommu.c           | 35 +++++++++++++
>  drivers/iommu/amd/iommufd.c         | 34 ++++++++++++
>  drivers/iommu/amd/nested.c          | 80 +++++++++++++++++++++++++++++
>  4 files changed, 172 insertions(+)

I think this looks OK in general, just the locking needs fixing up.

> +static int iommu_flush_pages_v1_hdom_ids(struct protection_domain *pdom, u64 address, size_t size)
> +{
> +	int ret = 0;
> +	struct amd_iommu_viommu *aviommu;
> +
> +	list_for_each_entry(aviommu, &pdom->viommu_list, pdom_list) {
> +		unsigned long i;
> +		struct guest_domain_mapping_info *gdom_info;
> +		struct amd_iommu *iommu = container_of(aviommu->core.iommu_dev, struct amd_iommu, iommu);
> +
> +		xa_for_each(&aviommu->gdomid_array, i, gdom_info) {
> +			struct iommu_cmd cmd;

What is the locking for the xa here?

It looks missing too. Either hold the xa lock for this iteration, or
do something to hold the pdom lock when updating the xarray.

> +			pr_debug("%s: iommu=%#x, hdom_id=%#x\n", __func__,
> +				 iommu->devid, gdom_info->hdom_id);
> +			build_inv_iommu_pages(&cmd, address, size, gdom_info->hdom_id,
> +					      IOMMU_NO_PASID, false);
> +			ret |= iommu_queue_command(iommu, &cmd);
> +		}
> +	}
> +	return ret;
> +}

This is kind of painfully slow for invalidation but OK for now, we
don't really expect alot of parent invalidation traffic..

I think after we get this landed:

https://lore.kernel.org/r/cover.1762588839.git.nicolinc@nvidia.com

We should take a serious run at trying to make it shared code and have
AMD use it. That would resolve the performance concern..

> +static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
> +{
> +	unsigned long flags;
> +	struct amd_iommu_viommu *entry, *next;
> +	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
> +	struct protection_domain *pdom = aviommu->parent;
> +
> +	spin_lock_irqsave(&pdom->lock, flags);
> +	list_for_each_entry_safe(entry, next, &pdom->viommu_list, pdom_list) {
> +		if (entry == aviommu)
> +			list_del(&entry->pdom_list);
> +	}
> +	spin_unlock_irqrestore(&pdom->lock, flags);

Same remark as Nicolin

>  static void nested_domain_free(struct iommu_domain *dom)
>  {
> +	struct guest_domain_mapping_info *curr;
>  	struct nested_domain *ndom = to_ndomain(dom);
> +	struct amd_iommu_viommu *aviommu = ndom->viommu;
> +
> +	if (!refcount_dec_and_test(&ndom->gdom_info->users))
> +		return;

Same locking issues here, you have to hold the xa_lock while doing
this decrement through to thecmpxchg otherwise it will go wrong.

> +	/*
> +	 * The refcount for the gdom_id to hdom_id mapping is zero.
> +	 * It is now safe to remove the mapping.
> +	 */
> +	curr = xa_cmpxchg(&aviommu->gdomid_array, ndom->gdom_id,
> +			  ndom->gdom_info, NULL, GFP_ATOMIC);
> +	if (curr) {
> +		if (xa_err(curr)) {
> +			pr_err("%s: Failed to free nested domain gdom_id=%#x\n",
> +			       __func__, ndom->gdom_id);

Don't log.. This should be a WARN_ON, the cmpxchg cannot fail unless
the xa is corrupted.

> +			return;
> +		}
> +
> +		/* success */
> +		pr_debug("%s: Free gdom_id=%#x, hdom_id=%#x\n",
> +			__func__, ndom->gdom_id, curr->hdom_id);
> +		kfree(curr);
> +	}
> +
> +	amd_iommu_pdom_id_free(ndom->gdom_info->hdom_id);

?? This should be before the kfree(curr). the hdom_id remains
allocated and valid so long as the gdom_info is allocated.

Jason
