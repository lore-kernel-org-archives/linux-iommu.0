From: Will Deacon <will.deacon@arm.com>
Subject: [GIT PULL] iommu/arm-smmu: updates for 3.15
Date: Fri, 28 Feb 2014 11:05:25 +0000
Message-ID: <20140228110525.GA674@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please can you pull the following arm-smmu changes for 3.15?

The main changes are for accessing the buggy Calxeda SMMU, which is wired
as secure despite being non-secure. Unfortunately, the apparent demise
of Calxeda means that Andreas is no longer working on this, so I had to
extract what I could from a larger patchset (which wasn't yet ready for
merging in its entirety).

On my side, there's some cosmetic changes after Joerg fixed some locks
to use spin_lock_irq{save,restore} and also an optimisation to restrict
the scope of our barrier when publishing page tables (now that ARM64 can
accept the option).

Cheers,

Will

--->8

The following changes since commit cfbf8d4857c26a8a307fb7cd258074c9dcd8c691:

  Linux 3.14-rc4 (2014-02-23 17:40:03 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 34fb4b37b7b6da7dc34797d1abf234dd30b091d8:

  iommu/arm-smmu: fix incorrect comment regarding TLB invalidation (2014-02-27 19:08:43 +0000)

----------------------------------------------------------------
Andreas Herrmann (3):
      iommu/arm-smmu: set MAX_MASTER_STREAMIDS to MAX_PHANDLE_ARGS
      iommu/arm-smmu: support buggy implementations with secure cfg accesses
      documentation/iommu: update description of ARM System MMU binding

Will Deacon (3):
      iommu/arm-smmu: clean up use of `flags' in page table handling code
      iommu/arm-smmu: provide option to dsb macro when publishing tables
      iommu/arm-smmu: fix incorrect comment regarding TLB invalidation

 .../devicetree/bindings/iommu/arm,smmu.txt         |   6 ++
 drivers/iommu/arm-smmu.c                           | 105 ++++++++++++++-------
 2 files changed, 77 insertions(+), 34 deletions(-)
