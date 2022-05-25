Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18A6C433F5
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 01:48:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6229640562;
	Wed, 25 May 2022 01:48:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HRTiHP1ucblN; Wed, 25 May 2022 01:48:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3001A4032E;
	Wed, 25 May 2022 01:48:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1D75C0039;
	Wed, 25 May 2022 01:47:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1C13C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 01:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B97C8612AC
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 01:47:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VBWeOnd0q7De for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 01:47:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D5FE612AA
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 01:47:56 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4L7DTw0FX7z4xYN; Wed, 25 May 2022 11:47:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1653443268;
 bh=EGg/NWkhqgS+TYzveXIrYzjI5grJ8CrjMPa5KXIW82M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UWqS+owz8XnLsimncATVeIZPrt+M5FSMuEOwndbyTqNU6V3m9T5RrOiUKdC6M8eJM
 96kqlDkNFXOvl8bB75zPZ9bQQnTvg3JmgnjeNIMXE9aPnU5ZigbKTlI2dlqH7NDGdl
 4vsah1OhKJGiAQF90Hs01kO2l/gCVEXNy1qBBjtY=
Date: Wed, 25 May 2022 11:39:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 11/12] iommufd: vfio container FD ioctl compatibility
Message-ID: <Yo2I2zfDTEg8+PjE@yekko>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <11-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323165125.5efd5976.alex.williamson@redhat.com>
 <20220324003342.GV11336@nvidia.com>
 <20220324160403.42131028.alex.williamson@redhat.com>
 <YmqqXHsCTxVb2/Oa@yekko>
 <67692fa1-6539-3ec5-dcfe-c52dfd1e46b8@ozlabs.ru>
 <20220524132553.GR1343366@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220524132553.GR1343366@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
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
Content-Type: multipart/mixed; boundary="===============5265576288384837840=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5265576288384837840==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NTotmLiK/VZ5p5fr"
Content-Disposition: inline


--NTotmLiK/VZ5p5fr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 24, 2022 at 10:25:53AM -0300, Jason Gunthorpe wrote:
> On Mon, May 23, 2022 at 04:02:22PM +1000, Alexey Kardashevskiy wrote:
>=20
> > Which means the guest RAM does not need to be all mapped in that base I=
OAS
> > suggested down this thread as that would mean all memory is pinned and
> > powervm won't be able to swap it out (yeah, it can do such thing now!).=
 Not
> > sure if we really want to support this or stick to a simpler design.
>=20
> Huh? How can it swap? Calling GUP is not optional. Either you call GUP
> at the start and there is no swap, or you call GUP for each vIOMMU
> hypercall.
>=20
> Since everyone says PPC doesn't call GUP during the hypercall - how is
> it working?

The current implementation does GUP during the pre-reserve.  I think
Alexey's talking about a new PowerVM (IBM hypervisor) feature; I don't
know how that works.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NTotmLiK/VZ5p5fr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoULxWu4/Ws0dB+XtgypY4gEwYSIFAmKNiLQACgkQgypY4gEw
YSLnFRAAhlmoBMol4J9baUS6tCTxZ0TBL5Vbqt8RKLryhFiIIQOrrB6kTU5uyYSX
vdyI/V7+cC2vjYmEDwUM8hnFi3cTpW+BMj4TeQSxEgIPHJ4tWs0yGuuhboVKhuJV
9h2iSi/SLdOc5ZELFwWZ5YTJc88EUzeDY+B+l3gL+PTxOW8WuBQmjQs+xw5Oaqhx
YY24PAoLnL/nmSOJU9jmb+1opQoah0WmziyMp5H/eX+n09XrI+OieVcgAJSvlCQ8
MJsuVokzY/cvJKJPtJRB+VKxrcavcivF6WWzcCz6e3tzkdcfOzWrEzKjfoo5pFM0
bpk5iAs34G3n+m+OGQHEKgKpRa5cGTj92Wzdic1IDAA10PRScGwJVKynImWxozKT
S1C4zjG87inJyYQ15DEYygNvRCrzNMEsbHm4NGlh4H9rTEwJ2s0DZyPUGmxOnf5E
qG64BxrmR6HhoLvuAehIok7rfEZL0EWK7xLwP8w6Q/G33W/Tpc9PpZT06SdZoKOm
tD7TFUqjjtIZwGDpggJLCiDZYF8xwaW4qnWwnpgms//pijFkaL41pxE0y/vS4lOA
uS5ATgjrMtsvaIqvygQg8eUhhUtbn08sHseYoriwWMbCMzBt8KJEXyvQ3wWvUIYp
K7DQMs+/yPDTXxFo86ZqBWwEFC8MCnVM4V8rs8Fti1k87TrZT3Y=
=9VPE
-----END PGP SIGNATURE-----

--NTotmLiK/VZ5p5fr--

--===============5265576288384837840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5265576288384837840==--
