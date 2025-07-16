Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE49B10A1E
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647524; cv=none; b=iJyanenw5QoziFJdQuPJxaiivvo71zPVJLPQ/PjyapO4IhsN0L+uA7amYId9y+SuQCZJYyTXrCyZh81qSHhQXC0eyqemUNs98s/5Deb5MGegfCh7qqtshoZkDURS+7GJ3BjM7J/2/vYgdTZxov1NrLq1vQBWNAtdHAwXkGZDTYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647524; c=relaxed/simple;
	bh=imm/+zFHL6k4p1kZN5seAA5QdejLU0QF71JKzXeJy9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVuHs8+wMaEG5Wahtq5tiaIyQzlZT7hVodv/WUOPtPrmeB/FkEJR5mNEfmnt8/FWzhaOE9pJ5/8UFm2wq3a5edPbSZUi9Cm0taYh5CHJn3IAeMPJ8ePhricUtJsmHvlmB5c0clKYFM8bgEnknCoJJWMNpJaq+TEv/FU0QenfoO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WIRrLW1z; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WIRrLW1z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752647522; x=1784183522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=imm/+zFHL6k4p1kZN5seAA5QdejLU0QF71JKzXeJy9w=;
  b=WIRrLW1zY9FnFny7KPFxefbSnhtG1Um5kf+tFy6kfDidAlszG6uNGMUU
   dmsRE+OMLYW+D6neQ+GbWWK+j6hOkNfSNqvkKPfkSVySHuX2MfuDjRAeF
   3I4wEuircmDcMgrEOJsV3zADMyGJdkJQWzY9mnM37X+C5tpCr41aJXFb/
   SxTgYJITkD4VuLjI/UPmTjqhxnlDAWdVGn43GHRbrz48szBqMYkKMxAKx
   soZFWMbhkgQ3QY3UOFl2ZxJhP7Kn3zFmnqjotiAguc1+L1GWGuLC/htpa
   VO6dLustmZU7DxuitDx0C5xedaarIiU9xZ4V9pgr4ARZt6Ep5Fz4l/FNR
   w==;
X-CSE-ConnectionGUID: Cw2xsSt1Sny6Vq3sNlMPgw==
X-CSE-MsgGUID: vk3VOihvRb201w0kzl6cog==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65452190"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="65452190"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 23:32:02 -0700
X-CSE-ConnectionGUID: TPzuENZaQcGJXfu0ZN5p8Q==
X-CSE-MsgGUID: Rmz3bugySfCrICXilS2iJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157916648"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 15 Jul 2025 23:31:58 -0700
Date: Wed, 16 Jul 2025 14:23:21 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com, will@kernel.org,
	aneesh.kumar@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	shuah@kernel.org, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v5 6/8] iommufd/selftest: Explicitly skip tests for
 inapplicable variant
Message-ID: <aHdFWV9k9M7tRpD0@yilunxu-OptiPlex-7050>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
 <20250715063245.1799534-7-yilun.xu@linux.intel.com>
 <aHaoRAfClCoCtm21@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHaoRAfClCoCtm21@Asurada-Nvidia>

On Tue, Jul 15, 2025 at 12:13:08PM -0700, Nicolin Chen wrote:
> On Tue, Jul 15, 2025 at 02:32:43PM +0800, Xu Yilun wrote:
> 
> Two nits:
> 
> > +	test_ioctl_fault_alloc(&fault_id, &fault_fd);
> > +	test_err_hwpt_alloc_iopf(ENOENT, dev_id, viommu_id, UINT32_MAX,
> > +				 IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
> > +				 IOMMU_HWPT_DATA_SELFTEST, &data,
> > +				 sizeof(data));
> 
> sizeof(data) could fit into previous line.
> 
> > +	test_cmd_hwpt_alloc_iopf(dev_id, viommu_id, fault_id,
> > +				 IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
> > +				 IOMMU_HWPT_DATA_SELFTEST, &data,
> > +				 sizeof(data));
> 
> Ditto

Yes clang-format does change like this, but I didn't want them pass 80
columns.

Anyway, applied your changes.

Thanks,
Yilun

> 
> Thanks
> Nicolin
