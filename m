From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/2] Kernel MMU notifier for IOTLB/DEVTLB management
Date: Thu, 14 Dec 2017 09:02:44 +0800
Message-ID: <1513213366-22594-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: iommu@lists.linux-foundation.org, x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Shared Virtual Memory (SVM) allows a kernel memory mapping to be
shared between CPU and and a device which requested a supervisor
PASID. Both devices and IOMMU units have TLBs that cache entries
from CPU's page tables. We need to get a chance to flush them at
the same time when we flush the CPU TLBs.

These patches handle this by adding a kernel MMU notifier chain.
The callbacks on this chain will be called whenever the CPU TLB
is flushed for the kernel address space.

Ashok Raj (1):
  iommu/vt-d: Register kernel MMU notifier to manage IOTLB/DEVTLB

Huang Ying (1):
  mm: Add kernel MMU notifier to manage IOTLB/DEVTLB

 arch/x86/mm/tlb.c            |  2 ++
 drivers/iommu/intel-svm.c    | 27 +++++++++++++++++++++++++--
 include/linux/intel-iommu.h  |  5 ++++-
 include/linux/mmu_notifier.h | 33 +++++++++++++++++++++++++++++++++
 mm/mmu_notifier.c            | 27 +++++++++++++++++++++++++++
 5 files changed, 91 insertions(+), 3 deletions(-)

-- 
2.7.4

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
