Return-Path: <SRS0=ta7q=7L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1881CC433E0
	for <iommu@archiver.kernel.org>; Fri, 29 May 2020 18:58:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B0A2074B
	for <iommu@archiver.kernel.org>; Fri, 29 May 2020 18:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B0A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 31CE022253;
	Fri, 29 May 2020 18:58:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rjesMThySO2d; Fri, 29 May 2020 18:58:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 055BC260A9;
	Fri, 29 May 2020 18:58:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9976C088A;
	Fri, 29 May 2020 18:58:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B6BBC016F
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 18:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8FD9689415
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 18:58:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OuH+79KINF66 for <iommu@lists.linux-foundation.org>;
 Fri, 29 May 2020 18:58:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2B35F89413
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 18:58:46 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B97E450C; Fri, 29 May 2020 20:58:42 +0200 (CEST)
Date: Fri, 29 May 2020 20:58:41 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.7-rc7
Message-ID: <20200529185836.GA31964@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============8563240871361186860=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8563240871361186860==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9cb1fd0efd195590b828b9b865421ad345a4a145:

  Linux 5.7-rc7 (2020-05-24 15:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.7-rc7

for you to fetch changes up to 7cc31613734c4870ae32f5265d576ef296621343:

  iommu: Fix reference count leak in iommu_group_alloc. (2020-05-29 15:27:50 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.7-rc7

Including:

	- Two compile test fixes for issues introduced during the
	  5.7-rc1 merge window.

	- A fix for a reference count leak in an error path of
	  iommu_group_alloc().

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      ia64: Hide the archdata.iommu field behind generic IOMMU_API
      x86: Hide the archdata.iommu field behind generic IOMMU_API

Qiushi Wu (1):
      iommu: Fix reference count leak in iommu_group_alloc.

 arch/ia64/include/asm/device.h | 2 +-
 arch/x86/include/asm/device.h  | 2 +-
 drivers/iommu/iommu.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Please pull.

Thanks,

	Joerg

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl7RW1wACgkQK/BELZcB
GuPY8A//aBv4G6EhNbtdu/IoPcOeUHJZBmngcH/CA26kfJOfUOTkDqz0NBZrvrb0
VLbvXPc8SBiJkTYSQge5oMNQpEf+mtIEsjN2Um4y9lupF4p8+P6/cFmkaB4R57rN
23M2uJu7012BV4qR21vzeM46rGy377XD2QlSIrc8E2V8ndJ5hOwgmgTcAjuAmTZ6
dRb7/Q6pmsMvmmldYQQasVVNKcYmCkA6gA28wN2FZIDC1bLawc1kBw4wYrlSKHEi
et5ichhOlG/ApkE0/r8/ZUXwiLkDGnYcHpaiwvQwG4WjaKB/fXth131tKwMb+miU
O44aydqUzpUXQZ/SGKt4FPGljcKXfBqYS57GdInoaOoVRB71cGQvMHfVhKL1ER/O
m4MswSNkNGz4ChGw0uk+sE200mFJkowRs1OTb9gX/4j2XgYKlfho59WHEtbvS1T2
UfLsGJ37hTx3qYwMiG+8csIH9NhwYSDI8CmAx1qE3AjoGTfXmamjfyHr2ipM62ek
yPIVYIsWVnBAFRaSh7Caqcm9UiUfQ/ugwRFoAeNZzQvMZLfeWPdXabnD8ncJyBAf
42GBK3yjb0KYAJJ1rPy5MZsBwK2ISZpeWbDWJqpCLG7qbW0Ie1ceCB912MBAsCnY
cFZa1T21FllnZaWpbgsqA1nEeZdf0qZqf22Br91jzojLdaCTxY4=
=XJWf
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

--===============8563240871361186860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8563240871361186860==--
