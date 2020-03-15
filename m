Return-Path: <SRS0=ouxr=5A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9333C10DCE
	for <iommu@archiver.kernel.org>; Sun, 15 Mar 2020 09:16:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8E6205ED
	for <iommu@archiver.kernel.org>; Sun, 15 Mar 2020 09:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8E6205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2C01E889F4;
	Sun, 15 Mar 2020 09:16:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2tJfVCL2cKlP; Sun, 15 Mar 2020 09:16:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 239C886B67;
	Sun, 15 Mar 2020 09:16:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A530C18DA;
	Sun, 15 Mar 2020 09:16:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 761EDC013E
 for <iommu@lists.linux-foundation.org>; Sun, 15 Mar 2020 09:16:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 60AC188046
 for <iommu@lists.linux-foundation.org>; Sun, 15 Mar 2020 09:16:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dzkr3YgIqzJm for <iommu@lists.linux-foundation.org>;
 Sun, 15 Mar 2020 09:16:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 502DE87A14
 for <iommu@lists.linux-foundation.org>; Sun, 15 Mar 2020 09:16:14 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 53FF836C; Sun, 15 Mar 2020 10:16:11 +0100 (CET)
Date: Sun, 15 Mar 2020 10:16:10 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.6-rc5
Message-ID: <20200315091602.GA18173@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============4904378338233277560=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4904378338233277560==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.6-rc5

for you to fetch changes up to 1da8347d8505c137fb07ff06bbcd3f2bf37409bc:

  iommu/vt-d: Populate debugfs if IOMMUs are detected (2020-03-14 20:02:43 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.6-rc5

Including:

	- Mostly Intel VT-d fixes:
	   - RCU list handling fixes
	   - Replace WARN_TAINT with pr_warn + add_taint for reporting
	     firmware issues
	   - DebugFS fixes
	   - Fix for hugepage handling in iova_to_phys implementation
	   - Fix for handling VMD devices, which have a domain number
	     which doesn't fit into 16 bits
	   - Warning message fix
	- MSI allocation fix for iommu-dma code
	- Sign-extension fix for io page-table code
	- Fix for AMD-Vi to properly update the is-running bit when
	  AVIC is used

----------------------------------------------------------------
Amol Grover (1):
      iommu/vt-d: Fix RCU list debugging warnings

Daniel Drake (1):
      iommu/vt-d: Ignore devices with out-of-spec domain number

Hans de Goede (3):
      iommu/vt-d: dmar: replace WARN_TAINT with pr_warn + add_taint
      iommu/vt-d: dmar_parse_one_rmrr: replace WARN_TAINT with pr_warn + add_taint
      iommu/vt-d: quirk_ioat_snb_local_iommu: replace WARN_TAINT with pr_warn + add_taint

Marc Zyngier (1):
      iommu/dma: Fix MSI reservation allocation

Megha Dey (2):
      iommu/vt-d: Fix debugfs register reads
      iommu/vt-d: Populate debugfs if IOMMUs are detected

Qian Cai (2):
      iommu/vt-d: Fix RCU-list bugs in intel_iommu_init()
      iommu/vt-d: Silence RCU-list debugging warnings

Robin Murphy (1):
      iommu/io-pgtable-arm: Fix IOVA validation for 32-bit

Suravee Suthikulpanit (1):
      iommu/amd: Fix IOMMU AVIC not properly update the is_run bit in IRTE

Yonghyun Hwang (1):
      iommu/vt-d: Fix a bug in intel_iommu_iova_to_phys() for huge page

Zhenzhong Duan (1):
      iommu/vt-d: Fix the wrong printing in RHSA parsing

 drivers/iommu/amd_iommu.c           |  4 +--
 drivers/iommu/dma-iommu.c           | 16 ++++++------
 drivers/iommu/dmar.c                | 24 ++++++++++++-----
 drivers/iommu/intel-iommu-debugfs.c | 51 +++++++++++++++++++++++++------------
 drivers/iommu/intel-iommu.c         | 28 +++++++++++++-------
 drivers/iommu/io-pgtable-arm.c      |  4 +--
 include/linux/dmar.h                | 14 ++++++----
 include/linux/intel-iommu.h         |  2 ++
 8 files changed, 94 insertions(+), 49 deletions(-)

Please pull.

Thanks,

	Joerg

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl5t8lIACgkQK/BELZcB
GuNQ5Q/+JYhgMkuVL4zWxTmGPHN1b/rcjNcYD0LuJlfjyAo0vVoYhbcjXb0QsjWv
ml4k59xvoVTob2yO8w00dYI4xCgjLzwqoWWpgEqL4zyv3IYcV3ICYxh2QdkGmDBP
BYd01ItYbxq5wLsBXquqkizFxgIkDFV4QKk2qBpV0lScEIqHMzkQQstQyZzWM0jM
JdXZifHbAalGXLyPLYhWCuVNTNLrU2xbUSpmpd35I+OuckdV9mN2tDq9rWhN8Egr
K802uQZLrn1RBhFF4MfxXksNNAgURYb9zXGSwvKuwI9mQCV1YRxUy0uOgIBuyYcT
IdmFvqAgFODnbWy7xAtd0ABpb1FYj8bfQq84pQODTvzyIdnDbMNS1fnxN0fYy5uk
zeUoSEb90JdOT3M1wX3ZuvuvE2WCyp5WAyP+gfbNK8EorwRGa54W2t6dPA8Vwkr0
ujoRr6bjNLbTJvDKGJQeIx7q3J4NTXDZieqAgFI6PybxDJOKC+SBwVxcs+wiSEqA
gU/9AJ9yVq1hqMbgEX/nW4+exjvXHJbTXcuO/7TInKFsrnR1OE9Dc86zXJZve28Y
M1hAj541kbPsHZfjGwQrJGQzoQPhsPHou8z7BigvTxu2Whzn21Ue99ZukhARkmt5
QTxaws8G3vIJlTZmDcvl3E4d3NYN7mLkBDYyccUMXzBcRy3D/P0=
=P5WR
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

--===============4904378338233277560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4904378338233277560==--
