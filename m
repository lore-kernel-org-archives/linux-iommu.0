Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E8C25DD1E
	for <iommu@lists.linux.dev>; Tue,  7 Oct 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880602; cv=fail; b=MLEA6ydqcQHi9xXMuLj+zqL+ATrlgXev4oeshBAP0wMIzHo8zKOG6SLJZs4sgArCGGhkxTjBNHB18x8vPnfEnH/uNPPxDYNm+lBkxSZ9pVOoK7btpTAMd+QN3sPux4XiaDgDrh0nuSRX0uQOwPNzdFYlVMm0N0m1GybblQvIXo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880602; c=relaxed/simple;
	bh=/NBWhiSys3ZrsbRlRPUjzUyiRMvTWRgalPP94u4YE3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GTNyAKNHJLUBO+bGvhXmQD71u6B//n5udKFyB7WBV1XCzTWuppZtnmpePZhHrDslQRz3OkblLz65jNNZnX/BeOomGJfmtnQmPzrIuMN5Kws/R1CbLGq6Xzl2kvZV0M+Ms1XDSkixx1Mluaz8SBQi9uvOIfpjIy3gvCq42ZosMvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rewBxdUV; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rewBxdUV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFY6FccO10znzt4lsXcTA+H3AqfSsJik/lu0waiKxS6NKo8nFClJLStFqvrgZULrgUL3bNGKFUt5EawgEr9rd0EJ7xSHavTcSpuyjQSt/pKqIYj8WZGcdcod/3tpqGp0wsQ03wf0WBTJeREd7FaSlAuKQeVqXsyW+dSIFiW3daR/30sB4Frvra0lxDFpvLcsCE2IquVFCfSSAE8rncEkfuuZXHCARe7vs834ws3mNQDpobxgUYUwJG93Fy6suS+gucAlP9B3FHgUNX0cMqr9ORNQitacoTyQT/RHi/29w6kEg6o7zLVDmTwXOPXf3kkYIkRsoFL3Og+Ug0h8n/ODNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0juayFierWTYuObT69thMAuZqh4TvKOFhveqvce/4kg=;
 b=HwDGL+TGhRW7KEQuVVyJxE+VAGo8bSmnpv4kK4jvg7prBNCoBHjlbRrL4p6pXXjjtXd+cTUY+QHnBnEd+4TNaPSWEy3C0B8crUzc/lwANLD+rUx49mlIDlhtL4fCDmimq9wiUoJj5rp2Z3hvjjCzcZEuWoMQjFM8r3zmgZqRkGsddj0cTLNfb6+wRo+KWetws1lqVkd0TkQu+GqhA7qqaj5flXGxnVJW96K657sLUJOH5Q0qrAFtU2CZTyfuxQEIXxCinZVaFa8MXSqVmITFR/ysBr3yB+OqTz3JmV3NfQkSzyBSX2xjcCjwLqU5+rPqGwBg4wguuWwaQGjuRg59MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0juayFierWTYuObT69thMAuZqh4TvKOFhveqvce/4kg=;
 b=rewBxdUVKHOsbfCQNhfP9KgnaRINMuWT+EfGjLgPoQFiYhLpclEg1gOgCax041li70v6PXgxaU6vwTATiO/XyEGL0A28NT9AdzgFWpbym9D8tEaS7ovVxHdpYj61dLmOfHLmuJQ/XWAGPkppsRLZOeMbX+QqbJHUPUk6xkiRlO7PTk7O8v+fsghqfDjosExPMazu4nLaYACxvkZJ5bcYxBIU9M45Ox6DlFoJWyn3PMx2z/mjMYX4vHN8CLTEUld9kJsNmUnT1CnCXghpRNAIvrkqkhIBTSv2YRYFvUieHGwN+GytmPoA4GL2wl+FTs6VUtSbN/j1Bq44WTIY8rJpAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 23:43:16 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 23:43:16 +0000
Date: Tue, 7 Oct 2025 20:43:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v2 11/12] iommu/amd: Add support for nested domain
 attach/detach
Message-ID: <20251007234313.GE3474167@nvidia.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-12-suravee.suthikulpanit@amd.com>
 <20251006145900.GT3360665@nvidia.com>
 <3e27de73-61a1-4977-b0a1-629ffaa81032@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e27de73-61a1-4977-b0a1-629ffaa81032@amd.com>
X-ClientProxiedBy: SJ0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::6) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cfc1a4-4192-4c6b-7a38-08de05fb494f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pcKJVnSjpyhqnkIp1b9EL78XAkHibYwKbOvgbdwz9bJlRVZi+Pwdt/Hfpsu7?=
 =?us-ascii?Q?gkwZiLv6+gNzKwtUbEh+OGIo3CjoJirnU66fq2bUPW45LWIUGwhg6tblSTm8?=
 =?us-ascii?Q?4QpJ52KbnkAOAEK6StUirLbcxlMm23QLCrmNNhudX7m370tY4pQRCMuUKw9O?=
 =?us-ascii?Q?6WJGcNiyYBLYijJ6XM15VM+L0o9PsA0ALo3Xaw1K/KCbidFsgvbYrBzh+Sde?=
 =?us-ascii?Q?gyTzp8ipy3lVTbWvtj8y0tCSbiHpsGVg5mYJParumd5zLnU8nzBRHwvBxcV0?=
 =?us-ascii?Q?S2x4/rh63QUKKiHIpWRzPkzXdmz+a9v5lOvrnM9KjZfR+IqIXWVfV+jhsDCm?=
 =?us-ascii?Q?Y2mmHVUnxLjJMYJB4/O8z5/wnWSe6Tf1hduvAqF/gDy7dHQEMAgMflpQA+IV?=
 =?us-ascii?Q?07UpmSW3sztMBrowApNX5SYcxHf5A5MldB+epHIjEfEaJoTp2UvtD3dqwkPt?=
 =?us-ascii?Q?CETrLERXM0+19eT7g2I2N3Qj/y0eUhS7a/pgqgotxuIiur+8nnQEbrRl4kIO?=
 =?us-ascii?Q?Bb2mdim2EnVHusBH+KKciVhU3Pv9r5RPP8dJnaEyZWaJWREN2FzFhBwn+2w3?=
 =?us-ascii?Q?XkKy7KIEJ7ubOGoKOJCEO6riVdZMtCemthb5li6E/SDcB/kIWz+mBxkxNCKV?=
 =?us-ascii?Q?saWiY1gBi972zLgXGiEWJa1miEmJpcDTNNf+3r18W0tIXma8mHAXXhXhwQJV?=
 =?us-ascii?Q?ETqHX9QJiru6T4tJyOd3/cAd/nRWUb/rXhaXRfTJeiyAzDncRN0CFxILPG93?=
 =?us-ascii?Q?TbS9R2GPw4J4cTpGo72wp732YqH9g1SYH3goYNQqohdEvEnqL0v2Lo7EeipN?=
 =?us-ascii?Q?hYb7YRg2wHCLp7Fu/gkx/9Ucz0qQKew3GTKCTIKaCyx5BHongEud1ArYxoSc?=
 =?us-ascii?Q?cUwKuVcy+47olAhNoFRn+0wGuuyl76lOTKaFZvb65qUcOHydwOAVmfdzZvJE?=
 =?us-ascii?Q?BGIG2aXnpCu3GFG/x9Wdv3GBQqF974P8GfbHmKxVKaljUdivq25bVK4eb/6H?=
 =?us-ascii?Q?gxs/9GQY8xBC5QahmqqQ7V3Tikv9Tr4sUOcaERgk/pvsACPgSGVMdvUhwbez?=
 =?us-ascii?Q?ew6NzFfRjZYOVgPsvq/WrNecygH41JJxHlRhkg3aBW5Axdw43fsb5DQbsy6y?=
 =?us-ascii?Q?eUWN5MzwTlV+hbA1P18nzKg05Nq9EDD1Tdver5nMxE2qeNR3o86T51xVkI9D?=
 =?us-ascii?Q?+s3/mvtUXbYFAEhq1w+7ldbxfpK3mTXO+gpo1dmaGsQMAsKu+TRcSRN997XE?=
 =?us-ascii?Q?uOQdBU4ibolIwtQB9fMXnZQb0u1W/1nsUU7AxqUeoffrT/J/1H8pTvUXlHCk?=
 =?us-ascii?Q?ZpX2EhBAIVw/Gdbgc8qvZ8pFwIn4HQ1ADvCB0au6pFCQAeP8EMo6GgAW+UB1?=
 =?us-ascii?Q?N+hSBqof98CcJHAurn4Fd0as4foPYSRyfqg2+DAkgnfr+UtUBNsZ4s5B085i?=
 =?us-ascii?Q?Fpp55jo+EmdkmIy37ZedNHcIaRvkT8SC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KXWmSTEGR/fcTTGV9Ay8Lh3QkDCBrcSS362YuzjP/c2c0Mf7hw+4XtxXgSEo?=
 =?us-ascii?Q?6VUFfU8k7L6LX8ogxjDtbIh2kM9sxXAE2i2ZUdvd21zBy331P67Hrq4PlBGJ?=
 =?us-ascii?Q?s3+xaoSlpo6zAZNhMYT98XOuSWfnY4CoB702sqJMFSFllyGvK8mf9DB+tHmY?=
 =?us-ascii?Q?HonEhq+9vMfy1lPYuSHMmFwXrwZiVwudyohFTR8TyqHY+X/3H+BrxD9c8vkT?=
 =?us-ascii?Q?bTEMJG2jsHiJ35gy0pilVnzmCwYvZEXLaR8+vAE0jnKw9JXiQfdgMo/kLePy?=
 =?us-ascii?Q?5R/BxxWux36RUK0Ctv2BnMFBibp3TryK8hR5XRxBR6qVOOrMD8KLkWjVJjrE?=
 =?us-ascii?Q?FuoTPIKDS6XheDkUDbZDJLA3DT9SNP+ImbrUe7ebaZM2Ze1WiBzW7MifP2dV?=
 =?us-ascii?Q?1qlmHkE+YLy4pEwepyvzXZBjeATjmiZZJ7Hder/7muhcXhDevG1brX7JUGHG?=
 =?us-ascii?Q?1DwlFBFc+M/gIjZ20uz+6w6Ti5q+b4uKQbPQsurhMsM06U77ucyaGodIMqpK?=
 =?us-ascii?Q?Gy2WvtfK98UWOQNKkp+o/ElAT7X70SMnwNT6UObJifDi+/9lInoTRQU3PkjK?=
 =?us-ascii?Q?3EFwSPA9VC6O1zFVuiDduxrnnk2OoDiEtZzDCVhdKFSsoUSGFqjYb2Jaqblp?=
 =?us-ascii?Q?TemfMB0+AZz1IBaEGgTHHbT4h2yfZYDtt7gC4/+zu6a0deIYQX8eLxCvztUH?=
 =?us-ascii?Q?czojPXnJUb9OqU1dlsAHIqjgkSSSZir0FN/jHbylEgjjHb2Kn2BZg4t9vSGJ?=
 =?us-ascii?Q?j41Ciq8ERvBIUBPiQSWf21m8jRq8ploeOnf52y+QNrDdoZx76pntCwUDDcyt?=
 =?us-ascii?Q?4zTivY+k/wzmyzMIZp595/HfUhuc17FZjjom8gQnspjtbM2s/UwyZNvbhPGB?=
 =?us-ascii?Q?jkgwIFQXJ9kw2teCFmxbBqCYWUZhW01icq5l9GqifMgKfqtr0myyNaIIkM22?=
 =?us-ascii?Q?iZ+rfXQdlTYx1Rd3Z6gk9F36IoStKI+A+z4tt67ltvmegjlb9wFybHnxwmUM?=
 =?us-ascii?Q?M99Y5qrgj0Q5gp7+EoSiii7fR2xRwlfbr8UqhFXtO4/Tr7J+KLbJv28kwScX?=
 =?us-ascii?Q?ovTyVvBke51c+KDN2dIT4hm+UYNRknZkVC2I+nD/1nde8mzFHW7oNHndzLcR?=
 =?us-ascii?Q?lNXCDEuqvpX+LktKBSmqQf0ghsOD4fxgisMEZsDLmTGSzGJk9SBW80edcmp9?=
 =?us-ascii?Q?R/BBZBsxmZuTR1ZiZWDarh/D+iJ/yUpIqVLtmu+VcxUYHy5fhKcjqY7OCe4+?=
 =?us-ascii?Q?MgzQU88KJl9CKWGKQMGSPBkcfU31rvTy1Y8WLtMuO+QRuipskd3vzN3EdX//?=
 =?us-ascii?Q?Dr+A7BTEz4iEEX1AmGOIJ2Eatp7JhGcBnSQkdfOdRWSKmqSHvzKdYNvbxJaJ?=
 =?us-ascii?Q?smKDc43XHRXMcI1JU59u8/DThXsi9m4Xyg4jT9DL/q8CijtiWRdeItUfR4jG?=
 =?us-ascii?Q?Y7xe1Lu98k6DuJF8IFMTv4a1Gk7UtyJS3chRLh78dGKMA1wCjRsQal87GAaz?=
 =?us-ascii?Q?CZuzK7V+79ZUjEymMrDs8UKrGPtnwdgVzkiYpYiAKuizkl9Cs+P7iGzQEbb6?=
 =?us-ascii?Q?kaPcPj99+C6XIbVM+UIlvKKRYUA8qZsncuL6lZvX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cfc1a4-4192-4c6b-7a38-08de05fb494f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 23:43:16.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vz78tbFBivuqyN35aBS8pHN+cb+XBKbA6suYYQtYeJ0/4XpeD26tYfllQXoguuT/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

On Tue, Oct 07, 2025 at 02:22:30PM -0500, Suthikulpanit, Suravee wrote:
> 
> 
> On 10/6/2025 9:59 AM, Jason Gunthorpe wrote:
> > On Wed, Oct 01, 2025 at 06:09:53AM +0000, Suravee Suthikulpanit wrote:
> > > ....
> > > +	if (WARN_ON(!ndom || !pdom || (pdom->iop.mode == PAGE_MODE_NONE)))
> > > +		return;
> > > +
> > > +	amd_iommu_make_clear_dte(dev_data, &new);
> > > +
> > > +	new.data[0] |= iommu_virt_to_phys(pdom->iop.root);
> > > +	new.data[0] |= FIELD_PREP(DTE_MODE_MASK, pdom->iop.mode);
> > > +	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV;
> > > +	new.data[0] |= (DTE_FLAG_PPR & gdte->data[0]);
> > 
> > > +	if (pdom->dirty_tracking)
> > > +		new.data[0] |= DTE_FLAG_HAD;
> > > +
> > > +	if (dev_data->ats_enabled)
> > > +		new.data[1] |= DTE_FLAG_IOTLB;
> > 
> > This sequence should be in some set_dte_gcr3() ??
> 
> Not sure what you mean. This logic was in set_dte_entry(), and duplicated
> here in the set_dte_nested() since we no longer calling set_dte_entry() from
> the nested path. Also, it's not really related to GCR3 table.

Sorry some make_ste_v1()

This logic should be the same for any v1 page table.
> > > +	/*
> > > +	 * Restore cached persistent DTE bits, which can be set by information
> > > +	 * in IVRS table. See set_dev_entry_from_acpi().
> > > +	 */
> > > +	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
> > > +	if (initial_dte) {
> > > +		new.data128[0] |= initial_dte->data128[0];
> > > +		new.data128[1] |= initial_dte->data128[1];
> > > +	}
> > 
> > This should go into amd_iommu_make_clear_dte() I think, and refactor
> > it out of iommu_update_dte256() ?
> > Every created DTE needs these bits set, right?
> 
> Currently, the amd_iommu_make_clear_dte() clears all the DTE bits and set
> the DTE[V] (valid) bit. This is used when preparing the DTE for programming,
> detaching domain, and when setting the blocking domain. Putting this logic
> in the function would change the behavior.

Yes, but it seems like that is the right behavior?

> These bits affect Interrupt remapping (Lint0/Lint1/NMI/INIT/ExtInt interrupt
> pass-through) and System management message behavior. 

Because these bits shouldn't be cleared on a blocking domain!
Interrupts are still expected to work.


> > > +
> > > +	/* Guest translation stuff */
> > > +	new.data[0] |= (gdte->data[0] &
> > > +		       (DTE_GLX | DTE_FLAG_GV | DTE_FLAG_GIOV));
> > > +
> > > +	/* GCR3 table */
> > > +	new.data[0] |= (gdte->data[0] & DTE_GCR3_14_12);
> > > +	new.data[1] |= (gdte->data[1] & (DTE_GCR3_30_15 | DTE_GCR3_51_31));
> > > +
> > > +	/* Guest paging mode */
> > > +	new.data[2] |= (gdte->data[2] & DTE_GPT_LEVEL_MASK);
> > 
> > I didn't see anything validating gdte has only permitted set bits in
> > the prior patch?
> 
> Not sure which on are you referring to.

You have to validate gdte has only valid bits.

> > If this is goint to decode array item by item then why not use struct
> > iommu_hwpt_amd_guest in the nested_domain ?
> 
> The struct dev_table_entry *gdte is basically the same information as in the
> struct iommu_hwpt_amd_guest.dte that we copied from the userspace into the
> more appropriate in-kernel data structure type, which is used within the
> driver.

The appropriate type is the userspace type if you don't actually ever
use anything unique to the kernel type. You can avoid the special
assert/etc since this way of accessing it is not sensitive to layout.

> Here, we just select only what we needed for configuring guest page table
> specifically to be programmed onto the host DTE.

Everything you don't pick up should be checked to be 0. VMM needs to
filter out unsuopported things or generate a bad DTE error.

Jason
