Return-Path: <SRS0=hcXW=7Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A868C433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Jun 2020 15:22:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A01206A4
	for <iommu@archiver.kernel.org>; Fri, 12 Jun 2020 15:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A01206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8FECA87587;
	Fri, 12 Jun 2020 15:22:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iRo4vxFS2x0p; Fri, 12 Jun 2020 15:22:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8A7E887567;
	Fri, 12 Jun 2020 15:22:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 693F2C0178;
	Fri, 12 Jun 2020 15:22:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E69FC016F
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 15:22:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 484CC2046A
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 15:22:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uPoBTVemVtXS for <iommu@lists.linux-foundation.org>;
 Fri, 12 Jun 2020 15:22:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 7CD9520012
 for <iommu@lists.linux-foundation.org>; Fri, 12 Jun 2020 15:22:15 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 0F1EC3A2; Fri, 12 Jun 2020 17:22:11 +0200 (CEST)
Date: Fri, 12 Jun 2020 17:22:10 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] iommu: Move Intel and AMD drivers to a subdirectory
Message-ID: <20200612152205.GA18833@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============3064540482574686039=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3064540482574686039==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

I am not sure it is the right time to send this. The patches below have
not been part of the IOMMU updates for v5.8, in the AMD case because it
made the merge conflicts even worse, and in the Intel case because it
was not done yet.

It would be good to have both drivers moved in v5.8-rc1, mostly because
it avoids conflicts between fixes and v5.9 updates later in the cycle.
But it is also no problem to defer these changes, I can put them again
into the IOMMU tree and the end of the v5.8 cycle when you feel this
should have been ready earlier. With that said:

The following changes since commit 431275afdc7155415254aef4bd3816a1b8a2ead0:

  iommu: Check for deferred attach in iommu_group_do_dma_attach() (2020-06-04 11:38:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-drivers-move-v5.8

for you to fetch changes up to 672cf6df9b8a3a6d70a6a5c30397f76fa40d3178:

  iommu/vt-d: Move Intel IOMMU driver into subdirectory (2020-06-10 17:46:43 +0200)

----------------------------------------------------------------
IOMMU drivers directory structure cleanup:

	- Move the Intel and AMD IOMMU drivers into their own
	  subdirectory. Both drivers consist of several files by now and
	  giving them their own directory unclutters the IOMMU top-level
	  directory a bit.

----------------------------------------------------------------
Joerg Roedel (2):
      iommu/amd: Move AMD IOMMU driver into subdirectory
      iommu/vt-d: Move Intel IOMMU driver into subdirectory

 MAINTAINERS                                            |  5 ++---
 drivers/iommu/Makefile                                 | 18 +++++++++---------
 drivers/iommu/{ => amd}/amd_iommu.h                    |  0
 drivers/iommu/{ => amd}/amd_iommu_types.h              |  0
 drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c}   |  0
 drivers/iommu/{amd_iommu_init.c => amd/init.c}         |  2 +-
 drivers/iommu/{amd_iommu.c => amd/iommu.c}             |  2 +-
 drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c}       |  0
 drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c}     |  0
 .../iommu/{intel-iommu-debugfs.c => intel/debugfs.c}   |  0
 drivers/iommu/{ => intel}/dmar.c                       |  2 +-
 drivers/iommu/{ => intel}/intel-pasid.h                |  0
 drivers/iommu/{intel-iommu.c => intel/iommu.c}         |  2 +-
 .../{intel_irq_remapping.c => intel/irq_remapping.c}   |  2 +-
 drivers/iommu/{intel-pasid.c => intel/pasid.c}         |  0
 drivers/iommu/{intel-svm.c => intel/svm.c}             |  0
 drivers/iommu/{intel-trace.c => intel/trace.c}         |  0
 17 files changed, 16 insertions(+), 17 deletions(-)
 rename drivers/iommu/{ => amd}/amd_iommu.h (100%)
 rename drivers/iommu/{ => amd}/amd_iommu_types.h (100%)
 rename drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} (100%)
 rename drivers/iommu/{amd_iommu_init.c => amd/init.c} (99%)
 rename drivers/iommu/{amd_iommu.c => amd/iommu.c} (99%)
 rename drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c} (100%)
 rename drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c} (100%)
 rename drivers/iommu/{intel-iommu-debugfs.c => intel/debugfs.c} (100%)
 rename drivers/iommu/{ => intel}/dmar.c (99%)
 rename drivers/iommu/{ => intel}/intel-pasid.h (100%)
 rename drivers/iommu/{intel-iommu.c => intel/iommu.c} (99%)
 rename drivers/iommu/{intel_irq_remapping.c => intel/irq_remapping.c} (99%)
 rename drivers/iommu/{intel-pasid.c => intel/pasid.c} (100%)
 rename drivers/iommu/{intel-svm.c => intel/svm.c} (100%)
 rename drivers/iommu/{intel-trace.c => intel/trace.c} (100%)

Please pull.

Thanks,

	Joerg

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl7jnZkACgkQK/BELZcB
GuMCwRAAnfsSfW4OvKQ8lSOp2CfpXDKojX9nZ+pUuKjngIb/VKATSWuoEK6bSYJy
yAvu6itq2ftA4oQe5htoX4x5NpFJc8Yu7NOlMLCPkDa0s+ylqac7R+YZONgBnTCJ
LM9Am/UAxFvY9AJCFyKOqlOfHy6sYhzWSUTXlZk+WvXWznaNhec5rUFIOCgdbPAt
shPcTA39ilxOhyz/APN3DyP3SHah5odG+MO9Q5u40BzFl4M5pR80q0lCb0I29ejk
+llm/jbhnkE0E6W+SqvZkJoHdsnmnnoG2pQDhY1APmGXlhuJhsQGCHR+K3e6r+Hz
rYdyhiNVu7nXZ+yj/5tW+IemHMVayyGrsybe1L8RgoAMF12FyLcpTECQWgp6ceI4
hDtF1zmT5yQMTCZUI3W5V/ByfizTvhs4Y5H3gvc9ISvwzVD4vSZ9Eb6xnqypegi+
PRh1kOFUdEJTgAGOkIC4jVJwvs6NbO05eGOL4xpKd4jACrWUUNv0MYOry/+Q9Ot4
n4DMKuT4ML3mF/YZ3zilp2MrSzvXSoTMVfdrIEpXeSgHDBbp8ribOWQKYh8wsqLn
/Lox1b1AuqZGd1fGCjaKEoGDAx6djTcAVzVyMhpp98qEQDLO5X0CQnISf7v/C6+1
0oheyGvH2I89ui7VseYf8CMiJyAUWWNQ4ieKg8mDmLJpW9rvYPM=
=rI59
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

--===============3064540482574686039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3064540482574686039==--
