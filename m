From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC Patch V1 0/9] Simplify initialization of IR on x86 platforms
Date: Wed, 10 Dec 2014 14:47:42 +0800
Message-ID: <1418194071-13785-1-git-send-email-jiang.liu@linux.intel.com>
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
To: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is a following-on patch set to simplify initialization of interrupt
remapping subsystem on x86 platforms. Please refer to
	https://lkml.org/lkml/2014/12/5/114
for the whole story.

With this patch set applied, there are three steps to initialize IR on x86:
1) "Detect" stage to detect ACPI table for IR at early booting stage
2) "Prepare" stage to allocate resources for IR
3) "Enable" stage to program hardware device to enable IR

Patch 1-3 clean up the code to initialize IR and X2APIC on x86
Patch 4-5 kill the irq_remapping_supported() and related code
Patch 6-9 clean up IR code further.

It's based on tip/x86/apic branch and could be pulled from:
https://github.com/jiangliu/linux.git irq_remapping_v1

It has been tested on Intel platform with X2APIC enabled and disabled.
It also passes Fengguang's 0day test suite. Tests on AMD platform are
welcomed!

Jiang Liu (9):
  x86, apic: Kill useless variable x2apic_enabled in function
    enable_IR_x2apic()
  x86, apic: Correctly detect X2APIC status in function enable_IR()
  x86, apic: Refine enable_IR_x2apic() and related functions
  iommu/vt-d: Prepare for killing function irq_remapping_supported()
  iommu/irq_remapping: Kill function irq_remapping_supported() and
    related code
  iommu/irq_remapping: Refine function irq_remapping_prepare() for
    maintenance
  iommu/irq_remapping: Change variable disable_irq_remap to be static
  iommu/irq_remapping: Normailize the way to detect whether IR is
    enabled
  iommu/irq_remapping: Kill unused function irq_remapping_print_chip()

 arch/x86/include/asm/irq_remapping.h |    4 --
 arch/x86/kernel/apic/apic.c          |   89 +++++++++++++++-------------------
 drivers/iommu/amd_iommu.c            |    1 -
 drivers/iommu/amd_iommu_init.c       |   10 +---
 drivers/iommu/amd_iommu_proto.h      |    1 -
 drivers/iommu/intel_irq_remapping.c  |   59 ++++++++--------------
 drivers/iommu/irq_remapping.c        |   74 +++++++++-------------------
 drivers/iommu/irq_remapping.h        |    5 --
 8 files changed, 84 insertions(+), 159 deletions(-)

-- 
1.7.10.4
