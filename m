Return-Path: <SRS0=+9ml=PN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50334C43217
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 05:29:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB96060F6F
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 05:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB96060F6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8609440194;
	Mon, 25 Oct 2021 05:29:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V9w-kAlIS8c7; Mon, 25 Oct 2021 05:29:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 27F3B400D4;
	Mon, 25 Oct 2021 05:29:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10EC3C0019;
	Mon, 25 Oct 2021 05:29:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30519C000E
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 05:29:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F3F160663
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 05:29:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TlV_ztejw0Im for <iommu@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 05:29:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3649C60616
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 05:29:34 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4Hd3RV3yc5z4xZ1; Mon, 25 Oct 2021 16:29:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1635139766;
 bh=6zAr2dccLE+Xq46zC4THi7D5zvFV8MFg187CSJj4PoU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Soao14g4N+KZ/f9ElfqcTacz+edrkXvdUyuFDgkOIFFrK9kUH2lpbmN3vk8hW17/H
 /q6A0UCMXTV3UhexzZ6bC1Lh9qDYDc6E15yfCAZayVk1HT/60wXMetI0KviTXKvKnr
 Elq25upo6pL91ZXHBgCljcx5VZBkiMuPs8pKxLok=
Date: Mon, 25 Oct 2021 16:14:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 13/20] iommu: Extend iommu_at[de]tach_device() for multiple
 devices group
Message-ID: <YXY9UIKDlQpNDGax@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-14-yi.l.liu@intel.com>
 <YWe+88sfCbxgMYPN@yekko>
 <BN9PR11MB54337A8E65C789D038D875C68CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YWzwmAQDB9Qwu2uQ@yekko> <20211018163238.GO2744544@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211018163238.GO2744544@nvidia.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============0762729437162214353=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0762729437162214353==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yxRtDnBMBAGaMdJf"
Content-Disposition: inline


--yxRtDnBMBAGaMdJf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 18, 2021 at 01:32:38PM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 18, 2021 at 02:57:12PM +1100, David Gibson wrote:
>=20
> > The first user might read this.  Subsequent users are likely to just
> > copy paste examples from earlier things without fully understanding
> > them.  In general documenting restrictions somewhere is never as
> > effective as making those restrictions part of the interface signature
> > itself.
>=20
> I'd think this argument would hold more water if you could point to
> someplace in existing userspace that cares about the VFIO grouping.

My whole point here is that the proposed semantics mean that we have
weird side effects even if the app doesn't think it cares about
groups.

e.g. App's input is a bunch of PCI addresses for NICs.  It attaches
each one to a separate IOAS and bridges packets between them all.  As
far as the app is concerned, it doesn't care about groups, as you say.

Except that it breaks if any two of the devices are in the same group.
Worse, it has a completely horrible failure mode: no syscall returns
an, it just starts trying to do dma with device A, and the packets get
written into the IOAS that belongs to device B instead.  Sounds like a
complete nightmare to debug if you don't know about groups, because
you never thought you cared.


And yes, for a simple bridge like this app, attaching all the devices
to the same IOAS is a more likely setup.  But using an IOAS per device
is a perfectly valid configuration as well, and with the current draft
nothing will warn the app that this is a bad idea.

> From what I see the applications do what the admin tells them to do -
> and if the admin says to use a certain VFIO device then that is
> excatly what they do. I don't know of any applications that ask the
> admin to tell them group information.
>=20
> What I see is aligning what the kernel provides to the APIs the
> applications have already built.
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yxRtDnBMBAGaMdJf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmF2PVAACgkQbDjKyiDZ
s5LUJhAAqfdhIEiSLBVFINn04mkXp8wdf6ByN7npipHdyHzSj76wY3CwovNLbLyM
VVz+ua0VowY3482C4CbDxOEKQeYGIn5xD0nsr/gOl7PLm3uBsk4/NVXprgHblYFZ
Xlb4YtykCSVsxn/QPLYNTX4xhcWL8gUC0FS5n9Ga4N9/8JeT93aWbRMDO+hTTTv0
Enk/XhH3r4JtHXFUdr2CyU1MXmgJNd0J/Pz48U6OSqq/NP/vOhu9TnqYBLuNyV9J
ktLJe/vccmavhgscTZRH8hRTCQNgzsYC0OggrREEujZzOV6+uNFr8wCG3GvbGS4h
5+zL1kkHJ4KAIS38aQxylEOsbCIExyrSixQzdSorJWEGcNdDSy8cSmYeVzWoJMZX
jEVcCWXFkWobgB9GynbW9nj5sKZUe/8O9eVDpd9g1UDIagzdmD2yNUdLDwrx++Ef
YtJIFiYSHenbzzIfAoPcxCLLh7O/oXFTp654dODuIuZPfO2FLTdHNRznRn4r0aWW
x6u4e9KgdC9A5yeN74/Ho0U5snn5PDDxLam/tNz7/xiUBaxgKp96NS5peNU0BMOL
mI43kdEhXxrXlT3a4k+XZU+WHRTeFh69g9OyJqW6x1dkp5N/3DYgNF3nThc/x1s0
6tZg+nTGqnEAMV0QYgbR/4H5El5fMHJekab+aaMO69Ny5NnU110=
=Mlw2
-----END PGP SIGNATURE-----

--yxRtDnBMBAGaMdJf--

--===============0762729437162214353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0762729437162214353==--
