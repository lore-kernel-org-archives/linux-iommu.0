Return-Path: <SRS0=nChL=KW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA12C4708B
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 07:12:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8618613DC
	for <iommu@archiver.kernel.org>; Thu, 27 May 2021 07:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8618613DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A515783CE7;
	Thu, 27 May 2021 07:12:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LwNxI1f7RswD; Thu, 27 May 2021 07:12:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 875DE83CC4;
	Thu, 27 May 2021 07:12:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C7B5C0025;
	Thu, 27 May 2021 07:12:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EA38C000E
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 07:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFFA9607DE
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 07:12:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g0FPMU9uY1Dt for <iommu@lists.linux-foundation.org>;
 Thu, 27 May 2021 07:12:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 59E4160733
 for <iommu@lists.linux-foundation.org>; Thu, 27 May 2021 07:12:26 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FrJsx2tB6z9sWp; Thu, 27 May 2021 17:12:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1622099541;
 bh=/Vk6QIsfClarCnHuWF3h00g/TTHnE4TtoS0mH61nSvk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PBJfr7UYZPAGjibTLx3tnWLHnRpaUShxpkGQgtqAMqSU1cRDoZa5GzhsXCRFM76n6
 /2dBtWmxbyYYr4V+CxP4PSVzAwF4AD4T2TGF1pIXK0c44UNAZyDsnE8zGdVBo4KZpb
 3ivmm4aCrXG/e3Jm6+/nRQqIJ3rfH7ZWRNAOeov4=
Date: Thu, 27 May 2021 14:58:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YK8m9jNuvEzlXWlu@yekko>
References: <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com> <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com> <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com> <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525195257.GG1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210525195257.GG1002214@nvidia.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "Wu, Hao" <hao.wu@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>
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
Content-Type: multipart/mixed; boundary="===============4372381017305676234=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4372381017305676234==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rKeY89V0ifZRRhP6"
Content-Disposition: inline


--rKeY89V0ifZRRhP6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 25, 2021 at 04:52:57PM -0300, Jason Gunthorpe wrote:
> On Wed, May 26, 2021 at 12:56:30AM +0530, Kirti Wankhede wrote:
>=20
> > 2. iommu backed mdev devices for SRIOV where mdev device is created per
> > VF (mdev device =3D=3D VF device) then that mdev device has same iommu
> > protection scope as VF associated to it.=20
>=20
> This doesn't require, and certainly shouldn't create, a fake group.

It's only fake if you start with a narrow view of what a group is.  A
group is a set of devices (in the kernel sense of "device", not
necessarily the hardware sense) which can't be isolated from each
other.  The mdev device is a kernel device, and if working as intended
it can be isolated from everything else, and is therefore in an
absolute bona fide group of its own.

> Only the VF's real IOMMU group should be used to model an iommu domain
> linked to a VF. Injecting fake groups that are proxies for real groups
> only opens the possibility of security problems like David is
> concerned with.

It's not a proxy for a real group, it's a group of its own.  If you
discover that (due to a hardware bug, for example) the mdev is *not*
properly isolated from its parent PCI device, then both the mdev
virtual device *and* the physical PCI device are in the same group.
Groups including devices of different types and on different buses
were considered from the start, and are precedented, if rare.

> Max's series approaches this properly by fully linking the struct
> pci_device of the VF throughout the entire VFIO scheme, including the
> group and container, while still allowing override of various VFIO
> operations.
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rKeY89V0ifZRRhP6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCvJvYACgkQbDjKyiDZ
s5IEqBAAp3p5NH8nnJVVcGSVZxbNrLeTTJqPwhNtEEsveVKJd5BmHf3EvT4BqqnK
rXisyd2ygrY8fO1DiLJOa/WM6FDA05WD0XkqyDJ2XUFAOEHpyY0EesSw7CqSl1zz
V2dbprWQAD9nJoPG/fidBsmuYEwpxjvptttrf1yEgFe+isfJLdalJbA+k/kfZOdd
F4BL6+mtySC2DoKnQqoDQYCsXrSNzsYgv6SDbj4W7izUuOqYFADN7qawINcxAEBa
I43JXW3Dhx3aLzL0JeEjFf2j/f1YMQo/RfkfLg9OWuHdsF+SF8+5lcikGWtjBZKT
pC443P1CHOmJkW0TMr9Pz2lHJfjlcTaIq35qpaEP23tKmS60FDoLIvWPlFJYidaz
tWDNMtMmS8UbcyzF868ZJiRc94+A8RTFFW7hSmHQoqLnxMqNnUoyOKrZ2ehaqg+j
JjbsxFq37+jun2Fb2BxwPg+F2jFQmaw7l6FCdhePKc/h/HeCRPpZ+jTqF6AEqdU1
KrET9bw9TE3euBNQK62gJNfdIdrkBelfcUjKluxCWamoHFeJBEnBKbqGR4wn0Jqg
QucFQtoKZyEIXVKFtK0Pedz46dzxc5iH1hj+eIAGLw92/SIjWzVYEp6vCZYHxNSk
VQFvdHTLJJ8vRVhLGJlo5Ji4EX+jgb9i7eIufxgqD+SxhzOoRvo=
=ygK9
-----END PGP SIGNATURE-----

--rKeY89V0ifZRRhP6--

--===============4372381017305676234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4372381017305676234==--
