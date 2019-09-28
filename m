Return-Path: <SRS0=jma8=XX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8642C4360C
	for <iommu@archiver.kernel.org>; Sat, 28 Sep 2019 19:10:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5C52082F
	for <iommu@archiver.kernel.org>; Sat, 28 Sep 2019 19:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5C52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2B9DEE20;
	Sat, 28 Sep 2019 19:10:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9C0ACDCA
	for <iommu@lists.linux-foundation.org>;
	Sat, 28 Sep 2019 19:10:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4AAE38B5
	for <iommu@lists.linux-foundation.org>;
	Sat, 28 Sep 2019 19:10:21 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id BFF26342; Sat, 28 Sep 2019 21:10:18 +0200 (CEST)
Date: Sat, 28 Sep 2019 21:10:17 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.4-rc1
Message-ID: <20190928191007.GA7565@8bytes.org>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: multipart/mixed; boundary="===============7841742657590613614=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============7841742657590613614==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit e95adb9add75affb98570a518c902f50e5fcce1b:

  Merge branches 'arm/omap', 'arm/exynos', 'arm/smmu', 'arm/mediatek', 'arm/qcom', 'arm/renesas', 'x86/amd', 'x86/vt-d' and 'core' into next (2019-09-11 12:39:19 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-5.4-rc1

for you to fetch changes up to 2a78f9962565e53b78363eaf516eb052009e8020:

  iommu/amd: Lock code paths traversing protection_domain->dev_list (2019-09-28 14:44:13 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.4-rc1

A couple of fixes for the AMD IOMMU driver have piled up:

	* Some fixes for the reworked IO page-table which caused memory
	  leaks or did not allow to downgrade mappings under some
	  conditions.

	* Locking fixes to fix a couple of possible races around
	  accessing 'struct protection_domain'. The races got introduced
	  when the dma-ops path became lock-less in the fast-path.

----------------------------------------------------------------
Andrei Dulea (4):
      iommu/amd: Fix pages leak in free_pagetable()
      iommu/amd: Fix downgrading default page-sizes in alloc_pte()
      iommu/amd: Introduce first_pte_l7() helper
      iommu/amd: Unmap all L7 PTEs when downgrading page-sizes

Filippo Sironi (1):
      iommu/amd: Wait for completion of IOTLB flush in attach_device

Joerg Roedel (6):
      iommu/amd: Remove domain->updated
      iommu/amd: Remove amd_iommu_devtable_lock
      iommu/amd: Take domain->lock for complete attach/detach path
      iommu/amd: Check for busy devices earlier in attach_device()
      iommu/amd: Lock dev_data in attach/detach code paths
      iommu/amd: Lock code paths traversing protection_domain->dev_list

 drivers/iommu/amd_iommu.c       | 229 ++++++++++++++++++++++++----------------
 drivers/iommu/amd_iommu_types.h |   4 +-
 2 files changed, 139 insertions(+), 94 deletions(-)

Please pull.

Thanks,

	Joerg

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl2PsA8ACgkQK/BELZcB
GuO23hAA3ywhr5/cgbIu7M8wV+zAeqx0i0R6qkG7Imzh98HfCMtFGnkcl97tKM+k
ojIM1ITKJZhM+C96dkNVMdp7V5jcqA6RS4+9q1HcchU47Krb1I8050zxf9lp4Nhy
3GCTzC1waEhhrc39tBNJNkdz+KiZUm4WvMlYbjieD9KxH0Ny/zTWnVDiiW9Fq98c
rXJhWv+OwQ6Z/clSNQIUS87mTGymro/5VBc2IEh61N82YgOzmlDA2tgMNOKIFVV7
eQsAf2E/jGyNLR2zumceDB+p/0GXWNoz+imUXHJIRWDWcjL+W5+0GamPZ9YwFF+r
Lu3+bI4JSCkpUo0UbEwFe7l7Aw0KEMoyXHmySfuZ0sZ2ysMY5Xkx/InklX2kpHbk
NjfAiPbMn+AHuyDxj/9YkpApV7Q+WCEhvHapBKLmKBbYiRn7nz0N7hX3CaJqmeo1
Hi7La6y3NIAT95nyhkzU4tgklH1wMW3nzpwx2BXdYjcsy/Pe63C9IgPIxcCuq1cC
1W6A9YpYrV44sPl82V3u1SGoxM9KpWNx9uumSXBqzOJ8aj5luCoCYJVRHZgut+bm
R45JVVpHs4oIdeJSGC/wsCVwSDMyHf/dPd0+dz5nUnbGnCaKKxeZX5u618lU5gCJ
45zXdBAsUKafcU7d/ge6ZdlWmW1Q0oHRRPziuQq9isZ1JZansTA=
=ftDq
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

--===============7841742657590613614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7841742657590613614==--
