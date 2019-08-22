Return-Path: <SRS0=jB4a=WS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848F0C3A5A3
	for <iommu@archiver.kernel.org>; Thu, 22 Aug 2019 09:36:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E94233FC
	for <iommu@archiver.kernel.org>; Thu, 22 Aug 2019 09:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E94233FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1F17F107A;
	Thu, 22 Aug 2019 09:36:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 15167104F
	for <iommu@lists.linux-foundation.org>;
	Thu, 22 Aug 2019 09:35:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from pokefinder.org (sauhun.de [88.99.104.3])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 8538E735
	for <iommu@lists.linux-foundation.org>;
	Thu, 22 Aug 2019 09:35:58 +0000 (UTC)
Received: from localhost (p54B3343F.dip0.t-ipconnect.de [84.179.52.63])
	by pokefinder.org (Postfix) with ESMTPSA id D54622C2686;
	Thu, 22 Aug 2019 11:35:56 +0200 (CEST)
Date: Thu, 22 Aug 2019 11:35:56 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v9 3/5] block: sort headers on blk-setting.c
Message-ID: <20190822093556.ludte2vtp77fiaax@katana>
References: <1564129876-28261-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1564129876-28261-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<20190816195026.GC6886@kunai>
	<6ed6c62d-d773-71ec-382b-acd850e3dff1@kernel.dk>
MIME-Version: 1.0
In-Reply-To: <6ed6c62d-d773-71ec-382b-acd850e3dff1@kernel.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: linux-renesas-soc@vger.kernel.org, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, hch@lst.de,
	linux-block@vger.kernel.org, wsa+renesas@sang-engineering.com,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com
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
Content-Type: multipart/mixed; boundary="===============4156837875677353964=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============4156837875677353964==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kgj75bivo7t7ncfe"
Content-Disposition: inline


--kgj75bivo7t7ncfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jens,

thanks for the feedback.

> Please just drop this patch.

OK, we will do. And patch 4/5? Is it OK or do you need some more time to
think about it?

Regards,

   Wolfram


--kgj75bivo7t7ncfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1eYfcACgkQFA3kzBSg
KbaLww/+Ke0gLqx1XCJqev3VRm9mm9T+lYoT5L7RlOSw7vRIZSGbZ5TtRLZvKmsY
Kec20o8ozIAuXKsYsOZ3TC2sMh+ntcnP+Gaadoj0pSB3APqT/KdCae9q31zL5DV5
JoJUfQs9OKhNT1kiQgSa3lkZdOsFheB0k1e8l0lnZJOga68dRFcOA57Vx0vFm5UC
dobMpbGoF/aLRfF7rPOdGGy1kZ+8L1+TVLrK97YTlHFrrSlAT2l4HBHAn0gCUOxD
7naLN2w4PQ1fLHVfEAZQHp5wg1XTYjyBIHj3hafLdvxXFtJZmlZDKQ+cTMFD9Ht1
EKW18HKFyUhzrdBgmOlizxqybL5lOpJhFXXE9KZsFVgpbKW6+WtPpzmRk02UagF0
N5zPf7TqQLWzUzxDT9zR4baTy074i+Oazzv5ur9GTCk48JFLdtTNhW4BXCj55ksZ
lkYmbKBNxfI6V8rZn9zhJNJAXAi9Vq6mHJnTLfIHIvcTT2uWJ67Mg8kbB5I9NJ4K
APmuIvXoss/cgXllOwkUZO7A6Z4HCbAS4H5M5seSqJ3DBf4wN0DR6ihOlktho0vz
LTsI5Kqi65RZbtJFfLWmHp2HhHEJbt8zZqvrTivv9uv23lS3tfKLzHReTSW5yJIa
d40nFCayfsQPfE2+FqK49Nvw4KBcH7q0TtUhwsb4is/iHnV/Nvc=
=QW4f
-----END PGP SIGNATURE-----

--kgj75bivo7t7ncfe--

--===============4156837875677353964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4156837875677353964==--
