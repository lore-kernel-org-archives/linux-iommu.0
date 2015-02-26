From: "Wu, Feng" <feng.wu@intel.com>
Subject: RE: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU
 is blocked
Date: Thu, 26 Feb 2015 08:08:15 +0000
Message-ID: <E959C4978C3B6342920538CF579893F0023E9C69@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
 <1418397300-10870-25-git-send-email-feng.wu@intel.com>
 <20150225215011.GA16848@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150225215011.GA16848@amt.cnet>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "gleb@kernel.org" <gleb@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "eric.auger@linaro.org" <eric.auger@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Zhang, Yang Z" <yang.z.zhang@intel.com>, "Wu, Feng" <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Marcelo Tosatti [mailto:mtosatti@redhat.com]
> Sent: Thursday, February 26, 2015 5:50 AM
> To: Wu, Feng
> Cc: tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com; x86@kernel.org;
> gleb@kernel.org; pbonzini@redhat.com; dwmw2@infradead.org;
> joro@8bytes.org; alex.williamson@redhat.com; jiang.liu@linux.intel.com;
> eric.auger@linaro.org; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; kvm@vger.kernel.org
> Subject: Re: [v3 24/26] KVM: Update Posted-Interrupts Descriptor when vCPU
> is blocked
> 
> On Fri, Dec 12, 2014 at 11:14:58PM +0800, Feng Wu wrote:
> > This patch updates the Posted-Interrupts Descriptor when vCPU
> > is blocked.
> >
> > pre-block:
> > - Add the vCPU to the blocked per-CPU list
> > - Clear 'SN'
> > - Set 'NV' to POSTED_INTR_WAKEUP_VECTOR
> >
> > post-block:
> > - Remove the vCPU from the per-CPU list
> >
> > Signed-off-by: Feng Wu <feng.wu@intel.com>
> > ---
> 
> Don't see this is needed, can use the existing POSTED_INTR_VECTOR:
> 
> If in guest mode, IPI will be handled in VMX non-root by performed
> PIR->IRR transfer.
> 
> If outside guest mode, POSTED_INTR_VECTOR IPI will be handled by host
> which can wakeup the guest (in case it is halted).

Please see the following scenario:

1. vCPU0 is running on pCPU0
2. vCPU0 is halted and vCPU1 is currently running on pCPU0
3. An interrupt occurs for vCPU0, if we still use POSTED_INTR_VECTOR
for vCPU0, the notification event for vCPU0 (the event will go to pCPU1)
will be consumed by vCPU1 incorrectly. The worst case is that vCPU0
will never be woken up again since the wakeup event for it is always
consumed by other vCPUs incorrectly.

Thanks,
Feng
