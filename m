Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B81F2369
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024132; cv=fail; b=fcxkazRlMaqjZMOuA57Ph7EeYEgEZgSUCAQVnvd19B69oyp21p/DG/QZW8iX7ClD2A43ApfYTR8z5RnK3/TjRaAUt5rfIuV29iT/ZnWI9eLxze3U7YpShhLeOZ1qjpwCviulMXsguY4eEVT0qFdzolCGcHhg1PjpjykLzTR0XSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024132; c=relaxed/simple;
	bh=2AuvGtFV1WuNEGQpjWI43lm2xE1ldEuGPX8PiuuPZV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ieih1FtVUOIOgqCfNIR5+Z/gtv2ObTRLiutiG7miAV/oN4qUNaOz6fQwJJbqbp+RW2QX3vvNjLE0xEom5UMz0w3txT/iUmEm+ZZGNh5RjmnPCCSfC2ZkYyrSU2dug8BFBjh0Q+5oyGZoRjFAnc+Q+VQnOYH7m+HT/dDwGS1jW4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M6ii1kaR; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M6ii1kaR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kI1DfvxWj39rGK/Y5hiGhYAo/prJmKnMoB0IMXOMTbBk+zfSIJ4Iqb5/7hdNXCNSg8fkPFghT7SUxFqDZXMksx0dmGkPdjffz23bER4bJdNAvdQl9ZGj6QrhJkDGeac5oz+7VgCgwQhsUyxuzx8Np6JkpZviujoXedNPNDpfl3uIbzOemjuh6qE9+t63neSx4GY9k38Cvcq6sVh5zXngzNz1w8s7OX+eWGvQpi1iIwIu8d8CGvCw1ZIFfkMOEUOFUc1uD8V85gpM/5f13tlxAsyiH5DbY0hZpB9UgTP0+u0fM10/8lTV212dGZD2gdthHnhry1iiK2the7zWtBeNAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUd8ji6CZ1j63bOqRzCas/RHO2ZwRlIHPD2NJHATB38=;
 b=ppyLzLflH8ud3E+itU80UvEnVCDKJu5ClFQHu7pW3AouuByuq0S0qCcOfo7Kj+SDOtJLV9g0fhg4O4IRqB/5Ggk1NPz3r38mJadQe1Qz0tcaPwXqi0M+hypztR48jYu9Lx3DpsDCaTO5BBAPeJrw4QrCDJOPI9RXxxFilRADwi7GudMJtF3LUBjAyHQMjbcLi/D7t3TQzMmm4FHtd4CyDxuSR54VD0FVfTS6O9JLR9l9RUO6Xfc1vek+bN2T0nab2Wz3L720P9OGs+qzrXv47OTgF1LBOIU83kHermUsUZKfxA73KbbtzDaC9eXFp/yg8dvmxwZLFBQuTkY+zK60JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUd8ji6CZ1j63bOqRzCas/RHO2ZwRlIHPD2NJHATB38=;
 b=M6ii1kaRBnIdBBcTfZ3opetHs/ezd64I38R4D9BOJTTD1xqxoq3Y2QbvEkrgYWw3K9daRu7+Nsts2OiUJZ3rOAfMn1tnDuM/5G0lEe/XXc5pYurAqy/kO7QS6NBejhE1668L4JRHN+c9D+IZMNXmvwfBXMPVSMN++ZUKMALJwFCMr7+RWJHBEOvB8uyUy/gC3js7eXrbld16nUeyD8mHkkZ9uBU9r5Pi3lxCQnuS8a+AfzEF+Kx+MLjC6ahI+r9gdvnkiaNSSQVTy2lQRbtkHAQzQj1IjQtcBR1Byxee5sCCD5or8mffQOneb90rvzQfG1OaXh0W4sdzgAC5lRr20w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7333.namprd12.prod.outlook.com (2603:10b6:303:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 17:48:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 17:48:46 +0000
Date: Mon, 3 Mar 2025 13:48:45 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v8 06/12] iommufd: Support pasid attach/replace
Message-ID: <20250303174845.GD133783@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-7-yi.l.liu@intel.com>
 <20250228153252.GZ39591@nvidia.com>
 <ee4bdb1a-66e1-4d27-b7d3-f5dc1bc4e12b@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee4bdb1a-66e1-4d27-b7d3-f5dc1bc4e12b@intel.com>
X-ClientProxiedBy: BN0PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:408:e8::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 6491ccd4-6ce5-48fd-89cc-08dd5a7ba5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q1izQ+scQNMO6ecmgiSmjRf5mkflo69jB79dcRZdL34P89O9W3b3HDObL6GS?=
 =?us-ascii?Q?bIU+CEKN27LvLFhV3DjTqAmLEAYvVNvDq7C7iSYXQhtMiAOYtsGWbQKBtq2a?=
 =?us-ascii?Q?rBqVBxkeiTOBJFUusvxuoi+NrXPjDJZmxY4UdW1aczfCdX/zuStqlunyVuUM?=
 =?us-ascii?Q?AnZQAG6+Wx/xEcQv5YJ5OS8zKxijuWfGo7oz5BxBIJXXybeCb9927YHsex1w?=
 =?us-ascii?Q?FjDYWfVHQKrhsImcLedkwhWASxZqec0hwCIHblrINPF9ROvxnmZIRQWxM0+r?=
 =?us-ascii?Q?PUPnc/podi3mdcKiLNZzdrCmPAQ6H4RuBovyJ3lExqBJkRlgWTuAvGCCYOl5?=
 =?us-ascii?Q?pFNE5srWJpfn1cQyrt3wBXn8/HsWNVvZn295cxWbI3bVz8SaSBrH9Xh/L4xx?=
 =?us-ascii?Q?3EFoBFNQxN+H2IXjCmyKw5Y/q0BdTADE/zziweCxthfXqvjXx7BG/X8WXy4x?=
 =?us-ascii?Q?JnZRRtfi7MVJIafpUPq8baiiMX3sPP1vDOjyGvOmacXWBFv++QzRycqCgiv+?=
 =?us-ascii?Q?DGWueFZFiaiErHx3zxBzZfOu8lGql7bWsIsxAF9SZJVb1Tj2AIgd86XvG1d7?=
 =?us-ascii?Q?8n/62Yyc3x+uy9u6tDFUlP6kBRI5sr7q9xcWe8vdLpSYfCh2z+xKQRfAF8Xr?=
 =?us-ascii?Q?4Kv3+Fyg1+yYXBOEGbedNX5VnZ4VaPCyteb82uFtO/+uk4zWG2tY1JYFLiL7?=
 =?us-ascii?Q?MSg0s6P7N/QTgk+ySBwOhXy+3PwHw561U1m81xUvSmdgUeLH3ZOAC295gAFQ?=
 =?us-ascii?Q?M5lGpcez9w8WRmLeRebybJCnSP8rJU41t8eJs/VSrmoSl/AcpxDi4y1xg24X?=
 =?us-ascii?Q?ltb+QYhsAN22DL0SFwghBvFx6WeH1Oo7V5iiiZTo+CVBuwRhz194EA7Gqpt2?=
 =?us-ascii?Q?31ZIgJKef4dQ1ixpaETCzm+WemIBASp4XOL2p3RLm387HHfESj262vqA2Uhv?=
 =?us-ascii?Q?cCePKCdTJxyaIWc5cE2X6Nb2r71Df+qpK0AxOqFNi66xOo9jwZz9lcDBU41k?=
 =?us-ascii?Q?0to7qrtsY6ijEzHThZW++KR4GYeiNJygpWeOY9NIxEdN9lg8a4Yd+OvSvrZ/?=
 =?us-ascii?Q?rNOJENIUEwDVxMr/KX54qvd3nsDIlpT2UkMy4rXYiMfDtW6e+GnKZHC5eik3?=
 =?us-ascii?Q?mrFgq5riLzw4YBe4pCUmWO8nOeYfzQzgB5jNnlGcAFiqaZ0OwON3xoom6Pyz?=
 =?us-ascii?Q?fYZjLYkF5TUPt6mtHuWGSKyVwd1+u/FuqPdh7n9KECHQhVHE+HwD5BjVr5W8?=
 =?us-ascii?Q?3Kopd80l/nTrtF/gwqi1dSxcfP0W6PVm0kGFkCb7g+itXN9R6xZ2+wNXdfoa?=
 =?us-ascii?Q?yQScZrLf9PSlmLYdmU3dWcAlLCH0sxsKl4t3yr9+0qqcGlZ5gtp+d6NsVPLn?=
 =?us-ascii?Q?ZaQBpeLrBBWuN/NSl1aCr1UvZ+N7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z87VT7UyBh/2Dbjn2p+EinIB7JDUmCJDZdlL7eYmiBs+CsHYj+DkxZGOFTCm?=
 =?us-ascii?Q?6VJa9hV77ECguJRPXXBz4CPlBbrzOeIycpT6+xas1GYcKVKdqh0X+4k2DZvx?=
 =?us-ascii?Q?MasAAAbP4raQMEThlDuTAEDh5P5PSYC4QmhRdedPhhTuQcaRMly5F7Dc+bcU?=
 =?us-ascii?Q?tWICGIABVZslAFFO1mzEK9iofCkxwd77Ym+SvF2mA1C2vdjMSDCjKKS62aXU?=
 =?us-ascii?Q?cK15pMCnH4OR2u0jLujur8IGxQJuVZX+uXdGAFI0TJ7vBCpt+MJuVfWoiV7X?=
 =?us-ascii?Q?vC4/Esnd301aBGWOrfYSBbwheaauGrfwuWizE025mumVyjMseRUGTmIJevWf?=
 =?us-ascii?Q?WuQOi779VDcTpnBY/1pTek3b5o4TdfOg23VlgkgHfQMtO2GmXlaGzmLQ1roX?=
 =?us-ascii?Q?cKzKgRFAI69UMg6d848qw+Uis92utqQzGSB3uzk+s/c7pHqSYMmi8KAig4jy?=
 =?us-ascii?Q?HA5fjxxdN8Xz5UyBs5CGCafHfft5GCuW93+AeY/XV5lj8Jr6zbBG3NiejGHo?=
 =?us-ascii?Q?NfCKAHoUGhAa0k7oZyjcm1DVZ5C/bKQ/vD//V9jkyQSS+2DQvIJ/uSxdBV67?=
 =?us-ascii?Q?M0yBRlYPTnntoBz108qjUK820HprpVUnfBZ6sm90GtM7QXGyvxhgyQt7q174?=
 =?us-ascii?Q?4QYfYi+oIcLFM1+0GPdswCfh5+bQ4qb07n5W/LWQgGi79D7t54tN0YqH1KGS?=
 =?us-ascii?Q?0n2RoAVH6FTpEb5/Wyk42iWINkrkJSTlXww7rCs4Kp9RO8RTag5Z2sTu6pLD?=
 =?us-ascii?Q?p8ToMIi0HkI2G4sWpv2n2E/a75aSmDnEpzgrCCecbvRxHPJ7yKRphLyFd/7B?=
 =?us-ascii?Q?DIfmiEWUhfFibbpRvyd28jDN+VseB51myNy4cXwvIKYj0dvB9Wl8DVlca3r2?=
 =?us-ascii?Q?1s+TKvtqqQHtpXwgJ0WhZHr8mOOJiOoNiy8VnJqgdyydO2OQZnocevVd0m2/?=
 =?us-ascii?Q?2mJ0vpur1I2hRpJ7Kimy6T9E2ovDOTQpDWMbmEqtATDr6TuEpfjaH45c4r1/?=
 =?us-ascii?Q?cCKRP1OsZk//EhzOWeeg4kUSq5d4iKkDhneeNOFtKq+vw5NpfN9gbvI3gvQQ?=
 =?us-ascii?Q?ec/pxRs7T7q/IwwLgVEgOoyX99iH1QCBEfQNfja2W8iUeTe+XvHtXUK0eIZY?=
 =?us-ascii?Q?Vrr27QPTHhgWr35Ih67Q3mRwFF+WXK/hRsZhUzoO2FYIU+Yo4S3k8er2qv1A?=
 =?us-ascii?Q?7Lwuq4JTOC8uGSAZIHxg9I5BaQzPF2/BoalmiAL/RTvXJsAI/G/anaPDyd0n?=
 =?us-ascii?Q?5GlhNjIZRBVGuowKvttahkAUF+kNevNUSr2VRMzb2jFus7SMugxGB8ckT9BX?=
 =?us-ascii?Q?trBUoYZDMw64/RR8TNpIpvC602xykNC9sofIGPHB3cR3KVpilBYSXshITIDy?=
 =?us-ascii?Q?8rBnkEVLC/WH9s4OkoWJQQVY8snxDmdPcUbHhfC1c44OL8K0QFWGByhxyRRt?=
 =?us-ascii?Q?inBMxbf9wIwY9LSKJk8M+AdfDuZyTdFDlcZ67YRfT4P01LlvgYYdfhQCEIVb?=
 =?us-ascii?Q?UdKbV64RgU8UhYwFSx8lgSbLPQkriDFKZnCianTkC59ZAiLbiYfwnK5zMcrn?=
 =?us-ascii?Q?T9IgM0nogcGakaEvbEh7ow4OZwRz+P3AYUWdEu/l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6491ccd4-6ce5-48fd-89cc-08dd5a7ba5da
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:48:46.8537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dS2hStyoI7Mxlq6sjuCNFC41kvSS1TGYuQzGW+1sSG4S7gkbEj1ioLC41yQuGoQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333

On Sat, Mar 01, 2025 at 07:44:26PM +0800, Yi Liu wrote:
> On 2025/2/28 23:32, Jason Gunthorpe wrote:
> > On Wed, Feb 26, 2025 at 03:40:26AM -0800, Yi Liu wrote:
> > > This introduces three APIs for device drivers to manage pasid attach/
> > > replace/detach.
> > > 
> > >      int iommufd_device_pasid_attach(struct iommufd_device *idev,
> > > 				    ioasid_t pasid, u32 *pt_id);
> > >      int iommufd_device_pasid_replace(struct iommufd_device *idev,
> > > 				     ioasid_t pasid, u32 *pt_id);
> > >      void iommufd_device_pasid_detach(struct iommufd_device *idev,
> > > 				     ioasid_t pasid);
> > > 
> > > The pasid operations share underlying attach/replace/detach infrastructure
> > > with the device operations, but still have some different implications:
> > 
> > You don't want to just add a PASID to the existing APIs and keep with
> > PASID=0 means no pasid?
> 
> do you mean extending the iommufd_device_attach/detach/replace() APIs to
> support a @pasid? Sounds ok to me. VFIO side reuses ioctl for rid attach
> and pasid attach as well.

Yes

> > > @@ -136,6 +136,7 @@ void iommufd_device_destroy(struct iommufd_object *obj)
> > >   	struct iommufd_device *idev =
> > >   		container_of(obj, struct iommufd_device, obj);
> > > +	WARN_ON(!xa_empty(&idev->pasid_hwpts));
> > 
> > Should this be in the igroup? That's what the core code does, so some
> > of the protections you have here won't match the core's version if we
> > ever see a multi-device pasid capable group.
> 
> conceptually, yes. But I had an impression that pasid is only supported on
> singleton groups. Seems this does not stand since the SVA path dropped the
> device count in below commit. If so, indeed iommufd should add pasid_array
> per igroup.

I would keep it per igroup to match the code, even though we do expect
singleton groups.

> https://lore.kernel.org/linux-iommu/20221031005917.45690-10-baolu.lu@linux.intel.com/

PASID support is limited to single device groups directly currently,
so the SVA stuff was duplicate.

> > > +	mutex_lock(&idev->igroup->lock);
> > > +	curr = xa_cmpxchg(&idev->pasid_hwpts, pasid, NULL, hwpt, GFP_KERNEL);
> > > +	if (curr) {
> > 
> > I guess you could do the same trick you wanted in the core where the
> > xarray in the group stores the normal domain too, then I think these
> > special functions just go away since the xa tests are folded into the
> > normal functions in place of their normal domain tests?
> 
> do you mean storing the igroup->hwpt in the xarray?

Yes

That would be appealing if it avoids all the code duplication

Jason 
