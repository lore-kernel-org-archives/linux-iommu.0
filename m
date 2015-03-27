From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 09/16] iommu/tegra-smmu: Make use of domain_alloc and
	domain_free
Date: Fri, 27 Mar 2015 11:59:48 +0100
Message-ID: <20150327105946.GA5440@ulmo.nvidia.com>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
	<1427373799-18662-10-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3845829274076137479=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1427373799-18662-10-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============3845829274076137479==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 01:43:12PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>=20
> Implement domain_alloc and domain_free iommu-ops as a
> replacement for domain_init/domain_destroy.
>=20
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c | 41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVFTgfAAoJEN0jrNd/PrOhVFAQALuslBm7B5Zb7XsdRKPJHaTZ
pCO5rUG52jL8tgU/r1uq9sim4gGcAyxzDXQ80ixQaO3sNBAIev4CsKxYXHZjD5V2
5XqaQPakejzZldUcnD8c7B/gZFsW3E5PQieCEmmj1H5v3RP1OVLblgsF6MGsOU42
RKErLUs3Jcw7w9CCck1F88jzraOABlk5/YOR8TBVo82IC6VBwdaQDeNCeYkBAuE4
0QPhiXs11vbHoXcWEXc90CpSKXg4kUG3Bmxq8fvnXUzdmizJXAqeUXytJGLA2z8Z
T/CrDgORQHsUMwaZSku9amFlao0kYH77QAN7HVhJ6OVjOJ3P6pIW+K/Pmdc0sV3F
wurkpkLEORnRZTzdkpB3DCdlzsOTtJO0yXdgff3FGlgc52cyMwvjGrIivg7z+Zgg
Bgl1CbfJmPumbkWWpB9jU2uTGa2gu0nXnShCsN58DmAh33o5uiXA0MSuEzDBRtqK
6gG0rKYQ6jFT0RT0tUaVhKzqW6NjI6EYYqQprRk6ouAVTOdwOY8dLm3pN79PdMSm
+wISPj5+/iI8ZfWJV7otgjgpcO6boehvWeL5F6lob7N8PjfgWXFVX7ttxVEAD2r+
02bjD47lX0KZdfl/jmbsD1ddX9wLaPAyDPHUFApjzUavHPa2JDEU01vtDqk9eVdK
/e9BDnaJqBFAnpG1JQOg
=bESF
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--===============3845829274076137479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3845829274076137479==--
