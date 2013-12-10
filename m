From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [GIT PULL] IOMMU fixes for v3.13-rc4
Date: Tue, 10 Dec 2013 13:23:53 -0700
Message-ID: <1386707033.22974.14.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Linus,

Joerg is on holiday and asked me to pickup IOMMU fixes[1].  Thanks,

Alex

[1] https://lkml.org/lkml/2013/11/15/344

The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:

  Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)

are available in the git repository at:

  git://github.com/awilliam/linux-vfio.git tags/iommu-fixes-for-v3.13-rc4

for you to fetch changes up to 239a87020b263fe7e70adc5803cb157955023d3c:

  Merge branch 'for-joerg/arm-smmu/fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into for-linus (2013-12-06 14:32:15 -0700)

----------------------------------------------------------------

arm/smmu driver updates via Will Deacon fixing locking around page
table walks and a couple other issues.

----------------------------------------------------------------
Alex Williamson (1):
      Merge branch 'for-joerg/arm-smmu/fixes' of git://git.kernel.org/.../will/linux into for-linus

Wei Yongjun (1):
      iommu/arm-smmu: fix error return code in arm_smmu_device_dt_probe()

Will Deacon (2):
      iommu/arm-smmu: use mutex instead of spinlock for locking page tables
      iommu/arm-smmu: remove potential NULL dereference on mapping path

 drivers/iommu/arm-smmu.c | 66 ++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 38 deletions(-)
