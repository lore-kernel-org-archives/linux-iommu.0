From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [RFC v2 2/5] tps6586x: Add device tree support
Date: Wed, 25 Apr 2012 11:47:42 +0100
Message-ID: <20120425104742.GA20492@opensource.wolfsonmicro.com>
References: <1335347102-14905-1-git-send-email-thierry.reding@avionic-design.de>
 <1335347102-14905-3-git-send-email-thierry.reding@avionic-design.de>
 <20120425101031.GH3195@opensource.wolfsonmicro.com>
 <20120425101429.GA5085@avionic-0098.mockup.avionic-design.de>
 <20120425104147.GB5085@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120425104147.GB5085-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 25, 2012 at 12:41:47PM +0200, Thierry Reding wrote:

> After taking a closer look I don't think Rhyland's patch is very useful for
> this driver. I need to lookup the platform ID by regulator name anyway so
> using the new code is actually more work and requires a second table that
> lists the regulator names only.

Why do you need the plaform ID, and if it is needed could we work out a
way to make the generic code do that lookup for you (since presumably
other drivers will have the same requirement)?  If you can't use the
generic code it seems like the fix is to enhance the generic code and
I'd expect that something not requiring the platform ID would just be
able to igore that information if the generic code could look it up.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPl9ZIAAoJEBus8iNuMP3doOUP+gM4UU/3vhsy3T0bttkbBLEJ
QPwTuy155eJfsC8nDE/ojfZCjUfzfm0SspCeHvd5CzT9AEenEbxsTu3U1n9nnSjr
UwU7vQZj6PhS3tP5SSLXv6hVvIDjkLq61IYYZn6ZPyD1U/+uHzfX7OIwLjoFMMnm
drBcJKJpFTvZD1B1ifWJw8L707BLBsaIdj91EDXCODnx7ztpnTQ1TL5qxQokntgU
OHcrkPXlDYWgisk1hyQEhJaRAZVA8B+w/o3geLt13ClONY7zYXQszchlokZ5horw
nv2deAVhu4w5AbRJzKdMFqL1QRuiKuQfGtWpFgK/yHrdHf+8pEnNlBn5d1gLU6LI
slXrHUACRn8V94UcwwID2KE7ne3UrO53Bzn893G78UrhE7IJzumAKj0iMQ2gYB4q
qN6svCZ2CuvpeS+zroxDHTB4E/v2KL/xl3q14L+nUp4SfPjBIx2sxRr0Wmg61cs7
IkHKvDg1p5fgQ8/OLczE6T46ZoUOS4JHM6wt5Aj0Ud1tSYFbqk4hS8e079k1OP1m
ZBL/iQsbbwRdmptrNYQzrPxDO0fygVn7kBwO3TRcfKWH2tS0v9fK8QykajEYpQDE
UN7g2jbf9lbIyVfFRVWNgy7P2jEmOuIUVpbWJmaESDT+IY6Kt9fKbztlA7JMoN5U
Ch0YhA8ce08B97h4lniE
=i4oW
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
