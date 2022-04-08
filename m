Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F571C433F5
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 11:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DE786130C;
	Fri,  8 Apr 2022 11:52:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YqY2c7oVANPH; Fri,  8 Apr 2022 11:52:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8CB8960C28;
	Fri,  8 Apr 2022 11:52:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73829C0084;
	Fri,  8 Apr 2022 11:52:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84C86C002C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 11:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72AB883279
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 11:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4i47CY9hGyBC for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 11:52:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD7CA82C5E
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 11:52:11 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 331051E9; Fri,  8 Apr 2022 13:52:08 +0200 (CEST)
Date: Fri, 8 Apr 2022 13:52:06 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.18-rc1
Message-ID: <YlAh5jHAEl/wvb0g@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============6465281741187954288=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6465281741187954288==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S78vV3zdgm7+tFOJ"
Content-Disposition: inline


--S78vV3zdgm7+tFOJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.18-rc1

for you to fetch changes up to 71ff461c3f41f6465434b9e980c01782763e7ad8:

  iommu/omap: Fix regression in probe for NULL pointer dereference (2022-04-08 11:16:29 +0200)

----------------------------------------------------------------
IOMMU Fix for Linux v5.18-rc1:

	- Fix boot regression due to a NULL-ptr dereference on OMAP
	  machines

----------------------------------------------------------------
Tony Lindgren (1):
      iommu/omap: Fix regression in probe for NULL pointer dereference

 drivers/iommu/omap-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg

--S78vV3zdgm7+tFOJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmJQIeMACgkQK/BELZcB
GuPy1hAAnC8kn6odu36pzkZF/R7Wj51iCXRfHpDqggxFb0Una1PjSlCdIkfUURVU
x0DdLw+qWVbMkwhIvxG+1rNrhGoDqJdoxXLdJoHdm87ATLXj2XOmCd4h4UMGjK5k
jtx2f2n0H9KXa14FtMj4asJ+565ALRiJEswKv4DGji05WtABuUagxX7BG2/cVELW
MQUASwHwCNYXphkBLS0ki2CLNBnA55OkF4vvqRefNGsjwvHyUaYWiFmUfpU4veb2
m02kUxSjJbdevwXwRnQ/YXHZAjXttX1Lc61DJFCgCHhMh2W7NjggqaQ8OySpxmoC
6j3TDp16afUcERdYoQFB0uzeMb6Z5/vBXI71eoFJQse7MTOxsbyvqjDNPj0OMBmU
TRNzS1r4fBC8NcOPqJ+BifdVmcgWz0r+qnGkHYuU2/YaaSmlkFOzM6Y0F3fQcG7c
Drs0hqAABRaLuXVDpFNBVsl+OEaFfsg2hE5nsRFld3gc+fXC3TGtfttljBJuUsxa
ZtID2u53lebjpsODpEZbsY2klTozuIr6oKQNFLWez6KMHJIg4f9UBJGJgD6P/x+4
+Sm/wtRsOQjvJogsal2HEg05Bq+L+44bKdSoCLaMR3Gpu2LeCMjHWhSJAvVh19dm
HayU26ex0tjtkwmppEA58QGvCI1OVycuPvXXn93Y/WRiuRCMFp8=
=5IF9
-----END PGP SIGNATURE-----

--S78vV3zdgm7+tFOJ--

--===============6465281741187954288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6465281741187954288==--
