Return-Path: <SRS0=VAik=NT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDD5C432BE
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 21:11:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545BC60E93
	for <iommu@archiver.kernel.org>; Sat, 28 Aug 2021 21:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 545BC60E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11F8A60656;
	Sat, 28 Aug 2021 21:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AIHeRN9SazGN; Sat, 28 Aug 2021 21:11:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8BB086063D;
	Sat, 28 Aug 2021 21:11:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 452E5C0010;
	Sat, 28 Aug 2021 21:11:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33F73C000E
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 21:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13471425F5
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 21:11:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TK3Un3cO3-5S for <iommu@lists.linux-foundation.org>;
 Sat, 28 Aug 2021 21:11:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A045F40463
 for <iommu@lists.linux-foundation.org>; Sat, 28 Aug 2021 21:11:42 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10090"; a="214993839"
X-IronPort-AV: E=Sophos;i="5.84,359,1620716400"; 
 d="gz'50?scan'50,208,50";a="214993839"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2021 14:11:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,359,1620716400"; 
 d="gz'50?scan'50,208,50";a="496328154"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 28 Aug 2021 14:11:38 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mK5c1-0003jp-GE; Sat, 28 Aug 2021 21:11:37 +0000
Date: Sun, 29 Aug 2021 05:10:45 +0800
From: kernel test robot <lkp@intel.com>
To: Sven Peter <sven@svenpeter.dev>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 4/8] iommu/dma: Support granule > PAGE_SIZE in
 dma_map_sg
Message-ID: <202108290553.o1yVxBDm-lkp@intel.com>
References: <20210828153642.19396-5-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20210828153642.19396-5-sven@svenpeter.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Arnd Bergmann <arnd@kernel.org>, Hector Martin <marcan@marcan.st>,
 kbuild-all@lists.01.org, Robin Murphy <robin.murphy@arm.com>,
 llvm@lists.linux.dev, Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Will Deacon <will@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sven,

I love your patch! Perhaps something to improve:

[auto build test WARNING on iommu/next]
[also build test WARNING on v5.14-rc7 next-20210827]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sven-Peter/Support-IOMMU-page-sizes-larger-than-the-CPU-page-size/20210828-233909
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: i386-randconfig-c001-20210827 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4e1a164d7bd53653f79decc121afe784d2fde0a7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fa978f84667cfd7d8cb467899da60c08321798a5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sven-Peter/Support-IOMMU-page-sizes-larger-than-the-CPU-page-size/20210828-233909
        git checkout fa978f84667cfd7d8cb467899da60c08321798a5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iommu/dma-iommu.c:935:18: error: implicit declaration of function 'phys_to_page' [-Werror,-Wimplicit-function-declaration]
                   sg_set_page(s, phys_to_page(sg_phys(s) + s_iova_off), s_length,
                                  ^
>> drivers/iommu/dma-iommu.c:935:18: warning: incompatible integer to pointer conversion passing 'int' to parameter of type 'struct page *' [-Wint-conversion]
                   sg_set_page(s, phys_to_page(sg_phys(s) + s_iova_off), s_length,
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/scatterlist.h:110:69: note: passing argument to parameter 'page' here
   static inline void sg_set_page(struct scatterlist *sg, struct page *page,
                                                                       ^
   drivers/iommu/dma-iommu.c:982:9: error: implicit declaration of function 'phys_to_page' [-Werror,-Wimplicit-function-declaration]
                                       phys_to_page(sg_phys(s) + sg_dma_address(s)),
                                       ^
   drivers/iommu/dma-iommu.c:982:9: warning: incompatible integer to pointer conversion passing 'int' to parameter of type 'struct page *' [-Wint-conversion]
                                       phys_to_page(sg_phys(s) + sg_dma_address(s)),
                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/scatterlist.h:110:69: note: passing argument to parameter 'page' here
   static inline void sg_set_page(struct scatterlist *sg, struct page *page,
                                                                       ^
   drivers/iommu/dma-iommu.c:1068:18: error: implicit declaration of function 'phys_to_page' [-Werror,-Wimplicit-function-declaration]
                   sg_set_page(s, phys_to_page(s_phys - s_iova_off),
                                  ^
   drivers/iommu/dma-iommu.c:1068:18: warning: incompatible integer to pointer conversion passing 'int' to parameter of type 'struct page *' [-Wint-conversion]
                   sg_set_page(s, phys_to_page(s_phys - s_iova_off),
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/scatterlist.h:110:69: note: passing argument to parameter 'page' here
   static inline void sg_set_page(struct scatterlist *sg, struct page *page,
                                                                       ^
   3 warnings and 3 errors generated.


vim +935 drivers/iommu/dma-iommu.c

   913	
   914	/*
   915	 * Prepare a successfully-mapped scatterlist to give back to the caller.
   916	 *
   917	 * At this point the segments are already laid out by iommu_dma_map_sg() to
   918	 * avoid individually crossing any boundaries, so we merely need to check a
   919	 * segment's start address to avoid concatenating across one.
   920	 */
   921	static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
   922			dma_addr_t dma_addr)
   923	{
   924		struct scatterlist *s, *cur = sg;
   925		unsigned long seg_mask = dma_get_seg_boundary(dev);
   926		unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
   927		int i, count = 0;
   928	
   929		for_each_sg(sg, s, nents, i) {
   930			/* Restore this segment's original unaligned fields first */
   931			unsigned int s_iova_off = sg_dma_address(s);
   932			unsigned int s_length = sg_dma_len(s);
   933			unsigned int s_iova_len = s->length;
   934	
 > 935			sg_set_page(s, phys_to_page(sg_phys(s) + s_iova_off), s_length,
   936				    s_iova_off & ~PAGE_MASK);
   937			sg_dma_address(s) = DMA_MAPPING_ERROR;
   938			sg_dma_len(s) = 0;
   939	
   940			/*
   941			 * Now fill in the real DMA data. If...
   942			 * - there is a valid output segment to append to
   943			 * - and this segment starts on an IOVA page boundary
   944			 * - but doesn't fall at a segment boundary
   945			 * - and wouldn't make the resulting output segment too long
   946			 */
   947			if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
   948			    (max_len - cur_len >= s_length)) {
   949				/* ...then concatenate it with the previous one */
   950				cur_len += s_length;
   951			} else {
   952				/* Otherwise start the next output segment */
   953				if (i > 0)
   954					cur = sg_next(cur);
   955				cur_len = s_length;
   956				count++;
   957	
   958				sg_dma_address(cur) = dma_addr + s_iova_off;
   959			}
   960	
   961			sg_dma_len(cur) = cur_len;
   962			dma_addr += s_iova_len;
   963	
   964			if (s_length + s_iova_off < s_iova_len)
   965				cur_len = 0;
   966		}
   967		return count;
   968	}
   969	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--GvXjxJ+pjyke8COw
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--GvXjxJ+pjyke8COw--


