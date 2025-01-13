Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505EE1BD9D8
	for <iommu@lists.linux.dev>; Mon, 13 Jan 2025 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736799700; cv=fail; b=mywet8jokK2IJqCA5Qd2K2N3dsmrJuWQkHDhj44moiqrZmk1sp0glzvJxMrq0U+7ozcvoL12hSE3yrML3wG5aukWsSURjFOTV4MhIX5tbFGimo0HLAX9nF+7ZCkCTAmzPYkerQmG0RMwISSXGw/pyEB62RnkMTJe7xwAIDqgHCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736799700; c=relaxed/simple;
	bh=f+BeEISTGhkDz00sZpdheTNem3m1E55VHgy3fg7Vmgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SxS8wM2628oPYdsNV5EJuMygsKuyQAi7ZDgdz0N9NeSsm0rb+c2WdWyhDkT5RtuMjT4LSAXpC3a/IrMhihECQSIGFYkvI1Gc7YW6ikh4LX6anAr+26KC0l3IbfSs6v6ZV1uiwKxFOvcTotYFHyKH4svzLPMSEjqGVjwGpT/OiFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oQ7uF0J0; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oQ7uF0J0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJPmb+oNP2/yASH1+yg5MVD5qEutVs9k7q4oLUCe6SwYuIuYub9U4wYz4+uaUcLa0rBIGv+4QY9H0UgrgMV5vfZwhkvGHak1SfNp5Yf5j+GfezYMa5APUSSbje/M3BCLYBAzBhmn72na7lOYv1VV6GUmxqa991+hJrbTLRf7m19ngsBLKhSGcLNMq0vQ240MLRpyvfZzC4H0jAM01IiSSDkMw6M+1AyRzRVkMNiUR5f6MXwjSGcjolZu4UoVo1nfAe34MYg+QUYx50N5OpVI9XvQKPxTRKrVhbophItCbtKZIG1P7J0AfI/Bzy15ObQGcAOAIHI2cBYUowQmeYd6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gveofylpzUe+l1em/EF+e+ldRcgksV5U86lzSsKfD1Y=;
 b=lB6K7X22Z6YJvVypy6eizhQpgPSWxd2HzyXUM+di8XlvlqlPfughOciAiDwhr4osfy/jQ1//zNTniKmKe097gfEFZUxpHGDo4VEXlb50ph18c5p/+ztxu4SbakOA0lmxa0bO+Pq/4ygzhWtpqHc7N9yKXMbCdQgSvNuazfcdhNxBWQ+5znKEymjfVt0YP63qEabxazNXCALAinVma7eeXP39MfLZXTWIdt4fTOrOVny04i7v7vT9REPlj+qBhnEmHRWDGTIPRpaxbscdtUSlphjbPC7lBEc4uv0hToOGhr8TF1MxbH79TZ2nldxciRmN/E2/47MOx8WjXqvbFyp5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gveofylpzUe+l1em/EF+e+ldRcgksV5U86lzSsKfD1Y=;
 b=oQ7uF0J0IJoFHX8Eo4EoxxrxMJJlzyN+uG7iwWVxpso+J+PC2u8apj1xsU/jO8E0SWOGn7ug7lkmTw+gGwUANsjIcte7yPvtHh5JqCibiTPVT7G2tXtEHAbuXvA/Qlkr1jZ+7MccNipgQ5Ef1CTFT/UgygOt/XzUIMg8U4aJACXoaG6zgonDRCNwmidpQNMUMWuEroTj3I2mVClp8/Zdz4uFmXyYwFYJVRZyvdruv+XYYAAzo9jzUvwq4/ajgvO9f5I1zLD96l1hdIj0yFzTVM8dhkWa22V4lFqdex1oBO+cgdt2XPiHE+9LS0YM4W6WkQWghfXRvPE0j/7aZtvHZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 20:21:35 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8314.022; Mon, 13 Jan 2025
 20:21:35 +0000
Date: Mon, 13 Jan 2025 16:21:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	eric.auger@redhat.com, nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	vasant.hegde@amd.com, will@kernel.org
Subject: Re: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Message-ID: <20250113202134.GX5556@nvidia.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219132746.16193-2-yi.l.liu@intel.com>
X-ClientProxiedBy: BLAPR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:208:329::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b9fdcd-2e14-4335-67a7-08dd340fe075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O65ZOIMNZE+ZH7a7eW91Lq7nMX8UQ+ga48rK1WV09a6Vr9ZuiHFl0GjKh4ih?=
 =?us-ascii?Q?G/bDmHydY//ne2CtMgxTvnRLlQ5QUdFplEsRN8RTBYNhGlsWk3wVaS2RExI+?=
 =?us-ascii?Q?ggOsxgEKQGCz/V7Yj1LgfZCunxJayHzp1Vt7NwyOYLPQ8xpNRUxAmmI6i3ic?=
 =?us-ascii?Q?Q9fgPGDbSL5+fTazYG+Ay74pcNzzTM/WiFnJvkNZsRhnV7KEGS/C73OxvF/1?=
 =?us-ascii?Q?LSq9VBfMvxZYd0w4HVLSQDQTtogavBYk4psKbSLbkvY3VyrveVsvq88xmC84?=
 =?us-ascii?Q?ZTPyCqrOEDdQ9hu9aoBtYfUBntPOKiZ8fRhLeCw+HKPGpe1ihsFce4i4hot0?=
 =?us-ascii?Q?94A5/ssz/L5ZwT/wW1XNjgQnL6GrMduW/+uAC84MfpHufsD2VCW0Sj9D1+Vg?=
 =?us-ascii?Q?gALjed4JbnBbsH3uKREBdcFPg2uu/GW+DsJN6jyoSzzE6l3rXnXPRmZhkyAc?=
 =?us-ascii?Q?z/pEs4HpiHmgFSDIlO8CIWAc8giykv6DThUHldJAKoo4OWfcZhXr/wgwcchH?=
 =?us-ascii?Q?ZcwcFGjXXgpjgpk4+864xB8qnqWEtrmOblyrj5nMli3JQkmiGdroCVvocBcp?=
 =?us-ascii?Q?SRzBRJSvVDnRGSvhpJiSOWvjCBLpO9DI3C/SyJYxHe8HcN99AcqEtBEv5XCF?=
 =?us-ascii?Q?AXp6WXGa7VYi6bEvMRWAnCfxyBsKlTOrC+2DvTvb3P3owKVAsX5kIRZRKu+4?=
 =?us-ascii?Q?jyprrk151LeeSMqHQa8c4WP3WNvZAnGwA6ETpyJcmDeu0QOBMKU/AsjkUutk?=
 =?us-ascii?Q?4VBYo+FwdwxKBtp+9wICWFuT5UwaoHi+t+q4R64y2G47xhWL1yJmzTT/L14C?=
 =?us-ascii?Q?2Faft4GC19RGj0BIo4A2UOGiN7bJD90QwTgFAuLdbNE+C5AhbV91EoRKgrX+?=
 =?us-ascii?Q?aswft7O+oC97sXHxcOdqBPBUF5PXjxMLKJeli9rJZCFbXh0ShC0l6DE7gbrk?=
 =?us-ascii?Q?9BK/21JSHi9L+FD1WX1Dm40smHPC6WC7ZWQIjrV3TkFkjo+AuxNwFkq4qtGL?=
 =?us-ascii?Q?dFyQcz/B7Lv83WfxIsyFIDrexZb+Gornb1d1HGH46SCF/TOl9+aF9Y0852Ay?=
 =?us-ascii?Q?VpRsbKXYHtm9JU5AkyMX2fWVv7vipVqx3RdDXhJ3XSPj6uQoaOr9R2Ju14Yp?=
 =?us-ascii?Q?37CpGlHqef1kII0NRYXe+NHtXw98QgjLwCDMZyEPPWAPwpq5vdX/frKSU01M?=
 =?us-ascii?Q?oRAZhluUdXEoseIul5vU6F7lsTR17Ug3m7EWox3u8J7vG+KB39n4bwj1TieX?=
 =?us-ascii?Q?06+xAUXrAJqeV6KihglfJXVlODa6zL+MDdANA9tOme9/68y2y+E4pR4VMDM6?=
 =?us-ascii?Q?fjNnydAJmsbhdAAl5fiGr2tidpDTb/0o0hsecEgZJdheUOq9/yIzceLqVfhd?=
 =?us-ascii?Q?5gvsKLkpU2v4Sn4XCw7D+uBGAIql?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+orPBej3BtgZWjWcfx9opeWss8f/t2+Oe8h0z5ed2IzqT8XDPwnhNsVkg3M1?=
 =?us-ascii?Q?xxgdIK/9fBCjcAwh3DabCTo4U5OOZ3/p6+a2w0+MEfasbj82vMes6nKCZeKB?=
 =?us-ascii?Q?xQOQ88cLMGEAcmKXlZClpqxKfg4k6vZIYNLxIVlvENfY0IxY1eAUG7zgh2dB?=
 =?us-ascii?Q?nyhfxELsu/4pywrle26Yi1WEC6067BGUuQC3rOjjChIMm1oLRPOSpC79/SBP?=
 =?us-ascii?Q?SBTN+wtoVb0hxKklzQkrFwygVyOC4FIBhFxz8Y7i87nZc/qMdih4n7XFjKEb?=
 =?us-ascii?Q?W2O1iWKffnmkQgzaw1bjUYLNLxW58OmtiOoAORleInIcy1EIOQfv6xm1bdez?=
 =?us-ascii?Q?py0zATXyuMRC8lh3HBKKDj7ky6yypjowcz6OxGH5T/RMQFxthM2XRYThuRJ2?=
 =?us-ascii?Q?fpH3JAnh10PDEm5Omw8DxfcKMZFUZI5ou1Gj9i7C/XaGmRGtYexoxXPIE46X?=
 =?us-ascii?Q?3oOo4X7oIGKuDJmYLmjqfFXXZO0JCuUlqJK5IyiCZkwNGwEPIFNagLZ2ITd4?=
 =?us-ascii?Q?ElgbL/jTTAy1OERVJQ1bIWOYbj0rFocDzD1PWqxDo50Um9YwMVMQm7LVSG0A?=
 =?us-ascii?Q?WY+OtKCHWJB7yCzIj9fs17ZU/oZGPq3zQkebZLhvAJ4ETJThETfSExh4wJAZ?=
 =?us-ascii?Q?pEkPo6KoFtjuG6zXIp7A3TFprfOZrkrqCYdvuGYq9d+1j1OpoERp7UbNPAW1?=
 =?us-ascii?Q?2ZQ3QRc7umvfA7ttxVB3ZP9RXSX7OHP30K2tDQuYjoVgYI3dpnIfgCZasqjI?=
 =?us-ascii?Q?AgLgxJKj1HP+mKsq2WqIVuUGEMj9RA8Ev9QdgrZd14TsFVzzaBva29zb3erN?=
 =?us-ascii?Q?koL5G7eShQV5Yb5OYduezbXwAsgi/KsROs+FQ2m9VwI/27vdy8LTXPJh1HVL?=
 =?us-ascii?Q?9gFnwRMZsd2UdnQicnmW1tM66f6usI9MQ5dKYWn15FZP0fZF3eC5Rx3bldm2?=
 =?us-ascii?Q?VOO/yMmdPa/f/04fV7BZxbdBImgeKNty1/QslhDaXbjANhokxqYOQwttDCCu?=
 =?us-ascii?Q?o3/rLXsnCTLTMbEDOVI1BHNRBcwkTjKPH+WOeGzVk0HrPEInQ3H7cG+bSVRq?=
 =?us-ascii?Q?Q/MHc3VXcOwSas80PAkpuIlR3LQNrlS3x+6OXQuv2gnK4qaOv5Bie6l7mK65?=
 =?us-ascii?Q?mxiDz45mpN/iJ1jAmBVJedNWnPuzBVsqc7qYEJ0W5E+LuRvSXAmKW4pXN2Si?=
 =?us-ascii?Q?fZ0JGXE8qMftkiY2XEJlgJDBCoF6yNFf0ohaa1BWAkBmo+NmPnaIJqjo64E5?=
 =?us-ascii?Q?CQnjMgC8iAcnMwk8D/vwIFpTUmZIvEnzH7i//cGht2VKTdkHAdxVMSKm6W2U?=
 =?us-ascii?Q?K3f92kiGIiROeEZQ2B3iI9qiST5LByf679ZvuFUNXtPfPc/ZsS6ofuAKTpwZ?=
 =?us-ascii?Q?4vOgdi5eqnUX6XwEny9nTrn0VheTUl6OgpAN428E0NR52GXNfdClOeKw/3WE?=
 =?us-ascii?Q?w516Xj6Lbmrg/BzN4L0exAvAA4E69ZYfchgc33iYvCxUJSmXGCoD9Xi2KETG?=
 =?us-ascii?Q?398w6MlIRR5Fo86DQJAqEbBx103OKZKEkxwgPd8bzSLiLjmpIpBB+tq8B/t/?=
 =?us-ascii?Q?+v71lsDX5SfrQWcfpUxsbZ43M46NshN8wGHiuHkx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b9fdcd-2e14-4335-67a7-08dd340fe075
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 20:21:35.3285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: netHHVaHD2a7dUpelij5EmWZPgNKrPuf2J5R5wXcWDXTfqiEuxFUF/voB0PZ4e5Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857

On Thu, Dec 19, 2024 at 05:27:33AM -0800, Yi Liu wrote:
> +	mutex_lock(&group->mutex);
> +	/*
> +	 * The iommu_attach_handle of the pasid becomes inconsistent with the
> +	 * actual handle per the below operation. The concurrent PRI path will
> +	 * deliver the PRQs per the new handle, this does not have a functional
> +	 * impact. The PRI path would eventually become consistent when the
> +	 * replacement is done.
> +	 */
> +	curr = (struct iommu_attach_handle *)xa_store(&group->pasid_array,
> +						      pasid, handle,
> +						      GFP_KERNEL);

The cast is not necessary..

> +
> +	ret = __iommu_set_group_pasid(domain, group, pasid, curr->domain);
> +	if (ret)
> +		WARN_ON(handle != xa_store(&group->pasid_array, pasid,
> +					   curr, GFP_KERNEL));

I wonder about the ordering here, is it OK to have PRIs being
delivered to a domain that failed to attach? What cleans up that race
condition with domain free?

Should we replace the domain then set the xarray? (and same ordering
question for normal attach)

Jason
