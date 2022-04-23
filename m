Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CFCC433F5
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 09:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CF2E83F10;
	Sat, 23 Apr 2022 09:51:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1RbhXq3xN9ui; Sat, 23 Apr 2022 09:51:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E8B0683E9E;
	Sat, 23 Apr 2022 09:51:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDE32C0039;
	Sat, 23 Apr 2022 09:51:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2CDBC002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 09:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D9C3260B91
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 09:51:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wwRuGjNCUFNG for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 09:51:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABB2760AFF
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 09:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650707480; x=1682243480;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ApEeD5h/tW9BreK8Av0uhbhUoz5ZvVKRM9JtzTzDGXg=;
 b=AATh6+VLWUu9+xn7saWUwhtKemmbG5Zv8UIhkTvs9/w+91Xvhqcc36KL
 EeEi1uOQaCIIvSLSIAfQvmQcS80gjd65D3/Ed9HkpoicMnD1iJTWpSQ5/
 gY+2rSj2Kx2T0IT2xb9BCtz3WYSlcNQ2gZKTXYZNrc59qHlnmRavwKKYr
 qAm58za6/8iVDnxopw2O0/tRDJ82dKxkoZaMxqmv0MjLGkY6j3ANpeBcf
 7Ba1oyRSb3XaHRoaQkSz5sXtPfMD7FiTb7wnLaLtJiIcmtAoYtVUn6Ht/
 lbEIOOAsQR3lwR6s+hKOxP/T4nja115kVaR1VouaZQLn33ium5TOgCDhE g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="262469132"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="262469132"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 02:51:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="556799029"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 23 Apr 2022 02:51:15 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1niCQ6-00008Q-Et;
 Sat, 23 Apr 2022 09:51:14 +0000
Date: Sat, 23 Apr 2022 17:50:43 +0800
From: kernel test robot <lkp@intel.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: Re: [PATCH v11 4/9] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Message-ID: <202204231737.0jkKpxZk-lkp@intel.com>
References: <20220422162907.1276-5-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220422162907.1276-5-shameerali.kolothum.thodi@huawei.com>
Cc: kbuild-all@lists.01.org, will@kernel.org, llvm@lists.linux.dev,
 jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 hch@infradead.org, guohanjun@huawei.com, Sami.Mujawar@arm.com,
 robin.murphy@arm.com, wanghuiqiang@huawei.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Shameer,

I love your patch! Perhaps something to improve:

[auto build test WARNING on joro-iommu/next]
[also build test WARNING on rafael-pm/linux-next arm/for-next arm64/for-next/core soc/for-next linus/master v5.18-rc3 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Shameer-Kolothum/ACPI-IORT-Support-for-IORT-RMR-node/20220423-003822
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: arm64-randconfig-r012-20220422 (https://download.01.org/0day-ci/archive/20220423/202204231737.0jkKpxZk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/5b73fd681a27e2ad450bac28f8a81f4b35fe4d68
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shameer-Kolothum/ACPI-IORT-Support-for-IORT-RMR-node/20220423-003822
        git checkout 5b73fd681a27e2ad450bac28f8a81f4b35fe4d68
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/acpi/arm64/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/acpi/arm64/iort.c:801:29: warning: no previous prototype for function 'iort_rmr_alloc' [-Wmissing-prototypes]
   struct iommu_iort_rmr_data *iort_rmr_alloc(struct acpi_iort_rmr_desc *rmr_desc,
                               ^
   drivers/acpi/arm64/iort.c:801:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct iommu_iort_rmr_data *iort_rmr_alloc(struct acpi_iort_rmr_desc *rmr_desc,
   ^
   static 
   drivers/acpi/arm64/iort.c:896:20: error: use of undeclared identifier 'ACPI_IORT_RMR_REMAP_PERMITTED'
                   if (rmr->flags & ACPI_IORT_RMR_REMAP_PERMITTED)
                                    ^
   drivers/acpi/arm64/iort.c:901:20: error: use of undeclared identifier 'ACPI_IORT_RMR_ACCESS_PRIVILEGE'
                   if (rmr->flags & ACPI_IORT_RMR_ACCESS_PRIVILEGE)
                                    ^
   drivers/acpi/arm64/iort.c:905:7: error: call to undeclared function 'ACPI_IORT_RMR_ACCESS_ATTRIBUTES'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   if (ACPI_IORT_RMR_ACCESS_ATTRIBUTES(rmr->flags) <=
                       ^
   drivers/acpi/arm64/iort.c:906:5: error: use of undeclared identifier 'ACPI_IORT_RMR_ATTR_DEVICE_GRE'
                                   ACPI_IORT_RMR_ATTR_DEVICE_GRE)
                                   ^
   drivers/acpi/arm64/iort.c:909:5: error: use of undeclared identifier 'ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB'
                                   ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB)
                                   ^
   1 warning and 5 errors generated.


vim +/iort_rmr_alloc +801 drivers/acpi/arm64/iort.c

   800	
 > 801	struct iommu_iort_rmr_data *iort_rmr_alloc(struct acpi_iort_rmr_desc *rmr_desc,
   802						   int prot, enum iommu_resv_type type,
   803						   u32 *sids, u32 num_sids)
   804	{
   805		struct iommu_iort_rmr_data *rmr_data;
   806		struct iommu_resv_region *region;
   807		u32 *sids_copy;
   808		u64 addr = rmr_desc->base_address, size = rmr_desc->length;
   809	
   810		rmr_data = kmalloc(sizeof(*rmr_data), GFP_KERNEL);
   811		if (!rmr_data)
   812			return NULL;
   813	
   814		/* Create a copy of SIDs array to associate with this rmr_data */
   815		sids_copy = kmemdup(sids, num_sids * sizeof(*sids), GFP_KERNEL);
   816		if (!sids_copy) {
   817			kfree(rmr_data);
   818			return NULL;
   819		}
   820		rmr_data->sids = sids_copy;
   821		rmr_data->num_sids = num_sids;
   822	
   823		if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
   824			/* PAGE align base addr and size */
   825			addr &= PAGE_MASK;
   826			size = PAGE_ALIGN(size + offset_in_page(rmr_desc->base_address));
   827	
   828			pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to 64K, continue with [0x%llx - 0x%llx]\n",
   829			       rmr_desc->base_address,
   830			       rmr_desc->base_address + rmr_desc->length - 1,
   831			       addr, addr + size - 1);
   832		}
   833	
   834		region = &rmr_data->rr;
   835		INIT_LIST_HEAD(&region->list);
   836		region->start = addr;
   837		region->length = size;
   838		region->prot = prot;
   839		region->type = type;
   840		region->free = iort_rmr_free;
   841	
   842		return rmr_data;
   843	}
   844	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
