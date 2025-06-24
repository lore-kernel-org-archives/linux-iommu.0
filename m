Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338751DB346
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753154; cv=none; b=Q80ABkjpZyQgGRkM6JXCcc3t4vFMF5fQHiBrN+D+KAzIOTjvRgAmdKzNPz75rWBl0fV4+/1EpellWta7+JXVx6HXpWcspetSwVEJPdnRm+5OankBJEtj7NbhS66DUpHFGzaauN4DLa0uNon6Du0zk4iuWw2Ot7o1+myASQCmmXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753154; c=relaxed/simple;
	bh=veO6F7myXH23/l8pZJTYL/+cG25MIh24hmrup24rlgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p779shy6LIYI1F+XwY++6UnGM7O3TGMurKPruTzmeCLqEnVOHXZR62Ws2cdt/GdE2uXuMhFDKP0EauQ7RPbo2K2mwNZf9tsRgG7fXXlCkkPZt5FLaiuOlBgy3ppGcD7tAj9Xi6eIJ1mSJgwpoItbxjQwdnYr3lGdVyDe0WvpCbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JdD8YJ+r; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JdD8YJ+r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750753154; x=1782289154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=veO6F7myXH23/l8pZJTYL/+cG25MIh24hmrup24rlgk=;
  b=JdD8YJ+rD+Zel+VKZ530ockgPHAX9nZAere5bUa+HWlKByLtiSDPIpAh
   y+3c1atvFsg1PbzQEHthJdJ70iKzVymXUT/kc63JbF1t1PbYTSUdwy6wh
   OsTvULXzyG2zZNy2Lb54uj/QpCdCYjmveoFh0eyl4nA3NKr4sC4KICQv9
   3QI5lH90IfUBBgeZuAGSZme0sLV1/wtUwgVPs8wRJ7XR3v/lVL+SQs6EH
   OKNlEQO57/c9Yow7zz9SyiBLUCBs/ZHwmUYCMZHkZljj5sJbprS5PYF3F
   VcNTQBBrt2bu0/zlKQGk7BlVOcUMty0vC3oQ3mnE9vjPY/OqlmXe7ZvwE
   Q==;
X-CSE-ConnectionGUID: EHmYssFWQhqv7/s8HqBi6A==
X-CSE-MsgGUID: G3FKiTj1S6CCOP1dnnUVkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56763969"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="56763969"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:19:13 -0700
X-CSE-ConnectionGUID: Z0lLToT4SLOs3MmC/TtBig==
X-CSE-MsgGUID: g5OKnNdiScmqzJCM8VFGmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="151986381"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2025 01:19:09 -0700
Date: Tue, 24 Jun 2025 16:11:36 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, will@kernel.org,
	aneesh.kumar@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	shuah@kernel.org, nicolinc@nvidia.com, aik@amd.com,
	dan.j.williams@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aFpduJmdcru6r1kd@yilunxu-OptiPlex-7050>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
 <a2fddab4-bc85-46f6-9008-57a26e099698@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2fddab4-bc85-46f6-9008-57a26e099698@linux.intel.com>

On Tue, Jun 24, 2025 at 11:32:01AM +0800, Baolu Lu wrote:
> On 6/23/25 17:49, Xu Yilun wrote:
> > Destroy iommufd_vdevice(vdev) on iommufd_idevice(idev) destroy so that
> > vdev can't outlive idev.
> > 
> > iommufd_device(idev) represents the physical device bound to iommufd,
> > while the iommufd_vdevice(vdev) represents the virtual instance of the
> > physical device in the VM. The lifecycle of the vdev should not be
> > longer than idev. This doesn't cause real problem on existing use cases
> > cause vdev doesn't impact the physical device, only provides
> > virtualization information. But to extend vdev for Confidential
> > Computing(CC), there are needs to do secure configuration for the vdev,
> > e.g. TSM Bind/Unbind. These configurations should be rolled back on idev
> > destroy, or the external driver(VFIO) functionality may be impact.
> > 
> > Building the association between idev & vdev requires the two objects
> > pointing each other, but not referencing each other.
> 
> Does this mean each idevice can have at most a single vdevice? Is it

Yes, I got this idea from here.

https://lore.kernel.org/all/20250604132403.GJ5028@nvidia.com/

> possible that different PASIDs of a physical device are assigned to
> userspace for different purposes, such that there is a need for multiple
> vdevices per idevice?

Mm.. I don't have a clear idea how SIOV assignment work with iommufd,
may come back later.

Thanks,
Yilun
