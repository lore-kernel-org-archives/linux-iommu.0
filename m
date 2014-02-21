From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/5] iommu/arm-smmu: updates for 3.15
Date: Fri, 21 Feb 2014 17:16:27 +0000
Message-ID: <1393002992-24561-1-git-send-email-will.deacon@arm.com>
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
To: iommu@lists.linux-foundation.org
Cc: Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hello,

These are the arm-smmu updates I have queued for 3.15 and plan to send to
Joerg sometime next week.

The main parts are for accessing the buggy Calxeda SMMU, which is wired
as secure despite being non-secure. Unfortunately, the apparent demise
of Calxeda means that Andreas is no longer working on this, so I had to
extract what I could from a larger patchset (which wasn't yet ready for
merging).

On my side, there's some cosmetic changes after Joerg fixed some locks
to use spin_lock_irq{save,restore} and also an optimisation to restrict
the scope of our barrier when publishing page tables (now that ARM64 can
accept the option).

Feedback welcome,

Will


Andreas Herrmann (3):
  iommu/arm-smmu: set MAX_MASTER_STREAMIDS to MAX_PHANDLE_ARGS
  iommu/arm-smmu: support buggy implementations with secure cfg accesses
  documentation/iommu: update description of ARM System MMU binding

Will Deacon (2):
  iommu/arm-smmu: clean up use of `flags' in page table handling code
  iommu/arm-smmu: provide option to dsb macro when publishing tables

 .../devicetree/bindings/iommu/arm,smmu.txt         |   6 ++
 drivers/iommu/arm-smmu.c                           | 100 ++++++++++++++-------
 2 files changed, 75 insertions(+), 31 deletions(-)

-- 
1.8.2.2
