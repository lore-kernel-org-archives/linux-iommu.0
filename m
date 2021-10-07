Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65F6C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 01:23:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A59F611CA
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 01:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A59F611CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0B9A841D9;
	Thu,  7 Oct 2021 01:23:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1SMvCzFmAxIu; Thu,  7 Oct 2021 01:23:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A16CE841C9;
	Thu,  7 Oct 2021 01:23:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82DC8C0011;
	Thu,  7 Oct 2021 01:23:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45FBBC000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 01:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1AF0C60678
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 01:23:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id orLDw76fibxs for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 01:23:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1356560813
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 01:23:26 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4HPtqp36Vbz4xbG; Thu,  7 Oct 2021 12:23:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1633569798;
 bh=qstVtDT91XWliCaW5kitB3WljFF05mjQismqLt2KJ+A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n70FR0j9KTEGEzxwCxf2JDFXaUu8zShyp+4N0lscr1waf+K/ZgaxwyX9ZowdEeqyT
 93j/gp22nAcMRYODT0LPRwZZf8hod6y0LuY2l71D1O/R3Do5F53fEXCE37Ph8arTyB
 8uacyxaJkPxNRjhkPqJtBB70Xzz+taoWwt0m2ERk=
Date: Thu, 7 Oct 2021 12:23:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 07/20] iommu/iommufd: Add iommufd_[un]bind_device()
Message-ID: <YV5MAdzR6c2knowf@yekko>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-8-yi.l.liu@intel.com>
 <YVP44v4FVYJBSEEF@yekko> <20210929122457.GP964074@nvidia.com>
 <YVUqpff7DUtTLYKx@yekko> <20211001124322.GN964074@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211001124322.GN964074@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============0798083812396306327=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0798083812396306327==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KDKmP08LDN9ERU6o"
Content-Disposition: inline


--KDKmP08LDN9ERU6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 01, 2021 at 09:43:22AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 30, 2021 at 01:10:29PM +1000, David Gibson wrote:
> > On Wed, Sep 29, 2021 at 09:24:57AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 29, 2021 at 03:25:54PM +1000, David Gibson wrote:
> > >=20
> > > > > +struct iommufd_device {
> > > > > +	unsigned int id;
> > > > > +	struct iommufd_ctx *ictx;
> > > > > +	struct device *dev; /* always be the physical device */
> > > > > +	u64 dev_cookie;
> > > >=20
> > > > Why do you need both an 'id' and a 'dev_cookie'?  Since they're both
> > > > unique, couldn't you just use the cookie directly as the index into
> > > > the xarray?
> > >=20
> > > ID is the kernel value in the xarray - xarray is much more efficient &
> > > safe with small kernel controlled values.
> > >=20
> > > dev_cookie is a user assigned value that may not be unique. It's
> > > purpose is to allow userspace to receive and event and go back to its
> > > structure. Most likely userspace will store a pointer here, but it is
> > > also possible userspace could not use it.
> > >=20
> > > It is a pretty normal pattern
> >=20
> > Hm, ok.  Could you point me at an example?
>=20
> For instance user_data vs fd in io_uring

Ok, but one of those is an fd, which is an existing type of handle.
Here we're introducing two different unique handles that aren't an
existing kernel concept.

> RDMA has many similar examples.
>=20
> More or less anytime you want to allow the kernel to async retun some
> information providing a 64 bit user_data lets userspace have an easier
> time to deal with it.

I absolutely see the need for user_data.  What I'm questioning is
having two different, user-visible unique handles, neither of which is
an fd.


That said... is there any strong reason why user_data needs to be
unique?  I can imagine userspace applications where you don't care
which device the notification is coming from - or at least don't care
down to the same granularity that /dev/iommu is using.  In which case
having the kernel provided unique handle and the
not-necessarily-unique user_data would make perfect sense.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KDKmP08LDN9ERU6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmFeTAAACgkQbDjKyiDZ
s5IHfA//dHZrmxuC2Eg7GpSZRzPqLOFtDPTlZ/fOS0A3Ww2bU6S+CuugltvCz+U2
KZ65d6W7oAiRDmaxTdPARsY/JsYFSu+jGnVfYI4ZUf/N6v0NIInS5L5z31og1nhu
VYPLtYEPenL5Ikj/e3Ul9E6l5AqLcRqRw/j5G83ygQB3Wk93LdeF/p8wdEvEt599
U5V8JbGKUYzBySYD4+m6EhhYpAEagGRRltJE10AZm4WB9w6KbjkrQryg7zSfbbEo
ulwVrlY/IBzHmbBi82IQOiXFIZkdbvuigelt34UPdMSVj50Wmo4t/bxyTbRGk9O8
YMGa0Y5l0bH6gtl1M/e9Gq3rEwGrjSP/GyvLCZSv1D3nAti/WK7INv9NVEz1E74O
frugTJBSsodRVz31hMt+WDT5NTTv+F+xQjEnFZTcCeogHvDissXh2wnhUXSi5kQq
g8GcJfG621SrtvulFlFIhjgtXqxPzRJm+uXWTI5ESCA7+3g79Pr5kKo9UTiRK1c1
HtB8mM70Hp+vOmWSZ5D3wYZX4ImXpcWdHk0y0c1O0QQVmFF07iyqjVXu+A6r/A5y
ly8PwxvM0gnM7Ewuz37YXpGTgeiCTVaUVPITz09GN1mMqYa2V0l1X3q/G5iwb/g8
0SqR8HFGjS87nbngGm/vjD/AscCOHePTMrFQvN/GFytfMWdJO3c=
=VYju
-----END PGP SIGNATURE-----

--KDKmP08LDN9ERU6o--

--===============0798083812396306327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0798083812396306327==--
