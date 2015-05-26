From: "Wu, Feng" <feng.wu@intel.com>
Subject: RE: [v7 4/8] iommu, x86: No need to migrating irq for VT-d
 Posted-Interrupts
Date: Tue, 26 May 2015 13:59:59 +0000
Message-ID: <E959C4978C3B6342920538CF579893F0025534D5@SHSMSX104.ccr.corp.intel.com>
References: <1432531734-25978-1-git-send-email-feng.wu@intel.com>
 <1432531734-25978-5-git-send-email-feng.wu@intel.com>
 <alpine.DEB.2.11.1505251034070.5457@nanos>
 <E959C4978C3B6342920538CF579893F0025519ED@SHSMSX104.ccr.corp.intel.com>
 <alpine.DEB.2.11.1505261154330.5457@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1505261154330.5457@nanos>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wu, Feng" <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx@linutronix.de]
> Sent: Tuesday, May 26, 2015 6:00 PM
> To: Wu, Feng
> Cc: joro@8bytes.org; dwmw2@infradead.org; jiang.liu@linux.intel.com;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> Subject: RE: [v7 4/8] iommu, x86: No need to migrating irq for VT-d
> Posted-Interrupts
> 
> On Tue, 26 May 2015, Wu, Feng wrote:
> > > On Mon, 25 May 2015, Feng Wu wrote:
> > > > +
> > > > +	/* We don't need to modify irte if the interrupt is for posting. */
> > > > +	if (irte->pst != 1)
> > > > +		modify_irte(&ir_data->irq_2_iommu, irte);
> > >
> > > I don't think this is correct. ir_data->irte_entry contains the non
> > > posted version, which has pst == 0.
> > >
> > > You need some other way to store whether you are in posted mode or
> > > not.
> >
> > Yes, seems this is incorrect. Thank you for pointing this out. After more
> > thinking about this, I think I can do it this way:
> > #1. Check the 'pst' field in hardware
> > #2. If 'pst' is 1, we don't update the IRTE in hardware.
> >
> > However, the question is the check and update operations should be
> protected
> > by the same spinlock ' irq_2_ir_lock ', otherwise, race condition may happen.
> 
> Why?
> 
> set_affinity() and vcpu_set_affinity() are serialized via
> irq_desc->lock. And vcpu_set_affinity() is the only way to switch from
> and to posted mode.

Oh, Yes, I didn't notice that they are both protected by that lock. In that case,
I can just add a filed like you mentioned below. Thanks for the comments!

Thanks,
Feng

> 
> So all you need is a field in intel_irq_data which captures whether
> posted is enabled or not.
> 
> Thanks,
> 
> 	tglx
