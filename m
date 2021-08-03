Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479B1C4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 01:59:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC48861019
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 01:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC48861019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D4F84025C;
	Tue,  3 Aug 2021 01:59:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xqWw6yZGAR5D; Tue,  3 Aug 2021 01:59:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B54B0401C9;
	Tue,  3 Aug 2021 01:59:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8985BC0010;
	Tue,  3 Aug 2021 01:59:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93051C000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 01:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7410682E14
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 01:59:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zn3mndinPuKt for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 01:59:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D45C82D75
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 01:59:45 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Gdyjn2qhBz9sRR; Tue,  3 Aug 2021 11:59:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1627955981;
 bh=mcssnhKHGpqf7aGtYadSQBmF9hBe6OphCi9VnHFLwK8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YJzBitf3pp0u/NKy0gtRB+9FzkbD9C+yw1jDFI3o0uuA3rzB2LyegGA/PabDE74vP
 G+IG8wYOgtVrgFbrnRs7bMXHz5TJ72GHsRS3ush9ybD0NN4nZdzMsDsjCL8AUYXNSH
 F25Pcd0z5I5RLRdUHZii6gWgRXAyHxYnPsR78ncc=
Date: Tue, 3 Aug 2021 11:58:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <YQii3g3plte4gT5Z@yekko>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YP4/KJoYfbaf5U94@yekko> <20210730145123.GW1721383@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210730145123.GW1721383@nvidia.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============7472358214740016540=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7472358214740016540==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="woWztZ/43ybkO+Tp"
Content-Disposition: inline


--woWztZ/43ybkO+Tp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 30, 2021 at 11:51:23AM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 26, 2021 at 02:50:48PM +1000, David Gibson wrote:
>=20
> > That said, I'm still finding the various ways a device can attach to
> > an ioasid pretty confusing.  Here are some thoughts on some extra
> > concepts that might make it easier to handle [note, I haven't thought
> > this all the way through so far, so there might be fatal problems with
> > this approach].
>=20
> I think you've summarized how I've been viewing this problem. All the
> concepts you pointed to should show through in the various APIs at the
> end, one way or another.
>=20
> How much we need to expose to userspace, I don't know.
>=20
> Does userspace need to care how the system labels traffic between DMA
> endpoint and the IOASID? At some point maybe yes since stuff like
> PASID does leak out in various spots

Yeah, I'm not sure.  I think it probably doesn't for the "main path"
of the API, though we might want to expose that for debugging and some
edge cases.

We *should* however be exposing the address type for each IOAS, since
that affects how your MAP operations will work, as well as what
endpoints are compatible with the IOAS.

> > /dev/iommu would work entirely (or nearly so) in terms of endpoint
> > handles, not device handles.  Endpoints are what get bound to an IOAS,
> > and endpoints are what get the user chosen endpoint cookie.
>=20
> While an accurate modeling of groups, it feels like an
> overcomplication at this point in history where new HW largely doesn't
> need it.

So.. first, is that really true across the board?  I expect it's true
of high end server hardware, but for consumer level and embedded
hardware as well?  Then there's virtual hardware - I could point to
several things still routinely using emulated PCIe to PCI bridges in
qemu.

Second, we can't just ignore older hardware.

> The user interface VFIO and others presents is device
> centric, inserting a new endpoint object is going going back to some
> kind of group centric view of the world.

Well, kind of, yeah, because I still think the concept has value.
Part of the trouble is that "device" is pretty ambiguous.  "Device" in
the sense of PCI address for register interface may not be the same as
"device" in terms of DMA RID may not be the same as as "device" in
terms of Linux struct device=20


terms of PCI register interface is not the same as "device"
in terms of RID / DMA identifiability is not the same "device" in
terms of what.

> I'd rather deduce the endpoint from a collection of devices than the
> other way around...

Which I think is confusing, and in any case doesn't cover the case of
one "device" with multiple endpoints.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--woWztZ/43ybkO+Tp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmEIot4ACgkQbDjKyiDZ
s5LrNhAAuKUL5EwDkgGG0d1RtZfMCGJzZoJmU/9h/PLaLeR/INpQR+ZrAd0vNrUd
XxGaIEZelNKEFXMyALoYwXqiwxdwdhduIpdBaN2X2usYYKaMl6iuP34CMWKl7gxq
U+91Jwb/lP3IrU1t9fhAJaNUL/wIKpmMefsFjVqicYjwxGdIHdJLT8TsHqnd/Suq
Yx5kjGQhF8o3lziQtAeDwMfGytM2rekdpshVrIye8+6urrxO/PM308gGGUj3QBfE
NxmDYQWRDcqrPdtLN8Ln8sPi7GDliXX0+8pC83RiRPUgXGCgoLcmF8KGVUtio/td
TC8laRhl15Zls1/EyuBlDRZBkp/SQSlksh3v9sgHfJqUofgLtWcHtb8w+arNEGKQ
b3ppdmORDQg47ELkRE/fYgNNHiFQmzZxEP7TJJaR+uhY2DQ7LEsFS3UUeFI82oUb
DY9+4FwKgI73+Cz+f088tIJ5gJgLoESLUDcqShvsbFK4RjD3bJcyCwwap8Vz5kuf
eH/fdvoeqw/M8L2xS+i6NqzVY59hAOFWNj8yU1O4V3yLCo8D8Z7/4ouoRqWgz6Ci
7JhDg/zYuoCRG9KNDO5s/FNpuQW6UCiJi07ZQi6J62mnmRvi3gFJcn3Wvi15yY4K
gLebfSKkC/adNM5iUb0shqpYS5qLt5OZUITuujtV2wVs5hr2zUk=
=1JD4
-----END PGP SIGNATURE-----

--woWztZ/43ybkO+Tp--

--===============7472358214740016540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7472358214740016540==--
