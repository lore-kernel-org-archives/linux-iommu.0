From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Thu, 10 Jul 2014 11:49:10 +0200
Message-ID: <20140710094909.GA21583@ulmo>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140709134050.GN9485@arm.com>
 <20140709142125.GB3262@ulmo>
 <20140709181048.GX9485@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140709181048.GX9485-5wv7dgnIgG8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TZNg+MwTxZMZA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2014 at 07:10:48PM +0100, Will Deacon wrote:
> Hi Thierry,
>=20
> On Wed, Jul 09, 2014 at 03:21:27PM +0100, Thierry Reding wrote:
> > On Wed, Jul 09, 2014 at 02:40:50PM +0100, Will Deacon wrote:
> > > I would like to move the ARM SMMU driver over to this for 3.18, if po=
ssible.
> > > One use-case there is the ability to describe groups of masters behin=
d a
> > > multi-master IOMMU but which must be part of the same domain (i.e. an
> > > iommu_group). This is useful for presenting devices to a guest with a
> > > virtual SMMU, where the physical devices share a stage-2 context.
> > >=20
> > > With your binding, does this simply mean determining the set of maste=
r IDs
> > > in the group, then describing the complete set for each master?
> >=20
> > I'm not sure I properly understand what you're trying to do, but I don't
> > think the binding is designed to cover that. Rather the goal was to
> > describe the IDs belonging to each master, so that an IOMMU can be
> > properly configured.
>=20
> This is directly related to that problem, see below.
>=20
> > Anything beyond that (e.g. logical grouping of masters) isn't directly
> > within the scope of the binding (it doesn't describe hardware but some
> > policy pertaining to some specific use-case).
>=20
> This *is* for hardware. I can use PCI as an example, but this could equal=
ly
> apply to other types of bus. If you have a bunch of PCI master devices
> sitting being a non-transparent bridge, they can end up sharing the same
> master device ID (requester ID). This means that there is no way in the
> IOMMU to initialise a translation for one of these devices without also
> affecting the others. We currently have iommu_groups to deal with this, b=
ut
> it *is* a property of the hardware and we absolutely need a way to descri=
be
> it. I'm happy to add it later, but we need to think about it now to avoid
> merging something that can't easily be extended.
>=20
> For PCI, the topology is probable but even then, we need this information=
 to
> describe the resulting master device ID emitted by the bridge for the
> upstream group. One way to do this with your binding would be to treat all
> of the upstream masters as having the same device ID.

Yes, I think that makes most sense. After all from the IOMMU's point of
view requests from all devices behind the bridge will originate from the
same ID.

So technically it's not really correct to encode the master ID within
each of the devices, but rather they should be inheriting the ID from
the non-transparent bridge.

> With virtualisation, we may want to assign a group of devices to a guest =
but
> without emulating the bridge. This would need something the device-tree to
> describe that they are grouped together.

But that's also a software decision, isn't it? Virtualization doesn't
have anything to do with the hardware description. Or am I missing
something? Of course I guess you could generate a DTB for the guest and
group device together, in which case you're pretty much free to do what
you want since you're essentially defining your own hardware.

Thierry

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTvmGVAAoJEN0jrNd/PrOhkkgQAK9Oh++C2Hiqj8BoR+GbjFXn
zKw+5tmSV7JzSf6DraSBeLEkhPOtmJy+fqhDSQxW2BO0QsPUDqbrrbYEXxdPRdDr
10Vk2ZPXsCpSH8PMsYpXANroA91kCtv3dExof3pGuw5rzMjHrLnPsk+YJCc4FEko
gHpfT+wmA1dT37xQLkTZo8n3UxTrfLWCMR4cVvBeoLO9IFvhhEjLbGgyq2Hzvve5
W6ZeEP9V+YL286Q0/ax01G3QCke7FIKJGYpb0Y+6VIdnd6KFykbnkabuFJ7IGYox
RgWDyYtEJg/jnLIsolyPjhcL5MA34Fyi5UUsR92qq8HxMs4/QziUIKtHtYjHSJ41
tM9TqO5F51oyV2GrDssOgjlg3n3EGP4sj0iBV7w/kTe+Nt4TscQB+GFnumgJWvsI
Uyhgsr14xBjOaZp/VT1UeHcSXyINEnmyl/KV5XuWsWVb99YzlxhNIdFlj7v3mKEh
guymycJKDq36QeOQBziLbBPdkRR8DbzsS4GFPE3zb3yaznEYwKDSVSxTS/Dvgtnw
L6PVhK2YXvXyZoXh1uLLtcRVxKLdmPqjvj6+QSJV6ok6mf3xFjm1ZRPsBQN2E16N
i5M+vWFyKYpZZtVQwBq/dBusiYlZdEeQ0VuhmKOLisVy1oqFgnFEEDnkCK9BpOmG
bZcB5Ik1aDuJggkR+D5s
=lHv3
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
