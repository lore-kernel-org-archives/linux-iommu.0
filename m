From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch v2 00/16] Refine IR initialization flow and fixes bugs related
	to X2APIC
Date: Wed,  7 Jan 2015 15:31:27 +0800
Message-ID: <1420615903-28253-1-git-send-email-jiang.liu@linux.intel.com>
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
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When converting x86 to new hierarchy irqdoamin framework, Thomas noticed
that the interrupt remapping initialization flow is a little complex and
has troubles in memory allocation. Then there is a joint force to
simplify IR initialization flow, please refer to related threads at:
https://lkml.org/lkml/2014/12/5/114
https://lkml.org/lkml/2014/12/10/20
https://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg788792.html

This patch set is based on v3.19-rc3. And you may access it at:
https://github.com/jiangliu/linux.git ir_init_v2

This patch set combimes above three patches to simplify IR initalization
flow and solves memory allocation issues. While at it, this patch set
also refines CPU X2APIC initialization code for maintenance. It also
fixes two bugs related to X2APIC support.
1) System hangs or panics if BIOS enables CPU X2APIC mode but kernel
   doesn't support X2APIC.
2) System livelocks if BIOS enables CPU X2APIC but opt-outs IR X2APIC.

This patch set has been tested with on an Intel 4-socket system with
following configuration:
---------------------------------------------------------------------------
[CPU X2APIC]	[IR X2APIC]	[Linux IR]	[Linux X2APIC]	[Result]
1     D		    /		    D		    D		  OK
2     D		    /		    E		    D		  OK
3     D		    /		    E		    E		  OK
4     P		    /		    E		    E		  OK
5     P		    /		    D		    D		  Panic(expected)
6     P		    /		    E		    D		  Panic(expected)
7     P		    H		    E		    E		  OK
----------------------------------------------------------------------------
CPU X2APIC: whether CPU X2APIC is enabled by hardware and BIOS
IR X2APIC: whether interrupt remapping hardware supports X2APIC mode
Linux IR: whether interrupt remapping is enabled by Linux kernel
Linux X2APIC: whether X2APIC is supported by Linux kernel
D: disabled
E: enabled
/: Not care
P: CPU X2APIC pre-enabled by BIOS
H: Hard-coded to opt-out X2APIC support in interrupt remapping hardware

The patch set changes the behevior of the last three rows:
1) Row 5 and 6 panics with clear messages instead of random hang or panic.
2) Row 7 boots successfully instead of livelocking.

The patch set also passes Fengguang's 0day test suites.

Due to lack of hardware platforms for tests, tests on AMD platform are
welcomed!

V1->V2:
1) Rebase onto v3.19-rc3

Jiang Liu (11):
  x86/apic: Panic if kernel doesn't support x2apic but BIOS has enabled
    x2apic
  x86/apic: Kill useless variable x2apic_enabled in function
    enable_IR_x2apic()
  x86/apic: Correctly detect X2APIC status in function enable_IR()
  x86/apic: Refine enable_IR_x2apic() and related functions
  iommu/vt-d: Prepare for killing function irq_remapping_supported()
  iommu/vt-d: Allow IR works in XAPIC mode though CPU works in X2APIC
    mode
  x86/apic: Only disable CPU x2apic mode when necessary
  iommu/irq_remapping: Kill function irq_remapping_supported() and
    related code
  iommu/irq_remapping: Refine function irq_remapping_prepare() for
    maintenance
  iommu/irq_remapping: Change variable disable_irq_remap to be static
  iommu/irq_remapping: Normailize the way to detect whether IR is
    enabled

Joerg Roedel (2):
  iommu/vt-d: Allocate IRQ remapping data structures only for all
    IOMMUs
  iommu/amd: Check for irq-remap support amd_iommu_prepare()

Thomas Gleixner (3):
  iommu, x86: Restructure setup of the irq remapping feature
  iommu/vt-d: Move iommu preparatory allocations to
    irq_remap_ops.prepare
  iommu/vt-d: Convert allocations to GFP_KERNEL

 arch/x86/include/asm/irq_remapping.h |    4 --
 arch/x86/kernel/apic/apic.c          |  104 ++++++++++++++++------------------
 drivers/iommu/amd_iommu.c            |    1 -
 drivers/iommu/amd_iommu_init.c       |   10 +---
 drivers/iommu/amd_iommu_proto.h      |    1 -
 drivers/iommu/intel_irq_remapping.c  |   96 ++++++++++++++++---------------
 drivers/iommu/irq_remapping.c        |   74 ++++++++----------------
 drivers/iommu/irq_remapping.h        |    5 --
 8 files changed, 128 insertions(+), 167 deletions(-)

-- 
1.7.10.4
