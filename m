From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 03/23] ARM: dt: tegra30: iommu: Add
 "nvidia,memory-clients"
Date: Wed, 26 Jun 2013 12:10:30 +0200
Message-ID: <20130626101028.GD27083@manwe>
References: <1372238906-9346-4-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372238906-9346-4-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 26, 2013 at 12:28:06PM +0300, Hiroshi Doyu wrote:
> Add "nvidia,memory-clients" to identify which swgroup ID a device
> belongs to.

Why not call the property "nvidia,swgid" instead? That seems a lot more
intuitive.

Thierry

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyr4UAAoJEN0jrNd/PrOhffgP/3zmWzS+WPmP7BAXw4zMgfGA
AXRgECMBaIVYOl8WRYYtYJoWmQ3t2mKEpu2zlvV1q4NEq/9yew59sgfcJ8fZinim
usEjYhoaPDGY1Uc0rrxEN+oYRPfF46oaTgywToO/jUKAhkpk8HlackxvBp9ZZ5Cy
vqL3GRD/6rmbDrThTjjp52nHVtBo3MAL/FCt6BB06aLBLEgrpFc9GQ5aYzf856e2
ZizYrT+jAqKFvF/d0ytEmD+ywmQQKXcE5E1pMJt5ldFfDwEEnUfSh5iPMrODP0PU
WBwDlVTQj3ZU3vLPfy2+54iOWsE9Ko1LTowfXtfZRSL5uI/HFFR3LXO5Oc6yEF7D
M0yaAxGqZ03AqXIsNTmNR1HZW++GjY4ezGylGsAgIASb4FW9RJ/0f9dfnk4ISR9r
TlOt5mUMDJYlEeb3SocF6+2YqGWcPVvwisXK3Cv2pdrcRQCGKtpic8CSxjoMo8MM
AOmOiV0zg4WS8G+SZ2mg4RJ2ED0PxpHxf5i7MTERVaAuHqtZPkczfL9QMKncbiWi
1UOXi0FbyXElbLMoY5iqHFNalE/xaQ67uXR1hO+frrfiUDc6w7uVq/qQWjEQL72p
eZS2ZLm6v0YqT8VXxz8aCmJm6J4ex796szgG3nxL0ZbVEBI/g9Lb0FpBm2Dxi/hr
bQnRU3md/Z1JZBC0IEXf
=Cazp
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--
