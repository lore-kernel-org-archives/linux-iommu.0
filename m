From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Fri, 25 Oct 2013 12:49:38 +0200
Message-ID: <20131025104937.GA25080@ulmo.nvidia.com>
References: <20131025075652.GB19622@ulmo.nvidia.com>
 <20131025.112549.2040849946958069337.hdoyu@nvidia.com>
 <20131025091104.GG19622@ulmo.nvidia.com>
 <20131025.124905.1154427805530939055.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131025.124905.1154427805530939055.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2013 at 11:49:05AM +0200, Hiroshi Doyu wrote:
> Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Fri, 25 Oct 2013 11:11:=
05 +0200:
>=20
> > > > This is actually "the other problem that I'm aware of that could be=
nefit
> > > > from [interrupt resolution at probe time]". My idea was that once w=
e had
> > > > a way within the driver core to resolve interrupt references at pro=
be
> > > > time it could be used for potentially many other resources as well.=
 Some
> > > > of the resources like GPIOs and regulators are obviously not someth=
ing
> > > > that the core can or should be requesting, but mostly resources tha=
t you
> > > > don't actually need to control after probing (such as interrupts) w=
ould
> > > > be a good fit because otherwise people would write the same boilerp=
late
> > > > over and over again.
> > > >=20
> > > > IOMMUs seem to me to be in that same category. As far as I can tell=
, an
> > > > IOMMU driver registers the IOMMU for a given bus, upon which every
> > > > device can simply be used (mostly transparently) with that IOMMU. W=
hile
> > > > I haven't figured out how exactly, I'm pretty sure we can take adva=
ntage
> > > > of the resolution of resources at probe time within the core to both
> > > > keep drivers from having to do anything in particular and at the sa=
me
> > > > time have code to determine if the IOMMU driver hasn't been probed =
yet
> > > > and return -EPROBE_DEFER appropriately.
> > >=20
> > > Can you explain the above a bit more?
> > >=20
> > > Originally I thought that what Grant suggested would work ok with this
> > > patch.
> >=20
> > I think the objection to these patches is that they special case the
> > instantiation of some devices. It's not a proper solution because it
> > implies various things. For example merely instantiating the IOMMU
> > device earlier than others is only going to work *if* the driver is
> > actually probed before the drivers of other devices. If you want to
> > build the driver as a module for example, probe order becomes entirely
> > non-deterministic.
>=20
> I understand the above limitation. What I thought for the solution is
> that I can make use of iommu_bus even before IOMMU is
> instanciated. iommu_bus has its notifier which calls
> iommu_ops()->add_device(). This could return -EPROBE_DEFER when IOMMU
> isn't ready. Only the problem is the current "bus_notifier" doesn't
> have the ability to return error. I'll see if it can be modified. Even
> with this, at least IOMMU *driver* needs to be init'ed enough earlier
> to prevent devices from being registered without IOMMU.

The way notifiers work is that they run completely hidden from whatever
triggers them. For instance you register the IOMMU bus notifier from the
IOMMU driver (by calling bus_set_iommu()). That registers a function to
be called when some event happens on that bus. When a device's driver is
probed successfully, the driver core will notify the bus, which causes
the IOMMU callback to be run.

Some of this code runs before the driver has successfully been probed,
so I imagine it would be possible to use it to abort probing. But that's
not possible at least with the current code.

> > Instead of handling such dependencies implicitly by making sure all
> > resource providers are probed earlier than any of their consumers, the
> > dependencies are handled more explicitly, which turns out to simplify
> > things a lot. There's some additional work required in the core, but if
> > done consistently no driver needs to care about the dependencies and it
> > no longer matters where the resources come from. The problem is reduced
> > to essentially this:
> >=20
> > 	while (!resource_available())
> > 		load_more_drivers();
> >=20
> > So my proposed solution for the IOMMU case is to treat it the same as
> > any other resources. Perhaps resource isn't the right word, but at the
> > core the issue is the same. A device requires the services of an IOMMU
> > so that it can be put into the correct address space. If the IOMMU is
> > not available yet it cannot do that, so we simply return -EPROBE_DEFER
> > and cause the probe to be retried later.
>=20
> This looks somewhat similar to the above iommu_bus notifier.
>=20
> Is there any way to implement the same mechanism rather than using
> bus?

Yes, I think it should be possible to get this to work without using the
bus notifier at all. I can try to code something up but wanted to wait
for feedback from Grant first.

Thierry

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIbBAEBAgAGBQJSakzBAAoJEN0jrNd/PrOhKEEP+J8AoEBstZoDtA/mHuzoa25K
8iN2M/VqBe/Binhy3wDBxQbLkckVJkFLan2Vgxfp0+08xNHjvS7rJVisUJ74b06E
H6C/IdtxRpxsSAxjYgll8AywBQDcK8SE/q1J3tTL9K+hCLETtAxswDTOcvOGHVUK
aPsLW66qNi4zPYH6oIjCRXrUYDui/m3ZZPjxns2f1twIGvZBjM8DurnDc/P0f+QN
jnwyPf6rCbPPqx2ez7MZ+os9/VqhYBypEw6IrwQ0xu/J4g0Y2SlNK/pA79bY6VDH
1kYUfQmkZLddsFau5oNbRVxtWNhd5bRfo8TOK2GoEpYqXmuUhMzUwpCbj6AIpJTD
ZYze6mUuypSTq8rp6ykfvK7LewDrPNwNe0Edz12NGbmMb2Y1ysRTM1eFP+NdUTfi
fnBEOXaDowOx6g0wEX9EagmIFrGHaSSsZBeesLG6NlCP1RfYBHqtaGPMfIPoVRgf
WmY8X87fa8UFPnJJef4OMXUF0D7ZepPjjk1Cx8lZzxE7/KX1iwnDDadXpJnN/FnV
vJYCWmZkG28Dn09U8gbdRpuygEqJ9gBvs1o8QjejSbXtIeXerHGlj1YAgvE93rKV
8uNlkfeGKb3c3K1lx2QTNwrccKpR5+Q2fVpcHt/HAq4K+2uSiPIE6RuRJ9H4tsXv
BbSAQl0hvOPtt1i3s38=
=qFZl
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
