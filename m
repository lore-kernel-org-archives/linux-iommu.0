From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Report from 2013 ARM kernel summit
Date: Wed, 20 Nov 2013 14:53:09 +0100
Message-ID: <20131120135308.GC8279@ulmo.nvidia.com>
References: <20131111.114723.1885845500744256130.hdoyu@nvidia.com>
 <20131115070627.6CF65C4079B@trevor.secretlab.ca>
 <20131119.114054.663999769447782808.hdoyu@nvidia.com>
 <20131119173524.GK11778@mudshark.cambridge.arm.com>
 <528BCDCE.6070006@gmail.com>
 <20131120103111.GB19352@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131120103111.GB19352-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "ksummit-2013-discuss-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org" <ksummit-2013-discuss-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "lwn-T1hC0tSOHrs@public.gmane.org" <lwn-T1hC0tSOHrs@public.gmane.org>, "paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org" <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2013 at 10:31:11AM +0000, Will Deacon wrote:
> On Tue, Nov 19, 2013 at 08:45:02PM +0000, Rob Herring wrote:
> > On 11/19/2013 11:35 AM, Will Deacon wrote:
> > > Adding Andreas and Rob for input on potential binding additions to th=
e SMMU.
> >=20
> > The above proposal would be an incompatible change. However, I think we
> > could still deal with a change in this binding at this stage.
> >=20
> > One way approach to handle this without changing the binding would be to
> > scan the DT for all iommu's up front and create a list of all nodes and
> > their iommu parent. The fact that the hierarchy is described in a way
> > that doesn't fit Linux well is really a Linux implementation detail.
> >=20
> > If changing the binding, a simple approach would be to allow
> > 'smmu-parent' to be a bus and/or device property and not just for
> > chained iommu's. This could be a global or bus property that is
> > inherited. Like interrupt-parent, you would have to deal with the parent
> > being itself. Also, perhaps iommu-parent would be a better name. In any
> > case, I'd like to see this all be a generic iommu binding.
>=20
> I like that idea. I've recently been toying with removing the chained IOM=
MU
> support, since I don't think anybody is using it who is interested in
> mainline. However, making it more general sounds like a better idea.
>=20
> One potential issue is that I think the nvidia guys want to describe mast=
ers
> that master via multiple SMMUs (which I believe was the motivation for
> moving the stream-ids out into the master nodes, rather than keeping them=
 in
> the SMMU). Again, that's not something we can easily add to the arm-smmu,
> because the incoming stream-ids are a property of the SMMU node.

If I remember correctly, one of the reasons for the proposal was also
that the interrupt-parent property turned out to be insufficient for
some use-cases, which lead to Grant's proposal of the new interrupts-
extended property. Since that comparison has already been drawn, I think
we can agree that both are used in similar ways. Therefore we should
consider what we've learned from interrupt-parent when designing this
generic IOMMU binding to avoid having to introduce iommu-extended at
some point.

> So the question is: do we actually need to describe masters that master
> through multiple SMMUs as a single node in the devicetree?

I would think so, yes. The alternative would be to have several nodes
that describe the same device, and that conflicts on a different level.

Perhaps it could be done by having separate sub-nodes that each use a
different IOMMU, but that sounds like a much grosser solution. That
pretty much boils down to interrupt-parent/interrupt-map.

Thierry

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjL7EAAoJEN0jrNd/PrOhrzkP/3jF9DZO87xHqlLHZztd0VUf
+fn4ViFaj1y/xB1EjIvL0+8FRK/CGUOFQgqIg1bvzCJQgkDLEzkx4VhpVuZJXvsD
Ip2q7AMdtQnc4g2VceR/wFqMakyNEzsvAyMqWfTCSP5pWofJK3GIi2MErdLRVe1a
FOMrSIUaPkgbHTmuRDM/Z8gVXwngEBia4/KFzxa4oGkdnN77gtmRtT+BKMcAc7El
dHzRK9AnUEVFaKcJ0oMZbC5xSQQjxCCqEWy3cjpqMo1LYL4geeNfiqIZIljUfYUB
qS8JAGBWuU8Sli3UF73XTl6gGYVkoh945a5ctrT7azST7kL/5WPowaksVnKmIwDp
puVLjAHRiNVBhYssUbQ8l6GYbXXSCpNhfaAaBp0MoPGLIb4Zla4Iv8hbpJeiYhPX
8pgT4Y/pbahfK/V1BJzP3OlheX0RsgKJMA3IQuoumDrZ7dr663p0LR/TtNp6H4IV
vyH4yYRayI9+0wiS5tVups5kvByfs2E9aJlj+lmnZKZegy9qv8sVILhWyB2huKH1
CRmgLkrXSIHQ/+AIllnQURkFZM2Tjb6Dmk5zX57NraxY8gtHbyX/mbV8jdt0R/kZ
3Mozv1YezzCJXjGDuUq+4dRjbTrXe+pJnQi/8DLEJIA0x2ILpjQxcArbIQz9d9Nb
061iyHBuCQm+dJTSYsDB
=i2+i
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
