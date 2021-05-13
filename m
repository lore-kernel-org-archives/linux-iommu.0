Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD173C43461
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 06:07:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9DF6142E
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 06:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9DF6142E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC05F60819;
	Thu, 13 May 2021 06:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OsShWu6Sbl_9; Thu, 13 May 2021 06:07:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E5276070D;
	Thu, 13 May 2021 06:07:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0ED12C0028;
	Thu, 13 May 2021 06:07:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8562CC000E
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 06:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DE8A40EEC
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 06:07:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oLOOn1a_V6ee for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 06:07:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3586340675
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 06:07:16 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Fgh5D6YwQz9sWl; Thu, 13 May 2021 16:07:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1620886032;
 bh=EDbwQxFNCJJrrEgHzT5gGi+1oWXpdmyJr1eJ+NUQ4bM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kWqsHMbOiAyxwLod+Rqt4KhSwB2oo0bV5TchI5WxvF3IL2lqztrJrQv615kgKUDnS
 rvOjRZCfVWenSYZrOWPrRga+vGFG2OWEIfQgUnlH6IFYpycIGoxJyhVRhtXU4RZ9Gc
 02pKAkrH9LTvDiy9LdpyASoaGfwW0N2RNDDTSEfE=
Date: Thu, 13 May 2021 16:07:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YJzCC18cQDdKMR6p@yekko>
References: <YIeYJZOdgMN/orl0@yekko.fritz.box>
 <20210427172432.GE1370958@nvidia.com>
 <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
 <20210429002149.GZ1370958@nvidia.com> <YIol9p3z8BTWFRh8@yekko>
 <20210503160530.GL1370958@nvidia.com> <YJDFj+sAv41JRIo4@yekko>
 <20210504181537.GC1370958@nvidia.com>
 <7e5c2276-ca1c-a8af-c15f-72a7c83c8bfa@ozlabs.ru>
 <20210505163902.GG1370958@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210505163902.GG1370958@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============1876923243086576895=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1876923243086576895==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/Mf++rjztzZShRAS"
Content-Disposition: inline


--/Mf++rjztzZShRAS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 05, 2021 at 01:39:02PM -0300, Jason Gunthorpe wrote:
> On Wed, May 05, 2021 at 02:28:53PM +1000, Alexey Kardashevskiy wrote:
>=20
> > This is a good feature in general when let's say there is a linux suppo=
rted
> > device which has a proprietary device firmware update tool which only e=
xists
> > as an x86 binary and your hardware is not x86 - running qemu + vfio in =
full
> > emulation would provide a way to run the tool to update a physical devi=
ce.
>=20
> That specific use case doesn't really need a vIOMMU though, does it?

Possibly not, but the mechanics needed to do vIOMMU on different host
IOMMU aren't really different from what you need for a no-vIOMMU
guest.  With a vIOMMU you need to map guest IOVA space into the host
IOVA space.  With no no-vIOMMU you need to map guest physical
addresses into the host IOVA space.  In either case the GPA/gIOVA to
userspace and userspace to HPA mappings are basically arbitrary.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/Mf++rjztzZShRAS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCcwgsACgkQbDjKyiDZ
s5JqLg/+Px9hBLz/IZ8N6Bl1BLwug0BbIEk1xxrBhtyubIdEbf6AuAkqa0HnxcSm
EgS1KJ0eOe3yLUKaLskepCJDojbuqFYnLf1VTv3Uu0zp5AP8ggKQgfokxUVJdhpR
aWMVjwOFAoUatYTP2umFN2ZfUsSxe/FsTkdTiAVApqn4AdTSlbGBvK+C4D7WPzZy
5rjVhgLfaQWJDGrTnhqCr4PJoz0z1FpOhzYXtpHR+u+d9BgDe2yj1gEFzICDk+UV
67QOqTNxWi1gSQ6uVa+xmB+xY0RZ7+x+fwObNBHrGWuFKJzwbf6aCQIprqEY5mro
9KAR0kP3LkywUN+rZjWQun9pXQdu/JWjZPtmdbm4rw+kIJEDdMk9TrOohOpjxUot
7vSoLVklFyMbnL84I3i7CELRxpkvtXaBd5VdGkEObg5nCcY8Fci8yLmhjOLXviGU
iNmRCaiZikT+JKvnwiG7qIILT3DCA92Y+AiQYayPkmujhlmzxpFkyAM1Igh7EIfe
a4O/U8qm61xxoTZhe+cbM11cIfiux8FwcxUrq54D1DCZstQ60IP/FaA4CQGSiBwm
55RNfJf+KFN9HG9hxH8BZYEGRtCYMuDfTjFdM0DaYHI8Rjv3X9MO4vuSI1tkoiQd
kW7n1QyP2QKMzSHCJlE56aSa9T6HTtUetOuO3vAxirN9Z5/042I=
=S/vm
-----END PGP SIGNATURE-----

--/Mf++rjztzZShRAS--

--===============1876923243086576895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1876923243086576895==--
