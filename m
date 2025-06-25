Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE08626C38D
	for <iommu@lists.linux.dev>; Wed, 25 Jun 2025 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840669; cv=none; b=XuUBjzpGr9wsD8Ac0HjJQclBAbSDeqqbQAfikguYoorqERp3TmnJm9lWZcvVRE3gOQPKT2qwTmVCr0fQGofoqXXS/GTD3wS7hcsGIJEjOVYFkiMw8S639hMaewd5aJcJttRbyYC8unOpBctihO1U+hO8qRNeaoChIbJ4CFjw6NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840669; c=relaxed/simple;
	bh=EwvPZo7oTwprahWbVv9CKBqzmPZmEw39Hs2j42qQ/og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GH3odMgDe0AydpuuA/i3GsDcsRVhUMNawfRqxBnJb9/r2pdif8sPdkqQoZ8oyWqbYL4onrPvlyPWmbkbRGazysub0ZbrbKxXacQaD28bXA8e4Y3I5Ln/O7frMDhJcuKBmjfgBgZkID/M8VSI9fNzGkWCZs18qJxTEWkgtGGJtm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hubp5UU3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hubp5UU3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750840668; x=1782376668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EwvPZo7oTwprahWbVv9CKBqzmPZmEw39Hs2j42qQ/og=;
  b=hubp5UU38PSXiCuc7fNociJgOLGw26qbE3CshVPjlwfbIdGVb3J9FoND
   7oJguUliiX1wzDt1XrKSHn7pbA7luAvvLiayS79S/qL02ERd6o7eV7YHt
   MDxKDTluELgWP3TpUoPlKEPgGGtM51uWrHiTHfdWmTTw0QTeKPui9/Glk
   7TUkcEaXDjhuZbrYwQtvkp5MbOQfypqWd+NxCtdYz6uNgmuZXziEqKsrk
   X10DZ14Pdws8P5paZROZMgUayC2qqY7/egtliEkTRoUFlrzYWPKpMSNmq
   W8esqrw6//Z/nrnTvMHnMXiR8U/T+4MZxgUTF3GORfoPrZRJuQDz11MMT
   Q==;
X-CSE-ConnectionGUID: b3FVGParTtqYJpvhlfC2+Q==
X-CSE-MsgGUID: LF/j0nhGRPiXdNEhLkmmjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52973199"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="52973199"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 01:37:39 -0700
X-CSE-ConnectionGUID: whELoIkaQLOb2fMkjiX5Eg==
X-CSE-MsgGUID: WWOHAobDSV6gRb7pT1MS+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="156186620"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jun 2025 01:37:36 -0700
Date: Wed, 25 Jun 2025 16:29:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 4/4] iommufd/selftest: Add coverage for vdevice
 tombstone
Message-ID: <aFuzh4OPmjfemD8I@yilunxu-OptiPlex-7050>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-5-yilun.xu@linux.intel.com>
 <20250624134145.GB150753@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624134145.GB150753@nvidia.com>

On Tue, Jun 24, 2025 at 10:41:45AM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 23, 2025 at 05:49:46PM +0800, Xu Yilun wrote:
> > diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> > index 1a8e85afe9aa..092e1344447e 100644
> > --- a/tools/testing/selftests/iommu/iommufd.c
> > +++ b/tools/testing/selftests/iommu/iommufd.c
> > @@ -3014,6 +3014,19 @@ TEST_F(iommufd_viommu, vdevice_cache)
> >  	}
> >  }
> >  
> > +TEST_F(iommufd_viommu, vdevice_tombstone)
> > +{
> > +	uint32_t viommu_id = self->viommu_id;
> > +	uint32_t dev_id = self->device_id;
> > +	uint32_t vdev_id = 0;
> > +
> > +	if (dev_id) {
> 
> Why the if? The test should work or skip, not silently skip.
> 
> self->device_id is setup by the fixture, it can't be absent.

It can, when the variant no_viommu.

I agree this should not be silently skipped, see below changes:
Should also apply to viommu_alloc_nested_iopf, vdevice_cache.

+TEST_F(iommufd_viommu, vdevice_tombstone)
+{
+       uint32_t viommu_id = self->viommu_id;
+       uint32_t dev_id = self->device_id;
+       uint32_t vdev_id = 0;
+
+       if (!dev_id)
+               SKIP(return, "Skipping test for variant no_viommu");
+
+       test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+       test_ioctl_destroy(self->stdev_id);
+       EXPECT_ERRNO(ENOENT, _test_ioctl_destroy(self->fd, vdev_id));
+}

Thanks,
Yilun

> 
> Jason
