From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v6 3/8] iommu, x86: Implement irq_set_vcpu_affinity for
	intel_ir_chip
Date: Fri, 22 May 2015 01:02:42 +0000
Message-ID: <E959C4978C3B6342920538CF579893F002546B0D@SHSMSX104.ccr.corp.intel.com>
References: <1432191555-3516-1-git-send-email-feng.wu@intel.com>
	<1432191555-3516-4-git-send-email-feng.wu@intel.com>
	<alpine.DEB.2.11.1505211244110.4225@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1505211244110.4225@nanos>
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
> Sent: Thursday, May 21, 2015 6:48 PM
> To: Wu, Feng
> Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [v6 3/8] iommu, x86: Implement irq_set_vcpu_affinity for
> intel_ir_chip
> 
> On Thu, 21 May 2015, Feng Wu wrote:
> > +static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
> > +{
> > +	struct intel_ir_data *ir_data = data->chip_data;
> > +	struct irte *irte_pi = &ir_data->irte_pi_entry;
> > +	struct vcpu_data *vcpu_pi_info;
> > +
> > +	/* stop posting interrupts, back to remapping mode */
> > +	if (!vcpu_info)
> > +		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
> > +	else {
> 
> We add braces to both branches if one requires it.
> 
> > +		vcpu_pi_info = (struct vcpu_data *)vcpu_info;
> > +		memcpy(irte_pi, &ir_data->irte_entry, sizeof(struct irte));
> 
> This lacks a comment WHY you copy irte_entry to irte_pi_entry and WHY
> we have two seperate entries stored in ir_data.

"ir_data->irte_entry" saves the remapped format of IRTE, as you can see
from patch [4/8], it being a cached irte is still updated when setting the
affinity even when we are in posted mode. So this make it possible to switch
back to remapped mode from posted mode, we can just set "ir_data->irte_entry"
to hardware for that purpose. I will add the comments, thanks for the suggestion!

BTW, do you have any other comments/suggestions about this series?
Any comments are appreciated!

Thanks,
Feng

> 
> Thanks,
> 
> 	tglx
