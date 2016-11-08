From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.9-rc4
Date: Tue, 8 Nov 2016 16:47:12 +0100
Message-ID: <20161108154700.GA11889@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7896673674809713809=="
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


--===============7896673674809713809==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit bc33b0ca11e3df467777a4fa7639ba488c9d4911:

  Linux 4.9-rc4 (2016-11-05 16:23:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.9-rc4

for you to fetch changes up to bea64033dd7b5fb6296eda8266acab6364ce1554:

  iommu/vt-d: Fix dead-locks in disable_dmar_iommu() path (2016-11-08 15:08:26 +0100)

----------------------------------------------------------------
IOMMU-Fixes for Linux v4.9-rc4

Two places need fixing:

	* Four patches from Robin Murphy fix several issues with the
	  recently merged generic DT-bindings support for arm-smmu
	  drivers

	* A fix for a dead-lock issue in the VT-d driver, which shows up
	  on iommu hotplug

----------------------------------------------------------------
Joerg Roedel (1):
      iommu/vt-d: Fix dead-locks in disable_dmar_iommu() path

Robin Murphy (4):
      iommu/arm-smmu: Work around ARM DMA configuration
      iommu/arm-smmu: Don't inadvertently reject multiple SMMUv3s
      iommu/arm-smmu: Check that iommu_fwspecs are ours
      iommu/arm-smmu: Fix out-of-bounds dereference

 drivers/iommu/arm-smmu-v3.c | 25 +++++++++++++++++--------
 drivers/iommu/arm-smmu.c    | 16 ++++++++++++++--
 drivers/iommu/intel-iommu.c | 14 ++++++++++++--
 3 files changed, 43 insertions(+), 12 deletions(-)

Please pull.

Thanks,

	Joerg

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJYIfN0AAoJECvwRC2XARrjw2IQAMoaJfsGUYDVnV3Umcvb0KBw
29IpcLP1xTFzZ+EQ4konh1dpnbLrxQNDgQE738vCgClkb+ew6qrYaHOIS6S8R7dy
7QJWVTOixR4syJzRq817INpUTFBGG7S57r7kH+8lYQNDRxoWyQZlMyUOAAdq9Yx+
US/pK0F8vVVvgfisBfBaFWVYn1v+zxjnJUua1qnhfP7SWWma01bkdkAEtcqp4FLc
0I82CU3qQ8gp2+gsKXjwdIr3vglebwOYkdhbu7dfdIDWJUmiKCT7NoiUFRBEsNFl
JfRoEip6g244xfY7mnbGegpDIGIntqNuOEifE6z+JysguVVbEdBb66lJeBvW5yTz
EtMp9BT29RzzOXoqfArD0M0t4nETvOL4PYlqK+KiLUebhIww3a9O2rTVmDilqvM0
l2HbMEg2kjPhV5w1U0pjwg23T00Sl8duLILv/jL9eadWQdJqiW9q8DYYxSyLpeaB
tE8hzq8/evf3+pPJJYhcKORdLJY40zzzPUgFld+C/zBnRVm2nWENcFwnlbNNvd+t
IqxZHKNhYlUW/hJJEvwzQ1knqWYbmBUfa2WHYz1zAzhJCxY0lRZMtlEOZ47V9OcO
0+9OBloY/tGmiORDDEa8+pgxaTeZILL0U61vjtF/p1qGdmbyhRuycskD0GaPWwVd
1A2xi4B3Yerh7XhTvU4M
=nRU2
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

--===============7896673674809713809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7896673674809713809==--
