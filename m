Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F9AC49EA2
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:22:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F7F613B9
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F7F613B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0132841615;
	Thu, 17 Jun 2021 07:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vkSyvWZaVpcz; Thu, 17 Jun 2021 07:22:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E6A524161B;
	Thu, 17 Jun 2021 07:22:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2EFDAC002B;
	Thu, 17 Jun 2021 07:22:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D73F8C000E
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4DB76070B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Ne0EN83CYYw for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 07:22:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4CF460712
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:22:10 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4G5D5W5TCzz9sW7; Thu, 17 Jun 2021 17:22:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1623914527;
 bh=SOP0ABK+iUiJMHZ7HHdWKegAXFZNs1FMpwMu7wdh2Vk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=asxABNpKVjGvMtPoB/4lZ/JTHY+ovIMWCaskss412VS4kabClUi1J85yuPDLfOjEg
 PTwWhn5bIcy9l7eIPQhlEjZHF94PehVquR9HHFuu20tNQiTA6KISIjNpfqloJAd/ws
 bNN4vp+/190EVPl/FPqallzEXYZ1fHC52e7xW6SM=
Date: Thu, 17 Jun 2021 13:47:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YMrF2BV0goTIPbrN@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528200311.GP1002214@nvidia.com>
 <MWHPR11MB188685D57653827B566BF9B38C3E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210601162225.259923bc.alex.williamson@redhat.com>
 <YL7X0FKj+r6lIHQZ@yekko> <20210608131756.GF1002214@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210608131756.GF1002214@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Robin Murphy <robin.murphy@arm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, David Woodhouse <dwmw2@infradead.org>,
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
Content-Type: multipart/mixed; boundary="===============2733701699138097225=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2733701699138097225==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j3oeW5Y91uLYui5m"
Content-Disposition: inline


--j3oeW5Y91uLYui5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 08, 2021 at 10:17:56AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 08, 2021 at 12:37:04PM +1000, David Gibson wrote:
>=20
> > > The PPC/SPAPR support allows KVM to associate a vfio group to an IOMMU
> > > page table so that it can handle iotlb programming from pre-registered
> > > memory without trapping out to userspace.
> >=20
> > To clarify that's a guest side logical vIOMMU page table which is
> > partially managed by KVM.  This is an optimization - things can work
> > without it, but it means guest iomap/unmap becomes a hot path because
> > each map/unmap hypercall has to go
> > 	guest -> KVM -> qemu -> VFIO
> >=20
> > So there are multiple context transitions.
>=20
> Isn't this overhead true of many of the vIOMMUs?

Yes, but historically it bit much harder on POWER for a couple of reasons:

1) POWER guests *always* have a vIOMMU - the platform has no concept
   of passthrough mode.  We therefore had a vIOMMU implementation some
   time before the AMD or Intel IOMMUs were implemented as vIOMMUs in
   qemu.

2) At the time we were implementing this the supported IOVA window for
   the paravirtualized IOMMU was pretty small (1G, I think) making
   vIOMMU maps and unmaps a pretty common operation.

> Can the fast path be
> generalized?

Not really.  This is a paravirtualized guest IOMMU, so it's a platform
specific group of hypercalls that's being interpreted by KVM and
passed through to the IOMMU side using essentially the same backend
that that the userspace implementation would eventually get to after a
bunch more context switches.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--j3oeW5Y91uLYui5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmDKxdYACgkQbDjKyiDZ
s5Ih/A//YE3M7mMfFiKum31pHFC6pkSqy9q9fAc/ME7yP9WGeJuLNv4ONxJMsgDj
mE/9QC/SsU+6o+Vp1pLOVtUHHE/siI5G+cbKX7HA0dWbgn1faPT/C51NjpeVho6x
z/MsgI8zuDEXQpzJjncfTvCZh8j8uZYwUTiZU1QlwJ5Gr70LLCb+fnKvFDRjDhDa
N3SjUvfrUeknOz9tmnpETy/Ju0E6njTeyssXH/VCwZGcqV7p5LMbACsZ3Np9s5Fq
uRUYAIOhDCCucTdEwgggd2xIrVvfUBA/dm7vp31okvqHRfL0gCiLHtATlop3p/ZO
GZDtkJFXYB2nEw5DNbK4Rr2uDt76PjIU2U0WztLpzZW7bblr8eM7uURallS8QHhr
mMDRsjTXb3CTt4gPLbq7xayffp8Jc/AG5XzSutHgBXY0v8JeGM7MxhGv25NRkifS
ebJ+QyC6uxMSPhnlg4XLJ8MFzrSnMRUUuiit7FH71oEdu2AH4w5IuuG1SDg2A5PW
jgj0kOKiVg7JO+ZIXY8j9x08oT5s2tdAcfxfoqjrr9AmVBa/W6zk/wCjfYVnep+0
cJPh3VUC2zmkRvlizuU6HbP0vOdFcrIxqpSk67xAH4pgx2Sh+DLDWOpmZX5jJawH
pHiHepB/VJU1+zpvUNMEymFrgZUZ3+tSp3+qf7LkMRhMkrg4QE4=
=pfJz
-----END PGP SIGNATURE-----

--j3oeW5Y91uLYui5m--

--===============2733701699138097225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2733701699138097225==--
