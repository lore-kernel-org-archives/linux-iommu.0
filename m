Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF164A4F14;
	Fri, 18 Sep 2026 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716991; cv=none; b=FNjDWkURNC2T8gKgn7GOs4tR5vaYUcWzttwIqXnFvSOXlFTeFWbkkfHJNnY7MN55I+sj6d0Tb1sn15PauRrgMy+vas7PFTj9O1brpjWylYE17p6cDFbSyq94sSXtv9C1MMfO81pQU69xdjreQS7s4cBcuTvqQREbuO2Hibw1XF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716991; c=relaxed/simple;
	bh=CWxp2gJBf/OVUhKfgwW76OTA4hT5pppevN4HpR9nt6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quNKqHTHe6Q/rTUr5tJiEaCM5W8y+2os67n4Mk4MUj3VUDNY1EJyYd4qOcnr2LDxDuZ6+sQwIQB2oTzX/5DSctR2stmS0Mrk4/8SjqDC2+sTJfCY/exWwjmcg8VoVwbLjHzzQu7Eny2BskzA6u0/GVY+PbrUnCvZBIntebIDZsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=auMPjecg; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auMPjecg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789716984; x=1821252984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CWxp2gJBf/OVUhKfgwW76OTA4hT5pppevN4HpR9nt6M=;
  b=auMPjecgdxq0VK1s/1a3yM8sZXtbxwnlXWZWbNdWp8jn6XFlt6N4zVbo
   nNrsnQiNP3FLytYS5739B208IWCdVkon3M/Ok6NjP8YewvTfizFmIlZcL
   EwKAofSo/LSCCR9+y3/w0SCLYjy6a3gF79yWR4KbytvL4Y03fP5Sr7DYs
   Tdf8JXlZZhytQLhgV3+dw/FjUzeMcrDb2NFmKd6HzhEF4RyaN/br2+LWt
   ovLtHhrHgvGdqMLrISpK4Pra8176mk8eCEWVp6cd8Bco0+Ifm9H/TdNRK
   AbXI+JYfT+vkBXRbb7TmBBPPWvDZP+axjdHmr+kn/JQayUywCpqKmoPO+
   w==;
X-CSE-ConnectionGUID: sylOR9TMQRy9kpO1Pqvr+Q==
X-CSE-MsgGUID: Dk6SbJVORKKjpjIsK+IHfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107707894"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107707894"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 00:36:14 -0700
X-CSE-ConnectionGUID: O+8XaV7xRoSfGB2R+i2yGA==
X-CSE-MsgGUID: PbGuIm+BTUG5jYauOPEVzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="279507029"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Sep 2026 00:36:10 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x7T8h-000000009Px-25YR;
	Fri, 18 Sep 2026 07:36:07 +0000
Date: Fri, 18 Sep 2026 15:35:37 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>,
	Ning Sun <ning.sun@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Baolu Lu <baolu.lu@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Michal Camacho Romero <michal.camacho.romero@intel.com>,
	x86@kernel.org, iommu@lists.linux.dev,
	tboot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Mateusz Mowka <mateusz.mowka@intel.com>,
	Adam Pawlicki <adamx.pawlicki@intel.com>,
	Pawel Randzio <pawel.randzio@intel.com>
Subject: Re: [PATCH 1/1] x86/tboot: Add support for parsing DTPR table and
 disabling TPRs
Message-ID: <202609181503.HTEk09e5-lkp@intel.com>
References: <20260917094133.765149-1-michal.camacho.romero@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917094133.765149-1-michal.camacho.romero@linux.intel.com>

Hi Michal,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on tip/master linus/master tip/auto-latest v7.3-rc3 next-20260916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Camacho-Romero/x86-tboot-Add-support-for-parsing-DTPR-table-and-disabling-TPRs/20260917-114133
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20260917094133.765149-1-michal.camacho.romero%40linux.intel.com
patch subject: [PATCH 1/1] x86/tboot: Add support for parsing DTPR table and disabling TPRs
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260918/202609181503.HTEk09e5-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260918/202609181503.HTEk09e5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609181503.HTEk09e5-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   arch/x86/kernel/tboot.c: In function 'tboot_check_dtpr_size':
>> arch/x86/kernel/tboot.c:255:16: warning: unused variable 'j' [-Wunused-variable]
     255 |         u32 i, j, ref_tpr_cnt;
         |                ^
   arch/x86/kernel/tboot.c: At top level:
>> arch/x86/kernel/tboot.c:583:8: error: redefinition of 'struct heap_ext_data_elt'
     583 | struct heap_ext_data_elt {
         |        ^~~~~~~~~~~~~~~~~
   In file included from arch/x86/kernel/tboot.c:19:
   include/linux/tboot.h:68:8: note: originally defined here
      68 | struct heap_ext_data_elt {
         |        ^~~~~~~~~~~~~~~~~
   arch/x86/kernel/tboot.c: In function 'tboot_get_dtpr_table':
>> arch/x86/kernel/tboot.c:758:22: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
     758 |         } while (elt <= sinit_mle_end);
         |                      ^~
   arch/x86/kernel/tboot.c:760:17: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
     760 |         if (elt >= sinit_mle_end){
         |                 ^~
   arch/x86/kernel/tboot.c: In function 'tboot_parse_dtpr_table':
>> arch/x86/kernel/tboot.c:800:13: warning: variable 'ref_tpr_cnt' set but not used [-Wunused-but-set-variable]
     800 |         u32 ref_tpr_cnt;
         |             ^~~~~~~~~~~


vim +583 arch/x86/kernel/tboot.c

   582	
 > 583	struct heap_ext_data_elt {
   584		u32 type;
   585		u32 size;
   586		u8  data[];
   587	} __packed;
   588	
   589	struct sinit_mle_data {
   590		u32                      version;             /* currently 9 */
   591		struct sha1_hash         bios_acm_id;
   592		u32                      edx_senter_flags;
   593		u64                      mseg_valid;
   594		struct sha1_hash         sinit_hash;
   595		struct sha1_hash         mle_hash;
   596		struct sha1_hash         stm_hash;
   597		struct sha1_hash         lcp_policy_hash;
   598		u32                      lcp_policy_control;
   599		u32                      rlp_wakeup_addr;
   600		u32                      reserved;
   601		u32                      num_mdrs;
   602		u32                      mdrs_off;
   603		u32                      num_vtd_dmars;
   604		u32                      vtd_dmars_off;
   605		u32                      proc_scrtm_status; /* version 8 or later only*/
   606		struct heap_ext_data_elt ext_data_elts[];
   607	} __packed;
   608	
   609	struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tbl)
   610	{
   611		void *heap_base, *heap_ptr, *config;
   612	
   613		if (!tboot_enabled())
   614			return dmar_tbl;
   615	
   616		/*
   617		 * ACPI tables may not be DMA protected by tboot, so use DMAR copy
   618		 * SINIT saved in SinitMleData in TXT heap (which is DMA protected)
   619		 */
   620	
   621		/* map config space in order to get heap addr */
   622		config = ioremap(TXT_PUB_CONFIG_REGS_BASE, NR_TXT_CONFIG_PAGES *
   623				 PAGE_SIZE);
   624		if (!config)
   625			return NULL;
   626	
   627		/* now map TXT heap */
   628		heap_base = ioremap(*(u64 *)(config + TXTCR_HEAP_BASE),
   629				    *(u64 *)(config + TXTCR_HEAP_SIZE));
   630		iounmap(config);
   631		if (!heap_base)
   632			return NULL;
   633	
   634		/* walk heap to SinitMleData */
   635		/* skip BiosData */
   636		heap_ptr = heap_base + *(u64 *)heap_base;
   637		/* skip OsMleData */
   638		heap_ptr += *(u64 *)heap_ptr;
   639		/* skip OsSinitData */
   640		heap_ptr += *(u64 *)heap_ptr;
   641		/* now points to SinitMleDataSize; set to SinitMleData */
   642		heap_ptr += sizeof(u64);
   643		/* get addr of DMAR table */
   644		dmar_tbl = (struct acpi_table_header *)(heap_ptr +
   645			   ((struct sinit_mle_data *)heap_ptr)->vtd_dmars_off -
   646			   sizeof(u64));
   647	
   648		/* don't unmap heap because dmar.c needs access to this */
   649	
   650		return dmar_tbl;
   651	}
   652	
   653	struct acpi_table_dtpr *tboot_get_dtpr_table(void **heap_base)
   654	{
   655		void *heap_ptr, *config, *sinit_mle_end;
   656		struct sinit_mle_data *sinit_mle;
   657		struct heap_ext_data_elt *elt;
   658		u64 heap_end, heap_size, sinit_mle_size, heap_section_size;
   659	
   660		if (!heap_base)
   661			return NULL;
   662	
   663		if (!tboot_enabled())
   664			return NULL;
   665		/*
   666		 * ACPI tables may not be DMA protected by tboot, so use DMAR copy
   667		 * SINIT saved in SinitMleData in TXT heap (which is DMA protected)
   668		 */
   669	
   670		/* map config space in order to get heap addr */
   671		config = ioremap(TXT_PUB_CONFIG_REGS_BASE, NR_TXT_CONFIG_PAGES *
   672				 PAGE_SIZE);
   673		if (!config)
   674			return NULL;
   675	
   676		/* now map TXT heap */
   677		*heap_base = ioremap(*(u64 *)(config + TXTCR_HEAP_BASE),
   678				    *(u64 *)(config + TXTCR_HEAP_SIZE));
   679		heap_size = *(u64 *)(config + TXTCR_HEAP_SIZE);
   680		heap_end = (u64)*heap_base + heap_size;
   681		iounmap(config);
   682	
   683		if (!(*heap_base))
   684			return NULL;
   685	
   686		/* walk heap to SinitMleData */
   687		/* skip BiosData */
   688		/* get BiosData section size */
   689		heap_section_size = *(u64 *) (*heap_base);
   690		if (!tboot_check_txt_heap_section_bounds(heap_end, heap_base, *heap_base,
   691		                                         heap_section_size, "BiosData")) {
   692			return NULL;
   693		}
   694	
   695		/* skip OsMleData */
   696		heap_ptr = *heap_base + heap_section_size;
   697		/* get OsMleData section size */
   698		heap_section_size = *(u64 *)heap_ptr;
   699		if (!tboot_check_txt_heap_section_bounds(heap_end, heap_base, heap_ptr,
   700		                                         heap_section_size, "OsMleData")) {
   701			return NULL;
   702		}
   703	
   704		/* skip OsSinitData */
   705		heap_ptr += heap_section_size;
   706		/* get OsSinitData section size */
   707		heap_section_size = *(u64 *)heap_ptr;
   708		if (!tboot_check_txt_heap_section_bounds(heap_end, heap_base, heap_ptr,
   709		                                         heap_section_size, "OsSinitData")) {
   710			return NULL;
   711		}
   712	
   713		/* jump to the SinitMleData */
   714		heap_ptr += heap_section_size;
   715		/* now points to SinitMleDataSize; set to SinitMleData */
   716		sinit_mle_size = *(u64 *)heap_ptr;
   717		if(!tboot_check_txt_heap_section_bounds(heap_end, heap_base, heap_ptr,
   718		                                        sinit_mle_size, "SinitMleData")) {
   719			return NULL;
   720		}
   721	
   722		heap_ptr += sizeof(u64);
   723		sinit_mle = (struct sinit_mle_data *)heap_ptr;
   724		sinit_mle_end = (void *)sinit_mle + sinit_mle_size;
   725		if (sizeof(struct sinit_mle_data) > sinit_mle_size) {
   726			pr_err("SinitMleData size is smaller than expected.\n");
   727			goto err;
   728		}
   729	
   730		if (sinit_mle->version < 9) {
   731			pr_err("Unsupported SinitMleData version: %u\n", sinit_mle->version);
   732			goto err;
   733		}
   734	
   735		heap_ptr += sizeof(struct sinit_mle_data);
   736		if (heap_ptr > sinit_mle_end) {
   737			pr_err("SinitMleData header out of bounds.\n");
   738			goto err;
   739		}
   740	
   741		elt = sinit_mle->ext_data_elts;
   742		do {
   743			if ((u8 *)elt + sizeof(*elt) > (u8 *)sinit_mle_end) {
   744				pr_err("SinitMleData element header out of bounds.\n");
   745				goto err;
   746			}
   747	
   748			if (elt->size < sizeof(*elt)) {
   749				pr_err("Invalid SinitMleData element size: %u\n", elt->size);
   750				goto err;
   751			}
   752	
   753			if (elt->type == HEAP_EXTDATA_TYPE_END || elt->type == HEAP_EXTDATA_TYPE_DTPR) {
   754				break;
   755			}
   756	
   757			elt = (void *)elt + elt->size;
 > 758		} while (elt <= sinit_mle_end);
   759	
   760		if (elt >= sinit_mle_end){
   761			pr_err("Reached the end of SinitMleData without finding DTPR nor END"
   762			       " element.\n");
   763			goto err;
   764		}
   765	
   766		if (elt->type == HEAP_EXTDATA_TYPE_END) {
   767			pr_err("DTPR element not found in SinitMleData\n");
   768			iounmap(*heap_base);
   769			*heap_base = NULL;
   770			return NULL;
   771		}
   772	
   773		if ((u8 *)elt + elt->size > (u8 *)sinit_mle_end) {
   774			pr_err("DTPR Table exceeds SinitMleData bounds.\n");
   775			goto err;
   776		}
   777	
   778		if (!tboot_check_dtpr_size((struct acpi_table_dtpr *)elt->data,
   779		                           elt->size - sizeof(*elt))) {
   780			pr_err("Invalid DTPR Table size.\n");
   781			goto err;
   782		}
   783	
   784		return (struct acpi_table_dtpr *)elt->data;
   785	
   786	err:
   787		iounmap(*heap_base);
   788		*heap_base = NULL;
   789		return NULL;
   790	}
   791	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
