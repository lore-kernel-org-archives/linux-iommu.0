From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/2] iommu/arm-smmu-v3: make sure the kdump kernel can work well when smmu is enabled
Date: Mon, 18 Mar 2019 21:12:41 +0800
Message-ID: <20190318131243.20716-1-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

v1 --> v2:
1. Drop part2. Now, we only use the SMMUv3 hardware feature STE.config=0b000
(Report abort to device, no event recorded) to suppress the event messages
caused by the unexpected devices.
2. rewrite the patch description.

v1:
This patch series include two parts:
1. Patch1-2 use dummy STE tables with "ste abort" hardware feature to abort unexpected
   devices accessing. For more details, see the description in patch 2.
2. If the "ste abort" feature is not support, force the unexpected devices in the
   secondary kernel to use the memory maps which it used in the first kernel. For more
   details, see patch 5.

Zhen Lei (2):
  iommu/arm-smmu-v3: make sure the stale caching of L1STD are invalid
  iommu/arm-smmu-v3: to make smmu can be enabled in the kdump kernel

 drivers/iommu/arm-smmu-v3.c | 88 +++++++++++++++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 23 deletions(-)

-- 
1.8.3
