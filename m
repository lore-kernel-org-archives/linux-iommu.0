From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fix for Linux v5.1-rc1
Date: Fri, 15 Mar 2019 16:44:07 +0100
Message-ID: <20190315154359.GA22666@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit d05e4c8600c36084ce9de6249bb972c9bdd75b7e:

  Merge branches 'iommu/fixes', 'arm/msm', 'arm/tegra', 'arm/mediatek', 'x86/vt-d', 'x86/amd', 'hyper-v' and 'core' into next (2019-03-01 11:24:51 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.1-rc1

for you to fetch changes up to bb6bccba390c7d743c1e4427de4ef284c8cc6869:

  iommu/amd: Fix NULL dereference bug in match_hid_uid (2019-03-15 16:22:05 +0100)

----------------------------------------------------------------
IOMMU Fix for Linux v5.1-rc1

	- Fix a NULL-pointer dereference issue in the ACPI device
	  matching code of the AMD IOMMU driver

----------------------------------------------------------------
Aaron Ma (1):
      iommu/amd: Fix NULL dereference bug in match_hid_uid

 drivers/iommu/amd_iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Please pull.

Thanks,

	Joerg

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAlyLyD8ACgkQK/BELZcB
GuMkCQ/+LEAmk4cT1319VxXkGldJKXTDL5UJJL4pokGp+q5oUdE/gpCAmdD7VF9W
5uErCaYiNjR4gLrdyJijnNvfHo2h39ghdU4dgwlQy5VcK6nNxh0hl9vwmCf2nxOD
GliUTdjad+b6WTBSKgJ/T+sYObt2e0uLACS5kRzabE09z6pT/oJt23O63yFXUxo8
s/XakYMAfULoLmP891uPx24BYWQ+ssAevjF/430yuGhDCmJW+/JcISiMi+KIL3e8
SVjZYEY1DN3fUg7RyswSA/NGQzuziSKerhCcULYJmU/CNCCsU4y1NVyTwIXjKmvw
ZuLW9vcsBoAL2BHNRMJes2nwTAq+9l9HvgRXYY3x4iyqCWFmo1OAkWNY7uG2FEhA
/5o3m8hApq3FGjjYVtp8v6sTxFVmB1/KfRQyQ8BRaGEcxWWClAAsDc3tsxEJc/JZ
YugddwI0pWy4Ff9/63olwXslj/s6QncaKgJS4gh55PyO+3HZOKf1OM0mQY0eTPau
syvpFTF4bZ8X5qq2yrLifVBaDD+6VQk+XHFDwJCbcioLWCsuxSmHxeFPgbb1Zi/i
+U0ERsakVXPwahatioD9zh5lEPCFamupeA0x2W3iAH4G8CpNAEjpFS2ZGhB8dIyv
Ae2JNNtxVd3MIW0FjIWvyA4pa4RxWc8lj9cWEUm/nG6xwXshgEk=
=8R5f
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
