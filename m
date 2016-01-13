From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Can't boot new 4.4 kernel with IOMMU enabled
Date: Wed, 13 Jan 2016 11:09:50 +0800
Message-ID: <20160113030950.GB11902@dhcp-128-28.nay.redhat.com>
References: <56957209.1080202@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56957209.1080202-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Seems 0f:00.0 is not attached to a group so that it get a domain. Can
you also paste your "lspci -t" and "lspci -vvv" output? Here 0f:00.0
should be a pci bridge which need set the same domain with its
peripheral 0000:0f:04.0.

Please apply this patch and try again.


>From 6740bc427ddfeecc4b557fcb3ceb0832f73ab33a Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Wed, 13 Jan 2016 11:02:28 +0800
Subject: [PATCH] iommu/amd: Correct the wrong setting of alias DTE in
 do_attach

In below commit Joerg tried to set alias DTE when its peripheral
is setting DTE. But there's a code bug here to wrongly set the
alias DTE, correct it in this patch.

commit e25bfb56ea7f046b71414e02f80f620deb5c6362
Author: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date:   Tue Oct 20 17:33:38 2015 +0200

    iommu/amd: Set alias DTE in do_attach/do_detach

Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8b2be1e..fc836f5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1905,7 +1905,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	/* Update device table */
 	set_dte_entry(dev_data->devid, domain, ats);
 	if (alias != dev_data->devid)
-		set_dte_entry(dev_data->devid, domain, ats);
+		set_dte_entry(alias, domain, ats);
 
 	device_flush_dte(dev_data);
 }
-- 
2.1.0
