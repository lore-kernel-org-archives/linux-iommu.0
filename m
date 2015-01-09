From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] Change order of linkage in kernel makefiles for amdkfd
Date: Fri, 9 Jan 2015 10:56:43 +0100
Message-ID: <20150109095642.GD27845@ulmo>
References: <1419246435-7050-1-git-send-email-oded.gabbay@amd.com>
	<1621810.aTt9O4Ghzs@avalon> <549FEB52.4020103@amd.com>
	<1678486.9ZXZnn5och@avalon> <54A12028.7020303@amd.com>
	<20150105154657.GJ12010@ulmo.nvidia.com> <54AE910E.5060803@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2533725765740632537=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54AE910E.5060803-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Dana Elifaz <Dana.Elifaz-5C7GfCeVMHo@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Alexander Deucher <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============2533725765740632537==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2015 at 04:15:42PM +0200, Oded Gabbay wrote:
> Hi Thierry,
> Generally I agree with the issues you describe in the current design.
> One task in our 2015 workplan is to change the whole method amdkfd is
> loaded, so it can independently load at any time, regardless of the order of
> loading between it and radeon and amd_iommu_v2. To reach that goal, I assume
> we will have to use some form of deferred probing.

Sounds good.

> However, for the moment, this is the best band-aid I could think of, and
> choosing between this band-aid or no band-aid at all, I prefer the former
> any day.

Looking at the patches, the dependency is documented in the Makefile. I
guess that's fine as a temporary band-aid.

Thierry

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUr6XaAAoJEN0jrNd/PrOh9O8QAJldCX8K4vY+KWwbCDHfUUfo
llQLJs6E+9IkbGsD+btOjJYEPyBrlSxZ/C4GNBHIM7x+Uypj6BdCHT877nm3/Vkq
9AJcfWK3dK3zXvAXgOrQDDNMg4gpLOsUSWEuIC8/7eORP8LEM0zHhC/ZFBYxHm8Z
0Qlgva7qXesF73/mSSPgX1o/shEP4/5Vje9u7HG5hqedeYYyGmSPBVJnkMXmDYMa
hhM7pvtY6PhsxCdYzasAIr6LpkEdp0yRyrfS2or6TlfAoSRpPaXwjCFYVD/R2yjD
uy+kcTBeBsNvvyvh4MEttU2yXBBqF2dD6Mg7z6wl9sau2QeHtWw2QB803RQ4qhXE
IvJei79GR0MVb9rsliVTeHCjbPl0dS5yCgSTQAhqIfYyP4O0eoB9zicYCxOVz4Wg
a+YSkRfvwAQwYOQLjEa3puTeEYCfuGRD8Y/5iwSFd/Zas5B53yn4lg0hXVbyu2kq
65hxnUlu3OjNnPg9daXcTCbcidORChaasjfi30yET4B4wwuzyCIc7Lde3MwwayiH
mgWAxeXkyRrjdY1w1SpdBjS4TftuEZcAAWuB7Ge+V4Qpn8y7Yi7IFgbFD17u9Ouq
YM+sqo2aTatckYPhqIeYgEzc7C+yzVXWzGxSm7ZsMCyw2PeqN0O1gtFbfFX7u4Up
nZA4K56/xnAvDruakUpS
=3gCS
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--

--===============2533725765740632537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2533725765740632537==--
