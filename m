From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 00/17] Add VT-d Posted-Interrupts support
Date: Tue, 25 Aug 2015 16:50:03 +0800
Message-ID: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

VT-d Posted-Interrupts is an enhancement to CPU side Posted-Interrupt.
With VT-d Posted-Interrupts enabled, external interrupts from
direct-assigned devices can be delivered to guests without VMM
intervention when guest is running in non-root mode.

You can find the VT-d Posted-Interrtups Spec. in the following URL:
http://www.intel.com/content/www/us/en/intelligent-systems/intel-technology/vt-directed-io-spec.html

v7:
* Define two weak irq bypass callbacks:
  - kvm_arch_irq_bypass_start()
  - kvm_arch_irq_bypass_stop()
* Remove the x86 dummy implementation of the above two functions.
* Print some useful information instead of WARN_ON() when the
  irq bypass consumer unregistration fails.
* Fix an issue when calling pi_pre_block and pi_post_block.

v6:
* Rebase on 4.2.0-rc6
* Rebase on https://lkml.org/lkml/2015/8/6/526 and http://www.gossamer-threads.com/lists/linux/kernel/2235623
* Make the add_consumer and del_consumer callbacks static
* Remove pointless INIT_LIST_HEAD to 'vdev->ctx[vector].producer.node)'
* Use dev_info instead of WARN_ON() when irq_bypass_register_producer fails
* Remove optional dummy callbacks for irq producer

v4:
* For lowest-priority interrupt, only support single-CPU destination
interrupts at the current stage, more common lowest priority support
will be added later.
* Accoring to Marcelo's suggestion, when vCPU is blocked, we handle
the posted-interrupts in the HLT emulation path.
* Some small changes (coding style, typo, add some code comments)

v3:
* Adjust the Posted-interrupts Descriptor updating logic when vCPU is
  preempted or blocked.
* KVM_DEV_VFIO_DEVICE_POSTING_IRQ --> KVM_DEV_VFIO_DEVICE_POST_IRQ
* __KVM_HAVE_ARCH_KVM_VFIO_POSTING --> __KVM_HAVE_ARCH_KVM_VFIO_POST
* Add KVM_DEV_VFIO_DEVICE_UNPOST_IRQ attribute for VFIO irq, which
  can be used to change back to remapping mode.
* Fix typo

v2:
* Use VFIO framework to enable this feature, the VFIO part of this series is
  base on Eric's patch "[PATCH v3 0/8] KVM-VFIO IRQ forward control"
* Rebase this patchset on git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git,
  then revise some irq logic based on the new hierarchy irqdomain patches provided
  by Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Feng Wu (17):
  KVM: Extend struct pi_desc for VT-d Posted-Interrupts
  KVM: Add some helper functions for Posted-Interrupts
  KVM: Define a new interface kvm_intr_is_single_vcpu()
  KVM: Get Posted-Interrupts descriptor address from 'struct kvm_vcpu'
  KVM: Add interfaces to control PI outside vmx
  KVM: Make struct kvm_irq_routing_table accessible
  KVM: make kvm_set_msi_irq() public
  vfio: Select IRQ_BYPASS_MANAGER for vfio PCI devices
  vfio: Register/unregister irq_bypass_producer
  KVM: x86: Update IRTE for posted-interrupts
  KVM: Define two weak arch callbacks for irq bypass manager
  KVM: Implement IRQ bypass consumer callbacks for x86
  KVM: Add an arch specific hooks in 'struct kvm_kernel_irqfd'
  KVM: Update Posted-Interrupts Descriptor when vCPU is preempted
  KVM: Update Posted-Interrupts Descriptor when vCPU is blocked
  KVM: Warn if 'SN' is set during posting interrupts by software
  iommu/vt-d: Add a command line parameter for VT-d posted-interrupts

 Documentation/kernel-parameters.txt |   1 +
 arch/x86/include/asm/kvm_host.h     |  20 +++
 arch/x86/kvm/Kconfig                |   1 +
 arch/x86/kvm/irq_comm.c             |  28 +++-
 arch/x86/kvm/vmx.c                  | 288 +++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c                  | 167 +++++++++++++++++++--
 drivers/iommu/irq_remapping.c       |  12 +-
 drivers/vfio/pci/Kconfig            |   1 +
 drivers/vfio/pci/vfio_pci_intrs.c   |   9 ++
 drivers/vfio/pci/vfio_pci_private.h |   2 +
 include/linux/kvm_host.h            |  28 ++++
 include/linux/kvm_irqfd.h           |   2 +
 virt/kvm/eventfd.c                  |  22 ++-
 virt/kvm/irqchip.c                  |  10 --
 virt/kvm/kvm_main.c                 |   3 +
 15 files changed, 565 insertions(+), 29 deletions(-)

-- 
2.1.0
