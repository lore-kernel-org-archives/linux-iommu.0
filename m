From: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Subject: Re: PROBLEM: do_IRQ: [number] No irq handler for vector (irq -1)
Date: Thu, 23 Jan 2014 07:37:43 -0500
Message-ID: <20140123123743.GA26800@hmsreliant.think-freely.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52E01ED2.4080604-VnMYzjHJ8tfR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Anthony DeRobertis <aderobertis-VnMYzjHJ8tfR7s880joybQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 22, 2014 at 02:41:06PM -0500, Anthony DeRobertis wrote:
> I was looking through those files a bit, and notice there is a
> iommu_disable_irq_remapping. I added some printk's to it, and it
> isn't being called when the BIOS workaround is hit.
> 
> From the code, I gather that it should be disabled at boot, and the
> disable_irq_remap flag works by just pretending its not supported,
> so it never gets enabled.
> 
> However, I see in the enable path (intel_enable_irq_remapping) there
> is this:
> 
> 		/*
> 		 * Disable intr remapping and queued invalidation, if already
> 		 * enabled prior to OS handover.
> 		 */
> 		iommu_disable_irq_remapping(iommu);
> 
> It sounds like someone found a BIOS before that hands off to Linux
> with it already enabled.
> 
> So, I added a call to disable_irq_remapping, but it turns out that
> this BIOS doesn't do that. So doesn't help here.
> 
> Also, I notice that iommu_disable_irq_remapping looks suspicious as
> its weird that GSTS is being read with both readl and dmar_readq. I
> think readl is correct, as I think the Intel spec says its a 32-bit
> field.
> 
Hmm, you may be right.  IRQ remapping is supposed to be strictly opt-in, but if
you have a BIOS that did it for you (that setting in bios is just supposed to
set the supported bit for irq remapping in the iommu capabilities register, not
actually enable it), then that would explain your situation.

Can you try this patch on top of a vanilla kernel and tell me if it solves your
problem?

Thanks!


diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index bab10b1..19f41ee 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -533,6 +533,8 @@ static int __init intel_irq_remapping_supported(void)
 			"contact your BIOS vendor for an update\n");
 		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
 		disable_irq_remap = 1;
+		/* In case BIOS already enabled irq remapping */
+		disable_irq_remapping();
 		return 0;
 	}
 
