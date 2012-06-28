From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Thu, 28 Jun 2012 20:19:42 +0200
Message-ID: <20120628181942.GA13131@avionic-0098.adnet.avionic-design.de>
References: <20120627051418.GB7177@avionic-0098.mockup.avionic-design.de>
	<20120627155907.871b2a506374b7db14c202c4@nvidia.com>
	<20120627140809.GD19319@avionic-0098.mockup.avionic-design.de>
	<20120627172914.30a2ccfd1344161ca7724722@nvidia.com>
	<20120627144414.GA20681@avionic-0098.mockup.avionic-design.de>
	<1340812795.1350.7.camel@antimon>
	<20120628111253.GC15137@avionic-0098.mockup.avionic-design.de>
	<4FEC8B91.6010107@wwwdotorg.org> <1340903992.1348.27.camel@antimon>
	<4FEC9584.4080100@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7215670870857689605=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4FEC9584.4080100-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============7215670870857689605==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2012 at 11:33:56AM -0600, Stephen Warren wrote:
> On 06/28/2012 11:19 AM, Lucas Stach wrote:
> ...
> > CMA is just a way of providing large contiguous address space blocks in
> > a dynamic fashion. ...
> >=20
> > TTM though solves more advanced matters, like buffer synchronisation
> > between 3D and 2D block of hardware ...
> >=20
> > IMHO the best solution would be to use CMA as a flexible replacement of
> > the static carveout area and put TTM on top of this ...
>=20
> Ah right, thanks for the explanation. That makes sense to me now.

Okay. I think that resolves the last open issue. I'll try to get some
more work done on the DT and corresponding code soonish.

For those who don't know yet I've requested the creation of a project
on freedesktop.org for Tegra graphics drivers[0]. I plan to have the DRM
code hosted there once the project has been approved. Furthermore if we
ever get to write a corresponding X driver it can be hosted there as
well. We should also use the wiki for coordination once things get
started.

Thierry

[0]: https://bugs.freedesktop.org/show_bug.cgi?id=3D51505

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP7KA+AAoJEN0jrNd/PrOhi10P/jTqOfkKQ2rHdNZu8CzWrbYe
Yh7oGLPgFECnNtEPoQwkI5ezmb09qhxKp7QHylRxEg6DPOtE+zHQpWH20+g4hqQf
e6NPqETx41J6QLJN402wXUe3D/m5W/WX2oC6x17APmTguwaBkKswkwiOj7NYz0U1
cSsNsigMl/a2xWDIILGkz7vpPNfmayFWTRoZ1litfULgYZQFfW4X0i1YF3QyutN7
oKOOzqz7MAajHe5E3KX66/UsTwtu+iOIOtVhRrjBo65+m6xXyh6QKvSkw7miwGnX
NstuzLy+ZUADV8YImf6yLmCeJviHywZyDxgpFxiclIc2RUd6x+EHi/Irt5Hr8YlE
/mEmluM3RwWPbvVOuAk0xNp+EnLKx3RrkPNc8yjgyiAWQP8fFMSv/WkiFrWqyhwG
zayS2aKOazh3IKtnWz9RCtBeU0NDbXB5JX+iP6NzP7D7KNPWq8C/AlbfefmAklpp
1VkPDHeWK/5ZM4+Tqpbw2pW6tN5eHYXdLXEyOQmE1sZBuEIGLqnaufZnbWyLzVTG
Z6wbrOiRzSHhD6ULgsFncbOolq6CibIUqgUMemV6IPWTtoZIE+1rMJHoanjQmiaG
h73PFm+a3+jr3K17f9YzEOrfXIfGad9teOsGYP2R7QkKKWpywdgwi7VlfUW5xjsr
zejj+bYqMN3e2eJQ4KUU
=PB+4
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

--===============7215670870857689605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7215670870857689605==--
