From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Mon, 28 Oct 2013 08:31:34 +0100
Message-ID: <20131028073133.GA6629@ulmo.nvidia.com>
References: <20131025075652.GB19622@ulmo.nvidia.com>
 <20131025.112549.2040849946958069337.hdoyu@nvidia.com>
 <20131025091104.GG19622@ulmo.nvidia.com>
 <20131025.124905.1154427805530939055.hdoyu@nvidia.com>
 <20131025104937.GA25080@ulmo.nvidia.com>
 <20131025190136.D55F5C403A7@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131025190136.D55F5C403A7-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2013 at 08:01:36PM +0100, Grant Likely wrote:
> On Fri, 25 Oct 2013 12:49:38 +0200, Thierry Reding <thierry.reding@gmail.=
com> wrote:
> > On Fri, Oct 25, 2013 at 11:49:05AM +0200, Hiroshi Doyu wrote:
> > > Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Fri, 25 Oct 2013 11=
:11:05 +0200:
> > >=20
> > > > > > This is actually "the other problem that I'm aware of that coul=
d benefit
> > > > > > from [interrupt resolution at probe time]". My idea was that on=
ce we had
> > > > > > a way within the driver core to resolve interrupt references at=
 probe
> > > > > > time it could be used for potentially many other resources as w=
ell. Some
> > > > > > of the resources like GPIOs and regulators are obviously not so=
mething
> > > > > > that the core can or should be requesting, but mostly resources=
 that you
> > > > > > don't actually need to control after probing (such as interrupt=
s) would
> > > > > > be a good fit because otherwise people would write the same boi=
lerplate
> > > > > > over and over again.
> > > > > >=20
> > > > > > IOMMUs seem to me to be in that same category. As far as I can =
tell, an
> > > > > > IOMMU driver registers the IOMMU for a given bus, upon which ev=
ery
> > > > > > device can simply be used (mostly transparently) with that IOMM=
U. While
> > > > > > I haven't figured out how exactly, I'm pretty sure we can take =
advantage
> > > > > > of the resolution of resources at probe time within the core to=
 both
> > > > > > keep drivers from having to do anything in particular and at th=
e same
> > > > > > time have code to determine if the IOMMU driver hasn't been pro=
bed yet
> > > > > > and return -EPROBE_DEFER appropriately.
> > > > >=20
> > > > > Can you explain the above a bit more?
> > > > >=20
> > > > > Originally I thought that what Grant suggested would work ok with=
 this
> > > > > patch.
> > > >=20
> > > > I think the objection to these patches is that they special case the
> > > > instantiation of some devices. It's not a proper solution because it
> > > > implies various things. For example merely instantiating the IOMMU
> > > > device earlier than others is only going to work *if* the driver is
> > > > actually probed before the drivers of other devices. If you want to
> > > > build the driver as a module for example, probe order becomes entir=
ely
> > > > non-deterministic.
> > >=20
> > > I understand the above limitation. What I thought for the solution is
> > > that I can make use of iommu_bus even before IOMMU is
> > > instanciated. iommu_bus has its notifier which calls
> > > iommu_ops()->add_device(). This could return -EPROBE_DEFER when IOMMU
> > > isn't ready. Only the problem is the current "bus_notifier" doesn't
> > > have the ability to return error. I'll see if it can be modified. Even
> > > with this, at least IOMMU *driver* needs to be init'ed enough earlier
> > > to prevent devices from being registered without IOMMU.
> >=20
> > The way notifiers work is that they run completely hidden from whatever
> > triggers them. For instance you register the IOMMU bus notifier from the
> > IOMMU driver (by calling bus_set_iommu()). That registers a function to
> > be called when some event happens on that bus. When a device's driver is
> > probed successfully, the driver core will notify the bus, which causes
> > the IOMMU callback to be run.
> >=20
> > Some of this code runs before the driver has successfully been probed,
> > so I imagine it would be possible to use it to abort probing. But that's
> > not possible at least with the current code.
> >=20
> > > > Instead of handling such dependencies implicitly by making sure all
> > > > resource providers are probed earlier than any of their consumers, =
the
> > > > dependencies are handled more explicitly, which turns out to simpli=
fy
> > > > things a lot. There's some additional work required in the core, bu=
t if
> > > > done consistently no driver needs to care about the dependencies an=
d it
> > > > no longer matters where the resources come from. The problem is red=
uced
> > > > to essentially this:
> > > >=20
> > > > 	while (!resource_available())
> > > > 		load_more_drivers();
> > > >=20
> > > > So my proposed solution for the IOMMU case is to treat it the same =
as
> > > > any other resources. Perhaps resource isn't the right word, but at =
the
> > > > core the issue is the same. A device requires the services of an IO=
MMU
> > > > so that it can be put into the correct address space. If the IOMMU =
is
> > > > not available yet it cannot do that, so we simply return -EPROBE_DE=
FER
> > > > and cause the probe to be retried later.
> > >=20
> > > This looks somewhat similar to the above iommu_bus notifier.
> > >=20
> > > Is there any way to implement the same mechanism rather than using
> > > bus?
> >=20
> > Yes, I think it should be possible to get this to work without using the
> > bus notifier at all. I can try to code something up but wanted to wait
> > for feedback from Grant first.
>=20
> I've lost track. What feedback are you waiting for from me? I've not dug
> into this entire series so I may not provide clueful feedback.

I think the context was lost. Here's a link to the relevant message:

	http://www.spinics.net/lists/devicetree/msg09709.html

The message ID is:

	20131025075652.GB19622-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org

Thierry

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSbhLVAAoJEN0jrNd/PrOhjkkQALqr4FNWygHh/Kbdv9v/sRqD
jN4OX0RQwJ55+XQXidoeM6Pdsyhc1gTXP+5J0laCTnT4F9H5oK7S1fflKXf4zZuj
/+fqZUa4sk4Kxkgbz56ZWojuQ0hc6Jq3Est/oKUsmLsC8RxX+iY+/kBLZ3DHvudG
TDe0mW0Ry2Yi0Jrb5LQAyUKLEZku2tl33ucI9fAozfeANtOayynwskjyUtocNQ7F
USUePGBt24Bt5zHUxPyCprqLTwyGttEVH/QX0cVm5YmugRMwtj8NrpX85ojbRooe
YxQix3ceidgW/RuLA5f/FA94aS+GktNvoX2vNF7RdfVHhbcQTU6/cmj33P4NokBM
myy8KREvK1yjtpMNLmqDLVQRsQ+q69he8lXRjAXuyjAZt/0yMj+bWQKx/tDKRptp
BNCA/MpcV7GUHxE01rs5i/4W2LeGDr/sY3KsSbIPIv34/2DoSrr48BMRURwD95SQ
CkPmv0iv00b5TtmUJWM5/huMpm7JHQbQseNFYRFvQRqFVhd2Th5kNup4Apab0Uks
+nRVabFmIPb4CZpRjmfSrfK33+MpT/EzslfLNvKluyEQvN1vSKPFm3ADlurPt/lk
380hgui3pJfEa8eLvxc7t8WO2M3hFwxRf3yQ/Nf+Z1L2d92iWMXmJnn1SlnJ/bI4
zOA/di/AyGtUvY2PH5IY
=RCF9
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
