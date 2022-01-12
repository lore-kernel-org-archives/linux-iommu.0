Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE847C433EF
	for <iommu@archiver.kernel.org>; Wed, 12 Jan 2022 17:02:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6497683F89;
	Wed, 12 Jan 2022 17:02:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2KDlabaodyr2; Wed, 12 Jan 2022 17:02:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0FC5D83F65;
	Wed, 12 Jan 2022 17:02:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF679C0030;
	Wed, 12 Jan 2022 17:02:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51D8FC001E
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 17:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3207E83F89
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 17:02:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id maUBJj9PEtck for <iommu@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 17:02:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EF7B83F65
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 17:02:27 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 67A4525F; Wed, 12 Jan 2022 18:02:24 +0100 (CET)
Date: Wed, 12 Jan 2022 18:02:23 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Updates for Linux v5.17
Message-ID: <Yd8Jn2aUqblPfRvF@8bytes.org>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4999863351612262148=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4999863351612262148==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d8vwtHnKPut+5Js9"
Content-Disposition: inline


--d8vwtHnKPut+5Js9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit c9e6606c7fe92b50a02ce51dda82586ebdf99b48:

  Linux 5.16-rc8 (2022-01-02 14:23:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-update=
s-v5.17

for you to fetch changes up to 66dc1b791c5839d64d261c8b40250a33e6da050b:

  Merge branches 'arm/smmu', 'virtio', 'x86/amd', 'x86/vt-d' and 'core' int=
o next (2022-01-04 10:33:45 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v5.17

Including:

	- Identity domain support for virtio-iommu

	- Move flush queue code into iommu-dma

	- Some fixes for AMD IOMMU suspend/resume support when x2apic
	  is used

	- Arm SMMU Updates from Will Deacon:
	  - Revert evtq and priq back to their former sizes
	  - Return early on short-descriptor page-table allocation failure
	  - Fix page fault reporting for Adreno GPU on SMMUv2
	  - Make SMMUv3 MMU notifier ops 'const'
	  - Numerous new compatible strings for Qualcomm SMMUv2 implementations

	- Various smaller fixes and cleanups

----------------------------------------------------------------
Christophe JAILLET (1):
      iommu/vt-d: Use bitmap_zalloc() when applicable

Dafna Hirschfeld (1):
      iommu: Log iova range in map/unmap trace events

David Heidelberg (1):
      dt-bindings: arm-smmu: Add compatible for the SDX55 SoC

Hector Martin (1):
      iommu/io-pgtable-arm: Fix table descriptor paddr formatting

Jean-Philippe Brucker (5):
      iommu/virtio: Add definitions for VIRTIO_IOMMU_F_BYPASS_CONFIG
      iommu/virtio: Support bypass domains
      iommu/virtio: Sort reserved regions
      iommu/virtio: Pass end address to viommu_add_mapping()
      iommu/virtio: Support identity-mapped domains

Joerg Roedel (3):
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/will/linux into arm/smmu
      iommu/iova: Temporarily include dma-mapping.h from iova.h
      Merge branches 'arm/smmu', 'virtio', 'x86/amd', 'x86/vt-d' and 'core'=
 into next

John Garry via iommu (1):
      iommu/iova: Move fast alloc size roundup into alloc_iova_fast()

Kees Cook (1):
      iommu/vt-d: Use correctly sized arguments for bit field

Kefeng Wang (1):
      iommu/vt-d: Drop duplicate check in dma_pte_free_pagetable()

Lu Baolu (2):
      iommu: Extend mutex lock scope in iommu_probe_device()
      iommu/vt-d: Remove unused macros

Matthew Wilcox (Oracle) (2):
      iommu/amd: Use put_pages_list
      iommu/vt-d: Use put_pages_list

Maxim Levitsky (5):
      iommu/amd: Restore GA log/tail pointer on host resume
      iommu/amd: X2apic mode: re-enable after resume
      iommu/amd: X2apic mode: setup the INTX registers on mask/unmask
      iommu/amd: X2apic mode: mask/unmask interrupts on suspend/resume
      iommu/amd: Remove useless irq affinity notifier

Ma=C3=ADra Canal (1):
      iommu/vt-d: Remove unused dma_to_mm_pfn function

Paul Menzel (1):
      iommu/amd: Fix typo in *glues =E2=80=A6 together* in comment

Rikard Falkeborn (1):
      iommu/arm-smmu-v3: Constify arm_smmu_mmu_notifier_ops

Rob Clark (1):
      iommu/arm-smmu-qcom: Fix TTBR0 read

Robin Murphy (6):
      iommu/iova: Squash entry_dtor abstraction
      iommu/iova: Squash flush_cb abstraction
      iommu/amd: Simplify pagetable freeing
      iommu/iova: Consolidate flush queue code
      iommu/iova: Move flush queue code to iommu-dma
      iommu: Move flush queue data into iommu_dma_cookie

Vinod Koul (2):
      dt-bindings: arm-smmu: Add compatible for SM8450 SoC
      iommu: arm-smmu-impl: Add SM8450 qcom iommu implementation

Xiang wangx (1):
      iommu/virtio: Fix typo in a comment

Xiongfeng Wang (1):
      iommu/iova: Fix race between FQ timeout and teardown

Yunfei Wang (1):
      iommu/io-pgtable-arm-v7s: Add error handle for page table allocation =
failure

Zhou Wang (1):
      Revert "iommu/arm-smmu-v3: Decrease the queue size of evtq and priq"

 .../devicetree/bindings/iommu/arm,smmu.yaml        |   2 +
 drivers/iommu/amd/amd_iommu_types.h                |   2 -
 drivers/iommu/amd/init.c                           | 109 ++++----
 drivers/iommu/amd/io_pgtable.c                     | 110 +++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   5 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   3 +-
 drivers/iommu/dma-iommu.c                          | 274 ++++++++++++++++-=
----
 drivers/iommu/intel/iommu.c                        | 111 +++------
 drivers/iommu/io-pgtable-arm-v7s.c                 |   6 +-
 drivers/iommu/io-pgtable-arm.c                     |   9 +-
 drivers/iommu/iommu.c                              |   3 +-
 drivers/iommu/iova.c                               | 209 +---------------
 drivers/iommu/virtio-iommu.c                       | 115 +++++++--
 drivers/vdpa/vdpa_user/iova_domain.c               |   8 -
 include/linux/intel-svm.h                          |   6 -
 include/linux/iommu.h                              |   3 +-
 include/linux/iova.h                               |  68 +----
 include/trace/events/iommu.h                       |  10 +-
 include/uapi/linux/virtio_iommu.h                  |   8 +-
 20 files changed, 493 insertions(+), 570 deletions(-)

Please pull.

Thanks,

	Joerg

--d8vwtHnKPut+5Js9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmHfCZcACgkQK/BELZcB
GuPYbA/8DJ3UDORB+m9PPRo59QhfMsTtrJVMNxPUYan3Nfoz+l6K8QZc8lMVG6xY
TN7I9ptXi0TdZHbGUA/1YKgZlkXqQj60K9YK/0TBkwB/MwN2utQigbjZSRQPT3Zd
2D6y+mnMSX+j+mCWtwpttJkgriUPtk7eDkK2ur3Ex2QocfBnH1ObuL0ufQrj5XN8
A68YMLfl3bhn6X9RAuxBh15RZXHYyk7AK1NIFOxY4tKFiSk18QRl1y3in8o39kV2
lkDs4ggjh+TgE65+1Rrx1Cl9FV3kbwrkAkBVCKtyQjuPsYRZpw38bg1JWOg4imSY
sp9AXkJdmmFPECdEcE82++CCDp00S89Hh3NgoAhuhLD75h4zV2puYUdv6FgFOBif
bSZq3/Q7psQ9cjsamkjv8fq7gfqQHGS6P3g5Wtm/MGV4Ksv/dE9MnUcdszqpVVdr
9Hq1Fd/OvRDaqnuDIPRRTvzD5EbrnVBAEsXHXQEkZWNvlmPRnyfAnCgC5F4/6pw5
U2w8acAk9sFZHgtEEJK/GqvMGsmZ+Z9P58EXWpZz9/ovwQNpg/LtZp9bLG7cA8vM
xHe+HpJoEBMjZhaqVrngLBUjntZGac9aq35JRCd7/VlBD3qlEvLiQaAV6uWfomJG
FweCzpso0Q18sxH+bqOx0b2tFXYTsCylbvygZJqLSbMiU2Jfrio=
=gWcn
-----END PGP SIGNATURE-----

--d8vwtHnKPut+5Js9--

--===============4999863351612262148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4999863351612262148==--
