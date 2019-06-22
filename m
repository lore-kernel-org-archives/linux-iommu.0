Return-Path: <SRS0=H1gU=UV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABC5C43613
	for <iommu@archiver.kernel.org>; Sat, 22 Jun 2019 19:46:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD1DD2070B
	for <iommu@archiver.kernel.org>; Sat, 22 Jun 2019 19:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1DD2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 786F1185F;
	Sat, 22 Jun 2019 19:46:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AB6E8185B
	for <iommu@lists.linux-foundation.org>;
	Sat, 22 Jun 2019 19:46:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2022F224
	for <iommu@lists.linux-foundation.org>;
	Sat, 22 Jun 2019 19:46:50 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id ABB05447; Sat, 22 Jun 2019 21:46:48 +0200 (CEST)
Date: Sat, 22 Jun 2019 21:46:47 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.2-rc5
Message-ID: <20190622194641.GA5200@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============4678237273667261643=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============4678237273667261643==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9e0babf2c06c73cda2c0cd37a1653d823adb40ec:

  Linux 5.2-rc5 (2019-06-16 08:49:45 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.2-rc5

for you to fetch changes up to 0aafc8ae665f89b9031a914f80f5e58825b33021:

  Revert "iommu/vt-d: Fix lock inversion between iommu->lock and device_domain_lock" (2019-06-22 21:19:58 +0200)

----------------------------------------------------------------
IOMMU Fix for v5.2-rc5:

	- Revert a commit from the previous pile of fixes which causes
	  new lockdep splats. It is better to revert it for now and work
	  on a better and more well tested fix.

----------------------------------------------------------------
Peter Xu (1):
      Revert "iommu/vt-d: Fix lock inversion between iommu->lock and device_domain_lock"

 drivers/iommu/intel-iommu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Please pull.

Thanks,

	Joerg

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl0OhaEACgkQK/BELZcB
GuM8VBAAt+hIPpPrnVflwxut+8GGNPi/Rz9E+5ZOj4C23om7iGGk4VZq54KHizLL
cIBs5lR5OR7zcyvo4U9696KnRkj/k1CJaxmtR1u/Sz8gBDsh9UxQ7FsB8KABBWig
mW+q3c0oNU6/UjHlXK27+ylRXNKHniRHZlWdhstVDLTzrt33Z+8dyKJUWk1cQFK0
FzWw9L5gxpV6v2KskNroTJYLIjdIQalOV4JANaB7wtDK4zhkunjoCwAmDxmOY1fS
SaREtIT5F98klnJw5dU177sI0GSaWFShT1aSKIE/+u9KufYX3aCWBCS/onUV3mLL
5zTZSec4T8E5SR99g1yt3lXpneHQTT/14mRhZBSTqBowcneCbFxdKNb93GDO+Ylf
yKtjBzusHGa7fPE/QAP/071rOs0KAKAhiFx3/auxW9opwJC45NdIjUtLWibbcvyA
IBgRXGUyXmn5wW885LIA5Fwsd+hkTLCZxifLltwU7Axlfg/V6t0InOJLxhpRWINo
IPZQSb0WNTCsTRC1Bxs7kt5ZOj/614DcTfVXkY6eH51XHRgznqE8PhiO0O6WXa6w
u3tp/b1/FlyRvgifEZTvQa8bR65gquEzSFfiSrkMjfXofXkTlHw/rJrjCeR+kvS+
eogymxwUEnz/JRVw/tGYIHFrk/lAMiZ9jj00LL5/Fc69fTovKlQ=
=b3zC
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

--===============4678237273667261643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4678237273667261643==--
