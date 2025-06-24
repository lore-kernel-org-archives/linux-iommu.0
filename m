Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF571F463B
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750747373; cv=none; b=Cpi4B+LiEATneBUIpax+c3Rk2U7ql/IKiKhYX9U+sYG+UAdrqaRla4sTTXl5WD8bApox5WoHKJcQDllAzBnwEp8tNwd8NvfhQlhthdlIK6pMr/AxXANFo3JkYRbf/ZYuMfTt3OleHhloo8FxzuhMBMEEmOg0MNc7JKsNZifKGAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750747373; c=relaxed/simple;
	bh=onLRsAPAlqNyYp1MJ0vIrTl+4YIOU0c9R/hbGwqKhJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4/GHg8HgD81ZmjW8TONEU2EKiL2KthY51hNw5n2ovDon9NlulpUD4blaykcIQm18fMIC7c9/GPESLZO82G0fBUfo2LbudbClscy6R0fFJeCJgZl6NSQWZngxWANvPgmiccLvyPBM12naTUZngYLc0iBIHGpGiT2Ra+tfQVODC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnVdFEuJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnVdFEuJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750747371; x=1782283371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=onLRsAPAlqNyYp1MJ0vIrTl+4YIOU0c9R/hbGwqKhJs=;
  b=bnVdFEuJXaFTWy+axihK6klOLelJGeRzFhZMDAmUvVK5a4r/5FoSuUP6
   qydk0goMTwNLwPZYIKSYUzlgw7vA4n+Kdcjy84tr18OgkE300hqGEjyEf
   BoluzsjafiRjyDSUoXfn09gFY/OjxOYHSPFNlBODkbWhr7lIrUn3wUwMj
   XaY6OYzvqCtuCtToKar3xP7u1SU9+86DxU2RnO8zwbF+ooWgepqzU1V19
   /ZBpfdLkDjOU+fDYlu7vMvUV4bPzK4hIfi5bvytWicv8BUJqumLrnHkl0
   9wxKKqCbSvR1KK3ZwQYbPI42DtQtW1AVJHzx8dtUZODqa2tmqW5EKnUgM
   Q==;
X-CSE-ConnectionGUID: odijikTISUW4FZrtixGASA==
X-CSE-MsgGUID: mpfVJWQURvelG2tw0B62gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56778567"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="56778567"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 23:42:51 -0700
X-CSE-ConnectionGUID: zIIJLWnkSvePKeiZ+NRlUw==
X-CSE-MsgGUID: LTi3RoF9Rq+ChNs3lCwJLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="151583142"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 23 Jun 2025 23:42:47 -0700
Date: Tue, 24 Jun 2025 14:35:14 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, will@kernel.org,
	aneesh.kumar@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	shuah@kernel.org, nicolinc@nvidia.com, aik@amd.com,
	dan.j.williams@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 2/4] iommufd/viommu: Fix the uninitialized
 iommufd_vdevice::ictx
Message-ID: <aFpHInZwCC2N34Fh@yilunxu-OptiPlex-7050>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-3-yilun.xu@linux.intel.com>
 <ff1a3fc1-3671-4cff-917f-5ea44bd2451e@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff1a3fc1-3671-4cff-917f-5ea44bd2451e@linux.intel.com>

On Tue, Jun 24, 2025 at 11:24:02AM +0800, Baolu Lu wrote:
> On 6/23/25 17:49, Xu Yilun wrote:
> > Fix the uninitialized iommufd_vdevice::ictx. No code was using this
> > field before, but later vdevice will use it to sync up with idevice on
> > destroy paths.
> > 
> > Fixes: 0ce5c2477af2 ("iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and IOMMU_VDEVICE_ALLOC ioctl")
> > Cc:<stable@vger.kernel.org>
> > Signed-off-by: Xu Yilun<yilun.xu@linux.intel.com>
> > ---
> >   drivers/iommu/iommufd/viommu.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> > index 01df2b985f02..4577b88c8560 100644
> > --- a/drivers/iommu/iommufd/viommu.c
> > +++ b/drivers/iommu/iommufd/viommu.c
> > @@ -130,6 +130,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
> >   		goto out_put_idev;
> >   	}
> > +	vdev->ictx = ucmd->ictx;
> 
> iommufd_vdevice::ictx has been removed by this commit:
> 
> 6e235a772199 ("iommufd: Drop unused ictx in struct iommufd_vdevice")
> 
> in linux-next.

Ah, I see the thread. This patch should be dropped.

Thanks,
Yilun

> 
> Thanks,
> baolu
