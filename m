From: Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 2/2] Documentation: dt-bindings: Add option to workaround
	STE.VALID in Broadcom Vulcan
Date: Thu, 17 Dec 2015 15:29:36 +0530
Message-ID: <1450346376-30920-2-git-send-email-pmallapp@broadcom.com>
References: <1450346376-30920-1-git-send-email-pmallapp@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450346376-30920-1-git-send-email-pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Prem Mallappa <pmallapp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
index 947863a..9c1218e 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -43,6 +43,11 @@ the PCIe specification.
 - hisilicon,broken-prefetch-cmd
                     : Avoid sending CMD_PREFETCH_* commands to the SMMU.
 
+- broadcom,broken-ste-valid-check
+                    : Broadcom specific, h/w peeks into more than just 
+		      STE.VALID bit in "Bypass" mode. Enabling this, 
+		      populates needed bits.
+
 ** Example
 
         smmu@2b400000 {
-- 
2.6.0
