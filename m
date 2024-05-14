Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB3117EBA6
	for <iommu@lists.linux.dev>; Tue, 14 May 2024 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702011; cv=fail; b=Qb/R1yK3XVDovrclMB46Bt2v7cOmcNPDRNSMXaiMydPmuUvs1MbovtyA7vTVMhb8VP4S1pGA/WgoYC0m2WaL9ZkNBBmwm5JTgy+gg7NChPVOAMAB7ciZV5+zuvkT17MTA2MouOHDrQjg1gEytvx9ko1lnn5nMNUQ2e+usTQTUvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702011; c=relaxed/simple;
	bh=7zRoEWUVU3mKwcYMr9VyLsDGQi+RQOUmlzXYl2bajTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jen+UCr08ZkC0F1aXyglRthNIXy414lZNjvkw2ZJuDWXZsnM7fZOxf45+H7xIEfAAtt4Jq6WzEDn6aZghkcHG62QBgCYM4Ofp7FYqeMCsnyGNQVyLSDotVjplJUIaFZNBQzoiFSoPOBw4VpeotaeUeF7p4a7kV02youPMlMCHyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FZuiVjXa; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FZuiVjXa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+m0yM/OQ/MlAqWeNazws7spAEJCHmJNMcUBcQPCiqJyyjBkJFD1QzCJPZmZYGNWDgfNPTc9EYwgQG/sm1AMcXOaK2dYK5gNZIwyXMwaUl1CupvEQTHrwRUSqL8Y4wb3i9DU787LM9bPTDkdTvxotQzXvYLV8ooD9qUkv7hvByByj0Cacu/Aop8P2a/eoV5EJ3bRlSG1v+hVqVQPRB9+v3TgWt+f+PWlE0XJa7FjdocwxxwiMiIWGq6MHu/6D65g/kHnnrz9/oDhi9ezCpIMpK2YQ9JKQOzRpSeUbsBpjVzC7VCPJyHtUmIYkA+nTDihaF48o1HP+elEa5tNOXNWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOANvG65P9Cbz7EDd7p28oCJJFW3rG4vuvjFizjTNJI=;
 b=TI8PNPRnpUYnlrfhGahOTIDYIMzMGaxjNNqCMG7HTo1Q871hqo/4TzO/5ZsHlk8z0z6gYS4JIHXOLlXCeTFseISjTf7WxGfR3L+7mL1mYmWeK0ezHPEcQLKt4jg+DxGafOD03oWFDxeGuqevvyAb92MqHWaZ5fgBOMWAWD72Jea8kiSV+SL3To7JaaIO5a/CtnXSRgMhFN9J+EJmNYqkb9a2d7UBRdaiIqF99Hgm61DA8MgjAffO+U0yPc4xYTkORE7DQ6l4vCHFrLbTR4sqAZD3dwOYkUvlOWpUGGR9l4NBVzfy39TSWc50S/zxJoJo+35QrJHqva3ZZwyOPA3NNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOANvG65P9Cbz7EDd7p28oCJJFW3rG4vuvjFizjTNJI=;
 b=FZuiVjXa82xPHp2MyruQwTWQUZLopnwm13ldJZjuYLuaZFbetHtpG40g/VpIDleQX05jrcj3GibeyDVolVH/JW4qhx4Cltx7y8Mo58xW/+CusXCKHCovuViRcumsxAP4i3u5WfJUVRM2azcJhnWNmr4UFLD7h/SrQNjrmDSEFF5Gusba7f/BCFEbpL15Rj0D2BQJ6A7gHqjMDZqMlQONcqywrxWFK5xrpUisnAvq1fXdY0u3I+mB7ieWM2Q2Dr9Btkm72N880vM3i0dCrUvB6SWlK3pVKDVpmjj517D0mboNc/jkAujXWk0IX8SsNfqXFXw7mKlXCppB6kBCULQyXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 15:53:26 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 15:53:26 +0000
Date: Tue, 14 May 2024 12:53:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Message-ID: <ZkOI8ztR1mUMJ8oe@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com>
 <ZkGZc5dvLigXcWib@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkGZc5dvLigXcWib@nvidia.com>
X-ClientProxiedBy: PH7P220CA0042.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::25) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf6ad9f-b3fa-4c9e-b8f8-08dc742dfdab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?35HfbVtNjeRtEQWHc8M26QuB5szOQTJkHh1m+3CF49ItbYh3WZI+x8adbbn2?=
 =?us-ascii?Q?njKraobfcBT0pQuBxzVZIsz0rZabxDbSp0NRM7khWgJtWn86OCpez0CL6KrN?=
 =?us-ascii?Q?dBLwlSEAUtF093A/3z0AivTu7rZ0GuI+7C2a07YaI0rwROdkSKQNalxt9pZH?=
 =?us-ascii?Q?oMYFw/M6hYsQQIxBW2UcwpxoWGqgZWzsJr3E+e6d3bCF7Ow/LOw9jLcESEqA?=
 =?us-ascii?Q?p9dVWhDXQ58zwTFFGonrCsLGFAiWj3MztFWY9spTah5CGsAFVhDJgtQQ7M4C?=
 =?us-ascii?Q?O0K3xrsCUs+pwUIfCVg27018ogQp3XoqSsio2GkMTiwqidsgHoddgambHrMS?=
 =?us-ascii?Q?BA+L7kPXvy3S0MFDAy1SKyLObVDR9WC4CI6vJPk3Qi8yz8QSKQKGBbQiN4tV?=
 =?us-ascii?Q?PrA4t+KEbEuJews7ouC7J2LIyFvoU+KF257CYqhdlehBxufhnwKXR6uxbofq?=
 =?us-ascii?Q?gTRyz34FrtQJby+e5aQDDxmkjA0CdSI6QLsCvo7d5papSqMmdPka5aeqk+8L?=
 =?us-ascii?Q?cfNzuiVFF2vyNWzHkQLWI6jxGYxSYC+YR7VQKbMP/ICLHqFJdwFpBZ6GO+g9?=
 =?us-ascii?Q?kaZO+WT3kKHc0NLZ/CXGIpzB6ewf6xU+vh/nQD/cPvA4SWA4//L+B7zCYUIh?=
 =?us-ascii?Q?upGfS+MxwhHCFe+1BEbfdYwhP8rTwko+AY+gFeqfB6EJshECw3Gem2JN8xzf?=
 =?us-ascii?Q?H2Ssm/cOD2AVYt52ApeLZ0z9DEj09oXBKFyXACRi5flLNltyOwTL5pSTpqQH?=
 =?us-ascii?Q?09y/yfjP8pe7I7gQ7OUG6ioO1ua9OCktjMMKADWL45d+DomhpSKfPkFtG9Vj?=
 =?us-ascii?Q?oBvqmyq9CuqtcbKbRolg5aYtmIXevfdPEHKVOJaKMBzsyeCppDGy3jOjeAJW?=
 =?us-ascii?Q?xbpUzN86UYWw42WEYwae5GAV5p3WhU2SLIiqeCkG9SksfdcvAIW4KS00kXjz?=
 =?us-ascii?Q?jjvxeC+X5L+lImJgslT/U557FID8b0ZasAtoM4nljNOI7FI1GOaTe+tHNEdZ?=
 =?us-ascii?Q?bzjjJ/gnjrLsSLhaFRsZPuI4YRevv4W73XSlpGRDibAmeAfdPQRXhlmkHyKx?=
 =?us-ascii?Q?ROL3qHJFsHP0G3yoOMSOUhSdkYH3799JU/T2lrOzAa4HtbwdhTw2zKxzr41Q?=
 =?us-ascii?Q?EZQjLsIdxH2e6zB2cEQtQGZXQzDbNDlw6DSxwo95oVQjfD9Ic1oIjLZ6cbJ7?=
 =?us-ascii?Q?LPDMEHvN0iHNfF52IKWmnSusYWvqLIhaQkq3FSO57NwrM1HHM43gSmGPG/K7?=
 =?us-ascii?Q?nbyrf+QNhvAtZ60tO6CnfmeFWPD+GvZEnK47DCdCCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?spytAs+1nl+sRPb1dXgSinUmeHbCHqMAFKzGv9nXa/tNrdaTxh2kcG1ByT0V?=
 =?us-ascii?Q?qCHbsfZTzJ4Zba8HsAQACoTPQU0Th/B/9cybYOy57S74F+0lwtP2QEqcbnuB?=
 =?us-ascii?Q?VvrOPJ/AfQcNjj5g5XvKLBhzRWO2DOriDPJ6/S9iP3UnJfCE/EkHVxhS+cDV?=
 =?us-ascii?Q?J0x42bnTjcCvcnBgGxzVVK2NNFz5aRk3mLJ4pORaY4IjtB1k1ZSjlUdAjyuD?=
 =?us-ascii?Q?3OGWLp5NTRSkOmnqsBFY6N25robejsjNbLKpCfOp6zOfnnHgAKyXKUJ1GbHu?=
 =?us-ascii?Q?o3NkQ2TZYdYjwy0+afWQ4uhUIJca8u93wf15w/1hYtvJX+BSQ8ZeIZ2XPeWD?=
 =?us-ascii?Q?+J32RdM2SyZ5C8ajbs0CNvOeEuj3MG7fvN/sTt6Z3UqG06mYDa7wkPEKbDp0?=
 =?us-ascii?Q?h8zJ7IEEKTDuFPS9qXAyzxIL6nRyT3sQwg+dtqpjZ/Bya5hiJJIYuYF94ovf?=
 =?us-ascii?Q?sv8YNhuYTHGbO5MjIUeXxtcQUdzJY35UP8C+mtEuijyvIm21fhTTsBUtGAfI?=
 =?us-ascii?Q?H+2abxmA9J/TjAO8dmlco7k6geQvOveoeED3WiqmPezMRgFVOvM9DSTIlrTS?=
 =?us-ascii?Q?igVhju2wRgSMP4LzCYNW7C1jjWUVf3anKe8TdN08TfsxDchJEJGyul+DYkdy?=
 =?us-ascii?Q?y9J3mC20Fpfbh5RFALOk8MNdew6LuIOa/azpd6QN9ZlSA156/7VFD7Ymkk3S?=
 =?us-ascii?Q?3d+/NXDcnEUqw2cE7QEl07vl3D3wWw55n1Gd7SxSlmzbqKnweUU4uLbrjU+W?=
 =?us-ascii?Q?p1l/U3mmyvwysprOyFD5GgooUiWmxOBLxh1RKCXSQ3R5/bRy0t5Mw93bBg/x?=
 =?us-ascii?Q?PtfpH6n5W1GXK6kBCVIdID7DrDGspa4jSXnWE3HHZcvYOXaWn3OXwZYOwdWm?=
 =?us-ascii?Q?4jV9pxGp4Cl6Yoz+9l45Yw6FZknnv8C68RiLWzyiSfvGoeYqJLCLMcXSzdzL?=
 =?us-ascii?Q?jNiIdbzgh6iFdIUYertblfcqqWseueEVouafXtMAPgaRjtd8IVBzM0yVs8ot?=
 =?us-ascii?Q?dGNBXr3g8JBw73JQsXrf9Q7Hz4xmByizoP+cPP8YMI+h+tlitfNDT5fnqmju?=
 =?us-ascii?Q?xx1pxaOJzgW7dXyyo8AJAK8XPvj4uZVnwPcVqbeV7XJ/0qZ9af93FLCyR1Ij?=
 =?us-ascii?Q?6wasSPMryxHNMHIdCyvozyc8cHQLDjynR5xk3ChEF84qhx2mRwl0Rr4x8wVO?=
 =?us-ascii?Q?gTOhLOnGQEIZ3iqYIKwH6151sJb5A0F6bWtWis03WWCsRmezU/fiL9y3mhkW?=
 =?us-ascii?Q?GfgLbWogllXs/1byWgEgU7JfgQpGn/mk4mrVsg5lcPa4FH+UiEwrlZUZXDG8?=
 =?us-ascii?Q?arEfsbaOFW2ckdJxH7wBvn2R0n9Px6KsbvJbb3EoTEalbc8mN3YYNpCEPpLs?=
 =?us-ascii?Q?c0JKpGmXM7YSlRGy9beG5rjn7kZDvxsZ6EdIL7Ky5UNz/9E3U0yyxj/v5q+T?=
 =?us-ascii?Q?DnuqJrQrEPR5EuCh2xI/+pGcOAsQaqMwUqGhTH7ejscVRWMevoIC0N0QpQXE?=
 =?us-ascii?Q?+UK2/dFOMtWaG23NJV7m2l5ZxqDLKNIfuClESOvRRkUkHL7XnVaO1Sl6G0PZ?=
 =?us-ascii?Q?rc7vdzMGfTw0G2VqmfM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf6ad9f-b3fa-4c9e-b8f8-08dc742dfdab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 15:53:25.9178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdLP+UKgXsLYfizOIA01NiCq4giQ9XUoxAkKzzPRSsZeaqDXOSAJn36OCK6SssT9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369

On Sun, May 12, 2024 at 09:39:15PM -0700, Nicolin Chen wrote:
> On Sun, May 12, 2024 at 11:46:54AM -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 12, 2024 at 08:47:04PM -0700, Nicolin Chen wrote:
> > > Add a pair of ops to set and unet device's virtual ID that belongs to
> > > a viommu object. They will be used, in the following patch, by iommufd
> > > to support some HW-acceleration feature from the host level.
> > > 
> > > For instance, every device behind an ARM SMMU has a Stream ID. The ID
> > > is used by ATC invalidation commands so SMMU HW can direct invalidation
> > > requests to the corresponding PCI device where the ID belongs to. In a
> > > virtualization use case, a passthroughed device in the VM will have a
> > > virtuail Stream ID, used by the ATC invalidation commands in the guest
> > > system. NVIDIA's CMDQV extension for SMMUv3 provides a v-interface to
> > > execute the guest-level ATC invalidation commands directly, yet needs
> > > the HW to be aware of its virtual Stream ID so it can replace with its
> > > physical Stream ID.
> > 
> > I imagine using this as well for the ATC invalidation commands. It
> > would be very easy and simplifying if the command fixup just extracted
> > the vSID from the ATC invalidation and used an xarray to turn it into
> > a pSID and then pushed the resulting command.
> 
> You mean the nested SMMU series right? Actually the set_dev_id
> ioctl was a part of that until we wanted to try DEV_INVALIDATE.

Yes, there is nothing inherently wrong with DEV_INVALIDATE, we could
continue to use that as the API and automatically pick up the VIOMMU
instance from the nesting domain to process the ATS.

The VMM needs a reliable place to send the CMDQ data, on ARM/AMD this
needs to be an always available global-to-the-viommu thing. Intel
needs to associate the virtual invalidation with the correct nesting
domain as well.

So I original thought it would nice and simple to have a
VIOMMU_INVALIDATE as well.

But.. If we need a nesting domain that is indentity (ie the S2) then
when the VIOMMU is created then we'd also create an identity nesting
domain as well. Functionally we could use that global nesting domain
to deliver the DEV_INVALIDATE too.

It is a bit quirky, but it would be OK.

> So again, yes, it makes sense to me that we move viommu and the
> set_dev_id to the nested series, and then drop DEV_INVALIDATE.

I would like to do this bit by bit. viommu is a big series on its own.

DEV_INVALIDATE is fine, it just can't do ATS invalidation.

We can add ATS invalidation after either as an enhancement as part of
adding the VIOMMU either as DEV_INVALIDATE or VIOMMU_INVALIDATE (or
both)

Jason
