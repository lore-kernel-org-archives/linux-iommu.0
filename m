From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fix for Linux v4.1-rc6
Date: Fri, 5 Jun 2015 11:20:18 +0200
Message-ID: <20150605092018.GA25227@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4541292658728056067=="
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


--===============4541292658728056067==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit c65b99f046843d2455aa231747b5a07a999a9f3d:

  Linux 4.1-rc6 (2015-05-31 19:01:07 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.1-rc6

for you to fetch changes up to 2d0ec7a19b5796aa958636eeeff072b506460501:

  Revert "iommu/amd: Don't allocate with __GFP_ZERO in alloc_coherent" (2015-06-02 08:46:32 +0200)

----------------------------------------------------------------
IOMMU Fix for Linux v4.1-rc6

Only one patch:

	* Revert "iommu/amd: Don't allocate with __GFP_ZERO in alloc_coherent"
	  This patch caused problems with some drivers, so it is better
	  to revert it now until the drivers have been fixed.

----------------------------------------------------------------
Joerg Roedel (1):
      Revert "iommu/amd: Don't allocate with __GFP_ZERO in alloc_coherent"

 drivers/iommu/amd_iommu.c | 1 +
 1 file changed, 1 insertion(+)

Please pull.

Thanks,

	Joerg


--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVcWnSAAoJECvwRC2XARrjhjcP/ivl1knb3OSIkLIccgB1mf3b
ZPfurkWDHP8KPTk8kqB/QoGVXuwT3ICyd58TrpmycQFS/3+Zw2ELJjmK8JTUDNVF
BmfD7UIijOaNLE3aGRsqVptzAFIp5e0brLNrtpOB1sbPGCliHmGYl+e0uf8gJlc2
JXDJyXGAW6KCXMrw9R7cLW7hgAvuYR6eNptSD9jzQvAPD/ZXW4XLpvbep2ZWEECE
k+vSedHxNoetuXZX3Hh8jO25bC187huRP11DSTMGmlP0CwQMcIOYbHsYTEc6UoVQ
uLMohm6FVMkrqQqIv5w6H+ojZN2sHW67qiuKE7bH6FlbYG+A8S/W7irjRIrGApN9
9pB6HtiIbnbv+SSgo170tmS8W6dcMaw1ZvC/KVnlsLXOM8HTvO2UNg6lzrKzMw7o
+XFcfvqhzznoY8qTNLe6CA0oHdjmIHFfQyCPb44ErynKJlILbV9uTIRcX2fS6/eQ
A1BkP6v2m7mGbCObgE2sPEzXM+OKxNSY1D+M/KR3d2WTjI+AaWhpe/UY80vCEWT+
nxFB3DcBuXO8LwCPLwmQFmwSjW381m2qilq2oqd2F3lc2ekRX1lTX2m2Zs6mQZHC
ZSdtB+AMbXYMJRfM7phEV3L218luvdLrWtt5cAPim1tw48dvJkJet31UprrVo0Ah
1fog6/QTGaQFyLX0KizK
=68Qa
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

--===============4541292658728056067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4541292658728056067==--
