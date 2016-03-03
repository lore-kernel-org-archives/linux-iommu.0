From: Xunlei Pang <xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Assign old irt entries a common valid vector
	in kdump kernel
Date: Thu, 3 Mar 2016 11:29:14 +0800
Message-ID: <56D7AF8A.7080008@redhat.com>
References: <1456912948-5052-1-git-send-email-xlpang@redhat.com>
	<20160302145823.GV22747@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160302145823.GV22747-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 03/02/2016 at 10:58 PM, Joerg Roedel wrote:
> On Wed, Mar 02, 2016 at 06:02:28PM +0800, Xunlei Pang wrote:
>> Currently, the kernel copies the old irt entries during iommu
>> initialization for kdump, so old vectors in the first kernel are
>> used but having no related kernel irq handlers set explicitly,
>> this can lead to some problems after lapics are enabled:
>>  - When some in-flight dma finished and triggered an interrupt,
>>    the kernel will throw a warning message in do_IRQ() like "No
>>    irq handler", because handle_irq() will return false with no
>>    irq_desc handlers. This may confuse users.
>>  - When the in-flight dma interrupt arrives, and if there happens
>>    to be an irq with the same vector allocated in kdump kernel,
>>    it will invoke the existing ISR registered in kdump kernel as
>>    if one valid interrupt in the kdump kernel happens. This might
>>    cause some wrong software logic, for example if the ISR always
>>    wakes up a process.
> Hmm, the current situation with misdirected irq messages in the kdump
> kernel is not different from a situation without any iommu at all,
> right?

Right, non-iommu in-flight DMA after crash also suffers from this.
I think both of them should be fixed if possible.

> And the goal of preserving the old mappings is to get as close as
> possible to the situation without iommu. This seems to carry the VT-d
> driver away from that.

Without iommu, it's not so easy to fix due to the MSI registers
located in different pci devices. But vt-d introduces a mechanism
to redirect both MSI/MSI-X and I/O APIC to a common IR table,
so we can handle that much easily with the help of the IR table.

On kdump side, present-day servers with vt-d enabled are
becoming increasingly common-place, if this does happen in
real world(usually it will), that would be hard to dig it out, so I
think it would be better if we can fix it.

Also CC kexec list

Regards,
Xunlei

>
>
> 	Joerg
>
