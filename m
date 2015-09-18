From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v9 00/18] Add VT-d Posted-Interrupts support - including
	prerequisite series
Date: Fri, 18 Sep 2015 11:57:59 -0600
Message-ID: <1442599079.23936.261.camel@redhat.com>
References: <1442586596-5920-1-git-send-email-feng.wu@intel.com>
	<55FC2699.10608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <55FC2699.10608-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2015-09-18 at 16:58 +0200, Paolo Bonzini wrote:
> 
> On 18/09/2015 16:29, Feng Wu wrote:
> > VT-d Posted-Interrupts is an enhancement to CPU side Posted-Interrupt.
> > With VT-d Posted-Interrupts enabled, external interrupts from
> > direct-assigned devices can be delivered to guests without VMM
> > intervention when guest is running in non-root mode.
> > 
> > You can find the VT-d Posted-Interrtups Spec. in the following URL:
> > http://www.intel.com/content/www/us/en/intelligent-systems/intel-technology/vt-directed-io-spec.html
> 
> Thanks.  I will squash patches 2 and 14 together, and drop patch 3.
> 
> Signed-off-bys are missing in patch 1 and 4.  The patches exist
> elsewhere in the mailing list archives, so not a big deal.  Or just
> reply to them with the S-o-b line.
> 
> Alex, can you ack the series and review patch 12?

I sent an ack for 12 separately, I got a bit lost in 16 & 17, but for
all the others that don't already have some tag from me,

Reviewed-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

> 
> Joerg, can you ack patch 18?
> 
> Paolo
> 
> > v9:
> > - Include the whole series:
> > [01/18]: irq bypasser manager
> > [02/18] - [06/18]: Common non-architecture part for VT-d PI and ARM side forwarded irq
> > [07/18] - [18/18]: VT-d PI part
> > 
> > v8:
> > refer to the changelog in each patch
> > 
> > v7:
> > * Define two weak irq bypass callbacks:
> >   - kvm_arch_irq_bypass_start()
> >   - kvm_arch_irq_bypass_stop()
> > * Remove the x86 dummy implementation of the above two functions.
> > * Print some useful information instead of WARN_ON() when the
> >   irq bypass consumer unregistration fails.
> > * Fix an issue when calling pi_pre_block and pi_post_block.
> > 
> > v6:
> > * Rebase on 4.2.0-rc6
> > * Rebase on https://lkml.org/lkml/2015/8/6/526 and http://www.gossamer-threads.com/lists/linux/kernel/2235623
> > * Make the add_consumer and del_consumer callbacks static
> > * Remove pointless INIT_LIST_HEAD to 'vdev->ctx[vector].producer.node)'
> > * Use dev_info instead of WARN_ON() when irq_bypass_register_producer fails
> > * Remove optional dummy callbacks for irq producer
> > 
> > v4:
> > * For lowest-priority interrupt, only support single-CPU destination
> > interrupts at the current stage, more common lowest priority support
> > will be added later.
> > * Accoring to Marcelo's suggestion, when vCPU is blocked, we handle
> > the posted-interrupts in the HLT emulation path.
> > * Some small changes (coding style, typo, add some code comments)
> > 
> > v3:
> > * Adjust the Posted-interrupts Descriptor updating logic when vCPU is
> >   preempted or blocked.
> > * KVM_DEV_VFIO_DEVICE_POSTING_IRQ --> KVM_DEV_VFIO_DEVICE_POST_IRQ
> > * __KVM_HAVE_ARCH_KVM_VFIO_POSTING --> __KVM_HAVE_ARCH_KVM_VFIO_POST
> > * Add KVM_DEV_VFIO_DEVICE_UNPOST_IRQ attribute for VFIO irq, which
> >   can be used to change back to remapping mode.
> > * Fix typo
> > 
> > v2:
> > * Use VFIO framework to enable this feature, the VFIO part of this series is
> >   base on Eric's patch "[PATCH v3 0/8] KVM-VFIO IRQ forward control"
> > * Rebase this patchset on git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git,
> >   then revise some irq logic based on the new hierarchy irqdomain patches provided
> >   by Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > 
> > 
> > *** BLURB HERE ***
> > 
> > Alex Williamson (1):
> >   virt: IRQ bypass manager
> > 
> > Eric Auger (4):
> >   KVM: arm/arm64: select IRQ_BYPASS_MANAGER
> >   KVM: create kvm_irqfd.h
> >   KVM: introduce kvm_arch functions for IRQ bypass
> >   KVM: eventfd: add irq bypass consumer management
> > 
> > Feng Wu (13):
> >   KVM: x86: select IRQ_BYPASS_MANAGER
> >   KVM: Extend struct pi_desc for VT-d Posted-Interrupts
> >   KVM: Add some helper functions for Posted-Interrupts
> >   KVM: Define a new interface kvm_intr_is_single_vcpu()
> >   KVM: Make struct kvm_irq_routing_table accessible
> >   KVM: make kvm_set_msi_irq() public
> >   vfio: Register/unregister irq_bypass_producer
> >   KVM: x86: Update IRTE for posted-interrupts
> >   KVM: Implement IRQ bypass consumer callbacks for x86
> >   KVM: Add an arch specific hooks in 'struct kvm_kernel_irqfd'
> >   KVM: Update Posted-Interrupts Descriptor when vCPU is preempted
> >   KVM: Update Posted-Interrupts Descriptor when vCPU is blocked
> >   iommu/vt-d: Add a command line parameter for VT-d posted-interrupts
> > 
> >  Documentation/kernel-parameters.txt   |   1 +
> >  Documentation/virtual/kvm/locking.txt |  12 ++
> >  MAINTAINERS                           |   7 +
> >  arch/arm/kvm/Kconfig                  |   2 +
> >  arch/arm/kvm/Makefile                 |   1 +
> >  arch/arm64/kvm/Kconfig                |   2 +
> >  arch/arm64/kvm/Makefile               |   1 +
> >  arch/x86/include/asm/kvm_host.h       |  24 +++
> >  arch/x86/kvm/Kconfig                  |   3 +
> >  arch/x86/kvm/Makefile                 |   3 +
> >  arch/x86/kvm/irq_comm.c               |  32 ++-
> >  arch/x86/kvm/lapic.c                  |  59 ++++++
> >  arch/x86/kvm/lapic.h                  |   2 +
> >  arch/x86/kvm/trace.h                  |  33 ++++
> >  arch/x86/kvm/vmx.c                    | 361 +++++++++++++++++++++++++++++++++-
> >  arch/x86/kvm/x86.c                    | 108 +++++++++-
> >  drivers/iommu/irq_remapping.c         |  12 +-
> >  drivers/vfio/pci/Kconfig              |   1 +
> >  drivers/vfio/pci/vfio_pci_intrs.c     |   9 +
> >  drivers/vfio/pci/vfio_pci_private.h   |   2 +
> >  include/linux/irqbypass.h             |  90 +++++++++
> >  include/linux/kvm_host.h              |  29 +++
> >  include/linux/kvm_irqfd.h             |  71 +++++++
> >  virt/kvm/Kconfig                      |   3 +
> >  virt/kvm/eventfd.c                    | 142 +++++++------
> >  virt/kvm/irqchip.c                    |  10 -
> >  virt/kvm/kvm_main.c                   |   3 +
> >  virt/lib/Kconfig                      |   2 +
> >  virt/lib/Makefile                     |   1 +
> >  virt/lib/irqbypass.c                  | 257 ++++++++++++++++++++++++
> >  30 files changed, 1182 insertions(+), 101 deletions(-)
> >  create mode 100644 include/linux/irqbypass.h
> >  create mode 100644 include/linux/kvm_irqfd.h
> >  create mode 100644 virt/lib/Kconfig
> >  create mode 100644 virt/lib/Makefile
> >  create mode 100644 virt/lib/irqbypass.c
> > 
