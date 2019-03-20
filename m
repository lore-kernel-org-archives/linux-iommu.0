From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH 0/4] Add PCI ATS support to Arm SMMUv3
Date: Wed, 20 Mar 2019 17:36:30 +0000
Message-ID: <20190320173634.21895-1-jean-philippe.brucker@arm.com>
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
To: will.deacon@arm.com
Cc: lorenzo.pieralisi@arm.com, zhongmiao@hisilicon.com, okaya@kernel.org, joro@8bytes.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
List-Id: iommu@lists.linux-foundation.org

Add ATS support to the SMMUv3 driver. The previous posting was about a
year ago, as part of SVA v2 [1]. I feel slightly more confident
upstreaming this now that we can disable the feature for untrusted
devices. It's a low-hanging fruit in the SVA patch stack, and a good
candidate for v5.2.

As for testing, there is a public (free as in beer) software model that
has both SMMUv3 and a SATA controller with ATS [2]. It's not much since,
except for a dev_dbg message, you won't notice a difference when
enabling ATS, but it can still be used for checking that the patches
don't break anything.

[1] https://www.spinics.net/lists/kvm/msg168742.html
[2] https://patchwork.kernel.org/patch/10781793/

Jean-Philippe Brucker (4):
  ACPI/IORT: Check ATS capability in root complex nodes
  iommu/arm-smmu-v3: Link domains and devices
  iommu/arm-smmu-v3: Add support for PCI ATS
  iommu/arm-smmu-v3: Disable tagged pointers

 drivers/acpi/arm64/iort.c   |  11 ++
 drivers/iommu/arm-smmu-v3.c | 250 +++++++++++++++++++++++++++++++++++-
 include/linux/iommu.h       |   4 +
 3 files changed, 259 insertions(+), 6 deletions(-)

-- 
2.21.0
