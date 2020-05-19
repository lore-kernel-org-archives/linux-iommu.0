Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44669C433DF
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 15:40:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1EFC20657
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 15:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EFC20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AC2C4877F4;
	Tue, 19 May 2020 15:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TWZq10V56CAM; Tue, 19 May 2020 15:40:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A8EB2877D4;
	Tue, 19 May 2020 15:40:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8781FC0881;
	Tue, 19 May 2020 15:40:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8742CC0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 15:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7C02B88660
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 15:40:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dpGvNfSaaN1G for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 15:40:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EBDF288644
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 15:40:49 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 7A101286; Tue, 19 May 2020 17:40:46 +0200 (CEST)
Date: Tue, 19 May 2020 17:40:45 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.7-rc6
Message-ID: <20200519154039.GA27645@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============4373553085453774339=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4373553085453774339==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.7-rc6

for you to fetch changes up to bd421264ed307dd296eab036851221b225071a32:

  iommu: Fix deferred domain attachment (2020-05-19 15:05:43 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.7-rc6

All related to the AMD IOMMU driver, including:

	- ACPI table parser fix to correctly read the UID of ACPI
	  devices.

	- ACPI UID device matching fix.

	- Fix deferred device attachment to a domain in kdump kernels
	  when the IOMMU driver uses the dma-iommu DMA-API
	  implementation.

----------------------------------------------------------------
Alexander Monakov (1):
      iommu/amd: Fix over-read of ACPI UID from IVRS table

Joerg Roedel (1):
      iommu: Fix deferred domain attachment

Raul E Rangel (1):
      iommu/amd: Fix get_acpihid_device_id()

 drivers/iommu/amd_iommu.c      |  3 ++-
 drivers/iommu/amd_iommu_init.c |  9 +++++----
 drivers/iommu/iommu.c          | 17 +++++++++++------
 3 files changed, 18 insertions(+), 11 deletions(-)

Please pull.

Thanks,

	Joerg

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl7D/fQACgkQK/BELZcB
GuPR5xAAiPtEmj0wQrMYkn7R6ukRjQiphX+jjjHJgRzQOm3MSpFVJ2YkKUkMJ7fI
VxrK2BlZO03nHPRJMG1qERl8DZQZ7TMK7BIlcKAbVDTRhYslaXqqp7NT1Ctt3XaF
AqCe6WRaOz+PJQGSV4lmYgOCX5N5qkpj4NBnVbNxOuAKnr4f6utpOxdG3qYW5Qzf
mjya7kuKZb5+ppPWoq2r38JXo3xfMbZvyj2MsWqfkrtYdaZsWJm0jdnjshrnX5ma
xfvP0JGl149wAqlO2EnJmOVkrWuZxHNVvPrJAVv1vyQdE4DEy4A6+WH2hVsJBFUs
PtTxTvyvQpTlwY4hE/ZeUiwq52CAAzMOaii5xYwZ1+Lb6IX16+fN3pUTBwD4Y8Ia
zIokGp1M8XcKxYLgVsnRfIWWD2HAmifbZOi/ZZc2BMOR7Skqbvq4s6D+pHYhfuoG
1VOMsWUImTrvEVv6y0UwfYxhbO5rKCfzUh/6JS53sGnZmbkBAUAh9ynTYg9mFrpz
wFfP6KG8XtxyQdL6MYes7haq75yS/0UtaEAHWE8oC5CbtPcI2TDhD3dUFEjETp1k
d/0ZfRZTsOPK4mIvQYqVNRt9FkpAJQ5MlsyxAY5ux9bPyK46reCnJXp3bBAllglj
KEdcJwN8LHS4UDzjf8rA0X9evdEKeifY6/P47Vih7AZs7vm3YPg=
=dLUK
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--

--===============4373553085453774339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4373553085453774339==--
