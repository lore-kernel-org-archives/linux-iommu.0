Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14056C433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 06:28:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE57A60A9F;
	Thu, 28 Apr 2022 06:28:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5isRkhwKTK2S; Thu, 28 Apr 2022 06:28:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7BE8560A88;
	Thu, 28 Apr 2022 06:28:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 172A6C0039;
	Thu, 28 Apr 2022 06:28:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13F8AC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 06:28:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 018B0405B5
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 06:28:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BfCRjeaZSmHf for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 06:28:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2DE44027F
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 06:28:14 +0000 (UTC)
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
 id 4Kplzp22Nrz4ySX; Thu, 28 Apr 2022 16:28:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1651127286;
 bh=0B814dxJaRNgHX0ymjMRCIz8UmihQ/9vE3ArZl89JR0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F5Eijx8JxkipF5SM1J8vW/ZfFNU/gTPsGs4qkl0tPl6dhJy/+aQByH4C4TzEW+AYl
 jWOjyJkf70DA0sMIlS2X5jtVCTdJCoujW1FXtPcHkCwokuQECRvVUoscQyJj2pvi57
 cTiJLrWcQAAXM0zbY3WGdH3wvQFJxFNzaBs8jjOM=
Date: Thu, 28 Apr 2022 15:58:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 08/12] iommufd: IOCTLs for the io_pagetable
Message-ID: <YmotBkM103HqanoZ@yekko>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <8-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <YkUvzfHM00FEAemt@yekko> <20220331125841.GG2120790@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220331125841.GG2120790@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 iommu@lists.linux-foundation.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>
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
Content-Type: multipart/mixed; boundary="===============5028378758328105891=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5028378758328105891==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="332gL9uvgMOgNnaU"
Content-Disposition: inline


--332gL9uvgMOgNnaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2022 at 09:58:41AM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 31, 2022 at 03:36:29PM +1100, David Gibson wrote:
>=20
> > > +/**
> > > + * struct iommu_ioas_iova_ranges - ioctl(IOMMU_IOAS_IOVA_RANGES)
> > > + * @size: sizeof(struct iommu_ioas_iova_ranges)
> > > + * @ioas_id: IOAS ID to read ranges from
> > > + * @out_num_iovas: Output total number of ranges in the IOAS
> > > + * @__reserved: Must be 0
> > > + * @out_valid_iovas: Array of valid IOVA ranges. The array length is=
 the smaller
> > > + *                   of out_num_iovas or the length implied by size.
> > > + * @out_valid_iovas.start: First IOVA in the allowed range
> > > + * @out_valid_iovas.last: Inclusive last IOVA in the allowed range
> > > + *
> > > + * Query an IOAS for ranges of allowed IOVAs. Operation outside thes=
e ranges is
> > > + * not allowed. out_num_iovas will be set to the total number of iov=
as
> > > + * and the out_valid_iovas[] will be filled in as space permits.
> > > + * size should include the allocated flex array.
> > > + */
> > > +struct iommu_ioas_iova_ranges {
> > > +	__u32 size;
> > > +	__u32 ioas_id;
> > > +	__u32 out_num_iovas;
> > > +	__u32 __reserved;
> > > +	struct iommu_valid_iovas {
> > > +		__aligned_u64 start;
> > > +		__aligned_u64 last;
> > > +	} out_valid_iovas[];
> > > +};
> > > +#define IOMMU_IOAS_IOVA_RANGES _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_IO=
VA_RANGES)
> >=20
> > Is the information returned by this valid for the lifeime of the IOAS,
> > or can it change?  If it can change, what events can change it?
> >
> > If it *can't* change, then how do we have enough information to
> > determine this at ALLOC time, since we don't necessarily know which
> > (if any) hardware IOMMU will be attached to it.
>=20
> It is a good point worth documenting. It can change. Particularly
> after any device attachment.

Right.. this is vital and needs to be front and centre in the
comments/docs here.  Really, I think an interface that *doesn't* have
magically changing status would be better (which is why I was
advocating that the user set the constraints, and the kernel supplied
or failed outright).  Still I recognize that has its own problems.

> I added this:
>=20
>  * Query an IOAS for ranges of allowed IOVAs. Mapping IOVA outside these =
ranges
>  * is not allowed. out_num_iovas will be set to the total number of iovas=
 and
>  * the out_valid_iovas[] will be filled in as space permits. size should =
include
>  * the allocated flex array.
>  *
>  * The allowed ranges are dependent on the HW path the DMA operation take=
s, and
>  * can change during the lifetime of the IOAS. A fresh empty IOAS will ha=
ve a
>  * full range, and each attached device will narrow the ranges based on t=
hat
>  * devices HW restrictions.

I think you need to be even more explicit about this: which exact
operations on the fd can invalidate exactly which items in the
information from this call?  Can it only ever be narrowed, or can it
be broadened with any operations?

> > > +#define IOMMU_IOAS_COPY _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_COPY)
> >=20
> > Since it can only copy a single mapping, what's the benefit of this
> > over just repeating an IOAS_MAP in the new IOAS?
>=20
> It causes the underlying pin accounting to be shared and can avoid
> calling GUP entirely.

If that's the only purpose, then that needs to be right here in the
comments too.  So is expected best practice to IOAS_MAP everything you
might want to map into a sort of "scratch" IOAS, then IOAS_COPY the
mappings you actually end up wanting into the "real" IOASes for use?

Seems like it would be nicer for the interface to just figure it out
for you: I can see there being sufficient complications with that to
have this slightly awkward interface, but I think it needs a rationale
to accompany it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--332gL9uvgMOgNnaU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoULxWu4/Ws0dB+XtgypY4gEwYSIFAmJqLP8ACgkQgypY4gEw
YSJQhBAA0vbPYQkWajyUkrm7VrSShNBVj1XxBrzWLMKazGvweToud0V0W4HfBQo5
ju0BEq6McEvCbqpCgJz8K4lrVoaVCZrsXaanrocgvuqJ5REhlMT7asmJtQFT5bkk
j2poJPC7ByZEtBFtA0toLrvVo9J4JqTJ0sMzLGqYPmYmps3MOBCUa2K6j0VIRwXd
1+pMjmrCg16aZcabN2yOPnVjB/LosjUw2fv9vQvFjoT0SW7jmmOSjRSIB7i75NtN
TK4akZ3kS6fnS/3suoWuQ2ivvQPyJwQjhbXZ1EtVcegVtZjypBeEufw9TfQ7w/Wu
xNXOoZaTCmH+1/vTGgxFe4mwd3wR2a7UwIxRdkgh0l4HAaGkdaFv7VLrcXfZyJfi
RALENQJWnL/h44WXonbzy0V8EGB1exL9aMXSHlIcXpjg0VpRtHHnUg6B7euBSesQ
akTUBBU4yJynrwng9wm/XLxa+r58T5HYMXhAoLjpGAZg6+ZIxBmXsT3z2hAB5X1g
r/CCIDKzQQGIeR/Hruq0xt3TimCWz9jgOCstqi3EX0MXMenkOC3Ydp6mGH17Yx3l
QGcjYiAmdWcayN3dxsL/IfZyfEq2vGh+m+fCRAyicuf6f7eUh+vV0yWrxBHRdCsw
1vGjnrk64oDnaKX9lXOCPFoGFB/Q+GzWNaDexZW7AI2bhSsoaYY=
=zSej
-----END PGP SIGNATURE-----

--332gL9uvgMOgNnaU--

--===============5028378758328105891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5028378758328105891==--
