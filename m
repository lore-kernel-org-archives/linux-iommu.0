From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/2] Fix ACS path checking
Date: Mon, 6 Aug 2012 14:20:53 +0200
Message-ID: <20120806122053.GL1996@amd.com>
References: <20120804180155.6144.83332.stgit@bling.home>
	<20120806105010.GK1996@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120806105010.GK1996-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dsahern-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 06, 2012 at 12:50:10PM +0200, Joerg Roedel wrote:
> On Sat, Aug 04, 2012 at 12:08:46PM -0600, Alex Williamson wrote:
> Hmm, tried it here, At least pci_request_acs() still gets called. How do
> you detect if ACS is really enabled?

Okay, I found a problem. pci_request_acs needs to be called before PCI
probing. Does the attached patch help?

>From 87a4363be30d5d015a984a60769f29b0607fc5fb Mon Sep 17 00:00:00 2001
From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Date: Mon, 6 Aug 2012 14:18:42 +0200
Subject: [PATCH] iommu/amd: Fix pci_request_acs() call-place

The pci_request_acs() function needs to be called before PCI
probing to be effective. So move it to another call-place to
ensure that.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 500e7f1..0a2ea31 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1131,9 +1131,6 @@ static int __init amd_iommu_init_pci(void)
 			break;
 	}
 
-	/* Make sure ACS will be enabled */
-	pci_request_acs();
-
 	ret = amd_iommu_init_devices();
 
 	print_iommu_info();
@@ -1652,6 +1649,9 @@ static bool detect_ivrs(void)
 
 	early_acpi_os_unmap_memory((char __iomem *)ivrs_base, ivrs_size);
 
+	/* Make sure ACS will be enabled during PCI probe */
+	pci_request_acs();
+
 	return true;
 }
 
-- 
1.7.9.5
