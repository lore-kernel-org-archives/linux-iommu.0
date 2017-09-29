From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.14-rc2
Date: Fri, 29 Sep 2017 15:51:13 +0200
Message-ID: <20170929135109.57hvydwuexbqyzvr@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1593790044188152278=="
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


--===============1593790044188152278==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lxzswvgkq3vuxk2"
Content-Disposition: inline


--3lxzswvgkq3vuxk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit e19b205be43d11bff638cad4487008c48d21c103:

  Linux 4.14-rc2 (2017-09-24 16:38:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.14-rc2

for you to fetch changes up to 50ce6312f293e129eedf2affc7bd791c71d8287e:

  iommu: Fix comment for iommu_ops.map_sg (2017-09-27 17:02:45 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.14-rc2

Including:

	* A comment fix for 'struct iommu_ops'

	* Format string fixes for AMD IOMMU, unfortunatly I missed that
	  during review.

	* Limit mediatek physical addresses to 32 bit for v7s to fix a
	  warning triggered in io-page-table code.

	* Fix dma-sync in io-pgtable-arm-v7s code

----------------------------------------------------------------
Arvind Yadav (1):
      iommu/amd: pr_err() strings should end with newlines

Jean-Philippe Brucker (1):
      iommu: Fix comment for iommu_ops.map_sg

Yong Wu (2):
      iommu/io-pgtable-arm-v7s: Need dma-sync while there is no QUIRK_NO_DMA
      iommu/mediatek: Limit the physical address in 32bit for v7s

 drivers/iommu/amd_iommu_init.c     | 8 ++++----
 drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
 drivers/iommu/mtk_iommu.c          | 3 ++-
 include/linux/iommu.h              | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

Please pull.

Thanks,

	Joerg

--3lxzswvgkq3vuxk2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJZzk/NAAoJECvwRC2XARrjHZMQANSnWEGaMyHMvdGWGXFt4aZ9
dL2O6De9taCZYT1gQKH+aqtDziMOF9qvp2dkKI8t6hGdaX1hDDwl+uNkXILNtQkx
mpJu9bLH0Oad2h1nnLmjHRphNdjupH4G8XAjsMqCxzGgcJXhtEfPAGsxsJmNG346
rgup++Z9m4CbOPI/LdFDilbyhsD2alA6X1U3UA7VBD+iXwWKdO6wy77tDJ5Z7tJO
fu7RC7P4iH3A2bGYXjna7g/sdrhYFtj0O/f6QWsfYWjLZz0OIhLyNuL9iOdBpzKq
qsyxk4L7YYZTiLSpNVOxRsfQlWQ8eJcd57ejYgdHGD1rz058SL7Fs0YUpOBTLk5T
Y0tQA2uNqv4Ol/Jrkvw2ytnqmCX6vx2K/qwij13ApXPvhcWSH/vv93L+dFKHT0k9
IZJuIUrs+vOvhhFLUQlr60B9U/3s4KNOGm+2jEEDK9Td3ZzXbfiNZP/K8Jz1oHy3
M+cej1FHvMmCDv2q3wA9aeFepi+EQVyb7HBqBF0Qb9WubMgAJWtkIQma27C8j0Yy
S0dRD2q1CNP9qe/OibzQOF4C6XpRqBXmjQQeVZSEnb+yOCDeGrc26AlSt7fgvOM0
vB7sxl2Zb/MxkhL41Le3TJy+32NohfyL3j4VKyfdkC/gqpLNPRmLottFV48Nf2G4
1Wmwb/S5d6fxF2nyTPMR
=3VmD
-----END PGP SIGNATURE-----

--3lxzswvgkq3vuxk2--

--===============1593790044188152278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1593790044188152278==--
