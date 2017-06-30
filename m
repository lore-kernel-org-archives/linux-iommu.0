From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.12-rc7
Date: Fri, 30 Jun 2017 18:56:03 +0200
Message-ID: <20170630165557.GA22586@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6163472328199287549=="
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


--===============6163472328199287549==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 32c1431eea4881a6b17bd7c639315010aeefa452:

  Linux 4.12-rc5 (2017-06-11 16:48:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.12-rc7

for you to fetch changes up to 84a21dbdef0b96d773599c33c2afbb002198d303:

  iommu/amd: Fix interrupt remapping when disable guest_mode (2017-06-28 14:44:56 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux 4.12-rc7

	Two fixes:

		* A fix for AMD IOMMU interrupt remapping code when
		  IRQs are forwarded directly to KVM guests

		* Fixed check in the recently merged code to allow
		  tboot with Intel VT-d disabled

----------------------------------------------------------------
Shaohua Li (1):
      iommu/vt-d: Correctly disable Intel IOMMU force on

Suravee Suthikulpanit (1):
      iommu/amd: Fix interrupt remapping when disable guest_mode

 arch/x86/kernel/tboot.c   | 2 +-
 drivers/iommu/amd_iommu.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

Please pull.

Thanks,

	Joerg

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJZVoKdAAoJECvwRC2XARrjIYQQANkEFXVmHS+qJLv2KbabuCM6
4yVWV503hV9Cmfg3yw4ExiD9GMGse5mLdv3aBKPNcUBDe6OnmJQ2jj+M6yFWwoDS
TqGGBsFaPKBJ6CoBS94n+fSDGNsZ5w37B2MFH9IrcqxVcxn5BHd9k7oObRZnEUxz
Xx21W1mKM7RCNWYC3ICBeU1Yg6TAw5VzUa034pKjN5L0voovnjUiEi7IITzhd/PZ
iz/BZ1T2vibISqFIuBJ7+kjguMsXOFaajrxCc2UY5loSYOh9Yztwyr2trrtzda4U
fsdIliv3Bc2mrT9Ww1/llG5azVWu+Z3V5f1HJiZbw2WNsQfELl8nCKf/tHO6zXbI
QuqBIcFtCe+O1h3zFUqPLWwPNf5DBjbzFh7w+kqgpj/CpHz9mZoeiArxuzc3iQ/t
q0VZs8JO743qMdVKBA+7NtSexNOUAQdV49NqXYF77DJHSGjcqy3rUVRy25B1V2WU
cF5gpPWoJx0vUcG+9KXZmO7q0KgvOD8Mp9EbrkUC43YReM1h1NGUnp75klhp5V/0
iahLigEJDw/qxUcAghQBVCynbkMvj5AsfRrcV5VsaZKIUr/b2GI/XW90gn3oTzLX
IyuvsyPltu7fR1by0qHlUWX3wvYNKG+RZwXJE7bTp7k/xOmXouyRbceJrpY/d/bo
6Kh7Mx8QbMixsZY1s7PY
=SPpF
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

--===============6163472328199287549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6163472328199287549==--
