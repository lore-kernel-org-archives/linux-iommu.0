Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5EFC47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 03:01:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C02060BBB
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 03:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C02060BBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F269F402DE;
	Tue,  8 Jun 2021 03:01:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CGhzXYUn6r5M; Tue,  8 Jun 2021 03:01:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2595402A5;
	Tue,  8 Jun 2021 03:01:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87DF1C000B;
	Tue,  8 Jun 2021 03:01:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10AB2C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 03:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E95C4402DE
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 03:01:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jcyNfqzkHJoS for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 03:01:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1EA0402A5
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 03:01:21 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FzZkl2nPqz9sW8; Tue,  8 Jun 2021 13:01:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1623121279;
 bh=+41T/Fw5wyPRXDBoLIrJVctPmPOR2fLwaGL92NdGutM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SqA5VOBzVmGy0akKvS+MCkyhOJD08nQlmYgJrmV6flYJlP2DQD9ocY0Ml6+0E3nAz
 OadDFSFgeCUP5YqI96oVelNHj61AdbHJc8uZvC8kT5LG/pelInS9EqKfd52Uyv4kSA
 FzkjpzFS2H+SGCTR/IpFTh7+vgIW2G72ERaIYlw4=
Date: Tue, 8 Jun 2021 12:37:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YL7X0FKj+r6lIHQZ@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601162225.259923bc.alex.williamson@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210601162225.259923bc.alex.williamson@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Robin Murphy <robin.murphy@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, David Woodhouse <dwmw2@infradead.org>,
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
Content-Type: multipart/mixed; boundary="===============0783981537077809713=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0783981537077809713==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oBD7VOjePs9Ih+1P"
Content-Disposition: inline


--oBD7VOjePs9Ih+1P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 01, 2021 at 04:22:25PM -0600, Alex Williamson wrote:
> On Tue, 1 Jun 2021 07:01:57 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >=20
> > I summarized five opens here, about:
> >=20
> > 1)  Finalizing the name to replace /dev/ioasid;
> > 2)  Whether one device is allowed to bind to multiple IOASID fd's;
> > 3)  Carry device information in invalidation/fault reporting uAPI;
> > 4)  What should/could be specified when allocating an IOASID;
> > 5)  The protocol between vfio group and kvm;
> >=20
> ...
> >=20
> > For 5), I'd expect Alex to chime in. Per my understanding looks the
> > original purpose of this protocol is not about I/O address space. It's
> > for KVM to know whether any device is assigned to this VM and then
> > do something special (e.g. posted interrupt, EPT cache attribute, etc.).
>=20
> Right, the original use case was for KVM to determine whether it needs
> to emulate invlpg, so it needs to be aware when an assigned device is
> present and be able to test if DMA for that device is cache coherent.
> The user, QEMU, creates a KVM "pseudo" device representing the vfio
> group, providing the file descriptor of that group to show ownership.
> The ugly symbol_get code is to avoid hard module dependencies, ie. the
> kvm module should not pull in or require the vfio module, but vfio will
> be present if attempting to register this device.
>=20
> With kvmgt, the interface also became a way to register the kvm pointer
> with vfio for the translation mentioned elsewhere in this thread.
>=20
> The PPC/SPAPR support allows KVM to associate a vfio group to an IOMMU
> page table so that it can handle iotlb programming from pre-registered
> memory without trapping out to userspace.

To clarify that's a guest side logical vIOMMU page table which is
partially managed by KVM.  This is an optimization - things can work
without it, but it means guest iomap/unmap becomes a hot path because
each map/unmap hypercall has to go
	guest -> KVM -> qemu -> VFIO

So there are multiple context transitions.

> > Because KVM deduces some policy based on the fact of assigned device,=
=20
> > it needs to hold a reference to related vfio group. this part is irrele=
vant
> > to this RFC.=20
>=20
> All of these use cases are related to the IOMMU, whether DMA is
> coherent, translating device IOVA to GPA, and an acceleration path to
> emulate IOMMU programming in kernel... they seem pretty relevant.
>=20
> > But ARM's VMID usage is related to I/O address space thus needs some
> > consideration. Another strange thing is about PPC. Looks it also levera=
ges
> > this protocol to do iommu group attach: kvm_spapr_tce_attach_iommu_
> > group. I don't know why it's done through KVM instead of VFIO uAPI in
> > the first place.
>=20
> AIUI, IOMMU programming on PPC is done through hypercalls, so KVM needs
> to know how to handle those for in-kernel acceleration.  Thanks,

For PAPR guests, which is the common case, yes.  Bare metal POWER
hosts have their own page table format.  And probably some of the
newer embedded ppc models have some different IOMMU model entirely,
but I'm not familiar with it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oBD7VOjePs9Ih+1P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC+184ACgkQbDjKyiDZ
s5JotxAAu7wyTRuzaeVBDinjoZv5Pl9RRpRqYDd2zlWolEfYafahsPvJkI7hv0dz
q+7xnWDEDbjXyYO8/lIRgJ3xogF95Z4y8K88XmoEin+L0ZHpb6enfZzrxB5Wk/bw
HY4spyt45O7b8U5/bp7P3qiwPT8NcCW8Ba75DkBSpWPhZdmluH/1O78UUGeuqq4N
GNcF3MsHUR5H30m4NLuwAOv97OT5bb0aKHeb6rd1nJn+nyWwW+Bpnc8iuRAxzcEL
px4QBQYRH0ItJdgor8dnukxz1Evro63sS8VO+53SXtt4XUOgd9x8aHt0r+EluhCn
n7a1y2en1yHc7QEKl8gEB1u4GKm0rwP74jp0+VTgw+eQJujrjIeN1sMdXYKX6dZ8
hB4CMrJ5h2E6QCJso0vxgdaWy0sk+HOSObkIErwVktrCDZaf/H+Cqvvvncgt82Ym
ZiiLQaUbTJA7KwxHWjS8YC7L00Wzl2rBqCcH6OpJa1haBjnsEI2HmLxe7cj0pvuQ
YOeJ62QR8TJ9/p41kYca/+K/TAKMafWpZxYRSWJ9WMkjzpwvxhBG6sQPlvlIJUEH
90fO+gxMGBZb+M9LIL6XWqeIboY12kuAJ2GySNS8N8l2CBnWo/HyR+Cmetrheskc
eU53/BcWtXFrZrOP55nISiVQzajP4/FYjjRUeR5+u2PMYdGopyQ=
=Vo9Z
-----END PGP SIGNATURE-----

--oBD7VOjePs9Ih+1P--

--===============0783981537077809713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0783981537077809713==--
