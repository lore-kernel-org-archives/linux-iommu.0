Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E459EC2B9F4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:22:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00B4613CE
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00B4613CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87BFE82F6F;
	Thu, 17 Jun 2021 07:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MsV19lWueGy8; Thu, 17 Jun 2021 07:22:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 95DB681926;
	Thu, 17 Jun 2021 07:22:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72959C000E;
	Thu, 17 Jun 2021 07:22:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26536C0029
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 043A783DC2
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lqqy_X01S-BY for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 07:22:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6E6583DD5
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:16 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4G5D5W75dmz9sXN; Thu, 17 Jun 2021 17:22:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1623914528;
 bh=qHt4cdZnk75miSfGS18ZGHebQR5ivhD/A2lqaj41G0w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MFBPTGRFEVaNTvvFvlTgUWKwEc4kQPWOSalxsFmlF/dxovJu6UNpgXh06qmieAtla
 aTOsdeIpcRXrYzZ4M5ZysP3isWxuYVwSRue2XMxKO51w62GFXvTty/W2z2NR4Vc26v
 kGEdyjdkfH3HSbrNihVHLK5CK8XMgkoT3Stmj2Ig=
Date: Thu, 17 Jun 2021 14:45:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <YMrTeuUoqgzmSplL@yekko>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMCy48Xnt/aphfh3@8bytes.org> <20210609123919.GA1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210609123919.GA1002214@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============5184481683218297598=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5184481683218297598==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dBV3Ysu62aAbOUva"
Content-Disposition: inline


--dBV3Ysu62aAbOUva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 09:39:19AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 09, 2021 at 02:24:03PM +0200, Joerg Roedel wrote:
> > On Mon, Jun 07, 2021 at 02:58:18AM +0000, Tian, Kevin wrote:
> > > -   Device-centric (Jason) vs. group-centric (David) uAPI. David is n=
ot fully
> > >     convinced yet. Based on discussion v2 will continue to have ioasi=
d uAPI
> > >     being device-centric (but it's fine for vfio to be group-centric)=
=2E A new
> > >     section will be added to elaborate this part;
> >=20
> > I would vote for group-centric here. Or do the reasons for which VFIO is
> > group-centric not apply to IOASID? If so, why?
>=20
> VFIO being group centric has made it very ugly/difficult to inject
> device driver specific knowledge into the scheme.
>=20
> The device driver is the only thing that knows to ask:
>  - I need a SW table for this ioasid because I am like a mdev
>  - I will issue TLPs with PASID
>  - I need a IOASID linked to a PASID
>  - I am a devices that uses ENQCMD and vPASID
>  - etc in future

mdev drivers might know these, but shim drivers, like basic vfio-pci
often won't.  In that case only the userspace driver will know that
for certain.  The shim driver at best has a fairly loose bound on what
the userspace driver *could* do.

I still think you're having a tendency to partially conflate several
meanings of "group":
	1. the unavoidable hardware unit of non-isolation
	2. the kernel internal concept and interface to it
	3. the user visible fd and interface

We can't avoid having (1) somewhere, (3) and to a lesser extent (2)
are what you object to.

> The current approach has the group try to guess the device driver
> intention in the vfio type 1 code.

I agree this has gotten ugly.  What I'm not yet convinced of is that
reworking groups to make this not-ugly necessarily requires totally
minimizing the importance of groups.

> I want to see this be clean and have the device driver directly tell
> the iommu layer what kind of DMA it plans to do, and thus how it needs
> the IOMMU and IOASID configured.

>=20
> This is the source of the ugly symbol_get and the very, very hacky 'if
> you are a mdev *and* a iommu then you must want a single PASID' stuff
> in type1.
>=20
> The group is causing all this mess because the group knows nothing
> about what the device drivers contained in the group actually want.
>=20
> Further being group centric eliminates the possibility of working in
> cases like !ACS. How do I use PASID functionality of a device behind a
> !ACS switch if the uAPI forces all IOASID's to be linked to a group,
> not a device?
>=20
> Device centric with an report that "all devices in the group must use
> the same IOASID" covers all the new functionality, keep the old, and
> has a better chance to keep going as a uAPI into the future.
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dBV3Ysu62aAbOUva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmDK03gACgkQbDjKyiDZ
s5IDihAArTAIG0ZjpRdzkGG1oSy/yIILv/6kpvhvO41K7EWs7BoSD9wHWgKmNdOV
Z1/Wy1C+nITlY0c8Lfv94BziM+8f32AaoTbfekmzKYDcGHmZuBKmyLcHOulLsx78
OccGNfd4gFe9AsX7wMonxhTQEAjxGQOyqU+Fx1vnyUmhxypHx7iXdGosY+u1RaiN
uCNO0uHvslaEym/g11x1gTE02wAmd3eKpdl/Mdt9gMOB9Jq8kjr4inZf3NEOrPly
epHoghD1te2rQl5XZxJ/N9qrzofbpFuXwEfTBJyprctpFPF69iDK4i3txfb7JY6b
jFmwFSspVn2uzwmIW30dTvNDxwWqaIC+oHrzkYwGPF5Zc9NNRZdTbtJjbVafJTWr
eNnP4QzlRtlI/zcYQcvlnHgawL3O2w+MUvNWv9g8kxtFCbuqY1wMjcKIBle6ac/O
5Ln3MtAe2ZjwtRsmbsQL97XkjGaBtbNJHTtlBaJtY4x4fdND5CRvsOaPp/Nx0uLL
j8t+cr4WiBT7HP/68Ap0HZBqMWDjupyH30yWHDL4cWEIpSwFKb6Kwn8joGTLqhXS
BCXjR5EakXCp6fTkrtYOMqWRXp0dNpdLhsVphrMpzXyIB8wYtb2yRQlNW517/ccz
PDrwJgsax16LJkiIhq+5yGMzbUtiYOhvpU7B4KSQNn7d5y69Sn0=
=xxEr
-----END PGP SIGNATURE-----

--dBV3Ysu62aAbOUva--

--===============5184481683218297598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5184481683218297598==--
