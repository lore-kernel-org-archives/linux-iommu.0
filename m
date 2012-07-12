From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 01/27] x86/irq: Add data structure to keep AMD specific
	irq remapping information
Date: Thu, 12 Jul 2012 17:40:31 +0200
Message-ID: <20120712154031.GA4213@amd.com>
References: <1342013952-10174-1-git-send-email-joerg.roedel@amd.com>
	<1342013952-10174-2-git-send-email-joerg.roedel@amd.com>
	<CAE9FiQUEYVMi46WYfLDDUO=PuTHYbmqXreZnCWLRdUjBH2iH4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAE9FiQUEYVMi46WYfLDDUO=PuTHYbmqXreZnCWLRdUjBH2iH4Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 11, 2012 at 02:42:03PM -0700, Yinghai Lu wrote:
> >  #ifdef CONFIG_IRQ_REMAP
> > -       struct irq_2_iommu      irq_2_iommu;
> > +       union irq_remap_info    irq_remap_info;
> 
> how about
> +union {
> +       struct irq_2_iommu irq_2_iommu;
> +       struct irq_2_irte  irq_2_irte;
> +};
> 
> instead?

Yes, that is better. I updated the patch (and 4-5 more patches in the
series to adapt them to this data structure change). I will update the
branch on my tree today and push the version with this change included.
Here is the new patch:

>From a0fd5f10f015629592adc28cb9b79d61d0ba1bfb Mon Sep 17 00:00:00 2001
From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Date: Tue, 19 Jun 2012 16:07:45 +0200
Subject: [PATCH 01/27] x86/irq: Add data structure to keep AMD specific irq
 remapping information

Add a data structure to store information the IOMMU driver
can use to get from a 'struct irq_cfg' to the remapping
entry.

Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 arch/x86/include/asm/hw_irq.h |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index eb92a6e..fc89a2a 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -101,6 +101,7 @@ static inline void set_io_apic_irq_attr(struct io_apic_irq_attr *irq_attr,
 	irq_attr->polarity	= polarity;
 }
 
+/* Intel specific interrupt remapping information */
 struct irq_2_iommu {
 	struct intel_iommu *iommu;
 	u16 irte_index;
@@ -108,6 +109,12 @@ struct irq_2_iommu {
 	u8  irte_mask;
 };
 
+/* AMD specific interrupt remapping information */
+struct irq_2_irte {
+	u16 devid; /* Device ID for IRTE table */
+	u16 index; /* Index into IRTE table*/
+};
+
 /*
  * This is performance-critical, we want to do it O(1)
  *
@@ -120,7 +127,10 @@ struct irq_cfg {
 	u8			vector;
 	u8			move_in_progress : 1;
 #ifdef CONFIG_IRQ_REMAP
-	struct irq_2_iommu	irq_2_iommu;
+	union {
+		struct irq_2_iommu irq_2_iommu;
+		struct irq_2_irte  irq_2_irte;
+	};
 #endif
 };
 
-- 
1.7.9.5


-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
