Return-Path: <SRS0=5Hhm=O7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34669C433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 03:27:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C415B60EB1
	for <iommu@archiver.kernel.org>; Mon, 11 Oct 2021 03:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C415B60EB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8622A8176F;
	Mon, 11 Oct 2021 03:27:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wMcsMl2M7FL7; Mon, 11 Oct 2021 03:27:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 36E628174C;
	Mon, 11 Oct 2021 03:27:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08C8EC0011;
	Mon, 11 Oct 2021 03:27:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72E5AC000D
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 03:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5464F606E0
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 03:27:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HaP3AZZGUt7d for <iommu@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 03:27:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D00B606D6
 for <iommu@lists.linux-foundation.org>; Mon, 11 Oct 2021 03:27:00 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HSPNW4sRpz4xbc; Mon, 11 Oct 2021 14:26:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1633922811;
 bh=RzarCJ/iuPvuUb6JjprFQQYugb74lPNA9To2B9JBEaA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LyZqqdQjik07FKZJ5xvz/gaQnsXaq5EqMzu7gBtg5Jw9Z4TpOl6I9mTY8emE9D1eU
 noM+JfptyGWe1TgtRLM5FS8DgHlLunji2lQ6SeL8O5qWxeswmKUAV5f5PzNluTsHAu
 6BNFP38m2m86L5Qngupt69I+t0KCHDlyazEXXAfk=
Date: Mon, 11 Oct 2021 14:24:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 07/20] iommu/iommufd: Add iommufd_[un]bind_device()
Message-ID: <YWOuZWSIv304tY2L@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-8-yi.l.liu@intel.com>
 <YVP44v4FVYJBSEEF@yekko> <20210929122457.GP964074@nvidia.com>
 <YVUqpff7DUtTLYKx@yekko> <20211001124322.GN964074@nvidia.com>
 <YV5MAdzR6c2knowf@yekko> <20211007113503.GG2744544@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211007113503.GG2744544@nvidia.com>
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 jean-philippe@linaro.org, dave.jiang@intel.com, ashok.raj@intel.com,
 corbet@lwn.net, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, lkml@metux.net, dwmw2@infradead.org,
 jun.j.tian@intel.com, linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, robin.murphy@arm.com
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
Content-Type: multipart/mixed; boundary="===============4222720610695302265=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4222720610695302265==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0VYc2zw48AcQLMtf"
Content-Disposition: inline


--0VYc2zw48AcQLMtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 07, 2021 at 08:35:03AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 07, 2021 at 12:23:13PM +1100, David Gibson wrote:
> > On Fri, Oct 01, 2021 at 09:43:22AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Sep 30, 2021 at 01:10:29PM +1000, David Gibson wrote:
> > > > On Wed, Sep 29, 2021 at 09:24:57AM -0300, Jason Gunthorpe wrote:
> > > > > On Wed, Sep 29, 2021 at 03:25:54PM +1000, David Gibson wrote:
> > > > >=20
> > > > > > > +struct iommufd_device {
> > > > > > > +	unsigned int id;
> > > > > > > +	struct iommufd_ctx *ictx;
> > > > > > > +	struct device *dev; /* always be the physical device */
> > > > > > > +	u64 dev_cookie;
> > > > > >=20
> > > > > > Why do you need both an 'id' and a 'dev_cookie'?  Since they're=
 both
> > > > > > unique, couldn't you just use the cookie directly as the index =
into
> > > > > > the xarray?
> > > > >=20
> > > > > ID is the kernel value in the xarray - xarray is much more effici=
ent &
> > > > > safe with small kernel controlled values.
> > > > >=20
> > > > > dev_cookie is a user assigned value that may not be unique. It's
> > > > > purpose is to allow userspace to receive and event and go back to=
 its
> > > > > structure. Most likely userspace will store a pointer here, but i=
t is
> > > > > also possible userspace could not use it.
> > > > >=20
> > > > > It is a pretty normal pattern
> > > >=20
> > > > Hm, ok.  Could you point me at an example?
> > >=20
> > > For instance user_data vs fd in io_uring
> >=20
> > Ok, but one of those is an fd, which is an existing type of handle.
> > Here we're introducing two different unique handles that aren't an
> > existing kernel concept.
>=20
> I'm not sure how that matters, the kernel has many handles - and we
> get to make more of them.. Look at xarray/idr users in the kernel, many of
> those are making userspace handles.

Again, I'm commenting *just* on the fact that the current draft
introduce *two* handles for the same object.  I have no objection to
either of the handles in isoation.

> > That said... is there any strong reason why user_data needs to be
> > unique?  I can imagine userspace applications where you don't care
> > which device the notification is coming from - or at least don't care
> > down to the same granularity that /dev/iommu is using.  In which case
> > having the kernel provided unique handle and the
> > not-necessarily-unique user_data would make perfect sense.
>=20
> I don't think the user_data 64 bit value should be unique, it is just
> transported from  user to kernal and back again. It is *not* a handle,
> it is a cookie.
>=20
> Handles for the kernel/user boundary should come from xarrays that
> have nice lookup properties - not from user provided 64 bit values
> that have to be stored in red black trees..

Yes, I think that would make more sense.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0VYc2zw48AcQLMtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFjrmMACgkQbDjKyiDZ
s5L66BAA2KSYaq6MCy69G1nEtfYbAGPDJ4QuXouV1K4wx7uIroH1P/RjgD3gcaw9
I2/Ity23aYrXP7e/JIthanEw7WnB9Zw8Y7SqhqPsXfkpoQt0F9Voykhh6PUobHPj
FjAovwh2OID8MdecvxwsTVxfadH6Hs5E2ZJxgM7i7IexUFXp8ArKgTJoYfj1vvsz
eUmRJdqUVQsmAhLsprRXEVxleF1McEorHfR+gz/cGmoJHt/z66PqLBjARlbXtebg
2Iux0IFpguxtrKT9zpTEflC9qGJveGz7dGsrf9RFO+P2Xvgn1NG5qHaB0iYjZZxQ
hAdWXsW8SLOEmgDAfizHHRYJ/gbEx6rmmv8UmhdRD+CqvnFKj+g27bgN/AUuFUFf
2BZ0gAeQHyycgeKNruOUNq3p2grSzb4v1d3E8xFPnzJ9jXir2t78j4wcqwjdS3Ek
PR4NriYCCjRMiDon+cFP/qvjq4Aj50PJfh6zPjMiKobKd165ubO+KYzFYZMzsQ5B
wjyHMQwk5IzIxQTXXMhlV6ZgoATn6ivmaF5++e1YOitPOhFL5oKdcAR7ap5lt7Mq
iLVEPbPb1pcUjJJe+OJqNyAL1g59UUFpvILvGXDbVq2cqlf+cPlQMwUaTV9Nyut4
TPz2KR1VWKXN+eT+k3p6MuORLsAV67F/FqnZF0jVKu3blPwonCs=
=/qGA
-----END PGP SIGNATURE-----

--0VYc2zw48AcQLMtf--

--===============4222720610695302265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4222720610695302265==--
