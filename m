Return-Path: <SRS0=GLpr=2W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6D9C2D0DC
	for <iommu@archiver.kernel.org>; Wed,  1 Jan 2020 18:19:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87947206E6
	for <iommu@archiver.kernel.org>; Wed,  1 Jan 2020 18:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="G8/oZsF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87947206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D00C87089;
	Wed,  1 Jan 2020 18:19:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o4tnu-s2biVU; Wed,  1 Jan 2020 18:19:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 035AB86FB0;
	Wed,  1 Jan 2020 18:19:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0289C18DC;
	Wed,  1 Jan 2020 18:19:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D528C077D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jan 2020 18:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 06F5F85039
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jan 2020 18:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BzIJjQWXvgZS for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jan 2020 18:19:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CFEC684FB6
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jan 2020 18:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1577902738;
 bh=hpm2OGR91QQ/m5niGl/vEaS3kObf+3M6jFZ61Y1/CY8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=G8/oZsF9CPIVvIVmeUxBTihG3u6zLZ8zGIYhKv8u079GM9xmjWMmIeappByWQJd+a
 6bVYoesWtV0yVbbnoXOw8YBYzOgQ2N83qYmL6TM2/H4qWiLHi3IXLaJkFavOjJbHxZ
 sXouv3VcvcWHpvJDS/XK5+QaXvY3w7RLj3hHeRTA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.233.102]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYc0-1jRnuG0BIc-00m3Qw; Wed, 01
 Jan 2020 19:18:58 +0100
Date: Wed, 1 Jan 2020 19:18:57 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH] iommu/qcom: fix NULL pointer dereference during probe
 deferral
Message-ID: <20200101181857.GB2110@latitude>
References: <20200101033949.755-1-masneyb@onstation.org>
MIME-Version: 1.0
In-Reply-To: <20200101033949.755-1-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:3eYn0RZGHqV1q9jear8kWLgBqk7G/K4ETwM30zDRTCkJUqY6pCy
 K48FKiO3NN3BtpX31To/OcNCQiU4cs6fWV0iKVceLlc5KnL+I8mr+i4/i4F+M/xeEz97yn/
 UA4SezqipJ1XKPN8AV1V8ywBoC66lYeT0Jm636FhQuDnxsNTe3RlNNabqbUbyA7XpuZo7tP
 aJGtkbsuWqLjlmP//fE0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iLkOSE/y0FE=:1U22ENNWgayFiSrwSh3M37
 crbHF62WoA5m10xSN6vB76UxhTot4SEQDASsoFjnvMNUPvQcqmFQc3iNydauQTWZolUv+61k7
 Qkt519I4MnfNNFu0k/J6Drc28aSjyWqBijaWPueID4n6f/coz0erbEKVoHDHUB7quOJUynuSv
 /sIkoJ0MH1poV2JAXjy45ievAPC5tZv+TNtlo4NcPrL2KC7GXi3EI39tvra3Gx9I2NUCYHYwn
 CcBKp0es90e1F6wYYod2sz14wcIGg3X3MHCkj2vDTJfx2B90612PZqoGFqD3p1DeJ3LmB5ZVQ
 xK0iXXBtNMzPM/TAWwiEeLY90kOGQcRuoRG3qGo/NZ1cxHPbNrf/K0das2vaJA94mvdyO1mVK
 DP0YgnQ6hoa4AYrmkUL9sWZuqtIpLbgC3dnMAsusKRnLH1Pue0/XxONNxiMisujb9AVRS9Vva
 +t0rY24oM4H0slQ0/1YzCv80OoGVJAVRb6cIjscIYbwtvx5xLg3zVaBl520CpY36pKauJ82Gx
 kQm4hIvCC1SUo+bz9M/EeqmT2SBcFoHVnQHqtFIV+H+Vh2s8bHpCkAevZVA/0CjIMSUB7LZkd
 ggavJNDaYIsvWVJYB75qf11qS71TyvqfMtLTyr1z16ihOkttdHeAMUkpd/SRg+oC+rPamSz/g
 I5UoEu3dw23UUHecV7rJeA77mBY4JBCYRefUTyvXyMdh0aff2N4XJw3OyQoNntJmyTx9nNmkr
 yTiKoXPuXPpcvS0dvTr1C6IESXlOSBKBx2SLsBFoHOvkd4NPtf1DkvVnPEGjlXQNQlUOPDwvi
 pS1oUVq4XIC++LKAMT269jBcXAV7/VZfIG3AHAAZLZ5ylEM59KD7p57//KOh1lhRls3//qljg
 /wOoXBTGqRvxKuU/LZ7OxgB/XLitYCHNp1xk2FCy1eplMh6t/UFXCAnGKe5yogAFUrBn5wSzF
 RRF4Ht+HY3zAa5nEWZK2LJ0RHA3YCSR0bxrghhuI2kYRdYhylGSZhXgQbmMVRsSiINkYSY84e
 MGhfCAT702ntQ85u/+7dV37wPI84n2KK4Fkq7C4GugmWZ9gf/i6Edl1tRzUfegceDfUJ6le4E
 cWM2PlD570jRpGSTdSjQ3xk2P+BhfJpx8hCZeGCVF+5bb2G+BRwv7UP/W5BFmUzvv/HXb1yFQ
 nQssxjlfnkCkOfN+qzhIdsfKtpQkw3GfmZPw3a1JzMoa/e89fl9/DXykHeScGxqnXIp2tXrcx
 BLNsZroG7655XoznHBk6I5pMt0mwo0CR5XYA+DwRHLhOfoDmicK9c1UKyNhM=
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 bjorn.andersson@linaro.org, agross@kernel.org, linux-kernel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============8116746159726283183=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8116746159726283183==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2019 at 10:39:49PM -0500, Brian Masney wrote:
[...]
>     (kernel_init) from ret_from_fork (arch/arm/kernel/entry-common.S:156)
>     Exception stack(0xee89dfb0 to 0xee89dff8)
>     dfa0:                                     00000000 00000000 00000000 =
00000000
>     dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000
>     dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>     Code: e92d4070 e1a04000 e3a01004 e240501c (e5930014)

This looks like ARM code...

>     All code
>     =3D=3D=3D=3D=3D=3D=3D=3D
>        0:	70 40                	jo     0x42
>        2:	2d e9 00 40 a0       	sub    $0xa04000e9,%eax
>        7:	e1 04                	loope  0xd
>        9:	10 a0 e3 1c 50 40    	adc    %ah,0x40501ce3(%rax)
>        f:	e2 14                	loop   0x25
>       11:*	00                   	.byte 0x0		<-- trapping instruction
>       12:	93                   	xchg   %eax,%ebx
>       13:	e5                   	.byte 0xe5

=2E.. disassembled as x86 code.

I suspect that scripts/decodecode picked up the wrong architecture
somehow. Perhaps CROSS_COMPILE wasn't set?

>=20
>     Code starting with the faulting instruction
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>        0:	14 00                	adc    $0x0,%al
>        2:	93                   	xchg   %eax,%ebx
>        3:	e5                   	.byte 0xe5


Greetings and a happy new year,
Jonathan Neusch=C3=A4fer

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl4M4ogACgkQCDBEmo7z
X9uc6xAAt8EnWXrDJbKJksr2JLYDwsRONNkcbseMDFX6lxbaUtMInIzz+lALKI23
VFFFwmNKK72kxiQYgITNFWV4LC19MBMKdXSXtw8F56MX1vIFgcibvh703Y0n/hEE
81tMDn3DVlDyuRMN+jTAZrFMqeFB2yywoPYjzesQX9hprI0DyyGZtPbqRHkCpWfN
aWthJYvX1+QWyMjt8fHinUsLptLA7qtb4ZRUMXg/O8xO+NC3Khn9nVc8wqDeddAH
A/U9i9bvhFBzQotNQdqaxzn/4mlBGN9xpPR+b2m6evJ+71Di1uNpoZocxrIdEMsv
NPor1p04QFW8nWL1ZT6qa8MyUPuv+YTRrqBYnaXgPskBMal/KA+0U98WOWzWh84u
IKxWLYD1O3SL0udQsIXOb6FUE4fSrzXDKIWtgZERhnqM2vrmGooJbRNyE/IeRdXD
Q8gkOLwxZKX7aRzzXqYVCWbQsBIvE3oUUtJB/kdleY0Q1CRb9l2tYTqrlnMcSjIE
Qxh9EZim7MgzwX8nmf4CSAV5t7gSSoxlLXiMZOAye2AkhHygdVlGEH0AQk4P17oW
P6jwyKZ/88PgNai3frPAYOufE+AHS49K/p7iOWcmPbSmyJ3ii6tml6h8kvWA0ff1
sHXQgCiyZPUKNg3KD5TOZ4rLQwxon85eYlqP+KbB3taO1H6Mwvo=
=xMEO
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

--===============8116746159726283183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8116746159726283183==--
