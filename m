From: Will Deacon <will.deacon@arm.com>
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.21
Date: Tue, 11 Dec 2018 20:08:48 +0000
Message-ID: <20181211200847.GB5218@edgewater-inn.cambridge.arm.com>
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
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Please pull the following arm-smmu updates for 4.21. This includes the
clock and pm_runtime updates to the arm-smmu driver, as well as some
non-critical fixes for the arm-smmu-v3 driver.

Cheers,

Will

--->8

The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:

  Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to 89cddc563743cb1e0068867ac97013b2a5bf86aa:

  iommu/arm-smmu: Add support for qcom,smmu-v2 variant (2018-12-10 14:56:00 +0000)

----------------------------------------------------------------
Robin Murphy (1):
      iommu/arm-smmu-v3: Fix big-endian CMD_SYNC writes

Sricharan R (3):
      iommu/arm-smmu: Add pm_runtime/sleep ops
      iommu/arm-smmu: Invoke pm_runtime across the driver
      iommu/arm-smmu: Add the device_link between masters and smmu

Vivek Gautam (2):
      dt-bindings: arm-smmu: Add bindings for qcom,smmu-v2
      iommu/arm-smmu: Add support for qcom,smmu-v2 variant

Will Deacon (1):
      iommu/arm-smmu-v3: Use explicit mb() when moving cons pointer

Zhen Lei (1):
      iommu/arm-smmu-v3: Avoid memory corruption from Hisilicon MSI payloads

 .../devicetree/bindings/iommu/arm,smmu.txt         |  39 +++++
 drivers/iommu/arm-smmu-v3.c                        |  22 ++-
 drivers/iommu/arm-smmu.c                           | 170 +++++++++++++++++++--
 3 files changed, 216 insertions(+), 15 deletions(-)
