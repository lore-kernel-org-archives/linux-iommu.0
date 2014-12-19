From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v3 23/26] KVM: Update Posted-Interrupts Descriptor when vCPU
	is preempted
Date: Fri, 19 Dec 2014 02:09:54 +0000
Message-ID: <E959C4978C3B6342920538CF579893F00230A86A@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-24-git-send-email-feng.wu@intel.com>
	<5491B924.3090200@redhat.com>
	<E959C4978C3B6342920538CF579893F002307C66@SHSMSX104.ccr.corp.intel.com>
	<5492911D.3000900@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5492911D.3000900-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> [mailto:linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Paolo Bonzini
> Sent: Thursday, December 18, 2014 4:32 PM
> To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [v3 23/26] KVM: Update Posted-Interrupts Descriptor when vCPU
> is preempted
> 
> 
> 
> On 18/12/2014 04:15, Wu, Feng wrote:
> > Thanks for your comments, Paolo!
> >
> > If we use u64 new_control, we cannot use new.sn any more.
> > Maybe we can change the struct pi_desc {} like this:
> >
> > typedef struct pid_control{
> >         u64     on      : 1,
> >         sn      : 1,
> >         rsvd_1  : 13,
> >         ndm     : 1,
> >         nv      : 8,
> >         rsvd_2  : 8,
> >         ndst    : 32;
> > }pid_control_t;
> >
> > struct pi_desc {
> >         u32 pir[8];     /* Posted interrupt requested */
> > 		pid_control_t control;
> 
> Probably something like this to keep the union:
> 
> typedef union pid_control {
> 	u64 full;
> 	struct {
> 		u64 on : 1,
> 		...
> 	} fields;
> };
> 
> >         u32 rsvd[6];
> > } __aligned(64);
> >
> >
> > Then we can define pid_control_t new_control, old_control. And use
> new_control.sn = 0.
> >
> > What is your opinon?
> 
> Sure.  Alternatively, keep using struct pi_desc new; just
> do not zero it, nor access any field outide the control word.
> 
> Paolo

Yes, this is also a good idea. Thanks!

Thanks,
Feng

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
