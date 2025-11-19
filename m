Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453635A13F
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559842; cv=fail; b=F1lK1Cxahr/Hj8unLBdyNw3fzAT8KZppYkA/6TgS8To8wok6qju3n/RWy6Yw2oX6gTGnDjKf8I2Gdo7ww1R0T8ZkfVC/zJIWU81tSzyTwLtRFYsEPllNOTOO7kahM6UpW9pQfid9Ctr15Eun2aH3r0iXFX18bgNrmgDWQ5Ogjyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559842; c=relaxed/simple;
	bh=IbamgaFB7oTLnSMlq0NwpwPHYB/dblWhHvCSbtwiQlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=siqN6c9GWrVJ2j68gZ/tDVqdxBqUUI6JthvZzUNAU6g5AZokpHSDK+6d8dR3DhsiU+NpXI5LWqQu7IcRDAvbyMerQ2Xjx3ukYBLDRiB/OXK1WtZjVg3LH8LNyI+h9ZBjwMHXYKU7XnN5mV6YY9Lc12gkg32xI/KeC/lyH9tXgQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I375YFqF; arc=fail smtp.client-ip=52.101.52.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I375YFqF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBxBQy/WnbpmJTmWZMK7ZVmu7lefhpbKBO6gcEDe23jLWnsmOomUviEm0/zMScqJSpWCEliz7Lc7WiYoYt/VnVQOO9bCbgbyYBGX9Hdm6M2gATR4JL8S9eeSF/ItNt6OZErTuoVOg0J4I71P647m9eXG6nv31pVTvDUfzOC6oqdAZSN1ZQKoeehYu1Xp84eSET/DDbHnyB4GSGLU2bWlE88DiHtwfKxvGbP2/WFbWM8p+53+l3btz7f/E6Yz4i3QkrFDog68rLjvnoLhqgOxaHw270XOkvPqOIm2MF+v8d8Zh/qaF0AXoYj5Hma4WwKbHWkxScZnEXOXaoWsKD79GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRK5V0vo2ciRArJGYjj3KllKNzhW98Be/HgcnvLruak=;
 b=f5lw1dV3U+gDjj4qkVivc0JeHoiwNbDtTogfMUc28ciXbqQgZyHNvS24Z975K20tx1KlVX9m+sSKqZsI7dRDEJzt8agT+f3vl+4DXnMXa5Cl6IaVnMD0JBanc/xNA6Xd1cEZ69+MlUufUlV8/vWb5+M+yGnDyNAVrGeH7/18XHWiIMjW+TY4y/WAgoOXJm58enoWBzSXh8SVcYKUyrslyUz79VbqPXI20+vDAPq2euUi9key/letoPcsH1zGoeZcR2fftiWjJFRJwwBqlMKRfMBO4IhbSa+HorxJrWZ3JaBudKffZ4QDm+rQMAz39rZloaC+f3sz6VD8BP5oqu5oxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRK5V0vo2ciRArJGYjj3KllKNzhW98Be/HgcnvLruak=;
 b=I375YFqFdZPa5hpwP/LzPrKGsO7huVuw+0eIFTStxlW8w/M3UzI0cREvpAQzdVBvngAn1mmLU/mLa97y/XnjB0H4q13erralFId4sehfv/Y9ISqXHIQc941NcXtU7J2ErktM8wYGEkM4xfKeP0RmscNMnC89wWDwvd/lcUVbpM87JJJfTObGgH5WZNZ40oD5hR+2ItRfZpsRLUE6f8sV2Ne9YJEn4j9fFV7noffhWxj1fKmmXw4ykKbHFDUK6uN7Mtd1OLf+nh9szO4VEFYgzr01bIdH1S0xp5KLGLfft5UIGHzIUxRiQmxLokZQ8Tirl+hoKAb3KZfr4choimQAgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 13:43:55 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 13:43:54 +0000
Date: Wed, 19 Nov 2025 09:43:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, ashish.kalra@amd.com,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH 1/2] amd/iommu: Preserve domain ids inside the kdump
 kernel
Message-ID: <20251119134351.GM120075@nvidia.com>
References: <20251114104442.23296-1-sarunkod@amd.com>
 <20251114104442.23296-2-sarunkod@amd.com>
 <78a4598d-5d35-4fd0-a830-a740076aba41@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78a4598d-5d35-4fd0-a830-a740076aba41@amd.com>
X-ClientProxiedBy: BL6PEPF00016417.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:5) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ1PR12MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 8434069a-9353-4191-14d5-08de2771ad54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+lu+AGyjBYUPqlxND1lCzec8tcL4HW/Xq64aY4giRtCbBY1O4DcFs10tpihC?=
 =?us-ascii?Q?sZ2ta5lqxtpP/Vlm6SaKXaRdmY+fJJY9clKWyN0dCaADbHQS3Ocq8DybTwWi?=
 =?us-ascii?Q?e7J0hnu0v79z43y7ATfl0rFootlCn+K8cBpYPQxLrNu2h+8E9U1r6THXw4NZ?=
 =?us-ascii?Q?3FdAXkmrx731ORA/6WmCXITJMk/V4W0y7OWVoJZbyqYcmWXAc1U5zgB66lHZ?=
 =?us-ascii?Q?tTXVFQXYYR+acLn9bPeJJiIfbvuVd5qD6LyFbWY+STCBBQjmQk3Kq0B0sgsq?=
 =?us-ascii?Q?XMw7+3T8tRjVp2wH24XtIYUgaIidS1CVkceC6nGCyjg5w3DUl/1fOyLoVnyr?=
 =?us-ascii?Q?P7sW2m+tMBUY6caTVqk04jjfCJgnJMkHcO6YdNWDg+ZvXM6HQn3CXexgE6vB?=
 =?us-ascii?Q?mffZPCf+pyqhZMGPCSSUZnC2zBn1MkDShawZ6VUNFv3Z8olnOJDBmmWVJf7j?=
 =?us-ascii?Q?saHQYNYi+QHXUAy+XT/dplKIWCmhZ27EufBeVW6Rv6PUrngl2fG+Cuucaj25?=
 =?us-ascii?Q?lVfyEd1RQ4UzxZYRdwE6WQspQTWZ1Une9SgGBOBJyjUQCb92rcPOxnv6ExbW?=
 =?us-ascii?Q?O1doWZDChRvcT/0FAQv7H0ruqrlSo1YC4NCSmKUHwv1RNYCzGE2jEPfU71We?=
 =?us-ascii?Q?FjBnWFEFMfVFMTbypFOo65Lj/rmRyaDbUEPjI0QQ5oDfOMY0k3HKmBZhe0qM?=
 =?us-ascii?Q?pNiUuIB1FmC8BZo2zsCYykpjSnD5eVU2gSdtrjUF45XpYhAsH9M+X6++1Loo?=
 =?us-ascii?Q?4XW0f6N9WXqEmG77FJIT334C8YDamMMU33lbHH4X25llNyfEd2EIgQYkWlRh?=
 =?us-ascii?Q?RzHii1sFW80WNFUpLN6CcLndU4Ud1hPP6fdndxjEwgo8rP+CQQyMRVDOfNE3?=
 =?us-ascii?Q?qnysXu4nIhlRbjtDQs8T8An/jNuCJs1geZ3PDDuS3WmLaHOu3+LOKPwTQs+v?=
 =?us-ascii?Q?mvJ9Of2Ixzp0bAPh/HasOLH/0USXEAqOEwM8ueVf/7ao8lk5qjGBLZ0vfadF?=
 =?us-ascii?Q?iB9QPenWupkKonhHH8R+b+9H97diPnoATzOEzyG8S3f/5M+re1tHOz4M6fnl?=
 =?us-ascii?Q?5FnbHg72gAlIcEPR2aAFw3o3kvG0VPxeA/1IaidmBfaoswQmckUphwFGNQyO?=
 =?us-ascii?Q?Z0V/AJXKDDVXv4rSN/M2vd4UDE2G50KVi+GW+3+8+00EKsBtLKw0XAS5vuQ4?=
 =?us-ascii?Q?yvXhTf7va6kXa9OWWJPbIC8Q6MuPQf6SOmKrjn1svoUyMBXSvmtyrO7HLN7/?=
 =?us-ascii?Q?r4aXi6CtMzabkZPQLwHUAkJK/V5D9OUag3OdZ6ZZiSQhvZ+T8wX5YQyayeS0?=
 =?us-ascii?Q?LRpqPoO3ZSXxH7PnKip2s6BZu62+3A6jYSRMcueOkjh2eBOrhdmQmkJyuiHL?=
 =?us-ascii?Q?GG/x8HT3oEOtherclddcMOTMsR4kzi/9c1o22uack5qmgxTuoB07fwuyKg1L?=
 =?us-ascii?Q?scP5OIBDS90cVvL2fd0Yx0IBQZEASTqa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?exoyKJ+d4mpbyoIYn7aZxl1nalj1/Cx19nKF4J1GUVW/QO/FJ1i1Qpa+LIQh?=
 =?us-ascii?Q?2nJTame7YiHj0yaqoW68aSHwt4RDFnxsGrfSaxzGjyhT2Q2N3fW4C/ItVbjM?=
 =?us-ascii?Q?ihAZjDdiupWNHrW2/RznNBnaYBd1s06Ss5NuPqDeTClrphsTd4hsgN7IXoYh?=
 =?us-ascii?Q?Y7sQ9uyZ1luSnVdcEkt2yF6q0LpmZ7pF0pojluZ1eney/N5PTnPfx568L/tu?=
 =?us-ascii?Q?xXHJTH4tT20SWHiIsMDwfDACj3Q6p8we0Yh8nbAnJckzyad5CvVHeY9cqZ68?=
 =?us-ascii?Q?RlNsEr8eU4pImJoKEASFjVxsnSiHa3jfVdFNXZdHNEg3PuxttecKDvuoDg1U?=
 =?us-ascii?Q?Nf7PoTWXT9zNuUQqszgpswr10SVbOLCqFbA7UeOZk8TywiL7/66qWmXJjgPb?=
 =?us-ascii?Q?jlia6SHVUNeslxRmc5YCe/FO/uQ2I8WzXQjNwU5VhXYCUq8KLUo8H4Ljmcr2?=
 =?us-ascii?Q?6VH0ugZ7MytaLZ1LsXaHwkrOm9mBAJYvdn6KSz8zKV6l8nPSFMyUe2iQI0Sl?=
 =?us-ascii?Q?4+pQ9t3MaTCaeH7R67WZqmFsTNUDNDvos7dnSMm7n0r9VAVG49M7OFt0Fxej?=
 =?us-ascii?Q?P09yNRk3gqKzaJ0PqyEmD65KHzE6yFyKjxE4pTXS9OXcorXjZj7RhgU0qm6j?=
 =?us-ascii?Q?hyUvcG4Zme+QqD/m0V5ylgUZgBvK+as4BE4V1sWa+VihOmYYZaYpZ4eC6w5b?=
 =?us-ascii?Q?GyvTmTADQHh5eClzdeZTcelmd8AS6+seOOYh3cHiu1YnOobbrRr1E/eC6shw?=
 =?us-ascii?Q?hSX5IGxHCCuOU3axmXP88qIV06BwKoRFgW+RnieUw57cGfduQK/jQNPn97bf?=
 =?us-ascii?Q?uxz9rBed/bqY7ulGfXkqUNuLEY+em9Qjg3GBROe6vRgyOCN7hP/PSCMzDFO8?=
 =?us-ascii?Q?1IhmFW9rzeS0v4eVwjzQyX1BTt/KWmcfGqIcq7DgMCMESf7H75ThlBIpDwh1?=
 =?us-ascii?Q?trrsefWe12LCWt0Ry0avp3hYthXmXMSGf7rnQy84DLs9ApEQt/k8Xz1yVm++?=
 =?us-ascii?Q?Fk0OSpGn81GJojqCdrE/Zlc99N9ukGL19nJuICXb/xxCPvAMSyQPqRRF5/v7?=
 =?us-ascii?Q?pVs4gfgmQDBinmuYe1zAzt3W5wfLaowN5T0x0JDsmWXySviqljh1mz3d/nK3?=
 =?us-ascii?Q?ssqA+ELCu2FwD5mvQI9CdTJbUtX7pJarjrP1Q2GT6z+SNiEqfs8Ljkt5hZ6i?=
 =?us-ascii?Q?1dNMOPnL0CwXdybnWFl78Ak4C5mmHWUmp67q85AVQnBfz8umPaSI752Z7CFF?=
 =?us-ascii?Q?G092kQYHaKbFMuil8rINqFsu0ywkkloY7+aZJ8txXjnB2mcfsg4HtZhYBbYI?=
 =?us-ascii?Q?H+gIczuSPh1pjcjM4cey6WxBDvScY5DbMiwZc4zQD6qGFKxGFMEBYdhLYPwa?=
 =?us-ascii?Q?SksIx1O28UTRZGwxXY+oTGqfjkrhVsQ8FZ18/9Bbms07EYFcYByE2ExC0GZr?=
 =?us-ascii?Q?AbsLAbEfhtqOHSO25iffThBaA6R2Si3iL255w90rDKyj7nfFwe5sAfy8dHik?=
 =?us-ascii?Q?Xy49ck/MfPXujem1UF4cFEOSMXgFHlyKZtL5pCSVesDJoZaTJlfmTxiW16CR?=
 =?us-ascii?Q?aXGgSytPRL4DKM5nOfY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8434069a-9353-4191-14d5-08de2771ad54
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 13:43:54.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azE8+yDor851gV5vHEOAgmCVqRxD/ZpE/16U74BdWd7UVDnUBcLEqEfpBV2W+GAb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314

On Wed, Nov 19, 2025 at 04:20:28PM +0530, Vasant Hegde wrote:
> > diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> > index f2991c11867c..9375fba1071c 100644
> > --- a/drivers/iommu/amd/init.c
> > +++ b/drivers/iommu/amd/init.c
> > @@ -1136,9 +1136,13 @@ static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
> >  static bool __reuse_device_table(struct amd_iommu *iommu)
> >  {
> >  	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
> > -	u32 lo, hi, old_devtb_size;
> > +	struct dev_table_entry *old_dev_tbl_entry;
> > +	u32 lo, hi, old_devtb_size, devid;
> >  	phys_addr_t old_devtb_phys;
> > +	u16 dom_id;
> > +	bool dte_v;
> >  	u64 entry;
> > +	int ret;
> >  
> >  	/* Each IOMMU use separate device table with the same size */
> >  	lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
> > @@ -1173,6 +1177,25 @@ static bool __reuse_device_table(struct amd_iommu *iommu)
> >  		return false;
> >  	}
> >  
> > +	for (devid = 0; devid <= pci_seg->last_bdf; devid++) {
> > +		old_dev_tbl_entry = &pci_seg->old_dev_tbl_cpy[devid];
> > +		dte_v = old_dev_tbl_entry->data[0] & DTE_FLAG_V;
> > +		dom_id = old_dev_tbl_entry->data[1] & DEV_DOMID_MASK;
> > +
> > +		if (!dte_v || !dom_id)
> > +			continue;
> > +		/*
> > +		 * ID reseveration can fail with -ENOSPC when there
> > +		 * are multiple devices present in the same domain,
> > +		 * hence check only for -ENOMEM.
> > +		 */
> > +		ret = ida_alloc_range(&pdom_ids, dom_id, dom_id, GFP_ATOMIC);

Is it really an atomic context? Why?

> > +		if (ret == -ENOMEM) {
> > +			pr_err("Failed to reserve domain ID 0x%x\n", dom_id);
> > +			return false;

Please don't print on ENOMEM, there is already a print.

I think you should also keep iterating as other dom_ids may still be
fit in already allocated bitmaps. Though the system is probably toast
if this happens anyhow.

Jason
