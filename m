From: Baoquan He <bhe@redhat.com>
Subject: Re: [Patch v4 9/9] iommu/amd: Check the validation of irq table and
 domain id
Date: Mon, 30 May 2016 13:10:59 +0800
Message-ID: <20160530051059.GE2488@x1.redhat.com>
References: <1464157735-8865-1-git-send-email-bhe@redhat.com>
 <1464157735-8865-10-git-send-email-bhe@redhat.com>
 <4da4c13e-1dc8-1096-f05a-e6d172c07df2@iommu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4da4c13e-1dc8-1096-f05a-e6d172c07df2@iommu.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan Zongshun <vw@iommu.org>
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org, vincent.wan@amd.com, iommu@lists.linux-foundation.org, dyoung@redhat.com
List-Id: iommu@lists.linux-foundation.org

On 05/28/16 at 09:30pm, Wan Zongshun wrote:
> 
> 
> -------- Original Message --------
> >From: Baoquan HE <bhe@dhcp-129-10.nay.redhat.com>
> >diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> >index f3bd7fd..40c4a05 100644
> >--- a/drivers/iommu/amd_iommu.c
> >+++ b/drivers/iommu/amd_iommu.c
> >@@ -3697,10 +3697,6 @@ struct amd_ir_data {
> >
> > static struct irq_chip amd_ir_chip;
> >
> >-#define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
> >-#define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
> >-#define DTE_IRQ_TABLE_LEN       (8ULL << 1)
> >-#define DTE_IRQ_REMAP_ENABLE    1ULL
> 
> At least, you should give reason comments to why you want move it.
> 
> Any drivers files you want to use them as well?

Yes, sorry fot this. I have several test machines. I made change on
them and made patches. In the machine I posted this patch was not
arranged well.

> 
> >
> > static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
> > {
> >diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> >index 47e5972..263704a 100644
> >--- a/drivers/iommu/amd_iommu_init.c
> >+++ b/drivers/iommu/amd_iommu_init.c
> >@@ -670,7 +670,7 @@ static int copy_dev_tables(void)
> > 	u32 lo, hi, devid;
> > 	phys_addr_t old_devtb_phys;
> > 	struct dev_table_entry *old_devtb;
> >-	u16 dom_id, dte_v;
> >+	u16 dom_id, dte_v, irq_v;
> > 	struct amd_iommu *iommu;
> > 	static int copied;
> >
> >@@ -692,7 +692,8 @@ static int copy_dev_tables(void)
> >                         amd_iommu_dev_table[devid] = old_devtb[devid];
> >                         dom_id = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
> > 			dte_v = amd_iommu_dev_table[devid].data[0] & DTE_FLAG_V;
> >-			if (!dte_v)
> >+			irq_v = amd_iommu_dev_table[devid].data[2] & DTE_IRQ_REMAP_ENABLE;
> >+			if (!dte_v || !irq_v || !dom_id)
> > 				continue;
> >                         __set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
> >                 }
> >diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> >index 34acd73..08340f5 100644
> >--- a/drivers/iommu/amd_iommu_types.h
> >+++ b/drivers/iommu/amd_iommu_types.h
> >@@ -224,6 +224,11 @@
> >
> > #define PPR_REQ_FAULT		0x01
> >
> >+#define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
> >+#define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
> >+#define DTE_IRQ_TABLE_LEN       (8ULL << 1)
> >+#define DTE_IRQ_REMAP_ENABLE    1ULL
> >+
> > #define PAGE_MODE_NONE    0x00
> > #define PAGE_MODE_1_LEVEL 0x01
> > #define PAGE_MODE_2_LEVEL 0x02
> >
