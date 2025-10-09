Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33357246774
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020505; cv=fail; b=PgEFJYWDzyQcJT3BJLzHvhclBbijL2mkz4OSkXBB0zNyw1TQz2ZGn1V9x2QJF2ZoH+x2YaFhlxfnAls9DOOgdROeBoou93a6KaBU7DouhF2coG+RbyzAWi6OnTsmM9+xGUCMGL9tIg5h4X6S4PHAT0eb/xBFF5cg4vhRqQnY3tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020505; c=relaxed/simple;
	bh=oc31Y0Y/kHtbf0Fq5Vwdpyzmi1WE0Zh6f0EA9I11E8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gg8i3C6v2x5JTxU6lsktuwLk4CcH39cu7R/z8S8lAggm0yu4z3QonekQScT6GUER6a8rUj8i5Q3fwEC4EaZbNq344vRu255PGfcgNJY69QZCzjVQvuufr5ZYG7RCqaQr3ZUKLKmdRoHeKdT5xTOLyJ+IUoeyn8jrThhaXbNq2CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yf0b61iS; arc=fail smtp.client-ip=40.107.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yf0b61iS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyGZdMHYPg7JqiVCCre37tAqOVgtnuLLH9LEanfuIz7jG18my8lpYHmeRBCSK/JhtSTqsdxPDF9J++vuxCzBMpz1z9bMnYq/pWNUNmXRhV7p2hrlfZ5NPE8wWlQGDQX/dYgNwHYsFtUSc0gwstIwSTRH1ZqJfzIeV+fVvHx2n0QFfqR43rrCT3UhOpQ6NaefWxnrSGuV9Y+jvS/SrJofYx/0QTIM1yUk1R1HHwcOKKV4LOBAQkzYroFJHmYAC63RwNNjDJEWD1d/Rpzq6u5bne4/Muh3fT1CXm9L0Ly+PivrNFx5tDk7KdhRKo1DX/T3ejDELr9Ld3Ox/IHGvD9NxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZcb9gW02SIXlVRSElcpzub6XNWDbp2+sRp31VdDW3k=;
 b=bm0+aKtWxeHi+WCjs9eHIFDxZWvxP+28ycFvnKOKL6q2sZbIf2SE+Gyw5J8b10uJTrvNlCSZE0H3CaR5WoagZ8wew1OLquDDo4SC4WV3VYKzGHRh3RaRS7Z9fIODp+ds74xRXIOi5CIAtqbRvTHo3mLL/zMocaQhWMcktSPvhGTBdPI1oSRjn65pBFmsmtyjCd0UdjXIJ09FhZAQglXx/i9nxM8PS3G1Ru5aToLnN8O/P9qx9lTV7bqX+wCH8MYayZuX+bOYJ/3yPa8mHu6tdsWsS8qLzJSx74sEi+SA6uRmYeUGzjwY6u+jI7B96+6d0ETlBBQgCdUPlWiiWZA5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZcb9gW02SIXlVRSElcpzub6XNWDbp2+sRp31VdDW3k=;
 b=Yf0b61iSJQlo30pimI3USwRWbF8NiIOTjzhgMtwV+lvfR843u0S7T1N8RWP6XxJ5HMNKwkyBAh0dpB2bWvIG20/AlFIQcFgBZ6F9mrSVuiGUK6al2coTNIHbsnur5dK4FQnhcVePMx6xHcvjw5qdHkobYPVB0mZ1KrGSZgg6fMan2zq+VbkzX9NW2XHJz2muH7VzTd6HS536P2/R7Ko0OQDgbEyoXkH+l605SjM2Yi1Di8zFXONLRGAV+VazB98c3Ot6i5qvt7NLVCE/12d88oFXwm1DCOClFQejuV25EpeLzlVaoWdG7fYTpqjWC4kyppLgY4ME1ThP6KEoPx4Bfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 14:34:52 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 14:34:52 +0000
Date: Thu, 9 Oct 2025 11:34:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
	nicolinc@nvidia.com, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	kevin.tian@intel.com, jsnitsel@redhat.com, vasant.hegde@amd.com,
	iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com, joao.m.martins@oracle.com,
	alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v2 10/12] iommu/amd: Add support for nested domain
 allocation
Message-ID: <20251009143448.GB3839422@nvidia.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-11-suravee.suthikulpanit@amd.com>
 <20251006144936.GS3360665@nvidia.com>
 <fd4341ea-869f-459c-a3be-a98cd1c8ba4b@amd.com>
 <20251007233931.GD3474167@nvidia.com>
 <bff5f16e-ea25-4c59-96de-8002373f17c0@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bff5f16e-ea25-4c59-96de-8002373f17c0@amd.com>
X-ClientProxiedBy: BYAPR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:a03:80::49) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: bf64e446-fd1f-4c24-8bea-08de07410172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B/1anIjIJRRmBksYAaqxPUDbvLP+/5AHQ/Eyp66W/1MoyzCd/eEtoxaEbEkI?=
 =?us-ascii?Q?Z7/qOqfIJvkyJA7lOktAv2ILgw9bsXsIqonm7411VshyfA5UQ4m/s0MA2DTp?=
 =?us-ascii?Q?KGw1T/PSy5WzWrFLLLGyjWaQ/WdJFvktRMcyulY7nCHG12WVdYd8O4xTF3bK?=
 =?us-ascii?Q?8AUMCMIovxDJoUfAF/2RfuVYfVHdIl//oyTOnQkvkbiRm4uzJchUBfiI7uIk?=
 =?us-ascii?Q?8OypBvExdj/K+E23TG0d8O8eA3mC5/QKoPchxJ3U3oORxE+JtEaN3hktEomR?=
 =?us-ascii?Q?1681HFRO8WcwftOeW1CnIOU0QAuqUP3NCuWFANc24YfUNV4t2YcJFkuWkf97?=
 =?us-ascii?Q?YImXYYEUzBiJ1jIqUyKC811VimBWLVKcj7lEWFTv8bfbikjBBw34Yvivmgar?=
 =?us-ascii?Q?+0X73AzJyxONitxoT7U/91po7owvbht8Z32U5DZjNdo4r9c+Bn7qJhekNRdO?=
 =?us-ascii?Q?kAQjgkiEUDhBSm6AI+c5XLW/qisR6Dl67YRa0CrrqavvNFxd8xD6DIbdZADG?=
 =?us-ascii?Q?CAkTpaKuJO2hY6TOPk2jyDEgPECPvYLI9Ba5lBWIfRudmfG1R43fuopRLcJN?=
 =?us-ascii?Q?cSPxVxg1C85QA6ehtbTjX/YrBvuXzrnUV6syjm+0eUI9WSRvsee9o6sisF6l?=
 =?us-ascii?Q?5LkOETbgMlYvYWNIFwN1uc0TXJHYviZZ4qc3oFyIfaXIj/L9ypOMAXjSnbVn?=
 =?us-ascii?Q?auM/OW9bSce72PTcFJhxlOKarT8+JZH1TyKkELBWnkeVK+Gf13bqBexXEdM/?=
 =?us-ascii?Q?bxs9SlzT5jibmfe65MoDmfd1tdRuYSvUCUhX1BIUX0oMEiilcQllFbTO2Zyy?=
 =?us-ascii?Q?QPrZKVSWFYUg/8J49bLiXGAdr4q/wYr9kl77fe81QyH32o42EAC+f6eqxzcd?=
 =?us-ascii?Q?VsIhSuLldv2MybdaRUHMOg7GMEpqO9o8qE0SsgLwK4CUzQz8MoKZbnumU/5Q?=
 =?us-ascii?Q?MYOzpmEJ33LyAF4UGonFUsIimVkiWkSlpfQgbjDYcPvFDjw7EZv+pXcPYd/O?=
 =?us-ascii?Q?UAJab5BLrX6248FzQPq9vYp8zAO3qTUuwFx8ldPIYnVsvNHybRQKgu2WPKL5?=
 =?us-ascii?Q?VPGZjBgLuylCubQTKvtFJ1fMflCzEouT2YL+z35RnPlV+yYJhzEuDKsPiMkD?=
 =?us-ascii?Q?Puw6wuVSV3WVFQmf6N7GR/SzHbG+UGLKYi03TdsRSFkBjv1OTXkRaIGPGmD6?=
 =?us-ascii?Q?PGunXkynGoXDKQWP5RCq0yKBKiYYqFltxrLYz0DxfN0fxXGVjcFqjnOrXr9g?=
 =?us-ascii?Q?8LyTJl8pS4nY2ahOZkNBjfBxdDNTyZ7jDEkbUKMyb7Fjdy4Mte3YtrzAziEg?=
 =?us-ascii?Q?3TbcpE/jbKfxl5IYcQT+7lETF2HVinsMKFsvjQ7NGrlY3+57+PhkSZReVDMh?=
 =?us-ascii?Q?RLrXf7SJkpaJgq5+3W7pIfkbLF3+1zGt0hA6t6ue6lkYOsUBXzTPcdhgrtz3?=
 =?us-ascii?Q?yeR7RUufHGKaeqz0ApUwvk/yj3VLQZnU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aNqSQFWZc0dnYfpFrbhGsJJChYsWUgtz+EZcx1A04TYuo5KoYD5R58BnyE+T?=
 =?us-ascii?Q?t2gLXVlSANlS57iEb0r62f6YKGsQ2xrnZsmcEFmo7NEWTXyXfPOiiUsFe5/n?=
 =?us-ascii?Q?jnN9LPhxKg1svD1JQJyKtrPRGIKO1pvYXyO2u3VO8VYLAtqiZSUSHIyKtyAl?=
 =?us-ascii?Q?BjCx3o4Ew0v6M5joYZ0mWw91CX7R1pPjSOtdN4ZqXOVRUROiLC3bHyrS3Jxc?=
 =?us-ascii?Q?HbsRFcqI1nikdhqY67ivMGDBpieTE+D3r7ycQPce4ODlTyjJmf83WqBwPRU6?=
 =?us-ascii?Q?lxjjTitYAzkdGEdIKbDL2zUadGl0c2rz4BRIFs0+HolLBft1FOXRv5Fe6/Sx?=
 =?us-ascii?Q?3Bud43r2zyELsaAOlv6b4Uf2qE3p7kBvlpjH8o2iY90gkaR8oylbjgh1e96V?=
 =?us-ascii?Q?PnJv9+2Ybse+n/wu7fJwoh9fSUJdB0zbbrSnidOBndQ1iosJOymWyzSwVirF?=
 =?us-ascii?Q?FGG8jqsjGaCpN9JcENP3x2z69imOqT+mOLtKQh3cVJY+huXnsdndF0Q4o6DW?=
 =?us-ascii?Q?UV8e5Md+YmevLEAnCO2gnRQBHeAiMvzYi+MfJtm+CedaPIfA1pWjQetW3LVc?=
 =?us-ascii?Q?c4xTjTOxTSx59NrpoMk5zABgERtpivCB8k8E5TRiOawX/jNiGDpWjWzCzKzz?=
 =?us-ascii?Q?TRk+z7sasf8Il+NeLHIcDoVoaC/+VNFW4E5YxgXnJcG1BuD7ND+cZ8Wn6wtv?=
 =?us-ascii?Q?byYU3hyzTXdNQ4dCl2P11H6TEMBEd0XBfZUQoRXcws4YktlaQp0jelEfv70f?=
 =?us-ascii?Q?GxrY0p4MxevVt+Dqe2XyiAyVEVcSVPYAW8ZN3ClQ2qcyPBa1ek184I3NM8Mz?=
 =?us-ascii?Q?aDEkqPnP/0CpdVOWcwqlpaH4SIIm/8cqXHUCW6mkild7bXVmYffjc1S2TKij?=
 =?us-ascii?Q?4FMwxIFGrrejHese5Qr9IAx8hi6xQeoE3RIeBvVszt0VRDP/nqxgOHYVXaDd?=
 =?us-ascii?Q?XJMCfZkJNn++Ynzwn6RkadyRN66mFetxyh0QOKhf94xyFEZzjQb6r66izzC5?=
 =?us-ascii?Q?/k/CSB+xygg7gXm7k/b2E1zCSgDxlXOWAA52LlxBEdVyeKEuw9bIQPKnpnYH?=
 =?us-ascii?Q?dCfHWq2XaYQn9BNniq2rsweY4J1Z+/kmOvhKhX//DapC6vfiq3msb9yn/3sh?=
 =?us-ascii?Q?i/tCeFWsA1QfCSO5u+eHYsXsIt9PsQO5sBX0IqiIfWqVARs0oDNKONUmmd+H?=
 =?us-ascii?Q?O0hKZvzoQGpdEnhsoxgOaMDnKaiJgxyc4bvfBuRVkPzVU3YHgKjrYhXVJwYs?=
 =?us-ascii?Q?28KoKJAuxVv8i+3xbs/RyxD/uWj2qMiODacr47mwvAAc58dQNh3wNi0n6yZ1?=
 =?us-ascii?Q?ZQx9VF3Awgdgx6Nl38O5pak+7casdx/ng3Qnnn9C5NO7VTK5WQXqfXkLJUnn?=
 =?us-ascii?Q?zY0gZX+ESlDDDGKuDTbSWK/LQzymtQPdmnQ5s1po+MweiJ4s/ylt3RIT/aVb?=
 =?us-ascii?Q?p2SbvIUr/nJ8iWmAcPnOREJiLl6i0MC52YbVahC0hMI29Jajqm927RxkQAHN?=
 =?us-ascii?Q?1hx3frfRxgHPUWNYNzmX277J4enO8XSRh6HcYqOaOTKKsedhcmT4UowsRVyj?=
 =?us-ascii?Q?rQmQMIWvauTucLnanpyF5YosC+++oVgHlPner73F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf64e446-fd1f-4c24-8bea-08de07410172
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 14:34:52.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1jFjp4fByD1M6IafwmdjrY/8pQcTzF/Elq0hngOIwOKjbyzTotFCasAE9cv3AEs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682

On Thu, Oct 09, 2025 at 11:52:23AM +0530, Sairaj Kodilkar wrote:
> 
> 
> On 10/8/2025 5:09 AM, Jason Gunthorpe wrote:
> > On Tue, Oct 07, 2025 at 03:36:58PM -0500, Suthikulpanit, Suravee wrote:
> > > The gDTE[DomainID] field contains guest Domain ID (gDomID). The host IOMMU
> > > driver uses the gDomId and guest ID (gid) to index the Domain ID mapping
> > > table, and store the host Domain ID (hDomID) in the table entry. This data
> > > structure is required by hw to translation gDomID->hDomID to virtualize
> > > guest invalidation command. This will be part of the upcoming series to
> > > enable hw-vIOMMU.
> > Sure, this translation is part of viommu
> > 
> > > This ndom->id is the hDomID, which is currently allocated per-device to
> > > avoid TLB aliasing i.e. A guest w/ multiple pass-through devices w/ the same
> > > hDomID (same stage 2 table) and different stage-1 tables with same PASID.
> > > IOMMU would use the same TLB tag, which results in TLB aliasing issue.
> > > Therefore, we workaround the issue by allocating per-device hDomID for
> > > nested domain.
> > But this is what I mean here, the gDomId should be 1:1 with the hDomId
> > and here you are making it 1:N.
> Hi Jason,
> The guest will only see V2 page table when we are using hardware vIOMMU.

??

This patch is about adding the gDTE support to the driver and the GDTE
is the mechanism for userspace to inform the kernel about the V2 page
table in the guest.

If the idea at this point is to not support V2 page table then have
this function validate the gDTE to exclude it.

> Since IOMMU driver allocates per device domains when it is using V2
> page table, the mappings are still N:N and invalidations will work
> similar to V2 page table mode in host.

I don't see how this can work. Invalidations will be pushed by the
guest kernel directly to the HW invalidation queue using the
gDOMID. That must translate to a single hDOMID to invalidate the right
stuff.

If there is a hDOMID per device it cannot work unless the guest is
also making per-device IDs.

But we can't make this assumption in the viommu code.

So you must not do this, the gDOMID must be mapped to exactly one
hDOMID, and the viommu object should be managing this. When attaching
a gDTE the kernel should validate that the gDOMID maps to a hDOMID
that has the same V1 page table.

Jason

