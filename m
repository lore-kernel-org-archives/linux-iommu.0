Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57934C48BE5
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:22:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A61613CE
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A61613CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3BE182F8B;
	Thu, 17 Jun 2021 07:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wcm63p-B4o-W; Thu, 17 Jun 2021 07:22:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 09C4B823E8;
	Thu, 17 Jun 2021 07:22:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99E34C0023;
	Thu, 17 Jun 2021 07:22:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89D4AC000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78D8460761
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3MJsVBT8e6SL for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 07:22:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5987E6070B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:18 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4G5D5X0Rcrz9sX1; Thu, 17 Jun 2021 17:22:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1623914528;
 bh=cv9SO0hR36Zcr4ac50I3juTYJZKB4nHG5BIWoMEa7HU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SrHIuOMI6KkBFE0XphoxAhqxIbSomglcOjfWzG2pRKq+fMlpdJGC7ht3vlkI4Aumk
 T3GgdaSnI7DqFMrwNxLgFwaMIpVIjPuzAU3LeBt5H/nzAPIRviS3DvWX+z4EaAYsLY
 4rsEDmf2kSgaaT5t4+LRse8bz6TuDynlENtHAgZo=
Date: Thu, 17 Jun 2021 15:29:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <YMrduqZj970sMC12@yekko>
References: <YMCy48Xnt/aphfh3@8bytes.org> <20210609123919.GA1002214@nvidia.com>
 <YMDC8tOMvw4FtSek@8bytes.org> <20210609150009.GE1002214@nvidia.com>
 <YMDjfmJKUDSrbZbo@8bytes.org>
 <20210609101532.452851eb.alex.williamson@redhat.com>
 <20210609102722.5abf62e1.alex.williamson@redhat.com>
 <20210609184940.GH1002214@nvidia.com>
 <20210610093842.6b9a4e5b.alex.williamson@redhat.com>
 <20210611164529.GR1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210611164529.GR1002214@nvidia.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
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
Content-Type: multipart/mixed; boundary="===============7875968582262564642=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7875968582262564642==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6z+5/HR0ORsYRart"
Content-Disposition: inline


--6z+5/HR0ORsYRart
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 11, 2021 at 01:45:29PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 10, 2021 at 09:38:42AM -0600, Alex Williamson wrote:
>=20
> > Opening the group is not the extent of the security check currently
> > required, the group must be added to a container and an IOMMU model
> > configured for the container *before* the user can get a devicefd.
> > Each devicefd creates a reference to this security context, therefore
> > access to a device does not exist without such a context.
>=20
> Okay, I missed that detail in the organization..
>=20
> So, if we have an independent vfio device fd then it needs to be
> kept disable until the user joins it to an ioasid that provides the
> security proof to allow it to work?
>=20
> > What happens on detach?  As we've discussed elsewhere in this thread,
> > revoking access is more difficult than holding a reference to the
> > secure context, but I'm under the impression that moving a device
> > between IOASIDs could be standard practice in this new model.  A device
> > that's detached from a secure context, even temporarily, is a
> > problem.
>=20
> This is why I think the single iommu FD is critical, it is the FD, not
> the IOASID that has to authorize the security. You shouldn't move
> devices between FDs, but you can move them between IOASIDs inside the
> same FD.
>=20
> > How to label a device seems like a relatively mundane issue relative to
> > ownership and isolated contexts of groups and devices.  The label is
> > essentially just creating an identifier to device mapping, where the
> > identifier (label) will be used in the IOASID interface, right?=20
>=20
> It looks that way
>=20
> > As I note above, that makes it difficult for vfio to maintain that a
> > user only accesses a device in a secure context.  This is exactly
> > why vfio has the model of getting a devicefd from a groupfd only
> > when that group is in a secure context and maintaining references to
> > that secure context for each device.  Split ownership of the secure
> > context in IOASID vs device access in vfio and exposing devicefds
> > outside the group is still a big question mark for me.  Thanks,
>=20
> I think the protection model becomes different once we allow
> individual devices inside a group to be attached to different
> IOASID's.

I'm really wary of this.  They might be rare, but we still need to
consider the case of devices which can't be distinguished on the bus,
and therefore can't be attached to different IOASIDs.  That means that
if we allow attaching devices within a group to different IOASIDs we
effectively need to introduce two levels of "group-like" things.
First the idenfication group, then the isolation group.


You're using "group" for the isolation group, but then we have to
somehow expose this concept of identification group.  That seems like
a heap of complexity and confusion in the interface.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6z+5/HR0ORsYRart
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmDK3boACgkQbDjKyiDZ
s5I9kxAA0QukseY3jKTmf0dc22wGxjZPOcBjHPo0Q0kDkFXxDCKbE+OFmwIS/Udr
lQ2sAThf1Oy9CRMarmqN12YOtr+a02CHa+L87P4//PYb3KxVSUnfk/67MUm4KBRI
Amkn4QWgJEXeSZRp7GjftpDjZ9hoLURDUPJRPJnDb5j0zliw/eSI4IbhIVt31XLf
4l0ADlAaPyvwPvMPVSQSF7uIvSRsVr3M/RRWZjj6MSgJPwIMqaA7RXv8GGqutzc3
JFwVbI5X8AfUgDdNrRpj4HPwo32+hCvAu7g70/rKSruGjAzQM2k45b8GzfQOAXPF
JjRcSVxenCzbNmP7XlB1ZcBNQanp5KhkVReMISh2GVins129nJ2drZvaCmHUcq2v
92ppg1uqYxQgjeRQoccuwQDvJ0dTmtPldoPbCKVDm/0nauz6htcyThh5No4Kcsl8
RLl7mDukYKEX5yYCiTt2gBIjDCkO6foBotyuRwSGmQkTlUMDuQ1xTodnbfWRvLCF
87OvDiYomV+elvPx06+oOPZVqHlifFa+dFN61o/m1HiJQV7Gr3ZB8wkBsDp69WYe
FjVbJE+gDtPdZXkbS36QVY98zNWhp9wX5c4Gtl7erAzEWwgmrlg8KoD0smPKN0SQ
z9gTR1QD7S9KxWsPQF/bf76tdecS9CGOGHmch9JbstjJU3JO3pM=
=+5am
-----END PGP SIGNATURE-----

--6z+5/HR0ORsYRart--

--===============7875968582262564642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7875968582262564642==--
