From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fix for Linux v4.11-rc0
Date: Wed, 22 Feb 2017 14:22:00 +0100
Message-ID: <20170222132153.GA21744@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1074491675274183826=="
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


--===============1074491675274183826==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit ebb4949eb32ff500602f960525592fc4e614c5a7:

  Merge tag 'iommu-updates-v4.11' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu (2017-02-20 16:42:43 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v4.11-rc0

for you to fetch changes up to c37a01779b3954d9c8f9ac4f663a03c11f69fded:

  iommu/vt-d: Fix crash on boot when DMAR is disabled (2017-02-22 12:25:31 +0100)

----------------------------------------------------------------
IOMMU Fix for v4.11-rc0

	* Fix a boot crash caused by the VT-d driver when booted with IOMMU
	  disabled. This was introduced with the recent IOMMU changes.

----------------------------------------------------------------
Andy Shevchenko (1):
      iommu/vt-d: Fix crash on boot when DMAR is disabled

 drivers/iommu/dmar.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Please pull.

Thanks,

	Joerg

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJYrZBwAAoJECvwRC2XARrjASoP/iEGs00KF+QeCgEe8wlFgp5l
aU1dbUFM1p0vxv1+iWtooVfAFiyDupfN9YE29JgHh4+GChAG379afTQDDKtpHq3z
h7BelhAEHXEG5etC/EjcjhpNgKeoYvSSH5rbgZGlb9Gn0R9wxw75JLnmD7aX8ZnP
PKKxBbt+rxXIepbLelxMWk3Rmgu66zGvgZ63XBY0wsyfI6+jF5q9IzXlL+HTCTH0
6ifFeh6OTYnMyZTEZtUCGiaphBUomjBchJ1tDVqSj4+k/edJ5eeApTcFwE/6BxdL
ZmOd4MgR7j39or2deiGBFNtwtYchBNLx2MzyPAP9zd6AG2LDq7jGFuNwqFSKDSxq
J8c6wEhBWXhqGUFJQQHhZVcOospP8G0abv/shxXKElqTUUIYJ1WsDUV1nNZzEk3E
qhOTfA12ZNQfwOBnLQBNstAcO85utjTJwSK8neihaWzd4NvuyQ/IA5vfYHb/M2X6
RhCHYz6PSrINDHNoYl0gOWrgqLq82Pi7lkPY6MIYMYXGfF2Yu9VtQtRRb7aS0VFC
bzr3FHCJzmIUx19Hn6FJ+1XTpg6EnqsOX17hE9XghmuJEQ/7dyKT5+9CS4CZ8F0z
b270+lwOCYz9gugHy4xK2y5JsPvttkiFB4OQeIzQwQEE+kUyPCy6o7sZ5FT6NurX
/OnHsr0kFZ92Z1ALCjec
=lc32
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

--===============1074491675274183826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1074491675274183826==--
