From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Updates for Linux v3.14
Date: Wed, 29 Jan 2014 23:09:19 +0100
Message-ID: <20140129220724.GA2941@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7852533823626318866=="
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


--===============7852533823626318866==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,


The following changes since commit d6e0a2dd12f4067a5bcefb8bbd8ddbeff800afbc:

  Linux 3.13-rc7 (2014-01-04 15:12:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v3.14

for you to fetch changes up to dd1a175695edf662615e422d1c85eae875a411b2:

  Merge branches 'arm/smmu', 'core', 'x86/vt-d', 'arm/shmobile', 'x86/amd', 'ppc/pamu', 'iommu/fixes' and 'arm/msm' into next (2014-01-09 13:06:59 +0100)

----------------------------------------------------------------

IOMMU Updates for Linux v3.14

A few patches have been queued up for this merge window:

	* Improvements for the ARM-SMMU driver
	  (IOMMU_EXEC support, IOMMU group support)
	* Updates and fixes for the shmobile IOMMU driver
	* Various fixes to generic IOMMU code and the
	  Intel IOMMU driver
	* Some cleanups in IOMMU drivers (dev_is_pci() usage)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      iommu: Add empty stub for iommu_group_get_by_id()

Antonios Motakis (1):
      iommu/arm-smmu: add devices attached to the SMMU to an IOMMU group

Brian Norris (1):
      iommu: add missing include

Dan Carpenter (1):
      iommu/vt-d: Fix signedness bug in alloc_irte()

Jiang Liu (18):
      iommu/vt-d: use dedicated bitmap to track remapping entry allocation status
      iommu/vt-d: fix PCI device reference leakage on error recovery path
      iommu/vt-d: fix a race window in allocating domain ID for virtual machines
      iommu/vt-d: fix resource leakage on error recovery path in iommu_init_domains()
      iommu/vt-d, trivial: refine support of 64bit guest address
      iommu/vt-d, trivial: print correct domain id of static identity domain
      iommu/vt-d, trivial: check suitable flag in function detect_intel_iommu()
      iommu/vt-d, trivial: clean up unused code
      iommu/vt-d: mark internal functions as static
      iommu/vt-d, trivial: use defined macro instead of hardcoding
      iommu/vt-d, trivial: simplify code with existing macros
      iommu/vt-d: fix invalid memory access when freeing DMAR irq
      iommu/vt-d: keep shared resources when failed to initialize iommu devices
      iommu/vt-d: fix access after free issue in function free_dmar_iommu()
      iommu/vt-d: release invalidation queue when destroying IOMMU unit
      iommu/vt-d: fix wrong return value of dmar_table_init()
      iommu/vt-d, trivial: clean sparse warnings
      iommu/vt-d: free all resources if failed to initialize DMARs

Joerg Roedel (3):
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into arm/smmu
      drm/msm: Fix link error with !MSM_IOMMU
      Merge branches 'arm/smmu', 'core', 'x86/vt-d', 'arm/shmobile', 'x86/amd', 'ppc/pamu', 'iommu/fixes' and 'arm/msm' into next

Laurent Pinchart (3):
      iommu: shmobile: Enable driver compilation with COMPILE_TEST
      iommu/shmobile: Allocate archdata with kzalloc()
      iommu/shmobile: Turn the flush_lock mutex into a spinlock

Rashika Kheria (3):
      iommu/vt-d: Mark functions as static in dmar.c
      iommu/vt-d: Mark functions as static in intel_irq_remapping.c
      iommu/vt-d: Mark function eoi_ioapic_pin_remapped() as static in irq_remapping.c

Upinder Malhi (umalhi) (1):
      iommu: Rename domain_has_cap to iommu_domain_has_cap

Will Deacon (3):
      iommu/arm-smmu: use VA_BITS to determine arm64 virtual address space
      iommu: add IOMMU_EXEC flag for safely allowing XN mappings
      iommu/arm-smmu: add support for IOMMU_EXEC

Yijing Wang (3):
      iommu/amd: Use dev_is_pci() to check whether it is pci device
      iommu/vt-d: Use dev_is_pci() to check whether it is pci device
      iommu/fsl_pamu: Use dev_is_pci() to check whether it is pci device

 drivers/gpu/drm/msm/Kconfig         |    1 +
 drivers/iommu/Kconfig               |    1 +
 drivers/iommu/amd_iommu.c           |    4 +-
 drivers/iommu/arm-smmu.c            |   33 ++++--
 drivers/iommu/dmar.c                |  135 +++++++++++++---------
 drivers/iommu/fsl_pamu_domain.c     |    6 +-
 drivers/iommu/intel-iommu.c         |  216 ++++++++++++++---------------------
 drivers/iommu/intel_irq_remapping.c |  105 ++++++++---------
 drivers/iommu/irq_remapping.c       |    6 +-
 drivers/iommu/of_iommu.c            |    1 +
 drivers/iommu/shmobile-iommu.c      |    3 +-
 drivers/iommu/shmobile-ipmmu.c      |   10 +-
 drivers/iommu/shmobile-ipmmu.h      |    2 +-
 include/linux/dma_remapping.h       |    4 -
 include/linux/dmar.h                |   13 ++-
 include/linux/intel-iommu.h         |    3 +-
 include/linux/iommu.h               |   16 ++-
 17 files changed, 279 insertions(+), 280 deletions(-)

Please pull.

Thanks,

	Joerg


--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJS6XucAAoJECvwRC2XARrjyMkQAM5QM4URBsruzwhF2vm/gnTd
ZNTY8TTnjnjxBWuhL80nXOk2uQhOkE7GDDxN6ApUGfVdQAekVqH7FAt0SjoIw0bp
ROMSgrPTT5Kbe7SztG7207l9P+niqJt5p1LbJ2Bhtg0Z43Yehk4bTdalqfhiU8cQ
mOOxbUVSpD5iLfsYM30+Rr3FNtuqfEPpbFHKd5a4b0PkwzvNw0qM1Ly/syeX7fut
0SgWXY15ongGWHagrg7JoIM7RLllyRprECfvenfASYuB9kiJFa92fK2kRR0C4zMV
0/bUHt1KUL+gN9N8ZD8eeVAywR3vGvze6xl0LCwgtt4jiWJtNXU2IYlV1Lr6O2ti
xPjVMtw/Tn8WaOjEwDCO8nXbTz15lbQvvxxF+JXzgq+7/qz97LPI6UArMA64Nfxj
T+wLSlvI9jqDcqRG03BUo9JwABQr6r4sZo3fMSvCb9MuFqueXLE+Qz6NpQfpGCFJ
fsenF9lkItyp+AMstj1A0RtBX0cglgcLDiTDTQrT7NkbVVcJUaYS/V79t6i7aEk1
RWVcpYIx0G9Ped+zdCb2NTMc6oxYo4KbBWnaxlyvCmPjkTl2LpTKFqIogdsft82l
3+RmEP/AKx14ZdhE64omJPw6U4GHWlJFZ4hmSPaYWeMqh1ujgjG9SLqRt069MN8B
NBndwYQZNCLjT4291v4r
=MRTW
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--



--===============7852533823626318866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7852533823626318866==--
