From: Glenn Serre <gserre-43mecJUBy8ZBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 2/2] Documentation/kernel-parameters.txt : Remove IA-64
	from iommu=pt doc
Date: Mon, 17 Oct 2016 11:15:08 -0700
Message-ID: <f5c34f99-04a5-3d35-2cf5-a5ce270aa30c@brocade.com>
References: <2ebef311-b346-f3ed-2fca-ce4715b84c9d@brocade.com>
	<6b2c6f0b-cce8-b8f6-37c2-d4cc453bd603@brocade.com>
	<20161004165232.GD2428@localhost.localdomain>
	<04ab568e-8088-cf23-facb-7ef3fecf4bb6@brocade.com>
	<20161004170358.GE2428@localhost.localdomain>
	<ad5f24df-99e3-d9c7-4ca3-ba3de820da8e@brocade.com>
	<f3608ce9-af12-9ac8-7503-1ccd45983ee7@brocade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f3608ce9-af12-9ac8-7503-1ccd45983ee7-43mecJUBy8ZBDgjK7y7TUQ@public.gmane.org>
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
List-Id: iommu@lists.linux-foundation.org

Remove IA-64 from iommu=pt doc

There is no sign of either iommu parameter parsing
or use of iommu_pass_through in arch/ia64/kernel/pci-dma.c,
so remove IA-64 from iommu=pt documentation.

This patch depends on patch iommu_default_pt.patch.

Signed-off-by: Glenn Serre <gserre-43mecJUBy8ZBDgjK7y7TUQ@public.gmane.org>
---
  Documentation/kernel-parameters.txt |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1747,7 +1747,7 @@
  		nomerge
  		forcesac
  		soft
-		pt		[x86, IA-64]
+		pt		[x86]
  		nopt		[x86]
  		nobypass	[PPC/POWERNV]
  			Disable IOMMU bypass, using IOMMU for PCI devices.
