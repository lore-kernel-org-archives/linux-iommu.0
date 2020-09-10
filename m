Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C42C433E2
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 08:47:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9059D20872
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 08:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="caMPoUSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9059D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EBF84204F0;
	Thu, 10 Sep 2020 08:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mFog4UfWzwW0; Thu, 10 Sep 2020 08:47:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7345E204C3;
	Thu, 10 Sep 2020 08:47:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5712FC0859;
	Thu, 10 Sep 2020 08:47:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D527C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 08:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 221DA204D4
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 08:47:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yRlkoeEPcNwt for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 08:47:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 718BF204C3
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 08:47:49 +0000 (UTC)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0C4F920770;
 Thu, 10 Sep 2020 08:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599727668;
 bh=RPokpgxyglYjppmxdwE4ETpgoWb+FLMn8txdhEbALdk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=caMPoUSKexLI6/Cqhtg8fT99cl3GRCJBgwM+b8CDUH4fpndiULhN2ZxxlePCqMtm8
 o+PPIhKL0Yab4dKBUBJb9PAX9HTFJdHyhq4ZrB98n0hws/gO34J2oo99WhyXQG8LAo
 ih4L+nIDe5nvGNhsdtsxYZAUrexQb+0pD4TKBRdk=
From: Felipe Balbi <balbi@kernel.org>
To: Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>, Jiri
 Kosina <trivial@kernel.org>
Subject: Re: [trivial PATCH] treewide: Convert switch/case fallthrough; to
 break;
In-Reply-To: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
References: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
Date: Thu, 10 Sep 2020 11:47:27 +0300
Message-ID: <878sdikogw.fsf@kernel.org>
MIME-Version: 1.0
Cc: linux-wireless@vger.kernel.org, linux-fbdev@vger.kernel.org,
 oss-drivers@netronome.com, nouveau@lists.freedesktop.org,
 alsa-devel <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org,
 linux-ide@vger.kernel.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org,
 linux-i2c@vger.kernel.org, sparclinux@vger.kernel.org,
 kvmarm@lists.cs.columbia.edu, linux-rtc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, dccp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-afs@lists.infradead.org, coreteam@netfilter.org,
 intel-wired-lan@lists.osuosl.org, linux-serial@vger.kernel.org,
 linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
 Kees Cook <kees.cook@canonical.com>, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-sctp@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-nvme@lists.infradead.org, storagedev@microchip.com,
 ceph-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>, linux-mips@vger.kernel.org,
 iommu@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
 linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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
Content-Type: multipart/mixed; boundary="===============0402141615107184235=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============0402141615107184235==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Joe Perches <joe@perches.com> writes:
>  drivers/usb/dwc3/core.c                                   |  2 +-
>  drivers/usb/gadget/legacy/inode.c                         |  2 +-
>  drivers/usb/gadget/udc/pxa25x_udc.c                       |  4 ++--
>  drivers/usb/phy/phy-fsl-usb.c                             |  2 +-

for the drivers above:

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9Z6B8RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZSCRAAuTv1hrqhd9iVfnwXFrfx8dYquoCMc3VI
y1IiULV6avnZvLQTqKviHDvZw05WY6dna714mpLFW1laW3WuhLSD4elIu6cqHaiz
ZgtvtA4bZ/s7ipV+jlZ86S9oIz4MMBbZYhqSN1ZVk50NsUA/1thpcjS0aLI5SAgX
j2dV6BEEHBSgMDwcWLPNwr6f5R/ycEBx3i6HYSSdNtBr1SK+UhbSkwNxdCA9IzH8
1WCugmJdohP26DIYNzFZcssjcSFb5wu2iuHXQXuvOmmAfQmro+gRcnq1SOElae7v
cas67L69RQ5fxskM/XpIYH2AURFnRUNondcJWViUQXHwXF1U0r+FdwXUr8OeFi19
sVEI4FNu7ZqgvhfUlKMpldyUZRIrWb+WZZ5toBQAKFee/3tqTs4Tqh9cwfLL9IU4
ho4tG7J/bd6hASfr0x2dH5Pm7oXKskxmtUpmmSVlNaTpXytiD30+pUvOl9Qg7A+X
tc9h6N3Z6kdVxkJlm1KpUUccPeUtHox549ukAtzKQL4x6PDCdNqBkNDVSIx04FA4
dgyt4O7w4HaWT1GPHH322pG5nNT1dsGT0CC9QA/2AJkoXTY03YGR3dgDw89GNUrP
WPj73gtBbWTwRFuwHQQs8F/E8x2UjBC005aawoKcK2bxBR1fzqz1y8daUaiCftnV
ocu1QwRIgL8=
=BFTp
-----END PGP SIGNATURE-----
--=-=-=--

--===============0402141615107184235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0402141615107184235==--
