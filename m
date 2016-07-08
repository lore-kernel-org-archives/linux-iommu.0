From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.7-rc6
Date: Fri, 8 Jul 2016 16:30:56 +0200
Message-ID: <20160708143046.GA1093@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6167494132155358307=="
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


--===============6167494132155358307==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit a99cde438de0c4c0cecc1d1af1a55a75b10bfdef:

  Linux 4.7-rc6 (2016-07-03 23:01:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.7-rc6

for you to fetch changes up to 522e5cb76d0663c88f96b6a8301451c8efa37207:

  iommu/amd: Fix unity mapping initialization race (2016-07-06 18:04:55 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.7-rc6

Two Fixes:

	* Intel VT-d fix for a suspend/resume issue, introduced with the
	  scalability improvements in this cycle.

	* AMD IOMMU fix for systems that have unity mappings defined. There was
	  a race where translation got enabled before the unity mappings were
	  in place. This issue was seen on some HP servers.

----------------------------------------------------------------
Aaron Campbell (1):
      iommu/vt-d: Fix infinite loop in free_all_cpu_cached_iovas

Joerg Roedel (1):
      iommu/amd: Fix unity mapping initialization race

 drivers/iommu/amd_iommu_init.c | 14 ++++++++++++--
 drivers/iommu/intel-iommu.c    |  4 ++--
 2 files changed, 14 insertions(+), 4 deletions(-)

Please pull.

Thanks,

	Joerg

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJXf7kWAAoJECvwRC2XARrjetMQAMvQi4sZldicwd2vm7XGUYiB
zcFjALH347bUtM8gAGtNhEdEqaRxB6tU7eux7AVLJi+hn9w8F+PSx0lfcH2Wu5Ze
4uwatMHj4ycLA4gGdMsxiazDkuL0ZbafBWIeQVhc72sTuRNzw/dsDhuXoFy2PFka
8vo/aChSlCMLAf5YRE7WAeIumIozIZEFFTQ1kL/0jDf4J9WevDMmO+TcGYKy0EWk
l1+5MOUXAbBjZZ1r7Fwx9qh1fl5HAT6n0MsP6fizMloxNRU+TmrSoFEvkTRqSl1P
waKBITRaKdS8MTQuyHTuHcigGhfW0H0BtEJ619pNopFKJOI3O1r81V1dgp1YbQRc
Pt3YU7DtMfwM0Kn17iS7bjA9uV7LUJ6fC3lNTta7H+HzuTBqq4oPNoTiKFVr37xv
AME3PQV43GNkqJZpI6TlfTbZjVS3X5V8rf2T3Ii+rqyCZFKcu71D1c5u1eTxFBk5
zVGf49+8dF/DThTXyZANyA18AJMdhk2UYWSbYLojOgKDMCNY4ufbpUSaFXquYSxT
lSPxTqbLpuY/tOOd6TlJAZ10XvSsV9KNMwsjTvdFhc0lAW9ZmjkZ2pd0F9Trmdxv
zeRAequw3yOhcMRyXMB6EBd0YMzy5U2RNysU0m3/P4Si2okm1JlfbUFz1PYNfG0e
90d4uR/c1sO5OzHJLxg3
=2l2u
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--

--===============6167494132155358307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6167494132155358307==--
