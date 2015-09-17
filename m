From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v8 03/13] KVM: Define a new interface
 kvm_intr_is_single_vcpu()
Date: Thu, 17 Sep 2015 11:42:05 +0200
Message-ID: <55FA8AED.6090700@redhat.com>
References: <1442393409-2623-1-git-send-email-feng.wu@intel.com>
 <1442393409-2623-4-git-send-email-feng.wu@intel.com>
 <55F934F5.7040605@redhat.com>
 <E959C4978C3B6342920538CF579893F002716FFA@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E959C4978C3B6342920538CF579893F002716FFA@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wu, Feng" <feng.wu@intel.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "joro@8bytes.org" <joro@8bytes.org>, "mtosatti@redhat.com" <mtosatti@redhat.com>
Cc: "eric.auger@linaro.org" <eric.auger@linaro.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org



On 17/09/2015 05:17, Wu, Feng wrote:
>>> > > +	if (irq->dest_mode == APIC_DEST_PHYSICAL) {
>>> > > +		if (irq->dest_id == 0xFF)
>>> > > +			goto out;
>>> > > +
>>> > > +		if (irq->dest_id >= ARRAY_SIZE(map->phys_map)) {
>> > 
>> > Warning here is wrong, the guest can trigger it.
> Could you please share more information about how the guest
> triggers these conditions (including the following two), Thanks
> a lot!

irq->dest_id is a 16-bit value, so it can be > 255.

> +		if (!kvm_apic_logical_map_valid(map)) {
> +			WARN_ON_ONCE(1);

Here, the guest can trigger it by setting a few APICs in flat mode and
others in cluster mode, for example.

> +		if (cid >= ARRAY_SIZE(map->logical_map)) {
> +			WARN_ON_ONCE(1);

In x2apic mode irq->dest_id could have bits 12..15 set.

Paolo
