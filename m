From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] documentation/iommu: Update description of ARM System MMU
	binding
Date: Thu, 30 Jan 2014 21:17:52 +0100
Message-ID: <20140130201752.GJ13543@alberich>
References: <1391105889-32718-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391105889-32718-1-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


This patch adds descriptions fore new properties of device tree
binding for the ARM SMMU architecture. These properties control
arm-smmu driver options.

Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Andreas Herrmann <herrmann.der.user-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/iommu/arm,smmu.txt         |   11 +++++++++++
 1 file changed, 11 insertions(+)

Hi Will,

I should have included this patch in the series as it describes the
options introduced there.


Andreas

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index e34c6cd..7ad8ff0 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -48,6 +48,16 @@ conditions.
                   from the mmu-masters towards memory) node for this
                   SMMU.
 
+- arm,smmu-isolate-devices : Enable device isolation for all masters
+                   of this SMMU. Ie. each master will be attached to
+                   its own iommu domain.
+
+- calxeda,smmu-secure-config-access : Enable proper handling of buggy
+                   implementations that always use secure access to
+                   SMMU configuration registers. In this case
+                   non-secure aliases of secure registers have to be
+                   used during SMMU configuration.
+
 Example:
 
         smmu {
@@ -67,4 +77,5 @@ Example:
                  */
                 mmu-masters = <&dma0 0xd01d 0xd01e>,
                               <&dma1 0xd11c>;
+                arm,smmu-isolate-devices;
         };
-- 
1.7.9.5
