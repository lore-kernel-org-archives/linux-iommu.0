From: Anthony DeRobertis <aderobertis-VnMYzjHJ8tfR7s880joybQ@public.gmane.org>
Subject: Re: PROBLEM: do_IRQ: [number] No irq handler for vector (irq -1)
Date: Wed, 22 Jan 2014 14:41:06 -0500
Message-ID: <52E01ED2.4080604@metrics.net>
References: <20140116121617.GA9984@hmsreliant.think-freely.org>
	<52D8120D.7090606@metrics.net>
	<20140116182134.GC9984@hmsreliant.think-freely.org>
	<52D83BF9.7040502@metrics.net>
	<20140117140831.GA19452@hmsreliant.think-freely.org>
	<52D97BFB.1020106@metrics.net>
	<20140117202712.GC19452@hmsreliant.think-freely.org>
	<52D9AFBB.5080203@metrics.net>
	<20140120122630.GB22690@hmsreliant.think-freely.org>
	<52DFF1FE.2080805@metrics.net>
	<20140122181707.GA14646@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140122181707.GA14646-B26myB8xz7F8NnZeBjwnZQMhkBWG/bsMQH7oEaQurus@public.gmane.org>
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

I was looking through those files a bit, and notice there is a 
iommu_disable_irq_remapping. I added some printk's to it, and it isn't 
being called when the BIOS workaround is hit.

 From the code, I gather that it should be disabled at boot, and the 
disable_irq_remap flag works by just pretending its not supported, so it 
never gets enabled.

However, I see in the enable path (intel_enable_irq_remapping) there is 
this:

		/*
		 * Disable intr remapping and queued invalidation, if already
		 * enabled prior to OS handover.
		 */
		iommu_disable_irq_remapping(iommu);

It sounds like someone found a BIOS before that hands off to Linux with 
it already enabled.

So, I added a call to disable_irq_remapping, but it turns out that this 
BIOS doesn't do that. So doesn't help here.

Also, I notice that iommu_disable_irq_remapping looks suspicious as its 
weird that GSTS is being read with both readl and dmar_readq. I think 
readl is correct, as I think the Intel spec says its a 32-bit field.
