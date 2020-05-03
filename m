Return-Path: <SRS0=M8Ie=6R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47451C28CBC
	for <iommu@archiver.kernel.org>; Sun,  3 May 2020 12:19:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD3C2075B
	for <iommu@archiver.kernel.org>; Sun,  3 May 2020 12:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD3C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B90AA20470;
	Sun,  3 May 2020 12:19:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y5n6MdqRGols; Sun,  3 May 2020 12:19:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6939F22661;
	Sun,  3 May 2020 12:19:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55BB9C088A;
	Sun,  3 May 2020 12:19:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A941DC0175
 for <iommu@lists.linux-foundation.org>; Sun,  3 May 2020 12:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A4E3F87A60
 for <iommu@lists.linux-foundation.org>; Sun,  3 May 2020 12:19:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8fylIBwLJ7cW for <iommu@lists.linux-foundation.org>;
 Sun,  3 May 2020 12:19:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0566587863
 for <iommu@lists.linux-foundation.org>; Sun,  3 May 2020 12:19:39 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id E13FF3A2; Sun,  3 May 2020 14:19:35 +0200 (CEST)
Date: Sun, 3 May 2020 14:19:34 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.7-rc3
Message-ID: <20200503121929.GA10425@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============7936194127449063791=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7936194127449063791==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c:

  Linux 5.7-rc3 (2020-04-26 13:51:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.7-rc3

for you to fetch changes up to b52649aee6243ea661905bdc5fbe28cc5f6dec76:

  iommu/qcom: Fix local_base status check (2020-05-01 13:37:23 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.7-rc3

Including:

	- Fix for a memory leak when dev_iommu gets freed and a
	  sub-pointer does not.

	- Build dependency fixes for Mediatek, spapr_tce, and
	  Intel IOMMU driver.

	- Export iommu_group_get_for_dev() only for GPLed modules

	- Fix for AMD IOMMU interrupt remapping when x2apic is
	  enabled

	- Fix for error path in the QCOM IOMMU driver probe function

----------------------------------------------------------------
Geert Uytterhoeven (1):
      iommu/mediatek: Fix MTK_IOMMU dependencies

Greg Kroah-Hartman (1):
      iommu: Properly export iommu_group_get_for_dev()

Kevin Hao (1):
      iommu: Fix the memory leak in dev_iommu_free()

Krzysztof Kozlowski (1):
      iommu: spapr_tce: Disable compile testing to fix build on book3s_32 config

Lu Baolu (1):
      iommu/vt-d: Use right Kconfig option name

Suravee Suthikulpanit (1):
      iommu/amd: Fix legacy interrupt remapping for x2APIC-enabled system

Tang Bin (1):
      iommu/qcom: Fix local_base status check

 drivers/iommu/Kconfig          | 4 ++--
 drivers/iommu/amd_iommu_init.c | 2 +-
 drivers/iommu/intel-iommu.c    | 4 ++--
 drivers/iommu/iommu.c          | 3 ++-
 drivers/iommu/qcom_iommu.c     | 5 ++++-
 5 files changed, 11 insertions(+), 7 deletions(-)

Please pull.

There are also some race condition fixes for the AMD IOMMU driver
pending, but I wait for more testing feedback from Qian before sending
them your way, so they are not included here.

Thanks,

	Joerg

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl6uttAACgkQK/BELZcB
GuNcNg/9EEptDzjNdWIh4GD+okAC+zWIMeWezt2Te8ytNx/r7zOS1Ye3VqgYq8GS
TavgT+a5hIeaxo2qTLRj7ZNrxVGcB7vshQBwXqBpFg2rYOeo3O+7lhmBeWpGUgBy
6IjyF0WctoUYCkxZPVYjAjoUrSI2ZMzYBpjNKto2EpLFj1f8FAR+Wujcx9l3qWFb
J8G49VIqPhjtHLOGHT1ijmfWaF2MvQmZVpYRsGkRqlaWc//iOrHKc+ONLTApmatP
ZqnqDTqeQNBSEbP0K4G2WZ4N8D3vdBjVrDRb4jQaPpmunK2WHXnSgv/VJy1IyqUT
P4jicSh0vr5YKbkrAeGEj11RLKyji8jrHV2yWBIH8TtHNLagJeyIK5KkNqk+Qz02
g+fUjjiS0Whvxc4zT2r+I+j3MvARZbY2sXRG/3WOUOna6D9HGKLVdQs/7ezDQKES
2LrYSx3G9omTIdwCugJ2jvItokXuryN6wLL87EpnK5iipKWtYnXKoG8Quq/VgJ3+
VI2mvqx4nspJ/ENj22DU++bbNO9KhTKgzrOeOgO8eE8QyUK382MGn5/ehBddK0yD
xnBbTtjEvQPFbAA2rEUrTyZszBE0BhHxQxwNEhmFBVE5CR10BHUseeWdW8HVUI7r
ZdTpE2CMZxR6tM3+hswWH6d5Vg5IeQbz8Amc4CN8DLYU8xQb8wo=
=cYaI
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

--===============7936194127449063791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7936194127449063791==--
