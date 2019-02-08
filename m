From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v1 0/7] iommu: Minor cleanups and dev_printk() usage
Date: Fri, 08 Feb 2019 16:05:33 -0600
Message-ID: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

I've had these minor iommu cleanups lying around for a while, but the ugly
dmesg logs from [1] prompted me to finally post them.  Take what you like,
ignore the rest, and tell me so I can clear out my queue of old stuff.

These fix no actual bugs.

[1] https://lore.kernel.org/linux-pci/1547649064-19019-1-git-send-email-liudongdong3@huawei.com

---

Bjorn Helgaas (7):
      iommu: Use dev_printk() when possible
      iommu/amd: Use dev_printk() when possible
      iommu/vt-d: Use dev_printk() when possible
      iommu/vt-d: Remove unnecessary local variable initializations
      iommu/vt-d: Remove unused dmar_remove_one_dev_info() argument
      iommu/vt-d: Remove misleading "domain 0" test from domain_exit()
      iommu/vt-d: Simplify control flow


 drivers/iommu/amd_iommu.c      |   25 +++----
 drivers/iommu/amd_iommu_init.c |   20 +++---
 drivers/iommu/intel-iommu.c    |  136 +++++++++++++++++-----------------------
 drivers/iommu/iommu.c          |    8 +-
 4 files changed, 84 insertions(+), 105 deletions(-)
