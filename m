From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.0-rc6
Date: Wed, 1 Apr 2015 15:11:28 +0200
Message-ID: <20150401131128.GA29217@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6788453447329942937=="
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


--===============6788453447329942937==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit bc465aa9d045feb0e13b4a8f32cc33c1943f62d6:

  Linux 4.0-rc5 (2015-03-22 16:50:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.0-rc6

for you to fetch changes up to 509fca899d5682a6eee3d1fb70bba7c89439034b:

  iommu/vt-d: Remove unused variable (2015-03-24 15:39:26 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.0-rc6

This contains fixes for:

	* A VT-d issue where hardware domain-ids might be freed while
	  still in use.

	* An ipmmu-vmsa issue where where the device-table was not zero
	  terminated

	* Unchecked register access issue in the arm-smmu driver

----------------------------------------------------------------
Alex Williamson (2):
      iommu/vt-d: Detach domain *only* from attached iommus
      iommu/vt-d: Remove unused variable

Axel Lin (1):
      iommu: ipmmu-vmsa: Add terminating entry for ipmmu_of_ids

Baptiste Reynal (1):
      iommu/arm-smmu: fix ARM_SMMU_FEAT_TRANS_OPS condition

 drivers/iommu/arm-smmu.c    | 9 ++++++---
 drivers/iommu/intel-iommu.c | 7 +++----
 drivers/iommu/ipmmu-vmsa.c  | 1 +
 3 files changed, 10 insertions(+), 7 deletions(-)

Please pull.

Thanks,

	Joerg


--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVG+6AAAoJECvwRC2XARrjTH4P/iRJZis/C3vClVEG3slUybKr
RMuqf5m/x5B0uxU0i03YTgbkEZ+Ok1vjphQ7p+3nkR496uxwqEf+3KHQvwHKMDAl
BfNJkk2Uapuy4EVkPkt5YEITr25pNPHiCtGWW8FE8+zNwCqeUICM9LUCf9eTM+br
fmuPxRTo5+gf0LwIRrz1Zck5qHSjAGn/QIXz+cpSNXdpYO1XetVBx7u/KC/nII8b
le9TWFyNxOe6vvMI8MDq8vh3ux2IO3uHaQ0akX1xA3Lzv5XuGM1XFPuLzEoAaAfO
EYaksscoLZNNpp2DKcb2sP2NvfuvsJgjgorjYOBr1E936GDBYjNGrsqsrcUUI8V2
dy/qwCsH7GFILaOVmZb1AiPasPr+LCFKeRmsAibbd7U5skkBYubr0qgc7MeXitpB
yQ6LfWw14ierKgqR0VdWCl7M4FE0yrYw7KvFd98Ry67kjgvuljDM/WE8bifnGSRV
s88PUtZ64WENdJGzeYzsfAOicDekdyfBZSFTZn05vXu1VEXJYit/F+Fzj3nyMWrS
9A3zeRdfURoxPhJyjQIPm7kk3OjcKFdEOxmP22/efzq/Bd8LqW4XtyPBbwkH8AD0
7uxdGluI5zOGEvwuEFjHT2JRtM+v2MdDXz76/8+ZJHAyt4ph3QMxrGMPB6Pmjx3/
icImr5Gm4qyehh5QZiao
=kj5o
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

--===============6788453447329942937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6788453447329942937==--
