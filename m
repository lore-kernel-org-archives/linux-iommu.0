From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [iommu:x86/vt-d 2/3] drivers/iommu/intel_irq_remapping.c:429:17:
	sparse: incorrect type in argument 1 (different address spaces)
Date: Tue, 4 Aug 2015 21:26:50 +0800
Message-ID: <201508042148.0FMSgxkW%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git x86/vt-d
head:   2238c0827a9bfa8d517e3175110ed603fb7b9537
commit: 50690762cfe32abadbaa5b22bebe3855e5b8ede8 [2/3] iommu/vt-d: Fix leaked ioremap mapping
reproduce:
  # apt-get install sparse
  git checkout 50690762cfe32abadbaa5b22bebe3855e5b8ede8
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/iommu/intel_irq_remapping.c:411:22: sparse: incorrect type in assignment (different address spaces)
   drivers/iommu/intel_irq_remapping.c:411:22:    expected struct irte *old_ir_table
   drivers/iommu/intel_irq_remapping.c:411:22:    got void [noderef] <asn:2>*
>> drivers/iommu/intel_irq_remapping.c:429:17: sparse: incorrect type in argument 1 (different address spaces)
   drivers/iommu/intel_irq_remapping.c:429:17:    expected void volatile [noderef] <asn:2>*addr
   drivers/iommu/intel_irq_remapping.c:429:17:    got struct irte *old_ir_table

vim +429 drivers/iommu/intel_irq_remapping.c

   405			return -EINVAL;
   406	
   407		irt_phys = irta & VTD_PAGE_MASK;
   408		size     = INTR_REMAP_TABLE_ENTRIES*sizeof(struct irte);
   409	
   410		/* Map the old IR table */
 > 411		old_ir_table = ioremap_cache(irt_phys, size);
   412		if (!old_ir_table)
   413			return -ENOMEM;
   414	
   415		/* Copy data over */
   416		memcpy(iommu->ir_table->base, old_ir_table, size);
   417	
   418		__iommu_flush_cache(iommu, iommu->ir_table->base, size);
   419	
   420		/*
   421		 * Now check the table for used entries and mark those as
   422		 * allocated in the bitmap
   423		 */
   424		for (i = 0; i < INTR_REMAP_TABLE_ENTRIES; i++) {
   425			if (iommu->ir_table->base[i].present)
   426				bitmap_set(iommu->ir_table->bitmap, i, 1);
   427		}
   428	
 > 429		iounmap(old_ir_table);
   430	
   431		return 0;
   432	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
