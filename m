From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 05/13] KVM: Update IRTE according to guest interrupt configuration
 changes
Date: Tue, 11 Nov 2014 12:01:45 +0100
Message-ID: <5461EC99.1000101@redhat.com>
References: <E959C4978C3B6342920538CF579893F00226EF05@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E959C4978C3B6342920538CF579893F00226EF05@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wu, Feng" <feng.wu@intel.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: "gleb@kernel.org" <gleb@kernel.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "joro@8bytes.org" <joro@8bytes.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org



On 11/11/2014 10:20, Wu, Feng wrote:
> > Since legacy KVM device assignment is effectively deprecated, have you
> > considered how we might do this with VFIO?  Thanks,
> 
> I haven't thought about how to enable this in VFIO so far. I think I can continue to
> implement that if needed after this patch set is finished. What do you think of this?

Hi Feng,

we are not applying new features to legacy KVM device assignment, since
it is unsafe (it does not honor ACS).

I and Alex can help you with designing a way to interface VFIO with KVM
posted interrupts.  Give us a few days to study these patches more, or
feel free to request comments if you have ideas about it yourself.

Paolo
