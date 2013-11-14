From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Updates for Linux v3.13
Date: Thu, 14 Nov 2013 23:58:26 +0100
Message-ID: <20131114225826.GA2953@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1987590235175335456=="
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


--===============1987590235175335456==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 959f58544b7f20c92d5eb43d1232c96c15c01bfb:

  Linux 3.12-rc7 (2013-10-27 16:12:03 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v3.13

for you to fetch changes up to bb51eeee5a947f61eeefaa55221c26460542654d:

  Merge branches 'iommu/fixes', 'tracing', 'core', 'arm/tegra', 'x86/vt-d', 'arm/smmu' and 'arm/shmobile' into next (2013-11-01 14:44:25 +0100)

----------------------------------------------------------------

IOMMU Updates for Linux v3.13

This time the updates contain:

* Tracepoints for certain IOMMU-API functions to make
  their use easier to debug
* A tracepoint for IOMMU page faults to make it easier
  to get them in user space
* Updates and fixes for the new ARM SMMU driver after
  the first hardware showed up
* Various other fixes and cleanups in other IOMMU drivers

----------------------------------------------------------------
Andreas Herrmann (5):
      iommu/arm-smmu: Switch to subsys_initcall for driver registration
      iommu/arm-smmu: Refine check for proper size of mapped region
      iommu/arm-smmu: Check for num_context_irqs > 0 to avoid divide by zero exception
      iommu/arm-smmu: Print context fault information
      iommu/arm-smmu: Clear global and context bank fault status registers

Fabio Estevam (1):
      iommu: No need to pass '0x' when '%pa' is used

Joerg Roedel (1):
      Merge branches 'iommu/fixes', 'tracing', 'core', 'arm/tegra', 'x86/vt-d', 'arm/smmu' and 'arm/shmobile' into next

Julia Lawall (1):
      iommu/arm-smmu: replace devm_request_and_ioremap by devm_ioremap_resource

Julian Stecklina (1):
      iommu/vt-d: Fixed interaction of VFIO_IOMMU_MAP_DMA with IOMMU address limits

Laurent Pinchart (1):
      iommu/shmobile: Enable the driver on all ARM platforms

Neil Horman (1):
      iommu: Remove stack trace from broken irq remapping warning

Sachin Kamat (2):
      iommu/tegra-gart: Staticize tegra_gart_pm_ops
      iommu/tegra-smmu: Staticize tegra_smmu_pm_ops

Shuah Khan (9):
      iommu: Add event tracing feature to iommu
      iommu: Change iommu driver to call add_device_to_group trace event
      iommu: Change iommu driver to call remove_device_to_group trace event
      iommu: Change iommu driver to call attach_device_to_domain trace event
      iommu: Change iommu driver to call detach_device_to_domain trace event
      iommu: Change iommu driver to call map trace event
      iommu: Change iommu driver to call unmap trace event
      iommu: Add iommu_error class event to iommu trace
      iommu: Change iommu driver to call io_page_fault trace event

Thierry Reding (1):
      iommu/tegra: Print phys_addr_t using %pa

Wei Yongjun (1):
      iommu/tegra: gart: cleanup devm_* functions usage

Will Deacon (1):
      iommu/arm-smmu: use relaxed accessors where possible

Yijing Wang (2):
      iommu/vt-d: Use for_each_drhd_unit() instead of list_for_each_entry()
      iommu/vt-d: Use list_for_each_entry_safe() for dmar_domain->devices traversal

 drivers/iommu/Kconfig               |    2 +-
 drivers/iommu/Makefile              |    1 +
 drivers/iommu/arm-smmu.c            |   69 ++++++++-------
 drivers/iommu/dmar.c                |    2 +-
 drivers/iommu/intel-iommu.c         |   12 +--
 drivers/iommu/intel_irq_remapping.c |   13 +--
 drivers/iommu/iommu-traces.c        |   27 ++++++
 drivers/iommu/iommu.c               |   21 ++++-
 drivers/iommu/tegra-gart.c          |   27 ++----
 drivers/iommu/tegra-smmu.c          |    4 +-
 include/linux/iommu.h               |    2 +
 include/trace/events/iommu.h        |  162 +++++++++++++++++++++++++++++++++++
 12 files changed, 270 insertions(+), 72 deletions(-)
 create mode 100644 drivers/iommu/iommu-traces.c
 create mode 100644 include/trace/events/iommu.h

Please pull.

Thanks,

	Joerg


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJShVWSAAoJECvwRC2XARrjAFMP/2y9AgZ0ZAlSo79lRtBAGO5R
jETePnIBUxQUbf7MEs2nd60QdWm+alPSv4lB7uM3O0YpxWwkmYCptSqfTtkVc54f
nCU92c0x9jOh6IJTgPN0VBLzApfNP75yJIOr4qP4WBEtJwhKma4CtdKP/lJ4wiQC
VhvSWhgJpZMJbSQHcH9EgXlpdcNb9bTDbUyvlJq+ZeVh7SJSjwwlAtz15J/79ggx
ogC1VYq/R4bttOzQS7WuUFRDHfLW6fh9tTV/O/9QKrG32sOFp4j3rlScg49I05SS
92JVkPnoXseYHqGE/rc+OQCp7pQilKgIKwQGknQ/YwS281Z1gWzZ7nwVWrhR2f17
h5Gh32IjIVDeVKMH4LjMjxVm7ACu/tsf1yHXnnLf7UbpWQn0wPY2gYDDac7G2LKP
hGd6y/JP35TGASp06MaMNF5yB0jYnyMF6hEALF58U1S+rb1tfd8L8ZdfhvktEK89
+yQtNqXWwT6xVruUdTVxw3CDMFdb3l4jty6IsV5qagyRNmKowWuDUVHz9Xae9MV1
N+9zopJEkX9C4U2T2pHX3qILFz45uDHDhBL+LA1sNaD9t3xGyWiBRVbH2dlSfuHG
OskCFaox3SBDFI2I4ZmHi3sS2X9LR7GFL0bNr6eFOrZc7h+XzqSed+d1KQXzXW87
0nRAnlcY88kfWTJ4MGR5
=L9uL
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--



--===============1987590235175335456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1987590235175335456==--
