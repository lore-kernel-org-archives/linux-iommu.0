Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1D71311AC
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039863; cv=fail; b=a+img7aqeyePyNseG3e+KEdr0Qqo2yNo55fI9KcQWtM+mwRwJc3VRl7kT6/QLBTMBWQJky1ua1GZkUDbk/T6dZEmdxSsfntCopKsutX1qaAoNf5CuoNTze+Xflw19M6RHeux4JC+D/XmoCF8264d61PMA7DXg3dPc6ZrpmeEjEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039863; c=relaxed/simple;
	bh=NjMdOCdgk/5u1Kp0jk3H7N5HFTy+pw2GHH4xZS4xSZU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EklXFxzFHxku+E9HZ3IcU6q9UTDZTHyQlIQs1WST99yejN9uuFZhXER0ynJwJepkXods7eDvqC8EcJjMzFc5rswk6IZs6vejLD/MVlG0YzQHsWiWAVA7TBRSENf/pz2+hh/JkdsF1mB6MEPDiVA5ySBhLBIbjwT0V3K7KwUFan4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tHVn2L3w; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tHVn2L3w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuDovCLPkCabLJS+gK1eQGpS2jLASHR8Akp6Qfvf3UIT7/ZRjtzCN4sJB9H0CLM5VHk+9jVgid9qdt+ONlt+GfunIENKVKUNmwMcsRzuAeTMQzn/4XjFw3HwPwS2ThFLTdn2LDiRKhPgOZE1Z4KxHK6RtCtcMq9/3fW8X8Py7eQCcwNc2PGxoD5f337HAgxJcavkPqbhy/twEZDX1Ayr81+Gk4jhbNRXoXTic/6tJbUzzx69zmK9gDXou+Ft8+GfyFcaohhTwOnkKXdeKrt+9wo++6J2BpxtNnKE7B+t6TexL/5xZlCJECXFb/gcwbRrdj0PqHz8k3hzAkzXhHQ4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3qOukB7JAZwgE0YPqossyWFletbA4sidkaNlZ/NhGs=;
 b=bHZrvcUVpHBSd/y5gQkEsAWgS7NlYgLx6vKNsDtRphgI7pb4T9KKML+0tnDStCB1jTv0ytGPVC3ODrzm9lBbgi0w+EPQGx/Wr28Bj+AZMEalr+2su7t8qUFX5U8WQlhqTZwKcWqPIqVmAC5EfcuAzm3xuAIrvygfQL+UeFMhNc37qdTd/dfFT4TSMzeOQjevBlhy5bFI9sqGMcPSjDv0SfNVWnmvCzm7dixygQOnueDD7zIWCIcrK0QNS11RwjNUVt8F/YHoMthRHy7i/vng2vuCvnka+nKp+tE5u0HNTCNCdZoQCbkTS+zNHWWQ92sPHFPWIK9tyTSwHIch5F/TEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3qOukB7JAZwgE0YPqossyWFletbA4sidkaNlZ/NhGs=;
 b=tHVn2L3wOHzPXXaDdKFRrOZt0RIOsYw+sgoP7W0nM/XPHM9i+t6nPE+5KcQ5SUJtgS7mHBO7b7zJQRAzMRqXyyMt5v+lYfPPIFCLTAgdShz8HcdRyFr5506/9GS2ieO4PZO+URs60kb9/uQs3zFk2a4Hkop6jLumh7EGXX3Qc0R5fIhbBYjoJ7ftGZSXVG0gBaGKLYhRnjxLrP8UeXw1CX/VOJEmC+70aglYJe2O6Pn6/pLMB/ytzWPyaZUg0LwfS4I2LemrqlkevanElba/uForS9zZMMtAQXzIRQB8D4ZKJtTeL/xZizcaDWjZLXQRwIloWplMXdA9X8skziMLvA==
Received: from PH8PR07CA0036.namprd07.prod.outlook.com (2603:10b6:510:2cf::9)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 07:30:57 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:2cf:cafe::e3) by PH8PR07CA0036.outlook.office365.com
 (2603:10b6:510:2cf::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 07:30:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 07:30:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 00:30:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 11 Sep 2024 00:30:38 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 00:30:34 -0700
Date: Wed, 11 Sep 2024 00:30:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] Documentation: userspace-api: iommufd: Update
 HWPT_PAGING and HWPT_NESTED
Message-ID: <ZuFHGHd2S+r6XzyN@nvidia.com>
References: <20240910204111.7969-1-nicolinc@nvidia.com>
 <BN9PR11MB5276142EF52299176BA3179F8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276142EF52299176BA3179F8C9B2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2503ef-2ebe-4f3e-289d-08dcd233ad2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HG/zKCtkAqzrBICLkGlj05U7GseL9F3Qt3k9DfdqAKtGqvEA1od/PrVOv6ln?=
 =?us-ascii?Q?yWqS4mzGjMxHL+Pk1pgCvHqarM11kB1dBy83F2dBKcOElLUbLiGz19xNICV8?=
 =?us-ascii?Q?FVwLGYnxT2hjxaHISsDG9jT/sm50JBLKSDWq0OlRYqTLgVvakNrDwmjHZZ5b?=
 =?us-ascii?Q?4V3yL7GeMD6IzEFOqJsXLR8jBccAgJJfMG7HVWr6tKFCdoDVUHEQsDHCmUUY?=
 =?us-ascii?Q?VnRywt2oakDXdFonfWnGayh9q5CQ/LOp2CXCSt8CyxebNamFwwpdSK1F7DCF?=
 =?us-ascii?Q?+7q8+8BpxtRnG1N23PbjUKAHDRPSCbMF4Sd1Y/wKay2iS5BRzxsXbrQIBfEl?=
 =?us-ascii?Q?jm3xqfrYbM7uxY1qu8QGPNEWq6S/4tCokKdbcpv+GyO4y9TnMoL6mMdcpYwz?=
 =?us-ascii?Q?PbKJVly/zvpNU0DSypVYiMLjbQ7gA513naGdzaFJ0KUe6kRK1pjG1hwQppXC?=
 =?us-ascii?Q?Euz7C0jLHsqcfn3cotU2I2aFmWuh6fGApj+hmqGcEdxCnuunoY9VvWNxTsB4?=
 =?us-ascii?Q?6W9iphtu73y6z9UjDr0dHNmnqwAF/BiIgQTDPisF7mRSMeHQOXUtmmEd12Fh?=
 =?us-ascii?Q?lOLCWwlIyPN4gm2rgtx6xcITEVZ24kdH+PXjeeSMKHkZLZhkHgXnbK0lrIPh?=
 =?us-ascii?Q?MmuF13/ooWKyELNi2xjOR9+1tDm3GELWiI8VbWlnnRRpxJtscY7/Q0u5B3BK?=
 =?us-ascii?Q?AF1bTAHXEsryWHl/RgLY2sir1kHNd7msS/spqiueRekU2X9sLTSZB7aj7y+G?=
 =?us-ascii?Q?iVOeIz0C7qHGRbmkCwNZLlw/2EOxDujzZ60euhD/qNsXCq7H3jEE23YyBEaD?=
 =?us-ascii?Q?X2qNXimyK53IOOVTCltV3J27m4GkBsDVf1/Nld8V1EE+gfQaLgOYyrLGaIbW?=
 =?us-ascii?Q?IgU1CjqC3kU27OdMkBdJ6xnnWl5jPyjCqULos0dGUZXovoaQwanLVMm5Tlxe?=
 =?us-ascii?Q?9zWwOhu+R+CrIUow3u+FHptIvfPxBMToVM/lgIAqsRJWQyirHHt53VYzmERS?=
 =?us-ascii?Q?5DqaL4kbmSXtBWIc8LC+ExOIs7VECn0FhPbqYxifuiK3oX3pamX9Z0FoAwRa?=
 =?us-ascii?Q?yeAlFdB3OlO5o9fVBzzIvzXj+1q3rTb6NleiEcgOcpDHU1LPTgFtH7LyeSaH?=
 =?us-ascii?Q?t8N6Jui57FQvAxsc2lv2OF1ti2TiFxfvA/xwGJUiUOvDJQBaeFLSBFSar2kA?=
 =?us-ascii?Q?Ii2g3KKclHx0N6clB3z/YirOXJTQ+HalccGsBilDNvSnenvKd7gLuyVhWdRG?=
 =?us-ascii?Q?DDEv8lST1akB60a53M/ahDiDfEBrqOakc+iQJ7aDRQImN3vYLgP7cCawlSeN?=
 =?us-ascii?Q?uUgAovXWSn1EC3aAn6Jf8NZonvYNXFwgVKQ8EAqN2KYCoP1ADypuUlG0raRq?=
 =?us-ascii?Q?aM0gOI7espm/Kt9vCWAB7Q+HSyahFMPGW6lTYlWLd4dlaKjNdpJd7vBr6Lad?=
 =?us-ascii?Q?AbvGMB35gse/JNooJvvf2j6JhkHRIn02?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:30:56.9438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2503ef-2ebe-4f3e-289d-08dcd233ad2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369

On Wed, Sep 11, 2024 at 07:09:15AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, September 11, 2024 4:41 AM
> >
> > +  feature flag. This can be either an UNMANAGED stage-1 domain for a
> > device
> > +  running in the user space, or a nesting parent stage-2 domain for
> > mappings
> > +  from guest-level physical addresses to host-level physical addresses.
> 
> the former part is inaccurate. It could be an UNMANAGED stage-2 domain.
> 
> > +
> > +- IOMMUFD_OBJ_HWPT_NESTED, representing an actual hardware I/O
> > page table
> > +  (i.e. a single struct iommu_domain) managed by user space (e.g. guest OS).
> > +  "NESTED" indicates that this type of HWPT can be linked to an
> > HWPT_PAGING.
> 
> s/can be/should be/

Was thinking of the 2nd choice: HWPT_NESTED->vIOMMU (HWPT_PAGING)
Yet, I think "should" could fit that narrative too. Will change.

> >
> > -3. IOMMUFD_OBJ_HW_PAGETABLE is created when an external driver calls
> > the IOMMUFD
> > +3. IOMMUFD_OBJ_HWPT_PAGING can be created in two ways:
> > +
> > +   IOMMUFD_OBJ_HWPT_PAGING is created when an external driver calls
> > the IOMMUFD
> >     kAPI to attach a bound device to an IOAS. Similarly the external driver uAPI
> >     allows userspace to initiate the attaching operation. If a compatible
> >     pagetable already exists then it is reused for the attachment. Otherwise a
> >     new pagetable object and iommu_domain is created. Successful
> > completion of
> >     this operation sets up the linkages among IOAS, device and
> > iommu_domain. Once
> > -   this completes the device could do DMA.
> > -
> > -   Every iommu_domain inside the IOAS is also represented to userspace as
> > a
> > -   HW_PAGETABLE object.
> > +   this completes the device could do DMA. Note that every iommu_domain
> > inside
> > +   the IOAS is also represented to userspace as an
> > IOMMUFD_OBJ_HWPT_PAGING.
> 
> the last sentence is redundant. here we are talking about how HWPT_PAGING
> is created so it's implied. probably you can state that HWPT_PAGING object
> is created when talking about "otherwise a new page table object and
> iommu_domain is created".

I don't quite get this part...where is the redundancy? And where
is "otherwise a new page table object .."?


> > +
> > +4. IOMMUFD_OBJ_HWPT_NESTED can be only manually created via the
> > IOMMU_HWPT_ALLOC
> > +   uAPI, provided an hwpt_id via @pt_id to associate the new
> > HWPT_NESTED object
> > +   to the corresponding HWPT_PAGING object. The associating
> > HWPT_PAGING object
> > +   must be a nesting parent manually allocated via the same uAPI previously
> > with
> > +   an IOMMU_HWPT_ALLOC_NEST_PARENT flag, otherwise the allocation
> > will fail. The
> > +   allocation will be further validated by the IOMMU driver of an IOMMU
> > hardware
> > +   that the given device (via @dev_id) is physically linked to, to ensure that
> > +   the nesting parent domain and a nested domain being allocated are
> > compatible.
> 
> just "validated by the IOMMU driver to ensure that ..."

OK.

> >
> >     .. note::
> >
> > -      Future IOMMUFD updates will provide an API to create and manipulate
> > the
> > -      HW_PAGETABLE directly.
> > +      Either a manual IOMMUFD_OBJ_HWPT_PAGING or an
> > IOMMUFD_OBJ_HWPT_NESTED is
> > +      created via the same IOMMU_HWPT_ALLOC uAPI. The difference is at
> > the type
> > +      of the object passed in via the @pt_id field of struct
> > iommufd_hwpt_alloc:
> > +      When @pt_id carries an ioas_id to an IOAS object, the
> > IOMMU_HWPT_ALLOC
> > +      call is instructed to allocate an HWPT_PAGING object only.
> > +      When @pt_id carries an hwpt_id to an HWPT_PAGING object, the uAPI
> > call
> > +      is instructed to allocate an HWPT_NESTED object only.
> > +      If any other type of object is passed in via the @pt_id, the uAPI call
> > +      will fail.
> >
> 
> I'm not sure whether this note is still required. probably just one
> sentence to highlight that it's @pt_id field to mark out the
> object type? most descriptions duplicate with the earlier words.

I feel it's a nice summary though... I'll see how I can simplify it.

Thanks
Nicolin
