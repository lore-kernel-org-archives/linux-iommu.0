Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2588AC49EA6
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 04:52:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10D4613D8
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 04:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10D4613D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9272B414B8;
	Thu, 24 Jun 2021 04:52:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PlPR-mmLQg5F; Thu, 24 Jun 2021 04:52:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E9FD6406B0;
	Thu, 24 Jun 2021 04:52:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECAC8C0027;
	Thu, 24 Jun 2021 04:52:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55177C0026
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35F96838B2
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0oUn_bkyAkQZ for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 04:52:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E16382566
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 04:52:26 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4G9SRT30qxz9ssP; Thu, 24 Jun 2021 14:52:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1624510341;
 bh=FpIm54FE6NeqCxqbL0+8c9oXauOoa+mQCY0S1Ycsm2Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G8jf7PkBL5/ze8PFImyFkoexGFqI8nk7CgT7tlTfROXrRsyg2VcRntjvCQI3uU1Oe
 dt2CC7TWxaPDL7UoQqnqKqoiYka+3hFTy5mSdgKX0jJjO35mBMOMkK4eBldGZ2+BGd
 wApxJBx6nWyIHJd6aN4Ntw6atuvUlaetMQYrC3R8=
Date: Thu, 24 Jun 2021 14:03:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: Plan for /dev/ioasid RFC v2
Message-ID: <YNQEClb1nptFBIRB@yekko>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMCy48Xnt/aphfh3@8bytes.org> <20210609123919.GA1002214@nvidia.com>
 <14d884a8-13bc-b2ba-7020-94b219e3e2d9@linux.intel.com>
 <YMrcLcTL+cUKd1a5@yekko>
 <b9c48526-8b8f-ff9e-4ece-4a39f476e3b7@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <b9c48526-8b8f-ff9e-4ece-4a39f476e3b7@linux.intel.com>
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
Content-Type: multipart/mixed; boundary="===============5692107902111599619=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5692107902111599619==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VFbEwJIv4uDkQBMg"
Content-Disposition: inline


--VFbEwJIv4uDkQBMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 18, 2021 at 01:21:47PM +0800, Lu Baolu wrote:
> Hi David,
>=20
> On 6/17/21 1:22 PM, David Gibson wrote:
> > > The iommu_group can guarantee the isolation among different physical
> > > devices (represented by RIDs). But when it comes to sub-devices (ex. =
mdev or
> > > vDPA devices represented by RID + SSID), we have to rely on the
> > > device driver for isolation. The devices which are able to generate s=
ub-
> > > devices should either use their own on-device mechanisms or use the
> > > platform features like Intel Scalable IOV to isolate the sub-devices.
> > This seems like a misunderstanding of groups.  Groups are not tied to
> > any PCI meaning.  Groups are the smallest unit of isolation, no matter
> > what is providing that isolation.
> >=20
> > If mdevs are isolated from each other by clever software, even though
> > they're on the same PCI device they are in different groups from each
> > other*by definition*.  They are also in a different group from their
> > parent device (however the mdevs only exist when mdev driver is
> > active, which implies that the parent device's group is owned by the
> > kernel).
>=20
>=20
> You are right. This is also my understanding of an "isolation group".
>=20
> But, as I understand it, iommu_group is only the isolation group visible
> to IOMMU. When we talk about sub-devices (sw-mdev or mdev w/ pasid),
> only the device and device driver knows the details of isolation, hence
> iommu_group could not be extended to cover them. The device drivers
> should define their own isolation groups.

So, "iommu group" isn't a perfect name.  It came about because
originally the main mechanism for isolation was the IOMMU, so it was
typically the IOMMU's capabilities that determined if devices were
isolated.  However it was always known that there could be other
reasons for failure of isolation.  To simplify the model we decided
that we'd put things into the same group if they were non-isolated for
any reason.

The kernel has no notion of "isolation group" as distinct from "iommu
group".  What are called iommu groups in the kernel now *are*
"isolation groups" and that was always the intention - it's just not a
great name.

> Otherwise, the device driver has to fake an iommu_group and add hacky
> code to link the related IOMMU elements (iommu device, domain, group
> etc.) together. Actually this is part of the problem that this proposal
> tries to solve.

Yeah, that's not ideal.

> > > Under above conditions, different sub-device from a same RID device
> > > could be able to use different IOASID. This seems to means that we ca=
n't
> > > support mixed mode where, for example, two RIDs share an iommu_group =
and
> > > one (or both) of them have sub-devices.
> > That doesn't necessarily follow.  mdevs which can be successfully
> > isolated by their mdev driver are in a different group from their
> > parent device, and therefore need not be affected by whether the
> > parent device shares a group with some other physical device.  They
> > *might*  be, but that's up to the mdev driver to determine based on
> > what it can safely isolate.
> >=20
>=20
> If we understand it as multiple levels of isolation, can we classify the
> devices into the following categories?
>=20
> 1) Legacy devices
>    - devices without device-level isolation
>    - multiple devices could sit in a single iommu_group
>    - only a single I/O address space could be bound to IOMMU

I'm not really clear on what that last statement means.

> 2) Modern devices
>    - devices capable of device-level isolation

This will *typically* be true of modern devices, but I don't think we
can really make it a hard API distinction.  Legacy or buggy bridges
can force modern devices into the same group as each other.  Modern
devices are not immune from bugs which would force lack of isolation
(e.g. forgotten debug registers on function 0 which affect other
functions).

>    - able to have subdevices
>    - self-isolated, hence not share iommu_group with others
>    - multiple I/O address spaces could be bound to IOMMU
>=20
> For 1), all devices in an iommu_group should be bound to a single
> IOASID; The isolation is guaranteed by an iommu_group.
>=20
> For 2) a single device could be bound to multiple IOASIDs with each sub-
> device corresponding to an IOASID. The isolation of each subdevice is
> guaranteed by the device driver.
>=20
> Best regards,
> baolu
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VFbEwJIv4uDkQBMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmDUBAkACgkQbDjKyiDZ
s5KENg/+O5vNMk/Gf1anhpAHt8p8aR1xG8jQRwZv3xWAxDX8EW0DABiJq0AMlYfv
b0kbBTm/F38eVCt26dSGnmElA1+XYMLMMMiLVDMSt/XCySPf80XhWBg/6bDh0bZd
sV5HPZhH0Aw/w/q8OB0fshHbgz3Avg6FDL6+fR9k84FBozzleQH2m9krPO1CXTIK
H7l3B1n69DvlnHlXlYwG8wFNqTUniRBEP0qwu2d9nXp+kDYjMIg8x2sIHjJFfKUW
b8YLJb+tZGFGFtDlwYoucy8hveUiw4QcrCERbIpyT+riNa5AvKTjKI0URsACNYPC
NCLkNcGKikw+xDBlkLtA+lAOkFNOHJvRq3R4nyXTwRyw7KgTiekUf+TsbISqrRh8
ipBZVhPywZmoUD4zLGiaOfAljj9cVEkY+h7PUs9QZFREM3IUmerR4ydi+YuELgMT
jO3EMf/0t6wE42PaQVv9JnQX6SIBz/3mY8OSlQPnioq3D6AX+bZqlQnux7tUyk3e
uMqYsyPhruGsQ/N5kAERzUiL62blliXwWDMdQKcitgAcP/A9ZkyMZX0CkRLHNFBT
j1RsZqmuKc4Zd0KfW8iTwyu0h20vSpasodD0/BX4sJ987AaRbNPNcwAZWl/pAorr
Gnx284rNejbekR/FfeN7zXqKTKoEwq683EXHvIHl6JcQB/kUiZU=
=kwCA
-----END PGP SIGNATURE-----

--VFbEwJIv4uDkQBMg--

--===============5692107902111599619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5692107902111599619==--
