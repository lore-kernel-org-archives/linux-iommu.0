From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.5-rc1
Date: Fri, 29 Jan 2016 15:22:24 +0100
Message-ID: <20160129142224.GF4204@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0669010142912888915=="
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


--===============0669010142912888915==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.5-rc1

for you to fetch changes up to 0d9bacb6c8265e7aa75ac28ae9b5d7748065942f:

  iommu: Update struct iommu_ops comments (2016-01-29 12:34:29 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.5-rc1

Five patches queued up:

	* Two patches for the AMD and Intel IOMMU drivers to fix alias
	  handling and ATS handling.

	* Fix build error with arm io-pgtable code

	* Two documentation fixes

----------------------------------------------------------------
Baoquan He (1):
      iommu/amd: Correct the wrong setting of alias DTE in do_attach

Jeremy McNicoll (1):
      iommu/vt-d: Don't skip PCI devices when disabling IOTLB

Lada Trimasova (1):
      iommu/io-pgtable-arm: Fix io-pgtable-arm build failure

Magnus Damm (1):
      iommu: Update struct iommu_ops comments

Michael S. Tsirkin (1):
      iommu/vt-d: Fix link to Intel IOMMU Specification

 Documentation/Intel-IOMMU.txt  |  2 +-
 drivers/iommu/amd_iommu.c      |  2 +-
 drivers/iommu/intel-iommu.c    |  2 +-
 drivers/iommu/io-pgtable-arm.c |  1 +
 include/linux/iommu.h          | 16 ++++++++++++----
 5 files changed, 16 insertions(+), 7 deletions(-)

Please pull.

Thanks,

	Joerg


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJWq3WgAAoJECvwRC2XARrjk60QALi32ut/eb1csiLJfeayAerd
FPAUx9osDxFIDl4cskh0/Wv8EriCynYA8rf19qg6gGxbxKBFsRakOI8YVW2u4A1Z
HcjtDtugx3AKl06P79mkzTF8z4jwgBzJiyjk3a5yKbh+lIo3vqlsZeclvTdKUA52
53WHMpOox1okx5+WUCddcW20CfCyGr7Y3bF5Mx1bB8X9Wu4E7Z/yPmxaW4dnfu7O
VqdOZOT6aWE4bxE3FtJiZAiLbqxdz3AYaGB5ar/vOJxI5TmMP6oQGxTLDHlBwzmb
23dtkGCmimfooFV/t/nCANhnOSlsWgCGJxDKMoYPsvUlgnvgLshTM0n0s82A30Wa
63UOXJt1T0Kijrmx1O/fPRb9Vrt9Tt3LrK0rha55yl5JuwBYDb3PVzxbwyPR26ru
sPSQjF5c/bKNYfnyqe1Qwd/dbsg9PJP4yKvjW3kX8TC/o4GQgYrcB/NqeO5PDjq4
E/uzVQVYnVa2lLRjn6m8rFcKNgqcgSIkywoH7gXSXhgbqnA/aG1SxZJ57OeMeG8M
ZBh7ZLqZln+HsTfdEi8J223AH69G8kuEvafFwa3PQoqMAgHXKDSY7YQ4A6gNQaZE
Nyw3HHypt83RgEH1hvMrpjgLvdqJwrITAbNL5rS3HpTfTB+IuLY5OhIie70kLPYZ
/1KhAQ+df6hdQ/7bojXL
=xAyU
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--

--===============0669010142912888915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0669010142912888915==--
