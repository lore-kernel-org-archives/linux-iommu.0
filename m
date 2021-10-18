Return-Path: <SRS0=5Tlr=PG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6329AC433EF
	for <iommu@archiver.kernel.org>; Mon, 18 Oct 2021 04:14:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D08061247
	for <iommu@archiver.kernel.org>; Mon, 18 Oct 2021 04:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D08061247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC9E8608AC;
	Mon, 18 Oct 2021 04:14:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id us8vU5dC38YS; Mon, 18 Oct 2021 04:14:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9A1C860730;
	Mon, 18 Oct 2021 04:14:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81BA3C000F;
	Mon, 18 Oct 2021 04:14:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79D21C0024
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 04:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 515A14038C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 04:14:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tLtrbD0iQ_Ly for <iommu@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 04:14:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 281B340385
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 04:14:09 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HXk5j5s6Dz4xd8; Mon, 18 Oct 2021 15:14:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1634530441;
 bh=LRKhCx62a8FylBa2igF2cBSiVauxjdJGZXJ54N9UUEI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CK3WSFHOUcDld4zE8yNAbqC4FyrTxzjVPfpA0zyCBUJMVp/le3OFTrYzrTlBoVQzh
 fXlROTKB0lSqJV5mx/U5GpTOASEgdS9niggv8iq/2N2ypTus31h0JEGlksaBT41awn
 zTaAZeSbIf9ckhrJ7VJNbj//fwPRZPbQN6A5//Zk=
Date: Mon, 18 Oct 2021 14:40:54 +1100
From: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <YWzsxlr10ejE2E7f@yekko>
References: <BN9PR11MB543362CEBDAD02DA9F06D8ED8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922140911.GT327412@nvidia.com> <YVaoamAaqayk1Hja@yekko>
 <20211001122505.GL964074@nvidia.com> <YVfeUkW7PWQeYFJQ@yekko>
 <20211002122542.GW964074@nvidia.com> <YWPNoknkNW55KQM4@yekko>
 <20211011171748.GA92207@nvidia.com> <YWezEY+CJBRY7uLj@yekko>
 <20211014150610.GS2744544@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211014150610.GS2744544@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============4097854576542904516=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4097854576542904516==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NfLXu0kVKdtqKGuK"
Content-Disposition: inline


--NfLXu0kVKdtqKGuK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 14, 2021 at 12:06:10PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 14, 2021 at 03:33:21PM +1100, david@gibson.dropbear.id.au wro=
te:
>=20
> > > If the HW can attach multiple non-overlapping IOAS's to the same
> > > device then the HW is routing to the correct IOAS by using the address
> > > bits. This is not much different from the prior discussion we had
> > > where we were thinking of the PASID as an 80 bit address
> >=20
> > Ah... that might be a workable approach.  And it even helps me get my
> > head around multiple attachment which I was struggling with before.
> >=20
> > So, the rule would be that you can attach multiple IOASes to a device,
> > as long as none of them overlap.  The non-overlapping could be because
> > each IOAS covers a disjoint address range, or it could be because
> > there's some attached information - such as a PASID - to disambiguate.
>=20
> Right exactly - it is very parallel to PASID
>=20
> And obviously HW support is required to have multiple page table
> pointers per RID - which sounds like PPC does (high/low pointer?)

Hardware support is require *in the IOMMU*.  Nothing (beyond regular
64-bit DMA support) is required in the endpoint devices.  That's not
true of PASID.

> > What remains a question is where the disambiguating information comes
> > from in each case: does it come from properties of the IOAS,
> > propertues of the device, or from extra parameters supplied at attach
> > time.  IIUC, the current draft suggests it always comes at attach time
> > for the PASID information.  Obviously the more consistency we can have
> > here the better.
>=20
> From a generic view point I'd say all are fair game. It is up to the
> IOMMU driver to take the requested set of IOAS's, the "at attachment"
> information (like PASID) and decide what to do, or fail.

Ok, that's a model that makes sense to me.

> > I can also see an additional problem in implementation, once we start
> > looking at hot-adding devices to existing address spaces. =20
>=20
> I won't pretend to guess how to implement this :) Just from a modeling
> perspective is something that works logically. If the kernel
> implementation is too hard then PPC should do one of the other ideas.
>=20
> Personally I'd probably try for a nice multi-domain attachment model
> like PASID and not try to create/destroy domains.

I don't really follow what you mean by that.

> As I said in my last email I think it is up to each IOMMU HW driver to
> make these decisions, the iommufd framework just provides a
> standardized API toward the attaching driver that the IOMMU HW must
> fit into.
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NfLXu0kVKdtqKGuK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFs7MQACgkQbDjKyiDZ
s5I36BAAtYQDHfUUrAAR+l1Nr+R/rx7GXp/8R6KR+CE1dfsCsiwzcMldNS97f68g
KxmxUoteQOeNn6s92JZ3MjvQS73SBD0n58JnUmdbjK6KmKn1yURJ7c01qI9/u8mG
f/F2nmTTtnbGNizIWVOcT3v+rVOpriok8+PVrzYLPZdwINIwGu9BvGTRX5rUH7dz
ebxBx708ex+y8Xjgahp6lN6TcpH4kZMe+7EihSh+94g2qqrjF1O4NG1E+nj0KA9a
AZohwPPqYfY2wq1ymxzEjbXHbfxoYMJGD0AdMGQoYeA4DYwokqUPcZbYCROl/EN2
hIMMjGkSLshVpla4Gswb0hIzZNyj4y6OwlnUHaCt99H64n35A14TZP+nB792qRyo
VdfYNa7bt2gyCVMJvIYjyIkT2GcsI6cUJY4xX6InPSU1cNwGH+hWiLyJ2uWz12zD
bOItcIEZFWX240UW8q0SOqfC/Yv18Z+hHtMWmv+Blwjq7E7qDGQTp9EvOga/VqsQ
bGlHugTZpZNnx0FsRQWva6RiyU+wvcQi49Uw565KotIqNkxE02PfcMOW4xTeKu39
p4LEMCw9ZdiGNF/vjSbpTBW+m1JvLpILLAi/xyqymcFBZbwxpUn+nMl2RcDJy35C
lBD9bu0MRYmWCcIm6B72rMnYR1+/zd/mVRZ2TdEJ3syDKgdGeAo=
=y6hM
-----END PGP SIGNATURE-----

--NfLXu0kVKdtqKGuK--

--===============4097854576542904516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4097854576542904516==--
