Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED64CC7618B
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 09:20:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB4422BEF
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 09:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB4422BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8721BE24;
	Fri, 26 Jul 2019 09:20:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B660DE20
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 09:20:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1AEDF8A0
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 09:20:57 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id D3E5D284; Fri, 26 Jul 2019 11:20:54 +0200 (CEST)
Date: Fri, 26 Jul 2019 11:20:53 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.3-rc1
Message-ID: <20190726092048.GA3957@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============4556154366666736947=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============4556154366666736947==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.3-rc1

for you to fetch changes up to 66929812955bbec808c94d7a3916f41638a98a0a:

  iommu/amd: Add support for X2APIC IOMMU interrupts (2019-07-23 17:41:52 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.3-rc1

Including:

	- Revert an Intel VT-d patch that caused boot problems on some
	  machines

	- Fix AMD IOMMU interrupts with x2apic enabled

	- Fix a potential crash when Intel VT-d domain allocation fails

	- Fix crash in Intel VT-d driver when accessing a domain without
	  a flush queue

	- Formatting fix for new Intel VT-d debugfs code

	- Fix for use-after-free bug in IOVA code

	- Fix for a NULL-pointer dereference in Intel VT-d driver when
	  PCI hotplug is used

	- Compilation fix for one of the previous fixes

----------------------------------------------------------------
Chris Wilson (1):
      iommu/iova: Remove stale cached32_node

Dmitry Safonov (2):
      iommu/vt-d: Don't queue_iova() if there is no flush queue
      iommu/vt-d: Check if domain->pgd was allocated

Joerg Roedel (2):
      Revert "iommu/vt-d: Consolidate domain_init() to avoid duplication"
      iommu/iova: Fix compilation error with !CONFIG_IOMMU_IOVA

Lu Baolu (1):
      iommu/vt-d: Avoid duplicated pci dma alias consideration

Sai Praneeth Prakhya (1):
      iommu/vt-d: Print pasid table entries MSB to LSB in debugfs

Suthikulpanit, Suravee (1):
      iommu/amd: Add support for X2APIC IOMMU interrupts

 drivers/iommu/amd_iommu_init.c      |  90 +++++++++++++++++
 drivers/iommu/amd_iommu_types.h     |   9 ++
 drivers/iommu/intel-iommu-debugfs.c |   4 +-
 drivers/iommu/intel-iommu.c         | 189 ++++++++++++++++++------------------
 drivers/iommu/iova.c                |  23 +++--
 include/linux/iova.h                |   6 ++
 6 files changed, 220 insertions(+), 101 deletions(-)

Please pull.

Thanks,

	Joerg

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl06xe8ACgkQK/BELZcB
GuN9rRAApQnbSOnNQGGaB7lVEIquMXgk28hAf/IHYIss8lPtxJDxDgZhgKyAxsLC
/Qn9dvZ1HHvZvvs7FMxWRYcdTmKSijlDUSjd50pOOyDFhIcycXvLWuP9hvP8xOLT
Rl3niH2QcSXN5c08oAcuwISwvn1t96bezVz+2vgAXqkYiJsg1avVnDwkJrAMmU1P
RPG2ZiYu39EAxnU0tUY+wUb9xebCwcCGoag3iV/lZ0QqffEwqBJkfUPO1SEKEuxr
gOfCxHQVhAqB/wRqr/5NOrQWXW+Lf0NPcFAU3atd6FVh3xG8MNUQmvd/kFNPj/Jn
//+1mtT6N4TuBdbSAiRUOdCZxPhfygnhL6MyO+th+e3lWjOlOmKp+vy3gW5OyGEG
zJpA8280Itz5Yz+ZrbDQZkJXrxvIkIccwjnDbf4jEVxgN8Vn+R2e0D3TckhzOnl7
yXAO3IFR1obEINpDplV5C+B8m7mNOryj6/RGqCujs8+XwklaHmZu6cBa61R25jZ6
oBzQEp/EG3Ymv84x9UWIr57zqXAiepfE5kxGP+d4KAa5bjK8M1gTdPbRi4o74V0j
xoKL7MgEmhCuqWEHgmkgQSZSJHFKK73gEz1DWs9048wjTkPsAJetKf38n8rsgxBB
Fz9dUuC1zb5qajpv4N0Fwr16OVjHFrJGxJq6UKoJXZOVpdZjZlM=
=uh7j
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

--===============4556154366666736947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4556154366666736947==--
