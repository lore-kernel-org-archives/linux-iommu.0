Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C3BC4709A
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:28:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23DF613E4
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23DF613E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1E6C4058D;
	Thu,  3 Jun 2021 06:28:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PmtfBCuRolJV; Thu,  3 Jun 2021 06:28:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 529BA40596;
	Thu,  3 Jun 2021 06:28:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D103BC0024;
	Thu,  3 Jun 2021 06:28:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C699C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 661B840597
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sIouiRBGS1xc for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 06:28:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 15FD24058D
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:24 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FwbYy4cPTz9s5R; Thu,  3 Jun 2021 16:28:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1622701702;
 bh=IEEiXT5ukbF9bVCRBbDqCX5LlE3sy5L+2Kdn6s28K58=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KIR+GzyhRu27toheHJDd50KhCPCJbP3gDGUuXZldNPxbTzZf7XO7iP7Va6FbAKtVw
 oMW2lSGDSJAAs3IwkPuecVOEzpLPFN5RrCse9tETBTjAv5q7b8inQprCzFkEGGT/7I
 jm7CC6cD+WQ8xfciulygEFE9O20QtHmyjblCEgeA=
Date: Thu, 3 Jun 2021 15:23:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YLhnRbJJqPUBiRwa@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528195839.GO1002214@nvidia.com>
 <MWHPR11MB1886A17F36CF744857C531148C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601175643.GQ1002214@nvidia.com> <YLcr8B7EPDCejlWZ@yekko>
 <20210602163753.GZ1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210602163753.GZ1002214@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============2983875341296008439=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2983875341296008439==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ct7l8sovhYah/GNA"
Content-Disposition: inline


--ct7l8sovhYah/GNA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 2021 at 01:37:53PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 02, 2021 at 04:57:52PM +1000, David Gibson wrote:
>=20
> > I don't think presence or absence of a group fd makes a lot of
> > difference to this design.  Having a group fd just means we attach
> > groups to the ioasid instead of individual devices, and we no longer
> > need the bookkeeping of "partial" devices.
>=20
> Oh, I think we really don't want to attach the group to an ioasid, or
> at least not as a first-class idea.
>=20
> The fundamental problem that got us here is we now live in a world
> where there are many ways to attach a device to an IOASID:

I'm not seeing that that's necessarily a problem.

>  - A RID binding
>  - A RID,PASID binding
>  - A RID,PASID binding for ENQCMD

I have to admit I haven't fully grasped the differences between these
modes.  I'm hoping we can consolidate at least some of them into the
same sort of binding onto different IOASIDs (which may be linked in
parent/child relationships).

>  - A SW TABLE binding
>  - etc
>=20
> The selection of which mode to use is based on the specific
> driver/device operation. Ie the thing that implements the 'struct
> vfio_device' is the thing that has to select the binding mode.

I thought userspace selected the binding mode - although not all modes
will be possible for all devices.

> group attachment was fine when there was only one mode. As you say it
> is fine to just attach every group member with RID binding if RID
> binding is the only option.
>=20
> When SW TABLE binding was added the group code was hacked up - now the
> group logic is choosing between RID/SW TABLE in a very hacky and mdev
> specific way, and this is just a mess.

Sounds like it.  What do you propose instead to handle backwards
compatibility for group-based VFIO code?

> The flow must carry the IOASID from the /dev/iommu to the vfio_device
> driver and the vfio_device implementation must choose which binding
> mode and parameters it wants based on driver and HW configuration.
>=20
> eg if two PCI devices are in a group then it is perfectly fine that
> one device uses RID binding and the other device uses RID,PASID
> binding.

Uhhhh... I don't see how that can be.  They could well be in the same
group because their RIDs cannot be distinguished from each other.

> The only place I see for a "group bind" in the uAPI is some compat
> layer for the vfio container, and the implementation would be quite
> different, we'd have to call each vfio_device driver in the group and
> execute the IOASID attach IOCTL.
>=20
> > > I would say no on the container. /dev/ioasid =3D=3D the container, ha=
ving
> > > two competing objects at once in a single process is just a mess.
> >=20
> > Right.  I'd assume that for compatibility, creating a container would
> > create a single IOASID under the hood with a compatiblity layer
> > translating the container operations to iosaid operations.
>=20
> It is a nice dream for sure
>=20
> /dev/vfio could be a special case of /dev/ioasid just with a different
> uapi and ending up with only one IOASID. They could be interchangable
> from then on, which would simplify the internals of VFIO if it
> consistently delt with these new ioasid objects everywhere. But last I
> looked it was complicated enough to best be done later on
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ct7l8sovhYah/GNA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC4Z0UACgkQbDjKyiDZ
s5JVmBAAvFLHQONjTSmYF0VpXWkFjszZDezpbL/wjXpuJp+d8d/JHfGH1jaP+UeJ
dBm4x2+wg5ObhI1DY/Q8OTrTKud71LvN8FayexQ0SKkqzaFTyXvEzP2vr30N2Svc
qzxReZfDkXPneWNb/IqdVO5KgxVgtNR+tgIlCiFAndJdOcjTPfC38zr3ceNbKn7Q
kofsipS61OUwkj7X7mUEuzajdYDDQ3yfPGbuI6XY2dJbQd1+Bgv9yfA71yruIw3L
5JenqmBlO9oJcvU09Db8wZe7iT27Jh5Jl/LAAzSoaVOb8lZkVRKLETgKHRx9SfDf
xwsIDCpOQ5jtClK4qpGmpATkNgd2q6S7uqb8GsXTXCVxV4GMHKLaDRTGCK4m3hx0
XPmTZDS3NDShGjeUVvrGNosIriXb0UaWzugtLpvGyRe6U53p9tL8khNUIUKZysrX
uHH0SxwwK8+4ke8+zPVn48Y6CE1IYWKVHb3oeLmgYLF28W4Qo2FmoVHlO+Go+Z4C
kh1yKIIm6phXqwIxVn4pFIi5A5u/pnsSVdod3Ll93xTf/Th3fmjAeAeOy9XU3Wf8
Qp9RmpMopPQARqDDY74Scbg2IxlzM/ks3rqGcKg/aUTaQl5Fhxzan7F5daKsHf1e
92Ou5VpiV0KKg4FDe160et4u4x/qAjq+ROSkB8I+HoGyZSw6Nsk=
=6Lix
-----END PGP SIGNATURE-----

--ct7l8sovhYah/GNA--

--===============2983875341296008439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2983875341296008439==--
