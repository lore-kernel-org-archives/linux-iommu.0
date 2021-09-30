Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDB8C433FE
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 04:19:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E498561882
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 04:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E498561882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A6A2A402B5;
	Thu, 30 Sep 2021 04:19:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0fHMpJv5fweD; Thu, 30 Sep 2021 04:19:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 301B240190;
	Thu, 30 Sep 2021 04:19:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99118C0021;
	Thu, 30 Sep 2021 04:19:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56514C001B
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 04:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F1DF40164
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 04:19:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BLqeNBOnxl5K for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 04:19:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1CAE40193
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 04:19:26 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HKg4C5Nqkz4xbP; Thu, 30 Sep 2021 14:19:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1632975563;
 bh=i+RGI9rpio1f9EZOmFMgvr+f89K9pwqzCrMlLiqEWBg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FbzFOHv16oDoZtnbVQYUyMRvyDXQI4YLsyG2XKZ4GrxAck6W71yAIVJFYOehjs+qB
 UywCjtC94TblKHh3y31F2/hjtyR4oATlOKO9szyQaP9PhU2/dwKL9A1g3JbQaRx/yq
 oyD0eqiKWeP7fVkfKKmGwMCmedhCm3cxV9fjxrJE=
Date: Thu, 30 Sep 2021 13:09:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma interfaces
Message-ID: <YVUqYsJTMkt1nnXL@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-7-yi.l.liu@intel.com>
 <YVPxzad5TYHAc1H/@yekko>
 <BN9PR11MB5433E1BF538C7D3632F4C6188CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YVQJJ/ZlRoJbAt0+@yekko> <20210929125716.GT964074@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210929125716.GT964074@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============7474402338511363369=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7474402338511363369==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Mv1ylZtgq547n0AU"
Content-Disposition: inline


--Mv1ylZtgq547n0AU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 29, 2021 at 09:57:16AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 29, 2021 at 04:35:19PM +1000, David Gibson wrote:
>=20
> > Yes, exactly.  And with a group interface it's obvious it has to
> > understand it.  With the non-group interface, you can get to this
> > stage in ignorance of groups.  It will even work as long as you are
> > lucky enough only to try with singleton-group devices.  Then you try
> > it with two devices in the one group and doing (3) on device A will
> > implicitly change the DMA environment of device B.
>=20
> The security model here says this is fine.

I'm not making a statement about the security model, I'm making a
statement about surprisingness of the programming interface.  In your
program you have devices A & B, you perform an operation that
specifies only device A and device B changes behaviour.

> This idea to put the iommu code in charge of security is quite clean,
> as I said in the other mail drivers attached to 'struct devices *'
> tell the iommu layer what they are are doing:
>=20
>    iommu_set_device_dma_owner(dev, DMA_OWNER_KERNEL, NULL)
>    iommu_set_device_dma_owner(dev, DMA_OWNER_SHARED, NULL)
>    iommu_set_device_dma_owner(dev, DMA_OWNER_USERSPACE, group_file/iommu_=
file)
>=20
> And it decides if it is allowed.
>=20
> If device A is allowed to go to userspace then security wise it is
> deemed fine that B is impacted. That is what we have defined already
> today.
>=20
> This proposal does not free userpace from having to understand this!
> The iommu_group sysfs is still there and still must be understood.
>=20
> The *admin* the one responsible to understand the groups, not the
> applications. The admin has no idea what a group FD is - they should
> be looking at the sysfs and seeing the iommu_group directories.

Not just the admin.  If an app is given two devices in the same group
to use *both* it must understand that and act accordingly.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Mv1ylZtgq547n0AU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFVKmIACgkQbDjKyiDZ
s5K5XBAAqrZ2Hc8P6SOxVMykfq+JWNlN1rOjaPhyyjJHdRNUSOoguO93Ywjx5dzN
FBqEQMxLqdE2vmw/OgQAcvjCKjKcNXP2OjhZThJtU9U2YGPJYqxbPL12n++FQ5f9
pYcNBQMeIrpv1Of+fCgd680kvHw+El/oK4LMz9p4K9d/Hy6kyZLyHbsAfM3RZx4m
+sSHKEglvAqtJfVqr14Ovl8xTywy7LjZowINxkf7HDPvTbfUM2L2UlZ290mb48Im
zImL5gVBESiXnjGrcxL8vel9KjYGI4MU+Qy7J2TZEgB78Mack2y3pLw3kIBYBwiZ
JAAUxO2lTLISY9jbtvg3GekiSCxEbHhwIv8CxB6ojsuLz93UEDsvfodRp/Mske6K
YrFF/GylnRnYYs3gj9EBYnAP7CJ/WqDfrYDoYIH7yWVIRjJvhIz1Xf6yvK+F7Le4
ffJHrGeoJhmzSPnAPWfIchie+E0uD7KaJUqDBvIUwFFLtNvlHnc8Ca2u+EM4qho/
O8gZIWeeiExfBrwchyyVWnXRL6N6LGp7YGkP7aYq8d09EtK8BnKVgjfNzd0vnF6j
ONMT6xNiL0scHdLrpv06m8dAZ3PRTMB7cVds4oiTzPTxecZLl0LzeOoypT+qZ/cG
XHlxswnKS6Ba2MjM5Qi7pPhwPhZtk/wzH7mI8D3Zsd22cBaWzlI=
=RiYv
-----END PGP SIGNATURE-----

--Mv1ylZtgq547n0AU--

--===============7474402338511363369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7474402338511363369==--
