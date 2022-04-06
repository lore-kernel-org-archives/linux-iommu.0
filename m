Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FF6C433F5
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 19:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BF8F83E86;
	Wed,  6 Apr 2022 19:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FaIOrxCPKsbo; Wed,  6 Apr 2022 19:55:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2FC4E83E88;
	Wed,  6 Apr 2022 19:55:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04C68C001D;
	Wed,  6 Apr 2022 19:55:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C47EDC0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 19:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA15341867
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 19:55:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wnx5wKvRDDbd for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 19:55:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4F98541866
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 19:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649274938; x=1680810938;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lMUxbDnG7L0B3wzW8RD5r+I9PnxFArarJ4rGUtcEOOw=;
 b=Mh6pz3Imw9keNUv6nWCCX2rnxEwfdccAf0baEdLAzjQ0kxuO95YYoPhp
 gXhiKUhX0hIRAPdKcAOodbvsdhMZzp4MG1S9FUlhcYqF4mZcYlUgAVJfD
 08wNbMI8F4vM3c+LzdLuKzwq0qob6nOSDkKKe9TKIo2ugabU6J5rcsnvj
 tCpMsHUiNAmpE3/ssrAKiD7hSWbFpw9Q6p+O+cbrDaCngi2v+mWgFJ799
 /GLbpx70JXU+3yv2xbZNP+wSbwEB0HX9iQ3IttPHuA8IdbbRGqfI9+Ae/
 P8NF7i9fG0jQy2m7O5Q16m0H852/pLrqpccfrziroXlOgNpJ3ABojx1XX g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="260837558"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; d="scan'208";a="260837558"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2022 12:55:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; d="scan'208";a="588504766"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
 by orsmga001.jf.intel.com with ESMTP; 06 Apr 2022 12:55:34 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1ncBkc-0004hV-7t;
 Wed, 06 Apr 2022 19:55:34 +0000
Date: Thu, 7 Apr 2022 03:54:56 +0800
From: kernel test robot <lkp@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, benve@cisco.com,
 neescoba@cisco.com, jgg@ziepe.ca
Subject: Re: [PATCH] RDMA/usnic: Refactor usnic_uiom_alloc_pd()
Message-ID: <202204070316.vOzwORw5-lkp@intel.com>
References: <ef607cb3f5a09920b86971b8c8e60af8c647457e.1649169359.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ef607cb3f5a09920b86971b8c8e60af8c647457e.1649169359.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org,
 kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
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

Hi Robin,

I love your patch! Yet something to improve:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on v5.18-rc1 next-20220406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Robin-Murphy/RDMA-usnic-Refactor-usnic_uiom_alloc_pd/20220406-133657
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220407/202204070316.vOzwORw5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/0aa6215010a083081b26ccb23d0aa2b4089bbbfd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Robin-Murphy/RDMA-usnic-Refactor-usnic_uiom_alloc_pd/20220406-133657
        git checkout 0aa6215010a083081b26ccb23d0aa2b4089bbbfd
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/infiniband/hw/usnic/usnic_uiom.c: In function 'usnic_uiom_init':
>> drivers/infiniband/hw/usnic/usnic_uiom.c:561:29: error: 'pci_bus_type' undeclared (first use in this function); did you mean 'bus_type'?
     561 |         if (!iommu_present(&pci_bus_type)) {
         |                             ^~~~~~~~~~~~
         |                             bus_type
   drivers/infiniband/hw/usnic/usnic_uiom.c:561:29: note: each undeclared identifier is reported only once for each function it appears in


vim +561 drivers/infiniband/hw/usnic/usnic_uiom.c

e3cf00d0a87f02 Upinder Malhi 2013-09-10  558  
e3cf00d0a87f02 Upinder Malhi 2013-09-10  559  int usnic_uiom_init(char *drv_name)
e3cf00d0a87f02 Upinder Malhi 2013-09-10  560  {
e3cf00d0a87f02 Upinder Malhi 2013-09-10 @561  	if (!iommu_present(&pci_bus_type)) {

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
