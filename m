Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D89C31E4A
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 19:45:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9F221744
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 19:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9F221744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 85A501594;
	Thu, 13 Jun 2019 19:45:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BACBD1593
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 19:45:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from pokefinder.org (sauhun.de [88.99.104.3])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 35501711
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 19:45:49 +0000 (UTC)
Received: from localhost (p5486CF99.dip0.t-ipconnect.de [84.134.207.153])
	by pokefinder.org (Postfix) with ESMTPSA id 62B404A127B;
	Thu, 13 Jun 2019 21:45:48 +0200 (CEST)
Date: Thu, 13 Jun 2019 21:45:47 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH v6 4/5] mmc: tmio: Use dma_max_mapping_size() instead
	of a workaround
Message-ID: <20190613194547.GD6863@kunai>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
In-Reply-To: <1560421215-10750-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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
Content-Type: multipart/mixed; boundary="===============7907793397334166513=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============7907793397334166513==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 07:20:14PM +0900, Yoshihiro Shimoda wrote:
> Since the commit 133d624b1cee ("dma: Introduce dma_max_mapping_size()")
> provides a helper function to get the max mapping size, we can use
> the function instead of the workaround code for swiotlb.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

I love it! I'd really like to see this code go away. Do I get this right
that this patch is kinda independent of the reset of the series? Anyway:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl0Cp+sACgkQFA3kzBSg
KbZH5w//YZbTziLismKCWT2Aa4Xx6jz9hYCViEHV3YlulecWNZMk1MMj5mAEVLDS
XQep1eGpqDNfxaXKoHdzinLJ1BQGEtwwqyKiWr2XC0PEZh4H7Ead43pYEg1xKgb6
9eC82CtEQemmnV9bW3DRi/H/zRE2oNmshA5oM8Nk70QDNSD/dW2XEWNTpCGwq/oQ
PiaDy2UMqneh6fpNADb/2motINaNseE4ChCTc27Hx/PGtnl4qvR34iZXSI0WhLaN
Ppt1uI9kC50YaMAgeO4mSK9B84N1FucI7rboutgkRWOfUlDaDf+yIMhnE92LLVs7
0yn0uXKtkDnnWRpI2jcMScLSpzk5ISbPfsmvImoRUwruKy/vfpsYylJYWtxTx6Rn
OyZccS9fKodljAJkn7aly1fezO2+m6+NlLY/mPxEcOMuHgXo948/za6b7Aa4bzEF
Rr/AiP4cXYdvUjy3OnYpnGMX+3zsStJSSEHl+Lh9cxhflCyj0o3BLoVFn7IUOC2K
3STPFIRsol+WtRH6NJSOCQ5u8PZd1nd8n4nm0/tv/tUp55Ao62uoStmkz7D0IzKQ
migGfFhLx+NEHejtIhFFUUXNAWk+Hqw3yfBsUtbnJXX+rZcxo+mXBUveBhs9GZ98
IWp9OB52Rb74TGprWNz4JxlKi/T82E9wl3IPD1jizTD915sW/uM=
=bAj7
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--

--===============7907793397334166513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7907793397334166513==--
