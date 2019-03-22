From: Joerg Roedel <joro@8bytes.org>
Subject: [git pull] IOMMU Fixes for Linux v5.1-rc1
Date: Fri, 22 Mar 2019 12:22:29 +0100
Message-ID: <20190322112224.GA22496@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.1-rc2

for you to fetch changes up to 84c11e4df5aa4955acaa441f0cf1cb2e50daf64b:

  iommu/vt-d: Save the right domain ID used by hardware (2019-03-22 12:02:27 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.1-rc2

Including:

	- AMD IOMMU fix for sg-mapping with sg->offset > PAGE_SIZE

	- Fix for IOVA code to trigger the slow-path less often

	- Two fixes for Intel VT-d to avoid writing to read-onl registers and
	  to flush the right domain id for the default domains in scalable
	  mode

----------------------------------------------------------------
Lu Baolu (2):
      iommu/vt-d: Check capability before disabling protected memory
      iommu/vt-d: Save the right domain ID used by hardware

Robert Richter (1):
      iommu/iova: Fix tracking of recently failed iova address

Stanislaw Gruszka (1):
      iommu/amd: fix sg->dma_address for sg->offset bigger than PAGE_SIZE

 drivers/iommu/amd_iommu.c   | 7 ++++++-
 drivers/iommu/intel-iommu.c | 5 ++++-
 drivers/iommu/iova.c        | 5 +++--
 3 files changed, 13 insertions(+), 4 deletions(-)

Please pull.

Thanks,

	Joerg

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAlyUxXAACgkQK/BELZcB
GuOOXA//flT1sZ7JMkiPtVO3sH67adhWnge3n++mWn7SEjSw4s4HJ+Bvu7VztrrG
yq/EifBsUncZbd/LsCDypNBSVRNinnro+NJbrlpn7Bxg+Rgyw6Y5y2fqh+C/5NA9
xLVxwETJYuv9koK1QqbfV2I2maZ2Xn8WwBNK8XvvsqCrtnahX/xuybQZDqqCZwJh
swEqBPzqOmIQocUAQf66XYQBGFjz/Rv5iTvJHY/XMVIS9TCwidtxvnrtesm9unCx
+i45CGJ9J55f2iEVPyPQlpkP9eCd+TR3WIc42No56copsBA/o7upSAji8V2acoSC
uLv9bUEy7S7s9rjnD4usRxIixTP876ehOw8Agq3n3XsMobZBYXOpewJAB0TTaxmK
6cMYV73cErOzRNylCVeAI9Z6i1ztniXITM+KapgAc97DlpDwYyvDIJj4pGvum1P1
ZXT56EparVhPBWeBP6gHlBYun5bJJ99Q3VPDvG+TzET3v9Uov2v+K8/LP7Fi7IYP
pz9JtEtlV4Dnbc9Gzn09PkmbAzposcfj7UTgaJ5ZRASbQ1VFR23SJ751EE3C0qM3
u0oEX0CV/uhlDa7/45FNwHe+bKAVyHPEYGAj8u2OMnxJSqFVTDmmVrt6Iw+h6XED
SI94psVbwBh5uxnx82wChlC2pIecf3Y5cCj45/kDzel6D2zqmqw=
=ZgKz
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
