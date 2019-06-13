Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8FEC31E49
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 19:36:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24EA52147A
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 19:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EA52147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F3D341591;
	Thu, 13 Jun 2019 19:36:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6F2121589
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 19:36:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from pokefinder.org (sauhun.de [88.99.104.3])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id CD82A711
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 19:36:30 +0000 (UTC)
Received: from localhost (p5486CF99.dip0.t-ipconnect.de [84.134.207.153])
	by pokefinder.org (Postfix) with ESMTPSA id 61EBA4A127B;
	Thu, 13 Jun 2019 21:36:29 +0200 (CEST)
Date: Thu, 13 Jun 2019 21:36:28 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH v6 0/5] treewide: improve R-Car SDHI performance
Message-ID: <20190613193628.GA6863@kunai>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
In-Reply-To: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: axboe@kernel.dk, linux-renesas-soc@vger.kernel.org, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
	wsa+renesas@sang-engineering.com,
	iommu@lists.linux-foundation.org, hch@lst.de
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
Content-Type: multipart/mixed; boundary="===============7359102268517268240=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============7359102268517268240==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 07:20:10PM +0900, Yoshihiro Shimoda wrote:
> This patch series is based on iommu.git / next branch.
>=20
> Since SDHI host internal DMAC of the R-Car Gen3 cannot handle two or
> more segments, the performance rate (especially, eMMC HS400 reading)
> is not good. However, if IOMMU is enabled on the DMAC, since IOMMU will
> map multiple scatter gather buffers as one contignous iova, the DMAC can
> handle the iova as well and then the performance rate is possible to
> improve. In fact, I have measured the performance by using bonnie++,
> "Sequential Input - block" rate was improved on r8a7795.
>=20
> To achieve this, this patch series modifies IOMMU and Block subsystem
> at first. Since I'd like to get any feedback from each subsystem whether
> this way is acceptable for upstream, I submit it to treewide with RFC.
>=20
> Changes from v5:
>  - Almost all patches are new code.
>  - [4/5 for MMC] This is a refactor patch so that I don't add any
>    {Tested,Reviewed}-by tags.
>  - [5/5 for MMC] Modify MMC subsystem to use bigger segments instead of
>    the renesas_sdhi driver.
>  - [5/5 for MMC] Use BLK_MAX_SEGMENTS (128) instead of local value
>    SDHI_MAX_SEGS_IN_IOMMU (512). Even if we use BLK_MAX_SEGMENTS,
>    the performance is still good.

Thanks for your hard work, Shimoda-san!

I may not be the biggest DMA, IOMMU, and block layer expert, but I
really like how this simplifies the SDHI driver and enhances the MMC
core. So, I'll add my two cents to the patches although I can't really
comment on the main functionality.


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0CpbgACgkQFA3kzBSg
Kbb6fhAAsdfuCLxXS4xDUphPESkF+gt9xfaK1rX85NT4mPOnCRA7AMdH0rzSAboF
MFBO01ZS1+9P5SOaOuKArFD1rDkk9t41Hp+AEcsyGZMt47QlwvXakNaQeoGVLUuu
9kex9v8bpMgXjDS9B7CFcbWnLvEjEyysBYBVRMpppo1UwfIwKoQFZAzKJkodXGpE
i5HOkl+woaQVUDgNnnKEVbAmSmCJ7H8Nb4CvzRk14i5GK2UYUi9ql9B4Fro4tsgM
dqSlNzb9x/70ajG5EYGv5+E+pA8u3du9hNLzsm7PoFWCUIPa5n74aQC4CpMcjUao
FqPHfzcT3Mg8fk2K7u6riIaQAO7c/sYJ4quv547+cPTyPoAs290HqRZqH413C9wr
hQtNlC2g7j+6hgrkzyoesGKl0zpiPdW3TKQ17tDGoCipGKDwQGptKunqWFbDY90h
UJdgHWAo/kjy+pAGlutoy5bPdEbYYpxgHCgCrOaN0fzV7qKg7N1gfvRCNJSS0U9d
gNzLc4vE+d3a2jPq90LRNxpBoUgB/iuJBIEhZcTycIMjUBrWQ8ikClrFBMHkLEds
slSs6vzgUDcqOBSVQUVAif92fBeOUONnGbwOBx/r6x8LFIpG5h3gw0rRr9mF6Ppo
48Oi8LWLrkZ3ZSjfNyQMaUi4rPwEqULxuhqN7MZIAVUZk3f9L5s=
=tqtY
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

--===============7359102268517268240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7359102268517268240==--
