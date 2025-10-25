Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678F286337;
	Sat, 25 Oct 2025 00:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761352360; cv=none; b=P4MCyZFEQ3eiWWmf/eeVPvy6nUlAKvFh9Vc4uD1UpP6ny+3x+cSbBu1u/0MbR5cnr1KsWI2wSeGrpYrmbM29bb3XU+rVNtHRU7wozjj3xgyhAuSbYeLS/0ySBlyaTQb0EpRbsoO0actshPrmegwlhVCglbQAQ057/PClJvSRUo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761352360; c=relaxed/simple;
	bh=xTIYdd8VsKQA2709uB50P3MiBnUYPX1PRmdeoF1Xh0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qegi0pmH4sKpzi28iF3PbZMZtGIjcgApt+71WTqrN9i9spxybyaIdCcadk4ZrwXQ/yXgiUHdWM/prCX71AW3eMCGlcCy4mt8nwdeDo/aV2u56pKNXiuVz6+BdqNhp4CvX180IWCxhckMUNd2Xc/HxBAl1tvtKqPKqSr8eqAX4AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/QfOfCY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/QfOfCY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761352358; x=1792888358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xTIYdd8VsKQA2709uB50P3MiBnUYPX1PRmdeoF1Xh0Y=;
  b=g/QfOfCY+tW/TL0U07KsMRuBy3ddrjh6QSoiR+P40GYzat+VJq0pcFoe
   zrp9F7qNP2fUC2JvA5PqglhxqSTcYurIgR7gCItALIq2DRffvZHQ6FD2V
   /P0R/eFL6OFLFhbIoGRbwNjUPgZAT3JXVKMX2seHTiy3GHfrisr7tMoeL
   1bHY0356S47gIKa4LIp7v9OsV3KK04JonRIxPgTjVLerDR2lrpLnDKPwU
   0y80JLMlXHqWzWe9Ph+JJT/YTmjPEWRPAxw2G9jbTuYS8GnnN0PvzrnmV
   vf9iOwkExouYuDq8OGLcvfAfP5M7zz/1zeNSeI0yqvolNqx1hqcyjxC+F
   A==;
X-CSE-ConnectionGUID: G4UO0P7fTyOIuzsyIYjpbw==
X-CSE-MsgGUID: rm3Un7p/TrypFb7N7pLC1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62742492"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="62742492"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 17:32:38 -0700
X-CSE-ConnectionGUID: FHWEFqmfRR+p93DZhDM3RA==
X-CSE-MsgGUID: 3ziwwJRORWaA6arprqFGBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="215209673"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 24 Oct 2025 17:32:36 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCSCv-000F07-0L;
	Sat, 25 Oct 2025 00:32:33 +0000
Date: Sat, 25 Oct 2025 08:31:54 +0800
From: kernel test robot <lkp@intel.com>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, suravee.suthikulpanit@amd.com,
	Vasant.Hegde@amd.com, Santosh.Shukla@amd.com,
	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Subject: Re: [PATCH v2] iommu/amd: Enhance "Completion-wait Time-out" error
 message
Message-ID: <202510250855.7wiC1wSz-lkp@intel.com>
References: <20251024061041.707-1-dheerajkumar.srivastava@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024061041.707-1-dheerajkumar.srivastava@amd.com>

Hi Dheeraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.18-rc2 next-20251024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dheeraj-Kumar-Srivastava/iommu-amd-Enhance-Completion-wait-Time-out-error-message/20251024-141312
base:   linus/master
patch link:    https://lore.kernel.org/r/20251024061041.707-1-dheerajkumar.srivastava%40amd.com
patch subject: [PATCH v2] iommu/amd: Enhance "Completion-wait Time-out" error message
config: x86_64-buildonly-randconfig-003-20251025 (https://download.01.org/0day-ci/archive/20251025/202510250855.7wiC1wSz-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251025/202510250855.7wiC1wSz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510250855.7wiC1wSz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iommu/amd/iommu.c: In function 'wait_on_sem':
>> drivers/iommu/amd/iommu.c:1171:21: warning: variable 'head' set but not used [-Wunused-but-set-variable]
    1171 |                 int head, tail;
         |                     ^~~~


vim +/head +1171 drivers/iommu/amd/iommu.c

  1153	
  1154	/****************************************************************************
  1155	 *
  1156	 * IOMMU command queuing functions
  1157	 *
  1158	 ****************************************************************************/
  1159	
  1160	static int wait_on_sem(struct amd_iommu *iommu, u64 data)
  1161	{
  1162		struct iommu_cmd *cmd;
  1163		int i = 0;
  1164	
  1165		while (*iommu->cmd_sem != data && i < LOOP_TIMEOUT) {
  1166			udelay(1);
  1167			i += 1;
  1168		}
  1169	
  1170		if (i == LOOP_TIMEOUT) {
> 1171			int head, tail;
  1172	
  1173			head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
  1174			tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
  1175	
  1176			pr_alert("IOMMU %04x:%02x:%02x.%01x: Completion-Wait loop timed out\n",
  1177				 iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
  1178				 PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));
  1179			/*
  1180			 * On command buffer completion timeout, step back by 2 commands
  1181			 * to locate the actual command that is causing the issue.
  1182			 */
  1183			tail = (MMIO_CMD_BUFFER_TAIL(tail) - 2) & (CMD_BUFFER_ENTRIES - 1);
  1184			cmd = (struct iommu_cmd *)(iommu->cmd_buf + tail * sizeof(*cmd));
  1185			dump_command(iommu_virt_to_phys(cmd));
  1186	
  1187			return -EIO;
  1188		}
  1189	
  1190		return 0;
  1191	}
  1192	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
