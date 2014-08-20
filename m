From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Wed, 20 Aug 2014 07:21:46 +0200
Message-ID: <20140820052144.GA13793@ulmo>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
 <2348740.xICP2AxYHy@avalon>
 <53F39A18.70409@codeaurora.org>
 <2767102.8U6hAaZh2n@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2767102.8U6hAaZh2n@avalon>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Olav Haugan <ohaugan@codeaurora.org>, Joerg Roedel <joro@8bytes.org>, laurent.pinchart+renesas@ideasonboard.com, konrad.wilk@oracle.com, mitchelh@codeaurora.org, linux-arm-msm@vger.kernel.org, will.deacon@arm.com, iommu@lists.linux-foundation.org, robdclark@gmail.com, Varun.Sethi@freescale.com, kgene.kim@samsung.com, dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org, hdoyu@nvidia.com
List-Id: iommu@lists.linux-foundation.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2014 at 10:52:46PM +0200, Laurent Pinchart wrote:
> On Tuesday 19 August 2014 11:40:24 Olav Haugan wrote:
> > On 8/19/2014 9:11 AM, Laurent Pinchart wrote:
> > > On Tuesday 19 August 2014 13:59:54 Joerg Roedel wrote:
> > >> On Mon, Aug 18, 2014 at 03:47:56PM -0700, Olav Haugan wrote:
> > >>> If the alignment is not correct then iommu_map() will return error.=
 Not
> > >>> sure what other option we have here (and why make it different beha=
vior
> > >>> than iommu_map which just return error when it is not aligned prope=
rly).
> > >>> I don't think we want to force any kind of alignment automatically.=
 I
> > >>> would rather have the API tell me I am doing something wrong than h=
aving
> > >>> the function aligning the values and possibly undermap or overmap.
> > >>=20
> > >> But sg->offset is an offset into the page (at least it is used that =
way
> > >> in the DMA-API and since you do 'page_len =3D s->offset + s->length'=
 you
> > >> use it the same way).
> > >> So when you pass iova + offset the result will no longer be
> > >> page-aligned. You should force sg->offset =3D=3D 0 and sg->length to=
 be
> > >> page-aligned instead. This makes more sense because the IOMMU-API wo=
rks
> > >> on (io)-page granularity and not on arbitrary phys-addr ranges like =
the
> > >> DMA-API.
> > >>=20
> > >>> Yes, I am aware of that. However, several people prefer this than
> > >>> passing in scatterlist. It is not very convenient to pass a scatter=
list
> > >>> in some use cases. Someone mentioned a use case where they would ha=
ve to
> > >>> create a dummy sg list and populate it with the iova just to do an
> > >>> unmap. I believe we would have to do this also. There is no use for
> > >>> sglist when unmapping. However, would like to keep separate API from
> > >>> iommu_unmap() to keep the API function names symmetric
> > >>> (map_sg/unmap_sg).
> > >>=20
> > >> Keeping it symetric is not more complicated, the caller just needs to
> > >> keep the sg-list used for mapping around. I prefer the unmap_sg call=
 to
> > >> work in sg-lists too.
> > >=20
> > > Do we have a use case where the unmap_sg() implementation would be
> > > different than a plain iommu_unmap() call ? If not I'd rather remove
> > > unmap_sg() completely.
> > >=20
> > >>> I thought that was why we added the default fallback and set all the
> > >>> drivers to point to these fallback functions. Several people wanted=
 this
> > >>> so that we don't have to have NULL-check in these functions (and ha=
ve
> > >>> the functions be simple inline functions).
> > >>=20
> > >> Okay, since you add these call-backs to all drivers I think I can li=
ve
> > >> with not doing a pointer check here.
> > >=20
> > > I suggested doing a
> > >=20
> > > if (ops is not NULL)
> > >=20
> > > 	return ops();
> > >=20
> > > else
> > >=20
> > > 	return default_ops();
> > >=20
> > > to avoid modifying all drivers. I'm not sure why that wasn't received=
 with
> > > much enthusiasm.
> >=20
> > Both Thierry R. and Konrad W. argued for modifying the drivers instead
> > so I implemented what the majority wanted. :-)
>=20
> I'm not blaming you :-) I was just wondering what their rationale was.

In my opinion it's much more direct that way. It means that if a driver
doesn't implement it, it won't fall back to some default implementation
instead. Providing an explicit helper like this makes it obvious that
the driver is using a default implementation rather than making things
work "magically". It's easier to see in the driver that there's the
potential to optimize.

It also has the side-effect of keeping the core code cleaner in my
opinion, since the core iommu_map_sg() and iommu_unmap_sg() functions
can now blindly call into drivers directly rather than performing the
various checks to see if they implement the required functionality.

Thierry

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT9DBoAAoJEN0jrNd/PrOhx7EQAISyMLmSTbRwxWrMk0p67NgH
IV7iJiEaE8FcoGObUofMNBlqkhWv5nlfrO9eGbv+C5MAFsOYySn1dsxc1+aRaPCS
TBiOq1osPisssQsbJwgNxuPoaFLw8DWW3w63VayqDafrldM+c/qeYtbE+gCRnzFB
yBpUQYKvVFwi2KwH/GD1trhMK8r5vWL36kn67b0ZmQywMluSl00dS6YOmAA9Pf2L
Q8yVI2zLe0M2AOqPW23xwNI1OAb8Rn9OdPXw0XcArmbQmGbnLCDFfaWFmyw+XcaT
whXLbtKB63iesmG6nUzlWmu75rUEj7HjJK280Jag14Pu1TbUGM70hK6XLKZafA2T
n4LAHkTRe9ggwhVqrYGeg2wh6GmGmIxGS9U124t58O/RVf/k4iqr11E9mZv//3do
/5E0uz0GL1PZhy80kzGRJYtZVdL8wCFHNnTjrNHhmHsTKt9mlHtgUySGt1oxhVuG
E3FJG9uZsSSZWtDk9UF5FiLJjeQoNhAu8tVHTa5XSnG8AuP9c54r+adhWr+dmrF6
xXnJtPvqZt5FSAqqH4PUFUHbXI8zlLQLMTjKrJTrnMOon+wHvgCvkCVXhRZynwWi
ztwcqQpKMmtVGkaQeYwOWAAWV+KWtbcKsEVTtcHUAIRCT8nZP5wUtIBO20ZnkC5w
R0RW+NfJ0yL0ttWyf1mZ
=YSND
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
