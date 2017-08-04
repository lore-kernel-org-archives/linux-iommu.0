From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.13-rc3
Date: Fri, 4 Aug 2017 10:38:54 +0200
Message-ID: <20170804083849.GA15959@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6684296380454072334=="
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


--===============6684296380454072334==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 520eccdfe187591a51ea9ab4c1a024ae4d0f68d9:

  Linux 4.13-rc2 (2017-07-23 16:15:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.13-rc3

for you to fetch changes up to 74ddda71f44c84af62f736a77fb9fcebe5bb436a:

  iommu/amd: Fix schedule-while-atomic BUG in initialization code (2017-07-26 15:39:14 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.13-rc3

Including:

	- Fix a scheduling-while-atomic bug in the AMD IOMMU driver. It
	  was found after the checker was enabled earlier.

	- A fix for the virtual APIC code in the AMD IOMMU driver which
	  delivers device interrupts directly into KVM guests for
	  assigned devices.

	- Fixes for the recently merged lock-less page-table code for
	  ARM. The redundant TLB syncs got reverted and locks added
	  again around the TLB sync code.

	- Fix for error handling in arm_smmu_add_device()

	- Address sanitization fix for arm io-pgtable code

----------------------------------------------------------------
Joerg Roedel (2):
      Merge branch 'for-joerg/arm-smmu/fixes' of git://git.kernel.org/.../will/linux into iommu/fixes
      iommu/amd: Fix schedule-while-atomic BUG in initialization code

Robin Murphy (3):
      iommu/mtk: Avoid redundant TLB syncs locally
      Revert "iommu/io-pgtable: Avoid redundant TLB syncs"
      iommu/io-pgtable: Sanitise map/unmap addresses

Suravee Suthikulpanit (1):
      iommu/amd: Enable ga_log_intr when enabling guest_mode

Vivek Gautam (1):
      iommu/arm-smmu: Fix the error path in arm_smmu_add_device

Will Deacon (1):
      iommu/arm-smmu: Reintroduce locking around TLB sync operations

 drivers/iommu/amd_iommu.c          |  1 +
 drivers/iommu/amd_iommu_init.c     |  2 +-
 drivers/iommu/arm-smmu.c           | 18 +++++++++++++-----
 drivers/iommu/io-pgtable-arm-v7s.c |  6 ++++++
 drivers/iommu/io-pgtable-arm.c     |  7 +++++++
 drivers/iommu/io-pgtable.h         |  9 +--------
 drivers/iommu/mtk_iommu.c          |  6 ++++++
 drivers/iommu/mtk_iommu.h          |  1 +
 8 files changed, 36 insertions(+), 14 deletions(-)

Please pull.

Thanks,

	Joerg

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJZhDKZAAoJECvwRC2XARrjo9oP/jbYmR2+NRxjDZx3S2+jIAB3
vSwxV3oKebHn1PJPNlx1hqD1U33inb5EXeiSyk9ayHMWaDdGG7xnn9mEAkecuPk6
816HhDqGWg6T8ERZBq0VlxeUtt/mq+f87kN3qF5e8cmTy46oupO64chg606gTe3K
5Wqh1oXF7jqp9oFKZ7g6TYwevYLyrlwL6ZSI6IBkh7kOkB2TPb4GqNhME62BnyrN
uSIf0ST/l3i2qFq+TbqegYlq+ArsmczVyoaPOpIuAoprmDHIAGcQCUmsE+MxD0rA
rRC3vpbOtetF+K3Q6VRHrQS13BS6CwV3dW26gvf67cLGEkiSnnj9J/TFqHUl99S4
gftZB9Vi8EE8X/2rKrksuWHCK4HuDPhj6oDzquqIz3o1tmZxgl63jR3bgYQf44al
CA731uO4zTp7c0N+OSpI6g7CPLlbOyFz1vp8WiUhBJxMDIDkCtatjB6RGyNnRXA4
tQT1QChjul6RDdNuTVoRyPlQDx+X64XC/8c4lyT5rx3Oobbxrk7Q6rpYa+qjvIJ4
cUkjrUE7FYiIHnRLUJM4jA8D3NPGG7BL2xbiQnE1E1lkhLudMr+q5nD2n5xARJ+V
GGoWpcAzIeSYhMFUX37HXQP+tYhaA6tpCkzcFkQGRVUjQIP7eaAGzo2nzR0sHld3
7DU64R56exMAftUy/dz7
=6uyE
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

--===============6684296380454072334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6684296380454072334==--
