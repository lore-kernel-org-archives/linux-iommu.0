From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 9/9] iommu/amd: Document ivrs_ioapic and ivrs_hpet parameters
Date: Tue,  9 Apr 2013 22:13:04 +0200
Message-ID: <1365538384-12426-10-git-send-email-joro@8bytes.org>
References: <1365538384-12426-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1365538384-12426-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Document the new kernel commandline parameters in the
appropriate file.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 Documentation/kernel-parameters.txt |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 4609e81..2848b1b 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1226,6 +1226,20 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 
 	iucv=		[HW,NET]
 
+	ivrs_ioapic	[HW,X86_64]
+			Provide an override to the IOAPIC-ID<->DEVICE-ID
+			mapping provided in the IVRS ACPI table. For
+			example, to map IOAPIC-ID decimal 10 to
+			PCI device 00:14.0 write the parameter as:
+				ivrs_ioapic[10]=00:14.0
+
+	ivrs_hpet	[HW,X86_64]
+			Provide an override to the HPET-ID<->DEVICE-ID
+			mapping provided in the IVRS ACPI table. For
+			example, to map HPET-ID decimal 0 to
+			PCI device 00:14.0 write the parameter as:
+				ivrs_hpet[0]=00:14.0
+
 	js=		[HW,JOY] Analog joystick
 			See Documentation/input/joystick.txt.
 
-- 
1.7.9.5
