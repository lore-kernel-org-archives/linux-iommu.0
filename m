From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Subject: [PATCH v3 0/2] acpi/iort, numa: Add numa node mapping for smmuv3 devices
Date: Thu,  8 Jun 2017 10:14:17 +0530
Message-ID: <1496897059-8272-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Will.Deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com, lv.zheng@intel.com, joro@8bytes.org, rjw@rjwysocki.net, lenb@kernel.org, jnair@caviumnetworks.com, gpkulkarni@gmail.com
List-Id: iommu@lists.linux-foundation.org

ARM IORT specification(rev. C) has added  provision to define proximity
domain in SMMUv3 IORT table. Adding required code to parse Proximity
domain and set numa_node of smmv3 platform devices.

v3:
  - Addressed Lorenzo Pieralisi comment.

v2:
  - Changed as per Lorenzo Pieralisi and Hanjun Guo suggestions.

v1:
  - Initial patch

Ganapatrao Kulkarni (2):
  acpica: iort: Update SMMUv3 header for proximity domain mapping
  acpi/iort: numa: Add numa node mapping for smmuv3 devices

 drivers/acpi/arm64/iort.c | 28 ++++++++++++++++++++++++++--
 include/acpi/actbl2.h     |  4 ++++
 2 files changed, 30 insertions(+), 2 deletions(-)

-- 
1.8.1.4

