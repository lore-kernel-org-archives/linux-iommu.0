From: Baoquan He <bhe@redhat.com>
Subject: Re: [Patch v4 6/9] iommu/amd: Add function copy_dev_tables
Date: Mon, 30 May 2016 11:32:45 +0800
Message-ID: <20160530033245.GD2488@x1.redhat.com>
References: <1464157735-8865-1-git-send-email-bhe@redhat.com>
 <1464157735-8865-7-git-send-email-bhe@redhat.com>
 <80e8478c-3797-df49-3bf9-e3c5d6879c8b@iommu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <80e8478c-3797-df49-3bf9-e3c5d6879c8b@iommu.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan Zongshun <vw@iommu.org>
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org, vincent.wan@amd.com, iommu@lists.linux-foundation.org, dyoung@redhat.com
List-Id: iommu@lists.linux-foundation.org

On 05/28/16 at 09:08pm, Wan Zongshun wrote:
> >+static int copy_dev_tables(void)
> >+{
> >+	u64 entry;
> >+	u32 lo, hi, devid;
> >+	phys_addr_t old_devtb_phys;
> >+	struct dev_table_entry *old_devtb;
> >+	u16 dom_id, dte_v;
> >+	struct amd_iommu *iommu;
> >+	static int copied;
> >+
> >+        for_each_iommu(iommu) {
> >+		if (!translation_pre_enabled()) {
> >+			pr_err("IOMMU:%d is not pre-enabled!/n", iommu->index);
> >+			return -1;
> >+		}
> 
> If one iommu is not pre-enabled, all iommus will be exit the copy.

Currently amd iommu driver make all iommu-s share a single device table.
When handling this code, I am struggling to take what way to make this
look better. Say we have two iommus A and B on a system, A is detected
to be pre_enabled, but B is not, I didn't think of a good way to do. Any
suggestion?

> 
> >+
> >+		if (copied)
> >+			continue;
> >+
> >+                lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
> >+                hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
> >+                entry = (((u64) hi) << 32) + lo;
> >+                old_devtb_phys = entry & PAGE_MASK;
> >+                old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
> >+                for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
> >+                        amd_iommu_dev_table[devid] = old_devtb[devid];
> >+                        dom_id = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
> >+			dte_v = amd_iommu_dev_table[devid].data[0] & DTE_FLAG_V;
> >+			if (!dte_v)
> >+				continue;
> >+                        __set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
> >+                }
> >+		memunmap(old_devtb);
> >+		copied = 1;
> >+        }
> >+	return 0;
> >+}
> >+
> > void amd_iommu_apply_erratum_63(u16 devid)
> > {
> > 	int sysmgt;
> >diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> >index 7796edf..34acd73 100644
> >--- a/drivers/iommu/amd_iommu_types.h
> >+++ b/drivers/iommu/amd_iommu_types.h
> >@@ -311,6 +311,7 @@
> > #define DTE_FLAG_MASK	(0x3ffULL << 32)
> > #define DTE_GLX_SHIFT	(56)
> > #define DTE_GLX_MASK	(3)
> >+#define DEV_DOMID_MASK 	0xffffULL
> >
> > #define DTE_GCR3_VAL_A(x)	(((x) >> 12) & 0x00007ULL)
> > #define DTE_GCR3_VAL_B(x)	(((x) >> 15) & 0x0ffffULL)
> >
