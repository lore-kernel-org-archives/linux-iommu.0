Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6799AC433EF
	for <iommu@archiver.kernel.org>; Sat, 30 Apr 2022 14:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1C3560A72;
	Sat, 30 Apr 2022 14:48:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uKSUhRkpBmM8; Sat, 30 Apr 2022 14:48:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8170D60595;
	Sat, 30 Apr 2022 14:48:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FC60C0032;
	Sat, 30 Apr 2022 14:48:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92A97C002D
 for <iommu@lists.linux-foundation.org>; Sat, 30 Apr 2022 14:48:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F9E74044D
 for <iommu@lists.linux-foundation.org>; Sat, 30 Apr 2022 14:48:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9U5hABl1Tryc for <iommu@lists.linux-foundation.org>;
 Sat, 30 Apr 2022 14:48:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5195840393
 for <iommu@lists.linux-foundation.org>; Sat, 30 Apr 2022 14:48:48 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4KrC0T18yZz4ySv; Sun,  1 May 2022 00:48:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1651330121;
 bh=lFNUWZ5oNAu/cSHE4jubOud019F50qbx1bbzg1GEQVM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bs+knwTDhAp9B05vcJz9xxoEf7tty6yO/H1AuxOgwsC4jOrFnqRNGlZtg6fqjDSyh
 c4Ps0RDl+jsHlIJ5RwYpLyHl8Z4p9Zvh118cH7YDMXhc0JEg+BOdRsNQhBjQVxe9VU
 T33mPspV4GRkiHNZBcJzifvjNGiMGZ4ixyqX809M=
Date: Sun, 1 May 2022 00:44:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 08/12] iommufd: IOCTLs for the io_pagetable
Message-ID: <Ym1LNDLVTr0yEwij@yekko>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <8-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <YkUvzfHM00FEAemt@yekko> <20220331125841.GG2120790@nvidia.com>
 <YmotBkM103HqanoZ@yekko> <20220428142258.GH8364@nvidia.com>
 <Ymt+7gOSlXyy4v5e@yekko> <20220429125442.GY8364@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220429125442.GY8364@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 iommu@lists.linux-foundation.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 Kevin Tian <kevin.tian@intel.com>,
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
Content-Type: multipart/mixed; boundary="===============6267577843071100099=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6267577843071100099==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OgLztxA0/ORkw/qB"
Content-Disposition: inline


--OgLztxA0/ORkw/qB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 29, 2022 at 09:54:42AM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 29, 2022 at 04:00:14PM +1000, David Gibson wrote:
> > > But I don't have a use case in mind? The simplified things I know
> > > about want to attach their devices then allocate valid IOVA, they
> > > don't really have a notion about what IOVA regions they are willing to
> > > accept, or necessarily do hotplug.
> >=20
> > The obvious use case is qemu (or whatever) emulating a vIOMMU.  The
> > emulation code knows the IOVA windows that are expected of the vIOMMU
> > (because that's a property of the emulated platform), and requests
> > them of the host IOMMU.  If the host can supply that, you're good
> > (this doesn't necessarily mean the host windows match exactly, just
> > that the requested windows fit within the host windows).  If not,
> > you report an error.  This can be done at any point when the host
> > windows might change - so try to attach a device that can't support
> > the requested windows, and it will fail.  Attaching a device which
> > shrinks the windows, but still fits the requested windows within, and
> > you're still good to go.
>=20
> We were just talking about this in another area - Alex said that qemu
> doesn't know the IOVA ranges? Is there some vIOMMU cases where it does?

Uh.. what?  We certainly know (or, rather, choose) the IOVA ranges for
ppc.  That is to say we set up the default IOVA ranges at machine
construction (those defaults have changed with machine version a
couple of times).  If the guest uses dynamic DMA windows we then
update those ranges based on the hypercalls, but at any point we know
what the IOVA windows are supposed to be.  I don't really see how x86
or anything else could not know the IOVA ranges.  Who else *could* set
the ranges when implementing a vIOMMU in TCG mode?

For the non-vIOMMU case then IOVA=3D=3DGPA, so everything qemu knows about
the GPA space it also knows about the IOVA space.  Which, come to
think of it, means memory hotplug also complicates things.

> Even if yes, qemu is able to manage this on its own - it doesn't use
> the kernel IOVA allocator, so there is not a strong reason to tell the
> kernel what the narrowed ranges are.

I don't follow.  The problem for the qemu case here is if you hotplug
a device which narrows down the range to something smaller than the
guest expects.  If qemu has told the kernel the ranges it needs, that
can just fail (which is the best you can do).  If the kernel adds the
device but narrows the ranges, then you may have just put the guest
into a situation where the vIOMMU cannot do what the guest expects it
to.  If qemu can only query the windows, not specify them then it
won't know that adding a particular device will conflict with its
guest side requirements until after it's already added.  That could
mess up concurrent guest initiated map operations for existing devices
in the same guest side domain, so I don't think reversing the hotplug
after the problem is detected is enough.

> > > That is one possibility, yes. qemu seems to be using this to establish
> > > a clone ioas of an existing operational one which is another usage
> > > model.
> >=20
> > Right, for qemu (or other hypervisors) the obvious choice would be to
> > create a "staging" IOAS where IOVA =3D=3D GPA, then COPY that into the =
various
> > emulated bus IOASes.  For a userspace driver situation, I'm guessing
> > you'd map your relevant memory pool into an IOAS, then COPY to the
> > IOAS you need for whatever specific devices you're using.
>=20
> qemu seems simpler, it juggled multiple containers so it literally
> just copies when it instantiates a new container and does a map in
> multi-container.

I don't follow you.  Are you talking about the vIOMMU or non vIOMMU
case?  In the vIOMMU case the different containers can be for
different guest side iommu domains with different guest-IOVA spaces,
so you can't just copy from one to another.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OgLztxA0/ORkw/qB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoULxWu4/Ws0dB+XtgypY4gEwYSIFAmJtSxMACgkQgypY4gEw
YSI5ARAAmxonWRK51/tM83pyMm6wR0Zk9Xs9qUyEvN+G1LPX2ogGeylr1XuhVqKJ
WchNr43loLqv1tD0RgHopwLYj9XinE9SUL+5EtaWqU+MBZkHZNFMiai45MaFIEwN
54JGbuCll5Rixhl+cLcI5XfzmRMvk9JXuoegi/kEKy2Dr//+yWaKgBhccSA/hSSh
FkaaOV9N5JIlYYQX98kcFDcY8lubu5bEJn/taWvPGyp3NM9TT5cj3vuyzGXx62dl
JsDgGO9DRFUMH0iW14+o1nsaoIvFwpgGgNdlLy/h7uMqDBpBw3IQp2aYW8aNB7CM
g2TAeVbY3Jc4c4MuBhG0Sg6KcDK939A5nuFYBdtWx4C4O9NuoP3cFiXEJLNp+9wE
4xbp/UOWNKQV+aR1QnVvFGx5rl/s62hB85A5CMaobolmot+rUHlSudl4AFuRWqJ7
mSXG1Xf/R4ZFchNFSpmL7JAoJXg/ympcr5GG1VfFTxFGncaN6vSL0jaGtorC5PRF
jucyvQI5YeHViD8n/QHq7rjllKEL6Ufs7S4mXAqCwiUGcDkFuz5T2m3JD1JEEv2l
TqexyG+/AiPh9SzbLSqqGh2F7NcQp1oPdaDjEC9OJnRTl8/+6HVBJvl4r8aESeF6
iPnX4CHc/BGo5b0dFJrCQ65rBXeJGUhb3gfJartaVB1bSUs8gHI=
=zpUj
-----END PGP SIGNATURE-----

--OgLztxA0/ORkw/qB--

--===============6267577843071100099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6267577843071100099==--
