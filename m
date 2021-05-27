Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F8EC4707F
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 17:57:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73B7613C9
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 17:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73B7613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 934F783E1C;
	Thu, 27 May 2021 17:57:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f1eOWWGVjjup; Thu, 27 May 2021 17:57:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2705683A95;
	Thu, 27 May 2021 17:57:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E112AC000D;
	Thu, 27 May 2021 17:57:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74B90C0001
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 17:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B82183DAC
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 17:57:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2q7fz87ydImG for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 17:57:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44CF183A95
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 17:57:30 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id CE612247; Thu, 27 May 2021 19:57:26 +0200 (CEST)
Date: Thu, 27 May 2021 19:57:25 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.13-rc3
Message-ID: <YK/dheM2NZz6KOkb@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============8733715593883309170=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8733715593883309170==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r7JlHYcG2r1PRoWj"
Content-Disposition: inline


--r7JlHYcG2r1PRoWj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.13-rc3

for you to fetch changes up to 0ee74d5a48635c848c20f152d0d488bf84641304:

  iommu/vt-d: Fix sysfs leak in alloc_iommu() (2021-05-27 16:07:08 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.13-rc3

Including:

	- Important fix for the AMD IOMMU driver in the recently added
	  page-specific invalidation code to fix a calculation.

	- Fix a NULL-ptr dereference in the AMD IOMMU driver when a
	  device switches domain types.

	- Fixes for the Intel VT-d driver to check for allocation
	  failure and do correct cleanup.

	- Another fix for Intel VT-d to not allow supervisor page
	  requests from devices when using second level page
	  translation.

	- Add a MODULE_DEVICE_TABLE to the VIRTIO IOMMU driver

----------------------------------------------------------------
Bixuan Cui (1):
      iommu/virtio: Add missing MODULE_DEVICE_TABLE

Dan Carpenter (1):
      iommu/vt-d: Check for allocation failure in aux_detach_device()

Jean-Philippe Brucker (1):
      iommu/amd: Clear DMA ops when switching domain

Lu Baolu (1):
      iommu/vt-d: Use user privilege for RID2PASID translation

Nadav Amit (1):
      iommu/amd: Fix wrong parentheses on page-specific invalidations

Rolf Eike Beer (1):
      iommu/vt-d: Fix sysfs leak in alloc_iommu()

 drivers/iommu/amd/iommu.c    | 4 +++-
 drivers/iommu/intel/dmar.c   | 4 +++-
 drivers/iommu/intel/iommu.c  | 9 +++++++--
 drivers/iommu/intel/pasid.c  | 3 ++-
 drivers/iommu/virtio-iommu.c | 1 +
 5 files changed, 16 insertions(+), 5 deletions(-)

Please pull.

Thanks,

	Joerg

--r7JlHYcG2r1PRoWj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmCv3YIACgkQK/BELZcB
GuOAWw//WQuACOwVW8z+7/0rzSoYcfITOJ21HhiHYCHpr7G6+3w5gUJfia/vWeB1
QkfS7IFtcnkjGCoI5ZLQN2c6NIHfXrv7hjk73A95XKAhy/t208u749EYvj0vJsFm
LNevjwcpQuRFJZMFO+1oCVt+lCGTdneY+BXme2GV6D5tu/U8MNGlzrnoMk5+rcPr
5jq60d9ELFxpLRVHc3/pd7uSn+LqzF2hPjxxifFgoZyVW9zC1Qp2pEOXhosb+HXv
rBjDaXlo7k9osgRWLErGjkr3xSIfDaLFWfJmOAwCem7OvZn9NIdIsikiQdSgQMJ2
fkwQcY8lwe6ZWvW5mCqy7gqIQVkYU2D3hoUdWUxpatrXoDLQyLpPJYEzNq6a4yMv
QeMQ5gEWGiYKar0PQoG257TjMieT4FWsFUBZxWl3tSsg3Vf0pmDa3NJ7493u06D6
d8nUFqjqDs4eFcivXop/sbGYyD9kpoEkzxKiciEsKw/5UvZb+zZ8aASl8JvY3nYC
qeRNtcThiK5HJF78UrSfFxmke1v8pp+5wphBi5Z4yBimliwo4hGVleQLrR4wOfDr
6EXDE+GA1mtzn0SvzMqhRy4C+VRUkz6f6gNTQFxhjLEa3j5MXjhHczZvSQeXFddX
UmilTYT2f4QNVdX5oR4rSzMLa5j5fYQXCEeDUW1LtZAXDUxs6yg=
=hxvZ
-----END PGP SIGNATURE-----

--r7JlHYcG2r1PRoWj--

--===============8733715593883309170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8733715593883309170==--
