From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 0/4] Add NVIDIA Tegra DRM support
Date: Fri, 20 Apr 2012 07:05:21 +0200
Message-ID: <20120420050521.GB15313@avionic-0098.adnet.avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
 <20120419173537.GA7692@avionic-0098.adnet.avionic-design.de>
 <CAPM=9tzK83yYS33eNruvFDwb62ycZxJMC31davVRN=yaZD53YA@mail.gmail.com>
 <20120419204016.GA8954@avionic-0098.mockup.avionic-design.de>
 <CAH3drwZhTzuOVfybB_KBgk22csK47xXv5G4aMOuqPy+ibKd21A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAH3drwZhTzuOVfybB_KBgk22csK47xXv5G4aMOuqPy+ibKd21A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Jerome Glisse wrote:
> Or you can hide the accel ioctl behing a staging/experimental kernel
> option that give you right to change the ABI and do everything upstream.
> Once you like your abi you just remove the option and enable the
> ioctl for the default case.

If it's acceptable, that sound like the most promising way to go.

Thanks,
Thierry

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+Q7pEACgkQZ+BJyKLjJp951ACgjQ1R+wr6yDIkbnSu2+nUkIkx
o8UAoKxU8W34gWFg/uBydakv0t/M9MG5
=ErkJ
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
