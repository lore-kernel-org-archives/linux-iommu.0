Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3220BC49EA2
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:22:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB4B613D5
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB4B613D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86E2D41616;
	Thu, 17 Jun 2021 07:22:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Go4tcD0b931; Thu, 17 Jun 2021 07:22:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8607641620;
	Thu, 17 Jun 2021 07:22:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2EECC002A;
	Thu, 17 Jun 2021 07:22:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF158C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 852D34161A
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 223B8sLdtJKb for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 07:22:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 598F64159E
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:19 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4G5D5X1pwnz9sfG; Thu, 17 Jun 2021 17:22:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1623914528;
 bh=STE+d2uTnkvdb42HamLd+MfBt9F8tUHB2UkclaEK7v8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PNq/C0LPf1BgWwCaRdZtEEDQVl7d9At1bLkWjoJSrAw0T6UF3ViXg5+mvjNwQ+9jv
 /wp0Y+Dn/tG5KfQf+IhgjPpwuW/selVgFMdz4WuREir4QoCn1+fymt+nnDNkpARVWN
 IjcHbdRMrkybcDavtdz1q58To3+VDiUMf6jHogDU=
Date: Thu, 17 Jun 2021 15:22:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <YMrcLcTL+cUKd1a5@yekko>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMCy48Xnt/aphfh3@8bytes.org> <20210609123919.GA1002214@nvidia.com>
 <14d884a8-13bc-b2ba-7020-94b219e3e2d9@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <14d884a8-13bc-b2ba-7020-94b219e3e2d9@linux.intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "parav@mellanox.com" <parav@mellanox.com>,
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
Content-Type: multipart/mixed; boundary="===============6526735122346786631=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6526735122346786631==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qg4Qzsx5xFwMhlcX"
Content-Disposition: inline


--Qg4Qzsx5xFwMhlcX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 10, 2021 at 01:50:22PM +0800, Lu Baolu wrote:
> On 6/9/21 8:39 PM, Jason Gunthorpe wrote:
> > On Wed, Jun 09, 2021 at 02:24:03PM +0200, Joerg Roedel wrote:
> > > On Mon, Jun 07, 2021 at 02:58:18AM +0000, Tian, Kevin wrote:
> > > > -   Device-centric (Jason) vs. group-centric (David) uAPI. David is=
 not fully
> > > >      convinced yet. Based on discussion v2 will continue to have io=
asid uAPI
> > > >      being device-centric (but it's fine for vfio to be group-centr=
ic). A new
> > > >      section will be added to elaborate this part;
> > > I would vote for group-centric here. Or do the reasons for which VFIO=
 is
> > > group-centric not apply to IOASID? If so, why?
> > VFIO being group centric has made it very ugly/difficult to inject
> > device driver specific knowledge into the scheme.
> >=20
> > The device driver is the only thing that knows to ask:
> >   - I need a SW table for this ioasid because I am like a mdev
> >   - I will issue TLPs with PASID
> >   - I need a IOASID linked to a PASID
> >   - I am a devices that uses ENQCMD and vPASID
> >   - etc in future
> >=20
> > The current approach has the group try to guess the device driver
> > intention in the vfio type 1 code.
> >=20
> > I want to see this be clean and have the device driver directly tell
> > the iommu layer what kind of DMA it plans to do, and thus how it needs
> > the IOMMU and IOASID configured.
> >=20
> > This is the source of the ugly symbol_get and the very, very hacky 'if
> > you are a mdev*and*  a iommu then you must want a single PASID' stuff
> > in type1.
> >=20
> > The group is causing all this mess because the group knows nothing
> > about what the device drivers contained in the group actually want.
> >=20
> > Further being group centric eliminates the possibility of working in
> > cases like !ACS. How do I use PASID functionality of a device behind a
> > !ACS switch if the uAPI forces all IOASID's to be linked to a group,
> > not a device?
> >=20
> > Device centric with an report that "all devices in the group must use
> > the same IOASID" covers all the new functionality, keep the old, and
> > has a better chance to keep going as a uAPI into the future.
>=20
> The iommu_group can guarantee the isolation among different physical
> devices (represented by RIDs). But when it comes to sub-devices (ex. mdev=
 or
> vDPA devices represented by RID + SSID), we have to rely on the
> device driver for isolation. The devices which are able to generate sub-
> devices should either use their own on-device mechanisms or use the
> platform features like Intel Scalable IOV to isolate the sub-devices.

This seems like a misunderstanding of groups.  Groups are not tied to
any PCI meaning.  Groups are the smallest unit of isolation, no matter
what is providing that isolation.

If mdevs are isolated from each other by clever software, even though
they're on the same PCI device they are in different groups from each
other *by definition*.  They are also in a different group from their
parent device (however the mdevs only exist when mdev driver is
active, which implies that the parent device's group is owned by the
kernel).

> Under above conditions, different sub-device from a same RID device
> could be able to use different IOASID. This seems to means that we can't
> support mixed mode where, for example, two RIDs share an iommu_group and
> one (or both) of them have sub-devices.

That doesn't necessarily follow.  mdevs which can be successfully
isolated by their mdev driver are in a different group from their
parent device, and therefore need not be affected by whether the
parent device shares a group with some other physical device.  They
*might* be, but that's up to the mdev driver to determine based on
what it can safely isolate.

> AIUI, when we attach a "RID + SSID" to an IOASID, we should require that
> the RID doesn't share the iommu_group with any other RID.
>=20
> Best regards,
> baolu
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qg4Qzsx5xFwMhlcX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmDK3CsACgkQbDjKyiDZ
s5IlrBAAwxFTrL8LAB2uQXstokS55+p2jxYUo/fOIk5+cfRY6geiV+GbzkG/xTod
k7QlN4g8dKSVLrHUnsqisNjAgO3y82Xedjs65Z1NzK2H+d1NUEZWvshZiraj/UkJ
9oAiDT7Vjso/HVTChuBOG/XpKvWCLVw/hjUB50msuwGcujvyjC8Wjg55t4hEJ+rE
2oV+hyxthPMIT3a/bxBbLegwXDJUCSZaDF7HzhHmbxUmMA6CxijfFHN3gJUE9NTk
Ilknrr5hDeDZOxjWhs9Fe3eRiD3dI75X8t33HGbFX5WM1tlz+6AGauoWBDoRYqGW
4LmrhHiNDLP2aS83/UKEoa2euTcjqS0vFzm0DhIpBBCrtX6W7mXOzJxBCBC6B8m/
HuwNVtA1R3NWmKOojtBoYXPouAecAvyeRW1QFPXzzSnoiQ8QEQW/p7lnusfIKIM1
2x2c4cL3pHpDspHY+juuDWK4Y7iM8RKRyvEHdfdXK2k1PDBhNsa8Jteo+gdXtIMO
SqXGCZjHV4d6RWfMUplc+4BJbVIJVzU7QB5j3fSNd2DYUSRS4LTpbP4RaA2jESJ0
aW9kXhCq1DazqnP6gTA5LDgRYWOT9VBOpCw51keQmQqehsvg/0v1mM6HV8IPnAf3
UyurYxCaU3lApcGqNOxk+hLdU7Fcd9B0WVMgKl3eqgMLxHFbxaE=
=X5QH
-----END PGP SIGNATURE-----

--Qg4Qzsx5xFwMhlcX--

--===============6526735122346786631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6526735122346786631==--
