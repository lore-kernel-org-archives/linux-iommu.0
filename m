Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B4219A
	for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736862339; cv=fail; b=dDp0MT+xbyYNnyRo1SONpAXGxzVW+5kZP0jTrkam3PW2RnFliTpnSZ8wyl66qdYhqvZQG+L3hiaLc8GydCOPKpn8Qyr5v5AuL7t8tVN6AOcD4yDkxnz/ms15F5t8E0f56WaUIkcLpcPsTFG8qa35zxa0G6BUU/mi0D0GwJjzOUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736862339; c=relaxed/simple;
	bh=Q/6Z9ljiz0OiexcZb0ECXnPj/48mwUTCppFV20uHsS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LVVN3kHJh8xBNr9HALPbJMkraeb1O6KFVVIPGpeiD/bpWNwN4/RIUrrbNQGbehOSYXVHL+eNjFjTc+QOdEJMLEm3rl//6N3Fh7iifVrJz3QGZDKpTjFYsnNJ39s4iHUs5vipWtAVNTtvDiCE+KT6jWqCbd6P62MmDhYCuFnJMfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ae0gR1nV; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ae0gR1nV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIq/vWj8fmYPWx7xv68MLtvfbqS4pwY0VBXOZY+2CTmVYyNPFbFF5k/wQszZiDH4XFQ7A9mnaq2WIeNZPfAA4jIKZnsw1qM168cdEtWJ96jurmDDa66u0H1xcw0m6KGIxWHhL2oaDhT7BZaWgxHbmanuQFE/ohwHSQ0dWS/6qnjnWLUUs1huZrE3IgeIEhLaSXolv2KiXOT7Hkr/x2DJQN1nIcrf4rSPW6ENqVHdVUQ8hpmPcFOJju7tTMIbFEPTWKfccDgJRKo0LdEaG5er7HtMTcc4HTcLIce928sJ2F2yIyOOogqbTOdN2crLi+q6lrQO2q8PvgjvxehVAFW+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQuTTuXV6jXBu6c+jx1+8AfeNjlNjQsZA0oCR9HA0sQ=;
 b=p/zJnRpBMK27I0PoOppoJsWelgy1S7k8iTRlHOpUSLrSOEgPaGFTunMpVbMd8apmIkNJcMkzqLm7qeoTbvy8miNeheU1I8/jEqdddeBzTsaTuE5yrTwUJfvmGWBsoL4hNyA4NmWNoCGftdkCPPKYmnvezji+1lvT8xm14sQY1Q/12rUYPSuPlZv/rtm3EMmMYfxRlqVqSL6K4dFPXQE37UA6+KQwBNyGGlJM7agQzBD6vPz1NSb7+1ZJMgJaChSDKke+8CicTwfQGxFBgoFRKfsg2OJG4cKV01Bsy9TeHNSaxmhrXWRhtgajdxFeh91RK7xDb7uf/AUtn4xLFudz6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQuTTuXV6jXBu6c+jx1+8AfeNjlNjQsZA0oCR9HA0sQ=;
 b=Ae0gR1nVzaYJgnpORI8/7iTbNmGyJRXKCMsbM6IXwrhBwSMMYjvlP1kmvZztiklufuljrWDrhY35LZMnNWEQULCoxqJqAin0Mk9Kiny4UFn33Zn+GBnKx2QyTV9a1pLAWHZMAWmCIWvt0/ZoL+o2nBywZoGmNlKYFoQli9MhWY23rYEH3QWRxz1EzrMuA7fyVspaQmfHNRNAMKpUUJ9WVFn1yVXnQPQeZGMFRLuPKJfWfnbGucggd4kRbSc472stPTWM6iKQIXF6Kg+lRbkzunRo+8XfrB1wpeV7/aErbj8cQ07pgxlZaNlycdKnWgEbaFpF7QI8vengh9TUubzDOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 13:45:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 13:45:32 +0000
Date: Tue, 14 Jan 2025 09:45:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Message-ID: <20250114134530.GD5556@nvidia.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-2-yi.l.liu@intel.com>
 <20250113202134.GX5556@nvidia.com>
 <BN9PR11MB5276A7F34F2B4206AF4233228C182@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A7F34F2B4206AF4233228C182@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN1PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:408:e0::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 86497b48-cb41-4754-58c3-08dd34a1b6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8nI+hwJcqqtGAVfIrp5SL8NGfmj8MaeJuLBoUFVnqfSt1gyhLwlAo9saU7QA?=
 =?us-ascii?Q?JfCFX4iIcWCuSEwNn/U+LutAJ32xJMQuRYdDTC70YO0W/7yB74d1htIahqi1?=
 =?us-ascii?Q?Au1dpUDlqUmo3ZUgEvpnHUkWjietLEDsfaH3PLFy3oMt7hTDj0i0nPQBI8xV?=
 =?us-ascii?Q?vot3ux7y6VfUoJS8R30/NSIGQvW3HKr0kp7Sgsl9oocI2hZUuTsLwg3IG+z7?=
 =?us-ascii?Q?G8gczIPEhOJopejm3GJ1bFzP662UJxXpI4MN2MkBzkMeq0CUxE3q5RReb1DQ?=
 =?us-ascii?Q?39glsGJmCIFqixqMyWD5PpgdLZQ86i2WVYUe/MzqX0mXr+FA6ob+tjhqhFq/?=
 =?us-ascii?Q?Ntrt3G2fhie1mlhRgW06DhYtCPpzcp16NhVi1/jKh2xBW+VhYHG14guyzjj9?=
 =?us-ascii?Q?GKbkV6EHE9XknazEatDnaLIPIMg2NTNXYsZvyE4c5VaSMrThTEYTExM0t40a?=
 =?us-ascii?Q?heZ77tVEcamiVnKCMkF/2tgUdzr/WrlGn4Yw7rVE0i+YpENqaZZDnuNrDbAp?=
 =?us-ascii?Q?jkM0rSGe1sIuLrjqPVItUpLaqHxkNYNSk+FIY2POkSBqcuZzuSbKzw0MsDWo?=
 =?us-ascii?Q?CqKOuFWawqrH2An9up6wt4ByAPzkPDCe5dn0tPOLTQn+8MOwYHbXyT1FmSOF?=
 =?us-ascii?Q?6kuejYYErFTjjUy7WVJzBLDrWO2wo7CkRZy9MwXGiA32EkmATWxJ6KZkWWpl?=
 =?us-ascii?Q?PPF6IpGp/MlN+7UQ7pmFd+esspuBG+Y5kT2yeKtbONilT+cvD5dM3AFJ0R9v?=
 =?us-ascii?Q?dL7MHnYYftdfUis1rzQmZQwW3zKUz76A62fn+fo5cdo4oZ6yQA0zBb8WQh2u?=
 =?us-ascii?Q?aZ3oJBVhZO9ieR0rG5h9NjXQXsskzDemsOhuFNT6PSszrT1Sdtu2SgPv4vOK?=
 =?us-ascii?Q?XhtUTVEfoowJekfgjD7uwSVg53JWBusixJsIz8fWappp+XhGGPgjhQp6ou/8?=
 =?us-ascii?Q?9mfJ4Q4jplrjnYrizsK9y1iUOCKGCQbO2qCDs+ZspSiwVg/+Ct5j4YUocN2Q?=
 =?us-ascii?Q?HLnSWBtDMOwpSfiq6prDURXEa7YPfexcslpWTTLKlBYFdKLyzLJkXUweEmPQ?=
 =?us-ascii?Q?4+a65i9/tL/DVqgAUZ+s4e3L9MzwXcoZoBzfLZgGFLsEN8n/LUEYXAPCRrWK?=
 =?us-ascii?Q?ieAgyioN6VxoTGjynJ3EqD9VqBmFeK85X1qnZx5FJdZcHnaWOp87sb7J0jbC?=
 =?us-ascii?Q?dgN6EMFnjp2aFLH3DoGriWHwbNXgGsy/3OhQHxvZyKCJJLrr9b9OLnSmc6mR?=
 =?us-ascii?Q?L2OB6fVLHlGSF0ZXDF7k607tWxOXcD5qiGs+dcoDZ9iZy41t6wG7tg2W089u?=
 =?us-ascii?Q?rT30B75Ipp8EsDaBg9zz3HTUA8nWoLf/vOWCxCbASag4ANsmkIt4+2EBU9nv?=
 =?us-ascii?Q?nsOPN1kZ5ylFlv7sq74bZkAzUytl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZzAwLUe2yQKcowz8fgMwrO/dNzQviQD2YgsSrBbMG2G2+nisW47QOuIQsHVk?=
 =?us-ascii?Q?XdCQIBmJUHTBTSdjG3omrezYtdV49e7npQQK7RHLWxTGDLDkMQ+oYZHCk4aW?=
 =?us-ascii?Q?Lo2zMzUVVkaa3iznRK8bIn8zGaoi3hXuKJGoCQxkZPwCJ/AVUaMxSw1ocf4L?=
 =?us-ascii?Q?r1lIE5YjjcUKhkrNkpOTmHzf3XgUngGtX0C/ToSzVGR1XIasaHz0BZwQdLBE?=
 =?us-ascii?Q?vPDRhhhGmk3xqMnb5z20C7/faF5HQ9oQZfWRZQGVjERKg01UKrH+3OdvvEIJ?=
 =?us-ascii?Q?QZXiQAm1DtImDThAQ0Qp/7R3mDgSkW0MFMz8DKHM+UXa6wOiBYFUtXaePqK/?=
 =?us-ascii?Q?hSrX89/OxS0LAjjPo75I/RLKo1sOvnxTOWkwtgBlubfo0jMYgB5TYgYbaj+e?=
 =?us-ascii?Q?4ONnG5ZXH+kJn4LMFxD7JVdUUY4s9YfpVZQ6A7O28BFgwV5xau84x8aPeG51?=
 =?us-ascii?Q?wLqTj/yu/OoudYG5UeH4kK/4im1vAnnqJIqJmC3t+7msazpi6Sq0Up3xK34R?=
 =?us-ascii?Q?NxG0vUBlCtUUdp0neLfZfN2sVVihgwblVTGHVbGHt6rWRz0JFlw2aAdu41WX?=
 =?us-ascii?Q?S3S276sA6cvWIqQee1dtXUeT+U8d6cxkFbn++N5Q5t83l7tAdZN9jpiVpzHG?=
 =?us-ascii?Q?Lvr408pEksSTHXTJm2777YAQy5xds0uDKb/cjuMKa0d2eo6yC5YGPqvfE6mj?=
 =?us-ascii?Q?J8S9qtND56MzoSqMeKLgrXgieSMvzs6I4/GE2GUvUd2EURqscV/Wybh8x02h?=
 =?us-ascii?Q?EncXnooRHaL8S8ZbkuJy8vUM80SIleSl2LNydG0gty7qiKIgH/srYgVzctbz?=
 =?us-ascii?Q?goCgTKeMC2bST3l5Ml3IdMmfBEOsM2eH9Db4KhyvtIqoFsk/fryQqTmajA4N?=
 =?us-ascii?Q?baMuA+tCkEvtlFsRDiw2KTHY8TnG0x0jZuPAyv79kpTA/U18PORNSC0kBPwz?=
 =?us-ascii?Q?xTiPVOKqvXFJUddirwq0nTC4gurFw5FmeeKdBWF2HbPh8g77EVIvytcdvwre?=
 =?us-ascii?Q?xlIy/dzg1FA/ccEYnLodm587qIW9pN1Eo+t6gAUMRH87WkIaAibgZGH7nrSy?=
 =?us-ascii?Q?xN5nU9WtqrV6yZZBDefMpbYvokVaXYP9LYqKdw+GaxL8dTTVRmNoMjGZsfbQ?=
 =?us-ascii?Q?7jYRicThvIA7uH/V6Pcv//MPay7qBFSuP9Q0z9sHxQsrFvURa/esDzVJ1vut?=
 =?us-ascii?Q?MzGzLJcP4C9Tb5ciSof+W+IRO4w6oUUhNMVcA0muBP7Z6BBkfbKkq1DxYiSw?=
 =?us-ascii?Q?+zly17EKfidU0b4XujeCbTzq61+AGm/LcSVOdEsrOns5uGTPZz2FtnNyhI9n?=
 =?us-ascii?Q?8NxKrICXT4ucYwsC8R0gxYh9xs7jZbpP3E9P4NRT6yUIvdz3PWWDLrnDmjhV?=
 =?us-ascii?Q?aQIfWw5zi39QxFsMKeyPgU8LT8CFhYXKXeHz+cWipZTaHDO5MMyvLY1Ce3nI?=
 =?us-ascii?Q?/aIrX+bpgQgx8JQl+nwODwO8cDF/IAjc77fizJM8jF+ZQSGHNdKKSsk1B/Q1?=
 =?us-ascii?Q?U1wSP2IlhXDbMyYdKXOq5Ht8rrmWDji5L23NLKI562IA3B3l+5kWdl92Z4h9?=
 =?us-ascii?Q?GMhANA1xHDIXwu/328OW4vU5/NUS/ZJ04JMC6kBF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86497b48-cb41-4754-58c3-08dd34a1b6d5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:45:32.0190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNVxD27kQAZx39yJrpTBK3fpDyUAmYOWCy1mFghbTLhTQdXNllMNMxC8Px3Rv7bG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716

On Tue, Jan 14, 2025 at 08:10:41AM +0000, Tian, Kevin wrote:

> > > +	ret = __iommu_set_group_pasid(domain, group, pasid, curr-
> > >domain);
> > > +	if (ret)
> > > +		WARN_ON(handle != xa_store(&group->pasid_array, pasid,
> > > +					   curr, GFP_KERNEL));
> > 
> > I wonder about the ordering here, is it OK to have PRIs being
> > delivered to a domain that failed to attach? What cleans up that race
> > condition with domain free?
> > 
> > Should we replace the domain then set the xarray? (and same ordering
> > question for normal attach)
> 
> That makes sense to me.
> 
> But I don't think there is a problem with attach. xa_insert() will
> return error if an entry already exists. So there won't be any
> PRI being delivered at __iommu_set_group_pasid(), no matter
> it succeeds or not.

It has the same issue:

	ret = xa_insert(&group->pasid_array, pasid, handle, GFP_KERNEL);
	if (ret)
		goto out_unlock;

	ret = __iommu_set_group_pasid(domain, group, pasid);
        .. Concurrently a PRI event is pushed to the domain ..
	if (ret)
		xa_erase(&group->pasid_array, pasid);

        .. Now what? Who fences the PRI event thread before the caller
	   frees the domain ..?

We arranged things so that detatch would fence the PRI, if detach is
not called then there is no fence..

Jason
