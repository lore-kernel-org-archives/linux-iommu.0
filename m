From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 00/21] IOMMU: Tegra GART driver clean up and
 optimization
Date: Wed, 12 Dec 2018 11:24:15 +0100
Message-ID: <20181212102415.GM15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181211095317.tv43aaefnsezmic7@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uwB7x3tnyrZQfZJI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211095317.tv43aaefnsezmic7@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Dmitry Osipenko <digetx@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--uwB7x3tnyrZQfZJI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 10:53:17AM +0100, Joerg Roedel wrote:
> On Sun, Dec 09, 2018 at 11:29:29PM +0300, Dmitry Osipenko wrote:
> > Dmitry Osipenko (21):
> >   iommu/tegra: gart: Remove pr_fmt and clean up includes
> >   iommu/tegra: gart: Clean up driver probe errors handling
> >   iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
> >   iommu: Introduce iotlb_sync_map callback
> >   iommu/tegra: gart: Optimize mapping / unmapping performance
> >   dt-bindings: memory: tegra: Squash tegra20-gart into tegra20-mc
> >   ARM: dts: tegra20: Update Memory Controller node to the new binding
> >   memory: tegra: Don't invoke Tegra30+ specific memory timing setup on
> >     Tegra20
> >   memory: tegra: Adapt to Tegra20 device-tree binding changes
> >   memory: tegra: Read client ID on GART page fault
> >   memory: tegra: Use of_device_get_match_data()
> >   memory: tegra: Use relaxed versions of readl/writel
> >   iommu/tegra: gart: Integrate with Memory Controller driver
> >   iommu/tegra: gart: Fix spinlock recursion
> >   iommu/tegra: gart: Fix NULL pointer dereference
> >   iommu/tegra: gart: Allow only one active domain at a time
> >   iommu/tegra: gart: Don't use managed resources
> >   iommu/tegra: gart: Prepend error/debug messages with "gart:"
> >   iommu/tegra: gart: Don't detach devices from inactive domains
> >   iommu/tegra: gart: Simplify clients-tracking code
> >   iommu/tegra: gart: Perform code refactoring
>=20
> This is making progress, but some parts have no Ack or Review yet, I'll
> wait for Thierry before applying these patches into the iommu tree.

So appart from the one issue in the "memory controller integration"
patch this looks good and I've acked the remaining patches. Once the one
remaining issue is fixed I think this is ready to be merged.

Joerg, given the dependencies between the various parts of the series, I
think it may be better for you to merge everything through the IOMMU
tree if you don't mind.

Thierry

--uwB7x3tnyrZQfZJI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ4c8ACgkQ3SOs138+
s6Ek+hAAm6Xaia2wnPAyQoDzIPdb1xFkdfVusp69nfAlVotjQ8HfB0arU+On09RB
wXfGQH/vbKNgTHd1vRVcKItq4gMoF7GqMREK/thwWzoT20Bw3olIz7ZaG+3mIYIj
u9NzPSujgklgdXyanA/OwXt8F1418zqj/wTi662xqE1ylkTjJQh2N6BSfwMLv0X8
ZQWYTkYNCh8E7GzYHCS0jeE9Cqyd/eXTm5QK8Lfl7oUKH2XZVY9t/Te5nJERDNEs
UTmtSuC+JsQYbxa2K9ogUvlOFAzB01Ovuc+mEzmek7MKVcNd36sllzcXWocbPTIE
aMjSFs+eIQvQgkjNiO9oAWSQNoTha+iiPNEVEVtm9oHoVt+K/YWgn49ZySgzkG/X
DjppZOBA3XHY5muFKDPYcTEw1K4OoI5FjwuRmaKwV+dBUY2k82/h/jMyVUZRqqO0
NBO+NHk3k4zkxxN9pql/b+6UJ1yZiTb2/+djahQwiM6YK2soK6CEe3jaHKbvfsHV
5Lm+FV3NfU9fqyafaSs/FMU59WU8vxb2vBJ4BAosgxRXyM/A8wXjHu4zIra+chtw
c5a1dfFMWr829ZMaVJb9bqkekvadAkMwnJv/2rVUYOH7KrRHoL1/Rs52xfjz7tSs
FrtQTnMfZK2muHlolT4HY7bBXW1LUwMEwby+RAYGX+SoTrAMY+U=
=1/qQ
-----END PGP SIGNATURE-----

--uwB7x3tnyrZQfZJI--
