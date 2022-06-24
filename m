Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923DACCA473
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 13:56:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2266960A9B;
	Fri, 24 Jun 2022 13:56:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2266960A9B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2CjnimN2Zwmt; Fri, 24 Jun 2022 13:56:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E17A760AD2;
	Fri, 24 Jun 2022 13:56:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E17A760AD2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA6AEC0032;
	Fri, 24 Jun 2022 13:56:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8660C002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 13:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFEE340071
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 13:56:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DFEE340071
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hpgHEcCqeju0 for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 13:56:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7EC8241B49
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7EC8241B49
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 13:56:19 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 03495672; Fri, 24 Jun 2022 15:56:15 +0200 (CEST)
Date: Fri, 24 Jun 2022 15:56:14 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.19-rc3
Message-ID: <YrXCfic1ua0DdDBQ@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============3719544940762301487=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3719544940762301487==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i5gdFe3KS1rh1Ndu"
Content-Disposition: inline


--i5gdFe3KS1rh1Ndu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.19-rc3

for you to fetch changes up to c242507c1b895646b4a25060df13b6214805759f:

  MAINTAINERS: Add new IOMMU development mailing list (2022-06-24 15:36:11 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.19-rc3

Including:

	- Add a new IOMMU mailing list to the MAINTAINERS file to
	  prepare for the a list migration happening on July 5th. The
	  old list needs to stay in place until the switch happens to
	  guarantee seemless archiving of list email.

	- Fix compatible device-tree string for rcar-gen4 in Renesas
	  IOMMU driver.

----------------------------------------------------------------
Joerg Roedel (1):
      MAINTAINERS: Add new IOMMU development mailing list

Yoshihiro Shimoda (1):
      iommu/ipmmu-vmsa: Fix compatible for rcar-gen4

 MAINTAINERS                | 11 +++++++++++
 drivers/iommu/ipmmu-vmsa.c |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg

--i5gdFe3KS1rh1Ndu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmK1wn4ACgkQK/BELZcB
GuOZaBAApa52HkW7MJ1GuhOvN0LLqNWMUOI1ED+dgNjSeLXH47WANnM4g/23uXfl
82YBQ8Gp8Cq+Xtv9cJPb1ol5GwXYrG4c3FMwqcwp9l8fLwyb1VwPXPNvFrHSrrin
GqVuBuWzv1M4k2yrggeVMztd9pt2N4OFfnzSbVTxGoErbbSv3S0o6o7/N0Gk79AY
5GrOVCGKZXz6lgJzzyBQBOb35IHBkFHzZm0GLCO6xOGBxSsChAWGOqOkC5acggJo
i6aaukPeD4Das20Vkph9Q/xKSGEIfZwhC4Bh/tuUEczgdKopoDO7uua/yX2POdJK
E1o1T7+OaklNFofIbGBm/83FcjOqQ6V8pkMmuvisvhoxm7CWdFqUg5IwSyCKsMjW
jlAduZ12RqYv6fPWisdkGxwZXtJhe+tYMFl/SBMpYZ0fGSg78QrXM0w3oWErsU7a
UAu0Ev8kglohHLpHTBQLM3dKNhaTgs1ZUZP0ZrY52jfcoyC7sb9H5NUmfMBS2ja2
nLxZsKkdC42ZzrtgB4g0PeIlykD/iZ/gA9nlwoOFoOZEnl9jM3WlTUmRgJvk9WIu
n31JiCJlOgAEOKVgQqnwgvdUi8UdU2rdUAOfeK/A/elUWg5dGUqxEZ33xIVQlyZr
ZVDw7hdIMAF/0p33z3Lpo9ydGZ5lpD8SrlcvKDFdaNjj0PGJZMo=
=ajTF
-----END PGP SIGNATURE-----

--i5gdFe3KS1rh1Ndu--

--===============3719544940762301487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3719544940762301487==--
