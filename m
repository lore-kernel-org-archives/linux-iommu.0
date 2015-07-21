From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 04/11] PCI: Reduce size of ATS structure elements
Date: Mon, 20 Jul 2015 19:14:21 -0500
Message-ID: <20150721001421.28145.58270.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150721001243.28145.81610.stgit-1RhO1Y9PlrlHTL0Zs8A6p/gx64E7kk8eUsxypvmhUTTZJqsBc5GL+g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Gregor Dick <gdick-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The extended capabilities list is linked with 12-bit pointers, and the ATS
Smallest Translation Unit and Invalidate Queue Depth fields are both 5
bits.

Use u16 and u8 to hold the extended capability address and the stu and qdep
values.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Reviewed-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 include/linux/pci.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8bc16b5..238b77e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -376,9 +376,9 @@ struct pci_dev {
 		struct pci_sriov *sriov;	/* SR-IOV capability related */
 		struct pci_dev *physfn;	/* the PF this VF is associated with */
 	};
-	int		ats_cap;	/* ATS Capability offset */
-	int		ats_stu;	/* ATS Smallest Translation Unit */
-	int		ats_qdep;	/* ATS Invalidate Queue Depth */
+	u16		ats_cap;	/* ATS Capability offset */
+	u8		ats_stu;	/* ATS Smallest Translation Unit */
+	u8		ats_qdep;	/* ATS Invalidate Queue Depth */
 	atomic_t	ats_ref_cnt;	/* number of VFs with ATS enabled */
 #endif
 	phys_addr_t rom; /* Physical address of ROM if it's not from the BAR */
