From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Fri, 1 Nov 2013 10:53:50 +0100
Message-ID: <20131101095349.GI27864@ulmo.nvidia.com>
References: <20131025091104.GG19622@ulmo.nvidia.com>
	<52718122.9000206@wwwdotorg.org> <20131030224108.GA6939@mithrandir>
	<20131031.101405.2229107340254709582.hdoyu@nvidia.com>
	<52728754.60307@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2511476189858324374=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <52728754.60307-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============2511476189858324374==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Content-Disposition: inline


--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2013 at 10:37:40AM -0600, Stephen Warren wrote:
> On 10/31/2013 02:14 AM, Hiroshi Doyu wrote:
> > Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Wed, 30 Oct 2013 23:4=
1:09 +0100:
> >=20
> >> My earlier proposal for deferred interrupt reference resolution actual=
ly
> >> tries to solve that problem within the core. Essentially what it does =
is
> >> add a new function that gets called right before the driver's .probe()
> >> function, so that it can parse standard resources and services from DT,
> >> such as the interrupts property. This could theoretically be done for
> >> other resources such as reg as well, but it really only matters where
> >> the resource can be dynamic (as is the case for interrupts).
> >>
> >> In this case I would envision a standard OF function to associate a
> >> device with its IOMMU. Perhaps something like:
> >>
> >> 	int of_iommu_attach(struct device *dev);
> >>
> >> That could be called by the core independent of the specific device and
> >> IOMMU. IOMMU-specifics can probably be handled using .of_xlate(), quite
> >> in a similar way to GPIO or regulators.
> >>
> >> That way drivers can remain agnostic of the IOMMU while still being ab=
le
> >> to take advantage of deferred probing.
> >=20
> > This could be simpler than making "bus_notifier" return "-EPROBE_DEFER".
> >=20
> > The disadvantage of this is that we may need to provide the similar
> > of_<"subsystem">_attach() per subsytem if needed.
>=20
> Well, "per subsystem" here means per subsystem that is providing
> resources, not per subsystem that is consuming resources. How many
> subsystems are you expecting to provide resources like this? At present,
> I believe IOMMU is the only subsystem missing some kind of API for
> clients to acquire the relevant resource. I don't think there's any
> scalability problem here.

Furthermore if the subsystem wants to provide resources then it needs
such a function anyway, so there really isn't any overhead here.

Thierry

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSc3otAAoJEN0jrNd/PrOhbSEQAJCK8J2ks2NXs/JNMdaRcMVQ
0xy8oPATYTHnw/HdNQG46CGbFUzuKsHZrbFY9mA8qEX4Yiy0AWVlZ/8rgE+VKXYD
CqyIrusRARdB5NdqtOkLGkvQAtlqx+aGgr0DB6y4xbE6FLeiPUue/rEwTYGl+20M
ualDsimW9HyphbnSp/n5Aw07BFSfhtVVj5OqKjwmM7P+xuD6LHIo4plG83QhiBUV
22PuZ4AhhwKAcAosepyHldYhO1he+hxF0nOhl6ntdsfHmShyE514uVbABVjhNkDz
vgq7j5oBICvIQHCCsiQbLwIQrOGtmDsA2s/R1EKhbBtb11doYL+lXM+QeV5YK5XR
UBwxoXoWoEi9O0CG66S++jNWhEC0eUiKx5Mh15mLW6+HT45g0qc5zG8LnUUpAF22
BdspoXeEzCr9mKY85WHi1iXatIK4oan579khbHzKbnOyUbHQUX++LTc4t9978Qpy
84bfDAmZB4jzgIhw7aJ8quF5M84wQMMo7vmaS5NM3KNz+DSelDvIYT8sI4MehnPG
cHvfi2+9GsmPPP0jf/QTPWVCwmUvooAXm7oMqnpg8DIAfiUKqsHnbnGJ4WIL1vqx
oniBhgjrHDrRFKw3jySzOj0MmfKcRtO3/PRkcHA/0kHrNEe1SFJj7sWPWp8a7KD4
XVESYM/LqoU91ZO4/cXe
=Zp7z
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--

--===============2511476189858324374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2511476189858324374==--
