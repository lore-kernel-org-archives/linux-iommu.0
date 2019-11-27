Return-Path: <SRS0=T/MU=ZT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FCAC432C0
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 18:24:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB0620869
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 18:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB0620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A505C8588C;
	Wed, 27 Nov 2019 18:24:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sxkm83ItGUqo; Wed, 27 Nov 2019 18:24:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 59DB3857CB;
	Wed, 27 Nov 2019 18:24:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44F07C1DD5;
	Wed, 27 Nov 2019 18:24:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F2B9C0881
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 18:24:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2CBEC857CB
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 18:24:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l4KEhQQF-Gcw for <iommu@lists.linux-foundation.org>;
 Wed, 27 Nov 2019 18:24:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DEF0B85725
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 18:24:14 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4C8F7ADBF;
 Wed, 27 Nov 2019 18:24:12 +0000 (UTC)
Message-ID: <b30002d48c9d010a1ee81c16cd29beee914c3b1d.camel@suse.de>
Subject: Re: [PATCH v3 1/7] linux/log2.h: Add roundup/rounddown_pow_two64()
 family of functions
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>
Date: Wed, 27 Nov 2019 19:24:07 +0100
In-Reply-To: <6e0b9079-9efd-2884-26d1-3db2d622079d@arm.com>
References: <20191126091946.7970-1-nsaenzjulienne@suse.de>
 <20191126091946.7970-2-nsaenzjulienne@suse.de>
 <20191126125137.GA10331@unreal>
 <6e0b9079-9efd-2884-26d1-3db2d622079d@arm.com>
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Hanjun Guo <guohanjun@huawei.com>,
 Frank Rowand <frowand.list@gmail.com>, Christoph Hellwig <hch@lst.de>,
 f.fainelli@gmail.com, linux-rockchip@lists.infradead.org,
 linux-rdma@vger.kernel.org, maz@kernel.org, phil@raspberrypi.org,
 linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 mbrugger@suse.com, netdev@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 jeremy.linton@arm.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, wahrenst@gmx.net, james.quinlan@broadcom.com,
 Sudeep Holla <sudeep.holla@arm.com>, "David S. Miller" <davem@davemloft.net>,
 Tariq Toukan <tariqt@mellanox.com>
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
Content-Type: multipart/mixed; boundary="===============6084688217464637133=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6084688217464637133==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-mxyStPsVH/f4qNVW2wlv"


--=-mxyStPsVH/f4qNVW2wlv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-27 at 18:06 +0000, Robin Murphy wrote:
> On 26/11/2019 12:51 pm, Leon Romanovsky wrote:
> > On Tue, Nov 26, 2019 at 10:19:39AM +0100, Nicolas Saenz Julienne wrote:
> > > Some users need to make sure their rounding function accepts and retu=
rns
> > > 64bit long variables regardless of the architecture. Sadly
> > > roundup/rounddown_pow_two() takes and returns unsigned longs. Create =
a
> > > new generic 64bit variant of the function and cleanup rougue custom
> > > implementations.
> >=20
> > Is it possible to create general roundup/rounddown_pow_two() which will
> > work correctly for any type of variables, instead of creating special
> > variant for every type?
>=20
> In fact, that is sort of the case already - roundup_pow_of_two() itself=
=20
> wraps ilog2() such that the constant case *is* type-independent. And=20
> since ilog2() handles non-constant values anyway, might it be reasonable=
=20
> to just take the strongly-typed __roundup_pow_of_two() helper out of the=
=20
> loop as below?
>=20
> Robin
>=20

That looks way better that's for sure. Some questions.

> ----->8-----
> diff --git a/include/linux/log2.h b/include/linux/log2.h
> index 83a4a3ca3e8a..e825f8a6e8b5 100644
> --- a/include/linux/log2.h
> +++ b/include/linux/log2.h
> @@ -172,11 +172,8 @@ unsigned long __rounddown_pow_of_two(unsigned long n=
)
>    */
>   #define roundup_pow_of_two(n)			\
>   (						\
> -	__builtin_constant_p(n) ? (		\
> -		(n =3D=3D 1) ? 1 :			\
> -		(1UL << (ilog2((n) - 1) + 1))	\
> -				   ) :		\
> -	__roundup_pow_of_two(n)			\
> +	(__builtin_constant_p(n) && (n =3D=3D 1)) ?	\
> +	1 : (1UL << (ilog2((n) - 1) + 1))	\

Then here you'd have to use ULL instead of UL, right? I want my 64bit value
everywhere regardless of the CPU arch. The downside is that would affect
performance to some extent (i.e. returning a 64bit value where you used to =
have
a 32bit one)?

Also, what about callers to this function on platforms with 32bit 'unsigned
longs' that happen to input a 64bit value into this. IIUC we'd have a chang=
e of
behaviour.

Regards,
Nicolas


--=-mxyStPsVH/f4qNVW2wlv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3ev0cACgkQlfZmHno8
x/7bZggAoQCurviCXXa381xJwqPJoSkVo+ESY4pKxZ8criUSzcK0v7Snj8tUrs+B
F6O3wS+0QIF0LcdHj48Rihbx2Ls980iATSGd+7REU4JrPWLjecMDqz9smaA8/mm+
8iO/OghEVch7cGpeDW/XLbdKCRWbWoqUCkZiyDIBeRQ5/RZs8pNSZ5k6yXpglval
Hn1RDO1O+Ux+IzX50cSagoiBUVEOHcSfxNM1t88eT90fKRo4bs/xJ+OcFByqCnzx
9RGZD2KWJiEsVOL3+HWLiB8m84UHAZGQwyMB5ZiMuh4f/hfaHo/9tBTUc1DG9Qcs
fyfOer6A4i/IvO29wvmBFubbD5Noxw==
=YNW2
-----END PGP SIGNATURE-----

--=-mxyStPsVH/f4qNVW2wlv--


--===============6084688217464637133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6084688217464637133==--

