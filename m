From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Thu, 31 Jul 2014 12:09:06 +0200
Message-ID: <20140731100905.GA7458@ulmo>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
	<20140730152646.GC20162@leverpostej>
	<CAOesGMi3zM1-cqmeGddJ69RNXx0ktFm_zXO_yq7N0EeA3HNrUQ@mail.gmail.com>
	<20140730181842.GG20162@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2958180861239380198=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140730181842.GG20162@leverpostej>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============2958180861239380198==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2014 at 07:18:42PM +0100, Mark Rutland wrote:
[...]
> > >> +
> > >> +Multiple-master IOMMU with configurable DMA window:
> > >> +---------------------------------------------------
> > >> +
> > >> +     / {
> > >> +             #address-cells =3D <1>;
> > >> +             #size-cells =3D <1>;
> > >> +
> > >> +             iommu {
> > >> +                     /* master ID, address and length of DMA window=
 */
> > >> +                     #iommu-cells =3D <4>;
> > >> +             };
> > >> +
> > >> +             master {
> > >> +                     /* master ID 42, 4 GiB DMA window starting at =
0 */
> > >> +                     iommus =3D <&/iommu  42  0  0x1 0x0>;
> > >
> > > Is this that window is from the POV of the master, i.e. the master can
> > > address 0x0 to 0xffffffff when generating transactions, and these get
> > > translated somehow?
> > >
> > > Or is this the physical addresses to allocate to the master?
> >=20
> > It needs to be clarified in the documentation, but as far as I know it
> > is the DMA address space that is used.
>=20
> Ok. So that's pre-translation, from the POV of the master?

Correct. It represents the window of the IOMMU's addressable I/O virtual
address space that should be assigned to this particular master.

> If we don't have that knowledge about the master already (e.g. based on
> the compatible string), surely we always need that information in a
> given iommu-specifier format? Otherwise certain iommus won't be able to
> handle masters with limited addressing only due to limitations of their
> binding.

This is only used for what's often called a windowed IOMMU. Many IOMMUs
(non-windowed) typically allow only a complete address space to be
assigned to a master without additional control over subregions. So this
is really a property/capability of the IOMMU rather than the masters
themselves.

There are already other means to respect the addressing limitations of
masters. We typcially use a device's DMA mask for this, and it's natural
to reuse that for I/O virtual addresses since they will in fact take the
place of physical addresses for the master when translation is enabled.

Thierry

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2hXBAAoJEN0jrNd/PrOhuRYP/1FmGWrTgAmEHgjkkvtOXP/a
vuqoaIZ3/U0tvA/CKMeBwrGWEbv+J8/y0XXYUj7UPnvB4lo6KKymFwWCp2DoaUyt
szt9210CIhfFdFpCANjJRpTUqkPrUrtp6dcF0W0EnbzVAGJitkrJaYUZF/KF806z
o2fodgySJk/VMabQ/Zol3XvrTrbuNpigLkTy2haB8ONuCcxLChhM91gMh+zhbjgZ
YqD2ltczrRWt9DuTvmoSQxonGZQhjyn2SFQB40Twsq3DNKtnjOlMm6rXxKs9GSuc
uBZbYmKPHo6bTchWNHGcuZ/klu8pwai0zeXkTcmjOmRuicZ0pJn1Tw6DC75zrpyN
vG8HJ4Yj0p/Fd2bDrGjp6xY9GrdjPAOsz9pT/TblphLUIx6VEFeef3G5IcDcyzHm
kw5sbG1j4bpSMdNYLCe0IxAuttA04Bnhq/tlmYCI2+tlh7VrjpGk+1pbYdTrMh20
URr6wE5wNbgiuk6UsInrNqT4zfmvFW4H+gjaRb7DzzS4XsWx1p/329FL5524fnlC
4mEGQwhbk+gVGtRIdRQKF2rhh1R4yXC4D/yUnTV5Uwm+WSauvEx5Mq6vHl6T4K+3
fw3X5QoZ6eZPSW13DJqXN2zqet8hyq/TMyixOIBrZfSWRRIhkJX8OW+7i/CFInLu
PbaRSzzA1ijTjAIHpm0A
=Z04E
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

--===============2958180861239380198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2958180861239380198==--
