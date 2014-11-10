From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 00/13] Add VT-d Posted-Interrupts support for KVM
Date: Mon, 10 Nov 2014 14:26:39 +0800
Message-ID: <1415600812-27773-1-git-send-email-feng.wu@intel.com>
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
To: gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

VT-d Posted-Interrupts is an enhancement to CPU side Posted-Interrupt.
With VT-d Posted-Interrupts enabled, external interrupts from
direct-assigned devices can be delivered to guests without VMM
intervention when guest is running in non-root mode.

You can find the VT-d Posted-Interrtups Spec. in the following URL:
http://www.intel.com/content/www/us/en/intelligent-systems/intel-technology/vt-directed-io-spec.html

Feng Wu (13):
  iommu/vt-d: VT-d Posted-Interrupts feature detection
  KVM: Initialize VT-d Posted-Interrtups Descriptor
  KVM: Add KVM_CAP_PI to detect VT-d Posted-Interrtups
  iommu/vt-d: Adjust 'struct irte' to better suit for VT-d
    Posted-Interrupts
  KVM: Update IRTE according to guest interrupt configuration changes
  KVM: Add some helper functions for Posted-Interrupts
  x86, irq: Define a global vector for VT-d Posted-Interrupts
  KVM: Update Posted-Interrupts descriptor during VCPU scheduling
  KVM: Change NDST field after VCPU scheduling
  KVM: Add the handler for Wake-up Vector
  KVM: Suppress posted-interrupt when 'SN' is set
  iommu/vt-d: No need to migrating irq for VT-d Posted-Interrtups
  iommu/vt-d: Add a command line parameter for VT-d posted-interrupts

 arch/x86/include/asm/entry_arch.h    |    2 +
 arch/x86/include/asm/hardirq.h       |    1 +
 arch/x86/include/asm/hw_irq.h        |    2 +
 arch/x86/include/asm/irq_remapping.h |    7 +
 arch/x86/include/asm/irq_vectors.h   |    1 +
 arch/x86/include/asm/kvm_host.h      |    9 ++
 arch/x86/kernel/apic/apic.c          |    1 +
 arch/x86/kernel/entry_64.S           |    2 +
 arch/x86/kernel/irq.c                |   27 ++++
 arch/x86/kernel/irqinit.c            |    2 +
 arch/x86/kvm/vmx.c                   |  257 +++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c                   |   53 ++++++-
 drivers/iommu/amd_iommu.c            |    6 +
 drivers/iommu/intel_irq_remapping.c  |   83 +++++++++--
 drivers/iommu/irq_remapping.c        |   20 +++
 drivers/iommu/irq_remapping.h        |    8 +
 include/linux/dmar.h                 |   30 ++++-
 include/linux/intel-iommu.h          |    1 +
 include/linux/kvm_host.h             |   25 ++++
 include/uapi/linux/kvm.h             |    2 +
 virt/kvm/assigned-dev.c              |  141 +++++++++++++++++++
 virt/kvm/irq_comm.c                  |    4 +-
 virt/kvm/irqchip.c                   |   11 --
 virt/kvm/kvm_main.c                  |   14 ++
 24 files changed, 667 insertions(+), 42 deletions(-)
