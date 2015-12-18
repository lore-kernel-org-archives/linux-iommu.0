From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.4-rc5
Date: Fri, 18 Dec 2015 16:51:23 +0100
Message-ID: <20151218155122.GA10260@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3195673450971795831=="
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


--===============3195673450971795831==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9f9499ae8e6415cefc4fe0a96ad0e27864353c89:

  Linux 4.4-rc5 (2015-12-13 17:42:58 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.4-rc5

for you to fetch changes up to 7f8312a3b31de5676144d9e75f2f2647c8b4b769:

  iommu/vt-d: Do access checks before calling handle_mm_fault() (2015-12-14 15:37:55 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.4-rc5

	* Two similar fixes for the Intel and AMD IOMMU drivers to add
	  proper access checks before calling handle_mm_fault.

----------------------------------------------------------------
Joerg Roedel (2):
      iommu/amd: Do proper access checking before calling handle_mm_fault()
      iommu/vt-d: Do access checks before calling handle_mm_fault()

 drivers/iommu/amd_iommu_v2.c | 20 ++++++++++++++++++--
 drivers/iommu/intel-svm.c    | 20 ++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

Please pull.

Thanks,

	Joerg


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJWdCt6AAoJECvwRC2XARrjqAcQALtUrvX49J9fCnbzyz5crEQe
vFt+n/230xbPAkxHBQWkyibiOGkH7rdHBAWXT2sQbf3RoMq7synytAkgEELuhLfa
QrMiKMk3fyiCDjmV/dQIdJGGgkQpdrwMWXFWC4lTsp/6qZ2QfYu7Kh/PZVYZvbDD
e7r9E6bOlA9RjjAWxAa9bpMNHJAw+H3b3wY77+raW/7Gw1tmMom+jwESxuVKNdMD
fSy0oUaioRcODzhtXQGyt/fWvo9Fk/K9dydb8F2EyUMRR22GdiIS7A8/+Os7nN3r
5cJq1nQmAAVfIvbT700FwlS1EPOyZbDWrJkco3iDtwZ70JBVV0joaAZFCB+V5xCt
s1ZAIg4MgSEvNP0nVK9F1sO1dxKJU62mYtHghD9syqrG9xd8MfXll9eVjjmSPBd2
YE5DBkh02/gyFH28fpZVwwFxo0n6KRvoLNv3VGHjOkfNonPeKzrnyg+hS+3+cDeI
CXBzs0S9gheH/tMlU90vwd98nyMQ4HMqivaCLQvT5NRJ3ecLmtXRHJs/r9OGzBDh
YcVTCJYOfXJOxc4J4864eVYnXtWdhUgu4Ix6hRXqXLWg82JthWlSJm2zFZHBb+KF
PJvsz1NcMWWLOZSC55Gnvw2WRDOK15xMaK/ZsZwazKYfHdxtzhbYkkT9phz/HjZs
q/H0BB/AxC93Q/QqGRl1
=8kz6
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

--===============3195673450971795831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3195673450971795831==--
