From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [iommu:x86/vt-d 4/10] drivers/iommu/intel-iommu.c:4875:17: sparse:
	incorrect type in argument 2 (different address spaces)
Date: Sat, 30 May 2015 02:48:03 +0800
Message-ID: <201505300200.zDmdNbJf%fengguang.wu@intel.com>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git x86/vt-d
head:   6c37b5ba0e4df96647677fac5d87d9fd561c3ef8
commit: ebe05c7397dc63d99fb3ec69a37b4440952089bc [4/10] iommu/vt-d: Functions to copy data from old mem
reproduce:
  # apt-get install sparse
  git checkout ebe05c7397dc63d99fb3ec69a37b4440952089bc
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/iommu/intel-iommu.c:1158:13: sparse: symbol 'domain_unmap' was not declared. Should it be static?
   drivers/iommu/intel-iommu.c:1184:6: sparse: symbol 'dma_free_pagelist' was not declared. Should it be static?
>> drivers/iommu/intel-iommu.c:4875:17: sparse: incorrect type in argument 2 (different address spaces)
   drivers/iommu/intel-iommu.c:4875:17:    expected void const *from
   drivers/iommu/intel-iommu.c:4875:17:    got void [noderef] <asn:2>*[assigned] virt_mem
>> drivers/iommu/intel-iommu.c:4912:17: sparse: incorrect type in argument 1 (different address spaces)
   drivers/iommu/intel-iommu.c:4912:17:    expected void *to
   drivers/iommu/intel-iommu.c:4912:17:    got void [noderef] <asn:2>*[assigned] virt_mem
   drivers/iommu/intel-iommu.c:4829:30: warning: 'device_to_existing_context_entry' defined but not used [-Wunused-function]
    static struct context_entry *device_to_existing_context_entry(
                                 ^

vim +4875 drivers/iommu/intel-iommu.c

  4869	
  4870			virt_mem = ioremap_cache((unsigned long)from, size);
  4871			if (!virt_mem) {
  4872				kfree(mapped);
  4873				return -ENOMEM;
  4874			}
> 4875			memcpy(to, virt_mem, size);
  4876	
  4877			mutex_lock(&__iommu_mem_list_lock);
  4878			mapped->mem = virt_mem;
  4879			list_add_tail(&mapped->list, &__iommu_remapped_mem);
  4880			mutex_unlock(&__iommu_mem_list_lock);
  4881		}
  4882		return size;
  4883	}
  4884	
  4885	/*
  4886	 * Copy memory from a virtually-addressed area into a physically-addressed area
  4887	 */
  4888	int __iommu_save_to_oldmem(unsigned long to, void *from, unsigned long size)
  4889	{
  4890		unsigned long pfn;		/* Page Frame Number */
  4891		size_t csize = (size_t)size;	/* Num(bytes to copy) */
  4892		unsigned long offset;		/* Lower 12 bits of to */
  4893		void __iomem *virt_mem;
  4894		struct iommu_remapped_entry *mapped;
  4895	
  4896		pfn = to >> VTD_PAGE_SHIFT;
  4897		offset = to & (~VTD_PAGE_MASK);
  4898	
  4899		if (page_is_ram(pfn)) {
  4900			memcpy(pfn_to_kaddr(pfn) + offset, from, csize);
  4901		} else{
  4902			mapped = kzalloc(sizeof(struct iommu_remapped_entry),
  4903					GFP_KERNEL);
  4904			if (!mapped)
  4905				return -ENOMEM;
  4906	
  4907			virt_mem = ioremap_cache((unsigned long)to, size);
  4908			if (!virt_mem) {
  4909				kfree(mapped);
  4910				return -ENOMEM;
  4911			}
> 4912			memcpy(virt_mem, from, size);
  4913			mutex_lock(&__iommu_mem_list_lock);
  4914			mapped->mem = virt_mem;
  4915			list_add_tail(&mapped->list, &__iommu_remapped_mem);

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
