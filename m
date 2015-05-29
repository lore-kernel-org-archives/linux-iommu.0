From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [iommu:x86/vt-d 7/10] drivers/iommu/intel-iommu.c:920:22: sparse:
	incorrect type in assignment (different address spaces)
Date: Sat, 30 May 2015 03:12:42 +0800
Message-ID: <201505300339.JS0Vuh5k%fengguang.wu@intel.com>
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
To: "Li, Zhen-Hua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Cc: Bill Sumner <billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git x86/vt-d
head:   6c37b5ba0e4df96647677fac5d87d9fd561c3ef8
commit: 60d69731b2742d12178b54844b852de0549bbd87 [7/10] iommu/vt-d: enable kdump support in iommu module
reproduce:
  # apt-get install sparse
  git checkout 60d69731b2742d12178b54844b852de0549bbd87
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/iommu/intel-iommu.c:5023:9: sparse: incorrect type in argument 2 (different address spaces)
   drivers/iommu/intel-iommu.c:5023:9:    expected void const *from
   drivers/iommu/intel-iommu.c:5023:9:    got void [noderef] <asn:2>*root_entry_old_virt
   drivers/iommu/intel-iommu.c:5057:9: sparse: incorrect type in argument 1 (different address spaces)
   drivers/iommu/intel-iommu.c:5057:9:    expected void *to
   drivers/iommu/intel-iommu.c:5057:9:    got void [noderef] <asn:2>*
   drivers/iommu/intel-iommu.c:5059:39: sparse: incorrect type in argument 2 (different address spaces)
   drivers/iommu/intel-iommu.c:5059:39:    expected void *addr
   drivers/iommu/intel-iommu.c:5059:39:    got void [noderef] <asn:2>*
>> drivers/iommu/intel-iommu.c:920:22: sparse: incorrect type in assignment (different address spaces)
   drivers/iommu/intel-iommu.c:920:22:    expected struct root_entry *root
   drivers/iommu/intel-iommu.c:920:22:    got void [noderef] <asn:2>*root_entry_old_virt
>> drivers/iommu/intel-iommu.c:933:25: sparse: incorrect type in argument 1 (different address spaces)
   drivers/iommu/intel-iommu.c:933:25:    expected void volatile [noderef] <asn:2>*addr
   drivers/iommu/intel-iommu.c:933:25:    got struct root_entry *root
   drivers/iommu/intel-iommu.c:1192:13: sparse: symbol 'domain_unmap' was not declared. Should it be static?
   drivers/iommu/intel-iommu.c:1218:6: sparse: symbol 'dma_free_pagelist' was not declared. Should it be static?
   drivers/iommu/intel-iommu.c:4950:17: sparse: incorrect type in argument 2 (different address spaces)
   drivers/iommu/intel-iommu.c:4950:17:    expected void const *from
   drivers/iommu/intel-iommu.c:4950:17:    got void [noderef] <asn:2>*[assigned] virt_mem
   drivers/iommu/intel-iommu.c:4987:17: sparse: incorrect type in argument 1 (different address spaces)
   drivers/iommu/intel-iommu.c:4987:17:    expected void *to
   drivers/iommu/intel-iommu.c:4987:17:    got void [noderef] <asn:2>*[assigned] virt_mem
   drivers/iommu/intel-iommu.c:5111:12: sparse: context imbalance in 'intel_iommu_load_translation_tables' - different lock contexts for basic block

vim +920 drivers/iommu/intel-iommu.c

   914				free_pgtable_page(context);
   915	
   916		}
   917	
   918		if (iommu->pre_enabled_trans) {
   919			iommu->root_entry_old_phys = 0;
 > 920			root = iommu->root_entry_old_virt;
   921			iommu->root_entry_old_virt = NULL;
   922		}
   923	
   924		free_pgtable_page(iommu->root_entry);
   925		iommu->root_entry = NULL;
   926	
   927		spin_unlock_irqrestore(&iommu->lock, flags);
   928	
   929		/* We put this out of spin_unlock is because iounmap() may
   930		 * cause error if surrounded by spin_lock and unlock;
   931		 */
   932		if (iommu->pre_enabled_trans)
 > 933			iounmap(root);
   934	}
   935	
   936	static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
