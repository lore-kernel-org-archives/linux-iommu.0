Return-Path: <SRS0=PBOI=OA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A36BC433F5
	for <iommu@archiver.kernel.org>; Fri, 10 Sep 2021 15:48:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB57611EF
	for <iommu@archiver.kernel.org>; Fri, 10 Sep 2021 15:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEB57611EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B708A40204;
	Fri, 10 Sep 2021 15:48:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id com-bLw7gR3K; Fri, 10 Sep 2021 15:48:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D730D40169;
	Fri, 10 Sep 2021 15:48:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96EC4C0011;
	Fri, 10 Sep 2021 15:48:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C413BC000D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 15:48:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A01D960BBC
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 15:48:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I8q240-_kNTh for <iommu@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 15:48:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D349660B66
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 15:48:25 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 752D560F; Fri, 10 Sep 2021 17:48:22 +0200 (CEST)
Date: Fri, 10 Sep 2021 17:48:20 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.15-rc0
Message-ID: <YTt+RAMfjZdchT8W@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============7635001770574991486=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7635001770574991486==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TdAk1chTf7oioDPJ"
Content-Disposition: inline


--TdAk1chTf7oioDPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit d8768d7eb9c21ef928adb93402d9348bcc4a6915:

  Merge branches 'apple/dart', 'arm/smmu', 'iommu/fixes', 'x86/amd', 'x86/vt-d' and 'core' into next (2021-08-20 17:14:35 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.15-rc0

for you to fetch changes up to 8cc633190b524c678b740c87fa1fc37447151a6b:

  iommu: Clarify default domain Kconfig (2021-09-09 13:18:07 +0200)

----------------------------------------------------------------
IOMMU Fixes for v5.15-rc1

Including:

	- Intel VT-d:
	  - PASID leakage in intel_svm_unbind_mm();
	  - Deadlock in intel_svm_drain_prq().

	- AMD IOMMU: Fixes for an unhandled page-fault bug when AVIC is used
	  for a KVM guest.

	- Make CONFIG_IOMMU_DEFAULT_DMA_LAZY architecture instead of IOMMU
	  driver dependent

----------------------------------------------------------------
Fenghua Yu (2):
      iommu/vt-d: Fix PASID leak in intel_svm_unbind_mm()
      iommu/vt-d: Fix a deadlock in intel_svm_drain_prq()

Robin Murphy (1):
      iommu: Clarify default domain Kconfig

Suravee Suthikulpanit (1):
      iommu/amd: Remove iommu_init_ga()

Wei Huang (1):
      iommu/amd: Relocate GAMSup check to early_enable_iommus

 drivers/iommu/Kconfig     |  2 +-
 drivers/iommu/amd/init.c  | 48 +++++++++++++++++++++++++++--------------------
 drivers/iommu/intel/svm.c | 15 ++++++++++++---
 3 files changed, 41 insertions(+), 24 deletions(-)

Please pull.

Thanks,

	Joerg

--TdAk1chTf7oioDPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmE7fkQACgkQK/BELZcB
GuNuvw/9HyW+VBCwaO7b6xV3fk6H6/BeAjAseKZdqy7YnszL6jIgVe96bb6u0bHT
xKRF4fuDwRncSNUMAUItEW3jBXeTnThVrGsttr2YILKPZ5vXC7hDKNIpV09NU4cP
+kJ+m9GVx7xCDVjDIDAspQyHO+Hb8Dnv5hEH1jh67vOxMyQ8poE77c2wqxAPKz54
Y3g92f9X/lAOq7KNXI5gL4p3u9wtsfEhPVakNUj1goxSy3gR78cDKxPSg0qBLtNa
ciG7N6FG9nQDG5Q/y3h9yEcFzY1+HllEG2cHoJdUnc79qUcMFPOBggPaDh8VGlwp
FD2OvKXnUhXqbknFhfsVlmHsn7XBjAc2E/Pj+/u/Pcxuofdr7VD3CL4b6Pbf06lL
KLbgC44+HfJT4blGcHM2rxogxv3GclOkyFIC8OD9/iPIqt+46Zy9zsHh2vW3gk43
gTpbsjMHtjslU4S+i1YmLLfUqQkPVCq6p622jCLTucw4hpJO19I5CsL+7BJZzVyU
E7caA+qKU9b10feJ22fUUDjkKl41YBxAG6xB81czdVYrBy/Dfd1e7vFi09nOZtUW
YXnQRE20Jy0P55ywQU2Xj8CoJjoKSQBTeotIKaI80/dvKhRqZ1vT7tA3YlPgcBEE
TdVOVpRhOxazGHprXZjS4Iv744aiJtWWk7XwTqIb0mgipNB68vI=
=s/pY
-----END PGP SIGNATURE-----

--TdAk1chTf7oioDPJ--

--===============7635001770574991486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7635001770574991486==--
