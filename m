Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872A143888
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723675132; cv=fail; b=pnsBy0whZ6POVoEdbkNYmFHG4A/bdnm2bh/p1yImjpnZ19atsc9pmZZp3W5hb5EVzWtzZ78JeQVJVhF86D9N2tvFXKPZ9aKhupU/ijafGKcbFfrTug5YUo7HZ/AbempKc8muG/sxyWUYdDsp0JFFtBvV0bzWEf58o3prbUzOdKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723675132; c=relaxed/simple;
	bh=YsiEqxXmesr/KxxnvlVPTkR77+NYoxpTCwBIdKrrew8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nOh2bLtikKGilk2lo5zPJzCm04Ty7jbE3mePoeT3Z3RroPYmN6b+/2dSoen5+cY60aw0fztJmHH+4C/gVlnDU4pz+m6gZUvPeUbGYFiOr08jK5hU0Xm/OTFckgUAx7Wdd+L8ZD3fE8UxttCHA3suzuGDJRTeW+/RufpYTrfe0J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ndTsc9uR; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ndTsc9uR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqwiN2daqHOT25VcsujOKwLW2dj9vxpSgtmqtFtJZaEgqM8CH3R53A9A6chm4vVRIBqfQS2zwhTBE77zAorSw9rTRwj/KEK7fRd0A8HX7LQIQ8kow1IkOuw9LWWlaIuBvB8k2ISS+HjqRBcrdnPSRd4ds8ZdgjNg+miaB1fmpRdYeBSrFPRDvDPQks0cK5yRyVjVta4iICNrouMEynh8o14KI8/YmW7jKPKIaI9pQqK0WXgnuGrk61xRnJTLVM2DfvFkRZebS9GLTtTMIuK6gaCPthkyUkLJo8xIGXUj+R3M040/Y/fQuwk3T8q0TJRNCWKNp/qw0ZkEMGPKakth2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYsXQwXzswzosJswxJN9EHTzh2KK7I3j3ZlBLXVlnFg=;
 b=UHpkW5IRn7xWG1JMYjb7qcGGvGRwUhnopqcz1mucfZGuu5VQHlod0+Pdip/akVd1jcDgVVy/hrJjee9kqZXFBrMkDX3bppf/5+0jeizmYCN6PTaCQ6tqRVd0lHJwnzhPARMTffzlGQB7jlJxJh/xV3PfzB1yqVTduLYlK0YV8SDySGE0lP/urOJINgKtydBaUEihs5X7a+xpIs4YxTKk0h4Xi7oEK6ZuDxZKVbikeyoLdEq8mSNCy/BJaDp6tTkAd0Wlcb2BQQRTc2n3yk01MWH8wsVIixivadeN2APvbw2/MIU9/GtiEUxi1HkrxeAKcCdoamz33AeVuwLa1a9A/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYsXQwXzswzosJswxJN9EHTzh2KK7I3j3ZlBLXVlnFg=;
 b=ndTsc9uR29v1K+3TNrKJtx/YoFkIJm3ucWl3XgizZj+Dso+8qTTNYca2prY72nYv4gurr3Fx4V/xl4G/l7FRZzpaxSv5KWafi0Bu7LLgDeshyPlHlSZME/SVyXRPioxN02HdLc7am54VxLyCfMzwpabecB9oXg98AEwyZ9SAR791G16D1Fy2yZU28C5ziUkHdokSDuGOGbgBagFhdIoJhGT9SpV/ziDH/tV1o2oVvlLxMIr0R+dKb7XRePXduac8Psxfgs/upocGB8ON6g2u/p4JXDpxLWuCl7rZK/neYJZ1zGwQWMC5XVn1hvGvawX/F4g0V87+zTSeyZsRQUekXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 22:38:44 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 22:38:44 +0000
Date: Wed, 14 Aug 2024 19:38:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iommufd/device: Enforce reserved IOVA also when
 attached to hwpt_nested
Message-ID: <20240814223843.GA3972912@nvidia.com>
References: <20240807003446.3740368-1-nicolinc@nvidia.com>
 <BN9PR11MB52762AD4E68BC0FC10CACBE18CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZrZ6sBbDK5gJtbB8@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrZ6sBbDK5gJtbB8@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR0102CA0010.prod.exchangelabs.com
 (2603:10b6:207:18::23) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: c45e242d-fa76-4216-0b81-08dcbcb1daa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EE+dU+h6LQNLEcdSNu3MviFBoq1A4mHPH3JJgDOPv7NQVV71YSDlmwYEG/DH?=
 =?us-ascii?Q?DXpdNp9SGL3WWC9CyedCbt+K5blPRx4l1h0jBs291J7pUtSWDqRRAWYmUy5f?=
 =?us-ascii?Q?pvNiUBEM4foTy5bdus6uNSjgMLTmG/v4FiEI307H8k7rwGnSVb/EjzHwAuzL?=
 =?us-ascii?Q?8JqwWUFuVxHEk4NWP4WU75oyeUJZ2Ko8rZgzYT8skKtIzLwvrgIZUi6CCV2k?=
 =?us-ascii?Q?TOStsyAKPxPYe+OFoBBkIY9MI8m6mYMba19nKjrxvO6p/BtkBPlXuPmxGX0L?=
 =?us-ascii?Q?/RiW66eYMAjKcW3XWVhZRQXA0a6GXYCJoaqhD9vLX9QWDdhMdwScsovb+tF3?=
 =?us-ascii?Q?1J3b7i6xH3R1/NB9Sj8o2wVcjWrxz/LAyHV+6MzJDS73ilpC6Hfoi4eMZSEP?=
 =?us-ascii?Q?9mnCVDGw9+jQyuuFGeD4CJuNxeojesg4OQ14wyKBvS8/vSkySTApAE5XMWH/?=
 =?us-ascii?Q?TBssi9rnj0XYmT+FVTeapata2H7shJ1a9Rg36kF2iIkNH6IWeExpmUstg7K4?=
 =?us-ascii?Q?quj/sUVOT+sqR6R7twIKsMt64w2vxptBZ/T6EnW2VWpUhRi++p/aV37W1PmT?=
 =?us-ascii?Q?GDKcYq5jOTkbyBdzqAW+8PxdUy7VT3YRTb914ljIaique5pJcJruwDNBXe3r?=
 =?us-ascii?Q?fgE2eLWmIVNbkpPlpxhIepI25j7JjgXYBjD1lUGDZN+zRTNEypHBj4hC8C1Y?=
 =?us-ascii?Q?VNF/HD63bUCJ9LsG6fgAEZhJ6MdGbpoNaNmFhaLvDBtUlMDGKOOw9DLDmB0k?=
 =?us-ascii?Q?QAUUS2zih8y9dyy8uZW0Q35mYmzY6qjzUFVNIIMWTFIA26TuodpiPcCpWn2w?=
 =?us-ascii?Q?0TDJOHBEIwreV0g1LHZ5lQ0V9WY7i6MIe2Gi01ccS2qT0Rc10KsbJo/dhDSF?=
 =?us-ascii?Q?t1XeCCSr+UxDmwDCF8C3n+vR0gKRSzWjuGle12DI1t9Qh1FjLroylDzyTXHC?=
 =?us-ascii?Q?dA+LmN3eIT5zC/G+cgglvRad92Rx2yLdWSKAvH3ja8CwFoyLAqimC2FLRcQ6?=
 =?us-ascii?Q?3iFHGH8cjJzbdM/gnEmYUD0BN3rFU9CIrP0AX3I29/8xRy3YBL0mYZKm+dJ9?=
 =?us-ascii?Q?x527EzxknHCGx/6bE7A4zWENp43XUrtP79dRINBB8kuPPJKCavm6oD0Z0Nuk?=
 =?us-ascii?Q?M1O4Ph0MwyCv8vCrERo78TihStwu45x/cW9mTpV5+HrbvHJCc48GiCCpw+ZI?=
 =?us-ascii?Q?INHWogvMhfy3RV3sRlnhKk7TYqireKkEUB0BiL0LC8Una72kC8VswM6d30at?=
 =?us-ascii?Q?2Q/sSLenxIju8U92M0DQGNoM7suQDUdHggW5DfVkCDJJdX+1zFqA4Y/Xrj88?=
 =?us-ascii?Q?PXd/r+wGsboAbsbUsmtAUmAlYkd8axk24/8DFICMrj7Re6yp+5FJf2etsFn9?=
 =?us-ascii?Q?Vd+/xXI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QrQjBUpXSeuUyOVO4bSJZHZHPpXxqrbNydAqfDy45w208+W1Isgmwc0XukeY?=
 =?us-ascii?Q?jYsdwDvNLZ31qp8xJPS0iMMVCQjKF9/Lff1lyL9sv8np3RBNvuS/B7ftgK0X?=
 =?us-ascii?Q?u5V8EurMxxTLelXf8tf/ulSocCFAYtfgFTtrB3OLRjyg7mmSd8wU8RObSVB/?=
 =?us-ascii?Q?DttKZwtB+0kpxH2Sc8nhvanw58e46hrUzvrZjDbq3GtNGerxt1zKVqw071sq?=
 =?us-ascii?Q?3z14B25Qzlgdg5ilWrfmkMEVQqW61B4FFblolMv2VQkKwvZ/bP5b6C4Px4kC?=
 =?us-ascii?Q?UKN0A5RqRVKjCKxDWaVxXD08AHcnnRtItWPdVw+IamZ52H7Q74vUd4SlBGNn?=
 =?us-ascii?Q?jdL/b6PFPHykYWUk7OaqMul0O2YwZW0mGOovULvZt146DDmSGj794hDLxgMD?=
 =?us-ascii?Q?4R2VJO0mlj61RgvLc6MCkqOP+hemuONWALC7f471RS8Tx/4eaE8hkzwhB+h+?=
 =?us-ascii?Q?SNokoNIWN+UE9jGkRSgf0qSeFPYVnahCQ4qlbq+dUPnyGGpEepxqnM3Z1Yh5?=
 =?us-ascii?Q?59mhhvRtGd5raPFg+eObgmnw8Z72mMzWlRMmT6l+L3Y8W2u3aA+aKx9paeIy?=
 =?us-ascii?Q?i+Vg9dKCC/G1szf9OJDeuIRo/KuvklIx1eMVqpTDXviANzm+a2RT6BKzikxx?=
 =?us-ascii?Q?cFxiCdciSFg8NV5lhP+zd4lTgDReVPpLKKdQVJ2Pg29hBmjl2biVAeISUchB?=
 =?us-ascii?Q?Burf+Y5+baGtIgxAVlnqSr/4CtbNh1OcemVoGAEpn0IHneaPw6o8Ht2kuX2m?=
 =?us-ascii?Q?Ivnzn+GZf5W/lzliBlyrAKPz4giR63d4rx6hjRikQI0IMjb5puH4Mj6rOVnj?=
 =?us-ascii?Q?NF31WoNeIJ3tAj86NJQj4pnKfnneRPXjeoAOfukw4RCF6fRzoJ0AclEYUpBy?=
 =?us-ascii?Q?MB9YfGxuQl0um5Y7CGfJljTyOuzf4m9VV41+YIar4GOqaOGg1xEkf6R7ArAc?=
 =?us-ascii?Q?WimFb8Eg4X7rDaPnOPVwgIbR9lZsGJ58NXEZj2DxivOAfuLHIJm2UafraABE?=
 =?us-ascii?Q?zrGWKS7QJzRvVdH1tbtbn8p2AcDuaM8s58uxMTCYj41Jk8H/63PrR5RXt2uM?=
 =?us-ascii?Q?Hl94HdkroDbKVQWQX9JIyVrCPNUzzwFU7ZuQwVc4jh3dkubeMtPvX8DjfCT5?=
 =?us-ascii?Q?QoakH3RPi9Dmi5XB1prkLfCOXmh7wcNf/FKLyhut/1fQQJuGSKCYL63b0395?=
 =?us-ascii?Q?Rk7LAPMN0eAWtoc0ngNsR8fJ8Kh/kkAGnmf7VvHyJ4POT7yShq04gtcdf4sL?=
 =?us-ascii?Q?FG3ojLuBIgoTktYJIpkoAlYLNsf4HlJgBnU3YWEGG7/3D54dJwz3J6seAtCE?=
 =?us-ascii?Q?/AJJCNhRYQxwE3num2yAa3/RkkBhZQRD3No0DdswieOpanbCeYU+iz2hGnTo?=
 =?us-ascii?Q?Yz33EUm77x7ajJBR7eCDFDrd/E8a3IkiPQjCCNxxDshENvWbjp7+MYV16wyF?=
 =?us-ascii?Q?9JDOQrnbuFerbBcSPJuhTtXPin8Uo+ELuMbTN4rFvsjMaAqr5oOxcU42wHB1?=
 =?us-ascii?Q?98YJkjZQkB8fZ1SmZV3UeJr8a7g8zp+jZypbvcA4daDUyZxze2xsX2vjyiax?=
 =?us-ascii?Q?qQ/zRsKimrrjvedUUyk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45e242d-fa76-4216-0b81-08dcbcb1daa2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 22:38:44.4426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+LVE2Ne0IJtSHnwZoGS9OugEUsqOMMSQXoPlvgKamGQAcOkHrlr+SuIOCKik6FY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973

On Fri, Aug 09, 2024 at 01:23:12PM -0700, Nicolin Chen wrote:
> On Fri, Aug 09, 2024 at 02:00:10AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, August 7, 2024 8:35 AM
> > >
> > > Currently, device reserved regions are only enforced when the device is
> > > attached to an hwpt_paging. In other words, if the device gets attached
> > > to an hwpt_nested directly, the parent hwpt_paging of the hwpt_nested's
> > > would not enforce those reserved IOVAs. This works for most of reserved
> > > region types, but not for IOMMU_RESV_SW_MSI, which is a unique software
> > > defined window, required by a nesting case too to setup an MSI doorbell
> > > on the parent stage-2 hwpt/domain.
> > >
> > > Kevin pointed out that:
> > > 1) there is no usage using up closely the entire IOVA space yet,
> > > 2) guest may change the viommu mode to switch between nested
> > >    and paging then VMM has to take all devices' reserved regions
> > >    into consideration anyway, when composing the GPA space.
> > > Link:
> > > https://lore.kernel.org/all/BN9PR11MB5276497781C96415272E6FED8CB12@
> > > BN9PR11MB5276.namprd11.prod.outlook.com/
> > >
> > > So it would be actually convenient for us to also enforce reserved IOVA
> > > onto the parent hwpt_paging, when attaching a device to an hwpt_nested.
> > >
> > > Repurpose the existing attach/replace_paging helpers to attach device's
> > > reserved IOVAs exclusively.
> > >
> > > Add a new find_hwpt_paging helper, which is only used by these reserved
> > > IOVA functions, to allow an IOMMUFD_OBJ_HWPT_NESTED hwpt to redirect
> > > to
> > > its parent hwpt_paging. Return a NULL in these two helpers for any new
> > > HWPT type in the future.
> > >
> > > Suggested-by: Tian, Kevin <kevin.tian@intel.com>
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > 
> > I'm not sure the name find_hwpt_paging() is good enough but can't
> > find a better alternative. So,
> > 
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> Thanks for the review. I couldn't figure out a better name but
> that :)
> 
> With the ongoing discussion with Robin at the other thread, we
> we might be able to get rid of the msi_cookie. If so, this one
> will be unnecessary. So, we might want to put this on hold?

Regardless this seems like a bug fix to me that we may as well
take. Unless we intend to retire the entire RESV_SW mechanism it
should work correctly.

When you say "enforce" you mean both that the reserved region list
reported to userspace does not include the region and that the
required mapping was never installed in the parent?

Jason
