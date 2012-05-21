From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC v2 5/5] drm: Add NVIDIA Tegra support
Date: Mon, 21 May 2012 15:58:38 +0200
Message-ID: <20120521135838.GA15046@avionic-0098.mockup.avionic-design.de>
References: <1335347102-14905-1-git-send-email-thierry.reding@avionic-design.de>
 <1335347102-14905-6-git-send-email-thierry.reding@avionic-design.de>
 <4FA78CBD.5010606@nvidia.com>
 <4FA7F80F.5090002@wwwdotorg.org>
 <20120521110514.GC27686@avionic-0098.mockup.avionic-design.de>
 <4FBA28FD.2060504@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FBA28FD.2060504-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Terje Bergstr=C3=B6m wrote:
> On 21.05.2012 14:05, Thierry Reding wrote:
>=20
> > I agree. It's really just a "simple-bus" kind of bus. Except that it'll=
 need
> > another compatible value to make the host1x driver bind to it. But we s=
hould
> > be able to make it work without creating a completely new bus. I guess =
the
> > "ranges" property could specify 0x54000000 as the base address and child
> > nodes could use offsets relative to that. Maybe even that is overkill,
> > though.
>=20
>=20
> Hi,
>=20
> In the phase where we are just getting display up, yes, the bus is a
> really simple bus. For that, all you need to know about host1x is that
> it needs to be turned on whenever you talk to the display. Having a bus
> seems overkill.
>=20
> At a latest stage, we're going to need support for host1x channels and
> related infrastructure. In that phase, we need to find good homes for
> channel allocation, job tracking, push buffer management, and other code
> common to all host1x drivers. In the current nvhost driver, it's the job
> of the bus_type and related utilities, and that seems like a good enough
> fit.
>=20
> I have a bit of hard time understanding the significance of a bus_type
> in the Linux driver model.
>=20
> On one hand, bus_type allows grouping a set of devices and drivers
> according to the APIs they implement. In nvhost, we have struct
> nvhost_device and struct nvhost_driver, and each host1x client driver
> needs to use them. It's natural to put them in the same bus_type. As a
> bonus, we can assign further common tasks to the bus_type.
>=20
> On the other hand, implementing a bus_type introduces code almost
> duplicate to platform bus. This is the part that I have hard time with.
>=20
> The device tree should reflect the target state, as it's going to be an
> API between kernel and boot loader. I believe it'd be best to introduce
> host1x as a bus and put all host1x clients as nodes inside host1x.

I agree that reflecting the hardware hierarchy within the device tree makes
sense. I'll need to add some code to tear down child devices in the cleanup
path, but that shouldn't be too difficult.

However, adding a whole bus_type implementation would pretty much duplicate
the platform bus code. I guess host1x could just provide struct host1x_clie=
nt
a set of corresponding APIs to create them, request channels, etc.

Thierry

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+6Sg4ACgkQZ+BJyKLjJp8pMQCcDzkRrXEqkRzMw++24qKAm5nz
uIYAn36d3doXZ7hlZV5xh09uRQChZxh3
=7PcX
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
