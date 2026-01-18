Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3B1F8BD6;
	Sun, 18 Jan 2026 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768770328; cv=none; b=UXUWDvaRNVDdTrZwX/AWZUysk9AwzyuSrJTAnFmA8H1yK0uKJYwZgmQ55tE6EN89d6oxPBUW9p1ZFNV1twnekT3lH491s8q+O444bsdVW2sqOLL5b0+Wm3Eyh4wCHJoCv4sUtm9OGDp5JhnEnRGouDnjU9I9PRofwzov7cGpXd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768770328; c=relaxed/simple;
	bh=GM3uKCMiilBcgyBVXN4FIzqknsc8oriYI5QHYaoewVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RB6fU7UuUJ4oS6wfPDwePB0fP6j/sjaMtKvvjJ7pdhG/mSVIi301oSsrENPThqcfdPiM7LJ9nbYfwjSZok8iSjVUUZ3K7tYV4tNmYjMEY/Su6OB5t5uLpiIlv0UWsaoqxTQnK9HJw44noftmle/PBmWmNQzrCZt4bEvpA+Ranxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hY0aIa+E; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hY0aIa+E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768770326; x=1800306326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GM3uKCMiilBcgyBVXN4FIzqknsc8oriYI5QHYaoewVg=;
  b=hY0aIa+EM70DTOH7myfQG6zMtDknZ6QQGrLVIbSMwzjSbh7Li7Nm9ZgM
   /WGbIappRfaOryLqvTo8YJCIu/LcpzXxioZDvLyjS5ticpt5rluTlGXm6
   jqrrxfm/zdkB3wNG/QAGE3PwLoc43dJ9EyyX+c/95IbDYlmQ2Zi5jr5zW
   tr8fo0egL9btAA58OFmgFJ0itoRe/vHh2iyTJtFyryEdBKU208oua2ykP
   jExnp3eOWq+GImucTpzqPmkuvGqk0Mwy3cN3YptTI6wNzN73bp/70RTeo
   q365SSB8wNazkmm80QAzvzmdWzHNZnT0XofonBQJRwKFdM6Ahq92XkRiu
   w==;
X-CSE-ConnectionGUID: zMoU35zcTtO4n2jpa32JFg==
X-CSE-MsgGUID: AbNWNk9JTvWMHOpRSoDjhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="69892319"
X-IronPort-AV: E=Sophos;i="6.21,236,1763452800"; 
   d="scan'208";a="69892319"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 13:05:26 -0800
X-CSE-ConnectionGUID: oYYZtdB8TAScbc8sN6SrZw==
X-CSE-MsgGUID: WYIuxMH6Tr+DshwILx+2Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,236,1763452800"; 
   d="scan'208";a="206131331"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 18 Jan 2026 13:05:21 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhZxX-00000000NDs-3azH;
	Sun, 18 Jan 2026 21:05:19 +0000
Date: Mon, 19 Jan 2026 05:04:26 +0800
From: kernel test robot <lkp@intel.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	robh@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
	bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
	prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	vijayanand.jitta@oss.qualcomm.com
Subject: Re: [PATCH v5 3/3] of: Respect #{iommu,msi}-cells in maps
Message-ID: <202601190432.C5Aya7rJ-lkp@intel.com>
References: <20260118181125.1436036-4-vijayanand.jitta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118181125.1436036-4-vijayanand.jitta@oss.qualcomm.com>

Hi Vijayanand,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on pci/next pci/for-linus xen-tip/linux-next linus/master v6.19-rc5 next-20260116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vijayanand-Jitta/of-Add-convenience-wrappers-for-of_map_id/20260119-021706
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20260118181125.1436036-4-vijayanand.jitta%40oss.qualcomm.com
patch subject: [PATCH v5 3/3] of: Respect #{iommu,msi}-cells in maps
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20260119/202601190432.C5Aya7rJ-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260119/202601190432.C5Aya7rJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601190432.C5Aya7rJ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/cpufreq.h:17,
                    from kernel/sched/sched.h:31,
                    from kernel/sched/rq-offsets.c:5:
>> include/linux/of.h:937:1: error: expected identifier or '(' before '{' token
     937 | {
         | ^
>> include/linux/of.h:934:19: warning: 'of_map_id' used but never defined
     934 | static inline int of_map_id(const struct device_node *np, u32 id, const char *map_name,
         |                   ^~~~~~~~~
   make[3]: *** [scripts/Makefile.build:182: kernel/sched/rq-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1314: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +937 include/linux/of.h

0384e8c6c6fa49 Pantelis Antoniou 2015-01-21  933  
eb8f695e71ec36 Robin Murphy      2026-01-18 @934  static inline int of_map_id(const struct device_node *np, u32 id, const char *map_name,
eb8f695e71ec36 Robin Murphy      2026-01-18  935  			    const char *cells_name, const char *map_mask_name,
eb8f695e71ec36 Robin Murphy      2026-01-18  936  			    struct of_map_id_arg *arg);
2a6db719c92dbf Nipun Gupta       2018-09-10 @937  {
2a6db719c92dbf Nipun Gupta       2018-09-10  938  	return -EINVAL;
2a6db719c92dbf Nipun Gupta       2018-09-10  939  }
2a6db719c92dbf Nipun Gupta       2018-09-10  940  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
