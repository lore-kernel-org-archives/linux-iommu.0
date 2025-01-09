Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223A0219E8F
	for <iommu@lists.linux.dev>; Thu,  9 Jan 2025 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433803; cv=fail; b=TOJcomNN+ON8bwPFx5I8fJfvufjLWUrB9rHmLSS1qB1dqMWS7N8EPxzpBlQqy6xPYHQToQH4FW9j5ECsnyzXDuKrgtiEL8ayt8oxdHqPypG56dZzCxfMhZNd/jl88dks2QNevovJljBCxnHQMpzExXUtXx64ROPyCbnrV6kXnHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433803; c=relaxed/simple;
	bh=hAybE9svC4hRMOg/XtGlfEF9z5BYNT2u6SY4SaAHTGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jJ//HS5YxsCOTMrcjgUK9JLfngdY/Rtyl+78uh2U++czr5fNlKEmbkC7DvAbNEBkQ8qfP+/gKiMCqKvh7cc5HAzKhZyMV10apfJiZAzGnIeA+lsccpRxBzlbb44e6sg+vrX5XS7+9LWnBikoPpxf1tIKx5VFm0jXhyFfFb0AZuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=quVMqcST; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="quVMqcST"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSALW3CJhqEUv0LNg9B38+z+QIT7/tri/wmLiNQGeW1cHS4+d8Uf/lraPUOLZb83t8zdFzrpR6ab6L7mvwQWM6JHS8+cJ97EA5hRlYgozReUNpjxVNFpu1hblaUGldnnOygvSN6ZKh6dTPPe6jWreO7d7tCU+nLOB4GBhCRjxa0PAIjJ7qG44Pt/RJk+lDusw3oE4eXc8y6wIv6dWAMsl0b+IcVqz9LYbgwSkqwqqt9IY6VBzhjIzm9VaonNxzh7V+NDzAdX72q5zHPdsDoAwX/X8kZpd+47ckqBvstrz2dIsuGTqigE+d76QZIojCiYlqYyaTzhHk+jO4KUdvzZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfcN2GGJVorMHoYmeaEqXM6OaWb8w/kCNqn7bvOwzjw=;
 b=CaqUX+waxUE3li6RaSTZlOg4fRHdBoqiLx5djhCOdkKhKH7gxi8i8fTb/uuR9eumV4ugFyGRs3BmRn/vEMTzQbei5RxqawQUtue2cfUvxOkzWio+QoBkczAN8p88oRxlD2BaBeyd7e3nF33l0RuxycuWQjLZQmdgL7YFvvSLR45f6PkotZJa+tv7UqevSSs3Fu7ILVyoPkOvEtAwpvxxFWaxBkfFfOmiInpTF11kuGoZ8kN8REbiiDDt2SnhhWE4vCEh/a7CvHT/fyWulLMHQEOLJWPavqnPzPl+h2lawlTA9cTTg2YGB5orodggZCT8fBpDmtH6ol/EavYWpEAylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfcN2GGJVorMHoYmeaEqXM6OaWb8w/kCNqn7bvOwzjw=;
 b=quVMqcSTOQU2ayYAJdZ9ovSS4lhUsPW4EWCZ/SAbX2iZN6x7A/z7CKB21wf0eO7ufCPGNpLFDqMJur5vURP7kFz6nAPyVySbritg33oS0VQgFRva2P8LzQsOhR+16WuwIpYe+IhTqWq81cUnW47S8TgEwRqmpE4zaCsyXbPyAJ3/H82u8nw9j2ZiAUEXaaUm4kp0vBAqzIym+lVqGCtgaWWJMOmx5+Jp54MQ/miqEQKDsY+9Eyz2Cmbpc4JTiThzFlwP2vqZU+yZGmBSNiEIvR6QvW5hwOOwbNgrnaeCOz/0Sz7PakSv9PO//IIvIJwps/1mEEdQugP1LWBGz6V3yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 14:43:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Thu, 9 Jan 2025
 14:43:17 +0000
Date: Thu, 9 Jan 2025 10:43:15 -0400
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
Message-ID: <20250109144315.GY5556@nvidia.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-2-yi.l.liu@intel.com>
 <BN9PR11MB527699DB033F2B192DC120EE8C132@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527699DB033F2B192DC120EE8C132@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:208:d4::40) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca801c1-13ea-4e27-5328-08dd30bbf439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X/ydSjZON+Q88X+p3kajLS68FGDw5QlFIKD5l8dLZNATLW1v3CNtM0j1keqM?=
 =?us-ascii?Q?MoL9bFGxmlGTQnGnsbPmHXXAJc3xeiMvsXXimsTVdnSxx+AnQ2JMbMmCDP/u?=
 =?us-ascii?Q?yY7WatZZDhegg8KlzpArxvLZ4TTd19zYEz6+m/sIm+ggZ+bDcrYwDtWesP17?=
 =?us-ascii?Q?Hyi+VW21ncg5GNUJ50QZa3boYZpJVgGD8JomZV9/t3RRSD31R7NoZC+okTMM?=
 =?us-ascii?Q?3AIRss+aYgAUm0Cc1NqAYPg1MTpRkvpwBu3C30Ew8JL5i5vlTmy+twyNIO+q?=
 =?us-ascii?Q?DWPoPb9sA2iDl+Q5TvBIdKSRu22KWz27O7nOxWzsKXq32/m3dqpDSuc3Rm3T?=
 =?us-ascii?Q?8Awdmhsr+GRVyZlbCfq/EdGhuqZdEitn8j6ZygQh5DzpmfW4o0cKsQ/f77Sx?=
 =?us-ascii?Q?vYglqbsVRzum9jEnbkGgw78RRxxaIWMbX7StUy6WT6BKvCQnv0gHL+ndJvi/?=
 =?us-ascii?Q?iASsbInAAmFLnB/eU/CPNB1ayxv0dcSHJEPmGXc+y0b5z04Pv/gI3/EefI5h?=
 =?us-ascii?Q?/Ep0/vfSZ/UNwOSdywyi3h1xdNJWS2JeCGBQ1pKA0eTuWNXPyOJHeChNpVqX?=
 =?us-ascii?Q?g7lsWbS8gBs5KcfnujsptwosihvNOxwV5z7Kyu2o+xWFXY81trAAcOCPi6j6?=
 =?us-ascii?Q?4xJSGBaYdl/u6rxb02g5u/ivfLUhJq2/F5k0kmrdi/TXsMBGtNxteTthl6Ft?=
 =?us-ascii?Q?BoiDPcywMXUISkBneB1rcix4cC9OdGfoo8b8brffN5vAfZaTzesCb38e0kkP?=
 =?us-ascii?Q?AsvxtKSEgtNFsIzTr+bnXPHOu+PhTSlJpAdnYJGgP2TfbRuIRfhFRl56jJx4?=
 =?us-ascii?Q?u9rUlW3Zw51J7cJfFGLtB39cB+U+ADpGNyAq1m2auR+3c6DZKfiHThuUh5hi?=
 =?us-ascii?Q?TVQmhbvlGgUJBYDulrII0xxmKXgdwoLCTz2Fmmpk/6usweD6MIalOYxRrP+6?=
 =?us-ascii?Q?S9G+Zocje0fzFTU+PoYiPoFwelqvedAbtvdXgABPgldOx3f0U5DVrIB1yPdX?=
 =?us-ascii?Q?pC7Fuqx6As8uNclv/0GDtrdATh8RKOoWiXKzgtb//d0EZwrCykq+/oLaJcz5?=
 =?us-ascii?Q?H/3WLqa6qiZmUIiDgKpiwpirAjOVrLGBPH1LuW9oIjBp5x08Qwap3ZMY/HKd?=
 =?us-ascii?Q?mvMEVMAK46TMpgNr6FeU1INrF5CUvQ9DE3lVIxQTec42mLpL1eEZUeii6pwj?=
 =?us-ascii?Q?pwbWMcBOfTeDXoksZxZ6Ldd5JMdkSWUnTpALmi3x+ZzbCWSHzKQ6DWnqHwhQ?=
 =?us-ascii?Q?jW9KBFcomuz0uEiQ7SqwwC7dKaoZxJMItZVRwvNGCWyZ9z75+q+AllsE8hgI?=
 =?us-ascii?Q?T1ezWX/7pLJ8CcTR5gkkR3blUIM6aKKLqrHlx/3EicgF5TlucFj5sfkDjnCi?=
 =?us-ascii?Q?/nuBl35GtxbDjz6ppsSxY70qbkY+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rxeJphpgOz3jLd1/9qQnKK3WMqsVP34FK9MkLS50pYLGWy5JCojkt/iolYxP?=
 =?us-ascii?Q?6K5cETc6RHK+AAILLic2DMQwTNH46nDN3HYrSwj8xvckhgBGRXWcRPl4NcMv?=
 =?us-ascii?Q?4eJOeTQ+ucIynU0toXz4hdTT1DDRNFfNiZpDsu2EoJNG1fJ0wYeFR1CJtgNw?=
 =?us-ascii?Q?Nvt01vgQ17dB+UPtyN2umtUu9EkpbtP3IkUKlGrmKMa3OLTVS1+6huBikkJy?=
 =?us-ascii?Q?7wyxBBjbwsotiyzoEdNvAY6FNoiZxfMT3rNWmOWd3B3PyqZ4bIP1bqKeyzSm?=
 =?us-ascii?Q?RJIYX/atT7R1clQUKCGdrkZxAb4+YIsm+A/dy+a9WJYkvI3pjDflbvZR25+D?=
 =?us-ascii?Q?wGiWswf5YxTNK8OhhA468ROZgI/rohBzanSTSwUAwGU4CrIFy02tB/RHq/On?=
 =?us-ascii?Q?FwcxGHLjtJt9n2xC6Uy8Ui7CZcRRaCp3ivBu7dCE7vL77pZd9uGpzJtqS9Pq?=
 =?us-ascii?Q?u8/FTnm2DlcE+r8Y0PlQSCGbKoJ+93aGvihd3gybe1G4wKJ5BR9Zi+3cOs2W?=
 =?us-ascii?Q?tfiKz3ud1Ub4NtU+RtN538djBppwK53aI++KkzIsr4f4PQvN2ElEiYUEf/OM?=
 =?us-ascii?Q?6+IrxMsauqUoyEnBKoT2wvLn10pmQ7I6FSH3MaCWGjgoVwpjpOB9OrIJnU60?=
 =?us-ascii?Q?3EDwW40/4Y6VcOtL4ooiyRPXDlMu20mO+e21BfB+DiFkSgVeBN+zgcMldXkU?=
 =?us-ascii?Q?PsRtFfIXRpDcRf+WgX/29A2/utXwNBFQLn3JnCEfSb0r5mba3/t7Ko5mNDZZ?=
 =?us-ascii?Q?hT0DWH8iw9qAKoeESF/r9fpQyFP/jqfYmfoCuTqSZfCY830Mf7tPRRovauQs?=
 =?us-ascii?Q?jS+uJ61n/Tf7kXgodbWtUD4DuFFOarR615ONmLc+Z9I09UQpOdD/ZXPjFEN2?=
 =?us-ascii?Q?gWKEGHoBd9kIULNUa+Y7LyKvAmrfByb9tqOx3Ri9rtgqU5Lb2eqPGL4jfSCi?=
 =?us-ascii?Q?yoX6YmGMYnvtqLC8MlcObdFbm2jGMvkHpMZRuOEBlAOUypraWng9XdU6R5rt?=
 =?us-ascii?Q?C1rwJfxx9mESbiN+Jm0zPgI/lHlPnOMRzmxWuoPT3xU1KwA+5hG6WuqVA2+X?=
 =?us-ascii?Q?hYpbA5PXOfmpRI0IXlRcwNuqT4DlcB1kFc0HKQjf02PFysKT4qfoTxHuznPL?=
 =?us-ascii?Q?JXOnZkEaaCFy1rRY0VT8gelnAZKEabcJkdjoQH9AUPKHwQ4Y85dZcnhD6hEx?=
 =?us-ascii?Q?pi57VqPvnVR1Y9rfGu6VqGrO0+T+IJqG/XjZm6aw9ntuGNPFqw8jETc9s3An?=
 =?us-ascii?Q?3yYxgZQCTYuWm2VZZG9kEa5dB8oQPYKRGWCi6GJYsq+lsjZpU/sweRkmddtZ?=
 =?us-ascii?Q?YwUemg0KFowQ3aEXN2jTmS/E6w+IfIK056FmgVlo9emil5bWBu4xCIZUSNAu?=
 =?us-ascii?Q?Si6rS2+earvbiEeszSPtBfeGtI6BoOfHR7hWY70KwLCPeXIgjyvHwcpwKxm8?=
 =?us-ascii?Q?E/7Q+JEcZnAjcoJI6ftg+h34AqW5H4eK9xuheH+0qcJLjehC9DdQY6ENmqcs?=
 =?us-ascii?Q?BofekMxJ2H6pfPOagHKAuDol8FZhYXKF7pyXnfuMAf32tmSyGhXD68eYqU6L?=
 =?us-ascii?Q?bZSabPe5jAZLxuAOg26Vk1tyCJPxxreOovMz4b+S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca801c1-13ea-4e27-5328-08dd30bbf439
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 14:43:17.2073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8GohWNAQTWFBUXFxS2/Q1suD/pnV9yqGdi4dRhC9jRNErV5FY8olAQ6XvuxhzEx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7992

On Thu, Jan 09, 2025 at 07:20:01AM +0000, Tian, Kevin wrote:
> > From: Tian, Kevin
> > Sent: Thursday, January 9, 2025 3:08 PM
> > 
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Thursday, December 19, 2024 9:28 PM
> > >
> > > +/**
> > > + * iommu_replace_device_pasid - Replace the domain that a pasid is
> > > attached to
> > > + * @domain: the new iommu domain
> > > + * @dev: the attached device.
> > > + * @pasid: the pasid of the device.
> > > + * @handle: the attach handle.
> > > + *
> > > + * This API allows the pasid to switch domains. Return 0 on success, or an
> > > + * error. The pasid will keep the old configuration if replacement failed.
> > > + * This is supposed to be used by iommufd, and iommufd can guarantee
> > > that
> > > + * both iommu_attach_device_pasid() and iommu_replace_device_pasid()
> > > would
> > > + * pass in a valid @handle.
> > > + */
> > 
> > Better explain why a valid handle is required here.
> 
> Okay, it's because __iommu_set_group_pasid() requires the old domain now
> and the only way to retrieve it at this point is via a handle. It's probably also
> ok to directly store a domain pointer to the xarray when the handle is missing
> but that sounds more confusing.

I had shared a xarray approach to do that at one point, it apparently
was scary enough nobody picked it up :)

https://lore.kernel.org/linux-iommu/20240322165927.GG66976@ziepe.ca/

Jason
