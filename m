From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v9 12/18] vfio: Register/unregister irq_bypass_producer
Date: Mon, 21 Sep 2015 15:02:38 +0200
Message-ID: <55FFFFEE.6090800@redhat.com>
References: <1442586596-5920-1-git-send-email-feng.wu@intel.com>
 <1442586596-5920-13-git-send-email-feng.wu@intel.com>
 <E959C4978C3B6342920538CF579893F00272346C@SHSMSX104.ccr.corp.intel.com>
 <55FFCE9F.5090001@redhat.com>
 <E959C4978C3B6342920538CF579893F002723F72@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E959C4978C3B6342920538CF579893F002723F72@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wu, Feng" <feng.wu@intel.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "joro@8bytes.org" <joro@8bytes.org>, "mtosatti@redhat.com" <mtosatti@redhat.com>
Cc: "eric.auger@linaro.org" <eric.auger@linaro.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org



On 21/09/2015 14:53, Wu, Feng wrote:
>>> > > I think the point is that we cannot trigger the build of irqbypass
>>> > > manager inside KVM or VFIO, we need trigger the build at a high
>>> > > level and it should be built before VFIO and KVM. Any ideas?
>> > 
>> > We can add virt/Makefile and build virt/lib/ directly, not through
>> > arch/x86/kvm.
> Thinking about this more, does that mean we need to add the virt directory
> in the top Makefile in Linux tree?

Yes, it does.

Paolo
