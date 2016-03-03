From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.5-rc6
Date: Thu, 3 Mar 2016 14:51:51 +0100
Message-ID: <20160303135151.GA30025@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5480306712686849692=="
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


--===============5480306712686849692==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 81f70ba233d5f660e1ea5fe23260ee323af5d53a:

  Linux 4.5-rc5 (2016-02-20 13:39:35 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.5-rc6

for you to fetch changes up to e6a8c9b337eed56eb481e1b4dd2180c25a1e5310:

  iommu/vt-d: Use BUS_NOTIFY_REMOVED_DEVICE in hotplug path (2016-02-29 23:55:16 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.5-rc6

Including one fix for Intel VT-d:

	* Use BUS_NOTIFY_REMOVED_DEVICE notifier to unbind a device from
	  its domain _after_ it has been unbound from its driver. This
	  fixes a BUG_ON being triggered in the PCI hotplug path.

And three for AMD IOMMU:

	* Add a workaround for a hardware issue with ATS in use

	* Fix ATS enable/disable balance when a device is removed

	* Fix a boot warning being triggered when the system has IOMMU
	  performance counters and PCI device 00:00.0 is not covered by
	  the IOMMU

----------------------------------------------------------------
Jay Cornwall (1):
      iommu/amd: Apply workaround for ATS write permission check

Joerg Roedel (2):
      iommu/amd: Detach device from domain before removal
      iommu/vt-d: Use BUS_NOTIFY_REMOVED_DEVICE in hotplug path

Suravee Suthikulpanit (1):
      iommu/amd: Fix boot warning when device 00:00.0 is not iommu covered

 drivers/iommu/amd_iommu.c      |  4 +++
 drivers/iommu/amd_iommu_init.c | 63 ++++++++++++++++++++++++++++++++++--------
 drivers/iommu/dmar.c           |  5 ++--
 drivers/iommu/intel-iommu.c    |  4 +--
 4 files changed, 60 insertions(+), 16 deletions(-)

Please pull.

Thanks,

	Joerg


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJW2EF3AAoJECvwRC2XARrjm48QANMJ4zT/S1I87WHz9TtvYDD/
LmoFDWd3PhlL2uPw3J9SPHtNxDcCyE3YsVyx5/x67AlcufK/UatW3lKVQwwnKwG6
ioRCaLYvhMyfhJLcN6US10offe6oeXoiOaq/zPqyJrT+haZmIzxf49xzr7r8Ksrz
RWnkUUmqyPAdcPIjBNV/L4LrQwE4+Oj9bz0KBkgZ0pIjayjMllskI4BOqfoMH0E4
MkW9S00+q1mNcEEiKpyYzUVono9KE8QMk+CmEPc3nIOQAajinvfzfL3k6LnJwSBx
W7jXW3M8fPQBrAyIWP8sZAf7D/4TUVW1isZgh84ag7kTKH/kzWxbwTSY5foLBl8V
pJvdMHTdBtwnWkpFikcJrmOUOuDCw679xP+1o5K+f0zbepCA+0PAYG9W2ROjjSXl
CrZsq5riA9Pw+hWF1iEvFYvWePIbHzqqVc5+z15FgMRiBG44FBH5QPO5jbXc9kRK
T4ChZlYVoAhH93TYnc8LKHxrqmXBIBlV4jdWycUFEbw1E7ZDJkc46e6AJ2U5rCUM
3Xlv/Gmvj094J0RYEaqZ9PQNZ8hJBm0iR2L58iEcS5WF4NXS4gIDplVGE9X6ZAHS
AQPyZphVmOXuVumjt1OY6DuAz6ojBg/6ABgfne5jXaYCdfDonHtFlx7bPxyeBHem
wS5H+MdIj2hpSsNErSqs
=uY1W
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

--===============5480306712686849692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5480306712686849692==--
