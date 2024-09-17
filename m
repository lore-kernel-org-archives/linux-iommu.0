Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7407F18C22;
	Tue, 17 Sep 2024 01:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726537787; cv=none; b=cAgtWdOW/7Z/KM3z1xUoGeT+wf6YZ81kGVMMD1S1WAxKD/PSpPxbqHOu2rEYcF5ISlMt/zAe51ZMGjtE5aTyTeiv745jkyyCfBAm+DSPHQumJSZBwMRXsdjqIb7PIN66CFfOUPrwKIIP0SzPMqzOKnWGbWLDNn/78dg0emFaxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726537787; c=relaxed/simple;
	bh=Eo77KNdi/8iemFjT6AdTWrK/OwDDlJo3jkg/LP3tlvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=an6xPIA+4jO2ZpNESZI7YI4uEpbSb9CWHQPuUmSZipTGAXR0sMQfb3eWnYE7USHxXNe5T/4eEU2Oig1o5FzHyiMRcqbLXobLyxNeipUy+0W+YLZm5KuafcpLrUC34I3nh7wzJS22rziSjWYvZN/hqUgpyMeqkRWfUEKM3VtW0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9Du/XMP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9Du/XMP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726537786; x=1758073786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Eo77KNdi/8iemFjT6AdTWrK/OwDDlJo3jkg/LP3tlvI=;
  b=f9Du/XMPYKCwEW4cBs0GVacxJPIfDoMpVAN3pNyu8WDq8kuX36wd+nt/
   v2zLZvlh7yoDcSw1xuW/h7yf+Hv92rn/azq5cq9RQy2dna9Gavt1zCkn4
   EmQAOcFqc+TU5kX5uco3mimlKEa8I0OtbRYDs+EssOPhf1xmyjPzzecBa
   Sozk6QG6L3izg6DzIG2LOKOhADzJFqX/HHKE4vlDnjxzWQVgIHgedz7/w
   bHDWb+RB7MKr/VLr7YfwgXs4fvYLuLq4H4lezoeTILGeOrR8dtklZRzZb
   xSlxdahAKubnWcZym958RPCj/gXTXj/F0xP+oitMGkwnK3RSGd3ywSbMi
   g==;
X-CSE-ConnectionGUID: +AlJMOi0SW2pCw7LE5bZ9g==
X-CSE-MsgGUID: UXIHeLfETcele2nY2cTY6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="25505118"
X-IronPort-AV: E=Sophos;i="6.10,234,1719903600"; 
   d="scan'208";a="25505118"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 18:49:43 -0700
X-CSE-ConnectionGUID: frMDvjj/Tz2Ey4ppVYuKoQ==
X-CSE-MsgGUID: +VrRC8pQSDeB8SGeqHKZyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,234,1719903600"; 
   d="scan'208";a="73405347"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 Sep 2024 18:49:41 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqNLW-000Ah4-2v;
	Tue, 17 Sep 2024 01:49:38 +0000
Date: Tue, 17 Sep 2024 09:48:52 +0800
From: kernel test robot <lkp@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, iommu@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 6/9] iommufd: IOMMU_IOAS_MAP_FILE implementation
Message-ID: <202409170940.No0O836I-lkp@intel.com>
References: <1726319158-283074-7-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726319158-283074-7-git-send-email-steven.sistare@oracle.com>

Hi Steve,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.11 next-20240916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steve-Sistare/mm-gup-repin_folio_unhugely/20240914-210746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/1726319158-283074-7-git-send-email-steven.sistare%40oracle.com
patch subject: [PATCH V1 6/9] iommufd: IOMMU_IOAS_MAP_FILE implementation
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240917/202409170940.No0O836I-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240917/202409170940.No0O836I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409170940.No0O836I-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/iommufd/io_pagetable.c:458: warning: Function parameter or struct member 'ictx' not described in 'iopt_map_file_pages'
>> drivers/iommu/iommufd/io_pagetable.c:458: warning: Function parameter or struct member 'iopt' not described in 'iopt_map_file_pages'
>> drivers/iommu/iommufd/io_pagetable.c:458: warning: Function parameter or struct member 'iova' not described in 'iopt_map_file_pages'
>> drivers/iommu/iommufd/io_pagetable.c:458: warning: Function parameter or struct member 'file' not described in 'iopt_map_file_pages'
>> drivers/iommu/iommufd/io_pagetable.c:458: warning: Function parameter or struct member 'start' not described in 'iopt_map_file_pages'
>> drivers/iommu/iommufd/io_pagetable.c:458: warning: Function parameter or struct member 'length' not described in 'iopt_map_file_pages'
>> drivers/iommu/iommufd/io_pagetable.c:458: warning: Function parameter or struct member 'iommu_prot' not described in 'iopt_map_file_pages'
>> drivers/iommu/iommufd/io_pagetable.c:458: warning: Function parameter or struct member 'flags' not described in 'iopt_map_file_pages'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +458 drivers/iommu/iommufd/io_pagetable.c

   448	
   449	/**
   450	 * iopt_map_file_pages() - Like iopt_map_user_pages, but map @file starting
   451	 * at byte offset @start.
   452	 */
   453	int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
   454				unsigned long *iova,
   455				struct file *file, unsigned long start,
   456				unsigned long length, int iommu_prot,
   457				unsigned int flags)
 > 458	{
   459		struct iopt_pages *pages;
   460	
   461		pages = iopt_alloc_file_pages(file, start, length,
   462					      iommu_prot & IOMMU_WRITE);
   463		if (IS_ERR(pages))
   464			return PTR_ERR(pages);
   465		return iopt_map_common(ictx, iopt, pages, iova, length,
   466				       start - pages->start,
   467				       iommu_prot, flags);
   468	}
   469	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
