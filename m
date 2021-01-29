Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCE5C433DB
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 16:41:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29ACB64E00
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 16:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29ACB64E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C504A867A5;
	Fri, 29 Jan 2021 16:41:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B-4HT6P6LIEX; Fri, 29 Jan 2021 16:41:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DF69B86511;
	Fri, 29 Jan 2021 16:41:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAAD4C0FA7;
	Fri, 29 Jan 2021 16:41:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6204FC013A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 16:41:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 558CF865A5
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 16:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B4xjzqZ-Rv24 for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 16:41:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5126886511
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 16:41:33 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 01A68303; Fri, 29 Jan 2021 17:41:30 +0100 (CET)
Date: Fri, 29 Jan 2021 17:41:29 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.11-rc5
Message-ID: <20210129164123.GA25513@8bytes.org>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Content-Type: multipart/mixed; boundary="===============1578497133573349085=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1578497133573349085==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.11-rc5

for you to fetch changes up to 29b32839725f8c89a41cb6ee054c85f3116ea8b5:

  iommu/vt-d: Do not use flush-queue when caching-mode is on (2021-01-28 13:59:02 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.11-rc5

Including:

	- AMD IOMMU Fix to make sure features are detected before they
	  are queried.

	- Intel IOMMU address alignment check fix for an IOLTB flushing
	  command.

	- Performance fix for Intel IOMMU to make sure the code does not
	  do full IOTLB flushes all the time. Those flushes are very
	  expensive on emulated IOMMUs.

----------------------------------------------------------------
Lu Baolu (1):
      iommu/vt-d: Correctly check addr alignment in qi_flush_dev_iotlb_pasid()

Nadav Amit (1):
      iommu/vt-d: Do not use flush-queue when caching-mode is on

Suravee Suthikulpanit (1):
      iommu/amd: Use IVHD EFR for early initialization of IOMMU features

 drivers/iommu/amd/amd_iommu.h       |  7 ++---
 drivers/iommu/amd/amd_iommu_types.h |  4 +++
 drivers/iommu/amd/init.c            | 56 +++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel/dmar.c          |  2 +-
 drivers/iommu/intel/iommu.c         | 32 ++++++++++++++++++++-
 5 files changed, 92 insertions(+), 9 deletions(-)

Please pull.

Thanks,

	Joerg

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmAUOrMACgkQK/BELZcB
GuNMbRAA1qlBq3RXbPp8Iftn1CXMnLLkpb576ndYAmxMTyh4WxRxrt8zTOJ17Lrc
xee83/utsWZ0K3AtSkXVe/cCdq+mH57M/A5bJUK0QdrPZC27xTNtBpKpI6NgbM/q
NJzdTpa9GFYkpKIEO5MvVTmC0DDin+yDLEge43osARz+1eteEfOTfaAkhVga4ml/
3tbmQouk4GdOw5b8aHMAXPJHJbNTWTcZ4B7mWVIKwAAhT1XM1TbjX2DjNr7QRrz1
Cibh0a3S9hkvr5W5dTU116f/MRAa9Cz28Zdk57hzD2ry+UVV6lNcLCQNndiafdnb
tKx7lqdXIfnXC+td622EXhqC82Rd5z1oM01Ipcrt89KourdWtGcfADmy927tOol4
VkuSTc6mVSmMT/vig6dy9r/BbcpX9CNkcKxBTt/PYT23mrDWKoMC9QdcQ5xNaR8G
Sd4ai96vWFz4IJsKkImRz8ASh2u2LflK9gtmjcg/xyUMiU34jbvnnN7yNAVi4eES
bBzwi8h/TXcel975KhR7xGDURPfOYuhGNy4pBtNUA+JB1MDQGVlDUrbQcdvIKQ3o
43PNwb4QYZRKfRCJhttsDNL+txYVuUjPSi6ydsJs1L9Wmhfy5ipMuJU/GD1HxtWA
mJFwF1GU67vauEvV7ZLZres8wkSvhfMR9qe6yo5egc67NyfCjnQ=
=PJqE
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--

--===============1578497133573349085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1578497133573349085==--
