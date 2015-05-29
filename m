From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [iommu:x86/vt-d 5/10] drivers/iommu/intel-iommu.c:4951:9: sparse:
	incorrect type in argument 2 (different address spaces)
Date: Sat, 30 May 2015 02:56:26 +0800
Message-ID: <201505300224.x7VyFq8U%fengguang.wu@intel.com>
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
commit: 0094b0dede547c1af03f93092f2ad25566c18f6b [5/10] iommu/vt-d: Add functions to load and save old root entry
reproduce:
  # apt-get install sparse
  git checkout 0094b0dede547c1af03f93092f2ad25566c18f6b
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/iommu/intel-iommu.c:4951:9: sparse: incorrect type in argument 2 (different address spaces)
   drivers/iommu/intel-iommu.c:4951:9:    expected void const *from
   drivers/iommu/intel-iommu.c:4951:9:    got void [noderef] <asn:2>*root_entry_old_virt
>> drivers/iommu/intel-iommu.c:4985:9: sparse: incorrect type in argument 1 (different address spaces)
   drivers/iommu/intel-iommu.c:4985:9:    expected void *to
   drivers/iommu/intel-iommu.c:4985:9:    got void [noderef] <asn:2>*
>> drivers/iommu/intel-iommu.c:4987:39: sparse: incorrect type in argument 2 (different address spaces)
   drivers/iommu/intel-iommu.c:4987:39:    expected void *addr
   drivers/iommu/intel-iommu.c:4987:39:    got void [noderef] <asn:2>*
   drivers/iommu/intel-iommu.c:1161:13: sparse: symbol 'domain_unmap' was not declared. Should it be static?
   drivers/iommu/intel-iommu.c:1187:6: sparse: symbol 'dma_free_pagelist' was not declared. Should it be static?
   drivers/iommu/intel-iommu.c:4878:17: sparse: incorrect type in argument 2 (different address spaces)
   drivers/iommu/intel-iommu.c:4878:17:    expected void const *from
   drivers/iommu/intel-iommu.c:4878:17:    got void [noderef] <asn:2>*[assigned] virt_mem
   drivers/iommu/intel-iommu.c:4915:17: sparse: incorrect type in argument 1 (different address spaces)
   drivers/iommu/intel-iommu.c:4915:17:    expected void *to
   drivers/iommu/intel-iommu.c:4915:17:    got void [noderef] <asn:2>*[assigned] virt_mem
   drivers/iommu/intel-iommu.c:4832:30: warning: 'device_to_existing_context_entry' defined but not used [-Wunused-function]
    static struct context_entry *device_to_existing_context_entry(
                                 ^
   drivers/iommu/intel-iommu.c:4944:13: warning: '__iommu_load_old_root_entry' defined but not used [-Wunused-function]
    static void __iommu_load_old_root_entry(struct intel_iommu *iommu)
                ^
   drivers/iommu/intel-iommu.c:4960:13: warning: '__iommu_update_old_root_entry' defined but not used [-Wunused-function]
    static void __iommu_update_old_root_entry(struct intel_iommu *iommu, int index)
                ^

vim +4951 drivers/iommu/intel-iommu.c

  4945	{
  4946		if ((!iommu)
  4947			|| (!iommu->root_entry)
  4948			|| (!iommu->root_entry_old_virt)
  4949			|| (!iommu->root_entry_old_phys))
  4950			return;
> 4951		memcpy(iommu->root_entry, iommu->root_entry_old_virt, PAGE_SIZE);
  4952	
  4953		__iommu_flush_cache(iommu, iommu->root_entry, PAGE_SIZE);
  4954	}
  4955	
  4956	/*
  4957	 * When the data in new root entry table is changed, this function
  4958	 * must be called to save the updated data to old root entry table.
  4959	 */
  4960	static void __iommu_update_old_root_entry(struct intel_iommu *iommu, int index)
  4961	{
  4962		u8 start;
  4963		unsigned long size;
  4964		void __iomem *to;
  4965		void *from;
  4966	
  4967		if ((!iommu)
  4968			|| (!iommu->root_entry)
  4969			|| (!iommu->root_entry_old_virt)
  4970			|| (!iommu->root_entry_old_phys))
  4971			return;
  4972	
  4973		if (index < -1 || index >= ROOT_ENTRY_NR)
  4974			return;
  4975	
  4976		if (index == -1) {
  4977			start = 0;
  4978			size = ROOT_ENTRY_NR * sizeof(struct root_entry);
  4979		} else {
  4980			start = index * sizeof(struct root_entry);
  4981			size = sizeof(struct root_entry);
  4982		}
  4983		to = iommu->root_entry_old_virt;
  4984		from = iommu->root_entry;
> 4985		memcpy(to + start, from + start, size);
  4986	
> 4987		__iommu_flush_cache(iommu, to + start, size);
  4988	}
  4989	

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
