From: "Wu, Feng" <feng.wu@intel.com>
Subject: RE: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU
 is blocked
Date: Mon, 8 Jun 2015 01:43:41 +0000
Message-ID: <E959C4978C3B6342920538CF579893F00257F319@SHSMSX104.ccr.corp.intel.com>
References: <20150304120608.GA26762@amt.cnet>
 <E959C4978C3B6342920538CF579893F002409841@SHSMSX104.ccr.corp.intel.com>
 <20150312011526.GA5878@amt.cnet>
 <E959C4978C3B6342920538CF579893F00243A819@SHSMSX104.ccr.corp.intel.com>
 <20150325231738.GA7333@amt.cnet>
 <E959C4978C3B6342920538CF579893F0024697E0@SHSMSX104.ccr.corp.intel.com>
 <20150327193013.GA6502@amt.cnet>
 <E959C4978C3B6342920538CF579893F002479E58@SHSMSX104.ccr.corp.intel.com>
 <20150330235533.GA15792@amt.cnet>
 <E959C4978C3B6342920538CF579893F0024A7FBF@SHSMSX104.ccr.corp.intel.com>
 <20150605215915.GA1382@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20150605215915.GA1382@amt.cnet>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "gleb@kernel.org" <gleb@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "eric.auger@linaro.org" <eric.auger@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Wu, Feng" <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Marcelo Tosatti [mailto:mtosatti@redhat.com]
> Sent: Saturday, June 06, 2015 5:59 AM
> To: Wu, Feng
> Cc: hpa@zytor.com; tglx@linutronix.de; mingo@redhat.com; x86@kernel.org;
> gleb@kernel.org; pbonzini@redhat.com; dwmw2@infradead.org;
> joro@8bytes.org; alex.williamson@redhat.com; jiang.liu@linux.intel.com;
> eric.auger@linaro.org; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; kvm@vger.kernel.org
> Subject: Re: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU
> is blocked
> 
> On Tue, Apr 14, 2015 at 07:37:44AM +0000, Wu, Feng wrote:
> >
> >
> > > -----Original Message-----
> > > From: Marcelo Tosatti [mailto:mtosatti@redhat.com]
> > > Sent: Tuesday, March 31, 2015 7:56 AM
> > > To: Wu, Feng
> > > Cc: hpa@zytor.com; tglx@linutronix.de; mingo@redhat.com;
> x86@kernel.org;
> > > gleb@kernel.org; pbonzini@redhat.com; dwmw2@infradead.org;
> > > joro@8bytes.org; alex.williamson@redhat.com; jiang.liu@linux.intel.com;
> > > eric.auger@linaro.org; linux-kernel@vger.kernel.org;
> > > iommu@lists.linux-foundation.org; kvm@vger.kernel.org
> > > Subject: Re: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when
> vCPU
> > > is blocked
> > >
> > > On Mon, Mar 30, 2015 at 04:46:55AM +0000, Wu, Feng wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Marcelo Tosatti [mailto:mtosatti@redhat.com]
> > > > > Sent: Saturday, March 28, 2015 3:30 AM
> > > > > To: Wu, Feng
> > > > > Cc: hpa@zytor.com; tglx@linutronix.de; mingo@redhat.com;
> > > x86@kernel.org;
> > > > > gleb@kernel.org; pbonzini@redhat.com; dwmw2@infradead.org;
> > > > > joro@8bytes.org; alex.williamson@redhat.com;
> jiang.liu@linux.intel.com;
> > > > > eric.auger@linaro.org; linux-kernel@vger.kernel.org;
> > > > > iommu@lists.linux-foundation.org; kvm@vger.kernel.org
> > > > > Subject: Re: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when
> > > vCPU
> > > > > is blocked
> > > > >
> > > > > On Fri, Mar 27, 2015 at 06:34:14AM +0000, Wu, Feng wrote:
> > > > > > > > Currently, the following code is executed before local_irq_disable()
> is
> > > > > called,
> > > > > > > > so do you mean 1)moving local_irq_disable() to the place before it.
> 2)
> > > after
> > > > > > > interrupt
> > > > > > > > is disabled, set KVM_REQ_EVENT in case the ON bit is set?
> > > > > > >
> > > > > > > 2) after interrupt is disabled, set KVM_REQ_EVENT in case the ON
> bit
> > > > > > > is set.
> > > > > >
> > > > > > Here is my understanding about your comments here:
> > > > > > - Disable interrupts
> > > > > > - Check 'ON'
> > > > > > - Set KVM_REQ_EVENT if 'ON' is set
> > > > > >
> > > > > > Then we can put the above code inside " if
> > > > > (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win) "
> > > > > > just like it used to be. However, I still have some questions about this
> > > > > comment:
> > > > > >
> > > > > > 1. Where should I set KVM_REQ_EVENT? In function
> vcpu_enter_guest(),
> > > or
> > > > > other places?
> > > > >
> > > > > See below:
> > > > >
> > > > > > If in vcpu_enter_guest(), since currently local_irq_disable() is called
> after
> > > > > 'KVM_REQ_EVENT'
> > > > > > is checked, is it helpful to set KVM_REQ_EVENT after
> local_irq_disable() is
> > > > > called?
> > > > >
> > > > >         local_irq_disable();
> > > > >
> > > > > 	*** add code here ***
> > > >
> > > > So we need add code like the following here, right?
> > > >
> > > >           if ('ON' is set)
> > > >               kvm_make_request(KVM_REQ_EVENT, vcpu);
> > >
> >
> > Hi Marcelo,
> >
> > I changed the code as above, then I found that the ping latency was
> extremely big, (70ms - 400ms).
> > I digged into it and got the root cause. We cannot use "checking-on" as the
> judgment, since 'ON'
> > can be cleared by hypervisor software in lots of places. In this case,
> KVM_REQ_EVENT cannot be
> > set when we check 'ON' bit, hence the interrupts are not injected to the guest
> in time.
> >
> > Please refer to the following code, in which 'ON' bit can be cleared:
> >
> > apic_find_highest_irr () --> vmx_sync_pir_to_irr () --> pi_test_and_clear_on()
> >
> > Searching from the code step by step, apic_find_highest_irr() can be called by
> many other guys.
> >
> > Thanks,
> 
> Ok then, ignore my suggestion.
> 
> Can you resend the latest version please ?

Thanks for your review, I will send the new version soon.

Thanks,
Feng

> 

