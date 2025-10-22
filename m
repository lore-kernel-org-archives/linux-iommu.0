Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010017.outbound.protection.outlook.com [40.93.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5209218E20
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163707; cv=fail; b=c5qOEB0y/I2G5NkxgvkOSoA63eom1BFcdhiGS8RRDmZ6FERLAox+iPIClWfel1Jo7avmawEdHiElvuKVflHw9OnCSkZJjtgW6Cs2YfD57hKgM3HeHiy4baeMtSeyoi1Vb7LvfcKnhJD/BtExmLyh5O0Qz0W9tlEBjK2koYMX7BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163707; c=relaxed/simple;
	bh=SkPbC0bQ63vDEJ5OGeuJFJab0kunAGOLjLq/ijl6Acs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kdP8o7uFg9JpGVh1C7FlAmOW17NXZHWJ7q79sznD8GhATTNNaCcUEhye3kAcJiSAY+0FFi6mqiHfZ4cl47VmVngdWXFbN4yBA9XIxj2GW4rLQHxtlrIpc3fycz7K2vq2q+od55/VIUHh2Un2G2OIF1NgIte881MgXFwlsGsh9G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q93ODK5u; arc=fail smtp.client-ip=40.93.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q93ODK5u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tl5C0H2qQOomjnoZuzienuzcVx3sfOo+40Xk4Qu/n4Qz+ejRXqko53QYIMrbgxAfAc2OOUTA2m7fRUzEf8mXBRuJ8yuu272n9X4xLd80RkkAAKPUmRxsIi2t9D9dvjtM1pwsh92ug208v52gGWSMU8mL1GxKP/5cw1KBv3YLkkdi5igJRFHWq6ikn4UcaH/XjXUkEguTgcFTFmmnBai05EWmz4isV+KVPkh6QpauAzzvEYBTJIRbu3dkTlAnmpt2P3BDKS6HjDxB7JQG4kccKvGclcdH8lRYSK/Oa8ADfxFvh0CwNQFw25Debovu1jENShsczw9gPX+lAvz16BE/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/eC1fzJ0bhsXK3HSF+MVGphot1HOunMfPjIy81n8bQ=;
 b=nS85zBCBiEvmWl3bSEeWepyVGWKnxcVj7Y509s+W25nLz+dVnLbRdt6RHv7xwZHqHZoV/EIiJe/oKXuDb+ZiOkQ0SUu1cATIPCkvnCEm2qIE4eGWZUVVAMIjN/Bbu1L6u6lzDBUvPwBD+yBSVPaN0akSc7EGsjlM2LbPJEA8Dt24DxVCEkNTGCp+ueahxTg7I4BknnruVPwTIctjaYJnJiKbZH6NpEbMaLVyq1oBtkp9bVNSgMtSMLkaLfT4Wn5O4VZI5Aac7vTHI7EuLP8+4ruyfJ2dIpQT95jE1GAmrG0RO/aDlKwHMwIYnETVD1be0lIc2Rda9jqhr6hCxWYMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/eC1fzJ0bhsXK3HSF+MVGphot1HOunMfPjIy81n8bQ=;
 b=q93ODK5ueOukv8RjKIg6SEy+zy67JT/f7vLOKQlEAusFLU5ZqcUWrCAA3WUbvZTqEKVz7Y2wNkrVpLSZ0MwpFMIp8A2J7vln546Yub48En6gkPKi4AsYtKPqP8vtrpmAkTjqmQtLwdTKGf+2XPqsPVIpTOqvjK4EDKUl8D2u9TtSRJBDWvEBbn3FXnI7luO9rhErUDN4Ld3h63pqddv/TY3zWVE4dOKC17nG0NCqXHkJ6cmedi/ATdX28WQ0eErV6L9I7Meb2mKch8XBcts8A+mx939yg3Y/WrQXMxrXhOIBPe6VmX0k7wzln0FKr0LYSzk5MR0AqTS9s0mKy7Efhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 20:08:22 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 20:08:22 +0000
Date: Wed, 22 Oct 2025 17:08:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v4 13/16] iommu/amd: Track host Domain ID mapping for
 each guest Domain ID
Message-ID: <20251022200819.GE262900@nvidia.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-14-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021014324.5837-14-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4PR01CA0302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::7) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e21579-88f4-4fbb-c010-08de11a6c015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MOtwYWemN/7NbUyzheOwCYUkcO9Qv5KcNq9hONYt1FU0J35O1Eu8BRkasLGd?=
 =?us-ascii?Q?AQqC5HVgxH4s9N0cf9bgEJ5Oo9Dv58xE3BB4SeQAta+Ayu4JE+ls8XDQnVcr?=
 =?us-ascii?Q?CvsfbSSdrKz7M1pqh9g14QrwXO2p7A4dHpnamKVH0hTRj1KuWpCrrWesvh31?=
 =?us-ascii?Q?0mNtGEYZB+4Ul77RguyRritu7eSIFdUceGIu3SrjLJeOfcSxArKJXwWQ0kms?=
 =?us-ascii?Q?03xYGh/f+ZYeFPIJzlMDbBwvmkLPskYWYB4f8jiaTHZQkKnS2qaW2++r60jJ?=
 =?us-ascii?Q?QVmNFpdebjRB7oIsplYt/KVDhrFRh44Mhe0Q1zSnordx2gc50mvDlw4fb4Ta?=
 =?us-ascii?Q?SxTJP0WMGDHIhtNy6g44DBSK6K+3WrUsssC77oMy3MhaNypr25RMbZSMFOgb?=
 =?us-ascii?Q?/+oYVb97sT+nftdpqEE8KqjW+gJlFiUsqW5ez914BYB5yGqoCPjs7h7vsUcA?=
 =?us-ascii?Q?8kfxqaiK4xW1cyC3kc4YxxAhIx2xpA8eZy4/hIJB1sKTXYeMGhjPISvZx/8R?=
 =?us-ascii?Q?T9ru+cqZa4Sr4C28pj1JkSI4H5P2rUw5ThgWf7jtstq4B6TBdFY0z/qnyH27?=
 =?us-ascii?Q?XZKt1Xh5+oiHM431hAZ4vxTG+uDsCY3TRMmjsarDwf2tc4KVkbma/SFpw/wc?=
 =?us-ascii?Q?UVeF8QZGs+YgYW9mUvPj1KCYwWOQjRypibqKKVxVKhoPbmr4bF+a3T6bzZKu?=
 =?us-ascii?Q?VTp3H+hr191jE0rmXON+8WGb+YkHB4T5R3vGdYVvLAv6tsobfIO0dNAMxwUj?=
 =?us-ascii?Q?4Mb3SFIvOKEtfeLNd1H9nMjvcGKYe3/bm/bMBf0bv74ulLHXbZ1nSqwsh+Tx?=
 =?us-ascii?Q?LqXDLZ7vvtBuSE3uOml1Ital+BRWt+Z1uqX71sHScNAARrEa/tKn0375m72H?=
 =?us-ascii?Q?sTuJ4qww5aV2VuzL5X7XeFo9SMYjcAFrrRGfvNvUZjRv6ELpvPCJwPKnWv7r?=
 =?us-ascii?Q?EGsmuXduw0Plt+jPW6Kz6dxAR+EQk0DEWtGkflIBC6f05JpdVHjFIGamZ0rW?=
 =?us-ascii?Q?5RXCjJhJP2Yb4o69xrSl0mV6TDVwj5b0YdHDrVrqAJnceO9e4e5rmSovsIwO?=
 =?us-ascii?Q?C9HapXCO7tzUi1wzlApxHtL5x4Nfe7WhZz+j+mujsB5zLkZH2zdQIUX316n3?=
 =?us-ascii?Q?5JKpO9ROsM/lDp2FQd9GrBLRRzQj6R09KAPMU6TuTiZkkkjw7gZRwGDrmoeL?=
 =?us-ascii?Q?qF98K8+Ev9SF1rQGsY/i5OIDcYNyt/797SIuUR7C17Bnw/PHNplqujT33LcE?=
 =?us-ascii?Q?SyYwlcv37+6+H7L86LuCrWD4yvddWSUtldx6K/85MkTII0BcqU17V3CNeCv2?=
 =?us-ascii?Q?xEQ7XTpxslr6ifSQm3+oT7w9iXtgq3Vi7PdfBvajD4hca8kV98QO9SHWnoxs?=
 =?us-ascii?Q?3L6GV+JbeNEVS/8i944M+t2kJ3wW/J0uldP0hwxKjeesFOUbW2mMMDpV8JIo?=
 =?us-ascii?Q?KLUv2fCsU+YtdjYPyOTVVtCPo+GmgoN+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ix9Xfao0tDF5hJlh7WAr+XHKkFpiYWlU7Q6Y0NGoMaBJ922r8w+2/FoRTtbS?=
 =?us-ascii?Q?ugxu+xQjHrJAdgJeMrjNYw0A1reCiWzbLdeTK1wFufnkU3PMPaq5HoC5dB/3?=
 =?us-ascii?Q?Et3JVj81Ee3BuzlYICS/HXVACkPOGmGt3wsKNpEc23fG9PNRBBzGzG9Yuonc?=
 =?us-ascii?Q?XT1p9aILmioihIld3Ouhi1UPxA/N0va8q/LcJV1LixejAxj3wkDi/+JTizdZ?=
 =?us-ascii?Q?ppuTQ6CY6xpBdxFHdff2kierTBBsZioSNopuj11/UGMUbBD6V9rE1b+HcjlT?=
 =?us-ascii?Q?fabMqfsWK4WwgL46pgHF53ZCF5Hu7D3Q9r9NMxaOiJlXqysBIa+8YLbnly6Q?=
 =?us-ascii?Q?HuBZy6ZXXrbLTMT5SrDdNTLvG46Lc5hWcxPwdlPfYjY2csowD4nsWGR+YFvm?=
 =?us-ascii?Q?Mq32YYOsXqMPG9xrhdDOcpuN+ThajjtR166XUZQdv2y3+qKgsfhOf1nTXIaO?=
 =?us-ascii?Q?ZB2Qq5Hu3Iu19GbPcn1OUcN/xUZfQap4EzWZN+29eXsC1b6q8MzHp4TIkR2K?=
 =?us-ascii?Q?TpJcgaAAjMc0Ih5D3426wVfHN+9ka4TH04zZVkpNXzYk5GBWNJMYsNH/Utvq?=
 =?us-ascii?Q?ZKP1URjGdgRhIIWFWmMnGuFxXOKBlGuPeh6RbPRqq9ePYgNrvNI/2XEPK0/B?=
 =?us-ascii?Q?JGPNBkp0MydhpeGuyF06Zrc1U2+dVj8rI7oUH0c/zTuWb3AFbqSQ2aka9nD2?=
 =?us-ascii?Q?It7a7u3GppN0Wr6Yrv6wa1A/qxzP9d0Ime4O8aZWx8mqXixHYtkvZ0vAOzVH?=
 =?us-ascii?Q?EeMuZ9qSNJ0PjP9onRCnpY0JCjbLEnG9cJWxto4J9rBDI2JwaA8cw4AwbYf7?=
 =?us-ascii?Q?qo8qFjrScursjxOoiYJd4RgCP3upJIpRw7GKAji7kCtN2yREMKsuHjAY55Hb?=
 =?us-ascii?Q?SZjGflbMAi0hHRuew0oRdMe1xc8Sc806bhmyek/BRdR/kUBsqeSr/rSk2MZi?=
 =?us-ascii?Q?2aPuV0i3Sg72mKDLWzcgNEF0IqF1XBdlDLCWzi9K7Dr1CGzNkn2HWpyMoruf?=
 =?us-ascii?Q?TWsDnZP2O+nqO/XQ14VDs5hxdYjcxdpDx0Weo/CXAHsdGOQsLNCMUYGuXKxr?=
 =?us-ascii?Q?IgO/p4pb9oO6mDmfkZsR5sg9u1G52ZXg1yEFUVyRXF4u/VAubWbOSNUdjAau?=
 =?us-ascii?Q?oz+XtrANwJqQchLgPN6XpabZ2Ln9yiVSscrQFkSxWyvLU7eC9Dcgxd2NH/KU?=
 =?us-ascii?Q?f+0Vblg0nCSiFbrYLv2+YHQB/wQUUUB449Iy7uF9b+quXwlPBSPBoiJgHoXK?=
 =?us-ascii?Q?fciMRVD3BOzLO3gatBTZ4Y1GouiLJSRiNTnsyLr4KsGJya+eqxcVVmkWvb01?=
 =?us-ascii?Q?JGFg7sO1x/b4kwizlY6WqN/0yQIV3YzD4iT5vN4+kE3o83zrI3rjez69WQCC?=
 =?us-ascii?Q?gAoISkJXsaeiA89LWqKrTS4U4ELdaQ7JsBUkqh87DpqPudlp/LstoLTdBjA7?=
 =?us-ascii?Q?wxbMoSVwPp9jwncLk8y6fsmeQ7LNaxEnqo8IDLzA/SfdQhbwwk4VaNFjrlUv?=
 =?us-ascii?Q?nWG7iJOnur80jFY0P6lTU9yev39YUetLjkkzmm9IaTpduS9e7fhJWZN6n6Mo?=
 =?us-ascii?Q?rMFs1QrDggxIsKmkWYw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e21579-88f4-4fbb-c010-08de11a6c015
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 20:08:22.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWcexkYWMIbS1yTOnZcYSddkV0sYHApH5aEq9Sx+ghEQCcNDQ353TVl0fXzK8m+G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327

On Tue, Oct 21, 2025 at 01:43:21AM +0000, Suravee Suthikulpanit wrote:
> Each nested domain is assigned guest domain ID (gDomID), which guest OS
> programs into guest Device Table Entry (gDTE). For each gDomID, the driver
> assigns a corresponding host domain ID (hDomID), which will be programmed
> into the host Device Table Entry (hDTE).
> 
> The gDTE to hDTE 1:1 mapping is stored in the nest parent domain using
> an xarray (struct protection_domain.gdomid_array). When invalidate the
> nest parent domain, the INVALIDATE_IOMMU_PAGES must be issued for each
> hDomID in the gdomid_array.

I think this should be stored in the viommu..

It is a small unrealistic detail but very pedantically the API allows
creating two VIOMMU's from the same NEST PARENT domain and if someone
did this then each of the VIOMMU should have its own private gDomID
number space and own separated xarray.

Allowing two VIOMMUs to share the same hDomID could be problematic
because we don't know the PASID layout is consistent.

> +static int iommu_flush_hdom_ids(struct amd_iommu *iommu,
> +				u64 address, size_t size,
> +				struct protection_domain *parent)
> +{
> +	int ret = 0;
> +	unsigned long i;
> +	struct iommu_cmd cmd;
> +	struct nested_domain *ndom;
> +
> +	xa_for_each(&parent->gdomid_array, i, ndom) {

This doesn't seem right.. There could be many nested_domains sharing
the same gDomID..

I expect this xarray to have a struct like

struct gdomid {
   refcount_t users;
   u32 hdomid;
};

And each nested_domain will go into the viommu and either allocate a
new gdomid or ++users for the existing one. Inverse when destroying a
nested_domain.

> @@ -92,6 +92,49 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>  	ndom->domain.type = IOMMU_DOMAIN_NESTED;
>  	ndom->viommu = aviommu;
>  
> +	/*
> +	 * Normally, when a guest has multiple pass-through devices,
> +	 * the IOMMU driver setup DTEs with the same stage-2 table and
> +	 * use the same host domain ID (hDomId). In case of nested translation,
> +	 * if the guest setup different stage-1 tables with same PASID,
> +	 * IOMMU would use the same TLB tag. This will results in TLB
> +	 * aliasing issue.
> +	 *
> +	 * The guest is assigning gDomIDs based on its own algorithm for managing
> +	 * cache tags of (DomID, PASID). Within a single viommu, the nest parent domain
> +	 * (w/ S2 table) is used by all DTEs. But we need to consistently map the gDomID
> +	 * to a single hDomID. This is done using an xarray in the nest parent domain to
> +	 * keep track of the gDomID mapping. When the S2 is changed, the INVALIDATE_IOMMU_PAGES
> +	 * command must be issued for each hDomID in the xarray.
> +	 *
> +	 * Since there is no invalidation support and no viommu yet, just always use a
> +	 * unique hDomID for now.

It is not "for now" anymore, this is the correct algorithm..

Jason
