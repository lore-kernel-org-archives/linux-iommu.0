Return-Path: <SRS0=5Tlr=PG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15262C433F5
	for <iommu@archiver.kernel.org>; Mon, 18 Oct 2021 04:14:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE9861247
	for <iommu@archiver.kernel.org>; Mon, 18 Oct 2021 04:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DE9861247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 158D9403B7;
	Mon, 18 Oct 2021 04:14:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X_LekV5GbtVE; Mon, 18 Oct 2021 04:14:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 876EC40301;
	Mon, 18 Oct 2021 04:14:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F712C000F;
	Mon, 18 Oct 2021 04:14:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B11CC000D
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 04:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F11C240301
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 04:14:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ejXIOHpI-j15 for <iommu@lists.linux-foundation.org>;
 Mon, 18 Oct 2021 04:14:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED935402E3
 for <iommu@lists.linux-foundation.org>; Mon, 18 Oct 2021 04:14:07 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HXk5j6GV3z4xdB; Mon, 18 Oct 2021 15:14:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1634530441;
 bh=C/rLmv8fhNr22IXWeZPftueLB57/QIRQ43bJ5wkgLAw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Mng9BRO/IxdK3OG5njDh91QRQn7MkjHq4BZrTWPSMQrtRFOkvJmQmbGKpEnryOwL/
 lGGN0xQWdjBc/HC3Idsey/azk6QafUz9OYCU6gQKsJJbV0YWHemh9GMWhCSZz9ks+k
 qzkpofM/UvJMYhZnWWNu1mCR1YkTMZGjVg7/emAA=
Date: Mon, 18 Oct 2021 14:57:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC 13/20] iommu: Extend iommu_at[de]tach_device() for multiple
 devices group
Message-ID: <YWzwmAQDB9Qwu2uQ@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-14-yi.l.liu@intel.com>
 <YWe+88sfCbxgMYPN@yekko>
 <BN9PR11MB54337A8E65C789D038D875C68CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB54337A8E65C789D038D875C68CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
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
Content-Type: multipart/mixed; boundary="===============3071650725768564597=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3071650725768564597==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t5WOCwIxqG/YwyD+"
Content-Disposition: inline


--t5WOCwIxqG/YwyD+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 14, 2021 at 07:06:07AM +0000, Tian, Kevin wrote:
> > From: David Gibson <david@gibson.dropbear.id.au>
> > Sent: Thursday, October 14, 2021 1:24 PM
> >=20
> > On Sun, Sep 19, 2021 at 02:38:41PM +0800, Liu Yi L wrote:
> > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > >
> > > These two helpers could be used when 1) the iommu group is singleton,
> > > or 2) the upper layer has put the iommu group into the secure state by
> > > calling iommu_device_init_user_dma().
> > >
> > > As we want the iommufd design to be a device-centric model, we want to
> > > remove any group knowledge in iommufd. Given that we already have
> > > iommu_at[de]tach_device() interface, we could extend it for iommufd
> > > simply by doing below:
> > >
> > >  - first device in a group does group attach;
> > >  - last device in a group does group detach.
> > >
> > > as long as the group has been put into the secure context.
> > >
> > > The commit <426a273834eae> ("iommu: Limit
> > iommu_attach/detach_device to
> > > device with their own group") deliberately restricts the two interfac=
es
> > > to single-device group. To avoid the conflict with existing usages, we
> > > keep this policy and put the new extension only when the group has be=
en
> > > marked for user_dma.
> >=20
> > I still kind of hate this interface because it means an operation that
> > appears to be explicitly on a single device has an implicit effect on
> > other devices.
> >=20
>=20
> I still didn't get your concern why it's such a big deal. With this propo=
sal
> the group restriction will be 'explicitly' documented in the attach uAPI
> comment and sample flow in iommufd.rst. A sane user should read all
> those information to understand how this new sub-system works and
> follow whatever constraints claimed there. In the end the user should
> maintain the same group knowledge regardless of whether to use an
> explicit group uAPI or a device uAPI which has group constraint...

The first user might read this.  Subsequent users are likely to just
copy paste examples from earlier things without fully understanding
them.  In general documenting restrictions somewhere is never as
effective as making those restrictions part of the interface signature
itself.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--t5WOCwIxqG/YwyD+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFs8JgACgkQbDjKyiDZ
s5KDHQ/7BdJd+sDvBLbOWNk5B46iA+DQ9DKSjis43JQRJWMFpVLPnaYstyJwnfIa
kHMmoTbiHlpQDKh4hgnGKtZvZmd+KWzVmyLH7ny7uBIdrGSN/gyMTqEmpo5K1j1e
lpn9GWi+K/OJOtQqNhsn6E9MSm2PKDN89UIECYn98T7AFe/Rbf+97Lm+wN3csGYp
wLM+QN9yHcA777vkv0ugPRxM47kCfIzaa3eMazjhS3mCopwIuGetxgb04EWXCNyx
mNbOFjX1TWD2RZBmMhQhsYVpaRtTFQJOvwM/8Sh5CDPpmG49zhCNjzc/rXkE8d1Q
P6mc3HGY+oy3RzVfCG26IlnSO96C91g768GD978Rh2y4RD3BqvN5gM91pjJztD1c
fLLxLu4fxfD+3bnjCYh9OT0AdPdWnGJ1rD3YQiSjCR6uW14XO6Msr0oVJVM88/wO
gNkYogm2kz4+CWz93Gqpv6LJpZL0899g0xOEk46JKi4Gc/OU1/KJwLR3tdJ35vIN
bf5OKR8fo7rc+5WO+8hTxmW1NEbL7w+Fyl7c4z1ntfBt6RiXrU88WA5OF+ciZ86w
0Y3LS9Lue21X7jKtQ0QXYB1ucgEDtsIYpd63uVCsG0CnpwOyHyuqbgTONiNaL31a
GmAVdvF9bbldOoxB9Gkw5N6Rgmui7umAMB2r2OA+jUWayx5xu2g=
=hliG
-----END PGP SIGNATURE-----

--t5WOCwIxqG/YwyD+--

--===============3071650725768564597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3071650725768564597==--
