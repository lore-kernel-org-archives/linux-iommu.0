Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D82A13A244
	for <iommu@lists.linux.dev>; Mon,  7 Jul 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751917791; cv=none; b=GDBReDhU0Kk1kgZAfd9drQqrTJ8F5GxfQtOyoooyNFZYtmW9EPThqlqksqxWkY+YXOD+pdKdIjQvKib9vp0lYb+qz+7EofSHit/EV1A653bipbN6jYtXdYd2jMfrUrceTgRFqWO7qa2qp2ImTMRilnCYgmimY4+dEdkCeYsaJtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751917791; c=relaxed/simple;
	bh=Bsc0l4oYKWpP++YJU/xfMtGDktQZziYr7xF8Xf+mvNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/1tImCJCls6gSyIWHkt0mOA+AD+ydNF1Dm95n/78krMxZ8s/GM252XL3D09wqn4qTyLzqptXW4LIfldyEc9X+Ai3UX/Bp7XSVnbVxLS7LXotZmkwam+tSGiuYNuFVaLVghAKJVi/EcFkjEJsiV6gK1ntHD9c1dr0p8NoIqmpFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CC3MIV32; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CC3MIV32"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751917790; x=1783453790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bsc0l4oYKWpP++YJU/xfMtGDktQZziYr7xF8Xf+mvNQ=;
  b=CC3MIV32WOsZx2iPQeAggW+NsBaxpJNU4SQLjEwqBc/KswvJHHbP6dWO
   HqM7D6R+ikDHf3wquGtT8w16Ec9h+UrE6MaoWRc3gsxvK2F71KdFFc2JO
   6kLXRKAX6p5vgGrSG2bwNLkWeVJaoGH5WT401S4oJKMBznpdabCfG+n90
   L9TXt+T59AyCAGWkGZT+Fri4xYZxCgN3cbgwPFPOJhuPGA99ktd1raDbc
   sqAh+47hP9LeO6XxmjVMdJQtM7X7hQN0kLKPLTuVsq0EOMnJxSjVCPox3
   mBxutyBukpB0pBKtGjQSCFqd94n8LBDFtSTpmouDN3QrGatQTECQuai4X
   Q==;
X-CSE-ConnectionGUID: QbMbHniQTiaFbG++Vj3h0A==
X-CSE-MsgGUID: 4OrXaNPgSMOkKh/kB7CumQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54032736"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="54032736"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:49:50 -0700
X-CSE-ConnectionGUID: Z1V7/n3HQBKr3e19/Ska5A==
X-CSE-MsgGUID: dsY7G08CQ9KxgbMOb1YOHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="155425105"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 07 Jul 2025 12:49:46 -0700
Date: Tue, 8 Jul 2025 03:41:33 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>
Subject: Re: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aGwi7fMVIOmALSz7@yilunxu-OptiPlex-7050>
References: <BL1PR11MB52712CE938B57E41C34580908C46A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <aGJkitx6wjfQ888t@yilunxu-OptiPlex-7050>
 <20250630145051.GY167785@nvidia.com>
 <aGOoCa3BkV7KrwVz@yilunxu-OptiPlex-7050>
 <20250701121315.GD167785@nvidia.com>
 <aGSYLVmV17g832Ta@yilunxu-OptiPlex-7050>
 <BN9PR11MB52769790C63FFCDC711E80DB8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250702124042.GD1051729@nvidia.com>
 <aGuoZUaNOgclC2uU@yilunxu-OptiPlex-7050>
 <20250707122502.GS1410929@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707122502.GS1410929@nvidia.com>

On Mon, Jul 07, 2025 at 09:25:02AM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 07, 2025 at 06:58:45PM +0800, Xu Yilun wrote:
> 
> > I still see concerns here. The pre_destroy() and wait_event is before the
> > idev's users count decreasing to 0, which means a new user could get
> > in.
> 
> Hum, yes it seems we could get a race with another vdevice being
> created during idevice destruction, but I think this could be fixed in
> a straightforward way with a flag 'being destroyed' in the idev under
> the lock if it is the only issue
> 
> > The worse thing is the new user could hold the shortterm_users until
> > pre_destroy(), but there isn't a second pre_destroy()...
> 
> This is OK, the point of pre_destroy is to remove the reference
> cycle. So it needs to prevent new vdevs from establishing references
> and remove the reference from any existing vdev.
> 
> refcounts outside of this cycle are handled by the existing
> mechanisms - pre_destroy is only about the refcount loop.

That works for me. I didn't prefer a being destroyed flag cause it
seems not align with the current refcounting mechanism. But I see it
makes sense cause idev does deterministic destruction.

The only concern is idev cannot actually prevent new reference by
itself, need vdev to honor the flag. But just keep simple, don't
over-engineering.

Thanks,
Yilun

> 
> > I think extending the life of shortterm_users at runtime makes things
> > complex. 
> 
> Well, it keeps the refcounting working the way it is supposed
> to. Holding a pointer without a reference is nasty and is creating
> alot of these weird problems and strange flows. Hold the refcount
> along with the pointer and things follow the normal patterns.
> 
> There is nothing inherently wrong with shortterm users for this
> besides its name. Think of it is as 'wait for users', and we clearly
> want to wait for the vdev user to put back its idev reference.
> 
