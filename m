From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/28] AMD IOMMU interrupt remapping support
Date: Thu, 5 Jul 2012 14:36:20 +0200
Message-ID: <1341491808-23083-1-git-send-email-joerg.roedel@amd.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

this patch-set adds support for IRQ remapping to the AMD IOMMU driver in
Linux. It works similar to the already present IRQ remapping code for
VT-d. The IOAPIC, HPET and MSI interrupts have a fixed setup to index an
interrupt remapping table entry and the real vector and destination is
only configured in the IRQ remapping table. This means that also the IRQ
affinity is only changed in the IOMMU. The code was heavily
stress-tested on a lot of machines and no known issues are left.

I also pushed this code into a branch of the IOMMU tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git irq-remapping

Use this branch if you want to test the code yourself.

Any feedback appreciated :)

Thanks,

	Joerg

Diffstat:

 arch/x86/include/asm/hw_irq.h        |   15 +-
 arch/x86/include/asm/irq_remapping.h |    2 +
 arch/x86/kernel/apic/io_apic.c       |    6 +-
 drivers/iommu/amd_iommu.c            |  507 +++++++++++++++++++++-
 drivers/iommu/amd_iommu_init.c       |  772 ++++++++++++++++++++++++----------
 drivers/iommu/amd_iommu_proto.h      |    8 +
 drivers/iommu/amd_iommu_types.h      |   58 ++-
 drivers/iommu/intel_irq_remapping.c  |    8 +-
 drivers/iommu/irq_remapping.c        |    6 +
 drivers/iommu/irq_remapping.h        |    5 +
 10 files changed, 1151 insertions(+), 236 deletions(-)
