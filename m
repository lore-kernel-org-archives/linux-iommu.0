Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AFEC55178
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 09:25:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC562076B
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 09:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC562076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0E09786AF2;
	Thu, 29 Oct 2020 09:25:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rTlGkmsDoNXV; Thu, 29 Oct 2020 09:25:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B2AEF85C11;
	Thu, 29 Oct 2020 09:25:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DE6DC088B;
	Thu, 29 Oct 2020 09:25:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1B05C0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 09:25:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C64C28755E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 09:25:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lm5T28jOg5XL for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 09:25:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6566487558
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 09:25:21 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 748F45C009D;
 Thu, 29 Oct 2020 05:25:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Thu, 29 Oct 2020 05:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=fORRJP5ZFdVljZT2SOUe6jKO6uX
 rQ3IJS6SChENSYRE=; b=sH9dnPy0ldKgbyIEvtU72dqnwWnWVsN09p/E51ZBrGA
 sAXhTriaihdKWPtjHKiR9RSzr/RLzd5X4FztwsNRl+jLfA8p7WITMAkkD3JS/N7Y
 cl7CIz6R3cu2N7DUqKKclDcGO9JnKudPEVI20f6n9aq3rYcvYx/2Tr7/Igyb8SLf
 oxb0aaHNIxx39wWEnBZQdActLBJ/uXau701UncAWCDcbL7buIpwZCOPDP7mPvyId
 YIjSNPRTwBs5ClKllo/tDOJ6IMhyPvT5L1q6Xjxkpz/yNRwJOZDHAuEbtNwWOgE6
 OivQ9XwI3FRvbCALyNxqztdofRqDTZKiX2BzDd/qN+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=fORRJP
 5ZFdVljZT2SOUe6jKO6uXrQ3IJS6SChENSYRE=; b=VubYrucvFt97xjYCPbVFHR
 +8Zgz45o8CI/7BkcJAxn/MTto8P1ar8K4USmbCQGpPiHUJomt0hjPWUWzpFqdJoW
 b1FMUMSXbj4iyPjm8QhJJRU6kFTAnhwwWB6evo/98T3rtbM1yoj3KKXAsNVqsiSt
 Nknn6lp2CzQlV02+SIVkXaRrKSr+Uf6spoeSlj1b3USoKzsmHz0l//d0UdaaLBeo
 yhlkIqfITQd9fFst7OzLiAIkbse7hh0BLrgjpxMaKYUHtDWCvFv7FqmLQ6xRobwz
 N1AJ1H1hMAQ9Lv3oiN+sradEEaHmhLuMQTtRXQOca+WaL96xlPVT8U7S2e8wL7Mg
 ==
X-ME-Sender: <xms:foqaX9GzgRd-U9jaa8fAoA2I1WXM6kDlaim3AjUXu0UTkEVrQ9u4kg>
 <xme:foqaXyVyadQl45LJdkLfp1zXvCJc3vxZIGjkrsZJ50jOgKBoFbskuCf0TZX8ck9va
 SfIUnFBQGa7mrTW6zo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleefgddtgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
 udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:foqaX_Iv73To4BgIWhhZKJ39UIpexCTaZK_BUIhHw136gKSMkPpsSw>
 <xmx:foqaXzFC5gLJcO1tkoNBmyMeHL3RTwk8eIWrKbLAN_WZILxrgW5Ygg>
 <xmx:foqaXzX58drMQAEoFt8TNILlSoOhODHNZ0ABc92BMcvDEIXyrPb80A>
 <xmx:f4qaX5w8r_3_FLKL5M2Veu8RqvJaFtENaro-R8Lpp6wcgGyF9kCUAw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 37114328005D;
 Thu, 29 Oct 2020 05:25:18 -0400 (EDT)
Date: Thu, 29 Oct 2020 10:25:16 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH] iommu/sun50i: check return value of
 of_find_device_by_node() in sun50i_iommu_of_xlate()
Message-ID: <20201029092516.rhhajxzzkwsyvtt5@gilmour.lan>
References: <20201029092244.900564-1-yukuai3@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20201029092244.900564-1-yukuai3@huawei.com>
Cc: yi.zhang@huawei.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, wens@csie.org,
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
Content-Type: multipart/mixed; boundary="===============8441497663921209724=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8441497663921209724==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g776cgqylgfg6fuc"
Content-Disposition: inline


--g776cgqylgfg6fuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2020 at 05:22:44PM +0800, Yu Kuai wrote:
> If of_find_device_by_node() failed in sun50i_iommu_of_xlate(), null
> pointer dereference will be triggered. Thus return error code if
> of_find_device_by_node() failed.
>=20
> Fixes: 4100b8c229b3("iommu: Add Allwinner H6 IOMMU driver")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--g776cgqylgfg6fuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5qKfAAKCRDj7w1vZxhR
xSDRAQCrm1rq32V1f+7In92beYotHM1K7zMBFFZLkZTBEHjtswEAtV1/C0ykkRUj
NNqL+oncLSDng/A8pDUfGcZnykgnxwk=
=tnA6
-----END PGP SIGNATURE-----

--g776cgqylgfg6fuc--

--===============8441497663921209724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8441497663921209724==--
