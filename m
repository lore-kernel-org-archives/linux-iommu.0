Return-Path: <SRS0=T/MU=ZT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FDAC432C0
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 19:16:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840F320835
	for <iommu@archiver.kernel.org>; Wed, 27 Nov 2019 19:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840F320835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 49C09850BE;
	Wed, 27 Nov 2019 19:16:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nwEcREVcdftG; Wed, 27 Nov 2019 19:16:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8E1CD81DF8;
	Wed, 27 Nov 2019 19:16:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A25FC1DDA;
	Wed, 27 Nov 2019 19:16:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 076B4C0881
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 19:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E9F5085F7C
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 19:16:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yTr-eNAOOjNB for <iommu@lists.linux-foundation.org>;
 Wed, 27 Nov 2019 19:16:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 61D9A85F78
 for <iommu@lists.linux-foundation.org>; Wed, 27 Nov 2019 19:16:39 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C825BACEF;
 Wed, 27 Nov 2019 19:16:36 +0000 (UTC)
Message-ID: <c3885c2ed8bec892290c3d957c8c5012039b6759.camel@suse.de>
Subject: Re: [PATCH v3 1/7] linux/log2.h: Add roundup/rounddown_pow_two64()
 family of functions
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>
Date: Wed, 27 Nov 2019 20:16:27 +0100
In-Reply-To: <c08863a7-49c6-962e-e968-92adb8ee2cc9@arm.com>
References: <20191126091946.7970-1-nsaenzjulienne@suse.de>
 <20191126091946.7970-2-nsaenzjulienne@suse.de>
 <20191126125137.GA10331@unreal>
 <6e0b9079-9efd-2884-26d1-3db2d622079d@arm.com>
 <b30002d48c9d010a1ee81c16cd29beee914c3b1d.camel@suse.de>
 <c08863a7-49c6-962e-e968-92adb8ee2cc9@arm.com>
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
Content-Type: multipart/mixed; boundary="===============3058927755399643942=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3058927755399643942==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-O+wgk4AZ6l++1CDkyqmb"


--=-O+wgk4AZ6l++1CDkyqmb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-27 at 19:06 +0000, Robin Murphy wrote:
> On 27/11/2019 6:24 pm, Nicolas Saenz Julienne wrote:
> > On Wed, 2019-11-27 at 18:06 +0000, Robin Murphy wrote:
> > > On 26/11/2019 12:51 pm, Leon Romanovsky wrote:
> > > > On Tue, Nov 26, 2019 at 10:19:39AM +0100, Nicolas Saenz Julienne wr=
ote:
> > > > > Some users need to make sure their rounding function accepts and
> > > > > returns
> > > > > 64bit long variables regardless of the architecture. Sadly
> > > > > roundup/rounddown_pow_two() takes and returns unsigned longs. Cre=
ate a
> > > > > new generic 64bit variant of the function and cleanup rougue cust=
om
> > > > > implementations.
> > > >=20
> > > > Is it possible to create general roundup/rounddown_pow_two() which =
will
> > > > work correctly for any type of variables, instead of creating speci=
al
> > > > variant for every type?
> > >=20
> > > In fact, that is sort of the case already - roundup_pow_of_two() itse=
lf
> > > wraps ilog2() such that the constant case *is* type-independent. And
> > > since ilog2() handles non-constant values anyway, might it be reasona=
ble
> > > to just take the strongly-typed __roundup_pow_of_two() helper out of =
the
> > > loop as below?
> > >=20
> > > Robin
> > >=20
> >=20
> > That looks way better that's for sure. Some questions.
> >=20
> > > ----->8-----
> > > diff --git a/include/linux/log2.h b/include/linux/log2.h
> > > index 83a4a3ca3e8a..e825f8a6e8b5 100644
> > > --- a/include/linux/log2.h
> > > +++ b/include/linux/log2.h
> > > @@ -172,11 +172,8 @@ unsigned long __rounddown_pow_of_two(unsigned lo=
ng n)
> > >     */
> > >    #define roundup_pow_of_two(n)			\
> > >    (						\
> > > -	__builtin_constant_p(n) ? (		\
> > > -		(n =3D=3D 1) ? 1 :			\
> > > -		(1UL << (ilog2((n) - 1) + 1))	\
> > > -				   ) :		\
> > > -	__roundup_pow_of_two(n)			\
> > > +	(__builtin_constant_p(n) && (n =3D=3D 1)) ?	\
> > > +	1 : (1UL << (ilog2((n) - 1) + 1))	\
> >=20
> > Then here you'd have to use ULL instead of UL, right? I want my 64bit v=
alue
> > everywhere regardless of the CPU arch. The downside is that would affec=
t
> > performance to some extent (i.e. returning a 64bit value where you used=
 to
> > have
> > a 32bit one)?
>=20
> True, although it's possible that 1ULL might result in the same codegen=
=20
> if the compiler can see that the result is immediately truncated back to=
=20
> long anyway. Or at worst, I suppose "(typeof(n))1" could suffice,=20
> however ugly. Either way, this diff was only an illustration rather than=
=20
> a concrete proposal, but it might be an interesting diversion to=20
> investigate.
>=20
> On that note, though, you should probably be using ULL in your current=
=20
> patch too.

I actually meant to, the fix got lost. Thanks for pointing it out.

As I see Leon also likes this, I'll try out this implementation and come ba=
ck
with some results.

Regards,
Nicolas


--=-O+wgk4AZ6l++1CDkyqmb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl3ey4sACgkQlfZmHno8
x/4qGggAi4+Q7jM0+bmigNE35y3GihyLXM3ahA2qmQ9ftiZshh+Z8XQUYcRi7852
LsPNmYpHjwV3LyoaBXdnHaIVR5I1rE6RXSAZEK4xRF872qqm9rKDeMGF1GXxrw3u
BJl/LR2xhGkhYepUUAiZ+vGy3FyTfl8ADH/V9AHtFtvXuFTpStBZS3/xYgaO9mRa
E0hCB01yKy14h+FAXRiEB0E6onkyAqWjLHPmAXCGmk4ZsJwAjdVr3QyVq6AUBBKt
CaBQ7gUU8NOTg8ZE9WDRdTfIlQ+1Gpiu2xk1jML8Y1eCGxB3wtXy0t5GdjOaiwzi
fzp73AN5N4UigGnR/sl3LgJQXPe3yA==
=ixwn
-----END PGP SIGNATURE-----

--=-O+wgk4AZ6l++1CDkyqmb--


--===============3058927755399643942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3058927755399643942==--

