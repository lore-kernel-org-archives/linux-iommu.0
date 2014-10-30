From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [Patch Part2 v3 15/24] x86, MSI: Use hierarchy irqdomain to manage
	MSI interrupts
Date: Thu, 30 Oct 2014 12:50:01 +0800
Message-ID: <5451C379.1050508@linux.intel.com>
References: <1414484803-10311-1-git-send-email-jiang.liu@linux.intel.com>
	<1414484803-10311-16-git-send-email-jiang.liu@linux.intel.com>
	<alpine.DEB.2.11.1410282046120.5308@nanos>
	<5450A9D8.108@linux.intel.com>
	<alpine.DEB.2.11.1410291017180.5308@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1410291017180.5308@nanos>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2014/10/29 17:19, Thomas Gleixner wrote:
>> Hi Thomas,
>> 	Thanks for your great suggestion and I have worked out a draft
>> patch to achieve what you want:)
>> 	I have made following changes to irq core to get rid of remapped
>> irq logic from msi.c:
>> 1) Add IRQ_SET_MASK_OK_DONE in addition to IRQ_SET_MASK_OK and
>> IRQ_SET_MASK_OK_NOCOPY. IRQ_SET_MASK_OK_DONE is the same as
>> IRQ_SET_MASK_OK for irq core and indicates to stacked irqchip that
>> parent irqchips have done all work and skip any handling in descendant
>> irqchips.
>> 2) Add int (*irq_compose_msi_msg)(struct irq_data *data, struct msi_msg
>> *msg) into struct irq_chip. I'm still hesitating to return void or int
>> here. By returning void, irq_chip_compose_msi_msg() will be simpler,
>> but it loses flexibility.
> 
> void should be sufficient. If the chip advertises this function it
> better can provide a proper msi msg :)
>  
>> With above changes to core, we could remove all knowledge of irq
>> remapping from msi.c and the irq remapping interfaces get simpler too.
>> Please refer to following patch for details. The patch passes basic
>> booting tests with irq remapping enabled. If it's OK, I will fold
>> it into the patch set.
> 
> Yes. That looks reasonable. 
>  
>> IOAPIC runs into the same situation, but I need some more time
>> to find a solution:)
> 
> I'm sure you will!
Hi Thomas,
	I have reviewed IOAPIC related change again, but the conclusion
may not be what you expect:(
	Currently IOAPIC driver detects IRQ remapping for following
tasks:
1) Issue different EOI command to IOAPIC chip for unammped and remapped
   interrupts. It uses pin number instead of vector number for remapped
   interrupts.
2) Print different format for IOAPIC entries for unmapped and remapped
   interrupts.
3) ioapic_ack_level() uses different method for unmapped and remapped
   interrupts
4) create different IOAPIC entry content for unmapped and remapped
   interrupts
5) choose different flow handler for unmapped and remapped interrupts

For MSI, it only needs to solve task 4) above. For IOAPIC, it needs
to solve all five tasks above, which may cause big changes to irq_chip.
And it even may cause IRQ remapping driver call back into IOAPIC driver,
which breaks another rules that only the driver touches corresponding
interrupt controller.

On the other hand, MSI is almost platform independent, so it's
reasonable to change public struct irq_chip to support MSI.
But IOAPIC is a sort of platform dependent (x86 and IA64), so it
doesn't sound good to make great change to struct irq_chip to support
IOAPIC.

So I prefer keeping IOAPIC driver sensing interrupt remapping and
acting different for unmapped and remapped interrupts.
This breaks the layered design, but it does make code simpler.

What's your thoughts?
Regards!
Gerry


> 
> Thanks,
> 
> 	tglx
> 
