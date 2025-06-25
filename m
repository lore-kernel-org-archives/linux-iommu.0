Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE36520E01E
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836735; cv=none; b=ESf1ujNwa6Ov2USlpp1HdEXLrFDB72YkyZOX2P6oPZImwmZF7j89QrBGG+a8hIYwssgtTazlTe6XQNulcrnDXCMDbQXHFSnBoGuz1quUGJXPP4gjT84f010g7jiTjDL/jkiu0VJCFensBg4ENXVJ+tfZAxZSMIeT9WlnU39W03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836735; c=relaxed/simple;
	bh=t3Wq1fod3wQxTIEB7OP08UfQKVsMYS8GGGHFeuqKWo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcSYo0cUgK0s+yra46hOOkwHY2S0vvKTEpXesyYBv59/whe0dt+AaSC/ZerDLdmpnwQI5nr1HI0f5zr4mteuqZMCu0vfjDc4C5N2L+NKbtJjVxEFme1G5mo5l9DC6KA8M54qB2mrFF8d2chdQwI0/F7HifUOBkcpQnuVpRluPJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LP2hvVn0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LP2hvVn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750836734; x=1782372734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t3Wq1fod3wQxTIEB7OP08UfQKVsMYS8GGGHFeuqKWo8=;
  b=LP2hvVn0/nDjednflOWr0WwfXHGhfKKELOo+KTRNCvb2G8t+jbejEKWM
   vqx1u+gDFYyF+2y3KDY7gmu9p0Bn4tebVI1bIRc7hGrrMmQatGor9ZKea
   rV9VF16ihvaCVQQAltMmADYtm3ZKlRU0S5in9qfDivU1jkSeX/8+2XHpx
   qUWyiIZUaS2Y3vspo1pFbzmaKAUErFGhPq9xi8w3ZDCI3CoN4I2TT1t+7
   nD2Me171u+9SSyw3WRuarhJyc/hw/WKH+USXXr5sWf8QEseC6jeB/eTIy
   pkkAKvPrpCU2N9xvurDNTT0Ec5ENoROc86Scu4bdg2TH4PXNsEeDIVImT
   Q==;
X-CSE-ConnectionGUID: KePTkGzwQma+H1PjwWxvVg==
X-CSE-MsgGUID: oIC/TM+YTBW3ifZLec4nzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53159726"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53159726"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 00:32:13 -0700
X-CSE-ConnectionGUID: JvsPcGPVTo+HbZDMSRX4ag==
X-CSE-MsgGUID: KVSJEOu9TWuvEHkw4tR7qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="152629995"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 25 Jun 2025 00:32:09 -0700
Date: Wed, 25 Jun 2025 15:24:33 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 1/4] iommufd: Add iommufd_object_tombstone_user()
 helper
Message-ID: <aFukMWTmupyHXCxw@yilunxu-OptiPlex-7050>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-2-yilun.xu@linux.intel.com>
 <20250624133520.GA150753@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624133520.GA150753@nvidia.com>

On Tue, Jun 24, 2025 at 10:35:20AM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 23, 2025 at 05:49:43PM +0800, Xu Yilun wrote:
> > @@ -251,16 +252,30 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
> >  	 */
> >  	while (!xa_empty(&ictx->objects)) {
> >  		unsigned int destroyed = 0;
> > -		unsigned long index;
> >  
> > -		xa_for_each(&ictx->objects, index, obj) {
> > -			if (!refcount_dec_if_one(&obj->users))
> > -				continue;
> 
> I don't think you need all these changes..
> 
> xa_for_each will skip the XA_ZERO_ENTRIES because it won't return NULL
> 
> xa_empty() will fail, but just remove it.
> 
> @@ -288,6 +288,7 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
>         struct iommufd_sw_msi_map *next;
>         struct iommufd_sw_msi_map *cur;
>         struct iommufd_object *obj;
> +       bool empty;
>  
>         /*
>          * The objects in the xarray form a graph of "users" counts, and we have
> @@ -298,11 +299,13 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
>          * until the entire list is destroyed. If this can't progress then there
>          * is some bug related to object refcounting.
>          */
> -       while (!xa_empty(&ictx->objects)) {
> +       do {
>                 unsigned int destroyed = 0;
>                 unsigned long index;
>  
> +               empty = true;
>                 xa_for_each(&ictx->objects, index, obj) {
> +                       empty = false;
>                         if (!refcount_dec_if_one(&obj->users))
>                                 continue;
>                         destroyed++;
> @@ -313,8 +316,13 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
>                 /* Bug related to users refcount */
>                 if (WARN_ON(!destroyed))
>                         break;
> -       }
> -       WARN_ON(!xa_empty(&ictx->groups));
> +       } while (!empty);
> +
> +       /*
> +        * There may be some tombstones left over from
> +        * iommufd_object_tombstone_user()
> +        */
> +       xa_destroy(&ictx->groups);

I'm good to it. I was obsessed to ensure the xarray super clean.

Thanks,
Yilun

> 
> 
> Jason
