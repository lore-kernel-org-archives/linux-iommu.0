From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v8 03/13] KVM: Define a new interface
 kvm_intr_is_single_vcpu()
Date: Thu, 17 Sep 2015 17:58:21 +0200
Message-ID: <20150917155821.GB2573@potion.brq.redhat.com>
References: <1442393409-2623-1-git-send-email-feng.wu@intel.com>
 <1442393409-2623-4-git-send-email-feng.wu@intel.com>
 <55F934F5.7040605@redhat.com>
 <E959C4978C3B6342920538CF579893F002716FFA@SHSMSX104.ccr.corp.intel.com>
 <55FA8AED.6090700@redhat.com>
 <E959C4978C3B6342920538CF579893F002718968@SHSMSX104.ccr.corp.intel.com>
 <55FACD35.1030602@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55FACD35.1030602@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Wu, Feng" <feng.wu@intel.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "joro@8bytes.org" <joro@8bytes.org>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "eric.auger@linaro.org" <eric.auger@linaro.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

2015-09-17 16:24+0200, Paolo Bonzini:
> I think kvm_apic_match_logical_addr for MSI and IOAPIC interrupts is
> buggy in x2apic mode.
> 
> It does:
> 
>         if (apic_x2apic_mode(apic))
>                 return ((logical_id >> 16) == (mda >> 16))
>                        && (logical_id & mda & 0xffff) != 0;
> 
> But mda is only 8-bits for MSI and IOAPIC interrupts.
> 
> Radim, should kvm_apic_mda also handle the !ipi && x2apic_mda && dest_id
> != APIC_BROADCAST case?  It never triggers with Linux because it uses
> only the physical mode (that's not super-easy to see;
> ioapic_set_affinity looks for the RTEs in irq_data->chip_data and that
> is allocated with kzalloc).

KVM handles that case, it's just convoluted.
(I wish we scrapped the IR-less x2APIC mode.)

For interrupts from MSI and IOxAPIC:
- Flat logical interrupts are delivered as if we had natural
  (CPU0<->bit0, CPU1<->bit1, ...) flat logical xAPIC for first 8 VCPUs.
- Cluster logical doesn't work much, it's interpreted like flat logical.
  I didn't care about xAPIC cluster because Linux, the sole user of our
  paravirtualized x2APIC, doesn't configure it.

I'll paste kvm_apic_mda() source for better explanation:

  static u32 kvm_apic_mda(unsigned int dest_id, struct kvm_lapic *source,
                                                struct kvm_lapic *target)
  {
  	bool ipi = source != NULL;
  	bool x2apic_mda = apic_x2apic_mode(ipi ? source : target);
  
  	if (!ipi && dest_id == APIC_BROADCAST && x2apic_mda)
  		return X2APIC_BROADCAST;
  
  	return x2apic_mda ? dest_id : SET_APIC_DEST_FIELD(dest_id);
  }

MSI/IOxAPIC interrupt means that source is NULL and if the target is in
x2APIC mode, the original 'dest_id' is returned as mda => a flat logical
xAPIC to 0x0f will get interpreted as (cluster) logical x2APIC 0xf in
kvm_apic_match_logical_addr().
xAPIC address are only 8 bit long so they always get delivered to x2APIC
cluster 0, where first 16 bits work like xAPIC flat logical mode.
