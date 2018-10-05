From: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Subject: Re: linux-next: Tree for Oct 4
Date: Fri, 5 Oct 2018 15:39:05 +1000
Message-ID: <20181005153905.126a005e@canb.auug.org.au>
References: <20181004183449.36bcc93b@canb.auug.org.au>
	<20181004134644.GA9130@roeck-us.net>
	<CAMuHMdXfhbFi8HYtqd6BeACyG64_eQvoiSQ7DMpyOmdXEXPymg@mail.gmail.com>
	<20181005094445.4d0b68bc@canb.auug.org.au>
	<01c4a73c-7901-2fbb-8f87-95ff21dc5126@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7172063334786996210=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <01c4a73c-7901-2fbb-8f87-95ff21dc5126-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Linus PPC <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux-Next <linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============7172063334786996210==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WI7YS39RX_FlyJjOQWG/6Eg"; protocol="application/pgp-signature"

--Sig_/WI7YS39RX_FlyJjOQWG/6Eg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Thu, 4 Oct 2018 18:33:02 -0700 Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
>
> Most of the boot failures are hopefully fixed with
> https://lore.kernel.org/patchwork/patch/995254/

I have added that commit to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/WI7YS39RX_FlyJjOQWG/6Eg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu2+PkACgkQAVBC80lX
0GxQzAgApaFroQMOF/b1oY8XdG0dDLNLqqOUPOKS294M4YJFl+hqZzB7UYdIYX1Y
PMZG8dwYDTQZuwvs3RVTsazCV3tWCvNgjk1VhvkUITwHQMmecDauMXwMr+chePgs
lsjwmnU+e6KojE7M4XdEFKeVhLxdK0LKmeBF6Nv5hYFvverfxl4ABRz4u7m1nxhg
ra4lUBWYjk7j/vbcKkMDU5PHhEZgfa/CQmDmR1idbv4Ceb1Z/EOo+G9v+fkgRZDk
PRH5B57R5x4ibDKbzWXwwtF2fbC1RYmGtkjioOTRQBk9avjxcpOgjn98oCNlHCUG
gd95XlVy2O22aLaUrl300VeJ/d7mpA==
=S9O9
-----END PGP SIGNATURE-----

--Sig_/WI7YS39RX_FlyJjOQWG/6Eg--

--===============7172063334786996210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7172063334786996210==--
