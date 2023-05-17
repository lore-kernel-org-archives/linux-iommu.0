Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DCB18B16
	for <iommu@lists.linux.dev>; Wed, 17 May 2023 13:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684331811; x=1715867811;
  h=message-id:date:mime-version:cc:to:from:subject:
   content-transfer-encoding;
  bh=3oqBeIRf93syaOJtaYRnoxz0zmze61KEDSyNdVFv6qQ=;
  b=Y/1lJRs9CBZmFPcy4NLBB0Ay2F0qH8bT9v5i/l9k3NqokzBEOZeXAM3+
   62WvknZe3rv/IlNguiGQxXG95PyDXZZ898vhvWa9bE2O4z+kbj0H468KR
   IqcjVK/0RjNaeh48k3o4owztQv+vwR5Du8+xmK7CsiO1DuzeDan7o4zlW
   7Zg3FWrJ+HizdasGGxGA5o9m3o0fiyV5wLwA5RuCuH6Tf7bdTdN+4gzPF
   L69I5ezP9ClLqHbVu6PpcjlvMpKHHeaKcS7Q+RZ1I3cs9htWF1xgkPcVc
   afWoD77kUOFRdXjtuqmJh9KKcU0hg4sG6hn1/pwSUt5Mr8HEm1+HmhgLr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="415177828"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="415177828"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 06:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="846100049"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="846100049"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.223]) ([10.255.31.223])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 06:56:49 -0700
Message-ID: <2e437fe7-59ef-be3c-1b94-c92adaf2e8eb@linux.intel.com>
Date: Wed, 17 May 2023 21:56:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: an iommufd selftest issue with 6.4-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jason,

I compiled a 6.4-rc1 kernel and ran the iommufd selftest. The test hung,
and I had to break it with Ctrl+C. Is this a known issue, or there is
something wrong with my test setup?

Best regards,
baolu

PS: the test log:

TAP version 13
1..1
# selftests: iommu: iommufd
# TAP version 13
# 1..129
# # Starting 129 tests from 11 test cases.
# #  RUN           iommufd.simple_close ...
# #            OK  iommufd.simple_close
# ok 1 iommufd.simple_close
# #  RUN           iommufd.cmd_fail ...
# #            OK  iommufd.cmd_fail
# ok 2 iommufd.cmd_fail
# #  RUN           iommufd.cmd_length ...
# #            OK  iommufd.cmd_length
# ok 3 iommufd.cmd_length
# #  RUN           iommufd.cmd_ex_fail ...
# #            OK  iommufd.cmd_ex_fail
# ok 4 iommufd.cmd_ex_fail
# #  RUN           iommufd.global_options ...
# #            OK  iommufd.global_options
# ok 5 iommufd.global_options
# #  RUN           iommufd.simple_ioctls ...
# #            OK  iommufd.simple_ioctls
# ok 6 iommufd.simple_ioctls
# #  RUN           iommufd.unmap_cmd ...
# #            OK  iommufd.unmap_cmd
# ok 7 iommufd.unmap_cmd
# #  RUN           iommufd.map_cmd ...
# #            OK  iommufd.map_cmd
# ok 8 iommufd.map_cmd
# #  RUN           iommufd.info_cmd ...
# #            OK  iommufd.info_cmd
# ok 9 iommufd.info_cmd
# #  RUN           iommufd.set_iommu_cmd ...
# #            OK  iommufd.set_iommu_cmd
# ok 10 iommufd.set_iommu_cmd
# #  RUN           iommufd.vfio_ioas ...
# #            OK  iommufd.vfio_ioas
# ok 11 iommufd.vfio_ioas
# #  RUN           iommufd_ioas.no_domain.ioas_auto_destroy ...
# #            OK  iommufd_ioas.no_domain.ioas_auto_destroy
# ok 12 iommufd_ioas.no_domain.ioas_auto_destroy
# #  RUN           iommufd_ioas.no_domain.ioas_destroy ...
# #            OK  iommufd_ioas.no_domain.ioas_destroy
# ok 13 iommufd_ioas.no_domain.ioas_destroy
# #  RUN           iommufd_ioas.no_domain.hwpt_attach ...
# # hwpt_attach: Test terminated unexpectedly by signal 9
# #          FAIL  iommufd_ioas.no_domain.hwpt_attach
# not ok 14 iommufd_ioas.no_domain.hwpt_attach
# #  RUN           iommufd_ioas.no_domain.ioas_area_destroy ...
# #            OK  iommufd_ioas.no_domain.ioas_area_destroy
# ok 15 iommufd_ioas.no_domain.ioas_area_destroy
# #  RUN           iommufd_ioas.no_domain.ioas_area_auto_destroy ...
# #            OK  iommufd_ioas.no_domain.ioas_area_auto_destroy
# ok 16 iommufd_ioas.no_domain.ioas_area_auto_destroy
# #  RUN           iommufd_ioas.no_domain.area ...
# #            OK  iommufd_ioas.no_domain.area
# ok 17 iommufd_ioas.no_domain.area
# #  RUN           iommufd_ioas.no_domain.unmap_fully_contained_areas ...
# #            OK  iommufd_ioas.no_domain.unmap_fully_contained_areas
# ok 18 iommufd_ioas.no_domain.unmap_fully_contained_areas
# #  RUN           iommufd_ioas.no_domain.area_auto_iova ...
# #            OK  iommufd_ioas.no_domain.area_auto_iova
# ok 19 iommufd_ioas.no_domain.area_auto_iova
# #  RUN           iommufd_ioas.no_domain.area_allowed ...
# #            OK  iommufd_ioas.no_domain.area_allowed
# ok 20 iommufd_ioas.no_domain.area_allowed
# #  RUN           iommufd_ioas.no_domain.copy_area ...
# #            OK  iommufd_ioas.no_domain.copy_area
# ok 21 iommufd_ioas.no_domain.copy_area
# #  RUN           iommufd_ioas.no_domain.iova_ranges ...
# #            OK  iommufd_ioas.no_domain.iova_ranges
# ok 22 iommufd_ioas.no_domain.iova_ranges
# #  RUN           iommufd_ioas.no_domain.access_domain_destory ...
# # iommufd.c:611:access_domain_destory:Expected MAP_FAILED 
(18446744073709551615) != buf (18446744073709551615)
