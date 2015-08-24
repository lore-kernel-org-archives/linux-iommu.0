From: "Xiao, Nan (Nan@HPS Performance, Beijing)" <nan.xiao-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH] Documentation/Intel-IOMMU.txt: Modify definition of DRHD
Date: Mon, 24 Aug 2015 06:22:42 +0000
Message-ID: <F9D82F0D71C0024FA18FE771EDDAF149081FAC82@G4W3303.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi David & Joerg,

According to "Intel Virtualization Technology for Directed I/O" specification,
DRHD stands for "DMA Remapping Hardware Unit Definition" , not "DMA Engine Reporting Structure".

Signed-off-by: Nan Xiao <nan.xiao-VXdhtT5mjnY@public.gmane.org>
---
 Documentation/Intel-IOMMU.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Intel-IOMMU.txt b/Documentation/Intel-IOMMU.txt
index cf9431d..7b57fc0 100644
--- a/Documentation/Intel-IOMMU.txt
+++ b/Documentation/Intel-IOMMU.txt
@@ -10,7 +10,7 @@ This guide gives a quick cheat sheet for some basic understanding.
 Some Keywords
 
 DMAR - DMA remapping
-DRHD - DMA Engine Reporting Structure
+DRHD - DMA Remapping Hardware Unit Definition
 RMRR - Reserved memory Region Reporting Structure
 ZLR  - Zero length reads from PCI devices
 IOVA - IO Virtual address.
-- 
2.4.3


Best Regards
Nan Xiao
