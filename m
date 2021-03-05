Return-Path: <SRS0=uIbQ=ID=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301A3C433E9
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 16:23:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3C464D96
	for <iommu@archiver.kernel.org>; Fri,  5 Mar 2021 16:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3C464D96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E48E06F480;
	Fri,  5 Mar 2021 16:23:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qnrlYEYHK8I9; Fri,  5 Mar 2021 16:23:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBF0F6ED1C;
	Fri,  5 Mar 2021 16:23:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9303EC000B;
	Fri,  5 Mar 2021 16:23:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81592C0001
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 16:23:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B8C94ED2F
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 16:23:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QwSkilD23KLA for <iommu@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 16:23:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA8654ED2C
 for <iommu@lists.linux-foundation.org>; Fri,  5 Mar 2021 16:23:29 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id CEDC947C; Fri,  5 Mar 2021 17:23:25 +0100 (CET)
Date: Fri, 5 Mar 2021 17:23:24 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux iommu-updates-v5.12
Message-ID: <20210305162319.GA14489@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============1748282185008780536=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1748282185008780536==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 45e606f2726926b04094e1c9bf809bca4884c57f:

  Merge branches 'arm/renesas', 'arm/smmu', 'x86/amd', 'x86/vt-d' and 'core' into next (2021-02-12 15:27:17 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.12-rc1

for you to fetch changes up to 444d66a23c1f1e4c4d12aed4812681d0ad835d60:

  iommu/vt-d: Fix status code for Allocate/Free PASID command (2021-03-04 13:32:04 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.12-rc1

Including:

	- Fix for a sleeping-while-atomic issue in the AMD IOMMU code

	- Disabling lazy IOTLB flush for untrusted devices in the Intel VT-d driver

	- Fix status code definitions for Intel VT-d

	- Fix IO Page Fault issue in Tegra IOMMU driver

----------------------------------------------------------------
Andrey Ryabinin (1):
      iommu/amd: Fix sleeping in atomic in increase_address_space()

Lu Baolu (1):
      iommu: Don't use lazy flush for untrusted device

Nicolin Chen (1):
      iommu/tegra-smmu: Fix mc errors on tegra124-nyan

Zenghui Yu (1):
      iommu/vt-d: Fix status code for Allocate/Free PASID command

 drivers/iommu/amd/io_pgtable.c | 10 +++---
 drivers/iommu/dma-iommu.c      | 15 +++++----
 drivers/iommu/intel/pasid.h    |  4 +--
 drivers/iommu/tegra-smmu.c     | 72 +++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 87 insertions(+), 14 deletions(-)

Please pull.

Thanks,

	Joerg

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmBCWvYACgkQK/BELZcB
GuNZ7Q/+KqbPG4VldrL3+whXokC0q+DaLATCaWJln2vjzUEqoJEf5T1YbEki+GzJ
T4hzfEjjQgqX4NyZY2dXELkbuclkeZJKXxTb72Dcnsqf8y8xo33PHVw0B10nE5mR
qi3SNrETGtykcx5hJKMZnHVVm7hJGRlTwKtzKKV4Rfl0TQnQ2IibqmDexeoUWXlz
tNK48glmGs3wcfjdRlPABCEFTqQoODllaZ9rgCiQMqegPR4dVyEFhhOJ3ATgAcCt
OYDnXyoUcdhWhmTCYosQlAlrRQ5X0VZ7voRMoAv2ZTHTjRvmvwIIPAnV5M6w3CtW
iGPzN7JwEULwPUgJajcj8Qda/kR41K1fXUdJO+LLKAnekU1W6xfCIsJRNAIcU2IB
2qZuJdcnZhkh4TN8UoQdQLZvT1YEshKpT7FdcY0LyDIsdp8KcHIeNfjx5crYC6IT
5uvlRfEV3vkqm2sZO+qAtxCxM9iRKkkWUCC1IqSLzQ2Dri+5b02fKkEqd5hIgn5I
qZOem3Sb29gpjcoKCV8tdgiiXeZ302rFB+Xkvl3VF4jb5DlwHkuTSkWM47dlD/L9
9WZSQzPWi09NWahHulPQEpYueppEhlJlzu9XXWoRWNSO6O80y3ROyx/Ag5t2gzYb
ILuS47fCLwUD8518MAVXD4MrhMzL4pbYVyvLVBykOnZKFztRoAo=
=UIv1
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

--===============1748282185008780536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1748282185008780536==--
