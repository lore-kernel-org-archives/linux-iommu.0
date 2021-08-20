Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C776EC4320A
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 09:03:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D916610CF
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 09:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D916610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4391A819BC;
	Fri, 20 Aug 2021 09:03:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rfKDO4kOH7hJ; Fri, 20 Aug 2021 09:03:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2A6F281991;
	Fri, 20 Aug 2021 09:03:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBC59C0010;
	Fri, 20 Aug 2021 09:03:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEE2EC000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 09:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B275C613E5
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 09:03:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cH0R81dZnGiZ for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 09:03:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64757613E3
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 09:03:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="214899393"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
 d="gz'50?scan'50,208,50";a="214899393"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2021 02:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
 d="gz'50?scan'50,208,50";a="452720601"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
 by fmsmga007.fm.intel.com with ESMTP; 20 Aug 2021 02:03:13 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1mH0Qi-000Uhw-Qx; Fri, 20 Aug 2021 09:03:12 +0000
Date: Fri, 20 Aug 2021 17:02:32 +0800
From: kernel test robot <lkp@intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [iommu:x86/vt-d 41/59] drivers/iommu/io-pgtable-arm-v7s.c:703:43:
 error: 'struct iommu_iotlb_gather' has no member named 'queued'
Message-ID: <202108201729.pd6kChqu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 kbuild-all@lists.01.org
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


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git x86/vt-d
head:   423d39d8518c1bba12e0889a92beeddbb1502392
commit: a8e5f04458c4e496eada2b029ce96713bb6c388d [41/59] iommu/io-pgtable: Remove non-strict quirk
config: nds32-buildonly-randconfig-r001-20210820 (attached as .config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?id=a8e5f04458c4e496eada2b029ce96713bb6c388d
        git remote add iommu https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
        git fetch --no-tags iommu x86/vt-d
        git checkout a8e5f04458c4e496eada2b029ce96713bb6c388d
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash drivers/iommu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/init.h:5,
                    from arch/nds32/include/asm/nds32.h:11,
                    from arch/nds32/include/asm/irqflags.h:4,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/cmpxchg.h:15,
                    from ./arch/nds32/include/generated/asm/cmpxchg.h:1,
                    from include/asm-generic/atomic.h:12,
                    from ./arch/nds32/include/generated/asm/atomic.h:1,
                    from include/linux/atomic.h:7,
                    from drivers/iommu/io-pgtable-arm-v7s.c:24:
   drivers/iommu/io-pgtable-arm-v7s.c: In function '__arm_v7s_unmap':
>> drivers/iommu/io-pgtable-arm-v7s.c:703:43: error: 'struct iommu_iotlb_gather' has no member named 'queued'
     703 |                         } else if (!gather->queued) {
         |                                           ^~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/iommu/io-pgtable-arm-v7s.c:703:32: note: in expansion of macro 'if'
     703 |                         } else if (!gather->queued) {
         |                                ^~
>> drivers/iommu/io-pgtable-arm-v7s.c:703:43: error: 'struct iommu_iotlb_gather' has no member named 'queued'
     703 |                         } else if (!gather->queued) {
         |                                           ^~
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/iommu/io-pgtable-arm-v7s.c:703:32: note: in expansion of macro 'if'
     703 |                         } else if (!gather->queued) {
         |                                ^~
>> drivers/iommu/io-pgtable-arm-v7s.c:703:43: error: 'struct iommu_iotlb_gather' has no member named 'queued'
     703 |                         } else if (!gather->queued) {
         |                                           ^~
   include/linux/compiler.h:69:10: note: in definition of macro '__trace_if_value'
      69 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm-v7s.c:703:32: note: in expansion of macro 'if'
     703 |                         } else if (!gather->queued) {
         |                                ^~


vim +703 drivers/iommu/io-pgtable-arm-v7s.c

   650	
   651	static size_t __arm_v7s_unmap(struct arm_v7s_io_pgtable *data,
   652				      struct iommu_iotlb_gather *gather,
   653				      unsigned long iova, size_t size, int lvl,
   654				      arm_v7s_iopte *ptep)
   655	{
   656		arm_v7s_iopte pte[ARM_V7S_CONT_PAGES];
   657		struct io_pgtable *iop = &data->iop;
   658		int idx, i = 0, num_entries = size >> ARM_V7S_LVL_SHIFT(lvl);
   659	
   660		/* Something went horribly wrong and we ran out of page table */
   661		if (WARN_ON(lvl > 2))
   662			return 0;
   663	
   664		idx = ARM_V7S_LVL_IDX(iova, lvl, &iop->cfg);
   665		ptep += idx;
   666		do {
   667			pte[i] = READ_ONCE(ptep[i]);
   668			if (WARN_ON(!ARM_V7S_PTE_IS_VALID(pte[i])))
   669				return 0;
   670		} while (++i < num_entries);
   671	
   672		/*
   673		 * If we've hit a contiguous 'large page' entry at this level, it
   674		 * needs splitting first, unless we're unmapping the whole lot.
   675		 *
   676		 * For splitting, we can't rewrite 16 PTEs atomically, and since we
   677		 * can't necessarily assume TEX remap we don't have a software bit to
   678		 * mark live entries being split. In practice (i.e. DMA API code), we
   679		 * will never be splitting large pages anyway, so just wrap this edge
   680		 * case in a lock for the sake of correctness and be done with it.
   681		 */
   682		if (num_entries <= 1 && arm_v7s_pte_is_cont(pte[0], lvl)) {
   683			unsigned long flags;
   684	
   685			spin_lock_irqsave(&data->split_lock, flags);
   686			pte[0] = arm_v7s_split_cont(data, iova, idx, lvl, ptep);
   687			spin_unlock_irqrestore(&data->split_lock, flags);
   688		}
   689	
   690		/* If the size matches this level, we're in the right place */
   691		if (num_entries) {
   692			size_t blk_size = ARM_V7S_BLOCK_SIZE(lvl);
   693	
   694			__arm_v7s_set_pte(ptep, 0, num_entries, &iop->cfg);
   695	
   696			for (i = 0; i < num_entries; i++) {
   697				if (ARM_V7S_PTE_IS_TABLE(pte[i], lvl)) {
   698					/* Also flush any partial walks */
   699					io_pgtable_tlb_flush_walk(iop, iova, blk_size,
   700							ARM_V7S_BLOCK_SIZE(lvl + 1));
   701					ptep = iopte_deref(pte[i], lvl, data);
   702					__arm_v7s_free_table(ptep, lvl + 1, data);
 > 703				} else if (!gather->queued) {
   704					io_pgtable_tlb_add_page(iop, gather, iova, blk_size);
   705				}
   706				iova += blk_size;
   707			}
   708			return size;
   709		} else if (lvl == 1 && !ARM_V7S_PTE_IS_TABLE(pte[0], lvl)) {
   710			/*
   711			 * Insert a table at the next level to map the old region,
   712			 * minus the part we want to unmap
   713			 */
   714			return arm_v7s_split_blk_unmap(data, gather, iova, size, pte[0],
   715						       ptep);
   716		}
   717	
   718		/* Keep on walkin' */
   719		ptep = iopte_deref(pte[0], lvl, data);
   720		return __arm_v7s_unmap(data, gather, iova, size, lvl + 1, ptep);
   721	}
   722	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--y0ulUmNC+osPPQO6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
tz7ZlwLVuKpxpDpPT/5/DJ2qSgLmAQA=

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--y0ulUmNC+osPPQO6--


