Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00CCC43462
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 06:07:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7052561432
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 06:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7052561432
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D24F607AE;
	Thu, 13 May 2021 06:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LJPpSrTWcywQ; Thu, 13 May 2021 06:07:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2EF8606C1;
	Thu, 13 May 2021 06:07:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86E7DC000E;
	Thu, 13 May 2021 06:07:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D082AC0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 06:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C4F14400BE
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 06:07:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sUAJP64NS9r2 for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 06:07:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C131400AE
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 06:07:15 +0000 (UTC)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Fgh5D6CF8z9sWP; Thu, 13 May 2021 16:07:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1620886032;
 bh=/axulpG0xr9w+zByZ9r8VsYsgvrRJR6F1vnx+4ZliIY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VCSg73m0p+0am+zuLt6xE9E+0pTgC38t8MJxZYRLSYnb7CqfnMt5j/KRUc9ZMvP5H
 bKjdMIoW+za0YAW8dTA//AV2s5AG1e/VN56fKRbS2bl/8cwIRcOXTFBgMpqrCfC2LH
 7d1OO640z6ZxZOvRZaPFfTIKjvSWBys3UPD/42y4=
Date: Thu, 13 May 2021 16:01:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YJzAsBNF1irJxRGg@yekko>
References: <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com>
 <YIeYJZOdgMN/orl0@yekko.fritz.box>
 <20210427172432.GE1370958@nvidia.com>
 <YIi5G4Wg/hpFqNdX@yekko.fritz.box>
 <20210429002149.GZ1370958@nvidia.com> <YIol9p3z8BTWFRh8@yekko>
 <20210503160530.GL1370958@nvidia.com> <YJDFj+sAv41JRIo4@yekko>
 <20210504181537.GC1370958@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210504181537.GC1370958@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Li Zefan <lizefan@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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
Content-Type: multipart/mixed; boundary="===============3470451628319693166=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3470451628319693166==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C5zTqZzJn85FYpd8"
Content-Disposition: inline


--C5zTqZzJn85FYpd8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 04, 2021 at 03:15:37PM -0300, Jason Gunthorpe wrote:
> On Tue, May 04, 2021 at 01:54:55PM +1000, David Gibson wrote:
> > On Mon, May 03, 2021 at 01:05:30PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Apr 29, 2021 at 01:20:22PM +1000, David Gibson wrote:
> > > > > There is a certain appeal to having some
> > > > > 'PPC_TCE_CREATE_SPECIAL_IOASID' entry point that has a wack of ex=
tra
> > > > > information like windows that can be optionally called by the vio=
mmu
> > > > > driver and it remains well defined and described.
> > > >=20
> > > > Windows really aren't ppc specific.  They're absolutely there on x86
> > > > and everything else as well - it's just that people are used to hav=
ing
> > > > a window at 0..<something largish> that you can often get away with
> > > > treating it sloppily.
> > >=20
> > > My point is this detailed control seems to go on to more than just
> > > windows. As you say the vIOMMU is emulating specific HW that needs to
> > > have kernel interfaces to match it exactly.
> >=20
> > It's really not that bad.  The case of emulating the PAPR vIOMMU on
> > something else is relatively easy, because all updates to the IO page
> > tables go through hypercalls.  So, as long as the backend IOMMU can
> > map all the IOVAs that the guest IOMMU can, then qemu's implementation
> > of those hypercalls just needs to put an equivalent mapping in the
> > backend, which it can do with a generic VFIO_DMA_MAP.
>=20
> So you also want the PAPR vIOMMU driver to run on, say, an ARM IOMMU?

Well, I don't want to preclude it in the API.  I'm not sure about that
specific example, but in most cases it should be possible to run the
PAPR vIOMMU on an x86 IOMMU backend.  Obviously only something you'd
want to do for testing and experimentation, but it could be quite
useful for that.

> > vIOMMUs with page tables in guest memory are harder, but only really
> > in the usual ways that a vIOMMU of that type is harder (needs cache
> > mode or whatever).  At whatever point you need to shadow from the
> > guest IO page tables to the host backend, you can again do that with
> > generic maps, as long as the backend supports the necessary IOVAs, and
> > has an IO page size that's equal to or a submultiple of the vIOMMU
> > page size.
>=20
> But this definitely all becomes HW specific.
>=20
> For instance I want to have an ARM vIOMMU driver it needs to do some
>=20
>  ret =3D ioctl(ioasid_fd, CREATE_NESTED_IOASID, [page table format is ARM=
vXXX])
>  if (ret =3D=3D -EOPNOTSUPP)
>      ret =3D ioctl(ioasid_fd, CREATE_NORMAL_IOASID, ..)
>      // and do completely different and more expensive emulation
>=20
> I can get a little bit of generality, but at the end of the day the
> IOMMU must create a specific HW layout of the nested page table, if it
> can't, it can't.

Erm.. I don't really know how your IOASID interface works here.  I'm
thinking about the VFIO interface where maps and unmaps are via
explicit ioctl()s, which provides an obvious point to do translation
between page table formats.

But.. even if you're exposing page tables to userspace.. with hardware
that has explicit support for nesting you can probably expose the hw
tables directly which is great for the cases that works for.  But
surely for older IOMMUs which don't do nesting you must have some way
of shadowing guest IO page tables to host IO page tables to translate
GPA to HPA at least?  If you're doing that, I don't see that
converting page table format is really any harder

> > > I'm remarking that trying to unify every HW IOMMU implementation that
> > > ever has/will exist into a generic API complete enough to allow the
> > > vIOMMU to be created is likely to result in an API too complicated to
> > > understand..
> >=20
> > Maybe not every one, but I think we can get a pretty wide range with a
> > reasonable interface. =20
>=20
> It sounds like a reasonable guideline is if the feature is actually
> general to all IOMMUs and can be used by qemu as part of a vIOMMU
> emulation when compatible vIOMMU HW is not available.
>=20
> Having 'requested window' support that isn't actually implemented in
> every IOMMU is going to mean the PAPR vIOMMU emulation won't work,
> defeating the whole point of making things general?

The trick is that you don't necessarily need dynamic window support in
the backend to emulate it in the vIOMMU.  If your backend has fixed
windows, then you emulate request window as:
	if (requested window is within backend windows)
		no-op;
	else
		return ERROR;

It might not be a theoretically complete emulation of the vIOMMU, but
it can support in-practice usage.  In particular it works pretty well
if your backend has a nice big IOVA range (like x86 IOMMUS) but your
guest platform typically uses relatively small IOVA windows.  PAPR on
x86 is exactly that... well.. possibly not the 64-bit window, but
because of old PAPR platforms that didn't support that, we can choose
not to advertise that and guests will cope.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C5zTqZzJn85FYpd8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmCcwK4ACgkQbDjKyiDZ
s5JsAA/+Ksb/SZNvr50y/TBaIPbfqcmhfoheOmJcHkEPdFWbaRuS82h6gBlIFdFQ
kV6VtLhX/ndrjto/oKqm7HWkSMx8gBQMoKwJCIbvQ1qesonLVpDqC03ZPK0X63Ew
43TjSo/De1e5pql3UnEbxiVbBduKVGy1S8JbYMbsnodh2SHgO5IKx8WwEXkoqGc8
SDUkOw6L/bdX0hrKDsrzNaZUZUgBOLKxFaInwyVI5z8LrY86mQaeyIxWDwtZ8IBK
YC0DcfoGSZpmI7cueapG3Y5nlleUg4HgqG3Ku5Ax/Q8TM/1PQq1HtNdc0FxEqlaE
cqezKQobuSPUXWk5Vc56IT9l+m6hhCGGpCWVKouS61BQU7tGLdulYYLGm1UWYZIW
cdk/npdqROu3MQllMCR+T7m6kQhsKn6bLTdPjx4WxMcfYigfPKB3KvUnGejucmOz
BRvcxIfMY9GQj7IKQtARFLRfxT6owerpQE0gaz6XXbR53yTIF2uaNcO3jIl6nyna
jK7ZG5GqifCs9E/qLmrvPkRC5fodM5MSyDPlInet4XL7lVDyz5di/S34s3IZ7rdM
rzjMtb4BqktP1x4YStXMdxh4eaHDb16BId+WSngPrMp3CKYDqaHtClXRb4ZCoiSP
oK82KitpY+PC/SjpJByud+WdpfSnLJnGIP811H3Ct405EYcKw0Q=
=EaCb
-----END PGP SIGNATURE-----

--C5zTqZzJn85FYpd8--

--===============3470451628319693166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3470451628319693166==--
