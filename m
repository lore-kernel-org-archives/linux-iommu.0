Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AF7C49EA7
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 04:52:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B93613D5
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 04:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B93613D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 58FA8403FA;
	Thu, 24 Jun 2021 04:52:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t_FNBOrPNUJA; Thu, 24 Jun 2021 04:52:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2927A403E7;
	Thu, 24 Jun 2021 04:52:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33DADC0029;
	Thu, 24 Jun 2021 04:52:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FB80C000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C4E8403ED
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xso9zEPtTTAQ for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 04:52:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E5DE400CE
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:27 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4G9SRT4N9jz9t0G; Thu, 24 Jun 2021 14:52:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1624510341;
 bh=IQ9z+FM1iAU3YGel/DdKjNbW4g2/iGQc7u1SOhwdQ0s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XrQJxQdJWPhjxVgCbCvSQiloi3rkVpfm2OknyTuLr5aJEyPSYbjaSQbwKTATK4Dh1
 a8jj2iFI0crcsm/IlvkPOx3yxN07wQw4ubXDYMVa3Ozx7AM41RbF2ER1ENOkGosarx
 VynjZgaWVK3oVxha+EdKVz8Phcc0ery4TQpvqyqE=
Date: Thu, 24 Jun 2021 14:26:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <YNQJY2Ji+KOBYWbt@yekko>
References: <20210614140711.GI1002214@nvidia.com>
 <20210614102814.43ada8df.alex.williamson@redhat.com>
 <MWHPR11MB1886239C82D6B66A732830B88C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615101215.4ba67c86.alex.williamson@redhat.com>
 <MWHPR11MB188692A6182B1292FADB3BDB8C0F9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210616133937.59050e1a.alex.williamson@redhat.com>
 <MWHPR11MB18865DF9C50F295820D038798C0E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210617151452.08beadae.alex.williamson@redhat.com>
 <20210618001956.GA1987166@nvidia.com>
 <MWHPR11MB1886A17124605251DF394E888C0D9@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1886A17124605251DF394E888C0D9@MWHPR11MB1886.namprd11.prod.outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, Robin Murphy <robin.murphy@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Shenming Lu <lushenming@huawei.com>,
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
Content-Type: multipart/mixed; boundary="===============2338867849928791192=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2338867849928791192==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BSFjbAhaUqNWeFX5"
Content-Disposition: inline


--BSFjbAhaUqNWeFX5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 18, 2021 at 04:57:40PM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, June 18, 2021 8:20 AM
> >=20
> > On Thu, Jun 17, 2021 at 03:14:52PM -0600, Alex Williamson wrote:
> >=20
> > > I've referred to this as a limitation of type1, that we can't put
> > > devices within the same group into different address spaces, such as
> > > behind separate vRoot-Ports in a vIOMMU config, but really, who cares?
> > > As isolation support improves we see fewer multi-device groups, this
> > > scenario becomes the exception.  Buy better hardware to use the devic=
es
> > > independently.
> >=20
> > This is basically my thinking too, but my conclusion is that we should
> > not continue to make groups central to the API.
> >=20
> > As I've explained to David this is actually causing functional
> > problems and mess - and I don't see a clean way to keep groups central
> > but still have the device in control of what is happening. We need
> > this device <-> iommu connection to be direct to robustly model all
> > the things that are in the RFC.
> >=20
> > To keep groups central someone needs to sketch out how to solve
> > today's mdev SW page table and mdev PASID issues in a clean
> > way. Device centric is my suggestion on how to make it clean, but I
> > haven't heard an alternative??
> >=20
> > So, I view the purpose of this discussion to scope out what a
> > device-centric world looks like and then if we can securely fit in the
> > legacy non-isolated world on top of that clean future oriented
> > API. Then decide if it is work worth doing or not.
> >=20
> > To my mind it looks like it is not so bad, granted not every detail is
> > clear, and no code has be sketched, but I don't see a big scary
> > blocker emerging. An extra ioctl or two, some special logic that
> > activates for >1 device groups that looks a lot like VFIO's current
> > logic..
> >=20
> > At some level I would be perfectly fine if we made the group FD part
> > of the API for >1 device groups - except that complexifies every user
> > space implementation to deal with that. It doesn't feel like a good
> > trade off.
> >=20
>=20
> Would it be an acceptable tradeoff by leaving >1 device groups=20
> supported only via legacy VFIO (which is anyway kept for backward=20
> compatibility), if we think such scenario is being deprecated over=20
> time (thus little value to add new features on it)? Then all new=20
> sub-systems including vdpa and new vfio only support singleton=20
> device group via /dev/iommu...

The case that worries me here is if you *thought* you had 1 device
groups, but then discover a hardware bug which means two things aren't
as isolated as you thought they were.  What do you do then?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BSFjbAhaUqNWeFX5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmDUCWMACgkQbDjKyiDZ
s5JgnBAAijxDul/b69WVeLvr273k1oikuFzryDz0SoUd6u2u3P7j6lAs+Dcv8JhT
1axAxKuR0AVeuXynUT+3495hpYmgk0oxgnVqv6aJN8mnClivsB8Np6X01ECSNvWE
sZCjNghU0iexB3mykPf3yNTT0GCOnLmSooAIuBd+EihcYCdMYWkCJlMzJFs5Q10f
BdHdbSft/nr+anGf7JNI5d+S5iZ/IadIU9/0Csz2jz52SmdYTTfp2aEPB8PTPcf+
+bF6xw1afgI+YvUn87Ortey5Vh1yvXWMoVNHD1YsY+/gtXeacONIYAewina44dim
nSzeeLRZH9lumHDaOl5Aa59cePtQ+1N5hSfSTTK9MNzutkVn7vmHivE9XugJ3lUO
NdrDbEhs5shVc/g4Te7yCagVc6F61z4onbsSCsJAw9s1IJcgqh9lytXPo91BoKM3
5RM/TV4Jp8Xege18mnEcv6rVcTp9FrBswbWR6cZG3gakVdF2KAvMFyqYHqzGRz9f
GaBPSkCddBxbghmHnDhCbU9nWZgoR2ieCCFEeqxj42vZj5sW9Jm5gVpzEQv1Wqem
vb4FjnRyiK14bx9P/mcZFwyWYcu8pZ/KZst6aKLB2mS62GzvnTJO8gnWzvHyer7s
Uw0G0wSCHLFFm4ubP01I7xv+Fa0h7R4hSrmUitr5aFYfMMF7bUY=
=v6Yg
-----END PGP SIGNATURE-----

--BSFjbAhaUqNWeFX5--

--===============2338867849928791192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2338867849928791192==--
