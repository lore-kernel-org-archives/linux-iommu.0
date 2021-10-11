Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17846C433FE
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 07:20:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2ED560C4A
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 07:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B2ED560C4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 73F0E40284;
	Mon, 11 Oct 2021 07:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gbuDv__7lDOo; Mon, 11 Oct 2021 07:19:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F316640289;
	Mon, 11 Oct 2021 07:19:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C26F0C0011;
	Mon, 11 Oct 2021 07:19:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B89D8C000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 07:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F3F4402B5
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 07:19:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1LEu0yvl9Cun for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 07:19:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C3C6402A4
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 07:19:55 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HSVYP2X9Hz4xqQ; Mon, 11 Oct 2021 18:19:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1633936793;
 bh=6mTyoEeD81UgPE8G1mGEU//Fuq65qBZTt4bSRVKbg+w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ovs+Na8a2kRhJXcn14WcB4fglDHKqyAZ8/CQsxyOfabFSpI/zbbDZJwE3j7PULIlS
 dSMCuiyIYVrWVCN6zc9OEJcA/dKef95nQHaBuR+WNkA4MWDlTuX4a8DC6JODeDtI67
 hNoQ9jXaUTAluoawqk65gzodmZtswX8RetSUVLXg=
Date: Mon, 11 Oct 2021 16:37:38 +1100
From: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <YWPNoknkNW55KQM4@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com>
 <BN9PR11MB543362CEBDAD02DA9F06D8ED8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922140911.GT327412@nvidia.com> <YVaoamAaqayk1Hja@yekko>
 <20211001122505.GL964074@nvidia.com> <YVfeUkW7PWQeYFJQ@yekko>
 <20211002122542.GW964074@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211002122542.GW964074@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============5199545108583612342=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5199545108583612342==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XAp8YQc7m504M8vp"
Content-Disposition: inline


--XAp8YQc7m504M8vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 02, 2021 at 09:25:42AM -0300, Jason Gunthorpe wrote:
> On Sat, Oct 02, 2021 at 02:21:38PM +1000, david@gibson.dropbear.id.au wro=
te:
>=20
> > > > No. qemu needs to supply *both* the 32-bit and 64-bit range to its
> > > > guest, and therefore needs to request both from the host.
> > >=20
> > > As I understood your remarks each IOAS can only be one of the formats
> > > as they have a different PTE layout. So here I ment that qmeu needs to
> > > be able to pick *for each IOAS* which of the two formats it is.
> >=20
> > No.  Both windows are in the same IOAS.  A device could do DMA
> > simultaneously to both windows. =20
>=20
> Sure, but that doesn't force us to model it as one IOAS in the
> iommufd. A while back you were talking about using nesting and 3
> IOAS's, right?
>=20
> 1, 2 or 3 IOAS's seems like a decision we can make.

Well, up to a point.  We can decide how such a thing should be
constructed.  However at some point there needs to exist an IOAS in
which both windows are mapped, whether it's directly or indirectly.
That's what the device will be attached to.

> PASID support will already require that a device can be multi-bound to
> many IOAS's, couldn't PPC do the same with the windows?

I don't see how that would make sense.  The device has no awareness of
multiple windows the way it does of PASIDs.  It just sends
transactions over the bus with the IOVAs it's told.  If those IOVAs
lie within one of the windows, the IOMMU picks them up and translates
them.  If they don't, it doesn't.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XAp8YQc7m504M8vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFjzaIACgkQbDjKyiDZ
s5LujA/+J+md5jc+nVRrvzZTN2GADL6m83rgNracoDm6uMvDRuCivgx8Gb61JAzj
4vdjATq7RrfNZK6OtwjU5TW4OPWr5Q6HltxUR7thLNZYgXdcquJZHtHz4VpddvVb
jbdydqJmo2pBy5lMenRlkZM4s8Yj1ERjPsRelh32pFWP4MGbFQaKDgxbypmWSVvT
T8eQfFlANqFI6nKKUt0C2vl4i+xHVMSxd+WFcsk1+xue7XI6KsnQ1pNOVJ2lB3Ai
+6RSwer5qMA001/lYRmFETyW6+eKZuIFR4RCiq1FdJuJnrcqZSofFErPj6IRDHL7
Dar99VlTQHgVgtrBmFxezRZeBHVQlAdJQgos3VVhL5+o+8KjmusWWxVAKi372cX3
pDGbUyurpqMrYinPewTVeyT0dDOHXfEnYDgGsj+v8SxtIYENPf92AziOx+KNBRlI
MCJkh6xQpfgEROvYp7bilA8RqymffYV+rz2sVoGDb8ZfIUeFuNJKqACKN3JIYlZS
6Hk+LH2QZjBwEw+i/hDrmdfYOLD2h0G1wRFJO6HdiVBgV4P+h08RFd874tU1skeR
LEYx8SoXpseZuyP45tSblYe7yvnE8cHIjLVHD8H/Aa6kvi4l6FCJeRTANYysWH4s
weFKjdEHPGNAi6vo19Hw5IaDJufGkPYq0jZA44jesTI0ejvBfqY=
=xnee
-----END PGP SIGNATURE-----

--XAp8YQc7m504M8vp--

--===============5199545108583612342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5199545108583612342==--
