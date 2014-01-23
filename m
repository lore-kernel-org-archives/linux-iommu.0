From: Anthony DeRobertis <aderobertis-VnMYzjHJ8tfR7s880joybQ@public.gmane.org>
Subject: Re: PROBLEM: do_IRQ: [number] No irq handler for vector (irq -1)
Date: Thu, 23 Jan 2014 14:24:06 -0500
Message-ID: <52E16C56.9000709@metrics.net>
References: <20140116182134.GC9984@hmsreliant.think-freely.org>
	<52D83BF9.7040502@metrics.net>
	<20140117140831.GA19452@hmsreliant.think-freely.org>
	<52D97BFB.1020106@metrics.net>
	<20140117202712.GC19452@hmsreliant.think-freely.org>
	<52D9AFBB.5080203@metrics.net>
	<20140120122630.GB22690@hmsreliant.think-freely.org>
	<52DFF1FE.2080805@metrics.net>
	<20140122181707.GA14646@hmsreliant.think-freely.org>
	<52E01ED2.4080604@metrics.net>
	<20140123123743.GA26800@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140123123743.GA26800-B26myB8xz7F8NnZeBjwnZQMhkBWG/bsMQH7oEaQurus@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/23/2014 07:37 AM, Neil Horman wrote:
> diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
> index bab10b1..19f41ee 100644
> --- a/drivers/iommu/intel_irq_remapping.c
> +++ b/drivers/iommu/intel_irq_remapping.c
> @@ -533,6 +533,8 @@ static int __init intel_irq_remapping_supported(void)
>   			"contact your BIOS vendor for an update\n");
>   		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
>   		disable_irq_remap = 1;
> +		/* In case BIOS already enabled irq remapping */
> +		disable_irq_remapping();
>   		return 0;
>   	}

I already tried that, well, similar (you need to declare 
disable_irq_remapping above that or it won't compile). I also added in 
some printks, to see what it is doing:

diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index bab10b1..8a502d7 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -496,8 +496,13 @@ static void iommu_disable_irq_remapping(struct intel_iommu *iommu)
         raw_spin_lock_irqsave(&iommu->register_lock, flags);
  
         sts = dmar_readq(iommu->reg + DMAR_GSTS_REG);
-       if (!(sts & DMA_GSTS_IRES))
+       if (!(sts & DMA_GSTS_IRES)) {
+               printk(KERN_WARNING
+                      "Not disabling interrupt remapping, was not enabled.\n");
                 goto end;
+       } else {
+               printk(KERN_INFO "Disabling interrupt remapping.\n");
+       }
  
         iommu->gcmd &= ~DMA_GCMD_IRE;
         writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
@@ -518,6 +523,8 @@ static int __init dmar_x2apic_optout(void)
         return dmar->flags & DMAR_X2APIC_OPT_OUT;
  }
  
+static void disable_irq_remapping(void);
+
  static int __init intel_irq_remapping_supported(void)
  {
         struct dmar_drhd_unit *drhd;
@@ -533,6 +540,7 @@ static int __init intel_irq_remapping_supported(void)
                         "contact your BIOS vendor for an update\n");
                 add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
                 disable_irq_remap = 1;
+               disable_irq_remapping();
                 return 0;
         }


The result. Note this is two boots, I changed to printk messages to 
something more understandable and rebooted to make sure there were no 
brown paper bag bugs. So the do_IRQ bugs logs are the first boot, the 
rest is the second boot:

[    0.063923] dmar: ATSR flags: 0x0
[    0.064075] This system BIOS has enabled interrupt remapping
[    0.064075] on a chipset that contains an erratum making that
[    0.064075] feature unstable.  To maintain system stability
[    0.064075] interrupt remapping is being disabled.  Please
[    0.064075] contact your BIOS vendor for an update
[    0.064226] Not disabling interrupt remapping, was not enabled.
[    0.064287] Not disabling interrupt remapping, was not enabled.
[    0.064408] Switched APIC routing to physical flat.


anthony@Zia:~$ dmesg | grep do_IRQ     # this is from the first boot
[ 2713.768956] do_IRQ: 40 callbacks suppressed
[ 2713.768963] do_IRQ: 0.132 No irq handler for vector (irq -1)
[ 3914.191481] do_IRQ: 3.219 No irq handler for vector (irq -1)
[12336.482217] do_IRQ: 3.106 No irq handler for vector (irq -1)
[19669.277859] do_IRQ: 2.136 No irq handler for vector (irq -1)
[31304.932672] do_IRQ: 2.204 No irq handler for vector (irq -1)
[35867.281432] do_IRQ: 2.135 No irq handler for vector (irq -1)
[43867.266257] do_IRQ: 1.174 No irq handler for vector (irq -1)
[50097.592403] do_IRQ: 3.81 No irq handler for vector (irq -1)
[55498.847866] do_IRQ: 0.92 No irq handler for vector (irq -1)
[57560.923165] do_IRQ: 0.199 No irq handler for vector (irq -1)
[57650.204418] do_IRQ: 0.120 No irq handler for vector (irq -1)
[72835.450862] do_IRQ: 0.163 No irq handler for vector (irq -1)
[76884.819496] do_IRQ: 2.68 No irq handler for vector (irq -1)
[77687.282915] do_IRQ: 2.216 No irq handler for vector (irq -1)
[77885.355992] do_IRQ: 2.185 No irq handler for vector (irq -1)
[78615.309285] do_IRQ: 12 callbacks suppressed
[78615.309291] do_IRQ: 3.45 No irq handler for vector (irq -1)
[78735.392357] do_IRQ: 6 callbacks suppressed
[78735.392362] do_IRQ: 2.173 No irq handler for vector (irq -1)
[79785.646442] do_IRQ: 6 callbacks suppressed
[79785.646449] do_IRQ: 1.53 No irq handler for vector (irq -1)
[79965.718447] do_IRQ: 8 callbacks suppressed
[79965.718453] do_IRQ: 0.150 No irq handler for vector (irq -1)

PS: Sent Asus a support request, to see if they have anything to say 
about what the BIOS is doing with that erratum. Will let you know if 
they respond with anything useful, I mostly expect "we don't support 
Linux". 
https://vip.asus.com/VIP2/Services/MailDetail/WTM20140124024244911 ... 
no idea if that link works for anyone but me.
