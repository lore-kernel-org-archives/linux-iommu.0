Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D712FCBE3;
	Fri, 15 Aug 2025 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251868; cv=none; b=laf/MS5qV8KMBNXxD5d5aB2mBtGnTG5dBrhT6DB5TJl/tSw4spX2Bt3ByL0yYehbvY9j3nVENDUSTcKQA3E/QcQHFW7SNvKTjIJmfOStmMtVf7sqoO/N9Bw0VecZJmGm6OljzGeevDf1/wfyIs2kK7TjIIgu6SbHB4k8PRCY+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251868; c=relaxed/simple;
	bh=cRwd0xAh9h5E7sVoqCJod5qdMXXF26YfR10Uhew0+Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAx4zpuYIvRACYQG3SX+Lk1U9cWE8xsfrwdOg1ehmZx3IUv7INKEEWNMvToEQi3gaPBg+7oCttWbV4SjoLTnRlYZoxWMQoKKeQfnVXD7xTOdienmW0eopIjzAPExCwrwgZdStY58ZyoLDHQhLp0u63qN1JEkIcNuX6YZjHReQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=msJfzHkQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="msJfzHkQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755251867; x=1786787867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cRwd0xAh9h5E7sVoqCJod5qdMXXF26YfR10Uhew0+Jg=;
  b=msJfzHkQzgoRI2Jq6zzxakROEzaWdukeqHrN8OjerPYvTyXNazpgupfb
   F8FFklF3mJJzMkeJQ3LT7Btgo14IhinU+6bb7r4+Zf4CXfTZ68uNxt8Qb
   Pizn2Rpac0YUZ70akp3lmnTJVW/WB1BNUA3HILB7bwZ/Tqb7+oXqbXkVG
   x1C0v2qkVD1xJSM5rldIyLZbPYirujrMpoYd74owvV1nAhvRXzjKv9337
   kdxbeCTBUKVBMHItcgSftvVzzKyDH2S2MYJBfYDhyIx7Bo9Owu9pBXGv7
   3cbjclW1VjqxbEagRHYtB6KGHy9gSQAwWixkiwGeU+quHWhSDV5CxpUxd
   A==;
X-CSE-ConnectionGUID: qApEckzfTJSdOPOaIoZvzQ==
X-CSE-MsgGUID: VrNgbeAKTye/EJpZhs7/Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="61207234"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="61207234"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 02:57:46 -0700
X-CSE-ConnectionGUID: DXmdI5xFRa+CIQ9bGOnzvQ==
X-CSE-MsgGUID: RtOQGOPiTKarUpJGcI93LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="171112789"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 15 Aug 2025 02:57:42 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umrBs-000Bpk-2c;
	Fri, 15 Aug 2025 09:57:40 +0000
Date: Fri, 15 Aug 2025 17:57:33 +0800
From: kernel test robot <lkp@intel.com>
To: Qinxin Xia <xiaqinxin@huawei.com>, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, xiaqinxin@huawei.com, yangyicong@huawei.com,
	wangzhou1@hisilicon.com, prime.zeng@hisilicon.com,
	xuwei5@huawei.com, fanghao11@huawei.com,
	jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 1/2] iommu/debug: Add IOMMU page table dump debug facility
Message-ID: <202508151711.pZGu9jac-lkp@intel.com>
References: <20250814093005.2040511-2-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814093005.2040511-2-xiaqinxin@huawei.com>

Hi Qinxin,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.17-rc1 next-20250815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qinxin-Xia/iommu-debug-Add-IOMMU-page-table-dump-debug-facility/20250814-173720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250814093005.2040511-2-xiaqinxin%40huawei.com
patch subject: [PATCH 1/2] iommu/debug: Add IOMMU page table dump debug facility
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250815/202508151711.pZGu9jac-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250815/202508151711.pZGu9jac-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508151711.pZGu9jac-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iommu/iommu.c: In function 'iommu_iova_info_dump':
>> drivers/iommu/iommu.c:1093:17: error: implicit declaration of function 'iommu_domain_to_iovad'; did you mean 'iommu_domain_type_str'? [-Wimplicit-function-declaration]
    1093 |         iovad = iommu_domain_to_iovad(domain);
         |                 ^~~~~~~~~~~~~~~~~~~~~
         |                 iommu_domain_type_str
>> drivers/iommu/iommu.c:1093:15: error: assignment to 'struct iova_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1093 |         iovad = iommu_domain_to_iovad(domain);
         |               ^


vim +1093 drivers/iommu/iommu.c

  1078	
  1079	/**
  1080	 * iova_info_dump - dump iova alloced
  1081	 * @s - file structure used to generate serialized output
  1082	 * @iovad: - iova domain in question.
  1083	 */
  1084	static int iommu_iova_info_dump(struct seq_file *s, struct iommu_domain *domain)
  1085	{
  1086		struct iova_domain *iovad;
  1087		unsigned long long pfn;
  1088		unsigned long i_shift;
  1089		struct rb_node *node;
  1090		unsigned long flags;
  1091		size_t prot_size;
  1092	
> 1093		iovad = iommu_domain_to_iovad(domain);
  1094		if (!iovad)
  1095			return -ENOMEM;
  1096	
  1097		i_shift = iova_shift(iovad);
  1098	
  1099		/* Take the lock so that no other thread is manipulating the rbtree */
  1100		spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
  1101		assert_spin_locked(&iovad->iova_rbtree_lock);
  1102	
  1103		for (node = rb_first(&iovad->rbroot); node; node = rb_next(node)) {
  1104			struct iova *iova = rb_entry(node, struct iova, node);
  1105	
  1106			if (iova->pfn_hi <= iova->pfn_lo)
  1107				continue;
  1108	
  1109			for (pfn = iova->pfn_lo; pfn <= iova->pfn_hi; ) {
  1110				prot_size = domain->ops->dump_iova_prot(s, domain, pfn << i_shift);
  1111				pfn = ((pfn << i_shift) + prot_size) >> i_shift;
  1112			}
  1113		}
  1114	
  1115		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
  1116		return 0;
  1117	}
  1118	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
