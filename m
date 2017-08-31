From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [RFC PATCH 1/6] dt-bindings: document stall and PASID properties for IOMMU masters
Date: Thu, 31 Aug 2017 16:20:37 +0800
Message-ID: <1504167642-14922-2-git-send-email-xieyisheng1@huawei.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: jean-philippe.brucker@arm.com
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, robin.murphy@arm.com, robert.moore@intel.com, lv.zheng@intel.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devel@acpica.org, liubo95@huawei.com, chenjiankang1@huawei.com, xieyisheng@huawei.com
List-Id: iommu@lists.linux-foundation.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Document the bindings for stall and PASID capable platform devices.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 Documentation/devicetree/bindings/iommu/iommu.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
index 5a8b462..7355d7f 100644
--- a/Documentation/devicetree/bindings/iommu/iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/iommu.txt
@@ -86,6 +86,19 @@ have a means to turn off translation. But it is invalid in such cases to
 disable the IOMMU's device tree node in the first place because it would
 prevent any driver from properly setting up the translations.
 
+Optional properties:
+--------------------
+- dma-can-stall: When present, the master can wait for a DMA transaction
+  to be handled by the IOMMU and can recover from a fault. For example, if
+  the page accessed by the DMA transaction isn't mapped, some IOMMUs are
+  able to stall the transaction and let the OS populate the page tables.
+  The IOMMU then performs the transaction if the fault was successfully
+  handled, or aborts the transaction otherwise.
+
+- pasid-bits: Some masters support multiple address spaces for DMA. By
+  tagging DMA transactions with an address space identifier. By default,
+  this is 0, which means that the device only has one address space.
+
 
 Notes:
 ======
-- 
1.7.12.4

