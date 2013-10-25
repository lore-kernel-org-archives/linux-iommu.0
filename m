From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Fri, 25 Oct 2013 11:11:05 +0200
Message-ID: <20131025091104.GG19622@ulmo.nvidia.com>
References: <20131024.122115.1035609747068925560.hdoyu@nvidia.com>
 <20131025001038.77299C403B6@trevor.secretlab.ca>
 <20131025075652.GB19622@ulmo.nvidia.com>
 <20131025.112549.2040849946958069337.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/i8j2F0k9BYX4qLc"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131025.112549.2040849946958069337.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--/i8j2F0k9BYX4qLc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2013 at 10:25:49AM +0200, Hiroshi Doyu wrote:
> Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Fri, 25 Oct 2013 09:56:=
55 +0200:
>=20
> > > > This patch is a part of HACK to control device instanciation order.=
 We
> > > > have an IOMMU device(platform) which needs to be instanciated earli=
er
> > > > than other (platform)devices so that IOMMU driver would configure t=
hem
> > > > as IOMMU'able device.
> > >=20
> > > Ideally the drivers depending on the IOMMU would return -EPROBE_DEFER=
 if
> > > the IOMMU driver isn't set up so that you don't need to play games wi=
th
> > > probe order. Creating certain platform devices early is a really ugly
> > > and fragile solution.
> > >=20
> > > Besides, probe order of device drivers is far more about link order of
> > > the kernel than it is about when of_platform_device_create() is calle=
d.
> > > Fiddling with the initcall level on the IOMMU driver (while not
> > > recommended) may very well have the effect you desire.
> >=20
> > This is actually "the other problem that I'm aware of that could benefit
> > from [interrupt resolution at probe time]". My idea was that once we had
> > a way within the driver core to resolve interrupt references at probe
> > time it could be used for potentially many other resources as well. Some
> > of the resources like GPIOs and regulators are obviously not something
> > that the core can or should be requesting, but mostly resources that you
> > don't actually need to control after probing (such as interrupts) would
> > be a good fit because otherwise people would write the same boilerplate
> > over and over again.
> >=20
> > IOMMUs seem to me to be in that same category. As far as I can tell, an
> > IOMMU driver registers the IOMMU for a given bus, upon which every
> > device can simply be used (mostly transparently) with that IOMMU. While
> > I haven't figured out how exactly, I'm pretty sure we can take advantage
> > of the resolution of resources at probe time within the core to both
> > keep drivers from having to do anything in particular and at the same
> > time have code to determine if the IOMMU driver hasn't been probed yet
> > and return -EPROBE_DEFER appropriately.
>=20
> Can you explain the above a bit more?
>=20
> Originally I thought that what Grant suggested would work ok with this
> patch.

I think the objection to these patches is that they special case the
instantiation of some devices. It's not a proper solution because it
implies various things. For example merely instantiating the IOMMU
device earlier than others is only going to work *if* the driver is
actually probed before the drivers of other devices. If you want to
build the driver as a module for example, probe order becomes entirely
non-deterministic.

So what Grant was saying is that you could possibly make it work by
forcing the driver to be loaded earlier using explicit initcall
ordering. But he also said that's not recommended because it's not a
proper solution and therefore not guaranteed to always work.

Explicit initcall ordering used to be heavily used in the past, but
there have been many efforts to move away from it. One of the solutions
introduced to help with that is deferred probing, which essentially adds
a new error code (EPROBE_DEFER) which a driver's .probe() can return to
cause it to be probed at a later point again, after other drivers have
been probed.

How this works is basically that a driver's .probe() requests whatever
resources it needs (GPIOs, clocks, regulators, ...). If any of those
resources isn't there yet (presumably because the driver providing it
hasn't been probed yet), it can return -EPROBE_DEFER to signal that not
all of its dependencies are available yet.

Instead of handling such dependencies implicitly by making sure all
resource providers are probed earlier than any of their consumers, the
dependencies are handled more explicitly, which turns out to simplify
things a lot. There's some additional work required in the core, but if
done consistently no driver needs to care about the dependencies and it
no longer matters where the resources come from. The problem is reduced
to essentially this:

	while (!resource_available())
		load_more_drivers();

So my proposed solution for the IOMMU case is to treat it the same as
any other resources. Perhaps resource isn't the right word, but at the
core the issue is the same. A device requires the services of an IOMMU
so that it can be put into the correct address space. If the IOMMU is
not available yet it cannot do that, so we simply return -EPROBE_DEFER
and cause the probe to be retried later.

Eventually the IOMMU driver will be probed and register the IOMMU. When
the earlier driver is probed again, it will be able to successfully
request to be put into the proper address space and continue with the
initialization.

Does that answer your question?

Thierry

--/i8j2F0k9BYX4qLc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSajWoAAoJEN0jrNd/PrOh1h4QALFqNgoyKwrYdAatbgelycFD
HdCy5vKhfrFSZSMngg++XhBVRloKCEjewSn5CxkasXo9UUos81Plkh4FxsvO2tj2
Rez6t/XFun5Xl0dTaslUJ/RhgiWzWEOQc/WPfJIMQSET8mNlwV7+JYXUAmQqiL4y
WGonyrTJu0rTsdNE3gPW9RBnKJnej7fyxPTZu52CiP4VTIgd5kt2ou4pWSNF/zkR
Fuc4hn8wM/Y3PqzTSCWXVZNHpt4z1oMcVZFsJS5sezWU4GKT/2UyuB0KVViETkU1
Uu+kYnUCANXiy7ysdqeBbXOrvkKwWf8RQ/7nSriQpaq22uAIMpVZiYMJ+YPvGAsA
61z5VUD8jfX2v3LHsLkc7AwweM4O+GAYHHFgVLbYY6SlVpMPAxE3T2czL2XvJGxT
P8jTw9xyvj0J6cfPlAcko9wog6nChNs1YsSw1bvq06OV5CAyshW+Ru/5afp4Rqnn
6UjjWr0Se1f1ywul77wsYULziHrj+nzVah6u++mlI2wIweAmV7iorzDCjAn1j+jr
diC2OhpzLBBdgwBuzwcpgCZwc8gHCGtA6+Ad2VaKEYPWzNDhei9fYmMVjWsrxr12
SN4mNpLHtx1tZZPP8PYLZT3BCnHzRnaLBtJXipH8Urq+/cGIbM+O45vxF7Dbrhcn
kBNgltno8Fgx7WRV/DmY
=oyQh
-----END PGP SIGNATURE-----

--/i8j2F0k9BYX4qLc--
