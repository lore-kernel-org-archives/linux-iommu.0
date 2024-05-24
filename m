Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF4886263
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555824; cv=fail; b=In0YsqNCNiS8t2doXCGYVdweF/vWvuLD1dfgzIkOMgkVZAxBngI7JbwQPkrKwXD71aRDw5+1t1r9Oq86XTm+MsYnXOjJJPzEmKD/Q7FBc1GqCg4Fp8FHq/SBDY6UtvKTNtpb4j0L8PBVofBaPO6cpIb1bcK4tKUJwgx6jFfcXtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555824; c=relaxed/simple;
	bh=j08HojIfWV1S22CJ/e09qTPNGHaYJuhWnvM3M7cMggY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D03c2w33YTCSlQoYgWDrfYM22jakYR6T0A5gAmAgf31IIWUONqvD1apWtNxEylAQRrksZ010GnMa/EMXCg6d+PJALC7E5GOk/VKuNkdXO5PnClrr45NR7WRVQ0raf2gT4R/Y0HX/aIiC4QNbRQj2pwiMtBf4zo0zBBhfwYHdNsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gJhkDoJp; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gJhkDoJp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9UhKo6lk9xfPmEFwuN7hi3IrxpkguE9bkZR+BtQs+XB8K7+9OZQTo9Nw6eoNq5UpOE/3G0P78/WBzMXKxFAb9qEKlYtgAzGSim0Xkmp3YQr3Deom4jvdjWmR/5/zIsiIeAbFmd5hB/gLV4s2tEi4IcStjVX/I4fWtrVZh3o0GI83LTvYqpba7tsi6dbUrXXmmFl2TUHhyPVJeNksf/fHnBUbQ/UIYXsbUYRheTfDJfXQ4jnBB7YwNbPNizpVFkUs9O451owshaqf+PEaqOfANjPHXdU9WCm+w6xJ8ReHK0GqDLeQn/61ZmR70xWFytRam39qzDZWNZcuW8SKtxhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7ODNHpiloVQMVboE5b0UlwFX7pEya+TAa9P8NHXK9k=;
 b=SVvx+oaWEfLyZQEywScE0aNqnm2O6tLyH2DzEunJsb5WsuDToDHkx3u0yTHmC/Lp+jpKj+nhaIj+WYthxD6yKG5DuLXl3joW4RW1694XJqCkQTBrxyrxl9N3+LdrAoqQT7QE7WPTtdcjfKHZl1DzMMfXAYnOSZHWtzrAOedK//p9ngqapPdwJ5GoqHS0N4/NMn+zHGAT5wCJq1UEnPcCGQpLIr63f8egtHea5snsc0T5SqHzwIzEoBAqqiNSiefVrvF+ueMvvWHWratTK9sAZWYzk5h4caat+V8Mn6pKsaG/9Z8La1oiep68FWU7sStrgm7Z9TzD/7LDIZ2aM6yZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7ODNHpiloVQMVboE5b0UlwFX7pEya+TAa9P8NHXK9k=;
 b=gJhkDoJpALGIhCDSMqIO4k/AWWilVdjfkm/4CEHtAgb0KCwixHIe9ai/U6PFcM85+4jlLQOIsgImgZi8+OAg5wZAgaUTIn+EbSvLGQfZBL2yHRfjOdqnSK+Ljb9hx2DCdI0AHxPWYAhWOTMKUEXluzZcYVyAqH8XhfhYKyYjph7fqMyJgDPQJoxPfSCmGKmMLWL6G/ECPLyhaChsH7oSEzbt3mJWuaPEeM88g3dJ2obfzozcAgA6gmYOejTPVEa6271+NWOTJnlAio8/0QcIdnaNCbCw3p/vxbewvq1hKV5mUbTMr9clw6b9rSTLaXSbYFN4D1pU4iL+fgMyd7DMLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 13:03:36 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 13:03:36 +0000
Date: Fri, 24 May 2024 10:03:34 -0300
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
Subject: Re: [PATCH RFCv1 04/14] iommufd: Add struct iommufd_viommu and
 iommufd_viommu_ops
Message-ID: <20240524130334.GQ20229@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <8610498e3fc00000e78bb9cef6fac9f6a54978a4.1712978212.git.nicolinc@nvidia.com>
 <ZkDMSfd9BXmsFfb+@nvidia.com>
 <ZkGKKoHnykAdGJq6@nvidia.com>
 <ZkOJgvMNFaZZ06OO@nvidia.com>
 <BN9PR11MB5276423A0BFBDA8346E1ED3C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240522133905.GX20229@nvidia.com>
 <BN9PR11MB5276267BB1CC4AA7008AFBFC8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240523125856.GL20229@nvidia.com>
 <BN9PR11MB5276461630564C74C9369CB88CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276461630564C74C9369CB88CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT3PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c56586-634c-4fa0-e98f-08dc7bf1ec51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wjx28QuHkQez1niGwSX7kxVCynP5GvubKD+wTngnctk7bwwJBLaWCqcQlwWk?=
 =?us-ascii?Q?7eyb9Cz+Jx/ScIs+E768FAGG2Djdy1zF9JIQeyLnHqD9cJ5+iMYWp4zhx9TX?=
 =?us-ascii?Q?sM6F/pGokeygKVhUA1aJPFZdk/IQyvsnQnMYB1N+RCoGfYLvccV1WKH/QwD0?=
 =?us-ascii?Q?Z5K2dPCqJUT0oP/dJ/AIRzBH0j4yuZE41cg6WuiCfEy9g5IFUoC07ZkoInmI?=
 =?us-ascii?Q?rBSK3JUCwhevUR02RqP+idb9Srq7LTXQt3AEhMpigFKIKYhJ6CDFr4TwHKxt?=
 =?us-ascii?Q?Cdc04Ae15aeHC32J78bMOK2MmPzO9wEH/uM1vQlrlfUSOkQsP/Trv6fXH/eO?=
 =?us-ascii?Q?Vb1SnSs2AW2SIA9KYfAPq6CpNt8/7pb1kOudQDGiKbI0z1iQdQRak317KS/p?=
 =?us-ascii?Q?666D5WNemCESQ1LZ6uZW0lfPs11u3jw5k8UDpWb98tzETdG9oo/mZvk1Pgun?=
 =?us-ascii?Q?FxFLBdtZCO+YYdrHCSzRMhsOnG3C32McxlKOH8pMrUkZpb87pAyIlqmeXtBu?=
 =?us-ascii?Q?sp5Lg5t1MHzx7lFIUobahWd2kWgWn85rZjbcS6N/fNJAftgu09iLHKX9M9k8?=
 =?us-ascii?Q?3y42lZmYUdCPZdgpVHO4DQ+XSkbQX8kAOsXZ/xQ7LlpwTlCXdtQwlTTp/j1F?=
 =?us-ascii?Q?bk/K4D/erWYz5uy2MTDN77gyM6VfUw086xqZH1NxSHgKxMmVGOmdXJxP5ruo?=
 =?us-ascii?Q?DbTGBxMVISZnOXtc6SxvOcUJ1iGgcjxCMqbEl8veNJfOnhYpi85AeOnXMfsY?=
 =?us-ascii?Q?LUr6+ndlHWeHAXxXX2V3DegR0IOEf6A1+JCPs5nzIa1iyeN5FrOrgn8+YUrU?=
 =?us-ascii?Q?GsV9LeL67gO6YTKd8+mzaRh2bktTMRgXl6VOuHjz2uA4+ZFhwtJeg1vQA/Mt?=
 =?us-ascii?Q?IdHGb56LjvMeJkVjBjjd/nuZsCBerLfrHiOSjdzkXUCIjby7PpzsqAAit+lE?=
 =?us-ascii?Q?I0sHkQ4r4tK4a/DHOgLSNUQBWahSXU8gY7CUEclae2BXAsq7OrR5m9Rjc8Tq?=
 =?us-ascii?Q?xaCZZLMlFlAhHMmANE0oQlh3r1WQXjRzKmsyZ1B9f9uz6jhm3WpKXjRp6G8s?=
 =?us-ascii?Q?5b6SyrGgj3Fe7E2yYzFG/YoCZG79uEQ6p9Qu988DkNe0g7O8npcRZ6k4y7MZ?=
 =?us-ascii?Q?AI6VCLLIWEQ6x1kB25zBBobNVnT9F/TipJRoIjY7hHOaxfutIpNI+PIvI3cf?=
 =?us-ascii?Q?SfGtATH1VA1iujAmwYxG8wZnfAUOhBtVeZc5lSQBqdnyy0SDFIwwzlhU2hLb?=
 =?us-ascii?Q?QjqhLOmCXraBMCHCHwAYYMp+EXoIbr5qoLAaRQ43jQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1oWZn3ZNGyyrlPnm+ayWvU/dpJN731zdbnxqq7iZ17jdEbfz3kfUAiN7Tt5n?=
 =?us-ascii?Q?ae7LhuOR0ih/KnZvjnO6Z3q9GbcDdLeUCezU7VH/5HBE0lwsR/L+ax6xBv40?=
 =?us-ascii?Q?a5D5N9v38HAW+gCoBKAH8o5x1erolNDmbg/t9X5XkPpKOtTUWwzf82PMqung?=
 =?us-ascii?Q?nSk8eltKRIN6VGmtQ3ApQBYKjlpslV/4MJdSLbR6uxWdOxYCqHjZ2xpZnk52?=
 =?us-ascii?Q?OGIMGA1WprVWvovWiv4vDxP87+8LoY46/7SdrSDDXQ8wOGLvUGbWTkQaTByC?=
 =?us-ascii?Q?B44VVkXCnReGi0TaxRtREu81TB7kunC6GwcMATPv8fqMrpfjmRAhib1DBk7K?=
 =?us-ascii?Q?SPltnJnz7KzZVwjH68j5wz1CLDpK8R88ARPAYoKtBv252VFwsS6/WyFboxp1?=
 =?us-ascii?Q?JfD1sNE4KpS8qW4mvTmPWWV/lznGvyFPTKaRqZ1xthg80k8WRNQuUQlgVAIw?=
 =?us-ascii?Q?PtIM2o7FIKHHoS6ZExr4uHpjRrPkzRgFKy7SOaRU430GSri0bkt+z/DQN7or?=
 =?us-ascii?Q?4RdqStm9+kv7D9qE09YcjRx87yaNU3o0i/HwbWuwwE3Ytaoc6EErrLt2rz4U?=
 =?us-ascii?Q?He68Ox3FDtinDHFXsvTsCAC2ubUfTt4jrcJnNM4QJ+vfiCMQZvIGD3whpUa9?=
 =?us-ascii?Q?jFGhBm0d7Z6JCz3ymVKTtqC9MKSAIYHVw6jDqQwaLk2pE6Hi18O0UQjwFEJp?=
 =?us-ascii?Q?Ycgwe+eE4er3YDW+aBLwkjdURr9pKIZgYrge5/wj/ed1UEiOOze639ck/jXS?=
 =?us-ascii?Q?zn5trSNdktfFTqYyc1/fpBOsK1rsmWolhmrlJOHTo7QN0NrWZmDVlvWHAWaS?=
 =?us-ascii?Q?mSeKiF6jxOCPWN+0wSp5AfZMV2BCEOfkTYoMnazE2KM9sI2tXsmd6/0/VESw?=
 =?us-ascii?Q?J0RNETtPoqzW8i606gvSlM9Qt1zjyuN7WQmYSA8Z74AO/kS+yg4YIs00xr4w?=
 =?us-ascii?Q?EV64sBC+lMU+6OGQvtYrBQokFR57HwAM69Ds4gdozgx/RVcUs2pNtga+FSgL?=
 =?us-ascii?Q?7oDvGro0jI6RenLGiKwe9fUgbkoeLJOiSu81/6/CA/I5528Dr2lJPC/n1bOK?=
 =?us-ascii?Q?CHdwRCeT8XsZ7bJOvDzi4unIitM9nl+47TLvlml1NiTVuctm+ojeAgAc85/M?=
 =?us-ascii?Q?v3XfciVA2289J9JIjtr6gKfB9rLQzLKvRb1NXTeMbSLHeR/jAMdY9QK4TKw8?=
 =?us-ascii?Q?+/SLoyo+X07GseoQ0UFakXKbAZJDOWUjOj8xjbygujP49Vq7HKTypFCOiv0w?=
 =?us-ascii?Q?381l7irDd7B1uw9WHGMTeRLSOLOAjaG9Dkh+RpI4nYc2v+ykG6LhSBl0HEsg?=
 =?us-ascii?Q?Hv8OugHm2gTPW7jLQjyA+bsHZofzNVnKWQm+TM22hAYXI4GyDu0cDPNXhR86?=
 =?us-ascii?Q?jrEjraWUIvFPWmrPBe8dZrrL1/yJIDApQkqZSbm3nUg5tBMAux9OQ8SJ0mJu?=
 =?us-ascii?Q?ede7qgs/pcLpVnwLHs3WmxviIuLtQua/Yn5HKw7jneYmnQv10dUqmmko+wSj?=
 =?us-ascii?Q?YWb2OHu+1jnIfZy6Rvxi3rxYoh/9Rsa6E8mJ8BECAVZzvcAyRcCE3J2vkqCs?=
 =?us-ascii?Q?YcbWM9IdEPdceugQYME+IYIW8SL+hGgHK+0HNhJO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c56586-634c-4fa0-e98f-08dc7bf1ec51
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 13:03:36.3652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxYmvKOz9Zg0P+IrXOtna+UdVJRHFQYfJM9mlhUwLDn+/HZo8TSk2WksS1vVYd4E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126

On Fri, May 24, 2024 at 02:16:34AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, May 23, 2024 8:59 PM
> > On Thu, May 23, 2024 at 01:43:45AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Wednesday, May 22, 2024 9:39 PM
> > > >
> > > > The driver will then know it should program three different VMIDs for
> > > > the same S2 page table, which matches the ARM expectation for
> > > > VMID. That is to say we'd pass in the viommu as the pt_id for the
> > > > iommu_hwpt_alloc. The viommu would imply both the S2 page table and
> > > > any meta information like VMID the driver needs.
> > >
> > > Can you elaborate the aspect about "three different VMIDs"?
> > 
> > In SMMUv3 the cache is tagged by (VMID,ASID) where ASID is completely
> > controlled by the guest.
> > 
> > Every time the guest observes a SMMUv3 instance it is allowed to
> > creates its own private ASID number space for that instance. The guest
> > could re-use ASID #1 on two instances.
> > 
> > So every SMMUv3 instance plugged into the guest needs to have its own
> > unique VMID so that the overlapping ASID's are disambiguate. The above
> > would create a VM where:
> > 
> >  deva -> vSMMUv3 #1
> >  devb -> vSMMUv3 #2
> >  devc -> No IOMMU
> 
> This assumes that each vSMMUv3 instance has only one ASID space
> i.e. the guest cannot create multiple VMID's itself?

Right, the vSMMUv3 in the guest has no support VMID at all.

> > I assume the vPPRLog will steal all the PRI before it reaches the
> > kernel, so once this is turned on Lu's path won't see anything.
> 
> Okay, then we expect this vqueue object only for HW acceleration
> while software-based fault logging is still routed via Baolu's work.

Yeah, I think it mirrors the invalidation that way, we have a SW
invalidation path and a HW path. The PRI is standards based so it is
easier to make a generic API for it.

Jason
