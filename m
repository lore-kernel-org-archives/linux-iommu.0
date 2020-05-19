Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6403C433DF
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 09:19:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B09206D4
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 09:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="L9XA01kP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YnnKw8Wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B09206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3DCCB204E8;
	Tue, 19 May 2020 09:19:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wg5fcJ19J3oV; Tue, 19 May 2020 09:19:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B090A20348;
	Tue, 19 May 2020 09:19:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E83FC0881;
	Tue, 19 May 2020 09:19:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77603C0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 09:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 58DA786160
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 09:19:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fzXcQ_VFitSg for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 09:19:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DF07B860F8
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 09:19:11 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 9A9315C014D;
 Tue, 19 May 2020 05:19:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 19 May 2020 05:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=RjzoA5kxlUIi7c22hbhNakxq1i/
 NbiM1nWgOxKJ79PU=; b=L9XA01kPY5Bz457PeQ68LrOZf3JTP6TCPJRTBQsayR1
 MxW3vC7o0wYvTY2SBMf350kgIS9VSTAKKuc3f9PFrEDrhdsnoLEt84ChDp8c62W2
 2to8A7cxDTcoJ59SoAQhOvhVVV3PtcTHRu/YNidC+WvykbtV3SS64nhPIAy26/rl
 0lXPAwdYFyCVY31IisIvVVQfuSliVDVnowdCzHx+u6e/ceoOsYWZYYn9OfLG/bvu
 6UKeQeiigDGRfwZSYIgeGnJoK2jBlqUdiNpegeXuLvIkIO0Td1IZlm6aOrIIhjBj
 I4bNhsjxR81qD72a0F3lftECHlZkrofkfpPENYlzCNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=RjzoA5
 kxlUIi7c22hbhNakxq1i/NbiM1nWgOxKJ79PU=; b=YnnKw8WqySzv8EpKdOJQhn
 S4BZ6dMvtgN4O3CWC6cMkAZYvP8sN5ExD2+6NeG/gPB4LE1cjLvsqnscphQqZrNT
 WjGNRZkgeiX8LwvBxQcWTmtHMBnrCPbWNl/20nzus5PwlylMkfvqZY9AMCuyNell
 ZqICMmlqSKckt+6gs8LqY4Y9CkQpTdE19ZN95WBnM5aRsmAqk9EmKBvhlbpK0E+t
 bhowuU0rM8dTMLv77e+tqdRW1WxXjArGbE1Gv4EPTdyiWSreHxzT0ZEnWoEfywLG
 qs3tUOPhtAJCKxeNrb03/u1EFqFlwgnLt+ffbm0fJEvQhh4EVC7B7YJQsDf/rZFA
 ==
X-ME-Sender: <xms:jaTDXhX74D2PtSH6Ed-MSz404V5g_hOOrfPFkqcwyA0_iGToAKra_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddtjedgudegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
 htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
 gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
 frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:jaTDXhnisW_NY6g49Qwn0g2aV7aX08-pazdtmo77QzEDcTOMzASBNQ>
 <xmx:jaTDXtYSTHSlhuHoyuZpAyGP-ezIycnM4206cFt8LKTMzxK9ePKAMQ>
 <xmx:jaTDXkW1exOZHihzsbKK1UPGxxRc43yqGzQl8m01CiEwKDYjyNPGTg>
 <xmx:jqTDXmszpfbNE2BXbgDvDRnLjJXx1TeXPLyut1BYimM2fbQ920A5ZQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 12776306642F;
 Tue, 19 May 2020 05:19:08 -0400 (EDT)
Date: Tue, 19 May 2020 11:19:07 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Wei Yongjun <weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] iommu/sun50i: Fix return value check in
 sun50i_iommu_probe()
Message-ID: <20200519091907.ulpo7mu5fsfqszcf@gilmour.lan>
References: <20200519091857.134170-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200519091857.134170-1-weiyongjun1@huawei.com>
Cc: kernel-janitors@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
 iommu@lists.linux-foundation.org, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============9149748428320861261=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============9149748428320861261==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="74zdazyhkrmz3gaa"
Content-Disposition: inline


--74zdazyhkrmz3gaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 09:18:57AM +0000, Wei Yongjun wrote:
> In case of error, the function devm_platform_ioremap_resource() returns
> ERR_PTR() not NULL. The NULL test in the return value check must be
> replaced with IS_ERR().
>=20
> Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--74zdazyhkrmz3gaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXsOkiwAKCRDj7w1vZxhR
xVpwAP0TCPZzgy5kSKkqW1DtDNUXKg/Gg5CGSNLmLbi8KqlKGwD/XOjsUH9OEO/s
GMvet9K0RJJNvGd7XgptJpN3LKyLpA4=
=lJPX
-----END PGP SIGNATURE-----

--74zdazyhkrmz3gaa--

--===============9149748428320861261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============9149748428320861261==--
