From: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v4 2/2] iommu: Change iommu driver to call io_page_fault trace
	event
Date: Tue, 24 Sep 2013 15:21:20 -0600
Message-ID: <5d124e3b1aee697d24c4b427cb21784c7c3a90e5.1380056222.git.shuah.kh@samsung.com>
References: <cover.1380056222.git.shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1380056222.git.shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
In-Reply-To: <cover.1380056222.git.shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
References: <cover.1380056222.git.shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, udknight-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org, fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Change iommu driver call io_page_fault trace event. This iommu_error class
event can be enabled to trigger when an iommu error occurs. Trace information
includes driver name, device name, iova, and flags.

Testing:
Added trace calls to iommu_prepare_identity_map() for testing some of the
conditions that are hard to trigger. Here is the trace from the testing:

       swapper/0-1     [003] ....     2.003774: io_page_fault: IOMMU:pci 0000:00:02.0 iova=0x00000000cb800000 flags=0x0002
       swapper/0-1     [003] ....     2.004098: io_page_fault: IOMMU:pci 0000:00:1d.0 iova=0x00000000cadc6000 flags=0x0002
       swapper/0-1     [003] ....     2.004115: io_page_fault: IOMMU:pci 0000:00:1a.0 iova=0x00000000cadc6000 flags=0x0002
       swapper/0-1     [003] ....     2.004129: io_page_fault: IOMMU:pci 0000:00:1f.0 iova=0x0000000000000000 flags=0x0002

Signed-off-by: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 include/linux/iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7ea319e..a444c79 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -22,6 +22,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/types.h>
+#include <trace/events/iommu.h>
 
 #define IOMMU_READ	(1)
 #define IOMMU_WRITE	(2)
@@ -227,6 +228,7 @@ static inline int report_iommu_fault(struct iommu_domain *domain,
 		ret = domain->handler(domain, dev, iova, flags,
 						domain->handler_token);
 
+	trace_io_page_fault(dev, iova, flags);
 	return ret;
 }
 
-- 
1.8.1.2
