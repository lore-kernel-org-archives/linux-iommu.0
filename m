From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v7 4/8] iommu, x86: No need to migrating irq for VT-d
	Posted-Interrupts
Date: Tue, 26 May 2015 02:53:00 +0000
Message-ID: <E959C4978C3B6342920538CF579893F0025519ED@SHSMSX104.ccr.corp.intel.com>
References: <1432531734-25978-1-git-send-email-feng.wu@intel.com>
	<1432531734-25978-5-git-send-email-feng.wu@intel.com>
	<alpine.DEB.2.11.1505251034070.5457@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1505251034070.5457@nanos>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org]
> Sent: Monday, May 25, 2015 4:38 PM
> To: Wu, Feng
> Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [v7 4/8] iommu, x86: No need to migrating irq for VT-d
> Posted-Interrupts
> 
> On Mon, 25 May 2015, Feng Wu wrote:
> 
> > We don't need to migrate the irqs for VT-d Posted-Interrupts here.
> > When 'pst' is set in IRTE, the associated irq will be posted to
> > guests instead of interrupt remapping. The destination of the
> > interrupt is set in Posted-Interrupts Descriptor, and the migration
> > happens during vCPU scheduling.
> >
> > However, we still update the cached irte here, which can be used
> > when changing back to remapping mode.
> >
> > Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Reviewed-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Acked-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/iommu/intel_irq_remapping.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/intel_irq_remapping.c
> b/drivers/iommu/intel_irq_remapping.c
> > index 1955b09..646f4cf 100644
> > --- a/drivers/iommu/intel_irq_remapping.c
> > +++ b/drivers/iommu/intel_irq_remapping.c
> > @@ -994,7 +994,10 @@ intel_ir_set_affinity(struct irq_data *data, const
> struct cpumask *mask,
> >  	 */
> >  	irte->vector = cfg->vector;
> >  	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
> > -	modify_irte(&ir_data->irq_2_iommu, irte);
> > +
> > +	/* We don't need to modify irte if the interrupt is for posting. */
> > +	if (irte->pst != 1)
> > +		modify_irte(&ir_data->irq_2_iommu, irte);
> 
> I don't think this is correct. ir_data->irte_entry contains the non
> posted version, which has pst == 0.
> 
> You need some other way to store whether you are in posted mode or
> not.

Yes, seems this is incorrect. Thank you for pointing this out. After more
thinking about this, I think I can do it this way:
#1. Check the 'pst' field in hardware
#2. If 'pst' is 1, we don't update the IRTE in hardware.

However, the question is the check and update operations should be protected
by the same spinlock ' irq_2_ir_lock ', otherwise, race condition may happen.

Based on the above idea, I have two solutions for this, do you think which one
is better or you have other better suggestions? It is highly appreciated if you
can give comments about them!

Solution 1:
Introduction a new function test_and_modify_irte() which is called by intel_ir_set_affinity
in place of the original modify_irte().
Here is the changes:

+static int test_and_modify_irte(struct irq_2_iommu *irq_iommu,
+                               struct irte *irte_modified)
+{
+       struct intel_iommu *iommu;
+       unsigned long flags;
+       struct irte *irte;
+       int rc, index;
+
+       if (!irq_iommu)
+               return -1;
+
+       raw_spin_lock_irqsave(&irq_2_ir_lock, flags);
+
+       iommu = irq_iommu->iommu;
+
+       index = irq_iommu->irte_index + irq_iommu->sub_handle;
+       irte = &iommu->ir_table->base[index];
+
+       if (irte->pst)
+               goto unlock;
+
+       set_64bit(&irte->low, irte_modified->low);
+       set_64bit(&irte->high, irte_modified->high);
+       __iommu_flush_cache(iommu, irte, sizeof(*irte));
+
+       rc = qi_flush_iec(iommu, index, 0);
+unlock:
+       raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
+
+       return rc;
+}
+

Soluation 2:
Instead of introducing a new function, add a flag in the original modify_irte()
function to indicate that whether we need to check and return before updating
the real hardware, add pass 1 to return_on_pst in intel_ir_set_affinity()
Here is the changes:
static int modify_irte(struct irq_2_iommu *irq_iommu,
-                      struct irte *irte_modified)
+                      struct irte *irte_modified
+                      bool return_on_pst)
 {
        struct intel_iommu *iommu;
        unsigned long flags;
@@ -140,11 +173,15 @@ static int modify_irte(struct irq_2_iommu *irq_iommu,
        index = irq_iommu->irte_index + irq_iommu->sub_handle;
        irte = &iommu->ir_table->base[index];

+       if (return_on_pst && irte->pst)
+               goto unlock;
+
        set_64bit(&irte->low, irte_modified->low);
        set_64bit(&irte->high, irte_modified->high);
        __iommu_flush_cache(iommu, irte, sizeof(*irte));

        rc = qi_flush_iec(iommu, index, 0);
+unlock:
        raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);

        return rc;

Thanks,
Feng

> 
> Thanks,
> 
> 	tglx
