From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v4 0/8] Add VT-d Posted-Interrupts support - IOMMU part
Date: Tue, 7 Apr 2015 05:02:55 +0000
Message-ID: <E959C4978C3B6342920538CF579893F002490369@SHSMSX104.ccr.corp.intel.com>
References: <1422864424-19411-1-git-send-email-feng.wu@intel.com>
	<20150402112833.GN4441@8bytes.org> <551E4B7D.6020108@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <551E4B7D.6020108-VXdhtT5mjnY@public.gmane.org>
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
To: "Li, ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Li, ZhenHua [mailto:zhen-hual-VXdhtT5mjnY@public.gmane.org]
> Sent: Friday, April 03, 2015 4:13 PM
> To: Wu, Feng
> Cc: Joerg Roedel; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Li, ZhenHua
> Subject: Re: [v4 0/8] Add VT-d Posted-Interrupts support - IOMMU part
> 
> Hi Feng Wu,
> In my patchset, I created a new member ir_table->base_old_phys; In the
> normal kernel, everything is the same. In kdump kernel, ir_table->base
> is used for a buffer, and  ir_table->base_old_phys is the physical
> address of the tables used by the old kernel, also being used by the
> current kernel.
> 
> I did this in modify_irte():
> 
>          set_64bit(&irte->high, irte_modified->high);
> +
> +#ifdef CONFIG_CRASH_DUMP
> +       if (is_kdump_kernel())
> +               __iommu_update_old_irte(iommu, index);
> +#endif
>          __iommu_flush_cache(iommu, irte, sizeof(*irte));
> 
> 
> Here the irte tables are stored in two places:
> iommu->ir_table->base : It is a buffer in kdump kernel, which is the
> running kernel;
> iommu->ir_table->base_old_phys : It is the irte used by the old kernel;
> 
> And function __iommu_update_old_irte is used to save the content of
> iommu->ir_table->base  to iommu->ir_table->base_old_phys. Because in
> kdump kernel, the vt-d is using ir_table->base_old_phys, not
> ir_table->base, so we need to copy the updated ir_table->base to
> ir_table->base_old_phys .
> 

Hi Zhenhua,

Thanks very much for your clarification! Basically, the main purpose of my
Patch-set is to provide an interface to KVM, so that KVM can update irte
for posted-interrupts. In this interface, it calls modify_irte(). I also go
through your patch set with the associated part, seems I cannot find
any conflicts with your patches. What is your idea about this? Thanks a lot!

Thanks,
Feng

-


> 
> Thanks
> Zhenhua
> 
> On 04/02/2015 07:28 PM, Joerg Roedel wrote:
> > On Mon, Feb 02, 2015 at 04:06:56PM +0800, Feng Wu wrote:
> >> VT-d Posted-Interrupts is an enhancement to CPU side Posted-Interrupt.
> >> With VT-d Posted-Interrupts enabled, external interrupts from
> >> direct-assigned devices can be delivered to guests without VMM
> >> intervention when guest is running in non-root mode.
> >>
> >> You can find the VT-d Posted-Interrtups Spec. in the following URL:
> >>
> http://www.intel.com/content/www/us/en/intelligent-systems/intel-technolog
> y/vt-directed-io-spec.html
> >>
> >> This series was part of
> http://thread.gmane.org/gmane.linux.kernel.iommu/7708. To make things
> clear, send out IOMMU part here.
> >
> > Besides the modify_irte() changes I asked for the patch-set looks good.
> > I just have some concerns what these changes mean for the VT-d kdump
> > improvements Zhen-Hua Li is working on. Can you please discuss the
> > implications of having both patch-sets applied with him and make sure
> > they work together? I think in its current form your patch-set breaks
> > the kdump support patches. I added Zhen-Hua to Cc.
> >
> > Thanks,
> >
> > 	Joerg
> >
