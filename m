From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: RE: [v7 4/8] iommu, x86: No need to migrating irq for VT-d
	Posted-Interrupts
Date: Tue, 26 May 2015 12:00:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1505261154330.5457@nanos>
References: <1432531734-25978-1-git-send-email-feng.wu@intel.com>
	<1432531734-25978-5-git-send-email-feng.wu@intel.com>
	<alpine.DEB.2.11.1505251034070.5457@nanos>
	<E959C4978C3B6342920538CF579893F0025519ED@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <E959C4978C3B6342920538CF579893F0025519ED-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
Cc: "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 26 May 2015, Wu, Feng wrote:
> > On Mon, 25 May 2015, Feng Wu wrote:
> > > +
> > > +	/* We don't need to modify irte if the interrupt is for posting. */
> > > +	if (irte->pst != 1)
> > > +		modify_irte(&ir_data->irq_2_iommu, irte);
> > 
> > I don't think this is correct. ir_data->irte_entry contains the non
> > posted version, which has pst == 0.
> > 
> > You need some other way to store whether you are in posted mode or
> > not.
> 
> Yes, seems this is incorrect. Thank you for pointing this out. After more
> thinking about this, I think I can do it this way:
> #1. Check the 'pst' field in hardware
> #2. If 'pst' is 1, we don't update the IRTE in hardware.
> 
> However, the question is the check and update operations should be protected
> by the same spinlock ' irq_2_ir_lock ', otherwise, race condition may happen.

Why? 

set_affinity() and vcpu_set_affinity() are serialized via
irq_desc->lock. And vcpu_set_affinity() is the only way to switch from
and to posted mode.

So all you need is a field in intel_irq_data which captures whether
posted is enabled or not.

Thanks,

	tglx
