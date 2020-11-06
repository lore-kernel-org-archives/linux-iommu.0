Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C3CC2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 16:23:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2859E21556
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 16:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2859E21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A5230860F6;
	Fri,  6 Nov 2020 16:23:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QzRCGmoDAXAz; Fri,  6 Nov 2020 16:23:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 86335860F9;
	Fri,  6 Nov 2020 16:23:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67E32C0893;
	Fri,  6 Nov 2020 16:23:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A1FAC0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 16:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2082A86760
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 16:23:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8ErHVeczKP2d for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 16:23:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A7D7586741
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 16:23:12 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id AAB4B3D3; Fri,  6 Nov 2020 17:23:09 +0100 (CET)
Date: Fri, 6 Nov 2020 17:23:08 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.10-rc2
Message-ID: <20201106162302.GA3084@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============4537827240642319189=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4537827240642319189==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.10-rc2

for you to fetch changes up to 4dd6ce478003525df8618750d30f0b90380047a7:

  iommu: Fix a check in iommu_check_bind_data() (2020-11-03 14:55:51 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.10-rc2

Including:

	- Fix a NULL-ptr dereference in the Intel VT-d driver

	- Two fixes for Intel SVM support

	- Increase IRQ remapping table size in the AMD IOMMU driver. The
	  old number of 128 turned out to be too low for some recent
	  devices.

	- Fix a mask check in generic IOMMU code

----------------------------------------------------------------
Dan Carpenter (1):
      iommu: Fix a check in iommu_check_bind_data()

Liu Yi L (1):
      iommu/vt-d: Fix sid not set issue in intel_svm_bind_gpasid()

Liu, Yi L (1):
      iommu/vt-d: Fix a bug for PDP check in prq_event_thread

Lu Baolu (1):
      iommu/vt-d: Fix kernel NULL pointer dereference in find_domain()

Suravee Suthikulpanit (1):
      iommu/amd: Increase interrupt remapping table limit to 512 entries

 drivers/iommu/amd/amd_iommu_types.h | 6 +++++-
 drivers/iommu/intel/iommu.c         | 3 +++
 drivers/iommu/intel/svm.c           | 8 +++++++-
 drivers/iommu/iommu.c               | 2 +-
 4 files changed, 16 insertions(+), 3 deletions(-)

Please pull.

Thanks,

	Joerg

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl+leGYACgkQK/BELZcB
GuMk+g/8D/ZGF3MByeEcWyYydC+51XpLLS+g9uf9tSFIXJUhCJYfCN4m8RMP4I2h
IErgzsuLKMI6Jbn6qziYk+7VBRmUFKQsQ74vg+WgQkrhjn9dAFm+pE/ffRnF//fp
NAZe/Q310ovw4TohUaZhBrQWtRIu47zSw9sc1zbvvU2yeOfQFCuiCA3YxaLprU4/
Mi/Wc3RVJCTs7zbcmMg1V3bkuER+cOOkvZgIW38vcHBh4ykoSmuovGQT/uOHEege
9dYUv4Kalpl0d2fiwQhKgTE9Vlfm0FAofAl4JVkbCIylIP9kvVHyk6ys/ZQ0A1fg
pFke9xLLE8ihj/nI7I4mL6D43/mKEVQkkInHpX8ApVT0pX7tQsQ8oG/18kHsbMUo
V9rOoliSfqjAMhL8G+UyAJ7gyFHosEdZQ39irmEIsPYDgqETNyqCQZlh+DMg41+2
CjtRq3lGTK/63M1fmOAGhXhQh/XmJGyX89NXdN1A/miFloRyG9W+4Z6XDWU4+Kt+
dmBgEf/gL565J3jca/vNEXmqw3tx5h+1SA3KDHIvziKEHz1XsGrz8pLYVf7AOxMb
RLDIbTnHJUotpyrmy8M8+TNmXIQp9060fxMSzg4KP8/LJFuV9XkJqaoAhtSQbUlS
63b2OU7c/k/TsOynKcqL2uTlp4ie7HH3ZXSPmOyaSBjs/26ogkc=
=gPl6
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

--===============4537827240642319189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4537827240642319189==--
