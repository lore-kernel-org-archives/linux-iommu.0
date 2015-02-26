From: Marcelo Tosatti <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU is
	blocked
Date: Thu, 26 Feb 2015 20:41:14 -0300
Message-ID: <20150226234114.GB7784@amt.cnet>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-25-git-send-email-feng.wu@intel.com>
	<20150225215011.GA16848@amt.cnet>
	<E959C4978C3B6342920538CF579893F0023E9C69@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E959C4978C3B6342920538CF579893F0023E9C69-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "Zhang, Yang Z" <yang.z.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 26, 2015 at 08:08:15AM +0000, Wu, Feng wrote:
> 
> 
> > -----Original Message-----
> > From: Marcelo Tosatti [mailto:mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> > Sent: Thursday, February 26, 2015 5:50 AM
> > To: Wu, Feng
> > Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org; mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org; x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> > gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org;
> > joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org;
> > eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Subject: Re: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU
> > is blocked
> > 
> > On Fri, Dec 12, 2014 at 11:14:58PM +0800, Feng Wu wrote:
> > > This patch updates the Posted-Interrupts Descriptor when vCPU
> > > is blocked.
> > >
> > > pre-block:
> > > - Add the vCPU to the blocked per-CPU list
> > > - Clear 'SN'
> > > - Set 'NV' to POSTED_INTR_WAKEUP_VECTOR
> > >
> > > post-block:
> > > - Remove the vCPU from the per-CPU list
> > >
> > > Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > ---
> > 
> > Don't see this is needed, can use the existing POSTED_INTR_VECTOR:
> > 
> > If in guest mode, IPI will be handled in VMX non-root by performed
> > PIR->IRR transfer.
> > 
> > If outside guest mode, POSTED_INTR_VECTOR IPI will be handled by host
> > which can wakeup the guest (in case it is halted).
> 
> Please see the following scenario:
> 
> 1. vCPU0 is running on pCPU0
> 2. vCPU0 is halted and vCPU1 is currently running on pCPU0
> 3. An interrupt occurs for vCPU0, if we still use POSTED_INTR_VECTOR
> for vCPU0, the notification event for vCPU0 (the event will go to pCPU1)
> will be consumed by vCPU1 incorrectly. The worst case is that vCPU0
> will never be woken up again since the wakeup event for it is always
> consumed by other vCPUs incorrectly.
> 
> Thanks,
> Feng

Ouch, yes.
