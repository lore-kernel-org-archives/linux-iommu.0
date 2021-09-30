Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD52C433F5
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 04:19:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A53361881
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 04:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A53361881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DFA9407C8;
	Thu, 30 Sep 2021 04:19:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I-AubaU3edjc; Thu, 30 Sep 2021 04:19:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AF7F140781;
	Thu, 30 Sep 2021 04:19:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C5C7C000F;
	Thu, 30 Sep 2021 04:19:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2250BC000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 04:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0BDE381C58
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 04:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qb0x2DHRhq_B for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 04:19:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EDB8381028
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 04:19:26 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HKg4C5nsLz4xbV; Thu, 30 Sep 2021 14:19:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1632975563;
 bh=oJ/ULXJCpB8pZh9T0MC+PCyhdj4ADzZWfm4oxAJ5hbY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LM/WDccNAofElIUqx6ZSzy4soq7R3iooZrZoPHFK9etndOX/erqv/SW6o9FymLCNI
 tTpH+gwM3y2hOXEZgck6bohGnynQmN84E9dCHZcEehqsNUyTDuVdDj4GCqMVfwdhER
 nJ+komzTd8XM+LZLEYtqysl90/1pUYmdKaXIjvcc=
Date: Thu, 30 Sep 2021 13:12:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 08/20] vfio/pci: Add VFIO_DEVICE_BIND_IOMMUFD
Message-ID: <YVUrAC7j0zYecxzY@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-9-yi.l.liu@intel.com>
 <YVQBFgOa4fQRpwqN@yekko>
 <BN9PR11MB54331D06D97B4FC975D8D23B8CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB54331D06D97B4FC975D8D23B8CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "jgg@nvidia.com" <jgg@nvidia.com>,
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
Content-Type: multipart/mixed; boundary="===============4425488673419436554=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4425488673419436554==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r8hKFivqxBOeSqL3"
Content-Disposition: inline


--r8hKFivqxBOeSqL3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 29, 2021 at 06:41:00AM +0000, Tian, Kevin wrote:
> > From: David Gibson <david@gibson.dropbear.id.au>
> > Sent: Wednesday, September 29, 2021 2:01 PM
> >=20
> > On Sun, Sep 19, 2021 at 02:38:36PM +0800, Liu Yi L wrote:
> > > This patch adds VFIO_DEVICE_BIND_IOMMUFD for userspace to bind the
> > vfio
> > > device to an iommufd. No VFIO_DEVICE_UNBIND_IOMMUFD interface is
> > provided
> > > because it's implicitly done when the device fd is closed.
> > >
> > > In concept a vfio device can be bound to multiple iommufds, each host=
ing
> > > a subset of I/O address spaces attached by this device.
> >=20
> > I really feel like this many<->many mapping between devices is going
> > to be super-confusing, and therefore make it really hard to be
> > confident we have all the rules right for proper isolation.
>=20
> Based on new discussion on group ownership part (patch06), I feel this
> many<->many relationship will disappear. The context fd (either container
> or iommufd) will uniquely mark the ownership on a physical device and
> its group. With this design it's impractical to have one device bound
> to multiple iommufds. Actually I don't think this is a compelling usage
> in reality. The previous rationale was that no need to impose such restri=
ction
> if no special reason... and now we have a reason. =F0=9F=98=8A
>=20
> Jason, are you OK with this simplification?
>=20
> >=20
> > That's why I was suggesting a concept like endpoints, to break this
> > into two many<->one relationships.  I'm ok if that isn't visible in
> > the user API, but I think this is going to be really hard to keep
> > track of if it isn't explicit somewhere in the internals.
> >=20
>=20
> I think this endpoint concept is represented by ioas_device_info in
> patch14:
>=20
> +/*
> + * An ioas_device_info object is created per each successful attaching
> + * request. A list of objects are maintained per ioas when the address
> + * space is shared by multiple devices.
> + */
> +struct ioas_device_info {
> +	struct iommufd_device *idev;
> +	struct list_head next;
>  };
>=20
> currently it's 1:1 mapping before this object and iommufd_device,=20
> because no pasid support yet.

Ok, I haven't read that far in the series yet.

> We can rename it to struct ioas_endpoint if it makes you feel
> better.

Meh.  The concept is much more important than the name.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r8hKFivqxBOeSqL3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFVKwAACgkQbDjKyiDZ
s5IyZBAApEbrAkg3NeEqYJu3KTfMnPffqvQpnQ5gbCPc4rEn+DpHudPJpwNt9uu9
/du7hPrwQqWDI+XCk4f3EWNUCbDZ6pOCT6f5OSCrqOl43qGLyxsSTZWzUh4eBf5I
BJ/YVp1mPfjrzSd0P1znf+/pjTgUIHBrBLbBTqkzrYrrFYTtvU8sV1gokdARiPnr
vnMp96v76nOhNZgVUwL5k+XWUHuSzNTTMttrg964N5IpNkwIOGvT+XO0rioshBjk
JWQMl9vxDKH0+6FGY1Vbc9MdGcO0IbeT+xT7ZTeD/YV3VeML+FL8Z8gaygnD/3J2
pSfDyc2Tm2jK0d96O5OpOchZDhL5A3+khZNMC14fGRUPIpx/itTIeU3vcuutGFCO
jbWItM8fARo2HvFFSXsa6Ir7GY+Ri8M+l02XT8MrWzGVCygmYUQjNisNLj4dxptV
DfxFFsQIN+V8U2rHpKJ3tBOXK4kwSQdDzfnvoHzs+iXgTL4ze/rcE6jVVLFpaDs+
1HmugwuFvDl93FyRfDVaKkj1ckA2Ddpbqyxqut7YHP6QnzH30le/OM0GTIaCGO9E
arJjVmp6cYqlkWc/a6Ues4xstYoW90oxq+XVwO8vzlZHbCTQg6fIkUiBdS29PsPj
3C9MCj4m8zKKjeucsGVvHBigj0CE9UD8dBr0KanSSrz9SIckKC8=
=SsHa
-----END PGP SIGNATURE-----

--r8hKFivqxBOeSqL3--

--===============4425488673419436554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4425488673419436554==--
