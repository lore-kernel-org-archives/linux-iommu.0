Return-Path: <SRS0=o7oR=M5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA8BC432BE
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 05:33:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DAA60E52
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 05:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A7DAA60E52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45F4E82FCE;
	Fri,  6 Aug 2021 05:33:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJcv_on40jsz; Fri,  6 Aug 2021 05:33:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6A34B82F03;
	Fri,  6 Aug 2021 05:33:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2892DC001A;
	Fri,  6 Aug 2021 05:33:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25225C001A
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 05:33:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E77F5402AA
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 05:33:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t0MY-eZgACNF for <iommu@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 05:33:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7E79402DD
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 05:33:01 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4GgvJT5CmJz9sWl; Fri,  6 Aug 2021 15:32:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1628227977;
 bh=H07A1vmsG7/hmEZvTTKfG6W1Nqbvj1job+oTNmVUUFA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PwL5ZJgISfrA9Ti81rxOUK7eS71N98wp2QENeeQcD3uBMmUdAWCKV3aqowF6NZOXh
 XI8W9HWfT1skRy4PZRx6ZQAUDg0g2DIbGv5UrWp94sJS7NqcsU7UAViaxcPyoHHi0b
 L+XALLz8KF0a+k3IWu0mPt0P9+s9QVX4yrejWGZE=
Date: Fri, 6 Aug 2021 14:24:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <YQy5fBJkKHhuNUuP@yekko>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YP4/KJoYfbaf5U94@yekko> <20210730145123.GW1721383@nvidia.com>
 <YQii3g3plte4gT5Z@yekko> <20210804140742.GI1721383@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210804140742.GI1721383@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============7289955539523923673=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7289955539523923673==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="waHxV1qIfKEUr127"
Content-Disposition: inline


--waHxV1qIfKEUr127
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 04, 2021 at 11:07:42AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 03, 2021 at 11:58:54AM +1000, David Gibson wrote:
> > > I'd rather deduce the endpoint from a collection of devices than the
> > > other way around...
> >=20
> > Which I think is confusing, and in any case doesn't cover the case of
> > one "device" with multiple endpoints.
>=20
> Well they are both confusing, and I'd prefer to focus on the common
> case without extra mandatory steps. Exposing optional endpoint sharing
> information seems more in line with where everything is going than
> making endpoint sharing a first class object.
>=20
> AFAIK a device with multiple endpoints where those endpoints are
> shared with other devices doesn't really exist/or is useful? Eg PASID
> has multiple RIDs by they are not shared.

No, I can't think of a (non-contrived) example where a device would
have *both* multiple endpoints and those endpoints are shared amongst
multiple devices.  I can easily think of examples where a device has
multiple (non shared) endpoints and where multiple devices share a
single endpoint.

The point is that making endpoints explicit separates the various
options here from the logic of the IOMMU layer itself.  New device
types with new possibilities here means new interfaces *on those
devices*, but not new interfaces on /dev/iommu.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--waHxV1qIfKEUr127
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmEMuXoACgkQbDjKyiDZ
s5Ll7RAAw19Bgqx4KAD/OEJN+VYXQEI6yg6Y78rk14ks5bjzQJ9Asq3t+HhsxCyx
EddzGgfqFGfkql9wXDEDbYFBVRMEZdcD0Zf0zFWVDqmoexXPQxCHQGTK87T1hb0f
qKbD3EP2dSv4cGNDejyHGghBcPK4PB+1DbRccJ0WV2a5FHeJ1dP4T3PF7ybRQps5
fHidQxDNkkv1b9AocsxpjXJ2c3LxXDbWGBN+5s/MmCP3ueYoH64MZEbM5EGZEo/g
8/XIDlrrCe3CXYvAxCjjafAw8+3dgrdLvkqmvtUVGb2vDWJgnFRrYP+KU89yT7H1
vZPKxV52nVaO7aM9EuN5bLatSQNgyiQwa02hXz6RbFPTQf5XOpja0Nm/TyNb1aol
7YxUWQpfiCydQdW+lzfa/7Em7rXZldwihDD/69VpKkinppathe2DoqzAr8hVkTFl
rwJyEWU5220p5tby5N9QHIQkajx7PvigbhmtLx/t7l3sgGb4wB3Lw2zSd0f739Kh
m6Qru1FOEVAW7ELEyD8b75upcT4tRnlDZfjbl5eHu/AyWt/lZoCVT8l9Syblrrl6
nYuzjCbzKGvkeD2wRfAuro7j3dh9VE+PIfUbGDvqmoKH27lJtWMLS2ek3zTEh95k
pvi1vc27W18oJ8bUdlpe9G5d6au5U/AhKuRFKkgNqltYjuTHwvU=
=o8eD
-----END PGP SIGNATURE-----

--waHxV1qIfKEUr127--

--===============7289955539523923673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7289955539523923673==--
