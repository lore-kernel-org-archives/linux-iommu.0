From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.10-rc2
Date: Fri, 6 Jan 2017 16:02:15 +0100
Message-ID: <20170106150209.GA29909@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2497852214782882652=="
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


--===============2497852214782882652==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.10-rc2

for you to fetch changes up to 432abf68a79332282329286d190e21fe3ac02a31:

  iommu/amd: Fix the left value check of cmd buffer (2017-01-04 15:22:22 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.10-rc2

Three fixes queued up:

	* Fix an issue with command buffer overflow handling in the AMD
	  IOMMU driver

	* Add an additional context entry flush to the Intel VT-d driver
	  to make sure any old context entry from kdump copying is
	  flushed out of the cache

	* Correct the encoding of the PASID table size in the Intel VT-d
	  driver

----------------------------------------------------------------
Huang Rui (1):
      iommu/amd: Fix the left value check of cmd buffer

Jacob Pan (1):
      iommu/vt-d: Fix pasid table size encoding

Xunlei Pang (1):
      iommu/vt-d: Flush old iommu caches for kdump when the device gets context mapped

 drivers/iommu/amd_iommu.c   |  2 +-
 drivers/iommu/intel-iommu.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

Please pull.

Thanks,

	Joerg

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJYb7FxAAoJECvwRC2XARrjdg0P/i6So7BsACaqoUnPSIx4HxG1
1YaGviu5ko516apfzmLLiSUW8/lkgwOEcfbMOEbkH6ivfM58MfsCmz65CC937qzC
ERL/GqG6n++br9AKYMiUSH/2K+YQ2cwIExVB6TAHRcf9C6eZSk6q+S40213y/H/g
Vtue4LhYrdwNczW1M1UapxDGciLhlAcDN7XCb3vuoYQI70YUZzpOTtr8/deWc65R
/QrNQshGTCFnOxIvkKeVtqMmKnyz+74P0Y3LzcXxlOtJsAi9aSU+si+GeCrWzm4H
IXZfjo2EDG3QTHHf8m6MGhj0uYIQg5V5OpaPWi0XcMeRSsjYTI5Klwe8f6oUdI3H
4E0eW/vt/9ybj537dyTgGkP17wz4hbOAsTr4SkAs+Wi0F3H5de5ZNJroswpAxGS0
BQT4q/Gk/ue9WCzkwcK60dFd6iVDTWek0H7H9SI38fAWtYYPmcvJddoi21CTIb3z
BOewo14igM7vnnNXTsJ536xKhKWQrmjmfc3/+oYqSVU12lAmkPKcbgXEJpQ1mZtC
PFRuHO/u1o/mKCjQv4GpFqKU0Yoc4Ve+Kzg0xgb4A31AQuHA5Zo0+jL4LspnXJGJ
4nqkVXikRin14e205+bnz83EKfrNzfixrIU0DJ+OKP409VOih95NNmYFs8j5NKh+
Rkxu9ykLmhtZmyputB7/
=Mk7l
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--

--===============2497852214782882652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2497852214782882652==--
