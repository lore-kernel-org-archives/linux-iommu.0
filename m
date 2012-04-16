From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Mon, 16 Apr 2012 21:03:20 +0200
Message-ID: <20120416190320.GA21233@avionic-0098.mockup.avionic-design.de>
References: <20120412065038.GB4162@avionic-0098.adnet.avionic-design.de>
	<4F86F97C.8010508@wwwdotorg.org>
	<20120412174429.GB10042@avionic-0098.adnet.avionic-design.de>
	<4F8753A0.6040907@wwwdotorg.org>
	<20120413091457.GB617@avionic-0098.mockup.avionic-design.de>
	<4F887C54.6030306@wwwdotorg.org>
	<20120415083905.GA15207@avionic-0098.mockup.avionic-design.de>
	<4F8C423B.8050609@wwwdotorg.org>
	<20120416184819.GA21043@avionic-0098.mockup.avionic-design.de>
	<4F8C6B80.4000001@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4139920670172405334=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4F8C6B80.4000001-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============4139920670172405334==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 04/16/2012 12:48 PM, Thierry Reding wrote:
> > * Stephen Warren wrote:
> ...
> >>> Has there been any discussion as to how EDID data would best be repre=
sented
> >>> in DT? Should it just be a binary blob or rather some textual represe=
ntation?
> >>
> >> I think a binary blob makes sense - that's the exact same format it'd
> >> have if read over the DDC I2C bus.
> >=20
> > DTC has /incbin/ for that. Is arch/arm/boot/dts still the correct place=
 for
> > EDID blobs? I could add tegra-medcom.edid if that's okay.
>=20
> As far as I know, yes.
>=20
> Perhaps we'll want to start putting stuff in SoC-specific
> sub-directories given the number of files we'll end up with here
> (irrespective of EDID etc.), but I haven't seen any move towards that yet.

Yes, especially as more machines are moving to DT that directory will soon
become quite cluttered. I suppose a tegra subdirectory wouldn't hurt.

I've been looking about for tools to generate EDID data but didn't find
anything useful. Does anyone know of any tool that's more convenient than
manually filling a struct edid and writing that to a file?

Thierry

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+MbPgACgkQZ+BJyKLjJp8bSwCfZfFtClerdzHb5xiRKoXBoWUI
olsAoKiTay5jX1NXv57vyDGh9/4RUEIE
=sXK8
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

--===============4139920670172405334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4139920670172405334==--
