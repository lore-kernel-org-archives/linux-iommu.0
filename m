Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59821C47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:28:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20DF0613E6
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 06:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DF0613E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0100740518;
	Thu,  3 Jun 2021 06:28:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vxPgT3hJ_PJY; Thu,  3 Jun 2021 06:28:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D431C40503;
	Thu,  3 Jun 2021 06:28:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0272C000E;
	Thu,  3 Jun 2021 06:28:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDE44C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA06583E1D
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Un2VSRSgrZAr for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 06:28:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C705283E21
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 06:28:28 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4FwbYy6bWlz9sX2; Thu,  3 Jun 2021 16:28:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1622701702;
 bh=WIm/yDsJvGo2IyYCrLryCua0Hmg97K2CGLyxXv+Q9ns=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MwVFV04b8Vkcxdo2x6dhk0tnzgJz3ut+csIP+RAw6g/HzBXI4c2Pt3c/MbTLsSJAc
 gqqK4HNNn5sS+Zpr1zTxOVzVy5gCqutPE3Jrjj/24F2h5QffnQmiOB/NfMM91P/U7q
 VvtjxMwKhU+oFadGopeloE87r1Xr3yO/qZXs+3oM=
Date: Thu, 3 Jun 2021 15:54:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YLhupAfUWWiVMDVU@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com>
 <786295f7-b154-cf28-3f4c-434426e897d3@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <786295f7-b154-cf28-3f4c-434426e897d3@linux.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============2777972843682679284=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2777972843682679284==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e+xYKskxbIIXJ+YF"
Content-Disposition: inline


--e+xYKskxbIIXJ+YF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 01, 2021 at 07:09:21PM +0800, Lu Baolu wrote:
> Hi Jason,
>=20
> On 2021/5/29 7:36, Jason Gunthorpe wrote:
> > > /*
> > >    * Bind an user-managed I/O page table with the IOMMU
> > >    *
> > >    * Because user page table is untrusted, IOASID nesting must be ena=
bled
> > >    * for this ioasid so the kernel can enforce its DMA isolation poli=
cy
> > >    * through the parent ioasid.
> > >    *
> > >    * Pgtable binding protocol is different from DMA mapping. The latt=
er
> > >    * has the I/O page table constructed by the kernel and updated
> > >    * according to user MAP/UNMAP commands. With pgtable binding the
> > >    * whole page table is created and updated by userspace, thus diffe=
rent
> > >    * set of commands are required (bind, iotlb invalidation, page fau=
lt, etc.).
> > >    *
> > >    * Because the page table is directly walked by the IOMMU, the user
> > >    * must  use a format compatible to the underlying hardware. It can
> > >    * check the format information through IOASID_GET_INFO.
> > >    *
> > >    * The page table is bound to the IOMMU according to the routing
> > >    * information of each attached device under the specified IOASID. =
The
> > >    * routing information (RID and optional PASID) is registered when a
> > >    * device is attached to this IOASID through VFIO uAPI.
> > >    *
> > >    * Input parameters:
> > >    *	- child_ioasid;
> > >    *	- address of the user page table;
> > >    *	- formats (vendor, address_width, etc.);
> > >    *
> > >    * Return: 0 on success, -errno on failure.
> > >    */
> > > #define IOASID_BIND_PGTABLE		_IO(IOASID_TYPE, IOASID_BASE + 9)
> > > #define IOASID_UNBIND_PGTABLE	_IO(IOASID_TYPE, IOASID_BASE + 10)
> > Also feels backwards, why wouldn't we specify this, and the required
> > page table format, during alloc time?
> >=20
>=20
> Thinking of the required page table format, perhaps we should shed more
> light on the page table of an IOASID. So far, an IOASID might represent
> one of the following page tables (might be more):
>=20
>  1) an IOMMU format page table (a.k.a. iommu_domain)
>  2) a user application CPU page table (SVA for example)
>  3) a KVM EPT (future option)
>  4) a VM guest managed page table (nesting mode)
>=20
> This version only covers 1) and 4). Do you think we need to support 2),

Isn't (2) the equivalent of using the using the host-managed pagetable
then doing a giant MAP of all your user address space into it?  But
maybe we should identify that case explicitly in case the host can
optimize it.

> 3) and beyond? If so, it seems that we need some in-kernel helpers and
> uAPIs to support pre-installing a page table to IOASID. From this point
> of view an IOASID is actually not just a variant of iommu_domain, but an
> I/O page table representation in a broader sense.
>=20
> Best regards,
> baolu
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--e+xYKskxbIIXJ+YF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC4bqQACgkQbDjKyiDZ
s5IZ/g/+KfrQ7u5dkP+nHBSnZErWCCHdUTJQSRRNkFuuMXpagfwmkjGvQCUuw1Vg
lwgTWZHnvHUzMEGfyM2uwwk4qZFaUP6K5tjyS6TqF/AEOSL1FGejsdKCLRlWMhlG
vSKE6P1y8UKMpV4deJBNthXeUVqYftrw1hTezsca0c5ZtlUfflP/0vhlM1+Q2FYM
WDvlgdLS9rOlQ9FJvvfnWiu4nlFiok9dXKpC/mMDamUlr9VfWxalmfULAy0VqXSM
pQTdGekWaX4Gn1WLCIBBAxHqIs9w7fZKDBqGw21kE4Q+fOOueoN0EqQLHsW2Gaw0
AD1H7tsuqPqj8WAIaHE406NmlxtZ2yybW3p6LnOAFrewuTRyej3kiA9LWKr1Csik
1lr3N+eNkuFYyUzk/LZHgBPiNSchFfNxLJBzvx/S2e2VC04psM0A8GIJ1Q4ja87Z
3qihYVH6fMWaIpoxsEDEn3Lfkt7sfYpDa0MpHHTF3Dfhxr6Fi+GahrnLCMXsddkO
5Os6wSzQA2saANfLgb4iTTOsQoAftn4r7bC4cZTM/V+U1EcQTmZrW0mAhhRtUiO1
xMoE6Ac2rOh0B8bTrZWwAREXbGvZrepEa9qi5gysA76zOPNWnNJHW3Ox3n9XCafP
XgwTUTjVmzBheuZ5wonf6JWBc+pnxmLekZwCBTzhB1B4k4LXwKA=
=sS9E
-----END PGP SIGNATURE-----

--e+xYKskxbIIXJ+YF--

--===============2777972843682679284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2777972843682679284==--
