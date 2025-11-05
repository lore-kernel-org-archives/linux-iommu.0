Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C9322C81
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349754; cv=fail; b=rsmrK9iwmV39vJuyDw9rY0Rdox2WME7jqwOQOgviOius0IBM4dQvwgtdSUDJcI6CTmvmX/CR4DYs3Jwng8Ybvl5EK3o2BoArkimTfY6GeLpbkXjhGrTULL7WoJXotQGT44EfPX41En4im3/FqFU5NT8kYElBPe+dBMJqBct0iFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349754; c=relaxed/simple;
	bh=gIUip+7pNVf6t4UlHCQhGlSOeRBFsGyW667gSJVbJpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L1mXHu/1yPEns3dMbHZImAwcp7j1uh19wrlxj/GqqcaXjYhMBUv9ZImqURKdmV6LfH4SMcSkJeekPlHFzhlg/j0E4J4nuCxPD9SiW3ocVeAJkSoePC4wpxbukVfloAP3b3JEK/imnSGUOCEaV+KhBpObjzLjEZZg1zaeD+G+rCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fNX3gK0Q; arc=fail smtp.client-ip=52.101.48.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fNX3gK0Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vzb7aFLN5HzVlOp7+tQlgAMyEip/DIESyUf0oUq6ztJtJ+u2yZluL70OfhLz32BJe8d0FOQRKKCwdxMhcH8Uk0+xlNYJ3RV9TSq81qTeQWJ2UQn9c6bdy0lRxaDrhu7QWiXLT5mg5hWpIqYFbhbND5yOdC5zV08ytsMQoP9XXvCPvDSbCc3YEpD4gJ7NyJz1SfJ0zaL7TL+nkJjk8X2/SXlB0cA/4B3BKkDkYC6TY0fMcDKhv8rjoHUExY8hRL5Mip4dYQg8zjO19oPBDeXPkMI/Kf9nfbqffJ8ZoMiL6gbcjAfKymzzxMQ5sMasmTTe5bbbCpR8zfecyFbitm579A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd3Eizx+I6eZd39DQGiRdqZl9ICAlqlhpYVLshWZSPo=;
 b=Cd3fUcNi2ReLNaQSTnsINjyhhJK4x+Eo6G4KxcUAPl+AxudKf7sPJz/kmxo7cyNS+4QahwSP0ESjBAG58VwD+J6fzY3XR6M1FTQUC3x/lwU2y7U9Z3oiwVAzPOEqDUaJNHZuzbBOnrAWWrOWUZjpna5LlAXNcoc3khCq6lnzHMFmi3Xe1Aa31zaLHwfN3I962AFa6Y727n7TErkyBksoSuRgGtflToelddzQmb4VqqR7qjL8l92V3Gr/q8UYIDYNM8hcflmjHyZmmJDGONnNW27z24Yqg1AtaPPdL7Gh933XcRSUEpCaT92y9BtG6/W/zpLkKUF6J6FQN9mMQ61ryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd3Eizx+I6eZd39DQGiRdqZl9ICAlqlhpYVLshWZSPo=;
 b=fNX3gK0QSxHPMSupnZqEqeXIyHMW4mG1Suc8736K/K3edFCBDG+XqnSo4VS8kiEGz9CU+bLsbXUHMyq43xHlMW5exgcezpw69u2gNqP2IuYsIkR37YdE26X8SzrzSiIxqOKx6DFbeg+Rrf8vmxUnSd3lcAIpFbP5O/YMUM0fxGu5MIamLZyrYGTW+hOVEE1Fmsv6QqR4Q3sIHfHkEBb/m4miz54BtHra05Q8iHDZDLV/lD+Nq46/cglgjhPo8ia2rzFeTTxxMXZf0yFTHsafzgyt/uBhLxW/uBAVfnMVlAu6jgMdHhpoBWdKOIfv0bF/1db49VGOqgZ6vvnEqi4esQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 13:35:46 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 13:35:46 +0000
Date: Wed, 5 Nov 2025 09:35:45 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v4 13/16] iommu/amd: Track host Domain ID mapping for
 each guest Domain ID
Message-ID: <20251105133545.GS1537560@nvidia.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-14-suravee.suthikulpanit@amd.com>
 <20251022200819.GE262900@nvidia.com>
 <ce25701e-87cd-4e9a-aa5d-c1962ffdd3b0@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce25701e-87cd-4e9a-aa5d-c1962ffdd3b0@amd.com>
X-ClientProxiedBy: MN0PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:208:52d::22) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 122384ad-ac6e-4b63-1b04-08de1c7039db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KiKJ9C1kN6Drc2aPcYx2wr86ZIHmhOaeIDZlRU94sB47aCemPGNIUe1qaWzQ?=
 =?us-ascii?Q?lgwPOtijDArvookRrbOg4xVZVebC2biAOUzmLyamASitJOfL/0yNOjSR7gql?=
 =?us-ascii?Q?diE+LutnvahNYXA2X27xZmnvhEO1s6yE7wwdCyZUvPS3e4hA5GbaUTaIUHha?=
 =?us-ascii?Q?6bJaDQCs15H0KfMG3rqBHRFxz3I+AISxRFf0NeQt0zEODbDsCeSDc3uzRE7x?=
 =?us-ascii?Q?JpjxToVzA4JJTWLpw6sgInR7qMzcmSDbKdJmp81IKhPkO3lQWuw7NACIRbiA?=
 =?us-ascii?Q?q+gmXIDSY7f2qBZCrV0bqqONBF0CYw86MuKv/4FfdgCEWHjuFgXqfhGBHj6G?=
 =?us-ascii?Q?ZEaxpQnehxoxTQAxH/92NOrY1dOnEW+zaPtScb3zSe0+/dBQWz3Kt1nK3th/?=
 =?us-ascii?Q?ZUzSJzAb9NZ3UI69mhdu8QD2IV2hGQjMAaRayJNWHmJI0CRfvDRE1uPj5oPE?=
 =?us-ascii?Q?zkyAK4+RxSzsSuETBLvQR9ymygs5v6NxGFJQFtQ+czrvoUMpauJeKm8tBCUN?=
 =?us-ascii?Q?Q5B64Fm9v8o/bM1pvGLTxRZ1pHQy93U4bUsMSTpvesZsIJvExti+xpBSyNrT?=
 =?us-ascii?Q?ZZIklEljeWFT7tv4ItZTflFmBQ5AXwSWPRh9YbRiauQd+uaAjR7KZ8qEAC4O?=
 =?us-ascii?Q?kG5Ak90nWDnENqmksjCLeZ8/VUWgTbFjbQS/4vougTuB//pj3NVxtURjGZne?=
 =?us-ascii?Q?Duw0wPo+w8EOrD9QQWkxs8gIcTBxO7WJdwlt5C7dtiTaFys4VXq8EN+ziJJi?=
 =?us-ascii?Q?ndi/qsKwgtYLxDSfsypVHi7DNWFVlgEMKz6o4H+CNPducu6jsEiySWzG74RO?=
 =?us-ascii?Q?PC1QcW5N6LFWpdNRQOz4KH995Y1s6MO8Fx3t88yIpkMCaX3wq2s3MesqgOPU?=
 =?us-ascii?Q?Ns3oUylBC8wzoMYC8YqOGUBgxpqw4BM2U9BetdYyEX49zJsqWb6sbMuIe3g5?=
 =?us-ascii?Q?gvYFGRGIzk+mtgI14f0mV0b18fodeNlJQ9PEIv0VHbqSVN7OJUI+Yc4XdkL/?=
 =?us-ascii?Q?fkjQ5Ml9w1+zR4umr4Vt2OUN6QsVuOdIWQ2ZgjtBvmofhkI+R5UXRns0z6l8?=
 =?us-ascii?Q?zhKyTDo6LoKL8BcdqlJuq8XZgC14zc9GC2EtS5msHfoqIaVgbiswEFB9nlx2?=
 =?us-ascii?Q?fJhqDtQ/oF24MP8qn0V0ukUugOJLfvP27J6zjPne1abriTM46+pIYDapM/aZ?=
 =?us-ascii?Q?hR9RluD9uiWREFYIuogjr0t6D5w3z/wDR31eSNrI2uzQ3f3TTMDWa7Redv3Q?=
 =?us-ascii?Q?tpKZpspgdf+3tz3dUZQYK3gl3y9lMJxge5YhTa9Dqu5m/DviNutDacnh8oT2?=
 =?us-ascii?Q?RxwPFIQVwk+NZmDMBoECEY5piEecZEZTD6Zb8yDdbzSU2ZV8TkQo0TT1CA4b?=
 =?us-ascii?Q?owt1OLy5mXmBwaCmk/KENjZ49vVc/MmdyvHAK1KWKZU4O77HBoMkNMZiuKfm?=
 =?us-ascii?Q?IhM1267U0uU9D4GfYWnx8yNBe925GHmU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xmjm9YX56nXQxCooKUgjjwPQRkXCvL02W66OyQhckEzfO/Yz71JgAVhkXG1r?=
 =?us-ascii?Q?hdch6Dd5+F9gJ2zrK+DZvGu+8QOG1HNV6AcJq2qgUuNLq3T2Hpn++/ZbY4dr?=
 =?us-ascii?Q?Gj6lqT62X++uhCtXNfAtcbucNjz6g9EnIVVzcD9AEFW8qDfBFudc6t6n7kaR?=
 =?us-ascii?Q?gEo1A3Je2UsgzwUi+4IdHUAMtTuDzBtdvlrO7/+MQZHfG/oijsulWDsEJDFh?=
 =?us-ascii?Q?BqkectKoxyoN8OBkTtMwBDnFnPNNY/D5E+BMyhTdyiyFaoEacMuwavZ6GNSd?=
 =?us-ascii?Q?ybmt/yESLojTSsi5p7c3MzFU9MadpspHrDnU20jpWJ5/RtR5KjLCnKB/NYn5?=
 =?us-ascii?Q?AUsJeb/hVzBxaJlzxvr8mcx0eJizajVTV6OnZqs6kVDKh+7t71+nWqBmKtan?=
 =?us-ascii?Q?69hym/nQFYGsg9ukFxSEDn8bDa0wUREvI+YUesuPP9swuk7+CGi51A/FNx48?=
 =?us-ascii?Q?P/L0c3W0C5ilVfaBCYk9254lEE3AnFWjao3Tgxj2MzEytLhmouMqht0myZh/?=
 =?us-ascii?Q?VvLTgASgWPbFoRdSIFQ2g87KENke8os7zG+zeR+3U4fp1I8OQggA7pF1jzGn?=
 =?us-ascii?Q?buttHVhIDe9J/48SwTCPaPk4qrgEbvLpQB2BFmpn1Kr4pchTzbdQDc6ZW4OD?=
 =?us-ascii?Q?LMgJLSoM0bUrMrAhNCR/1pKIvEC7wMjnTwHny6qEzt0M1VEIFEFeeRLcsThb?=
 =?us-ascii?Q?wardVIjN05gp+MB5enQRPWpDYQFMHE6eIDyCVufLB2SLieFMuqk7xs2CdSta?=
 =?us-ascii?Q?sncdmpPqJNRw9gBN2aJB6SiDew+rJK79+zvJtTMbYhdgtAijJJ6EComE1h9y?=
 =?us-ascii?Q?tYLNy7KIgpbGULrCzZulLByVX5wQFwcV1UJxjp0/FEVK6kgJMFohUInKInfE?=
 =?us-ascii?Q?3tcXmr1/bjFqFpX+v+mmt+URaY7C6RNqctlDmuuYY1klpXMa4n1Kj+teezpc?=
 =?us-ascii?Q?8tSGQ8GOHlKpa4pFsTYcErqVSfJDVcKpNEP03X8MEbpU18OD8DxxZn9VtGXH?=
 =?us-ascii?Q?bj9oyeq/6diNdrQqVLMjcFEsvLzIsZymINHntXMpwgSLhjV2VS6MPFPgVmke?=
 =?us-ascii?Q?dEPXmjvd8Eopg5HeEKtwAmCukt2WpP6m6NLwYIg5K4ZXaCBGOJbHHxlcVD4P?=
 =?us-ascii?Q?oJ7U3VbvmfLvfP5AR36C7PJ99iTfTlMsnyijZaRNUez6e5L8tgagIgZtikUn?=
 =?us-ascii?Q?bcF85P/JFh3W3gCKjy/88eM8QwwREPpV5WJndgpx7PAwcVuyflRuCNZe4701?=
 =?us-ascii?Q?w/OT8JrW8bLIbWYmXnlQxPHUIvQxC9UDwX5NX7O24ZicXhoeBrKsgLZN/qm4?=
 =?us-ascii?Q?ueioHxVaWwRYk3//bzf3x3516kzM0ICnolLHQ6CGGpX/GD7s3tvJb6z85siW?=
 =?us-ascii?Q?E9FMfE2/c5iL0zYwTyC2md5e3wzX9m9chEnMifiROsLOg+Nnfxjg+WsJod7U?=
 =?us-ascii?Q?pUIMA8xaqhlSQLHNExK8TLJ91fVz0+wwU8UNuGQJpT3uCF198bu3fQjPQtMO?=
 =?us-ascii?Q?rEHMwSBPPxPl43MZKnQgtoEzvWS6oxmyJvVpiLPGdugc96pu38QX7AHGJ1mm?=
 =?us-ascii?Q?hFLUSbPPfMUUyWXqf7w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122384ad-ac6e-4b63-1b04-08de1c7039db
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 13:35:46.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3U3/yV5o52LfKzaiyqBYD2KI7uwsXq2QB1cuXgETyCAdE5a1EKJwzu4zjHbKzanR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863

On Wed, Nov 05, 2025 at 05:50:44PM +0700, Suthikulpanit, Suravee wrote:
> Jason
> 
> On 10/23/2025 3:08 AM, Jason Gunthorpe wrote:
> > On Tue, Oct 21, 2025 at 01:43:21AM +0000, Suravee Suthikulpanit wrote:
> > > Each nested domain is assigned guest domain ID (gDomID), which guest OS
> > > programs into guest Device Table Entry (gDTE). For each gDomID, the driver
> > > assigns a corresponding host domain ID (hDomID), which will be programmed
> > > into the host Device Table Entry (hDTE).
> > > 
> > > The gDTE to hDTE 1:1 mapping is stored in the nest parent domain using
> > > an xarray (struct protection_domain.gdomid_array). When invalidate the
> > > nest parent domain, the INVALIDATE_IOMMU_PAGES must be issued for each
> > > hDomID in the gdomid_array.
> > 
> > I think this should be stored in the viommu..
> > 
> > It is a small unrealistic detail but very pedantically the API allows
> > creating two VIOMMU's from the same NEST PARENT domain and if someone
> > did this then each of the VIOMMU should have its own private gDomID
> > number space and own separated xarray.
> 
> Actually, to support nested translation w/ HW-based vIOMMU support in the
> guest w/ two VFIO devices on two different physical IOMMUs, it would require
> setting up two iommufd_viommu structures (one for each IOMMU) and share the
> same parent domain (single GPA-SPA mapping). Also, AMD HW-vIOMMU use a
> single domain ID (gDomID-to-hDomID) mapping table per guest-ID. Since the
> table is indexed using gDomID, it requires single gDomID space per guest.

Yes, this is why the guest ID needs to come from the viommu object,
not the parent domain.

> In this case, it makes more sense to store the gDomID-to-hDomID mapping in
> the parent domain since:
> 
>    1. There is one gDomID-space per guest and there is one parent domain per
> guest.

No. There is one gDomID-space *per viommu*. The driver has no concept
of what a guest is, that isn't part of our API.

For AMD hardware it is the viommu object that must hold the gDomID,
and all the other related HW datastructures for a "guest".

One viommu object per what the AMD spec calls a "guest".

>    2. When host issues invalidation for a parent domain, IOMMU driver needs
> to issue an invalidate command for each hDomId used for the same parent
> domain (on each IOMMU). We can't do this if we store xarray in the viommu.
> Otherwise, we would need to store a list of vIOMMUs per parent domain.

Correct, however this is just showing that the driver invalidation
logic is incorrect. See how Nicolin is working to fix this same
problem in the ARM driver. The driver cannot assume a domain has only
a single domain id in a viommu world.

For now you should still store the xarray in the viommu and then
prevent the parent domain from being used with more than one viommu
somehow so it doesn't get into trouble with the limited invalidation
logic.

Someday maybe we can fix the invalidation logic and allow domain
sharing. But for now the code should be structured along its own
limitations..

> > Allowing two VIOMMUs to share the same hDomID could be problematic
> > because we don't know the PASID layout is consistent.
> 
> Not sure why PASID layout matters here?

I'm saying you cannot share hDomID across two VIOMMU objects, it is
not allowed.

Jason
