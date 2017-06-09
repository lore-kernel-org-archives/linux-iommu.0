From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.12-rc4
Date: Sat, 10 Jun 2017 00:38:10 +0200
Message-ID: <20170609223804.GA26113@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7299605323810097411=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============7299605323810097411==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 5ed02dbb497422bf225783f46e6eadd237d23d6b:

  Linux 4.12-rc3 (2017-05-28 17:20:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.12-rc4

for you to fetch changes up to d3e01c51598b2639a4830549058500e5f2ace86f:

  arm: dma-mapping: Reset the device's dma_ops (2017-05-30 11:31:34 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.12-rc4

Including:

	* Another compile-fix for my header cleanup

	* A couple of fixes for the recently merged IOMMU probe
	  deferal code

	* Includes fixes for ACPI/IORT code necessary with
	  IOMMU probe deferal

----------------------------------------------------------------
Arnd Bergmann (1):
      iommu/dma: Fix function declaration

Laurent Pinchart (1):
      ARM: dma-mapping: Don't tear down third-party mappings

Lorenzo Pieralisi (1):
      ACPI/IORT: Move the check to get iommu_ops from translated fwspec

Sricharan R (4):
      iommu/of: Fix check for returning EPROBE_DEFER
      iommu/of: Ignore all errors except EPROBE_DEFER
      ACPI/IORT: Ignore all errors except EPROBE_DEFER
      arm: dma-mapping: Reset the device's dma_ops

 arch/arm/include/asm/device.h |  3 ++-
 arch/arm/mm/dma-mapping.c     | 29 ++++++++++++++---------------
 drivers/acpi/arm64/iort.c     | 22 ++++++++++++++--------
 drivers/acpi/scan.c           |  4 ++--
 drivers/iommu/of_iommu.c      |  7 +++++++
 drivers/of/device.c           |  4 ++--
 include/linux/dma-iommu.h     |  1 +
 7 files changed, 42 insertions(+), 28 deletions(-)

Please pull.

Thanks,

	Joerg

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJZOyNMAAoJECvwRC2XARrjBv4P/AkHWbUWZBdPdlpVFUCUmIm7
UvpHGPOiv5FAi4UW+x2leNNx4GQ2/h9OS9t9cu5xPE49Bw/gvXGFJBUXh4YpJXoc
yFD8FIxlUSoXMCYBBrgl5BiB8vqCkdsj1O9cVIFHc1QazCUAPLJvdsizHfnULQrw
WAFNlPekkEPAWYUus0pFEGF6YjuyZf24Y/qTlIXYolQH2gDOfn7/hNdVv8X/HRV+
un5vnIfoGNV1eg2zL2j/ILtafMrAEDExO0lXe0+s+nRUX/14RD3zuUZSTWcFy5dz
8vAu18nQq9vxgRqUBJ3xecWDCVlOtCGhzef0PIuAqlUA3o3r+shsAmoNxFiudl4K
NxVOb3nDG4XjmDMELf8GQDFpxltGipcz4+pYtr9DJ1YprMPEyszZf6TYXF+K2Dk9
ttfNO2SRc/7E3MRze16LwyuJqj5mAyaTBWWbyQYATtP+WjEKosztpuKB65c1U+eF
81/+Y2Q8p+jsOl307m3fyqVF50qti5Yo5bEYGpvd3PvcKBjHZ7lWpT6WuSP/OVIE
SygJIVufIHNRJBF+avuC2QDzaxvjjynEUKCqnGwtKEPxIyubUucHSOevY9CLyCxo
xN+JxTPAnUqqOpzg0cVVpQloTVAm9ur2QKa6XLO5mGH7YyFH+WF9ZVu65iPt3c1f
IWywKI4Nk8YMfsxyYwui
=p+Wd
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

--===============7299605323810097411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7299605323810097411==--
