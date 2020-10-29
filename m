Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98189C4363A
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 16:10:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C9E2076E
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 16:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C9E2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A1BD387584;
	Thu, 29 Oct 2020 16:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BENA8qn+tz8p; Thu, 29 Oct 2020 16:10:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 34AE887574;
	Thu, 29 Oct 2020 16:10:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01D81C0859;
	Thu, 29 Oct 2020 16:10:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64469C0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 16:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4769683539
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 16:10:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5pmSJqEZtB1t for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 16:10:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2F98880EBD
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 16:09:59 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id D64045C01C0;
 Thu, 29 Oct 2020 12:09:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Thu, 29 Oct 2020 12:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=mWw86KJ+/DMk7mu5JYwNxAokI35
 pTWEol37so2bPwxo=; b=cq2OJxSikgC6fWD6mlcWWkKOY7hURNNmKkneDkyt5sw
 yiw1r8+DYU+d+IZgY2Y+slqJOQ8eY5VyGtEblIFVZ5n12bIfwJfdO+3+Q4Y2sRdD
 RXTcPvFYodXX/CALcsiwozfnHVdnfJ0tjI/KcP1FoZk/U+YIOvwbeXZYCEwOHaB+
 /KGsHdgy/U1tzvQTLYLdFmOW0p7iCjcFXraG6L7XNWwu9ZZN0bcgNo0NIMKLbIWI
 SZsZUNG2d/6VQ0XtWTH7ZktXXCXNdzRLnu634wGkC4Sy3NhdGkGsAu+SGwKWf1mA
 AJR5zuOMHP9SDIYcKwEH2zYKqMe+CXNe8bqD2B/Y3yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mWw86K
 J+/DMk7mu5JYwNxAokI35pTWEol37so2bPwxo=; b=NVyg6MGUlb35jT5ibx3+J8
 I2bpdoOyE/V9rDlAhrfq1EEG9Cvm0Kof6Mf+4ozL/5tjTaUURTCW///weU0l/TTf
 XwjZsZ/LjamxhD++lQ9EuPBHZkuu2Uf86fzptDd4ojEvR6U+J8oNYWIlv7QsPUIc
 8IUPPaWTj3N/JsWeMRaAtZhd9pXl1rQ2o7PVabXiy6UvSOZs751LApjRdfFl6Xud
 Wj1MiVlGT8GlNIYhcOONFtO6Bl0TiRRCeDiRKDkjl+kBt6XJFNE9vcLdQ8Hq40nm
 bb2qMgSMDAbmegky1CDydQMRwixkgoSN9RiyKS0dVTjJmQ5GtzuIafeLi0vFqFhQ
 ==
X-ME-Sender: <xms:VOmaX5OwBUapLfjci1JpoyQwxFDhQkk3zWUNFAAyjPHai1s79WsTcQ>
 <xme:VOmaX79cinYfjTEilHO4K7FbV8GbkUBRliZwu6YQUvgmEGHz-bNv0_pyJ9SK0FVNP
 cu1jdifKOLxaIb2GZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleefgdekgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
 udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:VOmaX4RvseFuLTjAV_lVjQUJSZ4rYNHXOfHJxfvNJS5JPP2LpsKkXA>
 <xmx:VOmaX1t_UA2Gzy2jb8l652m5PY74AwctICXzeL-AA5urh1pkZiZVWg>
 <xmx:VOmaXxfA2Yvno28wW4mUEc1zcjA4ELUMCZ9W4DSCqD6UbU9KmmJE5g>
 <xmx:VumaX5Rg3KDynqd69S536Uv9ZjDtvh8BHJzG0p78gCmJtTN0WrUMHQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id B8EA73280065;
 Thu, 29 Oct 2020 12:09:55 -0400 (EDT)
Date: Thu, 29 Oct 2020 17:09:53 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Clarify .of_xlate assumptions
Message-ID: <20201029160953.vklbuag52gcrihcj@gilmour.lan>
References: <e86ad0f733a9fe7b209bb7c5ac58760266b97414.1603985657.git.robin.murphy@arm.com>
MIME-Version: 1.0
In-Reply-To: <e86ad0f733a9fe7b209bb7c5ac58760266b97414.1603985657.git.robin.murphy@arm.com>
Cc: geert+renesas@glider.be, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, Yu Kuai <yukuai3@huawei.com>
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
Content-Type: multipart/mixed; boundary="===============6954186836562364821=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6954186836562364821==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ctca4paoactgkeht"
Content-Disposition: inline


--ctca4paoactgkeht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2020 at 03:34:48PM +0000, Robin Murphy wrote:
> A common idiom for .of_xlate is to use of_find_device_by_node() to
> retrieve the relevant IOMMU instance data when translating IOMMU
> specifiers for a client device. Although it's slightly roundabout,
> this is simply looking up something we know exists - if it *were*
> to return NULL, that would mean that no platform device is associated
> with the given DT node, therefore the driver couldn't have probed
> and called iommu_device_register() with the ops that .of_xlate was
> called from in the first place. By construction, we can also assume
> that the instance data for any registered IOMMU must be valid.
>=20
> This isn't necessarily obvious at first glance, though, so add some
> comments to document these assumptions in-place.
>=20
> Suggested-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--ctca4paoactgkeht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5rpUQAKCRDj7w1vZxhR
xQD9AP9I9XnjigTyb8I3DNDiKiut8uLu7NzbDWF0oEypP4J6gwEAvHTUbv/z7OBW
DoAYoYngAXkTcL940oBf5beg98beUQk=
=Pixo
-----END PGP SIGNATURE-----

--ctca4paoactgkeht--

--===============6954186836562364821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6954186836562364821==--
