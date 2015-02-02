From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v4 0/8] Add VT-d Posted-Interrupts support - IOMMU part
Date: Mon,  2 Feb 2015 16:01:46 +0800
Message-ID: <1422864114-19324-1-git-send-email-feng.wu@intel.com>
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
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAJQFI55V6+gNQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

VT-d Posted-Interrupts is an enhancement to CPU side Posted-Interrupt.
With VT-d Posted-Interrupts enabled, external interrupts from
direct-assigned devices can be delivered to guests without VMM
intervention when guest is running in non-root mode.

You can find the VT-d Posted-Interrtups Spec. in the following URL:
http://www.intel.com/content/www/us/en/intelligent-systems/intel-technology/vt-directed-io-spec.html

This series was part of http://thread.gmane.org/gmane.linux.kernel.iommu/7708. To make things clear, send out IOMMU part here.

v3->v4:
* Change capability to a int variant flags instead of a function call
* Add hotplug case for VT-d PI

Feng Wu (8):
  iommu: Add new member capability to struct irq_remap_ops
  iommu, x86: Define new irte structure for VT-d Posted-Interrupts
  iommu, x86: Implement irq_set_vcpu_affinity for intel_ir_chip
  iommu, x86: No need to migrating irq for VT-d Posted-Interrupts
  iommu, x86: Add cap_pi_support() to detect VT-d PI capability
  iommu, x86: Setup Posted-Interrupts capability for Intel iommu
  iommu, x86: define irq_remapping_cap()
  iommu, x86: Properly handler PI for IOMMU hotplug

 arch/x86/include/asm/irq_remapping.h |   11 +++++
 drivers/iommu/intel_irq_remapping.c  |   78 +++++++++++++++++++++++++++++++++-
 drivers/iommu/irq_remapping.c        |   11 +++++
 drivers/iommu/irq_remapping.h        |    6 +++
 include/linux/dmar.h                 |   32 ++++++++++++++
 include/linux/intel-iommu.h          |    1 +
 6 files changed, 138 insertions(+), 1 deletions(-)
