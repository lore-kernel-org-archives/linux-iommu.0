Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAA92D9787;
	Thu, 16 Oct 2025 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642382; cv=none; b=IER+YHUVStitcapvbpXnFXvfsI1cUonp6LjR4KigBi0rrutD2PTTEEYeBR6UXCOoX/U3i4zSU7IUXWbSNt9hxP3Cs45inmZk4lAFFVVSERaUczGpx6GfL85YivlfnsgZ6u7qudbCeFtmW6KIL6MCN2yp0TF89SlVxvLrkVuiKHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642382; c=relaxed/simple;
	bh=uVCJyvmT8hz8YltzC3dkZ9FwIOqU+bxtdzLVDUMQCAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pk+jUwAM9GRCHEo0axx1P/IErIV5bY4Hz1V/Q7hfMzXaeDV2eRYid/D/awfpwwJH/yf6PkpJV3l810Qgq365hB+o3RbzKF1sUgkzXbMmvY/u5rDQJ9YzbobKE1XEBBUBzDHsmvrYH+2/uVr4dI0osHs/k0nCq2EEE6kTKcExENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCFPEvXB; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCFPEvXB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760642380; x=1792178380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uVCJyvmT8hz8YltzC3dkZ9FwIOqU+bxtdzLVDUMQCAE=;
  b=BCFPEvXBiCUofrZ26c0fc0eSm0El0atsGPUGrIlu0vTbLz0P5NSuZudB
   mGjwf77Jlmwl/O9zLlK/WQa+ZAZzyy15uu1WVpsVgMRFlqy/MQ00ot61m
   yagaTls6QIZleODmwUQNQP79NJZ/UBA2xoYdtUOUv6fWjj8fZTZjICxIz
   b6A7ZChSJwB3gIXI+SESEAHOfEhJ2T0HmFiiWrPMe4jZViJpfr2Iuduz9
   WATbQLpCkbfZpU5xrbvmiBqYsWQwy5HSfiLEnUEGVG0oWEB8ONYUccTUF
   jtW1PzW1Oe7jB1e3qr7cSZL+jGuo6ZTw0EqNn4rI7MHbAV3DWaoc8KxYu
   w==;
X-CSE-ConnectionGUID: 4ZjWl/4oTP+Gld1yCdmMRg==
X-CSE-MsgGUID: TPawmw/tQpmicvJrsNrD3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73134220"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="73134220"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 12:19:39 -0700
X-CSE-ConnectionGUID: L0/9s+v2SqC1MFaXkIQtng==
X-CSE-MsgGUID: FdXW7oIvQ9aJtH+xcx9hkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="206244266"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 16 Oct 2025 12:19:36 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9TV8-0005BP-1l;
	Thu, 16 Oct 2025 19:19:07 +0000
Date: Fri, 17 Oct 2025 03:18:21 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	balbirs@nvidia.com, miko.lenczewski@arm.com, peterz@infradead.org,
	kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <202510170345.lO7fR7ao-lkp@intel.com>
References: <345bb7703ebd19992694758b47e371900267fa0e.1760555863.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <345bb7703ebd19992694758b47e371900267fa0e.1760555863.git.nicolinc@nvidia.com>

Hi Nicolin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.18-rc1 next-20251016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommu-arm-smmu-v3-Explicitly-set-smmu_domain-stage-for-SVA/20251016-034754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/345bb7703ebd19992694758b47e371900267fa0e.1760555863.git.nicolinc%40nvidia.com
patch subject: [PATCH v3 3/7] iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array
config: arm64-randconfig-001-20251017 (https://download.01.org/0day-ci/archive/20251017/202510170345.lO7fR7ao-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510170345.lO7fR7ao-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510170345.lO7fR7ao-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1170:7: warning: variable 'cmp' is uninitialized when used here [-Wuninitialized]
    1170 |                 if (cmp <= 0 && !refcount_read(&invs->inv[i].users)) {
         |                     ^~~
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1167:10: note: initialize the variable 'cmp' to silence this warning
    1167 |                 int cmp;
         |                        ^
         |                         = 0
   1 warning generated.


vim +/cmp +1170 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

  1132	
  1133	/**
  1134	 * arm_smmu_invs_unref() - Find in @invs for all entries in @to_unref, decrease
  1135	 *                         the user counts without deletions
  1136	 * @invs: the base invalidation array
  1137	 * @to_unref: an array of invlidations to decrease their user counts
  1138	 * @flush_fn: A callback function to invoke, when an entry's user count reduces
  1139	 *            to 0
  1140	 *
  1141	 * Return: the number of trash entries in the array, for arm_smmu_invs_purge()
  1142	 *
  1143	 * This function will not fail. Any entry with users=0 will be marked as trash.
  1144	 * All tailing trash entries in the array will be dropped. And the size of the
  1145	 * array will be trimmed properly. All trash entries in-between will remain in
  1146	 * the @invs until being completely deleted by the next arm_smmu_invs_merge()
  1147	 * or an arm_smmu_invs_purge() function call.
  1148	 *
  1149	 * This function must be locked and serialized with arm_smmu_invs_merge() and
  1150	 * arm_smmu_invs_purge(), but do not lockdep on any mutex for KUNIT test.
  1151	 *
  1152	 * Note that the final @invs->num_invs might not reflect the actual number of
  1153	 * invalidations due to trash entries. Any reader should take the read lock to
  1154	 * iterate each entry and check its users counter till the last entry.
  1155	 */
  1156	VISIBLE_IF_KUNIT
  1157	size_t arm_smmu_invs_unref(struct arm_smmu_invs *invs,
  1158				   struct arm_smmu_invs *to_unref,
  1159				   void (*flush_fn)(struct arm_smmu_inv *inv))
  1160	{
  1161		unsigned long flags;
  1162		size_t num_trashes = 0;
  1163		size_t num_invs = 0;
  1164		size_t i, j;
  1165	
  1166		for (i = j = 0; i != invs->num_invs || j != to_unref->num_invs;) {
  1167			int cmp;
  1168	
  1169			/* Skip any existing trash entry */
> 1170			if (cmp <= 0 && !refcount_read(&invs->inv[i].users)) {
  1171				num_trashes++;
  1172				i++;
  1173				continue;
  1174			}
  1175	
  1176			cmp = arm_smmu_invs_cmp(invs, i, to_unref, j);
  1177			if (cmp < 0) {
  1178				/* not found in to_unref, leave alone */
  1179				i++;
  1180				num_invs = i;
  1181			} else if (cmp == 0) {
  1182				/* same item */
  1183				if (refcount_dec_and_test(&invs->inv[i].users)) {
  1184					/* KUNIT test doesn't pass in a flush_fn */
  1185					if (flush_fn)
  1186						flush_fn(&invs->inv[i]);
  1187					num_trashes++;
  1188				} else {
  1189					num_invs = i + 1;
  1190				}
  1191				i++;
  1192				j++;
  1193			} else {
  1194				/* item in to_unref is not in invs or already a trash */
  1195				WARN_ON(true);
  1196				j++;
  1197			}
  1198		}
  1199	
  1200		/* Exclude any tailing trash */
  1201		num_trashes -= invs->num_invs - num_invs;
  1202	
  1203		/* The lock is required to fence concurrent ATS operations. */
  1204		write_lock_irqsave(&invs->rwlock, flags);
  1205		WRITE_ONCE(invs->num_invs, num_invs); /* Remove tailing trash entries */
  1206		write_unlock_irqrestore(&invs->rwlock, flags);
  1207	
  1208		return num_trashes;
  1209	}
  1210	EXPORT_SYMBOL_IF_KUNIT(arm_smmu_invs_unref);
  1211	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
