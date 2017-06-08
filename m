From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 0/8] io-pgtable lock removal
Date: Thu,  8 Jun 2017 12:51:59 +0100
Message-ID: <cover.1496921366.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: will.deacon@arm.com, joro@8bytes.org
Cc: salil.mehta@huawei.com, sunil.goutham@cavium.com, iommu@lists.linux-foundation.org, ray.jui@broadcom.com, linux-arm-kernel@lists.infradead.org, linu.cherian@cavium.com, nwatters@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Here's the cleaned up nominally-final version of the patches everybody's
keen to see. #1 is just a non-critical thing-I-spotted-in-passing fix,
#2-#4 do some preparatory work (and bid farewell to everyone's least
favourite bit of code, hooray!), and #5-#8 do the dirty deed itself.

The branch I've previously shared has been updated too:

  git://linux-arm.org/linux-rm  iommu/pgtable

All feedback welcome, as I'd really like to land this for 4.13.

Robin.


Robin Murphy (8):
  iommu/io-pgtable-arm-v7s: Check table PTEs more precisely
  iommu/io-pgtable-arm: Improve split_blk_unmap
  iommu/io-pgtable-arm-v7s: Refactor split_blk_unmap
  iommu/io-pgtable: Introduce explicit coherency
  iommu/io-pgtable-arm: Support lockless operation
  iommu/io-pgtable-arm-v7s: Support lockless operation
  iommu/arm-smmu: Remove io-pgtable spinlock
  iommu/arm-smmu-v3: Remove io-pgtable spinlock

 drivers/iommu/arm-smmu-v3.c        |  36 ++-----
 drivers/iommu/arm-smmu.c           |  48 ++++------
 drivers/iommu/io-pgtable-arm-v7s.c | 173 +++++++++++++++++++++------------
 drivers/iommu/io-pgtable-arm.c     | 190 ++++++++++++++++++++++++-------------
 drivers/iommu/io-pgtable.h         |   6 ++
 5 files changed, 268 insertions(+), 185 deletions(-)

-- 
2.12.2.dirty
