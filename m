Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9EB14387C
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056879; cv=fail; b=IkpYC1DxaY74MGJbsmGLlhpk9+xCaoVhnoiyT9NVvOfBgmWcHgq0nol/nZX1PvF50Sy3dGX0OfpfxRdOYeeuAs0I8K3GRDk7EbPA3Q3o+3GfXPKbHupfeol2fZx4HmuATc5MdgKDPFewdMatIdMR5hE5JAXIkEVDVpVdlwMn7FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056879; c=relaxed/simple;
	bh=Z0yvtg9hQNRmlfpOK8eh6pTvEcoyHGBNZb/L2b6MQVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q85LNz38Ow1upfzu5hHwd0780o68Vxen14EZj/6QjDh9pRCQq7GK9ty4HMcJqJB4LsDUYhghIav/xauK4wiMRKaVEnsY2xO0o+MrX1FmYzjaEfu/eZzvx4ab5zt2GefT4M8VoEnOjvjuv8q7dWZ3VHnPiErI7Xeak9AZ25Fymtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z2xcouPw; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z2xcouPw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1fscPRc4EbWx4R7ukKMzbyT0YkBheKd2qkd5DenfDnSNcet1Sm9RFWy5WDfSbHxT/j55zAkIbKO01PPiS4YNlarVr4/2tfDLCc1+xAH415l03IWcLSmsnMMZ+Vzjd/4mi55yawFb2qXX3Put8wX7AWivbWl4oTes1hN/tQJ0T9HjrgidtuEFACnTVUDtExAfAakqqswlGt+WHZHacSrh+7RTTMI0flNMiBCjaeHDE/ij4HihlUSejuLTeBsRpDUK+RbrUffIf0ooOFuCKicvfwGebGATUSJ2XrAwx0UBi8zetJmFKVtC88rkWh5CR0Pehi5p+3HKBN789yJzY35XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ukzsYhJXL5GOFFSR1rVCr4sC/DcByiTzKV4AJMocSY=;
 b=VB/LYeKAa3/AbIfDJXvt9H88iMwg6apcSCHOTSnRFmJQ6ipyFFW2SSLtSB6SwPjCqGqILCUzwzbtU8D9rncpZnmu/tNBGlVpC8Ia5ixbe5wuG+veV9oHB1R8AXm5mJElnjt5+MntcWITeN+SPU5Cd/M8sT9a9AMphXp1l0CCheW/15i59AMlZnwJxYWUJhAvpxOmXXNoH7tzql+X8ZsXBuQ8x2xo3w3mbRaXX/0SNk8jis+gDgCd5l1ruXxTsOfrmjFb4q6ewIVjaZxDcNpvPEXQcfeNDCxGVgHypLgRDvja0ZKeykk74tfZintDrL3/JDnFmVvYZyYymr+aRnaKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ukzsYhJXL5GOFFSR1rVCr4sC/DcByiTzKV4AJMocSY=;
 b=Z2xcouPwVkHxFP3EccG1I/78NGtccnQt8RGXul/YsF6OMqf+1uupqT+gv1oMbJtSfJ9ND5FgITBVai3UrJ21Cwi1xEXc06Q90wDSlWoz7Qv+MWjCe7SVeOJGVyjGpq3hbf0/aob8gXS4z1sKXOx1MZP7EjRVZA0QI/y5WLK9BpkcrJmNqa56SZu9tVb2kwvu+LoOG3bVWh5rUuLiMNaHZM6sHkMYN2bCNojNhm9JCEKWzIwethqRzYCAenMjSS8jDEvRZD9slVZ7Y8UHSKBdN0d/U2LdWWnsOFVj24MHli1wCC24pJMEBBlxDjSKhj7qiOYJj2MCqqRevsSlcRZYQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 22:01:12 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 22:01:12 +0000
Date: Mon, 10 Jun 2024 19:01:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
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
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <20240610220110.GQ19897@nvidia.com>
References: <ZluWXYQjroz0fqqn@nvidia.com>
 <Zl03rsgZl/msa3I+@nvidia.com>
 <20240606182423.GF19897@nvidia.com>
 <ZmIDqgfINXfB0i3L@Asurada-Nvidia>
 <20240607002707.GJ19897@nvidia.com>
 <BN9PR11MB527604637EC37B3B03FBBE468CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240607144917.GK19897@nvidia.com>
 <ZmN5WZkvDeIS7RRH@Asurada-Nvidia>
 <20240610120446.GP19897@nvidia.com>
 <ZmdbnGnp73yR36N5@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmdbnGnp73yR36N5@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::32) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: caa1658c-6d95-453d-2db7-08dc8998d763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/t9zYv1f78ZQ6J2/pozjiyvlQxi5XYYlXvqbxsyYKJJJgK8X/O0/qQmXcyyn?=
 =?us-ascii?Q?THQ2/ka10SDC9pe34g9u+mhlImqw8oSSLghJrtafYQw5q72WNs5ArHnHlgWi?=
 =?us-ascii?Q?iuxRVH3GGXkQuttyyJECMdGgWk1+27N3BfdRaDuJIFguXl1MiFg2pdAiJ+ne?=
 =?us-ascii?Q?+5X00FimsjeHwi2Tp87+9IrK/Y89rQJb+Zn7YmT3TDFv3vzjrh3OhQYYy/az?=
 =?us-ascii?Q?QDLxHJCuYnzPhhjIpTRcqeMMhlW2pXBs3oLESJwKBMwVHFCg9maYQdiNQyGK?=
 =?us-ascii?Q?XluuY/WG3tMu6Pupv+WPxj0grXIr9Y6zWUhYe06OaSxLIe8OjYl7lF7wP1Fj?=
 =?us-ascii?Q?bHRJ7sSpguH9KG/4SNZ3zQcsx/EO0BLBCSkXjdJMFwpQ0TPTa3YpZcCl3RlH?=
 =?us-ascii?Q?kZjFi6yAgXsB+c7/xn0QqdSehP9cgliYO+G+TRFpj86AGt89U/5yuaIWqwir?=
 =?us-ascii?Q?Uas8Gf4SO0Xf5mPwMyvZiEvpJk7Hpf2kayQJ9XxM9LY9IUIIWn7qBbACfIMr?=
 =?us-ascii?Q?VaTWbRxIk5xySizJaMVQJsQG9pbuqGFGX4+sm5XE/HHcFOqHWrn3qf3dyK/p?=
 =?us-ascii?Q?ZUP1kIMFeyommNjnsjCnsm9NLOUBj/n8q8KRYviXhUucJ4TDcAG+m6cB666z?=
 =?us-ascii?Q?tk+0vXyZTCzKp4Tf50ZymZEenRaPS9uDPrq6QArVhGi3+EwoAS0a4DQpSNm7?=
 =?us-ascii?Q?JkO4M3Cdmfo//qBWB0EWtoTGgLiQu1/dnqzuW3E60HnrYI9vj4HAY931d3Yu?=
 =?us-ascii?Q?H7wxK+NNBCMPK+actc+t+olDfeeOVdtepqon2xlIPPD3CbPxH908Og/SGBhs?=
 =?us-ascii?Q?AGS2mVi/H6d2aWHuKQFOfyhNG3NLordPMg53kspz40Rb4GIvGEWkWChIDdSw?=
 =?us-ascii?Q?O3V0h930PXMWWzhJ2XKdolMQQsLclxFc2Ld6IOkVtfw5flneNhJ7gDc4tKUh?=
 =?us-ascii?Q?9vVBtcnWpf+D8WGg30RCL7iZlRG2pxcGA7hVZuVPFCcwUJ72lxXyUSB+iy4j?=
 =?us-ascii?Q?qBkREannZ4gwLnO2Snq6kfircJXm1PeGQVZLTqd56Imzp6zGV5P5hCFkyuDA?=
 =?us-ascii?Q?xOYRteNVLtMZvaj6KyZs/pBizvb09bX3T9tSRmqur4LH0cfequLq6Qpq06sk?=
 =?us-ascii?Q?LQi3rDZyjmBzCqEBTxloNG98nHRwFONZVPpaJ0E7SbvvvoyQBNyDnkoU06yv?=
 =?us-ascii?Q?Dy2pE0JxLDf5KXxf9Cn6/oxUc/g1LZCk0a2+cAjcQWTAsYZLOXDksyXqkgcR?=
 =?us-ascii?Q?TpxCHUy65VE/F/RskTDTMVmS/pFajZEb9ZgUwiczyoN59mkLBxlHG+rujb/7?=
 =?us-ascii?Q?wVnQ5khJlCrWBcxethl3xi3y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MGXkUGmGN1ZhPjSx0bEFdr8N2Tlb6kG6oe2gRKUSBWKc3U0rn8D5ZwXGWZWF?=
 =?us-ascii?Q?bK2C7HufJ4lPQ0ElmObfgw+pYjf6UPDMhK251nZzv/ftgvEMtIvyyxJP3xIG?=
 =?us-ascii?Q?30z6/vnqV6wkArTOQ5aNZ/6AjtVw6CmS8Vk9L5AuhszmbKMIKPc9uxzJUCxn?=
 =?us-ascii?Q?vxs5//y+mPoVz9YR5EmQqY+dUpw66NjeJaG99I4WEHw5aJX38B/dvBSPlhNA?=
 =?us-ascii?Q?qsXlgV62B1jEZFsbEev3fX3SKYI9mNcJFGl5bzc4YZy85gF3nxqb8AxsWlMh?=
 =?us-ascii?Q?Vyqfp3oujLQfIUmG9eJaNa4FZxYqSwBjxk2/oalIGdQQpytRS44IeVaTcpk4?=
 =?us-ascii?Q?/CRBLWMa3n3lyFwCNGQNvZS/cMtaDDFbsEZM6mInSkAyIdBI3M9qxIktghA1?=
 =?us-ascii?Q?ynMPD4IQykYsIvKlGMfojdCf8+1KCo2VVzDwebHwEevNPbsWuXE4hQfdLiTc?=
 =?us-ascii?Q?DXMh8Ck7iViiY3RP2HheFRVkadUh7JXdFmZrN0w5yw2/Ps73v9Z4lVHuLrC1?=
 =?us-ascii?Q?2WOHWkuAySu1xpoqx0p2k7URbeVqggQciC3uBH+fcHUE2KVvz6a8jbms1PlU?=
 =?us-ascii?Q?7/HLxOntML4Bip7KSyuu8NoNsCZmcwxS28IfbNHmWRPrY75ZTqmWm8tbFhYU?=
 =?us-ascii?Q?dN6W8Ua2RoIA6ERD7iA25Wz3cOcoNQxkzAXQSRE57egJp4ORz5TNEj2ev/bl?=
 =?us-ascii?Q?oiCgxsuiLnlyu1kVpE7f+6XlUAYRkt/SMp5D8+50i9nSyF2J9En51BB2cqUR?=
 =?us-ascii?Q?VbMNH4AYu/zW9kTBFhr+0l83/MIl6BPAaz2tNw1LsR7jp3CKqtrTsRdQAHDM?=
 =?us-ascii?Q?Nnult1sqjvVGFSECrjPAuBJVjmlDkjni9u0b7aODzsYuAFXi02zB39GUsIo0?=
 =?us-ascii?Q?M+pW/m2/pD7JhFoyHW8tzhZZfxfIwi4UG2CGYUxjHKxBoe3mooE7+ygjaYHY?=
 =?us-ascii?Q?CGBHGYJD9i6uYW4gpbiEyZ98uBgXa4qoKkrZ3SWFAS2u8EOKumiLaFjCGwpA?=
 =?us-ascii?Q?0TaAG1Fjh8KrXXitiPA+KDk8wjAr06yjL/XfB/p2r/+0NqNnmJmBDB2/13lS?=
 =?us-ascii?Q?svy6/jUjCvryap3joFfowQyVAejpxW5899NNNFDP2dZh7YO9jApTdnvf1W/O?=
 =?us-ascii?Q?bMiJCcy1w/w+5A9FAEJG/QzTn/UiowoHY3TECaEQUGX2ZFxIa6fbVd+Agbkh?=
 =?us-ascii?Q?jx5s33Khm/gLlajSFK3S6jhFs4oJgD4EUaogOhaf0eVIMSktEKWkTnwqg4z0?=
 =?us-ascii?Q?LNXulkuROTx79PlqN7CtAezv2XdyM+XDmnUFzaSBFBFIe4tzFEi2/7Dn+o4C?=
 =?us-ascii?Q?ducjUF/Wyfid8pMKnkwSXMlIyZkXGNwfw1Pfw4aPyx8buI6FbN0y0wtBxwB6?=
 =?us-ascii?Q?bNabeOgK4ikf2NDJClGA160mETDMxP2Q9epMuRkx8GMgP+g5A/MeLgHxWhLp?=
 =?us-ascii?Q?aaEJpdkz9FXF8676+nUlX3IGAI7J+o7LyTGFYRUrmIDfUTI3XCo68TBKGIWX?=
 =?us-ascii?Q?n6Is9Nk8LKz/vy8020f4P8UlWcEMT75p16+Aj/1I2cz6MDogLjA+exvfi4+m?=
 =?us-ascii?Q?wVArFJTGVgUfKFdppdJMVgBbHHiU8Q0iOPwaj0Pg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa1658c-6d95-453d-2db7-08dc8998d763
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 22:01:12.2565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzJwMHo5JDWZQMMu5BoRXR0mqH9hrdkdeefUqpsx/62lP+uuEjAzUBss5OhINfzJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549

On Mon, Jun 10, 2024 at 01:01:32PM -0700, Nicolin Chen wrote:
> On Mon, Jun 10, 2024 at 09:04:46AM -0300, Jason Gunthorpe wrote:
> > On Fri, Jun 07, 2024 at 02:19:21PM -0700, Nicolin Chen wrote:
> > 
> > > > IOTLB efficiency will suffer though when splitting 1p -> 2v while
> > > > invalidation performance will suffer when joining 2p -> 1v.
> > > 
> > > I think the invalidation efficiency is actually solvable. So,
> > > basically viommu_invalidate would receive a whole batch of cmds
> > > and dispatch them to different pSMMUs (nested_domains/devices).
> > > We already have a vdev_id table for devices, yet we just need a
> > > new vasid table for nested_domains. Right?
> > 
> > You can't know the ASID usage of the hypervisor from the VM, unless
> > you also inspect the CD table memory in the guest. That seems like
> > something we should try hard to avoid.
> 
> Actually, even now as we put a dispatcher in VMM, VMM still does
> decode the CD table to link ASID to s1_hwpt. Otherwise, it could
> only broadcast a TLBI cmd to all pSMMUs.

No, there should be no CD table decoding and no linking ASID to
anything by the VMM.

The ARM architecture is clean, the ASID can remain private to the VM,
there is no reason for the VMM to understand it.

The s1_hwpt is derived only from the vSTE and nothing more. It would
be fine for all the devices to have their own s1_hwpts with their own
vSTE's inside it.

> > > With that being said, it would make the kernel design a bit more
> > > complicated. And the VMM still has to separate the commands for
> > > passthrough devices (HW iotlb) from commands for emulated devices
> > > (emulated iotlb), unless we further split the topology at the VM
> > > level to have a dedicated vSMMU for all passthrough devices --
> > > then VMM could just forward its entire cmdq to the kernel without
> > > deciphering every command (likely?).
> > 
> > I would not include the emulated devices in a shared SMMU.. For the
> > same reason, we should try hard to avoid inspecting the page table
> > memory.
> 
> I wouldn't like the idea of attaching emulated devices to a shared
> vSMMU. Yet, mind elaborating why this would inspect the page table
> memory? Or do you mean we should avoid VMM inspecting user tables?

Emulated devices can't use the HW page table walker in the SMMU since
they won't get a clean CD linkage they can use. They have to manually
walk the page tables and convert them into an IOAS. It is a big PITA,
best to be avoided.

> > If a viommu is needed for emulated then virtio-iommu may be more
> > appropriate..
> > 
> > That said I'm sure someone will want to do this, so as long as it is
> > possible in the VMM, as slow as it may be, then it is fine.
> 
> Eric hasn't replied my previous query regarding how to design this,
> yet I guess the same. And looks like Intel is doing so for emulated
> devices, since there is only one intel_iommu instance in a VM.

Yes, Intel has long has this code to build VFIO containers from page
table walks.

Jason
