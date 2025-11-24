Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD22F6162
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764025733; cv=fail; b=hO488IH/eyhy++npYW6pM6PeRAuOdEJCw4ypFTZvFNMcBpGYaW4Isl8qwZ9Lh8suGj+v0lf0Eo2Gk4gQNvAJ0rPwr1nxr9wNEO2Poi0I4zicHe55TBssOnIjEQUgP0g8/XU3zE6eQQCr4+AEhMd4Z94EPbDRlOORwibyS9EMDxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764025733; c=relaxed/simple;
	bh=lfDgqb2Gqj7WitYyAvv3HznMEkwtqLZ7cKbnoGyzYj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JOszGk+E2yn1vP0Gh1qH5mYHr+3AR+taJIpTJY3khnYCisCngYcP2tPpT49kfj9uuBc807HubWE4cwuV5rzIHDzFesgUu8W/2Lwdh5RpCc26HAy7Lr/Z7KfkcpzhDhU83XVtC30FSE7Dpj1XjXjT8gulwl4BNL7Ycan+3UBqS1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pawvP2EC; arc=fail smtp.client-ip=52.101.193.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pawvP2EC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrHoHWHmdl97G+ZO5sQ2rb8e+H4IBrdnI62N0jxkBz2Dy+W7dCBEouJk5oxUCRPCibKdOeEZ+h1YtbI11e3IzKHVKEqV8b3SswJGIJPe7zkK4LrrZtjJlSctsjTz200QLqv/fJFF2mlciLVdnnmhb6STFm8y2rQulbfjozwessOArGt5+3gC+UxQngRFovMkX9rY+KsqcaQV+w6d4GMZM4nJsD+urqIEURWaIU2VcJNDOQu3Jg37fbSjgjqhGGWOUGzjWEHZGOfbrJej30h7Kxqn2Yzv0UWxT5993bDM2NGnUAKg9HLMXq5dIwkbS5Xl7znAOcHfrD4pBldcCh1iSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIgUxiQTIWuj12j+s7f1Kcy9AYtjY8ztCsIFo00D9nc=;
 b=KjdFhWljyX5VsTnR4+FgLrlO3xyu7/5m6pSWKTgmkP9kPV4FdBlfmX6v8mhQXE6HGezyCUlVQyAdOAaIXj99PqYBXMYljeDom1Qo3KUgaI9f3IaS26K0d+Q3dcM0UxMeQ/jt88AtyZ6rpERZrRDi5tRSRIjgOc0PDqI7d5UWJHABBm0FbVWfaeKoANqMJiP+C387dmRsifmWkcNTohyobGCqIj9ftejOps82x1iikwyRNuCS0EQ2P/Tatmpp9hEDJk43oFfO3iyhmB4qHWkYc8TZj5+lE47F03zL3LVSXhp5Ike2b/oesle5wqrtVpu+uCsm52p/8xw/u2uArSpIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIgUxiQTIWuj12j+s7f1Kcy9AYtjY8ztCsIFo00D9nc=;
 b=pawvP2ECOGHw2Xcqs/QHwDN++gB7RaYtwlsw93wDfpTms9rGtjyGlMkifOeVETlJoeLoIuTr7OqZCCATOKiyD/UaSmy2quX9W3mz+xPhKqVcVrNgFemK9zJtW7LvXwJUsER7NtPF+XZ78VJPR+dBBp4Fg3x1TYKt74eyuFej9WoSvsJoMn/SSYoIYIHXWkbgFqgvWcvkKUAV5VAyrFYNs+D1kTaxO0VwINOEcI7+XP0o4hWJksmNIdc6H/yAmL1EQU+uTjiBkrWpja3D/EzKEYWH3E36fKS4hVtisbEmwyYL9chBVfCiq+CPw0+E1aCgndRQ6mPxJJSlhOJBV+26WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 23:08:46 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Mon, 24 Nov 2025
 23:08:46 +0000
Date: Mon, 24 Nov 2025 19:08:45 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, balbirs@nvidia.com,
	miko.lenczewski@arm.com, peterz@infradead.org, kevin.tian@intel.com,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] iommu/arm-smmu-v3: Pre-allocate a per-master
 invalidation array
Message-ID: <20251124230845.GN153257@nvidia.com>
References: <cover.1762588839.git.nicolinc@nvidia.com>
 <b6e1b5d0ac0157fc06b5cd20c5cd72caec892c47.1762588839.git.nicolinc@nvidia.com>
 <aSTRX5RJJhfNU6l3@willie-the-truck>
 <aSTfrp9D7i03XhyU@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSTfrp9D7i03XhyU@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:23a::27) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY8PR12MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee31673-81a9-4fc9-1dd4-08de2bae6b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aiyG/5rrqJVu1YhNP8mqNcihgl0ylx+5sUFAEoT1BOVfrnmqFy40KkT6NvoE?=
 =?us-ascii?Q?6eRzbakg8ULbjVHWOAL6A/Z58nIACJKAhsAtB7OBAczNeRuZJBoWz5/ww50A?=
 =?us-ascii?Q?K67+waqR8ItbTuHYhTcs15Bwchnu+3mIPfgSwO7Jftqhc6ZaGuURFesRwjF7?=
 =?us-ascii?Q?9zd2AL8KhYgi4EeKVR/V4p/J3DILsl4xF2etT/+ZmPD7rkTAzOq8n8ytRBLA?=
 =?us-ascii?Q?Frv8ZaczoWRpqE7xWKfrABKaQTi7xkn9m445YovUWhXUQ1ZznTAYl4U51fUY?=
 =?us-ascii?Q?VkVuTogH8Df7Oa6v5KeMoYkwT/tpWPLjo7RsOvkbSrqLjes7m8ArwA5rxE5K?=
 =?us-ascii?Q?xJDGOa55y0EfbTJVjjINz1FiwlZACzKvrLeNL6/Ov2rzAfzxikRWMC/sWKeg?=
 =?us-ascii?Q?18DNXQvrkwbgPKXs9FWYZDXv4R3mLilhncW/jEOZ4/5qJPlw6pBV6GB1uXja?=
 =?us-ascii?Q?KbqfpfdSV+/h/uPIPWlJb5GhTYSAFlyMUwmAW1pOfSuA1u+OgSpt0UucDeXh?=
 =?us-ascii?Q?AwM5l4g7sw0TJ61iIsY+LpjZEnHXQHs/KTLBGiCLS+ebA2qyrfji0DpGYhhZ?=
 =?us-ascii?Q?xQxrp4qtJvAZGF23JZ4qeHSVpFo2qsaUTDSG7mBCcpLRDkslDGufEdptM4yc?=
 =?us-ascii?Q?14Q8uXFxlL9nAwdnD7sA72K0te7WxFyZ1zi4W1dxDw6w0m5l9P8u62gJvY0K?=
 =?us-ascii?Q?H2vHVB5VhOgKZp0CLfduhegfQ/pn4p2njUNnBqOFP4h93Ardw3VzCbTFS3Vn?=
 =?us-ascii?Q?UIzUxhxSpzAxRWcXEs22hmP4jVyk7vghwo+rryHhygVbFCq7wT8VYeLDkvtQ?=
 =?us-ascii?Q?ABisqe1BbaSVOoTdGpZISAgtY1w0jhk2naSLiprtIuAcCHCJ9w1CH+3/CtXL?=
 =?us-ascii?Q?Z8MUmNVFiostKo73Iz3hrsiL5ErcapZADkLC88iy/fU+RuWOYm+ddVR49xYY?=
 =?us-ascii?Q?Tq8hHG2Xq0Cr3fCm/IJwGrP+N2P4M/z3XiQQlG45k4ZiYQiUO6c5Ys0yui3D?=
 =?us-ascii?Q?z6D5NsJj7pdkns6U/YyJtPLi3mkXqo+I4rkO9p/cAPyQj4fMw9JxZHN7uLuk?=
 =?us-ascii?Q?nEl/0VWgff3M72YePODZNYcEVDaL3GrrvMRRGFqLxUhAbex2Iqh9JhKsJslq?=
 =?us-ascii?Q?we0U3tiPxm9Dw4w+YqV4YiYVILaqXUFE58up5qB4apihNBLNMwSRF+ihk52a?=
 =?us-ascii?Q?QFhkB6AFTQT3RU8eETyIKc5T/kidtGejZbOWTcCHDh81WewqhRzAr2khaW1R?=
 =?us-ascii?Q?hGsP4FrLJ+EqNUs4oeDIw+0msEn9exLziv9iT6Oyi/HaDzrkez4FHHGHzDB7?=
 =?us-ascii?Q?E8hKWFSX/qkH1PSlUGQWwJh6EtH5nEbuFBHNY1nWAEfPqDquuv+LLhIkIe1O?=
 =?us-ascii?Q?PYIm0EZy80oSVyzMPEwN2Ak3nmnJeWKL+hHSKjKXStf8x1uR7XmTdJNLbeig?=
 =?us-ascii?Q?MYC7ZeXfYUglh3RMT63RtMPZEBp9JiTn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pqSdsoMDq6uqUwSvNmJ4Kr3mfdUVK90ZwwZBgrriQcm7DSfIOA2KoEslLPBK?=
 =?us-ascii?Q?9Wwm2wkbOqfqeLGZSZGaFpkYNKPYYGAcRVspjvvPpkfb/hcxssDK8uz+kGAU?=
 =?us-ascii?Q?QjJoOIADNsZQp68cnWrwu2quloVFxbowsPHnyzFA3yD2fpLHV/JmEiTqajDR?=
 =?us-ascii?Q?Fy8LF3+QDUaeyRfK4rb6/zK64t5uo6KH1JouFZfPMWWCA4qhLse8Xj5+YQW7?=
 =?us-ascii?Q?EVjOZlxfVqaRcfxuRGV9EZBvVEhJirqImKkrx6HyQ95R/jHZzkw+OGQADE8u?=
 =?us-ascii?Q?mfYOX/AG+PZKdJ0lfrH4IPcrF/UCqlgHkT7zW77m2NgbqZAuRvIWDq7ltWUi?=
 =?us-ascii?Q?NN2ushkWd/d4FCl2TN4OV9VAfPltCpUBrGGhM4OFmJ0ml0xcjaBXR+RliK0+?=
 =?us-ascii?Q?78u+4NCptv+1xolQ2CNLcKTu18ve/Bz7HdJhbPEgZ6H5BT6oaEpru4037EDN?=
 =?us-ascii?Q?rd9Ai44M0Q8v+hqcdgpQdhKORJPBZ3ftW6BXw7dmITQ7V5SsE4CKU8WClIkP?=
 =?us-ascii?Q?O9PlLEdEk6agnPLI6Sxcxm6H17v5iT2PQJTVj2cVx+nq9IDXw1s6UMlzVVIw?=
 =?us-ascii?Q?6KdmfpmniDul/NZQChlPEXTiAjxTZJ0mOmvMInriy6FIJbhn17iushmOnokP?=
 =?us-ascii?Q?+ByDe6qXXAU6w58veDcxpfety/i0JgN8EcoKm2clWxd+AfLS0DHiQKE8V67h?=
 =?us-ascii?Q?3+0koOG+aHMtF0xU6Pd8cOoEp9ZweUzrOEXh54ulZvRtQWHhv/TxXb+ad7ld?=
 =?us-ascii?Q?BuFxDPcoMWxe+54ba8jx5Kf2nZ4gDcjvi91IEMfJDGS8hjeXYG7VgDsIgf/R?=
 =?us-ascii?Q?pzxWlQZmfzGHuCyIb3kARb6Tq7W0aOjuAqKxJuFVuTudoQKgW7TG2MTZPMVj?=
 =?us-ascii?Q?PAed1osH6CctklYkB5bV3B1QBSBALXgkQzP7vTDHH1mXREq71amhFr+XSkmm?=
 =?us-ascii?Q?Z0e36FR9Hct9mBRb6/HGO3e+jglQdjgGUuly0GUJ4dMY88dVG3Qufun5y4kN?=
 =?us-ascii?Q?HuojZRyqU3kro4nL0jDZe6kxLHs3vntq6p6MsZCuUY+/ohv0mKjhQ5p7bUiE?=
 =?us-ascii?Q?EPl91p8jAoFFGZIrpJ0XgIRKRjlP8jDM0lCqaHTRbQkbH2IQbaYkYRB91p0B?=
 =?us-ascii?Q?AAM1/DqUe4WB3LdppYJaGoZvbu7+fls8MzIo9/e326sLUr25GISPqx2+4pWP?=
 =?us-ascii?Q?C2WzraYtrMy39WD0hImabyRono+5u5o4TXS9zyZCT3hONHCDdfMJ7J58y67B?=
 =?us-ascii?Q?sflnBR44DhhHJSls5F6WS9WdwxQKOK6SsaREvMLjYN1jEi3kbO7UoyDK1wtm?=
 =?us-ascii?Q?Cq1iFoPYp5lawRJvAtrZyeOUqZquOxTYC1KoMvLhJQ9FCMfl5qWU2C7h5mBc?=
 =?us-ascii?Q?Tvq1FFe+Oh1sF2Ek5sU6W1/SI2vjwc02b/s/duQNJYB+PfcMnigRXMvWoL3/?=
 =?us-ascii?Q?8gEtved1HR21q6wDu0288SZ2tdEFNgETMIQ/TIGCwPjEZW5QSHvLDyNkSFO3?=
 =?us-ascii?Q?t9Q1tkC4jh9JfRHeerv0u70tKymNpOhPe9pH8G7V29OUngxjmffZWuGkS7cv?=
 =?us-ascii?Q?GRCa93h5uR15dX7aNf8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee31673-81a9-4fc9-1dd4-08de2bae6b48
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 23:08:45.9538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31ljvTsRRhjsC1BLV7Xdctxc1M+zTzZWDxlqkfTpEXoBkswwgnqOmSCw9pQmNMbl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216

On Mon, Nov 24, 2025 at 02:43:58PM -0800, Nicolin Chen wrote:
> On Mon, Nov 24, 2025 at 09:42:55PM +0000, Will Deacon wrote:
> > On Sat, Nov 08, 2025 at 12:08:05AM -0800, Nicolin Chen wrote:
> > > +		/* Put the ids into order for sorted to_merge/to_unref arrays */
> > > +		sort_nonatomic(fwspec->ids, fwspec->num_ids,
> > > +			       sizeof(fwspec->ids[0]), arm_smmu_ids_cmp, NULL);
> > > +		/* ATS case adds num_ids of entries, on top of the base case */
> > > +		master->build_invs = arm_smmu_invs_alloc(2 + fwspec->num_ids);
> > 
> > Although I can't point at a specific issue here, I'm nervous about mutating
> > the 'fwspec->ids' array from within the driver, The array isn't allocated
> > or populated directly by the driver and so I don't think we really have any
> > business sorting it. Could we hack iommu_fwspec_add_ids() to keep the array
> > ordered instead?
> 
> Yea, I think it makes sense to do it in the core, once we have the
> data structure provided by the core as well.

I would be more worried about sorting it everywhere for every
driver. I feel confident SMMUv3 doesn't use it, but something really
old and embedded focused like tegra or omap, IDK.

So I wouldn't propose to change iommu_fwspec_add_ids().

If you want to be conservative then the thing to do is sort the
master->streams that arm_smmu_insert_master() copies the fwspec
into. It just has to be sorted prior to feeding it into the rbtree.

Then consistently use master->streams as the sorted list.

Jason
