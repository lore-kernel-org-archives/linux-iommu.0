From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 3/7] iommu: add new iommu_ops callback for adding a
	device with a set of IDs
Date: Mon, 1 Sep 2014 10:13:22 +0200
Message-ID: <20140901081320.GB24430@ulmo>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<1409327670-3495-4-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4318799479246009118=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409327670-3495-4-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============4318799479246009118==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2014 at 04:54:26PM +0100, Will Deacon wrote:
> This patch adds a new function to the iommu_ops structure to allow a
> device to be added to a specific IOMMU instance along with a set of
> opaque IDs that are used internally by the IOMMU for identifying and
> configuring translations.
>=20
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  include/linux/iommu.h | 2 ++
>  1 file changed, 2 insertions(+)

I don't really see the point of this new callback. As I understand it,
the strength of the current .add_device() callback is that it uses only
the struct device and figures out which exact IOMMU to associate it with
in case there are multiple IOMMUs.

Although that doesn't seem to be the general case either. That's really
been one of the difficulties in dealing with IOMMU. Every driver seems
to do things very differently and the IOMMU subsystem itself is fairly
different from other subsystems too.

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 20f9a527922a..3dd1b99c4542 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -114,6 +114,8 @@ struct iommu_ops {
>  	int (*domain_has_cap)(struct iommu_domain *domain,
>  			      unsigned long cap);
>  	int (*add_device)(struct device *dev);
> +	int (*add_device_master_ids)(struct device *dev, int count, u32 *ids,
> +				     void *data);

If we want to pass around IOMMU instances I think we should make them
proper objects rather than some loosely specified void *.

Also the generic IOMMU binding doesn't require the IOMMU specifier to
contain master IDs. So this seems to be a callback that would only be
used by a restricted set of IOMMUs.

Thierry

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBCqgAAoJEN0jrNd/PrOhdDIP/3+k7sJHOL/cYMaYac2XtHim
XTxjA6SRNxiMaBsqJu/McSR9tPmjRTMMlYdNm9VOSmSMm8j5qmD0xq7z13nnWCq7
Nu5BIrNYiWXwAv0JRIRokx/ZKeRulkhHM6OKLQbu4oMKxfa4OlOxczuTNtou2VPY
2yX8Svs6MFDfFrP7LcGOB6AvS96PhqKAFbqSfYefZ4yrMJSVBuGoz0w01lx26fh2
p0gv3xCcDsleXWlYXoE1IVZI6OWXqBMQgUJh5AzhXDa37GDJfnal/I2yaSYODX5J
Fmy/LupiZJqhhRJfF7IiNeFDp7vN/Ft1YB2d/u62OYXZogdmwYHptBEZdGfNFjBT
ZN7AdX63trlEZ+T0RmTlEDBHdTXWzPvdJTl7Fr/0KiiScpPWhQB11thIUsGyFur4
bpoZnPJIrdakx/ozDBvKmShdZb2Tzz5dG1KPQMAIL8V2TNWhC7JuzPh2ue+o6PJM
QjXWuBro5jQVfiNueXvcKgecAhIhUeM8m2NFRTp0k9t0kxCu0LCOP3VwDcpiJjO2
uyA1jaorc5Bc1bZCmDmpRDaOqBw0H4wEcRmZrTGO6xsoY+nKhRnm1MnVpEQKBuC3
TkFAWlF+zx3yqhpSZpupHNeUHaRXETbIeTwgtmKGdwR/82xdU7FUURQCs6PoSVLy
YcPY3EQchGdtA8lGI1Zf
=xn+H
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--

--===============4318799479246009118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4318799479246009118==--
