Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6D2C3F2CE
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 01:05:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8497246A6
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 01:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VSExQPM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8497246A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9D171863DC;
	Fri, 28 Feb 2020 01:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Y8gLLb1JLNY; Fri, 28 Feb 2020 01:04:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 73B09862BE;
	Fri, 28 Feb 2020 01:04:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 591CDC08A0;
	Fri, 28 Feb 2020 01:04:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B89FC0177;
 Fri, 28 Feb 2020 01:04:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3A45185DB1;
 Fri, 28 Feb 2020 01:04:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZxLb9JzzjR7i; Fri, 28 Feb 2020 01:04:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5278185B8D;
 Fri, 28 Feb 2020 01:04:54 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48TBCR4GXXz9sRR; Fri, 28 Feb 2020 12:04:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582851891;
 bh=bDF0YnZ0Ji7KIpNOME8A9+GnboyyHLm+51d5sgfbrXg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VSExQPM54mGS3q5ixPtCfJOcB9KtQ+FzWatNARyCA4xu7wLfK+gz0Ez94swVm2PMe
 q1bWrFrri/Ez/GKUaD8+ihbfU4GfFrXbRLT5HU3YbFqjaXhlU3udppCAi/1KL39awy
 DJTBNnHoW/jk6W+//WwyOVIHhKC7g/W256PliEQk=
Date: Fri, 28 Feb 2020 11:23:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
Message-ID: <20200228002353.GA1842@umbus.fritz.box>
References: <20200220161146.GA12709@lst.de>
 <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
 <20200220163135.GA13192@lst.de>
 <20200221032727.GC2298@umbus.fritz.box>
 <20200221140639.54928efe.pasic@linux.ibm.com>
 <20200221104724-mutt-send-email-mst@kernel.org>
 <20200221190702.68fd57fc.pasic@linux.ibm.com>
 <20200224033314.GC1751@umbus.fritz.box>
 <20200224194953.37c0d6b8.pasic@linux.ibm.com>
 <20200225190802.753cffef.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225190802.753cffef.cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, Michael Mueller <mimu@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
Content-Type: multipart/mixed; boundary="===============6990981550123344061=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6990981550123344061==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2020 at 07:08:02PM +0100, Cornelia Huck wrote:
> On Mon, 24 Feb 2020 19:49:53 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
>=20
> > On Mon, 24 Feb 2020 14:33:14 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Fri, Feb 21, 2020 at 07:07:02PM +0100, Halil Pasic wrote: =20
> > > > On Fri, 21 Feb 2020 10:48:15 -0500
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >  =20
> > > > > On Fri, Feb 21, 2020 at 02:06:39PM +0100, Halil Pasic wrote: =20
> > > > > > On Fri, 21 Feb 2020 14:27:27 +1100
> > > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > >  =20
> > > > > > > On Thu, Feb 20, 2020 at 05:31:35PM +0100, Christoph Hellwig w=
rote: =20
> > > > > > > > On Thu, Feb 20, 2020 at 05:23:20PM +0100, Christian Borntra=
eger wrote: =20
> > > > > > > > > >From a users perspective it makes absolutely perfect sen=
se to use the =20
> > > > > > > > > bounce buffers when they are NEEDED.=20
> > > > > > > > > Forcing the user to specify iommu_platform just because y=
ou need bounce buffers
> > > > > > > > > really feels wrong. And obviously we have a severe perfor=
mance issue
> > > > > > > > > because of the indirections. =20
> > > > > > > >=20
> > > > > > > > The point is that the user should not have to specify iommu=
_platform.
> > > > > > > > We need to make sure any new hypervisor (especially one tha=
t might require
> > > > > > > > bounce buffering) always sets it, =20
> > > > > > >=20
> > > > > > > So, I have draft qemu patches which enable iommu_platform by =
default.
> > > > > > > But that's really because of other problems with !iommu_platf=
orm, not
> > > > > > > anything to do with bounce buffering or secure VMs.
> > > > > > >=20
> > > > > > > The thing is that the hypervisor *doesn't* require bounce buf=
fering.
> > > > > > > In the POWER (and maybe s390 as well) models for Secure VMs, =
it's the
> > > > > > > *guest*'s choice to enter secure mode, so the hypervisor has =
no reason
> > > > > > > to know whether the guest needs bounce buffering.  As far as =
the
> > > > > > > hypervisor and qemu are concerned that's a guest internal det=
ail, it
> > > > > > > just expects to get addresses it can access whether those are=
 GPAs
> > > > > > > (iommu_platform=3Doff) or IOVAs (iommu_platform=3Don). =20
> > > > > >=20
> > > > > > I very much agree!
> > > > > >  =20
> > > > > > >  =20
> > > > > > > > as was a rather bogus legacy hack =20
> > > > > > >=20
> > > > > > > It was certainly a bad idea, but it was a bad idea that went =
into a
> > > > > > > public spec and has been widely deployed for many years.  We =
can't
> > > > > > > just pretend it didn't happen and move on.
> > > > > > >=20
> > > > > > > Turning iommu_platform=3Don by default breaks old guests, som=
e of which
> > > > > > > we still care about.  We can't (automatically) do it only for=
 guests
> > > > > > > that need bounce buffering, because the hypervisor doesn't kn=
ow that
> > > > > > > ahead of time. =20
>=20
> We could default to iommu_platform=3Don on s390 when the host has active
> support for protected virtualization... but that's just another kind of
> horrible, so let's just pretend I didn't suggest it.

Yeah, that would break migration between hosts with the feature and
hosts without - for everything, not just protected guests.  In general
any kind of guest visible configuration change based on host
properties is incompatible with the qemu/KVM migration model.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5YXZcACgkQbDjKyiDZ
s5LdKA//U9QbJilQoiEQCinA1xGVHP1Hm7w/1rqgbm4B30D4A7I3ioERM/uwdqkQ
ks4shzQNPfx3O2Bkiit5DGE/A4C9CODYVqjvPw0pDpMaYJI6tDVcjd3bgYhyE2QI
Gp5oQ4l40a4C5oUH9YYoOS7eyx0rg6q1HstQDyTtTUP8MURr5XsqMIU4086N8bDI
JrYkBRXTU/W5FCuHnKR8wUwuKGUqTu64yEtzlT40YuWCrUw2PRtaG6jjP9CMisqL
BS2ISdY2UeTZXNnavX0LycUAwUDo4gy/ux4TcSuzSii7A0ztiqqrbs/UFNs/GCUg
pfcr9JbU7dsT4po/YKERdQ/6PiYuVufHASLOhDdDw6pNVLyuTnzHgmRkWSrRV4NP
haSVx1u2JbRmJmO66RgJdt774tVxyDVIRhZprWlvg5yX0ad0TAHvx2MqitDgjCiV
XZdu7rCfKQVCXU35ODteapV9n+CguP8f2KYIVWXJIHCbjLg65nVr4moJNupn/5nd
kvhC+2MOoszj0PXtMEPTWe7N/H9KDfp4Vv861JhZL5pe3GluF9qsHDk/vHWuovCK
Vab8lroMXU5o345o4w70Cu/X+PO1lkVeml+MTI3c+hfZHcaGlvnsVehQGDYhwX4I
XvNb0jeVjkJJRHVxOIIgzD4PxiBaYtpfFV+cBvysaDf5aaCX2Zk=
=MCKa
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

--===============6990981550123344061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6990981550123344061==--
