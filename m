From: andrew-WCNZvuCk18ErewFq2K+F1F6hYfS7NtTn@public.gmane.org
Subject: [PATCH] iommu/amd: Workaround wrong IOAPIC devid in IVRS.
Date: Wed, 10 Oct 2012 23:05:09 +0100
Message-ID: <1349906709-5846-1-git-send-email-andrew@ado.is-a-geek.net>
References: <20121010230231.2fb3c3b9@ado-amd-gentoo.moore.slainvet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20121010230231.2fb3c3b9-IjT0q3EH84DI7ueSY2wKCeWwSe/Luo9VmGrBRn/+eNheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Oakley <andrew-WCNZvuCk18ErewFq2K+F1F6hYfS7NtTn@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Andrew Oakley <andrew-WCNZvuCk18ErewFq2K+F1F6hYfS7NtTn@public.gmane.org>

The IOAPIC always has the same device id but is sometimes reported in
the IVRS table with a different id.  This patch allows interrupt
remapping to work on devices with this bug.
---
 drivers/iommu/amd_iommu_init.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 18b0d99..ca266b9 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -751,6 +751,9 @@ static void __init set_device_exclusion_range(u16 devid, struct ivmd_header *m)
 	}
 }
 
+/* SB IOAPIC is always on this device in AMD systems */
+#define IOAPIC_SB_DEVID		((0x00 << 8) | PCI_DEVFN(0x14, 0))
+
 /*
  * Takes a pointer to an AMD IOMMU entry in the ACPI table and
  * initializes the hardware and our data structures with it.
@@ -928,6 +931,12 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 				    PCI_SLOT(devid),
 				    PCI_FUNC(devid));
 
+			if (type == IVHD_SPECIAL_IOAPIC &&
+			    devid != IOAPIC_SB_DEVID) {
+				pr_err(FW_BUG "AMD-Vi: wrong IOAPIC devid\n");
+				devid = IOAPIC_SB_DEVID;
+			}
+
 			set_dev_entry_from_acpi(iommu, devid, e->flags, 0);
 			ret = add_special_device(type, handle, devid);
 			if (ret)
-- 
1.7.8.6
