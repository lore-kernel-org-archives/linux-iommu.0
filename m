Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462D0C4320A
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 07:54:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8A46103C
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 07:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF8A46103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B57C74032C;
	Fri, 20 Aug 2021 07:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G2b7-3dl5Dv2; Fri, 20 Aug 2021 07:54:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 631304051E;
	Fri, 20 Aug 2021 07:54:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C9E6C0010;
	Fri, 20 Aug 2021 07:54:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD345C000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 07:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ADA2D4071E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 07:54:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VcZEz6lN_Flp for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 07:54:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D89B4071A
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 07:54:14 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B0847309; Fri, 20 Aug 2021 09:54:11 +0200 (CEST)
Date: Fri, 20 Aug 2021 09:54:10 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.14-rc6
Message-ID: <YR9fopoKjkg2o2V1@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============1493264807684634697=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1493264807684634697==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fxzoJDnuzNfsWAyh"
Content-Disposition: inline


--fxzoJDnuzNfsWAyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.14-rc6

for you to fetch changes up to 8798d36411196da86e70b994725349c16c1119f6:

  iommu/vt-d: Fix incomplete cache flush in intel_pasid_tear_down_entry() (2021-08-18 13:15:58 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.14-rc6

Including:

	- Fix for a potential NULL-ptr dereference in IOMMU core code

	- Two resource leak fixes

	- Cache flush fix in the Intel VT-d driver

----------------------------------------------------------------
Ezequiel Garcia (1):
      iommu/dma: Fix leak in non-contiguous API

Fenghua Yu (1):
      iommu/vt-d: Fix PASID reference leak

Frank Wunderlich (1):
      iommu: Check if group is NULL before remove device

Liu Yi L (1):
      iommu/vt-d: Fix incomplete cache flush in intel_pasid_tear_down_entry()

 drivers/iommu/dma-iommu.c   |  1 +
 drivers/iommu/intel/pasid.c | 10 ++++++++--
 drivers/iommu/intel/pasid.h |  6 ++++++
 drivers/iommu/intel/svm.c   |  3 ++-
 drivers/iommu/iommu.c       |  3 +++
 5 files changed, 20 insertions(+), 3 deletions(-)

Please pull.

Thanks,

	Joerg

--fxzoJDnuzNfsWAyh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmEfX6IACgkQK/BELZcB
GuPnSBAA5BchTG8clKnQrKlrlekTM8zBVifRvcS01ERNMHXt3arJZ5l+1iSRMuUN
cpeTAWIMr3ckdWSIkb/f2eKp63QCY60asf+l05cc/yyyl/lbkgT/Nu/eXSUkZXxf
qU6XUn/7PNL9coKm5dwaBRC+fjX8vjtmh8F6aiT8dYGJB8cfyq51NDLoq11jdnEq
cD0aS4R+Uevg8HaNW0BMeeB9E+I/FQtsONYSAHiJGJz1b3abv6PGSBrP83l5EpUG
1TjmPF6eUAK9m/w9M9cY2qwlVZP64FHvtfzE2xJSRqHIDxVR+oAzdM+A8DznRJGt
zisrjq8w2tDp5tXLn1g5T1eWsHmMxqmk++m8aMeR3LVumzIAZQK7n1xktola/QqA
yoh7Y7sBuzrSybAwLkMgj+gxeWl3tvG1aEyaRCsDIaLJaIaFGyk3C1C1ib3+kRU/
NwTmBJccFU0et4aIcP/uraOCOul38wBnrUqNHIBZTt2IULP+sCfKohwLtYOFhQPM
uvYlEcSK1X43CQW3x+fWF4tpil/PjUwzPevoZjfTv6krVemfdXEjDL/vD/EKcAW8
9+3K24adP8u1YRDKjNooe2RXmm+2f1ikHAjiG+BvsPhtSKaUR5z4H0ryjlrHR7pa
+oWmCqvTd8Um7PPLD4HWN4cxcOx4MJGoBxJ9J4ggBWNgsuQJ2MA=
=1Nmb
-----END PGP SIGNATURE-----

--fxzoJDnuzNfsWAyh--

--===============1493264807684634697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1493264807684634697==--
