From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v2 0/3] iommu/amd: Enable x2APIC support
Date: Wed, 27 Jun 2018 10:31:19 -0500
Message-ID: <1530113482-85632-1-git-send-email-suravee.suthikulpanit@amd.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This series enable x2APIC support for AMD platform by enabling
AMD IOMMU XT mode to allow interrupt remapping with 32-bit
destination APIC ID.

For full x2APIC support, the following patches are also required
(already available in v4.18-rc1)
  * 6c4f5abaf356 ("x86/CPU: Modify detect_extended_topology() to return result")
  * 3986a0a805e6 ("x86/CPU/AMD: Derive CPU topology from CPUID function 0xB when available")

Thanks,
Suravee

Changes from V1 (https://lkml.org/lkml/2018/6/22/645):
  * 3/3: Declare the variable amd_iommu_xt_mode as static (per kbuild test robot)

Suravee Suthikulpanit (3):
  x86: irq_remapping: Move irq remapping mode enum
  iommu/amd: Add support for higher 64-bit IOMMU Control Register
  iommu/amd: Add support for IOMMU XT mode

 arch/x86/include/asm/irq_remapping.h |  5 ++++
 drivers/iommu/amd_iommu.c            | 21 +++++++++++----
 drivers/iommu/amd_iommu_init.c       | 51 +++++++++++++++++++++++++-----------
 drivers/iommu/amd_iommu_types.h      | 17 +++++++-----
 include/linux/dmar.h                 |  5 ----
 5 files changed, 68 insertions(+), 31 deletions(-)

-- 
2.7.4
