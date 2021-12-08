Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07957C433FE
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 18:38:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98EB040162;
	Wed,  8 Dec 2021 18:38:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hPGsODePu8Eu; Wed,  8 Dec 2021 18:38:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4810C4016F;
	Wed,  8 Dec 2021 18:38:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B23EC001E;
	Wed,  8 Dec 2021 18:38:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 214D3C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 18:37:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03EF4831EF
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 18:37:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0l3v2KP3EDDq for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 18:37:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EF61831DA
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 18:37:57 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="217926422"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; d="scan'208";a="217926422"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2021 10:37:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; d="scan'208";a="480003898"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
 by orsmga002.jf.intel.com with ESMTP; 08 Dec 2021 10:37:53 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mv1pA-0000uX-Fg; Wed, 08 Dec 2021 18:37:52 +0000
Date: Thu, 9 Dec 2021 02:37:17 +0800
From: kernel test robot <lkp@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: Re: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Message-ID: <202112090231.mEK0hpuw-lkp@intel.com>
References: <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Raj Ashok <ashok.raj@intel.com>, kbuild-all@lists.01.org,
 Jacob Pan <jacob.jun.pan@intel.com>
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

Hi Jacob,

I love your patch! Yet something to improve:

[auto build test ERROR on joro-iommu/next]
[also build test ERROR on vkoul-dmaengine/next linux/master linus/master v5.16-rc4 next-20211208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jacob-Pan/Enable-PASID-for-DMA-API-users/20211208-063637
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: x86_64-randconfig-a013-20211208 (https://download.01.org/0day-ci/archive/20211209/202112090231.mEK0hpuw-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/018108bcd08fc145526791870b4b58edeecfca1e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jacob-Pan/Enable-PASID-for-DMA-API-users/20211208-063637
        git checkout 018108bcd08fc145526791870b4b58edeecfca1e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/dma/idxd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/dma/idxd/init.c: In function 'idxd_enable_system_pasid':
>> drivers/dma/idxd/init.c:532:10: error: implicit declaration of function 'iommu_enable_pasid_dma'; did you mean 'iommu_enable_nesting'? [-Werror=implicit-function-declaration]
     532 |  pasid = iommu_enable_pasid_dma(&idxd->pdev->dev);
         |          ^~~~~~~~~~~~~~~~~~~~~~
         |          iommu_enable_nesting
   drivers/dma/idxd/init.c: In function 'idxd_disable_system_pasid':
>> drivers/dma/idxd/init.c:544:2: error: implicit declaration of function 'iommu_disable_pasid_dma' [-Werror=implicit-function-declaration]
     544 |  iommu_disable_pasid_dma(&idxd->pdev->dev);
         |  ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +532 drivers/dma/idxd/init.c

   527	
   528	static int idxd_enable_system_pasid(struct idxd_device *idxd)
   529	{
   530		u32 pasid;
   531	
 > 532		pasid = iommu_enable_pasid_dma(&idxd->pdev->dev);
   533		if (pasid == INVALID_IOASID) {
   534			dev_err(&idxd->pdev->dev, "No kernel DMA PASID\n");
   535			return -ENODEV;
   536		}
   537		idxd->pasid = pasid;
   538	
   539		return 0;
   540	}
   541	
   542	static void idxd_disable_system_pasid(struct idxd_device *idxd)
   543	{
 > 544		iommu_disable_pasid_dma(&idxd->pdev->dev);
   545		idxd->pasid = 0;
   546	}
   547	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
