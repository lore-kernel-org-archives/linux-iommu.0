Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA7417FC
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 07:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684394555; x=1715930555;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zX4bAIy6XqORHsqEJOVqXHTkaXna/0D1YLb4g37pR50=;
  b=jdoysXn2CXdDvR+/rG5R+suhDAAn2c8D7fx5f2izIcTtmttv+3BzOdyV
   ILeJ2lYMEAjjnDBTcUlKC4eXgVVRcvrYjfcrPAipm+6vVXUnZFEIzKh6P
   nDtw/iqOUoQ38IR3NxrrGs946lxtwJl2+XHcRyFJXvgIUuJ6dNoeSWS15
   Q+C5AcQJgj54iE4wnZOmuCgBbtjJRpFgIauDpHts3n1VQO3Hf2U/Mv0i8
   RwcMWqRVD9fIW0aG/Z3S73ObdZBS2J7kqeXC88SZvekJ77UH4Y69Pe4l1
   BLa2KZVgbMRVKBHzFUodnyUY+edI1AqmcrrsynFeitEDjSMrihQUEtAoh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="355181673"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="355181673"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 00:22:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="791849596"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="791849596"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.30.48]) ([10.255.30.48])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 00:22:33 -0700
Message-ID: <8a211d2e-27ac-90ca-584c-c438cd3b535b@linux.intel.com>
Date: Thu, 18 May 2023 15:22:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: an iommufd selftest issue with 6.4-rc1
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <2e437fe7-59ef-be3c-1b94-c92adaf2e8eb@linux.intel.com>
 <ZGTedVao04FKpl7A@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZGTedVao04FKpl7A@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/5/17 22:02, Jason Gunthorpe wrote:
> On Wed, May 17, 2023 at 09:56:47PM +0800, Baolu Lu wrote:
>> Hi Jason,
>>
>> I compiled a 6.4-rc1 kernel and ran the iommufd selftest. The test hung,
>> and I had to break it with Ctrl+C. Is this a known issue, or there is
>> something wrong with my test setup?
> 
> There is an annoying bug in the test harness and it infinite loops for
> some failure cases. That explains the hang

Get it, thank you!

> 
>> # #  RUN           iommufd_ioas.no_domain.ioas_destroy ...
>> # #            OK  iommufd_ioas.no_domain.ioas_destroy
>> # ok 13 iommufd_ioas.no_domain.ioas_destroy
>> # #  RUN           iommufd_ioas.no_domain.hwpt_attach ...
>> # # hwpt_attach: Test terminated unexpectedly by signal 9
> 
> That seems bad

I don't know yet, need some investigation.

> 
>> # #          FAIL  iommufd_ioas.no_domain.hwpt_attach
>> # not ok 14 iommufd_ioas.no_domain.hwpt_attach
>> # #  RUN           iommufd_ioas.no_domain.ioas_area_destroy ...
>> # #            OK  iommufd_ioas.no_domain.ioas_area_destroy
>> # ok 15 iommufd_ioas.no_domain.ioas_area_destroy
>> # #  RUN           iommufd_ioas.no_domain.ioas_area_auto_destroy ...
>> # #            OK  iommufd_ioas.no_domain.ioas_area_auto_destroy
>> # ok 16 iommufd_ioas.no_domain.ioas_area_auto_destroy
>> # #  RUN           iommufd_ioas.no_domain.area ...
>> # #            OK  iommufd_ioas.no_domain.area
>> # ok 17 iommufd_ioas.no_domain.area
>> # #  RUN           iommufd_ioas.no_domain.unmap_fully_contained_areas ...
>> # #            OK  iommufd_ioas.no_domain.unmap_fully_contained_areas
>> # ok 18 iommufd_ioas.no_domain.unmap_fully_contained_areas
>> # #  RUN           iommufd_ioas.no_domain.area_auto_iova ...
>> # #            OK  iommufd_ioas.no_domain.area_auto_iova
>> # ok 19 iommufd_ioas.no_domain.area_auto_iova
>> # #  RUN           iommufd_ioas.no_domain.area_allowed ...
>> # #            OK  iommufd_ioas.no_domain.area_allowed
>> # ok 20 iommufd_ioas.no_domain.area_allowed
>> # #  RUN           iommufd_ioas.no_domain.copy_area ...
>> # #            OK  iommufd_ioas.no_domain.copy_area
>> # ok 21 iommufd_ioas.no_domain.copy_area
>> # #  RUN           iommufd_ioas.no_domain.iova_ranges ...
>> # #            OK  iommufd_ioas.no_domain.iova_ranges
>> # ok 22 iommufd_ioas.no_domain.iova_ranges
>> # #  RUN           iommufd_ioas.no_domain.access_domain_destory ...
>> # # iommufd.c:611:access_domain_destory:Expected MAP_FAILED
>> (18446744073709551615) != buf (18446744073709551615)
> 
> And you had a failed mmp, so probably missing THPs or something

Seems to look good.

# grep THP .config
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set

# cat /sys/kernel/mm/transparent_hugepage/enabled
[always] madvise never

> I don't see any failures when I run it..

Okay, that's fine.

Best regards,
baolu

