Return-Path: <SRS0=rAFC=PC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B814C433FE
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 06:22:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11C360FF2
	for <iommu@archiver.kernel.org>; Thu, 14 Oct 2021 06:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B11C360FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 836A14077C;
	Thu, 14 Oct 2021 06:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AOFSPlYKe3Bh; Thu, 14 Oct 2021 06:22:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4A7C140683;
	Thu, 14 Oct 2021 06:22:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 126E4C0011;
	Thu, 14 Oct 2021 06:22:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27511C000D
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 06:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 140044071A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 06:22:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aRKC7YLd1Mf3 for <iommu@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 06:22:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 059FD405DA
 for <iommu@lists.linux-foundation.org>; Thu, 14 Oct 2021 06:22:37 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HVK7r1x5mz4xbY; Thu, 14 Oct 2021 17:22:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1634192552;
 bh=0uuzJ2RbbBNLtnJGxkiiKbw1slhnlGlCFfoDr9/tkG8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ajOeafBBMsDsL8D38GZaOWZA1yfZvnBkUfC8QlOIfR/6BjvGh+7Mp2Zx+FhLuI3Xs
 1Gq0RGkpfsfxNa3dhwc7gkM2sIjZJnKQ0KVupY2z6tdoBcXbpyzPah4RJ0ehuIKoJn
 +EWXGJP23F7UEogrsymqzG4hF8yQs38UooYaMgSw=
Date: Thu, 14 Oct 2021 15:33:21 +1100
From: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <YWezEY+CJBRY7uLj@yekko>
References: <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com>
 <BN9PR11MB543362CEBDAD02DA9F06D8ED8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922140911.GT327412@nvidia.com> <YVaoamAaqayk1Hja@yekko>
 <20211001122505.GL964074@nvidia.com> <YVfeUkW7PWQeYFJQ@yekko>
 <20211002122542.GW964074@nvidia.com> <YWPNoknkNW55KQM4@yekko>
 <20211011171748.GA92207@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211011171748.GA92207@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============1420541423424410752=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1420541423424410752==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fwwIMpD4bMVv6jlq"
Content-Disposition: inline


--fwwIMpD4bMVv6jlq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 11, 2021 at 02:17:48PM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 11, 2021 at 04:37:38PM +1100, david@gibson.dropbear.id.au wro=
te:
> > > PASID support will already require that a device can be multi-bound to
> > > many IOAS's, couldn't PPC do the same with the windows?
> >=20
> > I don't see how that would make sense.  The device has no awareness of
> > multiple windows the way it does of PASIDs.  It just sends
> > transactions over the bus with the IOVAs it's told.  If those IOVAs
> > lie within one of the windows, the IOMMU picks them up and translates
> > them.  If they don't, it doesn't.
>=20
> To my mind that address centric routing is awareness.

I don't really understand that position.  A PASID capable device has
to be built to be PASID capable, and will generally have registers
into which you store PASIDs to use.

Any 64-bit DMA capable device can use the POWER IOMMU just fine - it's
up to the driver to program it with addresses that will be translated
(and in Linux the driver will get those from the DMA subsystem).

> If the HW can attach multiple non-overlapping IOAS's to the same
> device then the HW is routing to the correct IOAS by using the address
> bits. This is not much different from the prior discussion we had
> where we were thinking of the PASID as an 80 bit address

Ah... that might be a workable approach.  And it even helps me get my
head around multiple attachment which I was struggling with before.

So, the rule would be that you can attach multiple IOASes to a device,
as long as none of them overlap.  The non-overlapping could be because
each IOAS covers a disjoint address range, or it could be because
there's some attached information - such as a PASID - to disambiguate.

What remains a question is where the disambiguating information comes
=66rom in each case: does it come from properties of the IOAS,
propertues of the device, or from extra parameters supplied at attach
time.  IIUC, the current draft suggests it always comes at attach time
for the PASID information.  Obviously the more consistency we can have
here the better.


I can also see an additional problem in implementation, once we start
looking at hot-adding devices to existing address spaces.  Suppose our
software (maybe qemu) wants to set up a single DMA view for a bunch of
devices, that has such a split window.  It can set up IOASes easily
enough for the two windows, then it needs to attach them.  Presumbly,
it attaches them one at a time, which means that each device (or
group) goes through an interim state where it's attached to one, but
not the other.  That can probably be achieved by using an extra IOMMU
domain (or the local equivalent) in the hardware for that interim
state.  However it means we have to repeatedly create and destroy that
extra domain for each device after the first we add, rather than
simply adding each device to the domain which has both windows.

[I think this doesn't arise on POWER when running under PowerVM.  That
 has no concept like IOMMU domains, and instead the mapping is always
 done per "partitionable endpoint" (PE), essentially a group.  That
 means it's just a question of whether we mirror mappings on both
 windows into a given PE or just those from one IOAS.  It's not an
 unreasonable extension/combination of existing hardware quirks to
 consider, though]

> The fact the PPC HW actually has multiple page table roots and those
> roots even have different page tables layouts while still connected to
> the same device suggests this is not even an unnatural modelling
> approach...
>=20
> Jason =20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fwwIMpD4bMVv6jlq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFnsw8ACgkQbDjKyiDZ
s5LGWA//UT6CCRBCEjcWZoC6JNlcnPfdnmk/n0SO78Xp3HNDFlS8Tw+wFLyNACbS
qZKqLiD0g5PjKhwN3QYknqaYzo9dX4yy6VYWyMpcBwz3djrbRoBE7DSX3/u5mt0x
GVMkXmKpQijPoVWJIX4ggS5ID6UHfeYFThZxHpYFCu0AykTMAVH/cJPRsxBHIkAx
1cPDVvS+fmd7H5DJ7D0nYlihlsf2xTg+rWhP9U5EXwlEpr1bncYBa1kvKk6FEQH6
QkTRLPZj5+OdTd8leASuOmBRopk6a11jRiM3CCe5ctOWd2ojYUqt4n707KEoTYA9
bPck1CQPb+tpnQaSLz6nR+EG4E4si0r+VPdvsVpGEb0kXeDdSYIfoLQRtasa5LIn
vLcJTjW+dUXXcJOAZ8Wz1sHvXh8YCPYT6NEpbJunjVTqSyUb1MzBd4uHbF4w2r9E
6ED8DzbuLR/cewlLwfNggIoQxQNtvRCrOSvzvAm8l/CED3T8UfsXhCGzgOVO+Y2y
PxcT4YqDi5OMHbMyAtEx6hN5qpUtXAz1ld3UcBXKQY5lcoq14SqyWGyKthRwYzuP
5A5Ip7at8lsj6jw+u7bNTLBfUBdaT4EvkDxWEaXX+aMvTMJ/57gsqgnTG5YGAbCJ
e4J+N/hNXUourFkWsOfjZlGcNobH0Jo8SpXCE5/EMhkpAvJrQu0=
=vnWt
-----END PGP SIGNATURE-----

--fwwIMpD4bMVv6jlq--

--===============1420541423424410752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1420541423424410752==--
