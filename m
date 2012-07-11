From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/27] AMD IOMMU interrupt remapping support v2
Date: Wed, 11 Jul 2012 15:38:45 +0200
Message-ID: <1342013952-10174-1-git-send-email-joerg.roedel@amd.com>
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

here is the second and revised patch-set to add interrupt remapping
support to the AMD IOMMU driver.

Changes v1->v2:

	* Improved print_iommu_info() function as suggested by Joe
	  Perches
	* Fixed all five problems reported by Fengguang Wu from Intel,
	  thanks again for the extensive compile tests
	* Fixed other sparse warnings I came across while fixing the
	  compile bug reports
	* Dropped patch 3 which introduced another flag into io-apic
	  code. I started to abstract the interrupt remapping support
	  better from the io-apic implementation and will post that as a
	  seperate patch-set (if all goes well probably next week). The
	  new patch-set will make use of the x86_io_apic_ops and
	  x86_msi_ops to get rid of the irq_remapping_enabled checks and
	  branches.
	* Rebased to v3.5-rc6

Please review. Feedback appreciated :-)


Regards,

	Joerg


Diffstat:

 arch/x86/include/asm/hw_irq.h       |   15 +-
 arch/x86/kernel/apic/io_apic.c      |    2 +-
 drivers/iommu/Kconfig               |    2 +-
 drivers/iommu/amd_iommu.c           |  509 +++++++++++++++++++++-
 drivers/iommu/amd_iommu_init.c      |  790 ++++++++++++++++++++++++-----------
 drivers/iommu/amd_iommu_proto.h     |    8 +
 drivers/iommu/amd_iommu_types.h     |   66 ++-
 drivers/iommu/amd_iommu_v2.c        |    2 +-
 drivers/iommu/intel_irq_remapping.c |    6 +-
 drivers/iommu/irq_remapping.c       |   10 +
 drivers/iommu/irq_remapping.h       |    5 +
 11 files changed, 1167 insertions(+), 248 deletions(-)
