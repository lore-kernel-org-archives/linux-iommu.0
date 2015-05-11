From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.1-rc3
Date: Mon, 11 May 2015 19:52:55 +0200
Message-ID: <20150511175255.GA31276@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5741803369699049061=="
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


--===============5741803369699049061==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.1-rc3

for you to fetch changes up to 5dc5616ee850eaba055bb469a6c4a471d489140e:

  iommu/arm-smmu: Fix sign-extension of upstream bus addresses at stage 1 (2015-05-11 18:36:20 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.1-rc3

Three fixes have queued up:

        * Reference count fix in the AMD IOMMUv2 driver

        * Sign extension fix in the ARM-SMMU driver

	* Build fix for rockchip driver with device tree

----------------------------------------------------------------
Arnd Bergmann (1):
      iommu/rockchip: Fix build without CONFIG_OF

Oded Gabbay (1):
      iommu/amd: Fix bug in put_pasid_state_wait

Will Deacon (1):
      iommu/arm-smmu: Fix sign-extension of upstream bus addresses at stage 1

 drivers/iommu/amd_iommu_v2.c   |  1 +
 drivers/iommu/arm-smmu.c       | 30 ++----------------------------
 drivers/iommu/rockchip-iommu.c |  4 +---
 3 files changed, 4 insertions(+), 31 deletions(-)

Please pull.

Thanks,

	Joerg


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVUOx3AAoJECvwRC2XARrjjYQQAMaZ9bawW1yrXfJEg08sckC2
EXwBZovYV3mf/OKLkyUB1yMjgcvWDuHoHjvDhC5TvPlnXdtjbT6Cv1C8sr/d+T3O
QJEAz2wWUsiwpW26XyxskwPH5EySkdpl+s405GK+jr0xiRreFpSX3A63mPpu8u6m
KNtuy44mcfYb8bQ8q6W1ODavnWo5+wvHs561DfC0uHlONwe2qhPnTH73Xb4tou95
55wxHN2PW0gqxaoEG6/6nX2NEyVOElBAcW7UJYsC5TZLVFy6MTp1MhHQd4RAr4Gj
+Emq2giJmGD++DwnKvvS1epQ0DDMz1ETFRIdNyDsVz0Sb+xN6z9YrEyEBzskcRii
PQwPBvy9GjG4NcOy4PNZzVhbP9fCKW7pufgQmLJfCEvCNr/76aezEChAWuiC5v0t
DeMLeL4tjP84MfpHxHD9VWIefPI/pn5rFE52udUlgo5jQ8/LnNpSSuuxi9UWfQw4
CrwyAy7y5ZglZenHA0ygj/o7G0iBfZ43JaiMDRh04NqMitNsQtDRys1OTABQN6O6
m5BRZ8uzsfqdUwMyX5HellH2kbZ3XeFs3olFKbMqvW9VOgF02sqbXb4tZBksoXNR
uw+R82HBxR5t+HdHEz0XpoFlFD4C/M9FMJlaAqzJRycCUgdrTrDDPFmvMOv7Apua
QIAiA9nJ5VRYFxvfVQwZ
=jqmf
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

--===============5741803369699049061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5741803369699049061==--
