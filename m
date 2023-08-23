Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7151381;
	Wed, 23 Aug 2023 01:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692755312; x=1724291312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/UX/VJr+eHMWDrw7OUXO6P7GMzF6UwuOSz3W+cQBqmI=;
  b=Cqtbp9AR5vxPJI52cKsa1mzbvnYiOLtV0N7ElDxRSVkv37KQaDcTULpe
   sPAeONvQ2dqPK0yGH3/RNrxPLHfaqscx8ISOg/rc4KlLf980UNw2znYh1
   O14JJd71RKGOAgox5OfyDe6YHE4r9cgAv2pOnzlEyTVo1zQ+8Gw6xIVpa
   Ja5afkXguDXaYBTARVjgTLoV2XjGNZ1PJr+d0wjw5sNFBh3xVdXebSp9Q
   p1AbzjdTkUwCpuu6OfJEATH1RO5BjmV6FTqyQjIWyYuVAUX5RG2xXvWhF
   7Vm/nn/7q/GhxXpcy09tvpl9rl0rZqnwDpv3aQqu5HEkqh2X7w8ycdLEg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="371452639"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="371452639"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 18:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="860142153"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="860142153"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 22 Aug 2023 18:48:18 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qYcyn-0000ja-2I;
	Wed, 23 Aug 2023 01:48:17 +0000
Date: Wed, 23 Aug 2023 09:47:48 +0800
From: kernel test robot <lkp@intel.com>
To: Huang Jiaqing <jiaqing.huang@intel.com>, kvm@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, jacob.jun.pan@linux.intel.com,
	yi.l.liu@intel.com, yi.y.sun@intel.com, jiaqing.huang@intel.com
Subject: Re: [PATCH] iommu/vt-d: Introduce a rb_tree for looking up device
Message-ID: <202308230922.9PKf5JkV-lkp@intel.com>
References: <20230821071659.123981-1-jiaqing.huang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821071659.123981-1-jiaqing.huang@intel.com>

Hi Huang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.5-rc7]
[also build test WARNING on linus/master]
[cannot apply to joro-iommu/next next-20230822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huang-Jiaqing/iommu-vt-d-Introduce-a-rb_tree-for-looking-up-device/20230821-151945
base:   v6.5-rc7
patch link:    https://lore.kernel.org/r/20230821071659.123981-1-jiaqing.huang%40intel.com
patch subject: [PATCH] iommu/vt-d: Introduce a rb_tree for looking up device
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20230823/202308230922.9PKf5JkV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308230922.9PKf5JkV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308230922.9PKf5JkV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/intel/iommu.c:239:28: warning: no previous prototype for 'device_rbtree_find' [-Wmissing-prototypes]
     239 | struct device_domain_info *device_rbtree_find(struct intel_iommu *iommu, u8 bus, u8 devfn)
         |                            ^~~~~~~~~~~~~~~~~~


vim +/device_rbtree_find +239 drivers/iommu/intel/iommu.c

   237	
   238	
 > 239	struct device_domain_info *device_rbtree_find(struct intel_iommu *iommu, u8 bus, u8 devfn)
   240	{
   241		struct device_domain_info *data = NULL;
   242		struct rb_node *node;
   243	
   244		down_read(&iommu->iopf_device_sem);
   245	
   246		node = iommu->iopf_device_rbtree.rb_node;
   247		while (node) {
   248			data = container_of(node, struct device_domain_info, node);
   249			s16 result = RB_NODE_CMP(bus, devfn, data->bus, data->devfn);
   250	
   251			if (result < 0)
   252				node = node->rb_left;
   253			else if (result > 0)
   254				node = node->rb_right;
   255			else
   256				break;
   257		}
   258		up_read(&iommu->iopf_device_sem);
   259	
   260		return node ? data : NULL;
   261	}
   262	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
