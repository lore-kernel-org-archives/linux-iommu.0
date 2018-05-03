From: James Hogan via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH 11/13] mips, unicore32: swiotlb doesn't need sg->dma_length
Date: Thu, 3 May 2018 07:47:32 +0100
Message-ID: <20180503064731.GA3971@jamesdev>
References: <20180425051539.1989-1-hch@lst.de>
	<20180425051539.1989-12-hch@lst.de>
	<20180502222017.GC20766@jamesdev> <20180503035643.GA9781@lst.de>
Reply-To: James Hogan <jhogan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6195503479831084227=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180503035643.GA9781-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============6195503479831084227==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 05:56:43AM +0200, Christoph Hellwig wrote:
> On Wed, May 02, 2018 at 11:20:18PM +0100, James Hogan wrote:
> > On Wed, Apr 25, 2018 at 07:15:37AM +0200, Christoph Hellwig wrote:
> > > Only mips and unicore32 select CONFIG_NEED_SG_DMA_LENGTH when building
> > > swiotlb.  swiotlb itself never merges segements and doesn't accesses =
the
> > > dma_length field directly, so drop the dependency.
> >=20
> > Is that at odds with Documentation/DMA-API-HOWTO.txt, which seems to
> > suggest arch ports should enable it for IOMMUs?
>=20
> swiotlb isn't really an iommu..  That being said iommus don't have to
> merge segments either if they don't want to, and we have various
> implementations that don't.  The whole dma api documentation needs
> a major overhaul, including merging the various files and dropping a lot
> of dead wood.  It has been on my todo list for a while, with an inner
> hope that someone else would do it before me.

Okay, for MIPS:
Acked-by: James Hogan <jhogan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Cheers
James

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuqwggAKCRA1zuSGKxAj
8jJ0AQDBwGZ2k1NphYwyh6OgPS7IN3FDLAFiO2iFddGI2zSf4AEA9hgbj9kgtHKd
8c/TTL4ZMY/xIMHoCb/jXAC1q13gig8=
=IGGZ
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

--===============6195503479831084227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6195503479831084227==--
