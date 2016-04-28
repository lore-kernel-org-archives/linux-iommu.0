From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 12/18] vfio: Register/unregister irq_bypass_producer
Date: Thu, 28 Apr 2016 17:35:12 +0200
Message-ID: <57222DB0.7080205@linaro.org>
References: <1442586596-5920-1-git-send-email-feng.wu@intel.com>
	<1442586596-5920-13-git-send-email-feng.wu@intel.com>
	<20160426140816.67b8b37c@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160426140816.67b8b37c-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Alex,
On 04/26/2016 10:08 PM, Alex Williamson wrote:
> On Fri, 18 Sep 2015 22:29:50 +0800
> Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 
>  @@ -360,6 +361,14 @@ static int vfio_msi_set_vector_signal(struct
>  vfio_pci_device *vdev,
>>  		return ret;
>>  	}
>>  
>> +	vdev->ctx[vector].producer.token = trigger;
>> +	vdev->ctx[vector].producer.irq = irq;
>> +	ret = irq_bypass_register_producer(&vdev->ctx[vector].producer);
>> +	if (unlikely(ret))
>> +		dev_info(&pdev->dev,
>> +		"irq bypass producer (token %p) registeration fails: %d\n",
>> +		vdev->ctx[vector].producer.token, ret);
>> +
>>  	vdev->ctx[vector].trigger = trigger;
>>  
>>  	return 0;
> 
> Digging back into the IRQ producer/consumer thing, I'm not sure how we
> should be handling a failure here, but it turns out that what we have
> is pretty sub-optimal.  Any sort of testing on AMD hits this dev_info
> because kvm_arch_irq_bypass_add_producer() returns -EINVAL without
> kvm_x86_ops->update_pi_irte which is only implemented for vmx.  Clearly
> we don't want to spew confusing error messages for a feature that does
> not exist.
> 
> The easiest option is to simply make this error silent, but should
> registering a producer/consumer really fail due to a mismatch on the
> other end or should the __connect sequence fail silently, which both
> ends would know about (if they care) due to the add/del handshake
> between them?  Perhaps for now we simply need a stable suitable fix to
> silence the dev_info above, but longer term, registration shouldn't
> fail for mismatches like this.  Thoughts?  Thanks,

Regarding the ARM IRQ forwarding use case, I think it is OK to fail
silently. We would fall back to the irqfd standard mechanism. Anyway
this series still is waiting for ARM new-vgic dependency to be resolved,
as discussed with Christoffer and Marc.

Best Regards

Eric
> 
> Alex
> 
