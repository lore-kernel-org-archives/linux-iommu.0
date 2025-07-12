Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB0288C92
	for <iommu@lists.linux.dev>; Sat, 12 Jul 2025 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752342978; cv=none; b=QZZKrUYBtaCGDIpBmF4DRRjmnFWE7M2scA5kgVYXDnJtD5SVGeF7A+vlybycqoyfH/OK9kzclPh5/8sbyFJrWvEpv6pX4e3bB2BuM86yVHo3M8CvyfXQ2XI4Dxfy+09ZNYmLaGouaJkhhsSVJ7HGJPuCQdZA9hOU0jcHSZqPl5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752342978; c=relaxed/simple;
	bh=O7150iv3cjqnWvZNJGwC3U69P0vBAIhio+CRzpLyvP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tn5ysIzwL7Xsbt0vYuUQ8mopiiGJPx3YFBzewJbRVUKsqTNMaRgjhqe1keNX2xpuTIXNI+2avXJnUC3g/2F0oP9JI2Q6cINTQ1XJ+vEKoJ2+VyCkelGuVe1EnRysSB6+Pal0/WEUOu2cdItWNvexPsEPGwgea/sVo7J6skFzsEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=McJeiGM1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="McJeiGM1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752342977; x=1783878977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O7150iv3cjqnWvZNJGwC3U69P0vBAIhio+CRzpLyvP8=;
  b=McJeiGM1y478U33KFdw4v9LwBLfPoVKEmupblCC10XkKWqF3CjA/Cdiv
   UakbXg1mfOuhEir1J0ytifZlmaBhGUhyX1EZTcjjWgxIry6KY3it8OEhp
   h80DP0DP4m1I0MuAjjFYDPGKPjSGVET0/WSrYu1J5s0ZUkR1ygM/helyh
   Z1Ki+7W/iE6NgUXfz44e9klmq/TdOaAHxLmzU3UsjzS87TcuJOFeYS9P+
   fq0ZCoB4CLvs6erOLujbXO2dBtnrU4Qo5IXL8jC00j6GrYP/ZsdGzTnay
   Vsq6soUup3d74vIm7O7bFZISHkvF1xHMNDL3SbLPnCW/ASqsS/0zwakz8
   g==;
X-CSE-ConnectionGUID: BnXxuGdDQhaIIY/SLH2tqg==
X-CSE-MsgGUID: FSghaBDITUWZD3MuhGuyVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65303190"
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="65303190"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 10:56:16 -0700
X-CSE-ConnectionGUID: F0yfcoVHT+CHhX1oIQIjbg==
X-CSE-MsgGUID: gblIoa7UQAibaB+7T36KXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,306,1744095600"; 
   d="scan'208";a="156405705"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 12 Jul 2025 10:56:13 -0700
Date: Sun, 13 Jul 2025 01:47:45 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, will@kernel.org,
	aneesh.kumar@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	shuah@kernel.org, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v4 4/7] iommufd: Destroy vdevice on idevice destroy
Message-ID: <aHKfwQ41x28bNWAL@yilunxu-OptiPlex-7050>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-5-yilun.xu@linux.intel.com>
 <aHHG/H6IT9lvYy8x@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHHG/H6IT9lvYy8x@Asurada-Nvidia>

> [..]
> 
> >  out_put_idev:
> > -	iommufd_put_object(ucmd->ictx, &idev->obj);
> > +	if (rc)
> > +		iommufd_put_object(ucmd->ictx, &idev->obj);
> 
> So, this actually holds both the short term user and (covertly)
> the regular user too.
> 
> Though it doesn't hurt to do that, holding the regular one seems
> to be useless, because its refcount check is way behind this new
> pre_destroy op:
> 
> 183         if (flags & REMOVE_WAIT_SHORTTERM) {                                                                                                                                                                                                                                                                                                             
> 184                 ret = iommufd_object_dec_wait_shortterm(ictx, to_destroy);
> ==>			/* pre_destroy op */
> ...
> 214         if (!refcount_dec_if_one(&obj->users)) {
> 215                 ret = -EBUSY;
> 216                 goto err_xa;
> 217         }
> 
> So, I think we could just do, exactly reflecting the comments:
> +	vdev->idev = idev;
> +	refcount_inc(&idev->obj.shortterm_users);

I think this makes things more clear, we have 3 types of refcounts:

1. shortterm_users + 1, users + 1, temporary refcount, can't be
   revoked by referenced object.
2. users + 1, long term refcount, can't be revoked either.
3. shortterm_users + 1, can be revoked by referenced object.

> 
> Then, keep the exit patch unchanged.
> out_put_idev:
> 	iommufd_put_object(ucmd->ictx, &idev->obj);

Yeah, this is the part I like the most.

Thanks,
Yilun

> 
> Thanks
> Nicolin
