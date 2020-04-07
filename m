Return-Path: <SRS0=p9ZB=5X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A38C2BA80
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 15:26:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB282074F
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 15:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB282074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3C3DC20035;
	Tue,  7 Apr 2020 15:26:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sgrXVyoik0mK; Tue,  7 Apr 2020 15:26:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A6A49204B3;
	Tue,  7 Apr 2020 15:26:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82492C1D7E;
	Tue,  7 Apr 2020 15:26:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 955D9C0177
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 15:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 769DE8771B
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 15:26:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6FyyS+9kix19 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Apr 2020 15:26:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9BFBA87595
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 15:26:46 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id ACAB15D8; Tue,  7 Apr 2020 17:26:41 +0200 (CEST)
Date: Tue, 7 Apr 2020 17:26:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Updates for Linux v5.7
Message-ID: <20200407152635.GA10588@8bytes.org>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============2887158022787646631=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2887158022787646631==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.7

for you to fetch changes up to ff68eb23308e6538ec7864c83d39540f423bbe90:

  Merge branches 'iommu/fixes', 'arm/qcom', 'arm/omap', 'arm/smmu', 'x86/amd', 'x86/vt-d', 'virtio' and 'core' into next (2020-03-27 11:33:27 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v5.7

Including:

	- ARM-SMMU support for the TLB range invalidation command in
	  SMMUv3.2.

	- ARM-SMMU introduction of command batching helpers to batch up
	  CD and ATC invalidation.

	- ARM-SMMU support for PCI PASID, along with necessary PCI
	  symbol exports.

	- Introduce a generic (actually rename an existing) IOMMU
	  related pointer in struct device and reduce the IOMMU related
	  pointers.

	- Some fixes for the OMAP IOMMU driver to make it build on 64bit
	  architectures.

	- Various smaller fixes and improvements.

----------------------------------------------------------------
Adrian Huang (1):
      iommu/amd: Fix the configuration of GCR3 table root pointer

Gustavo A. R. Silva (1):
      iommu/qcom: Replace zero-length array with flexible-array member

Jacob Pan (3):
      iommu/vt-d: Fix page request descriptor size
      iommu/vt-d: Fix mm reference leak
      iommu/vt-d: Add build dependency on IOASID

Jean-Philippe Brucker (9):
      iommu/virtio: Build virtio-iommu as module
      PCI/ATS: Export symbols of PASID functions
      iommu/arm-smmu-v3: Add support for PCI PASID
      iommu/arm-smmu-v3: Write level-1 descriptors atomically
      iommu/arm-smmu-v3: Add command queue batching helpers
      iommu/arm-smmu-v3: Batch context descriptor invalidation
      iommu/virtio: Fix sparse warning
      iommu/virtio: Fix freeing of incomplete domains
      iommu/virtio: Reject IOMMU page granule larger than PAGE_SIZE

Joerg Roedel (17):
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/.../will/linux into arm/smmu
      iommu: Define dev_iommu_fwspec_get() for !CONFIG_IOMMU_API
      ACPI/IORT: Remove direct access of dev->iommu_fwspec
      drm/msm/mdp5: Remove direct access of dev->iommu_fwspec
      iommu/tegra-gart: Remove direct access of dev->iommu_fwspec
      iommu: Rename struct iommu_param to dev_iommu
      iommu: Move iommu_fwspec to struct dev_iommu
      iommu/arm-smmu: Fix uninitilized variable warning
      iommu: Introduce accessors for iommu private data
      iommu/arm-smmu-v3: Use accessor functions for iommu private data
      iommu/arm-smmu: Use accessor functions for iommu private data
      iommu/renesas: Use accessor functions for iommu private data
      iommu/mediatek: Use accessor functions for iommu private data
      iommu/qcom: Use accessor functions for iommu private data
      iommu/virtio: Use accessor functions for iommu private data
      iommu: Move fwspec->iommu_priv to struct dev_iommu
      Merge branches 'iommu/fixes', 'arm/qcom', 'arm/omap', 'arm/smmu', 'x86/amd', 'x86/vt-d', 'virtio' and 'core' into next

Krzysztof Kozlowski (4):
      iommu/omap: Fix pointer cast -Wpointer-to-int-cast warnings on 64 bit
      iommu/omap: Fix printing format for size_t on 64-bit
      iommu/omap: Fix -Woverflow warnings when compiling on 64-bit architectures
      iommu: Enable compile testing for some of drivers

Qian Cai (1):
      iommu/vt-d: Silence RCU-list debugging warning in dmar_find_atsr()

Rob Herring (2):
      iommu/arm-smmu-v3: Batch ATC invalidation commands
      iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation support

Robin Murphy (3):
      iommu: Use C99 flexible array in fwspec
      MAINTAINERS: Cover Arm SMMU DT bindings
      iommu/arm-smmu: Refactor master_cfg/fwspec usage

 MAINTAINERS                              |   1 +
 drivers/acpi/arm64/iort.c                |   6 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c |   2 +-
 drivers/iommu/Kconfig                    |  21 +--
 drivers/iommu/amd_iommu_types.h          |   2 +-
 drivers/iommu/arm-smmu-v3.c              | 214 ++++++++++++++++++++++++++-----
 drivers/iommu/arm-smmu.c                 |  55 ++++----
 drivers/iommu/intel-iommu.c              |   3 +-
 drivers/iommu/intel-svm.c                |   9 +-
 drivers/iommu/iommu.c                    |  46 ++++---
 drivers/iommu/ipmmu-vmsa.c               |   7 +-
 drivers/iommu/mtk_iommu.c                |  13 +-
 drivers/iommu/mtk_iommu_v1.c             |  14 +-
 drivers/iommu/omap-iommu.c               |  10 +-
 drivers/iommu/omap-iopgtable.h           |   3 +-
 drivers/iommu/qcom_iommu.c               |  63 +++++----
 drivers/iommu/tegra-gart.c               |   2 +-
 drivers/iommu/virtio-iommu.c             |  42 +++---
 drivers/pci/ats.c                        |   4 +
 include/linux/device.h                   |   9 +-
 include/linux/iommu.h                    |  35 +++--
 include/uapi/linux/virtio_iommu.h        |  12 +-
 22 files changed, 386 insertions(+), 187 deletions(-)

The changes to 'include/linux/device.h' have been reviewed by Greg.

Please pull.

Thanks,

	Joerg

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl6Mm6oACgkQK/BELZcB
GuO6sg//dZtRWRQKKDiPuRQHlvPJyIorDO2OPvCk1eJWFAOwGyYQLnb1y38JUvZ/
pCMo8p3iRvmJs+qpTHsZY7I9EvGEdTr/2j00XTrtNoZ51N3YR337648FnSIndSL2
aLtTt9bMCbV3MF2beg9hxq8T34+94DdEoN/L22XjMnM1H8EDDxijGTDy8bvzhojX
2Tvq+haDzlR3F6f9o+3lyv0Xv5tqRlzfPcbTmXeIG+9Ccanh4g3bn5+SN8CZhTKu
GVsIb17HN/5vaTkMD5a5xt7BljfKXxhE8tt5lLkXIWWDQgbhWtJSY6paOnyEQn0U
uTlHAGEEX8TvYeTofqQrk1zM7WU/FaRNhL8r1vFQFaqWAeb5FI2+nBIJzDBtT+Cw
A3t4IAvkKoiXwDRFm04aKbvzy5by8hYC/p5XtV7Umw9OjJ6dvdH9hBZ99FKIv0pa
lzMq+EGgUK1MTlLImffcSQFA3QI88m693pxlvC6GnrnpQ3317SNyBSveOe6rzKc+
/n8W7BEpid1QcDJKQGfhfD5MOa3BQkSZSYv3t2mXn4Qk89eNINErlJELOGyVuqor
paQkOkjNWwrKA9FrewUVv8Px5lz2yMjReLYrSTiutipQUhvTcE1z2DJ+1q2MJ78x
pWyifx5BrVi5/0Iq5a1PCFEq6OenxgDqIgelhTLm4Wgw9frhRkA=
=uNur
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

--===============2887158022787646631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2887158022787646631==--
