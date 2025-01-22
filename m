Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596D71F76C7
	for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737536312; cv=none; b=Y0ur2cKILGo3Z750Pn2T68hul8pgJZCycpPhOLSR+nVDUYh4qt1bZCjsJlp7/rhzrQHOVNqtucktf//ZH8MTEjp8rc2a6Hnj7wOcfpRGOQCCTF/jLxeMV6EDd63nDll7P1hZ+pMaCwY71WIbIexDOLwqqlJ9s0cmni5Nlg2eVew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737536312; c=relaxed/simple;
	bh=eN8F6CRuOkdi+RxD3EmbgEjW3AueKj0j7dN2xoKugUw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aBa+5XWBflvM1BJZ/zD0TkUCMriOZHsz1XQbAKhLsHMmTJ9SJqYXAKchk5UAhC2102RXy7A3SnI9jHiC9GbJ+XQsU5/CODbCh/Br1z2KP5253SsDcQ3mhrPxQiVdVuRAaAzmM1zIMLDc5TnwOmeDaAiMkFKWrQU4Ov3ToqTTbvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=RHE7BmuS; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="RHE7BmuS"
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 99AB92E0334;
	Wed, 22 Jan 2025 09:58:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1737536301;
	bh=eN8F6CRuOkdi+RxD3EmbgEjW3AueKj0j7dN2xoKugUw=;
	h=Date:From:To:Cc:Subject:From;
	b=RHE7BmuSKu0n4aB6FkvN4BNJr48KL3N9ujCm23YqRzRZC/Yl32SuiIHkRfA0BD7Lz
	 EGCAFo3PaxjnauCixOsXK3jkHbp64tjl8rERHrUEwhF8lZNE4mloTzT0DH/wQgG3x/
	 DPRTy9+ZveIvqyadOJsLOpqBTTVWoc0S4V0wxbdia3iR3Q5kNZhh+EfoEU656AWwdN
	 lILiQpfSIgfhJZOKJ05bgxZWJ66HlpbkiUB34MqKAf7XXjnDA+0XoWx233JMGjpLuO
	 wDf+bl66SviKq7bI7g2JcnTrGzMjvI2710+2OQ15Oa1GbmfMLDZGq1K/KmgbGd20ba
	 2mIOiBgygXXLQ==
Date: Wed, 22 Jan 2025 09:58:20 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.14
Message-ID: <Z5CzLFtBJZrnAMdk@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K+LRosw8fYGAK1ti"
Content-Disposition: inline


--K+LRosw8fYGAK1ti
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 5bc55a333a2f7316b58edc7573e8e893f7acb532:

  Linux 6.13-rc7 (2025-01-12 14:37:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-=
updates-v6.14

for you to fetch changes up to 125f34e4c107b151029ccbeea92631481bf5a6a1:

  Merge branches 'arm/smmu/updates', 'arm/smmu/bindings', 'qualcomm/msm', '=
rockchip', 'riscv', 'core', 'intel/vt-d' and 'amd/amd-vi' into next (2025-0=
1-17 09:02:35 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v6.14

Including:

	- Core changes:
	  - PASID support for the blocked_domain.

	- ARM-SMMU Updates:
	  - SMMUv2:
	    * Implement per-client prefetcher configuration on Qualcomm SoCs.
	    * Support for the Adreno SMMU on Qualcomm's SDM670 SOC.
	  - SMMUv3:
	    * Pretty-printing of event records.
	    * Drop the ->domain_alloc_paging implementation in favour of
	      ->domain_alloc_paging_flags(flags=3D=3D0).
	  - IO-PGTable:
	    * Generalisation of the page-table walker to enable external walkers
	      (e.g. for debugging unexpected page-faults from the GPU).
	    * Minor fix for handling concatenated PGDs at stage-2 with 16KiB pages.
	  - Misc:
	    * Clean-up device probing and replace the crufty probe-deferral hack
	      with a more robust implementation of arm_smmu_get_by_fwnode().
	    * Device-tree binding updates for a bunch of Qualcomm platforms.

	- Intel VT-d Updates:
	  - Remove domain_alloc_paging().
	  - Remove capability audit code.
	  - Draining PRQ in sva unbind path when FPD bit set.
	  - Link cache tags of same iommu unit together.

	- AMD-Vi Updates:
	  - Use CMPXCHG128 to update DTE.
	  - Cleanups of the domain_alloc_paging() path.

	- RiscV IOMMU:
	  - Platform MSI support.
	  - Shutdown support.

	- Rockchip IOMMU:
	  - Add DT bindings for Rockchip RK3576.

	- More smaller fixes and cleanups.

----------------------------------------------------------------
Alejandro Jimenez (1):
      iommu/amd: Remove unused amd_iommu_domain_update()

Andrew Jones (1):
      iommu/riscv: Add support for platform msi

Andy Yan (1):
      dt-bindings: iommu: rockchip: Add Rockchip RK3576

Barnab=E1s Cz=E9m=E1n (1):
      dt-bindings: iommu: qcom,iommu: Add MSM8917 IOMMU to SMMUv1 compatibl=
es

Bibek Kumar Patro (5):
      iommu/arm-smmu: Re-enable context caching in smmu reset operation
      iommu/arm-smmu: Refactor qcom_smmu structure to include single pointer
      iommu/arm-smmu: Add support for PRR bit setup
      iommu/arm-smmu: Introduce ACTLR custom prefetcher settings
      iommu/arm-smmu: Add ACTLR data and support for qcom_smmu_500

Gao Shiyuan (1):
      iommu/amd: remove return value of amd_iommu_detect

Guo Ren (1):
      iommu/riscv: Fixup compile warning

Jason Gunthorpe (12):
      iommu/arm-smmuv3: Update comments about ATS and bypass
      iommu/arm-smmu-v3: Remove arm_smmu_domain_finalise() during attach
      iommu/arm-smmu-v3: Make domain_alloc_paging_flags() directly determin=
e the S1/S2
      iommu/arm-smmu-v3: Remove domain_alloc_paging()
      iommu/arm-smmu-v3: Make the blocked domain support PASID
      iommu/vt-d: Remove domain_alloc_paging()
      iommu/amd: Remove domain_alloc()
      iommu/amd: Remove dev =3D=3D NULL checks
      iommu/amd: Remove type argument from do_iommu_domain_alloc() and rela=
ted
      iommu/amd: Change amd_iommu_pgtable to use enum protection_domain_mode
      iommu/amd: Move the nid to pdom_setup_pgtable()
      iommu/amd: Fully decode all combinations of alloc_paging_flags

Joerg Roedel (1):
      Merge branches 'arm/smmu/updates', 'arm/smmu/bindings', 'qualcomm/msm=
', 'rockchip', 'riscv', 'core', 'intel/vt-d' and 'amd/amd-vi' into next

Kees Bakker (1):
      iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE

Krzysztof Kozlowski (1):
      iommu: Use str_enable_disable-like helpers

Lu Baolu (2):
      iommu/vt-d: Remove iommu cap audit
      iommu/vt-d: Draining PRQ in sva unbind path when FPD bit set

Melody Olvera (1):
      dt-bindings: arm-smmu: Document SM8750 SMMU

Mostafa Saleh (3):
      iommu/io-pgtable-arm: Fix stage-2 concatenation with 16K
      iommu/io-pgtable-arm: Add coverage for different OAS in selftest
      iommu/io-pgtable-arm: Fix cfg reading in arm_lpae_concat_mandatory()

Nicolin Chen (1):
      iommu/tegra241-cmdqv: Read SMMU IDR1.CMDQS instead of hardcoding

Pranjal Shrivastava (3):
      iommu/arm-smmu-v3: Introduce struct arm_smmu_event
      iommu/arm-smmu-v3: Log better event records
      iommu/arm-smmu-v3: Use str_read_write helper w/ logs

Qingqing Zhou (1):
      dt-bindings: arm-smmu: document QCS615 GPU SMMU

Richard Acayan (2):
      dt-bindings: iommu: arm,smmu: add sdm670 adreno iommu compatible
      iommu/arm-smmu-qcom: add sdm670 adreno iommu compatible

Rob Clark (3):
      iommu/io-pgtable-arm: Make pgtable walker more generic
      iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
      iommu/io-pgtable-arm: Add way to debug pgtable walk

Robin Murphy (5):
      iommu/arm-smmu: Make instance lookup robust
      iommu/arm-smmu: Retire probe deferral workaround
      iommu/arm-smmu-v3: Clean up more on probe failure
      iommu: Manage driver probe deferral better
      iommu/arm-smmu-v3: Document SVA interaction with new pagetable featur=
es

Suravee Suthikulpanit (9):
      iommu/amd: Misc ACPI IVRS debug info clean up
      iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported
      iommu/amd: Introduce struct ivhd_dte_flags to store persistent DTE fl=
ags
      iommu/amd: Introduce helper function to update 256-bit DTE
      iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
      iommu/amd: Introduce helper function get_dte256()
      iommu/amd: Modify clear_dte_entry() to avoid in-place update
      iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()
      iommu/amd: Remove amd_iommu_apply_erratum_63()

Will Deacon (1):
      iommu/arm-smmu-v3: Add missing #include of linux/string_choices.h

Xu Lu (2):
      iommu/riscv: Empty iommu queue before enabling it
      iommu/riscv: Add shutdown function for iommu driver

Yi Liu (6):
      iommu: Prevent pasid attach if no ops->remove_dev_pasid
      iommu: Consolidate the ops->remove_dev_pasid usage into a helper
      iommu: Detaching pasid by attaching to the blocked_domain
      iommu/vt-d: Make the blocked domain support PASID
      iommu/amd: Make the blocked domain support PASID
      iommu: Remove the remove_dev_pasid op

Zhang Heng (1):
      iommu/msm: Use helper function devm_clk_get_prepared()

Zhenzhong Duan (1):
      iommu/vt-d: Link cache tags of same iommu unit together

 Documentation/arch/arm64/silicon-errata.rst        |   3 +-
 .../devicetree/bindings/iommu/arm,smmu.yaml        |  23 +-
 .../devicetree/bindings/iommu/qcom,iommu.yaml      |   1 +
 .../devicetree/bindings/iommu/rockchip,iommu.yaml  |   1 +
 drivers/iommu/Kconfig                              |  12 +
 drivers/iommu/amd/amd_iommu.h                      |   9 +-
 drivers/iommu/amd/amd_iommu_types.h                |  41 +-
 drivers/iommu/amd/init.c                           | 253 +++++-----
 drivers/iommu/amd/iommu.c                          | 532 +++++++++++++----=
----
 drivers/iommu/amd/pasid.c                          |   3 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  15 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 298 ++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  31 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |   8 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c         |   5 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c   |   2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         | 121 ++++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h         |   3 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  43 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |   2 +
 drivers/iommu/intel/Makefile                       |   2 +-
 drivers/iommu/intel/cache.c                        |  11 +-
 drivers/iommu/intel/cap_audit.c                    | 217 ---------
 drivers/iommu/intel/cap_audit.h                    | 131 -----
 drivers/iommu/intel/iommu.c                        |  47 +-
 drivers/iommu/intel/irq_remapping.c                |   8 -
 drivers/iommu/intel/pasid.c                        |  22 +-
 drivers/iommu/intel/pasid.h                        |   6 +
 drivers/iommu/io-pgtable-arm.c                     | 227 +++++----
 drivers/iommu/iommu.c                              |  37 +-
 drivers/iommu/msm_iommu.c                          |  51 +-
 drivers/iommu/mtk_iommu.c                          |   9 +-
 drivers/iommu/mtk_iommu_v1.c                       |   3 +-
 drivers/iommu/of_iommu.c                           |   2 -
 drivers/iommu/riscv/iommu-pci.c                    |   8 +
 drivers/iommu/riscv/iommu-platform.c               | 108 ++++-
 drivers/iommu/riscv/iommu.c                        |  14 +-
 drivers/iommu/riscv/iommu.h                        |   1 +
 drivers/iommu/rockchip-iommu.c                     |   3 +-
 include/linux/adreno-smmu-priv.h                   |   7 +
 include/linux/amd-iommu.h                          |   4 +-
 include/linux/io-pgtable.h                         |  11 +
 include/linux/iommu.h                              |   5 -
 43 files changed, 1304 insertions(+), 1036 deletions(-)
 delete mode 100644 drivers/iommu/intel/cap_audit.c
 delete mode 100644 drivers/iommu/intel/cap_audit.h

Please pull.

Thanks,

	Joerg

--K+LRosw8fYGAK1ti
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmeQsywACgkQK/BELZcB
GuOYkRAAiVXGSvr3K2ajSz/aaojYgJQ/gd4ojE8XqKb7UCBT4OEYka6PQrfH30G1
Q/PJc7NMM9XGjbTA+4n0DD3Q9bt+gbXU5c4ypXK0iA46ukDOZb8ex8dd0g2QdyPt
46PwjoX1uxmpz8ikdoPUoKDlpzwVzsOYnEex12pyHF/3QmEM9KKK2xRph4tmXKWR
9w8a/F0owLjTWsqB6xhrKxiweoXtU7/bKvoOyH8749XLTqgi6x12cfbIVY3Gq/j6
QnNB66Cgyrj5AOo4fhFY9TdJoHpJ24SV0hXOyO6fnEYNy/KpvD0ffRMj0DS3ikGD
arMHToIA6JBnDpQqo5bIK9fvG+6ioF3kpW7Yxwgoi6B7l1Al34fgTVu8xuJajW8U
eviaf19PWs34fnr+iFw6tGunLsIgqUDqpb4Yka2uvwsRiowEI341XX2BUKayz8PP
nARezvP1uiThlfqJjYGdDLRZdfubkkpacKQaCGitCy49SylrXeRb8pKn18l9HOZA
k79paPcsN9RIR4jA9srXmrw9UtqmmIQX8hgtE3bpgIozCTbUaJ2R+/UlWBK9seDR
Onn2+5Yp3NlCDW9P6PlAwkDrIB7bA5kLcJrLNxdzUq/NiPh3jVMw+NMX6pe/H3on
q/plTt5KAeNrPcEzzx+lIOpT2El5aRwoNKiM5+5dcAbR2NoQwBs=
=egzu
-----END PGP SIGNATURE-----

--K+LRosw8fYGAK1ti--
