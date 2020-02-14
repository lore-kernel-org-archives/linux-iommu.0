Return-Path: <SRS0=UfLp=4C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF69C2BA83
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 07:46:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FD820873
	for <iommu@archiver.kernel.org>; Fri, 14 Feb 2020 07:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="JN5dYvug";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zgs7mwVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FD820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D4B8F8643D;
	Fri, 14 Feb 2020 07:46:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0siaXHlt__4p; Fri, 14 Feb 2020 07:46:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B0C2C86053;
	Fri, 14 Feb 2020 07:46:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 960DCC08A4;
	Fri, 14 Feb 2020 07:46:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECC04C0177
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 07:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D67BB8708C
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 07:46:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2BGrRteBhjct for <iommu@lists.linux-foundation.org>;
 Fri, 14 Feb 2020 07:46:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 81600869B6
 for <iommu@lists.linux-foundation.org>; Fri, 14 Feb 2020 07:46:50 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 51A7A6D03;
 Fri, 14 Feb 2020 02:46:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Fri, 14 Feb 2020 02:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=30N8lwJ76ANNJLmexRYW2YyfSL/
 98l30UQuoobG1iNg=; b=JN5dYvugDS5kqf2GGCp8ZMdFibo4E8KRIrL2o3DZvqQ
 ovSewFqziZEtnb9W7JRbZMPoX1NBVr8C/+RfpLt2TImgnIR8cgA+N4TKfcoraaiW
 eFsvMiRiRI66amQiDPXS4P+LWbnkqycyZ4tR63jWBpOE5cVfXJP0acsgtTnL1+FE
 jX7S93QhMC7sT9qLCjoW9RYS+yzbfHohrIr+evAsRS+1scMHbA3rKZFRP0qZm2P7
 kMO15SxB6fMyd9xgMI0d3hxFRXazLLjE43WWJuGhEsbZobP8Rm0CC2LavT3eEfcd
 Jfe5mE6n4GD0SSmzKJnrzYqn2zUXb+JqWFABy2vlALA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=30N8lw
 J76ANNJLmexRYW2YyfSL/98l30UQuoobG1iNg=; b=zgs7mwVwewVfMn7yLs4xxT
 7IfmQxufvBbG0CCCt9K1DYdxOURULoeN2iDr/Oe6SLR6kxcCtOgsQ0xynql5jeWW
 Jv2hYIN3Ck3Bk5IWYE2Q97OnNw1lH4c+tUd+WPCtZSrEl5QqpyGKjd6NJWivlpby
 2n755lBasVZx21RXFxv5S05RgA7VK6RhaojtPgr6uH8zhiMC8D1F1sBks5YNEMob
 biSrSeeZsD33tO64ZzEp2khnLvecYrcafLQvxk7+n9p6/DAqyzvAjxPY90JELOfu
 i1ZV+JFlYpl4pAhwxqe1liKGBER6R0z3tkT4fE4JTWnTw0kOZj7XOMZfXX4kSRmw
 ==
X-ME-Sender: <xms:aFBGXiuKYSuC0YTB4cRzClHTkRzayCcmXNYq9BD0mRBgnqqezcR-gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieelgdduudefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
 drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
 lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:aFBGXpvB2roE6DcENcXQiMJo7po7-NCCd0XC5dYRpYRxwY5NwhCQrg>
 <xmx:aFBGXtcCi6pPw98gKy3FPcc4kHkD2Awqlx1Viep3QzutLZE12Qv8qw>
 <xmx:aFBGXp7FMuSbVxJfIt8t3YXb15cM-f78C72qwNPL0TIPmiTvnmvbvg>
 <xmx:aVBGXp-nspaUV4PRqHIpdJQozZQ4qEOB1toDImRJhezbniykUY--Pw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5EAE43280066;
 Fri, 14 Feb 2020 02:46:48 -0500 (EST)
Date: Fri, 14 Feb 2020 08:46:46 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 0/5] memory: Introduce memory controller mini-framework
Message-ID: <20200214074646.j57uywq27xqrnjrd@gilmour.lan>
References: <20200213163959.819733-1-thierry.reding@gmail.com>
 <9841eb35-65e4-632a-ceff-bb2ba3b11bb0@arm.com>
 <20200213181555.GB1006063@ulmo>
MIME-Version: 1.0
In-Reply-To: <20200213181555.GB1006063@ulmo>
Cc: Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============8906512210912761307=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8906512210912761307==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cgx7eqxuhae5r2xz"
Content-Disposition: inline


--cgx7eqxuhae5r2xz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2020 at 07:15:55PM +0100, Thierry Reding wrote:
> On Thu, Feb 13, 2020 at 05:23:23PM +0000, Robin Murphy wrote:
> > [+ Maxime]
> >
> > On 13/02/2020 4:39 pm, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > Hi,
> > >
> > > this set of patches adds a new binding that allows device tree nodes to
> > > explicitly define the DMA parent for a given device. This supplements
> > > the existing interconnect bindings and is useful to disambiguate in the
> > > case where a device has multiple paths to system memory. Beyond that it
> > > can also be useful when there aren't any actual interconnect paths that
> > > can be controlled, so in simple cases this can serve as a simpler
> > > variant of interconnect paths.
> >
> > Isn't that still squarely the intent of the "dma-mem" binding, though? i.e.
> > it's not meant to be a 'real' interconnect provider, but a very simple way
> > to encode DMA parentage piggybacked onto a more general binding (with the
> > *option* of being a full-blown interconnect if it wants to, but certainly no
> > expectation).
>
> The way that this works on Tegra is that we want to describe multiple
> interconnect paths. A typical device will have a read and a write memory
> client, which can be separately "tuned". Both of these paths will target
> system memory, so they would both technically be "dma-mem" paths. But
> that would make it impossible to treat them separately elsewhere.
>
> So we could choose any of them to be the "dma-mem" path, but then we
> need to be very careful about defining which one that is, so that
> drivers know how to look them up, which is also not really desirable.
>
> One other things we could do is to duplicate one of the entries, so that
> we'd have "read", "write" and "dma-mem" interconnect paths, with
> "dma-mem" referencing the same path as "read" or "write". That doesn't
> sound *too* bad, but it's still a bit of a hack. Having an explicit
> description for this sounds much clearer and less error prone to me.

IIRC the dmaengine binding allows to do that, so it would make sense
to me to have the same thing allowed for interconnects.

Maxime

--cgx7eqxuhae5r2xz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXkZQZgAKCRDj7w1vZxhR
xZN1AP9xEZt3x9xN7nNg9v862AKEohAW68yHN8slrEdDkuDjLAEArPnr7wS/Ocya
nXTLIBU8NqQbSLnqTc5obXprpB/YcgM=
=twP1
-----END PGP SIGNATURE-----

--cgx7eqxuhae5r2xz--

--===============8906512210912761307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8906512210912761307==--
