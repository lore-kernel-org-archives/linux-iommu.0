From: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 03/10] NTB: Introduce helper functions to calculate logical
	port number
Date: Thu, 21 Mar 2019 18:06:38 -0600
Message-ID: <20190322000645.15580-4-logang@deltatee.com>
References: <20190322000645.15580-1-logang@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190322000645.15580-1-logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ntb-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kselftest-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Mason <jdmason-zqedIHPRSYI@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Allen Hubbe <allenbh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Serge Semin <fancer.lancer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch introduces the "Logical Port Number" which is similar to the
"Port Number" in that it enumerates the ports in the system.

The original (or Physical) "Port Number" can be any number used by the
hardware to uniquley identify a port in the system. The "Logical Port
Number" enumerates all ports in the system from 0 to the number of
ports minus one.

For example a system with 5 ports might have the following port numbers
which would be enumareted thusly:

Port Number:           1  2  5  7  116
Logical Port Number:   0  1  2  3  4

The logical port number is useful when calculating which resources
to use for which peers. So we thus define two helper functions:
ntb_logical_port_number() and ntb_peer_logical_port_number() which
provide the "Logical Port Number" for the local port and any peer
respectively.

Signed-off-by: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Cc: Jon Mason <jdmason-zqedIHPRSYI@public.gmane.org>
Cc: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Allen Hubbe <allenbh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Serge Semin <fancer.lancer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/linux/ntb.h | 53 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 56a92e3ae3ae..52060b2130b6 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -616,7 +616,6 @@ static inline int ntb_port_number(struct ntb_dev *ntb)
 
 	return ntb->ops->port_number(ntb);
 }
-
 /**
  * ntb_peer_port_count() - get the number of peer device ports
  * @ntb:	NTB device context.
@@ -653,6 +652,58 @@ static inline int ntb_peer_port_number(struct ntb_dev *ntb, int pidx)
 	return ntb->ops->peer_port_number(ntb, pidx);
 }
 
+/**
+ * ntb_logical_port_number() - get the logical port number of the local port
+ * @ntb:	NTB device context.
+ *
+ * The Logical Port Number is defined to be a unique number for each
+ * port starting from zero through to the number of ports minus one.
+ * This is in contrast to the Port Number where each port can be assigned
+ * any unqique physical number by the hardware.
+ *
+ * The logical port number is useful for calculating the resource indexes
+ * used by peers.
+ *
+ * Return: the logical port number or negative value indicating an error
+ */
+static inline int ntb_logical_port_number(struct ntb_dev *ntb)
+{
+	int lport = ntb_port_number(ntb);
+	int pidx;
+
+	if (lport < 0)
+		return lport;
+
+	for (pidx = 0; pidx < ntb_peer_port_count(ntb); pidx++)
+		if (lport <= ntb_peer_port_number(ntb, pidx))
+			return pidx;
+
+	return pidx;
+}
+
+/**
+ * ntb_peer_logical_port_number() - get the logical peer port by given index
+ * @ntb:	NTB device context.
+ * @pidx:	Peer port index.
+ *
+ * The Logical Port Number is defined to be a unique number for each
+ * port starting from zero through to the number of ports minus one.
+ * This is in contrast to the Port Number where each port can be assigned
+ * any unqique physical number by the hardware.
+ *
+ * The logical port number is useful for calculating the resource indexes
+ * used by peers.
+ *
+ * Return: the peer's logical port number or negative value indicating an error
+ */
+static inline int ntb_peer_logical_port_number(struct ntb_dev *ntb, int pidx)
+{
+	if (ntb_peer_port_number(ntb, pidx) < ntb_port_number(ntb))
+		return pidx;
+	else
+		return pidx + 1;
+}
+
 /**
  * ntb_peer_port_idx() - get the peer device port index by given port number
  * @ntb:	NTB device context.
-- 
2.20.1
