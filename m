From: Will Deacon <will.deacon@arm.com>
Subject: [GIT PULL] iommu/arm-smmu: updates for 3.16
Date: Tue, 6 May 2014 18:23:34 +0100
Message-ID: <20140506172333.GD13677@arm.com>
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

Please can you pull the following arm-smmu changes for 3.16?

There's not a lot here, but a non-essential fix (removing a extra shift by
0) and replacing a hard-coded constant with its corresponding definition
(which actually means we can support up to 42-bit addresses into stage-2).

Cheers,

Will

--->8

The following changes since commit d1db0eea852497762cab43b905b879dfcd3b8987:

  Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 6069d23ce0e568909d847f28af0257b085e8e77a:

  iommu/arm-smmu: fix incorrect use of S2CR_TYPE_SHIFT (2014-05-02 16:49:37 +0100)

----------------------------------------------------------------
Kefeng Wang (1):
      iommu/arm-smmu: fix incorrect use of S2CR_TYPE_SHIFT

Will Deacon (1):
      iommu/arm-smmu: allow 42-bit stage-1 output size with 64K pages

 drivers/iommu/arm-smmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
