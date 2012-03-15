From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [RFC PATCH 0/9] Introduce irq_remap_ops to x86
Date: Thu, 15 Mar 2012 18:39:42 +0100
Message-ID: <1331833191-25779-1-git-send-email-joerg.roedel@amd.com>
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
Cc: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

in order to implement interrupt remapping using the AMD IOMMU I did some
refactoring of the current Intel-specific interrupt remapping code. The
result is posted for comments in this patch-set.

The patch-set basically removes the Intel-specific calls from the X86
apic and io-apic code and replaces all of them with helper functions
that use the irq_remap_ops to hook into an implementation specific
implementation.

I have done basic testing on this patch-set on a VT-d machine with
interrupt remapping and found no regression so far. But as usual this
doesn't mean that there is none ;-)

Anyway, since I am on vacation soon I sent out these patches to receive
all kinds of comments so that I can start over to add the AMD part when
I am back.

Thanks,

	Joerg

Diffstat:

 arch/ia64/include/asm/intr_remapping.h |    4 +
 arch/x86/include/asm/intr_remapping.h  |  101 +++
 arch/x86/include/asm/irq_remapping.h   |   45 --
 arch/x86/kernel/apic/apic.c            |   20 +-
 arch/x86/kernel/apic/io_apic.c         |  276 ++-------
 drivers/iommu/Makefile                 |    2 +-
 drivers/iommu/amd_iommu_init.c         |  123 +++--
 drivers/iommu/dmar.c                   |    1 +
 drivers/iommu/intel-iommu.c            |    1 +
 drivers/iommu/intel_intr_remapping.c   | 1065 ++++++++++++++++++++++++++++++++
 drivers/iommu/intr_remapping.c         |  810 +++----------------------
 drivers/iommu/intr_remapping.h         |   97 +++-
 include/linux/amd-iommu.h              |    2 +-
 include/linux/dmar.h                   |   85 ---
 14 files changed, 1469 insertions(+), 1163 deletions(-)
