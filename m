From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Updates for Linux v4.5
Date: Tue, 19 Jan 2016 17:00:11 +0100
Message-ID: <20160119160010.GA11000@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1494066612793660398=="
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


--===============1494066612793660398==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc:

  Linux 4.4 (2016-01-10 15:01:32 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v4.5

for you to fetch changes up to 32704253dc008dfedead71da016b00d10cd1854f:

  Merge branches 's390', 'arm/renesas', 'arm/msm', 'arm/shmobile', 'arm/smmu', 'x86/amd' and 'x86/vt-d' into next (2016-01-19 15:30:43 +0100)

----------------------------------------------------------------

IOMMU Updates for Linux v4.5

The updates include:

	* Small code cleanups in the AMD IOMMUv2 driver

	* Scalability improvements for the DMA-API implementation of the
	  AMD IOMMU driver. This is just a starting point, but already
	  showed some good improvements in my tests.

	* Removal of the unused Renesas IPMMU/IPMMUI driver

	* Updates for ARM-SMMU include:

		* Some fixes to get the driver working nicely on
		  Broadcom hardware

		* A change to the io-pgtable API to indicate the unit in
		  which to flush (all callers converted, with Ack from
		  Laurent)

		* Use of devm_* for allocating/freeing the SMMUv3
		  buffers

	* Some other small fixes and improvements for other drivers

----------------------------------------------------------------
Dan Carpenter (1):
      iommu/amd: Remove an unneeded condition

Geert Uytterhoeven (1):
      iommu/shmobile: Remove unused Renesas IPMMU/IPMMUI driver

Joerg Roedel (28):
      iommu/amd: Correctly set flags for handle_mm_fault call
      iommu/amd: Cleanup error handling in do_fault()
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      iommu/amd: Warn only once on unexpected pte value
      iommu/amd: Move 'struct dma_ops_domain' definition to amd_iommu.c
      iommu/amd: Introduce bitmap_lock in struct aperture_range
      iommu/amd: Flush IOMMU TLB on __map_single error path
      iommu/amd: Flush the IOMMU TLB before the addresses are freed
      iommu/amd: Pass correct shift to iommu_area_alloc()
      iommu/amd: Add dma_ops_aperture_alloc() function
      iommu/amd: Move aperture_range.offset to another cache-line
      iommu/amd: Retry address allocation within one aperture
      iommu/amd: Flush iommu tlb in dma_ops_aperture_alloc()
      iommu/amd: Remove 'start' parameter from dma_ops_area_alloc
      iommu/amd: Rename dma_ops_domain->next_address to next_index
      iommu/amd: Flush iommu tlb in dma_ops_free_addresses
      iommu/amd: Iterate over all aperture ranges in dma_ops_area_alloc
      iommu/amd: Remove need_flush from struct dma_ops_domain
      iommu/amd: Optimize dma_ops_free_addresses
      iommu/amd: Allocate new aperture ranges in dma_ops_alloc_addresses
      iommu/amd: Build io page-tables with cmpxchg64
      iommu/amd: Initialize new aperture range before making it visible
      iommu/amd: Relax locking in dma_ops path
      iommu/amd: Make dma_ops_domain->next_index percpu
      iommu/amd: Use trylock to aquire bitmap_lock
      iommu/amd: Preallocate dma_ops apertures based on dma_mask
      iommu/vt-d: Fix up error handling in alloc_iommu
      Merge branches 's390', 'arm/renesas', 'arm/msm', 'arm/shmobile', 'arm/smmu', 'x86/amd' and 'x86/vt-d' into next

Julia Lawall (1):
      iommu/amd: Constify mmu_notifier_ops structures

Magnus Damm (1):
      iommu/ipmmu-vmsa: Include SoC part number in DT binding docs

Markus Elfring (1):
      iommu/arm-smmu: Delete an unnecessary check before free_io_pgtable_ops()

Nicholas Krause (1):
      iommu/vt-d: Check the return value of iommu_device_create()

Peng Fan (1):
      iommu/arm-smmu: Correct group reference count

Prem Mallappa (2):
      iommu/arm-smmu: Fix write to GERRORN register
      iommu/arm-smmu: Use STE.S1STALLD only when supported

Robin Murphy (4):
      iommu/io-pgtable-arm: Avoid dereferencing bogus PTEs
      iommu/io-pgtable: Indicate granule for TLB maintenance
      iommu/arm-smmu: Invalidate TLBs properly
      iommu/io-pgtable: Make io_pgtable_ops_to_pgtable() macro common

Sebastian Ott (1):
      iommu/s390: Fix sparse warnings

Thierry Reding (1):
      iommu/msm: Use platform_register/unregister_drivers()

Will Deacon (5):
      iommu/arm-smmu: Remove #define for non-existent PRIQ_0_OF field
      iommu/arm-smmu: Convert DMA buffer allocations to the managed API
      iommu/arm-smmu: Use incoming shareability attributes in bypass mode
      iommu/arm-smmu: Handle unknown CERROR values gracefully
      iommu/io-pgtable-arm: Ensure we free the final level on teardown

 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |  12 +-
 drivers/iommu/Kconfig                              |  75 ----
 drivers/iommu/Makefile                             |   2 -
 drivers/iommu/amd_iommu.c                          | 396 ++++++++++++--------
 drivers/iommu/amd_iommu_types.h                    |  40 --
 drivers/iommu/amd_iommu_v2.c                       |  38 +-
 drivers/iommu/arm-smmu-v3.c                        | 210 ++++-------
 drivers/iommu/arm-smmu.c                           |  23 +-
 drivers/iommu/dmar.c                               |  12 +-
 drivers/iommu/io-pgtable-arm.c                     |  49 +--
 drivers/iommu/io-pgtable.h                         |   6 +-
 drivers/iommu/ipmmu-vmsa.c                         |   4 +-
 drivers/iommu/msm_iommu_dev.c                      |  25 +-
 drivers/iommu/s390-iommu.c                         |   4 +-
 drivers/iommu/shmobile-iommu.c                     | 402 ---------------------
 drivers/iommu/shmobile-ipmmu.c                     | 129 -------
 drivers/iommu/shmobile-ipmmu.h                     |  34 --
 17 files changed, 411 insertions(+), 1050 deletions(-)
 delete mode 100644 drivers/iommu/shmobile-iommu.c
 delete mode 100644 drivers/iommu/shmobile-ipmmu.c
 delete mode 100644 drivers/iommu/shmobile-ipmmu.h

Please pull.

Thanks,

	Joerg


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJWnl2KAAoJECvwRC2XARrjVTUP/1aBoIdd/7ei24TRKomCwphZ
+YR+97qavevjy4Bbja0TBRriuCOYusHCnxWKJ46rsNNmhlpNUznDWDhfKFiURBrK
uVubtmAwakOdCddurciEsP5jy/4zwyE0GrxmP3Em8Uf4ZXGC8c3ZDRTOB4jdC3zy
feeydJa3SJawZhfsVcddkmOFZcfmuScFJJuPA3JF+1fEzp/ZTpTt1XHb7EnTuO4F
osa+XF7iWjZ78vFat5RZYMf0IsmbX5EW08G30GBxzRUEm/0OOow+JIEHI2wHsGec
vgaEJ4JuUD+6IkM0zDIb8b8uFg0q10sdU1x88TTAJTf3D8Xo1kTYMyAEmldAF+pD
RGpfB1UbVDSvJaGK/D8yPxbGQucPXNBrkaJUxKmbb9NdPoaqiAW9XBQm4HihaAA9
iERCr69MO5ARKL+8cOI42uloJDF8gvIDsbFMoHNwViDELurKSKzdpdMkVxl4+Lw8
zIDB0YJUvfXqob2+wfHbWiL/OMv6RJlb38GlaOSKOX6yeP3Dw7uk/CLZdmd+FNP6
2Ok79sO93z4FygiS9afgXxDgP4kYKGtTF4htj2E0PVy/ROPi5WWj1QCsbjDmvbb6
7CFQCUAM+o5k54igZFVbVve3vKJg/aXJYZSIWrRuCMHb85LPF6tiGWalyxEjYk9c
kp8/4IELJ11aNymkTASI
=FTbq
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

--===============1494066612793660398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1494066612793660398==--
