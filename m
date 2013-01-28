From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for v3.8-rc5
Date: Mon, 28 Jan 2013 17:05:57 +0100
Message-ID: <20130128160555.GA3867@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0078274236943348490=="
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


--===============0078274236943348490==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v3.8-rc5

for you to fetch changes up to 318fe782539c4150d1b8e4e6c9dc3a896512cb8a:

  IOMMU, AMD Family15h Model10-1Fh erratum 746 Workaround (2013-01-28 15:26:54 +0100)

----------------------------------------------------------------
IOMMU fixes for Linux v3.8-rc5

One fix for the AMD IOMMU driver to work around broken BIOSes found in
the field. Some BIOSes forget to enable a workaround for a hardware
problem which might cause the IOMMU to stop working under high load
conditions. The fix makes sure this workaround is enabled.

----------------------------------------------------------------
Suravee Suthikulpanit (1):
      IOMMU, AMD Family15h Model10-1Fh erratum 746 Workaround

 drivers/iommu/amd_iommu_init.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

Please pull.

Regards,

	Joerg


--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJRBqHjAAoJECvwRC2XARrj2TUQAJsAtqA4HNWbIiELsrUGS7fe
jz6/wJqEnZ7qr5QCh/gmR8pJplj9CJR6EBqw5SunRDMYEv+QhbZ2FQx6euKOe3Eh
fk5XPuFCaYOO5T2lpHG2t3PGGTx1yYqsB5Fob2JJMrY15XlNuEvvWACGp4BkiMy2
+eQ2tjzNMaXeDpQhxgxiREKd1jqKE+MQKzG54UL3mc4R8yH6hykoyEvHO3Kp8BkQ
Eg5iKcmyvmffBfcC7gMjXuiE79Elu8YKRfmqxepaW1z0cQA+mJuTeKGjLrjiJVD+
5/TixuFX37idr0KEFUs9XnPajSy8V+1julgXTmT3xlYISj2q+YYHsnCAYDWp3Yci
tUQG8vnOFnE9E7RHpPkw4Mm0v0YUjzmMVTL+uJIHBj3a36LBFb6QWNXVujR9EAEe
3ILw0af/LQ3GwMw5rdvFzUULWoPy/hsFiPxkeQGjZr1gbIR36XrqyVRuImifL9KA
hxno96hP7Nizz0GvwfJSMVjzE3FTACh8tmt5DO3QOIQ07AS0o/iuxSn48buai/bO
6c1FXahpgdu0WsT8TVBnAyvOaxe68a0Om/ZssPtsiFWhAGGNp2nMHsG/frPeKl9V
/864srQRUkoOmlvDuRl/GHjIXCzdiI+r7juS8dka/XEzuP4TZ8xHDnDaGtKc0jI4
pAbaw4OGBJdrmWkP5iDa
=8L7B
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--



--===============0078274236943348490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0078274236943348490==--
