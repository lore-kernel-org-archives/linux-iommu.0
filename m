Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB33DC433F5
	for <iommu@archiver.kernel.org>; Sun, 28 Nov 2021 13:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8707F830E6;
	Sun, 28 Nov 2021 13:33:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Th32MOTaQdzL; Sun, 28 Nov 2021 13:33:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6161F8102A;
	Sun, 28 Nov 2021 13:33:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC866C001C;
	Sun, 28 Nov 2021 13:33:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB4C0C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 13:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A507B40106
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 13:33:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V5K9nOiss5jd for <iommu@lists.linux-foundation.org>;
 Sun, 28 Nov 2021 13:33:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1BCA401C3
 for <iommu@lists.linux-foundation.org>; Sun, 28 Nov 2021 13:33:03 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id C7DA1396; Sun, 28 Nov 2021 14:33:00 +0100 (CET)
Date: Sun, 28 Nov 2021 14:32:59 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.16-rc2
Message-ID: <YaOFCyGBRITPRyaa@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============2590617969439081790=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2590617969439081790==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7xziTSZJMkKpZ1PO"
Content-Disposition: inline


--7xziTSZJMkKpZ1PO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.16-rc2

for you to fetch changes up to 86dc40c7ea9c22f64571e0e45f695de73a0e2644:

  iommu/vt-d: Fix unmap_pages support (2021-11-26 22:54:47 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.16-rc2:

Including:

  - Intel VT-d fixes:
    - Remove unused PASID_DISABLED
    - Fix RCU locking
    - Fix for the unmap_pages call-back

  - Rockchip RK3568 address mask fix

  - AMD IOMMUv2 log message clarification

----------------------------------------------------------------
Alex Bee (1):
      iommu/rockchip: Fix PAGE_DESC_HI_MASKs for RK3568

Alex Williamson (1):
      iommu/vt-d: Fix unmap_pages support

Christophe JAILLET (1):
      iommu/vt-d: Fix an unbalanced rcu_read_lock/rcu_read_unlock()

Joerg Roedel (2):
      iommu/vt-d: Remove unused PASID_DISABLED
      iommu/amd: Clarify AMD IOMMUv2 initialization messages

 arch/x86/include/asm/fpu/api.h  | 6 ------
 drivers/iommu/amd/iommu_v2.c    | 6 +++---
 drivers/iommu/intel/cap_audit.c | 5 +++--
 drivers/iommu/intel/iommu.c     | 6 ++----
 drivers/iommu/rockchip-iommu.c  | 4 ++--
 5 files changed, 10 insertions(+), 17 deletions(-)

Please pull.

Thanks,

	Joerg

--7xziTSZJMkKpZ1PO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmGjhQsACgkQK/BELZcB
GuPmVRAAub7Gwv82zRlFldNWwQOh6CHMmOBB34W8wNCO3BueB3erZTU2wBpSWCIu
BN0Bz5g1uGPqbDbW58i2UVDowBqY6MSN0RwLDtPAsVT5to2FiJcIu34pBfLDXpgs
j8rio4MSEWEyvT2i/8bEMXlyB4lHuw6Lateh3LV+eNDYA4va8625kBp7agAd1N2z
0SKPtMHlwzDfTbGKYUlASkFbPXHc6WKWDhL8enxfoBHY4ZTWcCj5OLqZzKfyRIMK
jgHPALme/nVJvbGWDFx4EXjQLQT0Q6FnOGxHi2W1iaKvcyHatrN/2KdflepTLP1C
THosEoua360YqVsWPtht2zga7sAHD1fAFIm1EIUgb9OpPq1BrxOGNbOXcOv5PkcD
h68vQqefysu68Af/OC8mX19xKXKH7MtJsF0xC+4jYG7dT16/fZUbekV19RD+Rq8W
8aVksSdwi+NinJ9iKfqcmPe7BFvmOyF3SLDbsAp9IEWJPt68JyiQ5KpE86P4tYA8
XKpOoGI16kT85oZyExGFcJm8B1wfYOLo7go7PyxGkeX93Tu8R9PI+k5XIoZcyBhv
RN2y6QhfnxfeMe8k9fiZPD84sS76w00x58OyMbjEDA/Zymsl2zDdAAP/hQ/guAxd
xCXIt9zH39efF3BNfB1KiQP5bHEFU2ebzsjfkPHs8ka4V4a1mAs=
=WhCV
-----END PGP SIGNATURE-----

--7xziTSZJMkKpZ1PO--

--===============2590617969439081790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2590617969439081790==--
