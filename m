Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7B6C47096
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 07:29:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222C5611CA
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 07:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222C5611CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF8E940177;
	Wed,  2 Jun 2021 07:29:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bOs3Pv85Y2pt; Wed,  2 Jun 2021 07:29:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id C90B7403A4;
	Wed,  2 Jun 2021 07:29:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77CA4C0026;
	Wed,  2 Jun 2021 07:29:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70253C0024
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7E5B4034B
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:29:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r9je_eqkmrYu for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 07:29:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4876401D2
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 07:29:20 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Fw0yh38RBz9sVt; Wed,  2 Jun 2021 17:29:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1622618956;
 bh=Kz6qjH+dnhao5Q20rjOPM++TAgs6jISL8RyW3dpgSC0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FTMeYGFoKYELSUpzJZHLjYOQ7Fmss/uSvM5IkjnKBMUtGtOBrkHkbAeAusPS7O14Q
 /Z2dilUEy3vGAigsxJiHHhxxl7avghBFF5qiSuMTiehV+ubKeemXFQGgeOJk9zLfAM
 5A00ahsUj+fefUCSlL8CA97DqOznjiVzjKMBH9f0=
Date: Wed, 2 Jun 2021 16:32:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <YLcl+zaK6Y0gB54a@yekko>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528173538.GA3816344@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210528173538.GA3816344@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============5721985340133174447=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5721985340133174447==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9kYDDwWLM5ffBHME"
Content-Disposition: inline


--9kYDDwWLM5ffBHME
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 28, 2021 at 02:35:38PM -0300, Jason Gunthorpe wrote:
> On Thu, May 27, 2021 at 07:58:12AM +0000, Tian, Kevin wrote:
[snip]
> > With above design /dev/ioasid uAPI is all about I/O address spaces.=20
> > It doesn't include any device routing information, which is only=20
> > indirectly registered to the ioasid driver through VFIO uAPI. For
> > example, I/O page fault is always reported to userspace per IOASID,
> > although it's physically reported per device (RID+PASID).=20
>=20
> I agree with Jean-Philippe - at the very least erasing this
> information needs a major rational - but I don't really see why it
> must be erased? The HW reports the originating device, is it just a
> matter of labeling the devices attached to the /dev/ioasid FD so it
> can be reported to userspace?

HW reports the originating device as far as it knows.  In many cases
where you have multiple devices in an IOMMU group, it's because
although they're treated as separate devices at the kernel level, they
have the same RID at the HW level.  Which means a RID for something in
the right group is the closest you can count on supplying.

[snip]
> > However this way significantly=20
> > violates the philosophy in this /dev/ioasid proposal. It is not one IOA=
SID=20
> > one address space any more. Device routing information (indirectly=20
> > marking hidden I/O spaces) has to be carried in iotlb invalidation and=
=20
> > page faulting uAPI to help connect vIOMMU with the underlying=20
> > pIOMMU. This is one design choice to be confirmed with ARM guys.
>=20
> I'm confused by this rational.
>=20
> For a vIOMMU that has IO page tables in the guest the basic
> choices are:
>  - Do we have a hypervisor trap to bind the page table or not? (RID
>    and PASID may differ here)
>  - Do we have a hypervisor trap to invaliate the page tables or not?
>=20
> If the first is a hypervisor trap then I agree it makes sense to create a
> child IOASID that points to each guest page table and manage it
> directly. This should not require walking guest page tables as it is
> really just informing the HW where the page table lives. HW will walk
> them.
>=20
> If there are no hypervisor traps (does this exist?) then there is no
> way to involve the hypervisor here and the child IOASID should simply
> be a pointer to the guest's data structure that describes binding. In
> this case that IOASID should claim all PASIDs when bound to a
> RID.=20

And in that case I think we should call that object something other
than an IOASID, since it represents multiple address spaces.

> Invalidation should be passed up the to the IOMMU driver in terms of
> the guest tables information and either the HW or software has to walk
> to guest tables to make sense of it.
>=20
> Events from the IOMMU to userspace should be tagged with the attached
> device label and the PASID/substream ID. This means there is no issue
> to have a a 'all PASID' IOASID.
>=20
> > Notes:
> > -   It might be confusing as IOASID is also used in the kernel (drivers/
> >     iommu/ioasid.c) to represent PCI PASID or ARM substream ID. We need
> >     find a better name later to differentiate.
>=20
> +1 on Jean-Philippe's remarks
>=20
> > -   PPC has not be considered yet as we haven't got time to fully under=
stand
> >     its semantics. According to previous discussion there is some gener=
ality=20
> >     between PPC window-based scheme and VFIO type1 semantics. Let's=20
> >     first make consensus on this proposal and then further discuss how =
to=20
> >     extend it to cover PPC's requirement.
>=20
> From what I understood PPC is not so bad, Nesting IOASID's did its
> preload feature and it needed a way to specify/query the IOVA range a
> IOASID will cover.
>=20
> > -   There is a protocol between vfio group and kvm. Needs to think about
> >     how it will be affected following this proposal.
>=20
> Ugh, I always stop looking when I reach that boundary. Can anyone
> summarize what is going on there?
>=20
> Most likely passing the /dev/ioasid into KVM's FD (or vicevera) is the
> right answer. Eg if ARM needs to get the VMID from KVM and set it to
> ioasid then a KVM "ioctl set_arm_vmid(/dev/ioasid)" call is
> reasonable. Certainly better than the symbol get sutff we have right
> now.
>=20
> I will read through the detail below in another email
>=20
> Jason
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9kYDDwWLM5ffBHME
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmC3JfgACgkQbDjKyiDZ
s5J3YA//TjUVjy2bj9AgMHYsHCsU7Weq5WJz03igxUG/IZ1BrvZWk3JDnEvciyO3
pnXBmEU9ocwIRdAHbcMw58Pfoyo6NCzzp2/MQBga0eYuXhBjnPpNZ8Pw4yUBjwTE
wQVS6XXBvJ5POKnh008kG3PYngM/Ebyv1q4A7pUYWI/h5G1HYD4zENQ9/rzkP7FG
e0rPLYl+BqEg2SV/94Ku4W3IX2byEg2adjRvVvMFQLj0rZ4SHo7moeLekc2fxSH5
0J5VLvY2xByTcloY+6P5KtTJJ9qHjU2tll2VIpJqAKAOVGbXyHLq8u/PBzjxfoLM
2N5zJNS1yfCSbXeqveJw8uXpzCeFLDW3aBMmJid1WAqxgH2x++2LBjR7F4YV6Vof
tAuNqXEdqNUBkc4c61Aeo/hozeVItcz5zqC6UrTSFjIvrHdW/HFaNwpUZmF7Yrmw
9Gxkuh2dBJJ0NXn+sutMyQaKHguue/z1gyapN3mYWKSakFTfZbdE23ObpD1koFT4
fAH32J1Q1a558nTA91AHkaKnU4AUANynCtkSSOcl0edZK9DyA+qzd5rqWvOrq3Le
eHeeNK6YdjB/LiVF9Zp+sMvA5pVc3oF9NucmU/m3qU1DCUmICAuUUsylnKLmFWLU
eL5UeSNVUE2i4REkMsZHS/M/Iw6LzYDKIJTJ0Jwm8/cU+R7vH9M=
=mSvq
-----END PGP SIGNATURE-----

--9kYDDwWLM5ffBHME--

--===============5721985340133174447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5721985340133174447==--
