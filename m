From: Chen Feng <puck.chen@hisilicon.com>
Subject: [PATCH RFC 0/3] Add iommu support for hi6220 HiKey board
Date: Tue, 17 Nov 2015 19:57:45 +0800
Message-ID: <1447761468-36952-1-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: puck.chen@hisilicon.com, yudongbin@hisilicon.com, saberlily.xia@hisilicon.com, suzhuangluan@hisilicon.com, kong.kongxinwei@hisilicon.com, xuyiping@hisilicon.com, z.liuxinliang@hisilicon.com, puck.chen@aliyun.com, weidong2@hisilicon.com, w.f@huawei.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, xuwei5@hisilicon.com
Cc: qijiwen@hisilicon.com, peter.panshilin@hisilicon.com, dan.zhao@hisilicon.com, linuxarm@huawei.com, arnd@linaro.org, rob.herring@linaro.org, guodong.xu@linaro.org, liguozhu@hisilicon.com
List-Id: iommu@lists.linux-foundation.org

The patch sets add iommu support for Hi6220 SoC. Current testing and support
board is Hikey which is one of 96boards.
It is an arm64 open source board. For more information about this board,
please access https://www.96boards.org.

The Architecture of SMMU on Hi6220 SoC:

   +------------------------------------------------------------------+
   |                                                                  |
   |         +---------+  +--------+  +-------------+   +-------+     |
   |         |   ADE   |  |  ISP   |  |  V/J codec  |   |  G3D  |     |
   |         +----|----+  +---|----+  +------|------+   +---|---|     |
   |              |           |              |              |         |
   |     ---------v-----------v--------------v--------------v-----    |
   |                           Media Bus                              |
   |     --------------------------------|---------------|--------    |
   |                                     |               |            |
   |                                 +---v---------------v--------+   |
   |                                 |            SMMU            |   |
   |                                 +----------|---------|-------+   |
   |                                            |         |           |
   +--------------------------------------------|---------|-----------+
                                                |         |
                                   +------------v---------v-----------+
                                   |              DDRC                |
                                   +----------------------------------+

Note:
The media system share the same smmu IP to access DDR memory. And all
media IP use the same page table. The hi6220 iommu driver also uses the
iova api to manage an iova allocator to ensure that the caller get different
iova address.
The caller can use the follow sample code to map phy and iova address.

eg:
struct iommu_domain *domain = iommu_domain_alloc(bus);
iommu_attach_device(domain, dev);
struct iova_domain *iovad = (struct iova_domain *)m_dev->archdata.iommu;
struct iova * t_iova = alloc_iova(iovad, size, limit_pfn, align);
iommu_map(domain, t_iova->pfn_lo << 12, phy_addr, size, port);

The patch sets are based on 4.4-RC1

Chen Feng (3):
  docs: iommu: Documentation for iommu in hi6220 SoC
  iommu/hisilicon: Add hi6220-SoC smmu driver
  arm64: dts: Add dts node for hi6220 smmu driver

 .../bindings/iommu/hisi,hi6220-iommu.txt           |  32 ++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |  13 +
 drivers/iommu/Kconfig                              |  11 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/hi6220_iommu.c                       | 492 +++++++++++++++++++++
 5 files changed, 549 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt
 create mode 100644 drivers/iommu/hi6220_iommu.c

-- 
1.9.1
