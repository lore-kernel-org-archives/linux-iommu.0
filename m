Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D54C433F5
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 02:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56A6B410BB;
	Fri, 13 May 2022 02:18:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nEWDkZbPwldD; Fri, 13 May 2022 02:18:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 95873410B9;
	Fri, 13 May 2022 02:18:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EE8EC0032;
	Fri, 13 May 2022 02:18:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08C53C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 02:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E47AE410BB
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 02:18:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qY6Kmt_W6uS5 for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 02:18:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 501D6410B9
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 02:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652408316; x=1683944316;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0G2giUeHgl7Bqq7hugqN69frj33hzfoNoWg6XUWTPfk=;
 b=kKI2JGQ/PaQrzGwKKsbo64iYEeL3IxvFIu6d21yip4bCqKykPX83Tj1d
 cVvnLYOoUlJ0CcRZM3gmCCy1YDpidAmwiJ9VOMlzKLeDe9lyu4Kx2RiE3
 6JiRRThflHTrWNouFSk0hbgvRJ/aqX7soqJaeEapzmzP0/ngHHLCcmYFK
 xAxRlJ7LNoTiQB+ZdTULp79CHuIbKquERx6eVhJshHhamq77/FEZ/ItRj
 q+ySdvukBzdhoEP7HDrIZMlsAj3sSPvXLxjftAN8pfCgm/p+Pmv2lWI0X
 RVwbo/3p5LZB5akgxxVu6MYqKidcDazg26A+2rE7A7rWUdgYc5OB5MdlE Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="330793112"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; d="scan'208";a="330793112"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2022 19:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; d="scan'208";a="594988159"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
 by orsmga008.jf.intel.com with ESMTP; 12 May 2022 19:18:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1npKsq-000LBw-Il;
 Fri, 13 May 2022 02:18:24 +0000
Date: Fri, 13 May 2022 10:18:14 +0800
From: kernel test robot <lkp@intel.com>
To: yf.wang@mediatek.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Georgi Djakov <quic_c_gdjako@quicinc.com>, Sven Peter <sven@svenpeter.dev>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/2] iommu/io-pgtable-arm-v7s: Add a quirk to allow
 pgtable PA up to 35bit
Message-ID: <202205131016.Ati0kpNR-lkp@intel.com>
References: <20220512144557.18025-2-yf.wang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220512144557.18025-2-yf.wang@mediatek.com>
Cc: kbuild-all@lists.01.org, wsd_upstream@mediatek.com, llvm@lists.linux.dev,
 Libo Kang <Libo.Kang@mediatek.com>, Ning Li <ning.li@mediatek.com>
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

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm-perf/for-next/perf]
[also build test WARNING on linus/master v5.18-rc6 next-20220512]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/yf-wang-mediatek-com/iommu-io-pgtable-arm-v7s-Add-a-quirk-to-allow-pgtable-PA-up-to-35bit/20220512-234603
base:   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20220513/202205131016.Ati0kpNR-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9519dacab7b8afd537811fc2abaceb4d14f4e16a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/916a5fc41cbb8ddfe343193598f250d06b09e3fa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review yf-wang-mediatek-com/iommu-io-pgtable-arm-v7s-Add-a-quirk-to-allow-pgtable-PA-up-to-35bit/20220512-234603
        git checkout 916a5fc41cbb8ddfe343193598f250d06b09e3fa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iommu/ drivers/rtc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iommu/io-pgtable-arm-v7s.c:886:4: warning: shift count >= width of type [-Wshift-count-overflow]
                           ARM_V7S_TTBR_35BIT_PA(cfg->arm_v7s_cfg.ttbr, paddr);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm-v7s.c:154:39: note: expanded from macro 'ARM_V7S_TTBR_35BIT_PA'
           ((ttbr & ((u32)(~0U << 3))) | ((pa & GENMASK(34, 32)) >> 32))
                                                ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:22: note: expanded from macro '__GENMASK'
           (((~UL(0)) - (UL(1) << (l)) + 1) & \
                               ^  ~~~
>> drivers/iommu/io-pgtable-arm-v7s.c:886:4: warning: shift count is negative [-Wshift-count-negative]
                           ARM_V7S_TTBR_35BIT_PA(cfg->arm_v7s_cfg.ttbr, paddr);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm-v7s.c:154:39: note: expanded from macro 'ARM_V7S_TTBR_35BIT_PA'
           ((ttbr & ((u32)(~0U << 3))) | ((pa & GENMASK(34, 32)) >> 32))
                                                ^~~~~~~~~~~~~~~
   include/linux/bits.h:38:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^~~~~~~~~~~~~~~
   include/linux/bits.h:36:11: note: expanded from macro '__GENMASK'
            (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
                    ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/io-pgtable-arm-v7s.c:886:4: warning: shift count >= width of type [-Wshift-count-overflow]
                           ARM_V7S_TTBR_35BIT_PA(cfg->arm_v7s_cfg.ttbr, paddr);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/io-pgtable-arm-v7s.c:154:56: note: expanded from macro 'ARM_V7S_TTBR_35BIT_PA'
           ((ttbr & ((u32)(~0U << 3))) | ((pa & GENMASK(34, 32)) >> 32))
                                                                 ^  ~~
   3 warnings generated.


vim +886 drivers/iommu/io-pgtable-arm-v7s.c

   795	
   796	static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
   797							void *cookie)
   798	{
   799		slab_flags_t slab_flag = ARM_V7S_TABLE_SLAB_FLAGS;
   800		struct arm_v7s_io_pgtable *data;
   801		phys_addr_t paddr;
   802	
   803		if (cfg->ias > (arm_v7s_is_mtk_enabled(cfg) ? 34 : ARM_V7S_ADDR_BITS))
   804			return NULL;
   805	
   806		if (cfg->oas > (arm_v7s_is_mtk_enabled(cfg) ? 35 : ARM_V7S_ADDR_BITS))
   807			return NULL;
   808	
   809		if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
   810				    IO_PGTABLE_QUIRK_NO_PERMS |
   811				    IO_PGTABLE_QUIRK_ARM_MTK_EXT |
   812				    IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT))
   813			return NULL;
   814	
   815		/* If ARM_MTK_4GB is enabled, the NO_PERMS is also expected. */
   816		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT &&
   817		    !(cfg->quirks & IO_PGTABLE_QUIRK_NO_PERMS))
   818				return NULL;
   819	
   820		data = kmalloc(sizeof(*data), GFP_KERNEL);
   821		if (!data)
   822			return NULL;
   823	
   824		spin_lock_init(&data->split_lock);
   825		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
   826			slab_flag = 0;
   827		data->l2_tables = kmem_cache_create("io-pgtable_armv7s_l2",
   828						    ARM_V7S_TABLE_SIZE(2, cfg),
   829						    ARM_V7S_TABLE_SIZE(2, cfg),
   830						    slab_flag, NULL);
   831		if (!data->l2_tables)
   832			goto out_free_data;
   833	
   834		data->iop.ops = (struct io_pgtable_ops) {
   835			.map		= arm_v7s_map,
   836			.map_pages	= arm_v7s_map_pages,
   837			.unmap		= arm_v7s_unmap,
   838			.unmap_pages	= arm_v7s_unmap_pages,
   839			.iova_to_phys	= arm_v7s_iova_to_phys,
   840		};
   841	
   842		/* We have to do this early for __arm_v7s_alloc_table to work... */
   843		data->iop.cfg = *cfg;
   844	
   845		/*
   846		 * Unless the IOMMU driver indicates supersection support by
   847		 * having SZ_16M set in the initial bitmap, they won't be used.
   848		 */
   849		cfg->pgsize_bitmap &= SZ_4K | SZ_64K | SZ_1M | SZ_16M;
   850	
   851		/* TCR: T0SZ=0, EAE=0 (if applicable) */
   852		cfg->arm_v7s_cfg.tcr = 0;
   853	
   854		/*
   855		 * TEX remap: the indices used map to the closest equivalent types
   856		 * under the non-TEX-remap interpretation of those attribute bits,
   857		 * excepting various implementation-defined aspects of shareability.
   858		 */
   859		cfg->arm_v7s_cfg.prrr = ARM_V7S_PRRR_TR(1, ARM_V7S_PRRR_TYPE_DEVICE) |
   860					ARM_V7S_PRRR_TR(4, ARM_V7S_PRRR_TYPE_NORMAL) |
   861					ARM_V7S_PRRR_TR(7, ARM_V7S_PRRR_TYPE_NORMAL) |
   862					ARM_V7S_PRRR_DS0 | ARM_V7S_PRRR_DS1 |
   863					ARM_V7S_PRRR_NS1 | ARM_V7S_PRRR_NOS(7);
   864		cfg->arm_v7s_cfg.nmrr = ARM_V7S_NMRR_IR(7, ARM_V7S_RGN_WBWA) |
   865					ARM_V7S_NMRR_OR(7, ARM_V7S_RGN_WBWA);
   866	
   867		/* Looking good; allocate a pgd */
   868		data->pgd = __arm_v7s_alloc_table(1, GFP_KERNEL, data);
   869		if (!data->pgd)
   870			goto out_free_data;
   871	
   872		/* Ensure the empty pgd is visible before any actual TTBR write */
   873		wmb();
   874	
   875		/* TTBR */
   876		paddr = virt_to_phys(data->pgd);
   877		cfg->arm_v7s_cfg.ttbr = paddr | ARM_V7S_TTBR_S |
   878					(cfg->coherent_walk ? (ARM_V7S_TTBR_NOS |
   879					 ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBWA) |
   880					 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_WBWA)) :
   881					(ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_NC) |
   882					 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_NC)));
   883	
   884		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
   885			cfg->arm_v7s_cfg.ttbr =
 > 886				ARM_V7S_TTBR_35BIT_PA(cfg->arm_v7s_cfg.ttbr, paddr);
   887		return &data->iop;
   888	
   889	out_free_data:
   890		kmem_cache_destroy(data->l2_tables);
   891		kfree(data);
   892		return NULL;
   893	}
   894	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
