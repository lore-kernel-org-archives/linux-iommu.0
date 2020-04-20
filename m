Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A21C3A5A0
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 14:40:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C0E2082E
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 14:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ufZchA3Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4mBxVLpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C0E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3086C86D95;
	Mon, 20 Apr 2020 14:40:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4t65F1GkcBGO; Mon, 20 Apr 2020 14:40:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 818AE84E0C;
	Mon, 20 Apr 2020 14:40:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66E28C1D74;
	Mon, 20 Apr 2020 14:40:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5A56C0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 14:40:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DEAC187D75
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 14:40:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7XjduIOm1h0u for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 14:40:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9F38787D46
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 14:40:02 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 5ACC05C0126;
 Mon, 20 Apr 2020 10:40:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 20 Apr 2020 10:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=PXh+J0spjajpstfYlJVLBegen5x
 1vPub81+/OQ14NPk=; b=ufZchA3YEU0q4bx7XGMFYwzGcFkO8xEWRqczsztkArr
 2R4KhCDcb1JNYLhMzEWZ63VsagHJCtPfO5uykwcIQRmjF228SxRdG4dzR4zKZIm1
 5UCRpfehIv6fx1J4nPCWAAFWo2UvUL7QI216ogujlDTOgEtDEwrn6BeehD3qFOHS
 8QxEIFELywYiOBeEdR5TfZH1H9yctlVeYQ5ho2H0kKZODfcEhpUN2+Sg9z0C8y4D
 Gnca1ZDdvYM/eiTJZ9DXaE8TPp8sQlbm28ieKM9q6raQt49zrE7UybaxkF0tY5Le
 H0IOgwMJstAbhzuJ+IFtGaasz8cUt7yoiRqhKUabiOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=PXh+J0
 spjajpstfYlJVLBegen5x1vPub81+/OQ14NPk=; b=4mBxVLpwXKEj7dteX1kJU9
 3Y5UhFhWhaWgIhLhglKQP4/9Dz1p8EzZXT1I2NcA+kBk7qMrcgRIOiy5qLFX5LIu
 LPxgs1CqMj7+N10okQKfd9lUh9pmWbVWL8Z6fNV0IMOsp2usM8jRmlkmG9hr9oES
 s0p8sl2CjoUlpH/wNBhwxSSRm+QF+fwMKmAfuecIFjwjSE/a+PV9otFwcbI/MDbA
 LrAq4f00WMolcCYkFl+l3sbumpLuo9oDc+94SQyUZkcvE/DN6oARDENEtwN4rgRR
 e5K6F0Z3YxZTXWH1IKtDmcJH30nf961j+dbvkCDaOBHErZo9Of2cZLp6y1C/foCg
 ==
X-ME-Sender: <xms:QLSdXjOctWb3R9tY3CVXYn6RD_VPwVFAnu9kynGrVrwuGBfZ-htojg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeefgdejlecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
 ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
 fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:QLSdXlDqCN_99v6KG6VwbYnyn3C290e6umaoo7BRsBUNWTSdeEwf-g>
 <xmx:QLSdXp_F2WTv8Nkp_tvAREiqEdrFZNPa-kM6GUwzRMWcq1wY6nJCjw>
 <xmx:QLSdXuGy6HLiH4EBVng6Ix-cpFfPe6eOT6QV70LrxVctW0VHllszFA>
 <xmx:QbSdXjDuuIV9lQaFtTUYtQw3soUWX_jrhBMLqSOyTb1TqQi8cGhYQQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 553F03280060;
 Mon, 20 Apr 2020 10:40:00 -0400 (EDT)
Date: Mon, 20 Apr 2020 16:39:58 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 2/4] iommu: Add Allwinner H6 IOMMU driver
Message-ID: <20200420143958.rdn3j27tu3umtkrh@gilmour.lan>
References: <cover.a31c229a83f1d92e6928ae2adb70887da0fd44b3.1582222496.git-series.maxime@cerno.tech>
 <6864f0f28825bb7a2ec1c0d811a4aacdecf5f945.1582222496.git-series.maxime@cerno.tech>
 <20200302153606.GB6540@8bytes.org>
 <20200401114710.doioefzmjhte7jwu@gilmour.lan>
 <20200408140649.GI3103@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200408140649.GI3103@8bytes.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
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
Content-Type: multipart/mixed; boundary="===============2262903875108878025=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2262903875108878025==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ru45p6lp7fq34z3p"
Content-Disposition: inline


--ru45p6lp7fq34z3p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 08, 2020 at 04:06:49PM +0200, Joerg Roedel wrote:
> On Wed, Apr 01, 2020 at 01:47:10PM +0200, Maxime Ripard wrote:
> > As far as I understand it, the page table can be accessed concurrently
> > since the framework doesn't seem to provide any serialization /
> > locking, shouldn't we have some locks to prevent concurrent access?
>=20
> The dma-iommu code makes sure that there are no concurrent accesses to
> the same address-range of the page-table, but there can (and will) be
> concurrent accesses to the same page-table, just for different parts of
> the address space.
>=20
> Making this lock-less usually involves updating non-leaf page-table
> entries using atomic compare-exchange instructions.

That makes sense, thanks!

I'm not sure what I should compare with though, do you want to compare with=
 0 to
check if there's already a page table assigned to that DTE? If so, then we
should also allocate the possible page table before the fact so that we have
something to swap with, and deallocate it if we already had one?

Maxime

--ru45p6lp7fq34z3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXp20PgAKCRDj7w1vZxhR
xdskAQD8uW/heD6sz1jtgnc/STqZgTUkb5RbyrBeNlR9JoXflQD8Dyylg9C7Aacl
NQgNnyYDy8bej8v1c5S34GeYWpSv6ws=
=ieXK
-----END PGP SIGNATURE-----

--ru45p6lp7fq34z3p--

--===============2262903875108878025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2262903875108878025==--
