From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Updates for Linux v4.13
Date: Wed, 12 Jul 2017 13:42:08 +0200
Message-ID: <20170712114201.GA20642@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0821034292100631407=="
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
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============0821034292100631407==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Just a note before the request: This pull-request is against v4.12-rc7,
as I didn't rebase my next branch against the final v4.12. This means
that the two fixes that went into v4.12 already are also listed in the
shortlog and diffstat below.

Doing the pull-request against v4.12 blows up the diffstat, so I decided
to do the request against the last merge-base. Please let me know if I
should merge against v4.12 and re-send the request.

On a side note, there is a small and trivial merge-conflict in
Documentation/arm64/silicon-errata.txt coming with this pull-request.

With this in mind:

The following changes since commit c0bc126f97fb929b3ae02c1c62322645d70eb408:

  Linux 4.12-rc7 (2017-06-25 18:30:05 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.13

for you to fetch changes up to 6a7086431fa18df7d03b1ed0126426c79b38dc8c:

  Merge branches 'iommu/fixes', 'arm/rockchip', 'arm/renesas', 'arm/smmu', 'arm/core', 'x86/vt-d', 'x86/amd', 's390' and 'core' into next (2017-06-28 14:45:02 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v4.13

This update comes with:

	* Support for lockless operation in the ARM io-pgtable code.
	  This is an important step to solve the scalability problems in
	  the common dma-iommu code for ARM

	* Some Errata workarounds for ARM SMMU implemenations

	* Rewrite of the deferred IO/TLB flush code in the AMD IOMMU
	  driver. The code suffered from very high flush rates, with the
	  new implementation the flush rate is down to ~1% of what it
	  was before

	* Support for amd_iommu=off when booting with kexec. Problem
	  here was that the IOMMU driver bailed out early without
	  disabling the iommu hardware, if it was enabled in the old
	  kernel

	* The Rockchip IOMMU driver is now available on ARM64

	* Align the return value of the iommu_ops->device_group
	  call-backs to not miss error values

	* Preempt-disable optimizations in the Intel VT-d and common
	  IOVA code to help Linux-RT

	* Various other small cleanups and fixes

----------------------------------------------------------------
Arvind Yadav (4):
      iommu/io-pgtable-arm-v7s: constify dummy_tlb_ops.
      iommu: arm-smmu-v3: make of_device_ids const
      iommu: arm-smmu: Handle return of iommu_device_register.
      iommu/vt-d: Constify intel_dma_ops

CQ Tang (1):
      iommu/vt-d: Helper function to query if a pasid has any active users

Geetha Sowjanya (1):
      iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #126

Joerg Roedel (23):
      iommu/amd: Ratelimit io-page-faults per device
      iommu/amd: Rip out old queue flushing code
      iommu/amd: Add per-domain flush-queue data structures
      iommu/amd: Make use of the per-domain flush queue
      iommu/amd: Add locking to per-domain flush-queue
      iommu/amd: Add flush counters to struct dma_ops_domain
      iommu/amd: Add per-domain timer to flush per-cpu queues
      iommu/amd: Remove queue_release() function
      iommu/amd: Suppress IO_PAGE_FAULTs in kdump kernel
      iommu/amd: Disable IOMMUs at boot if they are enabled
      iommu/amd: Rename free_on_init_error()
      iommu/amd: Add new init-state IOMMU_CMDLINE_DISABLED
      iommu/amd: Check for error states first in iommu_go_to_state()
      iommu/amd: Set global pointers to NULL after freeing them
      iommu/amd: Free IOMMU resources when disabled on command line
      iommu/amd: Remove amd_iommu_disabled check from amd_iommu_detect()
      iommu/amd: Free already flushed ring-buffer entries before full-check
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      iommu/s390: Use iommu_group_get_for_dev() in s390_iommu_add_device()
      iommu: Return ERR_PTR() values from device_group call-backs
      iommu/omap: Return ERR_PTR in device_group call-back
      iommu: Warn once when device_group callback returns NULL
      Merge branches 'iommu/fixes', 'arm/rockchip', 'arm/renesas', 'arm/smmu', 'arm/core', 'x86/vt-d', 'x86/amd', 's390' and 'core' into next

Linu Cherian (2):
      ACPI/IORT: Fixup SMMUv3 resource size for Cavium ThunderX2 SMMUv3 model
      iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #74

Magnus Damm (8):
      iommu/ipmmu-vmsa: Remove platform data handling
      iommu/ipmmu-vmsa: Rework interrupt code and use bitmap for context
      iommu/ipmmu-vmsa: Break out utlb parsing code
      iommu/ipmmu-vmsa: Break out domain allocation code
      iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
      iommu/ipmmu-vmsa: Use fwspec iommu_priv on ARM64
      iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency
      iommu/ipmmu-vmsa: Fix pgsize_bitmap semicolon typo

Peter Xu (1):
      iommu/vt-d: Unwrap __get_valid_domain_for_dev()

Robert Richter (1):
      iommu/arm-smmu-v3, acpi: Add temporary Cavium SMMU-V3 IORT model number definitions

Robin Murphy (10):
      iommu/iova: Sort out rbtree limit_pfn handling
      iommu/arm-smmu: Plumb in new ACPI identifiers
      iommu/io-pgtable-arm-v7s: Check table PTEs more precisely
      iommu/io-pgtable-arm: Improve split_blk_unmap
      iommu/io-pgtable-arm-v7s: Refactor split_blk_unmap
      iommu/io-pgtable: Introduce explicit coherency
      iommu/io-pgtable-arm: Support lockless operation
      iommu/io-pgtable-arm-v7s: Support lockless operation
      iommu/arm-smmu: Remove io-pgtable spinlock
      iommu/arm-smmu-v3: Remove io-pgtable spinlock

Sebastian Andrzej Siewior (2):
      iommu/iova: Don't disable preempt around this_cpu_ptr()
      iommu/vt-d: Don't disable preemption while accessing deferred_flush()

Shaohua Li (1):
      iommu/vt-d: Correctly disable Intel IOMMU force on

Simon Xue (1):
      iommu/rockchip: Enable Rockchip IOMMU on ARM64

Sunil Goutham (1):
      iommu/arm-smmu-v3: Increase CMDQ drain timeout value

Suravee Suthikulpanit (1):
      iommu/amd: Fix interrupt remapping when disable guest_mode

Tobias Klauser (2):
      iommu/vt-d: Constify irq_domain_ops
      iommu/amd: Constify irq_domain_ops

Tom Lendacky (2):
      iommu/amd: Reduce amount of MMIO when submitting commands
      iommu/amd: Reduce delay waiting for command buffer space

Will Deacon (2):
      iommu/io-pgtable: depend on !GENERIC_ATOMIC64 when using COMPILE_TEST with LPAE
      iommu/io-pgtable-arm: Use dma_wmb() instead of wmb() when publishing table

shameer (1):
      iommu/arm-smmu-v3: Enable ACPI based HiSilicon CMD_PREFETCH quirk(erratum 161010701)

 Documentation/arm64/silicon-errata.txt             |   3 +
 .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  12 +
 arch/x86/kernel/tboot.c                            |   2 +-
 drivers/acpi/arm64/iort.c                          |  83 +++-
 drivers/iommu/Kconfig                              |   6 +-
 drivers/iommu/amd_iommu.c                          | 464 +++++++++++++--------
 drivers/iommu/amd_iommu_init.c                     |  44 +-
 drivers/iommu/amd_iommu_types.h                    |   3 +
 drivers/iommu/arm-smmu-v3.c                        | 229 ++++++----
 drivers/iommu/arm-smmu.c                           |  64 +--
 drivers/iommu/dma-iommu.c                          |   2 +-
 drivers/iommu/intel-iommu.c                        |  26 +-
 drivers/iommu/intel-svm.c                          |  30 ++
 drivers/iommu/intel_irq_remapping.c                |   4 +-
 drivers/iommu/io-pgtable-arm-v7s.c                 | 183 +++++---
 drivers/iommu/io-pgtable-arm.c                     | 189 ++++++---
 drivers/iommu/io-pgtable.h                         |   6 +
 drivers/iommu/iommu.c                              |  17 +-
 drivers/iommu/iova.c                               |  30 +-
 drivers/iommu/ipmmu-vmsa.c                         | 353 +++++++++++++---
 drivers/iommu/omap-iommu.c                         |   2 +-
 drivers/iommu/s390-iommu.c                         |  15 +-
 include/linux/intel-svm.h                          |  20 +
 23 files changed, 1235 insertions(+), 552 deletions(-)

Please pull.

Thanks,

	Joerg

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJZZgsJAAoJECvwRC2XARrjAiwQAKRt8H7xKuk1RBfVjY7syFB3
5zlz1u5htb/8aVmMY+mqVAyzmGjkCAHKAGtv9iWrP1b3FoBm7gdzMGAWxpWKU1cM
aA+l944deIYT0i40n6Br3cVc7pcuPM4PyzxO+EJx7HWJeuNBZL37DH4cThER4Qcp
FhDGyfLnf2JeMwC07UhBa3F4pJt3bNFPzPuScK4XUCgnpCfIoDe/glVcZZDy1LRv
SLuCDxeicQH7HpHEdZCs2m7tb+KjCVve0JniUwrVhuJkOLi6sKvrTUKNBbyqPHqg
dMTrvCSLP5sesbkM0al3n9N17F0zdiOskQ2Ah/c9Fs5fdQE5fk5a4oLaU9VJ4rjd
aDlRUE9/c77Si4bXcpSAfv7CkJLTXQ+6/ZcS5F+5ncbCWcrppvGAr9OwnSrvlWeS
S7Bn0LFylwQo/0BkAuOvISIV3IiBxNfpN5rH2di8lRgK0nkffB70doRx/FeIIkVA
OFi6NUGgVfHJn7wvuTZG7V/85as8qoKiZ4aeswe6yplcC7jVMYjqIPsoZQV5uO9s
pyb2duPZJgHgNrFdEp0oGNg9MtKn9pXvk7A2e0IA2/ttfEkJXDqucZbyLFAh+bbD
QbJc+bOHP+q50xqVHaNknU/Dz0TRM3wbqyXeYjHnW8RH9U32ndEIAuuZ/nEBmELr
dODOCtcoCmnvmq2/06k9
=wQqO
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--

--===============0821034292100631407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0821034292100631407==--
