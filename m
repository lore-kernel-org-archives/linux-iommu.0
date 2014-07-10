From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Thu, 10 Jul 2014 12:57:38 +0200
Message-ID: <20140710105737.GD21583@ulmo>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
	<20140709134050.GN9485@arm.com> <20140709142125.GB3262@ulmo>
	<20140709181048.GX9485@arm.com> <20140710094909.GA21583@ulmo>
	<20140710102334.GG2449@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0174358065936859531=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140710102334.GG2449-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============0174358065936859531==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Content-Disposition: inline


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2014 at 11:23:34AM +0100, Will Deacon wrote:
> On Thu, Jul 10, 2014 at 10:49:10AM +0100, Thierry Reding wrote:
> > On Wed, Jul 09, 2014 at 07:10:48PM +0100, Will Deacon wrote:
> > > On Wed, Jul 09, 2014 at 03:21:27PM +0100, Thierry Reding wrote:
> > > > Anything beyond that (e.g. logical grouping of masters) isn't direc=
tly
> > > > within the scope of the binding (it doesn't describe hardware but s=
ome
> > > > policy pertaining to some specific use-case).
> > >=20
> > > This *is* for hardware. I can use PCI as an example, but this could e=
qually
> > > apply to other types of bus. If you have a bunch of PCI master devices
> > > sitting being a non-transparent bridge, they can end up sharing the s=
ame
> > > master device ID (requester ID). This means that there is no way in t=
he
> > > IOMMU to initialise a translation for one of these devices without al=
so
> > > affecting the others. We currently have iommu_groups to deal with thi=
s, but
> > > it *is* a property of the hardware and we absolutely need a way to de=
scribe
> > > it. I'm happy to add it later, but we need to think about it now to a=
void
> > > merging something that can't easily be extended.
> > >=20
> > > For PCI, the topology is probable but even then, we need this informa=
tion to
> > > describe the resulting master device ID emitted by the bridge for the
> > > upstream group. One way to do this with your binding would be to trea=
t all
> > > of the upstream masters as having the same device ID.
> >=20
> > Yes, I think that makes most sense. After all from the IOMMU's point of
> > view requests from all devices behind the bridge will originate from the
> > same ID.
> >=20
> > So technically it's not really correct to encode the master ID within
> > each of the devices, but rather they should be inheriting the ID from
> > the non-transparent bridge.
>=20
> Indeed. Is that possible with your binding, or would we just duplicate the
> IDs between the masters?

No, the binding only describes direct relationships between the IOMMU
and masters. There's no way to translate them inbetween or inherit them.

I'm wondering how this could be described in device tree, though.
Perhaps something like this:

	iommu {
		#iommu-cells =3D <1>;
	};

	bridge {
		iommus =3D <&/iommu 42>;
		#iommu-cells =3D <0>;

		device@0 {
			iommus =3D <&/bridge>;
		};

		device@1 {
			iommus =3D <&/bridge>;
		};

		...
	};

? That way some code could walk up the IOMMU tree to resolve this. Or
perhaps even easier:

	iommu {
		#iommu-cells =3D <1>;
	};

	bridge {
		iommus =3D <&/iommu 42>;

		device@0 {
			...
		};

		device@1 {
			...
		};

		...
	};

And we could enhance the binding by defining that the iommus node is
inherited by devices on a bus, which by what you're saying would be the
sensible thing to do anyway.

In the second example above, the presence of an iommus property in the
bridge would indicate that it's non-transparent regarding IOMMU
translation and therefore the master ID should be inherited. Devices
could still override by providing their own iommus property, though I'd
be a little surprised if there ever was hardware like that.

> > > With virtualisation, we may want to assign a group of devices to a gu=
est but
> > > without emulating the bridge. This would need something the device-tr=
ee to
> > > describe that they are grouped together.
> >=20
> > But that's also a software decision, isn't it? Virtualization doesn't
> > have anything to do with the hardware description. Or am I missing
> > something? Of course I guess you could generate a DTB for the guest and
> > group device together, in which case you're pretty much free to do what
> > you want since you're essentially defining your own hardware.
>=20
> If you're doing device passthrough and you want to allow the guest to
> program the IOMMU, I think that virtualisation is directly related to the
> hardware description, since the guest will be bound by physical properties
> of the system.

Evidently you know much better what the requirements are here and what
will actually be required. I guess we'll need to have more discussions
along with examples of use-cases.

Thierry

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTvnGhAAoJEN0jrNd/PrOhgnIP/2/PQINwth2sas2l1+AE2qbx
/OckQuyNw0J8nQHttsSwA9NQJtxH1Nffe5bLDx7Q7E2l+35zkHvQ0NoeK6/I3Bnp
VXMXAZ84k7BTher0MkwxbP6VNCJAS+vQBbtbEORkq5N7IrFR8fq6rQvvn5UFCAmu
CFP355SgCoLw/WmaDlRfk5kaRzd/jCCKFWGQ1Pw62Q/0q70PgC4GOdC2kgmp0x3I
Sd2LnJIclAmalkbA6ByEk1KK+QIr4A2zZQKmrV+GIMwDwM7JmZcC5u7n4OrYo3u0
qLUPpNommsbbztZ5cthNt1fW7ht69uZNdEdc40bROQlbIfX0TE7LqPDpvwEPrY/2
CLiWpzHhrjLdhTHzKQ5kmjLNtNg1mTgoaBQFyWc6T/P9Juzbsdw6oX7SxoHuqAg2
xmVZxBf4jrl6/uO1GD4H292qslOKh7+lpjhAQXJbXDzdojctaSGIGnyeJslWFBZq
eDi7ZTDDaSrOdMzDqbRpRJwtNAIjWVag2oUYdeBhQYBubgVVvC2rYKD7nfmy4isN
sd+xrRQeKDF1Mot4qmBjx/1lbQ08QAKt7US+uMMAR9ZWBdhtI9F6G2o9C20IOWRn
GuU+8fJv81Cty/xz7Cj0wyIiACEqo79nw16QMl/nWxIhyErxjEWYvt/weJDXqN58
SOxu9sRC7yZhsi6Flnk2
=yjDS
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--

--===============0174358065936859531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0174358065936859531==--
