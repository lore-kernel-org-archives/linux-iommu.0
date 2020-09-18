Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9355FC43464
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 15:11:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20875235FA
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 15:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20875235FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 95EE8815E8;
	Fri, 18 Sep 2020 15:11:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QoV8ZvDLqjzz; Fri, 18 Sep 2020 15:11:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CFCDC811C0;
	Fri, 18 Sep 2020 15:11:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC402C0888;
	Fri, 18 Sep 2020 15:11:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50E01C0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 15:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3E9E4815E8
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 15:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QWmchY5lYyQA for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 15:11:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 26A73811C0
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 15:11:01 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 43459A8D; Fri, 18 Sep 2020 17:10:58 +0200 (CEST)
Date: Fri, 18 Sep 2020 17:10:56 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.9-rc5
Message-ID: <20200918151051.GA31007@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============9171556810015745700=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============9171556810015745700==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.9-rc5

for you to fetch changes up to e97685abd5d711c885053d4949178f7ab9acbaef:

  iommu/amd: Restore IRTE.RemapEn bit for amd_iommu_activate_guest_mode (2020-09-18 11:17:19 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.9-rc5

Two fixes for the AMD IOMMU driver:

	- Fix a potential NULL-ptr dereference found by smatch

	- Fix interrupt remapping when a device is assigned to a guest
	  and AVIC is enabled.

----------------------------------------------------------------
Joao Martins (1):
      iommu/amd: Fix potential @entry null deref

Suravee Suthikulpanit (1):
      iommu/amd: Restore IRTE.RemapEn bit for amd_iommu_activate_guest_mode

 drivers/iommu/amd/iommu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl9kzfYACgkQK/BELZcB
GuPpIg//av7xkX3DUvOd7ZJf+Jd7q25MYp1V2h89/PvfkPPy/X05tJDt4N/MFzT8
qFi05Yl7kocTf7RhH5odvsaBF5x2DoF/7mmjJjBAesoJIye0BL2jugajiIyEOz8N
7cLItdClfs/cFjM9Qwux1NdsXnWThNywSpZRPpx279GGJZxwvV4B98MYOo/j1IY7
F41HWi3AeD/x1lnR3NuflnYv8TaTm7cZubzmimC9uOujbB1asBrIx1qVeqL3WP9K
QeXj8UeGaZFDWaYfRM+8RPP2fnqHQu6IyE0SuzyA2BsEh5qz59L0QUJ5vjauQt0N
IauNpKF8Yq04tHfnRyWnnbUgshM7WkTb+87i5ZVVf/EsXw8SCKKmfYLob/Ubb6mU
NI/a1F06IGFrMwvhMYE+GiHEP7JM7/g5/x1TmCj8XFXQhRpnMopoLNdLVjt8O64G
hStvr9OmM8y7ED//vUMdPAHnQKZ+CfXaG1TY5fJR8wIjTPMCow12S/6VG+klmJ26
XCrgoc0A1GCyxQKSOd4oJajcxW0/LBf7heUM7BjnHguEpDqEjNClYpU7FtiraR2Y
75SW5aIeIsx9WDR88pTRvBtu1IJ9pmXran0D1umsCPhQS4ULP/94APbLXmN8rObk
RACcOeWjDc+YDMj3YH9TS6O/8Y6VW+s08Mwnl1hDxrQpvzUfiLA=
=2y0U
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

--===============9171556810015745700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============9171556810015745700==--
