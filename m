Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196A140E5C
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386395; cv=fail; b=HO6cxaXT5MnwJHZ2NCrhpZLynkAv8MhBch50JFS1xhrUpjIJZZ34YSvcKxJ8Z+PdYaN1hX/nExvrlkCyZcPFPgT15zjYok/pcpO1DRDWeRbpZsynZgaGJGuzAFUXQJSuzYb3DzUCL4vlHRRL6RmQQf3YW34Bk3gVqB7GxmYoqII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386395; c=relaxed/simple;
	bh=4ZVJF0KC8ineZHkiwUDz4HcuRwo9iL7b6EEYZXv+cvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PK+zLLazuidTkESKf7S2qr8z7sXW40lAYl6TaES3aV1u9o15h+cjcsEUKeppCsP8I5iGIvCuo29FQjmXYuCvda1RpRHPoB7tmZ3vy7t20LnECNGTwPlHEzU37G7/yc0Rt5vP2w2oWqsBM/Swo0s8Qc7ig8YFv1i0xYhykGLluRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZnFvyLAZ; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZnFvyLAZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIjkxE6nAj/RBtpKBreBcgYIMX+VQcf2UOrtbW5HdIU+r17BjTAeO9L7ykZ++S6+BT/z86qR1UamHP+zv2gPV6CJI4ZGpS/7YTCOHW9pd0mT0NVnRuGIi1OCh9wNXhkIKW4UAmiS8SkuSIGTBdlcllKQF8NZ6tWHi37M/uA4pFYL9kmJbW+0lH9UJ2oi4ZmT/w+oyqJVCnwbYqt5+i7BqwtMsRIUF4cFI3u3in9emJcmamuJKW/PQTJI6d8uU0lwEmmf28MkDpueetXu9h9xHnwOnIHEVbccazIQgUmbUu0yVk28zgV58HScSB0U6mMD8qqLkuHNh+UD7SWFahdJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP4zmQRsC7nT8InGyYwVkXe9G+rdEs/n29cbz2MFyOE=;
 b=d+MUq2KbpE/kPuTY4J27VRnsPoWNpk1sPYWhhqWIjVF56YKoSaJ2E5WJaOVsfq2ZgaZrsDvGGmJbtsZeJvare5ILZoE4CWpByCw2/3TWjd/PTw+/UxQp3vr2kHZ8BGe+AyP1SbHu01H7J1Bl+rFR2bOii5jsUpaUcYRbxrSMB2cyG/jk/zySejPmyJfbY+M9MnHnkmpvQt7Mr1H/e0CMaU3SAbiJVzod7MS3wRpwytVdoU5B14aFjc5z3P4P/n7TQzCgIbby27FB99zXkLdHc6fKPqvB6g/F0ePf7IlVlY6rSOnv0rLUfSQYjeLaea3MtagwcUMdBpp7ErGk/fjeJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP4zmQRsC7nT8InGyYwVkXe9G+rdEs/n29cbz2MFyOE=;
 b=ZnFvyLAZVhj1jyopuqpnvBOqvyEQBSpiHgqG/SETinBswHws6yP6M8ZUyk33I0rHFwqeIQGVo2zDxq5Q5YAywuzm84u/MUGe7nF7Nz7jbTUnlh/i5SSo9PwsuSV5NzfoH0Ew2VOAkMRhq14NIpZElJ7b4V5HB/xrzWF2Wp6JclQYZX/zxTvDvTmiD1t94bsDUYguOtvdSfs/WY8hOa6Dzo18XVbNmruXR9vltp3xmg6dAcr+G2/3wYGOojGZX8UZt40guHDvEVnBipgt+7K9B4VQv4MW1JNjkG8MmgphaJB2+xcpDnfn9+YAn0y4Ab42aI+m+AGCDqMrdO19fWeXxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 13:59:46 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 13:59:46 +0000
Date: Wed, 22 May 2024 10:59:44 -0300
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
Message-ID: <20240522135944.GZ20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com>
 <ZkGZc5dvLigXcWib@nvidia.com>
 <ZkOI8ztR1mUMJ8oe@nvidia.com>
 <ZkQW6/OAQ8MzN6Go@nvidia.com>
 <20240521182448.GN20229@nvidia.com>
 <Zk0ftlf3f4gBaNgy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk0ftlf3f4gBaNgy@nvidia.com>
X-ClientProxiedBy: BL0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:91::12) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 2deb7fe2-0a0e-4bad-d011-08dc7a677058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J+zElvFERxXPgzDopn160/Im1pAY6gQXeQulog8S8WOFIztFbLWIzVFh8v6x?=
 =?us-ascii?Q?54RPuiolzujFOhtQCHyh3dwAwcr5JEQC7pGlTfgBfrrv4DV4/H11YXs7LWcb?=
 =?us-ascii?Q?4Gdv/xVQgOstw272BrkcyvEEnaJF700FVA6eljVrUjhNfk4VB+LzPcgWkcbT?=
 =?us-ascii?Q?zZM8um093Uh4VGf4we6TKg6PMy2FAIBE90bBkf5+FUm8k+cmY78SsWf0ecQP?=
 =?us-ascii?Q?OO6SiQbeVWyP0qyG8eTdDzhVV5NEdyqddEG2gGY/9cvUBwnCb8z2o4CV4LpI?=
 =?us-ascii?Q?utQ3zZ+RViOP79fuiqTW1Z3TmhuFkLUjDkkAleZmCyB0cmVWp0V8c60ZIiOx?=
 =?us-ascii?Q?RnCRlqCDiNub3M2RVHfgpOGWncTXiD1WluAVYw2Iei5Uptut0Vab+koirLpx?=
 =?us-ascii?Q?0b/sMVPgN0yG0mj/jaJ4oFZ4Sx8GSegbc/IBbGSQgINhuZNzDJW3Zuu4kw4T?=
 =?us-ascii?Q?Y/Krl4huEKVMOcUHzZ2tXbLhGYRGaFvdx7FHh+TNbX2bNS5bTZRbJZbUe0Hk?=
 =?us-ascii?Q?ipYwht5rgtCM9tWytFlUxSqfGKWXP9Is1sTVTOPp+kiaENw98YzF8zvFub2a?=
 =?us-ascii?Q?yWufDf02NW+giy/3mT/SWhwDcOoNPHjK1bA47Xf6TFbgw6Yhx2I+uJ7PjMzq?=
 =?us-ascii?Q?W9vhucCEM84AuXZkwfzFRdLmGaw1nSL4doqVcVaVQNaF/6fTcrP/plUxHzGp?=
 =?us-ascii?Q?URWdnpJq2UzCHthoPkjzZti+qJKTMjW/9s5I0+j0gmRlzIDYsoj1ShYgPvP+?=
 =?us-ascii?Q?cYeF8DnYlc3uS0mjw2Mt8/rp/+3NJcRF8JdcttyILtERWV9A+EyFrZPD/tf6?=
 =?us-ascii?Q?rcnMX69DwDqcejFzMN28RiQymJgthq7ZhxlvbCKs3oUkBnKAVkEsnPQEDHSJ?=
 =?us-ascii?Q?J/2/uVFNbUa1CgunqoJDI2GBlI950nvwOXErtlcpt33+qV1spFQjhD/0vVA1?=
 =?us-ascii?Q?qG7FYfFKKaTqhdRmmjzm975Gvf59/L93dtGOjKPbG77r8+Jh0QE8sCVScY80?=
 =?us-ascii?Q?165ZX2CaJ6ca3HoL+gLAx+dJIV5on6I6VbDyNOM9Qsp5hR5rL2dvrHV/Upsy?=
 =?us-ascii?Q?jnych80hjonzmv6pxZn3AFPZTdBfFF/j2dm6X+AhrzepHOtN1i6eEM3xcqqK?=
 =?us-ascii?Q?lHF9F/3Niw1MhbbN3dGkEM0ClntqvOzcN1XDzydUAZ3XfhTc16ULgImDrFDc?=
 =?us-ascii?Q?uUU9eGA/wmqK7zP0sTrmszG4+f1YagCfm0mIf1z0fAUwAH6XWkcKSW8fpRIc?=
 =?us-ascii?Q?1sGKNDbm2Q/0nRhNvyMoHXMg+FgJORe1PcKyUVQOEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?epMLSKaQSdkRMUqA24cKrgICEmn/QNnfY/5jbA/C4W+eEcOfQFSzfemnQ8ZW?=
 =?us-ascii?Q?WSlOTBk6zWhmDLRuoFhTr0YtlYCmv6p1Pu8NFT/7ZNQuqVSjTdM934BcTNJU?=
 =?us-ascii?Q?Llum5G42Jtf1CuBRFvkMEQIvNZlvlMdIszWBap4UDwGSED9tn6ab2RY2WnrV?=
 =?us-ascii?Q?vUC1YRAnk3jp4io74YJPHlaWveIK4miDBO3FCBvh0FgEBBoR42nkaFUwnpeE?=
 =?us-ascii?Q?7ylsxTT0P2uyLIIQOXn5ei3NB6ebYdZDJWB29LWB3uLN7WuPnPvbZawbVsoO?=
 =?us-ascii?Q?Ai9VlwDOjv9Xt10PYPD6gm9CwjDI57sCwUewtXFkxtkAiCagrPSTRefBc1s8?=
 =?us-ascii?Q?XiXRTiXxX33arNGen2rcJhnz8GZLSiujCBNL+csAvLc19/EL7H7DUX4qOiXF?=
 =?us-ascii?Q?CTbFmMPnrKBnQK2KeaVs21qRrI0ZvyArMzG8HSDaMg1PElGIxFMRm4uOMB9l?=
 =?us-ascii?Q?w17ESZZ/mBJO/ssanJRLc6bFTYL49oBgvS43Vi2pmLtdWRDXu0iRxmUMJvkV?=
 =?us-ascii?Q?Lddk0H1r4PCwFMgW+N+Hjp16/GnIf9F7CZfNeIu4dVe6DAp17IWnmH020azv?=
 =?us-ascii?Q?I3knF8KhIFd01fUf3m+tYJXbJ+TQocUKx64G0dhWY0TvgWhRUZC4DXc+DoBB?=
 =?us-ascii?Q?YwCa5a6R3tUf96jc4vyK1I3FnXroCoqpYpwCkPdAxXAwR+d/fvt6pME4+Ip0?=
 =?us-ascii?Q?85hLANf2ymUNMU3ktzl+BTY/LuUApvPkoR/YI3e8FH0pi6hY/TLlMV0MWcBC?=
 =?us-ascii?Q?JcZaI2xHc20U8MV0VztKZ++iLDs22gcgKVq9iEaeC6Ru1/xhGzz89vvJXVAT?=
 =?us-ascii?Q?lBMOc9rknPE1N05I79JzPZ/6WPnyWjuEhiDQ8WN9nkUlMSWCH0/hnhsBTlQb?=
 =?us-ascii?Q?fZnIP6snEDInYkVwQqTqkN2Lc/3g1Gn3LWE0QblKZbOa3KJUq0zjDGBzBMD0?=
 =?us-ascii?Q?PYl5wbEcX5SMGLZUN3PYSNM4loIav7bGmjjZeTKL31pulP4n9Z/cS8tG/E4v?=
 =?us-ascii?Q?dQE1sosrn/GjS3A0FYriQbIXydKBWbDSL2UewT0Q5TMv+FXzpQjS+Js/qaGM?=
 =?us-ascii?Q?nXWECTF3De+A9PpWQ/toYglCJMfjeEKS2KqsP/FyeirjRcjR2devnKt9P7Wu?=
 =?us-ascii?Q?A3MfjCJ7adg2LvQQkt3A/7kX9GcYPrsKvq4uCis/8qlRfGYhKJ7xcsMJ+KEC?=
 =?us-ascii?Q?uzROT8TKmwZn619X85RiF+x0liU/m7XoWg3yxBxzKjiaUqTTRADjs7XIGUth?=
 =?us-ascii?Q?eqfIdY3aPLfVdtK/qDKvNl/UZYjwq6W/lp/Qua6Cuj7vXu1/GyzIDRaPNJ4y?=
 =?us-ascii?Q?g2nzrxGECSr62drpcsg/6LBVAb7Z1nK18IOtbTGyxmKV49hge1cF2Y6EIUVJ?=
 =?us-ascii?Q?4x2O4frHz430bnK11fL0XpKVZyLcM7Vr5J2aZcB2dhCpVRwYuZjfNJu/WnoB?=
 =?us-ascii?Q?o6rQo0r1SN03+CGOjef+jnUGHwJshWLg4uhiLR6gjBWG8zPD15lhviTvwUbm?=
 =?us-ascii?Q?eiigtSh2Hb/UJclHGF49PIosQZc8ZOKHmLimcWatM4EyZs97zopMOfmz627u?=
 =?us-ascii?Q?hv9AaOSSmg3HjqRy9Ks=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2deb7fe2-0a0e-4bad-d011-08dc7a677058
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 13:59:46.5874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATZITZr1KNB/K16WcnzzkHRlGin7lmyFlZp94b38pWItA7g2o8p7HXCFY4ncm/p+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841

On Tue, May 21, 2024 at 03:27:02PM -0700, Nicolin Chen wrote:
> On Tue, May 21, 2024 at 03:24:48PM -0300, Jason Gunthorpe wrote:
> > On Tue, May 14, 2024 at 06:59:07PM -0700, Nicolin Chen wrote:
> > > So, you want a proxy S1 domain for a device to attach, in case
> > > of a stage-2 only setup, because an S2 domain will no longer has
> > > a VMID, since it's shared among viommus. In the SMMU driver case,
> > > an arm_smmu_domain won't have an smmu pointer, so a device can't
> > > attach to an S2 domain but always an nested S1 domain, right?
> > 
> > That seems like a simple solution to the VMID lifetime, but it means
> > the kernel has to decode more types of vSTE.
> 
> Yea. For vSTE=abort, likely we need a nested block domain too?

Sure, it is easy to do
 
> > I don't know if there is merit one way or the other. A more specific
> > API surface is nice, but the two APIs are completely duplicating.
> > 
> > So maybe:
> > 
> > #define IOMMU_VIOMMU_INVALIDATE IOMMU_HWPT_INVALIDATE
> > 
> > As documentation and have the kernel just detect based on the type of
> > the passed ID?
> 
> Yea, the only difference is viommu_id v.s. hwpt_id that we can
> document.
> 
> Then in this case, we have two mostly identical uAPIs for the
> SMMU driver to use. Should we implement both?

I suspect it will turn out nicely naturally, lets try and see
 
> > > > We can add ATS invalidation after either as an enhancement as part of
> > > > adding the VIOMMU either as DEV_INVALIDATE or VIOMMU_INVALIDATE (or
> > > > both)
> > > 
> > > Yea, maybe step by step like this:
> > > 
> > > Part-1 VIOMMU_ALLOC and VIOMMU_ATTACH
> > > Part-2 VIOMMU_SET/UNSET_VDEV_ID
> > > Part-3 VIOMMU_INVALIDATE
> > > Part-4 VQUEUE_ALLOC
> > > ...
> > 
> > So we have this stuff still open:
> >  - Identity STE with PASID (part 2b)
> >  - IOMMU_GET_HW_INFO (part 3)
> >  - IOMMU_HWPT_ALLOC_NEST_PARENT (part 3)
> >  - IOMMU_HWPT_DATA_ARM_SMMUV3 (part 3)
> >  - IOMMU_HWPT_INVALIDATE_DATA_ARM_SMMUV3
> >  - VIOMMU_ALLOC, VIOMMU_ATTACH
> >  - VIOMMU_INVALIDATE
> >  - VIOMMU_SET/UNSET_VDEV_ID
> >  - VQUEUE_ALLOC / vCMDQ
> > 
> > I feel like IOMMU_HWPT_INVALIDATE_DATA_ARM_SMMUV3 is a reasonable fit
> > to part 3. Then part 4 would be VIOMMU_ALLOC -> VIOMMU_SET/UNSET_VDEV_ID
> > which brings ATS support the API.
> 
> There is some conflict at passing in viommu_id/viommu v.s. parent
> hwpt_id/domain for a nested domain allocation. Do you think that
> should be addressed later in VIOMMU series v.s. part3?
>
> More specifically, I have two drafts in my viommu series:
> 87a659e65229 WAR: iommufd: Allow pt_it to carry viommu_id
> 7c5fd8f50bc9 WAR pass in viommu pointer to domain_alloc_user op

It would be good for viommu to come with all the uAPI changes in one
shot, so all the pt_ids should be updated to accept viommu to pass the
S2 HWPT.

Then whatever driver changes are needed to make ATS work should come
together too.

> I know that these two only make sense with VIOMMU_ALOC. Yet, will
> there be a problem, if we establish nested domain allocation with
> parent domain/hwpt by part3, in the uAPI, and then change later?
> Will we end up with supporting two for backward compatibility?

I think this is fairly minor compatability, let's see.

Jason
