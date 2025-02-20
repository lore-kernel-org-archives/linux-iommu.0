Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46BC1DF265
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068301; cv=fail; b=WXXgWm5hkg47xWKTMN/HTwG8S+CL5jeuK9dOWBigeFSxUU27Wc4WZ669XfXT+J2G9+janxw/fIi2gcDd/ljC3Nn+yfhW+u79jaePjVFoaPcOvdK3BG9QIhszrk9gJTh+Jc9DHDcPZbeJl1b/Zt1p7x85K6gZEaXpms4VMEaIxkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068301; c=relaxed/simple;
	bh=rOAtp+CfEwtWd8jclv7nx+d75rATEY/erg0YF1ytFxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rKdQq2xnNZiD0/D42cOMYbCTVPMZTe1RjsTKT0V2TTeWUhsiVh8Mdu//RRnZn1aoA5AexmghJ8IPqMI4cT31feIkF0CFqyPmDiqWy+PSokEepMr6VZnlq+InK3RyYuLuhLfGP8sk63W48VHqSThYsb3HnRv9YJNrVLuWo1q7VN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YJbbtO+k; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YJbbtO+k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nh291KQ8Ic3AcETpFyUAOtUHCxcm0J7xtymUZ1rm68Mc9tkKzVN4QuTEON8+815NZuCcn8T/R6lE0OGCh2F1Pl2OB7TOU2pZcMJz95CVLnxhQAobDGRZfbpHnW3Z/rD2+63dHY45JJ/6X8vdGTxS4w2gcR3RxqBRh5eEjHsmyccBzCOzrgFQzTvlERzKFCvDGBbGgYkQmUPeZnccQSdn54NCEV8HJklqixuL53FZ00UxXCS9aM7p77IpFK1yOYwQiBz5Bw2iGxl59Pl8EY0Tj4ZnVxxsx716j830w90AW9nhS5Vq+Y9p3xNNfPIYHLJPKQ3lIOZTwjPeHac/uaGpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGGogIrzLAoC6UuTlLdhgYym3/DBrF0iN4fR4SKg6KI=;
 b=HvK7zL/i5qS55WQvY4i5k6n9jVsTLuEMOa8wLEZzSyGGk9q8NmCvoLq64NzxdBfHbDGh1sfb7plgW1lR85amkZ8n0mN+eDC9swyXYJijcgMd5Lhy3Ul9/dlVbLRlhdaG8TacZmXwSGlOCkGuPvi5X5bUq8D8USPpKoSQhbiXeqoDPvhxuwAt571d/23j8ofM1A1NyNNwvC55us8yY6yBaMfje/Nb+95HV4wwlKy3PkQT3A6wRoDHIwZDT9IoXhH3voJgR0rorrk4Z2a1weaDuovqWq7s701JkoLzOOJ0jRAiywJNAmuc+cpLlj7IeUO0JGOtyALKfCI9ObiE9o+aTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGGogIrzLAoC6UuTlLdhgYym3/DBrF0iN4fR4SKg6KI=;
 b=YJbbtO+kaIhCouLdl/P/ZUz0pVM26DISFr0XTxcq8HHEJl+WXZAf00oFdwpk3RPCnHNg7uWIndxfpCDwLlpnPs6ak0rBXOLiaycf1jQB3o1IDYDeVWlzXlFm02SbzmYsMWTUtlPw3x9IeFqFUXqO1NzLAieiAxUqOgqnwvHJT7oaAlZT3slyARr9qV7ZsW7hsKyQwYgAYQqCRAjB4wQ6tVjh56p0y8i++iNOsJ3gh5YU0V4bmd2T5qsm7k/niE/fsJnQNEb3iz2SWmIpSnT0oJ/pb1pxF8fQuLLvK3EpWVVODXzOtzNajnqAvy22I8+9lrmxUkaZDyEsAkp9cAKj2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 16:18:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 16:18:15 +0000
Date: Thu, 20 Feb 2025 12:18:14 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, robin.murphy@arm.com, nicolinc@nvidia.com,
	will@kernel.org
Subject: Re: [PATCH 5/5] iommu: Retire group->domain
Message-ID: <20250220161814.GC50639@nvidia.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-6-yi.l.liu@intel.com>
 <20250218193909.GF4183890@nvidia.com>
 <1df9b532-1b42-40da-8499-503f53ba8998@intel.com>
 <7a6bd064-afec-4492-b703-f076c50d41b1@intel.com>
 <20250219131054.GL4183890@nvidia.com>
 <a72d2d49-a3e8-4da4-8a2a-355c0fc03df0@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a72d2d49-a3e8-4da4-8a2a-355c0fc03df0@intel.com>
X-ClientProxiedBy: BN9PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:408:fd::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e27169-6b30-4a93-ebf8-08dd51ca2e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cEI7cZHX/S2MRWooPrpZ+u9xqVjwJbk3Lys8X/yZIZVMS1RQPcYWW5yNUJfK?=
 =?us-ascii?Q?K/7170yKug3ewyPEQYCO2M6TcSaEOmmm21GJu8AZD/a4jGNLds/BdzB2wH+Q?=
 =?us-ascii?Q?L4lsXMijFe0UdpnNgHx8lYxSbgYvsZDo07u3+1RZscFiHHJ7rSD5B46YeIhE?=
 =?us-ascii?Q?9AZ+m+b+6Owb41Y3zOJkYVF3sUx7aTNojdYeU8sWA9fgcGz4EXVGV3Pl369Q?=
 =?us-ascii?Q?mkc7J3tQLy/0yINt+v/poP9tNWP/hq1oSkTX7gPZGujr6zkHkeYErZSRzs2I?=
 =?us-ascii?Q?zMuZMV1tR8QsgfBLrgfXJ8QMepCzogF/8xKh8KbOXIXdmNV2+PceoUXTaQnl?=
 =?us-ascii?Q?PAaHuoNVSk2TR6jSfloLMoZgzvP/S6ABH4STeikhLrY3ueNh0cTrJto+g/tb?=
 =?us-ascii?Q?A6w20pSUbAc+FR2WBMJsZwsM7ys9VfKKEp+H10uP/91RExtNdcYZnnn6b6em?=
 =?us-ascii?Q?NG3fk2UbrkA8S+Uexq90HXenAHFv7rXzLWyScnOZlFO7LO+g1mw2AsgC5v78?=
 =?us-ascii?Q?p3ZCN6Ro9mvISFQJXFaehfhTeIv8yafDXRxCgFVzvCut+dJb8lgwx8RDFjm3?=
 =?us-ascii?Q?ap8q5Rgy+8engozfLvSzwiaL020mzJBoxnwtBsh7JGhvGonNRcZkWxd2uGpZ?=
 =?us-ascii?Q?X7ld3JEscDQndf4hD4K8/onJWsPuXEF9vITWi60EAbAnIJSQZ2Lrwn41qjap?=
 =?us-ascii?Q?42SgnO+ufLFKIml/QwORn8BeJS96vXJkYrZ7sThnCHb2HtThksb5XZAh+bSF?=
 =?us-ascii?Q?R21pK99ZAjXEHhPqiZz9JXOY4erWkiXxAZ9/mVVk4QHHdXSRr4ZGS/xwXSbC?=
 =?us-ascii?Q?kp7tpcD4WY2skjvCdnz8/GT4ejJ19muvNLsWRhyccGSCxuKVU+VCuu5aYxde?=
 =?us-ascii?Q?r0v2otPbHhp93n/LUyMLZuPWtkcGtndoGY9rpscfquxlgnTIvXmJD4QgZ+C8?=
 =?us-ascii?Q?Ydsuc7oOx965f82t9qvNEPbB6J5NehPSNwLJBDBFwC/Nt3AdTTTQ31JAxMCL?=
 =?us-ascii?Q?WdL/qJ6UZ8gLzvqjNkErpgzE5hCSewNbIwPF/3+k6MTXdHQI1J3WwhuLaDcj?=
 =?us-ascii?Q?QoNBouq3j+7fcOfYWLLRMMB7T5A6Vr4Fw0CaPqRJ/QlRFvRCv61sWOEjwWN4?=
 =?us-ascii?Q?0fi0EqB8eRAwttJr7W+569m+lUhR1Wr1r9Pv6AipJHYoGio6VHsI7d9TPgF2?=
 =?us-ascii?Q?Po9JqtuEjdBmnHbUTXc3Xt2S/+2TxDDIOC2VuNupBmgMknrlb0MYWklbXdqc?=
 =?us-ascii?Q?I+z6cxcxp2eKohZPlhnXYIDO6nDL8DLDxsXe4kz9XtVgsLZ4qWAGNMVaZzSZ?=
 =?us-ascii?Q?IGmxlpeFYr3essn+yyps+InmTgDWkyxVekNPH1zY+HNaFUaqc8w6xfsZFSwZ?=
 =?us-ascii?Q?vouvB0s8uvC0t3DJGaP/6EAVesfY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aqccj0b9zKBg+AqzbF7jDPe1ZU+7n0vDIlWcyJzzSsw1/feoYlD9O+Cd3YFE?=
 =?us-ascii?Q?bm+AnXOYJbvDTH0yIp/bAp+rjmpywnWLs3pDYtLrch7B8+7nNYjfa+R/QTBp?=
 =?us-ascii?Q?aFOrViUCgM4zXAzlcs+LkyiYVEj28lKfIENHiNFpSo1o3GRSwCjYQomUX2wY?=
 =?us-ascii?Q?T3IwQLbU7Q6S61PMA6vnYNKdsFyJs41bMdY4KsPCird+zebcGEq/9Nr3FSr5?=
 =?us-ascii?Q?A8dF4dlK8OGAJREDyYkgHnVn/cLsHb3xb2mUfdyQopql0GiAFajGO6kRZzQA?=
 =?us-ascii?Q?1Kpqi9A/DEL6i9dA4Gs27CIKE+u5zlrx7yVUB2jiMlhqLKQ1IPldir6jb+cb?=
 =?us-ascii?Q?4kFsCCdYHN+Uo4cY7uCPmA8ey7f72LzW/rtVcwADPxFqd0s7/RoJWZcfOgyl?=
 =?us-ascii?Q?ER1/5uhKeRPMPaMFxSVfBz8bd0HDgKlzfU80OUysqKykExRU9EAdDiqLCQcD?=
 =?us-ascii?Q?GAwa4b1a1GzmXUbcMfCGCVbh/ATiMkH1u/TMChoSf7VyKkzQaQieEvfxGyzZ?=
 =?us-ascii?Q?4KZWf6vNj+x5e9jMl1YlDE34B8TYXi6Ojsw4rC/AEQubm34kB/owSYwtVZ6Z?=
 =?us-ascii?Q?4Fi3ZvuewCM7G3YcxB3lv5hWYJljoHiEy9nRuEQq0k+YkyT/dd4Td6zapfhv?=
 =?us-ascii?Q?5Co0z3J2HDXIrfVRjbP/kYsNKEmh2ZdkDl0iu3BoqUDJbKsKneIbmuUIjdWn?=
 =?us-ascii?Q?yCb/QnkBLVekflsdMBtXx+t2NKoGXcEUGkkv1jNkS2QSPTZw+FAPCOlCVgsh?=
 =?us-ascii?Q?4rnv+4BP6gM5en067SRKsbOzwht+gMjqtCQDXyiJyyotQ58Rw6czZfLv2vl3?=
 =?us-ascii?Q?IDtFLFsSd35bOecKOET8x1aUhdls/4FgQFGwJD7K8n8u1Wh/BvNk7edHqJin?=
 =?us-ascii?Q?f7wR0X6TLoJsstFXeG+2FIp3SEAEJc7Acz03Kq7UT9+RWtzAHv/2ACUZ6U9l?=
 =?us-ascii?Q?aLrxIg6nKzyrPN2i7JB+3X4V5ufqmImeInf6N9GNw1pTdnYvBs8hMRbKWVpE?=
 =?us-ascii?Q?AirEBXrMZK6JLCCcIU3S991GE8W2hqoYwAqD6RlzTjHcpySzTyZYv4isQN7M?=
 =?us-ascii?Q?QMaPFmNs69lES0+1v4IpIROng01g2WQCEvaob2vx76k3bGRq0fS6QhoZ6BZu?=
 =?us-ascii?Q?LKzLBI+PXJkEVJ75lcBAaP5BcV81nj6u9EY6q0LwrjMTUUm/NPQqRtKupLsI?=
 =?us-ascii?Q?tOWMtqCgLihiXPIjDlhmOvfnqwor4FuuuPK3XzwueE0E/lVANe14Izyl8ws0?=
 =?us-ascii?Q?XbEHWSOj75Gwe7JVtVOmzkJbKA4cLbZJBpo5lEO/AlfvSrt/nk7lpfI/VKan?=
 =?us-ascii?Q?srd+u81MP1Q3p0BHndrU11st64qUi2MR79z5AFwv+KFXw4kHzvbFsw9QvbiG?=
 =?us-ascii?Q?AmbKNDbQPqHiWnC21LOL2E1RQk9/naLGEqm1V8OM3dGOLiPomVuVO+siXoHM?=
 =?us-ascii?Q?D4dA1coO3Hxd+a57Np9Z6PPMjUlEAdG0XJv82XMtMGiWYK92QWgyYLAqCSf0?=
 =?us-ascii?Q?vySE5mIzDRt8HhGNbWONB+jYXSNIoZ5ZOGg1n0IY4y1zUZjreIZHpHErV8ii?=
 =?us-ascii?Q?gwJZC80m5ZLK/KgK0qcGcmNXkf7YqVprUnKWPZA5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e27169-6b30-4a93-ebf8-08dd51ca2e1c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:18:15.7258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQWCN8OysfAJCWqfNeja5WtMkkZ8Eavbp1nak/PYS5DYE6lJ+EPryYVGTdpfU+0h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037

On Thu, Feb 20, 2025 at 12:01:56PM +0800, Yi Liu wrote:
> On 2025/2/19 21:10, Jason Gunthorpe wrote:
> > On Wed, Feb 19, 2025 at 08:31:52PM +0800, Yi Liu wrote:
> > > > > And then iommu_get_domain_for_dev() which explains it is an older
> > > > > function that depends on the caller somehow ensuring that the attached
> > > > > domain cannot change. Ideally we would someday try to remove calls to
> > > > > iommu_get_domain_for_dev()..
> > > 
> > > currently, the paths hold group->mutex are mostly in the iommu drivers.
> > > So what we may do is updating the iommu drivers to use a version that
> > > has lockdep. While other callers keep using the iommu_get_domain_for_dev().
> > 
> > Honestly I would prefer to pass the old domain in as a function argument to
> > attach and remove the calls entirely.
> 
> hmmm. I may drop the retire group->domain from this series to avoid
> blocking the iommufd pasid series.

Ok

> yes. Since group->domain is set/clear under group->mutex as well. So I'm
> wondering if it is ok to add kdoc to iommu_get_domain_for_dev() to note
> it, and just add the xa_load && entry_decode stuffs without lockdep?

Yes, kdoc is the way to go here

Jason 
