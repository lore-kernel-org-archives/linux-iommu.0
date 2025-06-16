Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24B01B4F08
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 06:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750053972; cv=none; b=UakHWVvQOeSgFKjUIrKSMYWMjXxZn0li53daD2bBo/1b9yierQqmMat3x+aMgfoFsChk+398q2ZL/sNx2nlw2y2uOlO888sKPsJ8KjmDscQJfV3Snj0T2gvN8kHhuSjBC/caxQd2vH3WwCPenmPr70EW4XBOPjXNhmUhfDrNrM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750053972; c=relaxed/simple;
	bh=WoYUkXX5dEjpc4Q8CoOZKqyAvikm7ooh9iJLKMzKBh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNe4eR2pmZUL236XnoHvCRqhv6z9Ybk/SkRFD4I4rjdpM7Z8Uzx/HFrfM05rSdM1lQaoOloTbexVOYxtPbw48+QmPf5JeNZQcbhjeQG5POTf6qwvud38wQ2xKksgPfRKSMt5BC9H2x2HwAhh7ROYbGETamaSG+OuOYmUp8FBk2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hofiwx60; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hofiwx60"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750053971; x=1781589971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WoYUkXX5dEjpc4Q8CoOZKqyAvikm7ooh9iJLKMzKBh0=;
  b=hofiwx60WZvOLHzpElIUoiCv9FTx7+fAAXovp0jLFHq5qfpnDcmn16ld
   qq1ccvAoVqAA2dQ/32k6vzWQGSf/Ua+6u9QyNx94VBT0eUY1h0ffRf4Pv
   lJSDpLIDFYXOdENgVKeSXXL8URw1HsgHqnaGj5aiw+pPYVILjp4BM620s
   4ituuuKu5vUIrbjFXWoch7NDyl0phDmwEbGuerP6TctOviXD7uH60BLc0
   ELPLJOY7lAtqsabewlvK9oyKPw8l4hqjTLiCGqO6h0dmJro2ZyTMecKvI
   7660auQs3x4reeD4Dx0iSlGzREV2PsVlLmyZ59y/gsp5smMhr9PnyxCr0
   w==;
X-CSE-ConnectionGUID: Sy2z6ltPSaqmisI7cEaY+g==
X-CSE-MsgGUID: Y1N6yEzzTVi3R1tLU4u5Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52054628"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52054628"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:06:10 -0700
X-CSE-ConnectionGUID: A/Rc44HlRnaa603Q+EDAWA==
X-CSE-MsgGUID: +ApACYJ3RIiM6TTrple6+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148839611"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 15 Jun 2025 23:06:08 -0700
Date: Mon, 16 Jun 2025 13:58:58 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Message-ID: <aE+yopQb5T8VWk0i@yilunxu-OptiPlex-7050>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <yq5a8qlstht5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a8qlstht5.fsf@kernel.org>

> While vdevice objects can still be explicitly destroyed using
> iommufd_destroy(), with this patch, if the idevice is still bound,
> attempting to destroy the vdevice will return EBUSY.

I didn't get the necessity of this restriction. A vdev could not
outlive idev, but it could be ended earlier than idev, isn't it?

> 
> In effect, the change ensures that once a vdevice is created, its
> lifecycle is tied to that of the idevice.
