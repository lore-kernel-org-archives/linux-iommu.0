Return-Path: <SRS0=KoUT=IC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0B6C433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 08:06:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DF864F04
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 08:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DF864F04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59E556F608;
	Thu,  4 Mar 2021 08:06:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2IMrLrNnscUV; Thu,  4 Mar 2021 08:06:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 236486F4A5;
	Thu,  4 Mar 2021 08:06:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECAB9C000B;
	Thu,  4 Mar 2021 08:06:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D174C0001
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 08:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49C9D6F5B9
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 08:06:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lwNQ9mBorDVN for <iommu@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 08:06:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE2406F4A5
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 08:06:20 +0000 (UTC)
IronPort-SDR: VnEOaXo2y8EBRvpyoXcn64ywBgqISZLBz+cRugWjF0pcpVhEegloY8aKVVYdDoXxWFCY09iDb4
 f74/OrEQF5Ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="175000855"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
 d="gz'50?scan'50,208,50";a="175000855"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2021 00:06:19 -0800
IronPort-SDR: SjS72KT/uQ1qfWYO9oZlQwEkjU54Gz/g+rVEDLS3MU/Jwl9kFx+a+/tkce+4YBnYRw+1nZN10v
 qzkKWEkCMCOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
 d="gz'50?scan'50,208,50";a="507267659"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
 by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2021 00:06:16 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lHizv-00025z-Ea; Thu, 04 Mar 2021 08:06:15 +0000
Date: Thu, 4 Mar 2021 16:06:11 +0800
From: kernel test robot <lkp@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/4] iommu/vt-d: Enable write protect for supervisor SVM
Message-ID: <202103041527.778WkYN9-lkp@intel.com>
References: <1613683878-89946-2-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <1613683878-89946-2-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, kbuild-all@lists.01.org,
 Raj Ashok <ashok.raj@intel.com>, Yi Sun <yi.y.sun@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Wu Hao <hao.wu@intel.com>
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jacob,

I love your patch! Yet something to improve:

[auto build test ERROR on iommu/next]
[also build test ERROR on linux/master linus/master v5.12-rc1 next-20210303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jacob-Pan/Misc-vSVA-fixes-for-VT-d/20210219-141141
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: ia64-randconfig-r023-20210304 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4c1de3403ecb6f91cc1bdc5e3ca81f16a2ffc0b5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jacob-Pan/Misc-vSVA-fixes-for-VT-d/20210219-141141
        git checkout 4c1de3403ecb6f91cc1bdc5e3ca81f16a2ffc0b5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/pgtable.h:154,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:33,
                    from include/linux/scatterlist.h:8,
                    from include/linux/dma-mapping.h:10,
                    from include/linux/iova.h:16,
                    from include/linux/intel-iommu.h:14,
                    from drivers/iommu/intel/pasid.c:15:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:41: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |  unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                         ^~~~~~~
   drivers/iommu/intel/pasid.c: In function 'pasid_enable_wpe':
>> drivers/iommu/intel/pasid.c:536:22: error: implicit declaration of function 'read_cr0' [-Werror=implicit-function-declaration]
     536 |  unsigned long cr0 = read_cr0();
         |                      ^~~~~~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from drivers/iommu/intel/pasid.c:12:
>> drivers/iommu/intel/pasid.c:539:23: error: 'X86_CR0_WP' undeclared (first use in this function)
     539 |  if (unlikely(!(cr0 & X86_CR0_WP))) {
         |                       ^~~~~~~~~~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   drivers/iommu/intel/pasid.c:539:23: note: each undeclared identifier is reported only once for each function it appears in
     539 |  if (unlikely(!(cr0 & X86_CR0_WP))) {
         |                       ^~~~~~~~~~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   cc1: some warnings being treated as errors


vim +/read_cr0 +536 drivers/iommu/intel/pasid.c

   533	
   534	static inline int pasid_enable_wpe(struct pasid_entry *pte)
   535	{
 > 536		unsigned long cr0 = read_cr0();
   537	
   538		/* CR0.WP is normally set but just to be sure */
 > 539		if (unlikely(!(cr0 & X86_CR0_WP))) {
   540			pr_err_ratelimited("No CPU write protect!\n");
   541			return -EINVAL;
   542		}
   543		pasid_set_wpe(pte);
   544	
   545		return 0;
   546	};
   547	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--pWyiEgJYm5f9v55/
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
OBi//gGgEyTC2oUBAA==

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--pWyiEgJYm5f9v55/--


